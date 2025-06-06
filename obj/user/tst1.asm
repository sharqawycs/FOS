
obj/user/tst1:     file format elf32-i386


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
  800031:	e8 a7 03 00 00       	call   8003dd <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp
	

	
	

	rsttst();
  800041:	e8 2f 1a 00 00       	call   801a75 <rsttst>
	int Mega = 1024*1024;
  800046:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  80004d:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	void* ptr_allocations[20] = {0};
  800054:	8d 55 8c             	lea    -0x74(%ebp),%edx
  800057:	b9 14 00 00 00       	mov    $0x14,%ecx
  80005c:	b8 00 00 00 00       	mov    $0x0,%eax
  800061:	89 d7                	mov    %edx,%edi
  800063:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  800065:	e8 cf 16 00 00       	call   801739 <sys_calculate_free_frames>
  80006a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  80006d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800070:	01 c0                	add    %eax,%eax
  800072:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800075:	83 ec 0c             	sub    $0xc,%esp
  800078:	50                   	push   %eax
  800079:	e8 f9 12 00 00       	call   801377 <malloc>
  80007e:	83 c4 10             	add    $0x10,%esp
  800081:	89 45 8c             	mov    %eax,-0x74(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  800084:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	6a 00                	push   $0x0
  80008c:	6a 62                	push   $0x62
  80008e:	68 00 10 00 80       	push   $0x80001000
  800093:	68 00 00 00 80       	push   $0x80000000
  800098:	50                   	push   %eax
  800099:	e8 f1 19 00 00       	call   801a8f <tst>
  80009e:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8000a1:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8000a4:	e8 90 16 00 00       	call   801739 <sys_calculate_free_frames>
  8000a9:	29 c3                	sub    %eax,%ebx
  8000ab:	89 d8                	mov    %ebx,%eax
  8000ad:	83 ec 0c             	sub    $0xc,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	6a 65                	push   $0x65
  8000b4:	6a 00                	push   $0x0
  8000b6:	68 01 02 00 00       	push   $0x201
  8000bb:	50                   	push   %eax
  8000bc:	e8 ce 19 00 00       	call   801a8f <tst>
  8000c1:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8000c4:	e8 70 16 00 00       	call   801739 <sys_calculate_free_frames>
  8000c9:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  8000cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000cf:	01 c0                	add    %eax,%eax
  8000d1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000d4:	83 ec 0c             	sub    $0xc,%esp
  8000d7:	50                   	push   %eax
  8000d8:	e8 9a 12 00 00       	call   801377 <malloc>
  8000dd:	83 c4 10             	add    $0x10,%esp
  8000e0:	89 45 90             	mov    %eax,-0x70(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
  8000e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e6:	01 c0                	add    %eax,%eax
  8000e8:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8000ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f1:	01 c0                	add    %eax,%eax
  8000f3:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8000f9:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	6a 00                	push   $0x0
  800101:	6a 62                	push   $0x62
  800103:	51                   	push   %ecx
  800104:	52                   	push   %edx
  800105:	50                   	push   %eax
  800106:	e8 84 19 00 00       	call   801a8f <tst>
  80010b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  80010e:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  800111:	e8 23 16 00 00       	call   801739 <sys_calculate_free_frames>
  800116:	29 c3                	sub    %eax,%ebx
  800118:	89 d8                	mov    %ebx,%eax
  80011a:	83 ec 0c             	sub    $0xc,%esp
  80011d:	6a 00                	push   $0x0
  80011f:	6a 65                	push   $0x65
  800121:	6a 00                	push   $0x0
  800123:	68 00 02 00 00       	push   $0x200
  800128:	50                   	push   %eax
  800129:	e8 61 19 00 00       	call   801a8f <tst>
  80012e:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800131:	e8 03 16 00 00       	call   801739 <sys_calculate_free_frames>
  800136:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800139:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80013c:	01 c0                	add    %eax,%eax
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	50                   	push   %eax
  800142:	e8 30 12 00 00       	call   801377 <malloc>
  800147:	83 c4 10             	add    $0x10,%esp
  80014a:	89 45 94             	mov    %eax,-0x6c(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  80014d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800150:	c1 e0 02             	shl    $0x2,%eax
  800153:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800159:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80015c:	c1 e0 02             	shl    $0x2,%eax
  80015f:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800165:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800168:	83 ec 0c             	sub    $0xc,%esp
  80016b:	6a 00                	push   $0x0
  80016d:	6a 62                	push   $0x62
  80016f:	51                   	push   %ecx
  800170:	52                   	push   %edx
  800171:	50                   	push   %eax
  800172:	e8 18 19 00 00       	call   801a8f <tst>
  800177:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);
  80017a:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80017d:	e8 b7 15 00 00       	call   801739 <sys_calculate_free_frames>
  800182:	29 c3                	sub    %eax,%ebx
  800184:	89 d8                	mov    %ebx,%eax
  800186:	83 ec 0c             	sub    $0xc,%esp
  800189:	6a 00                	push   $0x0
  80018b:	6a 65                	push   $0x65
  80018d:	6a 00                	push   $0x0
  80018f:	6a 02                	push   $0x2
  800191:	50                   	push   %eax
  800192:	e8 f8 18 00 00       	call   801a8f <tst>
  800197:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80019a:	e8 9a 15 00 00       	call   801739 <sys_calculate_free_frames>
  80019f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8001a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001a5:	01 c0                	add    %eax,%eax
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	50                   	push   %eax
  8001ab:	e8 c7 11 00 00       	call   801377 <malloc>
  8001b0:	83 c4 10             	add    $0x10,%esp
  8001b3:	89 45 98             	mov    %eax,-0x68(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega + 4*kilo,USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE, 'b', 0);
  8001b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b9:	c1 e0 02             	shl    $0x2,%eax
  8001bc:	89 c2                	mov    %eax,%edx
  8001be:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001c1:	c1 e0 02             	shl    $0x2,%eax
  8001c4:	01 d0                	add    %edx,%eax
  8001c6:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001cf:	c1 e0 02             	shl    $0x2,%eax
  8001d2:	89 c2                	mov    %eax,%edx
  8001d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d7:	c1 e0 02             	shl    $0x2,%eax
  8001da:	01 d0                	add    %edx,%eax
  8001dc:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8001e2:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	6a 00                	push   $0x0
  8001ea:	6a 62                	push   $0x62
  8001ec:	51                   	push   %ecx
  8001ed:	52                   	push   %edx
  8001ee:	50                   	push   %eax
  8001ef:	e8 9b 18 00 00       	call   801a8f <tst>
  8001f4:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);
  8001f7:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8001fa:	e8 3a 15 00 00       	call   801739 <sys_calculate_free_frames>
  8001ff:	29 c3                	sub    %eax,%ebx
  800201:	89 d8                	mov    %ebx,%eax
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	6a 00                	push   $0x0
  800208:	6a 65                	push   $0x65
  80020a:	6a 00                	push   $0x0
  80020c:	6a 01                	push   $0x1
  80020e:	50                   	push   %eax
  80020f:	e8 7b 18 00 00       	call   801a8f <tst>
  800214:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800217:	e8 1d 15 00 00       	call   801739 <sys_calculate_free_frames>
  80021c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80021f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800222:	89 d0                	mov    %edx,%eax
  800224:	01 c0                	add    %eax,%eax
  800226:	01 d0                	add    %edx,%eax
  800228:	01 c0                	add    %eax,%eax
  80022a:	01 d0                	add    %edx,%eax
  80022c:	83 ec 0c             	sub    $0xc,%esp
  80022f:	50                   	push   %eax
  800230:	e8 42 11 00 00       	call   801377 <malloc>
  800235:	83 c4 10             	add    $0x10,%esp
  800238:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega + 8*kilo,USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE, 'b', 0);
  80023b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80023e:	c1 e0 02             	shl    $0x2,%eax
  800241:	89 c2                	mov    %eax,%edx
  800243:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800246:	c1 e0 03             	shl    $0x3,%eax
  800249:	01 d0                	add    %edx,%eax
  80024b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800251:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800254:	c1 e0 02             	shl    $0x2,%eax
  800257:	89 c2                	mov    %eax,%edx
  800259:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80025c:	c1 e0 03             	shl    $0x3,%eax
  80025f:	01 d0                	add    %edx,%eax
  800261:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800267:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	6a 00                	push   $0x0
  80026f:	6a 62                	push   $0x62
  800271:	51                   	push   %ecx
  800272:	52                   	push   %edx
  800273:	50                   	push   %eax
  800274:	e8 16 18 00 00       	call   801a8f <tst>
  800279:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 2 ,0, 'e', 0);
  80027c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80027f:	e8 b5 14 00 00       	call   801739 <sys_calculate_free_frames>
  800284:	29 c3                	sub    %eax,%ebx
  800286:	89 d8                	mov    %ebx,%eax
  800288:	83 ec 0c             	sub    $0xc,%esp
  80028b:	6a 00                	push   $0x0
  80028d:	6a 65                	push   $0x65
  80028f:	6a 00                	push   $0x0
  800291:	6a 02                	push   $0x2
  800293:	50                   	push   %eax
  800294:	e8 f6 17 00 00       	call   801a8f <tst>
  800299:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80029c:	e8 98 14 00 00       	call   801739 <sys_calculate_free_frames>
  8002a1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8002a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a7:	89 c2                	mov    %eax,%edx
  8002a9:	01 d2                	add    %edx,%edx
  8002ab:	01 d0                	add    %edx,%eax
  8002ad:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002b0:	83 ec 0c             	sub    $0xc,%esp
  8002b3:	50                   	push   %eax
  8002b4:	e8 be 10 00 00       	call   801377 <malloc>
  8002b9:	83 c4 10             	add    $0x10,%esp
  8002bc:	89 45 a0             	mov    %eax,-0x60(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega + 16*kilo,USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  8002bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002c2:	c1 e0 02             	shl    $0x2,%eax
  8002c5:	89 c2                	mov    %eax,%edx
  8002c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ca:	c1 e0 04             	shl    $0x4,%eax
  8002cd:	01 d0                	add    %edx,%eax
  8002cf:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002d8:	c1 e0 02             	shl    $0x2,%eax
  8002db:	89 c2                	mov    %eax,%edx
  8002dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e0:	c1 e0 04             	shl    $0x4,%eax
  8002e3:	01 d0                	add    %edx,%eax
  8002e5:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002eb:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8002ee:	83 ec 0c             	sub    $0xc,%esp
  8002f1:	6a 00                	push   $0x0
  8002f3:	6a 62                	push   $0x62
  8002f5:	51                   	push   %ecx
  8002f6:	52                   	push   %edx
  8002f7:	50                   	push   %eax
  8002f8:	e8 92 17 00 00       	call   801a8f <tst>
  8002fd:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);
  800300:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800303:	89 c2                	mov    %eax,%edx
  800305:	01 d2                	add    %edx,%edx
  800307:	01 d0                	add    %edx,%eax
  800309:	85 c0                	test   %eax,%eax
  80030b:	79 05                	jns    800312 <_main+0x2da>
  80030d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800312:	c1 f8 0c             	sar    $0xc,%eax
  800315:	89 c3                	mov    %eax,%ebx
  800317:	8b 75 dc             	mov    -0x24(%ebp),%esi
  80031a:	e8 1a 14 00 00       	call   801739 <sys_calculate_free_frames>
  80031f:	29 c6                	sub    %eax,%esi
  800321:	89 f0                	mov    %esi,%eax
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	6a 00                	push   $0x0
  800328:	6a 65                	push   $0x65
  80032a:	6a 00                	push   $0x0
  80032c:	53                   	push   %ebx
  80032d:	50                   	push   %eax
  80032e:	e8 5c 17 00 00       	call   801a8f <tst>
  800333:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800336:	e8 fe 13 00 00       	call   801739 <sys_calculate_free_frames>
  80033b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  80033e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800341:	01 c0                	add    %eax,%eax
  800343:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800346:	83 ec 0c             	sub    $0xc,%esp
  800349:	50                   	push   %eax
  80034a:	e8 28 10 00 00       	call   801377 <malloc>
  80034f:	83 c4 10             	add    $0x10,%esp
  800352:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega + 16*kilo,USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  800355:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800358:	89 d0                	mov    %edx,%eax
  80035a:	01 c0                	add    %eax,%eax
  80035c:	01 d0                	add    %edx,%eax
  80035e:	01 c0                	add    %eax,%eax
  800360:	01 d0                	add    %edx,%eax
  800362:	89 c2                	mov    %eax,%edx
  800364:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800367:	c1 e0 04             	shl    $0x4,%eax
  80036a:	01 d0                	add    %edx,%eax
  80036c:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800372:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800375:	89 d0                	mov    %edx,%eax
  800377:	01 c0                	add    %eax,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	01 c0                	add    %eax,%eax
  80037d:	01 d0                	add    %edx,%eax
  80037f:	89 c2                	mov    %eax,%edx
  800381:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800384:	c1 e0 04             	shl    $0x4,%eax
  800387:	01 d0                	add    %edx,%eax
  800389:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80038f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800392:	83 ec 0c             	sub    $0xc,%esp
  800395:	6a 00                	push   $0x0
  800397:	6a 62                	push   $0x62
  800399:	51                   	push   %ecx
  80039a:	52                   	push   %edx
  80039b:	50                   	push   %eax
  80039c:	e8 ee 16 00 00       	call   801a8f <tst>
  8003a1:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8003a4:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8003a7:	e8 8d 13 00 00       	call   801739 <sys_calculate_free_frames>
  8003ac:	29 c3                	sub    %eax,%ebx
  8003ae:	89 d8                	mov    %ebx,%eax
  8003b0:	83 ec 0c             	sub    $0xc,%esp
  8003b3:	6a 00                	push   $0x0
  8003b5:	6a 65                	push   $0x65
  8003b7:	6a 00                	push   $0x0
  8003b9:	68 01 02 00 00       	push   $0x201
  8003be:	50                   	push   %eax
  8003bf:	e8 cb 16 00 00       	call   801a8f <tst>
  8003c4:	83 c4 20             	add    $0x20,%esp
	}

	chktst(14);
  8003c7:	83 ec 0c             	sub    $0xc,%esp
  8003ca:	6a 0e                	push   $0xe
  8003cc:	e8 e9 16 00 00       	call   801aba <chktst>
  8003d1:	83 c4 10             	add    $0x10,%esp

	return;
  8003d4:	90                   	nop
}
  8003d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003d8:	5b                   	pop    %ebx
  8003d9:	5e                   	pop    %esi
  8003da:	5f                   	pop    %edi
  8003db:	5d                   	pop    %ebp
  8003dc:	c3                   	ret    

