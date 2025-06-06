
obj/user/tst_free_3:     file format elf32-i386


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
  800031:	e8 08 14 00 00       	call   80143e <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

#define numOfAccessesFor3MB 7
#define numOfAccessesFor8MB 4
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 7c 01 00 00    	sub    $0x17c,%esp



	int Mega = 1024*1024;
  800044:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)
	int kilo = 1024;
  80004b:	c7 45 d0 00 04 00 00 	movl   $0x400,-0x30(%ebp)
	char minByte = 1<<7;
  800052:	c6 45 cf 80          	movb   $0x80,-0x31(%ebp)
	char maxByte = 0x7F;
  800056:	c6 45 ce 7f          	movb   $0x7f,-0x32(%ebp)
	short minShort = 1<<15 ;
  80005a:	66 c7 45 cc 00 80    	movw   $0x8000,-0x34(%ebp)
	short maxShort = 0x7FFF;
  800060:	66 c7 45 ca ff 7f    	movw   $0x7fff,-0x36(%ebp)
	int minInt = 1<<31 ;
  800066:	c7 45 c4 00 00 00 80 	movl   $0x80000000,-0x3c(%ebp)
	int maxInt = 0x7FFFFFFF;
  80006d:	c7 45 c0 ff ff ff 7f 	movl   $0x7fffffff,-0x40(%ebp)
	int *intArr;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	a1 20 40 80 00       	mov    0x804020,%eax
  800079:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800084:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 a0 30 80 00       	push   $0x8030a0
  80009b:	6a 1e                	push   $0x1e
  80009d:	68 e1 30 80 00       	push   $0x8030e1
  8000a2:	e8 99 14 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 0c             	add    $0xc,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8000ba:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 a0 30 80 00       	push   $0x8030a0
  8000d1:	6a 1f                	push   $0x1f
  8000d3:	68 e1 30 80 00       	push   $0x8030e1
  8000d8:	e8 63 14 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 40 80 00       	mov    0x804020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 18             	add    $0x18,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8000f0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 a0 30 80 00       	push   $0x8030a0
  800107:	6a 20                	push   $0x20
  800109:	68 e1 30 80 00       	push   $0x8030e1
  80010e:	e8 2d 14 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 40 80 00       	mov    0x804020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 24             	add    $0x24,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800126:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 a0 30 80 00       	push   $0x8030a0
  80013d:	6a 21                	push   $0x21
  80013f:	68 e1 30 80 00       	push   $0x8030e1
  800144:	e8 f7 13 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 40 80 00       	mov    0x804020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 30             	add    $0x30,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80015c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 a0 30 80 00       	push   $0x8030a0
  800173:	6a 22                	push   $0x22
  800175:	68 e1 30 80 00       	push   $0x8030e1
  80017a:	e8 c1 13 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 40 80 00       	mov    0x804020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 3c             	add    $0x3c,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800192:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 a0 30 80 00       	push   $0x8030a0
  8001a9:	6a 23                	push   $0x23
  8001ab:	68 e1 30 80 00       	push   $0x8030e1
  8001b0:	e8 8b 13 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 40 80 00       	mov    0x804020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 48             	add    $0x48,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8001c8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 a0 30 80 00       	push   $0x8030a0
  8001df:	6a 24                	push   $0x24
  8001e1:	68 e1 30 80 00       	push   $0x8030e1
  8001e6:	e8 55 13 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 54             	add    $0x54,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8001fe:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 a0 30 80 00       	push   $0x8030a0
  800215:	6a 25                	push   $0x25
  800217:	68 e1 30 80 00       	push   $0x8030e1
  80021c:	e8 1f 13 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 20 40 80 00       	mov    0x804020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 60             	add    $0x60,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800234:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 a0 30 80 00       	push   $0x8030a0
  80024b:	6a 26                	push   $0x26
  80024d:	68 e1 30 80 00       	push   $0x8030e1
  800252:	e8 e9 12 00 00       	call   801540 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800257:	a1 20 40 80 00       	mov    0x804020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 6c             	add    $0x6c,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 98             	mov    %eax,-0x68(%ebp)
  80026a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 a0 30 80 00       	push   $0x8030a0
  800281:	6a 27                	push   $0x27
  800283:	68 e1 30 80 00       	push   $0x8030e1
  800288:	e8 b3 12 00 00       	call   801540 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028d:	a1 20 40 80 00       	mov    0x804020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 f4 30 80 00       	push   $0x8030f4
  8002a4:	6a 28                	push   $0x28
  8002a6:	68 e1 30 80 00       	push   $0x8030e1
  8002ab:	e8 90 12 00 00       	call   801540 <_panic>
	}

	int start_freeFrames = sys_calculate_free_frames() ;
  8002b0:	e8 c5 26 00 00       	call   80297a <sys_calculate_free_frames>
  8002b5:	89 45 94             	mov    %eax,-0x6c(%ebp)

	int indicesOf3MB[numOfAccessesFor3MB];
	int indicesOf8MB[numOfAccessesFor8MB];
	int var, i, j;

	void* ptr_allocations[20] = {0};
  8002b8:	8d 95 80 fe ff ff    	lea    -0x180(%ebp),%edx
  8002be:	b9 14 00 00 00       	mov    $0x14,%ecx
  8002c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8002c8:	89 d7                	mov    %edx,%edi
  8002ca:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		/*ALLOCATE 2 MB*/
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002cc:	e8 2c 27 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  8002d1:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8002d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002d7:	01 c0                	add    %eax,%eax
  8002d9:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8002dc:	83 ec 0c             	sub    $0xc,%esp
  8002df:	50                   	push   %eax
  8002e0:	e8 d3 22 00 00       	call   8025b8 <malloc>
  8002e5:	83 c4 10             	add    $0x10,%esp
  8002e8:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8002ee:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8002f4:	85 c0                	test   %eax,%eax
  8002f6:	79 0d                	jns    800305 <_main+0x2cd>
  8002f8:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8002fe:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800303:	76 14                	jbe    800319 <_main+0x2e1>
  800305:	83 ec 04             	sub    $0x4,%esp
  800308:	68 3c 31 80 00       	push   $0x80313c
  80030d:	6a 37                	push   $0x37
  80030f:	68 e1 30 80 00       	push   $0x8030e1
  800314:	e8 27 12 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800319:	e8 df 26 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  80031e:	2b 45 90             	sub    -0x70(%ebp),%eax
  800321:	3d 00 02 00 00       	cmp    $0x200,%eax
  800326:	74 14                	je     80033c <_main+0x304>
  800328:	83 ec 04             	sub    $0x4,%esp
  80032b:	68 a4 31 80 00       	push   $0x8031a4
  800330:	6a 38                	push   $0x38
  800332:	68 e1 30 80 00       	push   $0x8030e1
  800337:	e8 04 12 00 00       	call   801540 <_panic>

		/*ALLOCATE 3 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80033c:	e8 bc 26 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800341:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  800344:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800347:	89 c2                	mov    %eax,%edx
  800349:	01 d2                	add    %edx,%edx
  80034b:	01 d0                	add    %edx,%eax
  80034d:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800350:	83 ec 0c             	sub    $0xc,%esp
  800353:	50                   	push   %eax
  800354:	e8 5f 22 00 00       	call   8025b8 <malloc>
  800359:	83 c4 10             	add    $0x10,%esp
  80035c:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800362:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800368:	89 c2                	mov    %eax,%edx
  80036a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80036d:	01 c0                	add    %eax,%eax
  80036f:	05 00 00 00 80       	add    $0x80000000,%eax
  800374:	39 c2                	cmp    %eax,%edx
  800376:	72 16                	jb     80038e <_main+0x356>
  800378:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80037e:	89 c2                	mov    %eax,%edx
  800380:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800383:	01 c0                	add    %eax,%eax
  800385:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80038a:	39 c2                	cmp    %eax,%edx
  80038c:	76 14                	jbe    8003a2 <_main+0x36a>
  80038e:	83 ec 04             	sub    $0x4,%esp
  800391:	68 3c 31 80 00       	push   $0x80313c
  800396:	6a 3e                	push   $0x3e
  800398:	68 e1 30 80 00       	push   $0x8030e1
  80039d:	e8 9e 11 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8003a2:	e8 56 26 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  8003a7:	2b 45 90             	sub    -0x70(%ebp),%eax
  8003aa:	89 c2                	mov    %eax,%edx
  8003ac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003af:	89 c1                	mov    %eax,%ecx
  8003b1:	01 c9                	add    %ecx,%ecx
  8003b3:	01 c8                	add    %ecx,%eax
  8003b5:	85 c0                	test   %eax,%eax
  8003b7:	79 05                	jns    8003be <_main+0x386>
  8003b9:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003be:	c1 f8 0c             	sar    $0xc,%eax
  8003c1:	39 c2                	cmp    %eax,%edx
  8003c3:	74 14                	je     8003d9 <_main+0x3a1>
  8003c5:	83 ec 04             	sub    $0x4,%esp
  8003c8:	68 a4 31 80 00       	push   $0x8031a4
  8003cd:	6a 3f                	push   $0x3f
  8003cf:	68 e1 30 80 00       	push   $0x8030e1
  8003d4:	e8 67 11 00 00       	call   801540 <_panic>

		/*ALLOCATE 8 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003d9:	e8 1f 26 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  8003de:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(8*Mega-kilo);
  8003e1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003e4:	c1 e0 03             	shl    $0x3,%eax
  8003e7:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8003ea:	83 ec 0c             	sub    $0xc,%esp
  8003ed:	50                   	push   %eax
  8003ee:	e8 c5 21 00 00       	call   8025b8 <malloc>
  8003f3:	83 c4 10             	add    $0x10,%esp
  8003f6:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 5*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 5*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8003fc:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800402:	89 c1                	mov    %eax,%ecx
  800404:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800407:	89 d0                	mov    %edx,%eax
  800409:	c1 e0 02             	shl    $0x2,%eax
  80040c:	01 d0                	add    %edx,%eax
  80040e:	05 00 00 00 80       	add    $0x80000000,%eax
  800413:	39 c1                	cmp    %eax,%ecx
  800415:	72 1b                	jb     800432 <_main+0x3fa>
  800417:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  80041d:	89 c1                	mov    %eax,%ecx
  80041f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800422:	89 d0                	mov    %edx,%eax
  800424:	c1 e0 02             	shl    $0x2,%eax
  800427:	01 d0                	add    %edx,%eax
  800429:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80042e:	39 c1                	cmp    %eax,%ecx
  800430:	76 14                	jbe    800446 <_main+0x40e>
  800432:	83 ec 04             	sub    $0x4,%esp
  800435:	68 3c 31 80 00       	push   $0x80313c
  80043a:	6a 45                	push   $0x45
  80043c:	68 e1 30 80 00       	push   $0x8030e1
  800441:	e8 fa 10 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 8*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  800446:	e8 b2 25 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  80044b:	2b 45 90             	sub    -0x70(%ebp),%eax
  80044e:	89 c2                	mov    %eax,%edx
  800450:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800453:	c1 e0 03             	shl    $0x3,%eax
  800456:	85 c0                	test   %eax,%eax
  800458:	79 05                	jns    80045f <_main+0x427>
  80045a:	05 ff 0f 00 00       	add    $0xfff,%eax
  80045f:	c1 f8 0c             	sar    $0xc,%eax
  800462:	39 c2                	cmp    %eax,%edx
  800464:	74 14                	je     80047a <_main+0x442>
  800466:	83 ec 04             	sub    $0x4,%esp
  800469:	68 a4 31 80 00       	push   $0x8031a4
  80046e:	6a 46                	push   $0x46
  800470:	68 e1 30 80 00       	push   $0x8030e1
  800475:	e8 c6 10 00 00       	call   801540 <_panic>

		/*ALLOCATE 7 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80047a:	e8 7e 25 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  80047f:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(7*Mega-kilo);
  800482:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800485:	89 d0                	mov    %edx,%eax
  800487:	01 c0                	add    %eax,%eax
  800489:	01 d0                	add    %edx,%eax
  80048b:	01 c0                	add    %eax,%eax
  80048d:	01 d0                	add    %edx,%eax
  80048f:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800492:	83 ec 0c             	sub    $0xc,%esp
  800495:	50                   	push   %eax
  800496:	e8 1d 21 00 00       	call   8025b8 <malloc>
  80049b:	83 c4 10             	add    $0x10,%esp
  80049e:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 13*Mega) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 13*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8004a4:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004aa:	89 c1                	mov    %eax,%ecx
  8004ac:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004af:	89 d0                	mov    %edx,%eax
  8004b1:	01 c0                	add    %eax,%eax
  8004b3:	01 d0                	add    %edx,%eax
  8004b5:	c1 e0 02             	shl    $0x2,%eax
  8004b8:	01 d0                	add    %edx,%eax
  8004ba:	05 00 00 00 80       	add    $0x80000000,%eax
  8004bf:	39 c1                	cmp    %eax,%ecx
  8004c1:	72 1f                	jb     8004e2 <_main+0x4aa>
  8004c3:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004c9:	89 c1                	mov    %eax,%ecx
  8004cb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004ce:	89 d0                	mov    %edx,%eax
  8004d0:	01 c0                	add    %eax,%eax
  8004d2:	01 d0                	add    %edx,%eax
  8004d4:	c1 e0 02             	shl    $0x2,%eax
  8004d7:	01 d0                	add    %edx,%eax
  8004d9:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8004de:	39 c1                	cmp    %eax,%ecx
  8004e0:	76 14                	jbe    8004f6 <_main+0x4be>
  8004e2:	83 ec 04             	sub    $0x4,%esp
  8004e5:	68 3c 31 80 00       	push   $0x80313c
  8004ea:	6a 4c                	push   $0x4c
  8004ec:	68 e1 30 80 00       	push   $0x8030e1
  8004f1:	e8 4a 10 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 7*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8004f6:	e8 02 25 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  8004fb:	2b 45 90             	sub    -0x70(%ebp),%eax
  8004fe:	89 c1                	mov    %eax,%ecx
  800500:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800503:	89 d0                	mov    %edx,%eax
  800505:	01 c0                	add    %eax,%eax
  800507:	01 d0                	add    %edx,%eax
  800509:	01 c0                	add    %eax,%eax
  80050b:	01 d0                	add    %edx,%eax
  80050d:	85 c0                	test   %eax,%eax
  80050f:	79 05                	jns    800516 <_main+0x4de>
  800511:	05 ff 0f 00 00       	add    $0xfff,%eax
  800516:	c1 f8 0c             	sar    $0xc,%eax
  800519:	39 c1                	cmp    %eax,%ecx
  80051b:	74 14                	je     800531 <_main+0x4f9>
  80051d:	83 ec 04             	sub    $0x4,%esp
  800520:	68 a4 31 80 00       	push   $0x8031a4
  800525:	6a 4d                	push   $0x4d
  800527:	68 e1 30 80 00       	push   $0x8030e1
  80052c:	e8 0f 10 00 00       	call   801540 <_panic>

		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
  800531:	e8 44 24 00 00       	call   80297a <sys_calculate_free_frames>
  800536:	89 45 8c             	mov    %eax,-0x74(%ebp)
		int modFrames = sys_calculate_modified_frames();
  800539:	e8 55 24 00 00       	call   802993 <sys_calculate_modified_frames>
  80053e:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
  800541:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800544:	89 c2                	mov    %eax,%edx
  800546:	01 d2                	add    %edx,%edx
  800548:	01 d0                	add    %edx,%eax
  80054a:	2b 45 d0             	sub    -0x30(%ebp),%eax
  80054d:	48                   	dec    %eax
  80054e:	89 45 84             	mov    %eax,-0x7c(%ebp)
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
  800551:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800554:	bf 07 00 00 00       	mov    $0x7,%edi
  800559:	99                   	cltd   
  80055a:	f7 ff                	idiv   %edi
  80055c:	89 45 80             	mov    %eax,-0x80(%ebp)
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  80055f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800566:	eb 16                	jmp    80057e <_main+0x546>
		{
			indicesOf3MB[var] = var * inc ;
  800568:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80056b:	0f af 45 80          	imul   -0x80(%ebp),%eax
  80056f:	89 c2                	mov    %eax,%edx
  800571:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800574:	89 94 85 e0 fe ff ff 	mov    %edx,-0x120(%ebp,%eax,4)
		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
		int modFrames = sys_calculate_modified_frames();
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  80057b:	ff 45 e4             	incl   -0x1c(%ebp)
  80057e:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800582:	7e e4                	jle    800568 <_main+0x530>
		{
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
  800584:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80058a:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		//3 reads
		int sum = 0;
  800590:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  800597:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80059e:	eb 1f                	jmp    8005bf <_main+0x587>
		{
			sum += byteArr[indicesOf3MB[var]] ;
  8005a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005a3:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005aa:	89 c2                	mov    %eax,%edx
  8005ac:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005b2:	01 d0                	add    %edx,%eax
  8005b4:	8a 00                	mov    (%eax),%al
  8005b6:	0f be c0             	movsbl %al,%eax
  8005b9:	01 45 dc             	add    %eax,-0x24(%ebp)
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
		//3 reads
		int sum = 0;
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  8005bc:	ff 45 e4             	incl   -0x1c(%ebp)
  8005bf:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8005c3:	7e db                	jle    8005a0 <_main+0x568>
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005c5:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
  8005cc:	eb 1c                	jmp    8005ea <_main+0x5b2>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
  8005ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d1:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005d8:	89 c2                	mov    %eax,%edx
  8005da:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005e0:	01 c2                	add    %eax,%edx
  8005e2:	8a 45 ce             	mov    -0x32(%ebp),%al
  8005e5:	88 02                	mov    %al,(%edx)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005e7:	ff 45 e4             	incl   -0x1c(%ebp)
  8005ea:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8005ee:	7e de                	jle    8005ce <_main+0x596>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8005f0:	8b 55 8c             	mov    -0x74(%ebp),%edx
  8005f3:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005f6:	01 d0                	add    %edx,%eax
  8005f8:	89 c6                	mov    %eax,%esi
  8005fa:	e8 7b 23 00 00       	call   80297a <sys_calculate_free_frames>
  8005ff:	89 c3                	mov    %eax,%ebx
  800601:	e8 8d 23 00 00       	call   802993 <sys_calculate_modified_frames>
  800606:	01 d8                	add    %ebx,%eax
  800608:	29 c6                	sub    %eax,%esi
  80060a:	89 f0                	mov    %esi,%eax
  80060c:	83 f8 02             	cmp    $0x2,%eax
  80060f:	74 14                	je     800625 <_main+0x5ed>
  800611:	83 ec 04             	sub    $0x4,%esp
  800614:	68 d4 31 80 00       	push   $0x8031d4
  800619:	6a 65                	push   $0x65
  80061b:	68 e1 30 80 00       	push   $0x8030e1
  800620:	e8 1b 0f 00 00       	call   801540 <_panic>
		int found = 0;
  800625:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  80062c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800633:	eb 78                	jmp    8006ad <_main+0x675>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800635:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80063c:	eb 5d                	jmp    80069b <_main+0x663>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  80063e:	a1 20 40 80 00       	mov    0x804020,%eax
  800643:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800649:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064c:	89 d0                	mov    %edx,%eax
  80064e:	01 c0                	add    %eax,%eax
  800650:	01 d0                	add    %edx,%eax
  800652:	c1 e0 02             	shl    $0x2,%eax
  800655:	01 c8                	add    %ecx,%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  80065f:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800665:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80066a:	89 c2                	mov    %eax,%edx
  80066c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80066f:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  800676:	89 c1                	mov    %eax,%ecx
  800678:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80067e:	01 c8                	add    %ecx,%eax
  800680:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  800686:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80068c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800691:	39 c2                	cmp    %eax,%edx
  800693:	75 03                	jne    800698 <_main+0x660>
				{
					found++;
  800695:	ff 45 d8             	incl   -0x28(%ebp)
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800698:	ff 45 e0             	incl   -0x20(%ebp)
  80069b:	a1 20 40 80 00       	mov    0x804020,%eax
  8006a0:	8b 50 74             	mov    0x74(%eax),%edx
  8006a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a6:	39 c2                	cmp    %eax,%edx
  8006a8:	77 94                	ja     80063e <_main+0x606>
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  8006aa:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ad:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8006b1:	7e 82                	jle    800635 <_main+0x5fd>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor3MB) panic("malloc: page is not added to WS");
  8006b3:	83 7d d8 07          	cmpl   $0x7,-0x28(%ebp)
  8006b7:	74 14                	je     8006cd <_main+0x695>
  8006b9:	83 ec 04             	sub    $0x4,%esp
  8006bc:	68 18 32 80 00       	push   $0x803218
  8006c1:	6a 71                	push   $0x71
  8006c3:	68 e1 30 80 00       	push   $0x8030e1
  8006c8:	e8 73 0e 00 00       	call   801540 <_panic>

		/*access 8 MB*/// should bring 4 pages into WS (2 r, 2 w) and victimize 4 pages from 3 MB allocation
		freeFrames = sys_calculate_free_frames() ;
  8006cd:	e8 a8 22 00 00       	call   80297a <sys_calculate_free_frames>
  8006d2:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8006d5:	e8 b9 22 00 00       	call   802993 <sys_calculate_modified_frames>
  8006da:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfShort = (8*Mega-kilo)/sizeof(short) - 1;
  8006dd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e0:	c1 e0 03             	shl    $0x3,%eax
  8006e3:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8006e6:	d1 e8                	shr    %eax
  8006e8:	48                   	dec    %eax
  8006e9:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		indicesOf8MB[0] = lastIndexOfShort * 1 / 2;
  8006ef:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8006f5:	89 c2                	mov    %eax,%edx
  8006f7:	c1 ea 1f             	shr    $0x1f,%edx
  8006fa:	01 d0                	add    %edx,%eax
  8006fc:	d1 f8                	sar    %eax
  8006fe:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		indicesOf8MB[1] = lastIndexOfShort * 2 / 3;
  800704:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80070a:	01 c0                	add    %eax,%eax
  80070c:	89 c1                	mov    %eax,%ecx
  80070e:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800713:	f7 e9                	imul   %ecx
  800715:	c1 f9 1f             	sar    $0x1f,%ecx
  800718:	89 d0                	mov    %edx,%eax
  80071a:	29 c8                	sub    %ecx,%eax
  80071c:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		indicesOf8MB[2] = lastIndexOfShort * 3 / 4;
  800722:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800728:	89 c2                	mov    %eax,%edx
  80072a:	01 d2                	add    %edx,%edx
  80072c:	01 d0                	add    %edx,%eax
  80072e:	85 c0                	test   %eax,%eax
  800730:	79 03                	jns    800735 <_main+0x6fd>
  800732:	83 c0 03             	add    $0x3,%eax
  800735:	c1 f8 02             	sar    $0x2,%eax
  800738:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		indicesOf8MB[3] = lastIndexOfShort ;
  80073e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800744:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)

		//use one of the read pages from 3 MB to avoid victimizing it
		sum += byteArr[indicesOf3MB[0]] ;
  80074a:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800750:	89 c2                	mov    %eax,%edx
  800752:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800758:	01 d0                	add    %edx,%eax
  80075a:	8a 00                	mov    (%eax),%al
  80075c:	0f be c0             	movsbl %al,%eax
  80075f:	01 45 dc             	add    %eax,-0x24(%ebp)

		shortArr = (short *) ptr_allocations[2];
  800762:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800768:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		//2 reads
		sum = 0;
  80076e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  800775:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80077c:	eb 20                	jmp    80079e <_main+0x766>
		{
			sum += shortArr[indicesOf8MB[var]] ;
  80077e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800781:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  800788:	01 c0                	add    %eax,%eax
  80078a:	89 c2                	mov    %eax,%edx
  80078c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800792:	01 d0                	add    %edx,%eax
  800794:	66 8b 00             	mov    (%eax),%ax
  800797:	98                   	cwtl   
  800798:	01 45 dc             	add    %eax,-0x24(%ebp)
		sum += byteArr[indicesOf3MB[0]] ;

		shortArr = (short *) ptr_allocations[2];
		//2 reads
		sum = 0;
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  80079b:	ff 45 e4             	incl   -0x1c(%ebp)
  80079e:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8007a2:	7e da                	jle    80077e <_main+0x746>
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007a4:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
  8007ab:	eb 20                	jmp    8007cd <_main+0x795>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
  8007ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007b0:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  8007b7:	01 c0                	add    %eax,%eax
  8007b9:	89 c2                	mov    %eax,%edx
  8007bb:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007c1:	01 c2                	add    %eax,%edx
  8007c3:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  8007c7:	66 89 02             	mov    %ax,(%edx)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007ca:	ff 45 e4             	incl   -0x1c(%ebp)
  8007cd:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007d1:	7e da                	jle    8007ad <_main+0x775>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007d3:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8007d6:	e8 9f 21 00 00       	call   80297a <sys_calculate_free_frames>
  8007db:	29 c3                	sub    %eax,%ebx
  8007dd:	89 d8                	mov    %ebx,%eax
  8007df:	83 f8 04             	cmp    $0x4,%eax
  8007e2:	74 17                	je     8007fb <_main+0x7c3>
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	68 d4 31 80 00       	push   $0x8031d4
  8007ec:	68 8c 00 00 00       	push   $0x8c
  8007f1:	68 e1 30 80 00       	push   $0x8030e1
  8007f6:	e8 45 0d 00 00       	call   801540 <_panic>
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007fb:	8b 5d 88             	mov    -0x78(%ebp),%ebx
  8007fe:	e8 90 21 00 00       	call   802993 <sys_calculate_modified_frames>
  800803:	29 c3                	sub    %eax,%ebx
  800805:	89 d8                	mov    %ebx,%eax
  800807:	83 f8 fe             	cmp    $0xfffffffe,%eax
  80080a:	74 17                	je     800823 <_main+0x7eb>
  80080c:	83 ec 04             	sub    $0x4,%esp
  80080f:	68 d4 31 80 00       	push   $0x8031d4
  800814:	68 8d 00 00 00       	push   $0x8d
  800819:	68 e1 30 80 00       	push   $0x8030e1
  80081e:	e8 1d 0d 00 00       	call   801540 <_panic>
		found = 0;
  800823:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  80082a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800831:	eb 7a                	jmp    8008ad <_main+0x875>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800833:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80083a:	eb 5f                	jmp    80089b <_main+0x863>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[indicesOf8MB[var]])), PAGE_SIZE))
  80083c:	a1 20 40 80 00       	mov    0x804020,%eax
  800841:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800847:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80084a:	89 d0                	mov    %edx,%eax
  80084c:	01 c0                	add    %eax,%eax
  80084e:	01 d0                	add    %edx,%eax
  800850:	c1 e0 02             	shl    $0x2,%eax
  800853:	01 c8                	add    %ecx,%eax
  800855:	8b 00                	mov    (%eax),%eax
  800857:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  80085d:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800863:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800868:	89 c2                	mov    %eax,%edx
  80086a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80086d:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  800874:	01 c0                	add    %eax,%eax
  800876:	89 c1                	mov    %eax,%ecx
  800878:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80087e:	01 c8                	add    %ecx,%eax
  800880:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800886:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80088c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800891:	39 c2                	cmp    %eax,%edx
  800893:	75 03                	jne    800898 <_main+0x860>
				{
					found++;
  800895:	ff 45 d8             	incl   -0x28(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800898:	ff 45 e0             	incl   -0x20(%ebp)
  80089b:	a1 20 40 80 00       	mov    0x804020,%eax
  8008a0:	8b 50 74             	mov    0x74(%eax),%edx
  8008a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a6:	39 c2                	cmp    %eax,%edx
  8008a8:	77 92                	ja     80083c <_main+0x804>
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  8008aa:	ff 45 e4             	incl   -0x1c(%ebp)
  8008ad:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8008b1:	7e 80                	jle    800833 <_main+0x7fb>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor8MB) panic("malloc: page is not added to WS");
  8008b3:	83 7d d8 04          	cmpl   $0x4,-0x28(%ebp)
  8008b7:	74 17                	je     8008d0 <_main+0x898>
  8008b9:	83 ec 04             	sub    $0x4,%esp
  8008bc:	68 18 32 80 00       	push   $0x803218
  8008c1:	68 99 00 00 00       	push   $0x99
  8008c6:	68 e1 30 80 00       	push   $0x8030e1
  8008cb:	e8 70 0c 00 00       	call   801540 <_panic>

		/* Free 3 MB */// remove 3 pages from WS, 2 from free buffer, 2 from mod buffer and 2 tables
		freeFrames = sys_calculate_free_frames() ;
  8008d0:	e8 a5 20 00 00       	call   80297a <sys_calculate_free_frames>
  8008d5:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8008d8:	e8 b6 20 00 00       	call   802993 <sys_calculate_modified_frames>
  8008dd:	89 45 88             	mov    %eax,-0x78(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008e0:	e8 18 21 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  8008e5:	89 45 90             	mov    %eax,-0x70(%ebp)

		free(ptr_allocations[1]);
  8008e8:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  8008ee:	83 ec 0c             	sub    $0xc,%esp
  8008f1:	50                   	push   %eax
  8008f2:	e8 e2 1d 00 00       	call   8026d9 <free>
  8008f7:	83 c4 10             	add    $0x10,%esp

		//check page file
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  8008fa:	e8 fe 20 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  8008ff:	8b 55 90             	mov    -0x70(%ebp),%edx
  800902:	89 d1                	mov    %edx,%ecx
  800904:	29 c1                	sub    %eax,%ecx
  800906:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800909:	89 c2                	mov    %eax,%edx
  80090b:	01 d2                	add    %edx,%edx
  80090d:	01 d0                	add    %edx,%eax
  80090f:	85 c0                	test   %eax,%eax
  800911:	79 05                	jns    800918 <_main+0x8e0>
  800913:	05 ff 0f 00 00       	add    $0xfff,%eax
  800918:	c1 f8 0c             	sar    $0xc,%eax
  80091b:	39 c1                	cmp    %eax,%ecx
  80091d:	74 17                	je     800936 <_main+0x8fe>
  80091f:	83 ec 04             	sub    $0x4,%esp
  800922:	68 38 32 80 00       	push   $0x803238
  800927:	68 a3 00 00 00       	push   $0xa3
  80092c:	68 e1 30 80 00       	push   $0x8030e1
  800931:	e8 0a 0c 00 00       	call   801540 <_panic>
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
  800936:	e8 3f 20 00 00       	call   80297a <sys_calculate_free_frames>
  80093b:	89 c2                	mov    %eax,%edx
  80093d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800940:	29 c2                	sub    %eax,%edx
  800942:	89 d0                	mov    %edx,%eax
  800944:	83 f8 07             	cmp    $0x7,%eax
  800947:	74 17                	je     800960 <_main+0x928>
  800949:	83 ec 04             	sub    $0x4,%esp
  80094c:	68 74 32 80 00       	push   $0x803274
  800951:	68 a5 00 00 00       	push   $0xa5
  800956:	68 e1 30 80 00       	push   $0x8030e1
  80095b:	e8 e0 0b 00 00       	call   801540 <_panic>
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
  800960:	e8 2e 20 00 00       	call   802993 <sys_calculate_modified_frames>
  800965:	89 c2                	mov    %eax,%edx
  800967:	8b 45 88             	mov    -0x78(%ebp),%eax
  80096a:	29 c2                	sub    %eax,%edx
  80096c:	89 d0                	mov    %edx,%eax
  80096e:	83 f8 02             	cmp    $0x2,%eax
  800971:	74 17                	je     80098a <_main+0x952>
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	68 c8 32 80 00       	push   $0x8032c8
  80097b:	68 a6 00 00 00       	push   $0xa6
  800980:	68 e1 30 80 00       	push   $0x8030e1
  800985:	e8 b6 0b 00 00       	call   801540 <_panic>
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  80098a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800991:	e9 8c 00 00 00       	jmp    800a22 <_main+0x9ea>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800996:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80099d:	eb 71                	jmp    800a10 <_main+0x9d8>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  80099f:	a1 20 40 80 00       	mov    0x804020,%eax
  8009a4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ad:	89 d0                	mov    %edx,%eax
  8009af:	01 c0                	add    %eax,%eax
  8009b1:	01 d0                	add    %edx,%eax
  8009b3:	c1 e0 02             	shl    $0x2,%eax
  8009b6:	01 c8                	add    %ecx,%eax
  8009b8:	8b 00                	mov    (%eax),%eax
  8009ba:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  8009c0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8009c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009cb:	89 c2                	mov    %eax,%edx
  8009cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009d0:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8009d7:	89 c1                	mov    %eax,%ecx
  8009d9:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8009df:	01 c8                	add    %ecx,%eax
  8009e1:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  8009e7:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  8009ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009f2:	39 c2                	cmp    %eax,%edx
  8009f4:	75 17                	jne    800a0d <_main+0x9d5>
				{
					panic("free: page is not removed from WS");
  8009f6:	83 ec 04             	sub    $0x4,%esp
  8009f9:	68 00 33 80 00       	push   $0x803300
  8009fe:	68 ae 00 00 00       	push   $0xae
  800a03:	68 e1 30 80 00       	push   $0x8030e1
  800a08:	e8 33 0b 00 00       	call   801540 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800a0d:	ff 45 e0             	incl   -0x20(%ebp)
  800a10:	a1 20 40 80 00       	mov    0x804020,%eax
  800a15:	8b 50 74             	mov    0x74(%eax),%edx
  800a18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a1b:	39 c2                	cmp    %eax,%edx
  800a1d:	77 80                	ja     80099f <_main+0x967>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  800a1f:	ff 45 e4             	incl   -0x1c(%ebp)
  800a22:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800a26:	0f 8e 6a ff ff ff    	jle    800996 <_main+0x95e>
			}
		}



		freeFrames = sys_calculate_free_frames() ;
  800a2c:	e8 49 1f 00 00       	call   80297a <sys_calculate_free_frames>
  800a31:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr = (short *) ptr_allocations[2];
  800a34:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800a3a:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800a40:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a43:	01 c0                	add    %eax,%eax
  800a45:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800a48:	d1 e8                	shr    %eax
  800a4a:	48                   	dec    %eax
  800a4b:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		shortArr[0] = minShort;
  800a51:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
  800a57:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800a5a:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800a5d:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800a63:	01 c0                	add    %eax,%eax
  800a65:	89 c2                	mov    %eax,%edx
  800a67:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a6d:	01 c2                	add    %eax,%edx
  800a6f:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  800a73:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800a76:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800a79:	e8 fc 1e 00 00       	call   80297a <sys_calculate_free_frames>
  800a7e:	29 c3                	sub    %eax,%ebx
  800a80:	89 d8                	mov    %ebx,%eax
  800a82:	83 f8 02             	cmp    $0x2,%eax
  800a85:	74 17                	je     800a9e <_main+0xa66>
  800a87:	83 ec 04             	sub    $0x4,%esp
  800a8a:	68 d4 31 80 00       	push   $0x8031d4
  800a8f:	68 ba 00 00 00       	push   $0xba
  800a94:	68 e1 30 80 00       	push   $0x8030e1
  800a99:	e8 a2 0a 00 00       	call   801540 <_panic>
		found = 0;
  800a9e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800aa5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800aac:	e9 a7 00 00 00       	jmp    800b58 <_main+0xb20>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  800ab1:	a1 20 40 80 00       	mov    0x804020,%eax
  800ab6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800abc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800abf:	89 d0                	mov    %edx,%eax
  800ac1:	01 c0                	add    %eax,%eax
  800ac3:	01 d0                	add    %edx,%eax
  800ac5:	c1 e0 02             	shl    $0x2,%eax
  800ac8:	01 c8                	add    %ecx,%eax
  800aca:	8b 00                	mov    (%eax),%eax
  800acc:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800ad2:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ad8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800add:	89 c2                	mov    %eax,%edx
  800adf:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800ae5:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800aeb:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800af1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800af6:	39 c2                	cmp    %eax,%edx
  800af8:	75 03                	jne    800afd <_main+0xac5>
				found++;
  800afa:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  800afd:	a1 20 40 80 00       	mov    0x804020,%eax
  800b02:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b08:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800b0b:	89 d0                	mov    %edx,%eax
  800b0d:	01 c0                	add    %eax,%eax
  800b0f:	01 d0                	add    %edx,%eax
  800b11:	c1 e0 02             	shl    $0x2,%eax
  800b14:	01 c8                	add    %ecx,%eax
  800b16:	8b 00                	mov    (%eax),%eax
  800b18:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b1e:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b24:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b29:	89 c2                	mov    %eax,%edx
  800b2b:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800b31:	01 c0                	add    %eax,%eax
  800b33:	89 c1                	mov    %eax,%ecx
  800b35:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b3b:	01 c8                	add    %ecx,%eax
  800b3d:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b43:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b49:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b4e:	39 c2                	cmp    %eax,%edx
  800b50:	75 03                	jne    800b55 <_main+0xb1d>
				found++;
  800b52:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b55:	ff 45 e4             	incl   -0x1c(%ebp)
  800b58:	a1 20 40 80 00       	mov    0x804020,%eax
  800b5d:	8b 50 74             	mov    0x74(%eax),%edx
  800b60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b63:	39 c2                	cmp    %eax,%edx
  800b65:	0f 87 46 ff ff ff    	ja     800ab1 <_main+0xa79>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800b6b:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800b6f:	74 17                	je     800b88 <_main+0xb50>
  800b71:	83 ec 04             	sub    $0x4,%esp
  800b74:	68 18 32 80 00       	push   $0x803218
  800b79:	68 c3 00 00 00       	push   $0xc3
  800b7e:	68 e1 30 80 00       	push   $0x8030e1
  800b83:	e8 b8 09 00 00       	call   801540 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800b88:	e8 70 1e 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800b8d:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800b90:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b93:	01 c0                	add    %eax,%eax
  800b95:	83 ec 0c             	sub    $0xc,%esp
  800b98:	50                   	push   %eax
  800b99:	e8 1a 1a 00 00       	call   8025b8 <malloc>
  800b9e:	83 c4 10             	add    $0x10,%esp
  800ba1:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800ba7:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800bad:	89 c2                	mov    %eax,%edx
  800baf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800bb2:	c1 e0 02             	shl    $0x2,%eax
  800bb5:	05 00 00 00 80       	add    $0x80000000,%eax
  800bba:	39 c2                	cmp    %eax,%edx
  800bbc:	72 17                	jb     800bd5 <_main+0xb9d>
  800bbe:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800bc4:	89 c2                	mov    %eax,%edx
  800bc6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800bc9:	c1 e0 02             	shl    $0x2,%eax
  800bcc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800bd1:	39 c2                	cmp    %eax,%edx
  800bd3:	76 17                	jbe    800bec <_main+0xbb4>
  800bd5:	83 ec 04             	sub    $0x4,%esp
  800bd8:	68 3c 31 80 00       	push   $0x80313c
  800bdd:	68 c8 00 00 00       	push   $0xc8
  800be2:	68 e1 30 80 00       	push   $0x8030e1
  800be7:	e8 54 09 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800bec:	e8 0c 1e 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800bf1:	2b 45 90             	sub    -0x70(%ebp),%eax
  800bf4:	83 f8 01             	cmp    $0x1,%eax
  800bf7:	74 17                	je     800c10 <_main+0xbd8>
  800bf9:	83 ec 04             	sub    $0x4,%esp
  800bfc:	68 a4 31 80 00       	push   $0x8031a4
  800c01:	68 c9 00 00 00       	push   $0xc9
  800c06:	68 e1 30 80 00       	push   $0x8030e1
  800c0b:	e8 30 09 00 00       	call   801540 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800c10:	e8 65 1d 00 00       	call   80297a <sys_calculate_free_frames>
  800c15:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr = (int *) ptr_allocations[2];
  800c18:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800c1e:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  800c24:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800c27:	01 c0                	add    %eax,%eax
  800c29:	c1 e8 02             	shr    $0x2,%eax
  800c2c:	48                   	dec    %eax
  800c2d:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
		intArr[0] = minInt;
  800c33:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c39:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800c3c:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800c3e:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800c44:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c4b:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c51:	01 c2                	add    %eax,%edx
  800c53:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800c56:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800c58:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800c5b:	e8 1a 1d 00 00       	call   80297a <sys_calculate_free_frames>
  800c60:	29 c3                	sub    %eax,%ebx
  800c62:	89 d8                	mov    %ebx,%eax
  800c64:	83 f8 02             	cmp    $0x2,%eax
  800c67:	74 17                	je     800c80 <_main+0xc48>
  800c69:	83 ec 04             	sub    $0x4,%esp
  800c6c:	68 d4 31 80 00       	push   $0x8031d4
  800c71:	68 d0 00 00 00       	push   $0xd0
  800c76:	68 e1 30 80 00       	push   $0x8030e1
  800c7b:	e8 c0 08 00 00       	call   801540 <_panic>
		found = 0;
  800c80:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c87:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800c8e:	e9 aa 00 00 00       	jmp    800d3d <_main+0xd05>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800c93:	a1 20 40 80 00       	mov    0x804020,%eax
  800c98:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800c9e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ca1:	89 d0                	mov    %edx,%eax
  800ca3:	01 c0                	add    %eax,%eax
  800ca5:	01 d0                	add    %edx,%eax
  800ca7:	c1 e0 02             	shl    $0x2,%eax
  800caa:	01 c8                	add    %ecx,%eax
  800cac:	8b 00                	mov    (%eax),%eax
  800cae:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800cb4:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800cba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cbf:	89 c2                	mov    %eax,%edx
  800cc1:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800cc7:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800ccd:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800cd3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cd8:	39 c2                	cmp    %eax,%edx
  800cda:	75 03                	jne    800cdf <_main+0xca7>
				found++;
  800cdc:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800cdf:	a1 20 40 80 00       	mov    0x804020,%eax
  800ce4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ced:	89 d0                	mov    %edx,%eax
  800cef:	01 c0                	add    %eax,%eax
  800cf1:	01 d0                	add    %edx,%eax
  800cf3:	c1 e0 02             	shl    $0x2,%eax
  800cf6:	01 c8                	add    %ecx,%eax
  800cf8:	8b 00                	mov    (%eax),%eax
  800cfa:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800d00:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d0b:	89 c2                	mov    %eax,%edx
  800d0d:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800d13:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d1a:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800d20:	01 c8                	add    %ecx,%eax
  800d22:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d28:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d2e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d33:	39 c2                	cmp    %eax,%edx
  800d35:	75 03                	jne    800d3a <_main+0xd02>
				found++;
  800d37:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d3a:	ff 45 e4             	incl   -0x1c(%ebp)
  800d3d:	a1 20 40 80 00       	mov    0x804020,%eax
  800d42:	8b 50 74             	mov    0x74(%eax),%edx
  800d45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800d48:	39 c2                	cmp    %eax,%edx
  800d4a:	0f 87 43 ff ff ff    	ja     800c93 <_main+0xc5b>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800d50:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800d54:	74 17                	je     800d6d <_main+0xd35>
  800d56:	83 ec 04             	sub    $0x4,%esp
  800d59:	68 18 32 80 00       	push   $0x803218
  800d5e:	68 d9 00 00 00       	push   $0xd9
  800d63:	68 e1 30 80 00       	push   $0x8030e1
  800d68:	e8 d3 07 00 00       	call   801540 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800d6d:	e8 08 1c 00 00       	call   80297a <sys_calculate_free_frames>
  800d72:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800d75:	e8 83 1c 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800d7a:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800d7d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d80:	01 c0                	add    %eax,%eax
  800d82:	83 ec 0c             	sub    $0xc,%esp
  800d85:	50                   	push   %eax
  800d86:	e8 2d 18 00 00       	call   8025b8 <malloc>
  800d8b:	83 c4 10             	add    $0x10,%esp
  800d8e:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800d94:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800d9a:	89 c2                	mov    %eax,%edx
  800d9c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d9f:	c1 e0 02             	shl    $0x2,%eax
  800da2:	89 c1                	mov    %eax,%ecx
  800da4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800da7:	c1 e0 02             	shl    $0x2,%eax
  800daa:	01 c8                	add    %ecx,%eax
  800dac:	05 00 00 00 80       	add    $0x80000000,%eax
  800db1:	39 c2                	cmp    %eax,%edx
  800db3:	72 21                	jb     800dd6 <_main+0xd9e>
  800db5:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800dbb:	89 c2                	mov    %eax,%edx
  800dbd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dc0:	c1 e0 02             	shl    $0x2,%eax
  800dc3:	89 c1                	mov    %eax,%ecx
  800dc5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800dc8:	c1 e0 02             	shl    $0x2,%eax
  800dcb:	01 c8                	add    %ecx,%eax
  800dcd:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800dd2:	39 c2                	cmp    %eax,%edx
  800dd4:	76 17                	jbe    800ded <_main+0xdb5>
  800dd6:	83 ec 04             	sub    $0x4,%esp
  800dd9:	68 3c 31 80 00       	push   $0x80313c
  800dde:	68 df 00 00 00       	push   $0xdf
  800de3:	68 e1 30 80 00       	push   $0x8030e1
  800de8:	e8 53 07 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800ded:	e8 0b 1c 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800df2:	2b 45 90             	sub    -0x70(%ebp),%eax
  800df5:	83 f8 01             	cmp    $0x1,%eax
  800df8:	74 17                	je     800e11 <_main+0xdd9>
  800dfa:	83 ec 04             	sub    $0x4,%esp
  800dfd:	68 a4 31 80 00       	push   $0x8031a4
  800e02:	68 e0 00 00 00       	push   $0xe0
  800e07:	68 e1 30 80 00       	push   $0x8030e1
  800e0c:	e8 2f 07 00 00       	call   801540 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e11:	e8 e7 1b 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800e16:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800e19:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800e1c:	89 d0                	mov    %edx,%eax
  800e1e:	01 c0                	add    %eax,%eax
  800e20:	01 d0                	add    %edx,%eax
  800e22:	01 c0                	add    %eax,%eax
  800e24:	01 d0                	add    %edx,%eax
  800e26:	83 ec 0c             	sub    $0xc,%esp
  800e29:	50                   	push   %eax
  800e2a:	e8 89 17 00 00       	call   8025b8 <malloc>
  800e2f:	83 c4 10             	add    $0x10,%esp
  800e32:	89 85 90 fe ff ff    	mov    %eax,-0x170(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800e38:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e3e:	89 c2                	mov    %eax,%edx
  800e40:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e43:	c1 e0 02             	shl    $0x2,%eax
  800e46:	89 c1                	mov    %eax,%ecx
  800e48:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e4b:	c1 e0 03             	shl    $0x3,%eax
  800e4e:	01 c8                	add    %ecx,%eax
  800e50:	05 00 00 00 80       	add    $0x80000000,%eax
  800e55:	39 c2                	cmp    %eax,%edx
  800e57:	72 21                	jb     800e7a <_main+0xe42>
  800e59:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e5f:	89 c2                	mov    %eax,%edx
  800e61:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e64:	c1 e0 02             	shl    $0x2,%eax
  800e67:	89 c1                	mov    %eax,%ecx
  800e69:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e6c:	c1 e0 03             	shl    $0x3,%eax
  800e6f:	01 c8                	add    %ecx,%eax
  800e71:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800e76:	39 c2                	cmp    %eax,%edx
  800e78:	76 17                	jbe    800e91 <_main+0xe59>
  800e7a:	83 ec 04             	sub    $0x4,%esp
  800e7d:	68 3c 31 80 00       	push   $0x80313c
  800e82:	68 e6 00 00 00       	push   $0xe6
  800e87:	68 e1 30 80 00       	push   $0x8030e1
  800e8c:	e8 af 06 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800e91:	e8 67 1b 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800e96:	2b 45 90             	sub    -0x70(%ebp),%eax
  800e99:	83 f8 02             	cmp    $0x2,%eax
  800e9c:	74 17                	je     800eb5 <_main+0xe7d>
  800e9e:	83 ec 04             	sub    $0x4,%esp
  800ea1:	68 a4 31 80 00       	push   $0x8031a4
  800ea6:	68 e7 00 00 00       	push   $0xe7
  800eab:	68 e1 30 80 00       	push   $0x8030e1
  800eb0:	e8 8b 06 00 00       	call   801540 <_panic>


		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800eb5:	e8 c0 1a 00 00       	call   80297a <sys_calculate_free_frames>
  800eba:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800ebd:	e8 3b 1b 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800ec2:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800ec5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ec8:	89 c2                	mov    %eax,%edx
  800eca:	01 d2                	add    %edx,%edx
  800ecc:	01 d0                	add    %edx,%eax
  800ece:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800ed1:	83 ec 0c             	sub    $0xc,%esp
  800ed4:	50                   	push   %eax
  800ed5:	e8 de 16 00 00       	call   8025b8 <malloc>
  800eda:	83 c4 10             	add    $0x10,%esp
  800edd:	89 85 94 fe ff ff    	mov    %eax,-0x16c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800ee3:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800ee9:	89 c2                	mov    %eax,%edx
  800eeb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800eee:	c1 e0 02             	shl    $0x2,%eax
  800ef1:	89 c1                	mov    %eax,%ecx
  800ef3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800ef6:	c1 e0 04             	shl    $0x4,%eax
  800ef9:	01 c8                	add    %ecx,%eax
  800efb:	05 00 00 00 80       	add    $0x80000000,%eax
  800f00:	39 c2                	cmp    %eax,%edx
  800f02:	72 21                	jb     800f25 <_main+0xeed>
  800f04:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800f0a:	89 c2                	mov    %eax,%edx
  800f0c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f0f:	c1 e0 02             	shl    $0x2,%eax
  800f12:	89 c1                	mov    %eax,%ecx
  800f14:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800f17:	c1 e0 04             	shl    $0x4,%eax
  800f1a:	01 c8                	add    %ecx,%eax
  800f1c:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800f21:	39 c2                	cmp    %eax,%edx
  800f23:	76 17                	jbe    800f3c <_main+0xf04>
  800f25:	83 ec 04             	sub    $0x4,%esp
  800f28:	68 3c 31 80 00       	push   $0x80313c
  800f2d:	68 ee 00 00 00       	push   $0xee
  800f32:	68 e1 30 80 00       	push   $0x8030e1
  800f37:	e8 04 06 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800f3c:	e8 bc 1a 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800f41:	2b 45 90             	sub    -0x70(%ebp),%eax
  800f44:	89 c2                	mov    %eax,%edx
  800f46:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f49:	89 c1                	mov    %eax,%ecx
  800f4b:	01 c9                	add    %ecx,%ecx
  800f4d:	01 c8                	add    %ecx,%eax
  800f4f:	85 c0                	test   %eax,%eax
  800f51:	79 05                	jns    800f58 <_main+0xf20>
  800f53:	05 ff 0f 00 00       	add    $0xfff,%eax
  800f58:	c1 f8 0c             	sar    $0xc,%eax
  800f5b:	39 c2                	cmp    %eax,%edx
  800f5d:	74 17                	je     800f76 <_main+0xf3e>
  800f5f:	83 ec 04             	sub    $0x4,%esp
  800f62:	68 a4 31 80 00       	push   $0x8031a4
  800f67:	68 ef 00 00 00       	push   $0xef
  800f6c:	68 e1 30 80 00       	push   $0x8030e1
  800f71:	e8 ca 05 00 00       	call   801540 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f76:	e8 82 1a 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  800f7b:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800f7e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800f81:	89 d0                	mov    %edx,%eax
  800f83:	01 c0                	add    %eax,%eax
  800f85:	01 d0                	add    %edx,%eax
  800f87:	01 c0                	add    %eax,%eax
  800f89:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800f8c:	83 ec 0c             	sub    $0xc,%esp
  800f8f:	50                   	push   %eax
  800f90:	e8 23 16 00 00       	call   8025b8 <malloc>
  800f95:	83 c4 10             	add    $0x10,%esp
  800f98:	89 85 98 fe ff ff    	mov    %eax,-0x168(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800f9e:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800fa4:	89 c1                	mov    %eax,%ecx
  800fa6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fa9:	89 d0                	mov    %edx,%eax
  800fab:	01 c0                	add    %eax,%eax
  800fad:	01 d0                	add    %edx,%eax
  800faf:	01 c0                	add    %eax,%eax
  800fb1:	01 d0                	add    %edx,%eax
  800fb3:	89 c2                	mov    %eax,%edx
  800fb5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fb8:	c1 e0 04             	shl    $0x4,%eax
  800fbb:	01 d0                	add    %edx,%eax
  800fbd:	05 00 00 00 80       	add    $0x80000000,%eax
  800fc2:	39 c1                	cmp    %eax,%ecx
  800fc4:	72 28                	jb     800fee <_main+0xfb6>
  800fc6:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800fcc:	89 c1                	mov    %eax,%ecx
  800fce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fd1:	89 d0                	mov    %edx,%eax
  800fd3:	01 c0                	add    %eax,%eax
  800fd5:	01 d0                	add    %edx,%eax
  800fd7:	01 c0                	add    %eax,%eax
  800fd9:	01 d0                	add    %edx,%eax
  800fdb:	89 c2                	mov    %eax,%edx
  800fdd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fe0:	c1 e0 04             	shl    $0x4,%eax
  800fe3:	01 d0                	add    %edx,%eax
  800fe5:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800fea:	39 c1                	cmp    %eax,%ecx
  800fec:	76 17                	jbe    801005 <_main+0xfcd>
  800fee:	83 ec 04             	sub    $0x4,%esp
  800ff1:	68 3c 31 80 00       	push   $0x80313c
  800ff6:	68 f5 00 00 00       	push   $0xf5
  800ffb:	68 e1 30 80 00       	push   $0x8030e1
  801000:	e8 3b 05 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  801005:	e8 f3 19 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  80100a:	2b 45 90             	sub    -0x70(%ebp),%eax
  80100d:	89 c1                	mov    %eax,%ecx
  80100f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801012:	89 d0                	mov    %edx,%eax
  801014:	01 c0                	add    %eax,%eax
  801016:	01 d0                	add    %edx,%eax
  801018:	01 c0                	add    %eax,%eax
  80101a:	85 c0                	test   %eax,%eax
  80101c:	79 05                	jns    801023 <_main+0xfeb>
  80101e:	05 ff 0f 00 00       	add    $0xfff,%eax
  801023:	c1 f8 0c             	sar    $0xc,%eax
  801026:	39 c1                	cmp    %eax,%ecx
  801028:	74 17                	je     801041 <_main+0x1009>
  80102a:	83 ec 04             	sub    $0x4,%esp
  80102d:	68 a4 31 80 00       	push   $0x8031a4
  801032:	68 f6 00 00 00       	push   $0xf6
  801037:	68 e1 30 80 00       	push   $0x8030e1
  80103c:	e8 ff 04 00 00       	call   801540 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  801041:	e8 34 19 00 00       	call   80297a <sys_calculate_free_frames>
  801046:	89 45 8c             	mov    %eax,-0x74(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  801049:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80104c:	89 d0                	mov    %edx,%eax
  80104e:	01 c0                	add    %eax,%eax
  801050:	01 d0                	add    %edx,%eax
  801052:	01 c0                	add    %eax,%eax
  801054:	2b 45 d0             	sub    -0x30(%ebp),%eax
  801057:	48                   	dec    %eax
  801058:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  80105e:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  801064:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		byteArr2[0] = minByte ;
  80106a:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801070:	8a 55 cf             	mov    -0x31(%ebp),%dl
  801073:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  801075:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  80107b:	89 c2                	mov    %eax,%edx
  80107d:	c1 ea 1f             	shr    $0x1f,%edx
  801080:	01 d0                	add    %edx,%eax
  801082:	d1 f8                	sar    %eax
  801084:	89 c2                	mov    %eax,%edx
  801086:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  80108c:	01 c2                	add    %eax,%edx
  80108e:	8a 45 ce             	mov    -0x32(%ebp),%al
  801091:	88 c1                	mov    %al,%cl
  801093:	c0 e9 07             	shr    $0x7,%cl
  801096:	01 c8                	add    %ecx,%eax
  801098:	d0 f8                	sar    %al
  80109a:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  80109c:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  8010a2:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8010a8:	01 c2                	add    %eax,%edx
  8010aa:	8a 45 ce             	mov    -0x32(%ebp),%al
  8010ad:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8010af:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8010b2:	e8 c3 18 00 00       	call   80297a <sys_calculate_free_frames>
  8010b7:	29 c3                	sub    %eax,%ebx
  8010b9:	89 d8                	mov    %ebx,%eax
  8010bb:	83 f8 05             	cmp    $0x5,%eax
  8010be:	74 17                	je     8010d7 <_main+0x109f>
  8010c0:	83 ec 04             	sub    $0x4,%esp
  8010c3:	68 d4 31 80 00       	push   $0x8031d4
  8010c8:	68 fe 00 00 00       	push   $0xfe
  8010cd:	68 e1 30 80 00       	push   $0x8030e1
  8010d2:	e8 69 04 00 00       	call   801540 <_panic>
		found = 0;
  8010d7:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8010de:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8010e5:	e9 02 01 00 00       	jmp    8011ec <_main+0x11b4>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8010ea:	a1 20 40 80 00       	mov    0x804020,%eax
  8010ef:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8010f5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8010f8:	89 d0                	mov    %edx,%eax
  8010fa:	01 c0                	add    %eax,%eax
  8010fc:	01 d0                	add    %edx,%eax
  8010fe:	c1 e0 02             	shl    $0x2,%eax
  801101:	01 c8                	add    %ecx,%eax
  801103:	8b 00                	mov    (%eax),%eax
  801105:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  80110b:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  801111:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801116:	89 c2                	mov    %eax,%edx
  801118:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  80111e:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  801124:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80112a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80112f:	39 c2                	cmp    %eax,%edx
  801131:	75 03                	jne    801136 <_main+0x10fe>
				found++;
  801133:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  801136:	a1 20 40 80 00       	mov    0x804020,%eax
  80113b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801141:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801144:	89 d0                	mov    %edx,%eax
  801146:	01 c0                	add    %eax,%eax
  801148:	01 d0                	add    %edx,%eax
  80114a:	c1 e0 02             	shl    $0x2,%eax
  80114d:	01 c8                	add    %ecx,%eax
  80114f:	8b 00                	mov    (%eax),%eax
  801151:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
  801157:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80115d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801162:	89 c2                	mov    %eax,%edx
  801164:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  80116a:	89 c1                	mov    %eax,%ecx
  80116c:	c1 e9 1f             	shr    $0x1f,%ecx
  80116f:	01 c8                	add    %ecx,%eax
  801171:	d1 f8                	sar    %eax
  801173:	89 c1                	mov    %eax,%ecx
  801175:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  80117b:	01 c8                	add    %ecx,%eax
  80117d:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  801183:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  801189:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80118e:	39 c2                	cmp    %eax,%edx
  801190:	75 03                	jne    801195 <_main+0x115d>
				found++;
  801192:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  801195:	a1 20 40 80 00       	mov    0x804020,%eax
  80119a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8011a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011a3:	89 d0                	mov    %edx,%eax
  8011a5:	01 c0                	add    %eax,%eax
  8011a7:	01 d0                	add    %edx,%eax
  8011a9:	c1 e0 02             	shl    $0x2,%eax
  8011ac:	01 c8                	add    %ecx,%eax
  8011ae:	8b 00                	mov    (%eax),%eax
  8011b0:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  8011b6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  8011bc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011c1:	89 c1                	mov    %eax,%ecx
  8011c3:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  8011c9:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8011cf:	01 d0                	add    %edx,%eax
  8011d1:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  8011d7:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  8011dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011e2:	39 c1                	cmp    %eax,%ecx
  8011e4:	75 03                	jne    8011e9 <_main+0x11b1>
				found++;
  8011e6:	ff 45 d8             	incl   -0x28(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8011e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8011ec:	a1 20 40 80 00       	mov    0x804020,%eax
  8011f1:	8b 50 74             	mov    0x74(%eax),%edx
  8011f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8011f7:	39 c2                	cmp    %eax,%edx
  8011f9:	0f 87 eb fe ff ff    	ja     8010ea <_main+0x10b2>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  8011ff:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
  801203:	74 17                	je     80121c <_main+0x11e4>
  801205:	83 ec 04             	sub    $0x4,%esp
  801208:	68 18 32 80 00       	push   $0x803218
  80120d:	68 09 01 00 00       	push   $0x109
  801212:	68 e1 30 80 00       	push   $0x8030e1
  801217:	e8 24 03 00 00       	call   801540 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80121c:	e8 dc 17 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  801221:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  801224:	8b 55 d0             	mov    -0x30(%ebp),%edx
  801227:	89 d0                	mov    %edx,%eax
  801229:	01 c0                	add    %eax,%eax
  80122b:	01 d0                	add    %edx,%eax
  80122d:	01 c0                	add    %eax,%eax
  80122f:	01 d0                	add    %edx,%eax
  801231:	01 c0                	add    %eax,%eax
  801233:	83 ec 0c             	sub    $0xc,%esp
  801236:	50                   	push   %eax
  801237:	e8 7c 13 00 00       	call   8025b8 <malloc>
  80123c:	83 c4 10             	add    $0x10,%esp
  80123f:	89 85 9c fe ff ff    	mov    %eax,-0x164(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  801245:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  80124b:	89 c1                	mov    %eax,%ecx
  80124d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801250:	89 d0                	mov    %edx,%eax
  801252:	01 c0                	add    %eax,%eax
  801254:	01 d0                	add    %edx,%eax
  801256:	c1 e0 02             	shl    $0x2,%eax
  801259:	01 d0                	add    %edx,%eax
  80125b:	89 c2                	mov    %eax,%edx
  80125d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801260:	c1 e0 04             	shl    $0x4,%eax
  801263:	01 d0                	add    %edx,%eax
  801265:	05 00 00 00 80       	add    $0x80000000,%eax
  80126a:	39 c1                	cmp    %eax,%ecx
  80126c:	72 29                	jb     801297 <_main+0x125f>
  80126e:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  801274:	89 c1                	mov    %eax,%ecx
  801276:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801279:	89 d0                	mov    %edx,%eax
  80127b:	01 c0                	add    %eax,%eax
  80127d:	01 d0                	add    %edx,%eax
  80127f:	c1 e0 02             	shl    $0x2,%eax
  801282:	01 d0                	add    %edx,%eax
  801284:	89 c2                	mov    %eax,%edx
  801286:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801289:	c1 e0 04             	shl    $0x4,%eax
  80128c:	01 d0                	add    %edx,%eax
  80128e:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  801293:	39 c1                	cmp    %eax,%ecx
  801295:	76 17                	jbe    8012ae <_main+0x1276>
  801297:	83 ec 04             	sub    $0x4,%esp
  80129a:	68 3c 31 80 00       	push   $0x80313c
  80129f:	68 0e 01 00 00       	push   $0x10e
  8012a4:	68 e1 30 80 00       	push   $0x8030e1
  8012a9:	e8 92 02 00 00       	call   801540 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  8012ae:	e8 4a 17 00 00       	call   8029fd <sys_pf_calculate_allocated_pages>
  8012b3:	2b 45 90             	sub    -0x70(%ebp),%eax
  8012b6:	83 f8 04             	cmp    $0x4,%eax
  8012b9:	74 17                	je     8012d2 <_main+0x129a>
  8012bb:	83 ec 04             	sub    $0x4,%esp
  8012be:	68 a4 31 80 00       	push   $0x8031a4
  8012c3:	68 0f 01 00 00       	push   $0x10f
  8012c8:	68 e1 30 80 00       	push   $0x8030e1
  8012cd:	e8 6e 02 00 00       	call   801540 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8012d2:	e8 a3 16 00 00       	call   80297a <sys_calculate_free_frames>
  8012d7:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  8012da:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  8012e0:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  8012e6:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8012e9:	89 d0                	mov    %edx,%eax
  8012eb:	01 c0                	add    %eax,%eax
  8012ed:	01 d0                	add    %edx,%eax
  8012ef:	01 c0                	add    %eax,%eax
  8012f1:	01 d0                	add    %edx,%eax
  8012f3:	01 c0                	add    %eax,%eax
  8012f5:	d1 e8                	shr    %eax
  8012f7:	48                   	dec    %eax
  8012f8:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
		shortArr2[0] = minShort;
  8012fe:	8b 95 10 ff ff ff    	mov    -0xf0(%ebp),%edx
  801304:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801307:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  80130a:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  801310:	01 c0                	add    %eax,%eax
  801312:	89 c2                	mov    %eax,%edx
  801314:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  80131a:	01 c2                	add    %eax,%edx
  80131c:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  801320:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  801323:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  801326:	e8 4f 16 00 00       	call   80297a <sys_calculate_free_frames>
  80132b:	29 c3                	sub    %eax,%ebx
  80132d:	89 d8                	mov    %ebx,%eax
  80132f:	83 f8 02             	cmp    $0x2,%eax
  801332:	74 17                	je     80134b <_main+0x1313>
  801334:	83 ec 04             	sub    $0x4,%esp
  801337:	68 d4 31 80 00       	push   $0x8031d4
  80133c:	68 16 01 00 00       	push   $0x116
  801341:	68 e1 30 80 00       	push   $0x8030e1
  801346:	e8 f5 01 00 00       	call   801540 <_panic>
		found = 0;
  80134b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801352:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801359:	e9 a7 00 00 00       	jmp    801405 <_main+0x13cd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  80135e:	a1 20 40 80 00       	mov    0x804020,%eax
  801363:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801369:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80136c:	89 d0                	mov    %edx,%eax
  80136e:	01 c0                	add    %eax,%eax
  801370:	01 d0                	add    %edx,%eax
  801372:	c1 e0 02             	shl    $0x2,%eax
  801375:	01 c8                	add    %ecx,%eax
  801377:	8b 00                	mov    (%eax),%eax
  801379:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  80137f:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  801385:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80138a:	89 c2                	mov    %eax,%edx
  80138c:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  801392:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  801398:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  80139e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013a3:	39 c2                	cmp    %eax,%edx
  8013a5:	75 03                	jne    8013aa <_main+0x1372>
				found++;
  8013a7:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  8013aa:	a1 20 40 80 00       	mov    0x804020,%eax
  8013af:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8013b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013b8:	89 d0                	mov    %edx,%eax
  8013ba:	01 c0                	add    %eax,%eax
  8013bc:	01 d0                	add    %edx,%eax
  8013be:	c1 e0 02             	shl    $0x2,%eax
  8013c1:	01 c8                	add    %ecx,%eax
  8013c3:	8b 00                	mov    (%eax),%eax
  8013c5:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  8013cb:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  8013d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013d6:	89 c2                	mov    %eax,%edx
  8013d8:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  8013de:	01 c0                	add    %eax,%eax
  8013e0:	89 c1                	mov    %eax,%ecx
  8013e2:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  8013e8:	01 c8                	add    %ecx,%eax
  8013ea:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  8013f0:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  8013f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013fb:	39 c2                	cmp    %eax,%edx
  8013fd:	75 03                	jne    801402 <_main+0x13ca>
				found++;
  8013ff:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801402:	ff 45 e4             	incl   -0x1c(%ebp)
  801405:	a1 20 40 80 00       	mov    0x804020,%eax
  80140a:	8b 50 74             	mov    0x74(%eax),%edx
  80140d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801410:	39 c2                	cmp    %eax,%edx
  801412:	0f 87 46 ff ff ff    	ja     80135e <_main+0x1326>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  801418:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  80141c:	74 17                	je     801435 <_main+0x13fd>
  80141e:	83 ec 04             	sub    $0x4,%esp
  801421:	68 18 32 80 00       	push   $0x803218
  801426:	68 1f 01 00 00       	push   $0x11f
  80142b:	68 e1 30 80 00       	push   $0x8030e1
  801430:	e8 0b 01 00 00       	call   801540 <_panic>
		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
*/
	return;
  801435:	90                   	nop
}
  801436:	8d 65 f4             	lea    -0xc(%ebp),%esp
  801439:	5b                   	pop    %ebx
  80143a:	5e                   	pop    %esi
  80143b:	5f                   	pop    %edi
  80143c:	5d                   	pop    %ebp
  80143d:	c3                   	ret    

0080143e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
  801441:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801444:	e8 66 14 00 00       	call   8028af <sys_getenvindex>
  801449:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80144c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80144f:	89 d0                	mov    %edx,%eax
  801451:	01 c0                	add    %eax,%eax
  801453:	01 d0                	add    %edx,%eax
  801455:	c1 e0 02             	shl    $0x2,%eax
  801458:	01 d0                	add    %edx,%eax
  80145a:	c1 e0 06             	shl    $0x6,%eax
  80145d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  801462:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801467:	a1 20 40 80 00       	mov    0x804020,%eax
  80146c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  801472:	84 c0                	test   %al,%al
  801474:	74 0f                	je     801485 <libmain+0x47>
		binaryname = myEnv->prog_name;
  801476:	a1 20 40 80 00       	mov    0x804020,%eax
  80147b:	05 f4 02 00 00       	add    $0x2f4,%eax
  801480:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801485:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801489:	7e 0a                	jle    801495 <libmain+0x57>
		binaryname = argv[0];
  80148b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148e:	8b 00                	mov    (%eax),%eax
  801490:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  801495:	83 ec 08             	sub    $0x8,%esp
  801498:	ff 75 0c             	pushl  0xc(%ebp)
  80149b:	ff 75 08             	pushl  0x8(%ebp)
  80149e:	e8 95 eb ff ff       	call   800038 <_main>
  8014a3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8014a6:	e8 9f 15 00 00       	call   802a4a <sys_disable_interrupt>
	cprintf("**************************************\n");
  8014ab:	83 ec 0c             	sub    $0xc,%esp
  8014ae:	68 3c 33 80 00       	push   $0x80333c
  8014b3:	e8 3c 03 00 00       	call   8017f4 <cprintf>
  8014b8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8014bb:	a1 20 40 80 00       	mov    0x804020,%eax
  8014c0:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8014c6:	a1 20 40 80 00       	mov    0x804020,%eax
  8014cb:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8014d1:	83 ec 04             	sub    $0x4,%esp
  8014d4:	52                   	push   %edx
  8014d5:	50                   	push   %eax
  8014d6:	68 64 33 80 00       	push   $0x803364
  8014db:	e8 14 03 00 00       	call   8017f4 <cprintf>
  8014e0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8014e3:	a1 20 40 80 00       	mov    0x804020,%eax
  8014e8:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8014ee:	83 ec 08             	sub    $0x8,%esp
  8014f1:	50                   	push   %eax
  8014f2:	68 89 33 80 00       	push   $0x803389
  8014f7:	e8 f8 02 00 00       	call   8017f4 <cprintf>
  8014fc:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8014ff:	83 ec 0c             	sub    $0xc,%esp
  801502:	68 3c 33 80 00       	push   $0x80333c
  801507:	e8 e8 02 00 00       	call   8017f4 <cprintf>
  80150c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80150f:	e8 50 15 00 00       	call   802a64 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801514:	e8 19 00 00 00       	call   801532 <exit>
}
  801519:	90                   	nop
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
  80151f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801522:	83 ec 0c             	sub    $0xc,%esp
  801525:	6a 00                	push   $0x0
  801527:	e8 4f 13 00 00       	call   80287b <sys_env_destroy>
  80152c:	83 c4 10             	add    $0x10,%esp
}
  80152f:	90                   	nop
  801530:	c9                   	leave  
  801531:	c3                   	ret    

00801532 <exit>:

void
exit(void)
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
  801535:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801538:	e8 a4 13 00 00       	call   8028e1 <sys_env_exit>
}
  80153d:	90                   	nop
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
  801543:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801546:	8d 45 10             	lea    0x10(%ebp),%eax
  801549:	83 c0 04             	add    $0x4,%eax
  80154c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80154f:	a1 30 40 80 00       	mov    0x804030,%eax
  801554:	85 c0                	test   %eax,%eax
  801556:	74 16                	je     80156e <_panic+0x2e>
		cprintf("%s: ", argv0);
  801558:	a1 30 40 80 00       	mov    0x804030,%eax
  80155d:	83 ec 08             	sub    $0x8,%esp
  801560:	50                   	push   %eax
  801561:	68 a0 33 80 00       	push   $0x8033a0
  801566:	e8 89 02 00 00       	call   8017f4 <cprintf>
  80156b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80156e:	a1 00 40 80 00       	mov    0x804000,%eax
  801573:	ff 75 0c             	pushl  0xc(%ebp)
  801576:	ff 75 08             	pushl  0x8(%ebp)
  801579:	50                   	push   %eax
  80157a:	68 a5 33 80 00       	push   $0x8033a5
  80157f:	e8 70 02 00 00       	call   8017f4 <cprintf>
  801584:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801587:	8b 45 10             	mov    0x10(%ebp),%eax
  80158a:	83 ec 08             	sub    $0x8,%esp
  80158d:	ff 75 f4             	pushl  -0xc(%ebp)
  801590:	50                   	push   %eax
  801591:	e8 f3 01 00 00       	call   801789 <vcprintf>
  801596:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801599:	83 ec 08             	sub    $0x8,%esp
  80159c:	6a 00                	push   $0x0
  80159e:	68 c1 33 80 00       	push   $0x8033c1
  8015a3:	e8 e1 01 00 00       	call   801789 <vcprintf>
  8015a8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8015ab:	e8 82 ff ff ff       	call   801532 <exit>

	// should not return here
	while (1) ;
  8015b0:	eb fe                	jmp    8015b0 <_panic+0x70>

008015b2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
  8015b5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8015b8:	a1 20 40 80 00       	mov    0x804020,%eax
  8015bd:	8b 50 74             	mov    0x74(%eax),%edx
  8015c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c3:	39 c2                	cmp    %eax,%edx
  8015c5:	74 14                	je     8015db <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8015c7:	83 ec 04             	sub    $0x4,%esp
  8015ca:	68 c4 33 80 00       	push   $0x8033c4
  8015cf:	6a 26                	push   $0x26
  8015d1:	68 10 34 80 00       	push   $0x803410
  8015d6:	e8 65 ff ff ff       	call   801540 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8015db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8015e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015e9:	e9 c2 00 00 00       	jmp    8016b0 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8015ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	01 d0                	add    %edx,%eax
  8015fd:	8b 00                	mov    (%eax),%eax
  8015ff:	85 c0                	test   %eax,%eax
  801601:	75 08                	jne    80160b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801603:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801606:	e9 a2 00 00 00       	jmp    8016ad <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80160b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801612:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801619:	eb 69                	jmp    801684 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80161b:	a1 20 40 80 00       	mov    0x804020,%eax
  801620:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801626:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801629:	89 d0                	mov    %edx,%eax
  80162b:	01 c0                	add    %eax,%eax
  80162d:	01 d0                	add    %edx,%eax
  80162f:	c1 e0 02             	shl    $0x2,%eax
  801632:	01 c8                	add    %ecx,%eax
  801634:	8a 40 04             	mov    0x4(%eax),%al
  801637:	84 c0                	test   %al,%al
  801639:	75 46                	jne    801681 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80163b:	a1 20 40 80 00       	mov    0x804020,%eax
  801640:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801646:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801649:	89 d0                	mov    %edx,%eax
  80164b:	01 c0                	add    %eax,%eax
  80164d:	01 d0                	add    %edx,%eax
  80164f:	c1 e0 02             	shl    $0x2,%eax
  801652:	01 c8                	add    %ecx,%eax
  801654:	8b 00                	mov    (%eax),%eax
  801656:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801659:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80165c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801661:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801663:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801666:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	01 c8                	add    %ecx,%eax
  801672:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801674:	39 c2                	cmp    %eax,%edx
  801676:	75 09                	jne    801681 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801678:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80167f:	eb 12                	jmp    801693 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801681:	ff 45 e8             	incl   -0x18(%ebp)
  801684:	a1 20 40 80 00       	mov    0x804020,%eax
  801689:	8b 50 74             	mov    0x74(%eax),%edx
  80168c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80168f:	39 c2                	cmp    %eax,%edx
  801691:	77 88                	ja     80161b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801693:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801697:	75 14                	jne    8016ad <CheckWSWithoutLastIndex+0xfb>
			panic(
  801699:	83 ec 04             	sub    $0x4,%esp
  80169c:	68 1c 34 80 00       	push   $0x80341c
  8016a1:	6a 3a                	push   $0x3a
  8016a3:	68 10 34 80 00       	push   $0x803410
  8016a8:	e8 93 fe ff ff       	call   801540 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8016ad:	ff 45 f0             	incl   -0x10(%ebp)
  8016b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016b3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8016b6:	0f 8c 32 ff ff ff    	jl     8015ee <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8016bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016c3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8016ca:	eb 26                	jmp    8016f2 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8016cc:	a1 20 40 80 00       	mov    0x804020,%eax
  8016d1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8016d7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8016da:	89 d0                	mov    %edx,%eax
  8016dc:	01 c0                	add    %eax,%eax
  8016de:	01 d0                	add    %edx,%eax
  8016e0:	c1 e0 02             	shl    $0x2,%eax
  8016e3:	01 c8                	add    %ecx,%eax
  8016e5:	8a 40 04             	mov    0x4(%eax),%al
  8016e8:	3c 01                	cmp    $0x1,%al
  8016ea:	75 03                	jne    8016ef <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8016ec:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016ef:	ff 45 e0             	incl   -0x20(%ebp)
  8016f2:	a1 20 40 80 00       	mov    0x804020,%eax
  8016f7:	8b 50 74             	mov    0x74(%eax),%edx
  8016fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016fd:	39 c2                	cmp    %eax,%edx
  8016ff:	77 cb                	ja     8016cc <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801701:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801704:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801707:	74 14                	je     80171d <CheckWSWithoutLastIndex+0x16b>
		panic(
  801709:	83 ec 04             	sub    $0x4,%esp
  80170c:	68 70 34 80 00       	push   $0x803470
  801711:	6a 44                	push   $0x44
  801713:	68 10 34 80 00       	push   $0x803410
  801718:	e8 23 fe ff ff       	call   801540 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80171d:	90                   	nop
  80171e:	c9                   	leave  
  80171f:	c3                   	ret    

00801720 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
  801723:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801726:	8b 45 0c             	mov    0xc(%ebp),%eax
  801729:	8b 00                	mov    (%eax),%eax
  80172b:	8d 48 01             	lea    0x1(%eax),%ecx
  80172e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801731:	89 0a                	mov    %ecx,(%edx)
  801733:	8b 55 08             	mov    0x8(%ebp),%edx
  801736:	88 d1                	mov    %dl,%cl
  801738:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80173f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801742:	8b 00                	mov    (%eax),%eax
  801744:	3d ff 00 00 00       	cmp    $0xff,%eax
  801749:	75 2c                	jne    801777 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80174b:	a0 24 40 80 00       	mov    0x804024,%al
  801750:	0f b6 c0             	movzbl %al,%eax
  801753:	8b 55 0c             	mov    0xc(%ebp),%edx
  801756:	8b 12                	mov    (%edx),%edx
  801758:	89 d1                	mov    %edx,%ecx
  80175a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80175d:	83 c2 08             	add    $0x8,%edx
  801760:	83 ec 04             	sub    $0x4,%esp
  801763:	50                   	push   %eax
  801764:	51                   	push   %ecx
  801765:	52                   	push   %edx
  801766:	e8 ce 10 00 00       	call   802839 <sys_cputs>
  80176b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80176e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801771:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801777:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177a:	8b 40 04             	mov    0x4(%eax),%eax
  80177d:	8d 50 01             	lea    0x1(%eax),%edx
  801780:	8b 45 0c             	mov    0xc(%ebp),%eax
  801783:	89 50 04             	mov    %edx,0x4(%eax)
}
  801786:	90                   	nop
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
  80178c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801792:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801799:	00 00 00 
	b.cnt = 0;
  80179c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8017a3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8017a6:	ff 75 0c             	pushl  0xc(%ebp)
  8017a9:	ff 75 08             	pushl  0x8(%ebp)
  8017ac:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017b2:	50                   	push   %eax
  8017b3:	68 20 17 80 00       	push   $0x801720
  8017b8:	e8 11 02 00 00       	call   8019ce <vprintfmt>
  8017bd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8017c0:	a0 24 40 80 00       	mov    0x804024,%al
  8017c5:	0f b6 c0             	movzbl %al,%eax
  8017c8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8017ce:	83 ec 04             	sub    $0x4,%esp
  8017d1:	50                   	push   %eax
  8017d2:	52                   	push   %edx
  8017d3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017d9:	83 c0 08             	add    $0x8,%eax
  8017dc:	50                   	push   %eax
  8017dd:	e8 57 10 00 00       	call   802839 <sys_cputs>
  8017e2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8017e5:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  8017ec:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <cprintf>:

int cprintf(const char *fmt, ...) {
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
  8017f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8017fa:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801801:	8d 45 0c             	lea    0xc(%ebp),%eax
  801804:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801807:	8b 45 08             	mov    0x8(%ebp),%eax
  80180a:	83 ec 08             	sub    $0x8,%esp
  80180d:	ff 75 f4             	pushl  -0xc(%ebp)
  801810:	50                   	push   %eax
  801811:	e8 73 ff ff ff       	call   801789 <vcprintf>
  801816:	83 c4 10             	add    $0x10,%esp
  801819:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80181c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80181f:	c9                   	leave  
  801820:	c3                   	ret    

00801821 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801821:	55                   	push   %ebp
  801822:	89 e5                	mov    %esp,%ebp
  801824:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801827:	e8 1e 12 00 00       	call   802a4a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80182c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80182f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801832:	8b 45 08             	mov    0x8(%ebp),%eax
  801835:	83 ec 08             	sub    $0x8,%esp
  801838:	ff 75 f4             	pushl  -0xc(%ebp)
  80183b:	50                   	push   %eax
  80183c:	e8 48 ff ff ff       	call   801789 <vcprintf>
  801841:	83 c4 10             	add    $0x10,%esp
  801844:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801847:	e8 18 12 00 00       	call   802a64 <sys_enable_interrupt>
	return cnt;
  80184c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
  801854:	53                   	push   %ebx
  801855:	83 ec 14             	sub    $0x14,%esp
  801858:	8b 45 10             	mov    0x10(%ebp),%eax
  80185b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80185e:	8b 45 14             	mov    0x14(%ebp),%eax
  801861:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801864:	8b 45 18             	mov    0x18(%ebp),%eax
  801867:	ba 00 00 00 00       	mov    $0x0,%edx
  80186c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80186f:	77 55                	ja     8018c6 <printnum+0x75>
  801871:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801874:	72 05                	jb     80187b <printnum+0x2a>
  801876:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801879:	77 4b                	ja     8018c6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80187b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80187e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801881:	8b 45 18             	mov    0x18(%ebp),%eax
  801884:	ba 00 00 00 00       	mov    $0x0,%edx
  801889:	52                   	push   %edx
  80188a:	50                   	push   %eax
  80188b:	ff 75 f4             	pushl  -0xc(%ebp)
  80188e:	ff 75 f0             	pushl  -0x10(%ebp)
  801891:	e8 92 15 00 00       	call   802e28 <__udivdi3>
  801896:	83 c4 10             	add    $0x10,%esp
  801899:	83 ec 04             	sub    $0x4,%esp
  80189c:	ff 75 20             	pushl  0x20(%ebp)
  80189f:	53                   	push   %ebx
  8018a0:	ff 75 18             	pushl  0x18(%ebp)
  8018a3:	52                   	push   %edx
  8018a4:	50                   	push   %eax
  8018a5:	ff 75 0c             	pushl  0xc(%ebp)
  8018a8:	ff 75 08             	pushl  0x8(%ebp)
  8018ab:	e8 a1 ff ff ff       	call   801851 <printnum>
  8018b0:	83 c4 20             	add    $0x20,%esp
  8018b3:	eb 1a                	jmp    8018cf <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8018b5:	83 ec 08             	sub    $0x8,%esp
  8018b8:	ff 75 0c             	pushl  0xc(%ebp)
  8018bb:	ff 75 20             	pushl  0x20(%ebp)
  8018be:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c1:	ff d0                	call   *%eax
  8018c3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8018c6:	ff 4d 1c             	decl   0x1c(%ebp)
  8018c9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8018cd:	7f e6                	jg     8018b5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8018cf:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8018d2:	bb 00 00 00 00       	mov    $0x0,%ebx
  8018d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018dd:	53                   	push   %ebx
  8018de:	51                   	push   %ecx
  8018df:	52                   	push   %edx
  8018e0:	50                   	push   %eax
  8018e1:	e8 52 16 00 00       	call   802f38 <__umoddi3>
  8018e6:	83 c4 10             	add    $0x10,%esp
  8018e9:	05 d4 36 80 00       	add    $0x8036d4,%eax
  8018ee:	8a 00                	mov    (%eax),%al
  8018f0:	0f be c0             	movsbl %al,%eax
  8018f3:	83 ec 08             	sub    $0x8,%esp
  8018f6:	ff 75 0c             	pushl  0xc(%ebp)
  8018f9:	50                   	push   %eax
  8018fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fd:	ff d0                	call   *%eax
  8018ff:	83 c4 10             	add    $0x10,%esp
}
  801902:	90                   	nop
  801903:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80190b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80190f:	7e 1c                	jle    80192d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	8b 00                	mov    (%eax),%eax
  801916:	8d 50 08             	lea    0x8(%eax),%edx
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	89 10                	mov    %edx,(%eax)
  80191e:	8b 45 08             	mov    0x8(%ebp),%eax
  801921:	8b 00                	mov    (%eax),%eax
  801923:	83 e8 08             	sub    $0x8,%eax
  801926:	8b 50 04             	mov    0x4(%eax),%edx
  801929:	8b 00                	mov    (%eax),%eax
  80192b:	eb 40                	jmp    80196d <getuint+0x65>
	else if (lflag)
  80192d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801931:	74 1e                	je     801951 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	8b 00                	mov    (%eax),%eax
  801938:	8d 50 04             	lea    0x4(%eax),%edx
  80193b:	8b 45 08             	mov    0x8(%ebp),%eax
  80193e:	89 10                	mov    %edx,(%eax)
  801940:	8b 45 08             	mov    0x8(%ebp),%eax
  801943:	8b 00                	mov    (%eax),%eax
  801945:	83 e8 04             	sub    $0x4,%eax
  801948:	8b 00                	mov    (%eax),%eax
  80194a:	ba 00 00 00 00       	mov    $0x0,%edx
  80194f:	eb 1c                	jmp    80196d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801951:	8b 45 08             	mov    0x8(%ebp),%eax
  801954:	8b 00                	mov    (%eax),%eax
  801956:	8d 50 04             	lea    0x4(%eax),%edx
  801959:	8b 45 08             	mov    0x8(%ebp),%eax
  80195c:	89 10                	mov    %edx,(%eax)
  80195e:	8b 45 08             	mov    0x8(%ebp),%eax
  801961:	8b 00                	mov    (%eax),%eax
  801963:	83 e8 04             	sub    $0x4,%eax
  801966:	8b 00                	mov    (%eax),%eax
  801968:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80196d:	5d                   	pop    %ebp
  80196e:	c3                   	ret    

0080196f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801972:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801976:	7e 1c                	jle    801994 <getint+0x25>
		return va_arg(*ap, long long);
  801978:	8b 45 08             	mov    0x8(%ebp),%eax
  80197b:	8b 00                	mov    (%eax),%eax
  80197d:	8d 50 08             	lea    0x8(%eax),%edx
  801980:	8b 45 08             	mov    0x8(%ebp),%eax
  801983:	89 10                	mov    %edx,(%eax)
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8b 00                	mov    (%eax),%eax
  80198a:	83 e8 08             	sub    $0x8,%eax
  80198d:	8b 50 04             	mov    0x4(%eax),%edx
  801990:	8b 00                	mov    (%eax),%eax
  801992:	eb 38                	jmp    8019cc <getint+0x5d>
	else if (lflag)
  801994:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801998:	74 1a                	je     8019b4 <getint+0x45>
		return va_arg(*ap, long);
  80199a:	8b 45 08             	mov    0x8(%ebp),%eax
  80199d:	8b 00                	mov    (%eax),%eax
  80199f:	8d 50 04             	lea    0x4(%eax),%edx
  8019a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a5:	89 10                	mov    %edx,(%eax)
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019aa:	8b 00                	mov    (%eax),%eax
  8019ac:	83 e8 04             	sub    $0x4,%eax
  8019af:	8b 00                	mov    (%eax),%eax
  8019b1:	99                   	cltd   
  8019b2:	eb 18                	jmp    8019cc <getint+0x5d>
	else
		return va_arg(*ap, int);
  8019b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b7:	8b 00                	mov    (%eax),%eax
  8019b9:	8d 50 04             	lea    0x4(%eax),%edx
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bf:	89 10                	mov    %edx,(%eax)
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	8b 00                	mov    (%eax),%eax
  8019c6:	83 e8 04             	sub    $0x4,%eax
  8019c9:	8b 00                	mov    (%eax),%eax
  8019cb:	99                   	cltd   
}
  8019cc:	5d                   	pop    %ebp
  8019cd:	c3                   	ret    

008019ce <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
  8019d1:	56                   	push   %esi
  8019d2:	53                   	push   %ebx
  8019d3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8019d6:	eb 17                	jmp    8019ef <vprintfmt+0x21>
			if (ch == '\0')
  8019d8:	85 db                	test   %ebx,%ebx
  8019da:	0f 84 af 03 00 00    	je     801d8f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8019e0:	83 ec 08             	sub    $0x8,%esp
  8019e3:	ff 75 0c             	pushl  0xc(%ebp)
  8019e6:	53                   	push   %ebx
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	ff d0                	call   *%eax
  8019ec:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8019ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f2:	8d 50 01             	lea    0x1(%eax),%edx
  8019f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8019f8:	8a 00                	mov    (%eax),%al
  8019fa:	0f b6 d8             	movzbl %al,%ebx
  8019fd:	83 fb 25             	cmp    $0x25,%ebx
  801a00:	75 d6                	jne    8019d8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801a02:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801a06:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801a0d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801a14:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801a1b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801a22:	8b 45 10             	mov    0x10(%ebp),%eax
  801a25:	8d 50 01             	lea    0x1(%eax),%edx
  801a28:	89 55 10             	mov    %edx,0x10(%ebp)
  801a2b:	8a 00                	mov    (%eax),%al
  801a2d:	0f b6 d8             	movzbl %al,%ebx
  801a30:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801a33:	83 f8 55             	cmp    $0x55,%eax
  801a36:	0f 87 2b 03 00 00    	ja     801d67 <vprintfmt+0x399>
  801a3c:	8b 04 85 f8 36 80 00 	mov    0x8036f8(,%eax,4),%eax
  801a43:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801a45:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801a49:	eb d7                	jmp    801a22 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801a4b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801a4f:	eb d1                	jmp    801a22 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a51:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801a58:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a5b:	89 d0                	mov    %edx,%eax
  801a5d:	c1 e0 02             	shl    $0x2,%eax
  801a60:	01 d0                	add    %edx,%eax
  801a62:	01 c0                	add    %eax,%eax
  801a64:	01 d8                	add    %ebx,%eax
  801a66:	83 e8 30             	sub    $0x30,%eax
  801a69:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801a6c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a6f:	8a 00                	mov    (%eax),%al
  801a71:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801a74:	83 fb 2f             	cmp    $0x2f,%ebx
  801a77:	7e 3e                	jle    801ab7 <vprintfmt+0xe9>
  801a79:	83 fb 39             	cmp    $0x39,%ebx
  801a7c:	7f 39                	jg     801ab7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a7e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801a81:	eb d5                	jmp    801a58 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801a83:	8b 45 14             	mov    0x14(%ebp),%eax
  801a86:	83 c0 04             	add    $0x4,%eax
  801a89:	89 45 14             	mov    %eax,0x14(%ebp)
  801a8c:	8b 45 14             	mov    0x14(%ebp),%eax
  801a8f:	83 e8 04             	sub    $0x4,%eax
  801a92:	8b 00                	mov    (%eax),%eax
  801a94:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801a97:	eb 1f                	jmp    801ab8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801a99:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a9d:	79 83                	jns    801a22 <vprintfmt+0x54>
				width = 0;
  801a9f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801aa6:	e9 77 ff ff ff       	jmp    801a22 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801aab:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801ab2:	e9 6b ff ff ff       	jmp    801a22 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801ab7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801ab8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801abc:	0f 89 60 ff ff ff    	jns    801a22 <vprintfmt+0x54>
				width = precision, precision = -1;
  801ac2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ac5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801ac8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801acf:	e9 4e ff ff ff       	jmp    801a22 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801ad4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801ad7:	e9 46 ff ff ff       	jmp    801a22 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801adc:	8b 45 14             	mov    0x14(%ebp),%eax
  801adf:	83 c0 04             	add    $0x4,%eax
  801ae2:	89 45 14             	mov    %eax,0x14(%ebp)
  801ae5:	8b 45 14             	mov    0x14(%ebp),%eax
  801ae8:	83 e8 04             	sub    $0x4,%eax
  801aeb:	8b 00                	mov    (%eax),%eax
  801aed:	83 ec 08             	sub    $0x8,%esp
  801af0:	ff 75 0c             	pushl  0xc(%ebp)
  801af3:	50                   	push   %eax
  801af4:	8b 45 08             	mov    0x8(%ebp),%eax
  801af7:	ff d0                	call   *%eax
  801af9:	83 c4 10             	add    $0x10,%esp
			break;
  801afc:	e9 89 02 00 00       	jmp    801d8a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801b01:	8b 45 14             	mov    0x14(%ebp),%eax
  801b04:	83 c0 04             	add    $0x4,%eax
  801b07:	89 45 14             	mov    %eax,0x14(%ebp)
  801b0a:	8b 45 14             	mov    0x14(%ebp),%eax
  801b0d:	83 e8 04             	sub    $0x4,%eax
  801b10:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801b12:	85 db                	test   %ebx,%ebx
  801b14:	79 02                	jns    801b18 <vprintfmt+0x14a>
				err = -err;
  801b16:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801b18:	83 fb 64             	cmp    $0x64,%ebx
  801b1b:	7f 0b                	jg     801b28 <vprintfmt+0x15a>
  801b1d:	8b 34 9d 40 35 80 00 	mov    0x803540(,%ebx,4),%esi
  801b24:	85 f6                	test   %esi,%esi
  801b26:	75 19                	jne    801b41 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801b28:	53                   	push   %ebx
  801b29:	68 e5 36 80 00       	push   $0x8036e5
  801b2e:	ff 75 0c             	pushl  0xc(%ebp)
  801b31:	ff 75 08             	pushl  0x8(%ebp)
  801b34:	e8 5e 02 00 00       	call   801d97 <printfmt>
  801b39:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801b3c:	e9 49 02 00 00       	jmp    801d8a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801b41:	56                   	push   %esi
  801b42:	68 ee 36 80 00       	push   $0x8036ee
  801b47:	ff 75 0c             	pushl  0xc(%ebp)
  801b4a:	ff 75 08             	pushl  0x8(%ebp)
  801b4d:	e8 45 02 00 00       	call   801d97 <printfmt>
  801b52:	83 c4 10             	add    $0x10,%esp
			break;
  801b55:	e9 30 02 00 00       	jmp    801d8a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801b5a:	8b 45 14             	mov    0x14(%ebp),%eax
  801b5d:	83 c0 04             	add    $0x4,%eax
  801b60:	89 45 14             	mov    %eax,0x14(%ebp)
  801b63:	8b 45 14             	mov    0x14(%ebp),%eax
  801b66:	83 e8 04             	sub    $0x4,%eax
  801b69:	8b 30                	mov    (%eax),%esi
  801b6b:	85 f6                	test   %esi,%esi
  801b6d:	75 05                	jne    801b74 <vprintfmt+0x1a6>
				p = "(null)";
  801b6f:	be f1 36 80 00       	mov    $0x8036f1,%esi
			if (width > 0 && padc != '-')
  801b74:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801b78:	7e 6d                	jle    801be7 <vprintfmt+0x219>
  801b7a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801b7e:	74 67                	je     801be7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801b80:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b83:	83 ec 08             	sub    $0x8,%esp
  801b86:	50                   	push   %eax
  801b87:	56                   	push   %esi
  801b88:	e8 0c 03 00 00       	call   801e99 <strnlen>
  801b8d:	83 c4 10             	add    $0x10,%esp
  801b90:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801b93:	eb 16                	jmp    801bab <vprintfmt+0x1dd>
					putch(padc, putdat);
  801b95:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801b99:	83 ec 08             	sub    $0x8,%esp
  801b9c:	ff 75 0c             	pushl  0xc(%ebp)
  801b9f:	50                   	push   %eax
  801ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba3:	ff d0                	call   *%eax
  801ba5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801ba8:	ff 4d e4             	decl   -0x1c(%ebp)
  801bab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801baf:	7f e4                	jg     801b95 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801bb1:	eb 34                	jmp    801be7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801bb3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801bb7:	74 1c                	je     801bd5 <vprintfmt+0x207>
  801bb9:	83 fb 1f             	cmp    $0x1f,%ebx
  801bbc:	7e 05                	jle    801bc3 <vprintfmt+0x1f5>
  801bbe:	83 fb 7e             	cmp    $0x7e,%ebx
  801bc1:	7e 12                	jle    801bd5 <vprintfmt+0x207>
					putch('?', putdat);
  801bc3:	83 ec 08             	sub    $0x8,%esp
  801bc6:	ff 75 0c             	pushl  0xc(%ebp)
  801bc9:	6a 3f                	push   $0x3f
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	ff d0                	call   *%eax
  801bd0:	83 c4 10             	add    $0x10,%esp
  801bd3:	eb 0f                	jmp    801be4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801bd5:	83 ec 08             	sub    $0x8,%esp
  801bd8:	ff 75 0c             	pushl  0xc(%ebp)
  801bdb:	53                   	push   %ebx
  801bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdf:	ff d0                	call   *%eax
  801be1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801be4:	ff 4d e4             	decl   -0x1c(%ebp)
  801be7:	89 f0                	mov    %esi,%eax
  801be9:	8d 70 01             	lea    0x1(%eax),%esi
  801bec:	8a 00                	mov    (%eax),%al
  801bee:	0f be d8             	movsbl %al,%ebx
  801bf1:	85 db                	test   %ebx,%ebx
  801bf3:	74 24                	je     801c19 <vprintfmt+0x24b>
  801bf5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801bf9:	78 b8                	js     801bb3 <vprintfmt+0x1e5>
  801bfb:	ff 4d e0             	decl   -0x20(%ebp)
  801bfe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c02:	79 af                	jns    801bb3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c04:	eb 13                	jmp    801c19 <vprintfmt+0x24b>
				putch(' ', putdat);
  801c06:	83 ec 08             	sub    $0x8,%esp
  801c09:	ff 75 0c             	pushl  0xc(%ebp)
  801c0c:	6a 20                	push   $0x20
  801c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c11:	ff d0                	call   *%eax
  801c13:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c16:	ff 4d e4             	decl   -0x1c(%ebp)
  801c19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c1d:	7f e7                	jg     801c06 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801c1f:	e9 66 01 00 00       	jmp    801d8a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801c24:	83 ec 08             	sub    $0x8,%esp
  801c27:	ff 75 e8             	pushl  -0x18(%ebp)
  801c2a:	8d 45 14             	lea    0x14(%ebp),%eax
  801c2d:	50                   	push   %eax
  801c2e:	e8 3c fd ff ff       	call   80196f <getint>
  801c33:	83 c4 10             	add    $0x10,%esp
  801c36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c39:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801c3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c42:	85 d2                	test   %edx,%edx
  801c44:	79 23                	jns    801c69 <vprintfmt+0x29b>
				putch('-', putdat);
  801c46:	83 ec 08             	sub    $0x8,%esp
  801c49:	ff 75 0c             	pushl  0xc(%ebp)
  801c4c:	6a 2d                	push   $0x2d
  801c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c51:	ff d0                	call   *%eax
  801c53:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801c56:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c5c:	f7 d8                	neg    %eax
  801c5e:	83 d2 00             	adc    $0x0,%edx
  801c61:	f7 da                	neg    %edx
  801c63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c66:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801c69:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801c70:	e9 bc 00 00 00       	jmp    801d31 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801c75:	83 ec 08             	sub    $0x8,%esp
  801c78:	ff 75 e8             	pushl  -0x18(%ebp)
  801c7b:	8d 45 14             	lea    0x14(%ebp),%eax
  801c7e:	50                   	push   %eax
  801c7f:	e8 84 fc ff ff       	call   801908 <getuint>
  801c84:	83 c4 10             	add    $0x10,%esp
  801c87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c8a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801c8d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801c94:	e9 98 00 00 00       	jmp    801d31 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801c99:	83 ec 08             	sub    $0x8,%esp
  801c9c:	ff 75 0c             	pushl  0xc(%ebp)
  801c9f:	6a 58                	push   $0x58
  801ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca4:	ff d0                	call   *%eax
  801ca6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801ca9:	83 ec 08             	sub    $0x8,%esp
  801cac:	ff 75 0c             	pushl  0xc(%ebp)
  801caf:	6a 58                	push   $0x58
  801cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb4:	ff d0                	call   *%eax
  801cb6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cb9:	83 ec 08             	sub    $0x8,%esp
  801cbc:	ff 75 0c             	pushl  0xc(%ebp)
  801cbf:	6a 58                	push   $0x58
  801cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc4:	ff d0                	call   *%eax
  801cc6:	83 c4 10             	add    $0x10,%esp
			break;
  801cc9:	e9 bc 00 00 00       	jmp    801d8a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801cce:	83 ec 08             	sub    $0x8,%esp
  801cd1:	ff 75 0c             	pushl  0xc(%ebp)
  801cd4:	6a 30                	push   $0x30
  801cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd9:	ff d0                	call   *%eax
  801cdb:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801cde:	83 ec 08             	sub    $0x8,%esp
  801ce1:	ff 75 0c             	pushl  0xc(%ebp)
  801ce4:	6a 78                	push   $0x78
  801ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce9:	ff d0                	call   *%eax
  801ceb:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801cee:	8b 45 14             	mov    0x14(%ebp),%eax
  801cf1:	83 c0 04             	add    $0x4,%eax
  801cf4:	89 45 14             	mov    %eax,0x14(%ebp)
  801cf7:	8b 45 14             	mov    0x14(%ebp),%eax
  801cfa:	83 e8 04             	sub    $0x4,%eax
  801cfd:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801cff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801d09:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801d10:	eb 1f                	jmp    801d31 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801d12:	83 ec 08             	sub    $0x8,%esp
  801d15:	ff 75 e8             	pushl  -0x18(%ebp)
  801d18:	8d 45 14             	lea    0x14(%ebp),%eax
  801d1b:	50                   	push   %eax
  801d1c:	e8 e7 fb ff ff       	call   801908 <getuint>
  801d21:	83 c4 10             	add    $0x10,%esp
  801d24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d27:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801d2a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801d31:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801d35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d38:	83 ec 04             	sub    $0x4,%esp
  801d3b:	52                   	push   %edx
  801d3c:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d3f:	50                   	push   %eax
  801d40:	ff 75 f4             	pushl  -0xc(%ebp)
  801d43:	ff 75 f0             	pushl  -0x10(%ebp)
  801d46:	ff 75 0c             	pushl  0xc(%ebp)
  801d49:	ff 75 08             	pushl  0x8(%ebp)
  801d4c:	e8 00 fb ff ff       	call   801851 <printnum>
  801d51:	83 c4 20             	add    $0x20,%esp
			break;
  801d54:	eb 34                	jmp    801d8a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801d56:	83 ec 08             	sub    $0x8,%esp
  801d59:	ff 75 0c             	pushl  0xc(%ebp)
  801d5c:	53                   	push   %ebx
  801d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d60:	ff d0                	call   *%eax
  801d62:	83 c4 10             	add    $0x10,%esp
			break;
  801d65:	eb 23                	jmp    801d8a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801d67:	83 ec 08             	sub    $0x8,%esp
  801d6a:	ff 75 0c             	pushl  0xc(%ebp)
  801d6d:	6a 25                	push   $0x25
  801d6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d72:	ff d0                	call   *%eax
  801d74:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801d77:	ff 4d 10             	decl   0x10(%ebp)
  801d7a:	eb 03                	jmp    801d7f <vprintfmt+0x3b1>
  801d7c:	ff 4d 10             	decl   0x10(%ebp)
  801d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d82:	48                   	dec    %eax
  801d83:	8a 00                	mov    (%eax),%al
  801d85:	3c 25                	cmp    $0x25,%al
  801d87:	75 f3                	jne    801d7c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801d89:	90                   	nop
		}
	}
  801d8a:	e9 47 fc ff ff       	jmp    8019d6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801d8f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801d90:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d93:	5b                   	pop    %ebx
  801d94:	5e                   	pop    %esi
  801d95:	5d                   	pop    %ebp
  801d96:	c3                   	ret    

