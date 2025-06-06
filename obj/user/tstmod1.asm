
obj/user/tstmod1:     file format elf32-i386


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
  800031:	e8 d8 05 00 00       	call   80060e <libmain>
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
  80003d:	83 ec 70             	sub    $0x70,%esp
	
	rsttst();
  800040:	e8 61 1c 00 00       	call   801ca6 <rsttst>
	
	

	int Mega = 1024*1024;
  800045:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  80004c:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  800053:	8d 55 8c             	lea    -0x74(%ebp),%edx
  800056:	b9 14 00 00 00       	mov    $0x14,%ecx
  80005b:	b8 00 00 00 00       	mov    $0x0,%eax
  800060:	89 d7                	mov    %edx,%edi
  800062:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800064:	e8 01 19 00 00       	call   80196a <sys_calculate_free_frames>
  800069:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  80006c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80006f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800072:	83 ec 0c             	sub    $0xc,%esp
  800075:	50                   	push   %eax
  800076:	e8 2d 15 00 00       	call   8015a8 <malloc>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 8c             	mov    %eax,-0x74(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  800081:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800084:	83 ec 0c             	sub    $0xc,%esp
  800087:	6a 00                	push   $0x0
  800089:	6a 62                	push   $0x62
  80008b:	68 00 10 00 80       	push   $0x80001000
  800090:	68 00 00 00 80       	push   $0x80000000
  800095:	50                   	push   %eax
  800096:	e8 25 1c 00 00       	call   801cc0 <tst>
  80009b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256+1 ,0, 'e', 0);
  80009e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8000a1:	e8 c4 18 00 00       	call   80196a <sys_calculate_free_frames>
  8000a6:	29 c3                	sub    %eax,%ebx
  8000a8:	89 d8                	mov    %ebx,%eax
  8000aa:	83 ec 0c             	sub    $0xc,%esp
  8000ad:	6a 00                	push   $0x0
  8000af:	6a 65                	push   $0x65
  8000b1:	6a 00                	push   $0x0
  8000b3:	68 01 01 00 00       	push   $0x101
  8000b8:	50                   	push   %eax
  8000b9:	e8 02 1c 00 00       	call   801cc0 <tst>
  8000be:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000c1:	e8 a4 18 00 00       	call   80196a <sys_calculate_free_frames>
  8000c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  8000c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000cc:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	50                   	push   %eax
  8000d3:	e8 d0 14 00 00       	call   8015a8 <malloc>
  8000d8:	83 c4 10             	add    $0x10,%esp
  8000db:	89 45 90             	mov    %eax,-0x70(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
  8000de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e1:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8000e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ea:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8000f0:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f3:	83 ec 0c             	sub    $0xc,%esp
  8000f6:	6a 00                	push   $0x0
  8000f8:	6a 62                	push   $0x62
  8000fa:	51                   	push   %ecx
  8000fb:	52                   	push   %edx
  8000fc:	50                   	push   %eax
  8000fd:	e8 be 1b 00 00       	call   801cc0 <tst>
  800102:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  800105:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800108:	e8 5d 18 00 00       	call   80196a <sys_calculate_free_frames>
  80010d:	29 c3                	sub    %eax,%ebx
  80010f:	89 d8                	mov    %ebx,%eax
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	6a 00                	push   $0x0
  800116:	6a 65                	push   $0x65
  800118:	6a 00                	push   $0x0
  80011a:	68 00 01 00 00       	push   $0x100
  80011f:	50                   	push   %eax
  800120:	e8 9b 1b 00 00       	call   801cc0 <tst>
  800125:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800128:	e8 3d 18 00 00       	call   80196a <sys_calculate_free_frames>
  80012d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800130:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800133:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800136:	83 ec 0c             	sub    $0xc,%esp
  800139:	50                   	push   %eax
  80013a:	e8 69 14 00 00       	call   8015a8 <malloc>
  80013f:	83 c4 10             	add    $0x10,%esp
  800142:	89 45 94             	mov    %eax,-0x6c(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START + 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
  800145:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800148:	01 c0                	add    %eax,%eax
  80014a:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800150:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800153:	01 c0                	add    %eax,%eax
  800155:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80015b:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	6a 00                	push   $0x0
  800163:	6a 62                	push   $0x62
  800165:	51                   	push   %ecx
  800166:	52                   	push   %edx
  800167:	50                   	push   %eax
  800168:	e8 53 1b 00 00       	call   801cc0 <tst>
  80016d:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  800170:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800173:	e8 f2 17 00 00       	call   80196a <sys_calculate_free_frames>
  800178:	29 c3                	sub    %eax,%ebx
  80017a:	89 d8                	mov    %ebx,%eax
  80017c:	83 ec 0c             	sub    $0xc,%esp
  80017f:	6a 00                	push   $0x0
  800181:	6a 65                	push   $0x65
  800183:	6a 00                	push   $0x0
  800185:	68 00 01 00 00       	push   $0x100
  80018a:	50                   	push   %eax
  80018b:	e8 30 1b 00 00       	call   801cc0 <tst>
  800190:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800193:	e8 d2 17 00 00       	call   80196a <sys_calculate_free_frames>
  800198:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  80019b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80019e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	50                   	push   %eax
  8001a5:	e8 fe 13 00 00       	call   8015a8 <malloc>
  8001aa:	83 c4 10             	add    $0x10,%esp
  8001ad:	89 45 98             	mov    %eax,-0x68(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START + 3*Mega,USER_HEAP_START + 3*Mega + PAGE_SIZE, 'b', 0);
  8001b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001b3:	89 c2                	mov    %eax,%edx
  8001b5:	01 d2                	add    %edx,%edx
  8001b7:	01 d0                	add    %edx,%eax
  8001b9:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001c2:	89 c2                	mov    %eax,%edx
  8001c4:	01 d2                	add    %edx,%edx
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8001ce:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	6a 00                	push   $0x0
  8001d6:	6a 62                	push   $0x62
  8001d8:	51                   	push   %ecx
  8001d9:	52                   	push   %edx
  8001da:	50                   	push   %eax
  8001db:	e8 e0 1a 00 00       	call   801cc0 <tst>
  8001e0:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  8001e3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8001e6:	e8 7f 17 00 00       	call   80196a <sys_calculate_free_frames>
  8001eb:	29 c3                	sub    %eax,%ebx
  8001ed:	89 d8                	mov    %ebx,%eax
  8001ef:	83 ec 0c             	sub    $0xc,%esp
  8001f2:	6a 00                	push   $0x0
  8001f4:	6a 65                	push   $0x65
  8001f6:	6a 00                	push   $0x0
  8001f8:	68 00 01 00 00       	push   $0x100
  8001fd:	50                   	push   %eax
  8001fe:	e8 bd 1a 00 00       	call   801cc0 <tst>
  800203:	83 c4 20             	add    $0x20,%esp

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800206:	e8 5f 17 00 00       	call   80196a <sys_calculate_free_frames>
  80020b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  80020e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800211:	01 c0                	add    %eax,%eax
  800213:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800216:	83 ec 0c             	sub    $0xc,%esp
  800219:	50                   	push   %eax
  80021a:	e8 89 13 00 00       	call   8015a8 <malloc>
  80021f:	83 c4 10             	add    $0x10,%esp
  800222:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START + 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  800225:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800228:	c1 e0 02             	shl    $0x2,%eax
  80022b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800231:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800234:	c1 e0 02             	shl    $0x2,%eax
  800237:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80023d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	6a 00                	push   $0x0
  800245:	6a 62                	push   $0x62
  800247:	51                   	push   %ecx
  800248:	52                   	push   %edx
  800249:	50                   	push   %eax
  80024a:	e8 71 1a 00 00       	call   801cc0 <tst>
  80024f:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  800252:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800255:	e8 10 17 00 00       	call   80196a <sys_calculate_free_frames>
  80025a:	29 c3                	sub    %eax,%ebx
  80025c:	89 d8                	mov    %ebx,%eax
  80025e:	83 ec 0c             	sub    $0xc,%esp
  800261:	6a 00                	push   $0x0
  800263:	6a 65                	push   $0x65
  800265:	6a 00                	push   $0x0
  800267:	68 01 02 00 00       	push   $0x201
  80026c:	50                   	push   %eax
  80026d:	e8 4e 1a 00 00       	call   801cc0 <tst>
  800272:	83 c4 20             	add    $0x20,%esp

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800275:	e8 f0 16 00 00       	call   80196a <sys_calculate_free_frames>
  80027a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  80027d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800280:	01 c0                	add    %eax,%eax
  800282:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800285:	83 ec 0c             	sub    $0xc,%esp
  800288:	50                   	push   %eax
  800289:	e8 1a 13 00 00       	call   8015a8 <malloc>
  80028e:	83 c4 10             	add    $0x10,%esp
  800291:	89 45 a0             	mov    %eax,-0x60(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START + 6*Mega,USER_HEAP_START + 6*Mega + PAGE_SIZE, 'b', 0);
  800294:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800297:	89 d0                	mov    %edx,%eax
  800299:	01 c0                	add    %eax,%eax
  80029b:	01 d0                	add    %edx,%eax
  80029d:	01 c0                	add    %eax,%eax
  80029f:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8002a8:	89 d0                	mov    %edx,%eax
  8002aa:	01 c0                	add    %eax,%eax
  8002ac:	01 d0                	add    %edx,%eax
  8002ae:	01 c0                	add    %eax,%eax
  8002b0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002b6:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8002b9:	83 ec 0c             	sub    $0xc,%esp
  8002bc:	6a 00                	push   $0x0
  8002be:	6a 62                	push   $0x62
  8002c0:	51                   	push   %ecx
  8002c1:	52                   	push   %edx
  8002c2:	50                   	push   %eax
  8002c3:	e8 f8 19 00 00       	call   801cc0 <tst>
  8002c8:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  8002cb:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8002ce:	e8 97 16 00 00       	call   80196a <sys_calculate_free_frames>
  8002d3:	29 c3                	sub    %eax,%ebx
  8002d5:	89 d8                	mov    %ebx,%eax
  8002d7:	83 ec 0c             	sub    $0xc,%esp
  8002da:	6a 00                	push   $0x0
  8002dc:	6a 65                	push   $0x65
  8002de:	6a 00                	push   $0x0
  8002e0:	68 00 02 00 00       	push   $0x200
  8002e5:	50                   	push   %eax
  8002e6:	e8 d5 19 00 00       	call   801cc0 <tst>
  8002eb:	83 c4 20             	add    $0x20,%esp

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8002ee:	e8 77 16 00 00       	call   80196a <sys_calculate_free_frames>
  8002f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8002f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002f9:	89 c2                	mov    %eax,%edx
  8002fb:	01 d2                	add    %edx,%edx
  8002fd:	01 d0                	add    %edx,%eax
  8002ff:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800302:	83 ec 0c             	sub    $0xc,%esp
  800305:	50                   	push   %eax
  800306:	e8 9d 12 00 00       	call   8015a8 <malloc>
  80030b:	83 c4 10             	add    $0x10,%esp
  80030e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START + 8*Mega,USER_HEAP_START + 8*Mega + PAGE_SIZE, 'b', 0);
  800311:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800314:	c1 e0 03             	shl    $0x3,%eax
  800317:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  80031d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800320:	c1 e0 03             	shl    $0x3,%eax
  800323:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800329:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80032c:	83 ec 0c             	sub    $0xc,%esp
  80032f:	6a 00                	push   $0x0
  800331:	6a 62                	push   $0x62
  800333:	51                   	push   %ecx
  800334:	52                   	push   %edx
  800335:	50                   	push   %eax
  800336:	e8 85 19 00 00       	call   801cc0 <tst>
  80033b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);
  80033e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800341:	e8 24 16 00 00       	call   80196a <sys_calculate_free_frames>
  800346:	29 c3                	sub    %eax,%ebx
  800348:	89 d8                	mov    %ebx,%eax
  80034a:	83 ec 0c             	sub    $0xc,%esp
  80034d:	6a 00                	push   $0x0
  80034f:	6a 65                	push   $0x65
  800351:	6a 00                	push   $0x0
  800353:	68 01 03 00 00       	push   $0x301
  800358:	50                   	push   %eax
  800359:	e8 62 19 00 00       	call   801cc0 <tst>
  80035e:	83 c4 20             	add    $0x20,%esp

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800361:	e8 04 16 00 00       	call   80196a <sys_calculate_free_frames>
  800366:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  800369:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80036c:	89 c2                	mov    %eax,%edx
  80036e:	01 d2                	add    %edx,%edx
  800370:	01 d0                	add    %edx,%eax
  800372:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800375:	83 ec 0c             	sub    $0xc,%esp
  800378:	50                   	push   %eax
  800379:	e8 2a 12 00 00       	call   8015a8 <malloc>
  80037e:	83 c4 10             	add    $0x10,%esp
  800381:	89 45 a8             	mov    %eax,-0x58(%ebp)
		tst((uint32) ptr_allocations[7], USER_HEAP_START + 11*Mega,USER_HEAP_START + 11*Mega + PAGE_SIZE, 'b', 0);
  800384:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800387:	89 d0                	mov    %edx,%eax
  800389:	c1 e0 02             	shl    $0x2,%eax
  80038c:	01 d0                	add    %edx,%eax
  80038e:	01 c0                	add    %eax,%eax
  800390:	01 d0                	add    %edx,%eax
  800392:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800398:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80039b:	89 d0                	mov    %edx,%eax
  80039d:	c1 e0 02             	shl    $0x2,%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	01 c0                	add    %eax,%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8003ac:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003af:	83 ec 0c             	sub    $0xc,%esp
  8003b2:	6a 00                	push   $0x0
  8003b4:	6a 62                	push   $0x62
  8003b6:	51                   	push   %ecx
  8003b7:	52                   	push   %edx
  8003b8:	50                   	push   %eax
  8003b9:	e8 02 19 00 00       	call   801cc0 <tst>
  8003be:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);
  8003c1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8003c4:	e8 a1 15 00 00       	call   80196a <sys_calculate_free_frames>
  8003c9:	29 c3                	sub    %eax,%ebx
  8003cb:	89 d8                	mov    %ebx,%eax
  8003cd:	83 ec 0c             	sub    $0xc,%esp
  8003d0:	6a 00                	push   $0x0
  8003d2:	6a 65                	push   $0x65
  8003d4:	6a 00                	push   $0x0
  8003d6:	68 01 03 00 00       	push   $0x301
  8003db:	50                   	push   %eax
  8003dc:	e8 df 18 00 00       	call   801cc0 <tst>
  8003e1:	83 c4 20             	add    $0x20,%esp
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8003e4:	e8 81 15 00 00       	call   80196a <sys_calculate_free_frames>
  8003e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[1]);
  8003ec:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003ef:	83 ec 0c             	sub    $0xc,%esp
  8003f2:	50                   	push   %eax
  8003f3:	e8 d1 12 00 00       	call   8016c9 <free>
  8003f8:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
  8003fb:	e8 6a 15 00 00       	call   80196a <sys_calculate_free_frames>
  800400:	89 c2                	mov    %eax,%edx
  800402:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800405:	29 c2                	sub    %eax,%edx
  800407:	89 d0                	mov    %edx,%eax
  800409:	83 ec 0c             	sub    $0xc,%esp
  80040c:	6a 00                	push   $0x0
  80040e:	6a 65                	push   $0x65
  800410:	6a 00                	push   $0x0
  800412:	68 00 01 00 00       	push   $0x100
  800417:	50                   	push   %eax
  800418:	e8 a3 18 00 00       	call   801cc0 <tst>
  80041d:	83 c4 20             	add    $0x20,%esp

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800420:	e8 45 15 00 00       	call   80196a <sys_calculate_free_frames>
  800425:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[4]);
  800428:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	50                   	push   %eax
  80042f:	e8 95 12 00 00       	call   8016c9 <free>
  800434:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512,0, 'e', 0);
  800437:	e8 2e 15 00 00       	call   80196a <sys_calculate_free_frames>
  80043c:	89 c2                	mov    %eax,%edx
  80043e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800441:	29 c2                	sub    %eax,%edx
  800443:	89 d0                	mov    %edx,%eax
  800445:	83 ec 0c             	sub    $0xc,%esp
  800448:	6a 00                	push   $0x0
  80044a:	6a 65                	push   $0x65
  80044c:	6a 00                	push   $0x0
  80044e:	68 00 02 00 00       	push   $0x200
  800453:	50                   	push   %eax
  800454:	e8 67 18 00 00       	call   801cc0 <tst>
  800459:	83 c4 20             	add    $0x20,%esp

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 09 15 00 00       	call   80196a <sys_calculate_free_frames>
  800461:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[6]);
  800464:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800467:	83 ec 0c             	sub    $0xc,%esp
  80046a:	50                   	push   %eax
  80046b:	e8 59 12 00 00       	call   8016c9 <free>
  800470:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 768,0, 'e', 0);
  800473:	e8 f2 14 00 00       	call   80196a <sys_calculate_free_frames>
  800478:	89 c2                	mov    %eax,%edx
  80047a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80047d:	29 c2                	sub    %eax,%edx
  80047f:	89 d0                	mov    %edx,%eax
  800481:	83 ec 0c             	sub    $0xc,%esp
  800484:	6a 00                	push   $0x0
  800486:	6a 65                	push   $0x65
  800488:	6a 00                	push   $0x0
  80048a:	68 00 03 00 00       	push   $0x300
  80048f:	50                   	push   %eax
  800490:	e8 2b 18 00 00       	call   801cc0 <tst>
  800495:	83 c4 20             	add    $0x20,%esp
	}
	int cnt = 0;
  800498:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  80049f:	e8 c6 14 00 00       	call   80196a <sys_calculate_free_frames>
  8004a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8004a7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004aa:	89 d0                	mov    %edx,%eax
  8004ac:	c1 e0 09             	shl    $0x9,%eax
  8004af:	29 d0                	sub    %edx,%eax
  8004b1:	83 ec 0c             	sub    $0xc,%esp
  8004b4:	50                   	push   %eax
  8004b5:	e8 ee 10 00 00       	call   8015a8 <malloc>
  8004ba:	83 c4 10             	add    $0x10,%esp
  8004bd:	89 45 ac             	mov    %eax,-0x54(%ebp)
		tst((uint32) ptr_allocations[8], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
  8004c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004c3:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8004c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004cc:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8004d2:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8004d5:	83 ec 0c             	sub    $0xc,%esp
  8004d8:	6a 00                	push   $0x0
  8004da:	6a 62                	push   $0x62
  8004dc:	51                   	push   %ecx
  8004dd:	52                   	push   %edx
  8004de:	50                   	push   %eax
  8004df:	e8 dc 17 00 00       	call   801cc0 <tst>
  8004e4:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 128 ,0, 'e', 0);
  8004e7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004ea:	e8 7b 14 00 00       	call   80196a <sys_calculate_free_frames>
  8004ef:	29 c3                	sub    %eax,%ebx
  8004f1:	89 d8                	mov    %ebx,%eax
  8004f3:	83 ec 0c             	sub    $0xc,%esp
  8004f6:	6a 00                	push   $0x0
  8004f8:	6a 65                	push   $0x65
  8004fa:	6a 00                	push   $0x0
  8004fc:	68 80 00 00 00       	push   $0x80
  800501:	50                   	push   %eax
  800502:	e8 b9 17 00 00       	call   801cc0 <tst>
  800507:	83 c4 20             	add    $0x20,%esp

		//Expand it
		freeFrames = sys_calculate_free_frames() ;
  80050a:	e8 5b 14 00 00       	call   80196a <sys_calculate_free_frames>
  80050f:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		//expand(ptr_allocations[8], 512*kilo + 256*kilo - kilo);

		tst((freeFrames - sys_calculate_free_frames()) , 64 ,0, 'e', 0);
  800512:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800515:	e8 50 14 00 00       	call   80196a <sys_calculate_free_frames>
  80051a:	29 c3                	sub    %eax,%ebx
  80051c:	89 d8                	mov    %ebx,%eax
  80051e:	83 ec 0c             	sub    $0xc,%esp
  800521:	6a 00                	push   $0x0
  800523:	6a 65                	push   $0x65
  800525:	6a 00                	push   $0x0
  800527:	6a 40                	push   $0x40
  800529:	50                   	push   %eax
  80052a:	e8 91 17 00 00       	call   801cc0 <tst>
  80052f:	83 c4 20             	add    $0x20,%esp

		int *intArr = (int*) ptr_allocations[8];
  800532:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800535:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int lastIndexOfInt = ((512+256)*kilo)/sizeof(int) - 1;
  800538:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80053b:	89 d0                	mov    %edx,%eax
  80053d:	01 c0                	add    %eax,%eax
  80053f:	01 d0                	add    %edx,%eax
  800541:	c1 e0 08             	shl    $0x8,%eax
  800544:	c1 e8 02             	shr    $0x2,%eax
  800547:	48                   	dec    %eax
  800548:	89 45 dc             	mov    %eax,-0x24(%ebp)

		int i = 0;
  80054b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for (i=0; i < lastIndexOfInt ; i++)
  800552:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800559:	eb 1a                	jmp    800575 <_main+0x53d>
		{
			cnt++;
  80055b:	ff 45 f4             	incl   -0xc(%ebp)
			intArr[i] = i ;
  80055e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800561:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800568:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80056b:	01 c2                	add    %eax,%edx
  80056d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800570:	89 02                	mov    %eax,(%edx)

		int *intArr = (int*) ptr_allocations[8];
		int lastIndexOfInt = ((512+256)*kilo)/sizeof(int) - 1;

		int i = 0;
		for (i=0; i < lastIndexOfInt ; i++)
  800572:	ff 45 f0             	incl   -0x10(%ebp)
  800575:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800578:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80057b:	7c de                	jl     80055b <_main+0x523>
		{
			cnt++;
			intArr[i] = i ;
		}

		for (i=0; i < lastIndexOfInt ; i++)
  80057d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800584:	eb 2a                	jmp    8005b0 <_main+0x578>
		{
			tst(intArr[i], i,0, 'e', 0);
  800586:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800589:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80058c:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
  800593:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800596:	01 ca                	add    %ecx,%edx
  800598:	8b 12                	mov    (%edx),%edx
  80059a:	83 ec 0c             	sub    $0xc,%esp
  80059d:	6a 00                	push   $0x0
  80059f:	6a 65                	push   $0x65
  8005a1:	6a 00                	push   $0x0
  8005a3:	50                   	push   %eax
  8005a4:	52                   	push   %edx
  8005a5:	e8 16 17 00 00       	call   801cc0 <tst>
  8005aa:	83 c4 20             	add    $0x20,%esp
		{
			cnt++;
			intArr[i] = i ;
		}

		for (i=0; i < lastIndexOfInt ; i++)
  8005ad:	ff 45 f0             	incl   -0x10(%ebp)
  8005b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005b3:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005b6:	7c ce                	jl     800586 <_main+0x54e>
		{
			tst(intArr[i], i,0, 'e', 0);
		}

		freeFrames = sys_calculate_free_frames() ;
  8005b8:	e8 ad 13 00 00       	call   80196a <sys_calculate_free_frames>
  8005bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[8]);
  8005c0:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8005c3:	83 ec 0c             	sub    $0xc,%esp
  8005c6:	50                   	push   %eax
  8005c7:	e8 fd 10 00 00       	call   8016c9 <free>
  8005cc:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 192 ,0, 'e', 0);
  8005cf:	e8 96 13 00 00       	call   80196a <sys_calculate_free_frames>
  8005d4:	89 c2                	mov    %eax,%edx
  8005d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d9:	29 c2                	sub    %eax,%edx
  8005db:	89 d0                	mov    %edx,%eax
  8005dd:	83 ec 0c             	sub    $0xc,%esp
  8005e0:	6a 00                	push   $0x0
  8005e2:	6a 65                	push   $0x65
  8005e4:	6a 00                	push   $0x0
  8005e6:	68 c0 00 00 00       	push   $0xc0
  8005eb:	50                   	push   %eax
  8005ec:	e8 cf 16 00 00       	call   801cc0 <tst>
  8005f1:	83 c4 20             	add    $0x20,%esp
	}


	chktst(23 + cnt);
  8005f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f7:	83 c0 17             	add    $0x17,%eax
  8005fa:	83 ec 0c             	sub    $0xc,%esp
  8005fd:	50                   	push   %eax
  8005fe:	e8 e8 16 00 00       	call   801ceb <chktst>
  800603:	83 c4 10             	add    $0x10,%esp

	return;
  800606:	90                   	nop
}
  800607:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80060a:	5b                   	pop    %ebx
  80060b:	5f                   	pop    %edi
  80060c:	5d                   	pop    %ebp
  80060d:	c3                   	ret    