008003dd <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003dd:	55                   	push   %ebp
  8003de:	89 e5                	mov    %esp,%ebp
  8003e0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003e3:	e8 86 12 00 00       	call   80166e <sys_getenvindex>
  8003e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003ee:	89 d0                	mov    %edx,%eax
  8003f0:	01 c0                	add    %eax,%eax
  8003f2:	01 d0                	add    %edx,%eax
  8003f4:	c1 e0 02             	shl    $0x2,%eax
  8003f7:	01 d0                	add    %edx,%eax
  8003f9:	c1 e0 06             	shl    $0x6,%eax
  8003fc:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800401:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800406:	a1 20 30 80 00       	mov    0x803020,%eax
  80040b:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800411:	84 c0                	test   %al,%al
  800413:	74 0f                	je     800424 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800415:	a1 20 30 80 00       	mov    0x803020,%eax
  80041a:	05 f4 02 00 00       	add    $0x2f4,%eax
  80041f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800424:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800428:	7e 0a                	jle    800434 <libmain+0x57>
		binaryname = argv[0];
  80042a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800434:	83 ec 08             	sub    $0x8,%esp
  800437:	ff 75 0c             	pushl  0xc(%ebp)
  80043a:	ff 75 08             	pushl  0x8(%ebp)
  80043d:	e8 f6 fb ff ff       	call   800038 <_main>
  800442:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800445:	e8 bf 13 00 00       	call   801809 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80044a:	83 ec 0c             	sub    $0xc,%esp
  80044d:	68 58 20 80 00       	push   $0x802058
  800452:	e8 5c 01 00 00       	call   8005b3 <cprintf>
  800457:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80045a:	a1 20 30 80 00       	mov    0x803020,%eax
  80045f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800465:	a1 20 30 80 00       	mov    0x803020,%eax
  80046a:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800470:	83 ec 04             	sub    $0x4,%esp
  800473:	52                   	push   %edx
  800474:	50                   	push   %eax
  800475:	68 80 20 80 00       	push   $0x802080
  80047a:	e8 34 01 00 00       	call   8005b3 <cprintf>
  80047f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800482:	a1 20 30 80 00       	mov    0x803020,%eax
  800487:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80048d:	83 ec 08             	sub    $0x8,%esp
  800490:	50                   	push   %eax
  800491:	68 a5 20 80 00       	push   $0x8020a5
  800496:	e8 18 01 00 00       	call   8005b3 <cprintf>
  80049b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80049e:	83 ec 0c             	sub    $0xc,%esp
  8004a1:	68 58 20 80 00       	push   $0x802058
  8004a6:	e8 08 01 00 00       	call   8005b3 <cprintf>
  8004ab:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004ae:	e8 70 13 00 00       	call   801823 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004b3:	e8 19 00 00 00       	call   8004d1 <exit>
}
  8004b8:	90                   	nop
  8004b9:	c9                   	leave  
  8004ba:	c3                   	ret    

008004bb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004bb:	55                   	push   %ebp
  8004bc:	89 e5                	mov    %esp,%ebp
  8004be:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004c1:	83 ec 0c             	sub    $0xc,%esp
  8004c4:	6a 00                	push   $0x0
  8004c6:	e8 6f 11 00 00       	call   80163a <sys_env_destroy>
  8004cb:	83 c4 10             	add    $0x10,%esp
}
  8004ce:	90                   	nop
  8004cf:	c9                   	leave  
  8004d0:	c3                   	ret    

008004d1 <exit>:

void
exit(void)
{
  8004d1:	55                   	push   %ebp
  8004d2:	89 e5                	mov    %esp,%ebp
  8004d4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004d7:	e8 c4 11 00 00       	call   8016a0 <sys_env_exit>
}
  8004dc:	90                   	nop
  8004dd:	c9                   	leave  
  8004de:	c3                   	ret    

008004df <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004df:	55                   	push   %ebp
  8004e0:	89 e5                	mov    %esp,%ebp
  8004e2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e8:	8b 00                	mov    (%eax),%eax
  8004ea:	8d 48 01             	lea    0x1(%eax),%ecx
  8004ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f0:	89 0a                	mov    %ecx,(%edx)
  8004f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8004f5:	88 d1                	mov    %dl,%cl
  8004f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800501:	8b 00                	mov    (%eax),%eax
  800503:	3d ff 00 00 00       	cmp    $0xff,%eax
  800508:	75 2c                	jne    800536 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80050a:	a0 24 30 80 00       	mov    0x803024,%al
  80050f:	0f b6 c0             	movzbl %al,%eax
  800512:	8b 55 0c             	mov    0xc(%ebp),%edx
  800515:	8b 12                	mov    (%edx),%edx
  800517:	89 d1                	mov    %edx,%ecx
  800519:	8b 55 0c             	mov    0xc(%ebp),%edx
  80051c:	83 c2 08             	add    $0x8,%edx
  80051f:	83 ec 04             	sub    $0x4,%esp
  800522:	50                   	push   %eax
  800523:	51                   	push   %ecx
  800524:	52                   	push   %edx
  800525:	e8 ce 10 00 00       	call   8015f8 <sys_cputs>
  80052a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80052d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800530:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800536:	8b 45 0c             	mov    0xc(%ebp),%eax
  800539:	8b 40 04             	mov    0x4(%eax),%eax
  80053c:	8d 50 01             	lea    0x1(%eax),%edx
  80053f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800542:	89 50 04             	mov    %edx,0x4(%eax)
}
  800545:	90                   	nop
  800546:	c9                   	leave  
  800547:	c3                   	ret    

00800548 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800548:	55                   	push   %ebp
  800549:	89 e5                	mov    %esp,%ebp
  80054b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800551:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800558:	00 00 00 
	b.cnt = 0;
  80055b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800562:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800565:	ff 75 0c             	pushl  0xc(%ebp)
  800568:	ff 75 08             	pushl  0x8(%ebp)
  80056b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800571:	50                   	push   %eax
  800572:	68 df 04 80 00       	push   $0x8004df
  800577:	e8 11 02 00 00       	call   80078d <vprintfmt>
  80057c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80057f:	a0 24 30 80 00       	mov    0x803024,%al
  800584:	0f b6 c0             	movzbl %al,%eax
  800587:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80058d:	83 ec 04             	sub    $0x4,%esp
  800590:	50                   	push   %eax
  800591:	52                   	push   %edx
  800592:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800598:	83 c0 08             	add    $0x8,%eax
  80059b:	50                   	push   %eax
  80059c:	e8 57 10 00 00       	call   8015f8 <sys_cputs>
  8005a1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005a4:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005ab:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005b1:	c9                   	leave  
  8005b2:	c3                   	ret    

008005b3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005b3:	55                   	push   %ebp
  8005b4:	89 e5                	mov    %esp,%ebp
  8005b6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005b9:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005c0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c9:	83 ec 08             	sub    $0x8,%esp
  8005cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8005cf:	50                   	push   %eax
  8005d0:	e8 73 ff ff ff       	call   800548 <vcprintf>
  8005d5:	83 c4 10             	add    $0x10,%esp
  8005d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005de:	c9                   	leave  
  8005df:	c3                   	ret    

008005e0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005e0:	55                   	push   %ebp
  8005e1:	89 e5                	mov    %esp,%ebp
  8005e3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005e6:	e8 1e 12 00 00       	call   801809 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005eb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f4:	83 ec 08             	sub    $0x8,%esp
  8005f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8005fa:	50                   	push   %eax
  8005fb:	e8 48 ff ff ff       	call   800548 <vcprintf>
  800600:	83 c4 10             	add    $0x10,%esp
  800603:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800606:	e8 18 12 00 00       	call   801823 <sys_enable_interrupt>
	return cnt;
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80060e:	c9                   	leave  
  80060f:	c3                   	ret    

00800610 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800610:	55                   	push   %ebp
  800611:	89 e5                	mov    %esp,%ebp
  800613:	53                   	push   %ebx
  800614:	83 ec 14             	sub    $0x14,%esp
  800617:	8b 45 10             	mov    0x10(%ebp),%eax
  80061a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80061d:	8b 45 14             	mov    0x14(%ebp),%eax
  800620:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800623:	8b 45 18             	mov    0x18(%ebp),%eax
  800626:	ba 00 00 00 00       	mov    $0x0,%edx
  80062b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80062e:	77 55                	ja     800685 <printnum+0x75>
  800630:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800633:	72 05                	jb     80063a <printnum+0x2a>
  800635:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800638:	77 4b                	ja     800685 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80063a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80063d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800640:	8b 45 18             	mov    0x18(%ebp),%eax
  800643:	ba 00 00 00 00       	mov    $0x0,%edx
  800648:	52                   	push   %edx
  800649:	50                   	push   %eax
  80064a:	ff 75 f4             	pushl  -0xc(%ebp)
  80064d:	ff 75 f0             	pushl  -0x10(%ebp)
  800650:	e8 73 17 00 00       	call   801dc8 <__udivdi3>
  800655:	83 c4 10             	add    $0x10,%esp
  800658:	83 ec 04             	sub    $0x4,%esp
  80065b:	ff 75 20             	pushl  0x20(%ebp)
  80065e:	53                   	push   %ebx
  80065f:	ff 75 18             	pushl  0x18(%ebp)
  800662:	52                   	push   %edx
  800663:	50                   	push   %eax
  800664:	ff 75 0c             	pushl  0xc(%ebp)
  800667:	ff 75 08             	pushl  0x8(%ebp)
  80066a:	e8 a1 ff ff ff       	call   800610 <printnum>
  80066f:	83 c4 20             	add    $0x20,%esp
  800672:	eb 1a                	jmp    80068e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800674:	83 ec 08             	sub    $0x8,%esp
  800677:	ff 75 0c             	pushl  0xc(%ebp)
  80067a:	ff 75 20             	pushl  0x20(%ebp)
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	ff d0                	call   *%eax
  800682:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800685:	ff 4d 1c             	decl   0x1c(%ebp)
  800688:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80068c:	7f e6                	jg     800674 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80068e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800691:	bb 00 00 00 00       	mov    $0x0,%ebx
  800696:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800699:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80069c:	53                   	push   %ebx
  80069d:	51                   	push   %ecx
  80069e:	52                   	push   %edx
  80069f:	50                   	push   %eax
  8006a0:	e8 33 18 00 00       	call   801ed8 <__umoddi3>
  8006a5:	83 c4 10             	add    $0x10,%esp
  8006a8:	05 d4 22 80 00       	add    $0x8022d4,%eax
  8006ad:	8a 00                	mov    (%eax),%al
  8006af:	0f be c0             	movsbl %al,%eax
  8006b2:	83 ec 08             	sub    $0x8,%esp
  8006b5:	ff 75 0c             	pushl  0xc(%ebp)
  8006b8:	50                   	push   %eax
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	ff d0                	call   *%eax
  8006be:	83 c4 10             	add    $0x10,%esp
}
  8006c1:	90                   	nop
  8006c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006c5:	c9                   	leave  
  8006c6:	c3                   	ret    

008006c7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006c7:	55                   	push   %ebp
  8006c8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ce:	7e 1c                	jle    8006ec <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d3:	8b 00                	mov    (%eax),%eax
  8006d5:	8d 50 08             	lea    0x8(%eax),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	89 10                	mov    %edx,(%eax)
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	8b 00                	mov    (%eax),%eax
  8006e2:	83 e8 08             	sub    $0x8,%eax
  8006e5:	8b 50 04             	mov    0x4(%eax),%edx
  8006e8:	8b 00                	mov    (%eax),%eax
  8006ea:	eb 40                	jmp    80072c <getuint+0x65>
	else if (lflag)
  8006ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006f0:	74 1e                	je     800710 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	8b 00                	mov    (%eax),%eax
  8006f7:	8d 50 04             	lea    0x4(%eax),%edx
  8006fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fd:	89 10                	mov    %edx,(%eax)
  8006ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800702:	8b 00                	mov    (%eax),%eax
  800704:	83 e8 04             	sub    $0x4,%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	ba 00 00 00 00       	mov    $0x0,%edx
  80070e:	eb 1c                	jmp    80072c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800710:	8b 45 08             	mov    0x8(%ebp),%eax
  800713:	8b 00                	mov    (%eax),%eax
  800715:	8d 50 04             	lea    0x4(%eax),%edx
  800718:	8b 45 08             	mov    0x8(%ebp),%eax
  80071b:	89 10                	mov    %edx,(%eax)
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	8b 00                	mov    (%eax),%eax
  800722:	83 e8 04             	sub    $0x4,%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80072c:	5d                   	pop    %ebp
  80072d:	c3                   	ret    

0080072e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80072e:	55                   	push   %ebp
  80072f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800731:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800735:	7e 1c                	jle    800753 <getint+0x25>
		return va_arg(*ap, long long);
  800737:	8b 45 08             	mov    0x8(%ebp),%eax
  80073a:	8b 00                	mov    (%eax),%eax
  80073c:	8d 50 08             	lea    0x8(%eax),%edx
  80073f:	8b 45 08             	mov    0x8(%ebp),%eax
  800742:	89 10                	mov    %edx,(%eax)
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	8b 00                	mov    (%eax),%eax
  800749:	83 e8 08             	sub    $0x8,%eax
  80074c:	8b 50 04             	mov    0x4(%eax),%edx
  80074f:	8b 00                	mov    (%eax),%eax
  800751:	eb 38                	jmp    80078b <getint+0x5d>
	else if (lflag)
  800753:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800757:	74 1a                	je     800773 <getint+0x45>
		return va_arg(*ap, long);
  800759:	8b 45 08             	mov    0x8(%ebp),%eax
  80075c:	8b 00                	mov    (%eax),%eax
  80075e:	8d 50 04             	lea    0x4(%eax),%edx
  800761:	8b 45 08             	mov    0x8(%ebp),%eax
  800764:	89 10                	mov    %edx,(%eax)
  800766:	8b 45 08             	mov    0x8(%ebp),%eax
  800769:	8b 00                	mov    (%eax),%eax
  80076b:	83 e8 04             	sub    $0x4,%eax
  80076e:	8b 00                	mov    (%eax),%eax
  800770:	99                   	cltd   
  800771:	eb 18                	jmp    80078b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	8b 00                	mov    (%eax),%eax
  800778:	8d 50 04             	lea    0x4(%eax),%edx
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	89 10                	mov    %edx,(%eax)
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	83 e8 04             	sub    $0x4,%eax
  800788:	8b 00                	mov    (%eax),%eax
  80078a:	99                   	cltd   
}
  80078b:	5d                   	pop    %ebp
  80078c:	c3                   	ret    