00801d97 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
  801d9a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801d9d:	8d 45 10             	lea    0x10(%ebp),%eax
  801da0:	83 c0 04             	add    $0x4,%eax
  801da3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801da6:	8b 45 10             	mov    0x10(%ebp),%eax
  801da9:	ff 75 f4             	pushl  -0xc(%ebp)
  801dac:	50                   	push   %eax
  801dad:	ff 75 0c             	pushl  0xc(%ebp)
  801db0:	ff 75 08             	pushl  0x8(%ebp)
  801db3:	e8 16 fc ff ff       	call   8019ce <vprintfmt>
  801db8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801dbb:	90                   	nop
  801dbc:	c9                   	leave  
  801dbd:	c3                   	ret    

00801dbe <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801dbe:	55                   	push   %ebp
  801dbf:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dc4:	8b 40 08             	mov    0x8(%eax),%eax
  801dc7:	8d 50 01             	lea    0x1(%eax),%edx
  801dca:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dcd:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dd3:	8b 10                	mov    (%eax),%edx
  801dd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dd8:	8b 40 04             	mov    0x4(%eax),%eax
  801ddb:	39 c2                	cmp    %eax,%edx
  801ddd:	73 12                	jae    801df1 <sprintputch+0x33>
		*b->buf++ = ch;
  801ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801de2:	8b 00                	mov    (%eax),%eax
  801de4:	8d 48 01             	lea    0x1(%eax),%ecx
  801de7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dea:	89 0a                	mov    %ecx,(%edx)
  801dec:	8b 55 08             	mov    0x8(%ebp),%edx
  801def:	88 10                	mov    %dl,(%eax)
}
  801df1:	90                   	nop
  801df2:	5d                   	pop    %ebp
  801df3:	c3                   	ret    

