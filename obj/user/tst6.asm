
obj/user/tst6:     file format elf32-i386


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
  800031:	e8 4d 06 00 00       	call   800683 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp
	

	rsttst();
  800041:	e8 d5 1c 00 00       	call   801d1b <rsttst>
	
	

	int Mega = 1024*1024;
  800046:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  80004d:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	void* ptr_allocations[20] = {0};
  800054:	8d 55 88             	lea    -0x78(%ebp),%edx
  800057:	b9 14 00 00 00       	mov    $0x14,%ecx
  80005c:	b8 00 00 00 00       	mov    $0x0,%eax
  800061:	89 d7                	mov    %edx,%edi
  800063:	f3 ab                	rep stos %eax,%es:(%edi)

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
  800065:	83 ec 0c             	sub    $0xc,%esp
  800068:	68 01 00 00 20       	push   $0x20000001
  80006d:	e8 ab 15 00 00       	call   80161d <malloc>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 88             	mov    %eax,-0x78(%ebp)
		tst((uint32) ptr_allocations[0], 0,0, 'b', 0);
  800078:	8b 45 88             	mov    -0x78(%ebp),%eax
  80007b:	83 ec 0c             	sub    $0xc,%esp
  80007e:	6a 00                	push   $0x0
  800080:	6a 62                	push   $0x62
  800082:	6a 00                	push   $0x0
  800084:	6a 00                	push   $0x0
  800086:	50                   	push   %eax
  800087:	e8 a9 1c 00 00       	call   801d35 <tst>
  80008c:	83 c4 20             	add    $0x20,%esp

	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  80008f:	e8 4b 19 00 00       	call   8019df <sys_calculate_free_frames>
  800094:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800097:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80009a:	01 c0                	add    %eax,%eax
  80009c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80009f:	83 ec 0c             	sub    $0xc,%esp
  8000a2:	50                   	push   %eax
  8000a3:	e8 75 15 00 00       	call   80161d <malloc>
  8000a8:	83 c4 10             	add    $0x10,%esp
  8000ab:	89 45 88             	mov    %eax,-0x78(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  8000ae:	8b 45 88             	mov    -0x78(%ebp),%eax
  8000b1:	83 ec 0c             	sub    $0xc,%esp
  8000b4:	6a 00                	push   $0x0
  8000b6:	6a 62                	push   $0x62
  8000b8:	68 00 10 00 80       	push   $0x80001000
  8000bd:	68 00 00 00 80       	push   $0x80000000
  8000c2:	50                   	push   %eax
  8000c3:	e8 6d 1c 00 00       	call   801d35 <tst>
  8000c8:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8000cb:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8000ce:	e8 0c 19 00 00       	call   8019df <sys_calculate_free_frames>
  8000d3:	29 c3                	sub    %eax,%ebx
  8000d5:	89 d8                	mov    %ebx,%eax
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	6a 00                	push   $0x0
  8000dc:	6a 65                	push   $0x65
  8000de:	6a 00                	push   $0x0
  8000e0:	68 01 02 00 00       	push   $0x201
  8000e5:	50                   	push   %eax
  8000e6:	e8 4a 1c 00 00       	call   801d35 <tst>
  8000eb:	83 c4 20             	add    $0x20,%esp

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  8000ee:	e8 ec 18 00 00       	call   8019df <sys_calculate_free_frames>
  8000f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  8000f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 16 15 00 00       	call   80161d <malloc>
  800107:	83 c4 10             	add    $0x10,%esp
  80010a:	89 45 8c             	mov    %eax,-0x74(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega+ PAGE_SIZE, 'b', 0);
  80010d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800110:	01 c0                	add    %eax,%eax
  800112:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800118:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80011b:	01 c0                	add    %eax,%eax
  80011d:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800123:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800126:	83 ec 0c             	sub    $0xc,%esp
  800129:	6a 00                	push   $0x0
  80012b:	6a 62                	push   $0x62
  80012d:	51                   	push   %ecx
  80012e:	52                   	push   %edx
  80012f:	50                   	push   %eax
  800130:	e8 00 1c 00 00       	call   801d35 <tst>
  800135:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  800138:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80013b:	e8 9f 18 00 00       	call   8019df <sys_calculate_free_frames>
  800140:	29 c3                	sub    %eax,%ebx
  800142:	89 d8                	mov    %ebx,%eax
  800144:	83 ec 0c             	sub    $0xc,%esp
  800147:	6a 00                	push   $0x0
  800149:	6a 65                	push   $0x65
  80014b:	6a 00                	push   $0x0
  80014d:	68 00 02 00 00       	push   $0x200
  800152:	50                   	push   %eax
  800153:	e8 dd 1b 00 00       	call   801d35 <tst>
  800158:	83 c4 20             	add    $0x20,%esp

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80015b:	e8 7f 18 00 00       	call   8019df <sys_calculate_free_frames>
  800160:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800163:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800166:	01 c0                	add    %eax,%eax
  800168:	83 ec 0c             	sub    $0xc,%esp
  80016b:	50                   	push   %eax
  80016c:	e8 ac 14 00 00       	call   80161d <malloc>
  800171:	83 c4 10             	add    $0x10,%esp
  800174:	89 45 90             	mov    %eax,-0x70(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega+ PAGE_SIZE, 'b', 0);
  800177:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80017a:	c1 e0 02             	shl    $0x2,%eax
  80017d:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800183:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800186:	c1 e0 02             	shl    $0x2,%eax
  800189:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80018f:	8b 45 90             	mov    -0x70(%ebp),%eax
  800192:	83 ec 0c             	sub    $0xc,%esp
  800195:	6a 00                	push   $0x0
  800197:	6a 62                	push   $0x62
  800199:	51                   	push   %ecx
  80019a:	52                   	push   %edx
  80019b:	50                   	push   %eax
  80019c:	e8 94 1b 00 00       	call   801d35 <tst>
  8001a1:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);
  8001a4:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8001a7:	e8 33 18 00 00       	call   8019df <sys_calculate_free_frames>
  8001ac:	29 c3                	sub    %eax,%ebx
  8001ae:	89 d8                	mov    %ebx,%eax
  8001b0:	83 ec 0c             	sub    $0xc,%esp
  8001b3:	6a 00                	push   $0x0
  8001b5:	6a 65                	push   $0x65
  8001b7:	6a 00                	push   $0x0
  8001b9:	6a 02                	push   $0x2
  8001bb:	50                   	push   %eax
  8001bc:	e8 74 1b 00 00       	call   801d35 <tst>
  8001c1:	83 c4 20             	add    $0x20,%esp

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001c4:	e8 16 18 00 00       	call   8019df <sys_calculate_free_frames>
  8001c9:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8001cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001cf:	01 c0                	add    %eax,%eax
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	50                   	push   %eax
  8001d5:	e8 43 14 00 00       	call   80161d <malloc>
  8001da:	83 c4 10             	add    $0x10,%esp
  8001dd:	89 45 94             	mov    %eax,-0x6c(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega+ 4*kilo,USER_HEAP_START + 4*Mega+ 4*kilo+ PAGE_SIZE, 'b', 0);
  8001e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e3:	c1 e0 02             	shl    $0x2,%eax
  8001e6:	89 c2                	mov    %eax,%edx
  8001e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001eb:	c1 e0 02             	shl    $0x2,%eax
  8001ee:	01 d0                	add    %edx,%eax
  8001f0:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001f9:	c1 e0 02             	shl    $0x2,%eax
  8001fc:	89 c2                	mov    %eax,%edx
  8001fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800201:	c1 e0 02             	shl    $0x2,%eax
  800204:	01 d0                	add    %edx,%eax
  800206:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80020c:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80020f:	83 ec 0c             	sub    $0xc,%esp
  800212:	6a 00                	push   $0x0
  800214:	6a 62                	push   $0x62
  800216:	51                   	push   %ecx
  800217:	52                   	push   %edx
  800218:	50                   	push   %eax
  800219:	e8 17 1b 00 00       	call   801d35 <tst>
  80021e:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);
  800221:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  800224:	e8 b6 17 00 00       	call   8019df <sys_calculate_free_frames>
  800229:	29 c3                	sub    %eax,%ebx
  80022b:	89 d8                	mov    %ebx,%eax
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	6a 00                	push   $0x0
  800232:	6a 65                	push   $0x65
  800234:	6a 00                	push   $0x0
  800236:	6a 01                	push   $0x1
  800238:	50                   	push   %eax
  800239:	e8 f7 1a 00 00       	call   801d35 <tst>
  80023e:	83 c4 20             	add    $0x20,%esp

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  800241:	e8 99 17 00 00       	call   8019df <sys_calculate_free_frames>
  800246:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[2]);
  800249:	8b 45 90             	mov    -0x70(%ebp),%eax
  80024c:	83 ec 0c             	sub    $0xc,%esp
  80024f:	50                   	push   %eax
  800250:	e8 e9 14 00 00       	call   80173e <free>
  800255:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 1,0, 'e', 0);
  800258:	e8 82 17 00 00       	call   8019df <sys_calculate_free_frames>
  80025d:	89 c2                	mov    %eax,%edx
  80025f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800262:	29 c2                	sub    %eax,%edx
  800264:	89 d0                	mov    %edx,%eax
  800266:	83 ec 0c             	sub    $0xc,%esp
  800269:	6a 00                	push   $0x0
  80026b:	6a 65                	push   $0x65
  80026d:	6a 00                	push   $0x0
  80026f:	6a 01                	push   $0x1
  800271:	50                   	push   %eax
  800272:	e8 be 1a 00 00       	call   801d35 <tst>
  800277:	83 c4 20             	add    $0x20,%esp

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  80027a:	e8 60 17 00 00       	call   8019df <sys_calculate_free_frames>
  80027f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800282:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800285:	89 d0                	mov    %edx,%eax
  800287:	01 c0                	add    %eax,%eax
  800289:	01 d0                	add    %edx,%eax
  80028b:	01 c0                	add    %eax,%eax
  80028d:	01 d0                	add    %edx,%eax
  80028f:	83 ec 0c             	sub    $0xc,%esp
  800292:	50                   	push   %eax
  800293:	e8 85 13 00 00       	call   80161d <malloc>
  800298:	83 c4 10             	add    $0x10,%esp
  80029b:	89 45 98             	mov    %eax,-0x68(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega+ 8*kilo,USER_HEAP_START + 4*Mega+ 8*kilo+ PAGE_SIZE, 'b', 0);
  80029e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a1:	c1 e0 02             	shl    $0x2,%eax
  8002a4:	89 c2                	mov    %eax,%edx
  8002a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002a9:	c1 e0 03             	shl    $0x3,%eax
  8002ac:	01 d0                	add    %edx,%eax
  8002ae:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002b7:	c1 e0 02             	shl    $0x2,%eax
  8002ba:	89 c2                	mov    %eax,%edx
  8002bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002bf:	c1 e0 03             	shl    $0x3,%eax
  8002c2:	01 d0                	add    %edx,%eax
  8002c4:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002ca:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002cd:	83 ec 0c             	sub    $0xc,%esp
  8002d0:	6a 00                	push   $0x0
  8002d2:	6a 62                	push   $0x62
  8002d4:	51                   	push   %ecx
  8002d5:	52                   	push   %edx
  8002d6:	50                   	push   %eax
  8002d7:	e8 59 1a 00 00       	call   801d35 <tst>
  8002dc:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 2,0, 'e', 0);
  8002df:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8002e2:	e8 f8 16 00 00       	call   8019df <sys_calculate_free_frames>
  8002e7:	29 c3                	sub    %eax,%ebx
  8002e9:	89 d8                	mov    %ebx,%eax
  8002eb:	83 ec 0c             	sub    $0xc,%esp
  8002ee:	6a 00                	push   $0x0
  8002f0:	6a 65                	push   $0x65
  8002f2:	6a 00                	push   $0x0
  8002f4:	6a 02                	push   $0x2
  8002f6:	50                   	push   %eax
  8002f7:	e8 39 1a 00 00       	call   801d35 <tst>
  8002fc:	83 c4 20             	add    $0x20,%esp

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002ff:	e8 db 16 00 00       	call   8019df <sys_calculate_free_frames>
  800304:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[0]);
  800307:	8b 45 88             	mov    -0x78(%ebp),%eax
  80030a:	83 ec 0c             	sub    $0xc,%esp
  80030d:	50                   	push   %eax
  80030e:	e8 2b 14 00 00       	call   80173e <free>
  800313:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512,0, 'e', 0);
  800316:	e8 c4 16 00 00       	call   8019df <sys_calculate_free_frames>
  80031b:	89 c2                	mov    %eax,%edx
  80031d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800320:	29 c2                	sub    %eax,%edx
  800322:	89 d0                	mov    %edx,%eax
  800324:	83 ec 0c             	sub    $0xc,%esp
  800327:	6a 00                	push   $0x0
  800329:	6a 65                	push   $0x65
  80032b:	6a 00                	push   $0x0
  80032d:	68 00 02 00 00       	push   $0x200
  800332:	50                   	push   %eax
  800333:	e8 fd 19 00 00       	call   801d35 <tst>
  800338:	83 c4 20             	add    $0x20,%esp

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  80033b:	e8 9f 16 00 00       	call   8019df <sys_calculate_free_frames>
  800340:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800343:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800346:	89 c2                	mov    %eax,%edx
  800348:	01 d2                	add    %edx,%edx
  80034a:	01 d0                	add    %edx,%eax
  80034c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	50                   	push   %eax
  800353:	e8 c5 12 00 00       	call   80161d <malloc>
  800358:	83 c4 10             	add    $0x10,%esp
  80035b:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega+ 16*kilo,USER_HEAP_START + 4*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
  80035e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800361:	c1 e0 02             	shl    $0x2,%eax
  800364:	89 c2                	mov    %eax,%edx
  800366:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800369:	c1 e0 04             	shl    $0x4,%eax
  80036c:	01 d0                	add    %edx,%eax
  80036e:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800374:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800377:	c1 e0 02             	shl    $0x2,%eax
  80037a:	89 c2                	mov    %eax,%edx
  80037c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80037f:	c1 e0 04             	shl    $0x4,%eax
  800382:	01 d0                	add    %edx,%eax
  800384:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80038a:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80038d:	83 ec 0c             	sub    $0xc,%esp
  800390:	6a 00                	push   $0x0
  800392:	6a 62                	push   $0x62
  800394:	51                   	push   %ecx
  800395:	52                   	push   %edx
  800396:	50                   	push   %eax
  800397:	e8 99 19 00 00       	call   801d35 <tst>
  80039c:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);
  80039f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003a2:	89 c2                	mov    %eax,%edx
  8003a4:	01 d2                	add    %edx,%edx
  8003a6:	01 d0                	add    %edx,%eax
  8003a8:	85 c0                	test   %eax,%eax
  8003aa:	79 05                	jns    8003b1 <_main+0x379>
  8003ac:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003b1:	c1 f8 0c             	sar    $0xc,%eax
  8003b4:	89 c3                	mov    %eax,%ebx
  8003b6:	8b 75 dc             	mov    -0x24(%ebp),%esi
  8003b9:	e8 21 16 00 00       	call   8019df <sys_calculate_free_frames>
  8003be:	29 c6                	sub    %eax,%esi
  8003c0:	89 f0                	mov    %esi,%eax
  8003c2:	83 ec 0c             	sub    $0xc,%esp
  8003c5:	6a 00                	push   $0x0
  8003c7:	6a 65                	push   $0x65
  8003c9:	6a 00                	push   $0x0
  8003cb:	53                   	push   %ebx
  8003cc:	50                   	push   %eax
  8003cd:	e8 63 19 00 00       	call   801d35 <tst>
  8003d2:	83 c4 20             	add    $0x20,%esp

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  8003d5:	e8 05 16 00 00       	call   8019df <sys_calculate_free_frames>
  8003da:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
  8003dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003e0:	89 c2                	mov    %eax,%edx
  8003e2:	01 d2                	add    %edx,%edx
  8003e4:	01 c2                	add    %eax,%edx
  8003e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003e9:	01 d0                	add    %edx,%eax
  8003eb:	01 c0                	add    %eax,%eax
  8003ed:	83 ec 0c             	sub    $0xc,%esp
  8003f0:	50                   	push   %eax
  8003f1:	e8 27 12 00 00       	call   80161d <malloc>
  8003f6:	83 c4 10             	add    $0x10,%esp
  8003f9:	89 45 a0             	mov    %eax,-0x60(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega+ 16*kilo,USER_HEAP_START + 7*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
  8003fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003ff:	89 d0                	mov    %edx,%eax
  800401:	01 c0                	add    %eax,%eax
  800403:	01 d0                	add    %edx,%eax
  800405:	01 c0                	add    %eax,%eax
  800407:	01 d0                	add    %edx,%eax
  800409:	89 c2                	mov    %eax,%edx
  80040b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80040e:	c1 e0 04             	shl    $0x4,%eax
  800411:	01 d0                	add    %edx,%eax
  800413:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800419:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	01 c0                	add    %eax,%eax
  800420:	01 d0                	add    %edx,%eax
  800422:	01 c0                	add    %eax,%eax
  800424:	01 d0                	add    %edx,%eax
  800426:	89 c2                	mov    %eax,%edx
  800428:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80042b:	c1 e0 04             	shl    $0x4,%eax
  80042e:	01 d0                	add    %edx,%eax
  800430:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800436:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800439:	83 ec 0c             	sub    $0xc,%esp
  80043c:	6a 00                	push   $0x0
  80043e:	6a 62                	push   $0x62
  800440:	51                   	push   %ecx
  800441:	52                   	push   %edx
  800442:	50                   	push   %eax
  800443:	e8 ed 18 00 00       	call   801d35 <tst>
  800448:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 514+1 ,0, 'e', 0);
  80044b:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80044e:	e8 8c 15 00 00       	call   8019df <sys_calculate_free_frames>
  800453:	29 c3                	sub    %eax,%ebx
  800455:	89 d8                	mov    %ebx,%eax
  800457:	83 ec 0c             	sub    $0xc,%esp
  80045a:	6a 00                	push   $0x0
  80045c:	6a 65                	push   $0x65
  80045e:	6a 00                	push   $0x0
  800460:	68 03 02 00 00       	push   $0x203
  800465:	50                   	push   %eax
  800466:	e8 ca 18 00 00       	call   801d35 <tst>
  80046b:	83 c4 20             	add    $0x20,%esp

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80046e:	e8 6c 15 00 00       	call   8019df <sys_calculate_free_frames>
  800473:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[5]);
  800476:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800479:	83 ec 0c             	sub    $0xc,%esp
  80047c:	50                   	push   %eax
  80047d:	e8 bc 12 00 00       	call   80173e <free>
  800482:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 768,0, 'e', 0);
  800485:	e8 55 15 00 00       	call   8019df <sys_calculate_free_frames>
  80048a:	89 c2                	mov    %eax,%edx
  80048c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80048f:	29 c2                	sub    %eax,%edx
  800491:	89 d0                	mov    %edx,%eax
  800493:	83 ec 0c             	sub    $0xc,%esp
  800496:	6a 00                	push   $0x0
  800498:	6a 65                	push   $0x65
  80049a:	6a 00                	push   $0x0
  80049c:	68 00 03 00 00       	push   $0x300
  8004a1:	50                   	push   %eax
  8004a2:	e8 8e 18 00 00       	call   801d35 <tst>
  8004a7:	83 c4 20             	add    $0x20,%esp

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  8004aa:	e8 30 15 00 00       	call   8019df <sys_calculate_free_frames>
  8004af:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  8004b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8004b5:	89 d0                	mov    %edx,%eax
  8004b7:	c1 e0 02             	shl    $0x2,%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004bf:	83 ec 0c             	sub    $0xc,%esp
  8004c2:	50                   	push   %eax
  8004c3:	e8 55 11 00 00       	call   80161d <malloc>
  8004c8:	83 c4 10             	add    $0x10,%esp
  8004cb:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		tst((uint32) ptr_allocations[7], USER_HEAP_START+ 9*Mega+ 24*kilo,USER_HEAP_START + 9*Mega+ 24*kilo+ PAGE_SIZE, 'b', 0);
  8004ce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8004d1:	89 d0                	mov    %edx,%eax
  8004d3:	c1 e0 03             	shl    $0x3,%eax
  8004d6:	01 d0                	add    %edx,%eax
  8004d8:	89 c1                	mov    %eax,%ecx
  8004da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004dd:	89 d0                	mov    %edx,%eax
  8004df:	01 c0                	add    %eax,%eax
  8004e1:	01 d0                	add    %edx,%eax
  8004e3:	c1 e0 03             	shl    $0x3,%eax
  8004e6:	01 c8                	add    %ecx,%eax
  8004e8:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8004ee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8004f1:	89 d0                	mov    %edx,%eax
  8004f3:	c1 e0 03             	shl    $0x3,%eax
  8004f6:	01 d0                	add    %edx,%eax
  8004f8:	89 c3                	mov    %eax,%ebx
  8004fa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004fd:	89 d0                	mov    %edx,%eax
  8004ff:	01 c0                	add    %eax,%eax
  800501:	01 d0                	add    %edx,%eax
  800503:	c1 e0 03             	shl    $0x3,%eax
  800506:	01 d8                	add    %ebx,%eax
  800508:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80050e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800511:	83 ec 0c             	sub    $0xc,%esp
  800514:	6a 00                	push   $0x0
  800516:	6a 62                	push   $0x62
  800518:	51                   	push   %ecx
  800519:	52                   	push   %edx
  80051a:	50                   	push   %eax
  80051b:	e8 15 18 00 00       	call   801d35 <tst>
  800520:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 5*Mega/4096 + 1,0, 'e', 0);
  800523:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800526:	89 d0                	mov    %edx,%eax
  800528:	c1 e0 02             	shl    $0x2,%eax
  80052b:	01 d0                	add    %edx,%eax
  80052d:	85 c0                	test   %eax,%eax
  80052f:	79 05                	jns    800536 <_main+0x4fe>
  800531:	05 ff 0f 00 00       	add    $0xfff,%eax
  800536:	c1 f8 0c             	sar    $0xc,%eax
  800539:	40                   	inc    %eax
  80053a:	89 c3                	mov    %eax,%ebx
  80053c:	8b 75 dc             	mov    -0x24(%ebp),%esi
  80053f:	e8 9b 14 00 00       	call   8019df <sys_calculate_free_frames>
  800544:	29 c6                	sub    %eax,%esi
  800546:	89 f0                	mov    %esi,%eax
  800548:	83 ec 0c             	sub    $0xc,%esp
  80054b:	6a 00                	push   $0x0
  80054d:	6a 65                	push   $0x65
  80054f:	6a 00                	push   $0x0
  800551:	53                   	push   %ebx
  800552:	50                   	push   %eax
  800553:	e8 dd 17 00 00       	call   801d35 <tst>
  800558:	83 c4 20             	add    $0x20,%esp

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  80055b:	e8 7f 14 00 00       	call   8019df <sys_calculate_free_frames>
  800560:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[6]);
  800563:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800566:	83 ec 0c             	sub    $0xc,%esp
  800569:	50                   	push   %eax
  80056a:	e8 cf 11 00 00       	call   80173e <free>
  80056f:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 514,0, 'e', 0);
  800572:	e8 68 14 00 00       	call   8019df <sys_calculate_free_frames>
  800577:	89 c2                	mov    %eax,%edx
  800579:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80057c:	29 c2                	sub    %eax,%edx
  80057e:	89 d0                	mov    %edx,%eax
  800580:	83 ec 0c             	sub    $0xc,%esp
  800583:	6a 00                	push   $0x0
  800585:	6a 65                	push   $0x65
  800587:	6a 00                	push   $0x0
  800589:	68 02 02 00 00       	push   $0x202
  80058e:	50                   	push   %eax
  80058f:	e8 a1 17 00 00       	call   801d35 <tst>
  800594:	83 c4 20             	add    $0x20,%esp

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  800597:	e8 43 14 00 00       	call   8019df <sys_calculate_free_frames>
  80059c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[8] = malloc(4*Mega-kilo);
  80059f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005a2:	c1 e0 02             	shl    $0x2,%eax
  8005a5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8005a8:	83 ec 0c             	sub    $0xc,%esp
  8005ab:	50                   	push   %eax
  8005ac:	e8 6c 10 00 00       	call   80161d <malloc>
  8005b1:	83 c4 10             	add    $0x10,%esp
  8005b4:	89 45 a8             	mov    %eax,-0x58(%ebp)
		tst((uint32) ptr_allocations[8], USER_HEAP_START+ 4*Mega+ 16*kilo,USER_HEAP_START + 4*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
  8005b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005ba:	c1 e0 02             	shl    $0x2,%eax
  8005bd:	89 c2                	mov    %eax,%edx
  8005bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005c2:	c1 e0 04             	shl    $0x4,%eax
  8005c5:	01 d0                	add    %edx,%eax
  8005c7:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8005cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d0:	c1 e0 02             	shl    $0x2,%eax
  8005d3:	89 c2                	mov    %eax,%edx
  8005d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d8:	c1 e0 04             	shl    $0x4,%eax
  8005db:	01 d0                	add    %edx,%eax
  8005dd:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8005e3:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8005e6:	83 ec 0c             	sub    $0xc,%esp
  8005e9:	6a 00                	push   $0x0
  8005eb:	6a 62                	push   $0x62
  8005ed:	51                   	push   %ecx
  8005ee:	52                   	push   %edx
  8005ef:	50                   	push   %eax
  8005f0:	e8 40 17 00 00       	call   801d35 <tst>
  8005f5:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 4*Mega/4096,0, 'e', 0);
  8005f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005fb:	c1 e0 02             	shl    $0x2,%eax
  8005fe:	85 c0                	test   %eax,%eax
  800600:	79 05                	jns    800607 <_main+0x5cf>
  800602:	05 ff 0f 00 00       	add    $0xfff,%eax
  800607:	c1 f8 0c             	sar    $0xc,%eax
  80060a:	89 c3                	mov    %eax,%ebx
  80060c:	8b 75 dc             	mov    -0x24(%ebp),%esi
  80060f:	e8 cb 13 00 00       	call   8019df <sys_calculate_free_frames>
  800614:	29 c6                	sub    %eax,%esi
  800616:	89 f0                	mov    %esi,%eax
  800618:	83 ec 0c             	sub    $0xc,%esp
  80061b:	6a 00                	push   $0x0
  80061d:	6a 65                	push   $0x65
  80061f:	6a 00                	push   $0x0
  800621:	53                   	push   %ebx
  800622:	50                   	push   %eax
  800623:	e8 0d 17 00 00       	call   801d35 <tst>
  800628:	83 c4 20             	add    $0x20,%esp
	}

	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		int freeFrames = sys_calculate_free_frames() ;
  80062b:	e8 af 13 00 00       	call   8019df <sys_calculate_free_frames>
  800630:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[9] = malloc((USER_HEAP_MAX - USER_HEAP_START + 14*Mega));
  800633:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800636:	89 d0                	mov    %edx,%eax
  800638:	01 c0                	add    %eax,%eax
  80063a:	01 d0                	add    %edx,%eax
  80063c:	01 c0                	add    %eax,%eax
  80063e:	01 d0                	add    %edx,%eax
  800640:	01 c0                	add    %eax,%eax
  800642:	05 00 00 00 20       	add    $0x20000000,%eax
  800647:	83 ec 0c             	sub    $0xc,%esp
  80064a:	50                   	push   %eax
  80064b:	e8 cd 0f 00 00       	call   80161d <malloc>
  800650:	83 c4 10             	add    $0x10,%esp
  800653:	89 45 ac             	mov    %eax,-0x54(%ebp)
		tst((uint32) ptr_allocations[9], 0,0, 'b', 0);
  800656:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800659:	83 ec 0c             	sub    $0xc,%esp
  80065c:	6a 00                	push   $0x0
  80065e:	6a 62                	push   $0x62
  800660:	6a 00                	push   $0x0
  800662:	6a 00                	push   $0x0
  800664:	50                   	push   %eax
  800665:	e8 cb 16 00 00       	call   801d35 <tst>
  80066a:	83 c4 20             	add    $0x20,%esp

		chktst(24);
  80066d:	83 ec 0c             	sub    $0xc,%esp
  800670:	6a 18                	push   $0x18
  800672:	e8 e9 16 00 00       	call   801d60 <chktst>
  800677:	83 c4 10             	add    $0x10,%esp

		return;
  80067a:	90                   	nop
	}
}
  80067b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80067e:	5b                   	pop    %ebx
  80067f:	5e                   	pop    %esi
  800680:	5f                   	pop    %edi
  800681:	5d                   	pop    %ebp
  800682:	c3                   	ret    

