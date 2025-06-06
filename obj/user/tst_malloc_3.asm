
obj/user/tst_malloc_3:     file format elf32-i386


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
  800031:	e8 2b 0e 00 00       	call   800e61 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	short b;
	int c;
};

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec 20 01 00 00    	sub    $0x120,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800043:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800047:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004e:	eb 29                	jmp    800079 <_main+0x41>
		{
			if (myEnv->__uptr_pws[i].empty)
  800050:	a1 20 40 80 00       	mov    0x804020,%eax
  800055:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80005b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005e:	89 d0                	mov    %edx,%eax
  800060:	01 c0                	add    %eax,%eax
  800062:	01 d0                	add    %edx,%eax
  800064:	c1 e0 02             	shl    $0x2,%eax
  800067:	01 c8                	add    %ecx,%eax
  800069:	8a 40 04             	mov    0x4(%eax),%al
  80006c:	84 c0                	test   %al,%al
  80006e:	74 06                	je     800076 <_main+0x3e>
			{
				fullWS = 0;
  800070:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800074:	eb 12                	jmp    800088 <_main+0x50>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800076:	ff 45 f0             	incl   -0x10(%ebp)
  800079:	a1 20 40 80 00       	mov    0x804020,%eax
  80007e:	8b 50 74             	mov    0x74(%eax),%edx
  800081:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800084:	39 c2                	cmp    %eax,%edx
  800086:	77 c8                	ja     800050 <_main+0x18>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800088:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008c:	74 14                	je     8000a2 <_main+0x6a>
  80008e:	83 ec 04             	sub    $0x4,%esp
  800091:	68 c0 2a 80 00       	push   $0x802ac0
  800096:	6a 1a                	push   $0x1a
  800098:	68 dc 2a 80 00       	push   $0x802adc
  80009d:	e8 c1 0e 00 00       	call   800f63 <_panic>


	
	

	int Mega = 1024*1024;
  8000a2:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  8000a9:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	char minByte = 1<<7;
  8000b0:	c6 45 df 80          	movb   $0x80,-0x21(%ebp)
	char maxByte = 0x7F;
  8000b4:	c6 45 de 7f          	movb   $0x7f,-0x22(%ebp)
	short minShort = 1<<15 ;
  8000b8:	66 c7 45 dc 00 80    	movw   $0x8000,-0x24(%ebp)
	short maxShort = 0x7FFF;
  8000be:	66 c7 45 da ff 7f    	movw   $0x7fff,-0x26(%ebp)
	int minInt = 1<<31 ;
  8000c4:	c7 45 d4 00 00 00 80 	movl   $0x80000000,-0x2c(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000cb:	c7 45 d0 ff ff ff 7f 	movl   $0x7fffffff,-0x30(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000d2:	e8 c6 22 00 00       	call   80239d <sys_calculate_free_frames>
  8000d7:	89 45 cc             	mov    %eax,-0x34(%ebp)

	void* ptr_allocations[20] = {0};
  8000da:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  8000e0:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ea:	89 d7                	mov    %edx,%edi
  8000ec:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000ee:	e8 2d 23 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  8000f3:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 d4 1e 00 00       	call   801fdb <malloc>
  800107:	83 c4 10             	add    $0x10,%esp
  80010a:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800110:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800116:	85 c0                	test   %eax,%eax
  800118:	79 0d                	jns    800127 <_main+0xef>
  80011a:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800120:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800125:	76 14                	jbe    80013b <_main+0x103>
  800127:	83 ec 04             	sub    $0x4,%esp
  80012a:	68 f0 2a 80 00       	push   $0x802af0
  80012f:	6a 36                	push   $0x36
  800131:	68 dc 2a 80 00       	push   $0x802adc
  800136:	e8 28 0e 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80013b:	e8 e0 22 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800140:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800143:	3d 00 02 00 00       	cmp    $0x200,%eax
  800148:	74 14                	je     80015e <_main+0x126>
  80014a:	83 ec 04             	sub    $0x4,%esp
  80014d:	68 58 2b 80 00       	push   $0x802b58
  800152:	6a 37                	push   $0x37
  800154:	68 dc 2a 80 00       	push   $0x802adc
  800159:	e8 05 0e 00 00       	call   800f63 <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  80015e:	e8 3a 22 00 00       	call   80239d <sys_calculate_free_frames>
  800163:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800166:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80016e:	48                   	dec    %eax
  80016f:	89 45 c0             	mov    %eax,-0x40(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800172:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800178:	89 45 bc             	mov    %eax,-0x44(%ebp)
		byteArr[0] = minByte ;
  80017b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80017e:	8a 55 df             	mov    -0x21(%ebp),%dl
  800181:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800183:	8b 55 c0             	mov    -0x40(%ebp),%edx
  800186:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800189:	01 c2                	add    %eax,%edx
  80018b:	8a 45 de             	mov    -0x22(%ebp),%al
  80018e:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800190:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800193:	e8 05 22 00 00       	call   80239d <sys_calculate_free_frames>
  800198:	29 c3                	sub    %eax,%ebx
  80019a:	89 d8                	mov    %ebx,%eax
  80019c:	83 f8 03             	cmp    $0x3,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 88 2b 80 00       	push   $0x802b88
  8001a9:	6a 3e                	push   $0x3e
  8001ab:	68 dc 2a 80 00       	push   $0x802adc
  8001b0:	e8 ae 0d 00 00       	call   800f63 <_panic>
		int var;
		int found = 0;
  8001b5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8001bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001c3:	e9 82 00 00 00       	jmp    80024a <_main+0x212>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  8001c8:	a1 20 40 80 00       	mov    0x804020,%eax
  8001cd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8001d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001d6:	89 d0                	mov    %edx,%eax
  8001d8:	01 c0                	add    %eax,%eax
  8001da:	01 d0                	add    %edx,%eax
  8001dc:	c1 e0 02             	shl    $0x2,%eax
  8001df:	01 c8                	add    %ecx,%eax
  8001e1:	8b 00                	mov    (%eax),%eax
  8001e3:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001e6:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ee:	89 c2                	mov    %eax,%edx
  8001f0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001f3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001f6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001fe:	39 c2                	cmp    %eax,%edx
  800200:	75 03                	jne    800205 <_main+0x1cd>
				found++;
  800202:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800205:	a1 20 40 80 00       	mov    0x804020,%eax
  80020a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800210:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800213:	89 d0                	mov    %edx,%eax
  800215:	01 c0                	add    %eax,%eax
  800217:	01 d0                	add    %edx,%eax
  800219:	c1 e0 02             	shl    $0x2,%eax
  80021c:	01 c8                	add    %ecx,%eax
  80021e:	8b 00                	mov    (%eax),%eax
  800220:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800223:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800226:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022b:	89 c1                	mov    %eax,%ecx
  80022d:	8b 55 c0             	mov    -0x40(%ebp),%edx
  800230:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800233:	01 d0                	add    %edx,%eax
  800235:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800238:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80023b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800240:	39 c1                	cmp    %eax,%ecx
  800242:	75 03                	jne    800247 <_main+0x20f>
				found++;
  800244:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr[0] = minByte ;
		byteArr[lastIndexOfByte] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;
		int found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800247:	ff 45 ec             	incl   -0x14(%ebp)
  80024a:	a1 20 40 80 00       	mov    0x804020,%eax
  80024f:	8b 50 74             	mov    0x74(%eax),%edx
  800252:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800255:	39 c2                	cmp    %eax,%edx
  800257:	0f 87 6b ff ff ff    	ja     8001c8 <_main+0x190>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  80025d:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800261:	74 14                	je     800277 <_main+0x23f>
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 cc 2b 80 00       	push   $0x802bcc
  80026b:	6a 48                	push   $0x48
  80026d:	68 dc 2a 80 00       	push   $0x802adc
  800272:	e8 ec 0c 00 00       	call   800f63 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800277:	e8 a4 21 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  80027c:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80027f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800282:	01 c0                	add    %eax,%eax
  800284:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800287:	83 ec 0c             	sub    $0xc,%esp
  80028a:	50                   	push   %eax
  80028b:	e8 4b 1d 00 00       	call   801fdb <malloc>
  800290:	83 c4 10             	add    $0x10,%esp
  800293:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800299:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80029f:	89 c2                	mov    %eax,%edx
  8002a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a4:	01 c0                	add    %eax,%eax
  8002a6:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ab:	39 c2                	cmp    %eax,%edx
  8002ad:	72 16                	jb     8002c5 <_main+0x28d>
  8002af:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8002b5:	89 c2                	mov    %eax,%edx
  8002b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002ba:	01 c0                	add    %eax,%eax
  8002bc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002c1:	39 c2                	cmp    %eax,%edx
  8002c3:	76 14                	jbe    8002d9 <_main+0x2a1>
  8002c5:	83 ec 04             	sub    $0x4,%esp
  8002c8:	68 f0 2a 80 00       	push   $0x802af0
  8002cd:	6a 4d                	push   $0x4d
  8002cf:	68 dc 2a 80 00       	push   $0x802adc
  8002d4:	e8 8a 0c 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002d9:	e8 42 21 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  8002de:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8002e1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 58 2b 80 00       	push   $0x802b58
  8002f0:	6a 4e                	push   $0x4e
  8002f2:	68 dc 2a 80 00       	push   $0x802adc
  8002f7:	e8 67 0c 00 00       	call   800f63 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002fc:	e8 9c 20 00 00       	call   80239d <sys_calculate_free_frames>
  800301:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr = (short *) ptr_allocations[1];
  800304:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80030a:	89 45 a8             	mov    %eax,-0x58(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80030d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800310:	01 c0                	add    %eax,%eax
  800312:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800315:	d1 e8                	shr    %eax
  800317:	48                   	dec    %eax
  800318:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		shortArr[0] = minShort;
  80031b:	8b 55 a8             	mov    -0x58(%ebp),%edx
  80031e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800321:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800324:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800327:	01 c0                	add    %eax,%eax
  800329:	89 c2                	mov    %eax,%edx
  80032b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80032e:	01 c2                	add    %eax,%edx
  800330:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800334:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800337:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  80033a:	e8 5e 20 00 00       	call   80239d <sys_calculate_free_frames>
  80033f:	29 c3                	sub    %eax,%ebx
  800341:	89 d8                	mov    %ebx,%eax
  800343:	83 f8 02             	cmp    $0x2,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 88 2b 80 00       	push   $0x802b88
  800350:	6a 55                	push   $0x55
  800352:	68 dc 2a 80 00       	push   $0x802adc
  800357:	e8 07 0c 00 00       	call   800f63 <_panic>
		found = 0;
  80035c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800363:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80036a:	e9 86 00 00 00       	jmp    8003f5 <_main+0x3bd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  80036f:	a1 20 40 80 00       	mov    0x804020,%eax
  800374:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80037a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80037d:	89 d0                	mov    %edx,%eax
  80037f:	01 c0                	add    %eax,%eax
  800381:	01 d0                	add    %edx,%eax
  800383:	c1 e0 02             	shl    $0x2,%eax
  800386:	01 c8                	add    %ecx,%eax
  800388:	8b 00                	mov    (%eax),%eax
  80038a:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80038d:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800390:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800395:	89 c2                	mov    %eax,%edx
  800397:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80039a:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80039d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a5:	39 c2                	cmp    %eax,%edx
  8003a7:	75 03                	jne    8003ac <_main+0x374>
				found++;
  8003a9:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8003ac:	a1 20 40 80 00       	mov    0x804020,%eax
  8003b1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003ba:	89 d0                	mov    %edx,%eax
  8003bc:	01 c0                	add    %eax,%eax
  8003be:	01 d0                	add    %edx,%eax
  8003c0:	c1 e0 02             	shl    $0x2,%eax
  8003c3:	01 c8                	add    %ecx,%eax
  8003c5:	8b 00                	mov    (%eax),%eax
  8003c7:	89 45 98             	mov    %eax,-0x68(%ebp)
  8003ca:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003d7:	01 c0                	add    %eax,%eax
  8003d9:	89 c1                	mov    %eax,%ecx
  8003db:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003de:	01 c8                	add    %ecx,%eax
  8003e0:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003e3:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8003e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003eb:	39 c2                	cmp    %eax,%edx
  8003ed:	75 03                	jne    8003f2 <_main+0x3ba>
				found++;
  8003ef:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8003f2:	ff 45 ec             	incl   -0x14(%ebp)
  8003f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8003fa:	8b 50 74             	mov    0x74(%eax),%edx
  8003fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800400:	39 c2                	cmp    %eax,%edx
  800402:	0f 87 67 ff ff ff    	ja     80036f <_main+0x337>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800408:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  80040c:	74 14                	je     800422 <_main+0x3ea>
  80040e:	83 ec 04             	sub    $0x4,%esp
  800411:	68 cc 2b 80 00       	push   $0x802bcc
  800416:	6a 5e                	push   $0x5e
  800418:	68 dc 2a 80 00       	push   $0x802adc
  80041d:	e8 41 0b 00 00       	call   800f63 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800422:	e8 f9 1f 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800427:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  80042a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80042d:	01 c0                	add    %eax,%eax
  80042f:	83 ec 0c             	sub    $0xc,%esp
  800432:	50                   	push   %eax
  800433:	e8 a3 1b 00 00       	call   801fdb <malloc>
  800438:	83 c4 10             	add    $0x10,%esp
  80043b:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800441:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800447:	89 c2                	mov    %eax,%edx
  800449:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044c:	c1 e0 02             	shl    $0x2,%eax
  80044f:	05 00 00 00 80       	add    $0x80000000,%eax
  800454:	39 c2                	cmp    %eax,%edx
  800456:	72 17                	jb     80046f <_main+0x437>
  800458:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  80045e:	89 c2                	mov    %eax,%edx
  800460:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800463:	c1 e0 02             	shl    $0x2,%eax
  800466:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80046b:	39 c2                	cmp    %eax,%edx
  80046d:	76 14                	jbe    800483 <_main+0x44b>
  80046f:	83 ec 04             	sub    $0x4,%esp
  800472:	68 f0 2a 80 00       	push   $0x802af0
  800477:	6a 63                	push   $0x63
  800479:	68 dc 2a 80 00       	push   $0x802adc
  80047e:	e8 e0 0a 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800483:	e8 98 1f 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800488:	2b 45 c8             	sub    -0x38(%ebp),%eax
  80048b:	83 f8 01             	cmp    $0x1,%eax
  80048e:	74 14                	je     8004a4 <_main+0x46c>
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	68 58 2b 80 00       	push   $0x802b58
  800498:	6a 64                	push   $0x64
  80049a:	68 dc 2a 80 00       	push   $0x802adc
  80049f:	e8 bf 0a 00 00       	call   800f63 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004a4:	e8 f4 1e 00 00       	call   80239d <sys_calculate_free_frames>
  8004a9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		intArr = (int *) ptr_allocations[2];
  8004ac:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8004b2:	89 45 90             	mov    %eax,-0x70(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  8004b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004b8:	01 c0                	add    %eax,%eax
  8004ba:	c1 e8 02             	shr    $0x2,%eax
  8004bd:	48                   	dec    %eax
  8004be:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr[0] = minInt;
  8004c1:	8b 45 90             	mov    -0x70(%ebp),%eax
  8004c4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004c7:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8004c9:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d3:	8b 45 90             	mov    -0x70(%ebp),%eax
  8004d6:	01 c2                	add    %eax,%edx
  8004d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004db:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8004dd:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  8004e0:	e8 b8 1e 00 00       	call   80239d <sys_calculate_free_frames>
  8004e5:	29 c3                	sub    %eax,%ebx
  8004e7:	89 d8                	mov    %ebx,%eax
  8004e9:	83 f8 02             	cmp    $0x2,%eax
  8004ec:	74 14                	je     800502 <_main+0x4ca>
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	68 88 2b 80 00       	push   $0x802b88
  8004f6:	6a 6b                	push   $0x6b
  8004f8:	68 dc 2a 80 00       	push   $0x802adc
  8004fd:	e8 61 0a 00 00       	call   800f63 <_panic>
		found = 0;
  800502:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800509:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800510:	e9 8f 00 00 00       	jmp    8005a4 <_main+0x56c>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800515:	a1 20 40 80 00       	mov    0x804020,%eax
  80051a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800520:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800523:	89 d0                	mov    %edx,%eax
  800525:	01 c0                	add    %eax,%eax
  800527:	01 d0                	add    %edx,%eax
  800529:	c1 e0 02             	shl    $0x2,%eax
  80052c:	01 c8                	add    %ecx,%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	89 45 88             	mov    %eax,-0x78(%ebp)
  800533:	8b 45 88             	mov    -0x78(%ebp),%eax
  800536:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053b:	89 c2                	mov    %eax,%edx
  80053d:	8b 45 90             	mov    -0x70(%ebp),%eax
  800540:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800543:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800546:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80054b:	39 c2                	cmp    %eax,%edx
  80054d:	75 03                	jne    800552 <_main+0x51a>
				found++;
  80054f:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800552:	a1 20 40 80 00       	mov    0x804020,%eax
  800557:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80055d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800560:	89 d0                	mov    %edx,%eax
  800562:	01 c0                	add    %eax,%eax
  800564:	01 d0                	add    %edx,%eax
  800566:	c1 e0 02             	shl    $0x2,%eax
  800569:	01 c8                	add    %ecx,%eax
  80056b:	8b 00                	mov    (%eax),%eax
  80056d:	89 45 80             	mov    %eax,-0x80(%ebp)
  800570:	8b 45 80             	mov    -0x80(%ebp),%eax
  800573:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800578:	89 c2                	mov    %eax,%edx
  80057a:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80057d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800584:	8b 45 90             	mov    -0x70(%ebp),%eax
  800587:	01 c8                	add    %ecx,%eax
  800589:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80058f:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800595:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80059a:	39 c2                	cmp    %eax,%edx
  80059c:	75 03                	jne    8005a1 <_main+0x569>
				found++;
  80059e:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8005a1:	ff 45 ec             	incl   -0x14(%ebp)
  8005a4:	a1 20 40 80 00       	mov    0x804020,%eax
  8005a9:	8b 50 74             	mov    0x74(%eax),%edx
  8005ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005af:	39 c2                	cmp    %eax,%edx
  8005b1:	0f 87 5e ff ff ff    	ja     800515 <_main+0x4dd>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005b7:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005bb:	74 14                	je     8005d1 <_main+0x599>
  8005bd:	83 ec 04             	sub    $0x4,%esp
  8005c0:	68 cc 2b 80 00       	push   $0x802bcc
  8005c5:	6a 74                	push   $0x74
  8005c7:	68 dc 2a 80 00       	push   $0x802adc
  8005cc:	e8 92 09 00 00       	call   800f63 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8005d1:	e8 c7 1d 00 00       	call   80239d <sys_calculate_free_frames>
  8005d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005d9:	e8 42 1e 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  8005de:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8005e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005e4:	01 c0                	add    %eax,%eax
  8005e6:	83 ec 0c             	sub    $0xc,%esp
  8005e9:	50                   	push   %eax
  8005ea:	e8 ec 19 00 00       	call   801fdb <malloc>
  8005ef:	83 c4 10             	add    $0x10,%esp
  8005f2:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005f8:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  8005fe:	89 c2                	mov    %eax,%edx
  800600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800603:	c1 e0 02             	shl    $0x2,%eax
  800606:	89 c1                	mov    %eax,%ecx
  800608:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060b:	c1 e0 02             	shl    $0x2,%eax
  80060e:	01 c8                	add    %ecx,%eax
  800610:	05 00 00 00 80       	add    $0x80000000,%eax
  800615:	39 c2                	cmp    %eax,%edx
  800617:	72 21                	jb     80063a <_main+0x602>
  800619:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  80061f:	89 c2                	mov    %eax,%edx
  800621:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800624:	c1 e0 02             	shl    $0x2,%eax
  800627:	89 c1                	mov    %eax,%ecx
  800629:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80062c:	c1 e0 02             	shl    $0x2,%eax
  80062f:	01 c8                	add    %ecx,%eax
  800631:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800636:	39 c2                	cmp    %eax,%edx
  800638:	76 14                	jbe    80064e <_main+0x616>
  80063a:	83 ec 04             	sub    $0x4,%esp
  80063d:	68 f0 2a 80 00       	push   $0x802af0
  800642:	6a 7a                	push   $0x7a
  800644:	68 dc 2a 80 00       	push   $0x802adc
  800649:	e8 15 09 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80064e:	e8 cd 1d 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800653:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800656:	83 f8 01             	cmp    $0x1,%eax
  800659:	74 14                	je     80066f <_main+0x637>
  80065b:	83 ec 04             	sub    $0x4,%esp
  80065e:	68 58 2b 80 00       	push   $0x802b58
  800663:	6a 7b                	push   $0x7b
  800665:	68 dc 2a 80 00       	push   $0x802adc
  80066a:	e8 f4 08 00 00       	call   800f63 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80066f:	e8 ac 1d 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800674:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800677:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80067a:	89 d0                	mov    %edx,%eax
  80067c:	01 c0                	add    %eax,%eax
  80067e:	01 d0                	add    %edx,%eax
  800680:	01 c0                	add    %eax,%eax
  800682:	01 d0                	add    %edx,%eax
  800684:	83 ec 0c             	sub    $0xc,%esp
  800687:	50                   	push   %eax
  800688:	e8 4e 19 00 00       	call   801fdb <malloc>
  80068d:	83 c4 10             	add    $0x10,%esp
  800690:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800696:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  80069c:	89 c2                	mov    %eax,%edx
  80069e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006a1:	c1 e0 02             	shl    $0x2,%eax
  8006a4:	89 c1                	mov    %eax,%ecx
  8006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a9:	c1 e0 03             	shl    $0x3,%eax
  8006ac:	01 c8                	add    %ecx,%eax
  8006ae:	05 00 00 00 80       	add    $0x80000000,%eax
  8006b3:	39 c2                	cmp    %eax,%edx
  8006b5:	72 21                	jb     8006d8 <_main+0x6a0>
  8006b7:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8006bd:	89 c2                	mov    %eax,%edx
  8006bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006c2:	c1 e0 02             	shl    $0x2,%eax
  8006c5:	89 c1                	mov    %eax,%ecx
  8006c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006ca:	c1 e0 03             	shl    $0x3,%eax
  8006cd:	01 c8                	add    %ecx,%eax
  8006cf:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006d4:	39 c2                	cmp    %eax,%edx
  8006d6:	76 17                	jbe    8006ef <_main+0x6b7>
  8006d8:	83 ec 04             	sub    $0x4,%esp
  8006db:	68 f0 2a 80 00       	push   $0x802af0
  8006e0:	68 81 00 00 00       	push   $0x81
  8006e5:	68 dc 2a 80 00       	push   $0x802adc
  8006ea:	e8 74 08 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006ef:	e8 2c 1d 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  8006f4:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8006f7:	83 f8 02             	cmp    $0x2,%eax
  8006fa:	74 17                	je     800713 <_main+0x6db>
  8006fc:	83 ec 04             	sub    $0x4,%esp
  8006ff:	68 58 2b 80 00       	push   $0x802b58
  800704:	68 82 00 00 00       	push   $0x82
  800709:	68 dc 2a 80 00       	push   $0x802adc
  80070e:	e8 50 08 00 00       	call   800f63 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800713:	e8 85 1c 00 00       	call   80239d <sys_calculate_free_frames>
  800718:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  80071b:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800721:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  800727:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80072a:	89 d0                	mov    %edx,%eax
  80072c:	01 c0                	add    %eax,%eax
  80072e:	01 d0                	add    %edx,%eax
  800730:	01 c0                	add    %eax,%eax
  800732:	01 d0                	add    %edx,%eax
  800734:	c1 e8 03             	shr    $0x3,%eax
  800737:	48                   	dec    %eax
  800738:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  80073e:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800744:	8a 55 df             	mov    -0x21(%ebp),%dl
  800747:	88 10                	mov    %dl,(%eax)
  800749:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  80074f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800752:	66 89 42 02          	mov    %ax,0x2(%edx)
  800756:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80075c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80075f:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800762:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800768:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80076f:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800775:	01 c2                	add    %eax,%edx
  800777:	8a 45 de             	mov    -0x22(%ebp),%al
  80077a:	88 02                	mov    %al,(%edx)
  80077c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800782:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800789:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80078f:	01 c2                	add    %eax,%edx
  800791:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800795:	66 89 42 02          	mov    %ax,0x2(%edx)
  800799:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80079f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007a6:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8007ac:	01 c2                	add    %eax,%edx
  8007ae:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b1:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007b4:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  8007b7:	e8 e1 1b 00 00       	call   80239d <sys_calculate_free_frames>
  8007bc:	29 c3                	sub    %eax,%ebx
  8007be:	89 d8                	mov    %ebx,%eax
  8007c0:	83 f8 02             	cmp    $0x2,%eax
  8007c3:	74 17                	je     8007dc <_main+0x7a4>
  8007c5:	83 ec 04             	sub    $0x4,%esp
  8007c8:	68 88 2b 80 00       	push   $0x802b88
  8007cd:	68 89 00 00 00       	push   $0x89
  8007d2:	68 dc 2a 80 00       	push   $0x802adc
  8007d7:	e8 87 07 00 00       	call   800f63 <_panic>
		found = 0;
  8007dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007ea:	e9 aa 00 00 00       	jmp    800899 <_main+0x861>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007ef:	a1 20 40 80 00       	mov    0x804020,%eax
  8007f4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007fd:	89 d0                	mov    %edx,%eax
  8007ff:	01 c0                	add    %eax,%eax
  800801:	01 d0                	add    %edx,%eax
  800803:	c1 e0 02             	shl    $0x2,%eax
  800806:	01 c8                	add    %ecx,%eax
  800808:	8b 00                	mov    (%eax),%eax
  80080a:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  800810:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800816:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80081b:	89 c2                	mov    %eax,%edx
  80081d:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800823:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800829:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80082f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800834:	39 c2                	cmp    %eax,%edx
  800836:	75 03                	jne    80083b <_main+0x803>
				found++;
  800838:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  80083b:	a1 20 40 80 00       	mov    0x804020,%eax
  800840:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800846:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800849:	89 d0                	mov    %edx,%eax
  80084b:	01 c0                	add    %eax,%eax
  80084d:	01 d0                	add    %edx,%eax
  80084f:	c1 e0 02             	shl    $0x2,%eax
  800852:	01 c8                	add    %ecx,%eax
  800854:	8b 00                	mov    (%eax),%eax
  800856:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  80085c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800862:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800867:	89 c2                	mov    %eax,%edx
  800869:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80086f:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800876:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80087c:	01 c8                	add    %ecx,%eax
  80087e:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800884:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80088a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80088f:	39 c2                	cmp    %eax,%edx
  800891:	75 03                	jne    800896 <_main+0x85e>
				found++;
  800893:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800896:	ff 45 ec             	incl   -0x14(%ebp)
  800899:	a1 20 40 80 00       	mov    0x804020,%eax
  80089e:	8b 50 74             	mov    0x74(%eax),%edx
  8008a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008a4:	39 c2                	cmp    %eax,%edx
  8008a6:	0f 87 43 ff ff ff    	ja     8007ef <_main+0x7b7>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8008ac:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008b0:	74 17                	je     8008c9 <_main+0x891>
  8008b2:	83 ec 04             	sub    $0x4,%esp
  8008b5:	68 cc 2b 80 00       	push   $0x802bcc
  8008ba:	68 92 00 00 00       	push   $0x92
  8008bf:	68 dc 2a 80 00       	push   $0x802adc
  8008c4:	e8 9a 06 00 00       	call   800f63 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008c9:	e8 cf 1a 00 00       	call   80239d <sys_calculate_free_frames>
  8008ce:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008d1:	e8 4a 1b 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  8008d6:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008dc:	89 c2                	mov    %eax,%edx
  8008de:	01 d2                	add    %edx,%edx
  8008e0:	01 d0                	add    %edx,%eax
  8008e2:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008e5:	83 ec 0c             	sub    $0xc,%esp
  8008e8:	50                   	push   %eax
  8008e9:	e8 ed 16 00 00       	call   801fdb <malloc>
  8008ee:	83 c4 10             	add    $0x10,%esp
  8008f1:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8008f7:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  8008fd:	89 c2                	mov    %eax,%edx
  8008ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800902:	c1 e0 02             	shl    $0x2,%eax
  800905:	89 c1                	mov    %eax,%ecx
  800907:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80090a:	c1 e0 04             	shl    $0x4,%eax
  80090d:	01 c8                	add    %ecx,%eax
  80090f:	05 00 00 00 80       	add    $0x80000000,%eax
  800914:	39 c2                	cmp    %eax,%edx
  800916:	72 21                	jb     800939 <_main+0x901>
  800918:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  80091e:	89 c2                	mov    %eax,%edx
  800920:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800923:	c1 e0 02             	shl    $0x2,%eax
  800926:	89 c1                	mov    %eax,%ecx
  800928:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80092b:	c1 e0 04             	shl    $0x4,%eax
  80092e:	01 c8                	add    %ecx,%eax
  800930:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800935:	39 c2                	cmp    %eax,%edx
  800937:	76 17                	jbe    800950 <_main+0x918>
  800939:	83 ec 04             	sub    $0x4,%esp
  80093c:	68 f0 2a 80 00       	push   $0x802af0
  800941:	68 98 00 00 00       	push   $0x98
  800946:	68 dc 2a 80 00       	push   $0x802adc
  80094b:	e8 13 06 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800950:	e8 cb 1a 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800955:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800958:	89 c2                	mov    %eax,%edx
  80095a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80095d:	89 c1                	mov    %eax,%ecx
  80095f:	01 c9                	add    %ecx,%ecx
  800961:	01 c8                	add    %ecx,%eax
  800963:	85 c0                	test   %eax,%eax
  800965:	79 05                	jns    80096c <_main+0x934>
  800967:	05 ff 0f 00 00       	add    $0xfff,%eax
  80096c:	c1 f8 0c             	sar    $0xc,%eax
  80096f:	39 c2                	cmp    %eax,%edx
  800971:	74 17                	je     80098a <_main+0x952>
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	68 58 2b 80 00       	push   $0x802b58
  80097b:	68 99 00 00 00       	push   $0x99
  800980:	68 dc 2a 80 00       	push   $0x802adc
  800985:	e8 d9 05 00 00       	call   800f63 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80098a:	e8 91 1a 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  80098f:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800992:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800995:	89 d0                	mov    %edx,%eax
  800997:	01 c0                	add    %eax,%eax
  800999:	01 d0                	add    %edx,%eax
  80099b:	01 c0                	add    %eax,%eax
  80099d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8009a0:	83 ec 0c             	sub    $0xc,%esp
  8009a3:	50                   	push   %eax
  8009a4:	e8 32 16 00 00       	call   801fdb <malloc>
  8009a9:	83 c4 10             	add    $0x10,%esp
  8009ac:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009b2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  8009b8:	89 c1                	mov    %eax,%ecx
  8009ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009bd:	89 d0                	mov    %edx,%eax
  8009bf:	01 c0                	add    %eax,%eax
  8009c1:	01 d0                	add    %edx,%eax
  8009c3:	01 c0                	add    %eax,%eax
  8009c5:	01 d0                	add    %edx,%eax
  8009c7:	89 c2                	mov    %eax,%edx
  8009c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009cc:	c1 e0 04             	shl    $0x4,%eax
  8009cf:	01 d0                	add    %edx,%eax
  8009d1:	05 00 00 00 80       	add    $0x80000000,%eax
  8009d6:	39 c1                	cmp    %eax,%ecx
  8009d8:	72 28                	jb     800a02 <_main+0x9ca>
  8009da:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  8009e0:	89 c1                	mov    %eax,%ecx
  8009e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009e5:	89 d0                	mov    %edx,%eax
  8009e7:	01 c0                	add    %eax,%eax
  8009e9:	01 d0                	add    %edx,%eax
  8009eb:	01 c0                	add    %eax,%eax
  8009ed:	01 d0                	add    %edx,%eax
  8009ef:	89 c2                	mov    %eax,%edx
  8009f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009f4:	c1 e0 04             	shl    $0x4,%eax
  8009f7:	01 d0                	add    %edx,%eax
  8009f9:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8009fe:	39 c1                	cmp    %eax,%ecx
  800a00:	76 17                	jbe    800a19 <_main+0x9e1>
  800a02:	83 ec 04             	sub    $0x4,%esp
  800a05:	68 f0 2a 80 00       	push   $0x802af0
  800a0a:	68 9f 00 00 00       	push   $0x9f
  800a0f:	68 dc 2a 80 00       	push   $0x802adc
  800a14:	e8 4a 05 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a19:	e8 02 1a 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800a1e:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800a21:	89 c1                	mov    %eax,%ecx
  800a23:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a26:	89 d0                	mov    %edx,%eax
  800a28:	01 c0                	add    %eax,%eax
  800a2a:	01 d0                	add    %edx,%eax
  800a2c:	01 c0                	add    %eax,%eax
  800a2e:	85 c0                	test   %eax,%eax
  800a30:	79 05                	jns    800a37 <_main+0x9ff>
  800a32:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a37:	c1 f8 0c             	sar    $0xc,%eax
  800a3a:	39 c1                	cmp    %eax,%ecx
  800a3c:	74 17                	je     800a55 <_main+0xa1d>
  800a3e:	83 ec 04             	sub    $0x4,%esp
  800a41:	68 58 2b 80 00       	push   $0x802b58
  800a46:	68 a0 00 00 00       	push   $0xa0
  800a4b:	68 dc 2a 80 00       	push   $0x802adc
  800a50:	e8 0e 05 00 00       	call   800f63 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a55:	e8 43 19 00 00       	call   80239d <sys_calculate_free_frames>
  800a5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a5d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a60:	89 d0                	mov    %edx,%eax
  800a62:	01 c0                	add    %eax,%eax
  800a64:	01 d0                	add    %edx,%eax
  800a66:	01 c0                	add    %eax,%eax
  800a68:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a6b:	48                   	dec    %eax
  800a6c:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a72:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800a78:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		byteArr2[0] = minByte ;
  800a7e:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800a84:	8a 55 df             	mov    -0x21(%ebp),%dl
  800a87:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a89:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800a8f:	89 c2                	mov    %eax,%edx
  800a91:	c1 ea 1f             	shr    $0x1f,%edx
  800a94:	01 d0                	add    %edx,%eax
  800a96:	d1 f8                	sar    %eax
  800a98:	89 c2                	mov    %eax,%edx
  800a9a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800aa0:	01 c2                	add    %eax,%edx
  800aa2:	8a 45 de             	mov    -0x22(%ebp),%al
  800aa5:	88 c1                	mov    %al,%cl
  800aa7:	c0 e9 07             	shr    $0x7,%cl
  800aaa:	01 c8                	add    %ecx,%eax
  800aac:	d0 f8                	sar    %al
  800aae:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800ab0:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
  800ab6:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800abc:	01 c2                	add    %eax,%edx
  800abe:	8a 45 de             	mov    -0x22(%ebp),%al
  800ac1:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ac3:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800ac6:	e8 d2 18 00 00       	call   80239d <sys_calculate_free_frames>
  800acb:	29 c3                	sub    %eax,%ebx
  800acd:	89 d8                	mov    %ebx,%eax
  800acf:	83 f8 05             	cmp    $0x5,%eax
  800ad2:	74 17                	je     800aeb <_main+0xab3>
  800ad4:	83 ec 04             	sub    $0x4,%esp
  800ad7:	68 88 2b 80 00       	push   $0x802b88
  800adc:	68 a8 00 00 00       	push   $0xa8
  800ae1:	68 dc 2a 80 00       	push   $0x802adc
  800ae6:	e8 78 04 00 00       	call   800f63 <_panic>
		found = 0;
  800aeb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800af2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800af9:	e9 02 01 00 00       	jmp    800c00 <_main+0xbc8>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800afe:	a1 20 40 80 00       	mov    0x804020,%eax
  800b03:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b09:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b0c:	89 d0                	mov    %edx,%eax
  800b0e:	01 c0                	add    %eax,%eax
  800b10:	01 d0                	add    %edx,%eax
  800b12:	c1 e0 02             	shl    $0x2,%eax
  800b15:	01 c8                	add    %ecx,%eax
  800b17:	8b 00                	mov    (%eax),%eax
  800b19:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800b1f:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b25:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b2a:	89 c2                	mov    %eax,%edx
  800b2c:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b32:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800b38:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b3e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b43:	39 c2                	cmp    %eax,%edx
  800b45:	75 03                	jne    800b4a <_main+0xb12>
				found++;
  800b47:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b4a:	a1 20 40 80 00       	mov    0x804020,%eax
  800b4f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b55:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b58:	89 d0                	mov    %edx,%eax
  800b5a:	01 c0                	add    %eax,%eax
  800b5c:	01 d0                	add    %edx,%eax
  800b5e:	c1 e0 02             	shl    $0x2,%eax
  800b61:	01 c8                	add    %ecx,%eax
  800b63:	8b 00                	mov    (%eax),%eax
  800b65:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b6b:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b71:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b76:	89 c2                	mov    %eax,%edx
  800b78:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800b7e:	89 c1                	mov    %eax,%ecx
  800b80:	c1 e9 1f             	shr    $0x1f,%ecx
  800b83:	01 c8                	add    %ecx,%eax
  800b85:	d1 f8                	sar    %eax
  800b87:	89 c1                	mov    %eax,%ecx
  800b89:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b8f:	01 c8                	add    %ecx,%eax
  800b91:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b97:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ba2:	39 c2                	cmp    %eax,%edx
  800ba4:	75 03                	jne    800ba9 <_main+0xb71>
				found++;
  800ba6:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800ba9:	a1 20 40 80 00       	mov    0x804020,%eax
  800bae:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bb4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bb7:	89 d0                	mov    %edx,%eax
  800bb9:	01 c0                	add    %eax,%eax
  800bbb:	01 d0                	add    %edx,%eax
  800bbd:	c1 e0 02             	shl    $0x2,%eax
  800bc0:	01 c8                	add    %ecx,%eax
  800bc2:	8b 00                	mov    (%eax),%eax
  800bc4:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800bca:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800bd0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bd5:	89 c1                	mov    %eax,%ecx
  800bd7:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
  800bdd:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800be3:	01 d0                	add    %edx,%eax
  800be5:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800beb:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800bf1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bf6:	39 c1                	cmp    %eax,%ecx
  800bf8:	75 03                	jne    800bfd <_main+0xbc5>
				found++;
  800bfa:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800bfd:	ff 45 ec             	incl   -0x14(%ebp)
  800c00:	a1 20 40 80 00       	mov    0x804020,%eax
  800c05:	8b 50 74             	mov    0x74(%eax),%edx
  800c08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c0b:	39 c2                	cmp    %eax,%edx
  800c0d:	0f 87 eb fe ff ff    	ja     800afe <_main+0xac6>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c13:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c17:	74 17                	je     800c30 <_main+0xbf8>
  800c19:	83 ec 04             	sub    $0x4,%esp
  800c1c:	68 cc 2b 80 00       	push   $0x802bcc
  800c21:	68 b3 00 00 00       	push   $0xb3
  800c26:	68 dc 2a 80 00       	push   $0x802adc
  800c2b:	e8 33 03 00 00       	call   800f63 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c30:	e8 eb 17 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800c35:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c38:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c3b:	89 d0                	mov    %edx,%eax
  800c3d:	01 c0                	add    %eax,%eax
  800c3f:	01 d0                	add    %edx,%eax
  800c41:	01 c0                	add    %eax,%eax
  800c43:	01 d0                	add    %edx,%eax
  800c45:	01 c0                	add    %eax,%eax
  800c47:	83 ec 0c             	sub    $0xc,%esp
  800c4a:	50                   	push   %eax
  800c4b:	e8 8b 13 00 00       	call   801fdb <malloc>
  800c50:	83 c4 10             	add    $0x10,%esp
  800c53:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c59:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800c5f:	89 c1                	mov    %eax,%ecx
  800c61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c64:	89 d0                	mov    %edx,%eax
  800c66:	01 c0                	add    %eax,%eax
  800c68:	01 d0                	add    %edx,%eax
  800c6a:	c1 e0 02             	shl    $0x2,%eax
  800c6d:	01 d0                	add    %edx,%eax
  800c6f:	89 c2                	mov    %eax,%edx
  800c71:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c74:	c1 e0 04             	shl    $0x4,%eax
  800c77:	01 d0                	add    %edx,%eax
  800c79:	05 00 00 00 80       	add    $0x80000000,%eax
  800c7e:	39 c1                	cmp    %eax,%ecx
  800c80:	72 29                	jb     800cab <_main+0xc73>
  800c82:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800c88:	89 c1                	mov    %eax,%ecx
  800c8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c8d:	89 d0                	mov    %edx,%eax
  800c8f:	01 c0                	add    %eax,%eax
  800c91:	01 d0                	add    %edx,%eax
  800c93:	c1 e0 02             	shl    $0x2,%eax
  800c96:	01 d0                	add    %edx,%eax
  800c98:	89 c2                	mov    %eax,%edx
  800c9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c9d:	c1 e0 04             	shl    $0x4,%eax
  800ca0:	01 d0                	add    %edx,%eax
  800ca2:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800ca7:	39 c1                	cmp    %eax,%ecx
  800ca9:	76 17                	jbe    800cc2 <_main+0xc8a>
  800cab:	83 ec 04             	sub    $0x4,%esp
  800cae:	68 f0 2a 80 00       	push   $0x802af0
  800cb3:	68 b8 00 00 00       	push   $0xb8
  800cb8:	68 dc 2a 80 00       	push   $0x802adc
  800cbd:	e8 a1 02 00 00       	call   800f63 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc2:	e8 59 17 00 00       	call   802420 <sys_pf_calculate_allocated_pages>
  800cc7:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800cca:	83 f8 04             	cmp    $0x4,%eax
  800ccd:	74 17                	je     800ce6 <_main+0xcae>
  800ccf:	83 ec 04             	sub    $0x4,%esp
  800cd2:	68 58 2b 80 00       	push   $0x802b58
  800cd7:	68 b9 00 00 00       	push   $0xb9
  800cdc:	68 dc 2a 80 00       	push   $0x802adc
  800ce1:	e8 7d 02 00 00       	call   800f63 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800ce6:	e8 b2 16 00 00       	call   80239d <sys_calculate_free_frames>
  800ceb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cee:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800cf4:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800cfa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cfd:	89 d0                	mov    %edx,%eax
  800cff:	01 c0                	add    %eax,%eax
  800d01:	01 d0                	add    %edx,%eax
  800d03:	01 c0                	add    %eax,%eax
  800d05:	01 d0                	add    %edx,%eax
  800d07:	01 c0                	add    %eax,%eax
  800d09:	d1 e8                	shr    %eax
  800d0b:	48                   	dec    %eax
  800d0c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
		shortArr2[0] = minShort;
  800d12:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
  800d18:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d1b:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d1e:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d24:	01 c0                	add    %eax,%eax
  800d26:	89 c2                	mov    %eax,%edx
  800d28:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800d2e:	01 c2                	add    %eax,%edx
  800d30:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800d34:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d37:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800d3a:	e8 5e 16 00 00       	call   80239d <sys_calculate_free_frames>
  800d3f:	29 c3                	sub    %eax,%ebx
  800d41:	89 d8                	mov    %ebx,%eax
  800d43:	83 f8 02             	cmp    $0x2,%eax
  800d46:	74 17                	je     800d5f <_main+0xd27>
  800d48:	83 ec 04             	sub    $0x4,%esp
  800d4b:	68 88 2b 80 00       	push   $0x802b88
  800d50:	68 c0 00 00 00       	push   $0xc0
  800d55:	68 dc 2a 80 00       	push   $0x802adc
  800d5a:	e8 04 02 00 00       	call   800f63 <_panic>
		found = 0;
  800d5f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d66:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d6d:	e9 a7 00 00 00       	jmp    800e19 <_main+0xde1>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d72:	a1 20 40 80 00       	mov    0x804020,%eax
  800d77:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d7d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d80:	89 d0                	mov    %edx,%eax
  800d82:	01 c0                	add    %eax,%eax
  800d84:	01 d0                	add    %edx,%eax
  800d86:	c1 e0 02             	shl    $0x2,%eax
  800d89:	01 c8                	add    %ecx,%eax
  800d8b:	8b 00                	mov    (%eax),%eax
  800d8d:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800d93:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d99:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d9e:	89 c2                	mov    %eax,%edx
  800da0:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800da6:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800dac:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800db7:	39 c2                	cmp    %eax,%edx
  800db9:	75 03                	jne    800dbe <_main+0xd86>
				found++;
  800dbb:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dbe:	a1 20 40 80 00       	mov    0x804020,%eax
  800dc3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800dc9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dcc:	89 d0                	mov    %edx,%eax
  800dce:	01 c0                	add    %eax,%eax
  800dd0:	01 d0                	add    %edx,%eax
  800dd2:	c1 e0 02             	shl    $0x2,%eax
  800dd5:	01 c8                	add    %ecx,%eax
  800dd7:	8b 00                	mov    (%eax),%eax
  800dd9:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800ddf:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800de5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dea:	89 c2                	mov    %eax,%edx
  800dec:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800df2:	01 c0                	add    %eax,%eax
  800df4:	89 c1                	mov    %eax,%ecx
  800df6:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800dfc:	01 c8                	add    %ecx,%eax
  800dfe:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800e04:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800e0a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e0f:	39 c2                	cmp    %eax,%edx
  800e11:	75 03                	jne    800e16 <_main+0xdde>
				found++;
  800e13:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e16:	ff 45 ec             	incl   -0x14(%ebp)
  800e19:	a1 20 40 80 00       	mov    0x804020,%eax
  800e1e:	8b 50 74             	mov    0x74(%eax),%edx
  800e21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e24:	39 c2                	cmp    %eax,%edx
  800e26:	0f 87 46 ff ff ff    	ja     800d72 <_main+0xd3a>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e2c:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e30:	74 17                	je     800e49 <_main+0xe11>
  800e32:	83 ec 04             	sub    $0x4,%esp
  800e35:	68 cc 2b 80 00       	push   $0x802bcc
  800e3a:	68 c9 00 00 00       	push   $0xc9
  800e3f:	68 dc 2a 80 00       	push   $0x802adc
  800e44:	e8 1a 01 00 00       	call   800f63 <_panic>
	}

	cprintf("Congratulations!! test malloc [3] completed successfully.\n");
  800e49:	83 ec 0c             	sub    $0xc,%esp
  800e4c:	68 ec 2b 80 00       	push   $0x802bec
  800e51:	e8 c1 03 00 00       	call   801217 <cprintf>
  800e56:	83 c4 10             	add    $0x10,%esp

	return;
  800e59:	90                   	nop
}
  800e5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e5d:	5b                   	pop    %ebx
  800e5e:	5f                   	pop    %edi
  800e5f:	5d                   	pop    %ebp
  800e60:	c3                   	ret    

00800e61 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800e61:	55                   	push   %ebp
  800e62:	89 e5                	mov    %esp,%ebp
  800e64:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800e67:	e8 66 14 00 00       	call   8022d2 <sys_getenvindex>
  800e6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800e6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e72:	89 d0                	mov    %edx,%eax
  800e74:	01 c0                	add    %eax,%eax
  800e76:	01 d0                	add    %edx,%eax
  800e78:	c1 e0 02             	shl    $0x2,%eax
  800e7b:	01 d0                	add    %edx,%eax
  800e7d:	c1 e0 06             	shl    $0x6,%eax
  800e80:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800e85:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800e8a:	a1 20 40 80 00       	mov    0x804020,%eax
  800e8f:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800e95:	84 c0                	test   %al,%al
  800e97:	74 0f                	je     800ea8 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800e99:	a1 20 40 80 00       	mov    0x804020,%eax
  800e9e:	05 f4 02 00 00       	add    $0x2f4,%eax
  800ea3:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800ea8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800eac:	7e 0a                	jle    800eb8 <libmain+0x57>
		binaryname = argv[0];
  800eae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb1:	8b 00                	mov    (%eax),%eax
  800eb3:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800eb8:	83 ec 08             	sub    $0x8,%esp
  800ebb:	ff 75 0c             	pushl  0xc(%ebp)
  800ebe:	ff 75 08             	pushl  0x8(%ebp)
  800ec1:	e8 72 f1 ff ff       	call   800038 <_main>
  800ec6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800ec9:	e8 9f 15 00 00       	call   80246d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800ece:	83 ec 0c             	sub    $0xc,%esp
  800ed1:	68 40 2c 80 00       	push   $0x802c40
  800ed6:	e8 3c 03 00 00       	call   801217 <cprintf>
  800edb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800ede:	a1 20 40 80 00       	mov    0x804020,%eax
  800ee3:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800ee9:	a1 20 40 80 00       	mov    0x804020,%eax
  800eee:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800ef4:	83 ec 04             	sub    $0x4,%esp
  800ef7:	52                   	push   %edx
  800ef8:	50                   	push   %eax
  800ef9:	68 68 2c 80 00       	push   $0x802c68
  800efe:	e8 14 03 00 00       	call   801217 <cprintf>
  800f03:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800f06:	a1 20 40 80 00       	mov    0x804020,%eax
  800f0b:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800f11:	83 ec 08             	sub    $0x8,%esp
  800f14:	50                   	push   %eax
  800f15:	68 8d 2c 80 00       	push   $0x802c8d
  800f1a:	e8 f8 02 00 00       	call   801217 <cprintf>
  800f1f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800f22:	83 ec 0c             	sub    $0xc,%esp
  800f25:	68 40 2c 80 00       	push   $0x802c40
  800f2a:	e8 e8 02 00 00       	call   801217 <cprintf>
  800f2f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800f32:	e8 50 15 00 00       	call   802487 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800f37:	e8 19 00 00 00       	call   800f55 <exit>
}
  800f3c:	90                   	nop
  800f3d:	c9                   	leave  
  800f3e:	c3                   	ret    

00800f3f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800f3f:	55                   	push   %ebp
  800f40:	89 e5                	mov    %esp,%ebp
  800f42:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800f45:	83 ec 0c             	sub    $0xc,%esp
  800f48:	6a 00                	push   $0x0
  800f4a:	e8 4f 13 00 00       	call   80229e <sys_env_destroy>
  800f4f:	83 c4 10             	add    $0x10,%esp
}
  800f52:	90                   	nop
  800f53:	c9                   	leave  
  800f54:	c3                   	ret    

00800f55 <exit>:

void
exit(void)
{
  800f55:	55                   	push   %ebp
  800f56:	89 e5                	mov    %esp,%ebp
  800f58:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800f5b:	e8 a4 13 00 00       	call   802304 <sys_env_exit>
}
  800f60:	90                   	nop
  800f61:	c9                   	leave  
  800f62:	c3                   	ret    

00800f63 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800f63:	55                   	push   %ebp
  800f64:	89 e5                	mov    %esp,%ebp
  800f66:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800f69:	8d 45 10             	lea    0x10(%ebp),%eax
  800f6c:	83 c0 04             	add    $0x4,%eax
  800f6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800f72:	a1 30 40 80 00       	mov    0x804030,%eax
  800f77:	85 c0                	test   %eax,%eax
  800f79:	74 16                	je     800f91 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800f7b:	a1 30 40 80 00       	mov    0x804030,%eax
  800f80:	83 ec 08             	sub    $0x8,%esp
  800f83:	50                   	push   %eax
  800f84:	68 a4 2c 80 00       	push   $0x802ca4
  800f89:	e8 89 02 00 00       	call   801217 <cprintf>
  800f8e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800f91:	a1 00 40 80 00       	mov    0x804000,%eax
  800f96:	ff 75 0c             	pushl  0xc(%ebp)
  800f99:	ff 75 08             	pushl  0x8(%ebp)
  800f9c:	50                   	push   %eax
  800f9d:	68 a9 2c 80 00       	push   $0x802ca9
  800fa2:	e8 70 02 00 00       	call   801217 <cprintf>
  800fa7:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800faa:	8b 45 10             	mov    0x10(%ebp),%eax
  800fad:	83 ec 08             	sub    $0x8,%esp
  800fb0:	ff 75 f4             	pushl  -0xc(%ebp)
  800fb3:	50                   	push   %eax
  800fb4:	e8 f3 01 00 00       	call   8011ac <vcprintf>
  800fb9:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800fbc:	83 ec 08             	sub    $0x8,%esp
  800fbf:	6a 00                	push   $0x0
  800fc1:	68 c5 2c 80 00       	push   $0x802cc5
  800fc6:	e8 e1 01 00 00       	call   8011ac <vcprintf>
  800fcb:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800fce:	e8 82 ff ff ff       	call   800f55 <exit>

	// should not return here
	while (1) ;
  800fd3:	eb fe                	jmp    800fd3 <_panic+0x70>

00800fd5 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800fd5:	55                   	push   %ebp
  800fd6:	89 e5                	mov    %esp,%ebp
  800fd8:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800fdb:	a1 20 40 80 00       	mov    0x804020,%eax
  800fe0:	8b 50 74             	mov    0x74(%eax),%edx
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	39 c2                	cmp    %eax,%edx
  800fe8:	74 14                	je     800ffe <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800fea:	83 ec 04             	sub    $0x4,%esp
  800fed:	68 c8 2c 80 00       	push   $0x802cc8
  800ff2:	6a 26                	push   $0x26
  800ff4:	68 14 2d 80 00       	push   $0x802d14
  800ff9:	e8 65 ff ff ff       	call   800f63 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800ffe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801005:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80100c:	e9 c2 00 00 00       	jmp    8010d3 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801011:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801014:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	01 d0                	add    %edx,%eax
  801020:	8b 00                	mov    (%eax),%eax
  801022:	85 c0                	test   %eax,%eax
  801024:	75 08                	jne    80102e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801026:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801029:	e9 a2 00 00 00       	jmp    8010d0 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80102e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801035:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80103c:	eb 69                	jmp    8010a7 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80103e:	a1 20 40 80 00       	mov    0x804020,%eax
  801043:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801049:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80104c:	89 d0                	mov    %edx,%eax
  80104e:	01 c0                	add    %eax,%eax
  801050:	01 d0                	add    %edx,%eax
  801052:	c1 e0 02             	shl    $0x2,%eax
  801055:	01 c8                	add    %ecx,%eax
  801057:	8a 40 04             	mov    0x4(%eax),%al
  80105a:	84 c0                	test   %al,%al
  80105c:	75 46                	jne    8010a4 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80105e:	a1 20 40 80 00       	mov    0x804020,%eax
  801063:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801069:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80106c:	89 d0                	mov    %edx,%eax
  80106e:	01 c0                	add    %eax,%eax
  801070:	01 d0                	add    %edx,%eax
  801072:	c1 e0 02             	shl    $0x2,%eax
  801075:	01 c8                	add    %ecx,%eax
  801077:	8b 00                	mov    (%eax),%eax
  801079:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80107c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80107f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801084:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801086:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801089:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	01 c8                	add    %ecx,%eax
  801095:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801097:	39 c2                	cmp    %eax,%edx
  801099:	75 09                	jne    8010a4 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80109b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8010a2:	eb 12                	jmp    8010b6 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8010a4:	ff 45 e8             	incl   -0x18(%ebp)
  8010a7:	a1 20 40 80 00       	mov    0x804020,%eax
  8010ac:	8b 50 74             	mov    0x74(%eax),%edx
  8010af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010b2:	39 c2                	cmp    %eax,%edx
  8010b4:	77 88                	ja     80103e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8010b6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010ba:	75 14                	jne    8010d0 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8010bc:	83 ec 04             	sub    $0x4,%esp
  8010bf:	68 20 2d 80 00       	push   $0x802d20
  8010c4:	6a 3a                	push   $0x3a
  8010c6:	68 14 2d 80 00       	push   $0x802d14
  8010cb:	e8 93 fe ff ff       	call   800f63 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8010d0:	ff 45 f0             	incl   -0x10(%ebp)
  8010d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010d6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8010d9:	0f 8c 32 ff ff ff    	jl     801011 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8010df:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8010e6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8010ed:	eb 26                	jmp    801115 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8010ef:	a1 20 40 80 00       	mov    0x804020,%eax
  8010f4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8010fa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8010fd:	89 d0                	mov    %edx,%eax
  8010ff:	01 c0                	add    %eax,%eax
  801101:	01 d0                	add    %edx,%eax
  801103:	c1 e0 02             	shl    $0x2,%eax
  801106:	01 c8                	add    %ecx,%eax
  801108:	8a 40 04             	mov    0x4(%eax),%al
  80110b:	3c 01                	cmp    $0x1,%al
  80110d:	75 03                	jne    801112 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80110f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801112:	ff 45 e0             	incl   -0x20(%ebp)
  801115:	a1 20 40 80 00       	mov    0x804020,%eax
  80111a:	8b 50 74             	mov    0x74(%eax),%edx
  80111d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801120:	39 c2                	cmp    %eax,%edx
  801122:	77 cb                	ja     8010ef <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801124:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801127:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80112a:	74 14                	je     801140 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80112c:	83 ec 04             	sub    $0x4,%esp
  80112f:	68 74 2d 80 00       	push   $0x802d74
  801134:	6a 44                	push   $0x44
  801136:	68 14 2d 80 00       	push   $0x802d14
  80113b:	e8 23 fe ff ff       	call   800f63 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801140:	90                   	nop
  801141:	c9                   	leave  
  801142:	c3                   	ret    

00801143 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801143:	55                   	push   %ebp
  801144:	89 e5                	mov    %esp,%ebp
  801146:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801149:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114c:	8b 00                	mov    (%eax),%eax
  80114e:	8d 48 01             	lea    0x1(%eax),%ecx
  801151:	8b 55 0c             	mov    0xc(%ebp),%edx
  801154:	89 0a                	mov    %ecx,(%edx)
  801156:	8b 55 08             	mov    0x8(%ebp),%edx
  801159:	88 d1                	mov    %dl,%cl
  80115b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80115e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801162:	8b 45 0c             	mov    0xc(%ebp),%eax
  801165:	8b 00                	mov    (%eax),%eax
  801167:	3d ff 00 00 00       	cmp    $0xff,%eax
  80116c:	75 2c                	jne    80119a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80116e:	a0 24 40 80 00       	mov    0x804024,%al
  801173:	0f b6 c0             	movzbl %al,%eax
  801176:	8b 55 0c             	mov    0xc(%ebp),%edx
  801179:	8b 12                	mov    (%edx),%edx
  80117b:	89 d1                	mov    %edx,%ecx
  80117d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801180:	83 c2 08             	add    $0x8,%edx
  801183:	83 ec 04             	sub    $0x4,%esp
  801186:	50                   	push   %eax
  801187:	51                   	push   %ecx
  801188:	52                   	push   %edx
  801189:	e8 ce 10 00 00       	call   80225c <sys_cputs>
  80118e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80119a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119d:	8b 40 04             	mov    0x4(%eax),%eax
  8011a0:	8d 50 01             	lea    0x1(%eax),%edx
  8011a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a6:	89 50 04             	mov    %edx,0x4(%eax)
}
  8011a9:	90                   	nop
  8011aa:	c9                   	leave  
  8011ab:	c3                   	ret    

008011ac <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8011ac:	55                   	push   %ebp
  8011ad:	89 e5                	mov    %esp,%ebp
  8011af:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8011b5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8011bc:	00 00 00 
	b.cnt = 0;
  8011bf:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8011c6:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8011c9:	ff 75 0c             	pushl  0xc(%ebp)
  8011cc:	ff 75 08             	pushl  0x8(%ebp)
  8011cf:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8011d5:	50                   	push   %eax
  8011d6:	68 43 11 80 00       	push   $0x801143
  8011db:	e8 11 02 00 00       	call   8013f1 <vprintfmt>
  8011e0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8011e3:	a0 24 40 80 00       	mov    0x804024,%al
  8011e8:	0f b6 c0             	movzbl %al,%eax
  8011eb:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8011f1:	83 ec 04             	sub    $0x4,%esp
  8011f4:	50                   	push   %eax
  8011f5:	52                   	push   %edx
  8011f6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8011fc:	83 c0 08             	add    $0x8,%eax
  8011ff:	50                   	push   %eax
  801200:	e8 57 10 00 00       	call   80225c <sys_cputs>
  801205:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801208:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80120f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <cprintf>:

int cprintf(const char *fmt, ...) {
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
  80121a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80121d:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801224:	8d 45 0c             	lea    0xc(%ebp),%eax
  801227:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	83 ec 08             	sub    $0x8,%esp
  801230:	ff 75 f4             	pushl  -0xc(%ebp)
  801233:	50                   	push   %eax
  801234:	e8 73 ff ff ff       	call   8011ac <vcprintf>
  801239:	83 c4 10             	add    $0x10,%esp
  80123c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80123f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801242:	c9                   	leave  
  801243:	c3                   	ret    

00801244 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801244:	55                   	push   %ebp
  801245:	89 e5                	mov    %esp,%ebp
  801247:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80124a:	e8 1e 12 00 00       	call   80246d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80124f:	8d 45 0c             	lea    0xc(%ebp),%eax
  801252:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	83 ec 08             	sub    $0x8,%esp
  80125b:	ff 75 f4             	pushl  -0xc(%ebp)
  80125e:	50                   	push   %eax
  80125f:	e8 48 ff ff ff       	call   8011ac <vcprintf>
  801264:	83 c4 10             	add    $0x10,%esp
  801267:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80126a:	e8 18 12 00 00       	call   802487 <sys_enable_interrupt>
	return cnt;
  80126f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801272:	c9                   	leave  
  801273:	c3                   	ret    

00801274 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801274:	55                   	push   %ebp
  801275:	89 e5                	mov    %esp,%ebp
  801277:	53                   	push   %ebx
  801278:	83 ec 14             	sub    $0x14,%esp
  80127b:	8b 45 10             	mov    0x10(%ebp),%eax
  80127e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801281:	8b 45 14             	mov    0x14(%ebp),%eax
  801284:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801287:	8b 45 18             	mov    0x18(%ebp),%eax
  80128a:	ba 00 00 00 00       	mov    $0x0,%edx
  80128f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801292:	77 55                	ja     8012e9 <printnum+0x75>
  801294:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801297:	72 05                	jb     80129e <printnum+0x2a>
  801299:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129c:	77 4b                	ja     8012e9 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80129e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8012a1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8012a4:	8b 45 18             	mov    0x18(%ebp),%eax
  8012a7:	ba 00 00 00 00       	mov    $0x0,%edx
  8012ac:	52                   	push   %edx
  8012ad:	50                   	push   %eax
  8012ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8012b1:	ff 75 f0             	pushl  -0x10(%ebp)
  8012b4:	e8 93 15 00 00       	call   80284c <__udivdi3>
  8012b9:	83 c4 10             	add    $0x10,%esp
  8012bc:	83 ec 04             	sub    $0x4,%esp
  8012bf:	ff 75 20             	pushl  0x20(%ebp)
  8012c2:	53                   	push   %ebx
  8012c3:	ff 75 18             	pushl  0x18(%ebp)
  8012c6:	52                   	push   %edx
  8012c7:	50                   	push   %eax
  8012c8:	ff 75 0c             	pushl  0xc(%ebp)
  8012cb:	ff 75 08             	pushl  0x8(%ebp)
  8012ce:	e8 a1 ff ff ff       	call   801274 <printnum>
  8012d3:	83 c4 20             	add    $0x20,%esp
  8012d6:	eb 1a                	jmp    8012f2 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8012d8:	83 ec 08             	sub    $0x8,%esp
  8012db:	ff 75 0c             	pushl  0xc(%ebp)
  8012de:	ff 75 20             	pushl  0x20(%ebp)
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	ff d0                	call   *%eax
  8012e6:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8012e9:	ff 4d 1c             	decl   0x1c(%ebp)
  8012ec:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8012f0:	7f e6                	jg     8012d8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8012f2:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8012f5:	bb 00 00 00 00       	mov    $0x0,%ebx
  8012fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801300:	53                   	push   %ebx
  801301:	51                   	push   %ecx
  801302:	52                   	push   %edx
  801303:	50                   	push   %eax
  801304:	e8 53 16 00 00       	call   80295c <__umoddi3>
  801309:	83 c4 10             	add    $0x10,%esp
  80130c:	05 d4 2f 80 00       	add    $0x802fd4,%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	0f be c0             	movsbl %al,%eax
  801316:	83 ec 08             	sub    $0x8,%esp
  801319:	ff 75 0c             	pushl  0xc(%ebp)
  80131c:	50                   	push   %eax
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	ff d0                	call   *%eax
  801322:	83 c4 10             	add    $0x10,%esp
}
  801325:	90                   	nop
  801326:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80132e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801332:	7e 1c                	jle    801350 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	8b 00                	mov    (%eax),%eax
  801339:	8d 50 08             	lea    0x8(%eax),%edx
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	89 10                	mov    %edx,(%eax)
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8b 00                	mov    (%eax),%eax
  801346:	83 e8 08             	sub    $0x8,%eax
  801349:	8b 50 04             	mov    0x4(%eax),%edx
  80134c:	8b 00                	mov    (%eax),%eax
  80134e:	eb 40                	jmp    801390 <getuint+0x65>
	else if (lflag)
  801350:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801354:	74 1e                	je     801374 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	8b 00                	mov    (%eax),%eax
  80135b:	8d 50 04             	lea    0x4(%eax),%edx
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	89 10                	mov    %edx,(%eax)
  801363:	8b 45 08             	mov    0x8(%ebp),%eax
  801366:	8b 00                	mov    (%eax),%eax
  801368:	83 e8 04             	sub    $0x4,%eax
  80136b:	8b 00                	mov    (%eax),%eax
  80136d:	ba 00 00 00 00       	mov    $0x0,%edx
  801372:	eb 1c                	jmp    801390 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8b 00                	mov    (%eax),%eax
  801379:	8d 50 04             	lea    0x4(%eax),%edx
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	89 10                	mov    %edx,(%eax)
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8b 00                	mov    (%eax),%eax
  801386:	83 e8 04             	sub    $0x4,%eax
  801389:	8b 00                	mov    (%eax),%eax
  80138b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801390:	5d                   	pop    %ebp
  801391:	c3                   	ret    

00801392 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801395:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801399:	7e 1c                	jle    8013b7 <getint+0x25>
		return va_arg(*ap, long long);
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	8b 00                	mov    (%eax),%eax
  8013a0:	8d 50 08             	lea    0x8(%eax),%edx
  8013a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a6:	89 10                	mov    %edx,(%eax)
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	8b 00                	mov    (%eax),%eax
  8013ad:	83 e8 08             	sub    $0x8,%eax
  8013b0:	8b 50 04             	mov    0x4(%eax),%edx
  8013b3:	8b 00                	mov    (%eax),%eax
  8013b5:	eb 38                	jmp    8013ef <getint+0x5d>
	else if (lflag)
  8013b7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013bb:	74 1a                	je     8013d7 <getint+0x45>
		return va_arg(*ap, long);
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	8b 00                	mov    (%eax),%eax
  8013c2:	8d 50 04             	lea    0x4(%eax),%edx
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	89 10                	mov    %edx,(%eax)
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8b 00                	mov    (%eax),%eax
  8013cf:	83 e8 04             	sub    $0x4,%eax
  8013d2:	8b 00                	mov    (%eax),%eax
  8013d4:	99                   	cltd   
  8013d5:	eb 18                	jmp    8013ef <getint+0x5d>
	else
		return va_arg(*ap, int);
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8b 00                	mov    (%eax),%eax
  8013dc:	8d 50 04             	lea    0x4(%eax),%edx
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	89 10                	mov    %edx,(%eax)
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	8b 00                	mov    (%eax),%eax
  8013e9:	83 e8 04             	sub    $0x4,%eax
  8013ec:	8b 00                	mov    (%eax),%eax
  8013ee:	99                   	cltd   
}
  8013ef:	5d                   	pop    %ebp
  8013f0:	c3                   	ret    

008013f1 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
  8013f4:	56                   	push   %esi
  8013f5:	53                   	push   %ebx
  8013f6:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8013f9:	eb 17                	jmp    801412 <vprintfmt+0x21>
			if (ch == '\0')
  8013fb:	85 db                	test   %ebx,%ebx
  8013fd:	0f 84 af 03 00 00    	je     8017b2 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801403:	83 ec 08             	sub    $0x8,%esp
  801406:	ff 75 0c             	pushl  0xc(%ebp)
  801409:	53                   	push   %ebx
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	ff d0                	call   *%eax
  80140f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801412:	8b 45 10             	mov    0x10(%ebp),%eax
  801415:	8d 50 01             	lea    0x1(%eax),%edx
  801418:	89 55 10             	mov    %edx,0x10(%ebp)
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	0f b6 d8             	movzbl %al,%ebx
  801420:	83 fb 25             	cmp    $0x25,%ebx
  801423:	75 d6                	jne    8013fb <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801425:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801429:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801430:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801437:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80143e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801445:	8b 45 10             	mov    0x10(%ebp),%eax
  801448:	8d 50 01             	lea    0x1(%eax),%edx
  80144b:	89 55 10             	mov    %edx,0x10(%ebp)
  80144e:	8a 00                	mov    (%eax),%al
  801450:	0f b6 d8             	movzbl %al,%ebx
  801453:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801456:	83 f8 55             	cmp    $0x55,%eax
  801459:	0f 87 2b 03 00 00    	ja     80178a <vprintfmt+0x399>
  80145f:	8b 04 85 f8 2f 80 00 	mov    0x802ff8(,%eax,4),%eax
  801466:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801468:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80146c:	eb d7                	jmp    801445 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80146e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801472:	eb d1                	jmp    801445 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801474:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80147b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80147e:	89 d0                	mov    %edx,%eax
  801480:	c1 e0 02             	shl    $0x2,%eax
  801483:	01 d0                	add    %edx,%eax
  801485:	01 c0                	add    %eax,%eax
  801487:	01 d8                	add    %ebx,%eax
  801489:	83 e8 30             	sub    $0x30,%eax
  80148c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80148f:	8b 45 10             	mov    0x10(%ebp),%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801497:	83 fb 2f             	cmp    $0x2f,%ebx
  80149a:	7e 3e                	jle    8014da <vprintfmt+0xe9>
  80149c:	83 fb 39             	cmp    $0x39,%ebx
  80149f:	7f 39                	jg     8014da <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8014a1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8014a4:	eb d5                	jmp    80147b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8014a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a9:	83 c0 04             	add    $0x4,%eax
  8014ac:	89 45 14             	mov    %eax,0x14(%ebp)
  8014af:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b2:	83 e8 04             	sub    $0x4,%eax
  8014b5:	8b 00                	mov    (%eax),%eax
  8014b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8014ba:	eb 1f                	jmp    8014db <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8014bc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014c0:	79 83                	jns    801445 <vprintfmt+0x54>
				width = 0;
  8014c2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8014c9:	e9 77 ff ff ff       	jmp    801445 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8014ce:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8014d5:	e9 6b ff ff ff       	jmp    801445 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8014da:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8014db:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014df:	0f 89 60 ff ff ff    	jns    801445 <vprintfmt+0x54>
				width = precision, precision = -1;
  8014e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8014eb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8014f2:	e9 4e ff ff ff       	jmp    801445 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8014f7:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8014fa:	e9 46 ff ff ff       	jmp    801445 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8014ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801502:	83 c0 04             	add    $0x4,%eax
  801505:	89 45 14             	mov    %eax,0x14(%ebp)
  801508:	8b 45 14             	mov    0x14(%ebp),%eax
  80150b:	83 e8 04             	sub    $0x4,%eax
  80150e:	8b 00                	mov    (%eax),%eax
  801510:	83 ec 08             	sub    $0x8,%esp
  801513:	ff 75 0c             	pushl  0xc(%ebp)
  801516:	50                   	push   %eax
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	ff d0                	call   *%eax
  80151c:	83 c4 10             	add    $0x10,%esp
			break;
  80151f:	e9 89 02 00 00       	jmp    8017ad <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801524:	8b 45 14             	mov    0x14(%ebp),%eax
  801527:	83 c0 04             	add    $0x4,%eax
  80152a:	89 45 14             	mov    %eax,0x14(%ebp)
  80152d:	8b 45 14             	mov    0x14(%ebp),%eax
  801530:	83 e8 04             	sub    $0x4,%eax
  801533:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801535:	85 db                	test   %ebx,%ebx
  801537:	79 02                	jns    80153b <vprintfmt+0x14a>
				err = -err;
  801539:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80153b:	83 fb 64             	cmp    $0x64,%ebx
  80153e:	7f 0b                	jg     80154b <vprintfmt+0x15a>
  801540:	8b 34 9d 40 2e 80 00 	mov    0x802e40(,%ebx,4),%esi
  801547:	85 f6                	test   %esi,%esi
  801549:	75 19                	jne    801564 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80154b:	53                   	push   %ebx
  80154c:	68 e5 2f 80 00       	push   $0x802fe5
  801551:	ff 75 0c             	pushl  0xc(%ebp)
  801554:	ff 75 08             	pushl  0x8(%ebp)
  801557:	e8 5e 02 00 00       	call   8017ba <printfmt>
  80155c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80155f:	e9 49 02 00 00       	jmp    8017ad <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801564:	56                   	push   %esi
  801565:	68 ee 2f 80 00       	push   $0x802fee
  80156a:	ff 75 0c             	pushl  0xc(%ebp)
  80156d:	ff 75 08             	pushl  0x8(%ebp)
  801570:	e8 45 02 00 00       	call   8017ba <printfmt>
  801575:	83 c4 10             	add    $0x10,%esp
			break;
  801578:	e9 30 02 00 00       	jmp    8017ad <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80157d:	8b 45 14             	mov    0x14(%ebp),%eax
  801580:	83 c0 04             	add    $0x4,%eax
  801583:	89 45 14             	mov    %eax,0x14(%ebp)
  801586:	8b 45 14             	mov    0x14(%ebp),%eax
  801589:	83 e8 04             	sub    $0x4,%eax
  80158c:	8b 30                	mov    (%eax),%esi
  80158e:	85 f6                	test   %esi,%esi
  801590:	75 05                	jne    801597 <vprintfmt+0x1a6>
				p = "(null)";
  801592:	be f1 2f 80 00       	mov    $0x802ff1,%esi
			if (width > 0 && padc != '-')
  801597:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80159b:	7e 6d                	jle    80160a <vprintfmt+0x219>
  80159d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8015a1:	74 67                	je     80160a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8015a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015a6:	83 ec 08             	sub    $0x8,%esp
  8015a9:	50                   	push   %eax
  8015aa:	56                   	push   %esi
  8015ab:	e8 0c 03 00 00       	call   8018bc <strnlen>
  8015b0:	83 c4 10             	add    $0x10,%esp
  8015b3:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8015b6:	eb 16                	jmp    8015ce <vprintfmt+0x1dd>
					putch(padc, putdat);
  8015b8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8015bc:	83 ec 08             	sub    $0x8,%esp
  8015bf:	ff 75 0c             	pushl  0xc(%ebp)
  8015c2:	50                   	push   %eax
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	ff d0                	call   *%eax
  8015c8:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8015cb:	ff 4d e4             	decl   -0x1c(%ebp)
  8015ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015d2:	7f e4                	jg     8015b8 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8015d4:	eb 34                	jmp    80160a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8015d6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8015da:	74 1c                	je     8015f8 <vprintfmt+0x207>
  8015dc:	83 fb 1f             	cmp    $0x1f,%ebx
  8015df:	7e 05                	jle    8015e6 <vprintfmt+0x1f5>
  8015e1:	83 fb 7e             	cmp    $0x7e,%ebx
  8015e4:	7e 12                	jle    8015f8 <vprintfmt+0x207>
					putch('?', putdat);
  8015e6:	83 ec 08             	sub    $0x8,%esp
  8015e9:	ff 75 0c             	pushl  0xc(%ebp)
  8015ec:	6a 3f                	push   $0x3f
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f1:	ff d0                	call   *%eax
  8015f3:	83 c4 10             	add    $0x10,%esp
  8015f6:	eb 0f                	jmp    801607 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8015f8:	83 ec 08             	sub    $0x8,%esp
  8015fb:	ff 75 0c             	pushl  0xc(%ebp)
  8015fe:	53                   	push   %ebx
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	ff d0                	call   *%eax
  801604:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801607:	ff 4d e4             	decl   -0x1c(%ebp)
  80160a:	89 f0                	mov    %esi,%eax
  80160c:	8d 70 01             	lea    0x1(%eax),%esi
  80160f:	8a 00                	mov    (%eax),%al
  801611:	0f be d8             	movsbl %al,%ebx
  801614:	85 db                	test   %ebx,%ebx
  801616:	74 24                	je     80163c <vprintfmt+0x24b>
  801618:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80161c:	78 b8                	js     8015d6 <vprintfmt+0x1e5>
  80161e:	ff 4d e0             	decl   -0x20(%ebp)
  801621:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801625:	79 af                	jns    8015d6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801627:	eb 13                	jmp    80163c <vprintfmt+0x24b>
				putch(' ', putdat);
  801629:	83 ec 08             	sub    $0x8,%esp
  80162c:	ff 75 0c             	pushl  0xc(%ebp)
  80162f:	6a 20                	push   $0x20
  801631:	8b 45 08             	mov    0x8(%ebp),%eax
  801634:	ff d0                	call   *%eax
  801636:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801639:	ff 4d e4             	decl   -0x1c(%ebp)
  80163c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801640:	7f e7                	jg     801629 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801642:	e9 66 01 00 00       	jmp    8017ad <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801647:	83 ec 08             	sub    $0x8,%esp
  80164a:	ff 75 e8             	pushl  -0x18(%ebp)
  80164d:	8d 45 14             	lea    0x14(%ebp),%eax
  801650:	50                   	push   %eax
  801651:	e8 3c fd ff ff       	call   801392 <getint>
  801656:	83 c4 10             	add    $0x10,%esp
  801659:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80165c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80165f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801662:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801665:	85 d2                	test   %edx,%edx
  801667:	79 23                	jns    80168c <vprintfmt+0x29b>
				putch('-', putdat);
  801669:	83 ec 08             	sub    $0x8,%esp
  80166c:	ff 75 0c             	pushl  0xc(%ebp)
  80166f:	6a 2d                	push   $0x2d
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	ff d0                	call   *%eax
  801676:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801679:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80167c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80167f:	f7 d8                	neg    %eax
  801681:	83 d2 00             	adc    $0x0,%edx
  801684:	f7 da                	neg    %edx
  801686:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801689:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80168c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801693:	e9 bc 00 00 00       	jmp    801754 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801698:	83 ec 08             	sub    $0x8,%esp
  80169b:	ff 75 e8             	pushl  -0x18(%ebp)
  80169e:	8d 45 14             	lea    0x14(%ebp),%eax
  8016a1:	50                   	push   %eax
  8016a2:	e8 84 fc ff ff       	call   80132b <getuint>
  8016a7:	83 c4 10             	add    $0x10,%esp
  8016aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8016b0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8016b7:	e9 98 00 00 00       	jmp    801754 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8016bc:	83 ec 08             	sub    $0x8,%esp
  8016bf:	ff 75 0c             	pushl  0xc(%ebp)
  8016c2:	6a 58                	push   $0x58
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	ff d0                	call   *%eax
  8016c9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8016cc:	83 ec 08             	sub    $0x8,%esp
  8016cf:	ff 75 0c             	pushl  0xc(%ebp)
  8016d2:	6a 58                	push   $0x58
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	ff d0                	call   *%eax
  8016d9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8016dc:	83 ec 08             	sub    $0x8,%esp
  8016df:	ff 75 0c             	pushl  0xc(%ebp)
  8016e2:	6a 58                	push   $0x58
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	ff d0                	call   *%eax
  8016e9:	83 c4 10             	add    $0x10,%esp
			break;
  8016ec:	e9 bc 00 00 00       	jmp    8017ad <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8016f1:	83 ec 08             	sub    $0x8,%esp
  8016f4:	ff 75 0c             	pushl  0xc(%ebp)
  8016f7:	6a 30                	push   $0x30
  8016f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fc:	ff d0                	call   *%eax
  8016fe:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801701:	83 ec 08             	sub    $0x8,%esp
  801704:	ff 75 0c             	pushl  0xc(%ebp)
  801707:	6a 78                	push   $0x78
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	ff d0                	call   *%eax
  80170e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801711:	8b 45 14             	mov    0x14(%ebp),%eax
  801714:	83 c0 04             	add    $0x4,%eax
  801717:	89 45 14             	mov    %eax,0x14(%ebp)
  80171a:	8b 45 14             	mov    0x14(%ebp),%eax
  80171d:	83 e8 04             	sub    $0x4,%eax
  801720:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801722:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801725:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80172c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801733:	eb 1f                	jmp    801754 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801735:	83 ec 08             	sub    $0x8,%esp
  801738:	ff 75 e8             	pushl  -0x18(%ebp)
  80173b:	8d 45 14             	lea    0x14(%ebp),%eax
  80173e:	50                   	push   %eax
  80173f:	e8 e7 fb ff ff       	call   80132b <getuint>
  801744:	83 c4 10             	add    $0x10,%esp
  801747:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80174a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80174d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801754:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801758:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80175b:	83 ec 04             	sub    $0x4,%esp
  80175e:	52                   	push   %edx
  80175f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801762:	50                   	push   %eax
  801763:	ff 75 f4             	pushl  -0xc(%ebp)
  801766:	ff 75 f0             	pushl  -0x10(%ebp)
  801769:	ff 75 0c             	pushl  0xc(%ebp)
  80176c:	ff 75 08             	pushl  0x8(%ebp)
  80176f:	e8 00 fb ff ff       	call   801274 <printnum>
  801774:	83 c4 20             	add    $0x20,%esp
			break;
  801777:	eb 34                	jmp    8017ad <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801779:	83 ec 08             	sub    $0x8,%esp
  80177c:	ff 75 0c             	pushl  0xc(%ebp)
  80177f:	53                   	push   %ebx
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	ff d0                	call   *%eax
  801785:	83 c4 10             	add    $0x10,%esp
			break;
  801788:	eb 23                	jmp    8017ad <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80178a:	83 ec 08             	sub    $0x8,%esp
  80178d:	ff 75 0c             	pushl  0xc(%ebp)
  801790:	6a 25                	push   $0x25
  801792:	8b 45 08             	mov    0x8(%ebp),%eax
  801795:	ff d0                	call   *%eax
  801797:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80179a:	ff 4d 10             	decl   0x10(%ebp)
  80179d:	eb 03                	jmp    8017a2 <vprintfmt+0x3b1>
  80179f:	ff 4d 10             	decl   0x10(%ebp)
  8017a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a5:	48                   	dec    %eax
  8017a6:	8a 00                	mov    (%eax),%al
  8017a8:	3c 25                	cmp    $0x25,%al
  8017aa:	75 f3                	jne    80179f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8017ac:	90                   	nop
		}
	}
  8017ad:	e9 47 fc ff ff       	jmp    8013f9 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8017b2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8017b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017b6:	5b                   	pop    %ebx
  8017b7:	5e                   	pop    %esi
  8017b8:	5d                   	pop    %ebp
  8017b9:	c3                   	ret    