0080060e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80060e:	55                   	push   %ebp
  80060f:	89 e5                	mov    %esp,%ebp
  800611:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800614:	e8 86 12 00 00       	call   80189f <sys_getenvindex>
  800619:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80061c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80061f:	89 d0                	mov    %edx,%eax
  800621:	01 c0                	add    %eax,%eax
  800623:	01 d0                	add    %edx,%eax
  800625:	c1 e0 02             	shl    $0x2,%eax
  800628:	01 d0                	add    %edx,%eax
  80062a:	c1 e0 06             	shl    $0x6,%eax
  80062d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800632:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800637:	a1 20 30 80 00       	mov    0x803020,%eax
  80063c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800642:	84 c0                	test   %al,%al
  800644:	74 0f                	je     800655 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800646:	a1 20 30 80 00       	mov    0x803020,%eax
  80064b:	05 f4 02 00 00       	add    $0x2f4,%eax
  800650:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800655:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800659:	7e 0a                	jle    800665 <libmain+0x57>
		binaryname = argv[0];
  80065b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800665:	83 ec 08             	sub    $0x8,%esp
  800668:	ff 75 0c             	pushl  0xc(%ebp)
  80066b:	ff 75 08             	pushl  0x8(%ebp)
  80066e:	e8 c5 f9 ff ff       	call   800038 <_main>
  800673:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800676:	e8 bf 13 00 00       	call   801a3a <sys_disable_interrupt>
	cprintf("**************************************\n");
  80067b:	83 ec 0c             	sub    $0xc,%esp
  80067e:	68 78 22 80 00       	push   $0x802278
  800683:	e8 5c 01 00 00       	call   8007e4 <cprintf>
  800688:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80068b:	a1 20 30 80 00       	mov    0x803020,%eax
  800690:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800696:	a1 20 30 80 00       	mov    0x803020,%eax
  80069b:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006a1:	83 ec 04             	sub    $0x4,%esp
  8006a4:	52                   	push   %edx
  8006a5:	50                   	push   %eax
  8006a6:	68 a0 22 80 00       	push   $0x8022a0
  8006ab:	e8 34 01 00 00       	call   8007e4 <cprintf>
  8006b0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b8:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8006be:	83 ec 08             	sub    $0x8,%esp
  8006c1:	50                   	push   %eax
  8006c2:	68 c5 22 80 00       	push   $0x8022c5
  8006c7:	e8 18 01 00 00       	call   8007e4 <cprintf>
  8006cc:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006cf:	83 ec 0c             	sub    $0xc,%esp
  8006d2:	68 78 22 80 00       	push   $0x802278
  8006d7:	e8 08 01 00 00       	call   8007e4 <cprintf>
  8006dc:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006df:	e8 70 13 00 00       	call   801a54 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006e4:	e8 19 00 00 00       	call   800702 <exit>
}
  8006e9:	90                   	nop
  8006ea:	c9                   	leave  
  8006eb:	c3                   	ret    

008006ec <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006ec:	55                   	push   %ebp
  8006ed:	89 e5                	mov    %esp,%ebp
  8006ef:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006f2:	83 ec 0c             	sub    $0xc,%esp
  8006f5:	6a 00                	push   $0x0
  8006f7:	e8 6f 11 00 00       	call   80186b <sys_env_destroy>
  8006fc:	83 c4 10             	add    $0x10,%esp
}
  8006ff:	90                   	nop
  800700:	c9                   	leave  
  800701:	c3                   	ret    

00800702 <exit>:

void
exit(void)
{
  800702:	55                   	push   %ebp
  800703:	89 e5                	mov    %esp,%ebp
  800705:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800708:	e8 c4 11 00 00       	call   8018d1 <sys_env_exit>
}
  80070d:	90                   	nop
  80070e:	c9                   	leave  
  80070f:	c3                   	ret    

00800710 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800710:	55                   	push   %ebp
  800711:	89 e5                	mov    %esp,%ebp
  800713:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800716:	8b 45 0c             	mov    0xc(%ebp),%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	8d 48 01             	lea    0x1(%eax),%ecx
  80071e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800721:	89 0a                	mov    %ecx,(%edx)
  800723:	8b 55 08             	mov    0x8(%ebp),%edx
  800726:	88 d1                	mov    %dl,%cl
  800728:	8b 55 0c             	mov    0xc(%ebp),%edx
  80072b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80072f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800732:	8b 00                	mov    (%eax),%eax
  800734:	3d ff 00 00 00       	cmp    $0xff,%eax
  800739:	75 2c                	jne    800767 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80073b:	a0 24 30 80 00       	mov    0x803024,%al
  800740:	0f b6 c0             	movzbl %al,%eax
  800743:	8b 55 0c             	mov    0xc(%ebp),%edx
  800746:	8b 12                	mov    (%edx),%edx
  800748:	89 d1                	mov    %edx,%ecx
  80074a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80074d:	83 c2 08             	add    $0x8,%edx
  800750:	83 ec 04             	sub    $0x4,%esp
  800753:	50                   	push   %eax
  800754:	51                   	push   %ecx
  800755:	52                   	push   %edx
  800756:	e8 ce 10 00 00       	call   801829 <sys_cputs>
  80075b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80075e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800761:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076a:	8b 40 04             	mov    0x4(%eax),%eax
  80076d:	8d 50 01             	lea    0x1(%eax),%edx
  800770:	8b 45 0c             	mov    0xc(%ebp),%eax
  800773:	89 50 04             	mov    %edx,0x4(%eax)
}
  800776:	90                   	nop
  800777:	c9                   	leave  
  800778:	c3                   	ret    

00800779 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800779:	55                   	push   %ebp
  80077a:	89 e5                	mov    %esp,%ebp
  80077c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800782:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800789:	00 00 00 
	b.cnt = 0;
  80078c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800793:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800796:	ff 75 0c             	pushl  0xc(%ebp)
  800799:	ff 75 08             	pushl  0x8(%ebp)
  80079c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007a2:	50                   	push   %eax
  8007a3:	68 10 07 80 00       	push   $0x800710
  8007a8:	e8 11 02 00 00       	call   8009be <vprintfmt>
  8007ad:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8007b0:	a0 24 30 80 00       	mov    0x803024,%al
  8007b5:	0f b6 c0             	movzbl %al,%eax
  8007b8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8007be:	83 ec 04             	sub    $0x4,%esp
  8007c1:	50                   	push   %eax
  8007c2:	52                   	push   %edx
  8007c3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007c9:	83 c0 08             	add    $0x8,%eax
  8007cc:	50                   	push   %eax
  8007cd:	e8 57 10 00 00       	call   801829 <sys_cputs>
  8007d2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007d5:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8007dc:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007e2:	c9                   	leave  
  8007e3:	c3                   	ret    

008007e4 <cprintf>:

