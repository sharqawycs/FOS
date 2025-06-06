
obj/user/tst_free_1:     file format elf32-i386


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
  800031:	e8 5c 18 00 00       	call   801892 <libmain>
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
  80003d:	81 ec 90 01 00 00    	sub    $0x190,%esp
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
  800091:	68 e0 34 80 00       	push   $0x8034e0
  800096:	6a 1a                	push   $0x1a
  800098:	68 fc 34 80 00       	push   $0x8034fc
  80009d:	e8 f2 18 00 00       	call   801994 <_panic>


	
	

	int Mega = 1024*1024;
  8000a2:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  8000a9:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)
	char minByte = 1<<7;
  8000b0:	c6 45 db 80          	movb   $0x80,-0x25(%ebp)
	char maxByte = 0x7F;
  8000b4:	c6 45 da 7f          	movb   $0x7f,-0x26(%ebp)
	short minShort = 1<<15 ;
  8000b8:	66 c7 45 d8 00 80    	movw   $0x8000,-0x28(%ebp)
	short maxShort = 0x7FFF;
  8000be:	66 c7 45 d6 ff 7f    	movw   $0x7fff,-0x2a(%ebp)
	int minInt = 1<<31 ;
  8000c4:	c7 45 d0 00 00 00 80 	movl   $0x80000000,-0x30(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000cb:	c7 45 cc ff ff ff 7f 	movl   $0x7fffffff,-0x34(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000d2:	e8 f7 2c 00 00       	call   802dce <sys_calculate_free_frames>
  8000d7:	89 45 c8             	mov    %eax,-0x38(%ebp)

	void* ptr_allocations[20] = {0};
  8000da:	8d 95 68 fe ff ff    	lea    -0x198(%ebp),%edx
  8000e0:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ea:	89 d7                	mov    %edx,%edi
  8000ec:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000ee:	e8 5e 2d 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8000f3:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 05 29 00 00       	call   802a0c <malloc>
  800107:	83 c4 10             	add    $0x10,%esp
  80010a:	89 85 68 fe ff ff    	mov    %eax,-0x198(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800110:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800116:	85 c0                	test   %eax,%eax
  800118:	79 0d                	jns    800127 <_main+0xef>
  80011a:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800120:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800125:	76 14                	jbe    80013b <_main+0x103>
  800127:	83 ec 04             	sub    $0x4,%esp
  80012a:	68 10 35 80 00       	push   $0x803510
  80012f:	6a 36                	push   $0x36
  800131:	68 fc 34 80 00       	push   $0x8034fc
  800136:	e8 59 18 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80013b:	e8 11 2d 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800140:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800143:	3d 00 02 00 00       	cmp    $0x200,%eax
  800148:	74 14                	je     80015e <_main+0x126>
  80014a:	83 ec 04             	sub    $0x4,%esp
  80014d:	68 78 35 80 00       	push   $0x803578
  800152:	6a 37                	push   $0x37
  800154:	68 fc 34 80 00       	push   $0x8034fc
  800159:	e8 36 18 00 00       	call   801994 <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  80015e:	e8 6b 2c 00 00       	call   802dce <sys_calculate_free_frames>
  800163:	89 45 c0             	mov    %eax,-0x40(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800166:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80016e:	48                   	dec    %eax
  80016f:	89 45 bc             	mov    %eax,-0x44(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800172:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800178:	89 45 b8             	mov    %eax,-0x48(%ebp)
		byteArr[0] = minByte ;
  80017b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80017e:	8a 55 db             	mov    -0x25(%ebp),%dl
  800181:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800183:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800186:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800189:	01 c2                	add    %eax,%edx
  80018b:	8a 45 da             	mov    -0x26(%ebp),%al
  80018e:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800190:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800193:	e8 36 2c 00 00       	call   802dce <sys_calculate_free_frames>
  800198:	29 c3                	sub    %eax,%ebx
  80019a:	89 d8                	mov    %ebx,%eax
  80019c:	83 f8 03             	cmp    $0x3,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 a8 35 80 00       	push   $0x8035a8
  8001a9:	6a 3e                	push   $0x3e
  8001ab:	68 fc 34 80 00       	push   $0x8034fc
  8001b0:	e8 df 17 00 00       	call   801994 <_panic>
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
  8001e3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001e6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ee:	89 c2                	mov    %eax,%edx
  8001f0:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001f3:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8001f6:	8b 45 b0             	mov    -0x50(%ebp),%eax
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
  800220:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800223:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800226:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022b:	89 c1                	mov    %eax,%ecx
  80022d:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800230:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800233:	01 d0                	add    %edx,%eax
  800235:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800238:	8b 45 a8             	mov    -0x58(%ebp),%eax
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
  800266:	68 ec 35 80 00       	push   $0x8035ec
  80026b:	6a 48                	push   $0x48
  80026d:	68 fc 34 80 00       	push   $0x8034fc
  800272:	e8 1d 17 00 00       	call   801994 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800277:	e8 d5 2b 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  80027c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80027f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800282:	01 c0                	add    %eax,%eax
  800284:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800287:	83 ec 0c             	sub    $0xc,%esp
  80028a:	50                   	push   %eax
  80028b:	e8 7c 27 00 00       	call   802a0c <malloc>
  800290:	83 c4 10             	add    $0x10,%esp
  800293:	89 85 6c fe ff ff    	mov    %eax,-0x194(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800299:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  80029f:	89 c2                	mov    %eax,%edx
  8002a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002a4:	01 c0                	add    %eax,%eax
  8002a6:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ab:	39 c2                	cmp    %eax,%edx
  8002ad:	72 16                	jb     8002c5 <_main+0x28d>
  8002af:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  8002b5:	89 c2                	mov    %eax,%edx
  8002b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ba:	01 c0                	add    %eax,%eax
  8002bc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002c1:	39 c2                	cmp    %eax,%edx
  8002c3:	76 14                	jbe    8002d9 <_main+0x2a1>
  8002c5:	83 ec 04             	sub    $0x4,%esp
  8002c8:	68 10 35 80 00       	push   $0x803510
  8002cd:	6a 4d                	push   $0x4d
  8002cf:	68 fc 34 80 00       	push   $0x8034fc
  8002d4:	e8 bb 16 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002d9:	e8 73 2b 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8002de:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8002e1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 78 35 80 00       	push   $0x803578
  8002f0:	6a 4e                	push   $0x4e
  8002f2:	68 fc 34 80 00       	push   $0x8034fc
  8002f7:	e8 98 16 00 00       	call   801994 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002fc:	e8 cd 2a 00 00       	call   802dce <sys_calculate_free_frames>
  800301:	89 45 c0             	mov    %eax,-0x40(%ebp)
		shortArr = (short *) ptr_allocations[1];
  800304:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  80030a:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80030d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800310:	01 c0                	add    %eax,%eax
  800312:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800315:	d1 e8                	shr    %eax
  800317:	48                   	dec    %eax
  800318:	89 45 a0             	mov    %eax,-0x60(%ebp)
		shortArr[0] = minShort;
  80031b:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  80031e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800321:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800324:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800327:	01 c0                	add    %eax,%eax
  800329:	89 c2                	mov    %eax,%edx
  80032b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80032e:	01 c2                	add    %eax,%edx
  800330:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800334:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800337:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  80033a:	e8 8f 2a 00 00       	call   802dce <sys_calculate_free_frames>
  80033f:	29 c3                	sub    %eax,%ebx
  800341:	89 d8                	mov    %ebx,%eax
  800343:	83 f8 02             	cmp    $0x2,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 a8 35 80 00       	push   $0x8035a8
  800350:	6a 55                	push   $0x55
  800352:	68 fc 34 80 00       	push   $0x8034fc
  800357:	e8 38 16 00 00       	call   801994 <_panic>
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
  80038a:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80038d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800390:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800395:	89 c2                	mov    %eax,%edx
  800397:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80039a:	89 45 98             	mov    %eax,-0x68(%ebp)
  80039d:	8b 45 98             	mov    -0x68(%ebp),%eax
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
  8003c7:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003ca:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8003cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003d7:	01 c0                	add    %eax,%eax
  8003d9:	89 c1                	mov    %eax,%ecx
  8003db:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003de:	01 c8                	add    %ecx,%eax
  8003e0:	89 45 90             	mov    %eax,-0x70(%ebp)
  8003e3:	8b 45 90             	mov    -0x70(%ebp),%eax
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
  800411:	68 ec 35 80 00       	push   $0x8035ec
  800416:	6a 5e                	push   $0x5e
  800418:	68 fc 34 80 00       	push   $0x8034fc
  80041d:	e8 72 15 00 00       	call   801994 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800422:	e8 2a 2a 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800427:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  80042a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80042d:	01 c0                	add    %eax,%eax
  80042f:	83 ec 0c             	sub    $0xc,%esp
  800432:	50                   	push   %eax
  800433:	e8 d4 25 00 00       	call   802a0c <malloc>
  800438:	83 c4 10             	add    $0x10,%esp
  80043b:	89 85 70 fe ff ff    	mov    %eax,-0x190(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800441:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  800447:	89 c2                	mov    %eax,%edx
  800449:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80044c:	c1 e0 02             	shl    $0x2,%eax
  80044f:	05 00 00 00 80       	add    $0x80000000,%eax
  800454:	39 c2                	cmp    %eax,%edx
  800456:	72 17                	jb     80046f <_main+0x437>
  800458:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  80045e:	89 c2                	mov    %eax,%edx
  800460:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800463:	c1 e0 02             	shl    $0x2,%eax
  800466:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80046b:	39 c2                	cmp    %eax,%edx
  80046d:	76 14                	jbe    800483 <_main+0x44b>
  80046f:	83 ec 04             	sub    $0x4,%esp
  800472:	68 10 35 80 00       	push   $0x803510
  800477:	6a 63                	push   $0x63
  800479:	68 fc 34 80 00       	push   $0x8034fc
  80047e:	e8 11 15 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800483:	e8 c9 29 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800488:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80048b:	83 f8 01             	cmp    $0x1,%eax
  80048e:	74 14                	je     8004a4 <_main+0x46c>
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	68 78 35 80 00       	push   $0x803578
  800498:	6a 64                	push   $0x64
  80049a:	68 fc 34 80 00       	push   $0x8034fc
  80049f:	e8 f0 14 00 00       	call   801994 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004a4:	e8 25 29 00 00       	call   802dce <sys_calculate_free_frames>
  8004a9:	89 45 c0             	mov    %eax,-0x40(%ebp)
		intArr = (int *) ptr_allocations[2];
  8004ac:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  8004b2:	89 45 8c             	mov    %eax,-0x74(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  8004b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004b8:	01 c0                	add    %eax,%eax
  8004ba:	c1 e8 02             	shr    $0x2,%eax
  8004bd:	48                   	dec    %eax
  8004be:	89 45 88             	mov    %eax,-0x78(%ebp)
		intArr[0] = minInt;
  8004c1:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004c4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8004c7:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8004c9:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d3:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004d6:	01 c2                	add    %eax,%edx
  8004d8:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8004db:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8004dd:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8004e0:	e8 e9 28 00 00       	call   802dce <sys_calculate_free_frames>
  8004e5:	29 c3                	sub    %eax,%ebx
  8004e7:	89 d8                	mov    %ebx,%eax
  8004e9:	83 f8 02             	cmp    $0x2,%eax
  8004ec:	74 14                	je     800502 <_main+0x4ca>
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	68 a8 35 80 00       	push   $0x8035a8
  8004f6:	6a 6b                	push   $0x6b
  8004f8:	68 fc 34 80 00       	push   $0x8034fc
  8004fd:	e8 92 14 00 00       	call   801994 <_panic>
		found = 0;
  800502:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800509:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800510:	e9 95 00 00 00       	jmp    8005aa <_main+0x572>
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
  800530:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800533:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800536:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053b:	89 c2                	mov    %eax,%edx
  80053d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800540:	89 45 80             	mov    %eax,-0x80(%ebp)
  800543:	8b 45 80             	mov    -0x80(%ebp),%eax
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
  80056d:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  800573:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800579:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80057e:	89 c2                	mov    %eax,%edx
  800580:	8b 45 88             	mov    -0x78(%ebp),%eax
  800583:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80058a:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80058d:	01 c8                	add    %ecx,%eax
  80058f:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  800595:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80059b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005a0:	39 c2                	cmp    %eax,%edx
  8005a2:	75 03                	jne    8005a7 <_main+0x56f>
				found++;
  8005a4:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8005a7:	ff 45 ec             	incl   -0x14(%ebp)
  8005aa:	a1 20 40 80 00       	mov    0x804020,%eax
  8005af:	8b 50 74             	mov    0x74(%eax),%edx
  8005b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005b5:	39 c2                	cmp    %eax,%edx
  8005b7:	0f 87 58 ff ff ff    	ja     800515 <_main+0x4dd>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005bd:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005c1:	74 14                	je     8005d7 <_main+0x59f>
  8005c3:	83 ec 04             	sub    $0x4,%esp
  8005c6:	68 ec 35 80 00       	push   $0x8035ec
  8005cb:	6a 74                	push   $0x74
  8005cd:	68 fc 34 80 00       	push   $0x8034fc
  8005d2:	e8 bd 13 00 00       	call   801994 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8005d7:	e8 f2 27 00 00       	call   802dce <sys_calculate_free_frames>
  8005dc:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005df:	e8 6d 28 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8005e4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8005e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ea:	01 c0                	add    %eax,%eax
  8005ec:	83 ec 0c             	sub    $0xc,%esp
  8005ef:	50                   	push   %eax
  8005f0:	e8 17 24 00 00       	call   802a0c <malloc>
  8005f5:	83 c4 10             	add    $0x10,%esp
  8005f8:	89 85 74 fe ff ff    	mov    %eax,-0x18c(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005fe:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  800604:	89 c2                	mov    %eax,%edx
  800606:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800609:	c1 e0 02             	shl    $0x2,%eax
  80060c:	89 c1                	mov    %eax,%ecx
  80060e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800611:	c1 e0 02             	shl    $0x2,%eax
  800614:	01 c8                	add    %ecx,%eax
  800616:	05 00 00 00 80       	add    $0x80000000,%eax
  80061b:	39 c2                	cmp    %eax,%edx
  80061d:	72 21                	jb     800640 <_main+0x608>
  80061f:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  800625:	89 c2                	mov    %eax,%edx
  800627:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80062a:	c1 e0 02             	shl    $0x2,%eax
  80062d:	89 c1                	mov    %eax,%ecx
  80062f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800632:	c1 e0 02             	shl    $0x2,%eax
  800635:	01 c8                	add    %ecx,%eax
  800637:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80063c:	39 c2                	cmp    %eax,%edx
  80063e:	76 14                	jbe    800654 <_main+0x61c>
  800640:	83 ec 04             	sub    $0x4,%esp
  800643:	68 10 35 80 00       	push   $0x803510
  800648:	6a 7a                	push   $0x7a
  80064a:	68 fc 34 80 00       	push   $0x8034fc
  80064f:	e8 40 13 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800654:	e8 f8 27 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800659:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80065c:	83 f8 01             	cmp    $0x1,%eax
  80065f:	74 14                	je     800675 <_main+0x63d>
  800661:	83 ec 04             	sub    $0x4,%esp
  800664:	68 78 35 80 00       	push   $0x803578
  800669:	6a 7b                	push   $0x7b
  80066b:	68 fc 34 80 00       	push   $0x8034fc
  800670:	e8 1f 13 00 00       	call   801994 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800675:	e8 d7 27 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  80067a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80067d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800680:	89 d0                	mov    %edx,%eax
  800682:	01 c0                	add    %eax,%eax
  800684:	01 d0                	add    %edx,%eax
  800686:	01 c0                	add    %eax,%eax
  800688:	01 d0                	add    %edx,%eax
  80068a:	83 ec 0c             	sub    $0xc,%esp
  80068d:	50                   	push   %eax
  80068e:	e8 79 23 00 00       	call   802a0c <malloc>
  800693:	83 c4 10             	add    $0x10,%esp
  800696:	89 85 78 fe ff ff    	mov    %eax,-0x188(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80069c:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  8006a2:	89 c2                	mov    %eax,%edx
  8006a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a7:	c1 e0 02             	shl    $0x2,%eax
  8006aa:	89 c1                	mov    %eax,%ecx
  8006ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006af:	c1 e0 03             	shl    $0x3,%eax
  8006b2:	01 c8                	add    %ecx,%eax
  8006b4:	05 00 00 00 80       	add    $0x80000000,%eax
  8006b9:	39 c2                	cmp    %eax,%edx
  8006bb:	72 21                	jb     8006de <_main+0x6a6>
  8006bd:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  8006c3:	89 c2                	mov    %eax,%edx
  8006c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c8:	c1 e0 02             	shl    $0x2,%eax
  8006cb:	89 c1                	mov    %eax,%ecx
  8006cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006d0:	c1 e0 03             	shl    $0x3,%eax
  8006d3:	01 c8                	add    %ecx,%eax
  8006d5:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006da:	39 c2                	cmp    %eax,%edx
  8006dc:	76 17                	jbe    8006f5 <_main+0x6bd>
  8006de:	83 ec 04             	sub    $0x4,%esp
  8006e1:	68 10 35 80 00       	push   $0x803510
  8006e6:	68 81 00 00 00       	push   $0x81
  8006eb:	68 fc 34 80 00       	push   $0x8034fc
  8006f0:	e8 9f 12 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006f5:	e8 57 27 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8006fa:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8006fd:	83 f8 02             	cmp    $0x2,%eax
  800700:	74 17                	je     800719 <_main+0x6e1>
  800702:	83 ec 04             	sub    $0x4,%esp
  800705:	68 78 35 80 00       	push   $0x803578
  80070a:	68 82 00 00 00       	push   $0x82
  80070f:	68 fc 34 80 00       	push   $0x8034fc
  800714:	e8 7b 12 00 00       	call   801994 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800719:	e8 b0 26 00 00       	call   802dce <sys_calculate_free_frames>
  80071e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  800721:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  800727:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  80072d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800730:	89 d0                	mov    %edx,%eax
  800732:	01 c0                	add    %eax,%eax
  800734:	01 d0                	add    %edx,%eax
  800736:	01 c0                	add    %eax,%eax
  800738:	01 d0                	add    %edx,%eax
  80073a:	c1 e8 03             	shr    $0x3,%eax
  80073d:	48                   	dec    %eax
  80073e:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  800744:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80074a:	8a 55 db             	mov    -0x25(%ebp),%dl
  80074d:	88 10                	mov    %dl,(%eax)
  80074f:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
  800755:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800758:	66 89 42 02          	mov    %ax,0x2(%edx)
  80075c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800762:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800765:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800768:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80076e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800775:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80077b:	01 c2                	add    %eax,%edx
  80077d:	8a 45 da             	mov    -0x26(%ebp),%al
  800780:	88 02                	mov    %al,(%edx)
  800782:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800788:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80078f:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800795:	01 c2                	add    %eax,%edx
  800797:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  80079b:	66 89 42 02          	mov    %ax,0x2(%edx)
  80079f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007a5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007ac:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8007b2:	01 c2                	add    %eax,%edx
  8007b4:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007b7:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007ba:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8007bd:	e8 0c 26 00 00       	call   802dce <sys_calculate_free_frames>
  8007c2:	29 c3                	sub    %eax,%ebx
  8007c4:	89 d8                	mov    %ebx,%eax
  8007c6:	83 f8 02             	cmp    $0x2,%eax
  8007c9:	74 17                	je     8007e2 <_main+0x7aa>
  8007cb:	83 ec 04             	sub    $0x4,%esp
  8007ce:	68 a8 35 80 00       	push   $0x8035a8
  8007d3:	68 89 00 00 00       	push   $0x89
  8007d8:	68 fc 34 80 00       	push   $0x8034fc
  8007dd:	e8 b2 11 00 00       	call   801994 <_panic>
		found = 0;
  8007e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007f0:	e9 aa 00 00 00       	jmp    80089f <_main+0x867>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8007fa:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800800:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800803:	89 d0                	mov    %edx,%eax
  800805:	01 c0                	add    %eax,%eax
  800807:	01 d0                	add    %edx,%eax
  800809:	c1 e0 02             	shl    $0x2,%eax
  80080c:	01 c8                	add    %ecx,%eax
  80080e:	8b 00                	mov    (%eax),%eax
  800810:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800816:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80081c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800821:	89 c2                	mov    %eax,%edx
  800823:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800829:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  80082f:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800835:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80083a:	39 c2                	cmp    %eax,%edx
  80083c:	75 03                	jne    800841 <_main+0x809>
				found++;
  80083e:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  800841:	a1 20 40 80 00       	mov    0x804020,%eax
  800846:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80084c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80084f:	89 d0                	mov    %edx,%eax
  800851:	01 c0                	add    %eax,%eax
  800853:	01 d0                	add    %edx,%eax
  800855:	c1 e0 02             	shl    $0x2,%eax
  800858:	01 c8                	add    %ecx,%eax
  80085a:	8b 00                	mov    (%eax),%eax
  80085c:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800862:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800868:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80086d:	89 c2                	mov    %eax,%edx
  80086f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800875:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80087c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800882:	01 c8                	add    %ecx,%eax
  800884:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  80088a:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800890:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800895:	39 c2                	cmp    %eax,%edx
  800897:	75 03                	jne    80089c <_main+0x864>
				found++;
  800899:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80089c:	ff 45 ec             	incl   -0x14(%ebp)
  80089f:	a1 20 40 80 00       	mov    0x804020,%eax
  8008a4:	8b 50 74             	mov    0x74(%eax),%edx
  8008a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008aa:	39 c2                	cmp    %eax,%edx
  8008ac:	0f 87 43 ff ff ff    	ja     8007f5 <_main+0x7bd>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8008b2:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008b6:	74 17                	je     8008cf <_main+0x897>
  8008b8:	83 ec 04             	sub    $0x4,%esp
  8008bb:	68 ec 35 80 00       	push   $0x8035ec
  8008c0:	68 92 00 00 00       	push   $0x92
  8008c5:	68 fc 34 80 00       	push   $0x8034fc
  8008ca:	e8 c5 10 00 00       	call   801994 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008cf:	e8 fa 24 00 00       	call   802dce <sys_calculate_free_frames>
  8008d4:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008d7:	e8 75 25 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8008dc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008df:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e2:	89 c2                	mov    %eax,%edx
  8008e4:	01 d2                	add    %edx,%edx
  8008e6:	01 d0                	add    %edx,%eax
  8008e8:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008eb:	83 ec 0c             	sub    $0xc,%esp
  8008ee:	50                   	push   %eax
  8008ef:	e8 18 21 00 00       	call   802a0c <malloc>
  8008f4:	83 c4 10             	add    $0x10,%esp
  8008f7:	89 85 7c fe ff ff    	mov    %eax,-0x184(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8008fd:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  800903:	89 c2                	mov    %eax,%edx
  800905:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800908:	c1 e0 02             	shl    $0x2,%eax
  80090b:	89 c1                	mov    %eax,%ecx
  80090d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800910:	c1 e0 04             	shl    $0x4,%eax
  800913:	01 c8                	add    %ecx,%eax
  800915:	05 00 00 00 80       	add    $0x80000000,%eax
  80091a:	39 c2                	cmp    %eax,%edx
  80091c:	72 21                	jb     80093f <_main+0x907>
  80091e:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  800924:	89 c2                	mov    %eax,%edx
  800926:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800929:	c1 e0 02             	shl    $0x2,%eax
  80092c:	89 c1                	mov    %eax,%ecx
  80092e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800931:	c1 e0 04             	shl    $0x4,%eax
  800934:	01 c8                	add    %ecx,%eax
  800936:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80093b:	39 c2                	cmp    %eax,%edx
  80093d:	76 17                	jbe    800956 <_main+0x91e>
  80093f:	83 ec 04             	sub    $0x4,%esp
  800942:	68 10 35 80 00       	push   $0x803510
  800947:	68 98 00 00 00       	push   $0x98
  80094c:	68 fc 34 80 00       	push   $0x8034fc
  800951:	e8 3e 10 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800956:	e8 f6 24 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  80095b:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80095e:	89 c2                	mov    %eax,%edx
  800960:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800963:	89 c1                	mov    %eax,%ecx
  800965:	01 c9                	add    %ecx,%ecx
  800967:	01 c8                	add    %ecx,%eax
  800969:	85 c0                	test   %eax,%eax
  80096b:	79 05                	jns    800972 <_main+0x93a>
  80096d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800972:	c1 f8 0c             	sar    $0xc,%eax
  800975:	39 c2                	cmp    %eax,%edx
  800977:	74 17                	je     800990 <_main+0x958>
  800979:	83 ec 04             	sub    $0x4,%esp
  80097c:	68 78 35 80 00       	push   $0x803578
  800981:	68 99 00 00 00       	push   $0x99
  800986:	68 fc 34 80 00       	push   $0x8034fc
  80098b:	e8 04 10 00 00       	call   801994 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800990:	e8 bc 24 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800995:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800998:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80099b:	89 d0                	mov    %edx,%eax
  80099d:	01 c0                	add    %eax,%eax
  80099f:	01 d0                	add    %edx,%eax
  8009a1:	01 c0                	add    %eax,%eax
  8009a3:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8009a6:	83 ec 0c             	sub    $0xc,%esp
  8009a9:	50                   	push   %eax
  8009aa:	e8 5d 20 00 00       	call   802a0c <malloc>
  8009af:	83 c4 10             	add    $0x10,%esp
  8009b2:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009b8:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8009be:	89 c1                	mov    %eax,%ecx
  8009c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009c3:	89 d0                	mov    %edx,%eax
  8009c5:	01 c0                	add    %eax,%eax
  8009c7:	01 d0                	add    %edx,%eax
  8009c9:	01 c0                	add    %eax,%eax
  8009cb:	01 d0                	add    %edx,%eax
  8009cd:	89 c2                	mov    %eax,%edx
  8009cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009d2:	c1 e0 04             	shl    $0x4,%eax
  8009d5:	01 d0                	add    %edx,%eax
  8009d7:	05 00 00 00 80       	add    $0x80000000,%eax
  8009dc:	39 c1                	cmp    %eax,%ecx
  8009de:	72 28                	jb     800a08 <_main+0x9d0>
  8009e0:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8009e6:	89 c1                	mov    %eax,%ecx
  8009e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009eb:	89 d0                	mov    %edx,%eax
  8009ed:	01 c0                	add    %eax,%eax
  8009ef:	01 d0                	add    %edx,%eax
  8009f1:	01 c0                	add    %eax,%eax
  8009f3:	01 d0                	add    %edx,%eax
  8009f5:	89 c2                	mov    %eax,%edx
  8009f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009fa:	c1 e0 04             	shl    $0x4,%eax
  8009fd:	01 d0                	add    %edx,%eax
  8009ff:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800a04:	39 c1                	cmp    %eax,%ecx
  800a06:	76 17                	jbe    800a1f <_main+0x9e7>
  800a08:	83 ec 04             	sub    $0x4,%esp
  800a0b:	68 10 35 80 00       	push   $0x803510
  800a10:	68 9f 00 00 00       	push   $0x9f
  800a15:	68 fc 34 80 00       	push   $0x8034fc
  800a1a:	e8 75 0f 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a1f:	e8 2d 24 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800a24:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800a27:	89 c1                	mov    %eax,%ecx
  800a29:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a2c:	89 d0                	mov    %edx,%eax
  800a2e:	01 c0                	add    %eax,%eax
  800a30:	01 d0                	add    %edx,%eax
  800a32:	01 c0                	add    %eax,%eax
  800a34:	85 c0                	test   %eax,%eax
  800a36:	79 05                	jns    800a3d <_main+0xa05>
  800a38:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a3d:	c1 f8 0c             	sar    $0xc,%eax
  800a40:	39 c1                	cmp    %eax,%ecx
  800a42:	74 17                	je     800a5b <_main+0xa23>
  800a44:	83 ec 04             	sub    $0x4,%esp
  800a47:	68 78 35 80 00       	push   $0x803578
  800a4c:	68 a0 00 00 00       	push   $0xa0
  800a51:	68 fc 34 80 00       	push   $0x8034fc
  800a56:	e8 39 0f 00 00       	call   801994 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a5b:	e8 6e 23 00 00       	call   802dce <sys_calculate_free_frames>
  800a60:	89 45 c0             	mov    %eax,-0x40(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a63:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a66:	89 d0                	mov    %edx,%eax
  800a68:	01 c0                	add    %eax,%eax
  800a6a:	01 d0                	add    %edx,%eax
  800a6c:	01 c0                	add    %eax,%eax
  800a6e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a71:	48                   	dec    %eax
  800a72:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a78:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  800a7e:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2[0] = minByte ;
  800a84:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800a8a:	8a 55 db             	mov    -0x25(%ebp),%dl
  800a8d:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a8f:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800a95:	89 c2                	mov    %eax,%edx
  800a97:	c1 ea 1f             	shr    $0x1f,%edx
  800a9a:	01 d0                	add    %edx,%eax
  800a9c:	d1 f8                	sar    %eax
  800a9e:	89 c2                	mov    %eax,%edx
  800aa0:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aa6:	01 c2                	add    %eax,%edx
  800aa8:	8a 45 da             	mov    -0x26(%ebp),%al
  800aab:	88 c1                	mov    %al,%cl
  800aad:	c0 e9 07             	shr    $0x7,%cl
  800ab0:	01 c8                	add    %ecx,%eax
  800ab2:	d0 f8                	sar    %al
  800ab4:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800ab6:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800abc:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ac2:	01 c2                	add    %eax,%edx
  800ac4:	8a 45 da             	mov    -0x26(%ebp),%al
  800ac7:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ac9:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800acc:	e8 fd 22 00 00       	call   802dce <sys_calculate_free_frames>
  800ad1:	29 c3                	sub    %eax,%ebx
  800ad3:	89 d8                	mov    %ebx,%eax
  800ad5:	83 f8 05             	cmp    $0x5,%eax
  800ad8:	74 17                	je     800af1 <_main+0xab9>
  800ada:	83 ec 04             	sub    $0x4,%esp
  800add:	68 a8 35 80 00       	push   $0x8035a8
  800ae2:	68 a8 00 00 00       	push   $0xa8
  800ae7:	68 fc 34 80 00       	push   $0x8034fc
  800aec:	e8 a3 0e 00 00       	call   801994 <_panic>
		found = 0;
  800af1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800af8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800aff:	e9 02 01 00 00       	jmp    800c06 <_main+0xbce>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b04:	a1 20 40 80 00       	mov    0x804020,%eax
  800b09:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b0f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b12:	89 d0                	mov    %edx,%eax
  800b14:	01 c0                	add    %eax,%eax
  800b16:	01 d0                	add    %edx,%eax
  800b18:	c1 e0 02             	shl    $0x2,%eax
  800b1b:	01 c8                	add    %ecx,%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800b25:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b30:	89 c2                	mov    %eax,%edx
  800b32:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b38:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b3e:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b44:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b49:	39 c2                	cmp    %eax,%edx
  800b4b:	75 03                	jne    800b50 <_main+0xb18>
				found++;
  800b4d:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b50:	a1 20 40 80 00       	mov    0x804020,%eax
  800b55:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b5b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b5e:	89 d0                	mov    %edx,%eax
  800b60:	01 c0                	add    %eax,%eax
  800b62:	01 d0                	add    %edx,%eax
  800b64:	c1 e0 02             	shl    $0x2,%eax
  800b67:	01 c8                	add    %ecx,%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b71:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b77:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b7c:	89 c2                	mov    %eax,%edx
  800b7e:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b84:	89 c1                	mov    %eax,%ecx
  800b86:	c1 e9 1f             	shr    $0x1f,%ecx
  800b89:	01 c8                	add    %ecx,%eax
  800b8b:	d1 f8                	sar    %eax
  800b8d:	89 c1                	mov    %eax,%ecx
  800b8f:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b95:	01 c8                	add    %ecx,%eax
  800b97:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800b9d:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800ba3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ba8:	39 c2                	cmp    %eax,%edx
  800baa:	75 03                	jne    800baf <_main+0xb77>
				found++;
  800bac:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800baf:	a1 20 40 80 00       	mov    0x804020,%eax
  800bb4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bba:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bbd:	89 d0                	mov    %edx,%eax
  800bbf:	01 c0                	add    %eax,%eax
  800bc1:	01 d0                	add    %edx,%eax
  800bc3:	c1 e0 02             	shl    $0x2,%eax
  800bc6:	01 c8                	add    %ecx,%eax
  800bc8:	8b 00                	mov    (%eax),%eax
  800bca:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800bd0:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800bd6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bdb:	89 c1                	mov    %eax,%ecx
  800bdd:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800be3:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800be9:	01 d0                	add    %edx,%eax
  800beb:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800bf1:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800bf7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bfc:	39 c1                	cmp    %eax,%ecx
  800bfe:	75 03                	jne    800c03 <_main+0xbcb>
				found++;
  800c00:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c03:	ff 45 ec             	incl   -0x14(%ebp)
  800c06:	a1 20 40 80 00       	mov    0x804020,%eax
  800c0b:	8b 50 74             	mov    0x74(%eax),%edx
  800c0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c11:	39 c2                	cmp    %eax,%edx
  800c13:	0f 87 eb fe ff ff    	ja     800b04 <_main+0xacc>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c19:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c1d:	74 17                	je     800c36 <_main+0xbfe>
  800c1f:	83 ec 04             	sub    $0x4,%esp
  800c22:	68 ec 35 80 00       	push   $0x8035ec
  800c27:	68 b3 00 00 00       	push   $0xb3
  800c2c:	68 fc 34 80 00       	push   $0x8034fc
  800c31:	e8 5e 0d 00 00       	call   801994 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c36:	e8 16 22 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800c3b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c3e:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c41:	89 d0                	mov    %edx,%eax
  800c43:	01 c0                	add    %eax,%eax
  800c45:	01 d0                	add    %edx,%eax
  800c47:	01 c0                	add    %eax,%eax
  800c49:	01 d0                	add    %edx,%eax
  800c4b:	01 c0                	add    %eax,%eax
  800c4d:	83 ec 0c             	sub    $0xc,%esp
  800c50:	50                   	push   %eax
  800c51:	e8 b6 1d 00 00       	call   802a0c <malloc>
  800c56:	83 c4 10             	add    $0x10,%esp
  800c59:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c5f:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800c65:	89 c1                	mov    %eax,%ecx
  800c67:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c6a:	89 d0                	mov    %edx,%eax
  800c6c:	01 c0                	add    %eax,%eax
  800c6e:	01 d0                	add    %edx,%eax
  800c70:	c1 e0 02             	shl    $0x2,%eax
  800c73:	01 d0                	add    %edx,%eax
  800c75:	89 c2                	mov    %eax,%edx
  800c77:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c7a:	c1 e0 04             	shl    $0x4,%eax
  800c7d:	01 d0                	add    %edx,%eax
  800c7f:	05 00 00 00 80       	add    $0x80000000,%eax
  800c84:	39 c1                	cmp    %eax,%ecx
  800c86:	72 29                	jb     800cb1 <_main+0xc79>
  800c88:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800c8e:	89 c1                	mov    %eax,%ecx
  800c90:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c93:	89 d0                	mov    %edx,%eax
  800c95:	01 c0                	add    %eax,%eax
  800c97:	01 d0                	add    %edx,%eax
  800c99:	c1 e0 02             	shl    $0x2,%eax
  800c9c:	01 d0                	add    %edx,%eax
  800c9e:	89 c2                	mov    %eax,%edx
  800ca0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ca3:	c1 e0 04             	shl    $0x4,%eax
  800ca6:	01 d0                	add    %edx,%eax
  800ca8:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800cad:	39 c1                	cmp    %eax,%ecx
  800caf:	76 17                	jbe    800cc8 <_main+0xc90>
  800cb1:	83 ec 04             	sub    $0x4,%esp
  800cb4:	68 10 35 80 00       	push   $0x803510
  800cb9:	68 b8 00 00 00       	push   $0xb8
  800cbe:	68 fc 34 80 00       	push   $0x8034fc
  800cc3:	e8 cc 0c 00 00       	call   801994 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc8:	e8 84 21 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800ccd:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800cd0:	83 f8 04             	cmp    $0x4,%eax
  800cd3:	74 17                	je     800cec <_main+0xcb4>
  800cd5:	83 ec 04             	sub    $0x4,%esp
  800cd8:	68 78 35 80 00       	push   $0x803578
  800cdd:	68 b9 00 00 00       	push   $0xb9
  800ce2:	68 fc 34 80 00       	push   $0x8034fc
  800ce7:	e8 a8 0c 00 00       	call   801994 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800cec:	e8 dd 20 00 00       	call   802dce <sys_calculate_free_frames>
  800cf1:	89 45 c0             	mov    %eax,-0x40(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cf4:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800cfa:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800d00:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800d03:	89 d0                	mov    %edx,%eax
  800d05:	01 c0                	add    %eax,%eax
  800d07:	01 d0                	add    %edx,%eax
  800d09:	01 c0                	add    %eax,%eax
  800d0b:	01 d0                	add    %edx,%eax
  800d0d:	01 c0                	add    %eax,%eax
  800d0f:	d1 e8                	shr    %eax
  800d11:	48                   	dec    %eax
  800d12:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		shortArr2[0] = minShort;
  800d18:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800d1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d21:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d24:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d2a:	01 c0                	add    %eax,%eax
  800d2c:	89 c2                	mov    %eax,%edx
  800d2e:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d34:	01 c2                	add    %eax,%edx
  800d36:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800d3a:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d3d:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800d40:	e8 89 20 00 00       	call   802dce <sys_calculate_free_frames>
  800d45:	29 c3                	sub    %eax,%ebx
  800d47:	89 d8                	mov    %ebx,%eax
  800d49:	83 f8 02             	cmp    $0x2,%eax
  800d4c:	74 17                	je     800d65 <_main+0xd2d>
  800d4e:	83 ec 04             	sub    $0x4,%esp
  800d51:	68 a8 35 80 00       	push   $0x8035a8
  800d56:	68 c0 00 00 00       	push   $0xc0
  800d5b:	68 fc 34 80 00       	push   $0x8034fc
  800d60:	e8 2f 0c 00 00       	call   801994 <_panic>
		found = 0;
  800d65:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d6c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d73:	e9 a7 00 00 00       	jmp    800e1f <_main+0xde7>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d78:	a1 20 40 80 00       	mov    0x804020,%eax
  800d7d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d83:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d86:	89 d0                	mov    %edx,%eax
  800d88:	01 c0                	add    %eax,%eax
  800d8a:	01 d0                	add    %edx,%eax
  800d8c:	c1 e0 02             	shl    $0x2,%eax
  800d8f:	01 c8                	add    %ecx,%eax
  800d91:	8b 00                	mov    (%eax),%eax
  800d93:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d99:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d9f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800da4:	89 c2                	mov    %eax,%edx
  800da6:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800dac:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800db2:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800db8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dbd:	39 c2                	cmp    %eax,%edx
  800dbf:	75 03                	jne    800dc4 <_main+0xd8c>
				found++;
  800dc1:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dc4:	a1 20 40 80 00       	mov    0x804020,%eax
  800dc9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800dcf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dd2:	89 d0                	mov    %edx,%eax
  800dd4:	01 c0                	add    %eax,%eax
  800dd6:	01 d0                	add    %edx,%eax
  800dd8:	c1 e0 02             	shl    $0x2,%eax
  800ddb:	01 c8                	add    %ecx,%eax
  800ddd:	8b 00                	mov    (%eax),%eax
  800ddf:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800de5:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800deb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800df0:	89 c2                	mov    %eax,%edx
  800df2:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800df8:	01 c0                	add    %eax,%eax
  800dfa:	89 c1                	mov    %eax,%ecx
  800dfc:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800e02:	01 c8                	add    %ecx,%eax
  800e04:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800e0a:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800e10:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e15:	39 c2                	cmp    %eax,%edx
  800e17:	75 03                	jne    800e1c <_main+0xde4>
				found++;
  800e19:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e1c:	ff 45 ec             	incl   -0x14(%ebp)
  800e1f:	a1 20 40 80 00       	mov    0x804020,%eax
  800e24:	8b 50 74             	mov    0x74(%eax),%edx
  800e27:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e2a:	39 c2                	cmp    %eax,%edx
  800e2c:	0f 87 46 ff ff ff    	ja     800d78 <_main+0xd40>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e32:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e36:	74 17                	je     800e4f <_main+0xe17>
  800e38:	83 ec 04             	sub    $0x4,%esp
  800e3b:	68 ec 35 80 00       	push   $0x8035ec
  800e40:	68 c9 00 00 00       	push   $0xc9
  800e45:	68 fc 34 80 00       	push   $0x8034fc
  800e4a:	e8 45 0b 00 00       	call   801994 <_panic>
	}

	{
		//Free 1st 2 MB
		int freeFrames = sys_calculate_free_frames() ;
  800e4f:	e8 7a 1f 00 00       	call   802dce <sys_calculate_free_frames>
  800e54:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e5a:	e8 f2 1f 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800e5f:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[0]);
  800e65:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800e6b:	83 ec 0c             	sub    $0xc,%esp
  800e6e:	50                   	push   %eax
  800e6f:	e8 b9 1c 00 00       	call   802b2d <free>
  800e74:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800e77:	e8 d5 1f 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800e7c:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800e82:	29 c2                	sub    %eax,%edx
  800e84:	89 d0                	mov    %edx,%eax
  800e86:	3d 00 02 00 00       	cmp    $0x200,%eax
  800e8b:	74 17                	je     800ea4 <_main+0xe6c>
  800e8d:	83 ec 04             	sub    $0x4,%esp
  800e90:	68 0c 36 80 00       	push   $0x80360c
  800e95:	68 d1 00 00 00       	push   $0xd1
  800e9a:	68 fc 34 80 00       	push   $0x8034fc
  800e9f:	e8 f0 0a 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ea4:	e8 25 1f 00 00       	call   802dce <sys_calculate_free_frames>
  800ea9:	89 c2                	mov    %eax,%edx
  800eab:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800eb1:	29 c2                	sub    %eax,%edx
  800eb3:	89 d0                	mov    %edx,%eax
  800eb5:	83 f8 02             	cmp    $0x2,%eax
  800eb8:	74 17                	je     800ed1 <_main+0xe99>
  800eba:	83 ec 04             	sub    $0x4,%esp
  800ebd:	68 48 36 80 00       	push   $0x803648
  800ec2:	68 d2 00 00 00       	push   $0xd2
  800ec7:	68 fc 34 80 00       	push   $0x8034fc
  800ecc:	e8 c3 0a 00 00       	call   801994 <_panic>
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800ed1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800ed8:	e9 c2 00 00 00       	jmp    800f9f <_main+0xf67>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  800edd:	a1 20 40 80 00       	mov    0x804020,%eax
  800ee2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ee8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800eeb:	89 d0                	mov    %edx,%eax
  800eed:	01 c0                	add    %eax,%eax
  800eef:	01 d0                	add    %edx,%eax
  800ef1:	c1 e0 02             	shl    $0x2,%eax
  800ef4:	01 c8                	add    %ecx,%eax
  800ef6:	8b 00                	mov    (%eax),%eax
  800ef8:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  800efe:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  800f04:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f09:	89 c2                	mov    %eax,%edx
  800f0b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800f0e:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  800f14:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  800f1a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f1f:	39 c2                	cmp    %eax,%edx
  800f21:	75 17                	jne    800f3a <_main+0xf02>
				panic("free: page is not removed from WS");
  800f23:	83 ec 04             	sub    $0x4,%esp
  800f26:	68 94 36 80 00       	push   $0x803694
  800f2b:	68 d7 00 00 00       	push   $0xd7
  800f30:	68 fc 34 80 00       	push   $0x8034fc
  800f35:	e8 5a 0a 00 00       	call   801994 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800f3a:	a1 20 40 80 00       	mov    0x804020,%eax
  800f3f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800f45:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800f48:	89 d0                	mov    %edx,%eax
  800f4a:	01 c0                	add    %eax,%eax
  800f4c:	01 d0                	add    %edx,%eax
  800f4e:	c1 e0 02             	shl    $0x2,%eax
  800f51:	01 c8                	add    %ecx,%eax
  800f53:	8b 00                	mov    (%eax),%eax
  800f55:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  800f5b:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  800f61:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f66:	89 c1                	mov    %eax,%ecx
  800f68:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800f6b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800f6e:	01 d0                	add    %edx,%eax
  800f70:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  800f76:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  800f7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f81:	39 c1                	cmp    %eax,%ecx
  800f83:	75 17                	jne    800f9c <_main+0xf64>
				panic("free: page is not removed from WS");
  800f85:	83 ec 04             	sub    $0x4,%esp
  800f88:	68 94 36 80 00       	push   $0x803694
  800f8d:	68 d9 00 00 00       	push   $0xd9
  800f92:	68 fc 34 80 00       	push   $0x8034fc
  800f97:	e8 f8 09 00 00       	call   801994 <_panic>
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[0]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800f9c:	ff 45 e4             	incl   -0x1c(%ebp)
  800f9f:	a1 20 40 80 00       	mov    0x804020,%eax
  800fa4:	8b 50 74             	mov    0x74(%eax),%edx
  800fa7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800faa:	39 c2                	cmp    %eax,%edx
  800fac:	0f 87 2b ff ff ff    	ja     800edd <_main+0xea5>
				panic("free: page is not removed from WS");
		}


		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800fb2:	e8 17 1e 00 00       	call   802dce <sys_calculate_free_frames>
  800fb7:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800fbd:	e8 8f 1e 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800fc2:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[1]);
  800fc8:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  800fce:	83 ec 0c             	sub    $0xc,%esp
  800fd1:	50                   	push   %eax
  800fd2:	e8 56 1b 00 00       	call   802b2d <free>
  800fd7:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fda:	e8 72 1e 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  800fdf:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800fe5:	29 c2                	sub    %eax,%edx
  800fe7:	89 d0                	mov    %edx,%eax
  800fe9:	3d 00 02 00 00       	cmp    $0x200,%eax
  800fee:	74 17                	je     801007 <_main+0xfcf>
  800ff0:	83 ec 04             	sub    $0x4,%esp
  800ff3:	68 0c 36 80 00       	push   $0x80360c
  800ff8:	68 e1 00 00 00       	push   $0xe1
  800ffd:	68 fc 34 80 00       	push   $0x8034fc
  801002:	e8 8d 09 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801007:	e8 c2 1d 00 00       	call   802dce <sys_calculate_free_frames>
  80100c:	89 c2                	mov    %eax,%edx
  80100e:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801014:	29 c2                	sub    %eax,%edx
  801016:	89 d0                	mov    %edx,%eax
  801018:	83 f8 03             	cmp    $0x3,%eax
  80101b:	74 17                	je     801034 <_main+0xffc>
  80101d:	83 ec 04             	sub    $0x4,%esp
  801020:	68 48 36 80 00       	push   $0x803648
  801025:	68 e2 00 00 00       	push   $0xe2
  80102a:	68 fc 34 80 00       	push   $0x8034fc
  80102f:	e8 60 09 00 00       	call   801994 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801034:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80103b:	e9 c6 00 00 00       	jmp    801106 <_main+0x10ce>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  801040:	a1 20 40 80 00       	mov    0x804020,%eax
  801045:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80104b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80104e:	89 d0                	mov    %edx,%eax
  801050:	01 c0                	add    %eax,%eax
  801052:	01 d0                	add    %edx,%eax
  801054:	c1 e0 02             	shl    $0x2,%eax
  801057:	01 c8                	add    %ecx,%eax
  801059:	8b 00                	mov    (%eax),%eax
  80105b:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
  801061:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  801067:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80106c:	89 c2                	mov    %eax,%edx
  80106e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  801071:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  801077:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  80107d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801082:	39 c2                	cmp    %eax,%edx
  801084:	75 17                	jne    80109d <_main+0x1065>
				panic("free: page is not removed from WS");
  801086:	83 ec 04             	sub    $0x4,%esp
  801089:	68 94 36 80 00       	push   $0x803694
  80108e:	68 e6 00 00 00       	push   $0xe6
  801093:	68 fc 34 80 00       	push   $0x8034fc
  801098:	e8 f7 08 00 00       	call   801994 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  80109d:	a1 20 40 80 00       	mov    0x804020,%eax
  8010a2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8010a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8010ab:	89 d0                	mov    %edx,%eax
  8010ad:	01 c0                	add    %eax,%eax
  8010af:	01 d0                	add    %edx,%eax
  8010b1:	c1 e0 02             	shl    $0x2,%eax
  8010b4:	01 c8                	add    %ecx,%eax
  8010b6:	8b 00                	mov    (%eax),%eax
  8010b8:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  8010be:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  8010c4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010c9:	89 c2                	mov    %eax,%edx
  8010cb:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8010ce:	01 c0                	add    %eax,%eax
  8010d0:	89 c1                	mov    %eax,%ecx
  8010d2:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8010d5:	01 c8                	add    %ecx,%eax
  8010d7:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  8010dd:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  8010e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010e8:	39 c2                	cmp    %eax,%edx
  8010ea:	75 17                	jne    801103 <_main+0x10cb>
				panic("free: page is not removed from WS");
  8010ec:	83 ec 04             	sub    $0x4,%esp
  8010ef:	68 94 36 80 00       	push   $0x803694
  8010f4:	68 e8 00 00 00       	push   $0xe8
  8010f9:	68 fc 34 80 00       	push   $0x8034fc
  8010fe:	e8 91 08 00 00       	call   801994 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[1]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801103:	ff 45 e4             	incl   -0x1c(%ebp)
  801106:	a1 20 40 80 00       	mov    0x804020,%eax
  80110b:	8b 50 74             	mov    0x74(%eax),%edx
  80110e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801111:	39 c2                	cmp    %eax,%edx
  801113:	0f 87 27 ff ff ff    	ja     801040 <_main+0x1008>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 6 MB
		freeFrames = sys_calculate_free_frames() ;
  801119:	e8 b0 1c 00 00       	call   802dce <sys_calculate_free_frames>
  80111e:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801124:	e8 28 1d 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  801129:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[6]);
  80112f:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  801135:	83 ec 0c             	sub    $0xc,%esp
  801138:	50                   	push   %eax
  801139:	e8 ef 19 00 00       	call   802b2d <free>
  80113e:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  801141:	e8 0b 1d 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  801146:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80114c:	89 d1                	mov    %edx,%ecx
  80114e:	29 c1                	sub    %eax,%ecx
  801150:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801153:	89 d0                	mov    %edx,%eax
  801155:	01 c0                	add    %eax,%eax
  801157:	01 d0                	add    %edx,%eax
  801159:	01 c0                	add    %eax,%eax
  80115b:	85 c0                	test   %eax,%eax
  80115d:	79 05                	jns    801164 <_main+0x112c>
  80115f:	05 ff 0f 00 00       	add    $0xfff,%eax
  801164:	c1 f8 0c             	sar    $0xc,%eax
  801167:	39 c1                	cmp    %eax,%ecx
  801169:	74 17                	je     801182 <_main+0x114a>
  80116b:	83 ec 04             	sub    $0x4,%esp
  80116e:	68 0c 36 80 00       	push   $0x80360c
  801173:	68 ef 00 00 00       	push   $0xef
  801178:	68 fc 34 80 00       	push   $0x8034fc
  80117d:	e8 12 08 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801182:	e8 47 1c 00 00       	call   802dce <sys_calculate_free_frames>
  801187:	89 c2                	mov    %eax,%edx
  801189:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80118f:	29 c2                	sub    %eax,%edx
  801191:	89 d0                	mov    %edx,%eax
  801193:	83 f8 04             	cmp    $0x4,%eax
  801196:	74 17                	je     8011af <_main+0x1177>
  801198:	83 ec 04             	sub    $0x4,%esp
  80119b:	68 48 36 80 00       	push   $0x803648
  8011a0:	68 f0 00 00 00       	push   $0xf0
  8011a5:	68 fc 34 80 00       	push   $0x8034fc
  8011aa:	e8 e5 07 00 00       	call   801994 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8011af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8011b6:	e9 3e 01 00 00       	jmp    8012f9 <_main+0x12c1>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8011bb:	a1 20 40 80 00       	mov    0x804020,%eax
  8011c0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8011c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011c9:	89 d0                	mov    %edx,%eax
  8011cb:	01 c0                	add    %eax,%eax
  8011cd:	01 d0                	add    %edx,%eax
  8011cf:	c1 e0 02             	shl    $0x2,%eax
  8011d2:	01 c8                	add    %ecx,%eax
  8011d4:	8b 00                	mov    (%eax),%eax
  8011d6:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  8011dc:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  8011e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011e7:	89 c2                	mov    %eax,%edx
  8011e9:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8011ef:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
  8011f5:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  8011fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801200:	39 c2                	cmp    %eax,%edx
  801202:	75 17                	jne    80121b <_main+0x11e3>
				panic("free: page is not removed from WS");
  801204:	83 ec 04             	sub    $0x4,%esp
  801207:	68 94 36 80 00       	push   $0x803694
  80120c:	68 f4 00 00 00       	push   $0xf4
  801211:	68 fc 34 80 00       	push   $0x8034fc
  801216:	e8 79 07 00 00       	call   801994 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  80121b:	a1 20 40 80 00       	mov    0x804020,%eax
  801220:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801226:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801229:	89 d0                	mov    %edx,%eax
  80122b:	01 c0                	add    %eax,%eax
  80122d:	01 d0                	add    %edx,%eax
  80122f:	c1 e0 02             	shl    $0x2,%eax
  801232:	01 c8                	add    %ecx,%eax
  801234:	8b 00                	mov    (%eax),%eax
  801236:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  80123c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  801242:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801247:	89 c2                	mov    %eax,%edx
  801249:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  80124f:	89 c1                	mov    %eax,%ecx
  801251:	c1 e9 1f             	shr    $0x1f,%ecx
  801254:	01 c8                	add    %ecx,%eax
  801256:	d1 f8                	sar    %eax
  801258:	89 c1                	mov    %eax,%ecx
  80125a:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  801260:	01 c8                	add    %ecx,%eax
  801262:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
  801268:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  80126e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801273:	39 c2                	cmp    %eax,%edx
  801275:	75 17                	jne    80128e <_main+0x1256>
				panic("free: page is not removed from WS");
  801277:	83 ec 04             	sub    $0x4,%esp
  80127a:	68 94 36 80 00       	push   $0x803694
  80127f:	68 f6 00 00 00       	push   $0xf6
  801284:	68 fc 34 80 00       	push   $0x8034fc
  801289:	e8 06 07 00 00       	call   801994 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  80128e:	a1 20 40 80 00       	mov    0x804020,%eax
  801293:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801299:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80129c:	89 d0                	mov    %edx,%eax
  80129e:	01 c0                	add    %eax,%eax
  8012a0:	01 d0                	add    %edx,%eax
  8012a2:	c1 e0 02             	shl    $0x2,%eax
  8012a5:	01 c8                	add    %ecx,%eax
  8012a7:	8b 00                	mov    (%eax),%eax
  8012a9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  8012af:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8012b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012ba:	89 c1                	mov    %eax,%ecx
  8012bc:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  8012c2:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8012c8:	01 d0                	add    %edx,%eax
  8012ca:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
  8012d0:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  8012d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012db:	39 c1                	cmp    %eax,%ecx
  8012dd:	75 17                	jne    8012f6 <_main+0x12be>
				panic("free: page is not removed from WS");
  8012df:	83 ec 04             	sub    $0x4,%esp
  8012e2:	68 94 36 80 00       	push   $0x803694
  8012e7:	68 f8 00 00 00       	push   $0xf8
  8012ec:	68 fc 34 80 00       	push   $0x8034fc
  8012f1:	e8 9e 06 00 00       	call   801994 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[6]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8012f6:	ff 45 e4             	incl   -0x1c(%ebp)
  8012f9:	a1 20 40 80 00       	mov    0x804020,%eax
  8012fe:	8b 50 74             	mov    0x74(%eax),%edx
  801301:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801304:	39 c2                	cmp    %eax,%edx
  801306:	0f 87 af fe ff ff    	ja     8011bb <_main+0x1183>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  80130c:	e8 bd 1a 00 00       	call   802dce <sys_calculate_free_frames>
  801311:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801317:	e8 35 1b 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  80131c:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[4]);
  801322:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  801328:	83 ec 0c             	sub    $0xc,%esp
  80132b:	50                   	push   %eax
  80132c:	e8 fc 17 00 00       	call   802b2d <free>
  801331:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  801334:	e8 18 1b 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  801339:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80133f:	29 c2                	sub    %eax,%edx
  801341:	89 d0                	mov    %edx,%eax
  801343:	83 f8 02             	cmp    $0x2,%eax
  801346:	74 17                	je     80135f <_main+0x1327>
  801348:	83 ec 04             	sub    $0x4,%esp
  80134b:	68 0c 36 80 00       	push   $0x80360c
  801350:	68 ff 00 00 00       	push   $0xff
  801355:	68 fc 34 80 00       	push   $0x8034fc
  80135a:	e8 35 06 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80135f:	e8 6a 1a 00 00       	call   802dce <sys_calculate_free_frames>
  801364:	89 c2                	mov    %eax,%edx
  801366:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80136c:	29 c2                	sub    %eax,%edx
  80136e:	89 d0                	mov    %edx,%eax
  801370:	83 f8 02             	cmp    $0x2,%eax
  801373:	74 17                	je     80138c <_main+0x1354>
  801375:	83 ec 04             	sub    $0x4,%esp
  801378:	68 48 36 80 00       	push   $0x803648
  80137d:	68 00 01 00 00       	push   $0x100
  801382:	68 fc 34 80 00       	push   $0x8034fc
  801387:	e8 08 06 00 00       	call   801994 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80138c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801393:	e9 d2 00 00 00       	jmp    80146a <_main+0x1432>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  801398:	a1 20 40 80 00       	mov    0x804020,%eax
  80139d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8013a3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013a6:	89 d0                	mov    %edx,%eax
  8013a8:	01 c0                	add    %eax,%eax
  8013aa:	01 d0                	add    %edx,%eax
  8013ac:	c1 e0 02             	shl    $0x2,%eax
  8013af:	01 c8                	add    %ecx,%eax
  8013b1:	8b 00                	mov    (%eax),%eax
  8013b3:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
  8013b9:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8013bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013c4:	89 c2                	mov    %eax,%edx
  8013c6:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8013cc:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  8013d2:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8013d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013dd:	39 c2                	cmp    %eax,%edx
  8013df:	75 17                	jne    8013f8 <_main+0x13c0>
				panic("free: page is not removed from WS");
  8013e1:	83 ec 04             	sub    $0x4,%esp
  8013e4:	68 94 36 80 00       	push   $0x803694
  8013e9:	68 04 01 00 00       	push   $0x104
  8013ee:	68 fc 34 80 00       	push   $0x8034fc
  8013f3:	e8 9c 05 00 00       	call   801994 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  8013f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8013fd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801403:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801406:	89 d0                	mov    %edx,%eax
  801408:	01 c0                	add    %eax,%eax
  80140a:	01 d0                	add    %edx,%eax
  80140c:	c1 e0 02             	shl    $0x2,%eax
  80140f:	01 c8                	add    %ecx,%eax
  801411:	8b 00                	mov    (%eax),%eax
  801413:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
  801419:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80141f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801424:	89 c2                	mov    %eax,%edx
  801426:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80142c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  801433:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  801439:	01 c8                	add    %ecx,%eax
  80143b:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  801441:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  801447:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80144c:	39 c2                	cmp    %eax,%edx
  80144e:	75 17                	jne    801467 <_main+0x142f>
				panic("free: page is not removed from WS");
  801450:	83 ec 04             	sub    $0x4,%esp
  801453:	68 94 36 80 00       	push   $0x803694
  801458:	68 06 01 00 00       	push   $0x106
  80145d:	68 fc 34 80 00       	push   $0x8034fc
  801462:	e8 2d 05 00 00       	call   801994 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[4]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801467:	ff 45 e4             	incl   -0x1c(%ebp)
  80146a:	a1 20 40 80 00       	mov    0x804020,%eax
  80146f:	8b 50 74             	mov    0x74(%eax),%edx
  801472:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801475:	39 c2                	cmp    %eax,%edx
  801477:	0f 87 1b ff ff ff    	ja     801398 <_main+0x1360>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80147d:	e8 4c 19 00 00       	call   802dce <sys_calculate_free_frames>
  801482:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801488:	e8 c4 19 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  80148d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[5]);
  801493:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  801499:	83 ec 0c             	sub    $0xc,%esp
  80149c:	50                   	push   %eax
  80149d:	e8 8b 16 00 00       	call   802b2d <free>
  8014a2:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  8014a5:	e8 a7 19 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8014aa:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  8014b0:	89 d1                	mov    %edx,%ecx
  8014b2:	29 c1                	sub    %eax,%ecx
  8014b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014b7:	89 c2                	mov    %eax,%edx
  8014b9:	01 d2                	add    %edx,%edx
  8014bb:	01 d0                	add    %edx,%eax
  8014bd:	85 c0                	test   %eax,%eax
  8014bf:	79 05                	jns    8014c6 <_main+0x148e>
  8014c1:	05 ff 0f 00 00       	add    $0xfff,%eax
  8014c6:	c1 f8 0c             	sar    $0xc,%eax
  8014c9:	39 c1                	cmp    %eax,%ecx
  8014cb:	74 17                	je     8014e4 <_main+0x14ac>
  8014cd:	83 ec 04             	sub    $0x4,%esp
  8014d0:	68 0c 36 80 00       	push   $0x80360c
  8014d5:	68 0d 01 00 00       	push   $0x10d
  8014da:	68 fc 34 80 00       	push   $0x8034fc
  8014df:	e8 b0 04 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014e4:	e8 e5 18 00 00       	call   802dce <sys_calculate_free_frames>
  8014e9:	89 c2                	mov    %eax,%edx
  8014eb:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8014f1:	39 c2                	cmp    %eax,%edx
  8014f3:	74 17                	je     80150c <_main+0x14d4>
  8014f5:	83 ec 04             	sub    $0x4,%esp
  8014f8:	68 48 36 80 00       	push   $0x803648
  8014fd:	68 0e 01 00 00       	push   $0x10e
  801502:	68 fc 34 80 00       	push   $0x8034fc
  801507:	e8 88 04 00 00       	call   801994 <_panic>

		//Free 1st 2 KB
		freeFrames = sys_calculate_free_frames() ;
  80150c:	e8 bd 18 00 00       	call   802dce <sys_calculate_free_frames>
  801511:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801517:	e8 35 19 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  80151c:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[2]);
  801522:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  801528:	83 ec 0c             	sub    $0xc,%esp
  80152b:	50                   	push   %eax
  80152c:	e8 fc 15 00 00       	call   802b2d <free>
  801531:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  801534:	e8 18 19 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  801539:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80153f:	29 c2                	sub    %eax,%edx
  801541:	89 d0                	mov    %edx,%eax
  801543:	83 f8 01             	cmp    $0x1,%eax
  801546:	74 17                	je     80155f <_main+0x1527>
  801548:	83 ec 04             	sub    $0x4,%esp
  80154b:	68 0c 36 80 00       	push   $0x80360c
  801550:	68 14 01 00 00       	push   $0x114
  801555:	68 fc 34 80 00       	push   $0x8034fc
  80155a:	e8 35 04 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80155f:	e8 6a 18 00 00       	call   802dce <sys_calculate_free_frames>
  801564:	89 c2                	mov    %eax,%edx
  801566:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80156c:	29 c2                	sub    %eax,%edx
  80156e:	89 d0                	mov    %edx,%eax
  801570:	83 f8 02             	cmp    $0x2,%eax
  801573:	74 17                	je     80158c <_main+0x1554>
  801575:	83 ec 04             	sub    $0x4,%esp
  801578:	68 48 36 80 00       	push   $0x803648
  80157d:	68 15 01 00 00       	push   $0x115
  801582:	68 fc 34 80 00       	push   $0x8034fc
  801587:	e8 08 04 00 00       	call   801994 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80158c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801593:	e9 c9 00 00 00       	jmp    801661 <_main+0x1629>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  801598:	a1 20 40 80 00       	mov    0x804020,%eax
  80159d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8015a3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8015a6:	89 d0                	mov    %edx,%eax
  8015a8:	01 c0                	add    %eax,%eax
  8015aa:	01 d0                	add    %edx,%eax
  8015ac:	c1 e0 02             	shl    $0x2,%eax
  8015af:	01 c8                	add    %ecx,%eax
  8015b1:	8b 00                	mov    (%eax),%eax
  8015b3:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
  8015b9:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8015bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8015c4:	89 c2                	mov    %eax,%edx
  8015c6:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8015c9:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
  8015cf:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  8015d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8015da:	39 c2                	cmp    %eax,%edx
  8015dc:	75 17                	jne    8015f5 <_main+0x15bd>
				panic("free: page is not removed from WS");
  8015de:	83 ec 04             	sub    $0x4,%esp
  8015e1:	68 94 36 80 00       	push   $0x803694
  8015e6:	68 19 01 00 00       	push   $0x119
  8015eb:	68 fc 34 80 00       	push   $0x8034fc
  8015f0:	e8 9f 03 00 00       	call   801994 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  8015f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8015fa:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801600:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801603:	89 d0                	mov    %edx,%eax
  801605:	01 c0                	add    %eax,%eax
  801607:	01 d0                	add    %edx,%eax
  801609:	c1 e0 02             	shl    $0x2,%eax
  80160c:	01 c8                	add    %ecx,%eax
  80160e:	8b 00                	mov    (%eax),%eax
  801610:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
  801616:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  80161c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801621:	89 c2                	mov    %eax,%edx
  801623:	8b 45 88             	mov    -0x78(%ebp),%eax
  801626:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80162d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  801630:	01 c8                	add    %ecx,%eax
  801632:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
  801638:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80163e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801643:	39 c2                	cmp    %eax,%edx
  801645:	75 17                	jne    80165e <_main+0x1626>
				panic("free: page is not removed from WS");
  801647:	83 ec 04             	sub    $0x4,%esp
  80164a:	68 94 36 80 00       	push   $0x803694
  80164f:	68 1b 01 00 00       	push   $0x11b
  801654:	68 fc 34 80 00       	push   $0x8034fc
  801659:	e8 36 03 00 00       	call   801994 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[2]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80165e:	ff 45 e4             	incl   -0x1c(%ebp)
  801661:	a1 20 40 80 00       	mov    0x804020,%eax
  801666:	8b 50 74             	mov    0x74(%eax),%edx
  801669:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80166c:	39 c2                	cmp    %eax,%edx
  80166e:	0f 87 24 ff ff ff    	ja     801598 <_main+0x1560>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 2nd 2 KB
		freeFrames = sys_calculate_free_frames() ;
  801674:	e8 55 17 00 00       	call   802dce <sys_calculate_free_frames>
  801679:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80167f:	e8 cd 17 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  801684:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[3]);
  80168a:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  801690:	83 ec 0c             	sub    $0xc,%esp
  801693:	50                   	push   %eax
  801694:	e8 94 14 00 00       	call   802b2d <free>
  801699:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  80169c:	e8 b0 17 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8016a1:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  8016a7:	29 c2                	sub    %eax,%edx
  8016a9:	89 d0                	mov    %edx,%eax
  8016ab:	83 f8 01             	cmp    $0x1,%eax
  8016ae:	74 17                	je     8016c7 <_main+0x168f>
  8016b0:	83 ec 04             	sub    $0x4,%esp
  8016b3:	68 0c 36 80 00       	push   $0x80360c
  8016b8:	68 22 01 00 00       	push   $0x122
  8016bd:	68 fc 34 80 00       	push   $0x8034fc
  8016c2:	e8 cd 02 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8016c7:	e8 02 17 00 00       	call   802dce <sys_calculate_free_frames>
  8016cc:	89 c2                	mov    %eax,%edx
  8016ce:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8016d4:	39 c2                	cmp    %eax,%edx
  8016d6:	74 17                	je     8016ef <_main+0x16b7>
  8016d8:	83 ec 04             	sub    $0x4,%esp
  8016db:	68 48 36 80 00       	push   $0x803648
  8016e0:	68 23 01 00 00       	push   $0x123
  8016e5:	68 fc 34 80 00       	push   $0x8034fc
  8016ea:	e8 a5 02 00 00       	call   801994 <_panic>


		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  8016ef:	e8 da 16 00 00       	call   802dce <sys_calculate_free_frames>
  8016f4:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8016fa:	e8 52 17 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  8016ff:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[7]);
  801705:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80170b:	83 ec 0c             	sub    $0xc,%esp
  80170e:	50                   	push   %eax
  80170f:	e8 19 14 00 00       	call   802b2d <free>
  801714:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  801717:	e8 35 17 00 00       	call   802e51 <sys_pf_calculate_allocated_pages>
  80171c:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  801722:	29 c2                	sub    %eax,%edx
  801724:	89 d0                	mov    %edx,%eax
  801726:	83 f8 04             	cmp    $0x4,%eax
  801729:	74 17                	je     801742 <_main+0x170a>
  80172b:	83 ec 04             	sub    $0x4,%esp
  80172e:	68 0c 36 80 00       	push   $0x80360c
  801733:	68 2a 01 00 00       	push   $0x12a
  801738:	68 fc 34 80 00       	push   $0x8034fc
  80173d:	e8 52 02 00 00       	call   801994 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801742:	e8 87 16 00 00       	call   802dce <sys_calculate_free_frames>
  801747:	89 c2                	mov    %eax,%edx
  801749:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80174f:	29 c2                	sub    %eax,%edx
  801751:	89 d0                	mov    %edx,%eax
  801753:	83 f8 03             	cmp    $0x3,%eax
  801756:	74 17                	je     80176f <_main+0x1737>
  801758:	83 ec 04             	sub    $0x4,%esp
  80175b:	68 48 36 80 00       	push   $0x803648
  801760:	68 2b 01 00 00       	push   $0x12b
  801765:	68 fc 34 80 00       	push   $0x8034fc
  80176a:	e8 25 02 00 00       	call   801994 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80176f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801776:	e9 c6 00 00 00       	jmp    801841 <_main+0x1809>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  80177b:	a1 20 40 80 00       	mov    0x804020,%eax
  801780:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801786:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801789:	89 d0                	mov    %edx,%eax
  80178b:	01 c0                	add    %eax,%eax
  80178d:	01 d0                	add    %edx,%eax
  80178f:	c1 e0 02             	shl    $0x2,%eax
  801792:	01 c8                	add    %ecx,%eax
  801794:	8b 00                	mov    (%eax),%eax
  801796:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
  80179c:	8b 85 c4 fe ff ff    	mov    -0x13c(%ebp),%eax
  8017a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8017a7:	89 c2                	mov    %eax,%edx
  8017a9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8017ac:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
  8017b2:	8b 85 c0 fe ff ff    	mov    -0x140(%ebp),%eax
  8017b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8017bd:	39 c2                	cmp    %eax,%edx
  8017bf:	75 17                	jne    8017d8 <_main+0x17a0>
				panic("free: page is not removed from WS");
  8017c1:	83 ec 04             	sub    $0x4,%esp
  8017c4:	68 94 36 80 00       	push   $0x803694
  8017c9:	68 2f 01 00 00       	push   $0x12f
  8017ce:	68 fc 34 80 00       	push   $0x8034fc
  8017d3:	e8 bc 01 00 00       	call   801994 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8017d8:	a1 20 40 80 00       	mov    0x804020,%eax
  8017dd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8017e3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8017e6:	89 d0                	mov    %edx,%eax
  8017e8:	01 c0                	add    %eax,%eax
  8017ea:	01 d0                	add    %edx,%eax
  8017ec:	c1 e0 02             	shl    $0x2,%eax
  8017ef:	01 c8                	add    %ecx,%eax
  8017f1:	8b 00                	mov    (%eax),%eax
  8017f3:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
  8017f9:	8b 85 bc fe ff ff    	mov    -0x144(%ebp),%eax
  8017ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801804:	89 c2                	mov    %eax,%edx
  801806:	8b 45 a0             	mov    -0x60(%ebp),%eax
  801809:	01 c0                	add    %eax,%eax
  80180b:	89 c1                	mov    %eax,%ecx
  80180d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  801810:	01 c8                	add    %ecx,%eax
  801812:	89 85 b8 fe ff ff    	mov    %eax,-0x148(%ebp)
  801818:	8b 85 b8 fe ff ff    	mov    -0x148(%ebp),%eax
  80181e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801823:	39 c2                	cmp    %eax,%edx
  801825:	75 17                	jne    80183e <_main+0x1806>
				panic("free: page is not removed from WS");
  801827:	83 ec 04             	sub    $0x4,%esp
  80182a:	68 94 36 80 00       	push   $0x803694
  80182f:	68 31 01 00 00       	push   $0x131
  801834:	68 fc 34 80 00       	push   $0x8034fc
  801839:	e8 56 01 00 00       	call   801994 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[7]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80183e:	ff 45 e4             	incl   -0x1c(%ebp)
  801841:	a1 20 40 80 00       	mov    0x804020,%eax
  801846:	8b 50 74             	mov    0x74(%eax),%edx
  801849:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80184c:	39 c2                	cmp    %eax,%edx
  80184e:	0f 87 27 ff ff ff    	ja     80177b <_main+0x1743>
				panic("free: page is not removed from WS");
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  801854:	e8 75 15 00 00       	call   802dce <sys_calculate_free_frames>
  801859:	8d 50 04             	lea    0x4(%eax),%edx
  80185c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80185f:	39 c2                	cmp    %eax,%edx
  801861:	74 17                	je     80187a <_main+0x1842>
  801863:	83 ec 04             	sub    $0x4,%esp
  801866:	68 b8 36 80 00       	push   $0x8036b8
  80186b:	68 34 01 00 00       	push   $0x134
  801870:	68 fc 34 80 00       	push   $0x8034fc
  801875:	e8 1a 01 00 00       	call   801994 <_panic>
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
  80187a:	83 ec 0c             	sub    $0xc,%esp
  80187d:	68 ec 36 80 00       	push   $0x8036ec
  801882:	e8 c1 03 00 00       	call   801c48 <cprintf>
  801887:	83 c4 10             	add    $0x10,%esp

	return;
  80188a:	90                   	nop
}
  80188b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80188e:	5b                   	pop    %ebx
  80188f:	5f                   	pop    %edi
  801890:	5d                   	pop    %ebp
  801891:	c3                   	ret    

00801892 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
  801895:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801898:	e8 66 14 00 00       	call   802d03 <sys_getenvindex>
  80189d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8018a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018a3:	89 d0                	mov    %edx,%eax
  8018a5:	01 c0                	add    %eax,%eax
  8018a7:	01 d0                	add    %edx,%eax
  8018a9:	c1 e0 02             	shl    $0x2,%eax
  8018ac:	01 d0                	add    %edx,%eax
  8018ae:	c1 e0 06             	shl    $0x6,%eax
  8018b1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8018b6:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8018bb:	a1 20 40 80 00       	mov    0x804020,%eax
  8018c0:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8018c6:	84 c0                	test   %al,%al
  8018c8:	74 0f                	je     8018d9 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8018ca:	a1 20 40 80 00       	mov    0x804020,%eax
  8018cf:	05 f4 02 00 00       	add    $0x2f4,%eax
  8018d4:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8018d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018dd:	7e 0a                	jle    8018e9 <libmain+0x57>
		binaryname = argv[0];
  8018df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e2:	8b 00                	mov    (%eax),%eax
  8018e4:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8018e9:	83 ec 08             	sub    $0x8,%esp
  8018ec:	ff 75 0c             	pushl  0xc(%ebp)
  8018ef:	ff 75 08             	pushl  0x8(%ebp)
  8018f2:	e8 41 e7 ff ff       	call   800038 <_main>
  8018f7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8018fa:	e8 9f 15 00 00       	call   802e9e <sys_disable_interrupt>
	cprintf("**************************************\n");
  8018ff:	83 ec 0c             	sub    $0xc,%esp
  801902:	68 40 37 80 00       	push   $0x803740
  801907:	e8 3c 03 00 00       	call   801c48 <cprintf>
  80190c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80190f:	a1 20 40 80 00       	mov    0x804020,%eax
  801914:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80191a:	a1 20 40 80 00       	mov    0x804020,%eax
  80191f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  801925:	83 ec 04             	sub    $0x4,%esp
  801928:	52                   	push   %edx
  801929:	50                   	push   %eax
  80192a:	68 68 37 80 00       	push   $0x803768
  80192f:	e8 14 03 00 00       	call   801c48 <cprintf>
  801934:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801937:	a1 20 40 80 00       	mov    0x804020,%eax
  80193c:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  801942:	83 ec 08             	sub    $0x8,%esp
  801945:	50                   	push   %eax
  801946:	68 8d 37 80 00       	push   $0x80378d
  80194b:	e8 f8 02 00 00       	call   801c48 <cprintf>
  801950:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801953:	83 ec 0c             	sub    $0xc,%esp
  801956:	68 40 37 80 00       	push   $0x803740
  80195b:	e8 e8 02 00 00       	call   801c48 <cprintf>
  801960:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801963:	e8 50 15 00 00       	call   802eb8 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801968:	e8 19 00 00 00       	call   801986 <exit>
}
  80196d:	90                   	nop
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
  801973:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801976:	83 ec 0c             	sub    $0xc,%esp
  801979:	6a 00                	push   $0x0
  80197b:	e8 4f 13 00 00       	call   802ccf <sys_env_destroy>
  801980:	83 c4 10             	add    $0x10,%esp
}
  801983:	90                   	nop
  801984:	c9                   	leave  
  801985:	c3                   	ret    

00801986 <exit>:

void
exit(void)
{
  801986:	55                   	push   %ebp
  801987:	89 e5                	mov    %esp,%ebp
  801989:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80198c:	e8 a4 13 00 00       	call   802d35 <sys_env_exit>
}
  801991:	90                   	nop
  801992:	c9                   	leave  
  801993:	c3                   	ret    

00801994 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801994:	55                   	push   %ebp
  801995:	89 e5                	mov    %esp,%ebp
  801997:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80199a:	8d 45 10             	lea    0x10(%ebp),%eax
  80199d:	83 c0 04             	add    $0x4,%eax
  8019a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8019a3:	a1 30 40 80 00       	mov    0x804030,%eax
  8019a8:	85 c0                	test   %eax,%eax
  8019aa:	74 16                	je     8019c2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8019ac:	a1 30 40 80 00       	mov    0x804030,%eax
  8019b1:	83 ec 08             	sub    $0x8,%esp
  8019b4:	50                   	push   %eax
  8019b5:	68 a4 37 80 00       	push   $0x8037a4
  8019ba:	e8 89 02 00 00       	call   801c48 <cprintf>
  8019bf:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8019c2:	a1 00 40 80 00       	mov    0x804000,%eax
  8019c7:	ff 75 0c             	pushl  0xc(%ebp)
  8019ca:	ff 75 08             	pushl  0x8(%ebp)
  8019cd:	50                   	push   %eax
  8019ce:	68 a9 37 80 00       	push   $0x8037a9
  8019d3:	e8 70 02 00 00       	call   801c48 <cprintf>
  8019d8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8019db:	8b 45 10             	mov    0x10(%ebp),%eax
  8019de:	83 ec 08             	sub    $0x8,%esp
  8019e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8019e4:	50                   	push   %eax
  8019e5:	e8 f3 01 00 00       	call   801bdd <vcprintf>
  8019ea:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8019ed:	83 ec 08             	sub    $0x8,%esp
  8019f0:	6a 00                	push   $0x0
  8019f2:	68 c5 37 80 00       	push   $0x8037c5
  8019f7:	e8 e1 01 00 00       	call   801bdd <vcprintf>
  8019fc:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8019ff:	e8 82 ff ff ff       	call   801986 <exit>

	// should not return here
	while (1) ;
  801a04:	eb fe                	jmp    801a04 <_panic+0x70>

00801a06 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
  801a09:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801a0c:	a1 20 40 80 00       	mov    0x804020,%eax
  801a11:	8b 50 74             	mov    0x74(%eax),%edx
  801a14:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a17:	39 c2                	cmp    %eax,%edx
  801a19:	74 14                	je     801a2f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801a1b:	83 ec 04             	sub    $0x4,%esp
  801a1e:	68 c8 37 80 00       	push   $0x8037c8
  801a23:	6a 26                	push   $0x26
  801a25:	68 14 38 80 00       	push   $0x803814
  801a2a:	e8 65 ff ff ff       	call   801994 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801a2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801a36:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a3d:	e9 c2 00 00 00       	jmp    801b04 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801a42:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a45:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4f:	01 d0                	add    %edx,%eax
  801a51:	8b 00                	mov    (%eax),%eax
  801a53:	85 c0                	test   %eax,%eax
  801a55:	75 08                	jne    801a5f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a57:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a5a:	e9 a2 00 00 00       	jmp    801b01 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801a5f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a66:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801a6d:	eb 69                	jmp    801ad8 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801a6f:	a1 20 40 80 00       	mov    0x804020,%eax
  801a74:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a7a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a7d:	89 d0                	mov    %edx,%eax
  801a7f:	01 c0                	add    %eax,%eax
  801a81:	01 d0                	add    %edx,%eax
  801a83:	c1 e0 02             	shl    $0x2,%eax
  801a86:	01 c8                	add    %ecx,%eax
  801a88:	8a 40 04             	mov    0x4(%eax),%al
  801a8b:	84 c0                	test   %al,%al
  801a8d:	75 46                	jne    801ad5 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a8f:	a1 20 40 80 00       	mov    0x804020,%eax
  801a94:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a9a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a9d:	89 d0                	mov    %edx,%eax
  801a9f:	01 c0                	add    %eax,%eax
  801aa1:	01 d0                	add    %edx,%eax
  801aa3:	c1 e0 02             	shl    $0x2,%eax
  801aa6:	01 c8                	add    %ecx,%eax
  801aa8:	8b 00                	mov    (%eax),%eax
  801aaa:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801aad:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ab0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801ab5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801ab7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aba:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac4:	01 c8                	add    %ecx,%eax
  801ac6:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801ac8:	39 c2                	cmp    %eax,%edx
  801aca:	75 09                	jne    801ad5 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801acc:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801ad3:	eb 12                	jmp    801ae7 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ad5:	ff 45 e8             	incl   -0x18(%ebp)
  801ad8:	a1 20 40 80 00       	mov    0x804020,%eax
  801add:	8b 50 74             	mov    0x74(%eax),%edx
  801ae0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ae3:	39 c2                	cmp    %eax,%edx
  801ae5:	77 88                	ja     801a6f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801ae7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801aeb:	75 14                	jne    801b01 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801aed:	83 ec 04             	sub    $0x4,%esp
  801af0:	68 20 38 80 00       	push   $0x803820
  801af5:	6a 3a                	push   $0x3a
  801af7:	68 14 38 80 00       	push   $0x803814
  801afc:	e8 93 fe ff ff       	call   801994 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801b01:	ff 45 f0             	incl   -0x10(%ebp)
  801b04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b07:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801b0a:	0f 8c 32 ff ff ff    	jl     801a42 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801b10:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b17:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801b1e:	eb 26                	jmp    801b46 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801b20:	a1 20 40 80 00       	mov    0x804020,%eax
  801b25:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b2b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801b2e:	89 d0                	mov    %edx,%eax
  801b30:	01 c0                	add    %eax,%eax
  801b32:	01 d0                	add    %edx,%eax
  801b34:	c1 e0 02             	shl    $0x2,%eax
  801b37:	01 c8                	add    %ecx,%eax
  801b39:	8a 40 04             	mov    0x4(%eax),%al
  801b3c:	3c 01                	cmp    $0x1,%al
  801b3e:	75 03                	jne    801b43 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801b40:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b43:	ff 45 e0             	incl   -0x20(%ebp)
  801b46:	a1 20 40 80 00       	mov    0x804020,%eax
  801b4b:	8b 50 74             	mov    0x74(%eax),%edx
  801b4e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b51:	39 c2                	cmp    %eax,%edx
  801b53:	77 cb                	ja     801b20 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b58:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b5b:	74 14                	je     801b71 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801b5d:	83 ec 04             	sub    $0x4,%esp
  801b60:	68 74 38 80 00       	push   $0x803874
  801b65:	6a 44                	push   $0x44
  801b67:	68 14 38 80 00       	push   $0x803814
  801b6c:	e8 23 fe ff ff       	call   801994 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b71:	90                   	nop
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
  801b77:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b7d:	8b 00                	mov    (%eax),%eax
  801b7f:	8d 48 01             	lea    0x1(%eax),%ecx
  801b82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b85:	89 0a                	mov    %ecx,(%edx)
  801b87:	8b 55 08             	mov    0x8(%ebp),%edx
  801b8a:	88 d1                	mov    %dl,%cl
  801b8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801b93:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b96:	8b 00                	mov    (%eax),%eax
  801b98:	3d ff 00 00 00       	cmp    $0xff,%eax
  801b9d:	75 2c                	jne    801bcb <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801b9f:	a0 24 40 80 00       	mov    0x804024,%al
  801ba4:	0f b6 c0             	movzbl %al,%eax
  801ba7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801baa:	8b 12                	mov    (%edx),%edx
  801bac:	89 d1                	mov    %edx,%ecx
  801bae:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb1:	83 c2 08             	add    $0x8,%edx
  801bb4:	83 ec 04             	sub    $0x4,%esp
  801bb7:	50                   	push   %eax
  801bb8:	51                   	push   %ecx
  801bb9:	52                   	push   %edx
  801bba:	e8 ce 10 00 00       	call   802c8d <sys_cputs>
  801bbf:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bc5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bce:	8b 40 04             	mov    0x4(%eax),%eax
  801bd1:	8d 50 01             	lea    0x1(%eax),%edx
  801bd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bd7:	89 50 04             	mov    %edx,0x4(%eax)
}
  801bda:	90                   	nop
  801bdb:	c9                   	leave  
  801bdc:	c3                   	ret    

