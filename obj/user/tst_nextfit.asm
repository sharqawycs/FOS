
obj/user/tst_nextfit:     file format elf32-i386


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
  800031:	e8 28 0b 00 00       	call   800b5e <libmain>
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
  80003d:	81 ec 30 08 00 00    	sub    $0x830,%esp
	int Mega = 1024*1024;
  800043:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  80004a:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)

	//Make sure that the heap size is 512 MB
	int numOf2MBsInHeap = (USER_HEAP_MAX - USER_HEAP_START) / (2*Mega);
  800051:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	89 c7                	mov    %eax,%edi
  800058:	b8 00 00 00 20       	mov    $0x20000000,%eax
  80005d:	ba 00 00 00 00       	mov    $0x0,%edx
  800062:	f7 f7                	div    %edi
  800064:	89 45 d8             	mov    %eax,-0x28(%ebp)
	assert(numOf2MBsInHeap == 256);
  800067:	81 7d d8 00 01 00 00 	cmpl   $0x100,-0x28(%ebp)
  80006e:	74 16                	je     800086 <_main+0x4e>
  800070:	68 c0 27 80 00       	push   $0x8027c0
  800075:	68 d7 27 80 00       	push   $0x8027d7
  80007a:	6a 0e                	push   $0xe
  80007c:	68 ec 27 80 00       	push   $0x8027ec
  800081:	e8 da 0b 00 00       	call   800c60 <_panic>




	sys_set_uheap_strategy(UHP_PLACE_NEXTFIT);
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	6a 03                	push   $0x3
  80008b:	e8 9d 24 00 00       	call   80252d <sys_set_uheap_strategy>
  800090:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800093:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800097:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009e:	eb 29                	jmp    8000c9 <_main+0x91>
		{
			if (myEnv->__uptr_pws[i].empty)
  8000a0:	a1 20 40 80 00       	mov    0x804020,%eax
  8000a5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8000ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8000ae:	89 d0                	mov    %edx,%eax
  8000b0:	01 c0                	add    %eax,%eax
  8000b2:	01 d0                	add    %edx,%eax
  8000b4:	c1 e0 02             	shl    $0x2,%eax
  8000b7:	01 c8                	add    %ecx,%eax
  8000b9:	8a 40 04             	mov    0x4(%eax),%al
  8000bc:	84 c0                	test   %al,%al
  8000be:	74 06                	je     8000c6 <_main+0x8e>
			{
				fullWS = 0;
  8000c0:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  8000c4:	eb 12                	jmp    8000d8 <_main+0xa0>
	sys_set_uheap_strategy(UHP_PLACE_NEXTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  8000c6:	ff 45 f0             	incl   -0x10(%ebp)
  8000c9:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ce:	8b 50 74             	mov    0x74(%eax),%edx
  8000d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000d4:	39 c2                	cmp    %eax,%edx
  8000d6:	77 c8                	ja     8000a0 <_main+0x68>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  8000d8:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  8000dc:	74 14                	je     8000f2 <_main+0xba>
  8000de:	83 ec 04             	sub    $0x4,%esp
  8000e1:	68 ff 27 80 00       	push   $0x8027ff
  8000e6:	6a 20                	push   $0x20
  8000e8:	68 ec 27 80 00       	push   $0x8027ec
  8000ed:	e8 6e 0b 00 00       	call   800c60 <_panic>

	int freeFrames ;
	int usedDiskPages;

	//[0] Make sure there're available places in the WS
	int w = 0 ;
  8000f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int requiredNumOfEmptyWSLocs = 2;
  8000f9:	c7 45 d4 02 00 00 00 	movl   $0x2,-0x2c(%ebp)
	int numOfEmptyWSLocs = 0;
  800100:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  800107:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80010e:	eb 26                	jmp    800136 <_main+0xfe>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
  800110:	a1 20 40 80 00       	mov    0x804020,%eax
  800115:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80011b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80011e:	89 d0                	mov    %edx,%eax
  800120:	01 c0                	add    %eax,%eax
  800122:	01 d0                	add    %edx,%eax
  800124:	c1 e0 02             	shl    $0x2,%eax
  800127:	01 c8                	add    %ecx,%eax
  800129:	8a 40 04             	mov    0x4(%eax),%al
  80012c:	3c 01                	cmp    $0x1,%al
  80012e:	75 03                	jne    800133 <_main+0xfb>
			numOfEmptyWSLocs++;
  800130:	ff 45 e8             	incl   -0x18(%ebp)

	//[0] Make sure there're available places in the WS
	int w = 0 ;
	int requiredNumOfEmptyWSLocs = 2;
	int numOfEmptyWSLocs = 0;
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  800133:	ff 45 ec             	incl   -0x14(%ebp)
  800136:	a1 20 40 80 00       	mov    0x804020,%eax
  80013b:	8b 50 74             	mov    0x74(%eax),%edx
  80013e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800141:	39 c2                	cmp    %eax,%edx
  800143:	77 cb                	ja     800110 <_main+0xd8>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
			numOfEmptyWSLocs++;
	}
	if (numOfEmptyWSLocs < requiredNumOfEmptyWSLocs)
  800145:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800148:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  80014b:	7d 14                	jge    800161 <_main+0x129>
		panic("Insufficient number of WS empty locations! please increase the PAGE_WS_MAX_SIZE");
  80014d:	83 ec 04             	sub    $0x4,%esp
  800150:	68 1c 28 80 00       	push   $0x80281c
  800155:	6a 31                	push   $0x31
  800157:	68 ec 27 80 00       	push   $0x8027ec
  80015c:	e8 ff 0a 00 00       	call   800c60 <_panic>


	void* ptr_allocations[512] = {0};
  800161:	8d 95 c8 f7 ff ff    	lea    -0x838(%ebp),%edx
  800167:	b9 00 02 00 00       	mov    $0x200,%ecx
  80016c:	b8 00 00 00 00       	mov    $0x0,%eax
  800171:	89 d7                	mov    %edx,%edi
  800173:	f3 ab                	rep stos %eax,%es:(%edi)
	int i;

	cprintf("This test has THREE cases. A pass message will be displayed after each one.\n");
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	68 6c 28 80 00       	push   $0x80286c
  80017d:	e8 92 0d 00 00       	call   800f14 <cprintf>
  800182:	83 c4 10             	add    $0x10,%esp

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
  800185:	e8 10 1f 00 00       	call   80209a <sys_calculate_free_frames>
  80018a:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80018d:	e8 8b 1f 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800192:	89 45 cc             	mov    %eax,-0x34(%ebp)
	for(i = 0; i< 256;i++)
  800195:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80019c:	eb 20                	jmp    8001be <_main+0x186>
	{
		ptr_allocations[i] = malloc(2*Mega);
  80019e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001a1:	01 c0                	add    %eax,%eax
  8001a3:	83 ec 0c             	sub    $0xc,%esp
  8001a6:	50                   	push   %eax
  8001a7:	e8 2c 1b 00 00       	call   801cd8 <malloc>
  8001ac:	83 c4 10             	add    $0x10,%esp
  8001af:	89 c2                	mov    %eax,%edx
  8001b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b4:	89 94 85 c8 f7 ff ff 	mov    %edx,-0x838(%ebp,%eax,4)
	cprintf("This test has THREE cases. A pass message will be displayed after each one.\n");

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
	usedDiskPages = sys_pf_calculate_allocated_pages();
	for(i = 0; i< 256;i++)
  8001bb:	ff 45 e4             	incl   -0x1c(%ebp)
  8001be:	81 7d e4 ff 00 00 00 	cmpl   $0xff,-0x1c(%ebp)
  8001c5:	7e d7                	jle    80019e <_main+0x166>
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
  8001c7:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8001cd:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8001d2:	75 5b                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001d4:	8b 85 d0 f7 ff ff    	mov    -0x830(%ebp),%eax
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
  8001da:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8001df:	75 4e                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  8001e1:	8b 85 e8 f7 ff ff    	mov    -0x818(%ebp),%eax
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001e7:	3d 00 00 00 81       	cmp    $0x81000000,%eax
  8001ec:	75 41                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
  8001ee:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  8001f4:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  8001f9:	75 34                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
  8001fb:	8b 85 04 f8 ff ff    	mov    -0x7fc(%ebp),%eax

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
  800201:	3d 00 00 e0 81       	cmp    $0x81e00000,%eax
  800206:	75 27                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
  800208:	8b 85 18 f8 ff ff    	mov    -0x7e8(%ebp),%eax
	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
  80020e:	3d 00 00 80 82       	cmp    $0x82800000,%eax
  800213:	75 1a                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[20] != 0x82800000 ||
			(uint32)ptr_allocations[25] != 0x83200000 ||
  800215:	8b 85 2c f8 ff ff    	mov    -0x7d4(%ebp),%eax
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
  80021b:	3d 00 00 20 83       	cmp    $0x83200000,%eax
  800220:	75 0d                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[25] != 0x83200000 ||
			(uint32)ptr_allocations[255] != 0x9FE00000)
  800222:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
			(uint32)ptr_allocations[25] != 0x83200000 ||
  800228:	3d 00 00 e0 9f       	cmp    $0x9fe00000,%eax
  80022d:	74 14                	je     800243 <_main+0x20b>
			(uint32)ptr_allocations[255] != 0x9FE00000)
		panic("Wrong allocation, Check fitting strategy is working correctly");
  80022f:	83 ec 04             	sub    $0x4,%esp
  800232:	68 bc 28 80 00       	push   $0x8028bc
  800237:	6a 4a                	push   $0x4a
  800239:	68 ec 27 80 00       	push   $0x8027ec
  80023e:	e8 1d 0a 00 00       	call   800c60 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800243:	e8 d5 1e 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800248:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80024b:	89 c2                	mov    %eax,%edx
  80024d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800250:	c1 e0 09             	shl    $0x9,%eax
  800253:	85 c0                	test   %eax,%eax
  800255:	79 05                	jns    80025c <_main+0x224>
  800257:	05 ff 0f 00 00       	add    $0xfff,%eax
  80025c:	c1 f8 0c             	sar    $0xc,%eax
  80025f:	39 c2                	cmp    %eax,%edx
  800261:	74 14                	je     800277 <_main+0x23f>
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 fa 28 80 00       	push   $0x8028fa
  80026b:	6a 4c                	push   $0x4c
  80026d:	68 ec 27 80 00       	push   $0x8027ec
  800272:	e8 e9 09 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != (512*Mega)/(1024*PAGE_SIZE) ) panic("Wrong allocation");
  800277:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  80027a:	e8 1b 1e 00 00       	call   80209a <sys_calculate_free_frames>
  80027f:	29 c3                	sub    %eax,%ebx
  800281:	89 da                	mov    %ebx,%edx
  800283:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800286:	c1 e0 09             	shl    $0x9,%eax
  800289:	85 c0                	test   %eax,%eax
  80028b:	79 05                	jns    800292 <_main+0x25a>
  80028d:	05 ff ff 3f 00       	add    $0x3fffff,%eax
  800292:	c1 f8 16             	sar    $0x16,%eax
  800295:	39 c2                	cmp    %eax,%edx
  800297:	74 14                	je     8002ad <_main+0x275>
  800299:	83 ec 04             	sub    $0x4,%esp
  80029c:	68 17 29 80 00       	push   $0x802917
  8002a1:	6a 4d                	push   $0x4d
  8002a3:	68 ec 27 80 00       	push   $0x8027ec
  8002a8:	e8 b3 09 00 00       	call   800c60 <_panic>

	// Make memory holes.
	freeFrames = sys_calculate_free_frames() ;
  8002ad:	e8 e8 1d 00 00       	call   80209a <sys_calculate_free_frames>
  8002b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b5:	e8 63 1e 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8002ba:	89 45 cc             	mov    %eax,-0x34(%ebp)

	free(ptr_allocations[0]);		// Hole 1 = 2 M
  8002bd:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	50                   	push   %eax
  8002c7:	e8 2d 1b 00 00       	call   801df9 <free>
  8002cc:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[2]);		// Hole 2 = 4 M
  8002cf:	8b 85 d0 f7 ff ff    	mov    -0x830(%ebp),%eax
  8002d5:	83 ec 0c             	sub    $0xc,%esp
  8002d8:	50                   	push   %eax
  8002d9:	e8 1b 1b 00 00       	call   801df9 <free>
  8002de:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[3]);
  8002e1:	8b 85 d4 f7 ff ff    	mov    -0x82c(%ebp),%eax
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	50                   	push   %eax
  8002eb:	e8 09 1b 00 00       	call   801df9 <free>
  8002f0:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[5]);		// Hole 3 = 2 M
  8002f3:	8b 85 dc f7 ff ff    	mov    -0x824(%ebp),%eax
  8002f9:	83 ec 0c             	sub    $0xc,%esp
  8002fc:	50                   	push   %eax
  8002fd:	e8 f7 1a 00 00       	call   801df9 <free>
  800302:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[10]);		// Hole 4 = 6 M
  800305:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
  80030b:	83 ec 0c             	sub    $0xc,%esp
  80030e:	50                   	push   %eax
  80030f:	e8 e5 1a 00 00       	call   801df9 <free>
  800314:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[12]);
  800317:	8b 85 f8 f7 ff ff    	mov    -0x808(%ebp),%eax
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	50                   	push   %eax
  800321:	e8 d3 1a 00 00       	call   801df9 <free>
  800326:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[11]);
  800329:	8b 85 f4 f7 ff ff    	mov    -0x80c(%ebp),%eax
  80032f:	83 ec 0c             	sub    $0xc,%esp
  800332:	50                   	push   %eax
  800333:	e8 c1 1a 00 00       	call   801df9 <free>
  800338:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[20]);		// Hole 5 = 2 M
  80033b:	8b 85 18 f8 ff ff    	mov    -0x7e8(%ebp),%eax
  800341:	83 ec 0c             	sub    $0xc,%esp
  800344:	50                   	push   %eax
  800345:	e8 af 1a 00 00       	call   801df9 <free>
  80034a:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[25]);		// Hole 6 = 2 M
  80034d:	8b 85 2c f8 ff ff    	mov    -0x7d4(%ebp),%eax
  800353:	83 ec 0c             	sub    $0xc,%esp
  800356:	50                   	push   %eax
  800357:	e8 9d 1a 00 00       	call   801df9 <free>
  80035c:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[255]);		// Hole 7 = 2 M
  80035f:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	50                   	push   %eax
  800369:	e8 8b 1a 00 00       	call   801df9 <free>
  80036e:	83 c4 10             	add    $0x10,%esp

	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 10*(2*Mega)/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800371:	e8 a7 1d 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800376:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800379:	89 d1                	mov    %edx,%ecx
  80037b:	29 c1                	sub    %eax,%ecx
  80037d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800380:	89 d0                	mov    %edx,%eax
  800382:	c1 e0 02             	shl    $0x2,%eax
  800385:	01 d0                	add    %edx,%eax
  800387:	c1 e0 02             	shl    $0x2,%eax
  80038a:	85 c0                	test   %eax,%eax
  80038c:	79 05                	jns    800393 <_main+0x35b>
  80038e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800393:	c1 f8 0c             	sar    $0xc,%eax
  800396:	39 c1                	cmp    %eax,%ecx
  800398:	74 14                	je     8003ae <_main+0x376>
  80039a:	83 ec 04             	sub    $0x4,%esp
  80039d:	68 28 29 80 00       	push   $0x802928
  8003a2:	6a 5e                	push   $0x5e
  8003a4:	68 ec 27 80 00       	push   $0x8027ec
  8003a9:	e8 b2 08 00 00       	call   800c60 <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8003ae:	e8 e7 1c 00 00       	call   80209a <sys_calculate_free_frames>
  8003b3:	89 c2                	mov    %eax,%edx
  8003b5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003b8:	39 c2                	cmp    %eax,%edx
  8003ba:	74 14                	je     8003d0 <_main+0x398>
  8003bc:	83 ec 04             	sub    $0x4,%esp
  8003bf:	68 64 29 80 00       	push   $0x802964
  8003c4:	6a 5f                	push   $0x5f
  8003c6:	68 ec 27 80 00       	push   $0x8027ec
  8003cb:	e8 90 08 00 00       	call   800c60 <_panic>

	// Test next fit

	freeFrames = sys_calculate_free_frames() ;
  8003d0:	e8 c5 1c 00 00       	call   80209a <sys_calculate_free_frames>
  8003d5:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8003d8:	e8 40 1d 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8003dd:	89 45 cc             	mov    %eax,-0x34(%ebp)
	void* tempAddress = malloc(Mega-kilo);		// Use Hole 1 -> Hole 1 = 1 M
  8003e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003e3:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003e6:	83 ec 0c             	sub    $0xc,%esp
  8003e9:	50                   	push   %eax
  8003ea:	e8 e9 18 00 00       	call   801cd8 <malloc>
  8003ef:	83 c4 10             	add    $0x10,%esp
  8003f2:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80000000)
  8003f5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8003f8:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8003fd:	74 14                	je     800413 <_main+0x3db>
		panic("Next Fit not working correctly");
  8003ff:	83 ec 04             	sub    $0x4,%esp
  800402:	68 a4 29 80 00       	push   $0x8029a4
  800407:	6a 67                	push   $0x67
  800409:	68 ec 27 80 00       	push   $0x8027ec
  80040e:	e8 4d 08 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800413:	e8 05 1d 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800418:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80041b:	89 c2                	mov    %eax,%edx
  80041d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800420:	85 c0                	test   %eax,%eax
  800422:	79 05                	jns    800429 <_main+0x3f1>
  800424:	05 ff 0f 00 00       	add    $0xfff,%eax
  800429:	c1 f8 0c             	sar    $0xc,%eax
  80042c:	39 c2                	cmp    %eax,%edx
  80042e:	74 14                	je     800444 <_main+0x40c>
  800430:	83 ec 04             	sub    $0x4,%esp
  800433:	68 fa 28 80 00       	push   $0x8028fa
  800438:	6a 68                	push   $0x68
  80043a:	68 ec 27 80 00       	push   $0x8027ec
  80043f:	e8 1c 08 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800444:	e8 51 1c 00 00       	call   80209a <sys_calculate_free_frames>
  800449:	89 c2                	mov    %eax,%edx
  80044b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80044e:	39 c2                	cmp    %eax,%edx
  800450:	74 14                	je     800466 <_main+0x42e>
  800452:	83 ec 04             	sub    $0x4,%esp
  800455:	68 17 29 80 00       	push   $0x802917
  80045a:	6a 69                	push   $0x69
  80045c:	68 ec 27 80 00       	push   $0x8027ec
  800461:	e8 fa 07 00 00       	call   800c60 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800466:	e8 2f 1c 00 00       	call   80209a <sys_calculate_free_frames>
  80046b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80046e:	e8 aa 1c 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800473:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo);					// Use Hole 1 -> Hole 1 = 1 M - Kilo
  800476:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800479:	83 ec 0c             	sub    $0xc,%esp
  80047c:	50                   	push   %eax
  80047d:	e8 56 18 00 00       	call   801cd8 <malloc>
  800482:	83 c4 10             	add    $0x10,%esp
  800485:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80100000)
  800488:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80048b:	3d 00 00 10 80       	cmp    $0x80100000,%eax
  800490:	74 14                	je     8004a6 <_main+0x46e>
		panic("Next Fit not working correctly");
  800492:	83 ec 04             	sub    $0x4,%esp
  800495:	68 a4 29 80 00       	push   $0x8029a4
  80049a:	6a 6f                	push   $0x6f
  80049c:	68 ec 27 80 00       	push   $0x8027ec
  8004a1:	e8 ba 07 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  8004a6:	e8 72 1c 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8004ab:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8004ae:	89 c2                	mov    %eax,%edx
  8004b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004b3:	c1 e0 02             	shl    $0x2,%eax
  8004b6:	85 c0                	test   %eax,%eax
  8004b8:	79 05                	jns    8004bf <_main+0x487>
  8004ba:	05 ff 0f 00 00       	add    $0xfff,%eax
  8004bf:	c1 f8 0c             	sar    $0xc,%eax
  8004c2:	39 c2                	cmp    %eax,%edx
  8004c4:	74 14                	je     8004da <_main+0x4a2>
  8004c6:	83 ec 04             	sub    $0x4,%esp
  8004c9:	68 fa 28 80 00       	push   $0x8028fa
  8004ce:	6a 70                	push   $0x70
  8004d0:	68 ec 27 80 00       	push   $0x8027ec
  8004d5:	e8 86 07 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8004da:	e8 bb 1b 00 00       	call   80209a <sys_calculate_free_frames>
  8004df:	89 c2                	mov    %eax,%edx
  8004e1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004e4:	39 c2                	cmp    %eax,%edx
  8004e6:	74 14                	je     8004fc <_main+0x4c4>
  8004e8:	83 ec 04             	sub    $0x4,%esp
  8004eb:	68 17 29 80 00       	push   $0x802917
  8004f0:	6a 71                	push   $0x71
  8004f2:	68 ec 27 80 00       	push   $0x8027ec
  8004f7:	e8 64 07 00 00       	call   800c60 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  8004fc:	e8 99 1b 00 00       	call   80209a <sys_calculate_free_frames>
  800501:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800504:	e8 14 1c 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800509:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(5*Mega); 			   // Use Hole 4 -> Hole 4 = 1 M
  80050c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80050f:	89 d0                	mov    %edx,%eax
  800511:	c1 e0 02             	shl    $0x2,%eax
  800514:	01 d0                	add    %edx,%eax
  800516:	83 ec 0c             	sub    $0xc,%esp
  800519:	50                   	push   %eax
  80051a:	e8 b9 17 00 00       	call   801cd8 <malloc>
  80051f:	83 c4 10             	add    $0x10,%esp
  800522:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81400000)
  800525:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800528:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  80052d:	74 14                	je     800543 <_main+0x50b>
		panic("Next Fit not working correctly");
  80052f:	83 ec 04             	sub    $0x4,%esp
  800532:	68 a4 29 80 00       	push   $0x8029a4
  800537:	6a 77                	push   $0x77
  800539:	68 ec 27 80 00       	push   $0x8027ec
  80053e:	e8 1d 07 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800543:	e8 d5 1b 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800548:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80054b:	89 c1                	mov    %eax,%ecx
  80054d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800550:	89 d0                	mov    %edx,%eax
  800552:	c1 e0 02             	shl    $0x2,%eax
  800555:	01 d0                	add    %edx,%eax
  800557:	85 c0                	test   %eax,%eax
  800559:	79 05                	jns    800560 <_main+0x528>
  80055b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800560:	c1 f8 0c             	sar    $0xc,%eax
  800563:	39 c1                	cmp    %eax,%ecx
  800565:	74 14                	je     80057b <_main+0x543>
  800567:	83 ec 04             	sub    $0x4,%esp
  80056a:	68 fa 28 80 00       	push   $0x8028fa
  80056f:	6a 78                	push   $0x78
  800571:	68 ec 27 80 00       	push   $0x8027ec
  800576:	e8 e5 06 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80057b:	e8 1a 1b 00 00       	call   80209a <sys_calculate_free_frames>
  800580:	89 c2                	mov    %eax,%edx
  800582:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800585:	39 c2                	cmp    %eax,%edx
  800587:	74 14                	je     80059d <_main+0x565>
  800589:	83 ec 04             	sub    $0x4,%esp
  80058c:	68 17 29 80 00       	push   $0x802917
  800591:	6a 79                	push   $0x79
  800593:	68 ec 27 80 00       	push   $0x8027ec
  800598:	e8 c3 06 00 00       	call   800c60 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  80059d:	e8 f8 1a 00 00       	call   80209a <sys_calculate_free_frames>
  8005a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8005a5:	e8 73 1b 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8005aa:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(1*Mega); 			   // Use Hole 4 -> Hole 4 = 0 M
  8005ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b0:	83 ec 0c             	sub    $0xc,%esp
  8005b3:	50                   	push   %eax
  8005b4:	e8 1f 17 00 00       	call   801cd8 <malloc>
  8005b9:	83 c4 10             	add    $0x10,%esp
  8005bc:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81900000)
  8005bf:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8005c2:	3d 00 00 90 81       	cmp    $0x81900000,%eax
  8005c7:	74 14                	je     8005dd <_main+0x5a5>
		panic("Next Fit not working correctly");
  8005c9:	83 ec 04             	sub    $0x4,%esp
  8005cc:	68 a4 29 80 00       	push   $0x8029a4
  8005d1:	6a 7f                	push   $0x7f
  8005d3:	68 ec 27 80 00       	push   $0x8027ec
  8005d8:	e8 83 06 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  8005dd:	e8 3b 1b 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8005e2:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8005e5:	89 c2                	mov    %eax,%edx
  8005e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ea:	85 c0                	test   %eax,%eax
  8005ec:	79 05                	jns    8005f3 <_main+0x5bb>
  8005ee:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005f3:	c1 f8 0c             	sar    $0xc,%eax
  8005f6:	39 c2                	cmp    %eax,%edx
  8005f8:	74 17                	je     800611 <_main+0x5d9>
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	68 fa 28 80 00       	push   $0x8028fa
  800602:	68 80 00 00 00       	push   $0x80
  800607:	68 ec 27 80 00       	push   $0x8027ec
  80060c:	e8 4f 06 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800611:	e8 84 1a 00 00       	call   80209a <sys_calculate_free_frames>
  800616:	89 c2                	mov    %eax,%edx
  800618:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80061b:	39 c2                	cmp    %eax,%edx
  80061d:	74 17                	je     800636 <_main+0x5fe>
  80061f:	83 ec 04             	sub    $0x4,%esp
  800622:	68 17 29 80 00       	push   $0x802917
  800627:	68 81 00 00 00       	push   $0x81
  80062c:	68 ec 27 80 00       	push   $0x8027ec
  800631:	e8 2a 06 00 00       	call   800c60 <_panic>


	freeFrames = sys_calculate_free_frames() ;
  800636:	e8 5f 1a 00 00       	call   80209a <sys_calculate_free_frames>
  80063b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80063e:	e8 da 1a 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800643:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[15]);					// Make a new hole => 2 M
  800646:	8b 85 04 f8 ff ff    	mov    -0x7fc(%ebp),%eax
  80064c:	83 ec 0c             	sub    $0xc,%esp
  80064f:	50                   	push   %eax
  800650:	e8 a4 17 00 00       	call   801df9 <free>
  800655:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800658:	e8 c0 1a 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  80065d:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800660:	29 c2                	sub    %eax,%edx
  800662:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800665:	01 c0                	add    %eax,%eax
  800667:	85 c0                	test   %eax,%eax
  800669:	79 05                	jns    800670 <_main+0x638>
  80066b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800670:	c1 f8 0c             	sar    $0xc,%eax
  800673:	39 c2                	cmp    %eax,%edx
  800675:	74 17                	je     80068e <_main+0x656>
  800677:	83 ec 04             	sub    $0x4,%esp
  80067a:	68 28 29 80 00       	push   $0x802928
  80067f:	68 87 00 00 00       	push   $0x87
  800684:	68 ec 27 80 00       	push   $0x8027ec
  800689:	e8 d2 05 00 00       	call   800c60 <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  80068e:	e8 07 1a 00 00       	call   80209a <sys_calculate_free_frames>
  800693:	89 c2                	mov    %eax,%edx
  800695:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800698:	39 c2                	cmp    %eax,%edx
  80069a:	74 17                	je     8006b3 <_main+0x67b>
  80069c:	83 ec 04             	sub    $0x4,%esp
  80069f:	68 64 29 80 00       	push   $0x802964
  8006a4:	68 88 00 00 00       	push   $0x88
  8006a9:	68 ec 27 80 00       	push   $0x8027ec
  8006ae:	e8 ad 05 00 00       	call   800c60 <_panic>

	//[NEXT FIT Case]
	freeFrames = sys_calculate_free_frames() ;
  8006b3:	e8 e2 19 00 00       	call   80209a <sys_calculate_free_frames>
  8006b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8006bb:	e8 5d 1a 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8006c0:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo); 			   // Use new Hole = 2 M - 4 kilo
  8006c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006c6:	83 ec 0c             	sub    $0xc,%esp
  8006c9:	50                   	push   %eax
  8006ca:	e8 09 16 00 00       	call   801cd8 <malloc>
  8006cf:	83 c4 10             	add    $0x10,%esp
  8006d2:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E00000)
  8006d5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8006d8:	3d 00 00 e0 81       	cmp    $0x81e00000,%eax
  8006dd:	74 17                	je     8006f6 <_main+0x6be>
		panic("Next Fit not working correctly");
  8006df:	83 ec 04             	sub    $0x4,%esp
  8006e2:	68 a4 29 80 00       	push   $0x8029a4
  8006e7:	68 8f 00 00 00       	push   $0x8f
  8006ec:	68 ec 27 80 00       	push   $0x8027ec
  8006f1:	e8 6a 05 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  8006f6:	e8 22 1a 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8006fb:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8006fe:	89 c2                	mov    %eax,%edx
  800700:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800703:	c1 e0 02             	shl    $0x2,%eax
  800706:	85 c0                	test   %eax,%eax
  800708:	79 05                	jns    80070f <_main+0x6d7>
  80070a:	05 ff 0f 00 00       	add    $0xfff,%eax
  80070f:	c1 f8 0c             	sar    $0xc,%eax
  800712:	39 c2                	cmp    %eax,%edx
  800714:	74 17                	je     80072d <_main+0x6f5>
  800716:	83 ec 04             	sub    $0x4,%esp
  800719:	68 fa 28 80 00       	push   $0x8028fa
  80071e:	68 90 00 00 00       	push   $0x90
  800723:	68 ec 27 80 00       	push   $0x8027ec
  800728:	e8 33 05 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80072d:	e8 68 19 00 00       	call   80209a <sys_calculate_free_frames>
  800732:	89 c2                	mov    %eax,%edx
  800734:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800737:	39 c2                	cmp    %eax,%edx
  800739:	74 17                	je     800752 <_main+0x71a>
  80073b:	83 ec 04             	sub    $0x4,%esp
  80073e:	68 17 29 80 00       	push   $0x802917
  800743:	68 91 00 00 00       	push   $0x91
  800748:	68 ec 27 80 00       	push   $0x8027ec
  80074d:	e8 0e 05 00 00       	call   800c60 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800752:	e8 43 19 00 00       	call   80209a <sys_calculate_free_frames>
  800757:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80075a:	e8 be 19 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  80075f:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(Mega + 1016*kilo); 	// Use new Hole = 4 kilo
  800762:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800765:	c1 e0 03             	shl    $0x3,%eax
  800768:	89 c2                	mov    %eax,%edx
  80076a:	c1 e2 07             	shl    $0x7,%edx
  80076d:	29 c2                	sub    %eax,%edx
  80076f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800772:	01 d0                	add    %edx,%eax
  800774:	83 ec 0c             	sub    $0xc,%esp
  800777:	50                   	push   %eax
  800778:	e8 5b 15 00 00       	call   801cd8 <malloc>
  80077d:	83 c4 10             	add    $0x10,%esp
  800780:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E01000)
  800783:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800786:	3d 00 10 e0 81       	cmp    $0x81e01000,%eax
  80078b:	74 17                	je     8007a4 <_main+0x76c>
		panic("Next Fit not working correctly");
  80078d:	83 ec 04             	sub    $0x4,%esp
  800790:	68 a4 29 80 00       	push   $0x8029a4
  800795:	68 97 00 00 00       	push   $0x97
  80079a:	68 ec 27 80 00       	push   $0x8027ec
  80079f:	e8 bc 04 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (1*Mega+1016*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  8007a4:	e8 74 19 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8007a9:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8007ac:	89 c2                	mov    %eax,%edx
  8007ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007b1:	c1 e0 03             	shl    $0x3,%eax
  8007b4:	89 c1                	mov    %eax,%ecx
  8007b6:	c1 e1 07             	shl    $0x7,%ecx
  8007b9:	29 c1                	sub    %eax,%ecx
  8007bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007be:	01 c8                	add    %ecx,%eax
  8007c0:	85 c0                	test   %eax,%eax
  8007c2:	79 05                	jns    8007c9 <_main+0x791>
  8007c4:	05 ff 0f 00 00       	add    $0xfff,%eax
  8007c9:	c1 f8 0c             	sar    $0xc,%eax
  8007cc:	39 c2                	cmp    %eax,%edx
  8007ce:	74 17                	je     8007e7 <_main+0x7af>
  8007d0:	83 ec 04             	sub    $0x4,%esp
  8007d3:	68 fa 28 80 00       	push   $0x8028fa
  8007d8:	68 98 00 00 00       	push   $0x98
  8007dd:	68 ec 27 80 00       	push   $0x8027ec
  8007e2:	e8 79 04 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8007e7:	e8 ae 18 00 00       	call   80209a <sys_calculate_free_frames>
  8007ec:	89 c2                	mov    %eax,%edx
  8007ee:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007f1:	39 c2                	cmp    %eax,%edx
  8007f3:	74 17                	je     80080c <_main+0x7d4>
  8007f5:	83 ec 04             	sub    $0x4,%esp
  8007f8:	68 17 29 80 00       	push   $0x802917
  8007fd:	68 99 00 00 00       	push   $0x99
  800802:	68 ec 27 80 00       	push   $0x8027ec
  800807:	e8 54 04 00 00       	call   800c60 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  80080c:	e8 89 18 00 00       	call   80209a <sys_calculate_free_frames>
  800811:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800814:	e8 04 19 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800819:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(512*kilo); 			   // Use Hole 5 -> Hole 5 = 1.5 M
  80081c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80081f:	c1 e0 09             	shl    $0x9,%eax
  800822:	83 ec 0c             	sub    $0xc,%esp
  800825:	50                   	push   %eax
  800826:	e8 ad 14 00 00       	call   801cd8 <malloc>
  80082b:	83 c4 10             	add    $0x10,%esp
  80082e:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x82800000)
  800831:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800834:	3d 00 00 80 82       	cmp    $0x82800000,%eax
  800839:	74 17                	je     800852 <_main+0x81a>
		panic("Next Fit not working correctly");
  80083b:	83 ec 04             	sub    $0x4,%esp
  80083e:	68 a4 29 80 00       	push   $0x8029a4
  800843:	68 9f 00 00 00       	push   $0x9f
  800848:	68 ec 27 80 00       	push   $0x8027ec
  80084d:	e8 0e 04 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  800852:	e8 c6 18 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800857:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80085a:	89 c2                	mov    %eax,%edx
  80085c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80085f:	c1 e0 09             	shl    $0x9,%eax
  800862:	85 c0                	test   %eax,%eax
  800864:	79 05                	jns    80086b <_main+0x833>
  800866:	05 ff 0f 00 00       	add    $0xfff,%eax
  80086b:	c1 f8 0c             	sar    $0xc,%eax
  80086e:	39 c2                	cmp    %eax,%edx
  800870:	74 17                	je     800889 <_main+0x851>
  800872:	83 ec 04             	sub    $0x4,%esp
  800875:	68 fa 28 80 00       	push   $0x8028fa
  80087a:	68 a0 00 00 00       	push   $0xa0
  80087f:	68 ec 27 80 00       	push   $0x8027ec
  800884:	e8 d7 03 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800889:	e8 0c 18 00 00       	call   80209a <sys_calculate_free_frames>
  80088e:	89 c2                	mov    %eax,%edx
  800890:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800893:	39 c2                	cmp    %eax,%edx
  800895:	74 17                	je     8008ae <_main+0x876>
  800897:	83 ec 04             	sub    $0x4,%esp
  80089a:	68 17 29 80 00       	push   $0x802917
  80089f:	68 a1 00 00 00       	push   $0xa1
  8008a4:	68 ec 27 80 00       	push   $0x8027ec
  8008a9:	e8 b2 03 00 00       	call   800c60 <_panic>

	cprintf("\nCASE1: (next fit without looping back) is succeeded...\n") ;
  8008ae:	83 ec 0c             	sub    $0xc,%esp
  8008b1:	68 c4 29 80 00       	push   $0x8029c4
  8008b6:	e8 59 06 00 00       	call   800f14 <cprintf>
  8008bb:	83 c4 10             	add    $0x10,%esp

	// Check that next fit is looping back to check for free space
	freeFrames = sys_calculate_free_frames() ;
  8008be:	e8 d7 17 00 00       	call   80209a <sys_calculate_free_frames>
  8008c3:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c6:	e8 52 18 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  8008cb:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(3*Mega + 512*kilo); 			   // Use Hole 2 -> Hole 2 = 0.5 M
  8008ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d1:	89 c2                	mov    %eax,%edx
  8008d3:	01 d2                	add    %edx,%edx
  8008d5:	01 c2                	add    %eax,%edx
  8008d7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008da:	c1 e0 09             	shl    $0x9,%eax
  8008dd:	01 d0                	add    %edx,%eax
  8008df:	83 ec 0c             	sub    $0xc,%esp
  8008e2:	50                   	push   %eax
  8008e3:	e8 f0 13 00 00       	call   801cd8 <malloc>
  8008e8:	83 c4 10             	add    $0x10,%esp
  8008eb:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80400000)
  8008ee:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8008f1:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8008f6:	74 17                	je     80090f <_main+0x8d7>
		panic("Next Fit not working correctly");
  8008f8:	83 ec 04             	sub    $0x4,%esp
  8008fb:	68 a4 29 80 00       	push   $0x8029a4
  800900:	68 aa 00 00 00       	push   $0xaa
  800905:	68 ec 27 80 00       	push   $0x8027ec
  80090a:	e8 51 03 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (3*Mega+512*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  80090f:	e8 09 18 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800914:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800917:	89 c2                	mov    %eax,%edx
  800919:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091c:	89 c1                	mov    %eax,%ecx
  80091e:	01 c9                	add    %ecx,%ecx
  800920:	01 c1                	add    %eax,%ecx
  800922:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800925:	c1 e0 09             	shl    $0x9,%eax
  800928:	01 c8                	add    %ecx,%eax
  80092a:	85 c0                	test   %eax,%eax
  80092c:	79 05                	jns    800933 <_main+0x8fb>
  80092e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800933:	c1 f8 0c             	sar    $0xc,%eax
  800936:	39 c2                	cmp    %eax,%edx
  800938:	74 17                	je     800951 <_main+0x919>
  80093a:	83 ec 04             	sub    $0x4,%esp
  80093d:	68 fa 28 80 00       	push   $0x8028fa
  800942:	68 ab 00 00 00       	push   $0xab
  800947:	68 ec 27 80 00       	push   $0x8027ec
  80094c:	e8 0f 03 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800951:	e8 44 17 00 00       	call   80209a <sys_calculate_free_frames>
  800956:	89 c2                	mov    %eax,%edx
  800958:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80095b:	39 c2                	cmp    %eax,%edx
  80095d:	74 17                	je     800976 <_main+0x93e>
  80095f:	83 ec 04             	sub    $0x4,%esp
  800962:	68 17 29 80 00       	push   $0x802917
  800967:	68 ac 00 00 00       	push   $0xac
  80096c:	68 ec 27 80 00       	push   $0x8027ec
  800971:	e8 ea 02 00 00       	call   800c60 <_panic>


	freeFrames = sys_calculate_free_frames() ;
  800976:	e8 1f 17 00 00       	call   80209a <sys_calculate_free_frames>
  80097b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80097e:	e8 9a 17 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800983:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[24]);		// Increase size of Hole 6 to 4 M
  800986:	8b 85 28 f8 ff ff    	mov    -0x7d8(%ebp),%eax
  80098c:	83 ec 0c             	sub    $0xc,%esp
  80098f:	50                   	push   %eax
  800990:	e8 64 14 00 00       	call   801df9 <free>
  800995:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800998:	e8 80 17 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  80099d:	8b 55 cc             	mov    -0x34(%ebp),%edx
  8009a0:	29 c2                	sub    %eax,%edx
  8009a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009a5:	01 c0                	add    %eax,%eax
  8009a7:	85 c0                	test   %eax,%eax
  8009a9:	79 05                	jns    8009b0 <_main+0x978>
  8009ab:	05 ff 0f 00 00       	add    $0xfff,%eax
  8009b0:	c1 f8 0c             	sar    $0xc,%eax
  8009b3:	39 c2                	cmp    %eax,%edx
  8009b5:	74 17                	je     8009ce <_main+0x996>
  8009b7:	83 ec 04             	sub    $0x4,%esp
  8009ba:	68 28 29 80 00       	push   $0x802928
  8009bf:	68 b2 00 00 00       	push   $0xb2
  8009c4:	68 ec 27 80 00       	push   $0x8027ec
  8009c9:	e8 92 02 00 00       	call   800c60 <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8009ce:	e8 c7 16 00 00       	call   80209a <sys_calculate_free_frames>
  8009d3:	89 c2                	mov    %eax,%edx
  8009d5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8009d8:	39 c2                	cmp    %eax,%edx
  8009da:	74 17                	je     8009f3 <_main+0x9bb>
  8009dc:	83 ec 04             	sub    $0x4,%esp
  8009df:	68 64 29 80 00       	push   $0x802964
  8009e4:	68 b3 00 00 00       	push   $0xb3
  8009e9:	68 ec 27 80 00       	push   $0x8027ec
  8009ee:	e8 6d 02 00 00       	call   800c60 <_panic>


	freeFrames = sys_calculate_free_frames() ;
  8009f3:	e8 a2 16 00 00       	call   80209a <sys_calculate_free_frames>
  8009f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8009fb:	e8 1d 17 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800a00:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(4*Mega-kilo);		// Use Hole 6 -> Hole 6 = 0 M
  800a03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a06:	c1 e0 02             	shl    $0x2,%eax
  800a09:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a0c:	83 ec 0c             	sub    $0xc,%esp
  800a0f:	50                   	push   %eax
  800a10:	e8 c3 12 00 00       	call   801cd8 <malloc>
  800a15:	83 c4 10             	add    $0x10,%esp
  800a18:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x83000000)
  800a1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800a1e:	3d 00 00 00 83       	cmp    $0x83000000,%eax
  800a23:	74 17                	je     800a3c <_main+0xa04>
		panic("Next Fit not working correctly");
  800a25:	83 ec 04             	sub    $0x4,%esp
  800a28:	68 a4 29 80 00       	push   $0x8029a4
  800a2d:	68 ba 00 00 00       	push   $0xba
  800a32:	68 ec 27 80 00       	push   $0x8027ec
  800a37:	e8 24 02 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800a3c:	e8 dc 16 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800a41:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800a44:	89 c2                	mov    %eax,%edx
  800a46:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a49:	c1 e0 02             	shl    $0x2,%eax
  800a4c:	85 c0                	test   %eax,%eax
  800a4e:	79 05                	jns    800a55 <_main+0xa1d>
  800a50:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a55:	c1 f8 0c             	sar    $0xc,%eax
  800a58:	39 c2                	cmp    %eax,%edx
  800a5a:	74 17                	je     800a73 <_main+0xa3b>
  800a5c:	83 ec 04             	sub    $0x4,%esp
  800a5f:	68 fa 28 80 00       	push   $0x8028fa
  800a64:	68 bb 00 00 00       	push   $0xbb
  800a69:	68 ec 27 80 00       	push   $0x8027ec
  800a6e:	e8 ed 01 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800a73:	e8 22 16 00 00       	call   80209a <sys_calculate_free_frames>
  800a78:	89 c2                	mov    %eax,%edx
  800a7a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a7d:	39 c2                	cmp    %eax,%edx
  800a7f:	74 17                	je     800a98 <_main+0xa60>
  800a81:	83 ec 04             	sub    $0x4,%esp
  800a84:	68 17 29 80 00       	push   $0x802917
  800a89:	68 bc 00 00 00       	push   $0xbc
  800a8e:	68 ec 27 80 00       	push   $0x8027ec
  800a93:	e8 c8 01 00 00       	call   800c60 <_panic>

	cprintf("\nCASE2: (next fit WITH looping back) is succeeded...\n") ;
  800a98:	83 ec 0c             	sub    $0xc,%esp
  800a9b:	68 00 2a 80 00       	push   $0x802a00
  800aa0:	e8 6f 04 00 00       	call   800f14 <cprintf>
  800aa5:	83 c4 10             	add    $0x10,%esp

	// Check that next fit returns null in case all holes are not free
	freeFrames = sys_calculate_free_frames() ;
  800aa8:	e8 ed 15 00 00       	call   80209a <sys_calculate_free_frames>
  800aad:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab0:	e8 68 16 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800ab5:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(6*Mega); 			   // No Suitable Hole is available
  800ab8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800abb:	89 d0                	mov    %edx,%eax
  800abd:	01 c0                	add    %eax,%eax
  800abf:	01 d0                	add    %edx,%eax
  800ac1:	01 c0                	add    %eax,%eax
  800ac3:	83 ec 0c             	sub    $0xc,%esp
  800ac6:	50                   	push   %eax
  800ac7:	e8 0c 12 00 00       	call   801cd8 <malloc>
  800acc:	83 c4 10             	add    $0x10,%esp
  800acf:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x0)
  800ad2:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800ad5:	85 c0                	test   %eax,%eax
  800ad7:	74 17                	je     800af0 <_main+0xab8>
		panic("Next Fit not working correctly");
  800ad9:	83 ec 04             	sub    $0x4,%esp
  800adc:	68 a4 29 80 00       	push   $0x8029a4
  800ae1:	68 c5 00 00 00       	push   $0xc5
  800ae6:	68 ec 27 80 00       	push   $0x8027ec
  800aeb:	e8 70 01 00 00       	call   800c60 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800af0:	e8 28 16 00 00       	call   80211d <sys_pf_calculate_allocated_pages>
  800af5:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  800af8:	74 17                	je     800b11 <_main+0xad9>
  800afa:	83 ec 04             	sub    $0x4,%esp
  800afd:	68 fa 28 80 00       	push   $0x8028fa
  800b02:	68 c6 00 00 00       	push   $0xc6
  800b07:	68 ec 27 80 00       	push   $0x8027ec
  800b0c:	e8 4f 01 00 00       	call   800c60 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800b11:	e8 84 15 00 00       	call   80209a <sys_calculate_free_frames>
  800b16:	89 c2                	mov    %eax,%edx
  800b18:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b1b:	39 c2                	cmp    %eax,%edx
  800b1d:	74 17                	je     800b36 <_main+0xafe>
  800b1f:	83 ec 04             	sub    $0x4,%esp
  800b22:	68 17 29 80 00       	push   $0x802917
  800b27:	68 c7 00 00 00       	push   $0xc7
  800b2c:	68 ec 27 80 00       	push   $0x8027ec
  800b31:	e8 2a 01 00 00       	call   800c60 <_panic>

	cprintf("\nCASE3: (next fit with insufficient space) is succeeded...\n") ;
  800b36:	83 ec 0c             	sub    $0xc,%esp
  800b39:	68 38 2a 80 00       	push   $0x802a38
  800b3e:	e8 d1 03 00 00       	call   800f14 <cprintf>
  800b43:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test Next Fit completed successfully.\n");
  800b46:	83 ec 0c             	sub    $0xc,%esp
  800b49:	68 74 2a 80 00       	push   $0x802a74
  800b4e:	e8 c1 03 00 00       	call   800f14 <cprintf>
  800b53:	83 c4 10             	add    $0x10,%esp

	return;
  800b56:	90                   	nop
}
  800b57:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b5a:	5b                   	pop    %ebx
  800b5b:	5f                   	pop    %edi
  800b5c:	5d                   	pop    %ebp
  800b5d:	c3                   	ret    