int cprintf(const char *fmt, ...) {
  8007e4:	55                   	push   %ebp
  8007e5:	89 e5                	mov    %esp,%ebp
  8007e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007ea:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8007f1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	83 ec 08             	sub    $0x8,%esp
  8007fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800800:	50                   	push   %eax
  800801:	e8 73 ff ff ff       	call   800779 <vcprintf>
  800806:	83 c4 10             	add    $0x10,%esp
  800809:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80080c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80080f:	c9                   	leave  
  800810:	c3                   	ret    

00800811 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800811:	55                   	push   %ebp
  800812:	89 e5                	mov    %esp,%ebp
  800814:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800817:	e8 1e 12 00 00       	call   801a3a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80081c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80081f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800822:	8b 45 08             	mov    0x8(%ebp),%eax
  800825:	83 ec 08             	sub    $0x8,%esp
  800828:	ff 75 f4             	pushl  -0xc(%ebp)
  80082b:	50                   	push   %eax
  80082c:	e8 48 ff ff ff       	call   800779 <vcprintf>
  800831:	83 c4 10             	add    $0x10,%esp
  800834:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800837:	e8 18 12 00 00       	call   801a54 <sys_enable_interrupt>
	return cnt;
  80083c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80083f:	c9                   	leave  
  800840:	c3                   	ret    

00800841 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800841:	55                   	push   %ebp
  800842:	89 e5                	mov    %esp,%ebp
  800844:	53                   	push   %ebx
  800845:	83 ec 14             	sub    $0x14,%esp
  800848:	8b 45 10             	mov    0x10(%ebp),%eax
  80084b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084e:	8b 45 14             	mov    0x14(%ebp),%eax
  800851:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800854:	8b 45 18             	mov    0x18(%ebp),%eax
  800857:	ba 00 00 00 00       	mov    $0x0,%edx
  80085c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80085f:	77 55                	ja     8008b6 <printnum+0x75>
  800861:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800864:	72 05                	jb     80086b <printnum+0x2a>
  800866:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800869:	77 4b                	ja     8008b6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80086b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80086e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800871:	8b 45 18             	mov    0x18(%ebp),%eax
  800874:	ba 00 00 00 00       	mov    $0x0,%edx
  800879:	52                   	push   %edx
  80087a:	50                   	push   %eax
  80087b:	ff 75 f4             	pushl  -0xc(%ebp)
  80087e:	ff 75 f0             	pushl  -0x10(%ebp)
  800881:	e8 72 17 00 00       	call   801ff8 <__udivdi3>
  800886:	83 c4 10             	add    $0x10,%esp
  800889:	83 ec 04             	sub    $0x4,%esp
  80088c:	ff 75 20             	pushl  0x20(%ebp)
  80088f:	53                   	push   %ebx
  800890:	ff 75 18             	pushl  0x18(%ebp)
  800893:	52                   	push   %edx
  800894:	50                   	push   %eax
  800895:	ff 75 0c             	pushl  0xc(%ebp)
  800898:	ff 75 08             	pushl  0x8(%ebp)
  80089b:	e8 a1 ff ff ff       	call   800841 <printnum>
  8008a0:	83 c4 20             	add    $0x20,%esp
  8008a3:	eb 1a                	jmp    8008bf <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008a5:	83 ec 08             	sub    $0x8,%esp
  8008a8:	ff 75 0c             	pushl  0xc(%ebp)
  8008ab:	ff 75 20             	pushl  0x20(%ebp)
  8008ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b1:	ff d0                	call   *%eax
  8008b3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008b6:	ff 4d 1c             	decl   0x1c(%ebp)
  8008b9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008bd:	7f e6                	jg     8008a5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008bf:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008c2:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008cd:	53                   	push   %ebx
  8008ce:	51                   	push   %ecx
  8008cf:	52                   	push   %edx
  8008d0:	50                   	push   %eax
  8008d1:	e8 32 18 00 00       	call   802108 <__umoddi3>
  8008d6:	83 c4 10             	add    $0x10,%esp
  8008d9:	05 f4 24 80 00       	add    $0x8024f4,%eax
  8008de:	8a 00                	mov    (%eax),%al
  8008e0:	0f be c0             	movsbl %al,%eax
  8008e3:	83 ec 08             	sub    $0x8,%esp
  8008e6:	ff 75 0c             	pushl  0xc(%ebp)
  8008e9:	50                   	push   %eax
  8008ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ed:	ff d0                	call   *%eax
  8008ef:	83 c4 10             	add    $0x10,%esp
}
  8008f2:	90                   	nop
  8008f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008f6:	c9                   	leave  
  8008f7:	c3                   	ret    

008008f8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008f8:	55                   	push   %ebp
  8008f9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008fb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008ff:	7e 1c                	jle    80091d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800901:	8b 45 08             	mov    0x8(%ebp),%eax
  800904:	8b 00                	mov    (%eax),%eax
  800906:	8d 50 08             	lea    0x8(%eax),%edx
  800909:	8b 45 08             	mov    0x8(%ebp),%eax
  80090c:	89 10                	mov    %edx,(%eax)
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	8b 00                	mov    (%eax),%eax
  800913:	83 e8 08             	sub    $0x8,%eax
  800916:	8b 50 04             	mov    0x4(%eax),%edx
  800919:	8b 00                	mov    (%eax),%eax
  80091b:	eb 40                	jmp    80095d <getuint+0x65>
	else if (lflag)
  80091d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800921:	74 1e                	je     800941 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800923:	8b 45 08             	mov    0x8(%ebp),%eax
  800926:	8b 00                	mov    (%eax),%eax
  800928:	8d 50 04             	lea    0x4(%eax),%edx
  80092b:	8b 45 08             	mov    0x8(%ebp),%eax
  80092e:	89 10                	mov    %edx,(%eax)
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	8b 00                	mov    (%eax),%eax
  800935:	83 e8 04             	sub    $0x4,%eax
  800938:	8b 00                	mov    (%eax),%eax
  80093a:	ba 00 00 00 00       	mov    $0x0,%edx
  80093f:	eb 1c                	jmp    80095d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800941:	8b 45 08             	mov    0x8(%ebp),%eax
  800944:	8b 00                	mov    (%eax),%eax
  800946:	8d 50 04             	lea    0x4(%eax),%edx
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	89 10                	mov    %edx,(%eax)
  80094e:	8b 45 08             	mov    0x8(%ebp),%eax
  800951:	8b 00                	mov    (%eax),%eax
  800953:	83 e8 04             	sub    $0x4,%eax
  800956:	8b 00                	mov    (%eax),%eax
  800958:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80095d:	5d                   	pop    %ebp
  80095e:	c3                   	ret    

0080095f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80095f:	55                   	push   %ebp
  800960:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800962:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800966:	7e 1c                	jle    800984 <getint+0x25>
		return va_arg(*ap, long long);
  800968:	8b 45 08             	mov    0x8(%ebp),%eax
  80096b:	8b 00                	mov    (%eax),%eax
  80096d:	8d 50 08             	lea    0x8(%eax),%edx
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	89 10                	mov    %edx,(%eax)
  800975:	8b 45 08             	mov    0x8(%ebp),%eax
  800978:	8b 00                	mov    (%eax),%eax
  80097a:	83 e8 08             	sub    $0x8,%eax
  80097d:	8b 50 04             	mov    0x4(%eax),%edx
  800980:	8b 00                	mov    (%eax),%eax
  800982:	eb 38                	jmp    8009bc <getint+0x5d>
	else if (lflag)
  800984:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800988:	74 1a                	je     8009a4 <getint+0x45>
		return va_arg(*ap, long);
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	8b 00                	mov    (%eax),%eax
  80098f:	8d 50 04             	lea    0x4(%eax),%edx
  800992:	8b 45 08             	mov    0x8(%ebp),%eax
  800995:	89 10                	mov    %edx,(%eax)
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	8b 00                	mov    (%eax),%eax
  80099c:	83 e8 04             	sub    $0x4,%eax
  80099f:	8b 00                	mov    (%eax),%eax
  8009a1:	99                   	cltd   
  8009a2:	eb 18                	jmp    8009bc <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a7:	8b 00                	mov    (%eax),%eax
  8009a9:	8d 50 04             	lea    0x4(%eax),%edx
  8009ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8009af:	89 10                	mov    %edx,(%eax)
  8009b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b4:	8b 00                	mov    (%eax),%eax
  8009b6:	83 e8 04             	sub    $0x4,%eax
  8009b9:	8b 00                	mov    (%eax),%eax
  8009bb:	99                   	cltd   
}
  8009bc:	5d                   	pop    %ebp
  8009bd:	c3                   	ret    

008009be <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009be:	55                   	push   %ebp
  8009bf:	89 e5                	mov    %esp,%ebp
  8009c1:	56                   	push   %esi
  8009c2:	53                   	push   %ebx
  8009c3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009c6:	eb 17                	jmp    8009df <vprintfmt+0x21>
			if (ch == '\0')
  8009c8:	85 db                	test   %ebx,%ebx
  8009ca:	0f 84 af 03 00 00    	je     800d7f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8009d0:	83 ec 08             	sub    $0x8,%esp
  8009d3:	ff 75 0c             	pushl  0xc(%ebp)
  8009d6:	53                   	push   %ebx
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	ff d0                	call   *%eax
  8009dc:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009df:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e2:	8d 50 01             	lea    0x1(%eax),%edx
  8009e5:	89 55 10             	mov    %edx,0x10(%ebp)
  8009e8:	8a 00                	mov    (%eax),%al
  8009ea:	0f b6 d8             	movzbl %al,%ebx
  8009ed:	83 fb 25             	cmp    $0x25,%ebx
  8009f0:	75 d6                	jne    8009c8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009f2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009f6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8009fd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a04:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a0b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a12:	8b 45 10             	mov    0x10(%ebp),%eax
  800a15:	8d 50 01             	lea    0x1(%eax),%edx
  800a18:	89 55 10             	mov    %edx,0x10(%ebp)
  800a1b:	8a 00                	mov    (%eax),%al
  800a1d:	0f b6 d8             	movzbl %al,%ebx
  800a20:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a23:	83 f8 55             	cmp    $0x55,%eax
  800a26:	0f 87 2b 03 00 00    	ja     800d57 <vprintfmt+0x399>
  800a2c:	8b 04 85 18 25 80 00 	mov    0x802518(,%eax,4),%eax
  800a33:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a35:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a39:	eb d7                	jmp    800a12 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a3b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a3f:	eb d1                	jmp    800a12 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a41:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a48:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a4b:	89 d0                	mov    %edx,%eax
  800a4d:	c1 e0 02             	shl    $0x2,%eax
  800a50:	01 d0                	add    %edx,%eax
  800a52:	01 c0                	add    %eax,%eax
  800a54:	01 d8                	add    %ebx,%eax
  800a56:	83 e8 30             	sub    $0x30,%eax
  800a59:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5f:	8a 00                	mov    (%eax),%al
  800a61:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a64:	83 fb 2f             	cmp    $0x2f,%ebx
  800a67:	7e 3e                	jle    800aa7 <vprintfmt+0xe9>
  800a69:	83 fb 39             	cmp    $0x39,%ebx
  800a6c:	7f 39                	jg     800aa7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a6e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a71:	eb d5                	jmp    800a48 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a73:	8b 45 14             	mov    0x14(%ebp),%eax
  800a76:	83 c0 04             	add    $0x4,%eax
  800a79:	89 45 14             	mov    %eax,0x14(%ebp)
  800a7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a7f:	83 e8 04             	sub    $0x4,%eax
  800a82:	8b 00                	mov    (%eax),%eax
  800a84:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a87:	eb 1f                	jmp    800aa8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a89:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a8d:	79 83                	jns    800a12 <vprintfmt+0x54>
				width = 0;
  800a8f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a96:	e9 77 ff ff ff       	jmp    800a12 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a9b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800aa2:	e9 6b ff ff ff       	jmp    800a12 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800aa7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800aa8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aac:	0f 89 60 ff ff ff    	jns    800a12 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ab2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ab5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ab8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800abf:	e9 4e ff ff ff       	jmp    800a12 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ac4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ac7:	e9 46 ff ff ff       	jmp    800a12 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800acc:	8b 45 14             	mov    0x14(%ebp),%eax
  800acf:	83 c0 04             	add    $0x4,%eax
  800ad2:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad8:	83 e8 04             	sub    $0x4,%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	83 ec 08             	sub    $0x8,%esp
  800ae0:	ff 75 0c             	pushl  0xc(%ebp)
  800ae3:	50                   	push   %eax
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	ff d0                	call   *%eax
  800ae9:	83 c4 10             	add    $0x10,%esp
			break;
  800aec:	e9 89 02 00 00       	jmp    800d7a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800af1:	8b 45 14             	mov    0x14(%ebp),%eax
  800af4:	83 c0 04             	add    $0x4,%eax
  800af7:	89 45 14             	mov    %eax,0x14(%ebp)
  800afa:	8b 45 14             	mov    0x14(%ebp),%eax
  800afd:	83 e8 04             	sub    $0x4,%eax
  800b00:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b02:	85 db                	test   %ebx,%ebx
  800b04:	79 02                	jns    800b08 <vprintfmt+0x14a>
				err = -err;
  800b06:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b08:	83 fb 64             	cmp    $0x64,%ebx
  800b0b:	7f 0b                	jg     800b18 <vprintfmt+0x15a>
  800b0d:	8b 34 9d 60 23 80 00 	mov    0x802360(,%ebx,4),%esi
  800b14:	85 f6                	test   %esi,%esi
  800b16:	75 19                	jne    800b31 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b18:	53                   	push   %ebx
  800b19:	68 05 25 80 00       	push   $0x802505
  800b1e:	ff 75 0c             	pushl  0xc(%ebp)
  800b21:	ff 75 08             	pushl  0x8(%ebp)
  800b24:	e8 5e 02 00 00       	call   800d87 <printfmt>
  800b29:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b2c:	e9 49 02 00 00       	jmp    800d7a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b31:	56                   	push   %esi
  800b32:	68 0e 25 80 00       	push   $0x80250e
  800b37:	ff 75 0c             	pushl  0xc(%ebp)
  800b3a:	ff 75 08             	pushl  0x8(%ebp)
  800b3d:	e8 45 02 00 00       	call   800d87 <printfmt>
  800b42:	83 c4 10             	add    $0x10,%esp
			break;
  800b45:	e9 30 02 00 00       	jmp    800d7a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b4d:	83 c0 04             	add    $0x4,%eax
  800b50:	89 45 14             	mov    %eax,0x14(%ebp)
  800b53:	8b 45 14             	mov    0x14(%ebp),%eax
  800b56:	83 e8 04             	sub    $0x4,%eax
  800b59:	8b 30                	mov    (%eax),%esi
  800b5b:	85 f6                	test   %esi,%esi
  800b5d:	75 05                	jne    800b64 <vprintfmt+0x1a6>
				p = "(null)";
  800b5f:	be 11 25 80 00       	mov    $0x802511,%esi
			if (width > 0 && padc != '-')
  800b64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b68:	7e 6d                	jle    800bd7 <vprintfmt+0x219>
  800b6a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b6e:	74 67                	je     800bd7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b70:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b73:	83 ec 08             	sub    $0x8,%esp
  800b76:	50                   	push   %eax
  800b77:	56                   	push   %esi
  800b78:	e8 0c 03 00 00       	call   800e89 <strnlen>
  800b7d:	83 c4 10             	add    $0x10,%esp
  800b80:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b83:	eb 16                	jmp    800b9b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b85:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b89:	83 ec 08             	sub    $0x8,%esp
  800b8c:	ff 75 0c             	pushl  0xc(%ebp)
  800b8f:	50                   	push   %eax
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	ff d0                	call   *%eax
  800b95:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b98:	ff 4d e4             	decl   -0x1c(%ebp)
  800b9b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b9f:	7f e4                	jg     800b85 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ba1:	eb 34                	jmp    800bd7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ba3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ba7:	74 1c                	je     800bc5 <vprintfmt+0x207>
  800ba9:	83 fb 1f             	cmp    $0x1f,%ebx
  800bac:	7e 05                	jle    800bb3 <vprintfmt+0x1f5>
  800bae:	83 fb 7e             	cmp    $0x7e,%ebx
  800bb1:	7e 12                	jle    800bc5 <vprintfmt+0x207>
					putch('?', putdat);
  800bb3:	83 ec 08             	sub    $0x8,%esp
  800bb6:	ff 75 0c             	pushl  0xc(%ebp)
  800bb9:	6a 3f                	push   $0x3f
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	ff d0                	call   *%eax
  800bc0:	83 c4 10             	add    $0x10,%esp
  800bc3:	eb 0f                	jmp    800bd4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bc5:	83 ec 08             	sub    $0x8,%esp
  800bc8:	ff 75 0c             	pushl  0xc(%ebp)
  800bcb:	53                   	push   %ebx
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	ff d0                	call   *%eax
  800bd1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bd4:	ff 4d e4             	decl   -0x1c(%ebp)
  800bd7:	89 f0                	mov    %esi,%eax
  800bd9:	8d 70 01             	lea    0x1(%eax),%esi
  800bdc:	8a 00                	mov    (%eax),%al
  800bde:	0f be d8             	movsbl %al,%ebx
  800be1:	85 db                	test   %ebx,%ebx
  800be3:	74 24                	je     800c09 <vprintfmt+0x24b>
  800be5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800be9:	78 b8                	js     800ba3 <vprintfmt+0x1e5>
  800beb:	ff 4d e0             	decl   -0x20(%ebp)
  800bee:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bf2:	79 af                	jns    800ba3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bf4:	eb 13                	jmp    800c09 <vprintfmt+0x24b>
				putch(' ', putdat);
  800bf6:	83 ec 08             	sub    $0x8,%esp
  800bf9:	ff 75 0c             	pushl  0xc(%ebp)
  800bfc:	6a 20                	push   $0x20
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	ff d0                	call   *%eax
  800c03:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c06:	ff 4d e4             	decl   -0x1c(%ebp)
  800c09:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c0d:	7f e7                	jg     800bf6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c0f:	e9 66 01 00 00       	jmp    800d7a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c14:	83 ec 08             	sub    $0x8,%esp
  800c17:	ff 75 e8             	pushl  -0x18(%ebp)
  800c1a:	8d 45 14             	lea    0x14(%ebp),%eax
  800c1d:	50                   	push   %eax
  800c1e:	e8 3c fd ff ff       	call   80095f <getint>
  800c23:	83 c4 10             	add    $0x10,%esp
  800c26:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c29:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c32:	85 d2                	test   %edx,%edx
  800c34:	79 23                	jns    800c59 <vprintfmt+0x29b>
				putch('-', putdat);
  800c36:	83 ec 08             	sub    $0x8,%esp
  800c39:	ff 75 0c             	pushl  0xc(%ebp)
  800c3c:	6a 2d                	push   $0x2d
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	ff d0                	call   *%eax
  800c43:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c49:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c4c:	f7 d8                	neg    %eax
  800c4e:	83 d2 00             	adc    $0x0,%edx
  800c51:	f7 da                	neg    %edx
  800c53:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c56:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c59:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c60:	e9 bc 00 00 00       	jmp    800d21 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	ff 75 e8             	pushl  -0x18(%ebp)
  800c6b:	8d 45 14             	lea    0x14(%ebp),%eax
  800c6e:	50                   	push   %eax
  800c6f:	e8 84 fc ff ff       	call   8008f8 <getuint>
  800c74:	83 c4 10             	add    $0x10,%esp
  800c77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c7a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c7d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c84:	e9 98 00 00 00       	jmp    800d21 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c89:	83 ec 08             	sub    $0x8,%esp
  800c8c:	ff 75 0c             	pushl  0xc(%ebp)
  800c8f:	6a 58                	push   $0x58
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	ff d0                	call   *%eax
  800c96:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c99:	83 ec 08             	sub    $0x8,%esp
  800c9c:	ff 75 0c             	pushl  0xc(%ebp)
  800c9f:	6a 58                	push   $0x58
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	ff d0                	call   *%eax
  800ca6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ca9:	83 ec 08             	sub    $0x8,%esp
  800cac:	ff 75 0c             	pushl  0xc(%ebp)
  800caf:	6a 58                	push   $0x58
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	ff d0                	call   *%eax
  800cb6:	83 c4 10             	add    $0x10,%esp
			break;
  800cb9:	e9 bc 00 00 00       	jmp    800d7a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800cbe:	83 ec 08             	sub    $0x8,%esp
  800cc1:	ff 75 0c             	pushl  0xc(%ebp)
  800cc4:	6a 30                	push   $0x30
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	ff d0                	call   *%eax
  800ccb:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cce:	83 ec 08             	sub    $0x8,%esp
  800cd1:	ff 75 0c             	pushl  0xc(%ebp)
  800cd4:	6a 78                	push   $0x78
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	ff d0                	call   *%eax
  800cdb:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cde:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce1:	83 c0 04             	add    $0x4,%eax
  800ce4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cea:	83 e8 04             	sub    $0x4,%eax
  800ced:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800cef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cf2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800cf9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d00:	eb 1f                	jmp    800d21 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d02:	83 ec 08             	sub    $0x8,%esp
  800d05:	ff 75 e8             	pushl  -0x18(%ebp)
  800d08:	8d 45 14             	lea    0x14(%ebp),%eax
  800d0b:	50                   	push   %eax
  800d0c:	e8 e7 fb ff ff       	call   8008f8 <getuint>
  800d11:	83 c4 10             	add    $0x10,%esp
  800d14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d17:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d1a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d21:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d25:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d28:	83 ec 04             	sub    $0x4,%esp
  800d2b:	52                   	push   %edx
  800d2c:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d2f:	50                   	push   %eax
  800d30:	ff 75 f4             	pushl  -0xc(%ebp)
  800d33:	ff 75 f0             	pushl  -0x10(%ebp)
  800d36:	ff 75 0c             	pushl  0xc(%ebp)
  800d39:	ff 75 08             	pushl  0x8(%ebp)
  800d3c:	e8 00 fb ff ff       	call   800841 <printnum>
  800d41:	83 c4 20             	add    $0x20,%esp
			break;
  800d44:	eb 34                	jmp    800d7a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d46:	83 ec 08             	sub    $0x8,%esp
  800d49:	ff 75 0c             	pushl  0xc(%ebp)
  800d4c:	53                   	push   %ebx
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	ff d0                	call   *%eax
  800d52:	83 c4 10             	add    $0x10,%esp
			break;
  800d55:	eb 23                	jmp    800d7a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d57:	83 ec 08             	sub    $0x8,%esp
  800d5a:	ff 75 0c             	pushl  0xc(%ebp)
  800d5d:	6a 25                	push   $0x25
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	ff d0                	call   *%eax
  800d64:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d67:	ff 4d 10             	decl   0x10(%ebp)
  800d6a:	eb 03                	jmp    800d6f <vprintfmt+0x3b1>
  800d6c:	ff 4d 10             	decl   0x10(%ebp)
  800d6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d72:	48                   	dec    %eax
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	3c 25                	cmp    $0x25,%al
  800d77:	75 f3                	jne    800d6c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d79:	90                   	nop
		}
	}
  800d7a:	e9 47 fc ff ff       	jmp    8009c6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d7f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d80:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d83:	5b                   	pop    %ebx
  800d84:	5e                   	pop    %esi
  800d85:	5d                   	pop    %ebp
  800d86:	c3                   	ret    