0080078d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80078d:	55                   	push   %ebp
  80078e:	89 e5                	mov    %esp,%ebp
  800790:	56                   	push   %esi
  800791:	53                   	push   %ebx
  800792:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800795:	eb 17                	jmp    8007ae <vprintfmt+0x21>
			if (ch == '\0')
  800797:	85 db                	test   %ebx,%ebx
  800799:	0f 84 af 03 00 00    	je     800b4e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80079f:	83 ec 08             	sub    $0x8,%esp
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	53                   	push   %ebx
  8007a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a9:	ff d0                	call   *%eax
  8007ab:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b1:	8d 50 01             	lea    0x1(%eax),%edx
  8007b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8007b7:	8a 00                	mov    (%eax),%al
  8007b9:	0f b6 d8             	movzbl %al,%ebx
  8007bc:	83 fb 25             	cmp    $0x25,%ebx
  8007bf:	75 d6                	jne    800797 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007c1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007c5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007cc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007d3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007e4:	8d 50 01             	lea    0x1(%eax),%edx
  8007e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8007ea:	8a 00                	mov    (%eax),%al
  8007ec:	0f b6 d8             	movzbl %al,%ebx
  8007ef:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007f2:	83 f8 55             	cmp    $0x55,%eax
  8007f5:	0f 87 2b 03 00 00    	ja     800b26 <vprintfmt+0x399>
  8007fb:	8b 04 85 f8 22 80 00 	mov    0x8022f8(,%eax,4),%eax
  800802:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800804:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800808:	eb d7                	jmp    8007e1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80080a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80080e:	eb d1                	jmp    8007e1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800810:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800817:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80081a:	89 d0                	mov    %edx,%eax
  80081c:	c1 e0 02             	shl    $0x2,%eax
  80081f:	01 d0                	add    %edx,%eax
  800821:	01 c0                	add    %eax,%eax
  800823:	01 d8                	add    %ebx,%eax
  800825:	83 e8 30             	sub    $0x30,%eax
  800828:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80082b:	8b 45 10             	mov    0x10(%ebp),%eax
  80082e:	8a 00                	mov    (%eax),%al
  800830:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800833:	83 fb 2f             	cmp    $0x2f,%ebx
  800836:	7e 3e                	jle    800876 <vprintfmt+0xe9>
  800838:	83 fb 39             	cmp    $0x39,%ebx
  80083b:	7f 39                	jg     800876 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80083d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800840:	eb d5                	jmp    800817 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800842:	8b 45 14             	mov    0x14(%ebp),%eax
  800845:	83 c0 04             	add    $0x4,%eax
  800848:	89 45 14             	mov    %eax,0x14(%ebp)
  80084b:	8b 45 14             	mov    0x14(%ebp),%eax
  80084e:	83 e8 04             	sub    $0x4,%eax
  800851:	8b 00                	mov    (%eax),%eax
  800853:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800856:	eb 1f                	jmp    800877 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800858:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80085c:	79 83                	jns    8007e1 <vprintfmt+0x54>
				width = 0;
  80085e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800865:	e9 77 ff ff ff       	jmp    8007e1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80086a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800871:	e9 6b ff ff ff       	jmp    8007e1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800876:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800877:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80087b:	0f 89 60 ff ff ff    	jns    8007e1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800881:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800884:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800887:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80088e:	e9 4e ff ff ff       	jmp    8007e1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800893:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800896:	e9 46 ff ff ff       	jmp    8007e1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80089b:	8b 45 14             	mov    0x14(%ebp),%eax
  80089e:	83 c0 04             	add    $0x4,%eax
  8008a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a7:	83 e8 04             	sub    $0x4,%eax
  8008aa:	8b 00                	mov    (%eax),%eax
  8008ac:	83 ec 08             	sub    $0x8,%esp
  8008af:	ff 75 0c             	pushl  0xc(%ebp)
  8008b2:	50                   	push   %eax
  8008b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b6:	ff d0                	call   *%eax
  8008b8:	83 c4 10             	add    $0x10,%esp
			break;
  8008bb:	e9 89 02 00 00       	jmp    800b49 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c3:	83 c0 04             	add    $0x4,%eax
  8008c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008cc:	83 e8 04             	sub    $0x4,%eax
  8008cf:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008d1:	85 db                	test   %ebx,%ebx
  8008d3:	79 02                	jns    8008d7 <vprintfmt+0x14a>
				err = -err;
  8008d5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008d7:	83 fb 64             	cmp    $0x64,%ebx
  8008da:	7f 0b                	jg     8008e7 <vprintfmt+0x15a>
  8008dc:	8b 34 9d 40 21 80 00 	mov    0x802140(,%ebx,4),%esi
  8008e3:	85 f6                	test   %esi,%esi
  8008e5:	75 19                	jne    800900 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008e7:	53                   	push   %ebx
  8008e8:	68 e5 22 80 00       	push   $0x8022e5
  8008ed:	ff 75 0c             	pushl  0xc(%ebp)
  8008f0:	ff 75 08             	pushl  0x8(%ebp)
  8008f3:	e8 5e 02 00 00       	call   800b56 <printfmt>
  8008f8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008fb:	e9 49 02 00 00       	jmp    800b49 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800900:	56                   	push   %esi
  800901:	68 ee 22 80 00       	push   $0x8022ee
  800906:	ff 75 0c             	pushl  0xc(%ebp)
  800909:	ff 75 08             	pushl  0x8(%ebp)
  80090c:	e8 45 02 00 00       	call   800b56 <printfmt>
  800911:	83 c4 10             	add    $0x10,%esp
			break;
  800914:	e9 30 02 00 00       	jmp    800b49 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800919:	8b 45 14             	mov    0x14(%ebp),%eax
  80091c:	83 c0 04             	add    $0x4,%eax
  80091f:	89 45 14             	mov    %eax,0x14(%ebp)
  800922:	8b 45 14             	mov    0x14(%ebp),%eax
  800925:	83 e8 04             	sub    $0x4,%eax
  800928:	8b 30                	mov    (%eax),%esi
  80092a:	85 f6                	test   %esi,%esi
  80092c:	75 05                	jne    800933 <vprintfmt+0x1a6>
				p = "(null)";
  80092e:	be f1 22 80 00       	mov    $0x8022f1,%esi
			if (width > 0 && padc != '-')
  800933:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800937:	7e 6d                	jle    8009a6 <vprintfmt+0x219>
  800939:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80093d:	74 67                	je     8009a6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80093f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800942:	83 ec 08             	sub    $0x8,%esp
  800945:	50                   	push   %eax
  800946:	56                   	push   %esi
  800947:	e8 0c 03 00 00       	call   800c58 <strnlen>
  80094c:	83 c4 10             	add    $0x10,%esp
  80094f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800952:	eb 16                	jmp    80096a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800954:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800958:	83 ec 08             	sub    $0x8,%esp
  80095b:	ff 75 0c             	pushl  0xc(%ebp)
  80095e:	50                   	push   %eax
  80095f:	8b 45 08             	mov    0x8(%ebp),%eax
  800962:	ff d0                	call   *%eax
  800964:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800967:	ff 4d e4             	decl   -0x1c(%ebp)
  80096a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80096e:	7f e4                	jg     800954 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800970:	eb 34                	jmp    8009a6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800972:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800976:	74 1c                	je     800994 <vprintfmt+0x207>
  800978:	83 fb 1f             	cmp    $0x1f,%ebx
  80097b:	7e 05                	jle    800982 <vprintfmt+0x1f5>
  80097d:	83 fb 7e             	cmp    $0x7e,%ebx
  800980:	7e 12                	jle    800994 <vprintfmt+0x207>
					putch('?', putdat);
  800982:	83 ec 08             	sub    $0x8,%esp
  800985:	ff 75 0c             	pushl  0xc(%ebp)
  800988:	6a 3f                	push   $0x3f
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	ff d0                	call   *%eax
  80098f:	83 c4 10             	add    $0x10,%esp
  800992:	eb 0f                	jmp    8009a3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 0c             	pushl  0xc(%ebp)
  80099a:	53                   	push   %ebx
  80099b:	8b 45 08             	mov    0x8(%ebp),%eax
  80099e:	ff d0                	call   *%eax
  8009a0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009a3:	ff 4d e4             	decl   -0x1c(%ebp)
  8009a6:	89 f0                	mov    %esi,%eax
  8009a8:	8d 70 01             	lea    0x1(%eax),%esi
  8009ab:	8a 00                	mov    (%eax),%al
  8009ad:	0f be d8             	movsbl %al,%ebx
  8009b0:	85 db                	test   %ebx,%ebx
  8009b2:	74 24                	je     8009d8 <vprintfmt+0x24b>
  8009b4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009b8:	78 b8                	js     800972 <vprintfmt+0x1e5>
  8009ba:	ff 4d e0             	decl   -0x20(%ebp)
  8009bd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009c1:	79 af                	jns    800972 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009c3:	eb 13                	jmp    8009d8 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009c5:	83 ec 08             	sub    $0x8,%esp
  8009c8:	ff 75 0c             	pushl  0xc(%ebp)
  8009cb:	6a 20                	push   $0x20
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	ff d0                	call   *%eax
  8009d2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009d5:	ff 4d e4             	decl   -0x1c(%ebp)
  8009d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009dc:	7f e7                	jg     8009c5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009de:	e9 66 01 00 00       	jmp    800b49 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009e3:	83 ec 08             	sub    $0x8,%esp
  8009e6:	ff 75 e8             	pushl  -0x18(%ebp)
  8009e9:	8d 45 14             	lea    0x14(%ebp),%eax
  8009ec:	50                   	push   %eax
  8009ed:	e8 3c fd ff ff       	call   80072e <getint>
  8009f2:	83 c4 10             	add    $0x10,%esp
  8009f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a01:	85 d2                	test   %edx,%edx
  800a03:	79 23                	jns    800a28 <vprintfmt+0x29b>
				putch('-', putdat);
  800a05:	83 ec 08             	sub    $0x8,%esp
  800a08:	ff 75 0c             	pushl  0xc(%ebp)
  800a0b:	6a 2d                	push   $0x2d
  800a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a10:	ff d0                	call   *%eax
  800a12:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a18:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a1b:	f7 d8                	neg    %eax
  800a1d:	83 d2 00             	adc    $0x0,%edx
  800a20:	f7 da                	neg    %edx
  800a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a25:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a28:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a2f:	e9 bc 00 00 00       	jmp    800af0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 e8             	pushl  -0x18(%ebp)
  800a3a:	8d 45 14             	lea    0x14(%ebp),%eax
  800a3d:	50                   	push   %eax
  800a3e:	e8 84 fc ff ff       	call   8006c7 <getuint>
  800a43:	83 c4 10             	add    $0x10,%esp
  800a46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a49:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a4c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a53:	e9 98 00 00 00       	jmp    800af0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 0c             	pushl  0xc(%ebp)
  800a5e:	6a 58                	push   $0x58
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	ff d0                	call   *%eax
  800a65:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a68:	83 ec 08             	sub    $0x8,%esp
  800a6b:	ff 75 0c             	pushl  0xc(%ebp)
  800a6e:	6a 58                	push   $0x58
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	ff d0                	call   *%eax
  800a75:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a78:	83 ec 08             	sub    $0x8,%esp
  800a7b:	ff 75 0c             	pushl  0xc(%ebp)
  800a7e:	6a 58                	push   $0x58
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	ff d0                	call   *%eax
  800a85:	83 c4 10             	add    $0x10,%esp
			break;
  800a88:	e9 bc 00 00 00       	jmp    800b49 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 0c             	pushl  0xc(%ebp)
  800a93:	6a 30                	push   $0x30
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	ff d0                	call   *%eax
  800a9a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a9d:	83 ec 08             	sub    $0x8,%esp
  800aa0:	ff 75 0c             	pushl  0xc(%ebp)
  800aa3:	6a 78                	push   $0x78
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	ff d0                	call   *%eax
  800aaa:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800aad:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab0:	83 c0 04             	add    $0x4,%eax
  800ab3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ab6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab9:	83 e8 04             	sub    $0x4,%eax
  800abc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800abe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ac8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800acf:	eb 1f                	jmp    800af0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ad1:	83 ec 08             	sub    $0x8,%esp
  800ad4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ad7:	8d 45 14             	lea    0x14(%ebp),%eax
  800ada:	50                   	push   %eax
  800adb:	e8 e7 fb ff ff       	call   8006c7 <getuint>
  800ae0:	83 c4 10             	add    $0x10,%esp
  800ae3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ae9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800af0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800af4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800af7:	83 ec 04             	sub    $0x4,%esp
  800afa:	52                   	push   %edx
  800afb:	ff 75 e4             	pushl  -0x1c(%ebp)
  800afe:	50                   	push   %eax
  800aff:	ff 75 f4             	pushl  -0xc(%ebp)
  800b02:	ff 75 f0             	pushl  -0x10(%ebp)
  800b05:	ff 75 0c             	pushl  0xc(%ebp)
  800b08:	ff 75 08             	pushl  0x8(%ebp)
  800b0b:	e8 00 fb ff ff       	call   800610 <printnum>
  800b10:	83 c4 20             	add    $0x20,%esp
			break;
  800b13:	eb 34                	jmp    800b49 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	53                   	push   %ebx
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	ff d0                	call   *%eax
  800b21:	83 c4 10             	add    $0x10,%esp
			break;
  800b24:	eb 23                	jmp    800b49 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b26:	83 ec 08             	sub    $0x8,%esp
  800b29:	ff 75 0c             	pushl  0xc(%ebp)
  800b2c:	6a 25                	push   $0x25
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	ff d0                	call   *%eax
  800b33:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b36:	ff 4d 10             	decl   0x10(%ebp)
  800b39:	eb 03                	jmp    800b3e <vprintfmt+0x3b1>
  800b3b:	ff 4d 10             	decl   0x10(%ebp)
  800b3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b41:	48                   	dec    %eax
  800b42:	8a 00                	mov    (%eax),%al
  800b44:	3c 25                	cmp    $0x25,%al
  800b46:	75 f3                	jne    800b3b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b48:	90                   	nop
		}
	}
  800b49:	e9 47 fc ff ff       	jmp    800795 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b4e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b52:	5b                   	pop    %ebx
  800b53:	5e                   	pop    %esi
  800b54:	5d                   	pop    %ebp
  800b55:	c3                   	ret    

00800b56 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b56:	55                   	push   %ebp
  800b57:	89 e5                	mov    %esp,%ebp
  800b59:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b5c:	8d 45 10             	lea    0x10(%ebp),%eax
  800b5f:	83 c0 04             	add    $0x4,%eax
  800b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b65:	8b 45 10             	mov    0x10(%ebp),%eax
  800b68:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6b:	50                   	push   %eax
  800b6c:	ff 75 0c             	pushl  0xc(%ebp)
  800b6f:	ff 75 08             	pushl  0x8(%ebp)
  800b72:	e8 16 fc ff ff       	call   80078d <vprintfmt>
  800b77:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b7a:	90                   	nop
  800b7b:	c9                   	leave  
  800b7c:	c3                   	ret    

00800b7d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b7d:	55                   	push   %ebp
  800b7e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b83:	8b 40 08             	mov    0x8(%eax),%eax
  800b86:	8d 50 01             	lea    0x1(%eax),%edx
  800b89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b92:	8b 10                	mov    (%eax),%edx
  800b94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b97:	8b 40 04             	mov    0x4(%eax),%eax
  800b9a:	39 c2                	cmp    %eax,%edx
  800b9c:	73 12                	jae    800bb0 <sprintputch+0x33>
		*b->buf++ = ch;
  800b9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba1:	8b 00                	mov    (%eax),%eax
  800ba3:	8d 48 01             	lea    0x1(%eax),%ecx
  800ba6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba9:	89 0a                	mov    %ecx,(%edx)
  800bab:	8b 55 08             	mov    0x8(%ebp),%edx
  800bae:	88 10                	mov    %dl,(%eax)
}
  800bb0:	90                   	nop
  800bb1:	5d                   	pop    %ebp
  800bb2:	c3                   	ret    