00800b5e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
  800b61:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800b64:	e8 66 14 00 00       	call   801fcf <sys_getenvindex>
  800b69:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b6f:	89 d0                	mov    %edx,%eax
  800b71:	01 c0                	add    %eax,%eax
  800b73:	01 d0                	add    %edx,%eax
  800b75:	c1 e0 02             	shl    $0x2,%eax
  800b78:	01 d0                	add    %edx,%eax
  800b7a:	c1 e0 06             	shl    $0x6,%eax
  800b7d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800b82:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b87:	a1 20 40 80 00       	mov    0x804020,%eax
  800b8c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800b92:	84 c0                	test   %al,%al
  800b94:	74 0f                	je     800ba5 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800b96:	a1 20 40 80 00       	mov    0x804020,%eax
  800b9b:	05 f4 02 00 00       	add    $0x2f4,%eax
  800ba0:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800ba5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ba9:	7e 0a                	jle    800bb5 <libmain+0x57>
		binaryname = argv[0];
  800bab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bae:	8b 00                	mov    (%eax),%eax
  800bb0:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800bb5:	83 ec 08             	sub    $0x8,%esp
  800bb8:	ff 75 0c             	pushl  0xc(%ebp)
  800bbb:	ff 75 08             	pushl  0x8(%ebp)
  800bbe:	e8 75 f4 ff ff       	call   800038 <_main>
  800bc3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800bc6:	e8 9f 15 00 00       	call   80216a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800bcb:	83 ec 0c             	sub    $0xc,%esp
  800bce:	68 c8 2a 80 00       	push   $0x802ac8
  800bd3:	e8 3c 03 00 00       	call   800f14 <cprintf>
  800bd8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800bdb:	a1 20 40 80 00       	mov    0x804020,%eax
  800be0:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800be6:	a1 20 40 80 00       	mov    0x804020,%eax
  800beb:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800bf1:	83 ec 04             	sub    $0x4,%esp
  800bf4:	52                   	push   %edx
  800bf5:	50                   	push   %eax
  800bf6:	68 f0 2a 80 00       	push   $0x802af0
  800bfb:	e8 14 03 00 00       	call   800f14 <cprintf>
  800c00:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c03:	a1 20 40 80 00       	mov    0x804020,%eax
  800c08:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800c0e:	83 ec 08             	sub    $0x8,%esp
  800c11:	50                   	push   %eax
  800c12:	68 15 2b 80 00       	push   $0x802b15
  800c17:	e8 f8 02 00 00       	call   800f14 <cprintf>
  800c1c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800c1f:	83 ec 0c             	sub    $0xc,%esp
  800c22:	68 c8 2a 80 00       	push   $0x802ac8
  800c27:	e8 e8 02 00 00       	call   800f14 <cprintf>
  800c2c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c2f:	e8 50 15 00 00       	call   802184 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800c34:	e8 19 00 00 00       	call   800c52 <exit>
}
  800c39:	90                   	nop
  800c3a:	c9                   	leave  
  800c3b:	c3                   	ret    