00801df4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
  801df7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e00:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e03:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e06:	8b 45 08             	mov    0x8(%ebp),%eax
  801e09:	01 d0                	add    %edx,%eax
  801e0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e0e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801e15:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e19:	74 06                	je     801e21 <vsnprintf+0x2d>
  801e1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e1f:	7f 07                	jg     801e28 <vsnprintf+0x34>
		return -E_INVAL;
  801e21:	b8 03 00 00 00       	mov    $0x3,%eax
  801e26:	eb 20                	jmp    801e48 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801e28:	ff 75 14             	pushl  0x14(%ebp)
  801e2b:	ff 75 10             	pushl  0x10(%ebp)
  801e2e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801e31:	50                   	push   %eax
  801e32:	68 be 1d 80 00       	push   $0x801dbe
  801e37:	e8 92 fb ff ff       	call   8019ce <vprintfmt>
  801e3c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801e3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e42:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801e45:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801e48:	c9                   	leave  
  801e49:	c3                   	ret    

00801e4a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801e4a:	55                   	push   %ebp
  801e4b:	89 e5                	mov    %esp,%ebp
  801e4d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801e50:	8d 45 10             	lea    0x10(%ebp),%eax
  801e53:	83 c0 04             	add    $0x4,%eax
  801e56:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801e59:	8b 45 10             	mov    0x10(%ebp),%eax
  801e5c:	ff 75 f4             	pushl  -0xc(%ebp)
  801e5f:	50                   	push   %eax
  801e60:	ff 75 0c             	pushl  0xc(%ebp)
  801e63:	ff 75 08             	pushl  0x8(%ebp)
  801e66:	e8 89 ff ff ff       	call   801df4 <vsnprintf>
  801e6b:	83 c4 10             	add    $0x10,%esp
  801e6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801e71:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e74:	c9                   	leave  
  801e75:	c3                   	ret    