008017ba <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
  8017bd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8017c0:	8d 45 10             	lea    0x10(%ebp),%eax
  8017c3:	83 c0 04             	add    $0x4,%eax
  8017c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8017c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8017cf:	50                   	push   %eax
  8017d0:	ff 75 0c             	pushl  0xc(%ebp)
  8017d3:	ff 75 08             	pushl  0x8(%ebp)
  8017d6:	e8 16 fc ff ff       	call   8013f1 <vprintfmt>
  8017db:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8017de:	90                   	nop
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8017e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e7:	8b 40 08             	mov    0x8(%eax),%eax
  8017ea:	8d 50 01             	lea    0x1(%eax),%edx
  8017ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f0:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8017f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f6:	8b 10                	mov    (%eax),%edx
  8017f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fb:	8b 40 04             	mov    0x4(%eax),%eax
  8017fe:	39 c2                	cmp    %eax,%edx
  801800:	73 12                	jae    801814 <sprintputch+0x33>
		*b->buf++ = ch;
  801802:	8b 45 0c             	mov    0xc(%ebp),%eax
  801805:	8b 00                	mov    (%eax),%eax
  801807:	8d 48 01             	lea    0x1(%eax),%ecx
  80180a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180d:	89 0a                	mov    %ecx,(%edx)
  80180f:	8b 55 08             	mov    0x8(%ebp),%edx
  801812:	88 10                	mov    %dl,(%eax)
}
  801814:	90                   	nop
  801815:	5d                   	pop    %ebp
  801816:	c3                   	ret    