00800c3c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c3c:	55                   	push   %ebp
  800c3d:	89 e5                	mov    %esp,%ebp
  800c3f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800c42:	83 ec 0c             	sub    $0xc,%esp
  800c45:	6a 00                	push   $0x0
  800c47:	e8 4f 13 00 00       	call   801f9b <sys_env_destroy>
  800c4c:	83 c4 10             	add    $0x10,%esp
}
  800c4f:	90                   	nop
  800c50:	c9                   	leave  
  800c51:	c3                   	ret    

00800c52 <exit>:

void
exit(void)
{
  800c52:	55                   	push   %ebp
  800c53:	89 e5                	mov    %esp,%ebp
  800c55:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800c58:	e8 a4 13 00 00       	call   802001 <sys_env_exit>
}
  800c5d:	90                   	nop
  800c5e:	c9                   	leave  
  800c5f:	c3                   	ret    

00800c60 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c60:	55                   	push   %ebp
  800c61:	89 e5                	mov    %esp,%ebp
  800c63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c66:	8d 45 10             	lea    0x10(%ebp),%eax
  800c69:	83 c0 04             	add    $0x4,%eax
  800c6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800c6f:	a1 30 40 80 00       	mov    0x804030,%eax
  800c74:	85 c0                	test   %eax,%eax
  800c76:	74 16                	je     800c8e <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c78:	a1 30 40 80 00       	mov    0x804030,%eax
  800c7d:	83 ec 08             	sub    $0x8,%esp
  800c80:	50                   	push   %eax
  800c81:	68 2c 2b 80 00       	push   $0x802b2c
  800c86:	e8 89 02 00 00       	call   800f14 <cprintf>
  800c8b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c8e:	a1 00 40 80 00       	mov    0x804000,%eax
  800c93:	ff 75 0c             	pushl  0xc(%ebp)
  800c96:	ff 75 08             	pushl  0x8(%ebp)
  800c99:	50                   	push   %eax
  800c9a:	68 31 2b 80 00       	push   $0x802b31
  800c9f:	e8 70 02 00 00       	call   800f14 <cprintf>
  800ca4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800ca7:	8b 45 10             	mov    0x10(%ebp),%eax
  800caa:	83 ec 08             	sub    $0x8,%esp
  800cad:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb0:	50                   	push   %eax
  800cb1:	e8 f3 01 00 00       	call   800ea9 <vcprintf>
  800cb6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800cb9:	83 ec 08             	sub    $0x8,%esp
  800cbc:	6a 00                	push   $0x0
  800cbe:	68 4d 2b 80 00       	push   $0x802b4d
  800cc3:	e8 e1 01 00 00       	call   800ea9 <vcprintf>
  800cc8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800ccb:	e8 82 ff ff ff       	call   800c52 <exit>

	// should not return here
	while (1) ;
  800cd0:	eb fe                	jmp    800cd0 <_panic+0x70>