00801e76 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801e76:	55                   	push   %ebp
  801e77:	89 e5                	mov    %esp,%ebp
  801e79:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801e7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e83:	eb 06                	jmp    801e8b <strlen+0x15>
		n++;
  801e85:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801e88:	ff 45 08             	incl   0x8(%ebp)
  801e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8e:	8a 00                	mov    (%eax),%al
  801e90:	84 c0                	test   %al,%al
  801e92:	75 f1                	jne    801e85 <strlen+0xf>
		n++;
	return n;
  801e94:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
  801e9c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801e9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ea6:	eb 09                	jmp    801eb1 <strnlen+0x18>
		n++;
  801ea8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801eab:	ff 45 08             	incl   0x8(%ebp)
  801eae:	ff 4d 0c             	decl   0xc(%ebp)
  801eb1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801eb5:	74 09                	je     801ec0 <strnlen+0x27>
  801eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eba:	8a 00                	mov    (%eax),%al
  801ebc:	84 c0                	test   %al,%al
  801ebe:	75 e8                	jne    801ea8 <strnlen+0xf>
		n++;
	return n;
  801ec0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ec3:	c9                   	leave  
  801ec4:	c3                   	ret    

00801ec5 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801ec5:	55                   	push   %ebp
  801ec6:	89 e5                	mov    %esp,%ebp
  801ec8:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ece:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801ed1:	90                   	nop
  801ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed5:	8d 50 01             	lea    0x1(%eax),%edx
  801ed8:	89 55 08             	mov    %edx,0x8(%ebp)
  801edb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ede:	8d 4a 01             	lea    0x1(%edx),%ecx
  801ee1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801ee4:	8a 12                	mov    (%edx),%dl
  801ee6:	88 10                	mov    %dl,(%eax)
  801ee8:	8a 00                	mov    (%eax),%al
  801eea:	84 c0                	test   %al,%al
  801eec:	75 e4                	jne    801ed2 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801eee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ef1:	c9                   	leave  
  801ef2:	c3                   	ret    