00801bdd <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
  801be0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801be6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801bed:	00 00 00 
	b.cnt = 0;
  801bf0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801bf7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801bfa:	ff 75 0c             	pushl  0xc(%ebp)
  801bfd:	ff 75 08             	pushl  0x8(%ebp)
  801c00:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801c06:	50                   	push   %eax
  801c07:	68 74 1b 80 00       	push   $0x801b74
  801c0c:	e8 11 02 00 00       	call   801e22 <vprintfmt>
  801c11:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801c14:	a0 24 40 80 00       	mov    0x804024,%al
  801c19:	0f b6 c0             	movzbl %al,%eax
  801c1c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801c22:	83 ec 04             	sub    $0x4,%esp
  801c25:	50                   	push   %eax
  801c26:	52                   	push   %edx
  801c27:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801c2d:	83 c0 08             	add    $0x8,%eax
  801c30:	50                   	push   %eax
  801c31:	e8 57 10 00 00       	call   802c8d <sys_cputs>
  801c36:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801c39:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801c40:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801c46:	c9                   	leave  
  801c47:	c3                   	ret    

00801c48 <cprintf>:

int cprintf(const char *fmt, ...) {
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
  801c4b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801c4e:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801c55:	8d 45 0c             	lea    0xc(%ebp),%eax
  801c58:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5e:	83 ec 08             	sub    $0x8,%esp
  801c61:	ff 75 f4             	pushl  -0xc(%ebp)
  801c64:	50                   	push   %eax
  801c65:	e8 73 ff ff ff       	call   801bdd <vcprintf>
  801c6a:	83 c4 10             	add    $0x10,%esp
  801c6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801c70:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c73:	c9                   	leave  
  801c74:	c3                   	ret    

00801c75 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
  801c78:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801c7b:	e8 1e 12 00 00       	call   802e9e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801c80:	8d 45 0c             	lea    0xc(%ebp),%eax
  801c83:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801c86:	8b 45 08             	mov    0x8(%ebp),%eax
  801c89:	83 ec 08             	sub    $0x8,%esp
  801c8c:	ff 75 f4             	pushl  -0xc(%ebp)
  801c8f:	50                   	push   %eax
  801c90:	e8 48 ff ff ff       	call   801bdd <vcprintf>
  801c95:	83 c4 10             	add    $0x10,%esp
  801c98:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801c9b:	e8 18 12 00 00       	call   802eb8 <sys_enable_interrupt>
	return cnt;
  801ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ca3:	c9                   	leave  
  801ca4:	c3                   	ret    

00801ca5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
  801ca8:	53                   	push   %ebx
  801ca9:	83 ec 14             	sub    $0x14,%esp
  801cac:	8b 45 10             	mov    0x10(%ebp),%eax
  801caf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cb2:	8b 45 14             	mov    0x14(%ebp),%eax
  801cb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801cb8:	8b 45 18             	mov    0x18(%ebp),%eax
  801cbb:	ba 00 00 00 00       	mov    $0x0,%edx
  801cc0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801cc3:	77 55                	ja     801d1a <printnum+0x75>
  801cc5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801cc8:	72 05                	jb     801ccf <printnum+0x2a>
  801cca:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ccd:	77 4b                	ja     801d1a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801ccf:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801cd2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801cd5:	8b 45 18             	mov    0x18(%ebp),%eax
  801cd8:	ba 00 00 00 00       	mov    $0x0,%edx
  801cdd:	52                   	push   %edx
  801cde:	50                   	push   %eax
  801cdf:	ff 75 f4             	pushl  -0xc(%ebp)
  801ce2:	ff 75 f0             	pushl  -0x10(%ebp)
  801ce5:	e8 92 15 00 00       	call   80327c <__udivdi3>
  801cea:	83 c4 10             	add    $0x10,%esp
  801ced:	83 ec 04             	sub    $0x4,%esp
  801cf0:	ff 75 20             	pushl  0x20(%ebp)
  801cf3:	53                   	push   %ebx
  801cf4:	ff 75 18             	pushl  0x18(%ebp)
  801cf7:	52                   	push   %edx
  801cf8:	50                   	push   %eax
  801cf9:	ff 75 0c             	pushl  0xc(%ebp)
  801cfc:	ff 75 08             	pushl  0x8(%ebp)
  801cff:	e8 a1 ff ff ff       	call   801ca5 <printnum>
  801d04:	83 c4 20             	add    $0x20,%esp
  801d07:	eb 1a                	jmp    801d23 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801d09:	83 ec 08             	sub    $0x8,%esp
  801d0c:	ff 75 0c             	pushl  0xc(%ebp)
  801d0f:	ff 75 20             	pushl  0x20(%ebp)
  801d12:	8b 45 08             	mov    0x8(%ebp),%eax
  801d15:	ff d0                	call   *%eax
  801d17:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801d1a:	ff 4d 1c             	decl   0x1c(%ebp)
  801d1d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801d21:	7f e6                	jg     801d09 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801d23:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801d26:	bb 00 00 00 00       	mov    $0x0,%ebx
  801d2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d31:	53                   	push   %ebx
  801d32:	51                   	push   %ecx
  801d33:	52                   	push   %edx
  801d34:	50                   	push   %eax
  801d35:	e8 52 16 00 00       	call   80338c <__umoddi3>
  801d3a:	83 c4 10             	add    $0x10,%esp
  801d3d:	05 d4 3a 80 00       	add    $0x803ad4,%eax
  801d42:	8a 00                	mov    (%eax),%al
  801d44:	0f be c0             	movsbl %al,%eax
  801d47:	83 ec 08             	sub    $0x8,%esp
  801d4a:	ff 75 0c             	pushl  0xc(%ebp)
  801d4d:	50                   	push   %eax
  801d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d51:	ff d0                	call   *%eax
  801d53:	83 c4 10             	add    $0x10,%esp
}
  801d56:	90                   	nop
  801d57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d5a:	c9                   	leave  
  801d5b:	c3                   	ret    