00800cd2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800cd2:	55                   	push   %ebp
  800cd3:	89 e5                	mov    %esp,%ebp
  800cd5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800cd8:	a1 20 40 80 00       	mov    0x804020,%eax
  800cdd:	8b 50 74             	mov    0x74(%eax),%edx
  800ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce3:	39 c2                	cmp    %eax,%edx
  800ce5:	74 14                	je     800cfb <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800ce7:	83 ec 04             	sub    $0x4,%esp
  800cea:	68 50 2b 80 00       	push   $0x802b50
  800cef:	6a 26                	push   $0x26
  800cf1:	68 9c 2b 80 00       	push   $0x802b9c
  800cf6:	e8 65 ff ff ff       	call   800c60 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800cfb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d02:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800d09:	e9 c2 00 00 00       	jmp    800dd0 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800d0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d11:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	01 d0                	add    %edx,%eax
  800d1d:	8b 00                	mov    (%eax),%eax
  800d1f:	85 c0                	test   %eax,%eax
  800d21:	75 08                	jne    800d2b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800d23:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800d26:	e9 a2 00 00 00       	jmp    800dcd <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800d2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d32:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800d39:	eb 69                	jmp    800da4 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800d3b:	a1 20 40 80 00       	mov    0x804020,%eax
  800d40:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d46:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d49:	89 d0                	mov    %edx,%eax
  800d4b:	01 c0                	add    %eax,%eax
  800d4d:	01 d0                	add    %edx,%eax
  800d4f:	c1 e0 02             	shl    $0x2,%eax
  800d52:	01 c8                	add    %ecx,%eax
  800d54:	8a 40 04             	mov    0x4(%eax),%al
  800d57:	84 c0                	test   %al,%al
  800d59:	75 46                	jne    800da1 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d5b:	a1 20 40 80 00       	mov    0x804020,%eax
  800d60:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d66:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d69:	89 d0                	mov    %edx,%eax
  800d6b:	01 c0                	add    %eax,%eax
  800d6d:	01 d0                	add    %edx,%eax
  800d6f:	c1 e0 02             	shl    $0x2,%eax
  800d72:	01 c8                	add    %ecx,%eax
  800d74:	8b 00                	mov    (%eax),%eax
  800d76:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800d79:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d81:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800d83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d86:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	01 c8                	add    %ecx,%eax
  800d92:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d94:	39 c2                	cmp    %eax,%edx
  800d96:	75 09                	jne    800da1 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800d98:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800d9f:	eb 12                	jmp    800db3 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800da1:	ff 45 e8             	incl   -0x18(%ebp)
  800da4:	a1 20 40 80 00       	mov    0x804020,%eax
  800da9:	8b 50 74             	mov    0x74(%eax),%edx
  800dac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800daf:	39 c2                	cmp    %eax,%edx
  800db1:	77 88                	ja     800d3b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800db3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800db7:	75 14                	jne    800dcd <CheckWSWithoutLastIndex+0xfb>
			panic(
  800db9:	83 ec 04             	sub    $0x4,%esp
  800dbc:	68 a8 2b 80 00       	push   $0x802ba8
  800dc1:	6a 3a                	push   $0x3a
  800dc3:	68 9c 2b 80 00       	push   $0x802b9c
  800dc8:	e8 93 fe ff ff       	call   800c60 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800dcd:	ff 45 f0             	incl   -0x10(%ebp)
  800dd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dd3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800dd6:	0f 8c 32 ff ff ff    	jl     800d0e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800ddc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800de3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800dea:	eb 26                	jmp    800e12 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800dec:	a1 20 40 80 00       	mov    0x804020,%eax
  800df1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800df7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dfa:	89 d0                	mov    %edx,%eax
  800dfc:	01 c0                	add    %eax,%eax
  800dfe:	01 d0                	add    %edx,%eax
  800e00:	c1 e0 02             	shl    $0x2,%eax
  800e03:	01 c8                	add    %ecx,%eax
  800e05:	8a 40 04             	mov    0x4(%eax),%al
  800e08:	3c 01                	cmp    $0x1,%al
  800e0a:	75 03                	jne    800e0f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800e0c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e0f:	ff 45 e0             	incl   -0x20(%ebp)
  800e12:	a1 20 40 80 00       	mov    0x804020,%eax
  800e17:	8b 50 74             	mov    0x74(%eax),%edx
  800e1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e1d:	39 c2                	cmp    %eax,%edx
  800e1f:	77 cb                	ja     800dec <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e24:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800e27:	74 14                	je     800e3d <CheckWSWithoutLastIndex+0x16b>
		panic(
  800e29:	83 ec 04             	sub    $0x4,%esp
  800e2c:	68 fc 2b 80 00       	push   $0x802bfc
  800e31:	6a 44                	push   $0x44
  800e33:	68 9c 2b 80 00       	push   $0x802b9c
  800e38:	e8 23 fe ff ff       	call   800c60 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e3d:	90                   	nop
  800e3e:	c9                   	leave  
  800e3f:	c3                   	ret    

00800e40 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800e40:	55                   	push   %ebp
  800e41:	89 e5                	mov    %esp,%ebp
  800e43:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800e46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e49:	8b 00                	mov    (%eax),%eax
  800e4b:	8d 48 01             	lea    0x1(%eax),%ecx
  800e4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e51:	89 0a                	mov    %ecx,(%edx)
  800e53:	8b 55 08             	mov    0x8(%ebp),%edx
  800e56:	88 d1                	mov    %dl,%cl
  800e58:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e5b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	8b 00                	mov    (%eax),%eax
  800e64:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e69:	75 2c                	jne    800e97 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e6b:	a0 24 40 80 00       	mov    0x804024,%al
  800e70:	0f b6 c0             	movzbl %al,%eax
  800e73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e76:	8b 12                	mov    (%edx),%edx
  800e78:	89 d1                	mov    %edx,%ecx
  800e7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e7d:	83 c2 08             	add    $0x8,%edx
  800e80:	83 ec 04             	sub    $0x4,%esp
  800e83:	50                   	push   %eax
  800e84:	51                   	push   %ecx
  800e85:	52                   	push   %edx
  800e86:	e8 ce 10 00 00       	call   801f59 <sys_cputs>
  800e8b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e91:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800e97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9a:	8b 40 04             	mov    0x4(%eax),%eax
  800e9d:	8d 50 01             	lea    0x1(%eax),%edx
  800ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea3:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ea6:	90                   	nop
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800eb2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800eb9:	00 00 00 
	b.cnt = 0;
  800ebc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ec3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800ec6:	ff 75 0c             	pushl  0xc(%ebp)
  800ec9:	ff 75 08             	pushl  0x8(%ebp)
  800ecc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ed2:	50                   	push   %eax
  800ed3:	68 40 0e 80 00       	push   $0x800e40
  800ed8:	e8 11 02 00 00       	call   8010ee <vprintfmt>
  800edd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800ee0:	a0 24 40 80 00       	mov    0x804024,%al
  800ee5:	0f b6 c0             	movzbl %al,%eax
  800ee8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800eee:	83 ec 04             	sub    $0x4,%esp
  800ef1:	50                   	push   %eax
  800ef2:	52                   	push   %edx
  800ef3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ef9:	83 c0 08             	add    $0x8,%eax
  800efc:	50                   	push   %eax
  800efd:	e8 57 10 00 00       	call   801f59 <sys_cputs>
  800f02:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f05:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800f0c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800f12:	c9                   	leave  
  800f13:	c3                   	ret    

00800f14 <cprintf>:

int cprintf(const char *fmt, ...) {
  800f14:	55                   	push   %ebp
  800f15:	89 e5                	mov    %esp,%ebp
  800f17:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800f1a:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800f21:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f24:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	83 ec 08             	sub    $0x8,%esp
  800f2d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f30:	50                   	push   %eax
  800f31:	e8 73 ff ff ff       	call   800ea9 <vcprintf>
  800f36:	83 c4 10             	add    $0x10,%esp
  800f39:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f3f:	c9                   	leave  
  800f40:	c3                   	ret    

00800f41 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800f41:	55                   	push   %ebp
  800f42:	89 e5                	mov    %esp,%ebp
  800f44:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800f47:	e8 1e 12 00 00       	call   80216a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800f4c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	83 ec 08             	sub    $0x8,%esp
  800f58:	ff 75 f4             	pushl  -0xc(%ebp)
  800f5b:	50                   	push   %eax
  800f5c:	e8 48 ff ff ff       	call   800ea9 <vcprintf>
  800f61:	83 c4 10             	add    $0x10,%esp
  800f64:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f67:	e8 18 12 00 00       	call   802184 <sys_enable_interrupt>
	return cnt;
  800f6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f6f:	c9                   	leave  
  800f70:	c3                   	ret    

00800f71 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f71:	55                   	push   %ebp
  800f72:	89 e5                	mov    %esp,%ebp
  800f74:	53                   	push   %ebx
  800f75:	83 ec 14             	sub    $0x14,%esp
  800f78:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f81:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800f84:	8b 45 18             	mov    0x18(%ebp),%eax
  800f87:	ba 00 00 00 00       	mov    $0x0,%edx
  800f8c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f8f:	77 55                	ja     800fe6 <printnum+0x75>
  800f91:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f94:	72 05                	jb     800f9b <printnum+0x2a>
  800f96:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f99:	77 4b                	ja     800fe6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800f9b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800f9e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800fa1:	8b 45 18             	mov    0x18(%ebp),%eax
  800fa4:	ba 00 00 00 00       	mov    $0x0,%edx
  800fa9:	52                   	push   %edx
  800faa:	50                   	push   %eax
  800fab:	ff 75 f4             	pushl  -0xc(%ebp)
  800fae:	ff 75 f0             	pushl  -0x10(%ebp)
  800fb1:	e8 92 15 00 00       	call   802548 <__udivdi3>
  800fb6:	83 c4 10             	add    $0x10,%esp
  800fb9:	83 ec 04             	sub    $0x4,%esp
  800fbc:	ff 75 20             	pushl  0x20(%ebp)
  800fbf:	53                   	push   %ebx
  800fc0:	ff 75 18             	pushl  0x18(%ebp)
  800fc3:	52                   	push   %edx
  800fc4:	50                   	push   %eax
  800fc5:	ff 75 0c             	pushl  0xc(%ebp)
  800fc8:	ff 75 08             	pushl  0x8(%ebp)
  800fcb:	e8 a1 ff ff ff       	call   800f71 <printnum>
  800fd0:	83 c4 20             	add    $0x20,%esp
  800fd3:	eb 1a                	jmp    800fef <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800fd5:	83 ec 08             	sub    $0x8,%esp
  800fd8:	ff 75 0c             	pushl  0xc(%ebp)
  800fdb:	ff 75 20             	pushl  0x20(%ebp)
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	ff d0                	call   *%eax
  800fe3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800fe6:	ff 4d 1c             	decl   0x1c(%ebp)
  800fe9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800fed:	7f e6                	jg     800fd5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800fef:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ff2:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ff7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ffa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ffd:	53                   	push   %ebx
  800ffe:	51                   	push   %ecx
  800fff:	52                   	push   %edx
  801000:	50                   	push   %eax
  801001:	e8 52 16 00 00       	call   802658 <__umoddi3>
  801006:	83 c4 10             	add    $0x10,%esp
  801009:	05 74 2e 80 00       	add    $0x802e74,%eax
  80100e:	8a 00                	mov    (%eax),%al
  801010:	0f be c0             	movsbl %al,%eax
  801013:	83 ec 08             	sub    $0x8,%esp
  801016:	ff 75 0c             	pushl  0xc(%ebp)
  801019:	50                   	push   %eax
  80101a:	8b 45 08             	mov    0x8(%ebp),%eax
  80101d:	ff d0                	call   *%eax
  80101f:	83 c4 10             	add    $0x10,%esp
}
  801022:	90                   	nop
  801023:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801026:	c9                   	leave  
  801027:	c3                   	ret    

00801028 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801028:	55                   	push   %ebp
  801029:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80102b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80102f:	7e 1c                	jle    80104d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	8b 00                	mov    (%eax),%eax
  801036:	8d 50 08             	lea    0x8(%eax),%edx
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	89 10                	mov    %edx,(%eax)
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8b 00                	mov    (%eax),%eax
  801043:	83 e8 08             	sub    $0x8,%eax
  801046:	8b 50 04             	mov    0x4(%eax),%edx
  801049:	8b 00                	mov    (%eax),%eax
  80104b:	eb 40                	jmp    80108d <getuint+0x65>
	else if (lflag)
  80104d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801051:	74 1e                	je     801071 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8b 00                	mov    (%eax),%eax
  801058:	8d 50 04             	lea    0x4(%eax),%edx
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	89 10                	mov    %edx,(%eax)
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8b 00                	mov    (%eax),%eax
  801065:	83 e8 04             	sub    $0x4,%eax
  801068:	8b 00                	mov    (%eax),%eax
  80106a:	ba 00 00 00 00       	mov    $0x0,%edx
  80106f:	eb 1c                	jmp    80108d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8b 00                	mov    (%eax),%eax
  801076:	8d 50 04             	lea    0x4(%eax),%edx
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	89 10                	mov    %edx,(%eax)
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	8b 00                	mov    (%eax),%eax
  801083:	83 e8 04             	sub    $0x4,%eax
  801086:	8b 00                	mov    (%eax),%eax
  801088:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80108d:	5d                   	pop    %ebp
  80108e:	c3                   	ret    

0080108f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80108f:	55                   	push   %ebp
  801090:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801092:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801096:	7e 1c                	jle    8010b4 <getint+0x25>
		return va_arg(*ap, long long);
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	8b 00                	mov    (%eax),%eax
  80109d:	8d 50 08             	lea    0x8(%eax),%edx
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	89 10                	mov    %edx,(%eax)
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8b 00                	mov    (%eax),%eax
  8010aa:	83 e8 08             	sub    $0x8,%eax
  8010ad:	8b 50 04             	mov    0x4(%eax),%edx
  8010b0:	8b 00                	mov    (%eax),%eax
  8010b2:	eb 38                	jmp    8010ec <getint+0x5d>
	else if (lflag)
  8010b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010b8:	74 1a                	je     8010d4 <getint+0x45>
		return va_arg(*ap, long);
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	8b 00                	mov    (%eax),%eax
  8010bf:	8d 50 04             	lea    0x4(%eax),%edx
  8010c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c5:	89 10                	mov    %edx,(%eax)
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	8b 00                	mov    (%eax),%eax
  8010cc:	83 e8 04             	sub    $0x4,%eax
  8010cf:	8b 00                	mov    (%eax),%eax
  8010d1:	99                   	cltd   
  8010d2:	eb 18                	jmp    8010ec <getint+0x5d>
	else
		return va_arg(*ap, int);
  8010d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d7:	8b 00                	mov    (%eax),%eax
  8010d9:	8d 50 04             	lea    0x4(%eax),%edx
  8010dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010df:	89 10                	mov    %edx,(%eax)
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	8b 00                	mov    (%eax),%eax
  8010e6:	83 e8 04             	sub    $0x4,%eax
  8010e9:	8b 00                	mov    (%eax),%eax
  8010eb:	99                   	cltd   
}
  8010ec:	5d                   	pop    %ebp
  8010ed:	c3                   	ret    

008010ee <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8010ee:	55                   	push   %ebp
  8010ef:	89 e5                	mov    %esp,%ebp
  8010f1:	56                   	push   %esi
  8010f2:	53                   	push   %ebx
  8010f3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010f6:	eb 17                	jmp    80110f <vprintfmt+0x21>
			if (ch == '\0')
  8010f8:	85 db                	test   %ebx,%ebx
  8010fa:	0f 84 af 03 00 00    	je     8014af <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801100:	83 ec 08             	sub    $0x8,%esp
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	53                   	push   %ebx
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	ff d0                	call   *%eax
  80110c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80110f:	8b 45 10             	mov    0x10(%ebp),%eax
  801112:	8d 50 01             	lea    0x1(%eax),%edx
  801115:	89 55 10             	mov    %edx,0x10(%ebp)
  801118:	8a 00                	mov    (%eax),%al
  80111a:	0f b6 d8             	movzbl %al,%ebx
  80111d:	83 fb 25             	cmp    $0x25,%ebx
  801120:	75 d6                	jne    8010f8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801122:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801126:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80112d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801134:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80113b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801142:	8b 45 10             	mov    0x10(%ebp),%eax
  801145:	8d 50 01             	lea    0x1(%eax),%edx
  801148:	89 55 10             	mov    %edx,0x10(%ebp)
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	0f b6 d8             	movzbl %al,%ebx
  801150:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801153:	83 f8 55             	cmp    $0x55,%eax
  801156:	0f 87 2b 03 00 00    	ja     801487 <vprintfmt+0x399>
  80115c:	8b 04 85 98 2e 80 00 	mov    0x802e98(,%eax,4),%eax
  801163:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801165:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801169:	eb d7                	jmp    801142 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80116b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80116f:	eb d1                	jmp    801142 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801171:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801178:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80117b:	89 d0                	mov    %edx,%eax
  80117d:	c1 e0 02             	shl    $0x2,%eax
  801180:	01 d0                	add    %edx,%eax
  801182:	01 c0                	add    %eax,%eax
  801184:	01 d8                	add    %ebx,%eax
  801186:	83 e8 30             	sub    $0x30,%eax
  801189:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80118c:	8b 45 10             	mov    0x10(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801194:	83 fb 2f             	cmp    $0x2f,%ebx
  801197:	7e 3e                	jle    8011d7 <vprintfmt+0xe9>
  801199:	83 fb 39             	cmp    $0x39,%ebx
  80119c:	7f 39                	jg     8011d7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80119e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8011a1:	eb d5                	jmp    801178 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8011a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a6:	83 c0 04             	add    $0x4,%eax
  8011a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8011ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8011af:	83 e8 04             	sub    $0x4,%eax
  8011b2:	8b 00                	mov    (%eax),%eax
  8011b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8011b7:	eb 1f                	jmp    8011d8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8011b9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011bd:	79 83                	jns    801142 <vprintfmt+0x54>
				width = 0;
  8011bf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8011c6:	e9 77 ff ff ff       	jmp    801142 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8011cb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8011d2:	e9 6b ff ff ff       	jmp    801142 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8011d7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8011d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011dc:	0f 89 60 ff ff ff    	jns    801142 <vprintfmt+0x54>
				width = precision, precision = -1;
  8011e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8011e8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8011ef:	e9 4e ff ff ff       	jmp    801142 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8011f4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8011f7:	e9 46 ff ff ff       	jmp    801142 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8011fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ff:	83 c0 04             	add    $0x4,%eax
  801202:	89 45 14             	mov    %eax,0x14(%ebp)
  801205:	8b 45 14             	mov    0x14(%ebp),%eax
  801208:	83 e8 04             	sub    $0x4,%eax
  80120b:	8b 00                	mov    (%eax),%eax
  80120d:	83 ec 08             	sub    $0x8,%esp
  801210:	ff 75 0c             	pushl  0xc(%ebp)
  801213:	50                   	push   %eax
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	ff d0                	call   *%eax
  801219:	83 c4 10             	add    $0x10,%esp
			break;
  80121c:	e9 89 02 00 00       	jmp    8014aa <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801221:	8b 45 14             	mov    0x14(%ebp),%eax
  801224:	83 c0 04             	add    $0x4,%eax
  801227:	89 45 14             	mov    %eax,0x14(%ebp)
  80122a:	8b 45 14             	mov    0x14(%ebp),%eax
  80122d:	83 e8 04             	sub    $0x4,%eax
  801230:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801232:	85 db                	test   %ebx,%ebx
  801234:	79 02                	jns    801238 <vprintfmt+0x14a>
				err = -err;
  801236:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801238:	83 fb 64             	cmp    $0x64,%ebx
  80123b:	7f 0b                	jg     801248 <vprintfmt+0x15a>
  80123d:	8b 34 9d e0 2c 80 00 	mov    0x802ce0(,%ebx,4),%esi
  801244:	85 f6                	test   %esi,%esi
  801246:	75 19                	jne    801261 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801248:	53                   	push   %ebx
  801249:	68 85 2e 80 00       	push   $0x802e85
  80124e:	ff 75 0c             	pushl  0xc(%ebp)
  801251:	ff 75 08             	pushl  0x8(%ebp)
  801254:	e8 5e 02 00 00       	call   8014b7 <printfmt>
  801259:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80125c:	e9 49 02 00 00       	jmp    8014aa <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801261:	56                   	push   %esi
  801262:	68 8e 2e 80 00       	push   $0x802e8e
  801267:	ff 75 0c             	pushl  0xc(%ebp)
  80126a:	ff 75 08             	pushl  0x8(%ebp)
  80126d:	e8 45 02 00 00       	call   8014b7 <printfmt>
  801272:	83 c4 10             	add    $0x10,%esp
			break;
  801275:	e9 30 02 00 00       	jmp    8014aa <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80127a:	8b 45 14             	mov    0x14(%ebp),%eax
  80127d:	83 c0 04             	add    $0x4,%eax
  801280:	89 45 14             	mov    %eax,0x14(%ebp)
  801283:	8b 45 14             	mov    0x14(%ebp),%eax
  801286:	83 e8 04             	sub    $0x4,%eax
  801289:	8b 30                	mov    (%eax),%esi
  80128b:	85 f6                	test   %esi,%esi
  80128d:	75 05                	jne    801294 <vprintfmt+0x1a6>
				p = "(null)";
  80128f:	be 91 2e 80 00       	mov    $0x802e91,%esi
			if (width > 0 && padc != '-')
  801294:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801298:	7e 6d                	jle    801307 <vprintfmt+0x219>
  80129a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80129e:	74 67                	je     801307 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8012a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012a3:	83 ec 08             	sub    $0x8,%esp
  8012a6:	50                   	push   %eax
  8012a7:	56                   	push   %esi
  8012a8:	e8 0c 03 00 00       	call   8015b9 <strnlen>
  8012ad:	83 c4 10             	add    $0x10,%esp
  8012b0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8012b3:	eb 16                	jmp    8012cb <vprintfmt+0x1dd>
					putch(padc, putdat);
  8012b5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8012b9:	83 ec 08             	sub    $0x8,%esp
  8012bc:	ff 75 0c             	pushl  0xc(%ebp)
  8012bf:	50                   	push   %eax
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	ff d0                	call   *%eax
  8012c5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8012c8:	ff 4d e4             	decl   -0x1c(%ebp)
  8012cb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012cf:	7f e4                	jg     8012b5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8012d1:	eb 34                	jmp    801307 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8012d3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8012d7:	74 1c                	je     8012f5 <vprintfmt+0x207>
  8012d9:	83 fb 1f             	cmp    $0x1f,%ebx
  8012dc:	7e 05                	jle    8012e3 <vprintfmt+0x1f5>
  8012de:	83 fb 7e             	cmp    $0x7e,%ebx
  8012e1:	7e 12                	jle    8012f5 <vprintfmt+0x207>
					putch('?', putdat);
  8012e3:	83 ec 08             	sub    $0x8,%esp
  8012e6:	ff 75 0c             	pushl  0xc(%ebp)
  8012e9:	6a 3f                	push   $0x3f
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	ff d0                	call   *%eax
  8012f0:	83 c4 10             	add    $0x10,%esp
  8012f3:	eb 0f                	jmp    801304 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8012f5:	83 ec 08             	sub    $0x8,%esp
  8012f8:	ff 75 0c             	pushl  0xc(%ebp)
  8012fb:	53                   	push   %ebx
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	ff d0                	call   *%eax
  801301:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801304:	ff 4d e4             	decl   -0x1c(%ebp)
  801307:	89 f0                	mov    %esi,%eax
  801309:	8d 70 01             	lea    0x1(%eax),%esi
  80130c:	8a 00                	mov    (%eax),%al
  80130e:	0f be d8             	movsbl %al,%ebx
  801311:	85 db                	test   %ebx,%ebx
  801313:	74 24                	je     801339 <vprintfmt+0x24b>
  801315:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801319:	78 b8                	js     8012d3 <vprintfmt+0x1e5>
  80131b:	ff 4d e0             	decl   -0x20(%ebp)
  80131e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801322:	79 af                	jns    8012d3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801324:	eb 13                	jmp    801339 <vprintfmt+0x24b>
				putch(' ', putdat);
  801326:	83 ec 08             	sub    $0x8,%esp
  801329:	ff 75 0c             	pushl  0xc(%ebp)
  80132c:	6a 20                	push   $0x20
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	ff d0                	call   *%eax
  801333:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801336:	ff 4d e4             	decl   -0x1c(%ebp)
  801339:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80133d:	7f e7                	jg     801326 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80133f:	e9 66 01 00 00       	jmp    8014aa <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801344:	83 ec 08             	sub    $0x8,%esp
  801347:	ff 75 e8             	pushl  -0x18(%ebp)
  80134a:	8d 45 14             	lea    0x14(%ebp),%eax
  80134d:	50                   	push   %eax
  80134e:	e8 3c fd ff ff       	call   80108f <getint>
  801353:	83 c4 10             	add    $0x10,%esp
  801356:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801359:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80135c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80135f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801362:	85 d2                	test   %edx,%edx
  801364:	79 23                	jns    801389 <vprintfmt+0x29b>
				putch('-', putdat);
  801366:	83 ec 08             	sub    $0x8,%esp
  801369:	ff 75 0c             	pushl  0xc(%ebp)
  80136c:	6a 2d                	push   $0x2d
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	ff d0                	call   *%eax
  801373:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801376:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801379:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80137c:	f7 d8                	neg    %eax
  80137e:	83 d2 00             	adc    $0x0,%edx
  801381:	f7 da                	neg    %edx
  801383:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801386:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801389:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801390:	e9 bc 00 00 00       	jmp    801451 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801395:	83 ec 08             	sub    $0x8,%esp
  801398:	ff 75 e8             	pushl  -0x18(%ebp)
  80139b:	8d 45 14             	lea    0x14(%ebp),%eax
  80139e:	50                   	push   %eax
  80139f:	e8 84 fc ff ff       	call   801028 <getuint>
  8013a4:	83 c4 10             	add    $0x10,%esp
  8013a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8013ad:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8013b4:	e9 98 00 00 00       	jmp    801451 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8013b9:	83 ec 08             	sub    $0x8,%esp
  8013bc:	ff 75 0c             	pushl  0xc(%ebp)
  8013bf:	6a 58                	push   $0x58
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	ff d0                	call   *%eax
  8013c6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8013c9:	83 ec 08             	sub    $0x8,%esp
  8013cc:	ff 75 0c             	pushl  0xc(%ebp)
  8013cf:	6a 58                	push   $0x58
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	ff d0                	call   *%eax
  8013d6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8013d9:	83 ec 08             	sub    $0x8,%esp
  8013dc:	ff 75 0c             	pushl  0xc(%ebp)
  8013df:	6a 58                	push   $0x58
  8013e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e4:	ff d0                	call   *%eax
  8013e6:	83 c4 10             	add    $0x10,%esp
			break;
  8013e9:	e9 bc 00 00 00       	jmp    8014aa <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8013ee:	83 ec 08             	sub    $0x8,%esp
  8013f1:	ff 75 0c             	pushl  0xc(%ebp)
  8013f4:	6a 30                	push   $0x30
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	ff d0                	call   *%eax
  8013fb:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8013fe:	83 ec 08             	sub    $0x8,%esp
  801401:	ff 75 0c             	pushl  0xc(%ebp)
  801404:	6a 78                	push   $0x78
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	ff d0                	call   *%eax
  80140b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80140e:	8b 45 14             	mov    0x14(%ebp),%eax
  801411:	83 c0 04             	add    $0x4,%eax
  801414:	89 45 14             	mov    %eax,0x14(%ebp)
  801417:	8b 45 14             	mov    0x14(%ebp),%eax
  80141a:	83 e8 04             	sub    $0x4,%eax
  80141d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80141f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801422:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801429:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801430:	eb 1f                	jmp    801451 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801432:	83 ec 08             	sub    $0x8,%esp
  801435:	ff 75 e8             	pushl  -0x18(%ebp)
  801438:	8d 45 14             	lea    0x14(%ebp),%eax
  80143b:	50                   	push   %eax
  80143c:	e8 e7 fb ff ff       	call   801028 <getuint>
  801441:	83 c4 10             	add    $0x10,%esp
  801444:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801447:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80144a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801451:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801455:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801458:	83 ec 04             	sub    $0x4,%esp
  80145b:	52                   	push   %edx
  80145c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80145f:	50                   	push   %eax
  801460:	ff 75 f4             	pushl  -0xc(%ebp)
  801463:	ff 75 f0             	pushl  -0x10(%ebp)
  801466:	ff 75 0c             	pushl  0xc(%ebp)
  801469:	ff 75 08             	pushl  0x8(%ebp)
  80146c:	e8 00 fb ff ff       	call   800f71 <printnum>
  801471:	83 c4 20             	add    $0x20,%esp
			break;
  801474:	eb 34                	jmp    8014aa <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801476:	83 ec 08             	sub    $0x8,%esp
  801479:	ff 75 0c             	pushl  0xc(%ebp)
  80147c:	53                   	push   %ebx
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	ff d0                	call   *%eax
  801482:	83 c4 10             	add    $0x10,%esp
			break;
  801485:	eb 23                	jmp    8014aa <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801487:	83 ec 08             	sub    $0x8,%esp
  80148a:	ff 75 0c             	pushl  0xc(%ebp)
  80148d:	6a 25                	push   $0x25
  80148f:	8b 45 08             	mov    0x8(%ebp),%eax
  801492:	ff d0                	call   *%eax
  801494:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801497:	ff 4d 10             	decl   0x10(%ebp)
  80149a:	eb 03                	jmp    80149f <vprintfmt+0x3b1>
  80149c:	ff 4d 10             	decl   0x10(%ebp)
  80149f:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a2:	48                   	dec    %eax
  8014a3:	8a 00                	mov    (%eax),%al
  8014a5:	3c 25                	cmp    $0x25,%al
  8014a7:	75 f3                	jne    80149c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8014a9:	90                   	nop
		}
	}
  8014aa:	e9 47 fc ff ff       	jmp    8010f6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8014af:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8014b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8014b3:	5b                   	pop    %ebx
  8014b4:	5e                   	pop    %esi
  8014b5:	5d                   	pop    %ebp
  8014b6:	c3                   	ret    