00801ef3 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801ef3:	55                   	push   %ebp
  801ef4:	89 e5                	mov    %esp,%ebp
  801ef6:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  801efc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801eff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801f06:	eb 1f                	jmp    801f27 <strncpy+0x34>
		*dst++ = *src;
  801f08:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0b:	8d 50 01             	lea    0x1(%eax),%edx
  801f0e:	89 55 08             	mov    %edx,0x8(%ebp)
  801f11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f14:	8a 12                	mov    (%edx),%dl
  801f16:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f1b:	8a 00                	mov    (%eax),%al
  801f1d:	84 c0                	test   %al,%al
  801f1f:	74 03                	je     801f24 <strncpy+0x31>
			src++;
  801f21:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801f24:	ff 45 fc             	incl   -0x4(%ebp)
  801f27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f2a:	3b 45 10             	cmp    0x10(%ebp),%eax
  801f2d:	72 d9                	jb     801f08 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801f2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801f32:	c9                   	leave  
  801f33:	c3                   	ret    

00801f34 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801f34:	55                   	push   %ebp
  801f35:	89 e5                	mov    %esp,%ebp
  801f37:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801f40:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f44:	74 30                	je     801f76 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801f46:	eb 16                	jmp    801f5e <strlcpy+0x2a>
			*dst++ = *src++;
  801f48:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4b:	8d 50 01             	lea    0x1(%eax),%edx
  801f4e:	89 55 08             	mov    %edx,0x8(%ebp)
  801f51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f54:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f57:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f5a:	8a 12                	mov    (%edx),%dl
  801f5c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801f5e:	ff 4d 10             	decl   0x10(%ebp)
  801f61:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f65:	74 09                	je     801f70 <strlcpy+0x3c>
  801f67:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f6a:	8a 00                	mov    (%eax),%al
  801f6c:	84 c0                	test   %al,%al
  801f6e:	75 d8                	jne    801f48 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801f70:	8b 45 08             	mov    0x8(%ebp),%eax
  801f73:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801f76:	8b 55 08             	mov    0x8(%ebp),%edx
  801f79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f7c:	29 c2                	sub    %eax,%edx
  801f7e:	89 d0                	mov    %edx,%eax
}
  801f80:	c9                   	leave  
  801f81:	c3                   	ret    

00801f82 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801f82:	55                   	push   %ebp
  801f83:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801f85:	eb 06                	jmp    801f8d <strcmp+0xb>
		p++, q++;
  801f87:	ff 45 08             	incl   0x8(%ebp)
  801f8a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f90:	8a 00                	mov    (%eax),%al
  801f92:	84 c0                	test   %al,%al
  801f94:	74 0e                	je     801fa4 <strcmp+0x22>
  801f96:	8b 45 08             	mov    0x8(%ebp),%eax
  801f99:	8a 10                	mov    (%eax),%dl
  801f9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f9e:	8a 00                	mov    (%eax),%al
  801fa0:	38 c2                	cmp    %al,%dl
  801fa2:	74 e3                	je     801f87 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa7:	8a 00                	mov    (%eax),%al
  801fa9:	0f b6 d0             	movzbl %al,%edx
  801fac:	8b 45 0c             	mov    0xc(%ebp),%eax
  801faf:	8a 00                	mov    (%eax),%al
  801fb1:	0f b6 c0             	movzbl %al,%eax
  801fb4:	29 c2                	sub    %eax,%edx
  801fb6:	89 d0                	mov    %edx,%eax
}
  801fb8:	5d                   	pop    %ebp
  801fb9:	c3                   	ret    

00801fba <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801fba:	55                   	push   %ebp
  801fbb:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801fbd:	eb 09                	jmp    801fc8 <strncmp+0xe>
		n--, p++, q++;
  801fbf:	ff 4d 10             	decl   0x10(%ebp)
  801fc2:	ff 45 08             	incl   0x8(%ebp)
  801fc5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801fc8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fcc:	74 17                	je     801fe5 <strncmp+0x2b>
  801fce:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd1:	8a 00                	mov    (%eax),%al
  801fd3:	84 c0                	test   %al,%al
  801fd5:	74 0e                	je     801fe5 <strncmp+0x2b>
  801fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fda:	8a 10                	mov    (%eax),%dl
  801fdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fdf:	8a 00                	mov    (%eax),%al
  801fe1:	38 c2                	cmp    %al,%dl
  801fe3:	74 da                	je     801fbf <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801fe5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fe9:	75 07                	jne    801ff2 <strncmp+0x38>
		return 0;
  801feb:	b8 00 00 00 00       	mov    $0x0,%eax
  801ff0:	eb 14                	jmp    802006 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff5:	8a 00                	mov    (%eax),%al
  801ff7:	0f b6 d0             	movzbl %al,%edx
  801ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ffd:	8a 00                	mov    (%eax),%al
  801fff:	0f b6 c0             	movzbl %al,%eax
  802002:	29 c2                	sub    %eax,%edx
  802004:	89 d0                	mov    %edx,%eax
}
  802006:	5d                   	pop    %ebp
  802007:	c3                   	ret    

00802008 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  802008:	55                   	push   %ebp
  802009:	89 e5                	mov    %esp,%ebp
  80200b:	83 ec 04             	sub    $0x4,%esp
  80200e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802011:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802014:	eb 12                	jmp    802028 <strchr+0x20>
		if (*s == c)
  802016:	8b 45 08             	mov    0x8(%ebp),%eax
  802019:	8a 00                	mov    (%eax),%al
  80201b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80201e:	75 05                	jne    802025 <strchr+0x1d>
			return (char *) s;
  802020:	8b 45 08             	mov    0x8(%ebp),%eax
  802023:	eb 11                	jmp    802036 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802025:	ff 45 08             	incl   0x8(%ebp)
  802028:	8b 45 08             	mov    0x8(%ebp),%eax
  80202b:	8a 00                	mov    (%eax),%al
  80202d:	84 c0                	test   %al,%al
  80202f:	75 e5                	jne    802016 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802031:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802036:	c9                   	leave  
  802037:	c3                   	ret    

00802038 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  802038:	55                   	push   %ebp
  802039:	89 e5                	mov    %esp,%ebp
  80203b:	83 ec 04             	sub    $0x4,%esp
  80203e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802041:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802044:	eb 0d                	jmp    802053 <strfind+0x1b>
		if (*s == c)
  802046:	8b 45 08             	mov    0x8(%ebp),%eax
  802049:	8a 00                	mov    (%eax),%al
  80204b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80204e:	74 0e                	je     80205e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  802050:	ff 45 08             	incl   0x8(%ebp)
  802053:	8b 45 08             	mov    0x8(%ebp),%eax
  802056:	8a 00                	mov    (%eax),%al
  802058:	84 c0                	test   %al,%al
  80205a:	75 ea                	jne    802046 <strfind+0xe>
  80205c:	eb 01                	jmp    80205f <strfind+0x27>
		if (*s == c)
			break;
  80205e:	90                   	nop
	return (char *) s;
  80205f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
  802067:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80206a:	8b 45 08             	mov    0x8(%ebp),%eax
  80206d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  802070:	8b 45 10             	mov    0x10(%ebp),%eax
  802073:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  802076:	eb 0e                	jmp    802086 <memset+0x22>
		*p++ = c;
  802078:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80207b:	8d 50 01             	lea    0x1(%eax),%edx
  80207e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802081:	8b 55 0c             	mov    0xc(%ebp),%edx
  802084:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  802086:	ff 4d f8             	decl   -0x8(%ebp)
  802089:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80208d:	79 e9                	jns    802078 <memset+0x14>
		*p++ = c;

	return v;
  80208f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
  802097:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80209a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80209d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8020a6:	eb 16                	jmp    8020be <memcpy+0x2a>
		*d++ = *s++;
  8020a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020ab:	8d 50 01             	lea    0x1(%eax),%edx
  8020ae:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8020b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020b4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8020b7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8020ba:	8a 12                	mov    (%edx),%dl
  8020bc:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8020be:	8b 45 10             	mov    0x10(%ebp),%eax
  8020c1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8020c4:	89 55 10             	mov    %edx,0x10(%ebp)
  8020c7:	85 c0                	test   %eax,%eax
  8020c9:	75 dd                	jne    8020a8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8020cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020ce:	c9                   	leave  
  8020cf:	c3                   	ret    

008020d0 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8020d0:	55                   	push   %ebp
  8020d1:	89 e5                	mov    %esp,%ebp
  8020d3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8020d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020df:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8020e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020e5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8020e8:	73 50                	jae    80213a <memmove+0x6a>
  8020ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8020f0:	01 d0                	add    %edx,%eax
  8020f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8020f5:	76 43                	jbe    80213a <memmove+0x6a>
		s += n;
  8020f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8020fa:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8020fd:	8b 45 10             	mov    0x10(%ebp),%eax
  802100:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802103:	eb 10                	jmp    802115 <memmove+0x45>
			*--d = *--s;
  802105:	ff 4d f8             	decl   -0x8(%ebp)
  802108:	ff 4d fc             	decl   -0x4(%ebp)
  80210b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80210e:	8a 10                	mov    (%eax),%dl
  802110:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802113:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802115:	8b 45 10             	mov    0x10(%ebp),%eax
  802118:	8d 50 ff             	lea    -0x1(%eax),%edx
  80211b:	89 55 10             	mov    %edx,0x10(%ebp)
  80211e:	85 c0                	test   %eax,%eax
  802120:	75 e3                	jne    802105 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802122:	eb 23                	jmp    802147 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802124:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802127:	8d 50 01             	lea    0x1(%eax),%edx
  80212a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80212d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802130:	8d 4a 01             	lea    0x1(%edx),%ecx
  802133:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802136:	8a 12                	mov    (%edx),%dl
  802138:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80213a:	8b 45 10             	mov    0x10(%ebp),%eax
  80213d:	8d 50 ff             	lea    -0x1(%eax),%edx
  802140:	89 55 10             	mov    %edx,0x10(%ebp)
  802143:	85 c0                	test   %eax,%eax
  802145:	75 dd                	jne    802124 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802147:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80214a:	c9                   	leave  
  80214b:	c3                   	ret    

0080214c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80214c:	55                   	push   %ebp
  80214d:	89 e5                	mov    %esp,%ebp
  80214f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802152:	8b 45 08             	mov    0x8(%ebp),%eax
  802155:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80215b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80215e:	eb 2a                	jmp    80218a <memcmp+0x3e>
		if (*s1 != *s2)
  802160:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802163:	8a 10                	mov    (%eax),%dl
  802165:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802168:	8a 00                	mov    (%eax),%al
  80216a:	38 c2                	cmp    %al,%dl
  80216c:	74 16                	je     802184 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80216e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802171:	8a 00                	mov    (%eax),%al
  802173:	0f b6 d0             	movzbl %al,%edx
  802176:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802179:	8a 00                	mov    (%eax),%al
  80217b:	0f b6 c0             	movzbl %al,%eax
  80217e:	29 c2                	sub    %eax,%edx
  802180:	89 d0                	mov    %edx,%eax
  802182:	eb 18                	jmp    80219c <memcmp+0x50>
		s1++, s2++;
  802184:	ff 45 fc             	incl   -0x4(%ebp)
  802187:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80218a:	8b 45 10             	mov    0x10(%ebp),%eax
  80218d:	8d 50 ff             	lea    -0x1(%eax),%edx
  802190:	89 55 10             	mov    %edx,0x10(%ebp)
  802193:	85 c0                	test   %eax,%eax
  802195:	75 c9                	jne    802160 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  802197:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80219c:	c9                   	leave  
  80219d:	c3                   	ret    