00801d5c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801d5c:	55                   	push   %ebp
  801d5d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801d5f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801d63:	7e 1c                	jle    801d81 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801d65:	8b 45 08             	mov    0x8(%ebp),%eax
  801d68:	8b 00                	mov    (%eax),%eax
  801d6a:	8d 50 08             	lea    0x8(%eax),%edx
  801d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d70:	89 10                	mov    %edx,(%eax)
  801d72:	8b 45 08             	mov    0x8(%ebp),%eax
  801d75:	8b 00                	mov    (%eax),%eax
  801d77:	83 e8 08             	sub    $0x8,%eax
  801d7a:	8b 50 04             	mov    0x4(%eax),%edx
  801d7d:	8b 00                	mov    (%eax),%eax
  801d7f:	eb 40                	jmp    801dc1 <getuint+0x65>
	else if (lflag)
  801d81:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d85:	74 1e                	je     801da5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801d87:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8a:	8b 00                	mov    (%eax),%eax
  801d8c:	8d 50 04             	lea    0x4(%eax),%edx
  801d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d92:	89 10                	mov    %edx,(%eax)
  801d94:	8b 45 08             	mov    0x8(%ebp),%eax
  801d97:	8b 00                	mov    (%eax),%eax
  801d99:	83 e8 04             	sub    $0x4,%eax
  801d9c:	8b 00                	mov    (%eax),%eax
  801d9e:	ba 00 00 00 00       	mov    $0x0,%edx
  801da3:	eb 1c                	jmp    801dc1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801da5:	8b 45 08             	mov    0x8(%ebp),%eax
  801da8:	8b 00                	mov    (%eax),%eax
  801daa:	8d 50 04             	lea    0x4(%eax),%edx
  801dad:	8b 45 08             	mov    0x8(%ebp),%eax
  801db0:	89 10                	mov    %edx,(%eax)
  801db2:	8b 45 08             	mov    0x8(%ebp),%eax
  801db5:	8b 00                	mov    (%eax),%eax
  801db7:	83 e8 04             	sub    $0x4,%eax
  801dba:	8b 00                	mov    (%eax),%eax
  801dbc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801dc1:	5d                   	pop    %ebp
  801dc2:	c3                   	ret    