008014b7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
  8014ba:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8014bd:	8d 45 10             	lea    0x10(%ebp),%eax
  8014c0:	83 c0 04             	add    $0x4,%eax
  8014c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8014c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8014cc:	50                   	push   %eax
  8014cd:	ff 75 0c             	pushl  0xc(%ebp)
  8014d0:	ff 75 08             	pushl  0x8(%ebp)
  8014d3:	e8 16 fc ff ff       	call   8010ee <vprintfmt>
  8014d8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8014db:	90                   	nop
  8014dc:	c9                   	leave  
  8014dd:	c3                   	ret    

008014de <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8014de:	55                   	push   %ebp
  8014df:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8014e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e4:	8b 40 08             	mov    0x8(%eax),%eax
  8014e7:	8d 50 01             	lea    0x1(%eax),%edx
  8014ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ed:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8014f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f3:	8b 10                	mov    (%eax),%edx
  8014f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f8:	8b 40 04             	mov    0x4(%eax),%eax
  8014fb:	39 c2                	cmp    %eax,%edx
  8014fd:	73 12                	jae    801511 <sprintputch+0x33>
		*b->buf++ = ch;
  8014ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801502:	8b 00                	mov    (%eax),%eax
  801504:	8d 48 01             	lea    0x1(%eax),%ecx
  801507:	8b 55 0c             	mov    0xc(%ebp),%edx
  80150a:	89 0a                	mov    %ecx,(%edx)
  80150c:	8b 55 08             	mov    0x8(%ebp),%edx
  80150f:	88 10                	mov    %dl,(%eax)
}
  801511:	90                   	nop
  801512:	5d                   	pop    %ebp
  801513:	c3                   	ret    

00801514 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
  801517:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801520:	8b 45 0c             	mov    0xc(%ebp),%eax
  801523:	8d 50 ff             	lea    -0x1(%eax),%edx
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	01 d0                	add    %edx,%eax
  80152b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80152e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801535:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801539:	74 06                	je     801541 <vsnprintf+0x2d>
  80153b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80153f:	7f 07                	jg     801548 <vsnprintf+0x34>
		return -E_INVAL;
  801541:	b8 03 00 00 00       	mov    $0x3,%eax
  801546:	eb 20                	jmp    801568 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801548:	ff 75 14             	pushl  0x14(%ebp)
  80154b:	ff 75 10             	pushl  0x10(%ebp)
  80154e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801551:	50                   	push   %eax
  801552:	68 de 14 80 00       	push   $0x8014de
  801557:	e8 92 fb ff ff       	call   8010ee <vprintfmt>
  80155c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80155f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801562:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801565:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801568:	c9                   	leave  
  801569:	c3                   	ret    

0080156a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80156a:	55                   	push   %ebp
  80156b:	89 e5                	mov    %esp,%ebp
  80156d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801570:	8d 45 10             	lea    0x10(%ebp),%eax
  801573:	83 c0 04             	add    $0x4,%eax
  801576:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801579:	8b 45 10             	mov    0x10(%ebp),%eax
  80157c:	ff 75 f4             	pushl  -0xc(%ebp)
  80157f:	50                   	push   %eax
  801580:	ff 75 0c             	pushl  0xc(%ebp)
  801583:	ff 75 08             	pushl  0x8(%ebp)
  801586:	e8 89 ff ff ff       	call   801514 <vsnprintf>
  80158b:	83 c4 10             	add    $0x10,%esp
  80158e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801591:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
  801599:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80159c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015a3:	eb 06                	jmp    8015ab <strlen+0x15>
		n++;
  8015a5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8015a8:	ff 45 08             	incl   0x8(%ebp)
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	84 c0                	test   %al,%al
  8015b2:	75 f1                	jne    8015a5 <strlen+0xf>
		n++;
	return n;
  8015b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
  8015bc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8015bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c6:	eb 09                	jmp    8015d1 <strnlen+0x18>
		n++;
  8015c8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8015cb:	ff 45 08             	incl   0x8(%ebp)
  8015ce:	ff 4d 0c             	decl   0xc(%ebp)
  8015d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015d5:	74 09                	je     8015e0 <strnlen+0x27>
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	8a 00                	mov    (%eax),%al
  8015dc:	84 c0                	test   %al,%al
  8015de:	75 e8                	jne    8015c8 <strnlen+0xf>
		n++;
	return n;
  8015e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015e3:	c9                   	leave  
  8015e4:	c3                   	ret    

008015e5 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
  8015e8:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8015eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8015f1:	90                   	nop
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	8d 50 01             	lea    0x1(%eax),%edx
  8015f8:	89 55 08             	mov    %edx,0x8(%ebp)
  8015fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fe:	8d 4a 01             	lea    0x1(%edx),%ecx
  801601:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801604:	8a 12                	mov    (%edx),%dl
  801606:	88 10                	mov    %dl,(%eax)
  801608:	8a 00                	mov    (%eax),%al
  80160a:	84 c0                	test   %al,%al
  80160c:	75 e4                	jne    8015f2 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80160e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
  801616:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801619:	8b 45 08             	mov    0x8(%ebp),%eax
  80161c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80161f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801626:	eb 1f                	jmp    801647 <strncpy+0x34>
		*dst++ = *src;
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	8d 50 01             	lea    0x1(%eax),%edx
  80162e:	89 55 08             	mov    %edx,0x8(%ebp)
  801631:	8b 55 0c             	mov    0xc(%ebp),%edx
  801634:	8a 12                	mov    (%edx),%dl
  801636:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801638:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163b:	8a 00                	mov    (%eax),%al
  80163d:	84 c0                	test   %al,%al
  80163f:	74 03                	je     801644 <strncpy+0x31>
			src++;
  801641:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801644:	ff 45 fc             	incl   -0x4(%ebp)
  801647:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80164a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80164d:	72 d9                	jb     801628 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80164f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
  801657:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801660:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801664:	74 30                	je     801696 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801666:	eb 16                	jmp    80167e <strlcpy+0x2a>
			*dst++ = *src++;
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8d 50 01             	lea    0x1(%eax),%edx
  80166e:	89 55 08             	mov    %edx,0x8(%ebp)
  801671:	8b 55 0c             	mov    0xc(%ebp),%edx
  801674:	8d 4a 01             	lea    0x1(%edx),%ecx
  801677:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80167a:	8a 12                	mov    (%edx),%dl
  80167c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80167e:	ff 4d 10             	decl   0x10(%ebp)
  801681:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801685:	74 09                	je     801690 <strlcpy+0x3c>
  801687:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168a:	8a 00                	mov    (%eax),%al
  80168c:	84 c0                	test   %al,%al
  80168e:	75 d8                	jne    801668 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801696:	8b 55 08             	mov    0x8(%ebp),%edx
  801699:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80169c:	29 c2                	sub    %eax,%edx
  80169e:	89 d0                	mov    %edx,%eax
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8016a5:	eb 06                	jmp    8016ad <strcmp+0xb>
		p++, q++;
  8016a7:	ff 45 08             	incl   0x8(%ebp)
  8016aa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	8a 00                	mov    (%eax),%al
  8016b2:	84 c0                	test   %al,%al
  8016b4:	74 0e                	je     8016c4 <strcmp+0x22>
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	8a 10                	mov    (%eax),%dl
  8016bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	38 c2                	cmp    %al,%dl
  8016c2:	74 e3                	je     8016a7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	0f b6 d0             	movzbl %al,%edx
  8016cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cf:	8a 00                	mov    (%eax),%al
  8016d1:	0f b6 c0             	movzbl %al,%eax
  8016d4:	29 c2                	sub    %eax,%edx
  8016d6:	89 d0                	mov    %edx,%eax
}
  8016d8:	5d                   	pop    %ebp
  8016d9:	c3                   	ret    

008016da <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8016dd:	eb 09                	jmp    8016e8 <strncmp+0xe>
		n--, p++, q++;
  8016df:	ff 4d 10             	decl   0x10(%ebp)
  8016e2:	ff 45 08             	incl   0x8(%ebp)
  8016e5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8016e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ec:	74 17                	je     801705 <strncmp+0x2b>
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	8a 00                	mov    (%eax),%al
  8016f3:	84 c0                	test   %al,%al
  8016f5:	74 0e                	je     801705 <strncmp+0x2b>
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	8a 10                	mov    (%eax),%dl
  8016fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ff:	8a 00                	mov    (%eax),%al
  801701:	38 c2                	cmp    %al,%dl
  801703:	74 da                	je     8016df <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801705:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801709:	75 07                	jne    801712 <strncmp+0x38>
		return 0;
  80170b:	b8 00 00 00 00       	mov    $0x0,%eax
  801710:	eb 14                	jmp    801726 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801712:	8b 45 08             	mov    0x8(%ebp),%eax
  801715:	8a 00                	mov    (%eax),%al
  801717:	0f b6 d0             	movzbl %al,%edx
  80171a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171d:	8a 00                	mov    (%eax),%al
  80171f:	0f b6 c0             	movzbl %al,%eax
  801722:	29 c2                	sub    %eax,%edx
  801724:	89 d0                	mov    %edx,%eax
}
  801726:	5d                   	pop    %ebp
  801727:	c3                   	ret    

00801728 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
  80172b:	83 ec 04             	sub    $0x4,%esp
  80172e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801731:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801734:	eb 12                	jmp    801748 <strchr+0x20>
		if (*s == c)
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	8a 00                	mov    (%eax),%al
  80173b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80173e:	75 05                	jne    801745 <strchr+0x1d>
			return (char *) s;
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	eb 11                	jmp    801756 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801745:	ff 45 08             	incl   0x8(%ebp)
  801748:	8b 45 08             	mov    0x8(%ebp),%eax
  80174b:	8a 00                	mov    (%eax),%al
  80174d:	84 c0                	test   %al,%al
  80174f:	75 e5                	jne    801736 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801751:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
  80175b:	83 ec 04             	sub    $0x4,%esp
  80175e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801761:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801764:	eb 0d                	jmp    801773 <strfind+0x1b>
		if (*s == c)
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	8a 00                	mov    (%eax),%al
  80176b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80176e:	74 0e                	je     80177e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801770:	ff 45 08             	incl   0x8(%ebp)
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	8a 00                	mov    (%eax),%al
  801778:	84 c0                	test   %al,%al
  80177a:	75 ea                	jne    801766 <strfind+0xe>
  80177c:	eb 01                	jmp    80177f <strfind+0x27>
		if (*s == c)
			break;
  80177e:	90                   	nop
	return (char *) s;
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
  801787:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801790:	8b 45 10             	mov    0x10(%ebp),%eax
  801793:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801796:	eb 0e                	jmp    8017a6 <memset+0x22>
		*p++ = c;
  801798:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80179b:	8d 50 01             	lea    0x1(%eax),%edx
  80179e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8017a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8017a6:	ff 4d f8             	decl   -0x8(%ebp)
  8017a9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8017ad:	79 e9                	jns    801798 <memset+0x14>
		*p++ = c;

	return v;
  8017af:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8017c6:	eb 16                	jmp    8017de <memcpy+0x2a>
		*d++ = *s++;
  8017c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017cb:	8d 50 01             	lea    0x1(%eax),%edx
  8017ce:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017d4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017d7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8017da:	8a 12                	mov    (%edx),%dl
  8017dc:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8017de:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017e4:	89 55 10             	mov    %edx,0x10(%ebp)
  8017e7:	85 c0                	test   %eax,%eax
  8017e9:	75 dd                	jne    8017c8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8017eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017ee:	c9                   	leave  
  8017ef:	c3                   	ret    

008017f0 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
  8017f3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8017f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ff:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801802:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801805:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801808:	73 50                	jae    80185a <memmove+0x6a>
  80180a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80180d:	8b 45 10             	mov    0x10(%ebp),%eax
  801810:	01 d0                	add    %edx,%eax
  801812:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801815:	76 43                	jbe    80185a <memmove+0x6a>
		s += n;
  801817:	8b 45 10             	mov    0x10(%ebp),%eax
  80181a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80181d:	8b 45 10             	mov    0x10(%ebp),%eax
  801820:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801823:	eb 10                	jmp    801835 <memmove+0x45>
			*--d = *--s;
  801825:	ff 4d f8             	decl   -0x8(%ebp)
  801828:	ff 4d fc             	decl   -0x4(%ebp)
  80182b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80182e:	8a 10                	mov    (%eax),%dl
  801830:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801833:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801835:	8b 45 10             	mov    0x10(%ebp),%eax
  801838:	8d 50 ff             	lea    -0x1(%eax),%edx
  80183b:	89 55 10             	mov    %edx,0x10(%ebp)
  80183e:	85 c0                	test   %eax,%eax
  801840:	75 e3                	jne    801825 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801842:	eb 23                	jmp    801867 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801844:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801847:	8d 50 01             	lea    0x1(%eax),%edx
  80184a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80184d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801850:	8d 4a 01             	lea    0x1(%edx),%ecx
  801853:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801856:	8a 12                	mov    (%edx),%dl
  801858:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80185a:	8b 45 10             	mov    0x10(%ebp),%eax
  80185d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801860:	89 55 10             	mov    %edx,0x10(%ebp)
  801863:	85 c0                	test   %eax,%eax
  801865:	75 dd                	jne    801844 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801867:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
  80186f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801878:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80187e:	eb 2a                	jmp    8018aa <memcmp+0x3e>
		if (*s1 != *s2)
  801880:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801883:	8a 10                	mov    (%eax),%dl
  801885:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801888:	8a 00                	mov    (%eax),%al
  80188a:	38 c2                	cmp    %al,%dl
  80188c:	74 16                	je     8018a4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80188e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801891:	8a 00                	mov    (%eax),%al
  801893:	0f b6 d0             	movzbl %al,%edx
  801896:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801899:	8a 00                	mov    (%eax),%al
  80189b:	0f b6 c0             	movzbl %al,%eax
  80189e:	29 c2                	sub    %eax,%edx
  8018a0:	89 d0                	mov    %edx,%eax
  8018a2:	eb 18                	jmp    8018bc <memcmp+0x50>
		s1++, s2++;
  8018a4:	ff 45 fc             	incl   -0x4(%ebp)
  8018a7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8018aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8018b3:	85 c0                	test   %eax,%eax
  8018b5:	75 c9                	jne    801880 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8018b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
  8018c1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8018c4:	8b 55 08             	mov    0x8(%ebp),%edx
  8018c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ca:	01 d0                	add    %edx,%eax
  8018cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8018cf:	eb 15                	jmp    8018e6 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8018d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d4:	8a 00                	mov    (%eax),%al
  8018d6:	0f b6 d0             	movzbl %al,%edx
  8018d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018dc:	0f b6 c0             	movzbl %al,%eax
  8018df:	39 c2                	cmp    %eax,%edx
  8018e1:	74 0d                	je     8018f0 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8018e3:	ff 45 08             	incl   0x8(%ebp)
  8018e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8018ec:	72 e3                	jb     8018d1 <memfind+0x13>
  8018ee:	eb 01                	jmp    8018f1 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8018f0:	90                   	nop
	return (void *) s;
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
  8018f9:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8018fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801903:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80190a:	eb 03                	jmp    80190f <strtol+0x19>
		s++;
  80190c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80190f:	8b 45 08             	mov    0x8(%ebp),%eax
  801912:	8a 00                	mov    (%eax),%al
  801914:	3c 20                	cmp    $0x20,%al
  801916:	74 f4                	je     80190c <strtol+0x16>
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	8a 00                	mov    (%eax),%al
  80191d:	3c 09                	cmp    $0x9,%al
  80191f:	74 eb                	je     80190c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	8a 00                	mov    (%eax),%al
  801926:	3c 2b                	cmp    $0x2b,%al
  801928:	75 05                	jne    80192f <strtol+0x39>
		s++;
  80192a:	ff 45 08             	incl   0x8(%ebp)
  80192d:	eb 13                	jmp    801942 <strtol+0x4c>
	else if (*s == '-')
  80192f:	8b 45 08             	mov    0x8(%ebp),%eax
  801932:	8a 00                	mov    (%eax),%al
  801934:	3c 2d                	cmp    $0x2d,%al
  801936:	75 0a                	jne    801942 <strtol+0x4c>
		s++, neg = 1;
  801938:	ff 45 08             	incl   0x8(%ebp)
  80193b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801942:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801946:	74 06                	je     80194e <strtol+0x58>
  801948:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80194c:	75 20                	jne    80196e <strtol+0x78>
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	8a 00                	mov    (%eax),%al
  801953:	3c 30                	cmp    $0x30,%al
  801955:	75 17                	jne    80196e <strtol+0x78>
  801957:	8b 45 08             	mov    0x8(%ebp),%eax
  80195a:	40                   	inc    %eax
  80195b:	8a 00                	mov    (%eax),%al
  80195d:	3c 78                	cmp    $0x78,%al
  80195f:	75 0d                	jne    80196e <strtol+0x78>
		s += 2, base = 16;
  801961:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801965:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80196c:	eb 28                	jmp    801996 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80196e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801972:	75 15                	jne    801989 <strtol+0x93>
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	8a 00                	mov    (%eax),%al
  801979:	3c 30                	cmp    $0x30,%al
  80197b:	75 0c                	jne    801989 <strtol+0x93>
		s++, base = 8;
  80197d:	ff 45 08             	incl   0x8(%ebp)
  801980:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801987:	eb 0d                	jmp    801996 <strtol+0xa0>
	else if (base == 0)
  801989:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80198d:	75 07                	jne    801996 <strtol+0xa0>
		base = 10;
  80198f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801996:	8b 45 08             	mov    0x8(%ebp),%eax
  801999:	8a 00                	mov    (%eax),%al
  80199b:	3c 2f                	cmp    $0x2f,%al
  80199d:	7e 19                	jle    8019b8 <strtol+0xc2>
  80199f:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a2:	8a 00                	mov    (%eax),%al
  8019a4:	3c 39                	cmp    $0x39,%al
  8019a6:	7f 10                	jg     8019b8 <strtol+0xc2>
			dig = *s - '0';
  8019a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ab:	8a 00                	mov    (%eax),%al
  8019ad:	0f be c0             	movsbl %al,%eax
  8019b0:	83 e8 30             	sub    $0x30,%eax
  8019b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019b6:	eb 42                	jmp    8019fa <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	8a 00                	mov    (%eax),%al
  8019bd:	3c 60                	cmp    $0x60,%al
  8019bf:	7e 19                	jle    8019da <strtol+0xe4>
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	8a 00                	mov    (%eax),%al
  8019c6:	3c 7a                	cmp    $0x7a,%al
  8019c8:	7f 10                	jg     8019da <strtol+0xe4>
			dig = *s - 'a' + 10;
  8019ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cd:	8a 00                	mov    (%eax),%al
  8019cf:	0f be c0             	movsbl %al,%eax
  8019d2:	83 e8 57             	sub    $0x57,%eax
  8019d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019d8:	eb 20                	jmp    8019fa <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	8a 00                	mov    (%eax),%al
  8019df:	3c 40                	cmp    $0x40,%al
  8019e1:	7e 39                	jle    801a1c <strtol+0x126>
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	8a 00                	mov    (%eax),%al
  8019e8:	3c 5a                	cmp    $0x5a,%al
  8019ea:	7f 30                	jg     801a1c <strtol+0x126>
			dig = *s - 'A' + 10;
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	8a 00                	mov    (%eax),%al
  8019f1:	0f be c0             	movsbl %al,%eax
  8019f4:	83 e8 37             	sub    $0x37,%eax
  8019f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8019fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019fd:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a00:	7d 19                	jge    801a1b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a02:	ff 45 08             	incl   0x8(%ebp)
  801a05:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a08:	0f af 45 10          	imul   0x10(%ebp),%eax
  801a0c:	89 c2                	mov    %eax,%edx
  801a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a11:	01 d0                	add    %edx,%eax
  801a13:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801a16:	e9 7b ff ff ff       	jmp    801996 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801a1b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801a1c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801a20:	74 08                	je     801a2a <strtol+0x134>
		*endptr = (char *) s;
  801a22:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a25:	8b 55 08             	mov    0x8(%ebp),%edx
  801a28:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801a2a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a2e:	74 07                	je     801a37 <strtol+0x141>
  801a30:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a33:	f7 d8                	neg    %eax
  801a35:	eb 03                	jmp    801a3a <strtol+0x144>
  801a37:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a3a:	c9                   	leave  
  801a3b:	c3                   	ret    

