
obj/user/tst5:     file format elf32-i386


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
  800031:	e8 58 07 00 00       	call   80078e <libmain>
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
  80003d:	83 ec 60             	sub    $0x60,%esp
	
	rsttst();
  800040:	e8 e1 1d 00 00       	call   801e26 <rsttst>
	
	

	int Mega = 1024*1024;
  800045:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  80004c:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	void* ptr_allocations[20] = {0};
  800053:	8d 55 9c             	lea    -0x64(%ebp),%edx
  800056:	b9 14 00 00 00       	mov    $0x14,%ecx
  80005b:	b8 00 00 00 00       	mov    $0x0,%eax
  800060:	89 d7                	mov    %edx,%edi
  800062:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800064:	e8 81 1a 00 00       	call   801aea <sys_calculate_free_frames>
  800069:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  80006c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006f:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800072:	83 ec 0c             	sub    $0xc,%esp
  800075:	50                   	push   %eax
  800076:	e8 ad 16 00 00       	call   801728 <malloc>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  800081:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800084:	83 ec 0c             	sub    $0xc,%esp
  800087:	6a 00                	push   $0x0
  800089:	6a 62                	push   $0x62
  80008b:	68 00 10 00 80       	push   $0x80001000
  800090:	68 00 00 00 80       	push   $0x80000000
  800095:	50                   	push   %eax
  800096:	e8 a5 1d 00 00       	call   801e40 <tst>
  80009b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256+1 ,0, 'e', 0);
  80009e:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000a1:	e8 44 1a 00 00       	call   801aea <sys_calculate_free_frames>
  8000a6:	29 c3                	sub    %eax,%ebx
  8000a8:	89 d8                	mov    %ebx,%eax
  8000aa:	83 ec 0c             	sub    $0xc,%esp
  8000ad:	6a 00                	push   $0x0
  8000af:	6a 65                	push   $0x65
  8000b1:	6a 00                	push   $0x0
  8000b3:	68 01 01 00 00       	push   $0x101
  8000b8:	50                   	push   %eax
  8000b9:	e8 82 1d 00 00       	call   801e40 <tst>
  8000be:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000c1:	e8 24 1a 00 00       	call   801aea <sys_calculate_free_frames>
  8000c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	50                   	push   %eax
  8000d3:	e8 50 16 00 00       	call   801728 <malloc>
  8000d8:	83 c4 10             	add    $0x10,%esp
  8000db:	89 45 a0             	mov    %eax,-0x60(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
  8000de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000e1:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000ea:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8000f0:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8000f3:	83 ec 0c             	sub    $0xc,%esp
  8000f6:	6a 00                	push   $0x0
  8000f8:	6a 62                	push   $0x62
  8000fa:	51                   	push   %ecx
  8000fb:	52                   	push   %edx
  8000fc:	50                   	push   %eax
  8000fd:	e8 3e 1d 00 00       	call   801e40 <tst>
  800102:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  800105:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800108:	e8 dd 19 00 00       	call   801aea <sys_calculate_free_frames>
  80010d:	29 c3                	sub    %eax,%ebx
  80010f:	89 d8                	mov    %ebx,%eax
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	6a 00                	push   $0x0
  800116:	6a 65                	push   $0x65
  800118:	6a 00                	push   $0x0
  80011a:	68 00 01 00 00       	push   $0x100
  80011f:	50                   	push   %eax
  800120:	e8 1b 1d 00 00       	call   801e40 <tst>
  800125:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800128:	e8 bd 19 00 00       	call   801aea <sys_calculate_free_frames>
  80012d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800130:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800133:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800136:	83 ec 0c             	sub    $0xc,%esp
  800139:	50                   	push   %eax
  80013a:	e8 e9 15 00 00       	call   801728 <malloc>
  80013f:	83 c4 10             	add    $0x10,%esp
  800142:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START + 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
  800145:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800148:	01 c0                	add    %eax,%eax
  80014a:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800150:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800153:	01 c0                	add    %eax,%eax
  800155:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80015b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	6a 00                	push   $0x0
  800163:	6a 62                	push   $0x62
  800165:	51                   	push   %ecx
  800166:	52                   	push   %edx
  800167:	50                   	push   %eax
  800168:	e8 d3 1c 00 00       	call   801e40 <tst>
  80016d:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  800170:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800173:	e8 72 19 00 00       	call   801aea <sys_calculate_free_frames>
  800178:	29 c3                	sub    %eax,%ebx
  80017a:	89 d8                	mov    %ebx,%eax
  80017c:	83 ec 0c             	sub    $0xc,%esp
  80017f:	6a 00                	push   $0x0
  800181:	6a 65                	push   $0x65
  800183:	6a 00                	push   $0x0
  800185:	68 00 01 00 00       	push   $0x100
  80018a:	50                   	push   %eax
  80018b:	e8 b0 1c 00 00       	call   801e40 <tst>
  800190:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800193:	e8 52 19 00 00       	call   801aea <sys_calculate_free_frames>
  800198:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  80019b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80019e:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	50                   	push   %eax
  8001a5:	e8 7e 15 00 00       	call   801728 <malloc>
  8001aa:	83 c4 10             	add    $0x10,%esp
  8001ad:	89 45 a8             	mov    %eax,-0x58(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START + 3*Mega,USER_HEAP_START + 3*Mega + PAGE_SIZE, 'b', 0);
  8001b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b3:	89 c2                	mov    %eax,%edx
  8001b5:	01 d2                	add    %edx,%edx
  8001b7:	01 d0                	add    %edx,%eax
  8001b9:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001c2:	89 c2                	mov    %eax,%edx
  8001c4:	01 d2                	add    %edx,%edx
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8001ce:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	6a 00                	push   $0x0
  8001d6:	6a 62                	push   $0x62
  8001d8:	51                   	push   %ecx
  8001d9:	52                   	push   %edx
  8001da:	50                   	push   %eax
  8001db:	e8 60 1c 00 00       	call   801e40 <tst>
  8001e0:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  8001e3:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8001e6:	e8 ff 18 00 00       	call   801aea <sys_calculate_free_frames>
  8001eb:	29 c3                	sub    %eax,%ebx
  8001ed:	89 d8                	mov    %ebx,%eax
  8001ef:	83 ec 0c             	sub    $0xc,%esp
  8001f2:	6a 00                	push   $0x0
  8001f4:	6a 65                	push   $0x65
  8001f6:	6a 00                	push   $0x0
  8001f8:	68 00 01 00 00       	push   $0x100
  8001fd:	50                   	push   %eax
  8001fe:	e8 3d 1c 00 00       	call   801e40 <tst>
  800203:	83 c4 20             	add    $0x20,%esp

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800206:	e8 df 18 00 00       	call   801aea <sys_calculate_free_frames>
  80020b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  80020e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800211:	01 c0                	add    %eax,%eax
  800213:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800216:	83 ec 0c             	sub    $0xc,%esp
  800219:	50                   	push   %eax
  80021a:	e8 09 15 00 00       	call   801728 <malloc>
  80021f:	83 c4 10             	add    $0x10,%esp
  800222:	89 45 ac             	mov    %eax,-0x54(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START + 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  800225:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800228:	c1 e0 02             	shl    $0x2,%eax
  80022b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800231:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800234:	c1 e0 02             	shl    $0x2,%eax
  800237:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80023d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	6a 00                	push   $0x0
  800245:	6a 62                	push   $0x62
  800247:	51                   	push   %ecx
  800248:	52                   	push   %edx
  800249:	50                   	push   %eax
  80024a:	e8 f1 1b 00 00       	call   801e40 <tst>
  80024f:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  800252:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800255:	e8 90 18 00 00       	call   801aea <sys_calculate_free_frames>
  80025a:	29 c3                	sub    %eax,%ebx
  80025c:	89 d8                	mov    %ebx,%eax
  80025e:	83 ec 0c             	sub    $0xc,%esp
  800261:	6a 00                	push   $0x0
  800263:	6a 65                	push   $0x65
  800265:	6a 00                	push   $0x0
  800267:	68 01 02 00 00       	push   $0x201
  80026c:	50                   	push   %eax
  80026d:	e8 ce 1b 00 00       	call   801e40 <tst>
  800272:	83 c4 20             	add    $0x20,%esp

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800275:	e8 70 18 00 00       	call   801aea <sys_calculate_free_frames>
  80027a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  80027d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800280:	01 c0                	add    %eax,%eax
  800282:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800285:	83 ec 0c             	sub    $0xc,%esp
  800288:	50                   	push   %eax
  800289:	e8 9a 14 00 00       	call   801728 <malloc>
  80028e:	83 c4 10             	add    $0x10,%esp
  800291:	89 45 b0             	mov    %eax,-0x50(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START + 6*Mega,USER_HEAP_START + 6*Mega + PAGE_SIZE, 'b', 0);
  800294:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800297:	89 d0                	mov    %edx,%eax
  800299:	01 c0                	add    %eax,%eax
  80029b:	01 d0                	add    %edx,%eax
  80029d:	01 c0                	add    %eax,%eax
  80029f:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002a8:	89 d0                	mov    %edx,%eax
  8002aa:	01 c0                	add    %eax,%eax
  8002ac:	01 d0                	add    %edx,%eax
  8002ae:	01 c0                	add    %eax,%eax
  8002b0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002b6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002b9:	83 ec 0c             	sub    $0xc,%esp
  8002bc:	6a 00                	push   $0x0
  8002be:	6a 62                	push   $0x62
  8002c0:	51                   	push   %ecx
  8002c1:	52                   	push   %edx
  8002c2:	50                   	push   %eax
  8002c3:	e8 78 1b 00 00       	call   801e40 <tst>
  8002c8:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  8002cb:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8002ce:	e8 17 18 00 00       	call   801aea <sys_calculate_free_frames>
  8002d3:	29 c3                	sub    %eax,%ebx
  8002d5:	89 d8                	mov    %ebx,%eax
  8002d7:	83 ec 0c             	sub    $0xc,%esp
  8002da:	6a 00                	push   $0x0
  8002dc:	6a 65                	push   $0x65
  8002de:	6a 00                	push   $0x0
  8002e0:	68 00 02 00 00       	push   $0x200
  8002e5:	50                   	push   %eax
  8002e6:	e8 55 1b 00 00       	call   801e40 <tst>
  8002eb:	83 c4 20             	add    $0x20,%esp

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8002ee:	e8 f7 17 00 00       	call   801aea <sys_calculate_free_frames>
  8002f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8002f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f9:	89 c2                	mov    %eax,%edx
  8002fb:	01 d2                	add    %edx,%edx
  8002fd:	01 d0                	add    %edx,%eax
  8002ff:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800302:	83 ec 0c             	sub    $0xc,%esp
  800305:	50                   	push   %eax
  800306:	e8 1d 14 00 00       	call   801728 <malloc>
  80030b:	83 c4 10             	add    $0x10,%esp
  80030e:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START + 8*Mega,USER_HEAP_START + 8*Mega + PAGE_SIZE, 'b', 0);
  800311:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800314:	c1 e0 03             	shl    $0x3,%eax
  800317:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  80031d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800320:	c1 e0 03             	shl    $0x3,%eax
  800323:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800329:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80032c:	83 ec 0c             	sub    $0xc,%esp
  80032f:	6a 00                	push   $0x0
  800331:	6a 62                	push   $0x62
  800333:	51                   	push   %ecx
  800334:	52                   	push   %edx
  800335:	50                   	push   %eax
  800336:	e8 05 1b 00 00       	call   801e40 <tst>
  80033b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);
  80033e:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800341:	e8 a4 17 00 00       	call   801aea <sys_calculate_free_frames>
  800346:	29 c3                	sub    %eax,%ebx
  800348:	89 d8                	mov    %ebx,%eax
  80034a:	83 ec 0c             	sub    $0xc,%esp
  80034d:	6a 00                	push   $0x0
  80034f:	6a 65                	push   $0x65
  800351:	6a 00                	push   $0x0
  800353:	68 01 03 00 00       	push   $0x301
  800358:	50                   	push   %eax
  800359:	e8 e2 1a 00 00       	call   801e40 <tst>
  80035e:	83 c4 20             	add    $0x20,%esp

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800361:	e8 84 17 00 00       	call   801aea <sys_calculate_free_frames>
  800366:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  800369:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036c:	89 c2                	mov    %eax,%edx
  80036e:	01 d2                	add    %edx,%edx
  800370:	01 d0                	add    %edx,%eax
  800372:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800375:	83 ec 0c             	sub    $0xc,%esp
  800378:	50                   	push   %eax
  800379:	e8 aa 13 00 00       	call   801728 <malloc>
  80037e:	83 c4 10             	add    $0x10,%esp
  800381:	89 45 b8             	mov    %eax,-0x48(%ebp)
		tst((uint32) ptr_allocations[7], USER_HEAP_START + 11*Mega,USER_HEAP_START + 11*Mega + PAGE_SIZE, 'b', 0);
  800384:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800387:	89 d0                	mov    %edx,%eax
  800389:	c1 e0 02             	shl    $0x2,%eax
  80038c:	01 d0                	add    %edx,%eax
  80038e:	01 c0                	add    %eax,%eax
  800390:	01 d0                	add    %edx,%eax
  800392:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800398:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80039b:	89 d0                	mov    %edx,%eax
  80039d:	c1 e0 02             	shl    $0x2,%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	01 c0                	add    %eax,%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8003ac:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8003af:	83 ec 0c             	sub    $0xc,%esp
  8003b2:	6a 00                	push   $0x0
  8003b4:	6a 62                	push   $0x62
  8003b6:	51                   	push   %ecx
  8003b7:	52                   	push   %edx
  8003b8:	50                   	push   %eax
  8003b9:	e8 82 1a 00 00       	call   801e40 <tst>
  8003be:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);
  8003c1:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8003c4:	e8 21 17 00 00       	call   801aea <sys_calculate_free_frames>
  8003c9:	29 c3                	sub    %eax,%ebx
  8003cb:	89 d8                	mov    %ebx,%eax
  8003cd:	83 ec 0c             	sub    $0xc,%esp
  8003d0:	6a 00                	push   $0x0
  8003d2:	6a 65                	push   $0x65
  8003d4:	6a 00                	push   $0x0
  8003d6:	68 01 03 00 00       	push   $0x301
  8003db:	50                   	push   %eax
  8003dc:	e8 5f 1a 00 00       	call   801e40 <tst>
  8003e1:	83 c4 20             	add    $0x20,%esp
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8003e4:	e8 01 17 00 00       	call   801aea <sys_calculate_free_frames>
  8003e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[1]);
  8003ec:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003ef:	83 ec 0c             	sub    $0xc,%esp
  8003f2:	50                   	push   %eax
  8003f3:	e8 51 14 00 00       	call   801849 <free>
  8003f8:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
  8003fb:	e8 ea 16 00 00       	call   801aea <sys_calculate_free_frames>
  800400:	89 c2                	mov    %eax,%edx
  800402:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800405:	29 c2                	sub    %eax,%edx
  800407:	89 d0                	mov    %edx,%eax
  800409:	83 ec 0c             	sub    $0xc,%esp
  80040c:	6a 00                	push   $0x0
  80040e:	6a 65                	push   $0x65
  800410:	6a 00                	push   $0x0
  800412:	68 00 01 00 00       	push   $0x100
  800417:	50                   	push   %eax
  800418:	e8 23 1a 00 00       	call   801e40 <tst>
  80041d:	83 c4 20             	add    $0x20,%esp

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800420:	e8 c5 16 00 00       	call   801aea <sys_calculate_free_frames>
  800425:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[4]);
  800428:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	50                   	push   %eax
  80042f:	e8 15 14 00 00       	call   801849 <free>
  800434:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512,0, 'e', 0);
  800437:	e8 ae 16 00 00       	call   801aea <sys_calculate_free_frames>
  80043c:	89 c2                	mov    %eax,%edx
  80043e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800441:	29 c2                	sub    %eax,%edx
  800443:	89 d0                	mov    %edx,%eax
  800445:	83 ec 0c             	sub    $0xc,%esp
  800448:	6a 00                	push   $0x0
  80044a:	6a 65                	push   $0x65
  80044c:	6a 00                	push   $0x0
  80044e:	68 00 02 00 00       	push   $0x200
  800453:	50                   	push   %eax
  800454:	e8 e7 19 00 00       	call   801e40 <tst>
  800459:	83 c4 20             	add    $0x20,%esp

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 89 16 00 00       	call   801aea <sys_calculate_free_frames>
  800461:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[6]);
  800464:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800467:	83 ec 0c             	sub    $0xc,%esp
  80046a:	50                   	push   %eax
  80046b:	e8 d9 13 00 00       	call   801849 <free>
  800470:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 768,0, 'e', 0);
  800473:	e8 72 16 00 00       	call   801aea <sys_calculate_free_frames>
  800478:	89 c2                	mov    %eax,%edx
  80047a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80047d:	29 c2                	sub    %eax,%edx
  80047f:	89 d0                	mov    %edx,%eax
  800481:	83 ec 0c             	sub    $0xc,%esp
  800484:	6a 00                	push   $0x0
  800486:	6a 65                	push   $0x65
  800488:	6a 00                	push   $0x0
  80048a:	68 00 03 00 00       	push   $0x300
  80048f:	50                   	push   %eax
  800490:	e8 ab 19 00 00       	call   801e40 <tst>
  800495:	83 c4 20             	add    $0x20,%esp
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  800498:	e8 4d 16 00 00       	call   801aea <sys_calculate_free_frames>
  80049d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8004a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004a3:	89 d0                	mov    %edx,%eax
  8004a5:	c1 e0 09             	shl    $0x9,%eax
  8004a8:	29 d0                	sub    %edx,%eax
  8004aa:	83 ec 0c             	sub    $0xc,%esp
  8004ad:	50                   	push   %eax
  8004ae:	e8 75 12 00 00       	call   801728 <malloc>
  8004b3:	83 c4 10             	add    $0x10,%esp
  8004b6:	89 45 bc             	mov    %eax,-0x44(%ebp)
		tst((uint32) ptr_allocations[8], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
  8004b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bc:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8004c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c5:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8004cb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004ce:	83 ec 0c             	sub    $0xc,%esp
  8004d1:	6a 00                	push   $0x0
  8004d3:	6a 62                	push   $0x62
  8004d5:	51                   	push   %ecx
  8004d6:	52                   	push   %edx
  8004d7:	50                   	push   %eax
  8004d8:	e8 63 19 00 00       	call   801e40 <tst>
  8004dd:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 128 ,0, 'e', 0);
  8004e0:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8004e3:	e8 02 16 00 00       	call   801aea <sys_calculate_free_frames>
  8004e8:	29 c3                	sub    %eax,%ebx
  8004ea:	89 d8                	mov    %ebx,%eax
  8004ec:	83 ec 0c             	sub    $0xc,%esp
  8004ef:	6a 00                	push   $0x0
  8004f1:	6a 65                	push   $0x65
  8004f3:	6a 00                	push   $0x0
  8004f5:	68 80 00 00 00       	push   $0x80
  8004fa:	50                   	push   %eax
  8004fb:	e8 40 19 00 00       	call   801e40 <tst>
  800500:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800503:	e8 e2 15 00 00       	call   801aea <sys_calculate_free_frames>
  800508:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  80050b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050e:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800511:	83 ec 0c             	sub    $0xc,%esp
  800514:	50                   	push   %eax
  800515:	e8 0e 12 00 00       	call   801728 <malloc>
  80051a:	83 c4 10             	add    $0x10,%esp
  80051d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		tst((uint32) ptr_allocations[9], USER_HEAP_START + 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  800520:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800523:	c1 e0 02             	shl    $0x2,%eax
  800526:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  80052c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80052f:	c1 e0 02             	shl    $0x2,%eax
  800532:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800538:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80053b:	83 ec 0c             	sub    $0xc,%esp
  80053e:	6a 00                	push   $0x0
  800540:	6a 62                	push   $0x62
  800542:	51                   	push   %ecx
  800543:	52                   	push   %edx
  800544:	50                   	push   %eax
  800545:	e8 f6 18 00 00       	call   801e40 <tst>
  80054a:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256,0, 'e', 0);
  80054d:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800550:	e8 95 15 00 00       	call   801aea <sys_calculate_free_frames>
  800555:	29 c3                	sub    %eax,%ebx
  800557:	89 d8                	mov    %ebx,%eax
  800559:	83 ec 0c             	sub    $0xc,%esp
  80055c:	6a 00                	push   $0x0
  80055e:	6a 65                	push   $0x65
  800560:	6a 00                	push   $0x0
  800562:	68 00 01 00 00       	push   $0x100
  800567:	50                   	push   %eax
  800568:	e8 d3 18 00 00       	call   801e40 <tst>
  80056d:	83 c4 20             	add    $0x20,%esp

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  800570:	e8 75 15 00 00       	call   801aea <sys_calculate_free_frames>
  800575:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  800578:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80057b:	89 d0                	mov    %edx,%eax
  80057d:	c1 e0 08             	shl    $0x8,%eax
  800580:	29 d0                	sub    %edx,%eax
  800582:	83 ec 0c             	sub    $0xc,%esp
  800585:	50                   	push   %eax
  800586:	e8 9d 11 00 00       	call   801728 <malloc>
  80058b:	83 c4 10             	add    $0x10,%esp
  80058e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		tst((uint32) ptr_allocations[10], USER_HEAP_START + 1*Mega + 512*kilo,USER_HEAP_START + 1*Mega + 512*kilo + PAGE_SIZE, 'b', 0);
  800591:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800594:	c1 e0 09             	shl    $0x9,%eax
  800597:	89 c2                	mov    %eax,%edx
  800599:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80059c:	01 d0                	add    %edx,%eax
  80059e:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8005a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a7:	c1 e0 09             	shl    $0x9,%eax
  8005aa:	89 c2                	mov    %eax,%edx
  8005ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005af:	01 d0                	add    %edx,%eax
  8005b1:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8005b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8005ba:	83 ec 0c             	sub    $0xc,%esp
  8005bd:	6a 00                	push   $0x0
  8005bf:	6a 62                	push   $0x62
  8005c1:	51                   	push   %ecx
  8005c2:	52                   	push   %edx
  8005c3:	50                   	push   %eax
  8005c4:	e8 77 18 00 00       	call   801e40 <tst>
  8005c9:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 64,0, 'e', 0);
  8005cc:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8005cf:	e8 16 15 00 00       	call   801aea <sys_calculate_free_frames>
  8005d4:	29 c3                	sub    %eax,%ebx
  8005d6:	89 d8                	mov    %ebx,%eax
  8005d8:	83 ec 0c             	sub    $0xc,%esp
  8005db:	6a 00                	push   $0x0
  8005dd:	6a 65                	push   $0x65
  8005df:	6a 00                	push   $0x0
  8005e1:	6a 40                	push   $0x40
  8005e3:	50                   	push   %eax
  8005e4:	e8 57 18 00 00       	call   801e40 <tst>
  8005e9:	83 c4 20             	add    $0x20,%esp

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  8005ec:	e8 f9 14 00 00       	call   801aea <sys_calculate_free_frames>
  8005f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[11] = malloc(4*Mega - kilo);
  8005f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f7:	c1 e0 02             	shl    $0x2,%eax
  8005fa:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8005fd:	83 ec 0c             	sub    $0xc,%esp
  800600:	50                   	push   %eax
  800601:	e8 22 11 00 00       	call   801728 <malloc>
  800606:	83 c4 10             	add    $0x10,%esp
  800609:	89 45 c8             	mov    %eax,-0x38(%ebp)
		tst((uint32) ptr_allocations[11], USER_HEAP_START + 14*Mega,USER_HEAP_START + 14*Mega + PAGE_SIZE, 'b', 0);
  80060c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80060f:	89 d0                	mov    %edx,%eax
  800611:	01 c0                	add    %eax,%eax
  800613:	01 d0                	add    %edx,%eax
  800615:	01 c0                	add    %eax,%eax
  800617:	01 d0                	add    %edx,%eax
  800619:	01 c0                	add    %eax,%eax
  80061b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800621:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800624:	89 d0                	mov    %edx,%eax
  800626:	01 c0                	add    %eax,%eax
  800628:	01 d0                	add    %edx,%eax
  80062a:	01 c0                	add    %eax,%eax
  80062c:	01 d0                	add    %edx,%eax
  80062e:	01 c0                	add    %eax,%eax
  800630:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800636:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800639:	83 ec 0c             	sub    $0xc,%esp
  80063c:	6a 00                	push   $0x0
  80063e:	6a 62                	push   $0x62
  800640:	51                   	push   %ecx
  800641:	52                   	push   %edx
  800642:	50                   	push   %eax
  800643:	e8 f8 17 00 00       	call   801e40 <tst>
  800648:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1024 + 1,0, 'e', 0);
  80064b:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80064e:	e8 97 14 00 00       	call   801aea <sys_calculate_free_frames>
  800653:	29 c3                	sub    %eax,%ebx
  800655:	89 d8                	mov    %ebx,%eax
  800657:	83 ec 0c             	sub    $0xc,%esp
  80065a:	6a 00                	push   $0x0
  80065c:	6a 65                	push   $0x65
  80065e:	6a 00                	push   $0x0
  800660:	68 01 04 00 00       	push   $0x401
  800665:	50                   	push   %eax
  800666:	e8 d5 17 00 00       	call   801e40 <tst>
  80066b:	83 c4 20             	add    $0x20,%esp
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  80066e:	e8 77 14 00 00       	call   801aea <sys_calculate_free_frames>
  800673:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[2]);
  800676:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800679:	83 ec 0c             	sub    $0xc,%esp
  80067c:	50                   	push   %eax
  80067d:	e8 c7 11 00 00       	call   801849 <free>
  800682:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
  800685:	e8 60 14 00 00       	call   801aea <sys_calculate_free_frames>
  80068a:	89 c2                	mov    %eax,%edx
  80068c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80068f:	29 c2                	sub    %eax,%edx
  800691:	89 d0                	mov    %edx,%eax
  800693:	83 ec 0c             	sub    $0xc,%esp
  800696:	6a 00                	push   $0x0
  800698:	6a 65                	push   $0x65
  80069a:	6a 00                	push   $0x0
  80069c:	68 00 01 00 00       	push   $0x100
  8006a1:	50                   	push   %eax
  8006a2:	e8 99 17 00 00       	call   801e40 <tst>
  8006a7:	83 c4 20             	add    $0x20,%esp

		//Next 1 MB Hole appended also
		freeFrames = sys_calculate_free_frames() ;
  8006aa:	e8 3b 14 00 00       	call   801aea <sys_calculate_free_frames>
  8006af:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[3]);
  8006b2:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8006b5:	83 ec 0c             	sub    $0xc,%esp
  8006b8:	50                   	push   %eax
  8006b9:	e8 8b 11 00 00       	call   801849 <free>
  8006be:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
  8006c1:	e8 24 14 00 00       	call   801aea <sys_calculate_free_frames>
  8006c6:	89 c2                	mov    %eax,%edx
  8006c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006cb:	29 c2                	sub    %eax,%edx
  8006cd:	89 d0                	mov    %edx,%eax
  8006cf:	83 ec 0c             	sub    $0xc,%esp
  8006d2:	6a 00                	push   $0x0
  8006d4:	6a 65                	push   $0x65
  8006d6:	6a 00                	push   $0x0
  8006d8:	68 00 01 00 00       	push   $0x100
  8006dd:	50                   	push   %eax
  8006de:	e8 5d 17 00 00       	call   801e40 <tst>
  8006e3:	83 c4 20             	add    $0x20,%esp
	}

	//[5] Allocate again [test first fit]
	{
		//Allocate 2 MB + 128 KB - should be placed in the contiguous hole (256 KB + 2 MB)
		freeFrames = sys_calculate_free_frames() ;
  8006e6:	e8 ff 13 00 00       	call   801aea <sys_calculate_free_frames>
  8006eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[12] = malloc(2*Mega + 128*kilo - kilo);
  8006ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f1:	c1 e0 06             	shl    $0x6,%eax
  8006f4:	89 c2                	mov    %eax,%edx
  8006f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006f9:	01 d0                	add    %edx,%eax
  8006fb:	01 c0                	add    %eax,%eax
  8006fd:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800700:	83 ec 0c             	sub    $0xc,%esp
  800703:	50                   	push   %eax
  800704:	e8 1f 10 00 00       	call   801728 <malloc>
  800709:	83 c4 10             	add    $0x10,%esp
  80070c:	89 45 cc             	mov    %eax,-0x34(%ebp)
		tst((uint32) ptr_allocations[12], USER_HEAP_START + 1*Mega+ 768*kilo,USER_HEAP_START + 1*Mega+ 768*kilo + PAGE_SIZE, 'b', 0);
  80070f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800712:	89 d0                	mov    %edx,%eax
  800714:	01 c0                	add    %eax,%eax
  800716:	01 d0                	add    %edx,%eax
  800718:	c1 e0 08             	shl    $0x8,%eax
  80071b:	89 c2                	mov    %eax,%edx
  80071d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800720:	01 d0                	add    %edx,%eax
  800722:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800728:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80072b:	89 d0                	mov    %edx,%eax
  80072d:	01 c0                	add    %eax,%eax
  80072f:	01 d0                	add    %edx,%eax
  800731:	c1 e0 08             	shl    $0x8,%eax
  800734:	89 c2                	mov    %eax,%edx
  800736:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800739:	01 d0                	add    %edx,%eax
  80073b:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800741:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800744:	83 ec 0c             	sub    $0xc,%esp
  800747:	6a 00                	push   $0x0
  800749:	6a 62                	push   $0x62
  80074b:	51                   	push   %ecx
  80074c:	52                   	push   %edx
  80074d:	50                   	push   %eax
  80074e:	e8 ed 16 00 00       	call   801e40 <tst>
  800753:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+32,0, 'e', 0);
  800756:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800759:	e8 8c 13 00 00       	call   801aea <sys_calculate_free_frames>
  80075e:	29 c3                	sub    %eax,%ebx
  800760:	89 d8                	mov    %ebx,%eax
  800762:	83 ec 0c             	sub    $0xc,%esp
  800765:	6a 00                	push   $0x0
  800767:	6a 65                	push   $0x65
  800769:	6a 00                	push   $0x0
  80076b:	68 20 02 00 00       	push   $0x220
  800770:	50                   	push   %eax
  800771:	e8 ca 16 00 00       	call   801e40 <tst>
  800776:	83 c4 20             	add    $0x20,%esp
	}

	chktst(31);
  800779:	83 ec 0c             	sub    $0xc,%esp
  80077c:	6a 1f                	push   $0x1f
  80077e:	e8 e8 16 00 00       	call   801e6b <chktst>
  800783:	83 c4 10             	add    $0x10,%esp

	return;
  800786:	90                   	nop
}
  800787:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80078a:	5b                   	pop    %ebx
  80078b:	5f                   	pop    %edi
  80078c:	5d                   	pop    %ebp
  80078d:	c3                   	ret    