00800d87 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d87:	55                   	push   %ebp
  800d88:	89 e5                	mov    %esp,%ebp
  800d8a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d8d:	8d 45 10             	lea    0x10(%ebp),%eax
  800d90:	83 c0 04             	add    $0x4,%eax
  800d93:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d96:	8b 45 10             	mov    0x10(%ebp),%eax
  800d99:	ff 75 f4             	pushl  -0xc(%ebp)
  800d9c:	50                   	push   %eax
  800d9d:	ff 75 0c             	pushl  0xc(%ebp)
  800da0:	ff 75 08             	pushl  0x8(%ebp)
  800da3:	e8 16 fc ff ff       	call   8009be <vprintfmt>
  800da8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dab:	90                   	nop
  800dac:	c9                   	leave  
  800dad:	c3                   	ret    

00800dae <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800dae:	55                   	push   %ebp
  800daf:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800db1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db4:	8b 40 08             	mov    0x8(%eax),%eax
  800db7:	8d 50 01             	lea    0x1(%eax),%edx
  800dba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbd:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800dc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc3:	8b 10                	mov    (%eax),%edx
  800dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc8:	8b 40 04             	mov    0x4(%eax),%eax
  800dcb:	39 c2                	cmp    %eax,%edx
  800dcd:	73 12                	jae    800de1 <sprintputch+0x33>
		*b->buf++ = ch;
  800dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd2:	8b 00                	mov    (%eax),%eax
  800dd4:	8d 48 01             	lea    0x1(%eax),%ecx
  800dd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dda:	89 0a                	mov    %ecx,(%edx)
  800ddc:	8b 55 08             	mov    0x8(%ebp),%edx
  800ddf:	88 10                	mov    %dl,(%eax)
}
  800de1:	90                   	nop
  800de2:	5d                   	pop    %ebp
  800de3:	c3                   	ret    

00800de4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
  800de7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800df0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df6:	8b 45 08             	mov    0x8(%ebp),%eax
  800df9:	01 d0                	add    %edx,%eax
  800dfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e05:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e09:	74 06                	je     800e11 <vsnprintf+0x2d>
  800e0b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e0f:	7f 07                	jg     800e18 <vsnprintf+0x34>
		return -E_INVAL;
  800e11:	b8 03 00 00 00       	mov    $0x3,%eax
  800e16:	eb 20                	jmp    800e38 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e18:	ff 75 14             	pushl  0x14(%ebp)
  800e1b:	ff 75 10             	pushl  0x10(%ebp)
  800e1e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e21:	50                   	push   %eax
  800e22:	68 ae 0d 80 00       	push   $0x800dae
  800e27:	e8 92 fb ff ff       	call   8009be <vprintfmt>
  800e2c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e32:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e35:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e38:	c9                   	leave  
  800e39:	c3                   	ret    

00800e3a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e3a:	55                   	push   %ebp
  800e3b:	89 e5                	mov    %esp,%ebp
  800e3d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e40:	8d 45 10             	lea    0x10(%ebp),%eax
  800e43:	83 c0 04             	add    $0x4,%eax
  800e46:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e49:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4c:	ff 75 f4             	pushl  -0xc(%ebp)
  800e4f:	50                   	push   %eax
  800e50:	ff 75 0c             	pushl  0xc(%ebp)
  800e53:	ff 75 08             	pushl  0x8(%ebp)
  800e56:	e8 89 ff ff ff       	call   800de4 <vsnprintf>
  800e5b:	83 c4 10             	add    $0x10,%esp
  800e5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e61:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e64:	c9                   	leave  
  800e65:	c3                   	ret    

00800e66 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e66:	55                   	push   %ebp
  800e67:	89 e5                	mov    %esp,%ebp
  800e69:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e73:	eb 06                	jmp    800e7b <strlen+0x15>
		n++;
  800e75:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e78:	ff 45 08             	incl   0x8(%ebp)
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	8a 00                	mov    (%eax),%al
  800e80:	84 c0                	test   %al,%al
  800e82:	75 f1                	jne    800e75 <strlen+0xf>
		n++;
	return n;
  800e84:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e87:	c9                   	leave  
  800e88:	c3                   	ret    

00800e89 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e89:	55                   	push   %ebp
  800e8a:	89 e5                	mov    %esp,%ebp
  800e8c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e8f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e96:	eb 09                	jmp    800ea1 <strnlen+0x18>
		n++;
  800e98:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e9b:	ff 45 08             	incl   0x8(%ebp)
  800e9e:	ff 4d 0c             	decl   0xc(%ebp)
  800ea1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ea5:	74 09                	je     800eb0 <strnlen+0x27>
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	8a 00                	mov    (%eax),%al
  800eac:	84 c0                	test   %al,%al
  800eae:	75 e8                	jne    800e98 <strnlen+0xf>
		n++;
	return n;
  800eb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eb3:	c9                   	leave  
  800eb4:	c3                   	ret    

00800eb5 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800eb5:	55                   	push   %ebp
  800eb6:	89 e5                	mov    %esp,%ebp
  800eb8:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ec1:	90                   	nop
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8d 50 01             	lea    0x1(%eax),%edx
  800ec8:	89 55 08             	mov    %edx,0x8(%ebp)
  800ecb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ece:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ed1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ed4:	8a 12                	mov    (%edx),%dl
  800ed6:	88 10                	mov    %dl,(%eax)
  800ed8:	8a 00                	mov    (%eax),%al
  800eda:	84 c0                	test   %al,%al
  800edc:	75 e4                	jne    800ec2 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ede:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ee1:	c9                   	leave  
  800ee2:	c3                   	ret    

00800ee3 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ee3:	55                   	push   %ebp
  800ee4:	89 e5                	mov    %esp,%ebp
  800ee6:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800eef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ef6:	eb 1f                	jmp    800f17 <strncpy+0x34>
		*dst++ = *src;
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	8d 50 01             	lea    0x1(%eax),%edx
  800efe:	89 55 08             	mov    %edx,0x8(%ebp)
  800f01:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f04:	8a 12                	mov    (%edx),%dl
  800f06:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	84 c0                	test   %al,%al
  800f0f:	74 03                	je     800f14 <strncpy+0x31>
			src++;
  800f11:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f14:	ff 45 fc             	incl   -0x4(%ebp)
  800f17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f1d:	72 d9                	jb     800ef8 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f22:	c9                   	leave  
  800f23:	c3                   	ret    

00800f24 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f24:	55                   	push   %ebp
  800f25:	89 e5                	mov    %esp,%ebp
  800f27:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f30:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f34:	74 30                	je     800f66 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f36:	eb 16                	jmp    800f4e <strlcpy+0x2a>
			*dst++ = *src++;
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8d 50 01             	lea    0x1(%eax),%edx
  800f3e:	89 55 08             	mov    %edx,0x8(%ebp)
  800f41:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f44:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f47:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f4a:	8a 12                	mov    (%edx),%dl
  800f4c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f4e:	ff 4d 10             	decl   0x10(%ebp)
  800f51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f55:	74 09                	je     800f60 <strlcpy+0x3c>
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	84 c0                	test   %al,%al
  800f5e:	75 d8                	jne    800f38 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f66:	8b 55 08             	mov    0x8(%ebp),%edx
  800f69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6c:	29 c2                	sub    %eax,%edx
  800f6e:	89 d0                	mov    %edx,%eax
}
  800f70:	c9                   	leave  
  800f71:	c3                   	ret    

00800f72 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f72:	55                   	push   %ebp
  800f73:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f75:	eb 06                	jmp    800f7d <strcmp+0xb>
		p++, q++;
  800f77:	ff 45 08             	incl   0x8(%ebp)
  800f7a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	84 c0                	test   %al,%al
  800f84:	74 0e                	je     800f94 <strcmp+0x22>
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 10                	mov    (%eax),%dl
  800f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	38 c2                	cmp    %al,%dl
  800f92:	74 e3                	je     800f77 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	0f b6 d0             	movzbl %al,%edx
  800f9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	0f b6 c0             	movzbl %al,%eax
  800fa4:	29 c2                	sub    %eax,%edx
  800fa6:	89 d0                	mov    %edx,%eax
}
  800fa8:	5d                   	pop    %ebp
  800fa9:	c3                   	ret    

00800faa <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800faa:	55                   	push   %ebp
  800fab:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fad:	eb 09                	jmp    800fb8 <strncmp+0xe>
		n--, p++, q++;
  800faf:	ff 4d 10             	decl   0x10(%ebp)
  800fb2:	ff 45 08             	incl   0x8(%ebp)
  800fb5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fb8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fbc:	74 17                	je     800fd5 <strncmp+0x2b>
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	84 c0                	test   %al,%al
  800fc5:	74 0e                	je     800fd5 <strncmp+0x2b>
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 10                	mov    (%eax),%dl
  800fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	38 c2                	cmp    %al,%dl
  800fd3:	74 da                	je     800faf <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd9:	75 07                	jne    800fe2 <strncmp+0x38>
		return 0;
  800fdb:	b8 00 00 00 00       	mov    $0x0,%eax
  800fe0:	eb 14                	jmp    800ff6 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	0f b6 d0             	movzbl %al,%edx
  800fea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fed:	8a 00                	mov    (%eax),%al
  800fef:	0f b6 c0             	movzbl %al,%eax
  800ff2:	29 c2                	sub    %eax,%edx
  800ff4:	89 d0                	mov    %edx,%eax
}
  800ff6:	5d                   	pop    %ebp
  800ff7:	c3                   	ret    

00800ff8 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ff8:	55                   	push   %ebp
  800ff9:	89 e5                	mov    %esp,%ebp
  800ffb:	83 ec 04             	sub    $0x4,%esp
  800ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801001:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801004:	eb 12                	jmp    801018 <strchr+0x20>
		if (*s == c)
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80100e:	75 05                	jne    801015 <strchr+0x1d>
			return (char *) s;
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	eb 11                	jmp    801026 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801015:	ff 45 08             	incl   0x8(%ebp)
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	84 c0                	test   %al,%al
  80101f:	75 e5                	jne    801006 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801021:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801026:	c9                   	leave  
  801027:	c3                   	ret    

00801028 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801028:	55                   	push   %ebp
  801029:	89 e5                	mov    %esp,%ebp
  80102b:	83 ec 04             	sub    $0x4,%esp
  80102e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801031:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801034:	eb 0d                	jmp    801043 <strfind+0x1b>
		if (*s == c)
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8a 00                	mov    (%eax),%al
  80103b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80103e:	74 0e                	je     80104e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801040:	ff 45 08             	incl   0x8(%ebp)
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	8a 00                	mov    (%eax),%al
  801048:	84 c0                	test   %al,%al
  80104a:	75 ea                	jne    801036 <strfind+0xe>
  80104c:	eb 01                	jmp    80104f <strfind+0x27>
		if (*s == c)
			break;
  80104e:	90                   	nop
	return (char *) s;
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801052:	c9                   	leave  
  801053:	c3                   	ret    