00801a3c <ltostr>:

void
ltostr(long value, char *str)
{
  801a3c:	55                   	push   %ebp
  801a3d:	89 e5                	mov    %esp,%ebp
  801a3f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801a42:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801a49:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801a50:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a54:	79 13                	jns    801a69 <ltostr+0x2d>
	{
		neg = 1;
  801a56:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a60:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a63:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a66:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a69:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a71:	99                   	cltd   
  801a72:	f7 f9                	idiv   %ecx
  801a74:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a77:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a7a:	8d 50 01             	lea    0x1(%eax),%edx
  801a7d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a80:	89 c2                	mov    %eax,%edx
  801a82:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a85:	01 d0                	add    %edx,%eax
  801a87:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a8a:	83 c2 30             	add    $0x30,%edx
  801a8d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801a8f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a92:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a97:	f7 e9                	imul   %ecx
  801a99:	c1 fa 02             	sar    $0x2,%edx
  801a9c:	89 c8                	mov    %ecx,%eax
  801a9e:	c1 f8 1f             	sar    $0x1f,%eax
  801aa1:	29 c2                	sub    %eax,%edx
  801aa3:	89 d0                	mov    %edx,%eax
  801aa5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801aa8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801aab:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801ab0:	f7 e9                	imul   %ecx
  801ab2:	c1 fa 02             	sar    $0x2,%edx
  801ab5:	89 c8                	mov    %ecx,%eax
  801ab7:	c1 f8 1f             	sar    $0x1f,%eax
  801aba:	29 c2                	sub    %eax,%edx
  801abc:	89 d0                	mov    %edx,%eax
  801abe:	c1 e0 02             	shl    $0x2,%eax
  801ac1:	01 d0                	add    %edx,%eax
  801ac3:	01 c0                	add    %eax,%eax
  801ac5:	29 c1                	sub    %eax,%ecx
  801ac7:	89 ca                	mov    %ecx,%edx
  801ac9:	85 d2                	test   %edx,%edx
  801acb:	75 9c                	jne    801a69 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801acd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801ad4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ad7:	48                   	dec    %eax
  801ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801adb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801adf:	74 3d                	je     801b1e <ltostr+0xe2>
		start = 1 ;
  801ae1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801ae8:	eb 34                	jmp    801b1e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801aea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801aed:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af0:	01 d0                	add    %edx,%eax
  801af2:	8a 00                	mov    (%eax),%al
  801af4:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801af7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801afd:	01 c2                	add    %eax,%edx
  801aff:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b02:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b05:	01 c8                	add    %ecx,%eax
  801b07:	8a 00                	mov    (%eax),%al
  801b09:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801b0b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b11:	01 c2                	add    %eax,%edx
  801b13:	8a 45 eb             	mov    -0x15(%ebp),%al
  801b16:	88 02                	mov    %al,(%edx)
		start++ ;
  801b18:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801b1b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801b1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b21:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b24:	7c c4                	jl     801aea <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801b26:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801b29:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b2c:	01 d0                	add    %edx,%eax
  801b2e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801b31:	90                   	nop
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
  801b37:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801b3a:	ff 75 08             	pushl  0x8(%ebp)
  801b3d:	e8 54 fa ff ff       	call   801596 <strlen>
  801b42:	83 c4 04             	add    $0x4,%esp
  801b45:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b48:	ff 75 0c             	pushl  0xc(%ebp)
  801b4b:	e8 46 fa ff ff       	call   801596 <strlen>
  801b50:	83 c4 04             	add    $0x4,%esp
  801b53:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801b56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801b5d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b64:	eb 17                	jmp    801b7d <strcconcat+0x49>
		final[s] = str1[s] ;
  801b66:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b69:	8b 45 10             	mov    0x10(%ebp),%eax
  801b6c:	01 c2                	add    %eax,%edx
  801b6e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b71:	8b 45 08             	mov    0x8(%ebp),%eax
  801b74:	01 c8                	add    %ecx,%eax
  801b76:	8a 00                	mov    (%eax),%al
  801b78:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b7a:	ff 45 fc             	incl   -0x4(%ebp)
  801b7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b80:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b83:	7c e1                	jl     801b66 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801b85:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801b8c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801b93:	eb 1f                	jmp    801bb4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801b95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b98:	8d 50 01             	lea    0x1(%eax),%edx
  801b9b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801b9e:	89 c2                	mov    %eax,%edx
  801ba0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ba3:	01 c2                	add    %eax,%edx
  801ba5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ba8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bab:	01 c8                	add    %ecx,%eax
  801bad:	8a 00                	mov    (%eax),%al
  801baf:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801bb1:	ff 45 f8             	incl   -0x8(%ebp)
  801bb4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bb7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bba:	7c d9                	jl     801b95 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801bbc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bbf:	8b 45 10             	mov    0x10(%ebp),%eax
  801bc2:	01 d0                	add    %edx,%eax
  801bc4:	c6 00 00             	movb   $0x0,(%eax)
}
  801bc7:	90                   	nop
  801bc8:	c9                   	leave  
  801bc9:	c3                   	ret    

00801bca <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801bca:	55                   	push   %ebp
  801bcb:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801bcd:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801bd6:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd9:	8b 00                	mov    (%eax),%eax
  801bdb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801be2:	8b 45 10             	mov    0x10(%ebp),%eax
  801be5:	01 d0                	add    %edx,%eax
  801be7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801bed:	eb 0c                	jmp    801bfb <strsplit+0x31>
			*string++ = 0;
  801bef:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf2:	8d 50 01             	lea    0x1(%eax),%edx
  801bf5:	89 55 08             	mov    %edx,0x8(%ebp)
  801bf8:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfe:	8a 00                	mov    (%eax),%al
  801c00:	84 c0                	test   %al,%al
  801c02:	74 18                	je     801c1c <strsplit+0x52>
  801c04:	8b 45 08             	mov    0x8(%ebp),%eax
  801c07:	8a 00                	mov    (%eax),%al
  801c09:	0f be c0             	movsbl %al,%eax
  801c0c:	50                   	push   %eax
  801c0d:	ff 75 0c             	pushl  0xc(%ebp)
  801c10:	e8 13 fb ff ff       	call   801728 <strchr>
  801c15:	83 c4 08             	add    $0x8,%esp
  801c18:	85 c0                	test   %eax,%eax
  801c1a:	75 d3                	jne    801bef <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1f:	8a 00                	mov    (%eax),%al
  801c21:	84 c0                	test   %al,%al
  801c23:	74 5a                	je     801c7f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801c25:	8b 45 14             	mov    0x14(%ebp),%eax
  801c28:	8b 00                	mov    (%eax),%eax
  801c2a:	83 f8 0f             	cmp    $0xf,%eax
  801c2d:	75 07                	jne    801c36 <strsplit+0x6c>
		{
			return 0;
  801c2f:	b8 00 00 00 00       	mov    $0x0,%eax
  801c34:	eb 66                	jmp    801c9c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801c36:	8b 45 14             	mov    0x14(%ebp),%eax
  801c39:	8b 00                	mov    (%eax),%eax
  801c3b:	8d 48 01             	lea    0x1(%eax),%ecx
  801c3e:	8b 55 14             	mov    0x14(%ebp),%edx
  801c41:	89 0a                	mov    %ecx,(%edx)
  801c43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c4a:	8b 45 10             	mov    0x10(%ebp),%eax
  801c4d:	01 c2                	add    %eax,%edx
  801c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c52:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c54:	eb 03                	jmp    801c59 <strsplit+0x8f>
			string++;
  801c56:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c59:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5c:	8a 00                	mov    (%eax),%al
  801c5e:	84 c0                	test   %al,%al
  801c60:	74 8b                	je     801bed <strsplit+0x23>
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	8a 00                	mov    (%eax),%al
  801c67:	0f be c0             	movsbl %al,%eax
  801c6a:	50                   	push   %eax
  801c6b:	ff 75 0c             	pushl  0xc(%ebp)
  801c6e:	e8 b5 fa ff ff       	call   801728 <strchr>
  801c73:	83 c4 08             	add    $0x8,%esp
  801c76:	85 c0                	test   %eax,%eax
  801c78:	74 dc                	je     801c56 <strsplit+0x8c>
			string++;
	}
  801c7a:	e9 6e ff ff ff       	jmp    801bed <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801c7f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801c80:	8b 45 14             	mov    0x14(%ebp),%eax
  801c83:	8b 00                	mov    (%eax),%eax
  801c85:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801c8f:	01 d0                	add    %edx,%eax
  801c91:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801c97:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c9c:	c9                   	leave  
  801c9d:	c3                   	ret    

00801c9e <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c9e:	55                   	push   %ebp
  801c9f:	89 e5                	mov    %esp,%ebp
  801ca1:	83 ec 18             	sub    $0x18,%esp
  801ca4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca7:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801caa:	83 ec 04             	sub    $0x4,%esp
  801cad:	68 f0 2f 80 00       	push   $0x802ff0
  801cb2:	6a 17                	push   $0x17
  801cb4:	68 0f 30 80 00       	push   $0x80300f
  801cb9:	e8 a2 ef ff ff       	call   800c60 <_panic>

00801cbe <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
  801cc1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801cc4:	83 ec 04             	sub    $0x4,%esp
  801cc7:	68 1b 30 80 00       	push   $0x80301b
  801ccc:	6a 2f                	push   $0x2f
  801cce:	68 0f 30 80 00       	push   $0x80300f
  801cd3:	e8 88 ef ff ff       	call   800c60 <_panic>

00801cd8 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801cd8:	55                   	push   %ebp
  801cd9:	89 e5                	mov    %esp,%ebp
  801cdb:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801cde:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801ce5:	8b 55 08             	mov    0x8(%ebp),%edx
  801ce8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ceb:	01 d0                	add    %edx,%eax
  801ced:	48                   	dec    %eax
  801cee:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801cf1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cf4:	ba 00 00 00 00       	mov    $0x0,%edx
  801cf9:	f7 75 ec             	divl   -0x14(%ebp)
  801cfc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cff:	29 d0                	sub    %edx,%eax
  801d01:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801d04:	8b 45 08             	mov    0x8(%ebp),%eax
  801d07:	c1 e8 0c             	shr    $0xc,%eax
  801d0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801d0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801d14:	e9 c8 00 00 00       	jmp    801de1 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801d19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d20:	eb 27                	jmp    801d49 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801d22:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d28:	01 c2                	add    %eax,%edx
  801d2a:	89 d0                	mov    %edx,%eax
  801d2c:	01 c0                	add    %eax,%eax
  801d2e:	01 d0                	add    %edx,%eax
  801d30:	c1 e0 02             	shl    $0x2,%eax
  801d33:	05 48 40 80 00       	add    $0x804048,%eax
  801d38:	8b 00                	mov    (%eax),%eax
  801d3a:	85 c0                	test   %eax,%eax
  801d3c:	74 08                	je     801d46 <malloc+0x6e>
            	i += j;
  801d3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d41:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801d44:	eb 0b                	jmp    801d51 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801d46:	ff 45 f0             	incl   -0x10(%ebp)
  801d49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d4c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d4f:	72 d1                	jb     801d22 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801d51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d54:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d57:	0f 85 81 00 00 00    	jne    801dde <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d60:	05 00 00 08 00       	add    $0x80000,%eax
  801d65:	c1 e0 0c             	shl    $0xc,%eax
  801d68:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801d6b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d72:	eb 1f                	jmp    801d93 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801d74:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801d77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d7a:	01 c2                	add    %eax,%edx
  801d7c:	89 d0                	mov    %edx,%eax
  801d7e:	01 c0                	add    %eax,%eax
  801d80:	01 d0                	add    %edx,%eax
  801d82:	c1 e0 02             	shl    $0x2,%eax
  801d85:	05 48 40 80 00       	add    $0x804048,%eax
  801d8a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801d90:	ff 45 f0             	incl   -0x10(%ebp)
  801d93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d96:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d99:	72 d9                	jb     801d74 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801d9b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d9e:	89 d0                	mov    %edx,%eax
  801da0:	01 c0                	add    %eax,%eax
  801da2:	01 d0                	add    %edx,%eax
  801da4:	c1 e0 02             	shl    $0x2,%eax
  801da7:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  801dad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801db0:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801db2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801db5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801db8:	89 c8                	mov    %ecx,%eax
  801dba:	01 c0                	add    %eax,%eax
  801dbc:	01 c8                	add    %ecx,%eax
  801dbe:	c1 e0 02             	shl    $0x2,%eax
  801dc1:	05 44 40 80 00       	add    $0x804044,%eax
  801dc6:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801dc8:	83 ec 08             	sub    $0x8,%esp
  801dcb:	ff 75 08             	pushl  0x8(%ebp)
  801dce:	ff 75 e0             	pushl  -0x20(%ebp)
  801dd1:	e8 2b 03 00 00       	call   802101 <sys_allocateMem>
  801dd6:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801dd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ddc:	eb 19                	jmp    801df7 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801dde:	ff 45 f4             	incl   -0xc(%ebp)
  801de1:	a1 04 40 80 00       	mov    0x804004,%eax
  801de6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801de9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801dec:	0f 83 27 ff ff ff    	jae    801d19 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801df2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801df7:	c9                   	leave  
  801df8:	c3                   	ret    

00801df9 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801df9:	55                   	push   %ebp
  801dfa:	89 e5                	mov    %esp,%ebp
  801dfc:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801dff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e03:	0f 84 e5 00 00 00    	je     801eee <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801e09:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801e0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e12:	05 00 00 00 80       	add    $0x80000000,%eax
  801e17:	c1 e8 0c             	shr    $0xc,%eax
  801e1a:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801e1d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e20:	89 d0                	mov    %edx,%eax
  801e22:	01 c0                	add    %eax,%eax
  801e24:	01 d0                	add    %edx,%eax
  801e26:	c1 e0 02             	shl    $0x2,%eax
  801e29:	05 40 40 80 00       	add    $0x804040,%eax
  801e2e:	8b 00                	mov    (%eax),%eax
  801e30:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e33:	0f 85 b8 00 00 00    	jne    801ef1 <free+0xf8>
  801e39:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e3c:	89 d0                	mov    %edx,%eax
  801e3e:	01 c0                	add    %eax,%eax
  801e40:	01 d0                	add    %edx,%eax
  801e42:	c1 e0 02             	shl    $0x2,%eax
  801e45:	05 48 40 80 00       	add    $0x804048,%eax
  801e4a:	8b 00                	mov    (%eax),%eax
  801e4c:	85 c0                	test   %eax,%eax
  801e4e:	0f 84 9d 00 00 00    	je     801ef1 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801e54:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e57:	89 d0                	mov    %edx,%eax
  801e59:	01 c0                	add    %eax,%eax
  801e5b:	01 d0                	add    %edx,%eax
  801e5d:	c1 e0 02             	shl    $0x2,%eax
  801e60:	05 44 40 80 00       	add    $0x804044,%eax
  801e65:	8b 00                	mov    (%eax),%eax
  801e67:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801e6a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e6d:	c1 e0 0c             	shl    $0xc,%eax
  801e70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801e73:	83 ec 08             	sub    $0x8,%esp
  801e76:	ff 75 e4             	pushl  -0x1c(%ebp)
  801e79:	ff 75 f0             	pushl  -0x10(%ebp)
  801e7c:	e8 64 02 00 00       	call   8020e5 <sys_freeMem>
  801e81:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801e84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801e8b:	eb 57                	jmp    801ee4 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801e8d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e93:	01 c2                	add    %eax,%edx
  801e95:	89 d0                	mov    %edx,%eax
  801e97:	01 c0                	add    %eax,%eax
  801e99:	01 d0                	add    %edx,%eax
  801e9b:	c1 e0 02             	shl    $0x2,%eax
  801e9e:	05 48 40 80 00       	add    $0x804048,%eax
  801ea3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801ea9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801eac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801eaf:	01 c2                	add    %eax,%edx
  801eb1:	89 d0                	mov    %edx,%eax
  801eb3:	01 c0                	add    %eax,%eax
  801eb5:	01 d0                	add    %edx,%eax
  801eb7:	c1 e0 02             	shl    $0x2,%eax
  801eba:	05 40 40 80 00       	add    $0x804040,%eax
  801ebf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801ec5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ec8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ecb:	01 c2                	add    %eax,%edx
  801ecd:	89 d0                	mov    %edx,%eax
  801ecf:	01 c0                	add    %eax,%eax
  801ed1:	01 d0                	add    %edx,%eax
  801ed3:	c1 e0 02             	shl    $0x2,%eax
  801ed6:	05 44 40 80 00       	add    $0x804044,%eax
  801edb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801ee1:	ff 45 f4             	incl   -0xc(%ebp)
  801ee4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ee7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801eea:	7c a1                	jl     801e8d <free+0x94>
  801eec:	eb 04                	jmp    801ef2 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801eee:	90                   	nop
  801eef:	eb 01                	jmp    801ef2 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801ef1:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801ef2:	c9                   	leave  
  801ef3:	c3                   	ret    

00801ef4 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801ef4:	55                   	push   %ebp
  801ef5:	89 e5                	mov    %esp,%ebp
  801ef7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801efa:	83 ec 04             	sub    $0x4,%esp
  801efd:	68 38 30 80 00       	push   $0x803038
  801f02:	68 ae 00 00 00       	push   $0xae
  801f07:	68 0f 30 80 00       	push   $0x80300f
  801f0c:	e8 4f ed ff ff       	call   800c60 <_panic>

00801f11 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
  801f14:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801f17:	83 ec 04             	sub    $0x4,%esp
  801f1a:	68 58 30 80 00       	push   $0x803058
  801f1f:	68 ca 00 00 00       	push   $0xca
  801f24:	68 0f 30 80 00       	push   $0x80300f
  801f29:	e8 32 ed ff ff       	call   800c60 <_panic>

00801f2e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f2e:	55                   	push   %ebp
  801f2f:	89 e5                	mov    %esp,%ebp
  801f31:	57                   	push   %edi
  801f32:	56                   	push   %esi
  801f33:	53                   	push   %ebx
  801f34:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f37:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f40:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f43:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f46:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f49:	cd 30                	int    $0x30
  801f4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f51:	83 c4 10             	add    $0x10,%esp
  801f54:	5b                   	pop    %ebx
  801f55:	5e                   	pop    %esi
  801f56:	5f                   	pop    %edi
  801f57:	5d                   	pop    %ebp
  801f58:	c3                   	ret    

00801f59 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
  801f5c:	83 ec 04             	sub    $0x4,%esp
  801f5f:	8b 45 10             	mov    0x10(%ebp),%eax
  801f62:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801f65:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f69:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	52                   	push   %edx
  801f71:	ff 75 0c             	pushl  0xc(%ebp)
  801f74:	50                   	push   %eax
  801f75:	6a 00                	push   $0x0
  801f77:	e8 b2 ff ff ff       	call   801f2e <syscall>
  801f7c:	83 c4 18             	add    $0x18,%esp
}
  801f7f:	90                   	nop
  801f80:	c9                   	leave  
  801f81:	c3                   	ret    