0080078e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80078e:	55                   	push   %ebp
  80078f:	89 e5                	mov    %esp,%ebp
  800791:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800794:	e8 86 12 00 00       	call   801a1f <sys_getenvindex>
  800799:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80079c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80079f:	89 d0                	mov    %edx,%eax
  8007a1:	01 c0                	add    %eax,%eax
  8007a3:	01 d0                	add    %edx,%eax
  8007a5:	c1 e0 02             	shl    $0x2,%eax
  8007a8:	01 d0                	add    %edx,%eax
  8007aa:	c1 e0 06             	shl    $0x6,%eax
  8007ad:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007b2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007bc:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8007c2:	84 c0                	test   %al,%al
  8007c4:	74 0f                	je     8007d5 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8007c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8007cb:	05 f4 02 00 00       	add    $0x2f4,%eax
  8007d0:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007d9:	7e 0a                	jle    8007e5 <libmain+0x57>
		binaryname = argv[0];
  8007db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007de:	8b 00                	mov    (%eax),%eax
  8007e0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	ff 75 0c             	pushl  0xc(%ebp)
  8007eb:	ff 75 08             	pushl  0x8(%ebp)
  8007ee:	e8 45 f8 ff ff       	call   800038 <_main>
  8007f3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8007f6:	e8 bf 13 00 00       	call   801bba <sys_disable_interrupt>
	cprintf("**************************************\n");
  8007fb:	83 ec 0c             	sub    $0xc,%esp
  8007fe:	68 f8 23 80 00       	push   $0x8023f8
  800803:	e8 5c 01 00 00       	call   800964 <cprintf>
  800808:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80080b:	a1 20 30 80 00       	mov    0x803020,%eax
  800810:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800816:	a1 20 30 80 00       	mov    0x803020,%eax
  80081b:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800821:	83 ec 04             	sub    $0x4,%esp
  800824:	52                   	push   %edx
  800825:	50                   	push   %eax
  800826:	68 20 24 80 00       	push   $0x802420
  80082b:	e8 34 01 00 00       	call   800964 <cprintf>
  800830:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800833:	a1 20 30 80 00       	mov    0x803020,%eax
  800838:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80083e:	83 ec 08             	sub    $0x8,%esp
  800841:	50                   	push   %eax
  800842:	68 45 24 80 00       	push   $0x802445
  800847:	e8 18 01 00 00       	call   800964 <cprintf>
  80084c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80084f:	83 ec 0c             	sub    $0xc,%esp
  800852:	68 f8 23 80 00       	push   $0x8023f8
  800857:	e8 08 01 00 00       	call   800964 <cprintf>
  80085c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80085f:	e8 70 13 00 00       	call   801bd4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800864:	e8 19 00 00 00       	call   800882 <exit>
}
  800869:	90                   	nop
  80086a:	c9                   	leave  
  80086b:	c3                   	ret    