0080219e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80219e:	55                   	push   %ebp
  80219f:	89 e5                	mov    %esp,%ebp
  8021a1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8021a4:	8b 55 08             	mov    0x8(%ebp),%edx
  8021a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8021aa:	01 d0                	add    %edx,%eax
  8021ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8021af:	eb 15                	jmp    8021c6 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8021b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b4:	8a 00                	mov    (%eax),%al
  8021b6:	0f b6 d0             	movzbl %al,%edx
  8021b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021bc:	0f b6 c0             	movzbl %al,%eax
  8021bf:	39 c2                	cmp    %eax,%edx
  8021c1:	74 0d                	je     8021d0 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8021c3:	ff 45 08             	incl   0x8(%ebp)
  8021c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8021cc:	72 e3                	jb     8021b1 <memfind+0x13>
  8021ce:	eb 01                	jmp    8021d1 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8021d0:	90                   	nop
	return (void *) s;
  8021d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8021d4:	c9                   	leave  
  8021d5:	c3                   	ret    

008021d6 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8021d6:	55                   	push   %ebp
  8021d7:	89 e5                	mov    %esp,%ebp
  8021d9:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8021dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8021e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8021ea:	eb 03                	jmp    8021ef <strtol+0x19>
		s++;
  8021ec:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8021ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f2:	8a 00                	mov    (%eax),%al
  8021f4:	3c 20                	cmp    $0x20,%al
  8021f6:	74 f4                	je     8021ec <strtol+0x16>
  8021f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fb:	8a 00                	mov    (%eax),%al
  8021fd:	3c 09                	cmp    $0x9,%al
  8021ff:	74 eb                	je     8021ec <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802201:	8b 45 08             	mov    0x8(%ebp),%eax
  802204:	8a 00                	mov    (%eax),%al
  802206:	3c 2b                	cmp    $0x2b,%al
  802208:	75 05                	jne    80220f <strtol+0x39>
		s++;
  80220a:	ff 45 08             	incl   0x8(%ebp)
  80220d:	eb 13                	jmp    802222 <strtol+0x4c>
	else if (*s == '-')
  80220f:	8b 45 08             	mov    0x8(%ebp),%eax
  802212:	8a 00                	mov    (%eax),%al
  802214:	3c 2d                	cmp    $0x2d,%al
  802216:	75 0a                	jne    802222 <strtol+0x4c>
		s++, neg = 1;
  802218:	ff 45 08             	incl   0x8(%ebp)
  80221b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802222:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802226:	74 06                	je     80222e <strtol+0x58>
  802228:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80222c:	75 20                	jne    80224e <strtol+0x78>
  80222e:	8b 45 08             	mov    0x8(%ebp),%eax
  802231:	8a 00                	mov    (%eax),%al
  802233:	3c 30                	cmp    $0x30,%al
  802235:	75 17                	jne    80224e <strtol+0x78>
  802237:	8b 45 08             	mov    0x8(%ebp),%eax
  80223a:	40                   	inc    %eax
  80223b:	8a 00                	mov    (%eax),%al
  80223d:	3c 78                	cmp    $0x78,%al
  80223f:	75 0d                	jne    80224e <strtol+0x78>
		s += 2, base = 16;
  802241:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802245:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80224c:	eb 28                	jmp    802276 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80224e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802252:	75 15                	jne    802269 <strtol+0x93>
  802254:	8b 45 08             	mov    0x8(%ebp),%eax
  802257:	8a 00                	mov    (%eax),%al
  802259:	3c 30                	cmp    $0x30,%al
  80225b:	75 0c                	jne    802269 <strtol+0x93>
		s++, base = 8;
  80225d:	ff 45 08             	incl   0x8(%ebp)
  802260:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802267:	eb 0d                	jmp    802276 <strtol+0xa0>
	else if (base == 0)
  802269:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80226d:	75 07                	jne    802276 <strtol+0xa0>
		base = 10;
  80226f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802276:	8b 45 08             	mov    0x8(%ebp),%eax
  802279:	8a 00                	mov    (%eax),%al
  80227b:	3c 2f                	cmp    $0x2f,%al
  80227d:	7e 19                	jle    802298 <strtol+0xc2>
  80227f:	8b 45 08             	mov    0x8(%ebp),%eax
  802282:	8a 00                	mov    (%eax),%al
  802284:	3c 39                	cmp    $0x39,%al
  802286:	7f 10                	jg     802298 <strtol+0xc2>
			dig = *s - '0';
  802288:	8b 45 08             	mov    0x8(%ebp),%eax
  80228b:	8a 00                	mov    (%eax),%al
  80228d:	0f be c0             	movsbl %al,%eax
  802290:	83 e8 30             	sub    $0x30,%eax
  802293:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802296:	eb 42                	jmp    8022da <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  802298:	8b 45 08             	mov    0x8(%ebp),%eax
  80229b:	8a 00                	mov    (%eax),%al
  80229d:	3c 60                	cmp    $0x60,%al
  80229f:	7e 19                	jle    8022ba <strtol+0xe4>
  8022a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a4:	8a 00                	mov    (%eax),%al
  8022a6:	3c 7a                	cmp    $0x7a,%al
  8022a8:	7f 10                	jg     8022ba <strtol+0xe4>
			dig = *s - 'a' + 10;
  8022aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ad:	8a 00                	mov    (%eax),%al
  8022af:	0f be c0             	movsbl %al,%eax
  8022b2:	83 e8 57             	sub    $0x57,%eax
  8022b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022b8:	eb 20                	jmp    8022da <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8022ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8022bd:	8a 00                	mov    (%eax),%al
  8022bf:	3c 40                	cmp    $0x40,%al
  8022c1:	7e 39                	jle    8022fc <strtol+0x126>
  8022c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c6:	8a 00                	mov    (%eax),%al
  8022c8:	3c 5a                	cmp    $0x5a,%al
  8022ca:	7f 30                	jg     8022fc <strtol+0x126>
			dig = *s - 'A' + 10;
  8022cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8022cf:	8a 00                	mov    (%eax),%al
  8022d1:	0f be c0             	movsbl %al,%eax
  8022d4:	83 e8 37             	sub    $0x37,%eax
  8022d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8022da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022dd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8022e0:	7d 19                	jge    8022fb <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8022e2:	ff 45 08             	incl   0x8(%ebp)
  8022e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022e8:	0f af 45 10          	imul   0x10(%ebp),%eax
  8022ec:	89 c2                	mov    %eax,%edx
  8022ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022f1:	01 d0                	add    %edx,%eax
  8022f3:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8022f6:	e9 7b ff ff ff       	jmp    802276 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8022fb:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8022fc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802300:	74 08                	je     80230a <strtol+0x134>
		*endptr = (char *) s;
  802302:	8b 45 0c             	mov    0xc(%ebp),%eax
  802305:	8b 55 08             	mov    0x8(%ebp),%edx
  802308:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80230a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80230e:	74 07                	je     802317 <strtol+0x141>
  802310:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802313:	f7 d8                	neg    %eax
  802315:	eb 03                	jmp    80231a <strtol+0x144>
  802317:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80231a:	c9                   	leave  
  80231b:	c3                   	ret    

0080231c <ltostr>:

void
ltostr(long value, char *str)
{
  80231c:	55                   	push   %ebp
  80231d:	89 e5                	mov    %esp,%ebp
  80231f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802322:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  802329:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802330:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802334:	79 13                	jns    802349 <ltostr+0x2d>
	{
		neg = 1;
  802336:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80233d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802340:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802343:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802346:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802349:	8b 45 08             	mov    0x8(%ebp),%eax
  80234c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802351:	99                   	cltd   
  802352:	f7 f9                	idiv   %ecx
  802354:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802357:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80235a:	8d 50 01             	lea    0x1(%eax),%edx
  80235d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802360:	89 c2                	mov    %eax,%edx
  802362:	8b 45 0c             	mov    0xc(%ebp),%eax
  802365:	01 d0                	add    %edx,%eax
  802367:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80236a:	83 c2 30             	add    $0x30,%edx
  80236d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80236f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802372:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802377:	f7 e9                	imul   %ecx
  802379:	c1 fa 02             	sar    $0x2,%edx
  80237c:	89 c8                	mov    %ecx,%eax
  80237e:	c1 f8 1f             	sar    $0x1f,%eax
  802381:	29 c2                	sub    %eax,%edx
  802383:	89 d0                	mov    %edx,%eax
  802385:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802388:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80238b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802390:	f7 e9                	imul   %ecx
  802392:	c1 fa 02             	sar    $0x2,%edx
  802395:	89 c8                	mov    %ecx,%eax
  802397:	c1 f8 1f             	sar    $0x1f,%eax
  80239a:	29 c2                	sub    %eax,%edx
  80239c:	89 d0                	mov    %edx,%eax
  80239e:	c1 e0 02             	shl    $0x2,%eax
  8023a1:	01 d0                	add    %edx,%eax
  8023a3:	01 c0                	add    %eax,%eax
  8023a5:	29 c1                	sub    %eax,%ecx
  8023a7:	89 ca                	mov    %ecx,%edx
  8023a9:	85 d2                	test   %edx,%edx
  8023ab:	75 9c                	jne    802349 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8023ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8023b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023b7:	48                   	dec    %eax
  8023b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8023bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8023bf:	74 3d                	je     8023fe <ltostr+0xe2>
		start = 1 ;
  8023c1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8023c8:	eb 34                	jmp    8023fe <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8023ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023d0:	01 d0                	add    %edx,%eax
  8023d2:	8a 00                	mov    (%eax),%al
  8023d4:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8023d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023dd:	01 c2                	add    %eax,%edx
  8023df:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8023e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023e5:	01 c8                	add    %ecx,%eax
  8023e7:	8a 00                	mov    (%eax),%al
  8023e9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8023eb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8023ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023f1:	01 c2                	add    %eax,%edx
  8023f3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8023f6:	88 02                	mov    %al,(%edx)
		start++ ;
  8023f8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8023fb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8023fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802401:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802404:	7c c4                	jl     8023ca <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802406:	8b 55 f8             	mov    -0x8(%ebp),%edx
  802409:	8b 45 0c             	mov    0xc(%ebp),%eax
  80240c:	01 d0                	add    %edx,%eax
  80240e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802411:	90                   	nop
  802412:	c9                   	leave  
  802413:	c3                   	ret    

00802414 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802414:	55                   	push   %ebp
  802415:	89 e5                	mov    %esp,%ebp
  802417:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80241a:	ff 75 08             	pushl  0x8(%ebp)
  80241d:	e8 54 fa ff ff       	call   801e76 <strlen>
  802422:	83 c4 04             	add    $0x4,%esp
  802425:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802428:	ff 75 0c             	pushl  0xc(%ebp)
  80242b:	e8 46 fa ff ff       	call   801e76 <strlen>
  802430:	83 c4 04             	add    $0x4,%esp
  802433:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802436:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80243d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802444:	eb 17                	jmp    80245d <strcconcat+0x49>
		final[s] = str1[s] ;
  802446:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802449:	8b 45 10             	mov    0x10(%ebp),%eax
  80244c:	01 c2                	add    %eax,%edx
  80244e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802451:	8b 45 08             	mov    0x8(%ebp),%eax
  802454:	01 c8                	add    %ecx,%eax
  802456:	8a 00                	mov    (%eax),%al
  802458:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80245a:	ff 45 fc             	incl   -0x4(%ebp)
  80245d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802460:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802463:	7c e1                	jl     802446 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802465:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80246c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  802473:	eb 1f                	jmp    802494 <strcconcat+0x80>
		final[s++] = str2[i] ;
  802475:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802478:	8d 50 01             	lea    0x1(%eax),%edx
  80247b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80247e:	89 c2                	mov    %eax,%edx
  802480:	8b 45 10             	mov    0x10(%ebp),%eax
  802483:	01 c2                	add    %eax,%edx
  802485:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802488:	8b 45 0c             	mov    0xc(%ebp),%eax
  80248b:	01 c8                	add    %ecx,%eax
  80248d:	8a 00                	mov    (%eax),%al
  80248f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  802491:	ff 45 f8             	incl   -0x8(%ebp)
  802494:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802497:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80249a:	7c d9                	jl     802475 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80249c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80249f:	8b 45 10             	mov    0x10(%ebp),%eax
  8024a2:	01 d0                	add    %edx,%eax
  8024a4:	c6 00 00             	movb   $0x0,(%eax)
}
  8024a7:	90                   	nop
  8024a8:	c9                   	leave  
  8024a9:	c3                   	ret    

008024aa <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8024aa:	55                   	push   %ebp
  8024ab:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8024ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8024b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8024b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8024b9:	8b 00                	mov    (%eax),%eax
  8024bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8024c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8024c5:	01 d0                	add    %edx,%eax
  8024c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8024cd:	eb 0c                	jmp    8024db <strsplit+0x31>
			*string++ = 0;
  8024cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d2:	8d 50 01             	lea    0x1(%eax),%edx
  8024d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8024d8:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8024db:	8b 45 08             	mov    0x8(%ebp),%eax
  8024de:	8a 00                	mov    (%eax),%al
  8024e0:	84 c0                	test   %al,%al
  8024e2:	74 18                	je     8024fc <strsplit+0x52>
  8024e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024e7:	8a 00                	mov    (%eax),%al
  8024e9:	0f be c0             	movsbl %al,%eax
  8024ec:	50                   	push   %eax
  8024ed:	ff 75 0c             	pushl  0xc(%ebp)
  8024f0:	e8 13 fb ff ff       	call   802008 <strchr>
  8024f5:	83 c4 08             	add    $0x8,%esp
  8024f8:	85 c0                	test   %eax,%eax
  8024fa:	75 d3                	jne    8024cf <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8024fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ff:	8a 00                	mov    (%eax),%al
  802501:	84 c0                	test   %al,%al
  802503:	74 5a                	je     80255f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802505:	8b 45 14             	mov    0x14(%ebp),%eax
  802508:	8b 00                	mov    (%eax),%eax
  80250a:	83 f8 0f             	cmp    $0xf,%eax
  80250d:	75 07                	jne    802516 <strsplit+0x6c>
		{
			return 0;
  80250f:	b8 00 00 00 00       	mov    $0x0,%eax
  802514:	eb 66                	jmp    80257c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802516:	8b 45 14             	mov    0x14(%ebp),%eax
  802519:	8b 00                	mov    (%eax),%eax
  80251b:	8d 48 01             	lea    0x1(%eax),%ecx
  80251e:	8b 55 14             	mov    0x14(%ebp),%edx
  802521:	89 0a                	mov    %ecx,(%edx)
  802523:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80252a:	8b 45 10             	mov    0x10(%ebp),%eax
  80252d:	01 c2                	add    %eax,%edx
  80252f:	8b 45 08             	mov    0x8(%ebp),%eax
  802532:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802534:	eb 03                	jmp    802539 <strsplit+0x8f>
			string++;
  802536:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  802539:	8b 45 08             	mov    0x8(%ebp),%eax
  80253c:	8a 00                	mov    (%eax),%al
  80253e:	84 c0                	test   %al,%al
  802540:	74 8b                	je     8024cd <strsplit+0x23>
  802542:	8b 45 08             	mov    0x8(%ebp),%eax
  802545:	8a 00                	mov    (%eax),%al
  802547:	0f be c0             	movsbl %al,%eax
  80254a:	50                   	push   %eax
  80254b:	ff 75 0c             	pushl  0xc(%ebp)
  80254e:	e8 b5 fa ff ff       	call   802008 <strchr>
  802553:	83 c4 08             	add    $0x8,%esp
  802556:	85 c0                	test   %eax,%eax
  802558:	74 dc                	je     802536 <strsplit+0x8c>
			string++;
	}
  80255a:	e9 6e ff ff ff       	jmp    8024cd <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80255f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  802560:	8b 45 14             	mov    0x14(%ebp),%eax
  802563:	8b 00                	mov    (%eax),%eax
  802565:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80256c:	8b 45 10             	mov    0x10(%ebp),%eax
  80256f:	01 d0                	add    %edx,%eax
  802571:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802577:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80257c:	c9                   	leave  
  80257d:	c3                   	ret    

0080257e <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80257e:	55                   	push   %ebp
  80257f:	89 e5                	mov    %esp,%ebp
  802581:	83 ec 18             	sub    $0x18,%esp
  802584:	8b 45 10             	mov    0x10(%ebp),%eax
  802587:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80258a:	83 ec 04             	sub    $0x4,%esp
  80258d:	68 50 38 80 00       	push   $0x803850
  802592:	6a 17                	push   $0x17
  802594:	68 6f 38 80 00       	push   $0x80386f
  802599:	e8 a2 ef ff ff       	call   801540 <_panic>

0080259e <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80259e:	55                   	push   %ebp
  80259f:	89 e5                	mov    %esp,%ebp
  8025a1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8025a4:	83 ec 04             	sub    $0x4,%esp
  8025a7:	68 7b 38 80 00       	push   $0x80387b
  8025ac:	6a 2f                	push   $0x2f
  8025ae:	68 6f 38 80 00       	push   $0x80386f
  8025b3:	e8 88 ef ff ff       	call   801540 <_panic>

008025b8 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8025b8:	55                   	push   %ebp
  8025b9:	89 e5                	mov    %esp,%ebp
  8025bb:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8025be:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8025c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8025c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8025cb:	01 d0                	add    %edx,%eax
  8025cd:	48                   	dec    %eax
  8025ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8025d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8025d4:	ba 00 00 00 00       	mov    $0x0,%edx
  8025d9:	f7 75 ec             	divl   -0x14(%ebp)
  8025dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8025df:	29 d0                	sub    %edx,%eax
  8025e1:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8025e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8025e7:	c1 e8 0c             	shr    $0xc,%eax
  8025ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8025ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8025f4:	e9 c8 00 00 00       	jmp    8026c1 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8025f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802600:	eb 27                	jmp    802629 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  802602:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802605:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802608:	01 c2                	add    %eax,%edx
  80260a:	89 d0                	mov    %edx,%eax
  80260c:	01 c0                	add    %eax,%eax
  80260e:	01 d0                	add    %edx,%eax
  802610:	c1 e0 02             	shl    $0x2,%eax
  802613:	05 48 40 80 00       	add    $0x804048,%eax
  802618:	8b 00                	mov    (%eax),%eax
  80261a:	85 c0                	test   %eax,%eax
  80261c:	74 08                	je     802626 <malloc+0x6e>
            	i += j;
  80261e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802621:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  802624:	eb 0b                	jmp    802631 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  802626:	ff 45 f0             	incl   -0x10(%ebp)
  802629:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80262c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80262f:	72 d1                	jb     802602 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  802631:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802634:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802637:	0f 85 81 00 00 00    	jne    8026be <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80263d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802640:	05 00 00 08 00       	add    $0x80000,%eax
  802645:	c1 e0 0c             	shl    $0xc,%eax
  802648:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80264b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802652:	eb 1f                	jmp    802673 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  802654:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802657:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80265a:	01 c2                	add    %eax,%edx
  80265c:	89 d0                	mov    %edx,%eax
  80265e:	01 c0                	add    %eax,%eax
  802660:	01 d0                	add    %edx,%eax
  802662:	c1 e0 02             	shl    $0x2,%eax
  802665:	05 48 40 80 00       	add    $0x804048,%eax
  80266a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  802670:	ff 45 f0             	incl   -0x10(%ebp)
  802673:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802676:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802679:	72 d9                	jb     802654 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80267b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80267e:	89 d0                	mov    %edx,%eax
  802680:	01 c0                	add    %eax,%eax
  802682:	01 d0                	add    %edx,%eax
  802684:	c1 e0 02             	shl    $0x2,%eax
  802687:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  80268d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802690:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  802692:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802695:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  802698:	89 c8                	mov    %ecx,%eax
  80269a:	01 c0                	add    %eax,%eax
  80269c:	01 c8                	add    %ecx,%eax
  80269e:	c1 e0 02             	shl    $0x2,%eax
  8026a1:	05 44 40 80 00       	add    $0x804044,%eax
  8026a6:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8026a8:	83 ec 08             	sub    $0x8,%esp
  8026ab:	ff 75 08             	pushl  0x8(%ebp)
  8026ae:	ff 75 e0             	pushl  -0x20(%ebp)
  8026b1:	e8 2b 03 00 00       	call   8029e1 <sys_allocateMem>
  8026b6:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8026b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8026bc:	eb 19                	jmp    8026d7 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8026be:	ff 45 f4             	incl   -0xc(%ebp)
  8026c1:	a1 04 40 80 00       	mov    0x804004,%eax
  8026c6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8026c9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8026cc:	0f 83 27 ff ff ff    	jae    8025f9 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8026d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026d7:	c9                   	leave  
  8026d8:	c3                   	ret    

008026d9 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8026d9:	55                   	push   %ebp
  8026da:	89 e5                	mov    %esp,%ebp
  8026dc:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8026df:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8026e3:	0f 84 e5 00 00 00    	je     8027ce <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8026e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8026ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8026f2:	05 00 00 00 80       	add    $0x80000000,%eax
  8026f7:	c1 e8 0c             	shr    $0xc,%eax
  8026fa:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8026fd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802700:	89 d0                	mov    %edx,%eax
  802702:	01 c0                	add    %eax,%eax
  802704:	01 d0                	add    %edx,%eax
  802706:	c1 e0 02             	shl    $0x2,%eax
  802709:	05 40 40 80 00       	add    $0x804040,%eax
  80270e:	8b 00                	mov    (%eax),%eax
  802710:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802713:	0f 85 b8 00 00 00    	jne    8027d1 <free+0xf8>
  802719:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80271c:	89 d0                	mov    %edx,%eax
  80271e:	01 c0                	add    %eax,%eax
  802720:	01 d0                	add    %edx,%eax
  802722:	c1 e0 02             	shl    $0x2,%eax
  802725:	05 48 40 80 00       	add    $0x804048,%eax
  80272a:	8b 00                	mov    (%eax),%eax
  80272c:	85 c0                	test   %eax,%eax
  80272e:	0f 84 9d 00 00 00    	je     8027d1 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  802734:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802737:	89 d0                	mov    %edx,%eax
  802739:	01 c0                	add    %eax,%eax
  80273b:	01 d0                	add    %edx,%eax
  80273d:	c1 e0 02             	shl    $0x2,%eax
  802740:	05 44 40 80 00       	add    $0x804044,%eax
  802745:	8b 00                	mov    (%eax),%eax
  802747:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80274a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80274d:	c1 e0 0c             	shl    $0xc,%eax
  802750:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  802753:	83 ec 08             	sub    $0x8,%esp
  802756:	ff 75 e4             	pushl  -0x1c(%ebp)
  802759:	ff 75 f0             	pushl  -0x10(%ebp)
  80275c:	e8 64 02 00 00       	call   8029c5 <sys_freeMem>
  802761:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802764:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80276b:	eb 57                	jmp    8027c4 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80276d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802770:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802773:	01 c2                	add    %eax,%edx
  802775:	89 d0                	mov    %edx,%eax
  802777:	01 c0                	add    %eax,%eax
  802779:	01 d0                	add    %edx,%eax
  80277b:	c1 e0 02             	shl    $0x2,%eax
  80277e:	05 48 40 80 00       	add    $0x804048,%eax
  802783:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  802789:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80278c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80278f:	01 c2                	add    %eax,%edx
  802791:	89 d0                	mov    %edx,%eax
  802793:	01 c0                	add    %eax,%eax
  802795:	01 d0                	add    %edx,%eax
  802797:	c1 e0 02             	shl    $0x2,%eax
  80279a:	05 40 40 80 00       	add    $0x804040,%eax
  80279f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8027a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8027a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027ab:	01 c2                	add    %eax,%edx
  8027ad:	89 d0                	mov    %edx,%eax
  8027af:	01 c0                	add    %eax,%eax
  8027b1:	01 d0                	add    %edx,%eax
  8027b3:	c1 e0 02             	shl    $0x2,%eax
  8027b6:	05 44 40 80 00       	add    $0x804044,%eax
  8027bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8027c1:	ff 45 f4             	incl   -0xc(%ebp)
  8027c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027c7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8027ca:	7c a1                	jl     80276d <free+0x94>
  8027cc:	eb 04                	jmp    8027d2 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8027ce:	90                   	nop
  8027cf:	eb 01                	jmp    8027d2 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8027d1:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8027d2:	c9                   	leave  
  8027d3:	c3                   	ret    

008027d4 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8027d4:	55                   	push   %ebp
  8027d5:	89 e5                	mov    %esp,%ebp
  8027d7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8027da:	83 ec 04             	sub    $0x4,%esp
  8027dd:	68 98 38 80 00       	push   $0x803898
  8027e2:	68 ae 00 00 00       	push   $0xae
  8027e7:	68 6f 38 80 00       	push   $0x80386f
  8027ec:	e8 4f ed ff ff       	call   801540 <_panic>

008027f1 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8027f1:	55                   	push   %ebp
  8027f2:	89 e5                	mov    %esp,%ebp
  8027f4:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8027f7:	83 ec 04             	sub    $0x4,%esp
  8027fa:	68 b8 38 80 00       	push   $0x8038b8
  8027ff:	68 ca 00 00 00       	push   $0xca
  802804:	68 6f 38 80 00       	push   $0x80386f
  802809:	e8 32 ed ff ff       	call   801540 <_panic>

0080280e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80280e:	55                   	push   %ebp
  80280f:	89 e5                	mov    %esp,%ebp
  802811:	57                   	push   %edi
  802812:	56                   	push   %esi
  802813:	53                   	push   %ebx
  802814:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802817:	8b 45 08             	mov    0x8(%ebp),%eax
  80281a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80281d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802820:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802823:	8b 7d 18             	mov    0x18(%ebp),%edi
  802826:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802829:	cd 30                	int    $0x30
  80282b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80282e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802831:	83 c4 10             	add    $0x10,%esp
  802834:	5b                   	pop    %ebx
  802835:	5e                   	pop    %esi
  802836:	5f                   	pop    %edi
  802837:	5d                   	pop    %ebp
  802838:	c3                   	ret    

00802839 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802839:	55                   	push   %ebp
  80283a:	89 e5                	mov    %esp,%ebp
  80283c:	83 ec 04             	sub    $0x4,%esp
  80283f:	8b 45 10             	mov    0x10(%ebp),%eax
  802842:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802845:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802849:	8b 45 08             	mov    0x8(%ebp),%eax
  80284c:	6a 00                	push   $0x0
  80284e:	6a 00                	push   $0x0
  802850:	52                   	push   %edx
  802851:	ff 75 0c             	pushl  0xc(%ebp)
  802854:	50                   	push   %eax
  802855:	6a 00                	push   $0x0
  802857:	e8 b2 ff ff ff       	call   80280e <syscall>
  80285c:	83 c4 18             	add    $0x18,%esp
}
  80285f:	90                   	nop
  802860:	c9                   	leave  
  802861:	c3                   	ret    