00801f82 <sys_cgetc>:

int
sys_cgetc(void)
{
  801f82:	55                   	push   %ebp
  801f83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 01                	push   $0x1
  801f91:	e8 98 ff ff ff       	call   801f2e <syscall>
  801f96:	83 c4 18             	add    $0x18,%esp
}
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	50                   	push   %eax
  801faa:	6a 05                	push   $0x5
  801fac:	e8 7d ff ff ff       	call   801f2e <syscall>
  801fb1:	83 c4 18             	add    $0x18,%esp
}
  801fb4:	c9                   	leave  
  801fb5:	c3                   	ret    

00801fb6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801fb6:	55                   	push   %ebp
  801fb7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 02                	push   $0x2
  801fc5:	e8 64 ff ff ff       	call   801f2e <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
}
  801fcd:	c9                   	leave  
  801fce:	c3                   	ret    

00801fcf <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801fcf:	55                   	push   %ebp
  801fd0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 03                	push   $0x3
  801fde:	e8 4b ff ff ff       	call   801f2e <syscall>
  801fe3:	83 c4 18             	add    $0x18,%esp
}
  801fe6:	c9                   	leave  
  801fe7:	c3                   	ret    

00801fe8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801fe8:	55                   	push   %ebp
  801fe9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 04                	push   $0x4
  801ff7:	e8 32 ff ff ff       	call   801f2e <syscall>
  801ffc:	83 c4 18             	add    $0x18,%esp
}
  801fff:	c9                   	leave  
  802000:	c3                   	ret    

00802001 <sys_env_exit>:


void sys_env_exit(void)
{
  802001:	55                   	push   %ebp
  802002:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 06                	push   $0x6
  802010:	e8 19 ff ff ff       	call   801f2e <syscall>
  802015:	83 c4 18             	add    $0x18,%esp
}
  802018:	90                   	nop
  802019:	c9                   	leave  
  80201a:	c3                   	ret    

0080201b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80201b:	55                   	push   %ebp
  80201c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80201e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802021:	8b 45 08             	mov    0x8(%ebp),%eax
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	52                   	push   %edx
  80202b:	50                   	push   %eax
  80202c:	6a 07                	push   $0x7
  80202e:	e8 fb fe ff ff       	call   801f2e <syscall>
  802033:	83 c4 18             	add    $0x18,%esp
}
  802036:	c9                   	leave  
  802037:	c3                   	ret    

00802038 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802038:	55                   	push   %ebp
  802039:	89 e5                	mov    %esp,%ebp
  80203b:	56                   	push   %esi
  80203c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80203d:	8b 75 18             	mov    0x18(%ebp),%esi
  802040:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802043:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802046:	8b 55 0c             	mov    0xc(%ebp),%edx
  802049:	8b 45 08             	mov    0x8(%ebp),%eax
  80204c:	56                   	push   %esi
  80204d:	53                   	push   %ebx
  80204e:	51                   	push   %ecx
  80204f:	52                   	push   %edx
  802050:	50                   	push   %eax
  802051:	6a 08                	push   $0x8
  802053:	e8 d6 fe ff ff       	call   801f2e <syscall>
  802058:	83 c4 18             	add    $0x18,%esp
}
  80205b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80205e:	5b                   	pop    %ebx
  80205f:	5e                   	pop    %esi
  802060:	5d                   	pop    %ebp
  802061:	c3                   	ret    

00802062 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802062:	55                   	push   %ebp
  802063:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802065:	8b 55 0c             	mov    0xc(%ebp),%edx
  802068:	8b 45 08             	mov    0x8(%ebp),%eax
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	52                   	push   %edx
  802072:	50                   	push   %eax
  802073:	6a 09                	push   $0x9
  802075:	e8 b4 fe ff ff       	call   801f2e <syscall>
  80207a:	83 c4 18             	add    $0x18,%esp
}
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	ff 75 0c             	pushl  0xc(%ebp)
  80208b:	ff 75 08             	pushl  0x8(%ebp)
  80208e:	6a 0a                	push   $0xa
  802090:	e8 99 fe ff ff       	call   801f2e <syscall>
  802095:	83 c4 18             	add    $0x18,%esp
}
  802098:	c9                   	leave  
  802099:	c3                   	ret    

0080209a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80209a:	55                   	push   %ebp
  80209b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 0b                	push   $0xb
  8020a9:	e8 80 fe ff ff       	call   801f2e <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 0c                	push   $0xc
  8020c2:	e8 67 fe ff ff       	call   801f2e <syscall>
  8020c7:	83 c4 18             	add    $0x18,%esp
}
  8020ca:	c9                   	leave  
  8020cb:	c3                   	ret    

008020cc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8020cc:	55                   	push   %ebp
  8020cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 0d                	push   $0xd
  8020db:	e8 4e fe ff ff       	call   801f2e <syscall>
  8020e0:	83 c4 18             	add    $0x18,%esp
}
  8020e3:	c9                   	leave  
  8020e4:	c3                   	ret    

008020e5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8020e5:	55                   	push   %ebp
  8020e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	ff 75 0c             	pushl  0xc(%ebp)
  8020f1:	ff 75 08             	pushl  0x8(%ebp)
  8020f4:	6a 11                	push   $0x11
  8020f6:	e8 33 fe ff ff       	call   801f2e <syscall>
  8020fb:	83 c4 18             	add    $0x18,%esp
	return;
  8020fe:	90                   	nop
}
  8020ff:	c9                   	leave  
  802100:	c3                   	ret    

00802101 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802101:	55                   	push   %ebp
  802102:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	ff 75 0c             	pushl  0xc(%ebp)
  80210d:	ff 75 08             	pushl  0x8(%ebp)
  802110:	6a 12                	push   $0x12
  802112:	e8 17 fe ff ff       	call   801f2e <syscall>
  802117:	83 c4 18             	add    $0x18,%esp
	return ;
  80211a:	90                   	nop
}
  80211b:	c9                   	leave  
  80211c:	c3                   	ret    

0080211d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80211d:	55                   	push   %ebp
  80211e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	6a 0e                	push   $0xe
  80212c:	e8 fd fd ff ff       	call   801f2e <syscall>
  802131:	83 c4 18             	add    $0x18,%esp
}
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	ff 75 08             	pushl  0x8(%ebp)
  802144:	6a 0f                	push   $0xf
  802146:	e8 e3 fd ff ff       	call   801f2e <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	c9                   	leave  
  80214f:	c3                   	ret    

00802150 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802150:	55                   	push   %ebp
  802151:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	6a 10                	push   $0x10
  80215f:	e8 ca fd ff ff       	call   801f2e <syscall>
  802164:	83 c4 18             	add    $0x18,%esp
}
  802167:	90                   	nop
  802168:	c9                   	leave  
  802169:	c3                   	ret    

0080216a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80216a:	55                   	push   %ebp
  80216b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80216d:	6a 00                	push   $0x0
  80216f:	6a 00                	push   $0x0
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 14                	push   $0x14
  802179:	e8 b0 fd ff ff       	call   801f2e <syscall>
  80217e:	83 c4 18             	add    $0x18,%esp
}
  802181:	90                   	nop
  802182:	c9                   	leave  
  802183:	c3                   	ret    

00802184 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802184:	55                   	push   %ebp
  802185:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 15                	push   $0x15
  802193:	e8 96 fd ff ff       	call   801f2e <syscall>
  802198:	83 c4 18             	add    $0x18,%esp
}
  80219b:	90                   	nop
  80219c:	c9                   	leave  
  80219d:	c3                   	ret    

0080219e <sys_cputc>:


void
sys_cputc(const char c)
{
  80219e:	55                   	push   %ebp
  80219f:	89 e5                	mov    %esp,%ebp
  8021a1:	83 ec 04             	sub    $0x4,%esp
  8021a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8021aa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	50                   	push   %eax
  8021b7:	6a 16                	push   $0x16
  8021b9:	e8 70 fd ff ff       	call   801f2e <syscall>
  8021be:	83 c4 18             	add    $0x18,%esp
}
  8021c1:	90                   	nop
  8021c2:	c9                   	leave  
  8021c3:	c3                   	ret    

008021c4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8021c4:	55                   	push   %ebp
  8021c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 17                	push   $0x17
  8021d3:	e8 56 fd ff ff       	call   801f2e <syscall>
  8021d8:	83 c4 18             	add    $0x18,%esp
}
  8021db:	90                   	nop
  8021dc:	c9                   	leave  
  8021dd:	c3                   	ret    

008021de <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8021de:	55                   	push   %ebp
  8021df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8021e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	ff 75 0c             	pushl  0xc(%ebp)
  8021ed:	50                   	push   %eax
  8021ee:	6a 18                	push   $0x18
  8021f0:	e8 39 fd ff ff       	call   801f2e <syscall>
  8021f5:	83 c4 18             	add    $0x18,%esp
}
  8021f8:	c9                   	leave  
  8021f9:	c3                   	ret    

008021fa <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8021fa:	55                   	push   %ebp
  8021fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  802200:	8b 45 08             	mov    0x8(%ebp),%eax
  802203:	6a 00                	push   $0x0
  802205:	6a 00                	push   $0x0
  802207:	6a 00                	push   $0x0
  802209:	52                   	push   %edx
  80220a:	50                   	push   %eax
  80220b:	6a 1b                	push   $0x1b
  80220d:	e8 1c fd ff ff       	call   801f2e <syscall>
  802212:	83 c4 18             	add    $0x18,%esp
}
  802215:	c9                   	leave  
  802216:	c3                   	ret    

00802217 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802217:	55                   	push   %ebp
  802218:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80221a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80221d:	8b 45 08             	mov    0x8(%ebp),%eax
  802220:	6a 00                	push   $0x0
  802222:	6a 00                	push   $0x0
  802224:	6a 00                	push   $0x0
  802226:	52                   	push   %edx
  802227:	50                   	push   %eax
  802228:	6a 19                	push   $0x19
  80222a:	e8 ff fc ff ff       	call   801f2e <syscall>
  80222f:	83 c4 18             	add    $0x18,%esp
}
  802232:	90                   	nop
  802233:	c9                   	leave  
  802234:	c3                   	ret    

00802235 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802235:	55                   	push   %ebp
  802236:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802238:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223b:	8b 45 08             	mov    0x8(%ebp),%eax
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	52                   	push   %edx
  802245:	50                   	push   %eax
  802246:	6a 1a                	push   $0x1a
  802248:	e8 e1 fc ff ff       	call   801f2e <syscall>
  80224d:	83 c4 18             	add    $0x18,%esp
}
  802250:	90                   	nop
  802251:	c9                   	leave  
  802252:	c3                   	ret    

00802253 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802253:	55                   	push   %ebp
  802254:	89 e5                	mov    %esp,%ebp
  802256:	83 ec 04             	sub    $0x4,%esp
  802259:	8b 45 10             	mov    0x10(%ebp),%eax
  80225c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80225f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802262:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802266:	8b 45 08             	mov    0x8(%ebp),%eax
  802269:	6a 00                	push   $0x0
  80226b:	51                   	push   %ecx
  80226c:	52                   	push   %edx
  80226d:	ff 75 0c             	pushl  0xc(%ebp)
  802270:	50                   	push   %eax
  802271:	6a 1c                	push   $0x1c
  802273:	e8 b6 fc ff ff       	call   801f2e <syscall>
  802278:	83 c4 18             	add    $0x18,%esp
}
  80227b:	c9                   	leave  
  80227c:	c3                   	ret    

0080227d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80227d:	55                   	push   %ebp
  80227e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802280:	8b 55 0c             	mov    0xc(%ebp),%edx
  802283:	8b 45 08             	mov    0x8(%ebp),%eax
  802286:	6a 00                	push   $0x0
  802288:	6a 00                	push   $0x0
  80228a:	6a 00                	push   $0x0
  80228c:	52                   	push   %edx
  80228d:	50                   	push   %eax
  80228e:	6a 1d                	push   $0x1d
  802290:	e8 99 fc ff ff       	call   801f2e <syscall>
  802295:	83 c4 18             	add    $0x18,%esp
}
  802298:	c9                   	leave  
  802299:	c3                   	ret    

0080229a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80229a:	55                   	push   %ebp
  80229b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80229d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a6:	6a 00                	push   $0x0
  8022a8:	6a 00                	push   $0x0
  8022aa:	51                   	push   %ecx
  8022ab:	52                   	push   %edx
  8022ac:	50                   	push   %eax
  8022ad:	6a 1e                	push   $0x1e
  8022af:	e8 7a fc ff ff       	call   801f2e <syscall>
  8022b4:	83 c4 18             	add    $0x18,%esp
}
  8022b7:	c9                   	leave  
  8022b8:	c3                   	ret    

008022b9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8022b9:	55                   	push   %ebp
  8022ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8022bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	52                   	push   %edx
  8022c9:	50                   	push   %eax
  8022ca:	6a 1f                	push   $0x1f
  8022cc:	e8 5d fc ff ff       	call   801f2e <syscall>
  8022d1:	83 c4 18             	add    $0x18,%esp
}
  8022d4:	c9                   	leave  
  8022d5:	c3                   	ret    

008022d6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8022d6:	55                   	push   %ebp
  8022d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 20                	push   $0x20
  8022e5:	e8 44 fc ff ff       	call   801f2e <syscall>
  8022ea:	83 c4 18             	add    $0x18,%esp
}
  8022ed:	c9                   	leave  
  8022ee:	c3                   	ret    

008022ef <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8022ef:	55                   	push   %ebp
  8022f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8022f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f5:	6a 00                	push   $0x0
  8022f7:	6a 00                	push   $0x0
  8022f9:	ff 75 10             	pushl  0x10(%ebp)
  8022fc:	ff 75 0c             	pushl  0xc(%ebp)
  8022ff:	50                   	push   %eax
  802300:	6a 21                	push   $0x21
  802302:	e8 27 fc ff ff       	call   801f2e <syscall>
  802307:	83 c4 18             	add    $0x18,%esp
}
  80230a:	c9                   	leave  
  80230b:	c3                   	ret    

0080230c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80230c:	55                   	push   %ebp
  80230d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80230f:	8b 45 08             	mov    0x8(%ebp),%eax
  802312:	6a 00                	push   $0x0
  802314:	6a 00                	push   $0x0
  802316:	6a 00                	push   $0x0
  802318:	6a 00                	push   $0x0
  80231a:	50                   	push   %eax
  80231b:	6a 22                	push   $0x22
  80231d:	e8 0c fc ff ff       	call   801f2e <syscall>
  802322:	83 c4 18             	add    $0x18,%esp
}
  802325:	90                   	nop
  802326:	c9                   	leave  
  802327:	c3                   	ret    

00802328 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802328:	55                   	push   %ebp
  802329:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80232b:	8b 45 08             	mov    0x8(%ebp),%eax
  80232e:	6a 00                	push   $0x0
  802330:	6a 00                	push   $0x0
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	50                   	push   %eax
  802337:	6a 23                	push   $0x23
  802339:	e8 f0 fb ff ff       	call   801f2e <syscall>
  80233e:	83 c4 18             	add    $0x18,%esp
}
  802341:	90                   	nop
  802342:	c9                   	leave  
  802343:	c3                   	ret    

00802344 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802344:	55                   	push   %ebp
  802345:	89 e5                	mov    %esp,%ebp
  802347:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80234a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80234d:	8d 50 04             	lea    0x4(%eax),%edx
  802350:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	6a 00                	push   $0x0
  802359:	52                   	push   %edx
  80235a:	50                   	push   %eax
  80235b:	6a 24                	push   $0x24
  80235d:	e8 cc fb ff ff       	call   801f2e <syscall>
  802362:	83 c4 18             	add    $0x18,%esp
	return result;
  802365:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802368:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80236b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80236e:	89 01                	mov    %eax,(%ecx)
  802370:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802373:	8b 45 08             	mov    0x8(%ebp),%eax
  802376:	c9                   	leave  
  802377:	c2 04 00             	ret    $0x4

0080237a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80237a:	55                   	push   %ebp
  80237b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80237d:	6a 00                	push   $0x0
  80237f:	6a 00                	push   $0x0
  802381:	ff 75 10             	pushl  0x10(%ebp)
  802384:	ff 75 0c             	pushl  0xc(%ebp)
  802387:	ff 75 08             	pushl  0x8(%ebp)
  80238a:	6a 13                	push   $0x13
  80238c:	e8 9d fb ff ff       	call   801f2e <syscall>
  802391:	83 c4 18             	add    $0x18,%esp
	return ;
  802394:	90                   	nop
}
  802395:	c9                   	leave  
  802396:	c3                   	ret    

00802397 <sys_rcr2>:
uint32 sys_rcr2()
{
  802397:	55                   	push   %ebp
  802398:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80239a:	6a 00                	push   $0x0
  80239c:	6a 00                	push   $0x0
  80239e:	6a 00                	push   $0x0
  8023a0:	6a 00                	push   $0x0
  8023a2:	6a 00                	push   $0x0
  8023a4:	6a 25                	push   $0x25
  8023a6:	e8 83 fb ff ff       	call   801f2e <syscall>
  8023ab:	83 c4 18             	add    $0x18,%esp
}
  8023ae:	c9                   	leave  
  8023af:	c3                   	ret    

008023b0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8023b0:	55                   	push   %ebp
  8023b1:	89 e5                	mov    %esp,%ebp
  8023b3:	83 ec 04             	sub    $0x4,%esp
  8023b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8023bc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8023c0:	6a 00                	push   $0x0
  8023c2:	6a 00                	push   $0x0
  8023c4:	6a 00                	push   $0x0
  8023c6:	6a 00                	push   $0x0
  8023c8:	50                   	push   %eax
  8023c9:	6a 26                	push   $0x26
  8023cb:	e8 5e fb ff ff       	call   801f2e <syscall>
  8023d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8023d3:	90                   	nop
}
  8023d4:	c9                   	leave  
  8023d5:	c3                   	ret    

008023d6 <rsttst>:
void rsttst()
{
  8023d6:	55                   	push   %ebp
  8023d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8023d9:	6a 00                	push   $0x0
  8023db:	6a 00                	push   $0x0
  8023dd:	6a 00                	push   $0x0
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	6a 28                	push   $0x28
  8023e5:	e8 44 fb ff ff       	call   801f2e <syscall>
  8023ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8023ed:	90                   	nop
}
  8023ee:	c9                   	leave  
  8023ef:	c3                   	ret    