0080086c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80086c:	55                   	push   %ebp
  80086d:	89 e5                	mov    %esp,%ebp
  80086f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800872:	83 ec 0c             	sub    $0xc,%esp
  800875:	6a 00                	push   $0x0
  800877:	e8 6f 11 00 00       	call   8019eb <sys_env_destroy>
  80087c:	83 c4 10             	add    $0x10,%esp
}
  80087f:	90                   	nop
  800880:	c9                   	leave  
  800881:	c3                   	ret    

00800882 <exit>:

void
exit(void)
{
  800882:	55                   	push   %ebp
  800883:	89 e5                	mov    %esp,%ebp
  800885:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800888:	e8 c4 11 00 00       	call   801a51 <sys_env_exit>
}
  80088d:	90                   	nop
  80088e:	c9                   	leave  
  80088f:	c3                   	ret    

00800890 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800890:	55                   	push   %ebp
  800891:	89 e5                	mov    %esp,%ebp
  800893:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800896:	8b 45 0c             	mov    0xc(%ebp),%eax
  800899:	8b 00                	mov    (%eax),%eax
  80089b:	8d 48 01             	lea    0x1(%eax),%ecx
  80089e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a1:	89 0a                	mov    %ecx,(%edx)
  8008a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008a6:	88 d1                	mov    %dl,%cl
  8008a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ab:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008b9:	75 2c                	jne    8008e7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008bb:	a0 24 30 80 00       	mov    0x803024,%al
  8008c0:	0f b6 c0             	movzbl %al,%eax
  8008c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c6:	8b 12                	mov    (%edx),%edx
  8008c8:	89 d1                	mov    %edx,%ecx
  8008ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cd:	83 c2 08             	add    $0x8,%edx
  8008d0:	83 ec 04             	sub    $0x4,%esp
  8008d3:	50                   	push   %eax
  8008d4:	51                   	push   %ecx
  8008d5:	52                   	push   %edx
  8008d6:	e8 ce 10 00 00       	call   8019a9 <sys_cputs>
  8008db:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ea:	8b 40 04             	mov    0x4(%eax),%eax
  8008ed:	8d 50 01             	lea    0x1(%eax),%edx
  8008f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008f6:	90                   	nop
  8008f7:	c9                   	leave  
  8008f8:	c3                   	ret    

008008f9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008f9:	55                   	push   %ebp
  8008fa:	89 e5                	mov    %esp,%ebp
  8008fc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800902:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800909:	00 00 00 
	b.cnt = 0;
  80090c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800913:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800916:	ff 75 0c             	pushl  0xc(%ebp)
  800919:	ff 75 08             	pushl  0x8(%ebp)
  80091c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800922:	50                   	push   %eax
  800923:	68 90 08 80 00       	push   $0x800890
  800928:	e8 11 02 00 00       	call   800b3e <vprintfmt>
  80092d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800930:	a0 24 30 80 00       	mov    0x803024,%al
  800935:	0f b6 c0             	movzbl %al,%eax
  800938:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80093e:	83 ec 04             	sub    $0x4,%esp
  800941:	50                   	push   %eax
  800942:	52                   	push   %edx
  800943:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800949:	83 c0 08             	add    $0x8,%eax
  80094c:	50                   	push   %eax
  80094d:	e8 57 10 00 00       	call   8019a9 <sys_cputs>
  800952:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800955:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80095c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800962:	c9                   	leave  
  800963:	c3                   	ret    

00800964 <cprintf>:

int cprintf(const char *fmt, ...) {
  800964:	55                   	push   %ebp
  800965:	89 e5                	mov    %esp,%ebp
  800967:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80096a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800971:	8d 45 0c             	lea    0xc(%ebp),%eax
  800974:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	83 ec 08             	sub    $0x8,%esp
  80097d:	ff 75 f4             	pushl  -0xc(%ebp)
  800980:	50                   	push   %eax
  800981:	e8 73 ff ff ff       	call   8008f9 <vcprintf>
  800986:	83 c4 10             	add    $0x10,%esp
  800989:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80098c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80098f:	c9                   	leave  
  800990:	c3                   	ret    

00800991 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800991:	55                   	push   %ebp
  800992:	89 e5                	mov    %esp,%ebp
  800994:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800997:	e8 1e 12 00 00       	call   801bba <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80099c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80099f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	83 ec 08             	sub    $0x8,%esp
  8009a8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ab:	50                   	push   %eax
  8009ac:	e8 48 ff ff ff       	call   8008f9 <vcprintf>
  8009b1:	83 c4 10             	add    $0x10,%esp
  8009b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009b7:	e8 18 12 00 00       	call   801bd4 <sys_enable_interrupt>
	return cnt;
  8009bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009bf:	c9                   	leave  
  8009c0:	c3                   	ret    

008009c1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009c1:	55                   	push   %ebp
  8009c2:	89 e5                	mov    %esp,%ebp
  8009c4:	53                   	push   %ebx
  8009c5:	83 ec 14             	sub    $0x14,%esp
  8009c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009d4:	8b 45 18             	mov    0x18(%ebp),%eax
  8009d7:	ba 00 00 00 00       	mov    $0x0,%edx
  8009dc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009df:	77 55                	ja     800a36 <printnum+0x75>
  8009e1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009e4:	72 05                	jb     8009eb <printnum+0x2a>
  8009e6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009e9:	77 4b                	ja     800a36 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009eb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009ee:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009f1:	8b 45 18             	mov    0x18(%ebp),%eax
  8009f4:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f9:	52                   	push   %edx
  8009fa:	50                   	push   %eax
  8009fb:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fe:	ff 75 f0             	pushl  -0x10(%ebp)
  800a01:	e8 72 17 00 00       	call   802178 <__udivdi3>
  800a06:	83 c4 10             	add    $0x10,%esp
  800a09:	83 ec 04             	sub    $0x4,%esp
  800a0c:	ff 75 20             	pushl  0x20(%ebp)
  800a0f:	53                   	push   %ebx
  800a10:	ff 75 18             	pushl  0x18(%ebp)
  800a13:	52                   	push   %edx
  800a14:	50                   	push   %eax
  800a15:	ff 75 0c             	pushl  0xc(%ebp)
  800a18:	ff 75 08             	pushl  0x8(%ebp)
  800a1b:	e8 a1 ff ff ff       	call   8009c1 <printnum>
  800a20:	83 c4 20             	add    $0x20,%esp
  800a23:	eb 1a                	jmp    800a3f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a25:	83 ec 08             	sub    $0x8,%esp
  800a28:	ff 75 0c             	pushl  0xc(%ebp)
  800a2b:	ff 75 20             	pushl  0x20(%ebp)
  800a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a31:	ff d0                	call   *%eax
  800a33:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a36:	ff 4d 1c             	decl   0x1c(%ebp)
  800a39:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a3d:	7f e6                	jg     800a25 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a3f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a42:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a4d:	53                   	push   %ebx
  800a4e:	51                   	push   %ecx
  800a4f:	52                   	push   %edx
  800a50:	50                   	push   %eax
  800a51:	e8 32 18 00 00       	call   802288 <__umoddi3>
  800a56:	83 c4 10             	add    $0x10,%esp
  800a59:	05 74 26 80 00       	add    $0x802674,%eax
  800a5e:	8a 00                	mov    (%eax),%al
  800a60:	0f be c0             	movsbl %al,%eax
  800a63:	83 ec 08             	sub    $0x8,%esp
  800a66:	ff 75 0c             	pushl  0xc(%ebp)
  800a69:	50                   	push   %eax
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	ff d0                	call   *%eax
  800a6f:	83 c4 10             	add    $0x10,%esp
}
  800a72:	90                   	nop
  800a73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a76:	c9                   	leave  
  800a77:	c3                   	ret    

00800a78 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a78:	55                   	push   %ebp
  800a79:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a7b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a7f:	7e 1c                	jle    800a9d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	8b 00                	mov    (%eax),%eax
  800a86:	8d 50 08             	lea    0x8(%eax),%edx
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	89 10                	mov    %edx,(%eax)
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	8b 00                	mov    (%eax),%eax
  800a93:	83 e8 08             	sub    $0x8,%eax
  800a96:	8b 50 04             	mov    0x4(%eax),%edx
  800a99:	8b 00                	mov    (%eax),%eax
  800a9b:	eb 40                	jmp    800add <getuint+0x65>
	else if (lflag)
  800a9d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aa1:	74 1e                	je     800ac1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	8b 00                	mov    (%eax),%eax
  800aa8:	8d 50 04             	lea    0x4(%eax),%edx
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	89 10                	mov    %edx,(%eax)
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	8b 00                	mov    (%eax),%eax
  800ab5:	83 e8 04             	sub    $0x4,%eax
  800ab8:	8b 00                	mov    (%eax),%eax
  800aba:	ba 00 00 00 00       	mov    $0x0,%edx
  800abf:	eb 1c                	jmp    800add <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	8b 00                	mov    (%eax),%eax
  800ac6:	8d 50 04             	lea    0x4(%eax),%edx
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	89 10                	mov    %edx,(%eax)
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	8b 00                	mov    (%eax),%eax
  800ad3:	83 e8 04             	sub    $0x4,%eax
  800ad6:	8b 00                	mov    (%eax),%eax
  800ad8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800add:	5d                   	pop    %ebp
  800ade:	c3                   	ret    

00800adf <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800adf:	55                   	push   %ebp
  800ae0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ae2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ae6:	7e 1c                	jle    800b04 <getint+0x25>
		return va_arg(*ap, long long);
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8b 00                	mov    (%eax),%eax
  800aed:	8d 50 08             	lea    0x8(%eax),%edx
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	89 10                	mov    %edx,(%eax)
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8b 00                	mov    (%eax),%eax
  800afa:	83 e8 08             	sub    $0x8,%eax
  800afd:	8b 50 04             	mov    0x4(%eax),%edx
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	eb 38                	jmp    800b3c <getint+0x5d>
	else if (lflag)
  800b04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b08:	74 1a                	je     800b24 <getint+0x45>
		return va_arg(*ap, long);
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	8d 50 04             	lea    0x4(%eax),%edx
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	89 10                	mov    %edx,(%eax)
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	83 e8 04             	sub    $0x4,%eax
  800b1f:	8b 00                	mov    (%eax),%eax
  800b21:	99                   	cltd   
  800b22:	eb 18                	jmp    800b3c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	8d 50 04             	lea    0x4(%eax),%edx
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	89 10                	mov    %edx,(%eax)
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	83 e8 04             	sub    $0x4,%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	99                   	cltd   
}
  800b3c:	5d                   	pop    %ebp
  800b3d:	c3                   	ret    