00800bb3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bb3:	55                   	push   %ebp
  800bb4:	89 e5                	mov    %esp,%ebp
  800bb6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	01 d0                	add    %edx,%eax
  800bca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bcd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bd4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bd8:	74 06                	je     800be0 <vsnprintf+0x2d>
  800bda:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bde:	7f 07                	jg     800be7 <vsnprintf+0x34>
		return -E_INVAL;
  800be0:	b8 03 00 00 00       	mov    $0x3,%eax
  800be5:	eb 20                	jmp    800c07 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800be7:	ff 75 14             	pushl  0x14(%ebp)
  800bea:	ff 75 10             	pushl  0x10(%ebp)
  800bed:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bf0:	50                   	push   %eax
  800bf1:	68 7d 0b 80 00       	push   $0x800b7d
  800bf6:	e8 92 fb ff ff       	call   80078d <vprintfmt>
  800bfb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c01:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c07:	c9                   	leave  
  800c08:	c3                   	ret    

00800c09 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
  800c0c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c0f:	8d 45 10             	lea    0x10(%ebp),%eax
  800c12:	83 c0 04             	add    $0x4,%eax
  800c15:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c18:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c1e:	50                   	push   %eax
  800c1f:	ff 75 0c             	pushl  0xc(%ebp)
  800c22:	ff 75 08             	pushl  0x8(%ebp)
  800c25:	e8 89 ff ff ff       	call   800bb3 <vsnprintf>
  800c2a:	83 c4 10             	add    $0x10,%esp
  800c2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c30:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c33:	c9                   	leave  
  800c34:	c3                   	ret    

00800c35 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c35:	55                   	push   %ebp
  800c36:	89 e5                	mov    %esp,%ebp
  800c38:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c42:	eb 06                	jmp    800c4a <strlen+0x15>
		n++;
  800c44:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c47:	ff 45 08             	incl   0x8(%ebp)
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	8a 00                	mov    (%eax),%al
  800c4f:	84 c0                	test   %al,%al
  800c51:	75 f1                	jne    800c44 <strlen+0xf>
		n++;
	return n;
  800c53:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c56:	c9                   	leave  
  800c57:	c3                   	ret    

00800c58 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c58:	55                   	push   %ebp
  800c59:	89 e5                	mov    %esp,%ebp
  800c5b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c65:	eb 09                	jmp    800c70 <strnlen+0x18>
		n++;
  800c67:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c6a:	ff 45 08             	incl   0x8(%ebp)
  800c6d:	ff 4d 0c             	decl   0xc(%ebp)
  800c70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c74:	74 09                	je     800c7f <strnlen+0x27>
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	8a 00                	mov    (%eax),%al
  800c7b:	84 c0                	test   %al,%al
  800c7d:	75 e8                	jne    800c67 <strnlen+0xf>
		n++;
	return n;
  800c7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c82:	c9                   	leave  
  800c83:	c3                   	ret    

00800c84 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c84:	55                   	push   %ebp
  800c85:	89 e5                	mov    %esp,%ebp
  800c87:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c90:	90                   	nop
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8d 50 01             	lea    0x1(%eax),%edx
  800c97:	89 55 08             	mov    %edx,0x8(%ebp)
  800c9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c9d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ca0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ca3:	8a 12                	mov    (%edx),%dl
  800ca5:	88 10                	mov    %dl,(%eax)
  800ca7:	8a 00                	mov    (%eax),%al
  800ca9:	84 c0                	test   %al,%al
  800cab:	75 e4                	jne    800c91 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cb0:	c9                   	leave  
  800cb1:	c3                   	ret    

00800cb2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cb2:	55                   	push   %ebp
  800cb3:	89 e5                	mov    %esp,%ebp
  800cb5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cbe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cc5:	eb 1f                	jmp    800ce6 <strncpy+0x34>
		*dst++ = *src;
  800cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cca:	8d 50 01             	lea    0x1(%eax),%edx
  800ccd:	89 55 08             	mov    %edx,0x8(%ebp)
  800cd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd3:	8a 12                	mov    (%edx),%dl
  800cd5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	84 c0                	test   %al,%al
  800cde:	74 03                	je     800ce3 <strncpy+0x31>
			src++;
  800ce0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ce3:	ff 45 fc             	incl   -0x4(%ebp)
  800ce6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ce9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cec:	72 d9                	jb     800cc7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cee:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cf1:	c9                   	leave  
  800cf2:	c3                   	ret    

00800cf3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cf3:	55                   	push   %ebp
  800cf4:	89 e5                	mov    %esp,%ebp
  800cf6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d03:	74 30                	je     800d35 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d05:	eb 16                	jmp    800d1d <strlcpy+0x2a>
			*dst++ = *src++;
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8d 50 01             	lea    0x1(%eax),%edx
  800d0d:	89 55 08             	mov    %edx,0x8(%ebp)
  800d10:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d13:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d16:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d19:	8a 12                	mov    (%edx),%dl
  800d1b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d1d:	ff 4d 10             	decl   0x10(%ebp)
  800d20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d24:	74 09                	je     800d2f <strlcpy+0x3c>
  800d26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	84 c0                	test   %al,%al
  800d2d:	75 d8                	jne    800d07 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d35:	8b 55 08             	mov    0x8(%ebp),%edx
  800d38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d3b:	29 c2                	sub    %eax,%edx
  800d3d:	89 d0                	mov    %edx,%eax
}
  800d3f:	c9                   	leave  
  800d40:	c3                   	ret    

00800d41 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d44:	eb 06                	jmp    800d4c <strcmp+0xb>
		p++, q++;
  800d46:	ff 45 08             	incl   0x8(%ebp)
  800d49:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	84 c0                	test   %al,%al
  800d53:	74 0e                	je     800d63 <strcmp+0x22>
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 10                	mov    (%eax),%dl
  800d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5d:	8a 00                	mov    (%eax),%al
  800d5f:	38 c2                	cmp    %al,%dl
  800d61:	74 e3                	je     800d46 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	8a 00                	mov    (%eax),%al
  800d68:	0f b6 d0             	movzbl %al,%edx
  800d6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6e:	8a 00                	mov    (%eax),%al
  800d70:	0f b6 c0             	movzbl %al,%eax
  800d73:	29 c2                	sub    %eax,%edx
  800d75:	89 d0                	mov    %edx,%eax
}
  800d77:	5d                   	pop    %ebp
  800d78:	c3                   	ret    

00800d79 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d79:	55                   	push   %ebp
  800d7a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d7c:	eb 09                	jmp    800d87 <strncmp+0xe>
		n--, p++, q++;
  800d7e:	ff 4d 10             	decl   0x10(%ebp)
  800d81:	ff 45 08             	incl   0x8(%ebp)
  800d84:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d8b:	74 17                	je     800da4 <strncmp+0x2b>
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	8a 00                	mov    (%eax),%al
  800d92:	84 c0                	test   %al,%al
  800d94:	74 0e                	je     800da4 <strncmp+0x2b>
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
  800d99:	8a 10                	mov    (%eax),%dl
  800d9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9e:	8a 00                	mov    (%eax),%al
  800da0:	38 c2                	cmp    %al,%dl
  800da2:	74 da                	je     800d7e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800da4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da8:	75 07                	jne    800db1 <strncmp+0x38>
		return 0;
  800daa:	b8 00 00 00 00       	mov    $0x0,%eax
  800daf:	eb 14                	jmp    800dc5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	0f b6 d0             	movzbl %al,%edx
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	8a 00                	mov    (%eax),%al
  800dbe:	0f b6 c0             	movzbl %al,%eax
  800dc1:	29 c2                	sub    %eax,%edx
  800dc3:	89 d0                	mov    %edx,%eax
}
  800dc5:	5d                   	pop    %ebp
  800dc6:	c3                   	ret    

00800dc7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800dc7:	55                   	push   %ebp
  800dc8:	89 e5                	mov    %esp,%ebp
  800dca:	83 ec 04             	sub    $0x4,%esp
  800dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dd3:	eb 12                	jmp    800de7 <strchr+0x20>
		if (*s == c)
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ddd:	75 05                	jne    800de4 <strchr+0x1d>
			return (char *) s;
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	eb 11                	jmp    800df5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800de4:	ff 45 08             	incl   0x8(%ebp)
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	8a 00                	mov    (%eax),%al
  800dec:	84 c0                	test   %al,%al
  800dee:	75 e5                	jne    800dd5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800df0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800df5:	c9                   	leave  
  800df6:	c3                   	ret    

00800df7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800df7:	55                   	push   %ebp
  800df8:	89 e5                	mov    %esp,%ebp
  800dfa:	83 ec 04             	sub    $0x4,%esp
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e03:	eb 0d                	jmp    800e12 <strfind+0x1b>
		if (*s == c)
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e0d:	74 0e                	je     800e1d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e0f:	ff 45 08             	incl   0x8(%ebp)
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	8a 00                	mov    (%eax),%al
  800e17:	84 c0                	test   %al,%al
  800e19:	75 ea                	jne    800e05 <strfind+0xe>
  800e1b:	eb 01                	jmp    800e1e <strfind+0x27>
		if (*s == c)
			break;
  800e1d:	90                   	nop
	return (char *) s;
  800e1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e21:	c9                   	leave  
  800e22:	c3                   	ret    

00800e23 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e23:	55                   	push   %ebp
  800e24:	89 e5                	mov    %esp,%ebp
  800e26:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e32:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e35:	eb 0e                	jmp    800e45 <memset+0x22>
		*p++ = c;
  800e37:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e3a:	8d 50 01             	lea    0x1(%eax),%edx
  800e3d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e43:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e45:	ff 4d f8             	decl   -0x8(%ebp)
  800e48:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e4c:	79 e9                	jns    800e37 <memset+0x14>
		*p++ = c;

	return v;
  800e4e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e51:	c9                   	leave  
  800e52:	c3                   	ret    

00800e53 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e53:	55                   	push   %ebp
  800e54:	89 e5                	mov    %esp,%ebp
  800e56:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e65:	eb 16                	jmp    800e7d <memcpy+0x2a>
		*d++ = *s++;
  800e67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6a:	8d 50 01             	lea    0x1(%eax),%edx
  800e6d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e70:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e73:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e76:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e79:	8a 12                	mov    (%edx),%dl
  800e7b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e80:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e83:	89 55 10             	mov    %edx,0x10(%ebp)
  800e86:	85 c0                	test   %eax,%eax
  800e88:	75 dd                	jne    800e67 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e8d:	c9                   	leave  
  800e8e:	c3                   	ret    

00800e8f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e8f:	55                   	push   %ebp
  800e90:	89 e5                	mov    %esp,%ebp
  800e92:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ea1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ea7:	73 50                	jae    800ef9 <memmove+0x6a>
  800ea9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eac:	8b 45 10             	mov    0x10(%ebp),%eax
  800eaf:	01 d0                	add    %edx,%eax
  800eb1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800eb4:	76 43                	jbe    800ef9 <memmove+0x6a>
		s += n;
  800eb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ebc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ebf:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ec2:	eb 10                	jmp    800ed4 <memmove+0x45>
			*--d = *--s;
  800ec4:	ff 4d f8             	decl   -0x8(%ebp)
  800ec7:	ff 4d fc             	decl   -0x4(%ebp)
  800eca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ecd:	8a 10                	mov    (%eax),%dl
  800ecf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ed4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eda:	89 55 10             	mov    %edx,0x10(%ebp)
  800edd:	85 c0                	test   %eax,%eax
  800edf:	75 e3                	jne    800ec4 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ee1:	eb 23                	jmp    800f06 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ee3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee6:	8d 50 01             	lea    0x1(%eax),%edx
  800ee9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eef:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ef2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ef5:	8a 12                	mov    (%edx),%dl
  800ef7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ef9:	8b 45 10             	mov    0x10(%ebp),%eax
  800efc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eff:	89 55 10             	mov    %edx,0x10(%ebp)
  800f02:	85 c0                	test   %eax,%eax
  800f04:	75 dd                	jne    800ee3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f09:	c9                   	leave  
  800f0a:	c3                   	ret    

00800f0b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f0b:	55                   	push   %ebp
  800f0c:	89 e5                	mov    %esp,%ebp
  800f0e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f1d:	eb 2a                	jmp    800f49 <memcmp+0x3e>
		if (*s1 != *s2)
  800f1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f22:	8a 10                	mov    (%eax),%dl
  800f24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	38 c2                	cmp    %al,%dl
  800f2b:	74 16                	je     800f43 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f30:	8a 00                	mov    (%eax),%al
  800f32:	0f b6 d0             	movzbl %al,%edx
  800f35:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	0f b6 c0             	movzbl %al,%eax
  800f3d:	29 c2                	sub    %eax,%edx
  800f3f:	89 d0                	mov    %edx,%eax
  800f41:	eb 18                	jmp    800f5b <memcmp+0x50>
		s1++, s2++;
  800f43:	ff 45 fc             	incl   -0x4(%ebp)
  800f46:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f49:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f4f:	89 55 10             	mov    %edx,0x10(%ebp)
  800f52:	85 c0                	test   %eax,%eax
  800f54:	75 c9                	jne    800f1f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f56:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f5b:	c9                   	leave  
  800f5c:	c3                   	ret    

00800f5d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f5d:	55                   	push   %ebp
  800f5e:	89 e5                	mov    %esp,%ebp
  800f60:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f63:	8b 55 08             	mov    0x8(%ebp),%edx
  800f66:	8b 45 10             	mov    0x10(%ebp),%eax
  800f69:	01 d0                	add    %edx,%eax
  800f6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f6e:	eb 15                	jmp    800f85 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	0f b6 d0             	movzbl %al,%edx
  800f78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7b:	0f b6 c0             	movzbl %al,%eax
  800f7e:	39 c2                	cmp    %eax,%edx
  800f80:	74 0d                	je     800f8f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f82:	ff 45 08             	incl   0x8(%ebp)
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f8b:	72 e3                	jb     800f70 <memfind+0x13>
  800f8d:	eb 01                	jmp    800f90 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f8f:	90                   	nop
	return (void *) s;
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f93:	c9                   	leave  
  800f94:	c3                   	ret    