00801054 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801054:	55                   	push   %ebp
  801055:	89 e5                	mov    %esp,%ebp
  801057:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80105a:	8b 45 08             	mov    0x8(%ebp),%eax
  80105d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801060:	8b 45 10             	mov    0x10(%ebp),%eax
  801063:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801066:	eb 0e                	jmp    801076 <memset+0x22>
		*p++ = c;
  801068:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106b:	8d 50 01             	lea    0x1(%eax),%edx
  80106e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801071:	8b 55 0c             	mov    0xc(%ebp),%edx
  801074:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801076:	ff 4d f8             	decl   -0x8(%ebp)
  801079:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80107d:	79 e9                	jns    801068 <memset+0x14>
		*p++ = c;

	return v;
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801082:	c9                   	leave  
  801083:	c3                   	ret    

00801084 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801084:	55                   	push   %ebp
  801085:	89 e5                	mov    %esp,%ebp
  801087:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80108a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801096:	eb 16                	jmp    8010ae <memcpy+0x2a>
		*d++ = *s++;
  801098:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109b:	8d 50 01             	lea    0x1(%eax),%edx
  80109e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010aa:	8a 12                	mov    (%edx),%dl
  8010ac:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8010ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b7:	85 c0                	test   %eax,%eax
  8010b9:	75 dd                	jne    801098 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8010c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010d8:	73 50                	jae    80112a <memmove+0x6a>
  8010da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e0:	01 d0                	add    %edx,%eax
  8010e2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010e5:	76 43                	jbe    80112a <memmove+0x6a>
		s += n;
  8010e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ea:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f0:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010f3:	eb 10                	jmp    801105 <memmove+0x45>
			*--d = *--s;
  8010f5:	ff 4d f8             	decl   -0x8(%ebp)
  8010f8:	ff 4d fc             	decl   -0x4(%ebp)
  8010fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010fe:	8a 10                	mov    (%eax),%dl
  801100:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801103:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801105:	8b 45 10             	mov    0x10(%ebp),%eax
  801108:	8d 50 ff             	lea    -0x1(%eax),%edx
  80110b:	89 55 10             	mov    %edx,0x10(%ebp)
  80110e:	85 c0                	test   %eax,%eax
  801110:	75 e3                	jne    8010f5 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801112:	eb 23                	jmp    801137 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801114:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801117:	8d 50 01             	lea    0x1(%eax),%edx
  80111a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80111d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801120:	8d 4a 01             	lea    0x1(%edx),%ecx
  801123:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801126:	8a 12                	mov    (%edx),%dl
  801128:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80112a:	8b 45 10             	mov    0x10(%ebp),%eax
  80112d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801130:	89 55 10             	mov    %edx,0x10(%ebp)
  801133:	85 c0                	test   %eax,%eax
  801135:	75 dd                	jne    801114 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801137:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80113a:	c9                   	leave  
  80113b:	c3                   	ret    

0080113c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80113c:	55                   	push   %ebp
  80113d:	89 e5                	mov    %esp,%ebp
  80113f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801142:	8b 45 08             	mov    0x8(%ebp),%eax
  801145:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80114e:	eb 2a                	jmp    80117a <memcmp+0x3e>
		if (*s1 != *s2)
  801150:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801153:	8a 10                	mov    (%eax),%dl
  801155:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	38 c2                	cmp    %al,%dl
  80115c:	74 16                	je     801174 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80115e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	0f b6 d0             	movzbl %al,%edx
  801166:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	0f b6 c0             	movzbl %al,%eax
  80116e:	29 c2                	sub    %eax,%edx
  801170:	89 d0                	mov    %edx,%eax
  801172:	eb 18                	jmp    80118c <memcmp+0x50>
		s1++, s2++;
  801174:	ff 45 fc             	incl   -0x4(%ebp)
  801177:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80117a:	8b 45 10             	mov    0x10(%ebp),%eax
  80117d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801180:	89 55 10             	mov    %edx,0x10(%ebp)
  801183:	85 c0                	test   %eax,%eax
  801185:	75 c9                	jne    801150 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801187:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80118c:	c9                   	leave  
  80118d:	c3                   	ret    

0080118e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80118e:	55                   	push   %ebp
  80118f:	89 e5                	mov    %esp,%ebp
  801191:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801194:	8b 55 08             	mov    0x8(%ebp),%edx
  801197:	8b 45 10             	mov    0x10(%ebp),%eax
  80119a:	01 d0                	add    %edx,%eax
  80119c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80119f:	eb 15                	jmp    8011b6 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	0f b6 d0             	movzbl %al,%edx
  8011a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ac:	0f b6 c0             	movzbl %al,%eax
  8011af:	39 c2                	cmp    %eax,%edx
  8011b1:	74 0d                	je     8011c0 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011b3:	ff 45 08             	incl   0x8(%ebp)
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011bc:	72 e3                	jb     8011a1 <memfind+0x13>
  8011be:	eb 01                	jmp    8011c1 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011c0:	90                   	nop
	return (void *) s;
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011c4:	c9                   	leave  
  8011c5:	c3                   	ret    

008011c6 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011c6:	55                   	push   %ebp
  8011c7:	89 e5                	mov    %esp,%ebp
  8011c9:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011da:	eb 03                	jmp    8011df <strtol+0x19>
		s++;
  8011dc:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	3c 20                	cmp    $0x20,%al
  8011e6:	74 f4                	je     8011dc <strtol+0x16>
  8011e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011eb:	8a 00                	mov    (%eax),%al
  8011ed:	3c 09                	cmp    $0x9,%al
  8011ef:	74 eb                	je     8011dc <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	8a 00                	mov    (%eax),%al
  8011f6:	3c 2b                	cmp    $0x2b,%al
  8011f8:	75 05                	jne    8011ff <strtol+0x39>
		s++;
  8011fa:	ff 45 08             	incl   0x8(%ebp)
  8011fd:	eb 13                	jmp    801212 <strtol+0x4c>
	else if (*s == '-')
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	8a 00                	mov    (%eax),%al
  801204:	3c 2d                	cmp    $0x2d,%al
  801206:	75 0a                	jne    801212 <strtol+0x4c>
		s++, neg = 1;
  801208:	ff 45 08             	incl   0x8(%ebp)
  80120b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801212:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801216:	74 06                	je     80121e <strtol+0x58>
  801218:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80121c:	75 20                	jne    80123e <strtol+0x78>
  80121e:	8b 45 08             	mov    0x8(%ebp),%eax
  801221:	8a 00                	mov    (%eax),%al
  801223:	3c 30                	cmp    $0x30,%al
  801225:	75 17                	jne    80123e <strtol+0x78>
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
  80122a:	40                   	inc    %eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	3c 78                	cmp    $0x78,%al
  80122f:	75 0d                	jne    80123e <strtol+0x78>
		s += 2, base = 16;
  801231:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801235:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80123c:	eb 28                	jmp    801266 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80123e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801242:	75 15                	jne    801259 <strtol+0x93>
  801244:	8b 45 08             	mov    0x8(%ebp),%eax
  801247:	8a 00                	mov    (%eax),%al
  801249:	3c 30                	cmp    $0x30,%al
  80124b:	75 0c                	jne    801259 <strtol+0x93>
		s++, base = 8;
  80124d:	ff 45 08             	incl   0x8(%ebp)
  801250:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801257:	eb 0d                	jmp    801266 <strtol+0xa0>
	else if (base == 0)
  801259:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80125d:	75 07                	jne    801266 <strtol+0xa0>
		base = 10;
  80125f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	8a 00                	mov    (%eax),%al
  80126b:	3c 2f                	cmp    $0x2f,%al
  80126d:	7e 19                	jle    801288 <strtol+0xc2>
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	8a 00                	mov    (%eax),%al
  801274:	3c 39                	cmp    $0x39,%al
  801276:	7f 10                	jg     801288 <strtol+0xc2>
			dig = *s - '0';
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8a 00                	mov    (%eax),%al
  80127d:	0f be c0             	movsbl %al,%eax
  801280:	83 e8 30             	sub    $0x30,%eax
  801283:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801286:	eb 42                	jmp    8012ca <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801288:	8b 45 08             	mov    0x8(%ebp),%eax
  80128b:	8a 00                	mov    (%eax),%al
  80128d:	3c 60                	cmp    $0x60,%al
  80128f:	7e 19                	jle    8012aa <strtol+0xe4>
  801291:	8b 45 08             	mov    0x8(%ebp),%eax
  801294:	8a 00                	mov    (%eax),%al
  801296:	3c 7a                	cmp    $0x7a,%al
  801298:	7f 10                	jg     8012aa <strtol+0xe4>
			dig = *s - 'a' + 10;
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	8a 00                	mov    (%eax),%al
  80129f:	0f be c0             	movsbl %al,%eax
  8012a2:	83 e8 57             	sub    $0x57,%eax
  8012a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012a8:	eb 20                	jmp    8012ca <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	8a 00                	mov    (%eax),%al
  8012af:	3c 40                	cmp    $0x40,%al
  8012b1:	7e 39                	jle    8012ec <strtol+0x126>
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	8a 00                	mov    (%eax),%al
  8012b8:	3c 5a                	cmp    $0x5a,%al
  8012ba:	7f 30                	jg     8012ec <strtol+0x126>
			dig = *s - 'A' + 10;
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	8a 00                	mov    (%eax),%al
  8012c1:	0f be c0             	movsbl %al,%eax
  8012c4:	83 e8 37             	sub    $0x37,%eax
  8012c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012cd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012d0:	7d 19                	jge    8012eb <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012d2:	ff 45 08             	incl   0x8(%ebp)
  8012d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d8:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012dc:	89 c2                	mov    %eax,%edx
  8012de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012e1:	01 d0                	add    %edx,%eax
  8012e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012e6:	e9 7b ff ff ff       	jmp    801266 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012eb:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012f0:	74 08                	je     8012fa <strtol+0x134>
		*endptr = (char *) s;
  8012f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f8:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012fa:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012fe:	74 07                	je     801307 <strtol+0x141>
  801300:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801303:	f7 d8                	neg    %eax
  801305:	eb 03                	jmp    80130a <strtol+0x144>
  801307:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80130a:	c9                   	leave  
  80130b:	c3                   	ret    

0080130c <ltostr>:

void
ltostr(long value, char *str)
{
  80130c:	55                   	push   %ebp
  80130d:	89 e5                	mov    %esp,%ebp
  80130f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801312:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801319:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801320:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801324:	79 13                	jns    801339 <ltostr+0x2d>
	{
		neg = 1;
  801326:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80132d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801330:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801333:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801336:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801341:	99                   	cltd   
  801342:	f7 f9                	idiv   %ecx
  801344:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801347:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134a:	8d 50 01             	lea    0x1(%eax),%edx
  80134d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801350:	89 c2                	mov    %eax,%edx
  801352:	8b 45 0c             	mov    0xc(%ebp),%eax
  801355:	01 d0                	add    %edx,%eax
  801357:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80135a:	83 c2 30             	add    $0x30,%edx
  80135d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80135f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801362:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801367:	f7 e9                	imul   %ecx
  801369:	c1 fa 02             	sar    $0x2,%edx
  80136c:	89 c8                	mov    %ecx,%eax
  80136e:	c1 f8 1f             	sar    $0x1f,%eax
  801371:	29 c2                	sub    %eax,%edx
  801373:	89 d0                	mov    %edx,%eax
  801375:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801378:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80137b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801380:	f7 e9                	imul   %ecx
  801382:	c1 fa 02             	sar    $0x2,%edx
  801385:	89 c8                	mov    %ecx,%eax
  801387:	c1 f8 1f             	sar    $0x1f,%eax
  80138a:	29 c2                	sub    %eax,%edx
  80138c:	89 d0                	mov    %edx,%eax
  80138e:	c1 e0 02             	shl    $0x2,%eax
  801391:	01 d0                	add    %edx,%eax
  801393:	01 c0                	add    %eax,%eax
  801395:	29 c1                	sub    %eax,%ecx
  801397:	89 ca                	mov    %ecx,%edx
  801399:	85 d2                	test   %edx,%edx
  80139b:	75 9c                	jne    801339 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80139d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8013a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a7:	48                   	dec    %eax
  8013a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013af:	74 3d                	je     8013ee <ltostr+0xe2>
		start = 1 ;
  8013b1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013b8:	eb 34                	jmp    8013ee <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8013ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c0:	01 d0                	add    %edx,%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013cd:	01 c2                	add    %eax,%edx
  8013cf:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	01 c8                	add    %ecx,%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013db:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e1:	01 c2                	add    %eax,%edx
  8013e3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013e6:	88 02                	mov    %al,(%edx)
		start++ ;
  8013e8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013eb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013f4:	7c c4                	jl     8013ba <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013f6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fc:	01 d0                	add    %edx,%eax
  8013fe:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801401:	90                   	nop
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
  801407:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80140a:	ff 75 08             	pushl  0x8(%ebp)
  80140d:	e8 54 fa ff ff       	call   800e66 <strlen>
  801412:	83 c4 04             	add    $0x4,%esp
  801415:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801418:	ff 75 0c             	pushl  0xc(%ebp)
  80141b:	e8 46 fa ff ff       	call   800e66 <strlen>
  801420:	83 c4 04             	add    $0x4,%esp
  801423:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801426:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80142d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801434:	eb 17                	jmp    80144d <strcconcat+0x49>
		final[s] = str1[s] ;
  801436:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801439:	8b 45 10             	mov    0x10(%ebp),%eax
  80143c:	01 c2                	add    %eax,%edx
  80143e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	01 c8                	add    %ecx,%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80144a:	ff 45 fc             	incl   -0x4(%ebp)
  80144d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801450:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801453:	7c e1                	jl     801436 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801455:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80145c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801463:	eb 1f                	jmp    801484 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801465:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801468:	8d 50 01             	lea    0x1(%eax),%edx
  80146b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80146e:	89 c2                	mov    %eax,%edx
  801470:	8b 45 10             	mov    0x10(%ebp),%eax
  801473:	01 c2                	add    %eax,%edx
  801475:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147b:	01 c8                	add    %ecx,%eax
  80147d:	8a 00                	mov    (%eax),%al
  80147f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801481:	ff 45 f8             	incl   -0x8(%ebp)
  801484:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801487:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80148a:	7c d9                	jl     801465 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80148c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148f:	8b 45 10             	mov    0x10(%ebp),%eax
  801492:	01 d0                	add    %edx,%eax
  801494:	c6 00 00             	movb   $0x0,(%eax)
}
  801497:	90                   	nop
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80149d:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8014a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a9:	8b 00                	mov    (%eax),%eax
  8014ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b5:	01 d0                	add    %edx,%eax
  8014b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014bd:	eb 0c                	jmp    8014cb <strsplit+0x31>
			*string++ = 0;
  8014bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c2:	8d 50 01             	lea    0x1(%eax),%edx
  8014c5:	89 55 08             	mov    %edx,0x8(%ebp)
  8014c8:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	8a 00                	mov    (%eax),%al
  8014d0:	84 c0                	test   %al,%al
  8014d2:	74 18                	je     8014ec <strsplit+0x52>
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	8a 00                	mov    (%eax),%al
  8014d9:	0f be c0             	movsbl %al,%eax
  8014dc:	50                   	push   %eax
  8014dd:	ff 75 0c             	pushl  0xc(%ebp)
  8014e0:	e8 13 fb ff ff       	call   800ff8 <strchr>
  8014e5:	83 c4 08             	add    $0x8,%esp
  8014e8:	85 c0                	test   %eax,%eax
  8014ea:	75 d3                	jne    8014bf <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	8a 00                	mov    (%eax),%al
  8014f1:	84 c0                	test   %al,%al
  8014f3:	74 5a                	je     80154f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8014f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f8:	8b 00                	mov    (%eax),%eax
  8014fa:	83 f8 0f             	cmp    $0xf,%eax
  8014fd:	75 07                	jne    801506 <strsplit+0x6c>
		{
			return 0;
  8014ff:	b8 00 00 00 00       	mov    $0x0,%eax
  801504:	eb 66                	jmp    80156c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801506:	8b 45 14             	mov    0x14(%ebp),%eax
  801509:	8b 00                	mov    (%eax),%eax
  80150b:	8d 48 01             	lea    0x1(%eax),%ecx
  80150e:	8b 55 14             	mov    0x14(%ebp),%edx
  801511:	89 0a                	mov    %ecx,(%edx)
  801513:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80151a:	8b 45 10             	mov    0x10(%ebp),%eax
  80151d:	01 c2                	add    %eax,%edx
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801524:	eb 03                	jmp    801529 <strsplit+0x8f>
			string++;
  801526:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
  80152c:	8a 00                	mov    (%eax),%al
  80152e:	84 c0                	test   %al,%al
  801530:	74 8b                	je     8014bd <strsplit+0x23>
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	8a 00                	mov    (%eax),%al
  801537:	0f be c0             	movsbl %al,%eax
  80153a:	50                   	push   %eax
  80153b:	ff 75 0c             	pushl  0xc(%ebp)
  80153e:	e8 b5 fa ff ff       	call   800ff8 <strchr>
  801543:	83 c4 08             	add    $0x8,%esp
  801546:	85 c0                	test   %eax,%eax
  801548:	74 dc                	je     801526 <strsplit+0x8c>
			string++;
	}
  80154a:	e9 6e ff ff ff       	jmp    8014bd <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80154f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801550:	8b 45 14             	mov    0x14(%ebp),%eax
  801553:	8b 00                	mov    (%eax),%eax
  801555:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80155c:	8b 45 10             	mov    0x10(%ebp),%eax
  80155f:	01 d0                	add    %edx,%eax
  801561:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801567:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80156c:	c9                   	leave  
  80156d:	c3                   	ret    

0080156e <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
  801571:	83 ec 18             	sub    $0x18,%esp
  801574:	8b 45 10             	mov    0x10(%ebp),%eax
  801577:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80157a:	83 ec 04             	sub    $0x4,%esp
  80157d:	68 70 26 80 00       	push   $0x802670
  801582:	6a 17                	push   $0x17
  801584:	68 8f 26 80 00       	push   $0x80268f
  801589:	e8 8a 08 00 00       	call   801e18 <_panic>

0080158e <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
  801591:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801594:	83 ec 04             	sub    $0x4,%esp
  801597:	68 9b 26 80 00       	push   $0x80269b
  80159c:	6a 2f                	push   $0x2f
  80159e:	68 8f 26 80 00       	push   $0x80268f
  8015a3:	e8 70 08 00 00       	call   801e18 <_panic>

008015a8 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
  8015ab:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8015ae:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8015b5:	8b 55 08             	mov    0x8(%ebp),%edx
  8015b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015bb:	01 d0                	add    %edx,%eax
  8015bd:	48                   	dec    %eax
  8015be:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8015c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015c4:	ba 00 00 00 00       	mov    $0x0,%edx
  8015c9:	f7 75 ec             	divl   -0x14(%ebp)
  8015cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015cf:	29 d0                	sub    %edx,%eax
  8015d1:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8015d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d7:	c1 e8 0c             	shr    $0xc,%eax
  8015da:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8015dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8015e4:	e9 c8 00 00 00       	jmp    8016b1 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8015e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015f0:	eb 27                	jmp    801619 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8015f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015f8:	01 c2                	add    %eax,%edx
  8015fa:	89 d0                	mov    %edx,%eax
  8015fc:	01 c0                	add    %eax,%eax
  8015fe:	01 d0                	add    %edx,%eax
  801600:	c1 e0 02             	shl    $0x2,%eax
  801603:	05 48 30 80 00       	add    $0x803048,%eax
  801608:	8b 00                	mov    (%eax),%eax
  80160a:	85 c0                	test   %eax,%eax
  80160c:	74 08                	je     801616 <malloc+0x6e>
            	i += j;
  80160e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801611:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801614:	eb 0b                	jmp    801621 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801616:	ff 45 f0             	incl   -0x10(%ebp)
  801619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80161c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80161f:	72 d1                	jb     8015f2 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801621:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801624:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801627:	0f 85 81 00 00 00    	jne    8016ae <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80162d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801630:	05 00 00 08 00       	add    $0x80000,%eax
  801635:	c1 e0 0c             	shl    $0xc,%eax
  801638:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80163b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801642:	eb 1f                	jmp    801663 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801644:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801647:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80164a:	01 c2                	add    %eax,%edx
  80164c:	89 d0                	mov    %edx,%eax
  80164e:	01 c0                	add    %eax,%eax
  801650:	01 d0                	add    %edx,%eax
  801652:	c1 e0 02             	shl    $0x2,%eax
  801655:	05 48 30 80 00       	add    $0x803048,%eax
  80165a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801660:	ff 45 f0             	incl   -0x10(%ebp)
  801663:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801666:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801669:	72 d9                	jb     801644 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80166b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80166e:	89 d0                	mov    %edx,%eax
  801670:	01 c0                	add    %eax,%eax
  801672:	01 d0                	add    %edx,%eax
  801674:	c1 e0 02             	shl    $0x2,%eax
  801677:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80167d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801680:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801682:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801685:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801688:	89 c8                	mov    %ecx,%eax
  80168a:	01 c0                	add    %eax,%eax
  80168c:	01 c8                	add    %ecx,%eax
  80168e:	c1 e0 02             	shl    $0x2,%eax
  801691:	05 44 30 80 00       	add    $0x803044,%eax
  801696:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801698:	83 ec 08             	sub    $0x8,%esp
  80169b:	ff 75 08             	pushl  0x8(%ebp)
  80169e:	ff 75 e0             	pushl  -0x20(%ebp)
  8016a1:	e8 2b 03 00 00       	call   8019d1 <sys_allocateMem>
  8016a6:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8016a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016ac:	eb 19                	jmp    8016c7 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8016ae:	ff 45 f4             	incl   -0xc(%ebp)
  8016b1:	a1 04 30 80 00       	mov    0x803004,%eax
  8016b6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8016b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8016bc:	0f 83 27 ff ff ff    	jae    8015e9 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8016c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
  8016cc:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8016cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016d3:	0f 84 e5 00 00 00    	je     8017be <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8016d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8016df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016e2:	05 00 00 00 80       	add    $0x80000000,%eax
  8016e7:	c1 e8 0c             	shr    $0xc,%eax
  8016ea:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8016ed:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016f0:	89 d0                	mov    %edx,%eax
  8016f2:	01 c0                	add    %eax,%eax
  8016f4:	01 d0                	add    %edx,%eax
  8016f6:	c1 e0 02             	shl    $0x2,%eax
  8016f9:	05 40 30 80 00       	add    $0x803040,%eax
  8016fe:	8b 00                	mov    (%eax),%eax
  801700:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801703:	0f 85 b8 00 00 00    	jne    8017c1 <free+0xf8>
  801709:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80170c:	89 d0                	mov    %edx,%eax
  80170e:	01 c0                	add    %eax,%eax
  801710:	01 d0                	add    %edx,%eax
  801712:	c1 e0 02             	shl    $0x2,%eax
  801715:	05 48 30 80 00       	add    $0x803048,%eax
  80171a:	8b 00                	mov    (%eax),%eax
  80171c:	85 c0                	test   %eax,%eax
  80171e:	0f 84 9d 00 00 00    	je     8017c1 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801724:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801727:	89 d0                	mov    %edx,%eax
  801729:	01 c0                	add    %eax,%eax
  80172b:	01 d0                	add    %edx,%eax
  80172d:	c1 e0 02             	shl    $0x2,%eax
  801730:	05 44 30 80 00       	add    $0x803044,%eax
  801735:	8b 00                	mov    (%eax),%eax
  801737:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80173a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80173d:	c1 e0 0c             	shl    $0xc,%eax
  801740:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801743:	83 ec 08             	sub    $0x8,%esp
  801746:	ff 75 e4             	pushl  -0x1c(%ebp)
  801749:	ff 75 f0             	pushl  -0x10(%ebp)
  80174c:	e8 64 02 00 00       	call   8019b5 <sys_freeMem>
  801751:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801754:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80175b:	eb 57                	jmp    8017b4 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80175d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801760:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801763:	01 c2                	add    %eax,%edx
  801765:	89 d0                	mov    %edx,%eax
  801767:	01 c0                	add    %eax,%eax
  801769:	01 d0                	add    %edx,%eax
  80176b:	c1 e0 02             	shl    $0x2,%eax
  80176e:	05 48 30 80 00       	add    $0x803048,%eax
  801773:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801779:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80177c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80177f:	01 c2                	add    %eax,%edx
  801781:	89 d0                	mov    %edx,%eax
  801783:	01 c0                	add    %eax,%eax
  801785:	01 d0                	add    %edx,%eax
  801787:	c1 e0 02             	shl    $0x2,%eax
  80178a:	05 40 30 80 00       	add    $0x803040,%eax
  80178f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801795:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801798:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179b:	01 c2                	add    %eax,%edx
  80179d:	89 d0                	mov    %edx,%eax
  80179f:	01 c0                	add    %eax,%eax
  8017a1:	01 d0                	add    %edx,%eax
  8017a3:	c1 e0 02             	shl    $0x2,%eax
  8017a6:	05 44 30 80 00       	add    $0x803044,%eax
  8017ab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8017b1:	ff 45 f4             	incl   -0xc(%ebp)
  8017b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8017ba:	7c a1                	jl     80175d <free+0x94>
  8017bc:	eb 04                	jmp    8017c2 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8017be:	90                   	nop
  8017bf:	eb 01                	jmp    8017c2 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8017c1:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
  8017c7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8017ca:	83 ec 04             	sub    $0x4,%esp
  8017cd:	68 b8 26 80 00       	push   $0x8026b8
  8017d2:	68 ae 00 00 00       	push   $0xae
  8017d7:	68 8f 26 80 00       	push   $0x80268f
  8017dc:	e8 37 06 00 00       	call   801e18 <_panic>

008017e1 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
  8017e4:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8017e7:	83 ec 04             	sub    $0x4,%esp
  8017ea:	68 d8 26 80 00       	push   $0x8026d8
  8017ef:	68 ca 00 00 00       	push   $0xca
  8017f4:	68 8f 26 80 00       	push   $0x80268f
  8017f9:	e8 1a 06 00 00       	call   801e18 <_panic>

008017fe <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
  801801:	57                   	push   %edi
  801802:	56                   	push   %esi
  801803:	53                   	push   %ebx
  801804:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801807:	8b 45 08             	mov    0x8(%ebp),%eax
  80180a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801810:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801813:	8b 7d 18             	mov    0x18(%ebp),%edi
  801816:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801819:	cd 30                	int    $0x30
  80181b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80181e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801821:	83 c4 10             	add    $0x10,%esp
  801824:	5b                   	pop    %ebx
  801825:	5e                   	pop    %esi
  801826:	5f                   	pop    %edi
  801827:	5d                   	pop    %ebp
  801828:	c3                   	ret    

00801829 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
  80182c:	83 ec 04             	sub    $0x4,%esp
  80182f:	8b 45 10             	mov    0x10(%ebp),%eax
  801832:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801835:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801839:	8b 45 08             	mov    0x8(%ebp),%eax
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	52                   	push   %edx
  801841:	ff 75 0c             	pushl  0xc(%ebp)
  801844:	50                   	push   %eax
  801845:	6a 00                	push   $0x0
  801847:	e8 b2 ff ff ff       	call   8017fe <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
}
  80184f:	90                   	nop
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <sys_cgetc>:

int
sys_cgetc(void)
{
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 01                	push   $0x1
  801861:	e8 98 ff ff ff       	call   8017fe <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	50                   	push   %eax
  80187a:	6a 05                	push   $0x5
  80187c:	e8 7d ff ff ff       	call   8017fe <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 02                	push   $0x2
  801895:	e8 64 ff ff ff       	call   8017fe <syscall>
  80189a:	83 c4 18             	add    $0x18,%esp
}
  80189d:	c9                   	leave  
  80189e:	c3                   	ret    

0080189f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80189f:	55                   	push   %ebp
  8018a0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 03                	push   $0x3
  8018ae:	e8 4b ff ff ff       	call   8017fe <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
}
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 04                	push   $0x4
  8018c7:	e8 32 ff ff ff       	call   8017fe <syscall>
  8018cc:	83 c4 18             	add    $0x18,%esp
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_env_exit>:


void sys_env_exit(void)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 06                	push   $0x6
  8018e0:	e8 19 ff ff ff       	call   8017fe <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
}
  8018e8:	90                   	nop
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	52                   	push   %edx
  8018fb:	50                   	push   %eax
  8018fc:	6a 07                	push   $0x7
  8018fe:	e8 fb fe ff ff       	call   8017fe <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
  80190b:	56                   	push   %esi
  80190c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80190d:	8b 75 18             	mov    0x18(%ebp),%esi
  801910:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801913:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801916:	8b 55 0c             	mov    0xc(%ebp),%edx
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	56                   	push   %esi
  80191d:	53                   	push   %ebx
  80191e:	51                   	push   %ecx
  80191f:	52                   	push   %edx
  801920:	50                   	push   %eax
  801921:	6a 08                	push   $0x8
  801923:	e8 d6 fe ff ff       	call   8017fe <syscall>
  801928:	83 c4 18             	add    $0x18,%esp
}
  80192b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80192e:	5b                   	pop    %ebx
  80192f:	5e                   	pop    %esi
  801930:	5d                   	pop    %ebp
  801931:	c3                   	ret    

00801932 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801935:	8b 55 0c             	mov    0xc(%ebp),%edx
  801938:	8b 45 08             	mov    0x8(%ebp),%eax
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	52                   	push   %edx
  801942:	50                   	push   %eax
  801943:	6a 09                	push   $0x9
  801945:	e8 b4 fe ff ff       	call   8017fe <syscall>
  80194a:	83 c4 18             	add    $0x18,%esp
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	ff 75 0c             	pushl  0xc(%ebp)
  80195b:	ff 75 08             	pushl  0x8(%ebp)
  80195e:	6a 0a                	push   $0xa
  801960:	e8 99 fe ff ff       	call   8017fe <syscall>
  801965:	83 c4 18             	add    $0x18,%esp
}
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 0b                	push   $0xb
  801979:	e8 80 fe ff ff       	call   8017fe <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 0c                	push   $0xc
  801992:	e8 67 fe ff ff       	call   8017fe <syscall>
  801997:	83 c4 18             	add    $0x18,%esp
}
  80199a:	c9                   	leave  
  80199b:	c3                   	ret    

0080199c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80199c:	55                   	push   %ebp
  80199d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 0d                	push   $0xd
  8019ab:	e8 4e fe ff ff       	call   8017fe <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	ff 75 0c             	pushl  0xc(%ebp)
  8019c1:	ff 75 08             	pushl  0x8(%ebp)
  8019c4:	6a 11                	push   $0x11
  8019c6:	e8 33 fe ff ff       	call   8017fe <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
	return;
  8019ce:	90                   	nop
}
  8019cf:	c9                   	leave  
  8019d0:	c3                   	ret    

008019d1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019d1:	55                   	push   %ebp
  8019d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	ff 75 0c             	pushl  0xc(%ebp)
  8019dd:	ff 75 08             	pushl  0x8(%ebp)
  8019e0:	6a 12                	push   $0x12
  8019e2:	e8 17 fe ff ff       	call   8017fe <syscall>
  8019e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ea:	90                   	nop
}
  8019eb:	c9                   	leave  
  8019ec:	c3                   	ret    

008019ed <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019ed:	55                   	push   %ebp
  8019ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 0e                	push   $0xe
  8019fc:	e8 fd fd ff ff       	call   8017fe <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
}
  801a04:	c9                   	leave  
  801a05:	c3                   	ret    

00801a06 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	ff 75 08             	pushl  0x8(%ebp)
  801a14:	6a 0f                	push   $0xf
  801a16:	e8 e3 fd ff ff       	call   8017fe <syscall>
  801a1b:	83 c4 18             	add    $0x18,%esp
}
  801a1e:	c9                   	leave  
  801a1f:	c3                   	ret    

00801a20 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a20:	55                   	push   %ebp
  801a21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 10                	push   $0x10
  801a2f:	e8 ca fd ff ff       	call   8017fe <syscall>
  801a34:	83 c4 18             	add    $0x18,%esp
}
  801a37:	90                   	nop
  801a38:	c9                   	leave  
  801a39:	c3                   	ret    

00801a3a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 14                	push   $0x14
  801a49:	e8 b0 fd ff ff       	call   8017fe <syscall>
  801a4e:	83 c4 18             	add    $0x18,%esp
}
  801a51:	90                   	nop
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a54:	55                   	push   %ebp
  801a55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 15                	push   $0x15
  801a63:	e8 96 fd ff ff       	call   8017fe <syscall>
  801a68:	83 c4 18             	add    $0x18,%esp
}
  801a6b:	90                   	nop
  801a6c:	c9                   	leave  
  801a6d:	c3                   	ret    