00800b3e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b3e:	55                   	push   %ebp
  800b3f:	89 e5                	mov    %esp,%ebp
  800b41:	56                   	push   %esi
  800b42:	53                   	push   %ebx
  800b43:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b46:	eb 17                	jmp    800b5f <vprintfmt+0x21>
			if (ch == '\0')
  800b48:	85 db                	test   %ebx,%ebx
  800b4a:	0f 84 af 03 00 00    	je     800eff <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b50:	83 ec 08             	sub    $0x8,%esp
  800b53:	ff 75 0c             	pushl  0xc(%ebp)
  800b56:	53                   	push   %ebx
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	ff d0                	call   *%eax
  800b5c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b62:	8d 50 01             	lea    0x1(%eax),%edx
  800b65:	89 55 10             	mov    %edx,0x10(%ebp)
  800b68:	8a 00                	mov    (%eax),%al
  800b6a:	0f b6 d8             	movzbl %al,%ebx
  800b6d:	83 fb 25             	cmp    $0x25,%ebx
  800b70:	75 d6                	jne    800b48 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b72:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b76:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b7d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b84:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b8b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b92:	8b 45 10             	mov    0x10(%ebp),%eax
  800b95:	8d 50 01             	lea    0x1(%eax),%edx
  800b98:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9b:	8a 00                	mov    (%eax),%al
  800b9d:	0f b6 d8             	movzbl %al,%ebx
  800ba0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ba3:	83 f8 55             	cmp    $0x55,%eax
  800ba6:	0f 87 2b 03 00 00    	ja     800ed7 <vprintfmt+0x399>
  800bac:	8b 04 85 98 26 80 00 	mov    0x802698(,%eax,4),%eax
  800bb3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bb5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bb9:	eb d7                	jmp    800b92 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bbb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bbf:	eb d1                	jmp    800b92 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bc1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bc8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bcb:	89 d0                	mov    %edx,%eax
  800bcd:	c1 e0 02             	shl    $0x2,%eax
  800bd0:	01 d0                	add    %edx,%eax
  800bd2:	01 c0                	add    %eax,%eax
  800bd4:	01 d8                	add    %ebx,%eax
  800bd6:	83 e8 30             	sub    $0x30,%eax
  800bd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdf:	8a 00                	mov    (%eax),%al
  800be1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800be4:	83 fb 2f             	cmp    $0x2f,%ebx
  800be7:	7e 3e                	jle    800c27 <vprintfmt+0xe9>
  800be9:	83 fb 39             	cmp    $0x39,%ebx
  800bec:	7f 39                	jg     800c27 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bee:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bf1:	eb d5                	jmp    800bc8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bf3:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf6:	83 c0 04             	add    $0x4,%eax
  800bf9:	89 45 14             	mov    %eax,0x14(%ebp)
  800bfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800bff:	83 e8 04             	sub    $0x4,%eax
  800c02:	8b 00                	mov    (%eax),%eax
  800c04:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c07:	eb 1f                	jmp    800c28 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c09:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c0d:	79 83                	jns    800b92 <vprintfmt+0x54>
				width = 0;
  800c0f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c16:	e9 77 ff ff ff       	jmp    800b92 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c1b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c22:	e9 6b ff ff ff       	jmp    800b92 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c27:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c2c:	0f 89 60 ff ff ff    	jns    800b92 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c38:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c3f:	e9 4e ff ff ff       	jmp    800b92 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c44:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c47:	e9 46 ff ff ff       	jmp    800b92 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4f:	83 c0 04             	add    $0x4,%eax
  800c52:	89 45 14             	mov    %eax,0x14(%ebp)
  800c55:	8b 45 14             	mov    0x14(%ebp),%eax
  800c58:	83 e8 04             	sub    $0x4,%eax
  800c5b:	8b 00                	mov    (%eax),%eax
  800c5d:	83 ec 08             	sub    $0x8,%esp
  800c60:	ff 75 0c             	pushl  0xc(%ebp)
  800c63:	50                   	push   %eax
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	ff d0                	call   *%eax
  800c69:	83 c4 10             	add    $0x10,%esp
			break;
  800c6c:	e9 89 02 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c71:	8b 45 14             	mov    0x14(%ebp),%eax
  800c74:	83 c0 04             	add    $0x4,%eax
  800c77:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7d:	83 e8 04             	sub    $0x4,%eax
  800c80:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c82:	85 db                	test   %ebx,%ebx
  800c84:	79 02                	jns    800c88 <vprintfmt+0x14a>
				err = -err;
  800c86:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c88:	83 fb 64             	cmp    $0x64,%ebx
  800c8b:	7f 0b                	jg     800c98 <vprintfmt+0x15a>
  800c8d:	8b 34 9d e0 24 80 00 	mov    0x8024e0(,%ebx,4),%esi
  800c94:	85 f6                	test   %esi,%esi
  800c96:	75 19                	jne    800cb1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c98:	53                   	push   %ebx
  800c99:	68 85 26 80 00       	push   $0x802685
  800c9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ca1:	ff 75 08             	pushl  0x8(%ebp)
  800ca4:	e8 5e 02 00 00       	call   800f07 <printfmt>
  800ca9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cac:	e9 49 02 00 00       	jmp    800efa <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cb1:	56                   	push   %esi
  800cb2:	68 8e 26 80 00       	push   $0x80268e
  800cb7:	ff 75 0c             	pushl  0xc(%ebp)
  800cba:	ff 75 08             	pushl  0x8(%ebp)
  800cbd:	e8 45 02 00 00       	call   800f07 <printfmt>
  800cc2:	83 c4 10             	add    $0x10,%esp
			break;
  800cc5:	e9 30 02 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cca:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccd:	83 c0 04             	add    $0x4,%eax
  800cd0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd6:	83 e8 04             	sub    $0x4,%eax
  800cd9:	8b 30                	mov    (%eax),%esi
  800cdb:	85 f6                	test   %esi,%esi
  800cdd:	75 05                	jne    800ce4 <vprintfmt+0x1a6>
				p = "(null)";
  800cdf:	be 91 26 80 00       	mov    $0x802691,%esi
			if (width > 0 && padc != '-')
  800ce4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ce8:	7e 6d                	jle    800d57 <vprintfmt+0x219>
  800cea:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cee:	74 67                	je     800d57 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cf3:	83 ec 08             	sub    $0x8,%esp
  800cf6:	50                   	push   %eax
  800cf7:	56                   	push   %esi
  800cf8:	e8 0c 03 00 00       	call   801009 <strnlen>
  800cfd:	83 c4 10             	add    $0x10,%esp
  800d00:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d03:	eb 16                	jmp    800d1b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d05:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d09:	83 ec 08             	sub    $0x8,%esp
  800d0c:	ff 75 0c             	pushl  0xc(%ebp)
  800d0f:	50                   	push   %eax
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	ff d0                	call   *%eax
  800d15:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d18:	ff 4d e4             	decl   -0x1c(%ebp)
  800d1b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d1f:	7f e4                	jg     800d05 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d21:	eb 34                	jmp    800d57 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d23:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d27:	74 1c                	je     800d45 <vprintfmt+0x207>
  800d29:	83 fb 1f             	cmp    $0x1f,%ebx
  800d2c:	7e 05                	jle    800d33 <vprintfmt+0x1f5>
  800d2e:	83 fb 7e             	cmp    $0x7e,%ebx
  800d31:	7e 12                	jle    800d45 <vprintfmt+0x207>
					putch('?', putdat);
  800d33:	83 ec 08             	sub    $0x8,%esp
  800d36:	ff 75 0c             	pushl  0xc(%ebp)
  800d39:	6a 3f                	push   $0x3f
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	ff d0                	call   *%eax
  800d40:	83 c4 10             	add    $0x10,%esp
  800d43:	eb 0f                	jmp    800d54 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d45:	83 ec 08             	sub    $0x8,%esp
  800d48:	ff 75 0c             	pushl  0xc(%ebp)
  800d4b:	53                   	push   %ebx
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	ff d0                	call   *%eax
  800d51:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d54:	ff 4d e4             	decl   -0x1c(%ebp)
  800d57:	89 f0                	mov    %esi,%eax
  800d59:	8d 70 01             	lea    0x1(%eax),%esi
  800d5c:	8a 00                	mov    (%eax),%al
  800d5e:	0f be d8             	movsbl %al,%ebx
  800d61:	85 db                	test   %ebx,%ebx
  800d63:	74 24                	je     800d89 <vprintfmt+0x24b>
  800d65:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d69:	78 b8                	js     800d23 <vprintfmt+0x1e5>
  800d6b:	ff 4d e0             	decl   -0x20(%ebp)
  800d6e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d72:	79 af                	jns    800d23 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d74:	eb 13                	jmp    800d89 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d76:	83 ec 08             	sub    $0x8,%esp
  800d79:	ff 75 0c             	pushl  0xc(%ebp)
  800d7c:	6a 20                	push   $0x20
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	ff d0                	call   *%eax
  800d83:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d86:	ff 4d e4             	decl   -0x1c(%ebp)
  800d89:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8d:	7f e7                	jg     800d76 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d8f:	e9 66 01 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d94:	83 ec 08             	sub    $0x8,%esp
  800d97:	ff 75 e8             	pushl  -0x18(%ebp)
  800d9a:	8d 45 14             	lea    0x14(%ebp),%eax
  800d9d:	50                   	push   %eax
  800d9e:	e8 3c fd ff ff       	call   800adf <getint>
  800da3:	83 c4 10             	add    $0x10,%esp
  800da6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800da9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800daf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db2:	85 d2                	test   %edx,%edx
  800db4:	79 23                	jns    800dd9 <vprintfmt+0x29b>
				putch('-', putdat);
  800db6:	83 ec 08             	sub    $0x8,%esp
  800db9:	ff 75 0c             	pushl  0xc(%ebp)
  800dbc:	6a 2d                	push   $0x2d
  800dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc1:	ff d0                	call   *%eax
  800dc3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dcc:	f7 d8                	neg    %eax
  800dce:	83 d2 00             	adc    $0x0,%edx
  800dd1:	f7 da                	neg    %edx
  800dd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800dd9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800de0:	e9 bc 00 00 00       	jmp    800ea1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 e8             	pushl  -0x18(%ebp)
  800deb:	8d 45 14             	lea    0x14(%ebp),%eax
  800dee:	50                   	push   %eax
  800def:	e8 84 fc ff ff       	call   800a78 <getuint>
  800df4:	83 c4 10             	add    $0x10,%esp
  800df7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800dfd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e04:	e9 98 00 00 00       	jmp    800ea1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e09:	83 ec 08             	sub    $0x8,%esp
  800e0c:	ff 75 0c             	pushl  0xc(%ebp)
  800e0f:	6a 58                	push   $0x58
  800e11:	8b 45 08             	mov    0x8(%ebp),%eax
  800e14:	ff d0                	call   *%eax
  800e16:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e19:	83 ec 08             	sub    $0x8,%esp
  800e1c:	ff 75 0c             	pushl  0xc(%ebp)
  800e1f:	6a 58                	push   $0x58
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	ff d0                	call   *%eax
  800e26:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e29:	83 ec 08             	sub    $0x8,%esp
  800e2c:	ff 75 0c             	pushl  0xc(%ebp)
  800e2f:	6a 58                	push   $0x58
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	ff d0                	call   *%eax
  800e36:	83 c4 10             	add    $0x10,%esp
			break;
  800e39:	e9 bc 00 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e3e:	83 ec 08             	sub    $0x8,%esp
  800e41:	ff 75 0c             	pushl  0xc(%ebp)
  800e44:	6a 30                	push   $0x30
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	ff d0                	call   *%eax
  800e4b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e4e:	83 ec 08             	sub    $0x8,%esp
  800e51:	ff 75 0c             	pushl  0xc(%ebp)
  800e54:	6a 78                	push   $0x78
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	ff d0                	call   *%eax
  800e5b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e61:	83 c0 04             	add    $0x4,%eax
  800e64:	89 45 14             	mov    %eax,0x14(%ebp)
  800e67:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6a:	83 e8 04             	sub    $0x4,%eax
  800e6d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e72:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e79:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e80:	eb 1f                	jmp    800ea1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e82:	83 ec 08             	sub    $0x8,%esp
  800e85:	ff 75 e8             	pushl  -0x18(%ebp)
  800e88:	8d 45 14             	lea    0x14(%ebp),%eax
  800e8b:	50                   	push   %eax
  800e8c:	e8 e7 fb ff ff       	call   800a78 <getuint>
  800e91:	83 c4 10             	add    $0x10,%esp
  800e94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e9a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ea1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ea5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ea8:	83 ec 04             	sub    $0x4,%esp
  800eab:	52                   	push   %edx
  800eac:	ff 75 e4             	pushl  -0x1c(%ebp)
  800eaf:	50                   	push   %eax
  800eb0:	ff 75 f4             	pushl  -0xc(%ebp)
  800eb3:	ff 75 f0             	pushl  -0x10(%ebp)
  800eb6:	ff 75 0c             	pushl  0xc(%ebp)
  800eb9:	ff 75 08             	pushl  0x8(%ebp)
  800ebc:	e8 00 fb ff ff       	call   8009c1 <printnum>
  800ec1:	83 c4 20             	add    $0x20,%esp
			break;
  800ec4:	eb 34                	jmp    800efa <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ec6:	83 ec 08             	sub    $0x8,%esp
  800ec9:	ff 75 0c             	pushl  0xc(%ebp)
  800ecc:	53                   	push   %ebx
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	ff d0                	call   *%eax
  800ed2:	83 c4 10             	add    $0x10,%esp
			break;
  800ed5:	eb 23                	jmp    800efa <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ed7:	83 ec 08             	sub    $0x8,%esp
  800eda:	ff 75 0c             	pushl  0xc(%ebp)
  800edd:	6a 25                	push   $0x25
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	ff d0                	call   *%eax
  800ee4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ee7:	ff 4d 10             	decl   0x10(%ebp)
  800eea:	eb 03                	jmp    800eef <vprintfmt+0x3b1>
  800eec:	ff 4d 10             	decl   0x10(%ebp)
  800eef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef2:	48                   	dec    %eax
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	3c 25                	cmp    $0x25,%al
  800ef7:	75 f3                	jne    800eec <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ef9:	90                   	nop
		}
	}
  800efa:	e9 47 fc ff ff       	jmp    800b46 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800eff:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f00:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f03:	5b                   	pop    %ebx
  800f04:	5e                   	pop    %esi
  800f05:	5d                   	pop    %ebp
  800f06:	c3                   	ret    

00800f07 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f07:	55                   	push   %ebp
  800f08:	89 e5                	mov    %esp,%ebp
  800f0a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f0d:	8d 45 10             	lea    0x10(%ebp),%eax
  800f10:	83 c0 04             	add    $0x4,%eax
  800f13:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f16:	8b 45 10             	mov    0x10(%ebp),%eax
  800f19:	ff 75 f4             	pushl  -0xc(%ebp)
  800f1c:	50                   	push   %eax
  800f1d:	ff 75 0c             	pushl  0xc(%ebp)
  800f20:	ff 75 08             	pushl  0x8(%ebp)
  800f23:	e8 16 fc ff ff       	call   800b3e <vprintfmt>
  800f28:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f2b:	90                   	nop
  800f2c:	c9                   	leave  
  800f2d:	c3                   	ret    

00800f2e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f34:	8b 40 08             	mov    0x8(%eax),%eax
  800f37:	8d 50 01             	lea    0x1(%eax),%edx
  800f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f43:	8b 10                	mov    (%eax),%edx
  800f45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f48:	8b 40 04             	mov    0x4(%eax),%eax
  800f4b:	39 c2                	cmp    %eax,%edx
  800f4d:	73 12                	jae    800f61 <sprintputch+0x33>
		*b->buf++ = ch;
  800f4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f52:	8b 00                	mov    (%eax),%eax
  800f54:	8d 48 01             	lea    0x1(%eax),%ecx
  800f57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f5a:	89 0a                	mov    %ecx,(%edx)
  800f5c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f5f:	88 10                	mov    %dl,(%eax)
}
  800f61:	90                   	nop
  800f62:	5d                   	pop    %ebp
  800f63:	c3                   	ret    

00800f64 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f64:	55                   	push   %ebp
  800f65:	89 e5                	mov    %esp,%ebp
  800f67:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	01 d0                	add    %edx,%eax
  800f7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f85:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f89:	74 06                	je     800f91 <vsnprintf+0x2d>
  800f8b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f8f:	7f 07                	jg     800f98 <vsnprintf+0x34>
		return -E_INVAL;
  800f91:	b8 03 00 00 00       	mov    $0x3,%eax
  800f96:	eb 20                	jmp    800fb8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f98:	ff 75 14             	pushl  0x14(%ebp)
  800f9b:	ff 75 10             	pushl  0x10(%ebp)
  800f9e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fa1:	50                   	push   %eax
  800fa2:	68 2e 0f 80 00       	push   $0x800f2e
  800fa7:	e8 92 fb ff ff       	call   800b3e <vprintfmt>
  800fac:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800faf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fb2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fb8:	c9                   	leave  
  800fb9:	c3                   	ret    

00800fba <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fba:	55                   	push   %ebp
  800fbb:	89 e5                	mov    %esp,%ebp
  800fbd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fc0:	8d 45 10             	lea    0x10(%ebp),%eax
  800fc3:	83 c0 04             	add    $0x4,%eax
  800fc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcc:	ff 75 f4             	pushl  -0xc(%ebp)
  800fcf:	50                   	push   %eax
  800fd0:	ff 75 0c             	pushl  0xc(%ebp)
  800fd3:	ff 75 08             	pushl  0x8(%ebp)
  800fd6:	e8 89 ff ff ff       	call   800f64 <vsnprintf>
  800fdb:	83 c4 10             	add    $0x10,%esp
  800fde:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fe1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fe4:	c9                   	leave  
  800fe5:	c3                   	ret    

00800fe6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fe6:	55                   	push   %ebp
  800fe7:	89 e5                	mov    %esp,%ebp
  800fe9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ff3:	eb 06                	jmp    800ffb <strlen+0x15>
		n++;
  800ff5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ff8:	ff 45 08             	incl   0x8(%ebp)
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	84 c0                	test   %al,%al
  801002:	75 f1                	jne    800ff5 <strlen+0xf>
		n++;
	return n;
  801004:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801007:	c9                   	leave  
  801008:	c3                   	ret    

00801009 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801009:	55                   	push   %ebp
  80100a:	89 e5                	mov    %esp,%ebp
  80100c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80100f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801016:	eb 09                	jmp    801021 <strnlen+0x18>
		n++;
  801018:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80101b:	ff 45 08             	incl   0x8(%ebp)
  80101e:	ff 4d 0c             	decl   0xc(%ebp)
  801021:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801025:	74 09                	je     801030 <strnlen+0x27>
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	84 c0                	test   %al,%al
  80102e:	75 e8                	jne    801018 <strnlen+0xf>
		n++;
	return n;
  801030:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801041:	90                   	nop
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	8d 50 01             	lea    0x1(%eax),%edx
  801048:	89 55 08             	mov    %edx,0x8(%ebp)
  80104b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80104e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801051:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801054:	8a 12                	mov    (%edx),%dl
  801056:	88 10                	mov    %dl,(%eax)
  801058:	8a 00                	mov    (%eax),%al
  80105a:	84 c0                	test   %al,%al
  80105c:	75 e4                	jne    801042 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80105e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801061:	c9                   	leave  
  801062:	c3                   	ret    

00801063 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801063:	55                   	push   %ebp
  801064:	89 e5                	mov    %esp,%ebp
  801066:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80106f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801076:	eb 1f                	jmp    801097 <strncpy+0x34>
		*dst++ = *src;
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	8d 50 01             	lea    0x1(%eax),%edx
  80107e:	89 55 08             	mov    %edx,0x8(%ebp)
  801081:	8b 55 0c             	mov    0xc(%ebp),%edx
  801084:	8a 12                	mov    (%edx),%dl
  801086:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801088:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	84 c0                	test   %al,%al
  80108f:	74 03                	je     801094 <strncpy+0x31>
			src++;
  801091:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801094:	ff 45 fc             	incl   -0x4(%ebp)
  801097:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80109a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80109d:	72 d9                	jb     801078 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80109f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b4:	74 30                	je     8010e6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010b6:	eb 16                	jmp    8010ce <strlcpy+0x2a>
			*dst++ = *src++;
  8010b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bb:	8d 50 01             	lea    0x1(%eax),%edx
  8010be:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010ca:	8a 12                	mov    (%edx),%dl
  8010cc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010ce:	ff 4d 10             	decl   0x10(%ebp)
  8010d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d5:	74 09                	je     8010e0 <strlcpy+0x3c>
  8010d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010da:	8a 00                	mov    (%eax),%al
  8010dc:	84 c0                	test   %al,%al
  8010de:	75 d8                	jne    8010b8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8010e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ec:	29 c2                	sub    %eax,%edx
  8010ee:	89 d0                	mov    %edx,%eax
}
  8010f0:	c9                   	leave  
  8010f1:	c3                   	ret    

008010f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010f5:	eb 06                	jmp    8010fd <strcmp+0xb>
		p++, q++;
  8010f7:	ff 45 08             	incl   0x8(%ebp)
  8010fa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	84 c0                	test   %al,%al
  801104:	74 0e                	je     801114 <strcmp+0x22>
  801106:	8b 45 08             	mov    0x8(%ebp),%eax
  801109:	8a 10                	mov    (%eax),%dl
  80110b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110e:	8a 00                	mov    (%eax),%al
  801110:	38 c2                	cmp    %al,%dl
  801112:	74 e3                	je     8010f7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	0f b6 d0             	movzbl %al,%edx
  80111c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	0f b6 c0             	movzbl %al,%eax
  801124:	29 c2                	sub    %eax,%edx
  801126:	89 d0                	mov    %edx,%eax
}
  801128:	5d                   	pop    %ebp
  801129:	c3                   	ret    

0080112a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80112d:	eb 09                	jmp    801138 <strncmp+0xe>
		n--, p++, q++;
  80112f:	ff 4d 10             	decl   0x10(%ebp)
  801132:	ff 45 08             	incl   0x8(%ebp)
  801135:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801138:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113c:	74 17                	je     801155 <strncmp+0x2b>
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8a 00                	mov    (%eax),%al
  801143:	84 c0                	test   %al,%al
  801145:	74 0e                	je     801155 <strncmp+0x2b>
  801147:	8b 45 08             	mov    0x8(%ebp),%eax
  80114a:	8a 10                	mov    (%eax),%dl
  80114c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114f:	8a 00                	mov    (%eax),%al
  801151:	38 c2                	cmp    %al,%dl
  801153:	74 da                	je     80112f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801155:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801159:	75 07                	jne    801162 <strncmp+0x38>
		return 0;
  80115b:	b8 00 00 00 00       	mov    $0x0,%eax
  801160:	eb 14                	jmp    801176 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	0f b6 d0             	movzbl %al,%edx
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	0f b6 c0             	movzbl %al,%eax
  801172:	29 c2                	sub    %eax,%edx
  801174:	89 d0                	mov    %edx,%eax
}
  801176:	5d                   	pop    %ebp
  801177:	c3                   	ret    