00801817 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
  80181a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801823:	8b 45 0c             	mov    0xc(%ebp),%eax
  801826:	8d 50 ff             	lea    -0x1(%eax),%edx
  801829:	8b 45 08             	mov    0x8(%ebp),%eax
  80182c:	01 d0                	add    %edx,%eax
  80182e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801831:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801838:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80183c:	74 06                	je     801844 <vsnprintf+0x2d>
  80183e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801842:	7f 07                	jg     80184b <vsnprintf+0x34>
		return -E_INVAL;
  801844:	b8 03 00 00 00       	mov    $0x3,%eax
  801849:	eb 20                	jmp    80186b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80184b:	ff 75 14             	pushl  0x14(%ebp)
  80184e:	ff 75 10             	pushl  0x10(%ebp)
  801851:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801854:	50                   	push   %eax
  801855:	68 e1 17 80 00       	push   $0x8017e1
  80185a:	e8 92 fb ff ff       	call   8013f1 <vprintfmt>
  80185f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801862:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801865:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801868:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
  801870:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801873:	8d 45 10             	lea    0x10(%ebp),%eax
  801876:	83 c0 04             	add    $0x4,%eax
  801879:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80187c:	8b 45 10             	mov    0x10(%ebp),%eax
  80187f:	ff 75 f4             	pushl  -0xc(%ebp)
  801882:	50                   	push   %eax
  801883:	ff 75 0c             	pushl  0xc(%ebp)
  801886:	ff 75 08             	pushl  0x8(%ebp)
  801889:	e8 89 ff ff ff       	call   801817 <vsnprintf>
  80188e:	83 c4 10             	add    $0x10,%esp
  801891:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801894:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
  80189c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80189f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018a6:	eb 06                	jmp    8018ae <strlen+0x15>
		n++;
  8018a8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8018ab:	ff 45 08             	incl   0x8(%ebp)
  8018ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b1:	8a 00                	mov    (%eax),%al
  8018b3:	84 c0                	test   %al,%al
  8018b5:	75 f1                	jne    8018a8 <strlen+0xf>
		n++;
	return n;
  8018b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8018ba:	c9                   	leave  
  8018bb:	c3                   	ret    