00800683 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
  800686:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800689:	e8 86 12 00 00       	call   801914 <sys_getenvindex>
  80068e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800691:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800694:	89 d0                	mov    %edx,%eax
  800696:	01 c0                	add    %eax,%eax
  800698:	01 d0                	add    %edx,%eax
  80069a:	c1 e0 02             	shl    $0x2,%eax
  80069d:	01 d0                	add    %edx,%eax
  80069f:	c1 e0 06             	shl    $0x6,%eax
  8006a2:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006a7:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b1:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006b7:	84 c0                	test   %al,%al
  8006b9:	74 0f                	je     8006ca <libmain+0x47>
		binaryname = myEnv->prog_name;
  8006bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c0:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006c5:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006ce:	7e 0a                	jle    8006da <libmain+0x57>
		binaryname = argv[0];
  8006d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d3:	8b 00                	mov    (%eax),%eax
  8006d5:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006da:	83 ec 08             	sub    $0x8,%esp
  8006dd:	ff 75 0c             	pushl  0xc(%ebp)
  8006e0:	ff 75 08             	pushl  0x8(%ebp)
  8006e3:	e8 50 f9 ff ff       	call   800038 <_main>
  8006e8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006eb:	e8 bf 13 00 00       	call   801aaf <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006f0:	83 ec 0c             	sub    $0xc,%esp
  8006f3:	68 f8 22 80 00       	push   $0x8022f8
  8006f8:	e8 5c 01 00 00       	call   800859 <cprintf>
  8006fd:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800700:	a1 20 30 80 00       	mov    0x803020,%eax
  800705:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80070b:	a1 20 30 80 00       	mov    0x803020,%eax
  800710:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800716:	83 ec 04             	sub    $0x4,%esp
  800719:	52                   	push   %edx
  80071a:	50                   	push   %eax
  80071b:	68 20 23 80 00       	push   $0x802320
  800720:	e8 34 01 00 00       	call   800859 <cprintf>
  800725:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800728:	a1 20 30 80 00       	mov    0x803020,%eax
  80072d:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800733:	83 ec 08             	sub    $0x8,%esp
  800736:	50                   	push   %eax
  800737:	68 45 23 80 00       	push   $0x802345
  80073c:	e8 18 01 00 00       	call   800859 <cprintf>
  800741:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800744:	83 ec 0c             	sub    $0xc,%esp
  800747:	68 f8 22 80 00       	push   $0x8022f8
  80074c:	e8 08 01 00 00       	call   800859 <cprintf>
  800751:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800754:	e8 70 13 00 00       	call   801ac9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800759:	e8 19 00 00 00       	call   800777 <exit>
}
  80075e:	90                   	nop
  80075f:	c9                   	leave  
  800760:	c3                   	ret    

00800761 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800761:	55                   	push   %ebp
  800762:	89 e5                	mov    %esp,%ebp
  800764:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800767:	83 ec 0c             	sub    $0xc,%esp
  80076a:	6a 00                	push   $0x0
  80076c:	e8 6f 11 00 00       	call   8018e0 <sys_env_destroy>
  800771:	83 c4 10             	add    $0x10,%esp
}
  800774:	90                   	nop
  800775:	c9                   	leave  
  800776:	c3                   	ret    

00800777 <exit>:

void
exit(void)
{
  800777:	55                   	push   %ebp
  800778:	89 e5                	mov    %esp,%ebp
  80077a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80077d:	e8 c4 11 00 00       	call   801946 <sys_env_exit>
}
  800782:	90                   	nop
  800783:	c9                   	leave  
  800784:	c3                   	ret    

00800785 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800785:	55                   	push   %ebp
  800786:	89 e5                	mov    %esp,%ebp
  800788:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80078b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078e:	8b 00                	mov    (%eax),%eax
  800790:	8d 48 01             	lea    0x1(%eax),%ecx
  800793:	8b 55 0c             	mov    0xc(%ebp),%edx
  800796:	89 0a                	mov    %ecx,(%edx)
  800798:	8b 55 08             	mov    0x8(%ebp),%edx
  80079b:	88 d1                	mov    %dl,%cl
  80079d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007a0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8007a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a7:	8b 00                	mov    (%eax),%eax
  8007a9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8007ae:	75 2c                	jne    8007dc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8007b0:	a0 24 30 80 00       	mov    0x803024,%al
  8007b5:	0f b6 c0             	movzbl %al,%eax
  8007b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007bb:	8b 12                	mov    (%edx),%edx
  8007bd:	89 d1                	mov    %edx,%ecx
  8007bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007c2:	83 c2 08             	add    $0x8,%edx
  8007c5:	83 ec 04             	sub    $0x4,%esp
  8007c8:	50                   	push   %eax
  8007c9:	51                   	push   %ecx
  8007ca:	52                   	push   %edx
  8007cb:	e8 ce 10 00 00       	call   80189e <sys_cputs>
  8007d0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8007d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8007dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007df:	8b 40 04             	mov    0x4(%eax),%eax
  8007e2:	8d 50 01             	lea    0x1(%eax),%edx
  8007e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e8:	89 50 04             	mov    %edx,0x4(%eax)
}
  8007eb:	90                   	nop
  8007ec:	c9                   	leave  
  8007ed:	c3                   	ret    

008007ee <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8007ee:	55                   	push   %ebp
  8007ef:	89 e5                	mov    %esp,%ebp
  8007f1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8007f7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8007fe:	00 00 00 
	b.cnt = 0;
  800801:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800808:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80080b:	ff 75 0c             	pushl  0xc(%ebp)
  80080e:	ff 75 08             	pushl  0x8(%ebp)
  800811:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800817:	50                   	push   %eax
  800818:	68 85 07 80 00       	push   $0x800785
  80081d:	e8 11 02 00 00       	call   800a33 <vprintfmt>
  800822:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800825:	a0 24 30 80 00       	mov    0x803024,%al
  80082a:	0f b6 c0             	movzbl %al,%eax
  80082d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800833:	83 ec 04             	sub    $0x4,%esp
  800836:	50                   	push   %eax
  800837:	52                   	push   %edx
  800838:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80083e:	83 c0 08             	add    $0x8,%eax
  800841:	50                   	push   %eax
  800842:	e8 57 10 00 00       	call   80189e <sys_cputs>
  800847:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80084a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800851:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800857:	c9                   	leave  
  800858:	c3                   	ret    