00801178 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
  80117b:	83 ec 04             	sub    $0x4,%esp
  80117e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801181:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801184:	eb 12                	jmp    801198 <strchr+0x20>
		if (*s == c)
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
  801189:	8a 00                	mov    (%eax),%al
  80118b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80118e:	75 05                	jne    801195 <strchr+0x1d>
			return (char *) s;
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	eb 11                	jmp    8011a6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801195:	ff 45 08             	incl   0x8(%ebp)
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	84 c0                	test   %al,%al
  80119f:	75 e5                	jne    801186 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
  8011ab:	83 ec 04             	sub    $0x4,%esp
  8011ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011b4:	eb 0d                	jmp    8011c3 <strfind+0x1b>
		if (*s == c)
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	8a 00                	mov    (%eax),%al
  8011bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011be:	74 0e                	je     8011ce <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011c0:	ff 45 08             	incl   0x8(%ebp)
  8011c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	84 c0                	test   %al,%al
  8011ca:	75 ea                	jne    8011b6 <strfind+0xe>
  8011cc:	eb 01                	jmp    8011cf <strfind+0x27>
		if (*s == c)
			break;
  8011ce:	90                   	nop
	return (char *) s;
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011d2:	c9                   	leave  
  8011d3:	c3                   	ret    

008011d4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011d4:	55                   	push   %ebp
  8011d5:	89 e5                	mov    %esp,%ebp
  8011d7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011e6:	eb 0e                	jmp    8011f6 <memset+0x22>
		*p++ = c;
  8011e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011eb:	8d 50 01             	lea    0x1(%eax),%edx
  8011ee:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011f6:	ff 4d f8             	decl   -0x8(%ebp)
  8011f9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011fd:	79 e9                	jns    8011e8 <memset+0x14>
		*p++ = c;

	return v;
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
  801207:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80120a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801216:	eb 16                	jmp    80122e <memcpy+0x2a>
		*d++ = *s++;
  801218:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121b:	8d 50 01             	lea    0x1(%eax),%edx
  80121e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801221:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801224:	8d 4a 01             	lea    0x1(%edx),%ecx
  801227:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80122a:	8a 12                	mov    (%edx),%dl
  80122c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80122e:	8b 45 10             	mov    0x10(%ebp),%eax
  801231:	8d 50 ff             	lea    -0x1(%eax),%edx
  801234:	89 55 10             	mov    %edx,0x10(%ebp)
  801237:	85 c0                	test   %eax,%eax
  801239:	75 dd                	jne    801218 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80123e:	c9                   	leave  
  80123f:	c3                   	ret    

00801240 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801240:	55                   	push   %ebp
  801241:	89 e5                	mov    %esp,%ebp
  801243:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801246:	8b 45 0c             	mov    0xc(%ebp),%eax
  801249:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80124c:	8b 45 08             	mov    0x8(%ebp),%eax
  80124f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801252:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801255:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801258:	73 50                	jae    8012aa <memmove+0x6a>
  80125a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125d:	8b 45 10             	mov    0x10(%ebp),%eax
  801260:	01 d0                	add    %edx,%eax
  801262:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801265:	76 43                	jbe    8012aa <memmove+0x6a>
		s += n;
  801267:	8b 45 10             	mov    0x10(%ebp),%eax
  80126a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80126d:	8b 45 10             	mov    0x10(%ebp),%eax
  801270:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801273:	eb 10                	jmp    801285 <memmove+0x45>
			*--d = *--s;
  801275:	ff 4d f8             	decl   -0x8(%ebp)
  801278:	ff 4d fc             	decl   -0x4(%ebp)
  80127b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127e:	8a 10                	mov    (%eax),%dl
  801280:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801283:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801285:	8b 45 10             	mov    0x10(%ebp),%eax
  801288:	8d 50 ff             	lea    -0x1(%eax),%edx
  80128b:	89 55 10             	mov    %edx,0x10(%ebp)
  80128e:	85 c0                	test   %eax,%eax
  801290:	75 e3                	jne    801275 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801292:	eb 23                	jmp    8012b7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801294:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80129d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012a6:	8a 12                	mov    (%edx),%dl
  8012a8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012b3:	85 c0                	test   %eax,%eax
  8012b5:	75 dd                	jne    801294 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
  8012bf:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012ce:	eb 2a                	jmp    8012fa <memcmp+0x3e>
		if (*s1 != *s2)
  8012d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d3:	8a 10                	mov    (%eax),%dl
  8012d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d8:	8a 00                	mov    (%eax),%al
  8012da:	38 c2                	cmp    %al,%dl
  8012dc:	74 16                	je     8012f4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e1:	8a 00                	mov    (%eax),%al
  8012e3:	0f b6 d0             	movzbl %al,%edx
  8012e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e9:	8a 00                	mov    (%eax),%al
  8012eb:	0f b6 c0             	movzbl %al,%eax
  8012ee:	29 c2                	sub    %eax,%edx
  8012f0:	89 d0                	mov    %edx,%eax
  8012f2:	eb 18                	jmp    80130c <memcmp+0x50>
		s1++, s2++;
  8012f4:	ff 45 fc             	incl   -0x4(%ebp)
  8012f7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801300:	89 55 10             	mov    %edx,0x10(%ebp)
  801303:	85 c0                	test   %eax,%eax
  801305:	75 c9                	jne    8012d0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801307:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80130c:	c9                   	leave  
  80130d:	c3                   	ret    

0080130e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
  801311:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801314:	8b 55 08             	mov    0x8(%ebp),%edx
  801317:	8b 45 10             	mov    0x10(%ebp),%eax
  80131a:	01 d0                	add    %edx,%eax
  80131c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80131f:	eb 15                	jmp    801336 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	0f b6 d0             	movzbl %al,%edx
  801329:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132c:	0f b6 c0             	movzbl %al,%eax
  80132f:	39 c2                	cmp    %eax,%edx
  801331:	74 0d                	je     801340 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801333:	ff 45 08             	incl   0x8(%ebp)
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80133c:	72 e3                	jb     801321 <memfind+0x13>
  80133e:	eb 01                	jmp    801341 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801340:	90                   	nop
	return (void *) s;
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801344:	c9                   	leave  
  801345:	c3                   	ret    

00801346 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801346:	55                   	push   %ebp
  801347:	89 e5                	mov    %esp,%ebp
  801349:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80134c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801353:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80135a:	eb 03                	jmp    80135f <strtol+0x19>
		s++;
  80135c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	8a 00                	mov    (%eax),%al
  801364:	3c 20                	cmp    $0x20,%al
  801366:	74 f4                	je     80135c <strtol+0x16>
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	8a 00                	mov    (%eax),%al
  80136d:	3c 09                	cmp    $0x9,%al
  80136f:	74 eb                	je     80135c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	8a 00                	mov    (%eax),%al
  801376:	3c 2b                	cmp    $0x2b,%al
  801378:	75 05                	jne    80137f <strtol+0x39>
		s++;
  80137a:	ff 45 08             	incl   0x8(%ebp)
  80137d:	eb 13                	jmp    801392 <strtol+0x4c>
	else if (*s == '-')
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	3c 2d                	cmp    $0x2d,%al
  801386:	75 0a                	jne    801392 <strtol+0x4c>
		s++, neg = 1;
  801388:	ff 45 08             	incl   0x8(%ebp)
  80138b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801392:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801396:	74 06                	je     80139e <strtol+0x58>
  801398:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80139c:	75 20                	jne    8013be <strtol+0x78>
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	3c 30                	cmp    $0x30,%al
  8013a5:	75 17                	jne    8013be <strtol+0x78>
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	40                   	inc    %eax
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	3c 78                	cmp    $0x78,%al
  8013af:	75 0d                	jne    8013be <strtol+0x78>
		s += 2, base = 16;
  8013b1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013b5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013bc:	eb 28                	jmp    8013e6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c2:	75 15                	jne    8013d9 <strtol+0x93>
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	8a 00                	mov    (%eax),%al
  8013c9:	3c 30                	cmp    $0x30,%al
  8013cb:	75 0c                	jne    8013d9 <strtol+0x93>
		s++, base = 8;
  8013cd:	ff 45 08             	incl   0x8(%ebp)
  8013d0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013d7:	eb 0d                	jmp    8013e6 <strtol+0xa0>
	else if (base == 0)
  8013d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013dd:	75 07                	jne    8013e6 <strtol+0xa0>
		base = 10;
  8013df:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	8a 00                	mov    (%eax),%al
  8013eb:	3c 2f                	cmp    $0x2f,%al
  8013ed:	7e 19                	jle    801408 <strtol+0xc2>
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	3c 39                	cmp    $0x39,%al
  8013f6:	7f 10                	jg     801408 <strtol+0xc2>
			dig = *s - '0';
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	8a 00                	mov    (%eax),%al
  8013fd:	0f be c0             	movsbl %al,%eax
  801400:	83 e8 30             	sub    $0x30,%eax
  801403:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801406:	eb 42                	jmp    80144a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8a 00                	mov    (%eax),%al
  80140d:	3c 60                	cmp    $0x60,%al
  80140f:	7e 19                	jle    80142a <strtol+0xe4>
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	3c 7a                	cmp    $0x7a,%al
  801418:	7f 10                	jg     80142a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	0f be c0             	movsbl %al,%eax
  801422:	83 e8 57             	sub    $0x57,%eax
  801425:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801428:	eb 20                	jmp    80144a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	3c 40                	cmp    $0x40,%al
  801431:	7e 39                	jle    80146c <strtol+0x126>
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	3c 5a                	cmp    $0x5a,%al
  80143a:	7f 30                	jg     80146c <strtol+0x126>
			dig = *s - 'A' + 10;
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	0f be c0             	movsbl %al,%eax
  801444:	83 e8 37             	sub    $0x37,%eax
  801447:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80144a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80144d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801450:	7d 19                	jge    80146b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801452:	ff 45 08             	incl   0x8(%ebp)
  801455:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801458:	0f af 45 10          	imul   0x10(%ebp),%eax
  80145c:	89 c2                	mov    %eax,%edx
  80145e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801461:	01 d0                	add    %edx,%eax
  801463:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801466:	e9 7b ff ff ff       	jmp    8013e6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80146b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80146c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801470:	74 08                	je     80147a <strtol+0x134>
		*endptr = (char *) s;
  801472:	8b 45 0c             	mov    0xc(%ebp),%eax
  801475:	8b 55 08             	mov    0x8(%ebp),%edx
  801478:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80147a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80147e:	74 07                	je     801487 <strtol+0x141>
  801480:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801483:	f7 d8                	neg    %eax
  801485:	eb 03                	jmp    80148a <strtol+0x144>
  801487:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <ltostr>:

void
ltostr(long value, char *str)
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
  80148f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801492:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801499:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014a4:	79 13                	jns    8014b9 <ltostr+0x2d>
	{
		neg = 1;
  8014a6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014b3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014b6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014c1:	99                   	cltd   
  8014c2:	f7 f9                	idiv   %ecx
  8014c4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ca:	8d 50 01             	lea    0x1(%eax),%edx
  8014cd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d0:	89 c2                	mov    %eax,%edx
  8014d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d5:	01 d0                	add    %edx,%eax
  8014d7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014da:	83 c2 30             	add    $0x30,%edx
  8014dd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014e7:	f7 e9                	imul   %ecx
  8014e9:	c1 fa 02             	sar    $0x2,%edx
  8014ec:	89 c8                	mov    %ecx,%eax
  8014ee:	c1 f8 1f             	sar    $0x1f,%eax
  8014f1:	29 c2                	sub    %eax,%edx
  8014f3:	89 d0                	mov    %edx,%eax
  8014f5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014fb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801500:	f7 e9                	imul   %ecx
  801502:	c1 fa 02             	sar    $0x2,%edx
  801505:	89 c8                	mov    %ecx,%eax
  801507:	c1 f8 1f             	sar    $0x1f,%eax
  80150a:	29 c2                	sub    %eax,%edx
  80150c:	89 d0                	mov    %edx,%eax
  80150e:	c1 e0 02             	shl    $0x2,%eax
  801511:	01 d0                	add    %edx,%eax
  801513:	01 c0                	add    %eax,%eax
  801515:	29 c1                	sub    %eax,%ecx
  801517:	89 ca                	mov    %ecx,%edx
  801519:	85 d2                	test   %edx,%edx
  80151b:	75 9c                	jne    8014b9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80151d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801524:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801527:	48                   	dec    %eax
  801528:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80152b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80152f:	74 3d                	je     80156e <ltostr+0xe2>
		start = 1 ;
  801531:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801538:	eb 34                	jmp    80156e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80153a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80153d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801540:	01 d0                	add    %edx,%eax
  801542:	8a 00                	mov    (%eax),%al
  801544:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801547:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80154a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154d:	01 c2                	add    %eax,%edx
  80154f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801552:	8b 45 0c             	mov    0xc(%ebp),%eax
  801555:	01 c8                	add    %ecx,%eax
  801557:	8a 00                	mov    (%eax),%al
  801559:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80155b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80155e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801561:	01 c2                	add    %eax,%edx
  801563:	8a 45 eb             	mov    -0x15(%ebp),%al
  801566:	88 02                	mov    %al,(%edx)
		start++ ;
  801568:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80156b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80156e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801571:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801574:	7c c4                	jl     80153a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801576:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801579:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157c:	01 d0                	add    %edx,%eax
  80157e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801581:	90                   	nop
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
  801587:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80158a:	ff 75 08             	pushl  0x8(%ebp)
  80158d:	e8 54 fa ff ff       	call   800fe6 <strlen>
  801592:	83 c4 04             	add    $0x4,%esp
  801595:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801598:	ff 75 0c             	pushl  0xc(%ebp)
  80159b:	e8 46 fa ff ff       	call   800fe6 <strlen>
  8015a0:	83 c4 04             	add    $0x4,%esp
  8015a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015b4:	eb 17                	jmp    8015cd <strcconcat+0x49>
		final[s] = str1[s] ;
  8015b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bc:	01 c2                	add    %eax,%edx
  8015be:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c4:	01 c8                	add    %ecx,%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015ca:	ff 45 fc             	incl   -0x4(%ebp)
  8015cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015d3:	7c e1                	jl     8015b6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015e3:	eb 1f                	jmp    801604 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e8:	8d 50 01             	lea    0x1(%eax),%edx
  8015eb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015ee:	89 c2                	mov    %eax,%edx
  8015f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f3:	01 c2                	add    %eax,%edx
  8015f5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fb:	01 c8                	add    %ecx,%eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801601:	ff 45 f8             	incl   -0x8(%ebp)
  801604:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801607:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80160a:	7c d9                	jl     8015e5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80160c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80160f:	8b 45 10             	mov    0x10(%ebp),%eax
  801612:	01 d0                	add    %edx,%eax
  801614:	c6 00 00             	movb   $0x0,(%eax)
}
  801617:	90                   	nop
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80161d:	8b 45 14             	mov    0x14(%ebp),%eax
  801620:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801626:	8b 45 14             	mov    0x14(%ebp),%eax
  801629:	8b 00                	mov    (%eax),%eax
  80162b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801632:	8b 45 10             	mov    0x10(%ebp),%eax
  801635:	01 d0                	add    %edx,%eax
  801637:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80163d:	eb 0c                	jmp    80164b <strsplit+0x31>
			*string++ = 0;
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	8d 50 01             	lea    0x1(%eax),%edx
  801645:	89 55 08             	mov    %edx,0x8(%ebp)
  801648:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	84 c0                	test   %al,%al
  801652:	74 18                	je     80166c <strsplit+0x52>
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	8a 00                	mov    (%eax),%al
  801659:	0f be c0             	movsbl %al,%eax
  80165c:	50                   	push   %eax
  80165d:	ff 75 0c             	pushl  0xc(%ebp)
  801660:	e8 13 fb ff ff       	call   801178 <strchr>
  801665:	83 c4 08             	add    $0x8,%esp
  801668:	85 c0                	test   %eax,%eax
  80166a:	75 d3                	jne    80163f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8a 00                	mov    (%eax),%al
  801671:	84 c0                	test   %al,%al
  801673:	74 5a                	je     8016cf <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801675:	8b 45 14             	mov    0x14(%ebp),%eax
  801678:	8b 00                	mov    (%eax),%eax
  80167a:	83 f8 0f             	cmp    $0xf,%eax
  80167d:	75 07                	jne    801686 <strsplit+0x6c>
		{
			return 0;
  80167f:	b8 00 00 00 00       	mov    $0x0,%eax
  801684:	eb 66                	jmp    8016ec <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801686:	8b 45 14             	mov    0x14(%ebp),%eax
  801689:	8b 00                	mov    (%eax),%eax
  80168b:	8d 48 01             	lea    0x1(%eax),%ecx
  80168e:	8b 55 14             	mov    0x14(%ebp),%edx
  801691:	89 0a                	mov    %ecx,(%edx)
  801693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80169a:	8b 45 10             	mov    0x10(%ebp),%eax
  80169d:	01 c2                	add    %eax,%edx
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016a4:	eb 03                	jmp    8016a9 <strsplit+0x8f>
			string++;
  8016a6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8a 00                	mov    (%eax),%al
  8016ae:	84 c0                	test   %al,%al
  8016b0:	74 8b                	je     80163d <strsplit+0x23>
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	0f be c0             	movsbl %al,%eax
  8016ba:	50                   	push   %eax
  8016bb:	ff 75 0c             	pushl  0xc(%ebp)
  8016be:	e8 b5 fa ff ff       	call   801178 <strchr>
  8016c3:	83 c4 08             	add    $0x8,%esp
  8016c6:	85 c0                	test   %eax,%eax
  8016c8:	74 dc                	je     8016a6 <strsplit+0x8c>
			string++;
	}
  8016ca:	e9 6e ff ff ff       	jmp    80163d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016cf:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d3:	8b 00                	mov    (%eax),%eax
  8016d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016df:	01 d0                	add    %edx,%eax
  8016e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016e7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
  8016f1:	83 ec 18             	sub    $0x18,%esp
  8016f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f7:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8016fa:	83 ec 04             	sub    $0x4,%esp
  8016fd:	68 f0 27 80 00       	push   $0x8027f0
  801702:	6a 17                	push   $0x17
  801704:	68 0f 28 80 00       	push   $0x80280f
  801709:	e8 8a 08 00 00       	call   801f98 <_panic>