00800f95 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f95:	55                   	push   %ebp
  800f96:	89 e5                	mov    %esp,%ebp
  800f98:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fa2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fa9:	eb 03                	jmp    800fae <strtol+0x19>
		s++;
  800fab:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	8a 00                	mov    (%eax),%al
  800fb3:	3c 20                	cmp    $0x20,%al
  800fb5:	74 f4                	je     800fab <strtol+0x16>
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	3c 09                	cmp    $0x9,%al
  800fbe:	74 eb                	je     800fab <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	3c 2b                	cmp    $0x2b,%al
  800fc7:	75 05                	jne    800fce <strtol+0x39>
		s++;
  800fc9:	ff 45 08             	incl   0x8(%ebp)
  800fcc:	eb 13                	jmp    800fe1 <strtol+0x4c>
	else if (*s == '-')
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	3c 2d                	cmp    $0x2d,%al
  800fd5:	75 0a                	jne    800fe1 <strtol+0x4c>
		s++, neg = 1;
  800fd7:	ff 45 08             	incl   0x8(%ebp)
  800fda:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fe1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fe5:	74 06                	je     800fed <strtol+0x58>
  800fe7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800feb:	75 20                	jne    80100d <strtol+0x78>
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 00                	mov    (%eax),%al
  800ff2:	3c 30                	cmp    $0x30,%al
  800ff4:	75 17                	jne    80100d <strtol+0x78>
  800ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff9:	40                   	inc    %eax
  800ffa:	8a 00                	mov    (%eax),%al
  800ffc:	3c 78                	cmp    $0x78,%al
  800ffe:	75 0d                	jne    80100d <strtol+0x78>
		s += 2, base = 16;
  801000:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801004:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80100b:	eb 28                	jmp    801035 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80100d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801011:	75 15                	jne    801028 <strtol+0x93>
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8a 00                	mov    (%eax),%al
  801018:	3c 30                	cmp    $0x30,%al
  80101a:	75 0c                	jne    801028 <strtol+0x93>
		s++, base = 8;
  80101c:	ff 45 08             	incl   0x8(%ebp)
  80101f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801026:	eb 0d                	jmp    801035 <strtol+0xa0>
	else if (base == 0)
  801028:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80102c:	75 07                	jne    801035 <strtol+0xa0>
		base = 10;
  80102e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	8a 00                	mov    (%eax),%al
  80103a:	3c 2f                	cmp    $0x2f,%al
  80103c:	7e 19                	jle    801057 <strtol+0xc2>
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	3c 39                	cmp    $0x39,%al
  801045:	7f 10                	jg     801057 <strtol+0xc2>
			dig = *s - '0';
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	8a 00                	mov    (%eax),%al
  80104c:	0f be c0             	movsbl %al,%eax
  80104f:	83 e8 30             	sub    $0x30,%eax
  801052:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801055:	eb 42                	jmp    801099 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801057:	8b 45 08             	mov    0x8(%ebp),%eax
  80105a:	8a 00                	mov    (%eax),%al
  80105c:	3c 60                	cmp    $0x60,%al
  80105e:	7e 19                	jle    801079 <strtol+0xe4>
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	3c 7a                	cmp    $0x7a,%al
  801067:	7f 10                	jg     801079 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	0f be c0             	movsbl %al,%eax
  801071:	83 e8 57             	sub    $0x57,%eax
  801074:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801077:	eb 20                	jmp    801099 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	8a 00                	mov    (%eax),%al
  80107e:	3c 40                	cmp    $0x40,%al
  801080:	7e 39                	jle    8010bb <strtol+0x126>
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	8a 00                	mov    (%eax),%al
  801087:	3c 5a                	cmp    $0x5a,%al
  801089:	7f 30                	jg     8010bb <strtol+0x126>
			dig = *s - 'A' + 10;
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8a 00                	mov    (%eax),%al
  801090:	0f be c0             	movsbl %al,%eax
  801093:	83 e8 37             	sub    $0x37,%eax
  801096:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801099:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80109c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80109f:	7d 19                	jge    8010ba <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010a1:	ff 45 08             	incl   0x8(%ebp)
  8010a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a7:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010ab:	89 c2                	mov    %eax,%edx
  8010ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010b0:	01 d0                	add    %edx,%eax
  8010b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010b5:	e9 7b ff ff ff       	jmp    801035 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010ba:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010bf:	74 08                	je     8010c9 <strtol+0x134>
		*endptr = (char *) s;
  8010c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c4:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010cd:	74 07                	je     8010d6 <strtol+0x141>
  8010cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d2:	f7 d8                	neg    %eax
  8010d4:	eb 03                	jmp    8010d9 <strtol+0x144>
  8010d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010d9:	c9                   	leave  
  8010da:	c3                   	ret    

008010db <ltostr>:

void
ltostr(long value, char *str)
{
  8010db:	55                   	push   %ebp
  8010dc:	89 e5                	mov    %esp,%ebp
  8010de:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f3:	79 13                	jns    801108 <ltostr+0x2d>
	{
		neg = 1;
  8010f5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ff:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801102:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801105:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801110:	99                   	cltd   
  801111:	f7 f9                	idiv   %ecx
  801113:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801116:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801119:	8d 50 01             	lea    0x1(%eax),%edx
  80111c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80111f:	89 c2                	mov    %eax,%edx
  801121:	8b 45 0c             	mov    0xc(%ebp),%eax
  801124:	01 d0                	add    %edx,%eax
  801126:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801129:	83 c2 30             	add    $0x30,%edx
  80112c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80112e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801131:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801136:	f7 e9                	imul   %ecx
  801138:	c1 fa 02             	sar    $0x2,%edx
  80113b:	89 c8                	mov    %ecx,%eax
  80113d:	c1 f8 1f             	sar    $0x1f,%eax
  801140:	29 c2                	sub    %eax,%edx
  801142:	89 d0                	mov    %edx,%eax
  801144:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801147:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80114a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80114f:	f7 e9                	imul   %ecx
  801151:	c1 fa 02             	sar    $0x2,%edx
  801154:	89 c8                	mov    %ecx,%eax
  801156:	c1 f8 1f             	sar    $0x1f,%eax
  801159:	29 c2                	sub    %eax,%edx
  80115b:	89 d0                	mov    %edx,%eax
  80115d:	c1 e0 02             	shl    $0x2,%eax
  801160:	01 d0                	add    %edx,%eax
  801162:	01 c0                	add    %eax,%eax
  801164:	29 c1                	sub    %eax,%ecx
  801166:	89 ca                	mov    %ecx,%edx
  801168:	85 d2                	test   %edx,%edx
  80116a:	75 9c                	jne    801108 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80116c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801173:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801176:	48                   	dec    %eax
  801177:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80117a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80117e:	74 3d                	je     8011bd <ltostr+0xe2>
		start = 1 ;
  801180:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801187:	eb 34                	jmp    8011bd <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801189:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80118c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118f:	01 d0                	add    %edx,%eax
  801191:	8a 00                	mov    (%eax),%al
  801193:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801196:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801199:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119c:	01 c2                	add    %eax,%edx
  80119e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a4:	01 c8                	add    %ecx,%eax
  8011a6:	8a 00                	mov    (%eax),%al
  8011a8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b0:	01 c2                	add    %eax,%edx
  8011b2:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011b5:	88 02                	mov    %al,(%edx)
		start++ ;
  8011b7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011ba:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011c3:	7c c4                	jl     801189 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011c5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cb:	01 d0                	add    %edx,%eax
  8011cd:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011d0:	90                   	nop
  8011d1:	c9                   	leave  
  8011d2:	c3                   	ret    

008011d3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011d3:	55                   	push   %ebp
  8011d4:	89 e5                	mov    %esp,%ebp
  8011d6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011d9:	ff 75 08             	pushl  0x8(%ebp)
  8011dc:	e8 54 fa ff ff       	call   800c35 <strlen>
  8011e1:	83 c4 04             	add    $0x4,%esp
  8011e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011e7:	ff 75 0c             	pushl  0xc(%ebp)
  8011ea:	e8 46 fa ff ff       	call   800c35 <strlen>
  8011ef:	83 c4 04             	add    $0x4,%esp
  8011f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801203:	eb 17                	jmp    80121c <strcconcat+0x49>
		final[s] = str1[s] ;
  801205:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801208:	8b 45 10             	mov    0x10(%ebp),%eax
  80120b:	01 c2                	add    %eax,%edx
  80120d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	01 c8                	add    %ecx,%eax
  801215:	8a 00                	mov    (%eax),%al
  801217:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801219:	ff 45 fc             	incl   -0x4(%ebp)
  80121c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80121f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801222:	7c e1                	jl     801205 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801224:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80122b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801232:	eb 1f                	jmp    801253 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801234:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801237:	8d 50 01             	lea    0x1(%eax),%edx
  80123a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80123d:	89 c2                	mov    %eax,%edx
  80123f:	8b 45 10             	mov    0x10(%ebp),%eax
  801242:	01 c2                	add    %eax,%edx
  801244:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124a:	01 c8                	add    %ecx,%eax
  80124c:	8a 00                	mov    (%eax),%al
  80124e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801250:	ff 45 f8             	incl   -0x8(%ebp)
  801253:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801256:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801259:	7c d9                	jl     801234 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80125b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125e:	8b 45 10             	mov    0x10(%ebp),%eax
  801261:	01 d0                	add    %edx,%eax
  801263:	c6 00 00             	movb   $0x0,(%eax)
}
  801266:	90                   	nop
  801267:	c9                   	leave  
  801268:	c3                   	ret    

00801269 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801269:	55                   	push   %ebp
  80126a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80126c:	8b 45 14             	mov    0x14(%ebp),%eax
  80126f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801275:	8b 45 14             	mov    0x14(%ebp),%eax
  801278:	8b 00                	mov    (%eax),%eax
  80127a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801281:	8b 45 10             	mov    0x10(%ebp),%eax
  801284:	01 d0                	add    %edx,%eax
  801286:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80128c:	eb 0c                	jmp    80129a <strsplit+0x31>
			*string++ = 0;
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	8d 50 01             	lea    0x1(%eax),%edx
  801294:	89 55 08             	mov    %edx,0x8(%ebp)
  801297:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	8a 00                	mov    (%eax),%al
  80129f:	84 c0                	test   %al,%al
  8012a1:	74 18                	je     8012bb <strsplit+0x52>
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	8a 00                	mov    (%eax),%al
  8012a8:	0f be c0             	movsbl %al,%eax
  8012ab:	50                   	push   %eax
  8012ac:	ff 75 0c             	pushl  0xc(%ebp)
  8012af:	e8 13 fb ff ff       	call   800dc7 <strchr>
  8012b4:	83 c4 08             	add    $0x8,%esp
  8012b7:	85 c0                	test   %eax,%eax
  8012b9:	75 d3                	jne    80128e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	8a 00                	mov    (%eax),%al
  8012c0:	84 c0                	test   %al,%al
  8012c2:	74 5a                	je     80131e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8012c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c7:	8b 00                	mov    (%eax),%eax
  8012c9:	83 f8 0f             	cmp    $0xf,%eax
  8012cc:	75 07                	jne    8012d5 <strsplit+0x6c>
		{
			return 0;
  8012ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8012d3:	eb 66                	jmp    80133b <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8012d8:	8b 00                	mov    (%eax),%eax
  8012da:	8d 48 01             	lea    0x1(%eax),%ecx
  8012dd:	8b 55 14             	mov    0x14(%ebp),%edx
  8012e0:	89 0a                	mov    %ecx,(%edx)
  8012e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ec:	01 c2                	add    %eax,%edx
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012f3:	eb 03                	jmp    8012f8 <strsplit+0x8f>
			string++;
  8012f5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	8a 00                	mov    (%eax),%al
  8012fd:	84 c0                	test   %al,%al
  8012ff:	74 8b                	je     80128c <strsplit+0x23>
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	8a 00                	mov    (%eax),%al
  801306:	0f be c0             	movsbl %al,%eax
  801309:	50                   	push   %eax
  80130a:	ff 75 0c             	pushl  0xc(%ebp)
  80130d:	e8 b5 fa ff ff       	call   800dc7 <strchr>
  801312:	83 c4 08             	add    $0x8,%esp
  801315:	85 c0                	test   %eax,%eax
  801317:	74 dc                	je     8012f5 <strsplit+0x8c>
			string++;
	}
  801319:	e9 6e ff ff ff       	jmp    80128c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80131e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80131f:	8b 45 14             	mov    0x14(%ebp),%eax
  801322:	8b 00                	mov    (%eax),%eax
  801324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80132b:	8b 45 10             	mov    0x10(%ebp),%eax
  80132e:	01 d0                	add    %edx,%eax
  801330:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801336:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
  801340:	83 ec 18             	sub    $0x18,%esp
  801343:	8b 45 10             	mov    0x10(%ebp),%eax
  801346:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801349:	83 ec 04             	sub    $0x4,%esp
  80134c:	68 50 24 80 00       	push   $0x802450
  801351:	6a 17                	push   $0x17
  801353:	68 6f 24 80 00       	push   $0x80246f
  801358:	e8 8a 08 00 00       	call   801be7 <_panic>

0080135d <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
  801360:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801363:	83 ec 04             	sub    $0x4,%esp
  801366:	68 7b 24 80 00       	push   $0x80247b
  80136b:	6a 2f                	push   $0x2f
  80136d:	68 6f 24 80 00       	push   $0x80246f
  801372:	e8 70 08 00 00       	call   801be7 <_panic>

00801377 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801377:	55                   	push   %ebp
  801378:	89 e5                	mov    %esp,%ebp
  80137a:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80137d:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801384:	8b 55 08             	mov    0x8(%ebp),%edx
  801387:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80138a:	01 d0                	add    %edx,%eax
  80138c:	48                   	dec    %eax
  80138d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801390:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801393:	ba 00 00 00 00       	mov    $0x0,%edx
  801398:	f7 75 ec             	divl   -0x14(%ebp)
  80139b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80139e:	29 d0                	sub    %edx,%eax
  8013a0:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8013a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a6:	c1 e8 0c             	shr    $0xc,%eax
  8013a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8013ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8013b3:	e9 c8 00 00 00       	jmp    801480 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8013b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8013bf:	eb 27                	jmp    8013e8 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8013c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013c7:	01 c2                	add    %eax,%edx
  8013c9:	89 d0                	mov    %edx,%eax
  8013cb:	01 c0                	add    %eax,%eax
  8013cd:	01 d0                	add    %edx,%eax
  8013cf:	c1 e0 02             	shl    $0x2,%eax
  8013d2:	05 48 30 80 00       	add    $0x803048,%eax
  8013d7:	8b 00                	mov    (%eax),%eax
  8013d9:	85 c0                	test   %eax,%eax
  8013db:	74 08                	je     8013e5 <malloc+0x6e>
            	i += j;
  8013dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013e0:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8013e3:	eb 0b                	jmp    8013f0 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8013e5:	ff 45 f0             	incl   -0x10(%ebp)
  8013e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013eb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8013ee:	72 d1                	jb     8013c1 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8013f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013f3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8013f6:	0f 85 81 00 00 00    	jne    80147d <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8013fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ff:	05 00 00 08 00       	add    $0x80000,%eax
  801404:	c1 e0 0c             	shl    $0xc,%eax
  801407:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80140a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801411:	eb 1f                	jmp    801432 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801413:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801416:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801419:	01 c2                	add    %eax,%edx
  80141b:	89 d0                	mov    %edx,%eax
  80141d:	01 c0                	add    %eax,%eax
  80141f:	01 d0                	add    %edx,%eax
  801421:	c1 e0 02             	shl    $0x2,%eax
  801424:	05 48 30 80 00       	add    $0x803048,%eax
  801429:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80142f:	ff 45 f0             	incl   -0x10(%ebp)
  801432:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801435:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801438:	72 d9                	jb     801413 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80143a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80143d:	89 d0                	mov    %edx,%eax
  80143f:	01 c0                	add    %eax,%eax
  801441:	01 d0                	add    %edx,%eax
  801443:	c1 e0 02             	shl    $0x2,%eax
  801446:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80144c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80144f:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801451:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801454:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801457:	89 c8                	mov    %ecx,%eax
  801459:	01 c0                	add    %eax,%eax
  80145b:	01 c8                	add    %ecx,%eax
  80145d:	c1 e0 02             	shl    $0x2,%eax
  801460:	05 44 30 80 00       	add    $0x803044,%eax
  801465:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801467:	83 ec 08             	sub    $0x8,%esp
  80146a:	ff 75 08             	pushl  0x8(%ebp)
  80146d:	ff 75 e0             	pushl  -0x20(%ebp)
  801470:	e8 2b 03 00 00       	call   8017a0 <sys_allocateMem>
  801475:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801478:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80147b:	eb 19                	jmp    801496 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80147d:	ff 45 f4             	incl   -0xc(%ebp)
  801480:	a1 04 30 80 00       	mov    0x803004,%eax
  801485:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801488:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80148b:	0f 83 27 ff ff ff    	jae    8013b8 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801491:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801496:	c9                   	leave  
  801497:	c3                   	ret    

00801498 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801498:	55                   	push   %ebp
  801499:	89 e5                	mov    %esp,%ebp
  80149b:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80149e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014a2:	0f 84 e5 00 00 00    	je     80158d <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8014ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014b1:	05 00 00 00 80       	add    $0x80000000,%eax
  8014b6:	c1 e8 0c             	shr    $0xc,%eax
  8014b9:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8014bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014bf:	89 d0                	mov    %edx,%eax
  8014c1:	01 c0                	add    %eax,%eax
  8014c3:	01 d0                	add    %edx,%eax
  8014c5:	c1 e0 02             	shl    $0x2,%eax
  8014c8:	05 40 30 80 00       	add    $0x803040,%eax
  8014cd:	8b 00                	mov    (%eax),%eax
  8014cf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014d2:	0f 85 b8 00 00 00    	jne    801590 <free+0xf8>
  8014d8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014db:	89 d0                	mov    %edx,%eax
  8014dd:	01 c0                	add    %eax,%eax
  8014df:	01 d0                	add    %edx,%eax
  8014e1:	c1 e0 02             	shl    $0x2,%eax
  8014e4:	05 48 30 80 00       	add    $0x803048,%eax
  8014e9:	8b 00                	mov    (%eax),%eax
  8014eb:	85 c0                	test   %eax,%eax
  8014ed:	0f 84 9d 00 00 00    	je     801590 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8014f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014f6:	89 d0                	mov    %edx,%eax
  8014f8:	01 c0                	add    %eax,%eax
  8014fa:	01 d0                	add    %edx,%eax
  8014fc:	c1 e0 02             	shl    $0x2,%eax
  8014ff:	05 44 30 80 00       	add    $0x803044,%eax
  801504:	8b 00                	mov    (%eax),%eax
  801506:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801509:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80150c:	c1 e0 0c             	shl    $0xc,%eax
  80150f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801512:	83 ec 08             	sub    $0x8,%esp
  801515:	ff 75 e4             	pushl  -0x1c(%ebp)
  801518:	ff 75 f0             	pushl  -0x10(%ebp)
  80151b:	e8 64 02 00 00       	call   801784 <sys_freeMem>
  801520:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801523:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80152a:	eb 57                	jmp    801583 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80152c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801532:	01 c2                	add    %eax,%edx
  801534:	89 d0                	mov    %edx,%eax
  801536:	01 c0                	add    %eax,%eax
  801538:	01 d0                	add    %edx,%eax
  80153a:	c1 e0 02             	shl    $0x2,%eax
  80153d:	05 48 30 80 00       	add    $0x803048,%eax
  801542:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801548:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80154b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80154e:	01 c2                	add    %eax,%edx
  801550:	89 d0                	mov    %edx,%eax
  801552:	01 c0                	add    %eax,%eax
  801554:	01 d0                	add    %edx,%eax
  801556:	c1 e0 02             	shl    $0x2,%eax
  801559:	05 40 30 80 00       	add    $0x803040,%eax
  80155e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801564:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801567:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80156a:	01 c2                	add    %eax,%edx
  80156c:	89 d0                	mov    %edx,%eax
  80156e:	01 c0                	add    %eax,%eax
  801570:	01 d0                	add    %edx,%eax
  801572:	c1 e0 02             	shl    $0x2,%eax
  801575:	05 44 30 80 00       	add    $0x803044,%eax
  80157a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801580:	ff 45 f4             	incl   -0xc(%ebp)
  801583:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801586:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801589:	7c a1                	jl     80152c <free+0x94>
  80158b:	eb 04                	jmp    801591 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80158d:	90                   	nop
  80158e:	eb 01                	jmp    801591 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801590:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801591:	c9                   	leave  
  801592:	c3                   	ret    

00801593 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
  801596:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801599:	83 ec 04             	sub    $0x4,%esp
  80159c:	68 98 24 80 00       	push   $0x802498
  8015a1:	68 ae 00 00 00       	push   $0xae
  8015a6:	68 6f 24 80 00       	push   $0x80246f
  8015ab:	e8 37 06 00 00       	call   801be7 <_panic>

008015b0 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
  8015b3:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8015b6:	83 ec 04             	sub    $0x4,%esp
  8015b9:	68 b8 24 80 00       	push   $0x8024b8
  8015be:	68 ca 00 00 00       	push   $0xca
  8015c3:	68 6f 24 80 00       	push   $0x80246f
  8015c8:	e8 1a 06 00 00       	call   801be7 <_panic>

008015cd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
  8015d0:	57                   	push   %edi
  8015d1:	56                   	push   %esi
  8015d2:	53                   	push   %ebx
  8015d3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015dc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015df:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015e2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015e5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015e8:	cd 30                	int    $0x30
  8015ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015f0:	83 c4 10             	add    $0x10,%esp
  8015f3:	5b                   	pop    %ebx
  8015f4:	5e                   	pop    %esi
  8015f5:	5f                   	pop    %edi
  8015f6:	5d                   	pop    %ebp
  8015f7:	c3                   	ret    

008015f8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
  8015fb:	83 ec 04             	sub    $0x4,%esp
  8015fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801601:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801604:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	52                   	push   %edx
  801610:	ff 75 0c             	pushl  0xc(%ebp)
  801613:	50                   	push   %eax
  801614:	6a 00                	push   $0x0
  801616:	e8 b2 ff ff ff       	call   8015cd <syscall>
  80161b:	83 c4 18             	add    $0x18,%esp
}
  80161e:	90                   	nop
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_cgetc>:

int
sys_cgetc(void)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 01                	push   $0x1
  801630:	e8 98 ff ff ff       	call   8015cd <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	50                   	push   %eax
  801649:	6a 05                	push   $0x5
  80164b:	e8 7d ff ff ff       	call   8015cd <syscall>
  801650:	83 c4 18             	add    $0x18,%esp
}
  801653:	c9                   	leave  
  801654:	c3                   	ret    

00801655 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801655:	55                   	push   %ebp
  801656:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 02                	push   $0x2
  801664:	e8 64 ff ff ff       	call   8015cd <syscall>
  801669:	83 c4 18             	add    $0x18,%esp
}
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 03                	push   $0x3
  80167d:	e8 4b ff ff ff       	call   8015cd <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
}
  801685:	c9                   	leave  
  801686:	c3                   	ret    

00801687 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801687:	55                   	push   %ebp
  801688:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 04                	push   $0x4
  801696:	e8 32 ff ff ff       	call   8015cd <syscall>
  80169b:	83 c4 18             	add    $0x18,%esp
}
  80169e:	c9                   	leave  
  80169f:	c3                   	ret    

008016a0 <sys_env_exit>:


void sys_env_exit(void)
{
  8016a0:	55                   	push   %ebp
  8016a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 06                	push   $0x6
  8016af:	e8 19 ff ff ff       	call   8015cd <syscall>
  8016b4:	83 c4 18             	add    $0x18,%esp
}
  8016b7:	90                   	nop
  8016b8:	c9                   	leave  
  8016b9:	c3                   	ret    

008016ba <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016ba:	55                   	push   %ebp
  8016bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	52                   	push   %edx
  8016ca:	50                   	push   %eax
  8016cb:	6a 07                	push   $0x7
  8016cd:	e8 fb fe ff ff       	call   8015cd <syscall>
  8016d2:	83 c4 18             	add    $0x18,%esp
}
  8016d5:	c9                   	leave  
  8016d6:	c3                   	ret    

008016d7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
  8016da:	56                   	push   %esi
  8016db:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016dc:	8b 75 18             	mov    0x18(%ebp),%esi
  8016df:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016e2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	56                   	push   %esi
  8016ec:	53                   	push   %ebx
  8016ed:	51                   	push   %ecx
  8016ee:	52                   	push   %edx
  8016ef:	50                   	push   %eax
  8016f0:	6a 08                	push   $0x8
  8016f2:	e8 d6 fe ff ff       	call   8015cd <syscall>
  8016f7:	83 c4 18             	add    $0x18,%esp
}
  8016fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016fd:	5b                   	pop    %ebx
  8016fe:	5e                   	pop    %esi
  8016ff:	5d                   	pop    %ebp
  801700:	c3                   	ret    

00801701 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801704:	8b 55 0c             	mov    0xc(%ebp),%edx
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	52                   	push   %edx
  801711:	50                   	push   %eax
  801712:	6a 09                	push   $0x9
  801714:	e8 b4 fe ff ff       	call   8015cd <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	ff 75 0c             	pushl  0xc(%ebp)
  80172a:	ff 75 08             	pushl  0x8(%ebp)
  80172d:	6a 0a                	push   $0xa
  80172f:	e8 99 fe ff ff       	call   8015cd <syscall>
  801734:	83 c4 18             	add    $0x18,%esp
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 0b                	push   $0xb
  801748:	e8 80 fe ff ff       	call   8015cd <syscall>
  80174d:	83 c4 18             	add    $0x18,%esp
}
  801750:	c9                   	leave  
  801751:	c3                   	ret    

00801752 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801752:	55                   	push   %ebp
  801753:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 0c                	push   $0xc
  801761:	e8 67 fe ff ff       	call   8015cd <syscall>
  801766:	83 c4 18             	add    $0x18,%esp
}
  801769:	c9                   	leave  
  80176a:	c3                   	ret    

0080176b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80176b:	55                   	push   %ebp
  80176c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 0d                	push   $0xd
  80177a:	e8 4e fe ff ff       	call   8015cd <syscall>
  80177f:	83 c4 18             	add    $0x18,%esp
}
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	ff 75 0c             	pushl  0xc(%ebp)
  801790:	ff 75 08             	pushl  0x8(%ebp)
  801793:	6a 11                	push   $0x11
  801795:	e8 33 fe ff ff       	call   8015cd <syscall>
  80179a:	83 c4 18             	add    $0x18,%esp
	return;
  80179d:	90                   	nop
}
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	ff 75 0c             	pushl  0xc(%ebp)
  8017ac:	ff 75 08             	pushl  0x8(%ebp)
  8017af:	6a 12                	push   $0x12
  8017b1:	e8 17 fe ff ff       	call   8015cd <syscall>
  8017b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b9:	90                   	nop
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 0e                	push   $0xe
  8017cb:	e8 fd fd ff ff       	call   8015cd <syscall>
  8017d0:	83 c4 18             	add    $0x18,%esp
}
  8017d3:	c9                   	leave  
  8017d4:	c3                   	ret    

008017d5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017d5:	55                   	push   %ebp
  8017d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	ff 75 08             	pushl  0x8(%ebp)
  8017e3:	6a 0f                	push   $0xf
  8017e5:	e8 e3 fd ff ff       	call   8015cd <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 10                	push   $0x10
  8017fe:	e8 ca fd ff ff       	call   8015cd <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
}
  801806:	90                   	nop
  801807:	c9                   	leave  
  801808:	c3                   	ret    

00801809 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801809:	55                   	push   %ebp
  80180a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 14                	push   $0x14
  801818:	e8 b0 fd ff ff       	call   8015cd <syscall>
  80181d:	83 c4 18             	add    $0x18,%esp
}
  801820:	90                   	nop
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 15                	push   $0x15
  801832:	e8 96 fd ff ff       	call   8015cd <syscall>
  801837:	83 c4 18             	add    $0x18,%esp
}
  80183a:	90                   	nop
  80183b:	c9                   	leave  
  80183c:	c3                   	ret    

0080183d <sys_cputc>:


void
sys_cputc(const char c)
{
  80183d:	55                   	push   %ebp
  80183e:	89 e5                	mov    %esp,%ebp
  801840:	83 ec 04             	sub    $0x4,%esp
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801849:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	50                   	push   %eax
  801856:	6a 16                	push   $0x16
  801858:	e8 70 fd ff ff       	call   8015cd <syscall>
  80185d:	83 c4 18             	add    $0x18,%esp
}
  801860:	90                   	nop
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 17                	push   $0x17
  801872:	e8 56 fd ff ff       	call   8015cd <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
}
  80187a:	90                   	nop
  80187b:	c9                   	leave  
  80187c:	c3                   	ret    

0080187d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80187d:	55                   	push   %ebp
  80187e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	ff 75 0c             	pushl  0xc(%ebp)
  80188c:	50                   	push   %eax
  80188d:	6a 18                	push   $0x18
  80188f:	e8 39 fd ff ff       	call   8015cd <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
}
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80189c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80189f:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	52                   	push   %edx
  8018a9:	50                   	push   %eax
  8018aa:	6a 1b                	push   $0x1b
  8018ac:	e8 1c fd ff ff       	call   8015cd <syscall>
  8018b1:	83 c4 18             	add    $0x18,%esp
}
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	52                   	push   %edx
  8018c6:	50                   	push   %eax
  8018c7:	6a 19                	push   $0x19
  8018c9:	e8 ff fc ff ff       	call   8015cd <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
}
  8018d1:	90                   	nop
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018da:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	52                   	push   %edx
  8018e4:	50                   	push   %eax
  8018e5:	6a 1a                	push   $0x1a
  8018e7:	e8 e1 fc ff ff       	call   8015cd <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
}
  8018ef:	90                   	nop
  8018f0:	c9                   	leave  
  8018f1:	c3                   	ret    