00801dc3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801dc3:	55                   	push   %ebp
  801dc4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801dc6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801dca:	7e 1c                	jle    801de8 <getint+0x25>
		return va_arg(*ap, long long);
  801dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcf:	8b 00                	mov    (%eax),%eax
  801dd1:	8d 50 08             	lea    0x8(%eax),%edx
  801dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd7:	89 10                	mov    %edx,(%eax)
  801dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddc:	8b 00                	mov    (%eax),%eax
  801dde:	83 e8 08             	sub    $0x8,%eax
  801de1:	8b 50 04             	mov    0x4(%eax),%edx
  801de4:	8b 00                	mov    (%eax),%eax
  801de6:	eb 38                	jmp    801e20 <getint+0x5d>
	else if (lflag)
  801de8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801dec:	74 1a                	je     801e08 <getint+0x45>
		return va_arg(*ap, long);
  801dee:	8b 45 08             	mov    0x8(%ebp),%eax
  801df1:	8b 00                	mov    (%eax),%eax
  801df3:	8d 50 04             	lea    0x4(%eax),%edx
  801df6:	8b 45 08             	mov    0x8(%ebp),%eax
  801df9:	89 10                	mov    %edx,(%eax)
  801dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfe:	8b 00                	mov    (%eax),%eax
  801e00:	83 e8 04             	sub    $0x4,%eax
  801e03:	8b 00                	mov    (%eax),%eax
  801e05:	99                   	cltd   
  801e06:	eb 18                	jmp    801e20 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801e08:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0b:	8b 00                	mov    (%eax),%eax
  801e0d:	8d 50 04             	lea    0x4(%eax),%edx
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	89 10                	mov    %edx,(%eax)
  801e15:	8b 45 08             	mov    0x8(%ebp),%eax
  801e18:	8b 00                	mov    (%eax),%eax
  801e1a:	83 e8 04             	sub    $0x4,%eax
  801e1d:	8b 00                	mov    (%eax),%eax
  801e1f:	99                   	cltd   
}
  801e20:	5d                   	pop    %ebp
  801e21:	c3                   	ret    