00802862 <sys_cgetc>:

int
sys_cgetc(void)
{
  802862:	55                   	push   %ebp
  802863:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802865:	6a 00                	push   $0x0
  802867:	6a 00                	push   $0x0
  802869:	6a 00                	push   $0x0
  80286b:	6a 00                	push   $0x0
  80286d:	6a 00                	push   $0x0
  80286f:	6a 01                	push   $0x1
  802871:	e8 98 ff ff ff       	call   80280e <syscall>
  802876:	83 c4 18             	add    $0x18,%esp
}
  802879:	c9                   	leave  
  80287a:	c3                   	ret    

0080287b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80287b:	55                   	push   %ebp
  80287c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80287e:	8b 45 08             	mov    0x8(%ebp),%eax
  802881:	6a 00                	push   $0x0
  802883:	6a 00                	push   $0x0
  802885:	6a 00                	push   $0x0
  802887:	6a 00                	push   $0x0
  802889:	50                   	push   %eax
  80288a:	6a 05                	push   $0x5
  80288c:	e8 7d ff ff ff       	call   80280e <syscall>
  802891:	83 c4 18             	add    $0x18,%esp
}
  802894:	c9                   	leave  
  802895:	c3                   	ret    

00802896 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802896:	55                   	push   %ebp
  802897:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802899:	6a 00                	push   $0x0
  80289b:	6a 00                	push   $0x0
  80289d:	6a 00                	push   $0x0
  80289f:	6a 00                	push   $0x0
  8028a1:	6a 00                	push   $0x0
  8028a3:	6a 02                	push   $0x2
  8028a5:	e8 64 ff ff ff       	call   80280e <syscall>
  8028aa:	83 c4 18             	add    $0x18,%esp
}
  8028ad:	c9                   	leave  
  8028ae:	c3                   	ret    

008028af <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8028af:	55                   	push   %ebp
  8028b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8028b2:	6a 00                	push   $0x0
  8028b4:	6a 00                	push   $0x0
  8028b6:	6a 00                	push   $0x0
  8028b8:	6a 00                	push   $0x0
  8028ba:	6a 00                	push   $0x0
  8028bc:	6a 03                	push   $0x3
  8028be:	e8 4b ff ff ff       	call   80280e <syscall>
  8028c3:	83 c4 18             	add    $0x18,%esp
}
  8028c6:	c9                   	leave  
  8028c7:	c3                   	ret    

008028c8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8028c8:	55                   	push   %ebp
  8028c9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8028cb:	6a 00                	push   $0x0
  8028cd:	6a 00                	push   $0x0
  8028cf:	6a 00                	push   $0x0
  8028d1:	6a 00                	push   $0x0
  8028d3:	6a 00                	push   $0x0
  8028d5:	6a 04                	push   $0x4
  8028d7:	e8 32 ff ff ff       	call   80280e <syscall>
  8028dc:	83 c4 18             	add    $0x18,%esp
}
  8028df:	c9                   	leave  
  8028e0:	c3                   	ret    

008028e1 <sys_env_exit>:


void sys_env_exit(void)
{
  8028e1:	55                   	push   %ebp
  8028e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8028e4:	6a 00                	push   $0x0
  8028e6:	6a 00                	push   $0x0
  8028e8:	6a 00                	push   $0x0
  8028ea:	6a 00                	push   $0x0
  8028ec:	6a 00                	push   $0x0
  8028ee:	6a 06                	push   $0x6
  8028f0:	e8 19 ff ff ff       	call   80280e <syscall>
  8028f5:	83 c4 18             	add    $0x18,%esp
}
  8028f8:	90                   	nop
  8028f9:	c9                   	leave  
  8028fa:	c3                   	ret    

008028fb <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8028fb:	55                   	push   %ebp
  8028fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8028fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  802901:	8b 45 08             	mov    0x8(%ebp),%eax
  802904:	6a 00                	push   $0x0
  802906:	6a 00                	push   $0x0
  802908:	6a 00                	push   $0x0
  80290a:	52                   	push   %edx
  80290b:	50                   	push   %eax
  80290c:	6a 07                	push   $0x7
  80290e:	e8 fb fe ff ff       	call   80280e <syscall>
  802913:	83 c4 18             	add    $0x18,%esp
}
  802916:	c9                   	leave  
  802917:	c3                   	ret    

00802918 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802918:	55                   	push   %ebp
  802919:	89 e5                	mov    %esp,%ebp
  80291b:	56                   	push   %esi
  80291c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80291d:	8b 75 18             	mov    0x18(%ebp),%esi
  802920:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802923:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802926:	8b 55 0c             	mov    0xc(%ebp),%edx
  802929:	8b 45 08             	mov    0x8(%ebp),%eax
  80292c:	56                   	push   %esi
  80292d:	53                   	push   %ebx
  80292e:	51                   	push   %ecx
  80292f:	52                   	push   %edx
  802930:	50                   	push   %eax
  802931:	6a 08                	push   $0x8
  802933:	e8 d6 fe ff ff       	call   80280e <syscall>
  802938:	83 c4 18             	add    $0x18,%esp
}
  80293b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80293e:	5b                   	pop    %ebx
  80293f:	5e                   	pop    %esi
  802940:	5d                   	pop    %ebp
  802941:	c3                   	ret    

00802942 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802942:	55                   	push   %ebp
  802943:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802945:	8b 55 0c             	mov    0xc(%ebp),%edx
  802948:	8b 45 08             	mov    0x8(%ebp),%eax
  80294b:	6a 00                	push   $0x0
  80294d:	6a 00                	push   $0x0
  80294f:	6a 00                	push   $0x0
  802951:	52                   	push   %edx
  802952:	50                   	push   %eax
  802953:	6a 09                	push   $0x9
  802955:	e8 b4 fe ff ff       	call   80280e <syscall>
  80295a:	83 c4 18             	add    $0x18,%esp
}
  80295d:	c9                   	leave  
  80295e:	c3                   	ret    

0080295f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80295f:	55                   	push   %ebp
  802960:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802962:	6a 00                	push   $0x0
  802964:	6a 00                	push   $0x0
  802966:	6a 00                	push   $0x0
  802968:	ff 75 0c             	pushl  0xc(%ebp)
  80296b:	ff 75 08             	pushl  0x8(%ebp)
  80296e:	6a 0a                	push   $0xa
  802970:	e8 99 fe ff ff       	call   80280e <syscall>
  802975:	83 c4 18             	add    $0x18,%esp
}
  802978:	c9                   	leave  
  802979:	c3                   	ret    

0080297a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80297a:	55                   	push   %ebp
  80297b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80297d:	6a 00                	push   $0x0
  80297f:	6a 00                	push   $0x0
  802981:	6a 00                	push   $0x0
  802983:	6a 00                	push   $0x0
  802985:	6a 00                	push   $0x0
  802987:	6a 0b                	push   $0xb
  802989:	e8 80 fe ff ff       	call   80280e <syscall>
  80298e:	83 c4 18             	add    $0x18,%esp
}
  802991:	c9                   	leave  
  802992:	c3                   	ret    

00802993 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802993:	55                   	push   %ebp
  802994:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802996:	6a 00                	push   $0x0
  802998:	6a 00                	push   $0x0
  80299a:	6a 00                	push   $0x0
  80299c:	6a 00                	push   $0x0
  80299e:	6a 00                	push   $0x0
  8029a0:	6a 0c                	push   $0xc
  8029a2:	e8 67 fe ff ff       	call   80280e <syscall>
  8029a7:	83 c4 18             	add    $0x18,%esp
}
  8029aa:	c9                   	leave  
  8029ab:	c3                   	ret    

008029ac <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8029ac:	55                   	push   %ebp
  8029ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8029af:	6a 00                	push   $0x0
  8029b1:	6a 00                	push   $0x0
  8029b3:	6a 00                	push   $0x0
  8029b5:	6a 00                	push   $0x0
  8029b7:	6a 00                	push   $0x0
  8029b9:	6a 0d                	push   $0xd
  8029bb:	e8 4e fe ff ff       	call   80280e <syscall>
  8029c0:	83 c4 18             	add    $0x18,%esp
}
  8029c3:	c9                   	leave  
  8029c4:	c3                   	ret    

008029c5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8029c5:	55                   	push   %ebp
  8029c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8029c8:	6a 00                	push   $0x0
  8029ca:	6a 00                	push   $0x0
  8029cc:	6a 00                	push   $0x0
  8029ce:	ff 75 0c             	pushl  0xc(%ebp)
  8029d1:	ff 75 08             	pushl  0x8(%ebp)
  8029d4:	6a 11                	push   $0x11
  8029d6:	e8 33 fe ff ff       	call   80280e <syscall>
  8029db:	83 c4 18             	add    $0x18,%esp
	return;
  8029de:	90                   	nop
}
  8029df:	c9                   	leave  
  8029e0:	c3                   	ret    

008029e1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8029e1:	55                   	push   %ebp
  8029e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8029e4:	6a 00                	push   $0x0
  8029e6:	6a 00                	push   $0x0
  8029e8:	6a 00                	push   $0x0
  8029ea:	ff 75 0c             	pushl  0xc(%ebp)
  8029ed:	ff 75 08             	pushl  0x8(%ebp)
  8029f0:	6a 12                	push   $0x12
  8029f2:	e8 17 fe ff ff       	call   80280e <syscall>
  8029f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8029fa:	90                   	nop
}
  8029fb:	c9                   	leave  
  8029fc:	c3                   	ret    

008029fd <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8029fd:	55                   	push   %ebp
  8029fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802a00:	6a 00                	push   $0x0
  802a02:	6a 00                	push   $0x0
  802a04:	6a 00                	push   $0x0
  802a06:	6a 00                	push   $0x0
  802a08:	6a 00                	push   $0x0
  802a0a:	6a 0e                	push   $0xe
  802a0c:	e8 fd fd ff ff       	call   80280e <syscall>
  802a11:	83 c4 18             	add    $0x18,%esp
}
  802a14:	c9                   	leave  
  802a15:	c3                   	ret    

00802a16 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802a16:	55                   	push   %ebp
  802a17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802a19:	6a 00                	push   $0x0
  802a1b:	6a 00                	push   $0x0
  802a1d:	6a 00                	push   $0x0
  802a1f:	6a 00                	push   $0x0
  802a21:	ff 75 08             	pushl  0x8(%ebp)
  802a24:	6a 0f                	push   $0xf
  802a26:	e8 e3 fd ff ff       	call   80280e <syscall>
  802a2b:	83 c4 18             	add    $0x18,%esp
}
  802a2e:	c9                   	leave  
  802a2f:	c3                   	ret    

00802a30 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802a30:	55                   	push   %ebp
  802a31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802a33:	6a 00                	push   $0x0
  802a35:	6a 00                	push   $0x0
  802a37:	6a 00                	push   $0x0
  802a39:	6a 00                	push   $0x0
  802a3b:	6a 00                	push   $0x0
  802a3d:	6a 10                	push   $0x10
  802a3f:	e8 ca fd ff ff       	call   80280e <syscall>
  802a44:	83 c4 18             	add    $0x18,%esp
}
  802a47:	90                   	nop
  802a48:	c9                   	leave  
  802a49:	c3                   	ret    

00802a4a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802a4a:	55                   	push   %ebp
  802a4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802a4d:	6a 00                	push   $0x0
  802a4f:	6a 00                	push   $0x0
  802a51:	6a 00                	push   $0x0
  802a53:	6a 00                	push   $0x0
  802a55:	6a 00                	push   $0x0
  802a57:	6a 14                	push   $0x14
  802a59:	e8 b0 fd ff ff       	call   80280e <syscall>
  802a5e:	83 c4 18             	add    $0x18,%esp
}
  802a61:	90                   	nop
  802a62:	c9                   	leave  
  802a63:	c3                   	ret    

00802a64 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802a64:	55                   	push   %ebp
  802a65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802a67:	6a 00                	push   $0x0
  802a69:	6a 00                	push   $0x0
  802a6b:	6a 00                	push   $0x0
  802a6d:	6a 00                	push   $0x0
  802a6f:	6a 00                	push   $0x0
  802a71:	6a 15                	push   $0x15
  802a73:	e8 96 fd ff ff       	call   80280e <syscall>
  802a78:	83 c4 18             	add    $0x18,%esp
}
  802a7b:	90                   	nop
  802a7c:	c9                   	leave  
  802a7d:	c3                   	ret    

00802a7e <sys_cputc>:


void
sys_cputc(const char c)
{
  802a7e:	55                   	push   %ebp
  802a7f:	89 e5                	mov    %esp,%ebp
  802a81:	83 ec 04             	sub    $0x4,%esp
  802a84:	8b 45 08             	mov    0x8(%ebp),%eax
  802a87:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802a8a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802a8e:	6a 00                	push   $0x0
  802a90:	6a 00                	push   $0x0
  802a92:	6a 00                	push   $0x0
  802a94:	6a 00                	push   $0x0
  802a96:	50                   	push   %eax
  802a97:	6a 16                	push   $0x16
  802a99:	e8 70 fd ff ff       	call   80280e <syscall>
  802a9e:	83 c4 18             	add    $0x18,%esp
}
  802aa1:	90                   	nop
  802aa2:	c9                   	leave  
  802aa3:	c3                   	ret    

00802aa4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802aa4:	55                   	push   %ebp
  802aa5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802aa7:	6a 00                	push   $0x0
  802aa9:	6a 00                	push   $0x0
  802aab:	6a 00                	push   $0x0
  802aad:	6a 00                	push   $0x0
  802aaf:	6a 00                	push   $0x0
  802ab1:	6a 17                	push   $0x17
  802ab3:	e8 56 fd ff ff       	call   80280e <syscall>
  802ab8:	83 c4 18             	add    $0x18,%esp
}
  802abb:	90                   	nop
  802abc:	c9                   	leave  
  802abd:	c3                   	ret    

00802abe <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802abe:	55                   	push   %ebp
  802abf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  802ac4:	6a 00                	push   $0x0
  802ac6:	6a 00                	push   $0x0
  802ac8:	6a 00                	push   $0x0
  802aca:	ff 75 0c             	pushl  0xc(%ebp)
  802acd:	50                   	push   %eax
  802ace:	6a 18                	push   $0x18
  802ad0:	e8 39 fd ff ff       	call   80280e <syscall>
  802ad5:	83 c4 18             	add    $0x18,%esp
}
  802ad8:	c9                   	leave  
  802ad9:	c3                   	ret    

00802ada <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802ada:	55                   	push   %ebp
  802adb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802add:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  802ae3:	6a 00                	push   $0x0
  802ae5:	6a 00                	push   $0x0
  802ae7:	6a 00                	push   $0x0
  802ae9:	52                   	push   %edx
  802aea:	50                   	push   %eax
  802aeb:	6a 1b                	push   $0x1b
  802aed:	e8 1c fd ff ff       	call   80280e <syscall>
  802af2:	83 c4 18             	add    $0x18,%esp
}
  802af5:	c9                   	leave  
  802af6:	c3                   	ret    

00802af7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802af7:	55                   	push   %ebp
  802af8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802afa:	8b 55 0c             	mov    0xc(%ebp),%edx
  802afd:	8b 45 08             	mov    0x8(%ebp),%eax
  802b00:	6a 00                	push   $0x0
  802b02:	6a 00                	push   $0x0
  802b04:	6a 00                	push   $0x0
  802b06:	52                   	push   %edx
  802b07:	50                   	push   %eax
  802b08:	6a 19                	push   $0x19
  802b0a:	e8 ff fc ff ff       	call   80280e <syscall>
  802b0f:	83 c4 18             	add    $0x18,%esp
}
  802b12:	90                   	nop
  802b13:	c9                   	leave  
  802b14:	c3                   	ret    

00802b15 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802b15:	55                   	push   %ebp
  802b16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802b18:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  802b1e:	6a 00                	push   $0x0
  802b20:	6a 00                	push   $0x0
  802b22:	6a 00                	push   $0x0
  802b24:	52                   	push   %edx
  802b25:	50                   	push   %eax
  802b26:	6a 1a                	push   $0x1a
  802b28:	e8 e1 fc ff ff       	call   80280e <syscall>
  802b2d:	83 c4 18             	add    $0x18,%esp
}
  802b30:	90                   	nop
  802b31:	c9                   	leave  
  802b32:	c3                   	ret    

00802b33 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802b33:	55                   	push   %ebp
  802b34:	89 e5                	mov    %esp,%ebp
  802b36:	83 ec 04             	sub    $0x4,%esp
  802b39:	8b 45 10             	mov    0x10(%ebp),%eax
  802b3c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802b3f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802b42:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802b46:	8b 45 08             	mov    0x8(%ebp),%eax
  802b49:	6a 00                	push   $0x0
  802b4b:	51                   	push   %ecx
  802b4c:	52                   	push   %edx
  802b4d:	ff 75 0c             	pushl  0xc(%ebp)
  802b50:	50                   	push   %eax
  802b51:	6a 1c                	push   $0x1c
  802b53:	e8 b6 fc ff ff       	call   80280e <syscall>
  802b58:	83 c4 18             	add    $0x18,%esp
}
  802b5b:	c9                   	leave  
  802b5c:	c3                   	ret    

00802b5d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802b5d:	55                   	push   %ebp
  802b5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802b60:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b63:	8b 45 08             	mov    0x8(%ebp),%eax
  802b66:	6a 00                	push   $0x0
  802b68:	6a 00                	push   $0x0
  802b6a:	6a 00                	push   $0x0
  802b6c:	52                   	push   %edx
  802b6d:	50                   	push   %eax
  802b6e:	6a 1d                	push   $0x1d
  802b70:	e8 99 fc ff ff       	call   80280e <syscall>
  802b75:	83 c4 18             	add    $0x18,%esp
}
  802b78:	c9                   	leave  
  802b79:	c3                   	ret    

00802b7a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802b7a:	55                   	push   %ebp
  802b7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802b7d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802b80:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b83:	8b 45 08             	mov    0x8(%ebp),%eax
  802b86:	6a 00                	push   $0x0
  802b88:	6a 00                	push   $0x0
  802b8a:	51                   	push   %ecx
  802b8b:	52                   	push   %edx
  802b8c:	50                   	push   %eax
  802b8d:	6a 1e                	push   $0x1e
  802b8f:	e8 7a fc ff ff       	call   80280e <syscall>
  802b94:	83 c4 18             	add    $0x18,%esp
}
  802b97:	c9                   	leave  
  802b98:	c3                   	ret    

00802b99 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802b99:	55                   	push   %ebp
  802b9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802b9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  802ba2:	6a 00                	push   $0x0
  802ba4:	6a 00                	push   $0x0
  802ba6:	6a 00                	push   $0x0
  802ba8:	52                   	push   %edx
  802ba9:	50                   	push   %eax
  802baa:	6a 1f                	push   $0x1f
  802bac:	e8 5d fc ff ff       	call   80280e <syscall>
  802bb1:	83 c4 18             	add    $0x18,%esp
}
  802bb4:	c9                   	leave  
  802bb5:	c3                   	ret    

00802bb6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802bb6:	55                   	push   %ebp
  802bb7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802bb9:	6a 00                	push   $0x0
  802bbb:	6a 00                	push   $0x0
  802bbd:	6a 00                	push   $0x0
  802bbf:	6a 00                	push   $0x0
  802bc1:	6a 00                	push   $0x0
  802bc3:	6a 20                	push   $0x20
  802bc5:	e8 44 fc ff ff       	call   80280e <syscall>
  802bca:	83 c4 18             	add    $0x18,%esp
}
  802bcd:	c9                   	leave  
  802bce:	c3                   	ret    

00802bcf <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802bcf:	55                   	push   %ebp
  802bd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  802bd5:	6a 00                	push   $0x0
  802bd7:	6a 00                	push   $0x0
  802bd9:	ff 75 10             	pushl  0x10(%ebp)
  802bdc:	ff 75 0c             	pushl  0xc(%ebp)
  802bdf:	50                   	push   %eax
  802be0:	6a 21                	push   $0x21
  802be2:	e8 27 fc ff ff       	call   80280e <syscall>
  802be7:	83 c4 18             	add    $0x18,%esp
}
  802bea:	c9                   	leave  
  802beb:	c3                   	ret    

00802bec <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802bec:	55                   	push   %ebp
  802bed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802bef:	8b 45 08             	mov    0x8(%ebp),%eax
  802bf2:	6a 00                	push   $0x0
  802bf4:	6a 00                	push   $0x0
  802bf6:	6a 00                	push   $0x0
  802bf8:	6a 00                	push   $0x0
  802bfa:	50                   	push   %eax
  802bfb:	6a 22                	push   $0x22
  802bfd:	e8 0c fc ff ff       	call   80280e <syscall>
  802c02:	83 c4 18             	add    $0x18,%esp
}
  802c05:	90                   	nop
  802c06:	c9                   	leave  
  802c07:	c3                   	ret    

00802c08 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802c08:	55                   	push   %ebp
  802c09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  802c0e:	6a 00                	push   $0x0
  802c10:	6a 00                	push   $0x0
  802c12:	6a 00                	push   $0x0
  802c14:	6a 00                	push   $0x0
  802c16:	50                   	push   %eax
  802c17:	6a 23                	push   $0x23
  802c19:	e8 f0 fb ff ff       	call   80280e <syscall>
  802c1e:	83 c4 18             	add    $0x18,%esp
}
  802c21:	90                   	nop
  802c22:	c9                   	leave  
  802c23:	c3                   	ret    

00802c24 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802c24:	55                   	push   %ebp
  802c25:	89 e5                	mov    %esp,%ebp
  802c27:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802c2a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802c2d:	8d 50 04             	lea    0x4(%eax),%edx
  802c30:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802c33:	6a 00                	push   $0x0
  802c35:	6a 00                	push   $0x0
  802c37:	6a 00                	push   $0x0
  802c39:	52                   	push   %edx
  802c3a:	50                   	push   %eax
  802c3b:	6a 24                	push   $0x24
  802c3d:	e8 cc fb ff ff       	call   80280e <syscall>
  802c42:	83 c4 18             	add    $0x18,%esp
	return result;
  802c45:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802c48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802c4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802c4e:	89 01                	mov    %eax,(%ecx)
  802c50:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802c53:	8b 45 08             	mov    0x8(%ebp),%eax
  802c56:	c9                   	leave  
  802c57:	c2 04 00             	ret    $0x4