00800859 <cprintf>:

int cprintf(const char *fmt, ...) {
  800859:	55                   	push   %ebp
  80085a:	89 e5                	mov    %esp,%ebp
  80085c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80085f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800866:	8d 45 0c             	lea    0xc(%ebp),%eax
  800869:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80086c:	8b 45 08             	mov    0x8(%ebp),%eax
  80086f:	83 ec 08             	sub    $0x8,%esp
  800872:	ff 75 f4             	pushl  -0xc(%ebp)
  800875:	50                   	push   %eax
  800876:	e8 73 ff ff ff       	call   8007ee <vcprintf>
  80087b:	83 c4 10             	add    $0x10,%esp
  80087e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800881:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800884:	c9                   	leave  
  800885:	c3                   	ret    

00800886 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800886:	55                   	push   %ebp
  800887:	89 e5                	mov    %esp,%ebp
  800889:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80088c:	e8 1e 12 00 00       	call   801aaf <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800891:	8d 45 0c             	lea    0xc(%ebp),%eax
  800894:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800897:	8b 45 08             	mov    0x8(%ebp),%eax
  80089a:	83 ec 08             	sub    $0x8,%esp
  80089d:	ff 75 f4             	pushl  -0xc(%ebp)
  8008a0:	50                   	push   %eax
  8008a1:	e8 48 ff ff ff       	call   8007ee <vcprintf>
  8008a6:	83 c4 10             	add    $0x10,%esp
  8008a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8008ac:	e8 18 12 00 00       	call   801ac9 <sys_enable_interrupt>
	return cnt;
  8008b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008b4:	c9                   	leave  
  8008b5:	c3                   	ret    

008008b6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8008b6:	55                   	push   %ebp
  8008b7:	89 e5                	mov    %esp,%ebp
  8008b9:	53                   	push   %ebx
  8008ba:	83 ec 14             	sub    $0x14,%esp
  8008bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008c9:	8b 45 18             	mov    0x18(%ebp),%eax
  8008cc:	ba 00 00 00 00       	mov    $0x0,%edx
  8008d1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008d4:	77 55                	ja     80092b <printnum+0x75>
  8008d6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008d9:	72 05                	jb     8008e0 <printnum+0x2a>
  8008db:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008de:	77 4b                	ja     80092b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008e0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008e3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008e6:	8b 45 18             	mov    0x18(%ebp),%eax
  8008e9:	ba 00 00 00 00       	mov    $0x0,%edx
  8008ee:	52                   	push   %edx
  8008ef:	50                   	push   %eax
  8008f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f3:	ff 75 f0             	pushl  -0x10(%ebp)
  8008f6:	e8 75 17 00 00       	call   802070 <__udivdi3>
  8008fb:	83 c4 10             	add    $0x10,%esp
  8008fe:	83 ec 04             	sub    $0x4,%esp
  800901:	ff 75 20             	pushl  0x20(%ebp)
  800904:	53                   	push   %ebx
  800905:	ff 75 18             	pushl  0x18(%ebp)
  800908:	52                   	push   %edx
  800909:	50                   	push   %eax
  80090a:	ff 75 0c             	pushl  0xc(%ebp)
  80090d:	ff 75 08             	pushl  0x8(%ebp)
  800910:	e8 a1 ff ff ff       	call   8008b6 <printnum>
  800915:	83 c4 20             	add    $0x20,%esp
  800918:	eb 1a                	jmp    800934 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80091a:	83 ec 08             	sub    $0x8,%esp
  80091d:	ff 75 0c             	pushl  0xc(%ebp)
  800920:	ff 75 20             	pushl  0x20(%ebp)
  800923:	8b 45 08             	mov    0x8(%ebp),%eax
  800926:	ff d0                	call   *%eax
  800928:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80092b:	ff 4d 1c             	decl   0x1c(%ebp)
  80092e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800932:	7f e6                	jg     80091a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800934:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800937:	bb 00 00 00 00       	mov    $0x0,%ebx
  80093c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800942:	53                   	push   %ebx
  800943:	51                   	push   %ecx
  800944:	52                   	push   %edx
  800945:	50                   	push   %eax
  800946:	e8 35 18 00 00       	call   802180 <__umoddi3>
  80094b:	83 c4 10             	add    $0x10,%esp
  80094e:	05 74 25 80 00       	add    $0x802574,%eax
  800953:	8a 00                	mov    (%eax),%al
  800955:	0f be c0             	movsbl %al,%eax
  800958:	83 ec 08             	sub    $0x8,%esp
  80095b:	ff 75 0c             	pushl  0xc(%ebp)
  80095e:	50                   	push   %eax
  80095f:	8b 45 08             	mov    0x8(%ebp),%eax
  800962:	ff d0                	call   *%eax
  800964:	83 c4 10             	add    $0x10,%esp
}
  800967:	90                   	nop
  800968:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80096b:	c9                   	leave  
  80096c:	c3                   	ret    

0080096d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80096d:	55                   	push   %ebp
  80096e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800970:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800974:	7e 1c                	jle    800992 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800976:	8b 45 08             	mov    0x8(%ebp),%eax
  800979:	8b 00                	mov    (%eax),%eax
  80097b:	8d 50 08             	lea    0x8(%eax),%edx
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	89 10                	mov    %edx,(%eax)
  800983:	8b 45 08             	mov    0x8(%ebp),%eax
  800986:	8b 00                	mov    (%eax),%eax
  800988:	83 e8 08             	sub    $0x8,%eax
  80098b:	8b 50 04             	mov    0x4(%eax),%edx
  80098e:	8b 00                	mov    (%eax),%eax
  800990:	eb 40                	jmp    8009d2 <getuint+0x65>
	else if (lflag)
  800992:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800996:	74 1e                	je     8009b6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	8b 00                	mov    (%eax),%eax
  80099d:	8d 50 04             	lea    0x4(%eax),%edx
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	89 10                	mov    %edx,(%eax)
  8009a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a8:	8b 00                	mov    (%eax),%eax
  8009aa:	83 e8 04             	sub    $0x4,%eax
  8009ad:	8b 00                	mov    (%eax),%eax
  8009af:	ba 00 00 00 00       	mov    $0x0,%edx
  8009b4:	eb 1c                	jmp    8009d2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8009b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b9:	8b 00                	mov    (%eax),%eax
  8009bb:	8d 50 04             	lea    0x4(%eax),%edx
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	89 10                	mov    %edx,(%eax)
  8009c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c6:	8b 00                	mov    (%eax),%eax
  8009c8:	83 e8 04             	sub    $0x4,%eax
  8009cb:	8b 00                	mov    (%eax),%eax
  8009cd:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009d2:	5d                   	pop    %ebp
  8009d3:	c3                   	ret    

008009d4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009d4:	55                   	push   %ebp
  8009d5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009d7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009db:	7e 1c                	jle    8009f9 <getint+0x25>
		return va_arg(*ap, long long);
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	8b 00                	mov    (%eax),%eax
  8009e2:	8d 50 08             	lea    0x8(%eax),%edx
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	89 10                	mov    %edx,(%eax)
  8009ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ed:	8b 00                	mov    (%eax),%eax
  8009ef:	83 e8 08             	sub    $0x8,%eax
  8009f2:	8b 50 04             	mov    0x4(%eax),%edx
  8009f5:	8b 00                	mov    (%eax),%eax
  8009f7:	eb 38                	jmp    800a31 <getint+0x5d>
	else if (lflag)
  8009f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009fd:	74 1a                	je     800a19 <getint+0x45>
		return va_arg(*ap, long);
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	8b 00                	mov    (%eax),%eax
  800a04:	8d 50 04             	lea    0x4(%eax),%edx
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	89 10                	mov    %edx,(%eax)
  800a0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0f:	8b 00                	mov    (%eax),%eax
  800a11:	83 e8 04             	sub    $0x4,%eax
  800a14:	8b 00                	mov    (%eax),%eax
  800a16:	99                   	cltd   
  800a17:	eb 18                	jmp    800a31 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800a19:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1c:	8b 00                	mov    (%eax),%eax
  800a1e:	8d 50 04             	lea    0x4(%eax),%edx
  800a21:	8b 45 08             	mov    0x8(%ebp),%eax
  800a24:	89 10                	mov    %edx,(%eax)
  800a26:	8b 45 08             	mov    0x8(%ebp),%eax
  800a29:	8b 00                	mov    (%eax),%eax
  800a2b:	83 e8 04             	sub    $0x4,%eax
  800a2e:	8b 00                	mov    (%eax),%eax
  800a30:	99                   	cltd   
}
  800a31:	5d                   	pop    %ebp
  800a32:	c3                   	ret    

00800a33 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a33:	55                   	push   %ebp
  800a34:	89 e5                	mov    %esp,%ebp
  800a36:	56                   	push   %esi
  800a37:	53                   	push   %ebx
  800a38:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a3b:	eb 17                	jmp    800a54 <vprintfmt+0x21>
			if (ch == '\0')
  800a3d:	85 db                	test   %ebx,%ebx
  800a3f:	0f 84 af 03 00 00    	je     800df4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a45:	83 ec 08             	sub    $0x8,%esp
  800a48:	ff 75 0c             	pushl  0xc(%ebp)
  800a4b:	53                   	push   %ebx
  800a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4f:	ff d0                	call   *%eax
  800a51:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a54:	8b 45 10             	mov    0x10(%ebp),%eax
  800a57:	8d 50 01             	lea    0x1(%eax),%edx
  800a5a:	89 55 10             	mov    %edx,0x10(%ebp)
  800a5d:	8a 00                	mov    (%eax),%al
  800a5f:	0f b6 d8             	movzbl %al,%ebx
  800a62:	83 fb 25             	cmp    $0x25,%ebx
  800a65:	75 d6                	jne    800a3d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a67:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a6b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a72:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a79:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a80:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a87:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8a:	8d 50 01             	lea    0x1(%eax),%edx
  800a8d:	89 55 10             	mov    %edx,0x10(%ebp)
  800a90:	8a 00                	mov    (%eax),%al
  800a92:	0f b6 d8             	movzbl %al,%ebx
  800a95:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a98:	83 f8 55             	cmp    $0x55,%eax
  800a9b:	0f 87 2b 03 00 00    	ja     800dcc <vprintfmt+0x399>
  800aa1:	8b 04 85 98 25 80 00 	mov    0x802598(,%eax,4),%eax
  800aa8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800aaa:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800aae:	eb d7                	jmp    800a87 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ab0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ab4:	eb d1                	jmp    800a87 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ab6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800abd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ac0:	89 d0                	mov    %edx,%eax
  800ac2:	c1 e0 02             	shl    $0x2,%eax
  800ac5:	01 d0                	add    %edx,%eax
  800ac7:	01 c0                	add    %eax,%eax
  800ac9:	01 d8                	add    %ebx,%eax
  800acb:	83 e8 30             	sub    $0x30,%eax
  800ace:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad4:	8a 00                	mov    (%eax),%al
  800ad6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ad9:	83 fb 2f             	cmp    $0x2f,%ebx
  800adc:	7e 3e                	jle    800b1c <vprintfmt+0xe9>
  800ade:	83 fb 39             	cmp    $0x39,%ebx
  800ae1:	7f 39                	jg     800b1c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ae3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ae6:	eb d5                	jmp    800abd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ae8:	8b 45 14             	mov    0x14(%ebp),%eax
  800aeb:	83 c0 04             	add    $0x4,%eax
  800aee:	89 45 14             	mov    %eax,0x14(%ebp)
  800af1:	8b 45 14             	mov    0x14(%ebp),%eax
  800af4:	83 e8 04             	sub    $0x4,%eax
  800af7:	8b 00                	mov    (%eax),%eax
  800af9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800afc:	eb 1f                	jmp    800b1d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800afe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b02:	79 83                	jns    800a87 <vprintfmt+0x54>
				width = 0;
  800b04:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800b0b:	e9 77 ff ff ff       	jmp    800a87 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800b10:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800b17:	e9 6b ff ff ff       	jmp    800a87 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800b1c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800b1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b21:	0f 89 60 ff ff ff    	jns    800a87 <vprintfmt+0x54>
				width = precision, precision = -1;
  800b27:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b2a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b2d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b34:	e9 4e ff ff ff       	jmp    800a87 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b39:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b3c:	e9 46 ff ff ff       	jmp    800a87 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b41:	8b 45 14             	mov    0x14(%ebp),%eax
  800b44:	83 c0 04             	add    $0x4,%eax
  800b47:	89 45 14             	mov    %eax,0x14(%ebp)
  800b4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b4d:	83 e8 04             	sub    $0x4,%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	83 ec 08             	sub    $0x8,%esp
  800b55:	ff 75 0c             	pushl  0xc(%ebp)
  800b58:	50                   	push   %eax
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	ff d0                	call   *%eax
  800b5e:	83 c4 10             	add    $0x10,%esp
			break;
  800b61:	e9 89 02 00 00       	jmp    800def <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b66:	8b 45 14             	mov    0x14(%ebp),%eax
  800b69:	83 c0 04             	add    $0x4,%eax
  800b6c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b72:	83 e8 04             	sub    $0x4,%eax
  800b75:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b77:	85 db                	test   %ebx,%ebx
  800b79:	79 02                	jns    800b7d <vprintfmt+0x14a>
				err = -err;
  800b7b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b7d:	83 fb 64             	cmp    $0x64,%ebx
  800b80:	7f 0b                	jg     800b8d <vprintfmt+0x15a>
  800b82:	8b 34 9d e0 23 80 00 	mov    0x8023e0(,%ebx,4),%esi
  800b89:	85 f6                	test   %esi,%esi
  800b8b:	75 19                	jne    800ba6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b8d:	53                   	push   %ebx
  800b8e:	68 85 25 80 00       	push   $0x802585
  800b93:	ff 75 0c             	pushl  0xc(%ebp)
  800b96:	ff 75 08             	pushl  0x8(%ebp)
  800b99:	e8 5e 02 00 00       	call   800dfc <printfmt>
  800b9e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ba1:	e9 49 02 00 00       	jmp    800def <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ba6:	56                   	push   %esi
  800ba7:	68 8e 25 80 00       	push   $0x80258e
  800bac:	ff 75 0c             	pushl  0xc(%ebp)
  800baf:	ff 75 08             	pushl  0x8(%ebp)
  800bb2:	e8 45 02 00 00       	call   800dfc <printfmt>
  800bb7:	83 c4 10             	add    $0x10,%esp
			break;
  800bba:	e9 30 02 00 00       	jmp    800def <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800bbf:	8b 45 14             	mov    0x14(%ebp),%eax
  800bc2:	83 c0 04             	add    $0x4,%eax
  800bc5:	89 45 14             	mov    %eax,0x14(%ebp)
  800bc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bcb:	83 e8 04             	sub    $0x4,%eax
  800bce:	8b 30                	mov    (%eax),%esi
  800bd0:	85 f6                	test   %esi,%esi
  800bd2:	75 05                	jne    800bd9 <vprintfmt+0x1a6>
				p = "(null)";
  800bd4:	be 91 25 80 00       	mov    $0x802591,%esi
			if (width > 0 && padc != '-')
  800bd9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bdd:	7e 6d                	jle    800c4c <vprintfmt+0x219>
  800bdf:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800be3:	74 67                	je     800c4c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800be5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800be8:	83 ec 08             	sub    $0x8,%esp
  800beb:	50                   	push   %eax
  800bec:	56                   	push   %esi
  800bed:	e8 0c 03 00 00       	call   800efe <strnlen>
  800bf2:	83 c4 10             	add    $0x10,%esp
  800bf5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bf8:	eb 16                	jmp    800c10 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bfa:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bfe:	83 ec 08             	sub    $0x8,%esp
  800c01:	ff 75 0c             	pushl  0xc(%ebp)
  800c04:	50                   	push   %eax
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	ff d0                	call   *%eax
  800c0a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800c0d:	ff 4d e4             	decl   -0x1c(%ebp)
  800c10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c14:	7f e4                	jg     800bfa <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c16:	eb 34                	jmp    800c4c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800c18:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800c1c:	74 1c                	je     800c3a <vprintfmt+0x207>
  800c1e:	83 fb 1f             	cmp    $0x1f,%ebx
  800c21:	7e 05                	jle    800c28 <vprintfmt+0x1f5>
  800c23:	83 fb 7e             	cmp    $0x7e,%ebx
  800c26:	7e 12                	jle    800c3a <vprintfmt+0x207>
					putch('?', putdat);
  800c28:	83 ec 08             	sub    $0x8,%esp
  800c2b:	ff 75 0c             	pushl  0xc(%ebp)
  800c2e:	6a 3f                	push   $0x3f
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	ff d0                	call   *%eax
  800c35:	83 c4 10             	add    $0x10,%esp
  800c38:	eb 0f                	jmp    800c49 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c3a:	83 ec 08             	sub    $0x8,%esp
  800c3d:	ff 75 0c             	pushl  0xc(%ebp)
  800c40:	53                   	push   %ebx
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	ff d0                	call   *%eax
  800c46:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c49:	ff 4d e4             	decl   -0x1c(%ebp)
  800c4c:	89 f0                	mov    %esi,%eax
  800c4e:	8d 70 01             	lea    0x1(%eax),%esi
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	0f be d8             	movsbl %al,%ebx
  800c56:	85 db                	test   %ebx,%ebx
  800c58:	74 24                	je     800c7e <vprintfmt+0x24b>
  800c5a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c5e:	78 b8                	js     800c18 <vprintfmt+0x1e5>
  800c60:	ff 4d e0             	decl   -0x20(%ebp)
  800c63:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c67:	79 af                	jns    800c18 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c69:	eb 13                	jmp    800c7e <vprintfmt+0x24b>
				putch(' ', putdat);
  800c6b:	83 ec 08             	sub    $0x8,%esp
  800c6e:	ff 75 0c             	pushl  0xc(%ebp)
  800c71:	6a 20                	push   $0x20
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	ff d0                	call   *%eax
  800c78:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c7b:	ff 4d e4             	decl   -0x1c(%ebp)
  800c7e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c82:	7f e7                	jg     800c6b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c84:	e9 66 01 00 00       	jmp    800def <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c89:	83 ec 08             	sub    $0x8,%esp
  800c8c:	ff 75 e8             	pushl  -0x18(%ebp)
  800c8f:	8d 45 14             	lea    0x14(%ebp),%eax
  800c92:	50                   	push   %eax
  800c93:	e8 3c fd ff ff       	call   8009d4 <getint>
  800c98:	83 c4 10             	add    $0x10,%esp
  800c9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c9e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ca1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ca4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca7:	85 d2                	test   %edx,%edx
  800ca9:	79 23                	jns    800cce <vprintfmt+0x29b>
				putch('-', putdat);
  800cab:	83 ec 08             	sub    $0x8,%esp
  800cae:	ff 75 0c             	pushl  0xc(%ebp)
  800cb1:	6a 2d                	push   $0x2d
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb6:	ff d0                	call   *%eax
  800cb8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cbe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cc1:	f7 d8                	neg    %eax
  800cc3:	83 d2 00             	adc    $0x0,%edx
  800cc6:	f7 da                	neg    %edx
  800cc8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ccb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800cce:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cd5:	e9 bc 00 00 00       	jmp    800d96 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cda:	83 ec 08             	sub    $0x8,%esp
  800cdd:	ff 75 e8             	pushl  -0x18(%ebp)
  800ce0:	8d 45 14             	lea    0x14(%ebp),%eax
  800ce3:	50                   	push   %eax
  800ce4:	e8 84 fc ff ff       	call   80096d <getuint>
  800ce9:	83 c4 10             	add    $0x10,%esp
  800cec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cef:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cf2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cf9:	e9 98 00 00 00       	jmp    800d96 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cfe:	83 ec 08             	sub    $0x8,%esp
  800d01:	ff 75 0c             	pushl  0xc(%ebp)
  800d04:	6a 58                	push   $0x58
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	ff d0                	call   *%eax
  800d0b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d0e:	83 ec 08             	sub    $0x8,%esp
  800d11:	ff 75 0c             	pushl  0xc(%ebp)
  800d14:	6a 58                	push   $0x58
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	ff d0                	call   *%eax
  800d1b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d1e:	83 ec 08             	sub    $0x8,%esp
  800d21:	ff 75 0c             	pushl  0xc(%ebp)
  800d24:	6a 58                	push   $0x58
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	ff d0                	call   *%eax
  800d2b:	83 c4 10             	add    $0x10,%esp
			break;
  800d2e:	e9 bc 00 00 00       	jmp    800def <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d33:	83 ec 08             	sub    $0x8,%esp
  800d36:	ff 75 0c             	pushl  0xc(%ebp)
  800d39:	6a 30                	push   $0x30
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	ff d0                	call   *%eax
  800d40:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d43:	83 ec 08             	sub    $0x8,%esp
  800d46:	ff 75 0c             	pushl  0xc(%ebp)
  800d49:	6a 78                	push   $0x78
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	ff d0                	call   *%eax
  800d50:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d53:	8b 45 14             	mov    0x14(%ebp),%eax
  800d56:	83 c0 04             	add    $0x4,%eax
  800d59:	89 45 14             	mov    %eax,0x14(%ebp)
  800d5c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d5f:	83 e8 04             	sub    $0x4,%eax
  800d62:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d6e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d75:	eb 1f                	jmp    800d96 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d77:	83 ec 08             	sub    $0x8,%esp
  800d7a:	ff 75 e8             	pushl  -0x18(%ebp)
  800d7d:	8d 45 14             	lea    0x14(%ebp),%eax
  800d80:	50                   	push   %eax
  800d81:	e8 e7 fb ff ff       	call   80096d <getuint>
  800d86:	83 c4 10             	add    $0x10,%esp
  800d89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d8c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d8f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d96:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d9a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d9d:	83 ec 04             	sub    $0x4,%esp
  800da0:	52                   	push   %edx
  800da1:	ff 75 e4             	pushl  -0x1c(%ebp)
  800da4:	50                   	push   %eax
  800da5:	ff 75 f4             	pushl  -0xc(%ebp)
  800da8:	ff 75 f0             	pushl  -0x10(%ebp)
  800dab:	ff 75 0c             	pushl  0xc(%ebp)
  800dae:	ff 75 08             	pushl  0x8(%ebp)
  800db1:	e8 00 fb ff ff       	call   8008b6 <printnum>
  800db6:	83 c4 20             	add    $0x20,%esp
			break;
  800db9:	eb 34                	jmp    800def <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800dbb:	83 ec 08             	sub    $0x8,%esp
  800dbe:	ff 75 0c             	pushl  0xc(%ebp)
  800dc1:	53                   	push   %ebx
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	ff d0                	call   *%eax
  800dc7:	83 c4 10             	add    $0x10,%esp
			break;
  800dca:	eb 23                	jmp    800def <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800dcc:	83 ec 08             	sub    $0x8,%esp
  800dcf:	ff 75 0c             	pushl  0xc(%ebp)
  800dd2:	6a 25                	push   $0x25
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	ff d0                	call   *%eax
  800dd9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ddc:	ff 4d 10             	decl   0x10(%ebp)
  800ddf:	eb 03                	jmp    800de4 <vprintfmt+0x3b1>
  800de1:	ff 4d 10             	decl   0x10(%ebp)
  800de4:	8b 45 10             	mov    0x10(%ebp),%eax
  800de7:	48                   	dec    %eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	3c 25                	cmp    $0x25,%al
  800dec:	75 f3                	jne    800de1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800dee:	90                   	nop
		}
	}
  800def:	e9 47 fc ff ff       	jmp    800a3b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800df4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800df5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800df8:	5b                   	pop    %ebx
  800df9:	5e                   	pop    %esi
  800dfa:	5d                   	pop    %ebp
  800dfb:	c3                   	ret    