008018bc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8018bc:	55                   	push   %ebp
  8018bd:	89 e5                	mov    %esp,%ebp
  8018bf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8018c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018c9:	eb 09                	jmp    8018d4 <strnlen+0x18>
		n++;
  8018cb:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8018ce:	ff 45 08             	incl   0x8(%ebp)
  8018d1:	ff 4d 0c             	decl   0xc(%ebp)
  8018d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018d8:	74 09                	je     8018e3 <strnlen+0x27>
  8018da:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dd:	8a 00                	mov    (%eax),%al
  8018df:	84 c0                	test   %al,%al
  8018e1:	75 e8                	jne    8018cb <strnlen+0xf>
		n++;
	return n;
  8018e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8018e6:	c9                   	leave  
  8018e7:	c3                   	ret    

008018e8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8018e8:	55                   	push   %ebp
  8018e9:	89 e5                	mov    %esp,%ebp
  8018eb:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8018f4:	90                   	nop
  8018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f8:	8d 50 01             	lea    0x1(%eax),%edx
  8018fb:	89 55 08             	mov    %edx,0x8(%ebp)
  8018fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801901:	8d 4a 01             	lea    0x1(%edx),%ecx
  801904:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801907:	8a 12                	mov    (%edx),%dl
  801909:	88 10                	mov    %dl,(%eax)
  80190b:	8a 00                	mov    (%eax),%al
  80190d:	84 c0                	test   %al,%al
  80190f:	75 e4                	jne    8018f5 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801911:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801914:	c9                   	leave  
  801915:	c3                   	ret    