00801e22 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801e22:	55                   	push   %ebp
  801e23:	89 e5                	mov    %esp,%ebp
  801e25:	56                   	push   %esi
  801e26:	53                   	push   %ebx
  801e27:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801e2a:	eb 17                	jmp    801e43 <vprintfmt+0x21>
			if (ch == '\0')
  801e2c:	85 db                	test   %ebx,%ebx
  801e2e:	0f 84 af 03 00 00    	je     8021e3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801e34:	83 ec 08             	sub    $0x8,%esp
  801e37:	ff 75 0c             	pushl  0xc(%ebp)
  801e3a:	53                   	push   %ebx
  801e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3e:	ff d0                	call   *%eax
  801e40:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801e43:	8b 45 10             	mov    0x10(%ebp),%eax
  801e46:	8d 50 01             	lea    0x1(%eax),%edx
  801e49:	89 55 10             	mov    %edx,0x10(%ebp)
  801e4c:	8a 00                	mov    (%eax),%al
  801e4e:	0f b6 d8             	movzbl %al,%ebx
  801e51:	83 fb 25             	cmp    $0x25,%ebx
  801e54:	75 d6                	jne    801e2c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801e56:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801e5a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801e61:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801e68:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801e6f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801e76:	8b 45 10             	mov    0x10(%ebp),%eax
  801e79:	8d 50 01             	lea    0x1(%eax),%edx
  801e7c:	89 55 10             	mov    %edx,0x10(%ebp)
  801e7f:	8a 00                	mov    (%eax),%al
  801e81:	0f b6 d8             	movzbl %al,%ebx
  801e84:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801e87:	83 f8 55             	cmp    $0x55,%eax
  801e8a:	0f 87 2b 03 00 00    	ja     8021bb <vprintfmt+0x399>
  801e90:	8b 04 85 f8 3a 80 00 	mov    0x803af8(,%eax,4),%eax
  801e97:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801e99:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801e9d:	eb d7                	jmp    801e76 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801e9f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801ea3:	eb d1                	jmp    801e76 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ea5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801eac:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801eaf:	89 d0                	mov    %edx,%eax
  801eb1:	c1 e0 02             	shl    $0x2,%eax
  801eb4:	01 d0                	add    %edx,%eax
  801eb6:	01 c0                	add    %eax,%eax
  801eb8:	01 d8                	add    %ebx,%eax
  801eba:	83 e8 30             	sub    $0x30,%eax
  801ebd:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801ec0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ec3:	8a 00                	mov    (%eax),%al
  801ec5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801ec8:	83 fb 2f             	cmp    $0x2f,%ebx
  801ecb:	7e 3e                	jle    801f0b <vprintfmt+0xe9>
  801ecd:	83 fb 39             	cmp    $0x39,%ebx
  801ed0:	7f 39                	jg     801f0b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ed2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801ed5:	eb d5                	jmp    801eac <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801ed7:	8b 45 14             	mov    0x14(%ebp),%eax
  801eda:	83 c0 04             	add    $0x4,%eax
  801edd:	89 45 14             	mov    %eax,0x14(%ebp)
  801ee0:	8b 45 14             	mov    0x14(%ebp),%eax
  801ee3:	83 e8 04             	sub    $0x4,%eax
  801ee6:	8b 00                	mov    (%eax),%eax
  801ee8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801eeb:	eb 1f                	jmp    801f0c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801eed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ef1:	79 83                	jns    801e76 <vprintfmt+0x54>
				width = 0;
  801ef3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801efa:	e9 77 ff ff ff       	jmp    801e76 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801eff:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801f06:	e9 6b ff ff ff       	jmp    801e76 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801f0b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801f0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801f10:	0f 89 60 ff ff ff    	jns    801e76 <vprintfmt+0x54>
				width = precision, precision = -1;
  801f16:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801f1c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801f23:	e9 4e ff ff ff       	jmp    801e76 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801f28:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801f2b:	e9 46 ff ff ff       	jmp    801e76 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801f30:	8b 45 14             	mov    0x14(%ebp),%eax
  801f33:	83 c0 04             	add    $0x4,%eax
  801f36:	89 45 14             	mov    %eax,0x14(%ebp)
  801f39:	8b 45 14             	mov    0x14(%ebp),%eax
  801f3c:	83 e8 04             	sub    $0x4,%eax
  801f3f:	8b 00                	mov    (%eax),%eax
  801f41:	83 ec 08             	sub    $0x8,%esp
  801f44:	ff 75 0c             	pushl  0xc(%ebp)
  801f47:	50                   	push   %eax
  801f48:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4b:	ff d0                	call   *%eax
  801f4d:	83 c4 10             	add    $0x10,%esp
			break;
  801f50:	e9 89 02 00 00       	jmp    8021de <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801f55:	8b 45 14             	mov    0x14(%ebp),%eax
  801f58:	83 c0 04             	add    $0x4,%eax
  801f5b:	89 45 14             	mov    %eax,0x14(%ebp)
  801f5e:	8b 45 14             	mov    0x14(%ebp),%eax
  801f61:	83 e8 04             	sub    $0x4,%eax
  801f64:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801f66:	85 db                	test   %ebx,%ebx
  801f68:	79 02                	jns    801f6c <vprintfmt+0x14a>
				err = -err;
  801f6a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801f6c:	83 fb 64             	cmp    $0x64,%ebx
  801f6f:	7f 0b                	jg     801f7c <vprintfmt+0x15a>
  801f71:	8b 34 9d 40 39 80 00 	mov    0x803940(,%ebx,4),%esi
  801f78:	85 f6                	test   %esi,%esi
  801f7a:	75 19                	jne    801f95 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801f7c:	53                   	push   %ebx
  801f7d:	68 e5 3a 80 00       	push   $0x803ae5
  801f82:	ff 75 0c             	pushl  0xc(%ebp)
  801f85:	ff 75 08             	pushl  0x8(%ebp)
  801f88:	e8 5e 02 00 00       	call   8021eb <printfmt>
  801f8d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801f90:	e9 49 02 00 00       	jmp    8021de <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801f95:	56                   	push   %esi
  801f96:	68 ee 3a 80 00       	push   $0x803aee
  801f9b:	ff 75 0c             	pushl  0xc(%ebp)
  801f9e:	ff 75 08             	pushl  0x8(%ebp)
  801fa1:	e8 45 02 00 00       	call   8021eb <printfmt>
  801fa6:	83 c4 10             	add    $0x10,%esp
			break;
  801fa9:	e9 30 02 00 00       	jmp    8021de <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801fae:	8b 45 14             	mov    0x14(%ebp),%eax
  801fb1:	83 c0 04             	add    $0x4,%eax
  801fb4:	89 45 14             	mov    %eax,0x14(%ebp)
  801fb7:	8b 45 14             	mov    0x14(%ebp),%eax
  801fba:	83 e8 04             	sub    $0x4,%eax
  801fbd:	8b 30                	mov    (%eax),%esi
  801fbf:	85 f6                	test   %esi,%esi
  801fc1:	75 05                	jne    801fc8 <vprintfmt+0x1a6>
				p = "(null)";
  801fc3:	be f1 3a 80 00       	mov    $0x803af1,%esi
			if (width > 0 && padc != '-')
  801fc8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801fcc:	7e 6d                	jle    80203b <vprintfmt+0x219>
  801fce:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801fd2:	74 67                	je     80203b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801fd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801fd7:	83 ec 08             	sub    $0x8,%esp
  801fda:	50                   	push   %eax
  801fdb:	56                   	push   %esi
  801fdc:	e8 0c 03 00 00       	call   8022ed <strnlen>
  801fe1:	83 c4 10             	add    $0x10,%esp
  801fe4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801fe7:	eb 16                	jmp    801fff <vprintfmt+0x1dd>
					putch(padc, putdat);
  801fe9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801fed:	83 ec 08             	sub    $0x8,%esp
  801ff0:	ff 75 0c             	pushl  0xc(%ebp)
  801ff3:	50                   	push   %eax
  801ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff7:	ff d0                	call   *%eax
  801ff9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801ffc:	ff 4d e4             	decl   -0x1c(%ebp)
  801fff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802003:	7f e4                	jg     801fe9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  802005:	eb 34                	jmp    80203b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  802007:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80200b:	74 1c                	je     802029 <vprintfmt+0x207>
  80200d:	83 fb 1f             	cmp    $0x1f,%ebx
  802010:	7e 05                	jle    802017 <vprintfmt+0x1f5>
  802012:	83 fb 7e             	cmp    $0x7e,%ebx
  802015:	7e 12                	jle    802029 <vprintfmt+0x207>
					putch('?', putdat);
  802017:	83 ec 08             	sub    $0x8,%esp
  80201a:	ff 75 0c             	pushl  0xc(%ebp)
  80201d:	6a 3f                	push   $0x3f
  80201f:	8b 45 08             	mov    0x8(%ebp),%eax
  802022:	ff d0                	call   *%eax
  802024:	83 c4 10             	add    $0x10,%esp
  802027:	eb 0f                	jmp    802038 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  802029:	83 ec 08             	sub    $0x8,%esp
  80202c:	ff 75 0c             	pushl  0xc(%ebp)
  80202f:	53                   	push   %ebx
  802030:	8b 45 08             	mov    0x8(%ebp),%eax
  802033:	ff d0                	call   *%eax
  802035:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  802038:	ff 4d e4             	decl   -0x1c(%ebp)
  80203b:	89 f0                	mov    %esi,%eax
  80203d:	8d 70 01             	lea    0x1(%eax),%esi
  802040:	8a 00                	mov    (%eax),%al
  802042:	0f be d8             	movsbl %al,%ebx
  802045:	85 db                	test   %ebx,%ebx
  802047:	74 24                	je     80206d <vprintfmt+0x24b>
  802049:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80204d:	78 b8                	js     802007 <vprintfmt+0x1e5>
  80204f:	ff 4d e0             	decl   -0x20(%ebp)
  802052:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  802056:	79 af                	jns    802007 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  802058:	eb 13                	jmp    80206d <vprintfmt+0x24b>
				putch(' ', putdat);
  80205a:	83 ec 08             	sub    $0x8,%esp
  80205d:	ff 75 0c             	pushl  0xc(%ebp)
  802060:	6a 20                	push   $0x20
  802062:	8b 45 08             	mov    0x8(%ebp),%eax
  802065:	ff d0                	call   *%eax
  802067:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80206a:	ff 4d e4             	decl   -0x1c(%ebp)
  80206d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802071:	7f e7                	jg     80205a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  802073:	e9 66 01 00 00       	jmp    8021de <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  802078:	83 ec 08             	sub    $0x8,%esp
  80207b:	ff 75 e8             	pushl  -0x18(%ebp)
  80207e:	8d 45 14             	lea    0x14(%ebp),%eax
  802081:	50                   	push   %eax
  802082:	e8 3c fd ff ff       	call   801dc3 <getint>
  802087:	83 c4 10             	add    $0x10,%esp
  80208a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80208d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  802090:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802093:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802096:	85 d2                	test   %edx,%edx
  802098:	79 23                	jns    8020bd <vprintfmt+0x29b>
				putch('-', putdat);
  80209a:	83 ec 08             	sub    $0x8,%esp
  80209d:	ff 75 0c             	pushl  0xc(%ebp)
  8020a0:	6a 2d                	push   $0x2d
  8020a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a5:	ff d0                	call   *%eax
  8020a7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8020aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020b0:	f7 d8                	neg    %eax
  8020b2:	83 d2 00             	adc    $0x0,%edx
  8020b5:	f7 da                	neg    %edx
  8020b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8020bd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8020c4:	e9 bc 00 00 00       	jmp    802185 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8020c9:	83 ec 08             	sub    $0x8,%esp
  8020cc:	ff 75 e8             	pushl  -0x18(%ebp)
  8020cf:	8d 45 14             	lea    0x14(%ebp),%eax
  8020d2:	50                   	push   %eax
  8020d3:	e8 84 fc ff ff       	call   801d5c <getuint>
  8020d8:	83 c4 10             	add    $0x10,%esp
  8020db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020de:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8020e1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8020e8:	e9 98 00 00 00       	jmp    802185 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8020ed:	83 ec 08             	sub    $0x8,%esp
  8020f0:	ff 75 0c             	pushl  0xc(%ebp)
  8020f3:	6a 58                	push   $0x58
  8020f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f8:	ff d0                	call   *%eax
  8020fa:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8020fd:	83 ec 08             	sub    $0x8,%esp
  802100:	ff 75 0c             	pushl  0xc(%ebp)
  802103:	6a 58                	push   $0x58
  802105:	8b 45 08             	mov    0x8(%ebp),%eax
  802108:	ff d0                	call   *%eax
  80210a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80210d:	83 ec 08             	sub    $0x8,%esp
  802110:	ff 75 0c             	pushl  0xc(%ebp)
  802113:	6a 58                	push   $0x58
  802115:	8b 45 08             	mov    0x8(%ebp),%eax
  802118:	ff d0                	call   *%eax
  80211a:	83 c4 10             	add    $0x10,%esp
			break;
  80211d:	e9 bc 00 00 00       	jmp    8021de <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  802122:	83 ec 08             	sub    $0x8,%esp
  802125:	ff 75 0c             	pushl  0xc(%ebp)
  802128:	6a 30                	push   $0x30
  80212a:	8b 45 08             	mov    0x8(%ebp),%eax
  80212d:	ff d0                	call   *%eax
  80212f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  802132:	83 ec 08             	sub    $0x8,%esp
  802135:	ff 75 0c             	pushl  0xc(%ebp)
  802138:	6a 78                	push   $0x78
  80213a:	8b 45 08             	mov    0x8(%ebp),%eax
  80213d:	ff d0                	call   *%eax
  80213f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  802142:	8b 45 14             	mov    0x14(%ebp),%eax
  802145:	83 c0 04             	add    $0x4,%eax
  802148:	89 45 14             	mov    %eax,0x14(%ebp)
  80214b:	8b 45 14             	mov    0x14(%ebp),%eax
  80214e:	83 e8 04             	sub    $0x4,%eax
  802151:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  802153:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802156:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80215d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  802164:	eb 1f                	jmp    802185 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  802166:	83 ec 08             	sub    $0x8,%esp
  802169:	ff 75 e8             	pushl  -0x18(%ebp)
  80216c:	8d 45 14             	lea    0x14(%ebp),%eax
  80216f:	50                   	push   %eax
  802170:	e8 e7 fb ff ff       	call   801d5c <getuint>
  802175:	83 c4 10             	add    $0x10,%esp
  802178:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80217b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80217e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  802185:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  802189:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80218c:	83 ec 04             	sub    $0x4,%esp
  80218f:	52                   	push   %edx
  802190:	ff 75 e4             	pushl  -0x1c(%ebp)
  802193:	50                   	push   %eax
  802194:	ff 75 f4             	pushl  -0xc(%ebp)
  802197:	ff 75 f0             	pushl  -0x10(%ebp)
  80219a:	ff 75 0c             	pushl  0xc(%ebp)
  80219d:	ff 75 08             	pushl  0x8(%ebp)
  8021a0:	e8 00 fb ff ff       	call   801ca5 <printnum>
  8021a5:	83 c4 20             	add    $0x20,%esp
			break;
  8021a8:	eb 34                	jmp    8021de <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8021aa:	83 ec 08             	sub    $0x8,%esp
  8021ad:	ff 75 0c             	pushl  0xc(%ebp)
  8021b0:	53                   	push   %ebx
  8021b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b4:	ff d0                	call   *%eax
  8021b6:	83 c4 10             	add    $0x10,%esp
			break;
  8021b9:	eb 23                	jmp    8021de <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8021bb:	83 ec 08             	sub    $0x8,%esp
  8021be:	ff 75 0c             	pushl  0xc(%ebp)
  8021c1:	6a 25                	push   $0x25
  8021c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c6:	ff d0                	call   *%eax
  8021c8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8021cb:	ff 4d 10             	decl   0x10(%ebp)
  8021ce:	eb 03                	jmp    8021d3 <vprintfmt+0x3b1>
  8021d0:	ff 4d 10             	decl   0x10(%ebp)
  8021d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8021d6:	48                   	dec    %eax
  8021d7:	8a 00                	mov    (%eax),%al
  8021d9:	3c 25                	cmp    $0x25,%al
  8021db:	75 f3                	jne    8021d0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8021dd:	90                   	nop
		}
	}
  8021de:	e9 47 fc ff ff       	jmp    801e2a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8021e3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8021e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8021e7:	5b                   	pop    %ebx
  8021e8:	5e                   	pop    %esi
  8021e9:	5d                   	pop    %ebp
  8021ea:	c3                   	ret    

008021eb <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8021eb:	55                   	push   %ebp
  8021ec:	89 e5                	mov    %esp,%ebp
  8021ee:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8021f1:	8d 45 10             	lea    0x10(%ebp),%eax
  8021f4:	83 c0 04             	add    $0x4,%eax
  8021f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8021fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8021fd:	ff 75 f4             	pushl  -0xc(%ebp)
  802200:	50                   	push   %eax
  802201:	ff 75 0c             	pushl  0xc(%ebp)
  802204:	ff 75 08             	pushl  0x8(%ebp)
  802207:	e8 16 fc ff ff       	call   801e22 <vprintfmt>
  80220c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80220f:	90                   	nop
  802210:	c9                   	leave  
  802211:	c3                   	ret    

00802212 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  802212:	55                   	push   %ebp
  802213:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  802215:	8b 45 0c             	mov    0xc(%ebp),%eax
  802218:	8b 40 08             	mov    0x8(%eax),%eax
  80221b:	8d 50 01             	lea    0x1(%eax),%edx
  80221e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802221:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  802224:	8b 45 0c             	mov    0xc(%ebp),%eax
  802227:	8b 10                	mov    (%eax),%edx
  802229:	8b 45 0c             	mov    0xc(%ebp),%eax
  80222c:	8b 40 04             	mov    0x4(%eax),%eax
  80222f:	39 c2                	cmp    %eax,%edx
  802231:	73 12                	jae    802245 <sprintputch+0x33>
		*b->buf++ = ch;
  802233:	8b 45 0c             	mov    0xc(%ebp),%eax
  802236:	8b 00                	mov    (%eax),%eax
  802238:	8d 48 01             	lea    0x1(%eax),%ecx
  80223b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223e:	89 0a                	mov    %ecx,(%edx)
  802240:	8b 55 08             	mov    0x8(%ebp),%edx
  802243:	88 10                	mov    %dl,(%eax)
}
  802245:	90                   	nop
  802246:	5d                   	pop    %ebp
  802247:	c3                   	ret    

00802248 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  802248:	55                   	push   %ebp
  802249:	89 e5                	mov    %esp,%ebp
  80224b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80224e:	8b 45 08             	mov    0x8(%ebp),%eax
  802251:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802254:	8b 45 0c             	mov    0xc(%ebp),%eax
  802257:	8d 50 ff             	lea    -0x1(%eax),%edx
  80225a:	8b 45 08             	mov    0x8(%ebp),%eax
  80225d:	01 d0                	add    %edx,%eax
  80225f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802262:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  802269:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80226d:	74 06                	je     802275 <vsnprintf+0x2d>
  80226f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802273:	7f 07                	jg     80227c <vsnprintf+0x34>
		return -E_INVAL;
  802275:	b8 03 00 00 00       	mov    $0x3,%eax
  80227a:	eb 20                	jmp    80229c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80227c:	ff 75 14             	pushl  0x14(%ebp)
  80227f:	ff 75 10             	pushl  0x10(%ebp)
  802282:	8d 45 ec             	lea    -0x14(%ebp),%eax
  802285:	50                   	push   %eax
  802286:	68 12 22 80 00       	push   $0x802212
  80228b:	e8 92 fb ff ff       	call   801e22 <vprintfmt>
  802290:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  802293:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802296:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  802299:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80229c:	c9                   	leave  
  80229d:	c3                   	ret    

0080229e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80229e:	55                   	push   %ebp
  80229f:	89 e5                	mov    %esp,%ebp
  8022a1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8022a4:	8d 45 10             	lea    0x10(%ebp),%eax
  8022a7:	83 c0 04             	add    $0x4,%eax
  8022aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8022ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8022b0:	ff 75 f4             	pushl  -0xc(%ebp)
  8022b3:	50                   	push   %eax
  8022b4:	ff 75 0c             	pushl  0xc(%ebp)
  8022b7:	ff 75 08             	pushl  0x8(%ebp)
  8022ba:	e8 89 ff ff ff       	call   802248 <vsnprintf>
  8022bf:	83 c4 10             	add    $0x10,%esp
  8022c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8022c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8022c8:	c9                   	leave  
  8022c9:	c3                   	ret    

008022ca <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8022ca:	55                   	push   %ebp
  8022cb:	89 e5                	mov    %esp,%ebp
  8022cd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8022d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8022d7:	eb 06                	jmp    8022df <strlen+0x15>
		n++;
  8022d9:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8022dc:	ff 45 08             	incl   0x8(%ebp)
  8022df:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e2:	8a 00                	mov    (%eax),%al
  8022e4:	84 c0                	test   %al,%al
  8022e6:	75 f1                	jne    8022d9 <strlen+0xf>
		n++;
	return n;
  8022e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8022eb:	c9                   	leave  
  8022ec:	c3                   	ret    

008022ed <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8022ed:	55                   	push   %ebp
  8022ee:	89 e5                	mov    %esp,%ebp
  8022f0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8022f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8022fa:	eb 09                	jmp    802305 <strnlen+0x18>
		n++;
  8022fc:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8022ff:	ff 45 08             	incl   0x8(%ebp)
  802302:	ff 4d 0c             	decl   0xc(%ebp)
  802305:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802309:	74 09                	je     802314 <strnlen+0x27>
  80230b:	8b 45 08             	mov    0x8(%ebp),%eax
  80230e:	8a 00                	mov    (%eax),%al
  802310:	84 c0                	test   %al,%al
  802312:	75 e8                	jne    8022fc <strnlen+0xf>
		n++;
	return n;
  802314:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802317:	c9                   	leave  
  802318:	c3                   	ret    

00802319 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  802319:	55                   	push   %ebp
  80231a:	89 e5                	mov    %esp,%ebp
  80231c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80231f:	8b 45 08             	mov    0x8(%ebp),%eax
  802322:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  802325:	90                   	nop
  802326:	8b 45 08             	mov    0x8(%ebp),%eax
  802329:	8d 50 01             	lea    0x1(%eax),%edx
  80232c:	89 55 08             	mov    %edx,0x8(%ebp)
  80232f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802332:	8d 4a 01             	lea    0x1(%edx),%ecx
  802335:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802338:	8a 12                	mov    (%edx),%dl
  80233a:	88 10                	mov    %dl,(%eax)
  80233c:	8a 00                	mov    (%eax),%al
  80233e:	84 c0                	test   %al,%al
  802340:	75 e4                	jne    802326 <strcpy+0xd>
		/* do nothing */;
	return ret;
  802342:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802345:	c9                   	leave  
  802346:	c3                   	ret    

00802347 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  802347:	55                   	push   %ebp
  802348:	89 e5                	mov    %esp,%ebp
  80234a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80234d:	8b 45 08             	mov    0x8(%ebp),%eax
  802350:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  802353:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80235a:	eb 1f                	jmp    80237b <strncpy+0x34>
		*dst++ = *src;
  80235c:	8b 45 08             	mov    0x8(%ebp),%eax
  80235f:	8d 50 01             	lea    0x1(%eax),%edx
  802362:	89 55 08             	mov    %edx,0x8(%ebp)
  802365:	8b 55 0c             	mov    0xc(%ebp),%edx
  802368:	8a 12                	mov    (%edx),%dl
  80236a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80236c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80236f:	8a 00                	mov    (%eax),%al
  802371:	84 c0                	test   %al,%al
  802373:	74 03                	je     802378 <strncpy+0x31>
			src++;
  802375:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  802378:	ff 45 fc             	incl   -0x4(%ebp)
  80237b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80237e:	3b 45 10             	cmp    0x10(%ebp),%eax
  802381:	72 d9                	jb     80235c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  802383:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802386:	c9                   	leave  
  802387:	c3                   	ret    

00802388 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  802388:	55                   	push   %ebp
  802389:	89 e5                	mov    %esp,%ebp
  80238b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80238e:	8b 45 08             	mov    0x8(%ebp),%eax
  802391:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  802394:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802398:	74 30                	je     8023ca <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80239a:	eb 16                	jmp    8023b2 <strlcpy+0x2a>
			*dst++ = *src++;
  80239c:	8b 45 08             	mov    0x8(%ebp),%eax
  80239f:	8d 50 01             	lea    0x1(%eax),%edx
  8023a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8023a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023a8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8023ab:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8023ae:	8a 12                	mov    (%edx),%dl
  8023b0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8023b2:	ff 4d 10             	decl   0x10(%ebp)
  8023b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8023b9:	74 09                	je     8023c4 <strlcpy+0x3c>
  8023bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023be:	8a 00                	mov    (%eax),%al
  8023c0:	84 c0                	test   %al,%al
  8023c2:	75 d8                	jne    80239c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8023c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8023ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8023cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023d0:	29 c2                	sub    %eax,%edx
  8023d2:	89 d0                	mov    %edx,%eax
}
  8023d4:	c9                   	leave  
  8023d5:	c3                   	ret    

008023d6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8023d6:	55                   	push   %ebp
  8023d7:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8023d9:	eb 06                	jmp    8023e1 <strcmp+0xb>
		p++, q++;
  8023db:	ff 45 08             	incl   0x8(%ebp)
  8023de:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8023e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e4:	8a 00                	mov    (%eax),%al
  8023e6:	84 c0                	test   %al,%al
  8023e8:	74 0e                	je     8023f8 <strcmp+0x22>
  8023ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ed:	8a 10                	mov    (%eax),%dl
  8023ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023f2:	8a 00                	mov    (%eax),%al
  8023f4:	38 c2                	cmp    %al,%dl
  8023f6:	74 e3                	je     8023db <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8023f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023fb:	8a 00                	mov    (%eax),%al
  8023fd:	0f b6 d0             	movzbl %al,%edx
  802400:	8b 45 0c             	mov    0xc(%ebp),%eax
  802403:	8a 00                	mov    (%eax),%al
  802405:	0f b6 c0             	movzbl %al,%eax
  802408:	29 c2                	sub    %eax,%edx
  80240a:	89 d0                	mov    %edx,%eax
}
  80240c:	5d                   	pop    %ebp
  80240d:	c3                   	ret    

0080240e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80240e:	55                   	push   %ebp
  80240f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  802411:	eb 09                	jmp    80241c <strncmp+0xe>
		n--, p++, q++;
  802413:	ff 4d 10             	decl   0x10(%ebp)
  802416:	ff 45 08             	incl   0x8(%ebp)
  802419:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80241c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802420:	74 17                	je     802439 <strncmp+0x2b>
  802422:	8b 45 08             	mov    0x8(%ebp),%eax
  802425:	8a 00                	mov    (%eax),%al
  802427:	84 c0                	test   %al,%al
  802429:	74 0e                	je     802439 <strncmp+0x2b>
  80242b:	8b 45 08             	mov    0x8(%ebp),%eax
  80242e:	8a 10                	mov    (%eax),%dl
  802430:	8b 45 0c             	mov    0xc(%ebp),%eax
  802433:	8a 00                	mov    (%eax),%al
  802435:	38 c2                	cmp    %al,%dl
  802437:	74 da                	je     802413 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802439:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80243d:	75 07                	jne    802446 <strncmp+0x38>
		return 0;
  80243f:	b8 00 00 00 00       	mov    $0x0,%eax
  802444:	eb 14                	jmp    80245a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802446:	8b 45 08             	mov    0x8(%ebp),%eax
  802449:	8a 00                	mov    (%eax),%al
  80244b:	0f b6 d0             	movzbl %al,%edx
  80244e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802451:	8a 00                	mov    (%eax),%al
  802453:	0f b6 c0             	movzbl %al,%eax
  802456:	29 c2                	sub    %eax,%edx
  802458:	89 d0                	mov    %edx,%eax
}
  80245a:	5d                   	pop    %ebp
  80245b:	c3                   	ret    

0080245c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80245c:	55                   	push   %ebp
  80245d:	89 e5                	mov    %esp,%ebp
  80245f:	83 ec 04             	sub    $0x4,%esp
  802462:	8b 45 0c             	mov    0xc(%ebp),%eax
  802465:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802468:	eb 12                	jmp    80247c <strchr+0x20>
		if (*s == c)
  80246a:	8b 45 08             	mov    0x8(%ebp),%eax
  80246d:	8a 00                	mov    (%eax),%al
  80246f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802472:	75 05                	jne    802479 <strchr+0x1d>
			return (char *) s;
  802474:	8b 45 08             	mov    0x8(%ebp),%eax
  802477:	eb 11                	jmp    80248a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802479:	ff 45 08             	incl   0x8(%ebp)
  80247c:	8b 45 08             	mov    0x8(%ebp),%eax
  80247f:	8a 00                	mov    (%eax),%al
  802481:	84 c0                	test   %al,%al
  802483:	75 e5                	jne    80246a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802485:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80248a:	c9                   	leave  
  80248b:	c3                   	ret    

0080248c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80248c:	55                   	push   %ebp
  80248d:	89 e5                	mov    %esp,%ebp
  80248f:	83 ec 04             	sub    $0x4,%esp
  802492:	8b 45 0c             	mov    0xc(%ebp),%eax
  802495:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802498:	eb 0d                	jmp    8024a7 <strfind+0x1b>
		if (*s == c)
  80249a:	8b 45 08             	mov    0x8(%ebp),%eax
  80249d:	8a 00                	mov    (%eax),%al
  80249f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8024a2:	74 0e                	je     8024b2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8024a4:	ff 45 08             	incl   0x8(%ebp)
  8024a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024aa:	8a 00                	mov    (%eax),%al
  8024ac:	84 c0                	test   %al,%al
  8024ae:	75 ea                	jne    80249a <strfind+0xe>
  8024b0:	eb 01                	jmp    8024b3 <strfind+0x27>
		if (*s == c)
			break;
  8024b2:	90                   	nop
	return (char *) s;
  8024b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8024b6:	c9                   	leave  
  8024b7:	c3                   	ret    

008024b8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8024b8:	55                   	push   %ebp
  8024b9:	89 e5                	mov    %esp,%ebp
  8024bb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8024be:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8024c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8024c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8024ca:	eb 0e                	jmp    8024da <memset+0x22>
		*p++ = c;
  8024cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024cf:	8d 50 01             	lea    0x1(%eax),%edx
  8024d2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8024d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024d8:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8024da:	ff 4d f8             	decl   -0x8(%ebp)
  8024dd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8024e1:	79 e9                	jns    8024cc <memset+0x14>
		*p++ = c;

	return v;
  8024e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8024e6:	c9                   	leave  
  8024e7:	c3                   	ret    

008024e8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8024e8:	55                   	push   %ebp
  8024e9:	89 e5                	mov    %esp,%ebp
  8024eb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8024ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8024f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8024fa:	eb 16                	jmp    802512 <memcpy+0x2a>
		*d++ = *s++;
  8024fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024ff:	8d 50 01             	lea    0x1(%eax),%edx
  802502:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802505:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802508:	8d 4a 01             	lea    0x1(%edx),%ecx
  80250b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80250e:	8a 12                	mov    (%edx),%dl
  802510:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  802512:	8b 45 10             	mov    0x10(%ebp),%eax
  802515:	8d 50 ff             	lea    -0x1(%eax),%edx
  802518:	89 55 10             	mov    %edx,0x10(%ebp)
  80251b:	85 c0                	test   %eax,%eax
  80251d:	75 dd                	jne    8024fc <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80251f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802522:	c9                   	leave  
  802523:	c3                   	ret    