00801a6e <sys_cputc>:


void
sys_cputc(const char c)
{
  801a6e:	55                   	push   %ebp
  801a6f:	89 e5                	mov    %esp,%ebp
  801a71:	83 ec 04             	sub    $0x4,%esp
  801a74:	8b 45 08             	mov    0x8(%ebp),%eax
  801a77:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a7a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	50                   	push   %eax
  801a87:	6a 16                	push   $0x16
  801a89:	e8 70 fd ff ff       	call   8017fe <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
}
  801a91:	90                   	nop
  801a92:	c9                   	leave  
  801a93:	c3                   	ret    

00801a94 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 17                	push   $0x17
  801aa3:	e8 56 fd ff ff       	call   8017fe <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
}
  801aab:	90                   	nop
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	ff 75 0c             	pushl  0xc(%ebp)
  801abd:	50                   	push   %eax
  801abe:	6a 18                	push   $0x18
  801ac0:	e8 39 fd ff ff       	call   8017fe <syscall>
  801ac5:	83 c4 18             	add    $0x18,%esp
}
  801ac8:	c9                   	leave  
  801ac9:	c3                   	ret    

00801aca <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801aca:	55                   	push   %ebp
  801acb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801acd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	52                   	push   %edx
  801ada:	50                   	push   %eax
  801adb:	6a 1b                	push   $0x1b
  801add:	e8 1c fd ff ff       	call   8017fe <syscall>
  801ae2:	83 c4 18             	add    $0x18,%esp
}
  801ae5:	c9                   	leave  
  801ae6:	c3                   	ret    

00801ae7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ae7:	55                   	push   %ebp
  801ae8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801aea:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	52                   	push   %edx
  801af7:	50                   	push   %eax
  801af8:	6a 19                	push   $0x19
  801afa:	e8 ff fc ff ff       	call   8017fe <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
}
  801b02:	90                   	nop
  801b03:	c9                   	leave  
  801b04:	c3                   	ret    

00801b05 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b05:	55                   	push   %ebp
  801b06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	52                   	push   %edx
  801b15:	50                   	push   %eax
  801b16:	6a 1a                	push   $0x1a
  801b18:	e8 e1 fc ff ff       	call   8017fe <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
}
  801b20:	90                   	nop
  801b21:	c9                   	leave  
  801b22:	c3                   	ret    

00801b23 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b23:	55                   	push   %ebp
  801b24:	89 e5                	mov    %esp,%ebp
  801b26:	83 ec 04             	sub    $0x4,%esp
  801b29:	8b 45 10             	mov    0x10(%ebp),%eax
  801b2c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b2f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b32:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	6a 00                	push   $0x0
  801b3b:	51                   	push   %ecx
  801b3c:	52                   	push   %edx
  801b3d:	ff 75 0c             	pushl  0xc(%ebp)
  801b40:	50                   	push   %eax
  801b41:	6a 1c                	push   $0x1c
  801b43:	e8 b6 fc ff ff       	call   8017fe <syscall>
  801b48:	83 c4 18             	add    $0x18,%esp
}
  801b4b:	c9                   	leave  
  801b4c:	c3                   	ret    

00801b4d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b4d:	55                   	push   %ebp
  801b4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b53:	8b 45 08             	mov    0x8(%ebp),%eax
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	52                   	push   %edx
  801b5d:	50                   	push   %eax
  801b5e:	6a 1d                	push   $0x1d
  801b60:	e8 99 fc ff ff       	call   8017fe <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
}
  801b68:	c9                   	leave  
  801b69:	c3                   	ret    

00801b6a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b6d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b73:	8b 45 08             	mov    0x8(%ebp),%eax
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	51                   	push   %ecx
  801b7b:	52                   	push   %edx
  801b7c:	50                   	push   %eax
  801b7d:	6a 1e                	push   $0x1e
  801b7f:	e8 7a fc ff ff       	call   8017fe <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
}
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	52                   	push   %edx
  801b99:	50                   	push   %eax
  801b9a:	6a 1f                	push   $0x1f
  801b9c:	e8 5d fc ff ff       	call   8017fe <syscall>
  801ba1:	83 c4 18             	add    $0x18,%esp
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 20                	push   $0x20
  801bb5:	e8 44 fc ff ff       	call   8017fe <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
}
  801bbd:	c9                   	leave  
  801bbe:	c3                   	ret    

00801bbf <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801bbf:	55                   	push   %ebp
  801bc0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	ff 75 10             	pushl  0x10(%ebp)
  801bcc:	ff 75 0c             	pushl  0xc(%ebp)
  801bcf:	50                   	push   %eax
  801bd0:	6a 21                	push   $0x21
  801bd2:	e8 27 fc ff ff       	call   8017fe <syscall>
  801bd7:	83 c4 18             	add    $0x18,%esp
}
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	50                   	push   %eax
  801beb:	6a 22                	push   $0x22
  801bed:	e8 0c fc ff ff       	call   8017fe <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
}
  801bf5:	90                   	nop
  801bf6:	c9                   	leave  
  801bf7:	c3                   	ret    

00801bf8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	50                   	push   %eax
  801c07:	6a 23                	push   $0x23
  801c09:	e8 f0 fb ff ff       	call   8017fe <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	90                   	nop
  801c12:	c9                   	leave  
  801c13:	c3                   	ret    

00801c14 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c14:	55                   	push   %ebp
  801c15:	89 e5                	mov    %esp,%ebp
  801c17:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c1a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c1d:	8d 50 04             	lea    0x4(%eax),%edx
  801c20:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	52                   	push   %edx
  801c2a:	50                   	push   %eax
  801c2b:	6a 24                	push   $0x24
  801c2d:	e8 cc fb ff ff       	call   8017fe <syscall>
  801c32:	83 c4 18             	add    $0x18,%esp
	return result;
  801c35:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c38:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c3b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c3e:	89 01                	mov    %eax,(%ecx)
  801c40:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c43:	8b 45 08             	mov    0x8(%ebp),%eax
  801c46:	c9                   	leave  
  801c47:	c2 04 00             	ret    $0x4

00801c4a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c4a:	55                   	push   %ebp
  801c4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	ff 75 10             	pushl  0x10(%ebp)
  801c54:	ff 75 0c             	pushl  0xc(%ebp)
  801c57:	ff 75 08             	pushl  0x8(%ebp)
  801c5a:	6a 13                	push   $0x13
  801c5c:	e8 9d fb ff ff       	call   8017fe <syscall>
  801c61:	83 c4 18             	add    $0x18,%esp
	return ;
  801c64:	90                   	nop
}
  801c65:	c9                   	leave  
  801c66:	c3                   	ret    

00801c67 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c67:	55                   	push   %ebp
  801c68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 25                	push   $0x25
  801c76:	e8 83 fb ff ff       	call   8017fe <syscall>
  801c7b:	83 c4 18             	add    $0x18,%esp
}
  801c7e:	c9                   	leave  
  801c7f:	c3                   	ret    

00801c80 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c80:	55                   	push   %ebp
  801c81:	89 e5                	mov    %esp,%ebp
  801c83:	83 ec 04             	sub    $0x4,%esp
  801c86:	8b 45 08             	mov    0x8(%ebp),%eax
  801c89:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c8c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	50                   	push   %eax
  801c99:	6a 26                	push   $0x26
  801c9b:	e8 5e fb ff ff       	call   8017fe <syscall>
  801ca0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ca3:	90                   	nop
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <rsttst>:
void rsttst()
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 28                	push   $0x28
  801cb5:	e8 44 fb ff ff       	call   8017fe <syscall>
  801cba:	83 c4 18             	add    $0x18,%esp
	return ;
  801cbd:	90                   	nop
}
  801cbe:	c9                   	leave  
  801cbf:	c3                   	ret    

00801cc0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cc0:	55                   	push   %ebp
  801cc1:	89 e5                	mov    %esp,%ebp
  801cc3:	83 ec 04             	sub    $0x4,%esp
  801cc6:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ccc:	8b 55 18             	mov    0x18(%ebp),%edx
  801ccf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cd3:	52                   	push   %edx
  801cd4:	50                   	push   %eax
  801cd5:	ff 75 10             	pushl  0x10(%ebp)
  801cd8:	ff 75 0c             	pushl  0xc(%ebp)
  801cdb:	ff 75 08             	pushl  0x8(%ebp)
  801cde:	6a 27                	push   $0x27
  801ce0:	e8 19 fb ff ff       	call   8017fe <syscall>
  801ce5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ce8:	90                   	nop
}
  801ce9:	c9                   	leave  
  801cea:	c3                   	ret    

00801ceb <chktst>:
void chktst(uint32 n)
{
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	ff 75 08             	pushl  0x8(%ebp)
  801cf9:	6a 29                	push   $0x29
  801cfb:	e8 fe fa ff ff       	call   8017fe <syscall>
  801d00:	83 c4 18             	add    $0x18,%esp
	return ;
  801d03:	90                   	nop
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <inctst>:

void inctst()
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 2a                	push   $0x2a
  801d15:	e8 e4 fa ff ff       	call   8017fe <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d1d:	90                   	nop
}
  801d1e:	c9                   	leave  
  801d1f:	c3                   	ret    

00801d20 <gettst>:
uint32 gettst()
{
  801d20:	55                   	push   %ebp
  801d21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 2b                	push   $0x2b
  801d2f:	e8 ca fa ff ff       	call   8017fe <syscall>
  801d34:	83 c4 18             	add    $0x18,%esp
}
  801d37:	c9                   	leave  
  801d38:	c3                   	ret    

00801d39 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
  801d3c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 2c                	push   $0x2c
  801d4b:	e8 ae fa ff ff       	call   8017fe <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
  801d53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d56:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d5a:	75 07                	jne    801d63 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d5c:	b8 01 00 00 00       	mov    $0x1,%eax
  801d61:	eb 05                	jmp    801d68 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d63:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d68:	c9                   	leave  
  801d69:	c3                   	ret    

00801d6a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d6a:	55                   	push   %ebp
  801d6b:	89 e5                	mov    %esp,%ebp
  801d6d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 2c                	push   $0x2c
  801d7c:	e8 7d fa ff ff       	call   8017fe <syscall>
  801d81:	83 c4 18             	add    $0x18,%esp
  801d84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d87:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d8b:	75 07                	jne    801d94 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d8d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d92:	eb 05                	jmp    801d99 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
  801d9e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	6a 00                	push   $0x0
  801dab:	6a 2c                	push   $0x2c
  801dad:	e8 4c fa ff ff       	call   8017fe <syscall>
  801db2:	83 c4 18             	add    $0x18,%esp
  801db5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801db8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801dbc:	75 07                	jne    801dc5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801dbe:	b8 01 00 00 00       	mov    $0x1,%eax
  801dc3:	eb 05                	jmp    801dca <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801dc5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dca:	c9                   	leave  
  801dcb:	c3                   	ret    

00801dcc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801dcc:	55                   	push   %ebp
  801dcd:	89 e5                	mov    %esp,%ebp
  801dcf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 2c                	push   $0x2c
  801dde:	e8 1b fa ff ff       	call   8017fe <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
  801de6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801de9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ded:	75 07                	jne    801df6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801def:	b8 01 00 00 00       	mov    $0x1,%eax
  801df4:	eb 05                	jmp    801dfb <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801df6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dfb:	c9                   	leave  
  801dfc:	c3                   	ret    

00801dfd <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801dfd:	55                   	push   %ebp
  801dfe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	ff 75 08             	pushl  0x8(%ebp)
  801e0b:	6a 2d                	push   $0x2d
  801e0d:	e8 ec f9 ff ff       	call   8017fe <syscall>
  801e12:	83 c4 18             	add    $0x18,%esp
	return ;
  801e15:	90                   	nop
}
  801e16:	c9                   	leave  
  801e17:	c3                   	ret    

00801e18 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801e18:	55                   	push   %ebp
  801e19:	89 e5                	mov    %esp,%ebp
  801e1b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801e1e:	8d 45 10             	lea    0x10(%ebp),%eax
  801e21:	83 c0 04             	add    $0x4,%eax
  801e24:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801e27:	a1 40 30 98 00       	mov    0x983040,%eax
  801e2c:	85 c0                	test   %eax,%eax
  801e2e:	74 16                	je     801e46 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801e30:	a1 40 30 98 00       	mov    0x983040,%eax
  801e35:	83 ec 08             	sub    $0x8,%esp
  801e38:	50                   	push   %eax
  801e39:	68 fc 26 80 00       	push   $0x8026fc
  801e3e:	e8 a1 e9 ff ff       	call   8007e4 <cprintf>
  801e43:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801e46:	a1 00 30 80 00       	mov    0x803000,%eax
  801e4b:	ff 75 0c             	pushl  0xc(%ebp)
  801e4e:	ff 75 08             	pushl  0x8(%ebp)
  801e51:	50                   	push   %eax
  801e52:	68 01 27 80 00       	push   $0x802701
  801e57:	e8 88 e9 ff ff       	call   8007e4 <cprintf>
  801e5c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801e5f:	8b 45 10             	mov    0x10(%ebp),%eax
  801e62:	83 ec 08             	sub    $0x8,%esp
  801e65:	ff 75 f4             	pushl  -0xc(%ebp)
  801e68:	50                   	push   %eax
  801e69:	e8 0b e9 ff ff       	call   800779 <vcprintf>
  801e6e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801e71:	83 ec 08             	sub    $0x8,%esp
  801e74:	6a 00                	push   $0x0
  801e76:	68 1d 27 80 00       	push   $0x80271d
  801e7b:	e8 f9 e8 ff ff       	call   800779 <vcprintf>
  801e80:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801e83:	e8 7a e8 ff ff       	call   800702 <exit>

	// should not return here
	while (1) ;
  801e88:	eb fe                	jmp    801e88 <_panic+0x70>

00801e8a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801e8a:	55                   	push   %ebp
  801e8b:	89 e5                	mov    %esp,%ebp
  801e8d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801e90:	a1 20 30 80 00       	mov    0x803020,%eax
  801e95:	8b 50 74             	mov    0x74(%eax),%edx
  801e98:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e9b:	39 c2                	cmp    %eax,%edx
  801e9d:	74 14                	je     801eb3 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801e9f:	83 ec 04             	sub    $0x4,%esp
  801ea2:	68 20 27 80 00       	push   $0x802720
  801ea7:	6a 26                	push   $0x26
  801ea9:	68 6c 27 80 00       	push   $0x80276c
  801eae:	e8 65 ff ff ff       	call   801e18 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801eb3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801eba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ec1:	e9 c2 00 00 00       	jmp    801f88 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801ec6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ec9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed3:	01 d0                	add    %edx,%eax
  801ed5:	8b 00                	mov    (%eax),%eax
  801ed7:	85 c0                	test   %eax,%eax
  801ed9:	75 08                	jne    801ee3 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801edb:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801ede:	e9 a2 00 00 00       	jmp    801f85 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801ee3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801eea:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801ef1:	eb 69                	jmp    801f5c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801ef3:	a1 20 30 80 00       	mov    0x803020,%eax
  801ef8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801efe:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f01:	89 d0                	mov    %edx,%eax
  801f03:	01 c0                	add    %eax,%eax
  801f05:	01 d0                	add    %edx,%eax
  801f07:	c1 e0 02             	shl    $0x2,%eax
  801f0a:	01 c8                	add    %ecx,%eax
  801f0c:	8a 40 04             	mov    0x4(%eax),%al
  801f0f:	84 c0                	test   %al,%al
  801f11:	75 46                	jne    801f59 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f13:	a1 20 30 80 00       	mov    0x803020,%eax
  801f18:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801f1e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f21:	89 d0                	mov    %edx,%eax
  801f23:	01 c0                	add    %eax,%eax
  801f25:	01 d0                	add    %edx,%eax
  801f27:	c1 e0 02             	shl    $0x2,%eax
  801f2a:	01 c8                	add    %ecx,%eax
  801f2c:	8b 00                	mov    (%eax),%eax
  801f2e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801f31:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801f34:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801f39:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801f3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f3e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801f45:	8b 45 08             	mov    0x8(%ebp),%eax
  801f48:	01 c8                	add    %ecx,%eax
  801f4a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f4c:	39 c2                	cmp    %eax,%edx
  801f4e:	75 09                	jne    801f59 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801f50:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801f57:	eb 12                	jmp    801f6b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f59:	ff 45 e8             	incl   -0x18(%ebp)
  801f5c:	a1 20 30 80 00       	mov    0x803020,%eax
  801f61:	8b 50 74             	mov    0x74(%eax),%edx
  801f64:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f67:	39 c2                	cmp    %eax,%edx
  801f69:	77 88                	ja     801ef3 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801f6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801f6f:	75 14                	jne    801f85 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801f71:	83 ec 04             	sub    $0x4,%esp
  801f74:	68 78 27 80 00       	push   $0x802778
  801f79:	6a 3a                	push   $0x3a
  801f7b:	68 6c 27 80 00       	push   $0x80276c
  801f80:	e8 93 fe ff ff       	call   801e18 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801f85:	ff 45 f0             	incl   -0x10(%ebp)
  801f88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f8b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801f8e:	0f 8c 32 ff ff ff    	jl     801ec6 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801f94:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f9b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801fa2:	eb 26                	jmp    801fca <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801fa4:	a1 20 30 80 00       	mov    0x803020,%eax
  801fa9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801faf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801fb2:	89 d0                	mov    %edx,%eax
  801fb4:	01 c0                	add    %eax,%eax
  801fb6:	01 d0                	add    %edx,%eax
  801fb8:	c1 e0 02             	shl    $0x2,%eax
  801fbb:	01 c8                	add    %ecx,%eax
  801fbd:	8a 40 04             	mov    0x4(%eax),%al
  801fc0:	3c 01                	cmp    $0x1,%al
  801fc2:	75 03                	jne    801fc7 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801fc4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801fc7:	ff 45 e0             	incl   -0x20(%ebp)
  801fca:	a1 20 30 80 00       	mov    0x803020,%eax
  801fcf:	8b 50 74             	mov    0x74(%eax),%edx
  801fd2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801fd5:	39 c2                	cmp    %eax,%edx
  801fd7:	77 cb                	ja     801fa4 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801fd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fdc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801fdf:	74 14                	je     801ff5 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801fe1:	83 ec 04             	sub    $0x4,%esp
  801fe4:	68 cc 27 80 00       	push   $0x8027cc
  801fe9:	6a 44                	push   $0x44
  801feb:	68 6c 27 80 00       	push   $0x80276c
  801ff0:	e8 23 fe ff ff       	call   801e18 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801ff5:	90                   	nop
  801ff6:	c9                   	leave  
  801ff7:	c3                   	ret    