0080170e <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
  801711:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801714:	83 ec 04             	sub    $0x4,%esp
  801717:	68 1b 28 80 00       	push   $0x80281b
  80171c:	6a 2f                	push   $0x2f
  80171e:	68 0f 28 80 00       	push   $0x80280f
  801723:	e8 70 08 00 00       	call   801f98 <_panic>

00801728 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
  80172b:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80172e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801735:	8b 55 08             	mov    0x8(%ebp),%edx
  801738:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80173b:	01 d0                	add    %edx,%eax
  80173d:	48                   	dec    %eax
  80173e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801741:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801744:	ba 00 00 00 00       	mov    $0x0,%edx
  801749:	f7 75 ec             	divl   -0x14(%ebp)
  80174c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80174f:	29 d0                	sub    %edx,%eax
  801751:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801754:	8b 45 08             	mov    0x8(%ebp),%eax
  801757:	c1 e8 0c             	shr    $0xc,%eax
  80175a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80175d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801764:	e9 c8 00 00 00       	jmp    801831 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801769:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801770:	eb 27                	jmp    801799 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801772:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801775:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801778:	01 c2                	add    %eax,%edx
  80177a:	89 d0                	mov    %edx,%eax
  80177c:	01 c0                	add    %eax,%eax
  80177e:	01 d0                	add    %edx,%eax
  801780:	c1 e0 02             	shl    $0x2,%eax
  801783:	05 48 30 80 00       	add    $0x803048,%eax
  801788:	8b 00                	mov    (%eax),%eax
  80178a:	85 c0                	test   %eax,%eax
  80178c:	74 08                	je     801796 <malloc+0x6e>
            	i += j;
  80178e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801791:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801794:	eb 0b                	jmp    8017a1 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801796:	ff 45 f0             	incl   -0x10(%ebp)
  801799:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80179c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80179f:	72 d1                	jb     801772 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8017a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017a4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8017a7:	0f 85 81 00 00 00    	jne    80182e <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8017ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b0:	05 00 00 08 00       	add    $0x80000,%eax
  8017b5:	c1 e0 0c             	shl    $0xc,%eax
  8017b8:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8017bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017c2:	eb 1f                	jmp    8017e3 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8017c4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ca:	01 c2                	add    %eax,%edx
  8017cc:	89 d0                	mov    %edx,%eax
  8017ce:	01 c0                	add    %eax,%eax
  8017d0:	01 d0                	add    %edx,%eax
  8017d2:	c1 e0 02             	shl    $0x2,%eax
  8017d5:	05 48 30 80 00       	add    $0x803048,%eax
  8017da:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8017e0:	ff 45 f0             	incl   -0x10(%ebp)
  8017e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017e6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8017e9:	72 d9                	jb     8017c4 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8017eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017ee:	89 d0                	mov    %edx,%eax
  8017f0:	01 c0                	add    %eax,%eax
  8017f2:	01 d0                	add    %edx,%eax
  8017f4:	c1 e0 02             	shl    $0x2,%eax
  8017f7:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8017fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801800:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801802:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801805:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801808:	89 c8                	mov    %ecx,%eax
  80180a:	01 c0                	add    %eax,%eax
  80180c:	01 c8                	add    %ecx,%eax
  80180e:	c1 e0 02             	shl    $0x2,%eax
  801811:	05 44 30 80 00       	add    $0x803044,%eax
  801816:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801818:	83 ec 08             	sub    $0x8,%esp
  80181b:	ff 75 08             	pushl  0x8(%ebp)
  80181e:	ff 75 e0             	pushl  -0x20(%ebp)
  801821:	e8 2b 03 00 00       	call   801b51 <sys_allocateMem>
  801826:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801829:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80182c:	eb 19                	jmp    801847 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80182e:	ff 45 f4             	incl   -0xc(%ebp)
  801831:	a1 04 30 80 00       	mov    0x803004,%eax
  801836:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801839:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80183c:	0f 83 27 ff ff ff    	jae    801769 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801842:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801847:	c9                   	leave  
  801848:	c3                   	ret    

00801849 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801849:	55                   	push   %ebp
  80184a:	89 e5                	mov    %esp,%ebp
  80184c:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80184f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801853:	0f 84 e5 00 00 00    	je     80193e <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80185f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801862:	05 00 00 00 80       	add    $0x80000000,%eax
  801867:	c1 e8 0c             	shr    $0xc,%eax
  80186a:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80186d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801870:	89 d0                	mov    %edx,%eax
  801872:	01 c0                	add    %eax,%eax
  801874:	01 d0                	add    %edx,%eax
  801876:	c1 e0 02             	shl    $0x2,%eax
  801879:	05 40 30 80 00       	add    $0x803040,%eax
  80187e:	8b 00                	mov    (%eax),%eax
  801880:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801883:	0f 85 b8 00 00 00    	jne    801941 <free+0xf8>
  801889:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80188c:	89 d0                	mov    %edx,%eax
  80188e:	01 c0                	add    %eax,%eax
  801890:	01 d0                	add    %edx,%eax
  801892:	c1 e0 02             	shl    $0x2,%eax
  801895:	05 48 30 80 00       	add    $0x803048,%eax
  80189a:	8b 00                	mov    (%eax),%eax
  80189c:	85 c0                	test   %eax,%eax
  80189e:	0f 84 9d 00 00 00    	je     801941 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8018a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018a7:	89 d0                	mov    %edx,%eax
  8018a9:	01 c0                	add    %eax,%eax
  8018ab:	01 d0                	add    %edx,%eax
  8018ad:	c1 e0 02             	shl    $0x2,%eax
  8018b0:	05 44 30 80 00       	add    $0x803044,%eax
  8018b5:	8b 00                	mov    (%eax),%eax
  8018b7:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8018ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018bd:	c1 e0 0c             	shl    $0xc,%eax
  8018c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8018c3:	83 ec 08             	sub    $0x8,%esp
  8018c6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8018c9:	ff 75 f0             	pushl  -0x10(%ebp)
  8018cc:	e8 64 02 00 00       	call   801b35 <sys_freeMem>
  8018d1:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8018d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8018db:	eb 57                	jmp    801934 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8018dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018e3:	01 c2                	add    %eax,%edx
  8018e5:	89 d0                	mov    %edx,%eax
  8018e7:	01 c0                	add    %eax,%eax
  8018e9:	01 d0                	add    %edx,%eax
  8018eb:	c1 e0 02             	shl    $0x2,%eax
  8018ee:	05 48 30 80 00       	add    $0x803048,%eax
  8018f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8018f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018ff:	01 c2                	add    %eax,%edx
  801901:	89 d0                	mov    %edx,%eax
  801903:	01 c0                	add    %eax,%eax
  801905:	01 d0                	add    %edx,%eax
  801907:	c1 e0 02             	shl    $0x2,%eax
  80190a:	05 40 30 80 00       	add    $0x803040,%eax
  80190f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801915:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801918:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80191b:	01 c2                	add    %eax,%edx
  80191d:	89 d0                	mov    %edx,%eax
  80191f:	01 c0                	add    %eax,%eax
  801921:	01 d0                	add    %edx,%eax
  801923:	c1 e0 02             	shl    $0x2,%eax
  801926:	05 44 30 80 00       	add    $0x803044,%eax
  80192b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801931:	ff 45 f4             	incl   -0xc(%ebp)
  801934:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801937:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80193a:	7c a1                	jl     8018dd <free+0x94>
  80193c:	eb 04                	jmp    801942 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80193e:	90                   	nop
  80193f:	eb 01                	jmp    801942 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801941:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
  801947:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80194a:	83 ec 04             	sub    $0x4,%esp
  80194d:	68 38 28 80 00       	push   $0x802838
  801952:	68 ae 00 00 00       	push   $0xae
  801957:	68 0f 28 80 00       	push   $0x80280f
  80195c:	e8 37 06 00 00       	call   801f98 <_panic>

00801961 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
  801964:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801967:	83 ec 04             	sub    $0x4,%esp
  80196a:	68 58 28 80 00       	push   $0x802858
  80196f:	68 ca 00 00 00       	push   $0xca
  801974:	68 0f 28 80 00       	push   $0x80280f
  801979:	e8 1a 06 00 00       	call   801f98 <_panic>

0080197e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
  801981:	57                   	push   %edi
  801982:	56                   	push   %esi
  801983:	53                   	push   %ebx
  801984:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801987:	8b 45 08             	mov    0x8(%ebp),%eax
  80198a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801990:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801993:	8b 7d 18             	mov    0x18(%ebp),%edi
  801996:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801999:	cd 30                	int    $0x30
  80199b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80199e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8019a1:	83 c4 10             	add    $0x10,%esp
  8019a4:	5b                   	pop    %ebx
  8019a5:	5e                   	pop    %esi
  8019a6:	5f                   	pop    %edi
  8019a7:	5d                   	pop    %ebp
  8019a8:	c3                   	ret    

008019a9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8019a9:	55                   	push   %ebp
  8019aa:	89 e5                	mov    %esp,%ebp
  8019ac:	83 ec 04             	sub    $0x4,%esp
  8019af:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8019b5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	52                   	push   %edx
  8019c1:	ff 75 0c             	pushl  0xc(%ebp)
  8019c4:	50                   	push   %eax
  8019c5:	6a 00                	push   $0x0
  8019c7:	e8 b2 ff ff ff       	call   80197e <syscall>
  8019cc:	83 c4 18             	add    $0x18,%esp
}
  8019cf:	90                   	nop
  8019d0:	c9                   	leave  
  8019d1:	c3                   	ret    

008019d2 <sys_cgetc>:

int
sys_cgetc(void)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 01                	push   $0x1
  8019e1:	e8 98 ff ff ff       	call   80197e <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	c9                   	leave  
  8019ea:	c3                   	ret    

008019eb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8019ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	50                   	push   %eax
  8019fa:	6a 05                	push   $0x5
  8019fc:	e8 7d ff ff ff       	call   80197e <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
}
  801a04:	c9                   	leave  
  801a05:	c3                   	ret    

00801a06 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 02                	push   $0x2
  801a15:	e8 64 ff ff ff       	call   80197e <syscall>
  801a1a:	83 c4 18             	add    $0x18,%esp
}
  801a1d:	c9                   	leave  
  801a1e:	c3                   	ret    

00801a1f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a1f:	55                   	push   %ebp
  801a20:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 03                	push   $0x3
  801a2e:	e8 4b ff ff ff       	call   80197e <syscall>
  801a33:	83 c4 18             	add    $0x18,%esp
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 04                	push   $0x4
  801a47:	e8 32 ff ff ff       	call   80197e <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <sys_env_exit>:


void sys_env_exit(void)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 06                	push   $0x6
  801a60:	e8 19 ff ff ff       	call   80197e <syscall>
  801a65:	83 c4 18             	add    $0x18,%esp
}
  801a68:	90                   	nop
  801a69:	c9                   	leave  
  801a6a:	c3                   	ret    

00801a6b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a71:	8b 45 08             	mov    0x8(%ebp),%eax
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	52                   	push   %edx
  801a7b:	50                   	push   %eax
  801a7c:	6a 07                	push   $0x7
  801a7e:	e8 fb fe ff ff       	call   80197e <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
  801a8b:	56                   	push   %esi
  801a8c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a8d:	8b 75 18             	mov    0x18(%ebp),%esi
  801a90:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a93:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a99:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9c:	56                   	push   %esi
  801a9d:	53                   	push   %ebx
  801a9e:	51                   	push   %ecx
  801a9f:	52                   	push   %edx
  801aa0:	50                   	push   %eax
  801aa1:	6a 08                	push   $0x8
  801aa3:	e8 d6 fe ff ff       	call   80197e <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
}
  801aab:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801aae:	5b                   	pop    %ebx
  801aaf:	5e                   	pop    %esi
  801ab0:	5d                   	pop    %ebp
  801ab1:	c3                   	ret    

00801ab2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ab5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	52                   	push   %edx
  801ac2:	50                   	push   %eax
  801ac3:	6a 09                	push   $0x9
  801ac5:	e8 b4 fe ff ff       	call   80197e <syscall>
  801aca:	83 c4 18             	add    $0x18,%esp
}
  801acd:	c9                   	leave  
  801ace:	c3                   	ret    

00801acf <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	ff 75 0c             	pushl  0xc(%ebp)
  801adb:	ff 75 08             	pushl  0x8(%ebp)
  801ade:	6a 0a                	push   $0xa
  801ae0:	e8 99 fe ff ff       	call   80197e <syscall>
  801ae5:	83 c4 18             	add    $0x18,%esp
}
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 0b                	push   $0xb
  801af9:	e8 80 fe ff ff       	call   80197e <syscall>
  801afe:	83 c4 18             	add    $0x18,%esp
}
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 0c                	push   $0xc
  801b12:	e8 67 fe ff ff       	call   80197e <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
}
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 0d                	push   $0xd
  801b2b:	e8 4e fe ff ff       	call   80197e <syscall>
  801b30:	83 c4 18             	add    $0x18,%esp
}
  801b33:	c9                   	leave  
  801b34:	c3                   	ret    

00801b35 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801b35:	55                   	push   %ebp
  801b36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	ff 75 0c             	pushl  0xc(%ebp)
  801b41:	ff 75 08             	pushl  0x8(%ebp)
  801b44:	6a 11                	push   $0x11
  801b46:	e8 33 fe ff ff       	call   80197e <syscall>
  801b4b:	83 c4 18             	add    $0x18,%esp
	return;
  801b4e:	90                   	nop
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b54:	6a 00                	push   $0x0
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	ff 75 0c             	pushl  0xc(%ebp)
  801b5d:	ff 75 08             	pushl  0x8(%ebp)
  801b60:	6a 12                	push   $0x12
  801b62:	e8 17 fe ff ff       	call   80197e <syscall>
  801b67:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6a:	90                   	nop
}
  801b6b:	c9                   	leave  
  801b6c:	c3                   	ret    

00801b6d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b6d:	55                   	push   %ebp
  801b6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 0e                	push   $0xe
  801b7c:	e8 fd fd ff ff       	call   80197e <syscall>
  801b81:	83 c4 18             	add    $0x18,%esp
}
  801b84:	c9                   	leave  
  801b85:	c3                   	ret    

00801b86 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b86:	55                   	push   %ebp
  801b87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	ff 75 08             	pushl  0x8(%ebp)
  801b94:	6a 0f                	push   $0xf
  801b96:	e8 e3 fd ff ff       	call   80197e <syscall>
  801b9b:	83 c4 18             	add    $0x18,%esp
}
  801b9e:	c9                   	leave  
  801b9f:	c3                   	ret    

00801ba0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ba0:	55                   	push   %ebp
  801ba1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 10                	push   $0x10
  801baf:	e8 ca fd ff ff       	call   80197e <syscall>
  801bb4:	83 c4 18             	add    $0x18,%esp
}
  801bb7:	90                   	nop
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 14                	push   $0x14
  801bc9:	e8 b0 fd ff ff       	call   80197e <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
}
  801bd1:	90                   	nop
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 15                	push   $0x15
  801be3:	e8 96 fd ff ff       	call   80197e <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
}
  801beb:	90                   	nop
  801bec:	c9                   	leave  
  801bed:	c3                   	ret    

00801bee <sys_cputc>:


void
sys_cputc(const char c)
{
  801bee:	55                   	push   %ebp
  801bef:	89 e5                	mov    %esp,%ebp
  801bf1:	83 ec 04             	sub    $0x4,%esp
  801bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801bfa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	50                   	push   %eax
  801c07:	6a 16                	push   $0x16
  801c09:	e8 70 fd ff ff       	call   80197e <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	90                   	nop
  801c12:	c9                   	leave  
  801c13:	c3                   	ret    

00801c14 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c14:	55                   	push   %ebp
  801c15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 17                	push   $0x17
  801c23:	e8 56 fd ff ff       	call   80197e <syscall>
  801c28:	83 c4 18             	add    $0x18,%esp
}
  801c2b:	90                   	nop
  801c2c:	c9                   	leave  
  801c2d:	c3                   	ret    

00801c2e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c2e:	55                   	push   %ebp
  801c2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c31:	8b 45 08             	mov    0x8(%ebp),%eax
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	ff 75 0c             	pushl  0xc(%ebp)
  801c3d:	50                   	push   %eax
  801c3e:	6a 18                	push   $0x18
  801c40:	e8 39 fd ff ff       	call   80197e <syscall>
  801c45:	83 c4 18             	add    $0x18,%esp
}
  801c48:	c9                   	leave  
  801c49:	c3                   	ret    

00801c4a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801c4a:	55                   	push   %ebp
  801c4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c50:	8b 45 08             	mov    0x8(%ebp),%eax
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	52                   	push   %edx
  801c5a:	50                   	push   %eax
  801c5b:	6a 1b                	push   $0x1b
  801c5d:	e8 1c fd ff ff       	call   80197e <syscall>
  801c62:	83 c4 18             	add    $0x18,%esp
}
  801c65:	c9                   	leave  
  801c66:	c3                   	ret    

00801c67 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c67:	55                   	push   %ebp
  801c68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	52                   	push   %edx
  801c77:	50                   	push   %eax
  801c78:	6a 19                	push   $0x19
  801c7a:	e8 ff fc ff ff       	call   80197e <syscall>
  801c7f:	83 c4 18             	add    $0x18,%esp
}
  801c82:	90                   	nop
  801c83:	c9                   	leave  
  801c84:	c3                   	ret    

00801c85 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c85:	55                   	push   %ebp
  801c86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	52                   	push   %edx
  801c95:	50                   	push   %eax
  801c96:	6a 1a                	push   $0x1a
  801c98:	e8 e1 fc ff ff       	call   80197e <syscall>
  801c9d:	83 c4 18             	add    $0x18,%esp
}
  801ca0:	90                   	nop
  801ca1:	c9                   	leave  
  801ca2:	c3                   	ret    

00801ca3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
  801ca6:	83 ec 04             	sub    $0x4,%esp
  801ca9:	8b 45 10             	mov    0x10(%ebp),%eax
  801cac:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801caf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801cb2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb9:	6a 00                	push   $0x0
  801cbb:	51                   	push   %ecx
  801cbc:	52                   	push   %edx
  801cbd:	ff 75 0c             	pushl  0xc(%ebp)
  801cc0:	50                   	push   %eax
  801cc1:	6a 1c                	push   $0x1c
  801cc3:	e8 b6 fc ff ff       	call   80197e <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
}
  801ccb:	c9                   	leave  
  801ccc:	c3                   	ret    

00801ccd <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ccd:	55                   	push   %ebp
  801cce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801cd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	52                   	push   %edx
  801cdd:	50                   	push   %eax
  801cde:	6a 1d                	push   $0x1d
  801ce0:	e8 99 fc ff ff       	call   80197e <syscall>
  801ce5:	83 c4 18             	add    $0x18,%esp
}
  801ce8:	c9                   	leave  
  801ce9:	c3                   	ret    

00801cea <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ced:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	51                   	push   %ecx
  801cfb:	52                   	push   %edx
  801cfc:	50                   	push   %eax
  801cfd:	6a 1e                	push   $0x1e
  801cff:	e8 7a fc ff ff       	call   80197e <syscall>
  801d04:	83 c4 18             	add    $0x18,%esp
}
  801d07:	c9                   	leave  
  801d08:	c3                   	ret    

00801d09 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d09:	55                   	push   %ebp
  801d0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	52                   	push   %edx
  801d19:	50                   	push   %eax
  801d1a:	6a 1f                	push   $0x1f
  801d1c:	e8 5d fc ff ff       	call   80197e <syscall>
  801d21:	83 c4 18             	add    $0x18,%esp
}
  801d24:	c9                   	leave  
  801d25:	c3                   	ret    

00801d26 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d26:	55                   	push   %ebp
  801d27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 20                	push   $0x20
  801d35:	e8 44 fc ff ff       	call   80197e <syscall>
  801d3a:	83 c4 18             	add    $0x18,%esp
}
  801d3d:	c9                   	leave  
  801d3e:	c3                   	ret    

00801d3f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801d3f:	55                   	push   %ebp
  801d40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801d42:	8b 45 08             	mov    0x8(%ebp),%eax
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	ff 75 10             	pushl  0x10(%ebp)
  801d4c:	ff 75 0c             	pushl  0xc(%ebp)
  801d4f:	50                   	push   %eax
  801d50:	6a 21                	push   $0x21
  801d52:	e8 27 fc ff ff       	call   80197e <syscall>
  801d57:	83 c4 18             	add    $0x18,%esp
}
  801d5a:	c9                   	leave  
  801d5b:	c3                   	ret    

00801d5c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d5c:	55                   	push   %ebp
  801d5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d62:	6a 00                	push   $0x0
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	50                   	push   %eax
  801d6b:	6a 22                	push   $0x22
  801d6d:	e8 0c fc ff ff       	call   80197e <syscall>
  801d72:	83 c4 18             	add    $0x18,%esp
}
  801d75:	90                   	nop
  801d76:	c9                   	leave  
  801d77:	c3                   	ret    

00801d78 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d78:	55                   	push   %ebp
  801d79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	50                   	push   %eax
  801d87:	6a 23                	push   $0x23
  801d89:	e8 f0 fb ff ff       	call   80197e <syscall>
  801d8e:	83 c4 18             	add    $0x18,%esp
}
  801d91:	90                   	nop
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
  801d97:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d9a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d9d:	8d 50 04             	lea    0x4(%eax),%edx
  801da0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	52                   	push   %edx
  801daa:	50                   	push   %eax
  801dab:	6a 24                	push   $0x24
  801dad:	e8 cc fb ff ff       	call   80197e <syscall>
  801db2:	83 c4 18             	add    $0x18,%esp
	return result;
  801db5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801db8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801dbb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dbe:	89 01                	mov    %eax,(%ecx)
  801dc0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc6:	c9                   	leave  
  801dc7:	c2 04 00             	ret    $0x4

00801dca <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801dca:	55                   	push   %ebp
  801dcb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	ff 75 10             	pushl  0x10(%ebp)
  801dd4:	ff 75 0c             	pushl  0xc(%ebp)
  801dd7:	ff 75 08             	pushl  0x8(%ebp)
  801dda:	6a 13                	push   $0x13
  801ddc:	e8 9d fb ff ff       	call   80197e <syscall>
  801de1:	83 c4 18             	add    $0x18,%esp
	return ;
  801de4:	90                   	nop
}
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <sys_rcr2>:
uint32 sys_rcr2()
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 25                	push   $0x25
  801df6:	e8 83 fb ff ff       	call   80197e <syscall>
  801dfb:	83 c4 18             	add    $0x18,%esp
}
  801dfe:	c9                   	leave  
  801dff:	c3                   	ret    

00801e00 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e00:	55                   	push   %ebp
  801e01:	89 e5                	mov    %esp,%ebp
  801e03:	83 ec 04             	sub    $0x4,%esp
  801e06:	8b 45 08             	mov    0x8(%ebp),%eax
  801e09:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e0c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	50                   	push   %eax
  801e19:	6a 26                	push   $0x26
  801e1b:	e8 5e fb ff ff       	call   80197e <syscall>
  801e20:	83 c4 18             	add    $0x18,%esp
	return ;
  801e23:	90                   	nop
}
  801e24:	c9                   	leave  
  801e25:	c3                   	ret    

00801e26 <rsttst>:
void rsttst()
{
  801e26:	55                   	push   %ebp
  801e27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 28                	push   $0x28
  801e35:	e8 44 fb ff ff       	call   80197e <syscall>
  801e3a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e3d:	90                   	nop
}
  801e3e:	c9                   	leave  
  801e3f:	c3                   	ret    

00801e40 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801e40:	55                   	push   %ebp
  801e41:	89 e5                	mov    %esp,%ebp
  801e43:	83 ec 04             	sub    $0x4,%esp
  801e46:	8b 45 14             	mov    0x14(%ebp),%eax
  801e49:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801e4c:	8b 55 18             	mov    0x18(%ebp),%edx
  801e4f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e53:	52                   	push   %edx
  801e54:	50                   	push   %eax
  801e55:	ff 75 10             	pushl  0x10(%ebp)
  801e58:	ff 75 0c             	pushl  0xc(%ebp)
  801e5b:	ff 75 08             	pushl  0x8(%ebp)
  801e5e:	6a 27                	push   $0x27
  801e60:	e8 19 fb ff ff       	call   80197e <syscall>
  801e65:	83 c4 18             	add    $0x18,%esp
	return ;
  801e68:	90                   	nop
}
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <chktst>:
void chktst(uint32 n)
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	ff 75 08             	pushl  0x8(%ebp)
  801e79:	6a 29                	push   $0x29
  801e7b:	e8 fe fa ff ff       	call   80197e <syscall>
  801e80:	83 c4 18             	add    $0x18,%esp
	return ;
  801e83:	90                   	nop
}
  801e84:	c9                   	leave  
  801e85:	c3                   	ret    

00801e86 <inctst>:

void inctst()
{
  801e86:	55                   	push   %ebp
  801e87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	6a 2a                	push   $0x2a
  801e95:	e8 e4 fa ff ff       	call   80197e <syscall>
  801e9a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e9d:	90                   	nop
}
  801e9e:	c9                   	leave  
  801e9f:	c3                   	ret    

00801ea0 <gettst>:
uint32 gettst()
{
  801ea0:	55                   	push   %ebp
  801ea1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 2b                	push   $0x2b
  801eaf:	e8 ca fa ff ff       	call   80197e <syscall>
  801eb4:	83 c4 18             	add    $0x18,%esp
}
  801eb7:	c9                   	leave  
  801eb8:	c3                   	ret    

00801eb9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801eb9:	55                   	push   %ebp
  801eba:	89 e5                	mov    %esp,%ebp
  801ebc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 2c                	push   $0x2c
  801ecb:	e8 ae fa ff ff       	call   80197e <syscall>
  801ed0:	83 c4 18             	add    $0x18,%esp
  801ed3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ed6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801eda:	75 07                	jne    801ee3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801edc:	b8 01 00 00 00       	mov    $0x1,%eax
  801ee1:	eb 05                	jmp    801ee8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ee3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ee8:	c9                   	leave  
  801ee9:	c3                   	ret    

00801eea <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801eea:	55                   	push   %ebp
  801eeb:	89 e5                	mov    %esp,%ebp
  801eed:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 2c                	push   $0x2c
  801efc:	e8 7d fa ff ff       	call   80197e <syscall>
  801f01:	83 c4 18             	add    $0x18,%esp
  801f04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f07:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f0b:	75 07                	jne    801f14 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f0d:	b8 01 00 00 00       	mov    $0x1,%eax
  801f12:	eb 05                	jmp    801f19 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f14:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f19:	c9                   	leave  
  801f1a:	c3                   	ret    

00801f1b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f1b:	55                   	push   %ebp
  801f1c:	89 e5                	mov    %esp,%ebp
  801f1e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 2c                	push   $0x2c
  801f2d:	e8 4c fa ff ff       	call   80197e <syscall>
  801f32:	83 c4 18             	add    $0x18,%esp
  801f35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801f38:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801f3c:	75 07                	jne    801f45 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801f3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f43:	eb 05                	jmp    801f4a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801f45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f4a:	c9                   	leave  
  801f4b:	c3                   	ret    

00801f4c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801f4c:	55                   	push   %ebp
  801f4d:	89 e5                	mov    %esp,%ebp
  801f4f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 2c                	push   $0x2c
  801f5e:	e8 1b fa ff ff       	call   80197e <syscall>
  801f63:	83 c4 18             	add    $0x18,%esp
  801f66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f69:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f6d:	75 07                	jne    801f76 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f6f:	b8 01 00 00 00       	mov    $0x1,%eax
  801f74:	eb 05                	jmp    801f7b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f76:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f7b:	c9                   	leave  
  801f7c:	c3                   	ret    

00801f7d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f7d:	55                   	push   %ebp
  801f7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	ff 75 08             	pushl  0x8(%ebp)
  801f8b:	6a 2d                	push   $0x2d
  801f8d:	e8 ec f9 ff ff       	call   80197e <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
	return ;
  801f95:	90                   	nop
}
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
  801f9b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801f9e:	8d 45 10             	lea    0x10(%ebp),%eax
  801fa1:	83 c0 04             	add    $0x4,%eax
  801fa4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801fa7:	a1 40 30 98 00       	mov    0x983040,%eax
  801fac:	85 c0                	test   %eax,%eax
  801fae:	74 16                	je     801fc6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801fb0:	a1 40 30 98 00       	mov    0x983040,%eax
  801fb5:	83 ec 08             	sub    $0x8,%esp
  801fb8:	50                   	push   %eax
  801fb9:	68 7c 28 80 00       	push   $0x80287c
  801fbe:	e8 a1 e9 ff ff       	call   800964 <cprintf>
  801fc3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801fc6:	a1 00 30 80 00       	mov    0x803000,%eax
  801fcb:	ff 75 0c             	pushl  0xc(%ebp)
  801fce:	ff 75 08             	pushl  0x8(%ebp)
  801fd1:	50                   	push   %eax
  801fd2:	68 81 28 80 00       	push   $0x802881
  801fd7:	e8 88 e9 ff ff       	call   800964 <cprintf>
  801fdc:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801fdf:	8b 45 10             	mov    0x10(%ebp),%eax
  801fe2:	83 ec 08             	sub    $0x8,%esp
  801fe5:	ff 75 f4             	pushl  -0xc(%ebp)
  801fe8:	50                   	push   %eax
  801fe9:	e8 0b e9 ff ff       	call   8008f9 <vcprintf>
  801fee:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801ff1:	83 ec 08             	sub    $0x8,%esp
  801ff4:	6a 00                	push   $0x0
  801ff6:	68 9d 28 80 00       	push   $0x80289d
  801ffb:	e8 f9 e8 ff ff       	call   8008f9 <vcprintf>
  802000:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  802003:	e8 7a e8 ff ff       	call   800882 <exit>

	// should not return here
	while (1) ;
  802008:	eb fe                	jmp    802008 <_panic+0x70>