00802524 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802524:	55                   	push   %ebp
  802525:	89 e5                	mov    %esp,%ebp
  802527:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80252a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80252d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802530:	8b 45 08             	mov    0x8(%ebp),%eax
  802533:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802536:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802539:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80253c:	73 50                	jae    80258e <memmove+0x6a>
  80253e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802541:	8b 45 10             	mov    0x10(%ebp),%eax
  802544:	01 d0                	add    %edx,%eax
  802546:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802549:	76 43                	jbe    80258e <memmove+0x6a>
		s += n;
  80254b:	8b 45 10             	mov    0x10(%ebp),%eax
  80254e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  802551:	8b 45 10             	mov    0x10(%ebp),%eax
  802554:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802557:	eb 10                	jmp    802569 <memmove+0x45>
			*--d = *--s;
  802559:	ff 4d f8             	decl   -0x8(%ebp)
  80255c:	ff 4d fc             	decl   -0x4(%ebp)
  80255f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802562:	8a 10                	mov    (%eax),%dl
  802564:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802567:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802569:	8b 45 10             	mov    0x10(%ebp),%eax
  80256c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80256f:	89 55 10             	mov    %edx,0x10(%ebp)
  802572:	85 c0                	test   %eax,%eax
  802574:	75 e3                	jne    802559 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802576:	eb 23                	jmp    80259b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802578:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80257b:	8d 50 01             	lea    0x1(%eax),%edx
  80257e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802581:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802584:	8d 4a 01             	lea    0x1(%edx),%ecx
  802587:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80258a:	8a 12                	mov    (%edx),%dl
  80258c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80258e:	8b 45 10             	mov    0x10(%ebp),%eax
  802591:	8d 50 ff             	lea    -0x1(%eax),%edx
  802594:	89 55 10             	mov    %edx,0x10(%ebp)
  802597:	85 c0                	test   %eax,%eax
  802599:	75 dd                	jne    802578 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80259b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80259e:	c9                   	leave  
  80259f:	c3                   	ret    

008025a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8025a0:	55                   	push   %ebp
  8025a1:	89 e5                	mov    %esp,%ebp
  8025a3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8025a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8025ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025af:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8025b2:	eb 2a                	jmp    8025de <memcmp+0x3e>
		if (*s1 != *s2)
  8025b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8025b7:	8a 10                	mov    (%eax),%dl
  8025b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025bc:	8a 00                	mov    (%eax),%al
  8025be:	38 c2                	cmp    %al,%dl
  8025c0:	74 16                	je     8025d8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8025c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8025c5:	8a 00                	mov    (%eax),%al
  8025c7:	0f b6 d0             	movzbl %al,%edx
  8025ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025cd:	8a 00                	mov    (%eax),%al
  8025cf:	0f b6 c0             	movzbl %al,%eax
  8025d2:	29 c2                	sub    %eax,%edx
  8025d4:	89 d0                	mov    %edx,%eax
  8025d6:	eb 18                	jmp    8025f0 <memcmp+0x50>
		s1++, s2++;
  8025d8:	ff 45 fc             	incl   -0x4(%ebp)
  8025db:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8025de:	8b 45 10             	mov    0x10(%ebp),%eax
  8025e1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8025e4:	89 55 10             	mov    %edx,0x10(%ebp)
  8025e7:	85 c0                	test   %eax,%eax
  8025e9:	75 c9                	jne    8025b4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8025eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025f0:	c9                   	leave  
  8025f1:	c3                   	ret    

008025f2 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8025f2:	55                   	push   %ebp
  8025f3:	89 e5                	mov    %esp,%ebp
  8025f5:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8025f8:	8b 55 08             	mov    0x8(%ebp),%edx
  8025fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8025fe:	01 d0                	add    %edx,%eax
  802600:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  802603:	eb 15                	jmp    80261a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  802605:	8b 45 08             	mov    0x8(%ebp),%eax
  802608:	8a 00                	mov    (%eax),%al
  80260a:	0f b6 d0             	movzbl %al,%edx
  80260d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802610:	0f b6 c0             	movzbl %al,%eax
  802613:	39 c2                	cmp    %eax,%edx
  802615:	74 0d                	je     802624 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802617:	ff 45 08             	incl   0x8(%ebp)
  80261a:	8b 45 08             	mov    0x8(%ebp),%eax
  80261d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  802620:	72 e3                	jb     802605 <memfind+0x13>
  802622:	eb 01                	jmp    802625 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802624:	90                   	nop
	return (void *) s;
  802625:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802628:	c9                   	leave  
  802629:	c3                   	ret    

0080262a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80262a:	55                   	push   %ebp
  80262b:	89 e5                	mov    %esp,%ebp
  80262d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  802630:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802637:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80263e:	eb 03                	jmp    802643 <strtol+0x19>
		s++;
  802640:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802643:	8b 45 08             	mov    0x8(%ebp),%eax
  802646:	8a 00                	mov    (%eax),%al
  802648:	3c 20                	cmp    $0x20,%al
  80264a:	74 f4                	je     802640 <strtol+0x16>
  80264c:	8b 45 08             	mov    0x8(%ebp),%eax
  80264f:	8a 00                	mov    (%eax),%al
  802651:	3c 09                	cmp    $0x9,%al
  802653:	74 eb                	je     802640 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802655:	8b 45 08             	mov    0x8(%ebp),%eax
  802658:	8a 00                	mov    (%eax),%al
  80265a:	3c 2b                	cmp    $0x2b,%al
  80265c:	75 05                	jne    802663 <strtol+0x39>
		s++;
  80265e:	ff 45 08             	incl   0x8(%ebp)
  802661:	eb 13                	jmp    802676 <strtol+0x4c>
	else if (*s == '-')
  802663:	8b 45 08             	mov    0x8(%ebp),%eax
  802666:	8a 00                	mov    (%eax),%al
  802668:	3c 2d                	cmp    $0x2d,%al
  80266a:	75 0a                	jne    802676 <strtol+0x4c>
		s++, neg = 1;
  80266c:	ff 45 08             	incl   0x8(%ebp)
  80266f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802676:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80267a:	74 06                	je     802682 <strtol+0x58>
  80267c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  802680:	75 20                	jne    8026a2 <strtol+0x78>
  802682:	8b 45 08             	mov    0x8(%ebp),%eax
  802685:	8a 00                	mov    (%eax),%al
  802687:	3c 30                	cmp    $0x30,%al
  802689:	75 17                	jne    8026a2 <strtol+0x78>
  80268b:	8b 45 08             	mov    0x8(%ebp),%eax
  80268e:	40                   	inc    %eax
  80268f:	8a 00                	mov    (%eax),%al
  802691:	3c 78                	cmp    $0x78,%al
  802693:	75 0d                	jne    8026a2 <strtol+0x78>
		s += 2, base = 16;
  802695:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802699:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8026a0:	eb 28                	jmp    8026ca <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8026a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8026a6:	75 15                	jne    8026bd <strtol+0x93>
  8026a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ab:	8a 00                	mov    (%eax),%al
  8026ad:	3c 30                	cmp    $0x30,%al
  8026af:	75 0c                	jne    8026bd <strtol+0x93>
		s++, base = 8;
  8026b1:	ff 45 08             	incl   0x8(%ebp)
  8026b4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8026bb:	eb 0d                	jmp    8026ca <strtol+0xa0>
	else if (base == 0)
  8026bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8026c1:	75 07                	jne    8026ca <strtol+0xa0>
		base = 10;
  8026c3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8026ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8026cd:	8a 00                	mov    (%eax),%al
  8026cf:	3c 2f                	cmp    $0x2f,%al
  8026d1:	7e 19                	jle    8026ec <strtol+0xc2>
  8026d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8026d6:	8a 00                	mov    (%eax),%al
  8026d8:	3c 39                	cmp    $0x39,%al
  8026da:	7f 10                	jg     8026ec <strtol+0xc2>
			dig = *s - '0';
  8026dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8026df:	8a 00                	mov    (%eax),%al
  8026e1:	0f be c0             	movsbl %al,%eax
  8026e4:	83 e8 30             	sub    $0x30,%eax
  8026e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8026ea:	eb 42                	jmp    80272e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8026ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ef:	8a 00                	mov    (%eax),%al
  8026f1:	3c 60                	cmp    $0x60,%al
  8026f3:	7e 19                	jle    80270e <strtol+0xe4>
  8026f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8026f8:	8a 00                	mov    (%eax),%al
  8026fa:	3c 7a                	cmp    $0x7a,%al
  8026fc:	7f 10                	jg     80270e <strtol+0xe4>
			dig = *s - 'a' + 10;
  8026fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802701:	8a 00                	mov    (%eax),%al
  802703:	0f be c0             	movsbl %al,%eax
  802706:	83 e8 57             	sub    $0x57,%eax
  802709:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80270c:	eb 20                	jmp    80272e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80270e:	8b 45 08             	mov    0x8(%ebp),%eax
  802711:	8a 00                	mov    (%eax),%al
  802713:	3c 40                	cmp    $0x40,%al
  802715:	7e 39                	jle    802750 <strtol+0x126>
  802717:	8b 45 08             	mov    0x8(%ebp),%eax
  80271a:	8a 00                	mov    (%eax),%al
  80271c:	3c 5a                	cmp    $0x5a,%al
  80271e:	7f 30                	jg     802750 <strtol+0x126>
			dig = *s - 'A' + 10;
  802720:	8b 45 08             	mov    0x8(%ebp),%eax
  802723:	8a 00                	mov    (%eax),%al
  802725:	0f be c0             	movsbl %al,%eax
  802728:	83 e8 37             	sub    $0x37,%eax
  80272b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80272e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802731:	3b 45 10             	cmp    0x10(%ebp),%eax
  802734:	7d 19                	jge    80274f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802736:	ff 45 08             	incl   0x8(%ebp)
  802739:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80273c:	0f af 45 10          	imul   0x10(%ebp),%eax
  802740:	89 c2                	mov    %eax,%edx
  802742:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802745:	01 d0                	add    %edx,%eax
  802747:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80274a:	e9 7b ff ff ff       	jmp    8026ca <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80274f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  802750:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802754:	74 08                	je     80275e <strtol+0x134>
		*endptr = (char *) s;
  802756:	8b 45 0c             	mov    0xc(%ebp),%eax
  802759:	8b 55 08             	mov    0x8(%ebp),%edx
  80275c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80275e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802762:	74 07                	je     80276b <strtol+0x141>
  802764:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802767:	f7 d8                	neg    %eax
  802769:	eb 03                	jmp    80276e <strtol+0x144>
  80276b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80276e:	c9                   	leave  
  80276f:	c3                   	ret    

00802770 <ltostr>:

void
ltostr(long value, char *str)
{
  802770:	55                   	push   %ebp
  802771:	89 e5                	mov    %esp,%ebp
  802773:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802776:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80277d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802784:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802788:	79 13                	jns    80279d <ltostr+0x2d>
	{
		neg = 1;
  80278a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  802791:	8b 45 0c             	mov    0xc(%ebp),%eax
  802794:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802797:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80279a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80279d:	8b 45 08             	mov    0x8(%ebp),%eax
  8027a0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8027a5:	99                   	cltd   
  8027a6:	f7 f9                	idiv   %ecx
  8027a8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8027ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8027ae:	8d 50 01             	lea    0x1(%eax),%edx
  8027b1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8027b4:	89 c2                	mov    %eax,%edx
  8027b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8027b9:	01 d0                	add    %edx,%eax
  8027bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8027be:	83 c2 30             	add    $0x30,%edx
  8027c1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8027c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8027c6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8027cb:	f7 e9                	imul   %ecx
  8027cd:	c1 fa 02             	sar    $0x2,%edx
  8027d0:	89 c8                	mov    %ecx,%eax
  8027d2:	c1 f8 1f             	sar    $0x1f,%eax
  8027d5:	29 c2                	sub    %eax,%edx
  8027d7:	89 d0                	mov    %edx,%eax
  8027d9:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8027dc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8027df:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8027e4:	f7 e9                	imul   %ecx
  8027e6:	c1 fa 02             	sar    $0x2,%edx
  8027e9:	89 c8                	mov    %ecx,%eax
  8027eb:	c1 f8 1f             	sar    $0x1f,%eax
  8027ee:	29 c2                	sub    %eax,%edx
  8027f0:	89 d0                	mov    %edx,%eax
  8027f2:	c1 e0 02             	shl    $0x2,%eax
  8027f5:	01 d0                	add    %edx,%eax
  8027f7:	01 c0                	add    %eax,%eax
  8027f9:	29 c1                	sub    %eax,%ecx
  8027fb:	89 ca                	mov    %ecx,%edx
  8027fd:	85 d2                	test   %edx,%edx
  8027ff:	75 9c                	jne    80279d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  802801:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802808:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80280b:	48                   	dec    %eax
  80280c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80280f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802813:	74 3d                	je     802852 <ltostr+0xe2>
		start = 1 ;
  802815:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80281c:	eb 34                	jmp    802852 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80281e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802821:	8b 45 0c             	mov    0xc(%ebp),%eax
  802824:	01 d0                	add    %edx,%eax
  802826:	8a 00                	mov    (%eax),%al
  802828:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80282b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80282e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802831:	01 c2                	add    %eax,%edx
  802833:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802836:	8b 45 0c             	mov    0xc(%ebp),%eax
  802839:	01 c8                	add    %ecx,%eax
  80283b:	8a 00                	mov    (%eax),%al
  80283d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80283f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802842:	8b 45 0c             	mov    0xc(%ebp),%eax
  802845:	01 c2                	add    %eax,%edx
  802847:	8a 45 eb             	mov    -0x15(%ebp),%al
  80284a:	88 02                	mov    %al,(%edx)
		start++ ;
  80284c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80284f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  802852:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802855:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802858:	7c c4                	jl     80281e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80285a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80285d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802860:	01 d0                	add    %edx,%eax
  802862:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802865:	90                   	nop
  802866:	c9                   	leave  
  802867:	c3                   	ret    

00802868 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802868:	55                   	push   %ebp
  802869:	89 e5                	mov    %esp,%ebp
  80286b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80286e:	ff 75 08             	pushl  0x8(%ebp)
  802871:	e8 54 fa ff ff       	call   8022ca <strlen>
  802876:	83 c4 04             	add    $0x4,%esp
  802879:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80287c:	ff 75 0c             	pushl  0xc(%ebp)
  80287f:	e8 46 fa ff ff       	call   8022ca <strlen>
  802884:	83 c4 04             	add    $0x4,%esp
  802887:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80288a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  802891:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802898:	eb 17                	jmp    8028b1 <strcconcat+0x49>
		final[s] = str1[s] ;
  80289a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80289d:	8b 45 10             	mov    0x10(%ebp),%eax
  8028a0:	01 c2                	add    %eax,%edx
  8028a2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8028a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8028a8:	01 c8                	add    %ecx,%eax
  8028aa:	8a 00                	mov    (%eax),%al
  8028ac:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8028ae:	ff 45 fc             	incl   -0x4(%ebp)
  8028b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8028b4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8028b7:	7c e1                	jl     80289a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8028b9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8028c0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8028c7:	eb 1f                	jmp    8028e8 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8028c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8028cc:	8d 50 01             	lea    0x1(%eax),%edx
  8028cf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8028d2:	89 c2                	mov    %eax,%edx
  8028d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8028d7:	01 c2                	add    %eax,%edx
  8028d9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8028dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8028df:	01 c8                	add    %ecx,%eax
  8028e1:	8a 00                	mov    (%eax),%al
  8028e3:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8028e5:	ff 45 f8             	incl   -0x8(%ebp)
  8028e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8028eb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8028ee:	7c d9                	jl     8028c9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8028f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8028f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8028f6:	01 d0                	add    %edx,%eax
  8028f8:	c6 00 00             	movb   $0x0,(%eax)
}
  8028fb:	90                   	nop
  8028fc:	c9                   	leave  
  8028fd:	c3                   	ret    

008028fe <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8028fe:	55                   	push   %ebp
  8028ff:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  802901:	8b 45 14             	mov    0x14(%ebp),%eax
  802904:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80290a:	8b 45 14             	mov    0x14(%ebp),%eax
  80290d:	8b 00                	mov    (%eax),%eax
  80290f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802916:	8b 45 10             	mov    0x10(%ebp),%eax
  802919:	01 d0                	add    %edx,%eax
  80291b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802921:	eb 0c                	jmp    80292f <strsplit+0x31>
			*string++ = 0;
  802923:	8b 45 08             	mov    0x8(%ebp),%eax
  802926:	8d 50 01             	lea    0x1(%eax),%edx
  802929:	89 55 08             	mov    %edx,0x8(%ebp)
  80292c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80292f:	8b 45 08             	mov    0x8(%ebp),%eax
  802932:	8a 00                	mov    (%eax),%al
  802934:	84 c0                	test   %al,%al
  802936:	74 18                	je     802950 <strsplit+0x52>
  802938:	8b 45 08             	mov    0x8(%ebp),%eax
  80293b:	8a 00                	mov    (%eax),%al
  80293d:	0f be c0             	movsbl %al,%eax
  802940:	50                   	push   %eax
  802941:	ff 75 0c             	pushl  0xc(%ebp)
  802944:	e8 13 fb ff ff       	call   80245c <strchr>
  802949:	83 c4 08             	add    $0x8,%esp
  80294c:	85 c0                	test   %eax,%eax
  80294e:	75 d3                	jne    802923 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  802950:	8b 45 08             	mov    0x8(%ebp),%eax
  802953:	8a 00                	mov    (%eax),%al
  802955:	84 c0                	test   %al,%al
  802957:	74 5a                	je     8029b3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802959:	8b 45 14             	mov    0x14(%ebp),%eax
  80295c:	8b 00                	mov    (%eax),%eax
  80295e:	83 f8 0f             	cmp    $0xf,%eax
  802961:	75 07                	jne    80296a <strsplit+0x6c>
		{
			return 0;
  802963:	b8 00 00 00 00       	mov    $0x0,%eax
  802968:	eb 66                	jmp    8029d0 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80296a:	8b 45 14             	mov    0x14(%ebp),%eax
  80296d:	8b 00                	mov    (%eax),%eax
  80296f:	8d 48 01             	lea    0x1(%eax),%ecx
  802972:	8b 55 14             	mov    0x14(%ebp),%edx
  802975:	89 0a                	mov    %ecx,(%edx)
  802977:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80297e:	8b 45 10             	mov    0x10(%ebp),%eax
  802981:	01 c2                	add    %eax,%edx
  802983:	8b 45 08             	mov    0x8(%ebp),%eax
  802986:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802988:	eb 03                	jmp    80298d <strsplit+0x8f>
			string++;
  80298a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80298d:	8b 45 08             	mov    0x8(%ebp),%eax
  802990:	8a 00                	mov    (%eax),%al
  802992:	84 c0                	test   %al,%al
  802994:	74 8b                	je     802921 <strsplit+0x23>
  802996:	8b 45 08             	mov    0x8(%ebp),%eax
  802999:	8a 00                	mov    (%eax),%al
  80299b:	0f be c0             	movsbl %al,%eax
  80299e:	50                   	push   %eax
  80299f:	ff 75 0c             	pushl  0xc(%ebp)
  8029a2:	e8 b5 fa ff ff       	call   80245c <strchr>
  8029a7:	83 c4 08             	add    $0x8,%esp
  8029aa:	85 c0                	test   %eax,%eax
  8029ac:	74 dc                	je     80298a <strsplit+0x8c>
			string++;
	}
  8029ae:	e9 6e ff ff ff       	jmp    802921 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8029b3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8029b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8029b7:	8b 00                	mov    (%eax),%eax
  8029b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8029c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8029c3:	01 d0                	add    %edx,%eax
  8029c5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8029cb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8029d0:	c9                   	leave  
  8029d1:	c3                   	ret    

008029d2 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8029d2:	55                   	push   %ebp
  8029d3:	89 e5                	mov    %esp,%ebp
  8029d5:	83 ec 18             	sub    $0x18,%esp
  8029d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8029db:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8029de:	83 ec 04             	sub    $0x4,%esp
  8029e1:	68 50 3c 80 00       	push   $0x803c50
  8029e6:	6a 17                	push   $0x17
  8029e8:	68 6f 3c 80 00       	push   $0x803c6f
  8029ed:	e8 a2 ef ff ff       	call   801994 <_panic>

008029f2 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8029f2:	55                   	push   %ebp
  8029f3:	89 e5                	mov    %esp,%ebp
  8029f5:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8029f8:	83 ec 04             	sub    $0x4,%esp
  8029fb:	68 7b 3c 80 00       	push   $0x803c7b
  802a00:	6a 2f                	push   $0x2f
  802a02:	68 6f 3c 80 00       	push   $0x803c6f
  802a07:	e8 88 ef ff ff       	call   801994 <_panic>

00802a0c <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  802a0c:	55                   	push   %ebp
  802a0d:	89 e5                	mov    %esp,%ebp
  802a0f:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  802a12:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  802a19:	8b 55 08             	mov    0x8(%ebp),%edx
  802a1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a1f:	01 d0                	add    %edx,%eax
  802a21:	48                   	dec    %eax
  802a22:	89 45 e8             	mov    %eax,-0x18(%ebp)
  802a25:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802a28:	ba 00 00 00 00       	mov    $0x0,%edx
  802a2d:	f7 75 ec             	divl   -0x14(%ebp)
  802a30:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802a33:	29 d0                	sub    %edx,%eax
  802a35:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  802a38:	8b 45 08             	mov    0x8(%ebp),%eax
  802a3b:	c1 e8 0c             	shr    $0xc,%eax
  802a3e:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  802a41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802a48:	e9 c8 00 00 00       	jmp    802b15 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  802a4d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802a54:	eb 27                	jmp    802a7d <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  802a56:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a5c:	01 c2                	add    %eax,%edx
  802a5e:	89 d0                	mov    %edx,%eax
  802a60:	01 c0                	add    %eax,%eax
  802a62:	01 d0                	add    %edx,%eax
  802a64:	c1 e0 02             	shl    $0x2,%eax
  802a67:	05 48 40 80 00       	add    $0x804048,%eax
  802a6c:	8b 00                	mov    (%eax),%eax
  802a6e:	85 c0                	test   %eax,%eax
  802a70:	74 08                	je     802a7a <malloc+0x6e>
            	i += j;
  802a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a75:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  802a78:	eb 0b                	jmp    802a85 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  802a7a:	ff 45 f0             	incl   -0x10(%ebp)
  802a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a80:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802a83:	72 d1                	jb     802a56 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  802a85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a88:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802a8b:	0f 85 81 00 00 00    	jne    802b12 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  802a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a94:	05 00 00 08 00       	add    $0x80000,%eax
  802a99:	c1 e0 0c             	shl    $0xc,%eax
  802a9c:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  802a9f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802aa6:	eb 1f                	jmp    802ac7 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  802aa8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802aae:	01 c2                	add    %eax,%edx
  802ab0:	89 d0                	mov    %edx,%eax
  802ab2:	01 c0                	add    %eax,%eax
  802ab4:	01 d0                	add    %edx,%eax
  802ab6:	c1 e0 02             	shl    $0x2,%eax
  802ab9:	05 48 40 80 00       	add    $0x804048,%eax
  802abe:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  802ac4:	ff 45 f0             	incl   -0x10(%ebp)
  802ac7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802aca:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802acd:	72 d9                	jb     802aa8 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  802acf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802ad2:	89 d0                	mov    %edx,%eax
  802ad4:	01 c0                	add    %eax,%eax
  802ad6:	01 d0                	add    %edx,%eax
  802ad8:	c1 e0 02             	shl    $0x2,%eax
  802adb:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  802ae1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802ae4:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  802ae6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802ae9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  802aec:	89 c8                	mov    %ecx,%eax
  802aee:	01 c0                	add    %eax,%eax
  802af0:	01 c8                	add    %ecx,%eax
  802af2:	c1 e0 02             	shl    $0x2,%eax
  802af5:	05 44 40 80 00       	add    $0x804044,%eax
  802afa:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  802afc:	83 ec 08             	sub    $0x8,%esp
  802aff:	ff 75 08             	pushl  0x8(%ebp)
  802b02:	ff 75 e0             	pushl  -0x20(%ebp)
  802b05:	e8 2b 03 00 00       	call   802e35 <sys_allocateMem>
  802b0a:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  802b0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802b10:	eb 19                	jmp    802b2b <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  802b12:	ff 45 f4             	incl   -0xc(%ebp)
  802b15:	a1 04 40 80 00       	mov    0x804004,%eax
  802b1a:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  802b1d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802b20:	0f 83 27 ff ff ff    	jae    802a4d <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  802b26:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b2b:	c9                   	leave  
  802b2c:	c3                   	ret    

00802b2d <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  802b2d:	55                   	push   %ebp
  802b2e:	89 e5                	mov    %esp,%ebp
  802b30:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  802b33:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802b37:	0f 84 e5 00 00 00    	je     802c22 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  802b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  802b40:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  802b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802b46:	05 00 00 00 80       	add    $0x80000000,%eax
  802b4b:	c1 e8 0c             	shr    $0xc,%eax
  802b4e:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  802b51:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802b54:	89 d0                	mov    %edx,%eax
  802b56:	01 c0                	add    %eax,%eax
  802b58:	01 d0                	add    %edx,%eax
  802b5a:	c1 e0 02             	shl    $0x2,%eax
  802b5d:	05 40 40 80 00       	add    $0x804040,%eax
  802b62:	8b 00                	mov    (%eax),%eax
  802b64:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802b67:	0f 85 b8 00 00 00    	jne    802c25 <free+0xf8>
  802b6d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802b70:	89 d0                	mov    %edx,%eax
  802b72:	01 c0                	add    %eax,%eax
  802b74:	01 d0                	add    %edx,%eax
  802b76:	c1 e0 02             	shl    $0x2,%eax
  802b79:	05 48 40 80 00       	add    $0x804048,%eax
  802b7e:	8b 00                	mov    (%eax),%eax
  802b80:	85 c0                	test   %eax,%eax
  802b82:	0f 84 9d 00 00 00    	je     802c25 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  802b88:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802b8b:	89 d0                	mov    %edx,%eax
  802b8d:	01 c0                	add    %eax,%eax
  802b8f:	01 d0                	add    %edx,%eax
  802b91:	c1 e0 02             	shl    $0x2,%eax
  802b94:	05 44 40 80 00       	add    $0x804044,%eax
  802b99:	8b 00                	mov    (%eax),%eax
  802b9b:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  802b9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802ba1:	c1 e0 0c             	shl    $0xc,%eax
  802ba4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  802ba7:	83 ec 08             	sub    $0x8,%esp
  802baa:	ff 75 e4             	pushl  -0x1c(%ebp)
  802bad:	ff 75 f0             	pushl  -0x10(%ebp)
  802bb0:	e8 64 02 00 00       	call   802e19 <sys_freeMem>
  802bb5:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802bb8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802bbf:	eb 57                	jmp    802c18 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  802bc1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802bc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802bc7:	01 c2                	add    %eax,%edx
  802bc9:	89 d0                	mov    %edx,%eax
  802bcb:	01 c0                	add    %eax,%eax
  802bcd:	01 d0                	add    %edx,%eax
  802bcf:	c1 e0 02             	shl    $0x2,%eax
  802bd2:	05 48 40 80 00       	add    $0x804048,%eax
  802bd7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  802bdd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802be0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802be3:	01 c2                	add    %eax,%edx
  802be5:	89 d0                	mov    %edx,%eax
  802be7:	01 c0                	add    %eax,%eax
  802be9:	01 d0                	add    %edx,%eax
  802beb:	c1 e0 02             	shl    $0x2,%eax
  802bee:	05 40 40 80 00       	add    $0x804040,%eax
  802bf3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  802bf9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802bff:	01 c2                	add    %eax,%edx
  802c01:	89 d0                	mov    %edx,%eax
  802c03:	01 c0                	add    %eax,%eax
  802c05:	01 d0                	add    %edx,%eax
  802c07:	c1 e0 02             	shl    $0x2,%eax
  802c0a:	05 44 40 80 00       	add    $0x804044,%eax
  802c0f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802c15:	ff 45 f4             	incl   -0xc(%ebp)
  802c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802c1b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802c1e:	7c a1                	jl     802bc1 <free+0x94>
  802c20:	eb 04                	jmp    802c26 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  802c22:	90                   	nop
  802c23:	eb 01                	jmp    802c26 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  802c25:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  802c26:	c9                   	leave  
  802c27:	c3                   	ret    

00802c28 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  802c28:	55                   	push   %ebp
  802c29:	89 e5                	mov    %esp,%ebp
  802c2b:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  802c2e:	83 ec 04             	sub    $0x4,%esp
  802c31:	68 98 3c 80 00       	push   $0x803c98
  802c36:	68 ae 00 00 00       	push   $0xae
  802c3b:	68 6f 3c 80 00       	push   $0x803c6f
  802c40:	e8 4f ed ff ff       	call   801994 <_panic>

00802c45 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802c45:	55                   	push   %ebp
  802c46:	89 e5                	mov    %esp,%ebp
  802c48:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  802c4b:	83 ec 04             	sub    $0x4,%esp
  802c4e:	68 b8 3c 80 00       	push   $0x803cb8
  802c53:	68 ca 00 00 00       	push   $0xca
  802c58:	68 6f 3c 80 00       	push   $0x803c6f
  802c5d:	e8 32 ed ff ff       	call   801994 <_panic>

00802c62 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802c62:	55                   	push   %ebp
  802c63:	89 e5                	mov    %esp,%ebp
  802c65:	57                   	push   %edi
  802c66:	56                   	push   %esi
  802c67:	53                   	push   %ebx
  802c68:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  802c6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c71:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802c74:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802c77:	8b 7d 18             	mov    0x18(%ebp),%edi
  802c7a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802c7d:	cd 30                	int    $0x30
  802c7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802c82:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802c85:	83 c4 10             	add    $0x10,%esp
  802c88:	5b                   	pop    %ebx
  802c89:	5e                   	pop    %esi
  802c8a:	5f                   	pop    %edi
  802c8b:	5d                   	pop    %ebp
  802c8c:	c3                   	ret    

00802c8d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802c8d:	55                   	push   %ebp
  802c8e:	89 e5                	mov    %esp,%ebp
  802c90:	83 ec 04             	sub    $0x4,%esp
  802c93:	8b 45 10             	mov    0x10(%ebp),%eax
  802c96:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802c99:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  802ca0:	6a 00                	push   $0x0
  802ca2:	6a 00                	push   $0x0
  802ca4:	52                   	push   %edx
  802ca5:	ff 75 0c             	pushl  0xc(%ebp)
  802ca8:	50                   	push   %eax
  802ca9:	6a 00                	push   $0x0
  802cab:	e8 b2 ff ff ff       	call   802c62 <syscall>
  802cb0:	83 c4 18             	add    $0x18,%esp
}
  802cb3:	90                   	nop
  802cb4:	c9                   	leave  
  802cb5:	c3                   	ret    