00801916 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801916:	55                   	push   %ebp
  801917:	89 e5                	mov    %esp,%ebp
  801919:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80191c:	8b 45 08             	mov    0x8(%ebp),%eax
  80191f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801922:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801929:	eb 1f                	jmp    80194a <strncpy+0x34>
		*dst++ = *src;
  80192b:	8b 45 08             	mov    0x8(%ebp),%eax
  80192e:	8d 50 01             	lea    0x1(%eax),%edx
  801931:	89 55 08             	mov    %edx,0x8(%ebp)
  801934:	8b 55 0c             	mov    0xc(%ebp),%edx
  801937:	8a 12                	mov    (%edx),%dl
  801939:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80193b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80193e:	8a 00                	mov    (%eax),%al
  801940:	84 c0                	test   %al,%al
  801942:	74 03                	je     801947 <strncpy+0x31>
			src++;
  801944:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801947:	ff 45 fc             	incl   -0x4(%ebp)
  80194a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80194d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801950:	72 d9                	jb     80192b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801952:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
  80195a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80195d:	8b 45 08             	mov    0x8(%ebp),%eax
  801960:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801963:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801967:	74 30                	je     801999 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801969:	eb 16                	jmp    801981 <strlcpy+0x2a>
			*dst++ = *src++;
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	8d 50 01             	lea    0x1(%eax),%edx
  801971:	89 55 08             	mov    %edx,0x8(%ebp)
  801974:	8b 55 0c             	mov    0xc(%ebp),%edx
  801977:	8d 4a 01             	lea    0x1(%edx),%ecx
  80197a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80197d:	8a 12                	mov    (%edx),%dl
  80197f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801981:	ff 4d 10             	decl   0x10(%ebp)
  801984:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801988:	74 09                	je     801993 <strlcpy+0x3c>
  80198a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198d:	8a 00                	mov    (%eax),%al
  80198f:	84 c0                	test   %al,%al
  801991:	75 d8                	jne    80196b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801993:	8b 45 08             	mov    0x8(%ebp),%eax
  801996:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801999:	8b 55 08             	mov    0x8(%ebp),%edx
  80199c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80199f:	29 c2                	sub    %eax,%edx
  8019a1:	89 d0                	mov    %edx,%eax
}
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8019a8:	eb 06                	jmp    8019b0 <strcmp+0xb>
		p++, q++;
  8019aa:	ff 45 08             	incl   0x8(%ebp)
  8019ad:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	8a 00                	mov    (%eax),%al
  8019b5:	84 c0                	test   %al,%al
  8019b7:	74 0e                	je     8019c7 <strcmp+0x22>
  8019b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bc:	8a 10                	mov    (%eax),%dl
  8019be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c1:	8a 00                	mov    (%eax),%al
  8019c3:	38 c2                	cmp    %al,%dl
  8019c5:	74 e3                	je     8019aa <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8019c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ca:	8a 00                	mov    (%eax),%al
  8019cc:	0f b6 d0             	movzbl %al,%edx
  8019cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d2:	8a 00                	mov    (%eax),%al
  8019d4:	0f b6 c0             	movzbl %al,%eax
  8019d7:	29 c2                	sub    %eax,%edx
  8019d9:	89 d0                	mov    %edx,%eax
}
  8019db:	5d                   	pop    %ebp
  8019dc:	c3                   	ret    

008019dd <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8019e0:	eb 09                	jmp    8019eb <strncmp+0xe>
		n--, p++, q++;
  8019e2:	ff 4d 10             	decl   0x10(%ebp)
  8019e5:	ff 45 08             	incl   0x8(%ebp)
  8019e8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8019eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019ef:	74 17                	je     801a08 <strncmp+0x2b>
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f4:	8a 00                	mov    (%eax),%al
  8019f6:	84 c0                	test   %al,%al
  8019f8:	74 0e                	je     801a08 <strncmp+0x2b>
  8019fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fd:	8a 10                	mov    (%eax),%dl
  8019ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a02:	8a 00                	mov    (%eax),%al
  801a04:	38 c2                	cmp    %al,%dl
  801a06:	74 da                	je     8019e2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801a08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a0c:	75 07                	jne    801a15 <strncmp+0x38>
		return 0;
  801a0e:	b8 00 00 00 00       	mov    $0x0,%eax
  801a13:	eb 14                	jmp    801a29 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801a15:	8b 45 08             	mov    0x8(%ebp),%eax
  801a18:	8a 00                	mov    (%eax),%al
  801a1a:	0f b6 d0             	movzbl %al,%edx
  801a1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a20:	8a 00                	mov    (%eax),%al
  801a22:	0f b6 c0             	movzbl %al,%eax
  801a25:	29 c2                	sub    %eax,%edx
  801a27:	89 d0                	mov    %edx,%eax
}
  801a29:	5d                   	pop    %ebp
  801a2a:	c3                   	ret    

00801a2b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801a2b:	55                   	push   %ebp
  801a2c:	89 e5                	mov    %esp,%ebp
  801a2e:	83 ec 04             	sub    $0x4,%esp
  801a31:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a34:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a37:	eb 12                	jmp    801a4b <strchr+0x20>
		if (*s == c)
  801a39:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3c:	8a 00                	mov    (%eax),%al
  801a3e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a41:	75 05                	jne    801a48 <strchr+0x1d>
			return (char *) s;
  801a43:	8b 45 08             	mov    0x8(%ebp),%eax
  801a46:	eb 11                	jmp    801a59 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801a48:	ff 45 08             	incl   0x8(%ebp)
  801a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4e:	8a 00                	mov    (%eax),%al
  801a50:	84 c0                	test   %al,%al
  801a52:	75 e5                	jne    801a39 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801a54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a59:	c9                   	leave  
  801a5a:	c3                   	ret    

00801a5b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
  801a5e:	83 ec 04             	sub    $0x4,%esp
  801a61:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a64:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a67:	eb 0d                	jmp    801a76 <strfind+0x1b>
		if (*s == c)
  801a69:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6c:	8a 00                	mov    (%eax),%al
  801a6e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a71:	74 0e                	je     801a81 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801a73:	ff 45 08             	incl   0x8(%ebp)
  801a76:	8b 45 08             	mov    0x8(%ebp),%eax
  801a79:	8a 00                	mov    (%eax),%al
  801a7b:	84 c0                	test   %al,%al
  801a7d:	75 ea                	jne    801a69 <strfind+0xe>
  801a7f:	eb 01                	jmp    801a82 <strfind+0x27>
		if (*s == c)
			break;
  801a81:	90                   	nop
	return (char *) s;
  801a82:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
  801a8a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a90:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801a93:	8b 45 10             	mov    0x10(%ebp),%eax
  801a96:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801a99:	eb 0e                	jmp    801aa9 <memset+0x22>
		*p++ = c;
  801a9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a9e:	8d 50 01             	lea    0x1(%eax),%edx
  801aa1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801aa4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa7:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801aa9:	ff 4d f8             	decl   -0x8(%ebp)
  801aac:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801ab0:	79 e9                	jns    801a9b <memset+0x14>
		*p++ = c;

	return v;
  801ab2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801ab5:	c9                   	leave  
  801ab6:	c3                   	ret    

00801ab7 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
  801aba:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801abd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801ac9:	eb 16                	jmp    801ae1 <memcpy+0x2a>
		*d++ = *s++;
  801acb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ace:	8d 50 01             	lea    0x1(%eax),%edx
  801ad1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801ad4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ad7:	8d 4a 01             	lea    0x1(%edx),%ecx
  801ada:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801add:	8a 12                	mov    (%edx),%dl
  801adf:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801ae1:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae4:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ae7:	89 55 10             	mov    %edx,0x10(%ebp)
  801aea:	85 c0                	test   %eax,%eax
  801aec:	75 dd                	jne    801acb <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801aee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801af1:	c9                   	leave  
  801af2:	c3                   	ret    

00801af3 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801af3:	55                   	push   %ebp
  801af4:	89 e5                	mov    %esp,%ebp
  801af6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801af9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801afc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801aff:	8b 45 08             	mov    0x8(%ebp),%eax
  801b02:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801b05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b08:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b0b:	73 50                	jae    801b5d <memmove+0x6a>
  801b0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b10:	8b 45 10             	mov    0x10(%ebp),%eax
  801b13:	01 d0                	add    %edx,%eax
  801b15:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b18:	76 43                	jbe    801b5d <memmove+0x6a>
		s += n;
  801b1a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b1d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801b20:	8b 45 10             	mov    0x10(%ebp),%eax
  801b23:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801b26:	eb 10                	jmp    801b38 <memmove+0x45>
			*--d = *--s;
  801b28:	ff 4d f8             	decl   -0x8(%ebp)
  801b2b:	ff 4d fc             	decl   -0x4(%ebp)
  801b2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b31:	8a 10                	mov    (%eax),%dl
  801b33:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b36:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801b38:	8b 45 10             	mov    0x10(%ebp),%eax
  801b3b:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b3e:	89 55 10             	mov    %edx,0x10(%ebp)
  801b41:	85 c0                	test   %eax,%eax
  801b43:	75 e3                	jne    801b28 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801b45:	eb 23                	jmp    801b6a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801b47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b4a:	8d 50 01             	lea    0x1(%eax),%edx
  801b4d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b50:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b53:	8d 4a 01             	lea    0x1(%edx),%ecx
  801b56:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801b59:	8a 12                	mov    (%edx),%dl
  801b5b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801b5d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b60:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b63:	89 55 10             	mov    %edx,0x10(%ebp)
  801b66:	85 c0                	test   %eax,%eax
  801b68:	75 dd                	jne    801b47 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801b6a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b6d:	c9                   	leave  
  801b6e:	c3                   	ret    

00801b6f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801b6f:	55                   	push   %ebp
  801b70:	89 e5                	mov    %esp,%ebp
  801b72:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801b75:	8b 45 08             	mov    0x8(%ebp),%eax
  801b78:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801b7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b7e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801b81:	eb 2a                	jmp    801bad <memcmp+0x3e>
		if (*s1 != *s2)
  801b83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b86:	8a 10                	mov    (%eax),%dl
  801b88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b8b:	8a 00                	mov    (%eax),%al
  801b8d:	38 c2                	cmp    %al,%dl
  801b8f:	74 16                	je     801ba7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801b91:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b94:	8a 00                	mov    (%eax),%al
  801b96:	0f b6 d0             	movzbl %al,%edx
  801b99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b9c:	8a 00                	mov    (%eax),%al
  801b9e:	0f b6 c0             	movzbl %al,%eax
  801ba1:	29 c2                	sub    %eax,%edx
  801ba3:	89 d0                	mov    %edx,%eax
  801ba5:	eb 18                	jmp    801bbf <memcmp+0x50>
		s1++, s2++;
  801ba7:	ff 45 fc             	incl   -0x4(%ebp)
  801baa:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801bad:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb0:	8d 50 ff             	lea    -0x1(%eax),%edx
  801bb3:	89 55 10             	mov    %edx,0x10(%ebp)
  801bb6:	85 c0                	test   %eax,%eax
  801bb8:	75 c9                	jne    801b83 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801bba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bbf:	c9                   	leave  
  801bc0:	c3                   	ret    

00801bc1 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
  801bc4:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801bc7:	8b 55 08             	mov    0x8(%ebp),%edx
  801bca:	8b 45 10             	mov    0x10(%ebp),%eax
  801bcd:	01 d0                	add    %edx,%eax
  801bcf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801bd2:	eb 15                	jmp    801be9 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd7:	8a 00                	mov    (%eax),%al
  801bd9:	0f b6 d0             	movzbl %al,%edx
  801bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bdf:	0f b6 c0             	movzbl %al,%eax
  801be2:	39 c2                	cmp    %eax,%edx
  801be4:	74 0d                	je     801bf3 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801be6:	ff 45 08             	incl   0x8(%ebp)
  801be9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801bef:	72 e3                	jb     801bd4 <memfind+0x13>
  801bf1:	eb 01                	jmp    801bf4 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801bf3:	90                   	nop
	return (void *) s;
  801bf4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801bf7:	c9                   	leave  
  801bf8:	c3                   	ret    

00801bf9 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801bf9:	55                   	push   %ebp
  801bfa:	89 e5                	mov    %esp,%ebp
  801bfc:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801bff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801c06:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c0d:	eb 03                	jmp    801c12 <strtol+0x19>
		s++;
  801c0f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c12:	8b 45 08             	mov    0x8(%ebp),%eax
  801c15:	8a 00                	mov    (%eax),%al
  801c17:	3c 20                	cmp    $0x20,%al
  801c19:	74 f4                	je     801c0f <strtol+0x16>
  801c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1e:	8a 00                	mov    (%eax),%al
  801c20:	3c 09                	cmp    $0x9,%al
  801c22:	74 eb                	je     801c0f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801c24:	8b 45 08             	mov    0x8(%ebp),%eax
  801c27:	8a 00                	mov    (%eax),%al
  801c29:	3c 2b                	cmp    $0x2b,%al
  801c2b:	75 05                	jne    801c32 <strtol+0x39>
		s++;
  801c2d:	ff 45 08             	incl   0x8(%ebp)
  801c30:	eb 13                	jmp    801c45 <strtol+0x4c>
	else if (*s == '-')
  801c32:	8b 45 08             	mov    0x8(%ebp),%eax
  801c35:	8a 00                	mov    (%eax),%al
  801c37:	3c 2d                	cmp    $0x2d,%al
  801c39:	75 0a                	jne    801c45 <strtol+0x4c>
		s++, neg = 1;
  801c3b:	ff 45 08             	incl   0x8(%ebp)
  801c3e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801c45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c49:	74 06                	je     801c51 <strtol+0x58>
  801c4b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801c4f:	75 20                	jne    801c71 <strtol+0x78>
  801c51:	8b 45 08             	mov    0x8(%ebp),%eax
  801c54:	8a 00                	mov    (%eax),%al
  801c56:	3c 30                	cmp    $0x30,%al
  801c58:	75 17                	jne    801c71 <strtol+0x78>
  801c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5d:	40                   	inc    %eax
  801c5e:	8a 00                	mov    (%eax),%al
  801c60:	3c 78                	cmp    $0x78,%al
  801c62:	75 0d                	jne    801c71 <strtol+0x78>
		s += 2, base = 16;
  801c64:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801c68:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801c6f:	eb 28                	jmp    801c99 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801c71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c75:	75 15                	jne    801c8c <strtol+0x93>
  801c77:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7a:	8a 00                	mov    (%eax),%al
  801c7c:	3c 30                	cmp    $0x30,%al
  801c7e:	75 0c                	jne    801c8c <strtol+0x93>
		s++, base = 8;
  801c80:	ff 45 08             	incl   0x8(%ebp)
  801c83:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801c8a:	eb 0d                	jmp    801c99 <strtol+0xa0>
	else if (base == 0)
  801c8c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c90:	75 07                	jne    801c99 <strtol+0xa0>
		base = 10;
  801c92:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801c99:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9c:	8a 00                	mov    (%eax),%al
  801c9e:	3c 2f                	cmp    $0x2f,%al
  801ca0:	7e 19                	jle    801cbb <strtol+0xc2>
  801ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca5:	8a 00                	mov    (%eax),%al
  801ca7:	3c 39                	cmp    $0x39,%al
  801ca9:	7f 10                	jg     801cbb <strtol+0xc2>
			dig = *s - '0';
  801cab:	8b 45 08             	mov    0x8(%ebp),%eax
  801cae:	8a 00                	mov    (%eax),%al
  801cb0:	0f be c0             	movsbl %al,%eax
  801cb3:	83 e8 30             	sub    $0x30,%eax
  801cb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801cb9:	eb 42                	jmp    801cfd <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbe:	8a 00                	mov    (%eax),%al
  801cc0:	3c 60                	cmp    $0x60,%al
  801cc2:	7e 19                	jle    801cdd <strtol+0xe4>
  801cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc7:	8a 00                	mov    (%eax),%al
  801cc9:	3c 7a                	cmp    $0x7a,%al
  801ccb:	7f 10                	jg     801cdd <strtol+0xe4>
			dig = *s - 'a' + 10;
  801ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd0:	8a 00                	mov    (%eax),%al
  801cd2:	0f be c0             	movsbl %al,%eax
  801cd5:	83 e8 57             	sub    $0x57,%eax
  801cd8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801cdb:	eb 20                	jmp    801cfd <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce0:	8a 00                	mov    (%eax),%al
  801ce2:	3c 40                	cmp    $0x40,%al
  801ce4:	7e 39                	jle    801d1f <strtol+0x126>
  801ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce9:	8a 00                	mov    (%eax),%al
  801ceb:	3c 5a                	cmp    $0x5a,%al
  801ced:	7f 30                	jg     801d1f <strtol+0x126>
			dig = *s - 'A' + 10;
  801cef:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf2:	8a 00                	mov    (%eax),%al
  801cf4:	0f be c0             	movsbl %al,%eax
  801cf7:	83 e8 37             	sub    $0x37,%eax
  801cfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d00:	3b 45 10             	cmp    0x10(%ebp),%eax
  801d03:	7d 19                	jge    801d1e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801d05:	ff 45 08             	incl   0x8(%ebp)
  801d08:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d0b:	0f af 45 10          	imul   0x10(%ebp),%eax
  801d0f:	89 c2                	mov    %eax,%edx
  801d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d14:	01 d0                	add    %edx,%eax
  801d16:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801d19:	e9 7b ff ff ff       	jmp    801c99 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801d1e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801d1f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d23:	74 08                	je     801d2d <strtol+0x134>
		*endptr = (char *) s;
  801d25:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d28:	8b 55 08             	mov    0x8(%ebp),%edx
  801d2b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801d2d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801d31:	74 07                	je     801d3a <strtol+0x141>
  801d33:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d36:	f7 d8                	neg    %eax
  801d38:	eb 03                	jmp    801d3d <strtol+0x144>
  801d3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801d3d:	c9                   	leave  
  801d3e:	c3                   	ret    