00800dfc <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800dfc:	55                   	push   %ebp
  800dfd:	89 e5                	mov    %esp,%ebp
  800dff:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800e02:	8d 45 10             	lea    0x10(%ebp),%eax
  800e05:	83 c0 04             	add    $0x4,%eax
  800e08:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800e0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800e11:	50                   	push   %eax
  800e12:	ff 75 0c             	pushl  0xc(%ebp)
  800e15:	ff 75 08             	pushl  0x8(%ebp)
  800e18:	e8 16 fc ff ff       	call   800a33 <vprintfmt>
  800e1d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e20:	90                   	nop
  800e21:	c9                   	leave  
  800e22:	c3                   	ret    

00800e23 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e23:	55                   	push   %ebp
  800e24:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e29:	8b 40 08             	mov    0x8(%eax),%eax
  800e2c:	8d 50 01             	lea    0x1(%eax),%edx
  800e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e32:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e38:	8b 10                	mov    (%eax),%edx
  800e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3d:	8b 40 04             	mov    0x4(%eax),%eax
  800e40:	39 c2                	cmp    %eax,%edx
  800e42:	73 12                	jae    800e56 <sprintputch+0x33>
		*b->buf++ = ch;
  800e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e47:	8b 00                	mov    (%eax),%eax
  800e49:	8d 48 01             	lea    0x1(%eax),%ecx
  800e4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e4f:	89 0a                	mov    %ecx,(%edx)
  800e51:	8b 55 08             	mov    0x8(%ebp),%edx
  800e54:	88 10                	mov    %dl,(%eax)
}
  800e56:	90                   	nop
  800e57:	5d                   	pop    %ebp
  800e58:	c3                   	ret    

00800e59 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e59:	55                   	push   %ebp
  800e5a:	89 e5                	mov    %esp,%ebp
  800e5c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e68:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	01 d0                	add    %edx,%eax
  800e70:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e7a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e7e:	74 06                	je     800e86 <vsnprintf+0x2d>
  800e80:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e84:	7f 07                	jg     800e8d <vsnprintf+0x34>
		return -E_INVAL;
  800e86:	b8 03 00 00 00       	mov    $0x3,%eax
  800e8b:	eb 20                	jmp    800ead <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e8d:	ff 75 14             	pushl  0x14(%ebp)
  800e90:	ff 75 10             	pushl  0x10(%ebp)
  800e93:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e96:	50                   	push   %eax
  800e97:	68 23 0e 80 00       	push   $0x800e23
  800e9c:	e8 92 fb ff ff       	call   800a33 <vprintfmt>
  800ea1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ea4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ea7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ead:	c9                   	leave  
  800eae:	c3                   	ret    

00800eaf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800eaf:	55                   	push   %ebp
  800eb0:	89 e5                	mov    %esp,%ebp
  800eb2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800eb5:	8d 45 10             	lea    0x10(%ebp),%eax
  800eb8:	83 c0 04             	add    $0x4,%eax
  800ebb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ebe:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ec4:	50                   	push   %eax
  800ec5:	ff 75 0c             	pushl  0xc(%ebp)
  800ec8:	ff 75 08             	pushl  0x8(%ebp)
  800ecb:	e8 89 ff ff ff       	call   800e59 <vsnprintf>
  800ed0:	83 c4 10             	add    $0x10,%esp
  800ed3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ed6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ed9:	c9                   	leave  
  800eda:	c3                   	ret    

00800edb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800edb:	55                   	push   %ebp
  800edc:	89 e5                	mov    %esp,%ebp
  800ede:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ee1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee8:	eb 06                	jmp    800ef0 <strlen+0x15>
		n++;
  800eea:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800eed:	ff 45 08             	incl   0x8(%ebp)
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	84 c0                	test   %al,%al
  800ef7:	75 f1                	jne    800eea <strlen+0xf>
		n++;
	return n;
  800ef9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800efc:	c9                   	leave  
  800efd:	c3                   	ret    

00800efe <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800efe:	55                   	push   %ebp
  800eff:	89 e5                	mov    %esp,%ebp
  800f01:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f0b:	eb 09                	jmp    800f16 <strnlen+0x18>
		n++;
  800f0d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f10:	ff 45 08             	incl   0x8(%ebp)
  800f13:	ff 4d 0c             	decl   0xc(%ebp)
  800f16:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f1a:	74 09                	je     800f25 <strnlen+0x27>
  800f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	84 c0                	test   %al,%al
  800f23:	75 e8                	jne    800f0d <strnlen+0xf>
		n++;
	return n;
  800f25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f28:	c9                   	leave  
  800f29:	c3                   	ret    

00800f2a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f2a:	55                   	push   %ebp
  800f2b:	89 e5                	mov    %esp,%ebp
  800f2d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f36:	90                   	nop
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8d 50 01             	lea    0x1(%eax),%edx
  800f3d:	89 55 08             	mov    %edx,0x8(%ebp)
  800f40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f43:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f46:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f49:	8a 12                	mov    (%edx),%dl
  800f4b:	88 10                	mov    %dl,(%eax)
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	84 c0                	test   %al,%al
  800f51:	75 e4                	jne    800f37 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f53:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f56:	c9                   	leave  
  800f57:	c3                   	ret    

00800f58 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f58:	55                   	push   %ebp
  800f59:	89 e5                	mov    %esp,%ebp
  800f5b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f6b:	eb 1f                	jmp    800f8c <strncpy+0x34>
		*dst++ = *src;
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	8d 50 01             	lea    0x1(%eax),%edx
  800f73:	89 55 08             	mov    %edx,0x8(%ebp)
  800f76:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f79:	8a 12                	mov    (%edx),%dl
  800f7b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	84 c0                	test   %al,%al
  800f84:	74 03                	je     800f89 <strncpy+0x31>
			src++;
  800f86:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f89:	ff 45 fc             	incl   -0x4(%ebp)
  800f8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f8f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f92:	72 d9                	jb     800f6d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f94:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f97:	c9                   	leave  
  800f98:	c3                   	ret    

00800f99 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f99:	55                   	push   %ebp
  800f9a:	89 e5                	mov    %esp,%ebp
  800f9c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800fa5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa9:	74 30                	je     800fdb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800fab:	eb 16                	jmp    800fc3 <strlcpy+0x2a>
			*dst++ = *src++;
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	8d 50 01             	lea    0x1(%eax),%edx
  800fb3:	89 55 08             	mov    %edx,0x8(%ebp)
  800fb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fbc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fbf:	8a 12                	mov    (%edx),%dl
  800fc1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800fc3:	ff 4d 10             	decl   0x10(%ebp)
  800fc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fca:	74 09                	je     800fd5 <strlcpy+0x3c>
  800fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	84 c0                	test   %al,%al
  800fd3:	75 d8                	jne    800fad <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fdb:	8b 55 08             	mov    0x8(%ebp),%edx
  800fde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe1:	29 c2                	sub    %eax,%edx
  800fe3:	89 d0                	mov    %edx,%eax
}
  800fe5:	c9                   	leave  
  800fe6:	c3                   	ret    

00800fe7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fe7:	55                   	push   %ebp
  800fe8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fea:	eb 06                	jmp    800ff2 <strcmp+0xb>
		p++, q++;
  800fec:	ff 45 08             	incl   0x8(%ebp)
  800fef:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	84 c0                	test   %al,%al
  800ff9:	74 0e                	je     801009 <strcmp+0x22>
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 10                	mov    (%eax),%dl
  801000:	8b 45 0c             	mov    0xc(%ebp),%eax
  801003:	8a 00                	mov    (%eax),%al
  801005:	38 c2                	cmp    %al,%dl
  801007:	74 e3                	je     800fec <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	8a 00                	mov    (%eax),%al
  80100e:	0f b6 d0             	movzbl %al,%edx
  801011:	8b 45 0c             	mov    0xc(%ebp),%eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	0f b6 c0             	movzbl %al,%eax
  801019:	29 c2                	sub    %eax,%edx
  80101b:	89 d0                	mov    %edx,%eax
}
  80101d:	5d                   	pop    %ebp
  80101e:	c3                   	ret    

0080101f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80101f:	55                   	push   %ebp
  801020:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801022:	eb 09                	jmp    80102d <strncmp+0xe>
		n--, p++, q++;
  801024:	ff 4d 10             	decl   0x10(%ebp)
  801027:	ff 45 08             	incl   0x8(%ebp)
  80102a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80102d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801031:	74 17                	je     80104a <strncmp+0x2b>
  801033:	8b 45 08             	mov    0x8(%ebp),%eax
  801036:	8a 00                	mov    (%eax),%al
  801038:	84 c0                	test   %al,%al
  80103a:	74 0e                	je     80104a <strncmp+0x2b>
  80103c:	8b 45 08             	mov    0x8(%ebp),%eax
  80103f:	8a 10                	mov    (%eax),%dl
  801041:	8b 45 0c             	mov    0xc(%ebp),%eax
  801044:	8a 00                	mov    (%eax),%al
  801046:	38 c2                	cmp    %al,%dl
  801048:	74 da                	je     801024 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80104a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80104e:	75 07                	jne    801057 <strncmp+0x38>
		return 0;
  801050:	b8 00 00 00 00       	mov    $0x0,%eax
  801055:	eb 14                	jmp    80106b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801057:	8b 45 08             	mov    0x8(%ebp),%eax
  80105a:	8a 00                	mov    (%eax),%al
  80105c:	0f b6 d0             	movzbl %al,%edx
  80105f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801062:	8a 00                	mov    (%eax),%al
  801064:	0f b6 c0             	movzbl %al,%eax
  801067:	29 c2                	sub    %eax,%edx
  801069:	89 d0                	mov    %edx,%eax
}
  80106b:	5d                   	pop    %ebp
  80106c:	c3                   	ret    

0080106d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80106d:	55                   	push   %ebp
  80106e:	89 e5                	mov    %esp,%ebp
  801070:	83 ec 04             	sub    $0x4,%esp
  801073:	8b 45 0c             	mov    0xc(%ebp),%eax
  801076:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801079:	eb 12                	jmp    80108d <strchr+0x20>
		if (*s == c)
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8a 00                	mov    (%eax),%al
  801080:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801083:	75 05                	jne    80108a <strchr+0x1d>
			return (char *) s;
  801085:	8b 45 08             	mov    0x8(%ebp),%eax
  801088:	eb 11                	jmp    80109b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80108a:	ff 45 08             	incl   0x8(%ebp)
  80108d:	8b 45 08             	mov    0x8(%ebp),%eax
  801090:	8a 00                	mov    (%eax),%al
  801092:	84 c0                	test   %al,%al
  801094:	75 e5                	jne    80107b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801096:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80109b:	c9                   	leave  
  80109c:	c3                   	ret    