00802cb6 <sys_cgetc>:

int
sys_cgetc(void)
{
  802cb6:	55                   	push   %ebp
  802cb7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802cb9:	6a 00                	push   $0x0
  802cbb:	6a 00                	push   $0x0
  802cbd:	6a 00                	push   $0x0
  802cbf:	6a 00                	push   $0x0
  802cc1:	6a 00                	push   $0x0
  802cc3:	6a 01                	push   $0x1
  802cc5:	e8 98 ff ff ff       	call   802c62 <syscall>
  802cca:	83 c4 18             	add    $0x18,%esp
}
  802ccd:	c9                   	leave  
  802cce:	c3                   	ret    

00802ccf <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802ccf:	55                   	push   %ebp
  802cd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  802cd5:	6a 00                	push   $0x0
  802cd7:	6a 00                	push   $0x0
  802cd9:	6a 00                	push   $0x0
  802cdb:	6a 00                	push   $0x0
  802cdd:	50                   	push   %eax
  802cde:	6a 05                	push   $0x5
  802ce0:	e8 7d ff ff ff       	call   802c62 <syscall>
  802ce5:	83 c4 18             	add    $0x18,%esp
}
  802ce8:	c9                   	leave  
  802ce9:	c3                   	ret    

00802cea <sys_getenvid>:

int32 sys_getenvid(void)
{
  802cea:	55                   	push   %ebp
  802ceb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802ced:	6a 00                	push   $0x0
  802cef:	6a 00                	push   $0x0
  802cf1:	6a 00                	push   $0x0
  802cf3:	6a 00                	push   $0x0
  802cf5:	6a 00                	push   $0x0
  802cf7:	6a 02                	push   $0x2
  802cf9:	e8 64 ff ff ff       	call   802c62 <syscall>
  802cfe:	83 c4 18             	add    $0x18,%esp
}
  802d01:	c9                   	leave  
  802d02:	c3                   	ret    

00802d03 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802d03:	55                   	push   %ebp
  802d04:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802d06:	6a 00                	push   $0x0
  802d08:	6a 00                	push   $0x0
  802d0a:	6a 00                	push   $0x0
  802d0c:	6a 00                	push   $0x0
  802d0e:	6a 00                	push   $0x0
  802d10:	6a 03                	push   $0x3
  802d12:	e8 4b ff ff ff       	call   802c62 <syscall>
  802d17:	83 c4 18             	add    $0x18,%esp
}
  802d1a:	c9                   	leave  
  802d1b:	c3                   	ret    

00802d1c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802d1c:	55                   	push   %ebp
  802d1d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802d1f:	6a 00                	push   $0x0
  802d21:	6a 00                	push   $0x0
  802d23:	6a 00                	push   $0x0
  802d25:	6a 00                	push   $0x0
  802d27:	6a 00                	push   $0x0
  802d29:	6a 04                	push   $0x4
  802d2b:	e8 32 ff ff ff       	call   802c62 <syscall>
  802d30:	83 c4 18             	add    $0x18,%esp
}
  802d33:	c9                   	leave  
  802d34:	c3                   	ret    

00802d35 <sys_env_exit>:


void sys_env_exit(void)
{
  802d35:	55                   	push   %ebp
  802d36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802d38:	6a 00                	push   $0x0
  802d3a:	6a 00                	push   $0x0
  802d3c:	6a 00                	push   $0x0
  802d3e:	6a 00                	push   $0x0
  802d40:	6a 00                	push   $0x0
  802d42:	6a 06                	push   $0x6
  802d44:	e8 19 ff ff ff       	call   802c62 <syscall>
  802d49:	83 c4 18             	add    $0x18,%esp
}
  802d4c:	90                   	nop
  802d4d:	c9                   	leave  
  802d4e:	c3                   	ret    

00802d4f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802d4f:	55                   	push   %ebp
  802d50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802d52:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d55:	8b 45 08             	mov    0x8(%ebp),%eax
  802d58:	6a 00                	push   $0x0
  802d5a:	6a 00                	push   $0x0
  802d5c:	6a 00                	push   $0x0
  802d5e:	52                   	push   %edx
  802d5f:	50                   	push   %eax
  802d60:	6a 07                	push   $0x7
  802d62:	e8 fb fe ff ff       	call   802c62 <syscall>
  802d67:	83 c4 18             	add    $0x18,%esp
}
  802d6a:	c9                   	leave  
  802d6b:	c3                   	ret    

00802d6c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802d6c:	55                   	push   %ebp
  802d6d:	89 e5                	mov    %esp,%ebp
  802d6f:	56                   	push   %esi
  802d70:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802d71:	8b 75 18             	mov    0x18(%ebp),%esi
  802d74:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802d77:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802d7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  802d80:	56                   	push   %esi
  802d81:	53                   	push   %ebx
  802d82:	51                   	push   %ecx
  802d83:	52                   	push   %edx
  802d84:	50                   	push   %eax
  802d85:	6a 08                	push   $0x8
  802d87:	e8 d6 fe ff ff       	call   802c62 <syscall>
  802d8c:	83 c4 18             	add    $0x18,%esp
}
  802d8f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802d92:	5b                   	pop    %ebx
  802d93:	5e                   	pop    %esi
  802d94:	5d                   	pop    %ebp
  802d95:	c3                   	ret    

00802d96 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802d96:	55                   	push   %ebp
  802d97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802d99:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  802d9f:	6a 00                	push   $0x0
  802da1:	6a 00                	push   $0x0
  802da3:	6a 00                	push   $0x0
  802da5:	52                   	push   %edx
  802da6:	50                   	push   %eax
  802da7:	6a 09                	push   $0x9
  802da9:	e8 b4 fe ff ff       	call   802c62 <syscall>
  802dae:	83 c4 18             	add    $0x18,%esp
}
  802db1:	c9                   	leave  
  802db2:	c3                   	ret    

00802db3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802db3:	55                   	push   %ebp
  802db4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802db6:	6a 00                	push   $0x0
  802db8:	6a 00                	push   $0x0
  802dba:	6a 00                	push   $0x0
  802dbc:	ff 75 0c             	pushl  0xc(%ebp)
  802dbf:	ff 75 08             	pushl  0x8(%ebp)
  802dc2:	6a 0a                	push   $0xa
  802dc4:	e8 99 fe ff ff       	call   802c62 <syscall>
  802dc9:	83 c4 18             	add    $0x18,%esp
}
  802dcc:	c9                   	leave  
  802dcd:	c3                   	ret    

00802dce <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802dce:	55                   	push   %ebp
  802dcf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802dd1:	6a 00                	push   $0x0
  802dd3:	6a 00                	push   $0x0
  802dd5:	6a 00                	push   $0x0
  802dd7:	6a 00                	push   $0x0
  802dd9:	6a 00                	push   $0x0
  802ddb:	6a 0b                	push   $0xb
  802ddd:	e8 80 fe ff ff       	call   802c62 <syscall>
  802de2:	83 c4 18             	add    $0x18,%esp
}
  802de5:	c9                   	leave  
  802de6:	c3                   	ret    

00802de7 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802de7:	55                   	push   %ebp
  802de8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802dea:	6a 00                	push   $0x0
  802dec:	6a 00                	push   $0x0
  802dee:	6a 00                	push   $0x0
  802df0:	6a 00                	push   $0x0
  802df2:	6a 00                	push   $0x0
  802df4:	6a 0c                	push   $0xc
  802df6:	e8 67 fe ff ff       	call   802c62 <syscall>
  802dfb:	83 c4 18             	add    $0x18,%esp
}
  802dfe:	c9                   	leave  
  802dff:	c3                   	ret    

00802e00 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802e00:	55                   	push   %ebp
  802e01:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802e03:	6a 00                	push   $0x0
  802e05:	6a 00                	push   $0x0
  802e07:	6a 00                	push   $0x0
  802e09:	6a 00                	push   $0x0
  802e0b:	6a 00                	push   $0x0
  802e0d:	6a 0d                	push   $0xd
  802e0f:	e8 4e fe ff ff       	call   802c62 <syscall>
  802e14:	83 c4 18             	add    $0x18,%esp
}
  802e17:	c9                   	leave  
  802e18:	c3                   	ret    

00802e19 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802e19:	55                   	push   %ebp
  802e1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802e1c:	6a 00                	push   $0x0
  802e1e:	6a 00                	push   $0x0
  802e20:	6a 00                	push   $0x0
  802e22:	ff 75 0c             	pushl  0xc(%ebp)
  802e25:	ff 75 08             	pushl  0x8(%ebp)
  802e28:	6a 11                	push   $0x11
  802e2a:	e8 33 fe ff ff       	call   802c62 <syscall>
  802e2f:	83 c4 18             	add    $0x18,%esp
	return;
  802e32:	90                   	nop
}
  802e33:	c9                   	leave  
  802e34:	c3                   	ret    

00802e35 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802e35:	55                   	push   %ebp
  802e36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802e38:	6a 00                	push   $0x0
  802e3a:	6a 00                	push   $0x0
  802e3c:	6a 00                	push   $0x0
  802e3e:	ff 75 0c             	pushl  0xc(%ebp)
  802e41:	ff 75 08             	pushl  0x8(%ebp)
  802e44:	6a 12                	push   $0x12
  802e46:	e8 17 fe ff ff       	call   802c62 <syscall>
  802e4b:	83 c4 18             	add    $0x18,%esp
	return ;
  802e4e:	90                   	nop
}
  802e4f:	c9                   	leave  
  802e50:	c3                   	ret    

00802e51 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802e51:	55                   	push   %ebp
  802e52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802e54:	6a 00                	push   $0x0
  802e56:	6a 00                	push   $0x0
  802e58:	6a 00                	push   $0x0
  802e5a:	6a 00                	push   $0x0
  802e5c:	6a 00                	push   $0x0
  802e5e:	6a 0e                	push   $0xe
  802e60:	e8 fd fd ff ff       	call   802c62 <syscall>
  802e65:	83 c4 18             	add    $0x18,%esp
}
  802e68:	c9                   	leave  
  802e69:	c3                   	ret    

00802e6a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802e6a:	55                   	push   %ebp
  802e6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802e6d:	6a 00                	push   $0x0
  802e6f:	6a 00                	push   $0x0
  802e71:	6a 00                	push   $0x0
  802e73:	6a 00                	push   $0x0
  802e75:	ff 75 08             	pushl  0x8(%ebp)
  802e78:	6a 0f                	push   $0xf
  802e7a:	e8 e3 fd ff ff       	call   802c62 <syscall>
  802e7f:	83 c4 18             	add    $0x18,%esp
}
  802e82:	c9                   	leave  
  802e83:	c3                   	ret    

00802e84 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802e84:	55                   	push   %ebp
  802e85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802e87:	6a 00                	push   $0x0
  802e89:	6a 00                	push   $0x0
  802e8b:	6a 00                	push   $0x0
  802e8d:	6a 00                	push   $0x0
  802e8f:	6a 00                	push   $0x0
  802e91:	6a 10                	push   $0x10
  802e93:	e8 ca fd ff ff       	call   802c62 <syscall>
  802e98:	83 c4 18             	add    $0x18,%esp
}
  802e9b:	90                   	nop
  802e9c:	c9                   	leave  
  802e9d:	c3                   	ret    

00802e9e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802e9e:	55                   	push   %ebp
  802e9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802ea1:	6a 00                	push   $0x0
  802ea3:	6a 00                	push   $0x0
  802ea5:	6a 00                	push   $0x0
  802ea7:	6a 00                	push   $0x0
  802ea9:	6a 00                	push   $0x0
  802eab:	6a 14                	push   $0x14
  802ead:	e8 b0 fd ff ff       	call   802c62 <syscall>
  802eb2:	83 c4 18             	add    $0x18,%esp
}
  802eb5:	90                   	nop
  802eb6:	c9                   	leave  
  802eb7:	c3                   	ret    

00802eb8 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802eb8:	55                   	push   %ebp
  802eb9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802ebb:	6a 00                	push   $0x0
  802ebd:	6a 00                	push   $0x0
  802ebf:	6a 00                	push   $0x0
  802ec1:	6a 00                	push   $0x0
  802ec3:	6a 00                	push   $0x0
  802ec5:	6a 15                	push   $0x15
  802ec7:	e8 96 fd ff ff       	call   802c62 <syscall>
  802ecc:	83 c4 18             	add    $0x18,%esp
}
  802ecf:	90                   	nop
  802ed0:	c9                   	leave  
  802ed1:	c3                   	ret    

00802ed2 <sys_cputc>:


void
sys_cputc(const char c)
{
  802ed2:	55                   	push   %ebp
  802ed3:	89 e5                	mov    %esp,%ebp
  802ed5:	83 ec 04             	sub    $0x4,%esp
  802ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  802edb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802ede:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802ee2:	6a 00                	push   $0x0
  802ee4:	6a 00                	push   $0x0
  802ee6:	6a 00                	push   $0x0
  802ee8:	6a 00                	push   $0x0
  802eea:	50                   	push   %eax
  802eeb:	6a 16                	push   $0x16
  802eed:	e8 70 fd ff ff       	call   802c62 <syscall>
  802ef2:	83 c4 18             	add    $0x18,%esp
}
  802ef5:	90                   	nop
  802ef6:	c9                   	leave  
  802ef7:	c3                   	ret    

00802ef8 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802ef8:	55                   	push   %ebp
  802ef9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802efb:	6a 00                	push   $0x0
  802efd:	6a 00                	push   $0x0
  802eff:	6a 00                	push   $0x0
  802f01:	6a 00                	push   $0x0
  802f03:	6a 00                	push   $0x0
  802f05:	6a 17                	push   $0x17
  802f07:	e8 56 fd ff ff       	call   802c62 <syscall>
  802f0c:	83 c4 18             	add    $0x18,%esp
}
  802f0f:	90                   	nop
  802f10:	c9                   	leave  
  802f11:	c3                   	ret    

00802f12 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802f12:	55                   	push   %ebp
  802f13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802f15:	8b 45 08             	mov    0x8(%ebp),%eax
  802f18:	6a 00                	push   $0x0
  802f1a:	6a 00                	push   $0x0
  802f1c:	6a 00                	push   $0x0
  802f1e:	ff 75 0c             	pushl  0xc(%ebp)
  802f21:	50                   	push   %eax
  802f22:	6a 18                	push   $0x18
  802f24:	e8 39 fd ff ff       	call   802c62 <syscall>
  802f29:	83 c4 18             	add    $0x18,%esp
}
  802f2c:	c9                   	leave  
  802f2d:	c3                   	ret    

00802f2e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802f2e:	55                   	push   %ebp
  802f2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802f31:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f34:	8b 45 08             	mov    0x8(%ebp),%eax
  802f37:	6a 00                	push   $0x0
  802f39:	6a 00                	push   $0x0
  802f3b:	6a 00                	push   $0x0
  802f3d:	52                   	push   %edx
  802f3e:	50                   	push   %eax
  802f3f:	6a 1b                	push   $0x1b
  802f41:	e8 1c fd ff ff       	call   802c62 <syscall>
  802f46:	83 c4 18             	add    $0x18,%esp
}
  802f49:	c9                   	leave  
  802f4a:	c3                   	ret    

00802f4b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802f4b:	55                   	push   %ebp
  802f4c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802f4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f51:	8b 45 08             	mov    0x8(%ebp),%eax
  802f54:	6a 00                	push   $0x0
  802f56:	6a 00                	push   $0x0
  802f58:	6a 00                	push   $0x0
  802f5a:	52                   	push   %edx
  802f5b:	50                   	push   %eax
  802f5c:	6a 19                	push   $0x19
  802f5e:	e8 ff fc ff ff       	call   802c62 <syscall>
  802f63:	83 c4 18             	add    $0x18,%esp
}
  802f66:	90                   	nop
  802f67:	c9                   	leave  
  802f68:	c3                   	ret    

00802f69 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802f69:	55                   	push   %ebp
  802f6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802f6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  802f72:	6a 00                	push   $0x0
  802f74:	6a 00                	push   $0x0
  802f76:	6a 00                	push   $0x0
  802f78:	52                   	push   %edx
  802f79:	50                   	push   %eax
  802f7a:	6a 1a                	push   $0x1a
  802f7c:	e8 e1 fc ff ff       	call   802c62 <syscall>
  802f81:	83 c4 18             	add    $0x18,%esp
}
  802f84:	90                   	nop
  802f85:	c9                   	leave  
  802f86:	c3                   	ret    

00802f87 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802f87:	55                   	push   %ebp
  802f88:	89 e5                	mov    %esp,%ebp
  802f8a:	83 ec 04             	sub    $0x4,%esp
  802f8d:	8b 45 10             	mov    0x10(%ebp),%eax
  802f90:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802f93:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802f96:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  802f9d:	6a 00                	push   $0x0
  802f9f:	51                   	push   %ecx
  802fa0:	52                   	push   %edx
  802fa1:	ff 75 0c             	pushl  0xc(%ebp)
  802fa4:	50                   	push   %eax
  802fa5:	6a 1c                	push   $0x1c
  802fa7:	e8 b6 fc ff ff       	call   802c62 <syscall>
  802fac:	83 c4 18             	add    $0x18,%esp
}
  802faf:	c9                   	leave  
  802fb0:	c3                   	ret    

00802fb1 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802fb1:	55                   	push   %ebp
  802fb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802fb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  802fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  802fba:	6a 00                	push   $0x0
  802fbc:	6a 00                	push   $0x0
  802fbe:	6a 00                	push   $0x0
  802fc0:	52                   	push   %edx
  802fc1:	50                   	push   %eax
  802fc2:	6a 1d                	push   $0x1d
  802fc4:	e8 99 fc ff ff       	call   802c62 <syscall>
  802fc9:	83 c4 18             	add    $0x18,%esp
}
  802fcc:	c9                   	leave  
  802fcd:	c3                   	ret    

00802fce <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802fce:	55                   	push   %ebp
  802fcf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802fd1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802fd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  802fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  802fda:	6a 00                	push   $0x0
  802fdc:	6a 00                	push   $0x0
  802fde:	51                   	push   %ecx
  802fdf:	52                   	push   %edx
  802fe0:	50                   	push   %eax
  802fe1:	6a 1e                	push   $0x1e
  802fe3:	e8 7a fc ff ff       	call   802c62 <syscall>
  802fe8:	83 c4 18             	add    $0x18,%esp
}
  802feb:	c9                   	leave  
  802fec:	c3                   	ret    

00802fed <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802fed:	55                   	push   %ebp
  802fee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802ff0:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  802ff6:	6a 00                	push   $0x0
  802ff8:	6a 00                	push   $0x0
  802ffa:	6a 00                	push   $0x0
  802ffc:	52                   	push   %edx
  802ffd:	50                   	push   %eax
  802ffe:	6a 1f                	push   $0x1f
  803000:	e8 5d fc ff ff       	call   802c62 <syscall>
  803005:	83 c4 18             	add    $0x18,%esp
}
  803008:	c9                   	leave  
  803009:	c3                   	ret    

0080300a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80300a:	55                   	push   %ebp
  80300b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80300d:	6a 00                	push   $0x0
  80300f:	6a 00                	push   $0x0
  803011:	6a 00                	push   $0x0
  803013:	6a 00                	push   $0x0
  803015:	6a 00                	push   $0x0
  803017:	6a 20                	push   $0x20
  803019:	e8 44 fc ff ff       	call   802c62 <syscall>
  80301e:	83 c4 18             	add    $0x18,%esp
}
  803021:	c9                   	leave  
  803022:	c3                   	ret    

00803023 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  803023:	55                   	push   %ebp
  803024:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  803026:	8b 45 08             	mov    0x8(%ebp),%eax
  803029:	6a 00                	push   $0x0
  80302b:	6a 00                	push   $0x0
  80302d:	ff 75 10             	pushl  0x10(%ebp)
  803030:	ff 75 0c             	pushl  0xc(%ebp)
  803033:	50                   	push   %eax
  803034:	6a 21                	push   $0x21
  803036:	e8 27 fc ff ff       	call   802c62 <syscall>
  80303b:	83 c4 18             	add    $0x18,%esp
}
  80303e:	c9                   	leave  
  80303f:	c3                   	ret    