00801d3f <ltostr>:

void
ltostr(long value, char *str)
{
  801d3f:	55                   	push   %ebp
  801d40:	89 e5                	mov    %esp,%ebp
  801d42:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801d45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801d4c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801d53:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801d57:	79 13                	jns    801d6c <ltostr+0x2d>
	{
		neg = 1;
  801d59:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801d60:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d63:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801d66:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801d69:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801d74:	99                   	cltd   
  801d75:	f7 f9                	idiv   %ecx
  801d77:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801d7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d7d:	8d 50 01             	lea    0x1(%eax),%edx
  801d80:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801d83:	89 c2                	mov    %eax,%edx
  801d85:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d88:	01 d0                	add    %edx,%eax
  801d8a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d8d:	83 c2 30             	add    $0x30,%edx
  801d90:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801d92:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d95:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801d9a:	f7 e9                	imul   %ecx
  801d9c:	c1 fa 02             	sar    $0x2,%edx
  801d9f:	89 c8                	mov    %ecx,%eax
  801da1:	c1 f8 1f             	sar    $0x1f,%eax
  801da4:	29 c2                	sub    %eax,%edx
  801da6:	89 d0                	mov    %edx,%eax
  801da8:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801dab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801dae:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801db3:	f7 e9                	imul   %ecx
  801db5:	c1 fa 02             	sar    $0x2,%edx
  801db8:	89 c8                	mov    %ecx,%eax
  801dba:	c1 f8 1f             	sar    $0x1f,%eax
  801dbd:	29 c2                	sub    %eax,%edx
  801dbf:	89 d0                	mov    %edx,%eax
  801dc1:	c1 e0 02             	shl    $0x2,%eax
  801dc4:	01 d0                	add    %edx,%eax
  801dc6:	01 c0                	add    %eax,%eax
  801dc8:	29 c1                	sub    %eax,%ecx
  801dca:	89 ca                	mov    %ecx,%edx
  801dcc:	85 d2                	test   %edx,%edx
  801dce:	75 9c                	jne    801d6c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801dd0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801dd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801dda:	48                   	dec    %eax
  801ddb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801dde:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801de2:	74 3d                	je     801e21 <ltostr+0xe2>
		start = 1 ;
  801de4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801deb:	eb 34                	jmp    801e21 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801ded:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801df0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801df3:	01 d0                	add    %edx,%eax
  801df5:	8a 00                	mov    (%eax),%al
  801df7:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801dfa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e00:	01 c2                	add    %eax,%edx
  801e02:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801e05:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e08:	01 c8                	add    %ecx,%eax
  801e0a:	8a 00                	mov    (%eax),%al
  801e0c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801e0e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e11:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e14:	01 c2                	add    %eax,%edx
  801e16:	8a 45 eb             	mov    -0x15(%ebp),%al
  801e19:	88 02                	mov    %al,(%edx)
		start++ ;
  801e1b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801e1e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e24:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e27:	7c c4                	jl     801ded <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801e29:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e2f:	01 d0                	add    %edx,%eax
  801e31:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801e34:	90                   	nop
  801e35:	c9                   	leave  
  801e36:	c3                   	ret    

00801e37 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801e37:	55                   	push   %ebp
  801e38:	89 e5                	mov    %esp,%ebp
  801e3a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801e3d:	ff 75 08             	pushl  0x8(%ebp)
  801e40:	e8 54 fa ff ff       	call   801899 <strlen>
  801e45:	83 c4 04             	add    $0x4,%esp
  801e48:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801e4b:	ff 75 0c             	pushl  0xc(%ebp)
  801e4e:	e8 46 fa ff ff       	call   801899 <strlen>
  801e53:	83 c4 04             	add    $0x4,%esp
  801e56:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801e59:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801e60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e67:	eb 17                	jmp    801e80 <strcconcat+0x49>
		final[s] = str1[s] ;
  801e69:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e6c:	8b 45 10             	mov    0x10(%ebp),%eax
  801e6f:	01 c2                	add    %eax,%edx
  801e71:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801e74:	8b 45 08             	mov    0x8(%ebp),%eax
  801e77:	01 c8                	add    %ecx,%eax
  801e79:	8a 00                	mov    (%eax),%al
  801e7b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801e7d:	ff 45 fc             	incl   -0x4(%ebp)
  801e80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e83:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801e86:	7c e1                	jl     801e69 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801e88:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801e8f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801e96:	eb 1f                	jmp    801eb7 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801e98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e9b:	8d 50 01             	lea    0x1(%eax),%edx
  801e9e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ea1:	89 c2                	mov    %eax,%edx
  801ea3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ea6:	01 c2                	add    %eax,%edx
  801ea8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801eab:	8b 45 0c             	mov    0xc(%ebp),%eax
  801eae:	01 c8                	add    %ecx,%eax
  801eb0:	8a 00                	mov    (%eax),%al
  801eb2:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801eb4:	ff 45 f8             	incl   -0x8(%ebp)
  801eb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801eba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ebd:	7c d9                	jl     801e98 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ebf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ec5:	01 d0                	add    %edx,%eax
  801ec7:	c6 00 00             	movb   $0x0,(%eax)
}
  801eca:	90                   	nop
  801ecb:	c9                   	leave  
  801ecc:	c3                   	ret    

00801ecd <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ecd:	55                   	push   %ebp
  801ece:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801ed0:	8b 45 14             	mov    0x14(%ebp),%eax
  801ed3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801ed9:	8b 45 14             	mov    0x14(%ebp),%eax
  801edc:	8b 00                	mov    (%eax),%eax
  801ede:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ee5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ee8:	01 d0                	add    %edx,%eax
  801eea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801ef0:	eb 0c                	jmp    801efe <strsplit+0x31>
			*string++ = 0;
  801ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef5:	8d 50 01             	lea    0x1(%eax),%edx
  801ef8:	89 55 08             	mov    %edx,0x8(%ebp)
  801efb:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801efe:	8b 45 08             	mov    0x8(%ebp),%eax
  801f01:	8a 00                	mov    (%eax),%al
  801f03:	84 c0                	test   %al,%al
  801f05:	74 18                	je     801f1f <strsplit+0x52>
  801f07:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0a:	8a 00                	mov    (%eax),%al
  801f0c:	0f be c0             	movsbl %al,%eax
  801f0f:	50                   	push   %eax
  801f10:	ff 75 0c             	pushl  0xc(%ebp)
  801f13:	e8 13 fb ff ff       	call   801a2b <strchr>
  801f18:	83 c4 08             	add    $0x8,%esp
  801f1b:	85 c0                	test   %eax,%eax
  801f1d:	75 d3                	jne    801ef2 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f22:	8a 00                	mov    (%eax),%al
  801f24:	84 c0                	test   %al,%al
  801f26:	74 5a                	je     801f82 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801f28:	8b 45 14             	mov    0x14(%ebp),%eax
  801f2b:	8b 00                	mov    (%eax),%eax
  801f2d:	83 f8 0f             	cmp    $0xf,%eax
  801f30:	75 07                	jne    801f39 <strsplit+0x6c>
		{
			return 0;
  801f32:	b8 00 00 00 00       	mov    $0x0,%eax
  801f37:	eb 66                	jmp    801f9f <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801f39:	8b 45 14             	mov    0x14(%ebp),%eax
  801f3c:	8b 00                	mov    (%eax),%eax
  801f3e:	8d 48 01             	lea    0x1(%eax),%ecx
  801f41:	8b 55 14             	mov    0x14(%ebp),%edx
  801f44:	89 0a                	mov    %ecx,(%edx)
  801f46:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f4d:	8b 45 10             	mov    0x10(%ebp),%eax
  801f50:	01 c2                	add    %eax,%edx
  801f52:	8b 45 08             	mov    0x8(%ebp),%eax
  801f55:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f57:	eb 03                	jmp    801f5c <strsplit+0x8f>
			string++;
  801f59:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5f:	8a 00                	mov    (%eax),%al
  801f61:	84 c0                	test   %al,%al
  801f63:	74 8b                	je     801ef0 <strsplit+0x23>
  801f65:	8b 45 08             	mov    0x8(%ebp),%eax
  801f68:	8a 00                	mov    (%eax),%al
  801f6a:	0f be c0             	movsbl %al,%eax
  801f6d:	50                   	push   %eax
  801f6e:	ff 75 0c             	pushl  0xc(%ebp)
  801f71:	e8 b5 fa ff ff       	call   801a2b <strchr>
  801f76:	83 c4 08             	add    $0x8,%esp
  801f79:	85 c0                	test   %eax,%eax
  801f7b:	74 dc                	je     801f59 <strsplit+0x8c>
			string++;
	}
  801f7d:	e9 6e ff ff ff       	jmp    801ef0 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801f82:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801f83:	8b 45 14             	mov    0x14(%ebp),%eax
  801f86:	8b 00                	mov    (%eax),%eax
  801f88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  801f92:	01 d0                	add    %edx,%eax
  801f94:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801f9a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801f9f:	c9                   	leave  
  801fa0:	c3                   	ret    

00801fa1 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
  801fa4:	83 ec 18             	sub    $0x18,%esp
  801fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  801faa:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801fad:	83 ec 04             	sub    $0x4,%esp
  801fb0:	68 50 31 80 00       	push   $0x803150
  801fb5:	6a 17                	push   $0x17
  801fb7:	68 6f 31 80 00       	push   $0x80316f
  801fbc:	e8 a2 ef ff ff       	call   800f63 <_panic>

00801fc1 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801fc1:	55                   	push   %ebp
  801fc2:	89 e5                	mov    %esp,%ebp
  801fc4:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801fc7:	83 ec 04             	sub    $0x4,%esp
  801fca:	68 7b 31 80 00       	push   $0x80317b
  801fcf:	6a 2f                	push   $0x2f
  801fd1:	68 6f 31 80 00       	push   $0x80316f
  801fd6:	e8 88 ef ff ff       	call   800f63 <_panic>

00801fdb <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801fdb:	55                   	push   %ebp
  801fdc:	89 e5                	mov    %esp,%ebp
  801fde:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801fe1:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801fe8:	8b 55 08             	mov    0x8(%ebp),%edx
  801feb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fee:	01 d0                	add    %edx,%eax
  801ff0:	48                   	dec    %eax
  801ff1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801ff4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ff7:	ba 00 00 00 00       	mov    $0x0,%edx
  801ffc:	f7 75 ec             	divl   -0x14(%ebp)
  801fff:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802002:	29 d0                	sub    %edx,%eax
  802004:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  802007:	8b 45 08             	mov    0x8(%ebp),%eax
  80200a:	c1 e8 0c             	shr    $0xc,%eax
  80200d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  802010:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802017:	e9 c8 00 00 00       	jmp    8020e4 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80201c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802023:	eb 27                	jmp    80204c <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  802025:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802028:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80202b:	01 c2                	add    %eax,%edx
  80202d:	89 d0                	mov    %edx,%eax
  80202f:	01 c0                	add    %eax,%eax
  802031:	01 d0                	add    %edx,%eax
  802033:	c1 e0 02             	shl    $0x2,%eax
  802036:	05 48 40 80 00       	add    $0x804048,%eax
  80203b:	8b 00                	mov    (%eax),%eax
  80203d:	85 c0                	test   %eax,%eax
  80203f:	74 08                	je     802049 <malloc+0x6e>
            	i += j;
  802041:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802044:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  802047:	eb 0b                	jmp    802054 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  802049:	ff 45 f0             	incl   -0x10(%ebp)
  80204c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80204f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802052:	72 d1                	jb     802025 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  802054:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802057:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80205a:	0f 85 81 00 00 00    	jne    8020e1 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  802060:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802063:	05 00 00 08 00       	add    $0x80000,%eax
  802068:	c1 e0 0c             	shl    $0xc,%eax
  80206b:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80206e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802075:	eb 1f                	jmp    802096 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  802077:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80207a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80207d:	01 c2                	add    %eax,%edx
  80207f:	89 d0                	mov    %edx,%eax
  802081:	01 c0                	add    %eax,%eax
  802083:	01 d0                	add    %edx,%eax
  802085:	c1 e0 02             	shl    $0x2,%eax
  802088:	05 48 40 80 00       	add    $0x804048,%eax
  80208d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  802093:	ff 45 f0             	incl   -0x10(%ebp)
  802096:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802099:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80209c:	72 d9                	jb     802077 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80209e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020a1:	89 d0                	mov    %edx,%eax
  8020a3:	01 c0                	add    %eax,%eax
  8020a5:	01 d0                	add    %edx,%eax
  8020a7:	c1 e0 02             	shl    $0x2,%eax
  8020aa:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  8020b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8020b3:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8020b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8020b8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8020bb:	89 c8                	mov    %ecx,%eax
  8020bd:	01 c0                	add    %eax,%eax
  8020bf:	01 c8                	add    %ecx,%eax
  8020c1:	c1 e0 02             	shl    $0x2,%eax
  8020c4:	05 44 40 80 00       	add    $0x804044,%eax
  8020c9:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8020cb:	83 ec 08             	sub    $0x8,%esp
  8020ce:	ff 75 08             	pushl  0x8(%ebp)
  8020d1:	ff 75 e0             	pushl  -0x20(%ebp)
  8020d4:	e8 2b 03 00 00       	call   802404 <sys_allocateMem>
  8020d9:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8020dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8020df:	eb 19                	jmp    8020fa <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8020e1:	ff 45 f4             	incl   -0xc(%ebp)
  8020e4:	a1 04 40 80 00       	mov    0x804004,%eax
  8020e9:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8020ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8020ef:	0f 83 27 ff ff ff    	jae    80201c <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8020f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020fa:	c9                   	leave  
  8020fb:	c3                   	ret    

008020fc <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8020fc:	55                   	push   %ebp
  8020fd:	89 e5                	mov    %esp,%ebp
  8020ff:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  802102:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802106:	0f 84 e5 00 00 00    	je     8021f1 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80210c:	8b 45 08             	mov    0x8(%ebp),%eax
  80210f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  802112:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802115:	05 00 00 00 80       	add    $0x80000000,%eax
  80211a:	c1 e8 0c             	shr    $0xc,%eax
  80211d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  802120:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802123:	89 d0                	mov    %edx,%eax
  802125:	01 c0                	add    %eax,%eax
  802127:	01 d0                	add    %edx,%eax
  802129:	c1 e0 02             	shl    $0x2,%eax
  80212c:	05 40 40 80 00       	add    $0x804040,%eax
  802131:	8b 00                	mov    (%eax),%eax
  802133:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802136:	0f 85 b8 00 00 00    	jne    8021f4 <free+0xf8>
  80213c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80213f:	89 d0                	mov    %edx,%eax
  802141:	01 c0                	add    %eax,%eax
  802143:	01 d0                	add    %edx,%eax
  802145:	c1 e0 02             	shl    $0x2,%eax
  802148:	05 48 40 80 00       	add    $0x804048,%eax
  80214d:	8b 00                	mov    (%eax),%eax
  80214f:	85 c0                	test   %eax,%eax
  802151:	0f 84 9d 00 00 00    	je     8021f4 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  802157:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80215a:	89 d0                	mov    %edx,%eax
  80215c:	01 c0                	add    %eax,%eax
  80215e:	01 d0                	add    %edx,%eax
  802160:	c1 e0 02             	shl    $0x2,%eax
  802163:	05 44 40 80 00       	add    $0x804044,%eax
  802168:	8b 00                	mov    (%eax),%eax
  80216a:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80216d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802170:	c1 e0 0c             	shl    $0xc,%eax
  802173:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  802176:	83 ec 08             	sub    $0x8,%esp
  802179:	ff 75 e4             	pushl  -0x1c(%ebp)
  80217c:	ff 75 f0             	pushl  -0x10(%ebp)
  80217f:	e8 64 02 00 00       	call   8023e8 <sys_freeMem>
  802184:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802187:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80218e:	eb 57                	jmp    8021e7 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  802190:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802193:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802196:	01 c2                	add    %eax,%edx
  802198:	89 d0                	mov    %edx,%eax
  80219a:	01 c0                	add    %eax,%eax
  80219c:	01 d0                	add    %edx,%eax
  80219e:	c1 e0 02             	shl    $0x2,%eax
  8021a1:	05 48 40 80 00       	add    $0x804048,%eax
  8021a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8021ac:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8021af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021b2:	01 c2                	add    %eax,%edx
  8021b4:	89 d0                	mov    %edx,%eax
  8021b6:	01 c0                	add    %eax,%eax
  8021b8:	01 d0                	add    %edx,%eax
  8021ba:	c1 e0 02             	shl    $0x2,%eax
  8021bd:	05 40 40 80 00       	add    $0x804040,%eax
  8021c2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8021c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8021cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021ce:	01 c2                	add    %eax,%edx
  8021d0:	89 d0                	mov    %edx,%eax
  8021d2:	01 c0                	add    %eax,%eax
  8021d4:	01 d0                	add    %edx,%eax
  8021d6:	c1 e0 02             	shl    $0x2,%eax
  8021d9:	05 44 40 80 00       	add    $0x804044,%eax
  8021de:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8021e4:	ff 45 f4             	incl   -0xc(%ebp)
  8021e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021ea:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8021ed:	7c a1                	jl     802190 <free+0x94>
  8021ef:	eb 04                	jmp    8021f5 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8021f1:	90                   	nop
  8021f2:	eb 01                	jmp    8021f5 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8021f4:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8021f5:	c9                   	leave  
  8021f6:	c3                   	ret    

008021f7 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8021f7:	55                   	push   %ebp
  8021f8:	89 e5                	mov    %esp,%ebp
  8021fa:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8021fd:	83 ec 04             	sub    $0x4,%esp
  802200:	68 98 31 80 00       	push   $0x803198
  802205:	68 ae 00 00 00       	push   $0xae
  80220a:	68 6f 31 80 00       	push   $0x80316f
  80220f:	e8 4f ed ff ff       	call   800f63 <_panic>

00802214 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802214:	55                   	push   %ebp
  802215:	89 e5                	mov    %esp,%ebp
  802217:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80221a:	83 ec 04             	sub    $0x4,%esp
  80221d:	68 b8 31 80 00       	push   $0x8031b8
  802222:	68 ca 00 00 00       	push   $0xca
  802227:	68 6f 31 80 00       	push   $0x80316f
  80222c:	e8 32 ed ff ff       	call   800f63 <_panic>

00802231 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802231:	55                   	push   %ebp
  802232:	89 e5                	mov    %esp,%ebp
  802234:	57                   	push   %edi
  802235:	56                   	push   %esi
  802236:	53                   	push   %ebx
  802237:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80223a:	8b 45 08             	mov    0x8(%ebp),%eax
  80223d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802240:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802243:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802246:	8b 7d 18             	mov    0x18(%ebp),%edi
  802249:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80224c:	cd 30                	int    $0x30
  80224e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802251:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802254:	83 c4 10             	add    $0x10,%esp
  802257:	5b                   	pop    %ebx
  802258:	5e                   	pop    %esi
  802259:	5f                   	pop    %edi
  80225a:	5d                   	pop    %ebp
  80225b:	c3                   	ret    

0080225c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80225c:	55                   	push   %ebp
  80225d:	89 e5                	mov    %esp,%ebp
  80225f:	83 ec 04             	sub    $0x4,%esp
  802262:	8b 45 10             	mov    0x10(%ebp),%eax
  802265:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802268:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80226c:	8b 45 08             	mov    0x8(%ebp),%eax
  80226f:	6a 00                	push   $0x0
  802271:	6a 00                	push   $0x0
  802273:	52                   	push   %edx
  802274:	ff 75 0c             	pushl  0xc(%ebp)
  802277:	50                   	push   %eax
  802278:	6a 00                	push   $0x0
  80227a:	e8 b2 ff ff ff       	call   802231 <syscall>
  80227f:	83 c4 18             	add    $0x18,%esp
}
  802282:	90                   	nop
  802283:	c9                   	leave  
  802284:	c3                   	ret    

00802285 <sys_cgetc>:

int
sys_cgetc(void)
{
  802285:	55                   	push   %ebp
  802286:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802288:	6a 00                	push   $0x0
  80228a:	6a 00                	push   $0x0
  80228c:	6a 00                	push   $0x0
  80228e:	6a 00                	push   $0x0
  802290:	6a 00                	push   $0x0
  802292:	6a 01                	push   $0x1
  802294:	e8 98 ff ff ff       	call   802231 <syscall>
  802299:	83 c4 18             	add    $0x18,%esp
}
  80229c:	c9                   	leave  
  80229d:	c3                   	ret    

0080229e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80229e:	55                   	push   %ebp
  80229f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8022a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a4:	6a 00                	push   $0x0
  8022a6:	6a 00                	push   $0x0
  8022a8:	6a 00                	push   $0x0
  8022aa:	6a 00                	push   $0x0
  8022ac:	50                   	push   %eax
  8022ad:	6a 05                	push   $0x5
  8022af:	e8 7d ff ff ff       	call   802231 <syscall>
  8022b4:	83 c4 18             	add    $0x18,%esp
}
  8022b7:	c9                   	leave  
  8022b8:	c3                   	ret    

008022b9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8022b9:	55                   	push   %ebp
  8022ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 02                	push   $0x2
  8022c8:	e8 64 ff ff ff       	call   802231 <syscall>
  8022cd:	83 c4 18             	add    $0x18,%esp
}
  8022d0:	c9                   	leave  
  8022d1:	c3                   	ret    