008018f2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
  8018f5:	83 ec 04             	sub    $0x4,%esp
  8018f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8018fe:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801901:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	6a 00                	push   $0x0
  80190a:	51                   	push   %ecx
  80190b:	52                   	push   %edx
  80190c:	ff 75 0c             	pushl  0xc(%ebp)
  80190f:	50                   	push   %eax
  801910:	6a 1c                	push   $0x1c
  801912:	e8 b6 fc ff ff       	call   8015cd <syscall>
  801917:	83 c4 18             	add    $0x18,%esp
}
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80191f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801922:	8b 45 08             	mov    0x8(%ebp),%eax
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	52                   	push   %edx
  80192c:	50                   	push   %eax
  80192d:	6a 1d                	push   $0x1d
  80192f:	e8 99 fc ff ff       	call   8015cd <syscall>
  801934:	83 c4 18             	add    $0x18,%esp
}
  801937:	c9                   	leave  
  801938:	c3                   	ret    

00801939 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801939:	55                   	push   %ebp
  80193a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80193c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80193f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801942:	8b 45 08             	mov    0x8(%ebp),%eax
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	51                   	push   %ecx
  80194a:	52                   	push   %edx
  80194b:	50                   	push   %eax
  80194c:	6a 1e                	push   $0x1e
  80194e:	e8 7a fc ff ff       	call   8015cd <syscall>
  801953:	83 c4 18             	add    $0x18,%esp
}
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80195b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80195e:	8b 45 08             	mov    0x8(%ebp),%eax
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	52                   	push   %edx
  801968:	50                   	push   %eax
  801969:	6a 1f                	push   $0x1f
  80196b:	e8 5d fc ff ff       	call   8015cd <syscall>
  801970:	83 c4 18             	add    $0x18,%esp
}
  801973:	c9                   	leave  
  801974:	c3                   	ret    

00801975 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801975:	55                   	push   %ebp
  801976:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 20                	push   $0x20
  801984:	e8 44 fc ff ff       	call   8015cd <syscall>
  801989:	83 c4 18             	add    $0x18,%esp
}
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801991:	8b 45 08             	mov    0x8(%ebp),%eax
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	ff 75 10             	pushl  0x10(%ebp)
  80199b:	ff 75 0c             	pushl  0xc(%ebp)
  80199e:	50                   	push   %eax
  80199f:	6a 21                	push   $0x21
  8019a1:	e8 27 fc ff ff       	call   8015cd <syscall>
  8019a6:	83 c4 18             	add    $0x18,%esp
}
  8019a9:	c9                   	leave  
  8019aa:	c3                   	ret    

008019ab <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019ab:	55                   	push   %ebp
  8019ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	50                   	push   %eax
  8019ba:	6a 22                	push   $0x22
  8019bc:	e8 0c fc ff ff       	call   8015cd <syscall>
  8019c1:	83 c4 18             	add    $0x18,%esp
}
  8019c4:	90                   	nop
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	50                   	push   %eax
  8019d6:	6a 23                	push   $0x23
  8019d8:	e8 f0 fb ff ff       	call   8015cd <syscall>
  8019dd:	83 c4 18             	add    $0x18,%esp
}
  8019e0:	90                   	nop
  8019e1:	c9                   	leave  
  8019e2:	c3                   	ret    

008019e3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
  8019e6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019e9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019ec:	8d 50 04             	lea    0x4(%eax),%edx
  8019ef:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	52                   	push   %edx
  8019f9:	50                   	push   %eax
  8019fa:	6a 24                	push   $0x24
  8019fc:	e8 cc fb ff ff       	call   8015cd <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
	return result;
  801a04:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a0a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a0d:	89 01                	mov    %eax,(%ecx)
  801a0f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a12:	8b 45 08             	mov    0x8(%ebp),%eax
  801a15:	c9                   	leave  
  801a16:	c2 04 00             	ret    $0x4

00801a19 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	ff 75 10             	pushl  0x10(%ebp)
  801a23:	ff 75 0c             	pushl  0xc(%ebp)
  801a26:	ff 75 08             	pushl  0x8(%ebp)
  801a29:	6a 13                	push   $0x13
  801a2b:	e8 9d fb ff ff       	call   8015cd <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
	return ;
  801a33:	90                   	nop
}
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 25                	push   $0x25
  801a45:	e8 83 fb ff ff       	call   8015cd <syscall>
  801a4a:	83 c4 18             	add    $0x18,%esp
}
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    

00801a4f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a4f:	55                   	push   %ebp
  801a50:	89 e5                	mov    %esp,%ebp
  801a52:	83 ec 04             	sub    $0x4,%esp
  801a55:	8b 45 08             	mov    0x8(%ebp),%eax
  801a58:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a5b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	50                   	push   %eax
  801a68:	6a 26                	push   $0x26
  801a6a:	e8 5e fb ff ff       	call   8015cd <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a72:	90                   	nop
}
  801a73:	c9                   	leave  
  801a74:	c3                   	ret    

00801a75 <rsttst>:
void rsttst()
{
  801a75:	55                   	push   %ebp
  801a76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 28                	push   $0x28
  801a84:	e8 44 fb ff ff       	call   8015cd <syscall>
  801a89:	83 c4 18             	add    $0x18,%esp
	return ;
  801a8c:	90                   	nop
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
  801a92:	83 ec 04             	sub    $0x4,%esp
  801a95:	8b 45 14             	mov    0x14(%ebp),%eax
  801a98:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a9b:	8b 55 18             	mov    0x18(%ebp),%edx
  801a9e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801aa2:	52                   	push   %edx
  801aa3:	50                   	push   %eax
  801aa4:	ff 75 10             	pushl  0x10(%ebp)
  801aa7:	ff 75 0c             	pushl  0xc(%ebp)
  801aaa:	ff 75 08             	pushl  0x8(%ebp)
  801aad:	6a 27                	push   $0x27
  801aaf:	e8 19 fb ff ff       	call   8015cd <syscall>
  801ab4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab7:	90                   	nop
}
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <chktst>:
void chktst(uint32 n)
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	ff 75 08             	pushl  0x8(%ebp)
  801ac8:	6a 29                	push   $0x29
  801aca:	e8 fe fa ff ff       	call   8015cd <syscall>
  801acf:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad2:	90                   	nop
}
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    

00801ad5 <inctst>:

void inctst()
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 2a                	push   $0x2a
  801ae4:	e8 e4 fa ff ff       	call   8015cd <syscall>
  801ae9:	83 c4 18             	add    $0x18,%esp
	return ;
  801aec:	90                   	nop
}
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <gettst>:
uint32 gettst()
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 2b                	push   $0x2b
  801afe:	e8 ca fa ff ff       	call   8015cd <syscall>
  801b03:	83 c4 18             	add    $0x18,%esp
}
  801b06:	c9                   	leave  
  801b07:	c3                   	ret    

00801b08 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
  801b0b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 2c                	push   $0x2c
  801b1a:	e8 ae fa ff ff       	call   8015cd <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
  801b22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b25:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b29:	75 07                	jne    801b32 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b2b:	b8 01 00 00 00       	mov    $0x1,%eax
  801b30:	eb 05                	jmp    801b37 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b32:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b37:	c9                   	leave  
  801b38:	c3                   	ret    

00801b39 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b39:	55                   	push   %ebp
  801b3a:	89 e5                	mov    %esp,%ebp
  801b3c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 2c                	push   $0x2c
  801b4b:	e8 7d fa ff ff       	call   8015cd <syscall>
  801b50:	83 c4 18             	add    $0x18,%esp
  801b53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b56:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b5a:	75 07                	jne    801b63 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b5c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b61:	eb 05                	jmp    801b68 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b63:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b68:	c9                   	leave  
  801b69:	c3                   	ret    

00801b6a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
  801b6d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 2c                	push   $0x2c
  801b7c:	e8 4c fa ff ff       	call   8015cd <syscall>
  801b81:	83 c4 18             	add    $0x18,%esp
  801b84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b87:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b8b:	75 07                	jne    801b94 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b8d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b92:	eb 05                	jmp    801b99 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b99:	c9                   	leave  
  801b9a:	c3                   	ret    

00801b9b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b9b:	55                   	push   %ebp
  801b9c:	89 e5                	mov    %esp,%ebp
  801b9e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 2c                	push   $0x2c
  801bad:	e8 1b fa ff ff       	call   8015cd <syscall>
  801bb2:	83 c4 18             	add    $0x18,%esp
  801bb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bb8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bbc:	75 07                	jne    801bc5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bbe:	b8 01 00 00 00       	mov    $0x1,%eax
  801bc3:	eb 05                	jmp    801bca <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bc5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bca:	c9                   	leave  
  801bcb:	c3                   	ret    

00801bcc <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bcc:	55                   	push   %ebp
  801bcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	ff 75 08             	pushl  0x8(%ebp)
  801bda:	6a 2d                	push   $0x2d
  801bdc:	e8 ec f9 ff ff       	call   8015cd <syscall>
  801be1:	83 c4 18             	add    $0x18,%esp
	return ;
  801be4:	90                   	nop
}
  801be5:	c9                   	leave  
  801be6:	c3                   	ret    

00801be7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801be7:	55                   	push   %ebp
  801be8:	89 e5                	mov    %esp,%ebp
  801bea:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801bed:	8d 45 10             	lea    0x10(%ebp),%eax
  801bf0:	83 c0 04             	add    $0x4,%eax
  801bf3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801bf6:	a1 40 30 98 00       	mov    0x983040,%eax
  801bfb:	85 c0                	test   %eax,%eax
  801bfd:	74 16                	je     801c15 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801bff:	a1 40 30 98 00       	mov    0x983040,%eax
  801c04:	83 ec 08             	sub    $0x8,%esp
  801c07:	50                   	push   %eax
  801c08:	68 dc 24 80 00       	push   $0x8024dc
  801c0d:	e8 a1 e9 ff ff       	call   8005b3 <cprintf>
  801c12:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801c15:	a1 00 30 80 00       	mov    0x803000,%eax
  801c1a:	ff 75 0c             	pushl  0xc(%ebp)
  801c1d:	ff 75 08             	pushl  0x8(%ebp)
  801c20:	50                   	push   %eax
  801c21:	68 e1 24 80 00       	push   $0x8024e1
  801c26:	e8 88 e9 ff ff       	call   8005b3 <cprintf>
  801c2b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801c2e:	8b 45 10             	mov    0x10(%ebp),%eax
  801c31:	83 ec 08             	sub    $0x8,%esp
  801c34:	ff 75 f4             	pushl  -0xc(%ebp)
  801c37:	50                   	push   %eax
  801c38:	e8 0b e9 ff ff       	call   800548 <vcprintf>
  801c3d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801c40:	83 ec 08             	sub    $0x8,%esp
  801c43:	6a 00                	push   $0x0
  801c45:	68 fd 24 80 00       	push   $0x8024fd
  801c4a:	e8 f9 e8 ff ff       	call   800548 <vcprintf>
  801c4f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801c52:	e8 7a e8 ff ff       	call   8004d1 <exit>

	// should not return here
	while (1) ;
  801c57:	eb fe                	jmp    801c57 <_panic+0x70>

00801c59 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801c59:	55                   	push   %ebp
  801c5a:	89 e5                	mov    %esp,%ebp
  801c5c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801c5f:	a1 20 30 80 00       	mov    0x803020,%eax
  801c64:	8b 50 74             	mov    0x74(%eax),%edx
  801c67:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c6a:	39 c2                	cmp    %eax,%edx
  801c6c:	74 14                	je     801c82 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801c6e:	83 ec 04             	sub    $0x4,%esp
  801c71:	68 00 25 80 00       	push   $0x802500
  801c76:	6a 26                	push   $0x26
  801c78:	68 4c 25 80 00       	push   $0x80254c
  801c7d:	e8 65 ff ff ff       	call   801be7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801c82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801c89:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c90:	e9 c2 00 00 00       	jmp    801d57 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801c95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c98:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	01 d0                	add    %edx,%eax
  801ca4:	8b 00                	mov    (%eax),%eax
  801ca6:	85 c0                	test   %eax,%eax
  801ca8:	75 08                	jne    801cb2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801caa:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801cad:	e9 a2 00 00 00       	jmp    801d54 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801cb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cb9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801cc0:	eb 69                	jmp    801d2b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801cc2:	a1 20 30 80 00       	mov    0x803020,%eax
  801cc7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ccd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801cd0:	89 d0                	mov    %edx,%eax
  801cd2:	01 c0                	add    %eax,%eax
  801cd4:	01 d0                	add    %edx,%eax
  801cd6:	c1 e0 02             	shl    $0x2,%eax
  801cd9:	01 c8                	add    %ecx,%eax
  801cdb:	8a 40 04             	mov    0x4(%eax),%al
  801cde:	84 c0                	test   %al,%al
  801ce0:	75 46                	jne    801d28 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801ce2:	a1 20 30 80 00       	mov    0x803020,%eax
  801ce7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ced:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801cf0:	89 d0                	mov    %edx,%eax
  801cf2:	01 c0                	add    %eax,%eax
  801cf4:	01 d0                	add    %edx,%eax
  801cf6:	c1 e0 02             	shl    $0x2,%eax
  801cf9:	01 c8                	add    %ecx,%eax
  801cfb:	8b 00                	mov    (%eax),%eax
  801cfd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801d00:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d03:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d08:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801d0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d0d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801d14:	8b 45 08             	mov    0x8(%ebp),%eax
  801d17:	01 c8                	add    %ecx,%eax
  801d19:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d1b:	39 c2                	cmp    %eax,%edx
  801d1d:	75 09                	jne    801d28 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801d1f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801d26:	eb 12                	jmp    801d3a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d28:	ff 45 e8             	incl   -0x18(%ebp)
  801d2b:	a1 20 30 80 00       	mov    0x803020,%eax
  801d30:	8b 50 74             	mov    0x74(%eax),%edx
  801d33:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d36:	39 c2                	cmp    %eax,%edx
  801d38:	77 88                	ja     801cc2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801d3a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801d3e:	75 14                	jne    801d54 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801d40:	83 ec 04             	sub    $0x4,%esp
  801d43:	68 58 25 80 00       	push   $0x802558
  801d48:	6a 3a                	push   $0x3a
  801d4a:	68 4c 25 80 00       	push   $0x80254c
  801d4f:	e8 93 fe ff ff       	call   801be7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801d54:	ff 45 f0             	incl   -0x10(%ebp)
  801d57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d5a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801d5d:	0f 8c 32 ff ff ff    	jl     801c95 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801d63:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d6a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801d71:	eb 26                	jmp    801d99 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801d73:	a1 20 30 80 00       	mov    0x803020,%eax
  801d78:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801d7e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d81:	89 d0                	mov    %edx,%eax
  801d83:	01 c0                	add    %eax,%eax
  801d85:	01 d0                	add    %edx,%eax
  801d87:	c1 e0 02             	shl    $0x2,%eax
  801d8a:	01 c8                	add    %ecx,%eax
  801d8c:	8a 40 04             	mov    0x4(%eax),%al
  801d8f:	3c 01                	cmp    $0x1,%al
  801d91:	75 03                	jne    801d96 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801d93:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d96:	ff 45 e0             	incl   -0x20(%ebp)
  801d99:	a1 20 30 80 00       	mov    0x803020,%eax
  801d9e:	8b 50 74             	mov    0x74(%eax),%edx
  801da1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801da4:	39 c2                	cmp    %eax,%edx
  801da6:	77 cb                	ja     801d73 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801da8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dab:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801dae:	74 14                	je     801dc4 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801db0:	83 ec 04             	sub    $0x4,%esp
  801db3:	68 ac 25 80 00       	push   $0x8025ac
  801db8:	6a 44                	push   $0x44
  801dba:	68 4c 25 80 00       	push   $0x80254c
  801dbf:	e8 23 fe ff ff       	call   801be7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801dc4:	90                   	nop
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    
  801dc7:	90                   	nop