0080109d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80109d:	55                   	push   %ebp
  80109e:	89 e5                	mov    %esp,%ebp
  8010a0:	83 ec 04             	sub    $0x4,%esp
  8010a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010a9:	eb 0d                	jmp    8010b8 <strfind+0x1b>
		if (*s == c)
  8010ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ae:	8a 00                	mov    (%eax),%al
  8010b0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010b3:	74 0e                	je     8010c3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8010b5:	ff 45 08             	incl   0x8(%ebp)
  8010b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bb:	8a 00                	mov    (%eax),%al
  8010bd:	84 c0                	test   %al,%al
  8010bf:	75 ea                	jne    8010ab <strfind+0xe>
  8010c1:	eb 01                	jmp    8010c4 <strfind+0x27>
		if (*s == c)
			break;
  8010c3:	90                   	nop
	return (char *) s;
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c7:	c9                   	leave  
  8010c8:	c3                   	ret    

008010c9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8010c9:	55                   	push   %ebp
  8010ca:	89 e5                	mov    %esp,%ebp
  8010cc:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8010d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8010db:	eb 0e                	jmp    8010eb <memset+0x22>
		*p++ = c;
  8010dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e0:	8d 50 01             	lea    0x1(%eax),%edx
  8010e3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8010eb:	ff 4d f8             	decl   -0x8(%ebp)
  8010ee:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8010f2:	79 e9                	jns    8010dd <memset+0x14>
		*p++ = c;

	return v;
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f7:	c9                   	leave  
  8010f8:	c3                   	ret    

008010f9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8010f9:	55                   	push   %ebp
  8010fa:	89 e5                	mov    %esp,%ebp
  8010fc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801102:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80110b:	eb 16                	jmp    801123 <memcpy+0x2a>
		*d++ = *s++;
  80110d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801110:	8d 50 01             	lea    0x1(%eax),%edx
  801113:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801116:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801119:	8d 4a 01             	lea    0x1(%edx),%ecx
  80111c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80111f:	8a 12                	mov    (%edx),%dl
  801121:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801123:	8b 45 10             	mov    0x10(%ebp),%eax
  801126:	8d 50 ff             	lea    -0x1(%eax),%edx
  801129:	89 55 10             	mov    %edx,0x10(%ebp)
  80112c:	85 c0                	test   %eax,%eax
  80112e:	75 dd                	jne    80110d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801133:	c9                   	leave  
  801134:	c3                   	ret    

00801135 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801135:	55                   	push   %ebp
  801136:	89 e5                	mov    %esp,%ebp
  801138:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80113b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801141:	8b 45 08             	mov    0x8(%ebp),%eax
  801144:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801147:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80114d:	73 50                	jae    80119f <memmove+0x6a>
  80114f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801152:	8b 45 10             	mov    0x10(%ebp),%eax
  801155:	01 d0                	add    %edx,%eax
  801157:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80115a:	76 43                	jbe    80119f <memmove+0x6a>
		s += n;
  80115c:	8b 45 10             	mov    0x10(%ebp),%eax
  80115f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801162:	8b 45 10             	mov    0x10(%ebp),%eax
  801165:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801168:	eb 10                	jmp    80117a <memmove+0x45>
			*--d = *--s;
  80116a:	ff 4d f8             	decl   -0x8(%ebp)
  80116d:	ff 4d fc             	decl   -0x4(%ebp)
  801170:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801173:	8a 10                	mov    (%eax),%dl
  801175:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801178:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80117a:	8b 45 10             	mov    0x10(%ebp),%eax
  80117d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801180:	89 55 10             	mov    %edx,0x10(%ebp)
  801183:	85 c0                	test   %eax,%eax
  801185:	75 e3                	jne    80116a <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801187:	eb 23                	jmp    8011ac <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801189:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80118c:	8d 50 01             	lea    0x1(%eax),%edx
  80118f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801192:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801195:	8d 4a 01             	lea    0x1(%edx),%ecx
  801198:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80119b:	8a 12                	mov    (%edx),%dl
  80119d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80119f:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a5:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a8:	85 c0                	test   %eax,%eax
  8011aa:	75 dd                	jne    801189 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011af:	c9                   	leave  
  8011b0:	c3                   	ret    

008011b1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8011b1:	55                   	push   %ebp
  8011b2:	89 e5                	mov    %esp,%ebp
  8011b4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8011bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8011c3:	eb 2a                	jmp    8011ef <memcmp+0x3e>
		if (*s1 != *s2)
  8011c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c8:	8a 10                	mov    (%eax),%dl
  8011ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	38 c2                	cmp    %al,%dl
  8011d1:	74 16                	je     8011e9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8011d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d6:	8a 00                	mov    (%eax),%al
  8011d8:	0f b6 d0             	movzbl %al,%edx
  8011db:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	0f b6 c0             	movzbl %al,%eax
  8011e3:	29 c2                	sub    %eax,%edx
  8011e5:	89 d0                	mov    %edx,%eax
  8011e7:	eb 18                	jmp    801201 <memcmp+0x50>
		s1++, s2++;
  8011e9:	ff 45 fc             	incl   -0x4(%ebp)
  8011ec:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8011ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8011f8:	85 c0                	test   %eax,%eax
  8011fa:	75 c9                	jne    8011c5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801201:	c9                   	leave  
  801202:	c3                   	ret    

00801203 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801203:	55                   	push   %ebp
  801204:	89 e5                	mov    %esp,%ebp
  801206:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801209:	8b 55 08             	mov    0x8(%ebp),%edx
  80120c:	8b 45 10             	mov    0x10(%ebp),%eax
  80120f:	01 d0                	add    %edx,%eax
  801211:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801214:	eb 15                	jmp    80122b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	0f b6 d0             	movzbl %al,%edx
  80121e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801221:	0f b6 c0             	movzbl %al,%eax
  801224:	39 c2                	cmp    %eax,%edx
  801226:	74 0d                	je     801235 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801228:	ff 45 08             	incl   0x8(%ebp)
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
  80122e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801231:	72 e3                	jb     801216 <memfind+0x13>
  801233:	eb 01                	jmp    801236 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801235:	90                   	nop
	return (void *) s;
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801239:	c9                   	leave  
  80123a:	c3                   	ret    

0080123b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80123b:	55                   	push   %ebp
  80123c:	89 e5                	mov    %esp,%ebp
  80123e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801241:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801248:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80124f:	eb 03                	jmp    801254 <strtol+0x19>
		s++;
  801251:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	3c 20                	cmp    $0x20,%al
  80125b:	74 f4                	je     801251 <strtol+0x16>
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	8a 00                	mov    (%eax),%al
  801262:	3c 09                	cmp    $0x9,%al
  801264:	74 eb                	je     801251 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	8a 00                	mov    (%eax),%al
  80126b:	3c 2b                	cmp    $0x2b,%al
  80126d:	75 05                	jne    801274 <strtol+0x39>
		s++;
  80126f:	ff 45 08             	incl   0x8(%ebp)
  801272:	eb 13                	jmp    801287 <strtol+0x4c>
	else if (*s == '-')
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	3c 2d                	cmp    $0x2d,%al
  80127b:	75 0a                	jne    801287 <strtol+0x4c>
		s++, neg = 1;
  80127d:	ff 45 08             	incl   0x8(%ebp)
  801280:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801287:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80128b:	74 06                	je     801293 <strtol+0x58>
  80128d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801291:	75 20                	jne    8012b3 <strtol+0x78>
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	8a 00                	mov    (%eax),%al
  801298:	3c 30                	cmp    $0x30,%al
  80129a:	75 17                	jne    8012b3 <strtol+0x78>
  80129c:	8b 45 08             	mov    0x8(%ebp),%eax
  80129f:	40                   	inc    %eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	3c 78                	cmp    $0x78,%al
  8012a4:	75 0d                	jne    8012b3 <strtol+0x78>
		s += 2, base = 16;
  8012a6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8012aa:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8012b1:	eb 28                	jmp    8012db <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8012b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012b7:	75 15                	jne    8012ce <strtol+0x93>
  8012b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bc:	8a 00                	mov    (%eax),%al
  8012be:	3c 30                	cmp    $0x30,%al
  8012c0:	75 0c                	jne    8012ce <strtol+0x93>
		s++, base = 8;
  8012c2:	ff 45 08             	incl   0x8(%ebp)
  8012c5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8012cc:	eb 0d                	jmp    8012db <strtol+0xa0>
	else if (base == 0)
  8012ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012d2:	75 07                	jne    8012db <strtol+0xa0>
		base = 10;
  8012d4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	8a 00                	mov    (%eax),%al
  8012e0:	3c 2f                	cmp    $0x2f,%al
  8012e2:	7e 19                	jle    8012fd <strtol+0xc2>
  8012e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e7:	8a 00                	mov    (%eax),%al
  8012e9:	3c 39                	cmp    $0x39,%al
  8012eb:	7f 10                	jg     8012fd <strtol+0xc2>
			dig = *s - '0';
  8012ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f0:	8a 00                	mov    (%eax),%al
  8012f2:	0f be c0             	movsbl %al,%eax
  8012f5:	83 e8 30             	sub    $0x30,%eax
  8012f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012fb:	eb 42                	jmp    80133f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	3c 60                	cmp    $0x60,%al
  801304:	7e 19                	jle    80131f <strtol+0xe4>
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	3c 7a                	cmp    $0x7a,%al
  80130d:	7f 10                	jg     80131f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	8a 00                	mov    (%eax),%al
  801314:	0f be c0             	movsbl %al,%eax
  801317:	83 e8 57             	sub    $0x57,%eax
  80131a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80131d:	eb 20                	jmp    80133f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	8a 00                	mov    (%eax),%al
  801324:	3c 40                	cmp    $0x40,%al
  801326:	7e 39                	jle    801361 <strtol+0x126>
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
  80132b:	8a 00                	mov    (%eax),%al
  80132d:	3c 5a                	cmp    $0x5a,%al
  80132f:	7f 30                	jg     801361 <strtol+0x126>
			dig = *s - 'A' + 10;
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	8a 00                	mov    (%eax),%al
  801336:	0f be c0             	movsbl %al,%eax
  801339:	83 e8 37             	sub    $0x37,%eax
  80133c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80133f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801342:	3b 45 10             	cmp    0x10(%ebp),%eax
  801345:	7d 19                	jge    801360 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801347:	ff 45 08             	incl   0x8(%ebp)
  80134a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801351:	89 c2                	mov    %eax,%edx
  801353:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801356:	01 d0                	add    %edx,%eax
  801358:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80135b:	e9 7b ff ff ff       	jmp    8012db <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801360:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801361:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801365:	74 08                	je     80136f <strtol+0x134>
		*endptr = (char *) s;
  801367:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136a:	8b 55 08             	mov    0x8(%ebp),%edx
  80136d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80136f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801373:	74 07                	je     80137c <strtol+0x141>
  801375:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801378:	f7 d8                	neg    %eax
  80137a:	eb 03                	jmp    80137f <strtol+0x144>
  80137c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80137f:	c9                   	leave  
  801380:	c3                   	ret    

00801381 <ltostr>:

void
ltostr(long value, char *str)
{
  801381:	55                   	push   %ebp
  801382:	89 e5                	mov    %esp,%ebp
  801384:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801387:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80138e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801395:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801399:	79 13                	jns    8013ae <ltostr+0x2d>
	{
		neg = 1;
  80139b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8013a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013a8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8013ab:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8013b6:	99                   	cltd   
  8013b7:	f7 f9                	idiv   %ecx
  8013b9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8013bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013bf:	8d 50 01             	lea    0x1(%eax),%edx
  8013c2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013c5:	89 c2                	mov    %eax,%edx
  8013c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ca:	01 d0                	add    %edx,%eax
  8013cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013cf:	83 c2 30             	add    $0x30,%edx
  8013d2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8013d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013d7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013dc:	f7 e9                	imul   %ecx
  8013de:	c1 fa 02             	sar    $0x2,%edx
  8013e1:	89 c8                	mov    %ecx,%eax
  8013e3:	c1 f8 1f             	sar    $0x1f,%eax
  8013e6:	29 c2                	sub    %eax,%edx
  8013e8:	89 d0                	mov    %edx,%eax
  8013ea:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8013ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013f0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013f5:	f7 e9                	imul   %ecx
  8013f7:	c1 fa 02             	sar    $0x2,%edx
  8013fa:	89 c8                	mov    %ecx,%eax
  8013fc:	c1 f8 1f             	sar    $0x1f,%eax
  8013ff:	29 c2                	sub    %eax,%edx
  801401:	89 d0                	mov    %edx,%eax
  801403:	c1 e0 02             	shl    $0x2,%eax
  801406:	01 d0                	add    %edx,%eax
  801408:	01 c0                	add    %eax,%eax
  80140a:	29 c1                	sub    %eax,%ecx
  80140c:	89 ca                	mov    %ecx,%edx
  80140e:	85 d2                	test   %edx,%edx
  801410:	75 9c                	jne    8013ae <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801412:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801419:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80141c:	48                   	dec    %eax
  80141d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801420:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801424:	74 3d                	je     801463 <ltostr+0xe2>
		start = 1 ;
  801426:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80142d:	eb 34                	jmp    801463 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80142f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801432:	8b 45 0c             	mov    0xc(%ebp),%eax
  801435:	01 d0                	add    %edx,%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80143c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80143f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801442:	01 c2                	add    %eax,%edx
  801444:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801447:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144a:	01 c8                	add    %ecx,%eax
  80144c:	8a 00                	mov    (%eax),%al
  80144e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801450:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801453:	8b 45 0c             	mov    0xc(%ebp),%eax
  801456:	01 c2                	add    %eax,%edx
  801458:	8a 45 eb             	mov    -0x15(%ebp),%al
  80145b:	88 02                	mov    %al,(%edx)
		start++ ;
  80145d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801460:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801463:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801466:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801469:	7c c4                	jl     80142f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80146b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80146e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801471:	01 d0                	add    %edx,%eax
  801473:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801476:	90                   	nop
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
  80147c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80147f:	ff 75 08             	pushl  0x8(%ebp)
  801482:	e8 54 fa ff ff       	call   800edb <strlen>
  801487:	83 c4 04             	add    $0x4,%esp
  80148a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80148d:	ff 75 0c             	pushl  0xc(%ebp)
  801490:	e8 46 fa ff ff       	call   800edb <strlen>
  801495:	83 c4 04             	add    $0x4,%esp
  801498:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80149b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a9:	eb 17                	jmp    8014c2 <strcconcat+0x49>
		final[s] = str1[s] ;
  8014ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b1:	01 c2                	add    %eax,%edx
  8014b3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	01 c8                	add    %ecx,%eax
  8014bb:	8a 00                	mov    (%eax),%al
  8014bd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8014bf:	ff 45 fc             	incl   -0x4(%ebp)
  8014c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014c8:	7c e1                	jl     8014ab <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8014ca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8014d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8014d8:	eb 1f                	jmp    8014f9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8014da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014dd:	8d 50 01             	lea    0x1(%eax),%edx
  8014e0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014e3:	89 c2                	mov    %eax,%edx
  8014e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e8:	01 c2                	add    %eax,%edx
  8014ea:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f0:	01 c8                	add    %ecx,%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8014f6:	ff 45 f8             	incl   -0x8(%ebp)
  8014f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014fc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014ff:	7c d9                	jl     8014da <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801501:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801504:	8b 45 10             	mov    0x10(%ebp),%eax
  801507:	01 d0                	add    %edx,%eax
  801509:	c6 00 00             	movb   $0x0,(%eax)
}
  80150c:	90                   	nop
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801512:	8b 45 14             	mov    0x14(%ebp),%eax
  801515:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80151b:	8b 45 14             	mov    0x14(%ebp),%eax
  80151e:	8b 00                	mov    (%eax),%eax
  801520:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801527:	8b 45 10             	mov    0x10(%ebp),%eax
  80152a:	01 d0                	add    %edx,%eax
  80152c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801532:	eb 0c                	jmp    801540 <strsplit+0x31>
			*string++ = 0;
  801534:	8b 45 08             	mov    0x8(%ebp),%eax
  801537:	8d 50 01             	lea    0x1(%eax),%edx
  80153a:	89 55 08             	mov    %edx,0x8(%ebp)
  80153d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801540:	8b 45 08             	mov    0x8(%ebp),%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	84 c0                	test   %al,%al
  801547:	74 18                	je     801561 <strsplit+0x52>
  801549:	8b 45 08             	mov    0x8(%ebp),%eax
  80154c:	8a 00                	mov    (%eax),%al
  80154e:	0f be c0             	movsbl %al,%eax
  801551:	50                   	push   %eax
  801552:	ff 75 0c             	pushl  0xc(%ebp)
  801555:	e8 13 fb ff ff       	call   80106d <strchr>
  80155a:	83 c4 08             	add    $0x8,%esp
  80155d:	85 c0                	test   %eax,%eax
  80155f:	75 d3                	jne    801534 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
  801564:	8a 00                	mov    (%eax),%al
  801566:	84 c0                	test   %al,%al
  801568:	74 5a                	je     8015c4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80156a:	8b 45 14             	mov    0x14(%ebp),%eax
  80156d:	8b 00                	mov    (%eax),%eax
  80156f:	83 f8 0f             	cmp    $0xf,%eax
  801572:	75 07                	jne    80157b <strsplit+0x6c>
		{
			return 0;
  801574:	b8 00 00 00 00       	mov    $0x0,%eax
  801579:	eb 66                	jmp    8015e1 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80157b:	8b 45 14             	mov    0x14(%ebp),%eax
  80157e:	8b 00                	mov    (%eax),%eax
  801580:	8d 48 01             	lea    0x1(%eax),%ecx
  801583:	8b 55 14             	mov    0x14(%ebp),%edx
  801586:	89 0a                	mov    %ecx,(%edx)
  801588:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80158f:	8b 45 10             	mov    0x10(%ebp),%eax
  801592:	01 c2                	add    %eax,%edx
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801599:	eb 03                	jmp    80159e <strsplit+0x8f>
			string++;
  80159b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	8a 00                	mov    (%eax),%al
  8015a3:	84 c0                	test   %al,%al
  8015a5:	74 8b                	je     801532 <strsplit+0x23>
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	8a 00                	mov    (%eax),%al
  8015ac:	0f be c0             	movsbl %al,%eax
  8015af:	50                   	push   %eax
  8015b0:	ff 75 0c             	pushl  0xc(%ebp)
  8015b3:	e8 b5 fa ff ff       	call   80106d <strchr>
  8015b8:	83 c4 08             	add    $0x8,%esp
  8015bb:	85 c0                	test   %eax,%eax
  8015bd:	74 dc                	je     80159b <strsplit+0x8c>
			string++;
	}
  8015bf:	e9 6e ff ff ff       	jmp    801532 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8015c4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8015c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c8:	8b 00                	mov    (%eax),%eax
  8015ca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d4:	01 d0                	add    %edx,%eax
  8015d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8015dc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
  8015e6:	83 ec 18             	sub    $0x18,%esp
  8015e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ec:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8015ef:	83 ec 04             	sub    $0x4,%esp
  8015f2:	68 f0 26 80 00       	push   $0x8026f0
  8015f7:	6a 17                	push   $0x17
  8015f9:	68 0f 27 80 00       	push   $0x80270f
  8015fe:	e8 8a 08 00 00       	call   801e8d <_panic>

00801603 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
  801606:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801609:	83 ec 04             	sub    $0x4,%esp
  80160c:	68 1b 27 80 00       	push   $0x80271b
  801611:	6a 2f                	push   $0x2f
  801613:	68 0f 27 80 00       	push   $0x80270f
  801618:	e8 70 08 00 00       	call   801e8d <_panic>

0080161d <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
  801620:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801623:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  80162a:	8b 55 08             	mov    0x8(%ebp),%edx
  80162d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801630:	01 d0                	add    %edx,%eax
  801632:	48                   	dec    %eax
  801633:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801636:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801639:	ba 00 00 00 00       	mov    $0x0,%edx
  80163e:	f7 75 ec             	divl   -0x14(%ebp)
  801641:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801644:	29 d0                	sub    %edx,%eax
  801646:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801649:	8b 45 08             	mov    0x8(%ebp),%eax
  80164c:	c1 e8 0c             	shr    $0xc,%eax
  80164f:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801652:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801659:	e9 c8 00 00 00       	jmp    801726 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80165e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801665:	eb 27                	jmp    80168e <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801667:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80166d:	01 c2                	add    %eax,%edx
  80166f:	89 d0                	mov    %edx,%eax
  801671:	01 c0                	add    %eax,%eax
  801673:	01 d0                	add    %edx,%eax
  801675:	c1 e0 02             	shl    $0x2,%eax
  801678:	05 48 30 80 00       	add    $0x803048,%eax
  80167d:	8b 00                	mov    (%eax),%eax
  80167f:	85 c0                	test   %eax,%eax
  801681:	74 08                	je     80168b <malloc+0x6e>
            	i += j;
  801683:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801686:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801689:	eb 0b                	jmp    801696 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80168b:	ff 45 f0             	incl   -0x10(%ebp)
  80168e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801691:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801694:	72 d1                	jb     801667 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801696:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801699:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80169c:	0f 85 81 00 00 00    	jne    801723 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8016a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016a5:	05 00 00 08 00       	add    $0x80000,%eax
  8016aa:	c1 e0 0c             	shl    $0xc,%eax
  8016ad:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8016b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8016b7:	eb 1f                	jmp    8016d8 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8016b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016bf:	01 c2                	add    %eax,%edx
  8016c1:	89 d0                	mov    %edx,%eax
  8016c3:	01 c0                	add    %eax,%eax
  8016c5:	01 d0                	add    %edx,%eax
  8016c7:	c1 e0 02             	shl    $0x2,%eax
  8016ca:	05 48 30 80 00       	add    $0x803048,%eax
  8016cf:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8016d5:	ff 45 f0             	incl   -0x10(%ebp)
  8016d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016db:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8016de:	72 d9                	jb     8016b9 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8016e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016e3:	89 d0                	mov    %edx,%eax
  8016e5:	01 c0                	add    %eax,%eax
  8016e7:	01 d0                	add    %edx,%eax
  8016e9:	c1 e0 02             	shl    $0x2,%eax
  8016ec:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8016f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016f5:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8016f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8016fa:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8016fd:	89 c8                	mov    %ecx,%eax
  8016ff:	01 c0                	add    %eax,%eax
  801701:	01 c8                	add    %ecx,%eax
  801703:	c1 e0 02             	shl    $0x2,%eax
  801706:	05 44 30 80 00       	add    $0x803044,%eax
  80170b:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80170d:	83 ec 08             	sub    $0x8,%esp
  801710:	ff 75 08             	pushl  0x8(%ebp)
  801713:	ff 75 e0             	pushl  -0x20(%ebp)
  801716:	e8 2b 03 00 00       	call   801a46 <sys_allocateMem>
  80171b:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80171e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801721:	eb 19                	jmp    80173c <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801723:	ff 45 f4             	incl   -0xc(%ebp)
  801726:	a1 04 30 80 00       	mov    0x803004,%eax
  80172b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80172e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801731:	0f 83 27 ff ff ff    	jae    80165e <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801737:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
  801741:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801744:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801748:	0f 84 e5 00 00 00    	je     801833 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80174e:	8b 45 08             	mov    0x8(%ebp),%eax
  801751:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801754:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801757:	05 00 00 00 80       	add    $0x80000000,%eax
  80175c:	c1 e8 0c             	shr    $0xc,%eax
  80175f:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801762:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801765:	89 d0                	mov    %edx,%eax
  801767:	01 c0                	add    %eax,%eax
  801769:	01 d0                	add    %edx,%eax
  80176b:	c1 e0 02             	shl    $0x2,%eax
  80176e:	05 40 30 80 00       	add    $0x803040,%eax
  801773:	8b 00                	mov    (%eax),%eax
  801775:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801778:	0f 85 b8 00 00 00    	jne    801836 <free+0xf8>
  80177e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801781:	89 d0                	mov    %edx,%eax
  801783:	01 c0                	add    %eax,%eax
  801785:	01 d0                	add    %edx,%eax
  801787:	c1 e0 02             	shl    $0x2,%eax
  80178a:	05 48 30 80 00       	add    $0x803048,%eax
  80178f:	8b 00                	mov    (%eax),%eax
  801791:	85 c0                	test   %eax,%eax
  801793:	0f 84 9d 00 00 00    	je     801836 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801799:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80179c:	89 d0                	mov    %edx,%eax
  80179e:	01 c0                	add    %eax,%eax
  8017a0:	01 d0                	add    %edx,%eax
  8017a2:	c1 e0 02             	shl    $0x2,%eax
  8017a5:	05 44 30 80 00       	add    $0x803044,%eax
  8017aa:	8b 00                	mov    (%eax),%eax
  8017ac:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8017af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8017b2:	c1 e0 0c             	shl    $0xc,%eax
  8017b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8017b8:	83 ec 08             	sub    $0x8,%esp
  8017bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8017be:	ff 75 f0             	pushl  -0x10(%ebp)
  8017c1:	e8 64 02 00 00       	call   801a2a <sys_freeMem>
  8017c6:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8017c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8017d0:	eb 57                	jmp    801829 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8017d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017d8:	01 c2                	add    %eax,%edx
  8017da:	89 d0                	mov    %edx,%eax
  8017dc:	01 c0                	add    %eax,%eax
  8017de:	01 d0                	add    %edx,%eax
  8017e0:	c1 e0 02             	shl    $0x2,%eax
  8017e3:	05 48 30 80 00       	add    $0x803048,%eax
  8017e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8017ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017f4:	01 c2                	add    %eax,%edx
  8017f6:	89 d0                	mov    %edx,%eax
  8017f8:	01 c0                	add    %eax,%eax
  8017fa:	01 d0                	add    %edx,%eax
  8017fc:	c1 e0 02             	shl    $0x2,%eax
  8017ff:	05 40 30 80 00       	add    $0x803040,%eax
  801804:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  80180a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80180d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801810:	01 c2                	add    %eax,%edx
  801812:	89 d0                	mov    %edx,%eax
  801814:	01 c0                	add    %eax,%eax
  801816:	01 d0                	add    %edx,%eax
  801818:	c1 e0 02             	shl    $0x2,%eax
  80181b:	05 44 30 80 00       	add    $0x803044,%eax
  801820:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801826:	ff 45 f4             	incl   -0xc(%ebp)
  801829:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80182c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80182f:	7c a1                	jl     8017d2 <free+0x94>
  801831:	eb 04                	jmp    801837 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801833:	90                   	nop
  801834:	eb 01                	jmp    801837 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801836:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801837:	c9                   	leave  
  801838:	c3                   	ret    

00801839 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801839:	55                   	push   %ebp
  80183a:	89 e5                	mov    %esp,%ebp
  80183c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80183f:	83 ec 04             	sub    $0x4,%esp
  801842:	68 38 27 80 00       	push   $0x802738
  801847:	68 ae 00 00 00       	push   $0xae
  80184c:	68 0f 27 80 00       	push   $0x80270f
  801851:	e8 37 06 00 00       	call   801e8d <_panic>

00801856 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801856:	55                   	push   %ebp
  801857:	89 e5                	mov    %esp,%ebp
  801859:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80185c:	83 ec 04             	sub    $0x4,%esp
  80185f:	68 58 27 80 00       	push   $0x802758
  801864:	68 ca 00 00 00       	push   $0xca
  801869:	68 0f 27 80 00       	push   $0x80270f
  80186e:	e8 1a 06 00 00       	call   801e8d <_panic>

00801873 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
  801876:	57                   	push   %edi
  801877:	56                   	push   %esi
  801878:	53                   	push   %ebx
  801879:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80187c:	8b 45 08             	mov    0x8(%ebp),%eax
  80187f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801882:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801885:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801888:	8b 7d 18             	mov    0x18(%ebp),%edi
  80188b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80188e:	cd 30                	int    $0x30
  801890:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801893:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801896:	83 c4 10             	add    $0x10,%esp
  801899:	5b                   	pop    %ebx
  80189a:	5e                   	pop    %esi
  80189b:	5f                   	pop    %edi
  80189c:	5d                   	pop    %ebp
  80189d:	c3                   	ret    

0080189e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
  8018a1:	83 ec 04             	sub    $0x4,%esp
  8018a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8018aa:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	52                   	push   %edx
  8018b6:	ff 75 0c             	pushl  0xc(%ebp)
  8018b9:	50                   	push   %eax
  8018ba:	6a 00                	push   $0x0
  8018bc:	e8 b2 ff ff ff       	call   801873 <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
}
  8018c4:	90                   	nop
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 01                	push   $0x1
  8018d6:	e8 98 ff ff ff       	call   801873 <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
}
  8018de:	c9                   	leave  
  8018df:	c3                   	ret    

008018e0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8018e0:	55                   	push   %ebp
  8018e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	50                   	push   %eax
  8018ef:	6a 05                	push   $0x5
  8018f1:	e8 7d ff ff ff       	call   801873 <syscall>
  8018f6:	83 c4 18             	add    $0x18,%esp
}
  8018f9:	c9                   	leave  
  8018fa:	c3                   	ret    

008018fb <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018fb:	55                   	push   %ebp
  8018fc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 02                	push   $0x2
  80190a:	e8 64 ff ff ff       	call   801873 <syscall>
  80190f:	83 c4 18             	add    $0x18,%esp
}
  801912:	c9                   	leave  
  801913:	c3                   	ret    

00801914 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	6a 03                	push   $0x3
  801923:	e8 4b ff ff ff       	call   801873 <syscall>
  801928:	83 c4 18             	add    $0x18,%esp
}
  80192b:	c9                   	leave  
  80192c:	c3                   	ret    

0080192d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80192d:	55                   	push   %ebp
  80192e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 04                	push   $0x4
  80193c:	e8 32 ff ff ff       	call   801873 <syscall>
  801941:	83 c4 18             	add    $0x18,%esp
}
  801944:	c9                   	leave  
  801945:	c3                   	ret    

00801946 <sys_env_exit>:


void sys_env_exit(void)
{
  801946:	55                   	push   %ebp
  801947:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 06                	push   $0x6
  801955:	e8 19 ff ff ff       	call   801873 <syscall>
  80195a:	83 c4 18             	add    $0x18,%esp
}
  80195d:	90                   	nop
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801963:	8b 55 0c             	mov    0xc(%ebp),%edx
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	52                   	push   %edx
  801970:	50                   	push   %eax
  801971:	6a 07                	push   $0x7
  801973:	e8 fb fe ff ff       	call   801873 <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
  801980:	56                   	push   %esi
  801981:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801982:	8b 75 18             	mov    0x18(%ebp),%esi
  801985:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801988:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80198b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198e:	8b 45 08             	mov    0x8(%ebp),%eax
  801991:	56                   	push   %esi
  801992:	53                   	push   %ebx
  801993:	51                   	push   %ecx
  801994:	52                   	push   %edx
  801995:	50                   	push   %eax
  801996:	6a 08                	push   $0x8
  801998:	e8 d6 fe ff ff       	call   801873 <syscall>
  80199d:	83 c4 18             	add    $0x18,%esp
}
  8019a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8019a3:	5b                   	pop    %ebx
  8019a4:	5e                   	pop    %esi
  8019a5:	5d                   	pop    %ebp
  8019a6:	c3                   	ret    

008019a7 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8019aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	52                   	push   %edx
  8019b7:	50                   	push   %eax
  8019b8:	6a 09                	push   $0x9
  8019ba:	e8 b4 fe ff ff       	call   801873 <syscall>
  8019bf:	83 c4 18             	add    $0x18,%esp
}
  8019c2:	c9                   	leave  
  8019c3:	c3                   	ret    

008019c4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8019c4:	55                   	push   %ebp
  8019c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	ff 75 0c             	pushl  0xc(%ebp)
  8019d0:	ff 75 08             	pushl  0x8(%ebp)
  8019d3:	6a 0a                	push   $0xa
  8019d5:	e8 99 fe ff ff       	call   801873 <syscall>
  8019da:	83 c4 18             	add    $0x18,%esp
}
  8019dd:	c9                   	leave  
  8019de:	c3                   	ret    

008019df <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8019df:	55                   	push   %ebp
  8019e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 0b                	push   $0xb
  8019ee:	e8 80 fe ff ff       	call   801873 <syscall>
  8019f3:	83 c4 18             	add    $0x18,%esp
}
  8019f6:	c9                   	leave  
  8019f7:	c3                   	ret    

008019f8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019f8:	55                   	push   %ebp
  8019f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 0c                	push   $0xc
  801a07:	e8 67 fe ff ff       	call   801873 <syscall>
  801a0c:	83 c4 18             	add    $0x18,%esp
}
  801a0f:	c9                   	leave  
  801a10:	c3                   	ret    

00801a11 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a11:	55                   	push   %ebp
  801a12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 0d                	push   $0xd
  801a20:	e8 4e fe ff ff       	call   801873 <syscall>
  801a25:	83 c4 18             	add    $0x18,%esp
}
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	ff 75 0c             	pushl  0xc(%ebp)
  801a36:	ff 75 08             	pushl  0x8(%ebp)
  801a39:	6a 11                	push   $0x11
  801a3b:	e8 33 fe ff ff       	call   801873 <syscall>
  801a40:	83 c4 18             	add    $0x18,%esp
	return;
  801a43:	90                   	nop
}
  801a44:	c9                   	leave  
  801a45:	c3                   	ret    

00801a46 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	ff 75 0c             	pushl  0xc(%ebp)
  801a52:	ff 75 08             	pushl  0x8(%ebp)
  801a55:	6a 12                	push   $0x12
  801a57:	e8 17 fe ff ff       	call   801873 <syscall>
  801a5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5f:	90                   	nop
}
  801a60:	c9                   	leave  
  801a61:	c3                   	ret    

00801a62 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 0e                	push   $0xe
  801a71:	e8 fd fd ff ff       	call   801873 <syscall>
  801a76:	83 c4 18             	add    $0x18,%esp
}
  801a79:	c9                   	leave  
  801a7a:	c3                   	ret    

00801a7b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	ff 75 08             	pushl  0x8(%ebp)
  801a89:	6a 0f                	push   $0xf
  801a8b:	e8 e3 fd ff ff       	call   801873 <syscall>
  801a90:	83 c4 18             	add    $0x18,%esp
}
  801a93:	c9                   	leave  
  801a94:	c3                   	ret    