00802c5a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802c5a:	55                   	push   %ebp
  802c5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802c5d:	6a 00                	push   $0x0
  802c5f:	6a 00                	push   $0x0
  802c61:	ff 75 10             	pushl  0x10(%ebp)
  802c64:	ff 75 0c             	pushl  0xc(%ebp)
  802c67:	ff 75 08             	pushl  0x8(%ebp)
  802c6a:	6a 13                	push   $0x13
  802c6c:	e8 9d fb ff ff       	call   80280e <syscall>
  802c71:	83 c4 18             	add    $0x18,%esp
	return ;
  802c74:	90                   	nop
}
  802c75:	c9                   	leave  
  802c76:	c3                   	ret    

00802c77 <sys_rcr2>:
uint32 sys_rcr2()
{
  802c77:	55                   	push   %ebp
  802c78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802c7a:	6a 00                	push   $0x0
  802c7c:	6a 00                	push   $0x0
  802c7e:	6a 00                	push   $0x0
  802c80:	6a 00                	push   $0x0
  802c82:	6a 00                	push   $0x0
  802c84:	6a 25                	push   $0x25
  802c86:	e8 83 fb ff ff       	call   80280e <syscall>
  802c8b:	83 c4 18             	add    $0x18,%esp
}
  802c8e:	c9                   	leave  
  802c8f:	c3                   	ret    

00802c90 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802c90:	55                   	push   %ebp
  802c91:	89 e5                	mov    %esp,%ebp
  802c93:	83 ec 04             	sub    $0x4,%esp
  802c96:	8b 45 08             	mov    0x8(%ebp),%eax
  802c99:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802c9c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802ca0:	6a 00                	push   $0x0
  802ca2:	6a 00                	push   $0x0
  802ca4:	6a 00                	push   $0x0
  802ca6:	6a 00                	push   $0x0
  802ca8:	50                   	push   %eax
  802ca9:	6a 26                	push   $0x26
  802cab:	e8 5e fb ff ff       	call   80280e <syscall>
  802cb0:	83 c4 18             	add    $0x18,%esp
	return ;
  802cb3:	90                   	nop
}
  802cb4:	c9                   	leave  
  802cb5:	c3                   	ret    

00802cb6 <rsttst>:
void rsttst()
{
  802cb6:	55                   	push   %ebp
  802cb7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802cb9:	6a 00                	push   $0x0
  802cbb:	6a 00                	push   $0x0
  802cbd:	6a 00                	push   $0x0
  802cbf:	6a 00                	push   $0x0
  802cc1:	6a 00                	push   $0x0
  802cc3:	6a 28                	push   $0x28
  802cc5:	e8 44 fb ff ff       	call   80280e <syscall>
  802cca:	83 c4 18             	add    $0x18,%esp
	return ;
  802ccd:	90                   	nop
}
  802cce:	c9                   	leave  
  802ccf:	c3                   	ret    

00802cd0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802cd0:	55                   	push   %ebp
  802cd1:	89 e5                	mov    %esp,%ebp
  802cd3:	83 ec 04             	sub    $0x4,%esp
  802cd6:	8b 45 14             	mov    0x14(%ebp),%eax
  802cd9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802cdc:	8b 55 18             	mov    0x18(%ebp),%edx
  802cdf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802ce3:	52                   	push   %edx
  802ce4:	50                   	push   %eax
  802ce5:	ff 75 10             	pushl  0x10(%ebp)
  802ce8:	ff 75 0c             	pushl  0xc(%ebp)
  802ceb:	ff 75 08             	pushl  0x8(%ebp)
  802cee:	6a 27                	push   $0x27
  802cf0:	e8 19 fb ff ff       	call   80280e <syscall>
  802cf5:	83 c4 18             	add    $0x18,%esp
	return ;
  802cf8:	90                   	nop
}
  802cf9:	c9                   	leave  
  802cfa:	c3                   	ret    

00802cfb <chktst>:
void chktst(uint32 n)
{
  802cfb:	55                   	push   %ebp
  802cfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802cfe:	6a 00                	push   $0x0
  802d00:	6a 00                	push   $0x0
  802d02:	6a 00                	push   $0x0
  802d04:	6a 00                	push   $0x0
  802d06:	ff 75 08             	pushl  0x8(%ebp)
  802d09:	6a 29                	push   $0x29
  802d0b:	e8 fe fa ff ff       	call   80280e <syscall>
  802d10:	83 c4 18             	add    $0x18,%esp
	return ;
  802d13:	90                   	nop
}
  802d14:	c9                   	leave  
  802d15:	c3                   	ret    

00802d16 <inctst>:

void inctst()
{
  802d16:	55                   	push   %ebp
  802d17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802d19:	6a 00                	push   $0x0
  802d1b:	6a 00                	push   $0x0
  802d1d:	6a 00                	push   $0x0
  802d1f:	6a 00                	push   $0x0
  802d21:	6a 00                	push   $0x0
  802d23:	6a 2a                	push   $0x2a
  802d25:	e8 e4 fa ff ff       	call   80280e <syscall>
  802d2a:	83 c4 18             	add    $0x18,%esp
	return ;
  802d2d:	90                   	nop
}
  802d2e:	c9                   	leave  
  802d2f:	c3                   	ret    

00802d30 <gettst>:
uint32 gettst()
{
  802d30:	55                   	push   %ebp
  802d31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802d33:	6a 00                	push   $0x0
  802d35:	6a 00                	push   $0x0
  802d37:	6a 00                	push   $0x0
  802d39:	6a 00                	push   $0x0
  802d3b:	6a 00                	push   $0x0
  802d3d:	6a 2b                	push   $0x2b
  802d3f:	e8 ca fa ff ff       	call   80280e <syscall>
  802d44:	83 c4 18             	add    $0x18,%esp
}
  802d47:	c9                   	leave  
  802d48:	c3                   	ret    

00802d49 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802d49:	55                   	push   %ebp
  802d4a:	89 e5                	mov    %esp,%ebp
  802d4c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802d4f:	6a 00                	push   $0x0
  802d51:	6a 00                	push   $0x0
  802d53:	6a 00                	push   $0x0
  802d55:	6a 00                	push   $0x0
  802d57:	6a 00                	push   $0x0
  802d59:	6a 2c                	push   $0x2c
  802d5b:	e8 ae fa ff ff       	call   80280e <syscall>
  802d60:	83 c4 18             	add    $0x18,%esp
  802d63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802d66:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802d6a:	75 07                	jne    802d73 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802d6c:	b8 01 00 00 00       	mov    $0x1,%eax
  802d71:	eb 05                	jmp    802d78 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802d73:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802d78:	c9                   	leave  
  802d79:	c3                   	ret    

00802d7a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802d7a:	55                   	push   %ebp
  802d7b:	89 e5                	mov    %esp,%ebp
  802d7d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802d80:	6a 00                	push   $0x0
  802d82:	6a 00                	push   $0x0
  802d84:	6a 00                	push   $0x0
  802d86:	6a 00                	push   $0x0
  802d88:	6a 00                	push   $0x0
  802d8a:	6a 2c                	push   $0x2c
  802d8c:	e8 7d fa ff ff       	call   80280e <syscall>
  802d91:	83 c4 18             	add    $0x18,%esp
  802d94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802d97:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802d9b:	75 07                	jne    802da4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802d9d:	b8 01 00 00 00       	mov    $0x1,%eax
  802da2:	eb 05                	jmp    802da9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802da4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802da9:	c9                   	leave  
  802daa:	c3                   	ret    

00802dab <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802dab:	55                   	push   %ebp
  802dac:	89 e5                	mov    %esp,%ebp
  802dae:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802db1:	6a 00                	push   $0x0
  802db3:	6a 00                	push   $0x0
  802db5:	6a 00                	push   $0x0
  802db7:	6a 00                	push   $0x0
  802db9:	6a 00                	push   $0x0
  802dbb:	6a 2c                	push   $0x2c
  802dbd:	e8 4c fa ff ff       	call   80280e <syscall>
  802dc2:	83 c4 18             	add    $0x18,%esp
  802dc5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802dc8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802dcc:	75 07                	jne    802dd5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802dce:	b8 01 00 00 00       	mov    $0x1,%eax
  802dd3:	eb 05                	jmp    802dda <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802dd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802dda:	c9                   	leave  
  802ddb:	c3                   	ret    

00802ddc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802ddc:	55                   	push   %ebp
  802ddd:	89 e5                	mov    %esp,%ebp
  802ddf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802de2:	6a 00                	push   $0x0
  802de4:	6a 00                	push   $0x0
  802de6:	6a 00                	push   $0x0
  802de8:	6a 00                	push   $0x0
  802dea:	6a 00                	push   $0x0
  802dec:	6a 2c                	push   $0x2c
  802dee:	e8 1b fa ff ff       	call   80280e <syscall>
  802df3:	83 c4 18             	add    $0x18,%esp
  802df6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802df9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802dfd:	75 07                	jne    802e06 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802dff:	b8 01 00 00 00       	mov    $0x1,%eax
  802e04:	eb 05                	jmp    802e0b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802e06:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802e0b:	c9                   	leave  
  802e0c:	c3                   	ret    

00802e0d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802e0d:	55                   	push   %ebp
  802e0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802e10:	6a 00                	push   $0x0
  802e12:	6a 00                	push   $0x0
  802e14:	6a 00                	push   $0x0
  802e16:	6a 00                	push   $0x0
  802e18:	ff 75 08             	pushl  0x8(%ebp)
  802e1b:	6a 2d                	push   $0x2d
  802e1d:	e8 ec f9 ff ff       	call   80280e <syscall>
  802e22:	83 c4 18             	add    $0x18,%esp
	return ;
  802e25:	90                   	nop
}
  802e26:	c9                   	leave  
  802e27:	c3                   	ret    

00802e28 <__udivdi3>:
  802e28:	55                   	push   %ebp
  802e29:	57                   	push   %edi
  802e2a:	56                   	push   %esi
  802e2b:	53                   	push   %ebx
  802e2c:	83 ec 1c             	sub    $0x1c,%esp
  802e2f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802e33:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802e37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802e3b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802e3f:	89 ca                	mov    %ecx,%edx
  802e41:	89 f8                	mov    %edi,%eax
  802e43:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802e47:	85 f6                	test   %esi,%esi
  802e49:	75 2d                	jne    802e78 <__udivdi3+0x50>
  802e4b:	39 cf                	cmp    %ecx,%edi
  802e4d:	77 65                	ja     802eb4 <__udivdi3+0x8c>
  802e4f:	89 fd                	mov    %edi,%ebp
  802e51:	85 ff                	test   %edi,%edi
  802e53:	75 0b                	jne    802e60 <__udivdi3+0x38>
  802e55:	b8 01 00 00 00       	mov    $0x1,%eax
  802e5a:	31 d2                	xor    %edx,%edx
  802e5c:	f7 f7                	div    %edi
  802e5e:	89 c5                	mov    %eax,%ebp
  802e60:	31 d2                	xor    %edx,%edx
  802e62:	89 c8                	mov    %ecx,%eax
  802e64:	f7 f5                	div    %ebp
  802e66:	89 c1                	mov    %eax,%ecx
  802e68:	89 d8                	mov    %ebx,%eax
  802e6a:	f7 f5                	div    %ebp
  802e6c:	89 cf                	mov    %ecx,%edi
  802e6e:	89 fa                	mov    %edi,%edx
  802e70:	83 c4 1c             	add    $0x1c,%esp
  802e73:	5b                   	pop    %ebx
  802e74:	5e                   	pop    %esi
  802e75:	5f                   	pop    %edi
  802e76:	5d                   	pop    %ebp
  802e77:	c3                   	ret    
  802e78:	39 ce                	cmp    %ecx,%esi
  802e7a:	77 28                	ja     802ea4 <__udivdi3+0x7c>
  802e7c:	0f bd fe             	bsr    %esi,%edi
  802e7f:	83 f7 1f             	xor    $0x1f,%edi
  802e82:	75 40                	jne    802ec4 <__udivdi3+0x9c>
  802e84:	39 ce                	cmp    %ecx,%esi
  802e86:	72 0a                	jb     802e92 <__udivdi3+0x6a>
  802e88:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802e8c:	0f 87 9e 00 00 00    	ja     802f30 <__udivdi3+0x108>
  802e92:	b8 01 00 00 00       	mov    $0x1,%eax
  802e97:	89 fa                	mov    %edi,%edx
  802e99:	83 c4 1c             	add    $0x1c,%esp
  802e9c:	5b                   	pop    %ebx
  802e9d:	5e                   	pop    %esi
  802e9e:	5f                   	pop    %edi
  802e9f:	5d                   	pop    %ebp
  802ea0:	c3                   	ret    
  802ea1:	8d 76 00             	lea    0x0(%esi),%esi
  802ea4:	31 ff                	xor    %edi,%edi
  802ea6:	31 c0                	xor    %eax,%eax
  802ea8:	89 fa                	mov    %edi,%edx
  802eaa:	83 c4 1c             	add    $0x1c,%esp
  802ead:	5b                   	pop    %ebx
  802eae:	5e                   	pop    %esi
  802eaf:	5f                   	pop    %edi
  802eb0:	5d                   	pop    %ebp
  802eb1:	c3                   	ret    
  802eb2:	66 90                	xchg   %ax,%ax
  802eb4:	89 d8                	mov    %ebx,%eax
  802eb6:	f7 f7                	div    %edi
  802eb8:	31 ff                	xor    %edi,%edi
  802eba:	89 fa                	mov    %edi,%edx
  802ebc:	83 c4 1c             	add    $0x1c,%esp
  802ebf:	5b                   	pop    %ebx
  802ec0:	5e                   	pop    %esi
  802ec1:	5f                   	pop    %edi
  802ec2:	5d                   	pop    %ebp
  802ec3:	c3                   	ret    
  802ec4:	bd 20 00 00 00       	mov    $0x20,%ebp
  802ec9:	89 eb                	mov    %ebp,%ebx
  802ecb:	29 fb                	sub    %edi,%ebx
  802ecd:	89 f9                	mov    %edi,%ecx
  802ecf:	d3 e6                	shl    %cl,%esi
  802ed1:	89 c5                	mov    %eax,%ebp
  802ed3:	88 d9                	mov    %bl,%cl
  802ed5:	d3 ed                	shr    %cl,%ebp
  802ed7:	89 e9                	mov    %ebp,%ecx
  802ed9:	09 f1                	or     %esi,%ecx
  802edb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802edf:	89 f9                	mov    %edi,%ecx
  802ee1:	d3 e0                	shl    %cl,%eax
  802ee3:	89 c5                	mov    %eax,%ebp
  802ee5:	89 d6                	mov    %edx,%esi
  802ee7:	88 d9                	mov    %bl,%cl
  802ee9:	d3 ee                	shr    %cl,%esi
  802eeb:	89 f9                	mov    %edi,%ecx
  802eed:	d3 e2                	shl    %cl,%edx
  802eef:	8b 44 24 08          	mov    0x8(%esp),%eax
  802ef3:	88 d9                	mov    %bl,%cl
  802ef5:	d3 e8                	shr    %cl,%eax
  802ef7:	09 c2                	or     %eax,%edx
  802ef9:	89 d0                	mov    %edx,%eax
  802efb:	89 f2                	mov    %esi,%edx
  802efd:	f7 74 24 0c          	divl   0xc(%esp)
  802f01:	89 d6                	mov    %edx,%esi
  802f03:	89 c3                	mov    %eax,%ebx
  802f05:	f7 e5                	mul    %ebp
  802f07:	39 d6                	cmp    %edx,%esi
  802f09:	72 19                	jb     802f24 <__udivdi3+0xfc>
  802f0b:	74 0b                	je     802f18 <__udivdi3+0xf0>
  802f0d:	89 d8                	mov    %ebx,%eax
  802f0f:	31 ff                	xor    %edi,%edi
  802f11:	e9 58 ff ff ff       	jmp    802e6e <__udivdi3+0x46>
  802f16:	66 90                	xchg   %ax,%ax
  802f18:	8b 54 24 08          	mov    0x8(%esp),%edx
  802f1c:	89 f9                	mov    %edi,%ecx
  802f1e:	d3 e2                	shl    %cl,%edx
  802f20:	39 c2                	cmp    %eax,%edx
  802f22:	73 e9                	jae    802f0d <__udivdi3+0xe5>
  802f24:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802f27:	31 ff                	xor    %edi,%edi
  802f29:	e9 40 ff ff ff       	jmp    802e6e <__udivdi3+0x46>
  802f2e:	66 90                	xchg   %ax,%ax
  802f30:	31 c0                	xor    %eax,%eax
  802f32:	e9 37 ff ff ff       	jmp    802e6e <__udivdi3+0x46>
  802f37:	90                   	nop

00802f38 <__umoddi3>:
  802f38:	55                   	push   %ebp
  802f39:	57                   	push   %edi
  802f3a:	56                   	push   %esi
  802f3b:	53                   	push   %ebx
  802f3c:	83 ec 1c             	sub    $0x1c,%esp
  802f3f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802f43:	8b 74 24 34          	mov    0x34(%esp),%esi
  802f47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802f4b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802f4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802f53:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802f57:	89 f3                	mov    %esi,%ebx
  802f59:	89 fa                	mov    %edi,%edx
  802f5b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802f5f:	89 34 24             	mov    %esi,(%esp)
  802f62:	85 c0                	test   %eax,%eax
  802f64:	75 1a                	jne    802f80 <__umoddi3+0x48>
  802f66:	39 f7                	cmp    %esi,%edi
  802f68:	0f 86 a2 00 00 00    	jbe    803010 <__umoddi3+0xd8>
  802f6e:	89 c8                	mov    %ecx,%eax
  802f70:	89 f2                	mov    %esi,%edx
  802f72:	f7 f7                	div    %edi
  802f74:	89 d0                	mov    %edx,%eax
  802f76:	31 d2                	xor    %edx,%edx
  802f78:	83 c4 1c             	add    $0x1c,%esp
  802f7b:	5b                   	pop    %ebx
  802f7c:	5e                   	pop    %esi
  802f7d:	5f                   	pop    %edi
  802f7e:	5d                   	pop    %ebp
  802f7f:	c3                   	ret    
  802f80:	39 f0                	cmp    %esi,%eax
  802f82:	0f 87 ac 00 00 00    	ja     803034 <__umoddi3+0xfc>
  802f88:	0f bd e8             	bsr    %eax,%ebp
  802f8b:	83 f5 1f             	xor    $0x1f,%ebp
  802f8e:	0f 84 ac 00 00 00    	je     803040 <__umoddi3+0x108>
  802f94:	bf 20 00 00 00       	mov    $0x20,%edi
  802f99:	29 ef                	sub    %ebp,%edi
  802f9b:	89 fe                	mov    %edi,%esi
  802f9d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802fa1:	89 e9                	mov    %ebp,%ecx
  802fa3:	d3 e0                	shl    %cl,%eax
  802fa5:	89 d7                	mov    %edx,%edi
  802fa7:	89 f1                	mov    %esi,%ecx
  802fa9:	d3 ef                	shr    %cl,%edi
  802fab:	09 c7                	or     %eax,%edi
  802fad:	89 e9                	mov    %ebp,%ecx
  802faf:	d3 e2                	shl    %cl,%edx
  802fb1:	89 14 24             	mov    %edx,(%esp)
  802fb4:	89 d8                	mov    %ebx,%eax
  802fb6:	d3 e0                	shl    %cl,%eax
  802fb8:	89 c2                	mov    %eax,%edx
  802fba:	8b 44 24 08          	mov    0x8(%esp),%eax
  802fbe:	d3 e0                	shl    %cl,%eax
  802fc0:	89 44 24 04          	mov    %eax,0x4(%esp)
  802fc4:	8b 44 24 08          	mov    0x8(%esp),%eax
  802fc8:	89 f1                	mov    %esi,%ecx
  802fca:	d3 e8                	shr    %cl,%eax
  802fcc:	09 d0                	or     %edx,%eax
  802fce:	d3 eb                	shr    %cl,%ebx
  802fd0:	89 da                	mov    %ebx,%edx
  802fd2:	f7 f7                	div    %edi
  802fd4:	89 d3                	mov    %edx,%ebx
  802fd6:	f7 24 24             	mull   (%esp)
  802fd9:	89 c6                	mov    %eax,%esi
  802fdb:	89 d1                	mov    %edx,%ecx
  802fdd:	39 d3                	cmp    %edx,%ebx
  802fdf:	0f 82 87 00 00 00    	jb     80306c <__umoddi3+0x134>
  802fe5:	0f 84 91 00 00 00    	je     80307c <__umoddi3+0x144>
  802feb:	8b 54 24 04          	mov    0x4(%esp),%edx
  802fef:	29 f2                	sub    %esi,%edx
  802ff1:	19 cb                	sbb    %ecx,%ebx
  802ff3:	89 d8                	mov    %ebx,%eax
  802ff5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802ff9:	d3 e0                	shl    %cl,%eax
  802ffb:	89 e9                	mov    %ebp,%ecx
  802ffd:	d3 ea                	shr    %cl,%edx
  802fff:	09 d0                	or     %edx,%eax
  803001:	89 e9                	mov    %ebp,%ecx
  803003:	d3 eb                	shr    %cl,%ebx
  803005:	89 da                	mov    %ebx,%edx
  803007:	83 c4 1c             	add    $0x1c,%esp
  80300a:	5b                   	pop    %ebx
  80300b:	5e                   	pop    %esi
  80300c:	5f                   	pop    %edi
  80300d:	5d                   	pop    %ebp
  80300e:	c3                   	ret    
  80300f:	90                   	nop
  803010:	89 fd                	mov    %edi,%ebp
  803012:	85 ff                	test   %edi,%edi
  803014:	75 0b                	jne    803021 <__umoddi3+0xe9>
  803016:	b8 01 00 00 00       	mov    $0x1,%eax
  80301b:	31 d2                	xor    %edx,%edx
  80301d:	f7 f7                	div    %edi
  80301f:	89 c5                	mov    %eax,%ebp
  803021:	89 f0                	mov    %esi,%eax
  803023:	31 d2                	xor    %edx,%edx
  803025:	f7 f5                	div    %ebp
  803027:	89 c8                	mov    %ecx,%eax
  803029:	f7 f5                	div    %ebp
  80302b:	89 d0                	mov    %edx,%eax
  80302d:	e9 44 ff ff ff       	jmp    802f76 <__umoddi3+0x3e>
  803032:	66 90                	xchg   %ax,%ax
  803034:	89 c8                	mov    %ecx,%eax
  803036:	89 f2                	mov    %esi,%edx
  803038:	83 c4 1c             	add    $0x1c,%esp
  80303b:	5b                   	pop    %ebx
  80303c:	5e                   	pop    %esi
  80303d:	5f                   	pop    %edi
  80303e:	5d                   	pop    %ebp
  80303f:	c3                   	ret    
  803040:	3b 04 24             	cmp    (%esp),%eax
  803043:	72 06                	jb     80304b <__umoddi3+0x113>
  803045:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803049:	77 0f                	ja     80305a <__umoddi3+0x122>
  80304b:	89 f2                	mov    %esi,%edx
  80304d:	29 f9                	sub    %edi,%ecx
  80304f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  803053:	89 14 24             	mov    %edx,(%esp)
  803056:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80305a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80305e:	8b 14 24             	mov    (%esp),%edx
  803061:	83 c4 1c             	add    $0x1c,%esp
  803064:	5b                   	pop    %ebx
  803065:	5e                   	pop    %esi
  803066:	5f                   	pop    %edi
  803067:	5d                   	pop    %ebp
  803068:	c3                   	ret    
  803069:	8d 76 00             	lea    0x0(%esi),%esi
  80306c:	2b 04 24             	sub    (%esp),%eax
  80306f:	19 fa                	sbb    %edi,%edx
  803071:	89 d1                	mov    %edx,%ecx
  803073:	89 c6                	mov    %eax,%esi
  803075:	e9 71 ff ff ff       	jmp    802feb <__umoddi3+0xb3>
  80307a:	66 90                	xchg   %ax,%ax
  80307c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  803080:	72 ea                	jb     80306c <__umoddi3+0x134>
  803082:	89 d9                	mov    %ebx,%ecx
  803084:	e9 62 ff ff ff       	jmp    802feb <__umoddi3+0xb3>