008022d2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8022d2:	55                   	push   %ebp
  8022d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8022d5:	6a 00                	push   $0x0
  8022d7:	6a 00                	push   $0x0
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 03                	push   $0x3
  8022e1:	e8 4b ff ff ff       	call   802231 <syscall>
  8022e6:	83 c4 18             	add    $0x18,%esp
}
  8022e9:	c9                   	leave  
  8022ea:	c3                   	ret    

008022eb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8022eb:	55                   	push   %ebp
  8022ec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 04                	push   $0x4
  8022fa:	e8 32 ff ff ff       	call   802231 <syscall>
  8022ff:	83 c4 18             	add    $0x18,%esp
}
  802302:	c9                   	leave  
  802303:	c3                   	ret    

00802304 <sys_env_exit>:


void sys_env_exit(void)
{
  802304:	55                   	push   %ebp
  802305:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	6a 00                	push   $0x0
  802311:	6a 06                	push   $0x6
  802313:	e8 19 ff ff ff       	call   802231 <syscall>
  802318:	83 c4 18             	add    $0x18,%esp
}
  80231b:	90                   	nop
  80231c:	c9                   	leave  
  80231d:	c3                   	ret    

0080231e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80231e:	55                   	push   %ebp
  80231f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802321:	8b 55 0c             	mov    0xc(%ebp),%edx
  802324:	8b 45 08             	mov    0x8(%ebp),%eax
  802327:	6a 00                	push   $0x0
  802329:	6a 00                	push   $0x0
  80232b:	6a 00                	push   $0x0
  80232d:	52                   	push   %edx
  80232e:	50                   	push   %eax
  80232f:	6a 07                	push   $0x7
  802331:	e8 fb fe ff ff       	call   802231 <syscall>
  802336:	83 c4 18             	add    $0x18,%esp
}
  802339:	c9                   	leave  
  80233a:	c3                   	ret    

0080233b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80233b:	55                   	push   %ebp
  80233c:	89 e5                	mov    %esp,%ebp
  80233e:	56                   	push   %esi
  80233f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802340:	8b 75 18             	mov    0x18(%ebp),%esi
  802343:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802346:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802349:	8b 55 0c             	mov    0xc(%ebp),%edx
  80234c:	8b 45 08             	mov    0x8(%ebp),%eax
  80234f:	56                   	push   %esi
  802350:	53                   	push   %ebx
  802351:	51                   	push   %ecx
  802352:	52                   	push   %edx
  802353:	50                   	push   %eax
  802354:	6a 08                	push   $0x8
  802356:	e8 d6 fe ff ff       	call   802231 <syscall>
  80235b:	83 c4 18             	add    $0x18,%esp
}
  80235e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802361:	5b                   	pop    %ebx
  802362:	5e                   	pop    %esi
  802363:	5d                   	pop    %ebp
  802364:	c3                   	ret    

00802365 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802365:	55                   	push   %ebp
  802366:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802368:	8b 55 0c             	mov    0xc(%ebp),%edx
  80236b:	8b 45 08             	mov    0x8(%ebp),%eax
  80236e:	6a 00                	push   $0x0
  802370:	6a 00                	push   $0x0
  802372:	6a 00                	push   $0x0
  802374:	52                   	push   %edx
  802375:	50                   	push   %eax
  802376:	6a 09                	push   $0x9
  802378:	e8 b4 fe ff ff       	call   802231 <syscall>
  80237d:	83 c4 18             	add    $0x18,%esp
}
  802380:	c9                   	leave  
  802381:	c3                   	ret    

00802382 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802382:	55                   	push   %ebp
  802383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	ff 75 0c             	pushl  0xc(%ebp)
  80238e:	ff 75 08             	pushl  0x8(%ebp)
  802391:	6a 0a                	push   $0xa
  802393:	e8 99 fe ff ff       	call   802231 <syscall>
  802398:	83 c4 18             	add    $0x18,%esp
}
  80239b:	c9                   	leave  
  80239c:	c3                   	ret    

0080239d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80239d:	55                   	push   %ebp
  80239e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8023a0:	6a 00                	push   $0x0
  8023a2:	6a 00                	push   $0x0
  8023a4:	6a 00                	push   $0x0
  8023a6:	6a 00                	push   $0x0
  8023a8:	6a 00                	push   $0x0
  8023aa:	6a 0b                	push   $0xb
  8023ac:	e8 80 fe ff ff       	call   802231 <syscall>
  8023b1:	83 c4 18             	add    $0x18,%esp
}
  8023b4:	c9                   	leave  
  8023b5:	c3                   	ret    

008023b6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8023b6:	55                   	push   %ebp
  8023b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 00                	push   $0x0
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 00                	push   $0x0
  8023c3:	6a 0c                	push   $0xc
  8023c5:	e8 67 fe ff ff       	call   802231 <syscall>
  8023ca:	83 c4 18             	add    $0x18,%esp
}
  8023cd:	c9                   	leave  
  8023ce:	c3                   	ret    

008023cf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8023cf:	55                   	push   %ebp
  8023d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8023d2:	6a 00                	push   $0x0
  8023d4:	6a 00                	push   $0x0
  8023d6:	6a 00                	push   $0x0
  8023d8:	6a 00                	push   $0x0
  8023da:	6a 00                	push   $0x0
  8023dc:	6a 0d                	push   $0xd
  8023de:	e8 4e fe ff ff       	call   802231 <syscall>
  8023e3:	83 c4 18             	add    $0x18,%esp
}
  8023e6:	c9                   	leave  
  8023e7:	c3                   	ret    

008023e8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8023e8:	55                   	push   %ebp
  8023e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8023eb:	6a 00                	push   $0x0
  8023ed:	6a 00                	push   $0x0
  8023ef:	6a 00                	push   $0x0
  8023f1:	ff 75 0c             	pushl  0xc(%ebp)
  8023f4:	ff 75 08             	pushl  0x8(%ebp)
  8023f7:	6a 11                	push   $0x11
  8023f9:	e8 33 fe ff ff       	call   802231 <syscall>
  8023fe:	83 c4 18             	add    $0x18,%esp
	return;
  802401:	90                   	nop
}
  802402:	c9                   	leave  
  802403:	c3                   	ret    

00802404 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802404:	55                   	push   %ebp
  802405:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802407:	6a 00                	push   $0x0
  802409:	6a 00                	push   $0x0
  80240b:	6a 00                	push   $0x0
  80240d:	ff 75 0c             	pushl  0xc(%ebp)
  802410:	ff 75 08             	pushl  0x8(%ebp)
  802413:	6a 12                	push   $0x12
  802415:	e8 17 fe ff ff       	call   802231 <syscall>
  80241a:	83 c4 18             	add    $0x18,%esp
	return ;
  80241d:	90                   	nop
}
  80241e:	c9                   	leave  
  80241f:	c3                   	ret    

00802420 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802420:	55                   	push   %ebp
  802421:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802423:	6a 00                	push   $0x0
  802425:	6a 00                	push   $0x0
  802427:	6a 00                	push   $0x0
  802429:	6a 00                	push   $0x0
  80242b:	6a 00                	push   $0x0
  80242d:	6a 0e                	push   $0xe
  80242f:	e8 fd fd ff ff       	call   802231 <syscall>
  802434:	83 c4 18             	add    $0x18,%esp
}
  802437:	c9                   	leave  
  802438:	c3                   	ret    

00802439 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802439:	55                   	push   %ebp
  80243a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80243c:	6a 00                	push   $0x0
  80243e:	6a 00                	push   $0x0
  802440:	6a 00                	push   $0x0
  802442:	6a 00                	push   $0x0
  802444:	ff 75 08             	pushl  0x8(%ebp)
  802447:	6a 0f                	push   $0xf
  802449:	e8 e3 fd ff ff       	call   802231 <syscall>
  80244e:	83 c4 18             	add    $0x18,%esp
}
  802451:	c9                   	leave  
  802452:	c3                   	ret    

00802453 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802453:	55                   	push   %ebp
  802454:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802456:	6a 00                	push   $0x0
  802458:	6a 00                	push   $0x0
  80245a:	6a 00                	push   $0x0
  80245c:	6a 00                	push   $0x0
  80245e:	6a 00                	push   $0x0
  802460:	6a 10                	push   $0x10
  802462:	e8 ca fd ff ff       	call   802231 <syscall>
  802467:	83 c4 18             	add    $0x18,%esp
}
  80246a:	90                   	nop
  80246b:	c9                   	leave  
  80246c:	c3                   	ret    

0080246d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80246d:	55                   	push   %ebp
  80246e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802470:	6a 00                	push   $0x0
  802472:	6a 00                	push   $0x0
  802474:	6a 00                	push   $0x0
  802476:	6a 00                	push   $0x0
  802478:	6a 00                	push   $0x0
  80247a:	6a 14                	push   $0x14
  80247c:	e8 b0 fd ff ff       	call   802231 <syscall>
  802481:	83 c4 18             	add    $0x18,%esp
}
  802484:	90                   	nop
  802485:	c9                   	leave  
  802486:	c3                   	ret    

00802487 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802487:	55                   	push   %ebp
  802488:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80248a:	6a 00                	push   $0x0
  80248c:	6a 00                	push   $0x0
  80248e:	6a 00                	push   $0x0
  802490:	6a 00                	push   $0x0
  802492:	6a 00                	push   $0x0
  802494:	6a 15                	push   $0x15
  802496:	e8 96 fd ff ff       	call   802231 <syscall>
  80249b:	83 c4 18             	add    $0x18,%esp
}
  80249e:	90                   	nop
  80249f:	c9                   	leave  
  8024a0:	c3                   	ret    

008024a1 <sys_cputc>:


void
sys_cputc(const char c)
{
  8024a1:	55                   	push   %ebp
  8024a2:	89 e5                	mov    %esp,%ebp
  8024a4:	83 ec 04             	sub    $0x4,%esp
  8024a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024aa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8024ad:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8024b1:	6a 00                	push   $0x0
  8024b3:	6a 00                	push   $0x0
  8024b5:	6a 00                	push   $0x0
  8024b7:	6a 00                	push   $0x0
  8024b9:	50                   	push   %eax
  8024ba:	6a 16                	push   $0x16
  8024bc:	e8 70 fd ff ff       	call   802231 <syscall>
  8024c1:	83 c4 18             	add    $0x18,%esp
}
  8024c4:	90                   	nop
  8024c5:	c9                   	leave  
  8024c6:	c3                   	ret    

008024c7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8024c7:	55                   	push   %ebp
  8024c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8024ca:	6a 00                	push   $0x0
  8024cc:	6a 00                	push   $0x0
  8024ce:	6a 00                	push   $0x0
  8024d0:	6a 00                	push   $0x0
  8024d2:	6a 00                	push   $0x0
  8024d4:	6a 17                	push   $0x17
  8024d6:	e8 56 fd ff ff       	call   802231 <syscall>
  8024db:	83 c4 18             	add    $0x18,%esp
}
  8024de:	90                   	nop
  8024df:	c9                   	leave  
  8024e0:	c3                   	ret    

008024e1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8024e1:	55                   	push   %ebp
  8024e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8024e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024e7:	6a 00                	push   $0x0
  8024e9:	6a 00                	push   $0x0
  8024eb:	6a 00                	push   $0x0
  8024ed:	ff 75 0c             	pushl  0xc(%ebp)
  8024f0:	50                   	push   %eax
  8024f1:	6a 18                	push   $0x18
  8024f3:	e8 39 fd ff ff       	call   802231 <syscall>
  8024f8:	83 c4 18             	add    $0x18,%esp
}
  8024fb:	c9                   	leave  
  8024fc:	c3                   	ret    

008024fd <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8024fd:	55                   	push   %ebp
  8024fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802500:	8b 55 0c             	mov    0xc(%ebp),%edx
  802503:	8b 45 08             	mov    0x8(%ebp),%eax
  802506:	6a 00                	push   $0x0
  802508:	6a 00                	push   $0x0
  80250a:	6a 00                	push   $0x0
  80250c:	52                   	push   %edx
  80250d:	50                   	push   %eax
  80250e:	6a 1b                	push   $0x1b
  802510:	e8 1c fd ff ff       	call   802231 <syscall>
  802515:	83 c4 18             	add    $0x18,%esp
}
  802518:	c9                   	leave  
  802519:	c3                   	ret    

0080251a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80251a:	55                   	push   %ebp
  80251b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80251d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802520:	8b 45 08             	mov    0x8(%ebp),%eax
  802523:	6a 00                	push   $0x0
  802525:	6a 00                	push   $0x0
  802527:	6a 00                	push   $0x0
  802529:	52                   	push   %edx
  80252a:	50                   	push   %eax
  80252b:	6a 19                	push   $0x19
  80252d:	e8 ff fc ff ff       	call   802231 <syscall>
  802532:	83 c4 18             	add    $0x18,%esp
}
  802535:	90                   	nop
  802536:	c9                   	leave  
  802537:	c3                   	ret    

00802538 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802538:	55                   	push   %ebp
  802539:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80253b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80253e:	8b 45 08             	mov    0x8(%ebp),%eax
  802541:	6a 00                	push   $0x0
  802543:	6a 00                	push   $0x0
  802545:	6a 00                	push   $0x0
  802547:	52                   	push   %edx
  802548:	50                   	push   %eax
  802549:	6a 1a                	push   $0x1a
  80254b:	e8 e1 fc ff ff       	call   802231 <syscall>
  802550:	83 c4 18             	add    $0x18,%esp
}
  802553:	90                   	nop
  802554:	c9                   	leave  
  802555:	c3                   	ret    

00802556 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802556:	55                   	push   %ebp
  802557:	89 e5                	mov    %esp,%ebp
  802559:	83 ec 04             	sub    $0x4,%esp
  80255c:	8b 45 10             	mov    0x10(%ebp),%eax
  80255f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802562:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802565:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802569:	8b 45 08             	mov    0x8(%ebp),%eax
  80256c:	6a 00                	push   $0x0
  80256e:	51                   	push   %ecx
  80256f:	52                   	push   %edx
  802570:	ff 75 0c             	pushl  0xc(%ebp)
  802573:	50                   	push   %eax
  802574:	6a 1c                	push   $0x1c
  802576:	e8 b6 fc ff ff       	call   802231 <syscall>
  80257b:	83 c4 18             	add    $0x18,%esp
}
  80257e:	c9                   	leave  
  80257f:	c3                   	ret    

00802580 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802580:	55                   	push   %ebp
  802581:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802583:	8b 55 0c             	mov    0xc(%ebp),%edx
  802586:	8b 45 08             	mov    0x8(%ebp),%eax
  802589:	6a 00                	push   $0x0
  80258b:	6a 00                	push   $0x0
  80258d:	6a 00                	push   $0x0
  80258f:	52                   	push   %edx
  802590:	50                   	push   %eax
  802591:	6a 1d                	push   $0x1d
  802593:	e8 99 fc ff ff       	call   802231 <syscall>
  802598:	83 c4 18             	add    $0x18,%esp
}
  80259b:	c9                   	leave  
  80259c:	c3                   	ret    

0080259d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80259d:	55                   	push   %ebp
  80259e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8025a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8025a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a9:	6a 00                	push   $0x0
  8025ab:	6a 00                	push   $0x0
  8025ad:	51                   	push   %ecx
  8025ae:	52                   	push   %edx
  8025af:	50                   	push   %eax
  8025b0:	6a 1e                	push   $0x1e
  8025b2:	e8 7a fc ff ff       	call   802231 <syscall>
  8025b7:	83 c4 18             	add    $0x18,%esp
}
  8025ba:	c9                   	leave  
  8025bb:	c3                   	ret    

008025bc <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8025bc:	55                   	push   %ebp
  8025bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8025bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8025c5:	6a 00                	push   $0x0
  8025c7:	6a 00                	push   $0x0
  8025c9:	6a 00                	push   $0x0
  8025cb:	52                   	push   %edx
  8025cc:	50                   	push   %eax
  8025cd:	6a 1f                	push   $0x1f
  8025cf:	e8 5d fc ff ff       	call   802231 <syscall>
  8025d4:	83 c4 18             	add    $0x18,%esp
}
  8025d7:	c9                   	leave  
  8025d8:	c3                   	ret    

008025d9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8025d9:	55                   	push   %ebp
  8025da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8025dc:	6a 00                	push   $0x0
  8025de:	6a 00                	push   $0x0
  8025e0:	6a 00                	push   $0x0
  8025e2:	6a 00                	push   $0x0
  8025e4:	6a 00                	push   $0x0
  8025e6:	6a 20                	push   $0x20
  8025e8:	e8 44 fc ff ff       	call   802231 <syscall>
  8025ed:	83 c4 18             	add    $0x18,%esp
}
  8025f0:	c9                   	leave  
  8025f1:	c3                   	ret    

008025f2 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8025f2:	55                   	push   %ebp
  8025f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8025f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8025f8:	6a 00                	push   $0x0
  8025fa:	6a 00                	push   $0x0
  8025fc:	ff 75 10             	pushl  0x10(%ebp)
  8025ff:	ff 75 0c             	pushl  0xc(%ebp)
  802602:	50                   	push   %eax
  802603:	6a 21                	push   $0x21
  802605:	e8 27 fc ff ff       	call   802231 <syscall>
  80260a:	83 c4 18             	add    $0x18,%esp
}
  80260d:	c9                   	leave  
  80260e:	c3                   	ret    

0080260f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80260f:	55                   	push   %ebp
  802610:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802612:	8b 45 08             	mov    0x8(%ebp),%eax
  802615:	6a 00                	push   $0x0
  802617:	6a 00                	push   $0x0
  802619:	6a 00                	push   $0x0
  80261b:	6a 00                	push   $0x0
  80261d:	50                   	push   %eax
  80261e:	6a 22                	push   $0x22
  802620:	e8 0c fc ff ff       	call   802231 <syscall>
  802625:	83 c4 18             	add    $0x18,%esp
}
  802628:	90                   	nop
  802629:	c9                   	leave  
  80262a:	c3                   	ret    

0080262b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80262b:	55                   	push   %ebp
  80262c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80262e:	8b 45 08             	mov    0x8(%ebp),%eax
  802631:	6a 00                	push   $0x0
  802633:	6a 00                	push   $0x0
  802635:	6a 00                	push   $0x0
  802637:	6a 00                	push   $0x0
  802639:	50                   	push   %eax
  80263a:	6a 23                	push   $0x23
  80263c:	e8 f0 fb ff ff       	call   802231 <syscall>
  802641:	83 c4 18             	add    $0x18,%esp
}
  802644:	90                   	nop
  802645:	c9                   	leave  
  802646:	c3                   	ret    

00802647 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802647:	55                   	push   %ebp
  802648:	89 e5                	mov    %esp,%ebp
  80264a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80264d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802650:	8d 50 04             	lea    0x4(%eax),%edx
  802653:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802656:	6a 00                	push   $0x0
  802658:	6a 00                	push   $0x0
  80265a:	6a 00                	push   $0x0
  80265c:	52                   	push   %edx
  80265d:	50                   	push   %eax
  80265e:	6a 24                	push   $0x24
  802660:	e8 cc fb ff ff       	call   802231 <syscall>
  802665:	83 c4 18             	add    $0x18,%esp
	return result;
  802668:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80266b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80266e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802671:	89 01                	mov    %eax,(%ecx)
  802673:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802676:	8b 45 08             	mov    0x8(%ebp),%eax
  802679:	c9                   	leave  
  80267a:	c2 04 00             	ret    $0x4

0080267d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80267d:	55                   	push   %ebp
  80267e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802680:	6a 00                	push   $0x0
  802682:	6a 00                	push   $0x0
  802684:	ff 75 10             	pushl  0x10(%ebp)
  802687:	ff 75 0c             	pushl  0xc(%ebp)
  80268a:	ff 75 08             	pushl  0x8(%ebp)
  80268d:	6a 13                	push   $0x13
  80268f:	e8 9d fb ff ff       	call   802231 <syscall>
  802694:	83 c4 18             	add    $0x18,%esp
	return ;
  802697:	90                   	nop
}
  802698:	c9                   	leave  
  802699:	c3                   	ret    

0080269a <sys_rcr2>:
uint32 sys_rcr2()
{
  80269a:	55                   	push   %ebp
  80269b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80269d:	6a 00                	push   $0x0
  80269f:	6a 00                	push   $0x0
  8026a1:	6a 00                	push   $0x0
  8026a3:	6a 00                	push   $0x0
  8026a5:	6a 00                	push   $0x0
  8026a7:	6a 25                	push   $0x25
  8026a9:	e8 83 fb ff ff       	call   802231 <syscall>
  8026ae:	83 c4 18             	add    $0x18,%esp
}
  8026b1:	c9                   	leave  
  8026b2:	c3                   	ret    

008026b3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8026b3:	55                   	push   %ebp
  8026b4:	89 e5                	mov    %esp,%ebp
  8026b6:	83 ec 04             	sub    $0x4,%esp
  8026b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8026bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8026bf:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8026c3:	6a 00                	push   $0x0
  8026c5:	6a 00                	push   $0x0
  8026c7:	6a 00                	push   $0x0
  8026c9:	6a 00                	push   $0x0
  8026cb:	50                   	push   %eax
  8026cc:	6a 26                	push   $0x26
  8026ce:	e8 5e fb ff ff       	call   802231 <syscall>
  8026d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8026d6:	90                   	nop
}
  8026d7:	c9                   	leave  
  8026d8:	c3                   	ret    