00801dc8 <__udivdi3>:
  801dc8:	55                   	push   %ebp
  801dc9:	57                   	push   %edi
  801dca:	56                   	push   %esi
  801dcb:	53                   	push   %ebx
  801dcc:	83 ec 1c             	sub    $0x1c,%esp
  801dcf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dd3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dd7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ddb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ddf:	89 ca                	mov    %ecx,%edx
  801de1:	89 f8                	mov    %edi,%eax
  801de3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801de7:	85 f6                	test   %esi,%esi
  801de9:	75 2d                	jne    801e18 <__udivdi3+0x50>
  801deb:	39 cf                	cmp    %ecx,%edi
  801ded:	77 65                	ja     801e54 <__udivdi3+0x8c>
  801def:	89 fd                	mov    %edi,%ebp
  801df1:	85 ff                	test   %edi,%edi
  801df3:	75 0b                	jne    801e00 <__udivdi3+0x38>
  801df5:	b8 01 00 00 00       	mov    $0x1,%eax
  801dfa:	31 d2                	xor    %edx,%edx
  801dfc:	f7 f7                	div    %edi
  801dfe:	89 c5                	mov    %eax,%ebp
  801e00:	31 d2                	xor    %edx,%edx
  801e02:	89 c8                	mov    %ecx,%eax
  801e04:	f7 f5                	div    %ebp
  801e06:	89 c1                	mov    %eax,%ecx
  801e08:	89 d8                	mov    %ebx,%eax
  801e0a:	f7 f5                	div    %ebp
  801e0c:	89 cf                	mov    %ecx,%edi
  801e0e:	89 fa                	mov    %edi,%edx
  801e10:	83 c4 1c             	add    $0x1c,%esp
  801e13:	5b                   	pop    %ebx
  801e14:	5e                   	pop    %esi
  801e15:	5f                   	pop    %edi
  801e16:	5d                   	pop    %ebp
  801e17:	c3                   	ret    
  801e18:	39 ce                	cmp    %ecx,%esi
  801e1a:	77 28                	ja     801e44 <__udivdi3+0x7c>
  801e1c:	0f bd fe             	bsr    %esi,%edi
  801e1f:	83 f7 1f             	xor    $0x1f,%edi
  801e22:	75 40                	jne    801e64 <__udivdi3+0x9c>
  801e24:	39 ce                	cmp    %ecx,%esi
  801e26:	72 0a                	jb     801e32 <__udivdi3+0x6a>
  801e28:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e2c:	0f 87 9e 00 00 00    	ja     801ed0 <__udivdi3+0x108>
  801e32:	b8 01 00 00 00       	mov    $0x1,%eax
  801e37:	89 fa                	mov    %edi,%edx
  801e39:	83 c4 1c             	add    $0x1c,%esp
  801e3c:	5b                   	pop    %ebx
  801e3d:	5e                   	pop    %esi
  801e3e:	5f                   	pop    %edi
  801e3f:	5d                   	pop    %ebp
  801e40:	c3                   	ret    
  801e41:	8d 76 00             	lea    0x0(%esi),%esi
  801e44:	31 ff                	xor    %edi,%edi
  801e46:	31 c0                	xor    %eax,%eax
  801e48:	89 fa                	mov    %edi,%edx
  801e4a:	83 c4 1c             	add    $0x1c,%esp
  801e4d:	5b                   	pop    %ebx
  801e4e:	5e                   	pop    %esi
  801e4f:	5f                   	pop    %edi
  801e50:	5d                   	pop    %ebp
  801e51:	c3                   	ret    
  801e52:	66 90                	xchg   %ax,%ax
  801e54:	89 d8                	mov    %ebx,%eax
  801e56:	f7 f7                	div    %edi
  801e58:	31 ff                	xor    %edi,%edi
  801e5a:	89 fa                	mov    %edi,%edx
  801e5c:	83 c4 1c             	add    $0x1c,%esp
  801e5f:	5b                   	pop    %ebx
  801e60:	5e                   	pop    %esi
  801e61:	5f                   	pop    %edi
  801e62:	5d                   	pop    %ebp
  801e63:	c3                   	ret    
  801e64:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e69:	89 eb                	mov    %ebp,%ebx
  801e6b:	29 fb                	sub    %edi,%ebx
  801e6d:	89 f9                	mov    %edi,%ecx
  801e6f:	d3 e6                	shl    %cl,%esi
  801e71:	89 c5                	mov    %eax,%ebp
  801e73:	88 d9                	mov    %bl,%cl
  801e75:	d3 ed                	shr    %cl,%ebp
  801e77:	89 e9                	mov    %ebp,%ecx
  801e79:	09 f1                	or     %esi,%ecx
  801e7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e7f:	89 f9                	mov    %edi,%ecx
  801e81:	d3 e0                	shl    %cl,%eax
  801e83:	89 c5                	mov    %eax,%ebp
  801e85:	89 d6                	mov    %edx,%esi
  801e87:	88 d9                	mov    %bl,%cl
  801e89:	d3 ee                	shr    %cl,%esi
  801e8b:	89 f9                	mov    %edi,%ecx
  801e8d:	d3 e2                	shl    %cl,%edx
  801e8f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e93:	88 d9                	mov    %bl,%cl
  801e95:	d3 e8                	shr    %cl,%eax
  801e97:	09 c2                	or     %eax,%edx
  801e99:	89 d0                	mov    %edx,%eax
  801e9b:	89 f2                	mov    %esi,%edx
  801e9d:	f7 74 24 0c          	divl   0xc(%esp)
  801ea1:	89 d6                	mov    %edx,%esi
  801ea3:	89 c3                	mov    %eax,%ebx
  801ea5:	f7 e5                	mul    %ebp
  801ea7:	39 d6                	cmp    %edx,%esi
  801ea9:	72 19                	jb     801ec4 <__udivdi3+0xfc>
  801eab:	74 0b                	je     801eb8 <__udivdi3+0xf0>
  801ead:	89 d8                	mov    %ebx,%eax
  801eaf:	31 ff                	xor    %edi,%edi
  801eb1:	e9 58 ff ff ff       	jmp    801e0e <__udivdi3+0x46>
  801eb6:	66 90                	xchg   %ax,%ax
  801eb8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ebc:	89 f9                	mov    %edi,%ecx
  801ebe:	d3 e2                	shl    %cl,%edx
  801ec0:	39 c2                	cmp    %eax,%edx
  801ec2:	73 e9                	jae    801ead <__udivdi3+0xe5>
  801ec4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ec7:	31 ff                	xor    %edi,%edi
  801ec9:	e9 40 ff ff ff       	jmp    801e0e <__udivdi3+0x46>
  801ece:	66 90                	xchg   %ax,%ax
  801ed0:	31 c0                	xor    %eax,%eax
  801ed2:	e9 37 ff ff ff       	jmp    801e0e <__udivdi3+0x46>
  801ed7:	90                   	nop

00801ed8 <__umoddi3>:
  801ed8:	55                   	push   %ebp
  801ed9:	57                   	push   %edi
  801eda:	56                   	push   %esi
  801edb:	53                   	push   %ebx
  801edc:	83 ec 1c             	sub    $0x1c,%esp
  801edf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ee3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ee7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801eeb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801eef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ef3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ef7:	89 f3                	mov    %esi,%ebx
  801ef9:	89 fa                	mov    %edi,%edx
  801efb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eff:	89 34 24             	mov    %esi,(%esp)
  801f02:	85 c0                	test   %eax,%eax
  801f04:	75 1a                	jne    801f20 <__umoddi3+0x48>
  801f06:	39 f7                	cmp    %esi,%edi
  801f08:	0f 86 a2 00 00 00    	jbe    801fb0 <__umoddi3+0xd8>
  801f0e:	89 c8                	mov    %ecx,%eax
  801f10:	89 f2                	mov    %esi,%edx
  801f12:	f7 f7                	div    %edi
  801f14:	89 d0                	mov    %edx,%eax
  801f16:	31 d2                	xor    %edx,%edx
  801f18:	83 c4 1c             	add    $0x1c,%esp
  801f1b:	5b                   	pop    %ebx
  801f1c:	5e                   	pop    %esi
  801f1d:	5f                   	pop    %edi
  801f1e:	5d                   	pop    %ebp
  801f1f:	c3                   	ret    
  801f20:	39 f0                	cmp    %esi,%eax
  801f22:	0f 87 ac 00 00 00    	ja     801fd4 <__umoddi3+0xfc>
  801f28:	0f bd e8             	bsr    %eax,%ebp
  801f2b:	83 f5 1f             	xor    $0x1f,%ebp
  801f2e:	0f 84 ac 00 00 00    	je     801fe0 <__umoddi3+0x108>
  801f34:	bf 20 00 00 00       	mov    $0x20,%edi
  801f39:	29 ef                	sub    %ebp,%edi
  801f3b:	89 fe                	mov    %edi,%esi
  801f3d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f41:	89 e9                	mov    %ebp,%ecx
  801f43:	d3 e0                	shl    %cl,%eax
  801f45:	89 d7                	mov    %edx,%edi
  801f47:	89 f1                	mov    %esi,%ecx
  801f49:	d3 ef                	shr    %cl,%edi
  801f4b:	09 c7                	or     %eax,%edi
  801f4d:	89 e9                	mov    %ebp,%ecx
  801f4f:	d3 e2                	shl    %cl,%edx
  801f51:	89 14 24             	mov    %edx,(%esp)
  801f54:	89 d8                	mov    %ebx,%eax
  801f56:	d3 e0                	shl    %cl,%eax
  801f58:	89 c2                	mov    %eax,%edx
  801f5a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f5e:	d3 e0                	shl    %cl,%eax
  801f60:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f64:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f68:	89 f1                	mov    %esi,%ecx
  801f6a:	d3 e8                	shr    %cl,%eax
  801f6c:	09 d0                	or     %edx,%eax
  801f6e:	d3 eb                	shr    %cl,%ebx
  801f70:	89 da                	mov    %ebx,%edx
  801f72:	f7 f7                	div    %edi
  801f74:	89 d3                	mov    %edx,%ebx
  801f76:	f7 24 24             	mull   (%esp)
  801f79:	89 c6                	mov    %eax,%esi
  801f7b:	89 d1                	mov    %edx,%ecx
  801f7d:	39 d3                	cmp    %edx,%ebx
  801f7f:	0f 82 87 00 00 00    	jb     80200c <__umoddi3+0x134>
  801f85:	0f 84 91 00 00 00    	je     80201c <__umoddi3+0x144>
  801f8b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f8f:	29 f2                	sub    %esi,%edx
  801f91:	19 cb                	sbb    %ecx,%ebx
  801f93:	89 d8                	mov    %ebx,%eax
  801f95:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f99:	d3 e0                	shl    %cl,%eax
  801f9b:	89 e9                	mov    %ebp,%ecx
  801f9d:	d3 ea                	shr    %cl,%edx
  801f9f:	09 d0                	or     %edx,%eax
  801fa1:	89 e9                	mov    %ebp,%ecx
  801fa3:	d3 eb                	shr    %cl,%ebx
  801fa5:	89 da                	mov    %ebx,%edx
  801fa7:	83 c4 1c             	add    $0x1c,%esp
  801faa:	5b                   	pop    %ebx
  801fab:	5e                   	pop    %esi
  801fac:	5f                   	pop    %edi
  801fad:	5d                   	pop    %ebp
  801fae:	c3                   	ret    
  801faf:	90                   	nop
  801fb0:	89 fd                	mov    %edi,%ebp
  801fb2:	85 ff                	test   %edi,%edi
  801fb4:	75 0b                	jne    801fc1 <__umoddi3+0xe9>
  801fb6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fbb:	31 d2                	xor    %edx,%edx
  801fbd:	f7 f7                	div    %edi
  801fbf:	89 c5                	mov    %eax,%ebp
  801fc1:	89 f0                	mov    %esi,%eax
  801fc3:	31 d2                	xor    %edx,%edx
  801fc5:	f7 f5                	div    %ebp
  801fc7:	89 c8                	mov    %ecx,%eax
  801fc9:	f7 f5                	div    %ebp
  801fcb:	89 d0                	mov    %edx,%eax
  801fcd:	e9 44 ff ff ff       	jmp    801f16 <__umoddi3+0x3e>
  801fd2:	66 90                	xchg   %ax,%ax
  801fd4:	89 c8                	mov    %ecx,%eax
  801fd6:	89 f2                	mov    %esi,%edx
  801fd8:	83 c4 1c             	add    $0x1c,%esp
  801fdb:	5b                   	pop    %ebx
  801fdc:	5e                   	pop    %esi
  801fdd:	5f                   	pop    %edi
  801fde:	5d                   	pop    %ebp
  801fdf:	c3                   	ret    
  801fe0:	3b 04 24             	cmp    (%esp),%eax
  801fe3:	72 06                	jb     801feb <__umoddi3+0x113>
  801fe5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fe9:	77 0f                	ja     801ffa <__umoddi3+0x122>
  801feb:	89 f2                	mov    %esi,%edx
  801fed:	29 f9                	sub    %edi,%ecx
  801fef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ff3:	89 14 24             	mov    %edx,(%esp)
  801ff6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ffa:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ffe:	8b 14 24             	mov    (%esp),%edx
  802001:	83 c4 1c             	add    $0x1c,%esp
  802004:	5b                   	pop    %ebx
  802005:	5e                   	pop    %esi
  802006:	5f                   	pop    %edi
  802007:	5d                   	pop    %ebp
  802008:	c3                   	ret    
  802009:	8d 76 00             	lea    0x0(%esi),%esi
  80200c:	2b 04 24             	sub    (%esp),%eax
  80200f:	19 fa                	sbb    %edi,%edx
  802011:	89 d1                	mov    %edx,%ecx
  802013:	89 c6                	mov    %eax,%esi
  802015:	e9 71 ff ff ff       	jmp    801f8b <__umoddi3+0xb3>
  80201a:	66 90                	xchg   %ax,%ax
  80201c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802020:	72 ea                	jb     80200c <__umoddi3+0x134>
  802022:	89 d9                	mov    %ebx,%ecx
  802024:	e9 62 ff ff ff       	jmp    801f8b <__umoddi3+0xb3>