00801ff8 <__udivdi3>:
  801ff8:	55                   	push   %ebp
  801ff9:	57                   	push   %edi
  801ffa:	56                   	push   %esi
  801ffb:	53                   	push   %ebx
  801ffc:	83 ec 1c             	sub    $0x1c,%esp
  801fff:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802003:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802007:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80200b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80200f:	89 ca                	mov    %ecx,%edx
  802011:	89 f8                	mov    %edi,%eax
  802013:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802017:	85 f6                	test   %esi,%esi
  802019:	75 2d                	jne    802048 <__udivdi3+0x50>
  80201b:	39 cf                	cmp    %ecx,%edi
  80201d:	77 65                	ja     802084 <__udivdi3+0x8c>
  80201f:	89 fd                	mov    %edi,%ebp
  802021:	85 ff                	test   %edi,%edi
  802023:	75 0b                	jne    802030 <__udivdi3+0x38>
  802025:	b8 01 00 00 00       	mov    $0x1,%eax
  80202a:	31 d2                	xor    %edx,%edx
  80202c:	f7 f7                	div    %edi
  80202e:	89 c5                	mov    %eax,%ebp
  802030:	31 d2                	xor    %edx,%edx
  802032:	89 c8                	mov    %ecx,%eax
  802034:	f7 f5                	div    %ebp
  802036:	89 c1                	mov    %eax,%ecx
  802038:	89 d8                	mov    %ebx,%eax
  80203a:	f7 f5                	div    %ebp
  80203c:	89 cf                	mov    %ecx,%edi
  80203e:	89 fa                	mov    %edi,%edx
  802040:	83 c4 1c             	add    $0x1c,%esp
  802043:	5b                   	pop    %ebx
  802044:	5e                   	pop    %esi
  802045:	5f                   	pop    %edi
  802046:	5d                   	pop    %ebp
  802047:	c3                   	ret    
  802048:	39 ce                	cmp    %ecx,%esi
  80204a:	77 28                	ja     802074 <__udivdi3+0x7c>
  80204c:	0f bd fe             	bsr    %esi,%edi
  80204f:	83 f7 1f             	xor    $0x1f,%edi
  802052:	75 40                	jne    802094 <__udivdi3+0x9c>
  802054:	39 ce                	cmp    %ecx,%esi
  802056:	72 0a                	jb     802062 <__udivdi3+0x6a>
  802058:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80205c:	0f 87 9e 00 00 00    	ja     802100 <__udivdi3+0x108>
  802062:	b8 01 00 00 00       	mov    $0x1,%eax
  802067:	89 fa                	mov    %edi,%edx
  802069:	83 c4 1c             	add    $0x1c,%esp
  80206c:	5b                   	pop    %ebx
  80206d:	5e                   	pop    %esi
  80206e:	5f                   	pop    %edi
  80206f:	5d                   	pop    %ebp
  802070:	c3                   	ret    
  802071:	8d 76 00             	lea    0x0(%esi),%esi
  802074:	31 ff                	xor    %edi,%edi
  802076:	31 c0                	xor    %eax,%eax
  802078:	89 fa                	mov    %edi,%edx
  80207a:	83 c4 1c             	add    $0x1c,%esp
  80207d:	5b                   	pop    %ebx
  80207e:	5e                   	pop    %esi
  80207f:	5f                   	pop    %edi
  802080:	5d                   	pop    %ebp
  802081:	c3                   	ret    
  802082:	66 90                	xchg   %ax,%ax
  802084:	89 d8                	mov    %ebx,%eax
  802086:	f7 f7                	div    %edi
  802088:	31 ff                	xor    %edi,%edi
  80208a:	89 fa                	mov    %edi,%edx
  80208c:	83 c4 1c             	add    $0x1c,%esp
  80208f:	5b                   	pop    %ebx
  802090:	5e                   	pop    %esi
  802091:	5f                   	pop    %edi
  802092:	5d                   	pop    %ebp
  802093:	c3                   	ret    
  802094:	bd 20 00 00 00       	mov    $0x20,%ebp
  802099:	89 eb                	mov    %ebp,%ebx
  80209b:	29 fb                	sub    %edi,%ebx
  80209d:	89 f9                	mov    %edi,%ecx
  80209f:	d3 e6                	shl    %cl,%esi
  8020a1:	89 c5                	mov    %eax,%ebp
  8020a3:	88 d9                	mov    %bl,%cl
  8020a5:	d3 ed                	shr    %cl,%ebp
  8020a7:	89 e9                	mov    %ebp,%ecx
  8020a9:	09 f1                	or     %esi,%ecx
  8020ab:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020af:	89 f9                	mov    %edi,%ecx
  8020b1:	d3 e0                	shl    %cl,%eax
  8020b3:	89 c5                	mov    %eax,%ebp
  8020b5:	89 d6                	mov    %edx,%esi
  8020b7:	88 d9                	mov    %bl,%cl
  8020b9:	d3 ee                	shr    %cl,%esi
  8020bb:	89 f9                	mov    %edi,%ecx
  8020bd:	d3 e2                	shl    %cl,%edx
  8020bf:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020c3:	88 d9                	mov    %bl,%cl
  8020c5:	d3 e8                	shr    %cl,%eax
  8020c7:	09 c2                	or     %eax,%edx
  8020c9:	89 d0                	mov    %edx,%eax
  8020cb:	89 f2                	mov    %esi,%edx
  8020cd:	f7 74 24 0c          	divl   0xc(%esp)
  8020d1:	89 d6                	mov    %edx,%esi
  8020d3:	89 c3                	mov    %eax,%ebx
  8020d5:	f7 e5                	mul    %ebp
  8020d7:	39 d6                	cmp    %edx,%esi
  8020d9:	72 19                	jb     8020f4 <__udivdi3+0xfc>
  8020db:	74 0b                	je     8020e8 <__udivdi3+0xf0>
  8020dd:	89 d8                	mov    %ebx,%eax
  8020df:	31 ff                	xor    %edi,%edi
  8020e1:	e9 58 ff ff ff       	jmp    80203e <__udivdi3+0x46>
  8020e6:	66 90                	xchg   %ax,%ax
  8020e8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020ec:	89 f9                	mov    %edi,%ecx
  8020ee:	d3 e2                	shl    %cl,%edx
  8020f0:	39 c2                	cmp    %eax,%edx
  8020f2:	73 e9                	jae    8020dd <__udivdi3+0xe5>
  8020f4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8020f7:	31 ff                	xor    %edi,%edi
  8020f9:	e9 40 ff ff ff       	jmp    80203e <__udivdi3+0x46>
  8020fe:	66 90                	xchg   %ax,%ax
  802100:	31 c0                	xor    %eax,%eax
  802102:	e9 37 ff ff ff       	jmp    80203e <__udivdi3+0x46>
  802107:	90                   	nop

00802108 <__umoddi3>:
  802108:	55                   	push   %ebp
  802109:	57                   	push   %edi
  80210a:	56                   	push   %esi
  80210b:	53                   	push   %ebx
  80210c:	83 ec 1c             	sub    $0x1c,%esp
  80210f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802113:	8b 74 24 34          	mov    0x34(%esp),%esi
  802117:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80211b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80211f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802123:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802127:	89 f3                	mov    %esi,%ebx
  802129:	89 fa                	mov    %edi,%edx
  80212b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80212f:	89 34 24             	mov    %esi,(%esp)
  802132:	85 c0                	test   %eax,%eax
  802134:	75 1a                	jne    802150 <__umoddi3+0x48>
  802136:	39 f7                	cmp    %esi,%edi
  802138:	0f 86 a2 00 00 00    	jbe    8021e0 <__umoddi3+0xd8>
  80213e:	89 c8                	mov    %ecx,%eax
  802140:	89 f2                	mov    %esi,%edx
  802142:	f7 f7                	div    %edi
  802144:	89 d0                	mov    %edx,%eax
  802146:	31 d2                	xor    %edx,%edx
  802148:	83 c4 1c             	add    $0x1c,%esp
  80214b:	5b                   	pop    %ebx
  80214c:	5e                   	pop    %esi
  80214d:	5f                   	pop    %edi
  80214e:	5d                   	pop    %ebp
  80214f:	c3                   	ret    
  802150:	39 f0                	cmp    %esi,%eax
  802152:	0f 87 ac 00 00 00    	ja     802204 <__umoddi3+0xfc>
  802158:	0f bd e8             	bsr    %eax,%ebp
  80215b:	83 f5 1f             	xor    $0x1f,%ebp
  80215e:	0f 84 ac 00 00 00    	je     802210 <__umoddi3+0x108>
  802164:	bf 20 00 00 00       	mov    $0x20,%edi
  802169:	29 ef                	sub    %ebp,%edi
  80216b:	89 fe                	mov    %edi,%esi
  80216d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802171:	89 e9                	mov    %ebp,%ecx
  802173:	d3 e0                	shl    %cl,%eax
  802175:	89 d7                	mov    %edx,%edi
  802177:	89 f1                	mov    %esi,%ecx
  802179:	d3 ef                	shr    %cl,%edi
  80217b:	09 c7                	or     %eax,%edi
  80217d:	89 e9                	mov    %ebp,%ecx
  80217f:	d3 e2                	shl    %cl,%edx
  802181:	89 14 24             	mov    %edx,(%esp)
  802184:	89 d8                	mov    %ebx,%eax
  802186:	d3 e0                	shl    %cl,%eax
  802188:	89 c2                	mov    %eax,%edx
  80218a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80218e:	d3 e0                	shl    %cl,%eax
  802190:	89 44 24 04          	mov    %eax,0x4(%esp)
  802194:	8b 44 24 08          	mov    0x8(%esp),%eax
  802198:	89 f1                	mov    %esi,%ecx
  80219a:	d3 e8                	shr    %cl,%eax
  80219c:	09 d0                	or     %edx,%eax
  80219e:	d3 eb                	shr    %cl,%ebx
  8021a0:	89 da                	mov    %ebx,%edx
  8021a2:	f7 f7                	div    %edi
  8021a4:	89 d3                	mov    %edx,%ebx
  8021a6:	f7 24 24             	mull   (%esp)
  8021a9:	89 c6                	mov    %eax,%esi
  8021ab:	89 d1                	mov    %edx,%ecx
  8021ad:	39 d3                	cmp    %edx,%ebx
  8021af:	0f 82 87 00 00 00    	jb     80223c <__umoddi3+0x134>
  8021b5:	0f 84 91 00 00 00    	je     80224c <__umoddi3+0x144>
  8021bb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021bf:	29 f2                	sub    %esi,%edx
  8021c1:	19 cb                	sbb    %ecx,%ebx
  8021c3:	89 d8                	mov    %ebx,%eax
  8021c5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021c9:	d3 e0                	shl    %cl,%eax
  8021cb:	89 e9                	mov    %ebp,%ecx
  8021cd:	d3 ea                	shr    %cl,%edx
  8021cf:	09 d0                	or     %edx,%eax
  8021d1:	89 e9                	mov    %ebp,%ecx
  8021d3:	d3 eb                	shr    %cl,%ebx
  8021d5:	89 da                	mov    %ebx,%edx
  8021d7:	83 c4 1c             	add    $0x1c,%esp
  8021da:	5b                   	pop    %ebx
  8021db:	5e                   	pop    %esi
  8021dc:	5f                   	pop    %edi
  8021dd:	5d                   	pop    %ebp
  8021de:	c3                   	ret    
  8021df:	90                   	nop
  8021e0:	89 fd                	mov    %edi,%ebp
  8021e2:	85 ff                	test   %edi,%edi
  8021e4:	75 0b                	jne    8021f1 <__umoddi3+0xe9>
  8021e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021eb:	31 d2                	xor    %edx,%edx
  8021ed:	f7 f7                	div    %edi
  8021ef:	89 c5                	mov    %eax,%ebp
  8021f1:	89 f0                	mov    %esi,%eax
  8021f3:	31 d2                	xor    %edx,%edx
  8021f5:	f7 f5                	div    %ebp
  8021f7:	89 c8                	mov    %ecx,%eax
  8021f9:	f7 f5                	div    %ebp
  8021fb:	89 d0                	mov    %edx,%eax
  8021fd:	e9 44 ff ff ff       	jmp    802146 <__umoddi3+0x3e>
  802202:	66 90                	xchg   %ax,%ax
  802204:	89 c8                	mov    %ecx,%eax
  802206:	89 f2                	mov    %esi,%edx
  802208:	83 c4 1c             	add    $0x1c,%esp
  80220b:	5b                   	pop    %ebx
  80220c:	5e                   	pop    %esi
  80220d:	5f                   	pop    %edi
  80220e:	5d                   	pop    %ebp
  80220f:	c3                   	ret    
  802210:	3b 04 24             	cmp    (%esp),%eax
  802213:	72 06                	jb     80221b <__umoddi3+0x113>
  802215:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802219:	77 0f                	ja     80222a <__umoddi3+0x122>
  80221b:	89 f2                	mov    %esi,%edx
  80221d:	29 f9                	sub    %edi,%ecx
  80221f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802223:	89 14 24             	mov    %edx,(%esp)
  802226:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80222a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80222e:	8b 14 24             	mov    (%esp),%edx
  802231:	83 c4 1c             	add    $0x1c,%esp
  802234:	5b                   	pop    %ebx
  802235:	5e                   	pop    %esi
  802236:	5f                   	pop    %edi
  802237:	5d                   	pop    %ebp
  802238:	c3                   	ret    
  802239:	8d 76 00             	lea    0x0(%esi),%esi
  80223c:	2b 04 24             	sub    (%esp),%eax
  80223f:	19 fa                	sbb    %edi,%edx
  802241:	89 d1                	mov    %edx,%ecx
  802243:	89 c6                	mov    %eax,%esi
  802245:	e9 71 ff ff ff       	jmp    8021bb <__umoddi3+0xb3>
  80224a:	66 90                	xchg   %ax,%ax
  80224c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802250:	72 ea                	jb     80223c <__umoddi3+0x134>
  802252:	89 d9                	mov    %ebx,%ecx
  802254:	e9 62 ff ff ff       	jmp    8021bb <__umoddi3+0xb3>