00801a95 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a95:	55                   	push   %ebp
  801a96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 10                	push   $0x10
  801aa4:	e8 ca fd ff ff       	call   801873 <syscall>
  801aa9:	83 c4 18             	add    $0x18,%esp
}
  801aac:	90                   	nop
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 14                	push   $0x14
  801abe:	e8 b0 fd ff ff       	call   801873 <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
}
  801ac6:	90                   	nop
  801ac7:	c9                   	leave  
  801ac8:	c3                   	ret    

00801ac9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 15                	push   $0x15
  801ad8:	e8 96 fd ff ff       	call   801873 <syscall>
  801add:	83 c4 18             	add    $0x18,%esp
}
  801ae0:	90                   	nop
  801ae1:	c9                   	leave  
  801ae2:	c3                   	ret    

00801ae3 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ae3:	55                   	push   %ebp
  801ae4:	89 e5                	mov    %esp,%ebp
  801ae6:	83 ec 04             	sub    $0x4,%esp
  801ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801aef:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	50                   	push   %eax
  801afc:	6a 16                	push   $0x16
  801afe:	e8 70 fd ff ff       	call   801873 <syscall>
  801b03:	83 c4 18             	add    $0x18,%esp
}
  801b06:	90                   	nop
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 17                	push   $0x17
  801b18:	e8 56 fd ff ff       	call   801873 <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
}
  801b20:	90                   	nop
  801b21:	c9                   	leave  
  801b22:	c3                   	ret    

00801b23 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b23:	55                   	push   %ebp
  801b24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b26:	8b 45 08             	mov    0x8(%ebp),%eax
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	ff 75 0c             	pushl  0xc(%ebp)
  801b32:	50                   	push   %eax
  801b33:	6a 18                	push   $0x18
  801b35:	e8 39 fd ff ff       	call   801873 <syscall>
  801b3a:	83 c4 18             	add    $0x18,%esp
}
  801b3d:	c9                   	leave  
  801b3e:	c3                   	ret    

00801b3f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b3f:	55                   	push   %ebp
  801b40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b45:	8b 45 08             	mov    0x8(%ebp),%eax
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	52                   	push   %edx
  801b4f:	50                   	push   %eax
  801b50:	6a 1b                	push   $0x1b
  801b52:	e8 1c fd ff ff       	call   801873 <syscall>
  801b57:	83 c4 18             	add    $0x18,%esp
}
  801b5a:	c9                   	leave  
  801b5b:	c3                   	ret    

00801b5c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b5c:	55                   	push   %ebp
  801b5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b62:	8b 45 08             	mov    0x8(%ebp),%eax
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	52                   	push   %edx
  801b6c:	50                   	push   %eax
  801b6d:	6a 19                	push   $0x19
  801b6f:	e8 ff fc ff ff       	call   801873 <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	90                   	nop
  801b78:	c9                   	leave  
  801b79:	c3                   	ret    

00801b7a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b7a:	55                   	push   %ebp
  801b7b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b80:	8b 45 08             	mov    0x8(%ebp),%eax
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	52                   	push   %edx
  801b8a:	50                   	push   %eax
  801b8b:	6a 1a                	push   $0x1a
  801b8d:	e8 e1 fc ff ff       	call   801873 <syscall>
  801b92:	83 c4 18             	add    $0x18,%esp
}
  801b95:	90                   	nop
  801b96:	c9                   	leave  
  801b97:	c3                   	ret    

00801b98 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b98:	55                   	push   %ebp
  801b99:	89 e5                	mov    %esp,%ebp
  801b9b:	83 ec 04             	sub    $0x4,%esp
  801b9e:	8b 45 10             	mov    0x10(%ebp),%eax
  801ba1:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ba4:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ba7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bab:	8b 45 08             	mov    0x8(%ebp),%eax
  801bae:	6a 00                	push   $0x0
  801bb0:	51                   	push   %ecx
  801bb1:	52                   	push   %edx
  801bb2:	ff 75 0c             	pushl  0xc(%ebp)
  801bb5:	50                   	push   %eax
  801bb6:	6a 1c                	push   $0x1c
  801bb8:	e8 b6 fc ff ff       	call   801873 <syscall>
  801bbd:	83 c4 18             	add    $0x18,%esp
}
  801bc0:	c9                   	leave  
  801bc1:	c3                   	ret    

00801bc2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801bc2:	55                   	push   %ebp
  801bc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801bc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	52                   	push   %edx
  801bd2:	50                   	push   %eax
  801bd3:	6a 1d                	push   $0x1d
  801bd5:	e8 99 fc ff ff       	call   801873 <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
}
  801bdd:	c9                   	leave  
  801bde:	c3                   	ret    

00801bdf <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801be2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801be5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be8:	8b 45 08             	mov    0x8(%ebp),%eax
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	51                   	push   %ecx
  801bf0:	52                   	push   %edx
  801bf1:	50                   	push   %eax
  801bf2:	6a 1e                	push   $0x1e
  801bf4:	e8 7a fc ff ff       	call   801873 <syscall>
  801bf9:	83 c4 18             	add    $0x18,%esp
}
  801bfc:	c9                   	leave  
  801bfd:	c3                   	ret    

00801bfe <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801bfe:	55                   	push   %ebp
  801bff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c01:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c04:	8b 45 08             	mov    0x8(%ebp),%eax
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	52                   	push   %edx
  801c0e:	50                   	push   %eax
  801c0f:	6a 1f                	push   $0x1f
  801c11:	e8 5d fc ff ff       	call   801873 <syscall>
  801c16:	83 c4 18             	add    $0x18,%esp
}
  801c19:	c9                   	leave  
  801c1a:	c3                   	ret    

00801c1b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c1b:	55                   	push   %ebp
  801c1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	6a 00                	push   $0x0
  801c28:	6a 20                	push   $0x20
  801c2a:	e8 44 fc ff ff       	call   801873 <syscall>
  801c2f:	83 c4 18             	add    $0x18,%esp
}
  801c32:	c9                   	leave  
  801c33:	c3                   	ret    

00801c34 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801c34:	55                   	push   %ebp
  801c35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801c37:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	ff 75 10             	pushl  0x10(%ebp)
  801c41:	ff 75 0c             	pushl  0xc(%ebp)
  801c44:	50                   	push   %eax
  801c45:	6a 21                	push   $0x21
  801c47:	e8 27 fc ff ff       	call   801873 <syscall>
  801c4c:	83 c4 18             	add    $0x18,%esp
}
  801c4f:	c9                   	leave  
  801c50:	c3                   	ret    

00801c51 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c51:	55                   	push   %ebp
  801c52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c54:	8b 45 08             	mov    0x8(%ebp),%eax
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	50                   	push   %eax
  801c60:	6a 22                	push   $0x22
  801c62:	e8 0c fc ff ff       	call   801873 <syscall>
  801c67:	83 c4 18             	add    $0x18,%esp
}
  801c6a:	90                   	nop
  801c6b:	c9                   	leave  
  801c6c:	c3                   	ret    

00801c6d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c6d:	55                   	push   %ebp
  801c6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c70:	8b 45 08             	mov    0x8(%ebp),%eax
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	50                   	push   %eax
  801c7c:	6a 23                	push   $0x23
  801c7e:	e8 f0 fb ff ff       	call   801873 <syscall>
  801c83:	83 c4 18             	add    $0x18,%esp
}
  801c86:	90                   	nop
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
  801c8c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c8f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c92:	8d 50 04             	lea    0x4(%eax),%edx
  801c95:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 00                	push   $0x0
  801c9e:	52                   	push   %edx
  801c9f:	50                   	push   %eax
  801ca0:	6a 24                	push   $0x24
  801ca2:	e8 cc fb ff ff       	call   801873 <syscall>
  801ca7:	83 c4 18             	add    $0x18,%esp
	return result;
  801caa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801cad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cb0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801cb3:	89 01                	mov    %eax,(%ecx)
  801cb5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbb:	c9                   	leave  
  801cbc:	c2 04 00             	ret    $0x4

00801cbf <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801cbf:	55                   	push   %ebp
  801cc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	ff 75 10             	pushl  0x10(%ebp)
  801cc9:	ff 75 0c             	pushl  0xc(%ebp)
  801ccc:	ff 75 08             	pushl  0x8(%ebp)
  801ccf:	6a 13                	push   $0x13
  801cd1:	e8 9d fb ff ff       	call   801873 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
	return ;
  801cd9:	90                   	nop
}
  801cda:	c9                   	leave  
  801cdb:	c3                   	ret    

00801cdc <sys_rcr2>:
uint32 sys_rcr2()
{
  801cdc:	55                   	push   %ebp
  801cdd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 25                	push   $0x25
  801ceb:	e8 83 fb ff ff       	call   801873 <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
}
  801cf3:	c9                   	leave  
  801cf4:	c3                   	ret    

00801cf5 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801cf5:	55                   	push   %ebp
  801cf6:	89 e5                	mov    %esp,%ebp
  801cf8:	83 ec 04             	sub    $0x4,%esp
  801cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfe:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d01:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	50                   	push   %eax
  801d0e:	6a 26                	push   $0x26
  801d10:	e8 5e fb ff ff       	call   801873 <syscall>
  801d15:	83 c4 18             	add    $0x18,%esp
	return ;
  801d18:	90                   	nop
}
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <rsttst>:
void rsttst()
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 28                	push   $0x28
  801d2a:	e8 44 fb ff ff       	call   801873 <syscall>
  801d2f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d32:	90                   	nop
}
  801d33:	c9                   	leave  
  801d34:	c3                   	ret    

00801d35 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d35:	55                   	push   %ebp
  801d36:	89 e5                	mov    %esp,%ebp
  801d38:	83 ec 04             	sub    $0x4,%esp
  801d3b:	8b 45 14             	mov    0x14(%ebp),%eax
  801d3e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d41:	8b 55 18             	mov    0x18(%ebp),%edx
  801d44:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d48:	52                   	push   %edx
  801d49:	50                   	push   %eax
  801d4a:	ff 75 10             	pushl  0x10(%ebp)
  801d4d:	ff 75 0c             	pushl  0xc(%ebp)
  801d50:	ff 75 08             	pushl  0x8(%ebp)
  801d53:	6a 27                	push   $0x27
  801d55:	e8 19 fb ff ff       	call   801873 <syscall>
  801d5a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d5d:	90                   	nop
}
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <chktst>:
void chktst(uint32 n)
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	ff 75 08             	pushl  0x8(%ebp)
  801d6e:	6a 29                	push   $0x29
  801d70:	e8 fe fa ff ff       	call   801873 <syscall>
  801d75:	83 c4 18             	add    $0x18,%esp
	return ;
  801d78:	90                   	nop
}
  801d79:	c9                   	leave  
  801d7a:	c3                   	ret    

00801d7b <inctst>:

void inctst()
{
  801d7b:	55                   	push   %ebp
  801d7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	6a 2a                	push   $0x2a
  801d8a:	e8 e4 fa ff ff       	call   801873 <syscall>
  801d8f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d92:	90                   	nop
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <gettst>:
uint32 gettst()
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 2b                	push   $0x2b
  801da4:	e8 ca fa ff ff       	call   801873 <syscall>
  801da9:	83 c4 18             	add    $0x18,%esp
}
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
  801db1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 2c                	push   $0x2c
  801dc0:	e8 ae fa ff ff       	call   801873 <syscall>
  801dc5:	83 c4 18             	add    $0x18,%esp
  801dc8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801dcb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801dcf:	75 07                	jne    801dd8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801dd1:	b8 01 00 00 00       	mov    $0x1,%eax
  801dd6:	eb 05                	jmp    801ddd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801dd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ddd:	c9                   	leave  
  801dde:	c3                   	ret    

00801ddf <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
  801de2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 2c                	push   $0x2c
  801df1:	e8 7d fa ff ff       	call   801873 <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
  801df9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801dfc:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e00:	75 07                	jne    801e09 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e02:	b8 01 00 00 00       	mov    $0x1,%eax
  801e07:	eb 05                	jmp    801e0e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801e09:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e0e:	c9                   	leave  
  801e0f:	c3                   	ret    

00801e10 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e10:	55                   	push   %ebp
  801e11:	89 e5                	mov    %esp,%ebp
  801e13:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 2c                	push   $0x2c
  801e22:	e8 4c fa ff ff       	call   801873 <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
  801e2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e2d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e31:	75 07                	jne    801e3a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e33:	b8 01 00 00 00       	mov    $0x1,%eax
  801e38:	eb 05                	jmp    801e3f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
  801e44:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 2c                	push   $0x2c
  801e53:	e8 1b fa ff ff       	call   801873 <syscall>
  801e58:	83 c4 18             	add    $0x18,%esp
  801e5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e5e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e62:	75 07                	jne    801e6b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e64:	b8 01 00 00 00       	mov    $0x1,%eax
  801e69:	eb 05                	jmp    801e70 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e6b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e70:	c9                   	leave  
  801e71:	c3                   	ret    

00801e72 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e72:	55                   	push   %ebp
  801e73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	ff 75 08             	pushl  0x8(%ebp)
  801e80:	6a 2d                	push   $0x2d
  801e82:	e8 ec f9 ff ff       	call   801873 <syscall>
  801e87:	83 c4 18             	add    $0x18,%esp
	return ;
  801e8a:	90                   	nop
}
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
  801e90:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801e93:	8d 45 10             	lea    0x10(%ebp),%eax
  801e96:	83 c0 04             	add    $0x4,%eax
  801e99:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801e9c:	a1 40 30 98 00       	mov    0x983040,%eax
  801ea1:	85 c0                	test   %eax,%eax
  801ea3:	74 16                	je     801ebb <_panic+0x2e>
		cprintf("%s: ", argv0);
  801ea5:	a1 40 30 98 00       	mov    0x983040,%eax
  801eaa:	83 ec 08             	sub    $0x8,%esp
  801ead:	50                   	push   %eax
  801eae:	68 7c 27 80 00       	push   $0x80277c
  801eb3:	e8 a1 e9 ff ff       	call   800859 <cprintf>
  801eb8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801ebb:	a1 00 30 80 00       	mov    0x803000,%eax
  801ec0:	ff 75 0c             	pushl  0xc(%ebp)
  801ec3:	ff 75 08             	pushl  0x8(%ebp)
  801ec6:	50                   	push   %eax
  801ec7:	68 81 27 80 00       	push   $0x802781
  801ecc:	e8 88 e9 ff ff       	call   800859 <cprintf>
  801ed1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801ed4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ed7:	83 ec 08             	sub    $0x8,%esp
  801eda:	ff 75 f4             	pushl  -0xc(%ebp)
  801edd:	50                   	push   %eax
  801ede:	e8 0b e9 ff ff       	call   8007ee <vcprintf>
  801ee3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801ee6:	83 ec 08             	sub    $0x8,%esp
  801ee9:	6a 00                	push   $0x0
  801eeb:	68 9d 27 80 00       	push   $0x80279d
  801ef0:	e8 f9 e8 ff ff       	call   8007ee <vcprintf>
  801ef5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801ef8:	e8 7a e8 ff ff       	call   800777 <exit>

	// should not return here
	while (1) ;
  801efd:	eb fe                	jmp    801efd <_panic+0x70>