008023f0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8023f0:	55                   	push   %ebp
  8023f1:	89 e5                	mov    %esp,%ebp
  8023f3:	83 ec 04             	sub    $0x4,%esp
  8023f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8023f9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8023fc:	8b 55 18             	mov    0x18(%ebp),%edx
  8023ff:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802403:	52                   	push   %edx
  802404:	50                   	push   %eax
  802405:	ff 75 10             	pushl  0x10(%ebp)
  802408:	ff 75 0c             	pushl  0xc(%ebp)
  80240b:	ff 75 08             	pushl  0x8(%ebp)
  80240e:	6a 27                	push   $0x27
  802410:	e8 19 fb ff ff       	call   801f2e <syscall>
  802415:	83 c4 18             	add    $0x18,%esp
	return ;
  802418:	90                   	nop
}
  802419:	c9                   	leave  
  80241a:	c3                   	ret    

0080241b <chktst>:
void chktst(uint32 n)
{
  80241b:	55                   	push   %ebp
  80241c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80241e:	6a 00                	push   $0x0
  802420:	6a 00                	push   $0x0
  802422:	6a 00                	push   $0x0
  802424:	6a 00                	push   $0x0
  802426:	ff 75 08             	pushl  0x8(%ebp)
  802429:	6a 29                	push   $0x29
  80242b:	e8 fe fa ff ff       	call   801f2e <syscall>
  802430:	83 c4 18             	add    $0x18,%esp
	return ;
  802433:	90                   	nop
}
  802434:	c9                   	leave  
  802435:	c3                   	ret    

00802436 <inctst>:

void inctst()
{
  802436:	55                   	push   %ebp
  802437:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802439:	6a 00                	push   $0x0
  80243b:	6a 00                	push   $0x0
  80243d:	6a 00                	push   $0x0
  80243f:	6a 00                	push   $0x0
  802441:	6a 00                	push   $0x0
  802443:	6a 2a                	push   $0x2a
  802445:	e8 e4 fa ff ff       	call   801f2e <syscall>
  80244a:	83 c4 18             	add    $0x18,%esp
	return ;
  80244d:	90                   	nop
}
  80244e:	c9                   	leave  
  80244f:	c3                   	ret    

00802450 <gettst>:
uint32 gettst()
{
  802450:	55                   	push   %ebp
  802451:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802453:	6a 00                	push   $0x0
  802455:	6a 00                	push   $0x0
  802457:	6a 00                	push   $0x0
  802459:	6a 00                	push   $0x0
  80245b:	6a 00                	push   $0x0
  80245d:	6a 2b                	push   $0x2b
  80245f:	e8 ca fa ff ff       	call   801f2e <syscall>
  802464:	83 c4 18             	add    $0x18,%esp
}
  802467:	c9                   	leave  
  802468:	c3                   	ret    

00802469 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802469:	55                   	push   %ebp
  80246a:	89 e5                	mov    %esp,%ebp
  80246c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80246f:	6a 00                	push   $0x0
  802471:	6a 00                	push   $0x0
  802473:	6a 00                	push   $0x0
  802475:	6a 00                	push   $0x0
  802477:	6a 00                	push   $0x0
  802479:	6a 2c                	push   $0x2c
  80247b:	e8 ae fa ff ff       	call   801f2e <syscall>
  802480:	83 c4 18             	add    $0x18,%esp
  802483:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802486:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80248a:	75 07                	jne    802493 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80248c:	b8 01 00 00 00       	mov    $0x1,%eax
  802491:	eb 05                	jmp    802498 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802493:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802498:	c9                   	leave  
  802499:	c3                   	ret    

0080249a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80249a:	55                   	push   %ebp
  80249b:	89 e5                	mov    %esp,%ebp
  80249d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024a0:	6a 00                	push   $0x0
  8024a2:	6a 00                	push   $0x0
  8024a4:	6a 00                	push   $0x0
  8024a6:	6a 00                	push   $0x0
  8024a8:	6a 00                	push   $0x0
  8024aa:	6a 2c                	push   $0x2c
  8024ac:	e8 7d fa ff ff       	call   801f2e <syscall>
  8024b1:	83 c4 18             	add    $0x18,%esp
  8024b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8024b7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8024bb:	75 07                	jne    8024c4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8024bd:	b8 01 00 00 00       	mov    $0x1,%eax
  8024c2:	eb 05                	jmp    8024c9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8024c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024c9:	c9                   	leave  
  8024ca:	c3                   	ret    

008024cb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8024cb:	55                   	push   %ebp
  8024cc:	89 e5                	mov    %esp,%ebp
  8024ce:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024d1:	6a 00                	push   $0x0
  8024d3:	6a 00                	push   $0x0
  8024d5:	6a 00                	push   $0x0
  8024d7:	6a 00                	push   $0x0
  8024d9:	6a 00                	push   $0x0
  8024db:	6a 2c                	push   $0x2c
  8024dd:	e8 4c fa ff ff       	call   801f2e <syscall>
  8024e2:	83 c4 18             	add    $0x18,%esp
  8024e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8024e8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8024ec:	75 07                	jne    8024f5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8024ee:	b8 01 00 00 00       	mov    $0x1,%eax
  8024f3:	eb 05                	jmp    8024fa <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8024f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024fa:	c9                   	leave  
  8024fb:	c3                   	ret    

008024fc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8024fc:	55                   	push   %ebp
  8024fd:	89 e5                	mov    %esp,%ebp
  8024ff:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802502:	6a 00                	push   $0x0
  802504:	6a 00                	push   $0x0
  802506:	6a 00                	push   $0x0
  802508:	6a 00                	push   $0x0
  80250a:	6a 00                	push   $0x0
  80250c:	6a 2c                	push   $0x2c
  80250e:	e8 1b fa ff ff       	call   801f2e <syscall>
  802513:	83 c4 18             	add    $0x18,%esp
  802516:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802519:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80251d:	75 07                	jne    802526 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80251f:	b8 01 00 00 00       	mov    $0x1,%eax
  802524:	eb 05                	jmp    80252b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802526:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80252b:	c9                   	leave  
  80252c:	c3                   	ret    

0080252d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80252d:	55                   	push   %ebp
  80252e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802530:	6a 00                	push   $0x0
  802532:	6a 00                	push   $0x0
  802534:	6a 00                	push   $0x0
  802536:	6a 00                	push   $0x0
  802538:	ff 75 08             	pushl  0x8(%ebp)
  80253b:	6a 2d                	push   $0x2d
  80253d:	e8 ec f9 ff ff       	call   801f2e <syscall>
  802542:	83 c4 18             	add    $0x18,%esp
	return ;
  802545:	90                   	nop
}
  802546:	c9                   	leave  
  802547:	c3                   	ret    

00802548 <__udivdi3>:
  802548:	55                   	push   %ebp
  802549:	57                   	push   %edi
  80254a:	56                   	push   %esi
  80254b:	53                   	push   %ebx
  80254c:	83 ec 1c             	sub    $0x1c,%esp
  80254f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802553:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802557:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80255b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80255f:	89 ca                	mov    %ecx,%edx
  802561:	89 f8                	mov    %edi,%eax
  802563:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802567:	85 f6                	test   %esi,%esi
  802569:	75 2d                	jne    802598 <__udivdi3+0x50>
  80256b:	39 cf                	cmp    %ecx,%edi
  80256d:	77 65                	ja     8025d4 <__udivdi3+0x8c>
  80256f:	89 fd                	mov    %edi,%ebp
  802571:	85 ff                	test   %edi,%edi
  802573:	75 0b                	jne    802580 <__udivdi3+0x38>
  802575:	b8 01 00 00 00       	mov    $0x1,%eax
  80257a:	31 d2                	xor    %edx,%edx
  80257c:	f7 f7                	div    %edi
  80257e:	89 c5                	mov    %eax,%ebp
  802580:	31 d2                	xor    %edx,%edx
  802582:	89 c8                	mov    %ecx,%eax
  802584:	f7 f5                	div    %ebp
  802586:	89 c1                	mov    %eax,%ecx
  802588:	89 d8                	mov    %ebx,%eax
  80258a:	f7 f5                	div    %ebp
  80258c:	89 cf                	mov    %ecx,%edi
  80258e:	89 fa                	mov    %edi,%edx
  802590:	83 c4 1c             	add    $0x1c,%esp
  802593:	5b                   	pop    %ebx
  802594:	5e                   	pop    %esi
  802595:	5f                   	pop    %edi
  802596:	5d                   	pop    %ebp
  802597:	c3                   	ret    
  802598:	39 ce                	cmp    %ecx,%esi
  80259a:	77 28                	ja     8025c4 <__udivdi3+0x7c>
  80259c:	0f bd fe             	bsr    %esi,%edi
  80259f:	83 f7 1f             	xor    $0x1f,%edi
  8025a2:	75 40                	jne    8025e4 <__udivdi3+0x9c>
  8025a4:	39 ce                	cmp    %ecx,%esi
  8025a6:	72 0a                	jb     8025b2 <__udivdi3+0x6a>
  8025a8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8025ac:	0f 87 9e 00 00 00    	ja     802650 <__udivdi3+0x108>
  8025b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8025b7:	89 fa                	mov    %edi,%edx
  8025b9:	83 c4 1c             	add    $0x1c,%esp
  8025bc:	5b                   	pop    %ebx
  8025bd:	5e                   	pop    %esi
  8025be:	5f                   	pop    %edi
  8025bf:	5d                   	pop    %ebp
  8025c0:	c3                   	ret    
  8025c1:	8d 76 00             	lea    0x0(%esi),%esi
  8025c4:	31 ff                	xor    %edi,%edi
  8025c6:	31 c0                	xor    %eax,%eax
  8025c8:	89 fa                	mov    %edi,%edx
  8025ca:	83 c4 1c             	add    $0x1c,%esp
  8025cd:	5b                   	pop    %ebx
  8025ce:	5e                   	pop    %esi
  8025cf:	5f                   	pop    %edi
  8025d0:	5d                   	pop    %ebp
  8025d1:	c3                   	ret    
  8025d2:	66 90                	xchg   %ax,%ax
  8025d4:	89 d8                	mov    %ebx,%eax
  8025d6:	f7 f7                	div    %edi
  8025d8:	31 ff                	xor    %edi,%edi
  8025da:	89 fa                	mov    %edi,%edx
  8025dc:	83 c4 1c             	add    $0x1c,%esp
  8025df:	5b                   	pop    %ebx
  8025e0:	5e                   	pop    %esi
  8025e1:	5f                   	pop    %edi
  8025e2:	5d                   	pop    %ebp
  8025e3:	c3                   	ret    
  8025e4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8025e9:	89 eb                	mov    %ebp,%ebx
  8025eb:	29 fb                	sub    %edi,%ebx
  8025ed:	89 f9                	mov    %edi,%ecx
  8025ef:	d3 e6                	shl    %cl,%esi
  8025f1:	89 c5                	mov    %eax,%ebp
  8025f3:	88 d9                	mov    %bl,%cl
  8025f5:	d3 ed                	shr    %cl,%ebp
  8025f7:	89 e9                	mov    %ebp,%ecx
  8025f9:	09 f1                	or     %esi,%ecx
  8025fb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8025ff:	89 f9                	mov    %edi,%ecx
  802601:	d3 e0                	shl    %cl,%eax
  802603:	89 c5                	mov    %eax,%ebp
  802605:	89 d6                	mov    %edx,%esi
  802607:	88 d9                	mov    %bl,%cl
  802609:	d3 ee                	shr    %cl,%esi
  80260b:	89 f9                	mov    %edi,%ecx
  80260d:	d3 e2                	shl    %cl,%edx
  80260f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802613:	88 d9                	mov    %bl,%cl
  802615:	d3 e8                	shr    %cl,%eax
  802617:	09 c2                	or     %eax,%edx
  802619:	89 d0                	mov    %edx,%eax
  80261b:	89 f2                	mov    %esi,%edx
  80261d:	f7 74 24 0c          	divl   0xc(%esp)
  802621:	89 d6                	mov    %edx,%esi
  802623:	89 c3                	mov    %eax,%ebx
  802625:	f7 e5                	mul    %ebp
  802627:	39 d6                	cmp    %edx,%esi
  802629:	72 19                	jb     802644 <__udivdi3+0xfc>
  80262b:	74 0b                	je     802638 <__udivdi3+0xf0>
  80262d:	89 d8                	mov    %ebx,%eax
  80262f:	31 ff                	xor    %edi,%edi
  802631:	e9 58 ff ff ff       	jmp    80258e <__udivdi3+0x46>
  802636:	66 90                	xchg   %ax,%ax
  802638:	8b 54 24 08          	mov    0x8(%esp),%edx
  80263c:	89 f9                	mov    %edi,%ecx
  80263e:	d3 e2                	shl    %cl,%edx
  802640:	39 c2                	cmp    %eax,%edx
  802642:	73 e9                	jae    80262d <__udivdi3+0xe5>
  802644:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802647:	31 ff                	xor    %edi,%edi
  802649:	e9 40 ff ff ff       	jmp    80258e <__udivdi3+0x46>
  80264e:	66 90                	xchg   %ax,%ax
  802650:	31 c0                	xor    %eax,%eax
  802652:	e9 37 ff ff ff       	jmp    80258e <__udivdi3+0x46>
  802657:	90                   	nop

00802658 <__umoddi3>:
  802658:	55                   	push   %ebp
  802659:	57                   	push   %edi
  80265a:	56                   	push   %esi
  80265b:	53                   	push   %ebx
  80265c:	83 ec 1c             	sub    $0x1c,%esp
  80265f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802663:	8b 74 24 34          	mov    0x34(%esp),%esi
  802667:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80266b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80266f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802673:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802677:	89 f3                	mov    %esi,%ebx
  802679:	89 fa                	mov    %edi,%edx
  80267b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80267f:	89 34 24             	mov    %esi,(%esp)
  802682:	85 c0                	test   %eax,%eax
  802684:	75 1a                	jne    8026a0 <__umoddi3+0x48>
  802686:	39 f7                	cmp    %esi,%edi
  802688:	0f 86 a2 00 00 00    	jbe    802730 <__umoddi3+0xd8>
  80268e:	89 c8                	mov    %ecx,%eax
  802690:	89 f2                	mov    %esi,%edx
  802692:	f7 f7                	div    %edi
  802694:	89 d0                	mov    %edx,%eax
  802696:	31 d2                	xor    %edx,%edx
  802698:	83 c4 1c             	add    $0x1c,%esp
  80269b:	5b                   	pop    %ebx
  80269c:	5e                   	pop    %esi
  80269d:	5f                   	pop    %edi
  80269e:	5d                   	pop    %ebp
  80269f:	c3                   	ret    
  8026a0:	39 f0                	cmp    %esi,%eax
  8026a2:	0f 87 ac 00 00 00    	ja     802754 <__umoddi3+0xfc>
  8026a8:	0f bd e8             	bsr    %eax,%ebp
  8026ab:	83 f5 1f             	xor    $0x1f,%ebp
  8026ae:	0f 84 ac 00 00 00    	je     802760 <__umoddi3+0x108>
  8026b4:	bf 20 00 00 00       	mov    $0x20,%edi
  8026b9:	29 ef                	sub    %ebp,%edi
  8026bb:	89 fe                	mov    %edi,%esi
  8026bd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8026c1:	89 e9                	mov    %ebp,%ecx
  8026c3:	d3 e0                	shl    %cl,%eax
  8026c5:	89 d7                	mov    %edx,%edi
  8026c7:	89 f1                	mov    %esi,%ecx
  8026c9:	d3 ef                	shr    %cl,%edi
  8026cb:	09 c7                	or     %eax,%edi
  8026cd:	89 e9                	mov    %ebp,%ecx
  8026cf:	d3 e2                	shl    %cl,%edx
  8026d1:	89 14 24             	mov    %edx,(%esp)
  8026d4:	89 d8                	mov    %ebx,%eax
  8026d6:	d3 e0                	shl    %cl,%eax
  8026d8:	89 c2                	mov    %eax,%edx
  8026da:	8b 44 24 08          	mov    0x8(%esp),%eax
  8026de:	d3 e0                	shl    %cl,%eax
  8026e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8026e4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8026e8:	89 f1                	mov    %esi,%ecx
  8026ea:	d3 e8                	shr    %cl,%eax
  8026ec:	09 d0                	or     %edx,%eax
  8026ee:	d3 eb                	shr    %cl,%ebx
  8026f0:	89 da                	mov    %ebx,%edx
  8026f2:	f7 f7                	div    %edi
  8026f4:	89 d3                	mov    %edx,%ebx
  8026f6:	f7 24 24             	mull   (%esp)
  8026f9:	89 c6                	mov    %eax,%esi
  8026fb:	89 d1                	mov    %edx,%ecx
  8026fd:	39 d3                	cmp    %edx,%ebx
  8026ff:	0f 82 87 00 00 00    	jb     80278c <__umoddi3+0x134>
  802705:	0f 84 91 00 00 00    	je     80279c <__umoddi3+0x144>
  80270b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80270f:	29 f2                	sub    %esi,%edx
  802711:	19 cb                	sbb    %ecx,%ebx
  802713:	89 d8                	mov    %ebx,%eax
  802715:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802719:	d3 e0                	shl    %cl,%eax
  80271b:	89 e9                	mov    %ebp,%ecx
  80271d:	d3 ea                	shr    %cl,%edx
  80271f:	09 d0                	or     %edx,%eax
  802721:	89 e9                	mov    %ebp,%ecx
  802723:	d3 eb                	shr    %cl,%ebx
  802725:	89 da                	mov    %ebx,%edx
  802727:	83 c4 1c             	add    $0x1c,%esp
  80272a:	5b                   	pop    %ebx
  80272b:	5e                   	pop    %esi
  80272c:	5f                   	pop    %edi
  80272d:	5d                   	pop    %ebp
  80272e:	c3                   	ret    
  80272f:	90                   	nop
  802730:	89 fd                	mov    %edi,%ebp
  802732:	85 ff                	test   %edi,%edi
  802734:	75 0b                	jne    802741 <__umoddi3+0xe9>
  802736:	b8 01 00 00 00       	mov    $0x1,%eax
  80273b:	31 d2                	xor    %edx,%edx
  80273d:	f7 f7                	div    %edi
  80273f:	89 c5                	mov    %eax,%ebp
  802741:	89 f0                	mov    %esi,%eax
  802743:	31 d2                	xor    %edx,%edx
  802745:	f7 f5                	div    %ebp
  802747:	89 c8                	mov    %ecx,%eax
  802749:	f7 f5                	div    %ebp
  80274b:	89 d0                	mov    %edx,%eax
  80274d:	e9 44 ff ff ff       	jmp    802696 <__umoddi3+0x3e>
  802752:	66 90                	xchg   %ax,%ax
  802754:	89 c8                	mov    %ecx,%eax
  802756:	89 f2                	mov    %esi,%edx
  802758:	83 c4 1c             	add    $0x1c,%esp
  80275b:	5b                   	pop    %ebx
  80275c:	5e                   	pop    %esi
  80275d:	5f                   	pop    %edi
  80275e:	5d                   	pop    %ebp
  80275f:	c3                   	ret    
  802760:	3b 04 24             	cmp    (%esp),%eax
  802763:	72 06                	jb     80276b <__umoddi3+0x113>
  802765:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802769:	77 0f                	ja     80277a <__umoddi3+0x122>
  80276b:	89 f2                	mov    %esi,%edx
  80276d:	29 f9                	sub    %edi,%ecx
  80276f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802773:	89 14 24             	mov    %edx,(%esp)
  802776:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80277a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80277e:	8b 14 24             	mov    (%esp),%edx
  802781:	83 c4 1c             	add    $0x1c,%esp
  802784:	5b                   	pop    %ebx
  802785:	5e                   	pop    %esi
  802786:	5f                   	pop    %edi
  802787:	5d                   	pop    %ebp
  802788:	c3                   	ret    
  802789:	8d 76 00             	lea    0x0(%esi),%esi
  80278c:	2b 04 24             	sub    (%esp),%eax
  80278f:	19 fa                	sbb    %edi,%edx
  802791:	89 d1                	mov    %edx,%ecx
  802793:	89 c6                	mov    %eax,%esi
  802795:	e9 71 ff ff ff       	jmp    80270b <__umoddi3+0xb3>
  80279a:	66 90                	xchg   %ax,%ax
  80279c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8027a0:	72 ea                	jb     80278c <__umoddi3+0x134>
  8027a2:	89 d9                	mov    %ebx,%ecx
  8027a4:	e9 62 ff ff ff       	jmp    80270b <__umoddi3+0xb3>