0080200a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80200a:	55                   	push   %ebp
  80200b:	89 e5                	mov    %esp,%ebp
  80200d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  802010:	a1 20 30 80 00       	mov    0x803020,%eax
  802015:	8b 50 74             	mov    0x74(%eax),%edx
  802018:	8b 45 0c             	mov    0xc(%ebp),%eax
  80201b:	39 c2                	cmp    %eax,%edx
  80201d:	74 14                	je     802033 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80201f:	83 ec 04             	sub    $0x4,%esp
  802022:	68 a0 28 80 00       	push   $0x8028a0
  802027:	6a 26                	push   $0x26
  802029:	68 ec 28 80 00       	push   $0x8028ec
  80202e:	e8 65 ff ff ff       	call   801f98 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  802033:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80203a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802041:	e9 c2 00 00 00       	jmp    802108 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  802046:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802049:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802050:	8b 45 08             	mov    0x8(%ebp),%eax
  802053:	01 d0                	add    %edx,%eax
  802055:	8b 00                	mov    (%eax),%eax
  802057:	85 c0                	test   %eax,%eax
  802059:	75 08                	jne    802063 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80205b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80205e:	e9 a2 00 00 00       	jmp    802105 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  802063:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80206a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  802071:	eb 69                	jmp    8020dc <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  802073:	a1 20 30 80 00       	mov    0x803020,%eax
  802078:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80207e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  802081:	89 d0                	mov    %edx,%eax
  802083:	01 c0                	add    %eax,%eax
  802085:	01 d0                	add    %edx,%eax
  802087:	c1 e0 02             	shl    $0x2,%eax
  80208a:	01 c8                	add    %ecx,%eax
  80208c:	8a 40 04             	mov    0x4(%eax),%al
  80208f:	84 c0                	test   %al,%al
  802091:	75 46                	jne    8020d9 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  802093:	a1 20 30 80 00       	mov    0x803020,%eax
  802098:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80209e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8020a1:	89 d0                	mov    %edx,%eax
  8020a3:	01 c0                	add    %eax,%eax
  8020a5:	01 d0                	add    %edx,%eax
  8020a7:	c1 e0 02             	shl    $0x2,%eax
  8020aa:	01 c8                	add    %ecx,%eax
  8020ac:	8b 00                	mov    (%eax),%eax
  8020ae:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8020b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8020b4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8020b9:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8020bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020be:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8020c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c8:	01 c8                	add    %ecx,%eax
  8020ca:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8020cc:	39 c2                	cmp    %eax,%edx
  8020ce:	75 09                	jne    8020d9 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8020d0:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8020d7:	eb 12                	jmp    8020eb <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8020d9:	ff 45 e8             	incl   -0x18(%ebp)
  8020dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8020e1:	8b 50 74             	mov    0x74(%eax),%edx
  8020e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8020e7:	39 c2                	cmp    %eax,%edx
  8020e9:	77 88                	ja     802073 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8020eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8020ef:	75 14                	jne    802105 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8020f1:	83 ec 04             	sub    $0x4,%esp
  8020f4:	68 f8 28 80 00       	push   $0x8028f8
  8020f9:	6a 3a                	push   $0x3a
  8020fb:	68 ec 28 80 00       	push   $0x8028ec
  802100:	e8 93 fe ff ff       	call   801f98 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  802105:	ff 45 f0             	incl   -0x10(%ebp)
  802108:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80210b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80210e:	0f 8c 32 ff ff ff    	jl     802046 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  802114:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80211b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802122:	eb 26                	jmp    80214a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802124:	a1 20 30 80 00       	mov    0x803020,%eax
  802129:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80212f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802132:	89 d0                	mov    %edx,%eax
  802134:	01 c0                	add    %eax,%eax
  802136:	01 d0                	add    %edx,%eax
  802138:	c1 e0 02             	shl    $0x2,%eax
  80213b:	01 c8                	add    %ecx,%eax
  80213d:	8a 40 04             	mov    0x4(%eax),%al
  802140:	3c 01                	cmp    $0x1,%al
  802142:	75 03                	jne    802147 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  802144:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802147:	ff 45 e0             	incl   -0x20(%ebp)
  80214a:	a1 20 30 80 00       	mov    0x803020,%eax
  80214f:	8b 50 74             	mov    0x74(%eax),%edx
  802152:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802155:	39 c2                	cmp    %eax,%edx
  802157:	77 cb                	ja     802124 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  802159:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80215c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80215f:	74 14                	je     802175 <CheckWSWithoutLastIndex+0x16b>
		panic(
  802161:	83 ec 04             	sub    $0x4,%esp
  802164:	68 4c 29 80 00       	push   $0x80294c
  802169:	6a 44                	push   $0x44
  80216b:	68 ec 28 80 00       	push   $0x8028ec
  802170:	e8 23 fe ff ff       	call   801f98 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  802175:	90                   	nop
  802176:	c9                   	leave  
  802177:	c3                   	ret    

00802178 <__udivdi3>:
  802178:	55                   	push   %ebp
  802179:	57                   	push   %edi
  80217a:	56                   	push   %esi
  80217b:	53                   	push   %ebx
  80217c:	83 ec 1c             	sub    $0x1c,%esp
  80217f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802183:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802187:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80218b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80218f:	89 ca                	mov    %ecx,%edx
  802191:	89 f8                	mov    %edi,%eax
  802193:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802197:	85 f6                	test   %esi,%esi
  802199:	75 2d                	jne    8021c8 <__udivdi3+0x50>
  80219b:	39 cf                	cmp    %ecx,%edi
  80219d:	77 65                	ja     802204 <__udivdi3+0x8c>
  80219f:	89 fd                	mov    %edi,%ebp
  8021a1:	85 ff                	test   %edi,%edi
  8021a3:	75 0b                	jne    8021b0 <__udivdi3+0x38>
  8021a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021aa:	31 d2                	xor    %edx,%edx
  8021ac:	f7 f7                	div    %edi
  8021ae:	89 c5                	mov    %eax,%ebp
  8021b0:	31 d2                	xor    %edx,%edx
  8021b2:	89 c8                	mov    %ecx,%eax
  8021b4:	f7 f5                	div    %ebp
  8021b6:	89 c1                	mov    %eax,%ecx
  8021b8:	89 d8                	mov    %ebx,%eax
  8021ba:	f7 f5                	div    %ebp
  8021bc:	89 cf                	mov    %ecx,%edi
  8021be:	89 fa                	mov    %edi,%edx
  8021c0:	83 c4 1c             	add    $0x1c,%esp
  8021c3:	5b                   	pop    %ebx
  8021c4:	5e                   	pop    %esi
  8021c5:	5f                   	pop    %edi
  8021c6:	5d                   	pop    %ebp
  8021c7:	c3                   	ret    
  8021c8:	39 ce                	cmp    %ecx,%esi
  8021ca:	77 28                	ja     8021f4 <__udivdi3+0x7c>
  8021cc:	0f bd fe             	bsr    %esi,%edi
  8021cf:	83 f7 1f             	xor    $0x1f,%edi
  8021d2:	75 40                	jne    802214 <__udivdi3+0x9c>
  8021d4:	39 ce                	cmp    %ecx,%esi
  8021d6:	72 0a                	jb     8021e2 <__udivdi3+0x6a>
  8021d8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021dc:	0f 87 9e 00 00 00    	ja     802280 <__udivdi3+0x108>
  8021e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021e7:	89 fa                	mov    %edi,%edx
  8021e9:	83 c4 1c             	add    $0x1c,%esp
  8021ec:	5b                   	pop    %ebx
  8021ed:	5e                   	pop    %esi
  8021ee:	5f                   	pop    %edi
  8021ef:	5d                   	pop    %ebp
  8021f0:	c3                   	ret    
  8021f1:	8d 76 00             	lea    0x0(%esi),%esi
  8021f4:	31 ff                	xor    %edi,%edi
  8021f6:	31 c0                	xor    %eax,%eax
  8021f8:	89 fa                	mov    %edi,%edx
  8021fa:	83 c4 1c             	add    $0x1c,%esp
  8021fd:	5b                   	pop    %ebx
  8021fe:	5e                   	pop    %esi
  8021ff:	5f                   	pop    %edi
  802200:	5d                   	pop    %ebp
  802201:	c3                   	ret    
  802202:	66 90                	xchg   %ax,%ax
  802204:	89 d8                	mov    %ebx,%eax
  802206:	f7 f7                	div    %edi
  802208:	31 ff                	xor    %edi,%edi
  80220a:	89 fa                	mov    %edi,%edx
  80220c:	83 c4 1c             	add    $0x1c,%esp
  80220f:	5b                   	pop    %ebx
  802210:	5e                   	pop    %esi
  802211:	5f                   	pop    %edi
  802212:	5d                   	pop    %ebp
  802213:	c3                   	ret    
  802214:	bd 20 00 00 00       	mov    $0x20,%ebp
  802219:	89 eb                	mov    %ebp,%ebx
  80221b:	29 fb                	sub    %edi,%ebx
  80221d:	89 f9                	mov    %edi,%ecx
  80221f:	d3 e6                	shl    %cl,%esi
  802221:	89 c5                	mov    %eax,%ebp
  802223:	88 d9                	mov    %bl,%cl
  802225:	d3 ed                	shr    %cl,%ebp
  802227:	89 e9                	mov    %ebp,%ecx
  802229:	09 f1                	or     %esi,%ecx
  80222b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80222f:	89 f9                	mov    %edi,%ecx
  802231:	d3 e0                	shl    %cl,%eax
  802233:	89 c5                	mov    %eax,%ebp
  802235:	89 d6                	mov    %edx,%esi
  802237:	88 d9                	mov    %bl,%cl
  802239:	d3 ee                	shr    %cl,%esi
  80223b:	89 f9                	mov    %edi,%ecx
  80223d:	d3 e2                	shl    %cl,%edx
  80223f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802243:	88 d9                	mov    %bl,%cl
  802245:	d3 e8                	shr    %cl,%eax
  802247:	09 c2                	or     %eax,%edx
  802249:	89 d0                	mov    %edx,%eax
  80224b:	89 f2                	mov    %esi,%edx
  80224d:	f7 74 24 0c          	divl   0xc(%esp)
  802251:	89 d6                	mov    %edx,%esi
  802253:	89 c3                	mov    %eax,%ebx
  802255:	f7 e5                	mul    %ebp
  802257:	39 d6                	cmp    %edx,%esi
  802259:	72 19                	jb     802274 <__udivdi3+0xfc>
  80225b:	74 0b                	je     802268 <__udivdi3+0xf0>
  80225d:	89 d8                	mov    %ebx,%eax
  80225f:	31 ff                	xor    %edi,%edi
  802261:	e9 58 ff ff ff       	jmp    8021be <__udivdi3+0x46>
  802266:	66 90                	xchg   %ax,%ax
  802268:	8b 54 24 08          	mov    0x8(%esp),%edx
  80226c:	89 f9                	mov    %edi,%ecx
  80226e:	d3 e2                	shl    %cl,%edx
  802270:	39 c2                	cmp    %eax,%edx
  802272:	73 e9                	jae    80225d <__udivdi3+0xe5>
  802274:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802277:	31 ff                	xor    %edi,%edi
  802279:	e9 40 ff ff ff       	jmp    8021be <__udivdi3+0x46>
  80227e:	66 90                	xchg   %ax,%ax
  802280:	31 c0                	xor    %eax,%eax
  802282:	e9 37 ff ff ff       	jmp    8021be <__udivdi3+0x46>
  802287:	90                   	nop

00802288 <__umoddi3>:
  802288:	55                   	push   %ebp
  802289:	57                   	push   %edi
  80228a:	56                   	push   %esi
  80228b:	53                   	push   %ebx
  80228c:	83 ec 1c             	sub    $0x1c,%esp
  80228f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802293:	8b 74 24 34          	mov    0x34(%esp),%esi
  802297:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80229b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80229f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022a3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022a7:	89 f3                	mov    %esi,%ebx
  8022a9:	89 fa                	mov    %edi,%edx
  8022ab:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022af:	89 34 24             	mov    %esi,(%esp)
  8022b2:	85 c0                	test   %eax,%eax
  8022b4:	75 1a                	jne    8022d0 <__umoddi3+0x48>
  8022b6:	39 f7                	cmp    %esi,%edi
  8022b8:	0f 86 a2 00 00 00    	jbe    802360 <__umoddi3+0xd8>
  8022be:	89 c8                	mov    %ecx,%eax
  8022c0:	89 f2                	mov    %esi,%edx
  8022c2:	f7 f7                	div    %edi
  8022c4:	89 d0                	mov    %edx,%eax
  8022c6:	31 d2                	xor    %edx,%edx
  8022c8:	83 c4 1c             	add    $0x1c,%esp
  8022cb:	5b                   	pop    %ebx
  8022cc:	5e                   	pop    %esi
  8022cd:	5f                   	pop    %edi
  8022ce:	5d                   	pop    %ebp
  8022cf:	c3                   	ret    
  8022d0:	39 f0                	cmp    %esi,%eax
  8022d2:	0f 87 ac 00 00 00    	ja     802384 <__umoddi3+0xfc>
  8022d8:	0f bd e8             	bsr    %eax,%ebp
  8022db:	83 f5 1f             	xor    $0x1f,%ebp
  8022de:	0f 84 ac 00 00 00    	je     802390 <__umoddi3+0x108>
  8022e4:	bf 20 00 00 00       	mov    $0x20,%edi
  8022e9:	29 ef                	sub    %ebp,%edi
  8022eb:	89 fe                	mov    %edi,%esi
  8022ed:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022f1:	89 e9                	mov    %ebp,%ecx
  8022f3:	d3 e0                	shl    %cl,%eax
  8022f5:	89 d7                	mov    %edx,%edi
  8022f7:	89 f1                	mov    %esi,%ecx
  8022f9:	d3 ef                	shr    %cl,%edi
  8022fb:	09 c7                	or     %eax,%edi
  8022fd:	89 e9                	mov    %ebp,%ecx
  8022ff:	d3 e2                	shl    %cl,%edx
  802301:	89 14 24             	mov    %edx,(%esp)
  802304:	89 d8                	mov    %ebx,%eax
  802306:	d3 e0                	shl    %cl,%eax
  802308:	89 c2                	mov    %eax,%edx
  80230a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80230e:	d3 e0                	shl    %cl,%eax
  802310:	89 44 24 04          	mov    %eax,0x4(%esp)
  802314:	8b 44 24 08          	mov    0x8(%esp),%eax
  802318:	89 f1                	mov    %esi,%ecx
  80231a:	d3 e8                	shr    %cl,%eax
  80231c:	09 d0                	or     %edx,%eax
  80231e:	d3 eb                	shr    %cl,%ebx
  802320:	89 da                	mov    %ebx,%edx
  802322:	f7 f7                	div    %edi
  802324:	89 d3                	mov    %edx,%ebx
  802326:	f7 24 24             	mull   (%esp)
  802329:	89 c6                	mov    %eax,%esi
  80232b:	89 d1                	mov    %edx,%ecx
  80232d:	39 d3                	cmp    %edx,%ebx
  80232f:	0f 82 87 00 00 00    	jb     8023bc <__umoddi3+0x134>
  802335:	0f 84 91 00 00 00    	je     8023cc <__umoddi3+0x144>
  80233b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80233f:	29 f2                	sub    %esi,%edx
  802341:	19 cb                	sbb    %ecx,%ebx
  802343:	89 d8                	mov    %ebx,%eax
  802345:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802349:	d3 e0                	shl    %cl,%eax
  80234b:	89 e9                	mov    %ebp,%ecx
  80234d:	d3 ea                	shr    %cl,%edx
  80234f:	09 d0                	or     %edx,%eax
  802351:	89 e9                	mov    %ebp,%ecx
  802353:	d3 eb                	shr    %cl,%ebx
  802355:	89 da                	mov    %ebx,%edx
  802357:	83 c4 1c             	add    $0x1c,%esp
  80235a:	5b                   	pop    %ebx
  80235b:	5e                   	pop    %esi
  80235c:	5f                   	pop    %edi
  80235d:	5d                   	pop    %ebp
  80235e:	c3                   	ret    
  80235f:	90                   	nop
  802360:	89 fd                	mov    %edi,%ebp
  802362:	85 ff                	test   %edi,%edi
  802364:	75 0b                	jne    802371 <__umoddi3+0xe9>
  802366:	b8 01 00 00 00       	mov    $0x1,%eax
  80236b:	31 d2                	xor    %edx,%edx
  80236d:	f7 f7                	div    %edi
  80236f:	89 c5                	mov    %eax,%ebp
  802371:	89 f0                	mov    %esi,%eax
  802373:	31 d2                	xor    %edx,%edx
  802375:	f7 f5                	div    %ebp
  802377:	89 c8                	mov    %ecx,%eax
  802379:	f7 f5                	div    %ebp
  80237b:	89 d0                	mov    %edx,%eax
  80237d:	e9 44 ff ff ff       	jmp    8022c6 <__umoddi3+0x3e>
  802382:	66 90                	xchg   %ax,%ax
  802384:	89 c8                	mov    %ecx,%eax
  802386:	89 f2                	mov    %esi,%edx
  802388:	83 c4 1c             	add    $0x1c,%esp
  80238b:	5b                   	pop    %ebx
  80238c:	5e                   	pop    %esi
  80238d:	5f                   	pop    %edi
  80238e:	5d                   	pop    %ebp
  80238f:	c3                   	ret    
  802390:	3b 04 24             	cmp    (%esp),%eax
  802393:	72 06                	jb     80239b <__umoddi3+0x113>
  802395:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802399:	77 0f                	ja     8023aa <__umoddi3+0x122>
  80239b:	89 f2                	mov    %esi,%edx
  80239d:	29 f9                	sub    %edi,%ecx
  80239f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023a3:	89 14 24             	mov    %edx,(%esp)
  8023a6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023aa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023ae:	8b 14 24             	mov    (%esp),%edx
  8023b1:	83 c4 1c             	add    $0x1c,%esp
  8023b4:	5b                   	pop    %ebx
  8023b5:	5e                   	pop    %esi
  8023b6:	5f                   	pop    %edi
  8023b7:	5d                   	pop    %ebp
  8023b8:	c3                   	ret    
  8023b9:	8d 76 00             	lea    0x0(%esi),%esi
  8023bc:	2b 04 24             	sub    (%esp),%eax
  8023bf:	19 fa                	sbb    %edi,%edx
  8023c1:	89 d1                	mov    %edx,%ecx
  8023c3:	89 c6                	mov    %eax,%esi
  8023c5:	e9 71 ff ff ff       	jmp    80233b <__umoddi3+0xb3>
  8023ca:	66 90                	xchg   %ax,%ax
  8023cc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023d0:	72 ea                	jb     8023bc <__umoddi3+0x134>
  8023d2:	89 d9                	mov    %ebx,%ecx
  8023d4:	e9 62 ff ff ff       	jmp    80233b <__umoddi3+0xb3>