00801eff <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801eff:	55                   	push   %ebp
  801f00:	89 e5                	mov    %esp,%ebp
  801f02:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801f05:	a1 20 30 80 00       	mov    0x803020,%eax
  801f0a:	8b 50 74             	mov    0x74(%eax),%edx
  801f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f10:	39 c2                	cmp    %eax,%edx
  801f12:	74 14                	je     801f28 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801f14:	83 ec 04             	sub    $0x4,%esp
  801f17:	68 a0 27 80 00       	push   $0x8027a0
  801f1c:	6a 26                	push   $0x26
  801f1e:	68 ec 27 80 00       	push   $0x8027ec
  801f23:	e8 65 ff ff ff       	call   801e8d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801f28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801f2f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801f36:	e9 c2 00 00 00       	jmp    801ffd <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801f3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f3e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f45:	8b 45 08             	mov    0x8(%ebp),%eax
  801f48:	01 d0                	add    %edx,%eax
  801f4a:	8b 00                	mov    (%eax),%eax
  801f4c:	85 c0                	test   %eax,%eax
  801f4e:	75 08                	jne    801f58 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801f50:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801f53:	e9 a2 00 00 00       	jmp    801ffa <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801f58:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f5f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801f66:	eb 69                	jmp    801fd1 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801f68:	a1 20 30 80 00       	mov    0x803020,%eax
  801f6d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801f73:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f76:	89 d0                	mov    %edx,%eax
  801f78:	01 c0                	add    %eax,%eax
  801f7a:	01 d0                	add    %edx,%eax
  801f7c:	c1 e0 02             	shl    $0x2,%eax
  801f7f:	01 c8                	add    %ecx,%eax
  801f81:	8a 40 04             	mov    0x4(%eax),%al
  801f84:	84 c0                	test   %al,%al
  801f86:	75 46                	jne    801fce <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f88:	a1 20 30 80 00       	mov    0x803020,%eax
  801f8d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801f93:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f96:	89 d0                	mov    %edx,%eax
  801f98:	01 c0                	add    %eax,%eax
  801f9a:	01 d0                	add    %edx,%eax
  801f9c:	c1 e0 02             	shl    $0x2,%eax
  801f9f:	01 c8                	add    %ecx,%eax
  801fa1:	8b 00                	mov    (%eax),%eax
  801fa3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801fa6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801fa9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801fae:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801fb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fb3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801fba:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbd:	01 c8                	add    %ecx,%eax
  801fbf:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801fc1:	39 c2                	cmp    %eax,%edx
  801fc3:	75 09                	jne    801fce <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801fc5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801fcc:	eb 12                	jmp    801fe0 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801fce:	ff 45 e8             	incl   -0x18(%ebp)
  801fd1:	a1 20 30 80 00       	mov    0x803020,%eax
  801fd6:	8b 50 74             	mov    0x74(%eax),%edx
  801fd9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801fdc:	39 c2                	cmp    %eax,%edx
  801fde:	77 88                	ja     801f68 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801fe0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801fe4:	75 14                	jne    801ffa <CheckWSWithoutLastIndex+0xfb>
			panic(
  801fe6:	83 ec 04             	sub    $0x4,%esp
  801fe9:	68 f8 27 80 00       	push   $0x8027f8
  801fee:	6a 3a                	push   $0x3a
  801ff0:	68 ec 27 80 00       	push   $0x8027ec
  801ff5:	e8 93 fe ff ff       	call   801e8d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801ffa:	ff 45 f0             	incl   -0x10(%ebp)
  801ffd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802000:	3b 45 0c             	cmp    0xc(%ebp),%eax
  802003:	0f 8c 32 ff ff ff    	jl     801f3b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  802009:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802010:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802017:	eb 26                	jmp    80203f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802019:	a1 20 30 80 00       	mov    0x803020,%eax
  80201e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  802024:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802027:	89 d0                	mov    %edx,%eax
  802029:	01 c0                	add    %eax,%eax
  80202b:	01 d0                	add    %edx,%eax
  80202d:	c1 e0 02             	shl    $0x2,%eax
  802030:	01 c8                	add    %ecx,%eax
  802032:	8a 40 04             	mov    0x4(%eax),%al
  802035:	3c 01                	cmp    $0x1,%al
  802037:	75 03                	jne    80203c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  802039:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80203c:	ff 45 e0             	incl   -0x20(%ebp)
  80203f:	a1 20 30 80 00       	mov    0x803020,%eax
  802044:	8b 50 74             	mov    0x74(%eax),%edx
  802047:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80204a:	39 c2                	cmp    %eax,%edx
  80204c:	77 cb                	ja     802019 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80204e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802051:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802054:	74 14                	je     80206a <CheckWSWithoutLastIndex+0x16b>
		panic(
  802056:	83 ec 04             	sub    $0x4,%esp
  802059:	68 4c 28 80 00       	push   $0x80284c
  80205e:	6a 44                	push   $0x44
  802060:	68 ec 27 80 00       	push   $0x8027ec
  802065:	e8 23 fe ff ff       	call   801e8d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80206a:	90                   	nop
  80206b:	c9                   	leave  
  80206c:	c3                   	ret    
  80206d:	66 90                	xchg   %ax,%ax
  80206f:	90                   	nop

00802070 <__udivdi3>:
  802070:	55                   	push   %ebp
  802071:	57                   	push   %edi
  802072:	56                   	push   %esi
  802073:	53                   	push   %ebx
  802074:	83 ec 1c             	sub    $0x1c,%esp
  802077:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80207b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80207f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802083:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802087:	89 ca                	mov    %ecx,%edx
  802089:	89 f8                	mov    %edi,%eax
  80208b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80208f:	85 f6                	test   %esi,%esi
  802091:	75 2d                	jne    8020c0 <__udivdi3+0x50>
  802093:	39 cf                	cmp    %ecx,%edi
  802095:	77 65                	ja     8020fc <__udivdi3+0x8c>
  802097:	89 fd                	mov    %edi,%ebp
  802099:	85 ff                	test   %edi,%edi
  80209b:	75 0b                	jne    8020a8 <__udivdi3+0x38>
  80209d:	b8 01 00 00 00       	mov    $0x1,%eax
  8020a2:	31 d2                	xor    %edx,%edx
  8020a4:	f7 f7                	div    %edi
  8020a6:	89 c5                	mov    %eax,%ebp
  8020a8:	31 d2                	xor    %edx,%edx
  8020aa:	89 c8                	mov    %ecx,%eax
  8020ac:	f7 f5                	div    %ebp
  8020ae:	89 c1                	mov    %eax,%ecx
  8020b0:	89 d8                	mov    %ebx,%eax
  8020b2:	f7 f5                	div    %ebp
  8020b4:	89 cf                	mov    %ecx,%edi
  8020b6:	89 fa                	mov    %edi,%edx
  8020b8:	83 c4 1c             	add    $0x1c,%esp
  8020bb:	5b                   	pop    %ebx
  8020bc:	5e                   	pop    %esi
  8020bd:	5f                   	pop    %edi
  8020be:	5d                   	pop    %ebp
  8020bf:	c3                   	ret    
  8020c0:	39 ce                	cmp    %ecx,%esi
  8020c2:	77 28                	ja     8020ec <__udivdi3+0x7c>
  8020c4:	0f bd fe             	bsr    %esi,%edi
  8020c7:	83 f7 1f             	xor    $0x1f,%edi
  8020ca:	75 40                	jne    80210c <__udivdi3+0x9c>
  8020cc:	39 ce                	cmp    %ecx,%esi
  8020ce:	72 0a                	jb     8020da <__udivdi3+0x6a>
  8020d0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020d4:	0f 87 9e 00 00 00    	ja     802178 <__udivdi3+0x108>
  8020da:	b8 01 00 00 00       	mov    $0x1,%eax
  8020df:	89 fa                	mov    %edi,%edx
  8020e1:	83 c4 1c             	add    $0x1c,%esp
  8020e4:	5b                   	pop    %ebx
  8020e5:	5e                   	pop    %esi
  8020e6:	5f                   	pop    %edi
  8020e7:	5d                   	pop    %ebp
  8020e8:	c3                   	ret    
  8020e9:	8d 76 00             	lea    0x0(%esi),%esi
  8020ec:	31 ff                	xor    %edi,%edi
  8020ee:	31 c0                	xor    %eax,%eax
  8020f0:	89 fa                	mov    %edi,%edx
  8020f2:	83 c4 1c             	add    $0x1c,%esp
  8020f5:	5b                   	pop    %ebx
  8020f6:	5e                   	pop    %esi
  8020f7:	5f                   	pop    %edi
  8020f8:	5d                   	pop    %ebp
  8020f9:	c3                   	ret    
  8020fa:	66 90                	xchg   %ax,%ax
  8020fc:	89 d8                	mov    %ebx,%eax
  8020fe:	f7 f7                	div    %edi
  802100:	31 ff                	xor    %edi,%edi
  802102:	89 fa                	mov    %edi,%edx
  802104:	83 c4 1c             	add    $0x1c,%esp
  802107:	5b                   	pop    %ebx
  802108:	5e                   	pop    %esi
  802109:	5f                   	pop    %edi
  80210a:	5d                   	pop    %ebp
  80210b:	c3                   	ret    
  80210c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802111:	89 eb                	mov    %ebp,%ebx
  802113:	29 fb                	sub    %edi,%ebx
  802115:	89 f9                	mov    %edi,%ecx
  802117:	d3 e6                	shl    %cl,%esi
  802119:	89 c5                	mov    %eax,%ebp
  80211b:	88 d9                	mov    %bl,%cl
  80211d:	d3 ed                	shr    %cl,%ebp
  80211f:	89 e9                	mov    %ebp,%ecx
  802121:	09 f1                	or     %esi,%ecx
  802123:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802127:	89 f9                	mov    %edi,%ecx
  802129:	d3 e0                	shl    %cl,%eax
  80212b:	89 c5                	mov    %eax,%ebp
  80212d:	89 d6                	mov    %edx,%esi
  80212f:	88 d9                	mov    %bl,%cl
  802131:	d3 ee                	shr    %cl,%esi
  802133:	89 f9                	mov    %edi,%ecx
  802135:	d3 e2                	shl    %cl,%edx
  802137:	8b 44 24 08          	mov    0x8(%esp),%eax
  80213b:	88 d9                	mov    %bl,%cl
  80213d:	d3 e8                	shr    %cl,%eax
  80213f:	09 c2                	or     %eax,%edx
  802141:	89 d0                	mov    %edx,%eax
  802143:	89 f2                	mov    %esi,%edx
  802145:	f7 74 24 0c          	divl   0xc(%esp)
  802149:	89 d6                	mov    %edx,%esi
  80214b:	89 c3                	mov    %eax,%ebx
  80214d:	f7 e5                	mul    %ebp
  80214f:	39 d6                	cmp    %edx,%esi
  802151:	72 19                	jb     80216c <__udivdi3+0xfc>
  802153:	74 0b                	je     802160 <__udivdi3+0xf0>
  802155:	89 d8                	mov    %ebx,%eax
  802157:	31 ff                	xor    %edi,%edi
  802159:	e9 58 ff ff ff       	jmp    8020b6 <__udivdi3+0x46>
  80215e:	66 90                	xchg   %ax,%ax
  802160:	8b 54 24 08          	mov    0x8(%esp),%edx
  802164:	89 f9                	mov    %edi,%ecx
  802166:	d3 e2                	shl    %cl,%edx
  802168:	39 c2                	cmp    %eax,%edx
  80216a:	73 e9                	jae    802155 <__udivdi3+0xe5>
  80216c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80216f:	31 ff                	xor    %edi,%edi
  802171:	e9 40 ff ff ff       	jmp    8020b6 <__udivdi3+0x46>
  802176:	66 90                	xchg   %ax,%ax
  802178:	31 c0                	xor    %eax,%eax
  80217a:	e9 37 ff ff ff       	jmp    8020b6 <__udivdi3+0x46>
  80217f:	90                   	nop

00802180 <__umoddi3>:
  802180:	55                   	push   %ebp
  802181:	57                   	push   %edi
  802182:	56                   	push   %esi
  802183:	53                   	push   %ebx
  802184:	83 ec 1c             	sub    $0x1c,%esp
  802187:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80218b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80218f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802193:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802197:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80219b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80219f:	89 f3                	mov    %esi,%ebx
  8021a1:	89 fa                	mov    %edi,%edx
  8021a3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021a7:	89 34 24             	mov    %esi,(%esp)
  8021aa:	85 c0                	test   %eax,%eax
  8021ac:	75 1a                	jne    8021c8 <__umoddi3+0x48>
  8021ae:	39 f7                	cmp    %esi,%edi
  8021b0:	0f 86 a2 00 00 00    	jbe    802258 <__umoddi3+0xd8>
  8021b6:	89 c8                	mov    %ecx,%eax
  8021b8:	89 f2                	mov    %esi,%edx
  8021ba:	f7 f7                	div    %edi
  8021bc:	89 d0                	mov    %edx,%eax
  8021be:	31 d2                	xor    %edx,%edx
  8021c0:	83 c4 1c             	add    $0x1c,%esp
  8021c3:	5b                   	pop    %ebx
  8021c4:	5e                   	pop    %esi
  8021c5:	5f                   	pop    %edi
  8021c6:	5d                   	pop    %ebp
  8021c7:	c3                   	ret    
  8021c8:	39 f0                	cmp    %esi,%eax
  8021ca:	0f 87 ac 00 00 00    	ja     80227c <__umoddi3+0xfc>
  8021d0:	0f bd e8             	bsr    %eax,%ebp
  8021d3:	83 f5 1f             	xor    $0x1f,%ebp
  8021d6:	0f 84 ac 00 00 00    	je     802288 <__umoddi3+0x108>
  8021dc:	bf 20 00 00 00       	mov    $0x20,%edi
  8021e1:	29 ef                	sub    %ebp,%edi
  8021e3:	89 fe                	mov    %edi,%esi
  8021e5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021e9:	89 e9                	mov    %ebp,%ecx
  8021eb:	d3 e0                	shl    %cl,%eax
  8021ed:	89 d7                	mov    %edx,%edi
  8021ef:	89 f1                	mov    %esi,%ecx
  8021f1:	d3 ef                	shr    %cl,%edi
  8021f3:	09 c7                	or     %eax,%edi
  8021f5:	89 e9                	mov    %ebp,%ecx
  8021f7:	d3 e2                	shl    %cl,%edx
  8021f9:	89 14 24             	mov    %edx,(%esp)
  8021fc:	89 d8                	mov    %ebx,%eax
  8021fe:	d3 e0                	shl    %cl,%eax
  802200:	89 c2                	mov    %eax,%edx
  802202:	8b 44 24 08          	mov    0x8(%esp),%eax
  802206:	d3 e0                	shl    %cl,%eax
  802208:	89 44 24 04          	mov    %eax,0x4(%esp)
  80220c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802210:	89 f1                	mov    %esi,%ecx
  802212:	d3 e8                	shr    %cl,%eax
  802214:	09 d0                	or     %edx,%eax
  802216:	d3 eb                	shr    %cl,%ebx
  802218:	89 da                	mov    %ebx,%edx
  80221a:	f7 f7                	div    %edi
  80221c:	89 d3                	mov    %edx,%ebx
  80221e:	f7 24 24             	mull   (%esp)
  802221:	89 c6                	mov    %eax,%esi
  802223:	89 d1                	mov    %edx,%ecx
  802225:	39 d3                	cmp    %edx,%ebx
  802227:	0f 82 87 00 00 00    	jb     8022b4 <__umoddi3+0x134>
  80222d:	0f 84 91 00 00 00    	je     8022c4 <__umoddi3+0x144>
  802233:	8b 54 24 04          	mov    0x4(%esp),%edx
  802237:	29 f2                	sub    %esi,%edx
  802239:	19 cb                	sbb    %ecx,%ebx
  80223b:	89 d8                	mov    %ebx,%eax
  80223d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802241:	d3 e0                	shl    %cl,%eax
  802243:	89 e9                	mov    %ebp,%ecx
  802245:	d3 ea                	shr    %cl,%edx
  802247:	09 d0                	or     %edx,%eax
  802249:	89 e9                	mov    %ebp,%ecx
  80224b:	d3 eb                	shr    %cl,%ebx
  80224d:	89 da                	mov    %ebx,%edx
  80224f:	83 c4 1c             	add    $0x1c,%esp
  802252:	5b                   	pop    %ebx
  802253:	5e                   	pop    %esi
  802254:	5f                   	pop    %edi
  802255:	5d                   	pop    %ebp
  802256:	c3                   	ret    
  802257:	90                   	nop
  802258:	89 fd                	mov    %edi,%ebp
  80225a:	85 ff                	test   %edi,%edi
  80225c:	75 0b                	jne    802269 <__umoddi3+0xe9>
  80225e:	b8 01 00 00 00       	mov    $0x1,%eax
  802263:	31 d2                	xor    %edx,%edx
  802265:	f7 f7                	div    %edi
  802267:	89 c5                	mov    %eax,%ebp
  802269:	89 f0                	mov    %esi,%eax
  80226b:	31 d2                	xor    %edx,%edx
  80226d:	f7 f5                	div    %ebp
  80226f:	89 c8                	mov    %ecx,%eax
  802271:	f7 f5                	div    %ebp
  802273:	89 d0                	mov    %edx,%eax
  802275:	e9 44 ff ff ff       	jmp    8021be <__umoddi3+0x3e>
  80227a:	66 90                	xchg   %ax,%ax
  80227c:	89 c8                	mov    %ecx,%eax
  80227e:	89 f2                	mov    %esi,%edx
  802280:	83 c4 1c             	add    $0x1c,%esp
  802283:	5b                   	pop    %ebx
  802284:	5e                   	pop    %esi
  802285:	5f                   	pop    %edi
  802286:	5d                   	pop    %ebp
  802287:	c3                   	ret    
  802288:	3b 04 24             	cmp    (%esp),%eax
  80228b:	72 06                	jb     802293 <__umoddi3+0x113>
  80228d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802291:	77 0f                	ja     8022a2 <__umoddi3+0x122>
  802293:	89 f2                	mov    %esi,%edx
  802295:	29 f9                	sub    %edi,%ecx
  802297:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80229b:	89 14 24             	mov    %edx,(%esp)
  80229e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022a2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022a6:	8b 14 24             	mov    (%esp),%edx
  8022a9:	83 c4 1c             	add    $0x1c,%esp
  8022ac:	5b                   	pop    %ebx
  8022ad:	5e                   	pop    %esi
  8022ae:	5f                   	pop    %edi
  8022af:	5d                   	pop    %ebp
  8022b0:	c3                   	ret    
  8022b1:	8d 76 00             	lea    0x0(%esi),%esi
  8022b4:	2b 04 24             	sub    (%esp),%eax
  8022b7:	19 fa                	sbb    %edi,%edx
  8022b9:	89 d1                	mov    %edx,%ecx
  8022bb:	89 c6                	mov    %eax,%esi
  8022bd:	e9 71 ff ff ff       	jmp    802233 <__umoddi3+0xb3>
  8022c2:	66 90                	xchg   %ax,%ax
  8022c4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022c8:	72 ea                	jb     8022b4 <__umoddi3+0x134>
  8022ca:	89 d9                	mov    %ebx,%ecx
  8022cc:	e9 62 ff ff ff       	jmp    802233 <__umoddi3+0xb3>