008026d9 <rsttst>:
void rsttst()
{
  8026d9:	55                   	push   %ebp
  8026da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8026dc:	6a 00                	push   $0x0
  8026de:	6a 00                	push   $0x0
  8026e0:	6a 00                	push   $0x0
  8026e2:	6a 00                	push   $0x0
  8026e4:	6a 00                	push   $0x0
  8026e6:	6a 28                	push   $0x28
  8026e8:	e8 44 fb ff ff       	call   802231 <syscall>
  8026ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8026f0:	90                   	nop
}
  8026f1:	c9                   	leave  
  8026f2:	c3                   	ret    

008026f3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8026f3:	55                   	push   %ebp
  8026f4:	89 e5                	mov    %esp,%ebp
  8026f6:	83 ec 04             	sub    $0x4,%esp
  8026f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8026fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8026ff:	8b 55 18             	mov    0x18(%ebp),%edx
  802702:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802706:	52                   	push   %edx
  802707:	50                   	push   %eax
  802708:	ff 75 10             	pushl  0x10(%ebp)
  80270b:	ff 75 0c             	pushl  0xc(%ebp)
  80270e:	ff 75 08             	pushl  0x8(%ebp)
  802711:	6a 27                	push   $0x27
  802713:	e8 19 fb ff ff       	call   802231 <syscall>
  802718:	83 c4 18             	add    $0x18,%esp
	return ;
  80271b:	90                   	nop
}
  80271c:	c9                   	leave  
  80271d:	c3                   	ret    

0080271e <chktst>:
void chktst(uint32 n)
{
  80271e:	55                   	push   %ebp
  80271f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802721:	6a 00                	push   $0x0
  802723:	6a 00                	push   $0x0
  802725:	6a 00                	push   $0x0
  802727:	6a 00                	push   $0x0
  802729:	ff 75 08             	pushl  0x8(%ebp)
  80272c:	6a 29                	push   $0x29
  80272e:	e8 fe fa ff ff       	call   802231 <syscall>
  802733:	83 c4 18             	add    $0x18,%esp
	return ;
  802736:	90                   	nop
}
  802737:	c9                   	leave  
  802738:	c3                   	ret    

00802739 <inctst>:

void inctst()
{
  802739:	55                   	push   %ebp
  80273a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80273c:	6a 00                	push   $0x0
  80273e:	6a 00                	push   $0x0
  802740:	6a 00                	push   $0x0
  802742:	6a 00                	push   $0x0
  802744:	6a 00                	push   $0x0
  802746:	6a 2a                	push   $0x2a
  802748:	e8 e4 fa ff ff       	call   802231 <syscall>
  80274d:	83 c4 18             	add    $0x18,%esp
	return ;
  802750:	90                   	nop
}
  802751:	c9                   	leave  
  802752:	c3                   	ret    

00802753 <gettst>:
uint32 gettst()
{
  802753:	55                   	push   %ebp
  802754:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802756:	6a 00                	push   $0x0
  802758:	6a 00                	push   $0x0
  80275a:	6a 00                	push   $0x0
  80275c:	6a 00                	push   $0x0
  80275e:	6a 00                	push   $0x0
  802760:	6a 2b                	push   $0x2b
  802762:	e8 ca fa ff ff       	call   802231 <syscall>
  802767:	83 c4 18             	add    $0x18,%esp
}
  80276a:	c9                   	leave  
  80276b:	c3                   	ret    

0080276c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80276c:	55                   	push   %ebp
  80276d:	89 e5                	mov    %esp,%ebp
  80276f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802772:	6a 00                	push   $0x0
  802774:	6a 00                	push   $0x0
  802776:	6a 00                	push   $0x0
  802778:	6a 00                	push   $0x0
  80277a:	6a 00                	push   $0x0
  80277c:	6a 2c                	push   $0x2c
  80277e:	e8 ae fa ff ff       	call   802231 <syscall>
  802783:	83 c4 18             	add    $0x18,%esp
  802786:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802789:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80278d:	75 07                	jne    802796 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80278f:	b8 01 00 00 00       	mov    $0x1,%eax
  802794:	eb 05                	jmp    80279b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802796:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80279b:	c9                   	leave  
  80279c:	c3                   	ret    

0080279d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80279d:	55                   	push   %ebp
  80279e:	89 e5                	mov    %esp,%ebp
  8027a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8027a3:	6a 00                	push   $0x0
  8027a5:	6a 00                	push   $0x0
  8027a7:	6a 00                	push   $0x0
  8027a9:	6a 00                	push   $0x0
  8027ab:	6a 00                	push   $0x0
  8027ad:	6a 2c                	push   $0x2c
  8027af:	e8 7d fa ff ff       	call   802231 <syscall>
  8027b4:	83 c4 18             	add    $0x18,%esp
  8027b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8027ba:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8027be:	75 07                	jne    8027c7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8027c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8027c5:	eb 05                	jmp    8027cc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8027c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8027cc:	c9                   	leave  
  8027cd:	c3                   	ret    

008027ce <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8027ce:	55                   	push   %ebp
  8027cf:	89 e5                	mov    %esp,%ebp
  8027d1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8027d4:	6a 00                	push   $0x0
  8027d6:	6a 00                	push   $0x0
  8027d8:	6a 00                	push   $0x0
  8027da:	6a 00                	push   $0x0
  8027dc:	6a 00                	push   $0x0
  8027de:	6a 2c                	push   $0x2c
  8027e0:	e8 4c fa ff ff       	call   802231 <syscall>
  8027e5:	83 c4 18             	add    $0x18,%esp
  8027e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8027eb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8027ef:	75 07                	jne    8027f8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8027f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8027f6:	eb 05                	jmp    8027fd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8027f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8027fd:	c9                   	leave  
  8027fe:	c3                   	ret    

008027ff <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8027ff:	55                   	push   %ebp
  802800:	89 e5                	mov    %esp,%ebp
  802802:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802805:	6a 00                	push   $0x0
  802807:	6a 00                	push   $0x0
  802809:	6a 00                	push   $0x0
  80280b:	6a 00                	push   $0x0
  80280d:	6a 00                	push   $0x0
  80280f:	6a 2c                	push   $0x2c
  802811:	e8 1b fa ff ff       	call   802231 <syscall>
  802816:	83 c4 18             	add    $0x18,%esp
  802819:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80281c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802820:	75 07                	jne    802829 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802822:	b8 01 00 00 00       	mov    $0x1,%eax
  802827:	eb 05                	jmp    80282e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802829:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80282e:	c9                   	leave  
  80282f:	c3                   	ret    

00802830 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802830:	55                   	push   %ebp
  802831:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802833:	6a 00                	push   $0x0
  802835:	6a 00                	push   $0x0
  802837:	6a 00                	push   $0x0
  802839:	6a 00                	push   $0x0
  80283b:	ff 75 08             	pushl  0x8(%ebp)
  80283e:	6a 2d                	push   $0x2d
  802840:	e8 ec f9 ff ff       	call   802231 <syscall>
  802845:	83 c4 18             	add    $0x18,%esp
	return ;
  802848:	90                   	nop
}
  802849:	c9                   	leave  
  80284a:	c3                   	ret    
  80284b:	90                   	nop

0080284c <__udivdi3>:
  80284c:	55                   	push   %ebp
  80284d:	57                   	push   %edi
  80284e:	56                   	push   %esi
  80284f:	53                   	push   %ebx
  802850:	83 ec 1c             	sub    $0x1c,%esp
  802853:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802857:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80285b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80285f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802863:	89 ca                	mov    %ecx,%edx
  802865:	89 f8                	mov    %edi,%eax
  802867:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80286b:	85 f6                	test   %esi,%esi
  80286d:	75 2d                	jne    80289c <__udivdi3+0x50>
  80286f:	39 cf                	cmp    %ecx,%edi
  802871:	77 65                	ja     8028d8 <__udivdi3+0x8c>
  802873:	89 fd                	mov    %edi,%ebp
  802875:	85 ff                	test   %edi,%edi
  802877:	75 0b                	jne    802884 <__udivdi3+0x38>
  802879:	b8 01 00 00 00       	mov    $0x1,%eax
  80287e:	31 d2                	xor    %edx,%edx
  802880:	f7 f7                	div    %edi
  802882:	89 c5                	mov    %eax,%ebp
  802884:	31 d2                	xor    %edx,%edx
  802886:	89 c8                	mov    %ecx,%eax
  802888:	f7 f5                	div    %ebp
  80288a:	89 c1                	mov    %eax,%ecx
  80288c:	89 d8                	mov    %ebx,%eax
  80288e:	f7 f5                	div    %ebp
  802890:	89 cf                	mov    %ecx,%edi
  802892:	89 fa                	mov    %edi,%edx
  802894:	83 c4 1c             	add    $0x1c,%esp
  802897:	5b                   	pop    %ebx
  802898:	5e                   	pop    %esi
  802899:	5f                   	pop    %edi
  80289a:	5d                   	pop    %ebp
  80289b:	c3                   	ret    
  80289c:	39 ce                	cmp    %ecx,%esi
  80289e:	77 28                	ja     8028c8 <__udivdi3+0x7c>
  8028a0:	0f bd fe             	bsr    %esi,%edi
  8028a3:	83 f7 1f             	xor    $0x1f,%edi
  8028a6:	75 40                	jne    8028e8 <__udivdi3+0x9c>
  8028a8:	39 ce                	cmp    %ecx,%esi
  8028aa:	72 0a                	jb     8028b6 <__udivdi3+0x6a>
  8028ac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8028b0:	0f 87 9e 00 00 00    	ja     802954 <__udivdi3+0x108>
  8028b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8028bb:	89 fa                	mov    %edi,%edx
  8028bd:	83 c4 1c             	add    $0x1c,%esp
  8028c0:	5b                   	pop    %ebx
  8028c1:	5e                   	pop    %esi
  8028c2:	5f                   	pop    %edi
  8028c3:	5d                   	pop    %ebp
  8028c4:	c3                   	ret    
  8028c5:	8d 76 00             	lea    0x0(%esi),%esi
  8028c8:	31 ff                	xor    %edi,%edi
  8028ca:	31 c0                	xor    %eax,%eax
  8028cc:	89 fa                	mov    %edi,%edx
  8028ce:	83 c4 1c             	add    $0x1c,%esp
  8028d1:	5b                   	pop    %ebx
  8028d2:	5e                   	pop    %esi
  8028d3:	5f                   	pop    %edi
  8028d4:	5d                   	pop    %ebp
  8028d5:	c3                   	ret    
  8028d6:	66 90                	xchg   %ax,%ax
  8028d8:	89 d8                	mov    %ebx,%eax
  8028da:	f7 f7                	div    %edi
  8028dc:	31 ff                	xor    %edi,%edi
  8028de:	89 fa                	mov    %edi,%edx
  8028e0:	83 c4 1c             	add    $0x1c,%esp
  8028e3:	5b                   	pop    %ebx
  8028e4:	5e                   	pop    %esi
  8028e5:	5f                   	pop    %edi
  8028e6:	5d                   	pop    %ebp
  8028e7:	c3                   	ret    
  8028e8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8028ed:	89 eb                	mov    %ebp,%ebx
  8028ef:	29 fb                	sub    %edi,%ebx
  8028f1:	89 f9                	mov    %edi,%ecx
  8028f3:	d3 e6                	shl    %cl,%esi
  8028f5:	89 c5                	mov    %eax,%ebp
  8028f7:	88 d9                	mov    %bl,%cl
  8028f9:	d3 ed                	shr    %cl,%ebp
  8028fb:	89 e9                	mov    %ebp,%ecx
  8028fd:	09 f1                	or     %esi,%ecx
  8028ff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802903:	89 f9                	mov    %edi,%ecx
  802905:	d3 e0                	shl    %cl,%eax
  802907:	89 c5                	mov    %eax,%ebp
  802909:	89 d6                	mov    %edx,%esi
  80290b:	88 d9                	mov    %bl,%cl
  80290d:	d3 ee                	shr    %cl,%esi
  80290f:	89 f9                	mov    %edi,%ecx
  802911:	d3 e2                	shl    %cl,%edx
  802913:	8b 44 24 08          	mov    0x8(%esp),%eax
  802917:	88 d9                	mov    %bl,%cl
  802919:	d3 e8                	shr    %cl,%eax
  80291b:	09 c2                	or     %eax,%edx
  80291d:	89 d0                	mov    %edx,%eax
  80291f:	89 f2                	mov    %esi,%edx
  802921:	f7 74 24 0c          	divl   0xc(%esp)
  802925:	89 d6                	mov    %edx,%esi
  802927:	89 c3                	mov    %eax,%ebx
  802929:	f7 e5                	mul    %ebp
  80292b:	39 d6                	cmp    %edx,%esi
  80292d:	72 19                	jb     802948 <__udivdi3+0xfc>
  80292f:	74 0b                	je     80293c <__udivdi3+0xf0>
  802931:	89 d8                	mov    %ebx,%eax
  802933:	31 ff                	xor    %edi,%edi
  802935:	e9 58 ff ff ff       	jmp    802892 <__udivdi3+0x46>
  80293a:	66 90                	xchg   %ax,%ax
  80293c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802940:	89 f9                	mov    %edi,%ecx
  802942:	d3 e2                	shl    %cl,%edx
  802944:	39 c2                	cmp    %eax,%edx
  802946:	73 e9                	jae    802931 <__udivdi3+0xe5>
  802948:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80294b:	31 ff                	xor    %edi,%edi
  80294d:	e9 40 ff ff ff       	jmp    802892 <__udivdi3+0x46>
  802952:	66 90                	xchg   %ax,%ax
  802954:	31 c0                	xor    %eax,%eax
  802956:	e9 37 ff ff ff       	jmp    802892 <__udivdi3+0x46>
  80295b:	90                   	nop

0080295c <__umoddi3>:
  80295c:	55                   	push   %ebp
  80295d:	57                   	push   %edi
  80295e:	56                   	push   %esi
  80295f:	53                   	push   %ebx
  802960:	83 ec 1c             	sub    $0x1c,%esp
  802963:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802967:	8b 74 24 34          	mov    0x34(%esp),%esi
  80296b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80296f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802973:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802977:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80297b:	89 f3                	mov    %esi,%ebx
  80297d:	89 fa                	mov    %edi,%edx
  80297f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802983:	89 34 24             	mov    %esi,(%esp)
  802986:	85 c0                	test   %eax,%eax
  802988:	75 1a                	jne    8029a4 <__umoddi3+0x48>
  80298a:	39 f7                	cmp    %esi,%edi
  80298c:	0f 86 a2 00 00 00    	jbe    802a34 <__umoddi3+0xd8>
  802992:	89 c8                	mov    %ecx,%eax
  802994:	89 f2                	mov    %esi,%edx
  802996:	f7 f7                	div    %edi
  802998:	89 d0                	mov    %edx,%eax
  80299a:	31 d2                	xor    %edx,%edx
  80299c:	83 c4 1c             	add    $0x1c,%esp
  80299f:	5b                   	pop    %ebx
  8029a0:	5e                   	pop    %esi
  8029a1:	5f                   	pop    %edi
  8029a2:	5d                   	pop    %ebp
  8029a3:	c3                   	ret    
  8029a4:	39 f0                	cmp    %esi,%eax
  8029a6:	0f 87 ac 00 00 00    	ja     802a58 <__umoddi3+0xfc>
  8029ac:	0f bd e8             	bsr    %eax,%ebp
  8029af:	83 f5 1f             	xor    $0x1f,%ebp
  8029b2:	0f 84 ac 00 00 00    	je     802a64 <__umoddi3+0x108>
  8029b8:	bf 20 00 00 00       	mov    $0x20,%edi
  8029bd:	29 ef                	sub    %ebp,%edi
  8029bf:	89 fe                	mov    %edi,%esi
  8029c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8029c5:	89 e9                	mov    %ebp,%ecx
  8029c7:	d3 e0                	shl    %cl,%eax
  8029c9:	89 d7                	mov    %edx,%edi
  8029cb:	89 f1                	mov    %esi,%ecx
  8029cd:	d3 ef                	shr    %cl,%edi
  8029cf:	09 c7                	or     %eax,%edi
  8029d1:	89 e9                	mov    %ebp,%ecx
  8029d3:	d3 e2                	shl    %cl,%edx
  8029d5:	89 14 24             	mov    %edx,(%esp)
  8029d8:	89 d8                	mov    %ebx,%eax
  8029da:	d3 e0                	shl    %cl,%eax
  8029dc:	89 c2                	mov    %eax,%edx
  8029de:	8b 44 24 08          	mov    0x8(%esp),%eax
  8029e2:	d3 e0                	shl    %cl,%eax
  8029e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8029e8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8029ec:	89 f1                	mov    %esi,%ecx
  8029ee:	d3 e8                	shr    %cl,%eax
  8029f0:	09 d0                	or     %edx,%eax
  8029f2:	d3 eb                	shr    %cl,%ebx
  8029f4:	89 da                	mov    %ebx,%edx
  8029f6:	f7 f7                	div    %edi
  8029f8:	89 d3                	mov    %edx,%ebx
  8029fa:	f7 24 24             	mull   (%esp)
  8029fd:	89 c6                	mov    %eax,%esi
  8029ff:	89 d1                	mov    %edx,%ecx
  802a01:	39 d3                	cmp    %edx,%ebx
  802a03:	0f 82 87 00 00 00    	jb     802a90 <__umoddi3+0x134>
  802a09:	0f 84 91 00 00 00    	je     802aa0 <__umoddi3+0x144>
  802a0f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802a13:	29 f2                	sub    %esi,%edx
  802a15:	19 cb                	sbb    %ecx,%ebx
  802a17:	89 d8                	mov    %ebx,%eax
  802a19:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802a1d:	d3 e0                	shl    %cl,%eax
  802a1f:	89 e9                	mov    %ebp,%ecx
  802a21:	d3 ea                	shr    %cl,%edx
  802a23:	09 d0                	or     %edx,%eax
  802a25:	89 e9                	mov    %ebp,%ecx
  802a27:	d3 eb                	shr    %cl,%ebx
  802a29:	89 da                	mov    %ebx,%edx
  802a2b:	83 c4 1c             	add    $0x1c,%esp
  802a2e:	5b                   	pop    %ebx
  802a2f:	5e                   	pop    %esi
  802a30:	5f                   	pop    %edi
  802a31:	5d                   	pop    %ebp
  802a32:	c3                   	ret    
  802a33:	90                   	nop
  802a34:	89 fd                	mov    %edi,%ebp
  802a36:	85 ff                	test   %edi,%edi
  802a38:	75 0b                	jne    802a45 <__umoddi3+0xe9>
  802a3a:	b8 01 00 00 00       	mov    $0x1,%eax
  802a3f:	31 d2                	xor    %edx,%edx
  802a41:	f7 f7                	div    %edi
  802a43:	89 c5                	mov    %eax,%ebp
  802a45:	89 f0                	mov    %esi,%eax
  802a47:	31 d2                	xor    %edx,%edx
  802a49:	f7 f5                	div    %ebp
  802a4b:	89 c8                	mov    %ecx,%eax
  802a4d:	f7 f5                	div    %ebp
  802a4f:	89 d0                	mov    %edx,%eax
  802a51:	e9 44 ff ff ff       	jmp    80299a <__umoddi3+0x3e>
  802a56:	66 90                	xchg   %ax,%ax
  802a58:	89 c8                	mov    %ecx,%eax
  802a5a:	89 f2                	mov    %esi,%edx
  802a5c:	83 c4 1c             	add    $0x1c,%esp
  802a5f:	5b                   	pop    %ebx
  802a60:	5e                   	pop    %esi
  802a61:	5f                   	pop    %edi
  802a62:	5d                   	pop    %ebp
  802a63:	c3                   	ret    
  802a64:	3b 04 24             	cmp    (%esp),%eax
  802a67:	72 06                	jb     802a6f <__umoddi3+0x113>
  802a69:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802a6d:	77 0f                	ja     802a7e <__umoddi3+0x122>
  802a6f:	89 f2                	mov    %esi,%edx
  802a71:	29 f9                	sub    %edi,%ecx
  802a73:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802a77:	89 14 24             	mov    %edx,(%esp)
  802a7a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802a7e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802a82:	8b 14 24             	mov    (%esp),%edx
  802a85:	83 c4 1c             	add    $0x1c,%esp
  802a88:	5b                   	pop    %ebx
  802a89:	5e                   	pop    %esi
  802a8a:	5f                   	pop    %edi
  802a8b:	5d                   	pop    %ebp
  802a8c:	c3                   	ret    
  802a8d:	8d 76 00             	lea    0x0(%esi),%esi
  802a90:	2b 04 24             	sub    (%esp),%eax
  802a93:	19 fa                	sbb    %edi,%edx
  802a95:	89 d1                	mov    %edx,%ecx
  802a97:	89 c6                	mov    %eax,%esi
  802a99:	e9 71 ff ff ff       	jmp    802a0f <__umoddi3+0xb3>
  802a9e:	66 90                	xchg   %ax,%ax
  802aa0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802aa4:	72 ea                	jb     802a90 <__umoddi3+0x134>
  802aa6:	89 d9                	mov    %ebx,%ecx
  802aa8:	e9 62 ff ff ff       	jmp    802a0f <__umoddi3+0xb3>