00803040 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  803040:	55                   	push   %ebp
  803041:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  803043:	8b 45 08             	mov    0x8(%ebp),%eax
  803046:	6a 00                	push   $0x0
  803048:	6a 00                	push   $0x0
  80304a:	6a 00                	push   $0x0
  80304c:	6a 00                	push   $0x0
  80304e:	50                   	push   %eax
  80304f:	6a 22                	push   $0x22
  803051:	e8 0c fc ff ff       	call   802c62 <syscall>
  803056:	83 c4 18             	add    $0x18,%esp
}
  803059:	90                   	nop
  80305a:	c9                   	leave  
  80305b:	c3                   	ret    

0080305c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80305c:	55                   	push   %ebp
  80305d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80305f:	8b 45 08             	mov    0x8(%ebp),%eax
  803062:	6a 00                	push   $0x0
  803064:	6a 00                	push   $0x0
  803066:	6a 00                	push   $0x0
  803068:	6a 00                	push   $0x0
  80306a:	50                   	push   %eax
  80306b:	6a 23                	push   $0x23
  80306d:	e8 f0 fb ff ff       	call   802c62 <syscall>
  803072:	83 c4 18             	add    $0x18,%esp
}
  803075:	90                   	nop
  803076:	c9                   	leave  
  803077:	c3                   	ret    

00803078 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  803078:	55                   	push   %ebp
  803079:	89 e5                	mov    %esp,%ebp
  80307b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80307e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  803081:	8d 50 04             	lea    0x4(%eax),%edx
  803084:	8d 45 f8             	lea    -0x8(%ebp),%eax
  803087:	6a 00                	push   $0x0
  803089:	6a 00                	push   $0x0
  80308b:	6a 00                	push   $0x0
  80308d:	52                   	push   %edx
  80308e:	50                   	push   %eax
  80308f:	6a 24                	push   $0x24
  803091:	e8 cc fb ff ff       	call   802c62 <syscall>
  803096:	83 c4 18             	add    $0x18,%esp
	return result;
  803099:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80309c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80309f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8030a2:	89 01                	mov    %eax,(%ecx)
  8030a4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8030a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8030aa:	c9                   	leave  
  8030ab:	c2 04 00             	ret    $0x4

008030ae <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8030ae:	55                   	push   %ebp
  8030af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8030b1:	6a 00                	push   $0x0
  8030b3:	6a 00                	push   $0x0
  8030b5:	ff 75 10             	pushl  0x10(%ebp)
  8030b8:	ff 75 0c             	pushl  0xc(%ebp)
  8030bb:	ff 75 08             	pushl  0x8(%ebp)
  8030be:	6a 13                	push   $0x13
  8030c0:	e8 9d fb ff ff       	call   802c62 <syscall>
  8030c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8030c8:	90                   	nop
}
  8030c9:	c9                   	leave  
  8030ca:	c3                   	ret    

008030cb <sys_rcr2>:
uint32 sys_rcr2()
{
  8030cb:	55                   	push   %ebp
  8030cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8030ce:	6a 00                	push   $0x0
  8030d0:	6a 00                	push   $0x0
  8030d2:	6a 00                	push   $0x0
  8030d4:	6a 00                	push   $0x0
  8030d6:	6a 00                	push   $0x0
  8030d8:	6a 25                	push   $0x25
  8030da:	e8 83 fb ff ff       	call   802c62 <syscall>
  8030df:	83 c4 18             	add    $0x18,%esp
}
  8030e2:	c9                   	leave  
  8030e3:	c3                   	ret    

008030e4 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8030e4:	55                   	push   %ebp
  8030e5:	89 e5                	mov    %esp,%ebp
  8030e7:	83 ec 04             	sub    $0x4,%esp
  8030ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8030ed:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8030f0:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8030f4:	6a 00                	push   $0x0
  8030f6:	6a 00                	push   $0x0
  8030f8:	6a 00                	push   $0x0
  8030fa:	6a 00                	push   $0x0
  8030fc:	50                   	push   %eax
  8030fd:	6a 26                	push   $0x26
  8030ff:	e8 5e fb ff ff       	call   802c62 <syscall>
  803104:	83 c4 18             	add    $0x18,%esp
	return ;
  803107:	90                   	nop
}
  803108:	c9                   	leave  
  803109:	c3                   	ret    

0080310a <rsttst>:
void rsttst()
{
  80310a:	55                   	push   %ebp
  80310b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80310d:	6a 00                	push   $0x0
  80310f:	6a 00                	push   $0x0
  803111:	6a 00                	push   $0x0
  803113:	6a 00                	push   $0x0
  803115:	6a 00                	push   $0x0
  803117:	6a 28                	push   $0x28
  803119:	e8 44 fb ff ff       	call   802c62 <syscall>
  80311e:	83 c4 18             	add    $0x18,%esp
	return ;
  803121:	90                   	nop
}
  803122:	c9                   	leave  
  803123:	c3                   	ret    

00803124 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  803124:	55                   	push   %ebp
  803125:	89 e5                	mov    %esp,%ebp
  803127:	83 ec 04             	sub    $0x4,%esp
  80312a:	8b 45 14             	mov    0x14(%ebp),%eax
  80312d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  803130:	8b 55 18             	mov    0x18(%ebp),%edx
  803133:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  803137:	52                   	push   %edx
  803138:	50                   	push   %eax
  803139:	ff 75 10             	pushl  0x10(%ebp)
  80313c:	ff 75 0c             	pushl  0xc(%ebp)
  80313f:	ff 75 08             	pushl  0x8(%ebp)
  803142:	6a 27                	push   $0x27
  803144:	e8 19 fb ff ff       	call   802c62 <syscall>
  803149:	83 c4 18             	add    $0x18,%esp
	return ;
  80314c:	90                   	nop
}
  80314d:	c9                   	leave  
  80314e:	c3                   	ret    

0080314f <chktst>:
void chktst(uint32 n)
{
  80314f:	55                   	push   %ebp
  803150:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  803152:	6a 00                	push   $0x0
  803154:	6a 00                	push   $0x0
  803156:	6a 00                	push   $0x0
  803158:	6a 00                	push   $0x0
  80315a:	ff 75 08             	pushl  0x8(%ebp)
  80315d:	6a 29                	push   $0x29
  80315f:	e8 fe fa ff ff       	call   802c62 <syscall>
  803164:	83 c4 18             	add    $0x18,%esp
	return ;
  803167:	90                   	nop
}
  803168:	c9                   	leave  
  803169:	c3                   	ret    

0080316a <inctst>:

void inctst()
{
  80316a:	55                   	push   %ebp
  80316b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80316d:	6a 00                	push   $0x0
  80316f:	6a 00                	push   $0x0
  803171:	6a 00                	push   $0x0
  803173:	6a 00                	push   $0x0
  803175:	6a 00                	push   $0x0
  803177:	6a 2a                	push   $0x2a
  803179:	e8 e4 fa ff ff       	call   802c62 <syscall>
  80317e:	83 c4 18             	add    $0x18,%esp
	return ;
  803181:	90                   	nop
}
  803182:	c9                   	leave  
  803183:	c3                   	ret    

00803184 <gettst>:
uint32 gettst()
{
  803184:	55                   	push   %ebp
  803185:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  803187:	6a 00                	push   $0x0
  803189:	6a 00                	push   $0x0
  80318b:	6a 00                	push   $0x0
  80318d:	6a 00                	push   $0x0
  80318f:	6a 00                	push   $0x0
  803191:	6a 2b                	push   $0x2b
  803193:	e8 ca fa ff ff       	call   802c62 <syscall>
  803198:	83 c4 18             	add    $0x18,%esp
}
  80319b:	c9                   	leave  
  80319c:	c3                   	ret    

0080319d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80319d:	55                   	push   %ebp
  80319e:	89 e5                	mov    %esp,%ebp
  8031a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8031a3:	6a 00                	push   $0x0
  8031a5:	6a 00                	push   $0x0
  8031a7:	6a 00                	push   $0x0
  8031a9:	6a 00                	push   $0x0
  8031ab:	6a 00                	push   $0x0
  8031ad:	6a 2c                	push   $0x2c
  8031af:	e8 ae fa ff ff       	call   802c62 <syscall>
  8031b4:	83 c4 18             	add    $0x18,%esp
  8031b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8031ba:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8031be:	75 07                	jne    8031c7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8031c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8031c5:	eb 05                	jmp    8031cc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8031c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8031cc:	c9                   	leave  
  8031cd:	c3                   	ret    

008031ce <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8031ce:	55                   	push   %ebp
  8031cf:	89 e5                	mov    %esp,%ebp
  8031d1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8031d4:	6a 00                	push   $0x0
  8031d6:	6a 00                	push   $0x0
  8031d8:	6a 00                	push   $0x0
  8031da:	6a 00                	push   $0x0
  8031dc:	6a 00                	push   $0x0
  8031de:	6a 2c                	push   $0x2c
  8031e0:	e8 7d fa ff ff       	call   802c62 <syscall>
  8031e5:	83 c4 18             	add    $0x18,%esp
  8031e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8031eb:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8031ef:	75 07                	jne    8031f8 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8031f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8031f6:	eb 05                	jmp    8031fd <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8031f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8031fd:	c9                   	leave  
  8031fe:	c3                   	ret    

008031ff <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8031ff:	55                   	push   %ebp
  803200:	89 e5                	mov    %esp,%ebp
  803202:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803205:	6a 00                	push   $0x0
  803207:	6a 00                	push   $0x0
  803209:	6a 00                	push   $0x0
  80320b:	6a 00                	push   $0x0
  80320d:	6a 00                	push   $0x0
  80320f:	6a 2c                	push   $0x2c
  803211:	e8 4c fa ff ff       	call   802c62 <syscall>
  803216:	83 c4 18             	add    $0x18,%esp
  803219:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80321c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  803220:	75 07                	jne    803229 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  803222:	b8 01 00 00 00       	mov    $0x1,%eax
  803227:	eb 05                	jmp    80322e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  803229:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80322e:	c9                   	leave  
  80322f:	c3                   	ret    

00803230 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  803230:	55                   	push   %ebp
  803231:	89 e5                	mov    %esp,%ebp
  803233:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803236:	6a 00                	push   $0x0
  803238:	6a 00                	push   $0x0
  80323a:	6a 00                	push   $0x0
  80323c:	6a 00                	push   $0x0
  80323e:	6a 00                	push   $0x0
  803240:	6a 2c                	push   $0x2c
  803242:	e8 1b fa ff ff       	call   802c62 <syscall>
  803247:	83 c4 18             	add    $0x18,%esp
  80324a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80324d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  803251:	75 07                	jne    80325a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  803253:	b8 01 00 00 00       	mov    $0x1,%eax
  803258:	eb 05                	jmp    80325f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80325a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80325f:	c9                   	leave  
  803260:	c3                   	ret    

00803261 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  803261:	55                   	push   %ebp
  803262:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  803264:	6a 00                	push   $0x0
  803266:	6a 00                	push   $0x0
  803268:	6a 00                	push   $0x0
  80326a:	6a 00                	push   $0x0
  80326c:	ff 75 08             	pushl  0x8(%ebp)
  80326f:	6a 2d                	push   $0x2d
  803271:	e8 ec f9 ff ff       	call   802c62 <syscall>
  803276:	83 c4 18             	add    $0x18,%esp
	return ;
  803279:	90                   	nop
}
  80327a:	c9                   	leave  
  80327b:	c3                   	ret    

0080327c <__udivdi3>:
  80327c:	55                   	push   %ebp
  80327d:	57                   	push   %edi
  80327e:	56                   	push   %esi
  80327f:	53                   	push   %ebx
  803280:	83 ec 1c             	sub    $0x1c,%esp
  803283:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  803287:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80328b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80328f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  803293:	89 ca                	mov    %ecx,%edx
  803295:	89 f8                	mov    %edi,%eax
  803297:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80329b:	85 f6                	test   %esi,%esi
  80329d:	75 2d                	jne    8032cc <__udivdi3+0x50>
  80329f:	39 cf                	cmp    %ecx,%edi
  8032a1:	77 65                	ja     803308 <__udivdi3+0x8c>
  8032a3:	89 fd                	mov    %edi,%ebp
  8032a5:	85 ff                	test   %edi,%edi
  8032a7:	75 0b                	jne    8032b4 <__udivdi3+0x38>
  8032a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8032ae:	31 d2                	xor    %edx,%edx
  8032b0:	f7 f7                	div    %edi
  8032b2:	89 c5                	mov    %eax,%ebp
  8032b4:	31 d2                	xor    %edx,%edx
  8032b6:	89 c8                	mov    %ecx,%eax
  8032b8:	f7 f5                	div    %ebp
  8032ba:	89 c1                	mov    %eax,%ecx
  8032bc:	89 d8                	mov    %ebx,%eax
  8032be:	f7 f5                	div    %ebp
  8032c0:	89 cf                	mov    %ecx,%edi
  8032c2:	89 fa                	mov    %edi,%edx
  8032c4:	83 c4 1c             	add    $0x1c,%esp
  8032c7:	5b                   	pop    %ebx
  8032c8:	5e                   	pop    %esi
  8032c9:	5f                   	pop    %edi
  8032ca:	5d                   	pop    %ebp
  8032cb:	c3                   	ret    
  8032cc:	39 ce                	cmp    %ecx,%esi
  8032ce:	77 28                	ja     8032f8 <__udivdi3+0x7c>
  8032d0:	0f bd fe             	bsr    %esi,%edi
  8032d3:	83 f7 1f             	xor    $0x1f,%edi
  8032d6:	75 40                	jne    803318 <__udivdi3+0x9c>
  8032d8:	39 ce                	cmp    %ecx,%esi
  8032da:	72 0a                	jb     8032e6 <__udivdi3+0x6a>
  8032dc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8032e0:	0f 87 9e 00 00 00    	ja     803384 <__udivdi3+0x108>
  8032e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8032eb:	89 fa                	mov    %edi,%edx
  8032ed:	83 c4 1c             	add    $0x1c,%esp
  8032f0:	5b                   	pop    %ebx
  8032f1:	5e                   	pop    %esi
  8032f2:	5f                   	pop    %edi
  8032f3:	5d                   	pop    %ebp
  8032f4:	c3                   	ret    
  8032f5:	8d 76 00             	lea    0x0(%esi),%esi
  8032f8:	31 ff                	xor    %edi,%edi
  8032fa:	31 c0                	xor    %eax,%eax
  8032fc:	89 fa                	mov    %edi,%edx
  8032fe:	83 c4 1c             	add    $0x1c,%esp
  803301:	5b                   	pop    %ebx
  803302:	5e                   	pop    %esi
  803303:	5f                   	pop    %edi
  803304:	5d                   	pop    %ebp
  803305:	c3                   	ret    
  803306:	66 90                	xchg   %ax,%ax
  803308:	89 d8                	mov    %ebx,%eax
  80330a:	f7 f7                	div    %edi
  80330c:	31 ff                	xor    %edi,%edi
  80330e:	89 fa                	mov    %edi,%edx
  803310:	83 c4 1c             	add    $0x1c,%esp
  803313:	5b                   	pop    %ebx
  803314:	5e                   	pop    %esi
  803315:	5f                   	pop    %edi
  803316:	5d                   	pop    %ebp
  803317:	c3                   	ret    
  803318:	bd 20 00 00 00       	mov    $0x20,%ebp
  80331d:	89 eb                	mov    %ebp,%ebx
  80331f:	29 fb                	sub    %edi,%ebx
  803321:	89 f9                	mov    %edi,%ecx
  803323:	d3 e6                	shl    %cl,%esi
  803325:	89 c5                	mov    %eax,%ebp
  803327:	88 d9                	mov    %bl,%cl
  803329:	d3 ed                	shr    %cl,%ebp
  80332b:	89 e9                	mov    %ebp,%ecx
  80332d:	09 f1                	or     %esi,%ecx
  80332f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  803333:	89 f9                	mov    %edi,%ecx
  803335:	d3 e0                	shl    %cl,%eax
  803337:	89 c5                	mov    %eax,%ebp
  803339:	89 d6                	mov    %edx,%esi
  80333b:	88 d9                	mov    %bl,%cl
  80333d:	d3 ee                	shr    %cl,%esi
  80333f:	89 f9                	mov    %edi,%ecx
  803341:	d3 e2                	shl    %cl,%edx
  803343:	8b 44 24 08          	mov    0x8(%esp),%eax
  803347:	88 d9                	mov    %bl,%cl
  803349:	d3 e8                	shr    %cl,%eax
  80334b:	09 c2                	or     %eax,%edx
  80334d:	89 d0                	mov    %edx,%eax
  80334f:	89 f2                	mov    %esi,%edx
  803351:	f7 74 24 0c          	divl   0xc(%esp)
  803355:	89 d6                	mov    %edx,%esi
  803357:	89 c3                	mov    %eax,%ebx
  803359:	f7 e5                	mul    %ebp
  80335b:	39 d6                	cmp    %edx,%esi
  80335d:	72 19                	jb     803378 <__udivdi3+0xfc>
  80335f:	74 0b                	je     80336c <__udivdi3+0xf0>
  803361:	89 d8                	mov    %ebx,%eax
  803363:	31 ff                	xor    %edi,%edi
  803365:	e9 58 ff ff ff       	jmp    8032c2 <__udivdi3+0x46>
  80336a:	66 90                	xchg   %ax,%ax
  80336c:	8b 54 24 08          	mov    0x8(%esp),%edx
  803370:	89 f9                	mov    %edi,%ecx
  803372:	d3 e2                	shl    %cl,%edx
  803374:	39 c2                	cmp    %eax,%edx
  803376:	73 e9                	jae    803361 <__udivdi3+0xe5>
  803378:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80337b:	31 ff                	xor    %edi,%edi
  80337d:	e9 40 ff ff ff       	jmp    8032c2 <__udivdi3+0x46>
  803382:	66 90                	xchg   %ax,%ax
  803384:	31 c0                	xor    %eax,%eax
  803386:	e9 37 ff ff ff       	jmp    8032c2 <__udivdi3+0x46>
  80338b:	90                   	nop

0080338c <__umoddi3>:
  80338c:	55                   	push   %ebp
  80338d:	57                   	push   %edi
  80338e:	56                   	push   %esi
  80338f:	53                   	push   %ebx
  803390:	83 ec 1c             	sub    $0x1c,%esp
  803393:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  803397:	8b 74 24 34          	mov    0x34(%esp),%esi
  80339b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80339f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8033a3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8033a7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8033ab:	89 f3                	mov    %esi,%ebx
  8033ad:	89 fa                	mov    %edi,%edx
  8033af:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8033b3:	89 34 24             	mov    %esi,(%esp)
  8033b6:	85 c0                	test   %eax,%eax
  8033b8:	75 1a                	jne    8033d4 <__umoddi3+0x48>
  8033ba:	39 f7                	cmp    %esi,%edi
  8033bc:	0f 86 a2 00 00 00    	jbe    803464 <__umoddi3+0xd8>
  8033c2:	89 c8                	mov    %ecx,%eax
  8033c4:	89 f2                	mov    %esi,%edx
  8033c6:	f7 f7                	div    %edi
  8033c8:	89 d0                	mov    %edx,%eax
  8033ca:	31 d2                	xor    %edx,%edx
  8033cc:	83 c4 1c             	add    $0x1c,%esp
  8033cf:	5b                   	pop    %ebx
  8033d0:	5e                   	pop    %esi
  8033d1:	5f                   	pop    %edi
  8033d2:	5d                   	pop    %ebp
  8033d3:	c3                   	ret    
  8033d4:	39 f0                	cmp    %esi,%eax
  8033d6:	0f 87 ac 00 00 00    	ja     803488 <__umoddi3+0xfc>
  8033dc:	0f bd e8             	bsr    %eax,%ebp
  8033df:	83 f5 1f             	xor    $0x1f,%ebp
  8033e2:	0f 84 ac 00 00 00    	je     803494 <__umoddi3+0x108>
  8033e8:	bf 20 00 00 00       	mov    $0x20,%edi
  8033ed:	29 ef                	sub    %ebp,%edi
  8033ef:	89 fe                	mov    %edi,%esi
  8033f1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8033f5:	89 e9                	mov    %ebp,%ecx
  8033f7:	d3 e0                	shl    %cl,%eax
  8033f9:	89 d7                	mov    %edx,%edi
  8033fb:	89 f1                	mov    %esi,%ecx
  8033fd:	d3 ef                	shr    %cl,%edi
  8033ff:	09 c7                	or     %eax,%edi
  803401:	89 e9                	mov    %ebp,%ecx
  803403:	d3 e2                	shl    %cl,%edx
  803405:	89 14 24             	mov    %edx,(%esp)
  803408:	89 d8                	mov    %ebx,%eax
  80340a:	d3 e0                	shl    %cl,%eax
  80340c:	89 c2                	mov    %eax,%edx
  80340e:	8b 44 24 08          	mov    0x8(%esp),%eax
  803412:	d3 e0                	shl    %cl,%eax
  803414:	89 44 24 04          	mov    %eax,0x4(%esp)
  803418:	8b 44 24 08          	mov    0x8(%esp),%eax
  80341c:	89 f1                	mov    %esi,%ecx
  80341e:	d3 e8                	shr    %cl,%eax
  803420:	09 d0                	or     %edx,%eax
  803422:	d3 eb                	shr    %cl,%ebx
  803424:	89 da                	mov    %ebx,%edx
  803426:	f7 f7                	div    %edi
  803428:	89 d3                	mov    %edx,%ebx
  80342a:	f7 24 24             	mull   (%esp)
  80342d:	89 c6                	mov    %eax,%esi
  80342f:	89 d1                	mov    %edx,%ecx
  803431:	39 d3                	cmp    %edx,%ebx
  803433:	0f 82 87 00 00 00    	jb     8034c0 <__umoddi3+0x134>
  803439:	0f 84 91 00 00 00    	je     8034d0 <__umoddi3+0x144>
  80343f:	8b 54 24 04          	mov    0x4(%esp),%edx
  803443:	29 f2                	sub    %esi,%edx
  803445:	19 cb                	sbb    %ecx,%ebx
  803447:	89 d8                	mov    %ebx,%eax
  803449:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80344d:	d3 e0                	shl    %cl,%eax
  80344f:	89 e9                	mov    %ebp,%ecx
  803451:	d3 ea                	shr    %cl,%edx
  803453:	09 d0                	or     %edx,%eax
  803455:	89 e9                	mov    %ebp,%ecx
  803457:	d3 eb                	shr    %cl,%ebx
  803459:	89 da                	mov    %ebx,%edx
  80345b:	83 c4 1c             	add    $0x1c,%esp
  80345e:	5b                   	pop    %ebx
  80345f:	5e                   	pop    %esi
  803460:	5f                   	pop    %edi
  803461:	5d                   	pop    %ebp
  803462:	c3                   	ret    
  803463:	90                   	nop
  803464:	89 fd                	mov    %edi,%ebp
  803466:	85 ff                	test   %edi,%edi
  803468:	75 0b                	jne    803475 <__umoddi3+0xe9>
  80346a:	b8 01 00 00 00       	mov    $0x1,%eax
  80346f:	31 d2                	xor    %edx,%edx
  803471:	f7 f7                	div    %edi
  803473:	89 c5                	mov    %eax,%ebp
  803475:	89 f0                	mov    %esi,%eax
  803477:	31 d2                	xor    %edx,%edx
  803479:	f7 f5                	div    %ebp
  80347b:	89 c8                	mov    %ecx,%eax
  80347d:	f7 f5                	div    %ebp
  80347f:	89 d0                	mov    %edx,%eax
  803481:	e9 44 ff ff ff       	jmp    8033ca <__umoddi3+0x3e>
  803486:	66 90                	xchg   %ax,%ax
  803488:	89 c8                	mov    %ecx,%eax
  80348a:	89 f2                	mov    %esi,%edx
  80348c:	83 c4 1c             	add    $0x1c,%esp
  80348f:	5b                   	pop    %ebx
  803490:	5e                   	pop    %esi
  803491:	5f                   	pop    %edi
  803492:	5d                   	pop    %ebp
  803493:	c3                   	ret    
  803494:	3b 04 24             	cmp    (%esp),%eax
  803497:	72 06                	jb     80349f <__umoddi3+0x113>
  803499:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80349d:	77 0f                	ja     8034ae <__umoddi3+0x122>
  80349f:	89 f2                	mov    %esi,%edx
  8034a1:	29 f9                	sub    %edi,%ecx
  8034a3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8034a7:	89 14 24             	mov    %edx,(%esp)
  8034aa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8034ae:	8b 44 24 04          	mov    0x4(%esp),%eax
  8034b2:	8b 14 24             	mov    (%esp),%edx
  8034b5:	83 c4 1c             	add    $0x1c,%esp
  8034b8:	5b                   	pop    %ebx
  8034b9:	5e                   	pop    %esi
  8034ba:	5f                   	pop    %edi
  8034bb:	5d                   	pop    %ebp
  8034bc:	c3                   	ret    
  8034bd:	8d 76 00             	lea    0x0(%esi),%esi
  8034c0:	2b 04 24             	sub    (%esp),%eax
  8034c3:	19 fa                	sbb    %edi,%edx
  8034c5:	89 d1                	mov    %edx,%ecx
  8034c7:	89 c6                	mov    %eax,%esi
  8034c9:	e9 71 ff ff ff       	jmp    80343f <__umoddi3+0xb3>
  8034ce:	66 90                	xchg   %ax,%ax
  8034d0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8034d4:	72 ea                	jb     8034c0 <__umoddi3+0x134>
  8034d6:	89 d9                	mov    %ebx,%ecx
  8034d8:	e9 62 ff ff ff       	jmp    80343f <__umoddi3+0xb3>
