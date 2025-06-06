
obj/user/tst3:     file format elf32-i386


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
  800031:	e8 7a 05 00 00       	call   8005b0 <libmain>
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
  80003e:	83 ec 7c             	sub    $0x7c,%esp
	

	rsttst();
  800041:	e8 02 1c 00 00       	call   801c48 <rsttst>
	
	

	int Mega = 1024*1024;
  800046:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  80004d:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)

	int start_freeFrames = sys_calculate_free_frames() ;
  800054:	e8 b3 18 00 00       	call   80190c <sys_calculate_free_frames>
  800059:	89 45 dc             	mov    %eax,-0x24(%ebp)

	void* ptr_allocations[20] = {0};
  80005c:	8d 55 84             	lea    -0x7c(%ebp),%edx
  80005f:	b9 14 00 00 00       	mov    $0x14,%ecx
  800064:	b8 00 00 00 00       	mov    $0x0,%eax
  800069:	89 d7                	mov    %edx,%edi
  80006b:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  80006d:	e8 9a 18 00 00       	call   80190c <sys_calculate_free_frames>
  800072:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800075:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800078:	01 c0                	add    %eax,%eax
  80007a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80007d:	83 ec 0c             	sub    $0xc,%esp
  800080:	50                   	push   %eax
  800081:	e8 c4 14 00 00       	call   80154a <malloc>
  800086:	83 c4 10             	add    $0x10,%esp
  800089:	89 45 84             	mov    %eax,-0x7c(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  80008c:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	6a 00                	push   $0x0
  800094:	6a 62                	push   $0x62
  800096:	68 00 10 00 80       	push   $0x80001000
  80009b:	68 00 00 00 80       	push   $0x80000000
  8000a0:	50                   	push   %eax
  8000a1:	e8 bc 1b 00 00       	call   801c62 <tst>
  8000a6:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8000a9:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  8000ac:	e8 5b 18 00 00       	call   80190c <sys_calculate_free_frames>
  8000b1:	29 c3                	sub    %eax,%ebx
  8000b3:	89 d8                	mov    %ebx,%eax
  8000b5:	83 ec 0c             	sub    $0xc,%esp
  8000b8:	6a 00                	push   $0x0
  8000ba:	6a 65                	push   $0x65
  8000bc:	6a 00                	push   $0x0
  8000be:	68 01 02 00 00       	push   $0x201
  8000c3:	50                   	push   %eax
  8000c4:	e8 99 1b 00 00       	call   801c62 <tst>
  8000c9:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8000cc:	e8 3b 18 00 00       	call   80190c <sys_calculate_free_frames>
  8000d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  8000d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000d7:	01 c0                	add    %eax,%eax
  8000d9:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000dc:	83 ec 0c             	sub    $0xc,%esp
  8000df:	50                   	push   %eax
  8000e0:	e8 65 14 00 00       	call   80154a <malloc>
  8000e5:	83 c4 10             	add    $0x10,%esp
  8000e8:	89 45 88             	mov    %eax,-0x78(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
  8000eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000ee:	01 c0                	add    %eax,%eax
  8000f0:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8000f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800101:	8b 45 88             	mov    -0x78(%ebp),%eax
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	6a 00                	push   $0x0
  800109:	6a 62                	push   $0x62
  80010b:	51                   	push   %ecx
  80010c:	52                   	push   %edx
  80010d:	50                   	push   %eax
  80010e:	e8 4f 1b 00 00       	call   801c62 <tst>
  800113:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  800116:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800119:	e8 ee 17 00 00       	call   80190c <sys_calculate_free_frames>
  80011e:	29 c3                	sub    %eax,%ebx
  800120:	89 d8                	mov    %ebx,%eax
  800122:	83 ec 0c             	sub    $0xc,%esp
  800125:	6a 00                	push   $0x0
  800127:	6a 65                	push   $0x65
  800129:	6a 00                	push   $0x0
  80012b:	68 00 02 00 00       	push   $0x200
  800130:	50                   	push   %eax
  800131:	e8 2c 1b 00 00       	call   801c62 <tst>
  800136:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800139:	e8 ce 17 00 00       	call   80190c <sys_calculate_free_frames>
  80013e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800141:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800144:	01 c0                	add    %eax,%eax
  800146:	83 ec 0c             	sub    $0xc,%esp
  800149:	50                   	push   %eax
  80014a:	e8 fb 13 00 00       	call   80154a <malloc>
  80014f:	83 c4 10             	add    $0x10,%esp
  800152:	89 45 8c             	mov    %eax,-0x74(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  800155:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800158:	c1 e0 02             	shl    $0x2,%eax
  80015b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800161:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800164:	c1 e0 02             	shl    $0x2,%eax
  800167:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80016d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800170:	83 ec 0c             	sub    $0xc,%esp
  800173:	6a 00                	push   $0x0
  800175:	6a 62                	push   $0x62
  800177:	51                   	push   %ecx
  800178:	52                   	push   %edx
  800179:	50                   	push   %eax
  80017a:	e8 e3 1a 00 00       	call   801c62 <tst>
  80017f:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);
  800182:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800185:	e8 82 17 00 00       	call   80190c <sys_calculate_free_frames>
  80018a:	29 c3                	sub    %eax,%ebx
  80018c:	89 d8                	mov    %ebx,%eax
  80018e:	83 ec 0c             	sub    $0xc,%esp
  800191:	6a 00                	push   $0x0
  800193:	6a 65                	push   $0x65
  800195:	6a 00                	push   $0x0
  800197:	6a 02                	push   $0x2
  800199:	50                   	push   %eax
  80019a:	e8 c3 1a 00 00       	call   801c62 <tst>
  80019f:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8001a2:	e8 65 17 00 00       	call   80190c <sys_calculate_free_frames>
  8001a7:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8001aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001ad:	01 c0                	add    %eax,%eax
  8001af:	83 ec 0c             	sub    $0xc,%esp
  8001b2:	50                   	push   %eax
  8001b3:	e8 92 13 00 00       	call   80154a <malloc>
  8001b8:	83 c4 10             	add    $0x10,%esp
  8001bb:	89 45 90             	mov    %eax,-0x70(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega + 4*kilo,USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE, 'b', 0);
  8001be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001c1:	c1 e0 02             	shl    $0x2,%eax
  8001c4:	89 c2                	mov    %eax,%edx
  8001c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001c9:	c1 e0 02             	shl    $0x2,%eax
  8001cc:	01 d0                	add    %edx,%eax
  8001ce:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001d7:	c1 e0 02             	shl    $0x2,%eax
  8001da:	89 c2                	mov    %eax,%edx
  8001dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001df:	c1 e0 02             	shl    $0x2,%eax
  8001e2:	01 d0                	add    %edx,%eax
  8001e4:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8001ea:	8b 45 90             	mov    -0x70(%ebp),%eax
  8001ed:	83 ec 0c             	sub    $0xc,%esp
  8001f0:	6a 00                	push   $0x0
  8001f2:	6a 62                	push   $0x62
  8001f4:	51                   	push   %ecx
  8001f5:	52                   	push   %edx
  8001f6:	50                   	push   %eax
  8001f7:	e8 66 1a 00 00       	call   801c62 <tst>
  8001fc:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);
  8001ff:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800202:	e8 05 17 00 00       	call   80190c <sys_calculate_free_frames>
  800207:	29 c3                	sub    %eax,%ebx
  800209:	89 d8                	mov    %ebx,%eax
  80020b:	83 ec 0c             	sub    $0xc,%esp
  80020e:	6a 00                	push   $0x0
  800210:	6a 65                	push   $0x65
  800212:	6a 00                	push   $0x0
  800214:	6a 01                	push   $0x1
  800216:	50                   	push   %eax
  800217:	e8 46 1a 00 00       	call   801c62 <tst>
  80021c:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80021f:	e8 e8 16 00 00       	call   80190c <sys_calculate_free_frames>
  800224:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800227:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80022a:	89 d0                	mov    %edx,%eax
  80022c:	01 c0                	add    %eax,%eax
  80022e:	01 d0                	add    %edx,%eax
  800230:	01 c0                	add    %eax,%eax
  800232:	01 d0                	add    %edx,%eax
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	50                   	push   %eax
  800238:	e8 0d 13 00 00       	call   80154a <malloc>
  80023d:	83 c4 10             	add    $0x10,%esp
  800240:	89 45 94             	mov    %eax,-0x6c(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega + 8*kilo,USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE, 'b', 0);
  800243:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800246:	c1 e0 02             	shl    $0x2,%eax
  800249:	89 c2                	mov    %eax,%edx
  80024b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80024e:	c1 e0 03             	shl    $0x3,%eax
  800251:	01 d0                	add    %edx,%eax
  800253:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800259:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80025c:	c1 e0 02             	shl    $0x2,%eax
  80025f:	89 c2                	mov    %eax,%edx
  800261:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800264:	c1 e0 03             	shl    $0x3,%eax
  800267:	01 d0                	add    %edx,%eax
  800269:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80026f:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	6a 00                	push   $0x0
  800277:	6a 62                	push   $0x62
  800279:	51                   	push   %ecx
  80027a:	52                   	push   %edx
  80027b:	50                   	push   %eax
  80027c:	e8 e1 19 00 00       	call   801c62 <tst>
  800281:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 2 ,0, 'e', 0);
  800284:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800287:	e8 80 16 00 00       	call   80190c <sys_calculate_free_frames>
  80028c:	29 c3                	sub    %eax,%ebx
  80028e:	89 d8                	mov    %ebx,%eax
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	6a 00                	push   $0x0
  800295:	6a 65                	push   $0x65
  800297:	6a 00                	push   $0x0
  800299:	6a 02                	push   $0x2
  80029b:	50                   	push   %eax
  80029c:	e8 c1 19 00 00       	call   801c62 <tst>
  8002a1:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8002a4:	e8 63 16 00 00       	call   80190c <sys_calculate_free_frames>
  8002a9:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8002ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002af:	89 c2                	mov    %eax,%edx
  8002b1:	01 d2                	add    %edx,%edx
  8002b3:	01 d0                	add    %edx,%eax
  8002b5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002b8:	83 ec 0c             	sub    $0xc,%esp
  8002bb:	50                   	push   %eax
  8002bc:	e8 89 12 00 00       	call   80154a <malloc>
  8002c1:	83 c4 10             	add    $0x10,%esp
  8002c4:	89 45 98             	mov    %eax,-0x68(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega + 16*kilo,USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  8002c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002ca:	c1 e0 02             	shl    $0x2,%eax
  8002cd:	89 c2                	mov    %eax,%edx
  8002cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002d2:	c1 e0 04             	shl    $0x4,%eax
  8002d5:	01 d0                	add    %edx,%eax
  8002d7:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002e0:	c1 e0 02             	shl    $0x2,%eax
  8002e3:	89 c2                	mov    %eax,%edx
  8002e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e8:	c1 e0 04             	shl    $0x4,%eax
  8002eb:	01 d0                	add    %edx,%eax
  8002ed:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002f3:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002f6:	83 ec 0c             	sub    $0xc,%esp
  8002f9:	6a 00                	push   $0x0
  8002fb:	6a 62                	push   $0x62
  8002fd:	51                   	push   %ecx
  8002fe:	52                   	push   %edx
  8002ff:	50                   	push   %eax
  800300:	e8 5d 19 00 00       	call   801c62 <tst>
  800305:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);
  800308:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80030b:	89 c2                	mov    %eax,%edx
  80030d:	01 d2                	add    %edx,%edx
  80030f:	01 d0                	add    %edx,%eax
  800311:	85 c0                	test   %eax,%eax
  800313:	79 05                	jns    80031a <_main+0x2e2>
  800315:	05 ff 0f 00 00       	add    $0xfff,%eax
  80031a:	c1 f8 0c             	sar    $0xc,%eax
  80031d:	89 c3                	mov    %eax,%ebx
  80031f:	8b 75 d8             	mov    -0x28(%ebp),%esi
  800322:	e8 e5 15 00 00       	call   80190c <sys_calculate_free_frames>
  800327:	29 c6                	sub    %eax,%esi
  800329:	89 f0                	mov    %esi,%eax
  80032b:	83 ec 0c             	sub    $0xc,%esp
  80032e:	6a 00                	push   $0x0
  800330:	6a 65                	push   $0x65
  800332:	6a 00                	push   $0x0
  800334:	53                   	push   %ebx
  800335:	50                   	push   %eax
  800336:	e8 27 19 00 00       	call   801c62 <tst>
  80033b:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80033e:	e8 c9 15 00 00       	call   80190c <sys_calculate_free_frames>
  800343:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  800346:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800349:	01 c0                	add    %eax,%eax
  80034b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80034e:	83 ec 0c             	sub    $0xc,%esp
  800351:	50                   	push   %eax
  800352:	e8 f3 11 00 00       	call   80154a <malloc>
  800357:	83 c4 10             	add    $0x10,%esp
  80035a:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega + 16*kilo,USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  80035d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800360:	89 d0                	mov    %edx,%eax
  800362:	01 c0                	add    %eax,%eax
  800364:	01 d0                	add    %edx,%eax
  800366:	01 c0                	add    %eax,%eax
  800368:	01 d0                	add    %edx,%eax
  80036a:	89 c2                	mov    %eax,%edx
  80036c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80036f:	c1 e0 04             	shl    $0x4,%eax
  800372:	01 d0                	add    %edx,%eax
  800374:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  80037a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80037d:	89 d0                	mov    %edx,%eax
  80037f:	01 c0                	add    %eax,%eax
  800381:	01 d0                	add    %edx,%eax
  800383:	01 c0                	add    %eax,%eax
  800385:	01 d0                	add    %edx,%eax
  800387:	89 c2                	mov    %eax,%edx
  800389:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80038c:	c1 e0 04             	shl    $0x4,%eax
  80038f:	01 d0                	add    %edx,%eax
  800391:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800397:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80039a:	83 ec 0c             	sub    $0xc,%esp
  80039d:	6a 00                	push   $0x0
  80039f:	6a 62                	push   $0x62
  8003a1:	51                   	push   %ecx
  8003a2:	52                   	push   %edx
  8003a3:	50                   	push   %eax
  8003a4:	e8 b9 18 00 00       	call   801c62 <tst>
  8003a9:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8003ac:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  8003af:	e8 58 15 00 00       	call   80190c <sys_calculate_free_frames>
  8003b4:	29 c3                	sub    %eax,%ebx
  8003b6:	89 d8                	mov    %ebx,%eax
  8003b8:	83 ec 0c             	sub    $0xc,%esp
  8003bb:	6a 00                	push   $0x0
  8003bd:	6a 65                	push   $0x65
  8003bf:	6a 00                	push   $0x0
  8003c1:	68 01 02 00 00       	push   $0x201
  8003c6:	50                   	push   %eax
  8003c7:	e8 96 18 00 00       	call   801c62 <tst>
  8003cc:	83 c4 20             	add    $0x20,%esp
	}

	{
		int freeFrames = sys_calculate_free_frames() ;
  8003cf:	e8 38 15 00 00       	call   80190c <sys_calculate_free_frames>
  8003d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[0]);
  8003d7:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8003da:	83 ec 0c             	sub    $0xc,%esp
  8003dd:	50                   	push   %eax
  8003de:	e8 88 12 00 00       	call   80166b <free>
  8003e3:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512 ,0, 'e', 0);
  8003e6:	e8 21 15 00 00       	call   80190c <sys_calculate_free_frames>
  8003eb:	89 c2                	mov    %eax,%edx
  8003ed:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003f0:	29 c2                	sub    %eax,%edx
  8003f2:	89 d0                	mov    %edx,%eax
  8003f4:	83 ec 0c             	sub    $0xc,%esp
  8003f7:	6a 00                	push   $0x0
  8003f9:	6a 65                	push   $0x65
  8003fb:	6a 00                	push   $0x0
  8003fd:	68 00 02 00 00       	push   $0x200
  800402:	50                   	push   %eax
  800403:	e8 5a 18 00 00       	call   801c62 <tst>
  800408:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80040b:	e8 fc 14 00 00       	call   80190c <sys_calculate_free_frames>
  800410:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[1]);
  800413:	8b 45 88             	mov    -0x78(%ebp),%eax
  800416:	83 ec 0c             	sub    $0xc,%esp
  800419:	50                   	push   %eax
  80041a:	e8 4c 12 00 00       	call   80166b <free>
  80041f:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512+1 ,0, 'e', 0);
  800422:	e8 e5 14 00 00       	call   80190c <sys_calculate_free_frames>
  800427:	89 c2                	mov    %eax,%edx
  800429:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80042c:	29 c2                	sub    %eax,%edx
  80042e:	89 d0                	mov    %edx,%eax
  800430:	83 ec 0c             	sub    $0xc,%esp
  800433:	6a 00                	push   $0x0
  800435:	6a 65                	push   $0x65
  800437:	6a 00                	push   $0x0
  800439:	68 01 02 00 00       	push   $0x201
  80043e:	50                   	push   %eax
  80043f:	e8 1e 18 00 00       	call   801c62 <tst>
  800444:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800447:	e8 c0 14 00 00       	call   80190c <sys_calculate_free_frames>
  80044c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[2]);
  80044f:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800452:	83 ec 0c             	sub    $0xc,%esp
  800455:	50                   	push   %eax
  800456:	e8 10 12 00 00       	call   80166b <free>
  80045b:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 1 ,0, 'e', 0);
  80045e:	e8 a9 14 00 00       	call   80190c <sys_calculate_free_frames>
  800463:	89 c2                	mov    %eax,%edx
  800465:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800468:	29 c2                	sub    %eax,%edx
  80046a:	89 d0                	mov    %edx,%eax
  80046c:	83 ec 0c             	sub    $0xc,%esp
  80046f:	6a 00                	push   $0x0
  800471:	6a 65                	push   $0x65
  800473:	6a 00                	push   $0x0
  800475:	6a 01                	push   $0x1
  800477:	50                   	push   %eax
  800478:	e8 e5 17 00 00       	call   801c62 <tst>
  80047d:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800480:	e8 87 14 00 00       	call   80190c <sys_calculate_free_frames>
  800485:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[3]);
  800488:	8b 45 90             	mov    -0x70(%ebp),%eax
  80048b:	83 ec 0c             	sub    $0xc,%esp
  80048e:	50                   	push   %eax
  80048f:	e8 d7 11 00 00       	call   80166b <free>
  800494:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 1 ,0, 'e', 0);
  800497:	e8 70 14 00 00       	call   80190c <sys_calculate_free_frames>
  80049c:	89 c2                	mov    %eax,%edx
  80049e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004a1:	29 c2                	sub    %eax,%edx
  8004a3:	89 d0                	mov    %edx,%eax
  8004a5:	83 ec 0c             	sub    $0xc,%esp
  8004a8:	6a 00                	push   $0x0
  8004aa:	6a 65                	push   $0x65
  8004ac:	6a 00                	push   $0x0
  8004ae:	6a 01                	push   $0x1
  8004b0:	50                   	push   %eax
  8004b1:	e8 ac 17 00 00       	call   801c62 <tst>
  8004b6:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8004b9:	e8 4e 14 00 00       	call   80190c <sys_calculate_free_frames>
  8004be:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[4]);
  8004c1:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8004c4:	83 ec 0c             	sub    $0xc,%esp
  8004c7:	50                   	push   %eax
  8004c8:	e8 9e 11 00 00       	call   80166b <free>
  8004cd:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 2 ,0, 'e', 0);
  8004d0:	e8 37 14 00 00       	call   80190c <sys_calculate_free_frames>
  8004d5:	89 c2                	mov    %eax,%edx
  8004d7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004da:	29 c2                	sub    %eax,%edx
  8004dc:	89 d0                	mov    %edx,%eax
  8004de:	83 ec 0c             	sub    $0xc,%esp
  8004e1:	6a 00                	push   $0x0
  8004e3:	6a 65                	push   $0x65
  8004e5:	6a 00                	push   $0x0
  8004e7:	6a 02                	push   $0x2
  8004e9:	50                   	push   %eax
  8004ea:	e8 73 17 00 00       	call   801c62 <tst>
  8004ef:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8004f2:	e8 15 14 00 00       	call   80190c <sys_calculate_free_frames>
  8004f7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[5]);
  8004fa:	8b 45 98             	mov    -0x68(%ebp),%eax
  8004fd:	83 ec 0c             	sub    $0xc,%esp
  800500:	50                   	push   %eax
  800501:	e8 65 11 00 00       	call   80166b <free>
  800506:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 3*Mega/4096,0, 'e', 0);
  800509:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80050c:	89 c2                	mov    %eax,%edx
  80050e:	01 d2                	add    %edx,%edx
  800510:	01 d0                	add    %edx,%eax
  800512:	85 c0                	test   %eax,%eax
  800514:	79 05                	jns    80051b <_main+0x4e3>
  800516:	05 ff 0f 00 00       	add    $0xfff,%eax
  80051b:	c1 f8 0c             	sar    $0xc,%eax
  80051e:	89 c3                	mov    %eax,%ebx
  800520:	e8 e7 13 00 00       	call   80190c <sys_calculate_free_frames>
  800525:	89 c2                	mov    %eax,%edx
  800527:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80052a:	29 c2                	sub    %eax,%edx
  80052c:	89 d0                	mov    %edx,%eax
  80052e:	83 ec 0c             	sub    $0xc,%esp
  800531:	6a 00                	push   $0x0
  800533:	6a 65                	push   $0x65
  800535:	6a 00                	push   $0x0
  800537:	53                   	push   %ebx
  800538:	50                   	push   %eax
  800539:	e8 24 17 00 00       	call   801c62 <tst>
  80053e:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800541:	e8 c6 13 00 00       	call   80190c <sys_calculate_free_frames>
  800546:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[6]);
  800549:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80054c:	83 ec 0c             	sub    $0xc,%esp
  80054f:	50                   	push   %eax
  800550:	e8 16 11 00 00       	call   80166b <free>
  800555:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512+2 ,0, 'e', 0);
  800558:	e8 af 13 00 00       	call   80190c <sys_calculate_free_frames>
  80055d:	89 c2                	mov    %eax,%edx
  80055f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800562:	29 c2                	sub    %eax,%edx
  800564:	89 d0                	mov    %edx,%eax
  800566:	83 ec 0c             	sub    $0xc,%esp
  800569:	6a 00                	push   $0x0
  80056b:	6a 65                	push   $0x65
  80056d:	6a 00                	push   $0x0
  80056f:	68 02 02 00 00       	push   $0x202
  800574:	50                   	push   %eax
  800575:	e8 e8 16 00 00       	call   801c62 <tst>
  80057a:	83 c4 20             	add    $0x20,%esp

		tst(start_freeFrames, sys_calculate_free_frames() ,0, 'e', 0);
  80057d:	e8 8a 13 00 00       	call   80190c <sys_calculate_free_frames>
  800582:	89 c2                	mov    %eax,%edx
  800584:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800587:	83 ec 0c             	sub    $0xc,%esp
  80058a:	6a 00                	push   $0x0
  80058c:	6a 65                	push   $0x65
  80058e:	6a 00                	push   $0x0
  800590:	52                   	push   %edx
  800591:	50                   	push   %eax
  800592:	e8 cb 16 00 00       	call   801c62 <tst>
  800597:	83 c4 20             	add    $0x20,%esp

	}

	chktst(22);
  80059a:	83 ec 0c             	sub    $0xc,%esp
  80059d:	6a 16                	push   $0x16
  80059f:	e8 e9 16 00 00       	call   801c8d <chktst>
  8005a4:	83 c4 10             	add    $0x10,%esp

	return;
  8005a7:	90                   	nop
}
  8005a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005ab:	5b                   	pop    %ebx
  8005ac:	5e                   	pop    %esi
  8005ad:	5f                   	pop    %edi
  8005ae:	5d                   	pop    %ebp
  8005af:	c3                   	ret    

008005b0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005b0:	55                   	push   %ebp
  8005b1:	89 e5                	mov    %esp,%ebp
  8005b3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005b6:	e8 86 12 00 00       	call   801841 <sys_getenvindex>
  8005bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005c1:	89 d0                	mov    %edx,%eax
  8005c3:	01 c0                	add    %eax,%eax
  8005c5:	01 d0                	add    %edx,%eax
  8005c7:	c1 e0 02             	shl    $0x2,%eax
  8005ca:	01 d0                	add    %edx,%eax
  8005cc:	c1 e0 06             	shl    $0x6,%eax
  8005cf:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005d4:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005de:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005e4:	84 c0                	test   %al,%al
  8005e6:	74 0f                	je     8005f7 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8005e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ed:	05 f4 02 00 00       	add    $0x2f4,%eax
  8005f2:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005fb:	7e 0a                	jle    800607 <libmain+0x57>
		binaryname = argv[0];
  8005fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800600:	8b 00                	mov    (%eax),%eax
  800602:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800607:	83 ec 08             	sub    $0x8,%esp
  80060a:	ff 75 0c             	pushl  0xc(%ebp)
  80060d:	ff 75 08             	pushl  0x8(%ebp)
  800610:	e8 23 fa ff ff       	call   800038 <_main>
  800615:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800618:	e8 bf 13 00 00       	call   8019dc <sys_disable_interrupt>
	cprintf("**************************************\n");
  80061d:	83 ec 0c             	sub    $0xc,%esp
  800620:	68 18 22 80 00       	push   $0x802218
  800625:	e8 5c 01 00 00       	call   800786 <cprintf>
  80062a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80062d:	a1 20 30 80 00       	mov    0x803020,%eax
  800632:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800638:	a1 20 30 80 00       	mov    0x803020,%eax
  80063d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800643:	83 ec 04             	sub    $0x4,%esp
  800646:	52                   	push   %edx
  800647:	50                   	push   %eax
  800648:	68 40 22 80 00       	push   $0x802240
  80064d:	e8 34 01 00 00       	call   800786 <cprintf>
  800652:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800655:	a1 20 30 80 00       	mov    0x803020,%eax
  80065a:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	50                   	push   %eax
  800664:	68 65 22 80 00       	push   $0x802265
  800669:	e8 18 01 00 00       	call   800786 <cprintf>
  80066e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800671:	83 ec 0c             	sub    $0xc,%esp
  800674:	68 18 22 80 00       	push   $0x802218
  800679:	e8 08 01 00 00       	call   800786 <cprintf>
  80067e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800681:	e8 70 13 00 00       	call   8019f6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800686:	e8 19 00 00 00       	call   8006a4 <exit>
}
  80068b:	90                   	nop
  80068c:	c9                   	leave  
  80068d:	c3                   	ret    

0080068e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80068e:	55                   	push   %ebp
  80068f:	89 e5                	mov    %esp,%ebp
  800691:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800694:	83 ec 0c             	sub    $0xc,%esp
  800697:	6a 00                	push   $0x0
  800699:	e8 6f 11 00 00       	call   80180d <sys_env_destroy>
  80069e:	83 c4 10             	add    $0x10,%esp
}
  8006a1:	90                   	nop
  8006a2:	c9                   	leave  
  8006a3:	c3                   	ret    

008006a4 <exit>:

void
exit(void)
{
  8006a4:	55                   	push   %ebp
  8006a5:	89 e5                	mov    %esp,%ebp
  8006a7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006aa:	e8 c4 11 00 00       	call   801873 <sys_env_exit>
}
  8006af:	90                   	nop
  8006b0:	c9                   	leave  
  8006b1:	c3                   	ret    

008006b2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006b2:	55                   	push   %ebp
  8006b3:	89 e5                	mov    %esp,%ebp
  8006b5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8006b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006bb:	8b 00                	mov    (%eax),%eax
  8006bd:	8d 48 01             	lea    0x1(%eax),%ecx
  8006c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c3:	89 0a                	mov    %ecx,(%edx)
  8006c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8006c8:	88 d1                	mov    %dl,%cl
  8006ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006cd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d4:	8b 00                	mov    (%eax),%eax
  8006d6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006db:	75 2c                	jne    800709 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006dd:	a0 24 30 80 00       	mov    0x803024,%al
  8006e2:	0f b6 c0             	movzbl %al,%eax
  8006e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006e8:	8b 12                	mov    (%edx),%edx
  8006ea:	89 d1                	mov    %edx,%ecx
  8006ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ef:	83 c2 08             	add    $0x8,%edx
  8006f2:	83 ec 04             	sub    $0x4,%esp
  8006f5:	50                   	push   %eax
  8006f6:	51                   	push   %ecx
  8006f7:	52                   	push   %edx
  8006f8:	e8 ce 10 00 00       	call   8017cb <sys_cputs>
  8006fd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800700:	8b 45 0c             	mov    0xc(%ebp),%eax
  800703:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800709:	8b 45 0c             	mov    0xc(%ebp),%eax
  80070c:	8b 40 04             	mov    0x4(%eax),%eax
  80070f:	8d 50 01             	lea    0x1(%eax),%edx
  800712:	8b 45 0c             	mov    0xc(%ebp),%eax
  800715:	89 50 04             	mov    %edx,0x4(%eax)
}
  800718:	90                   	nop
  800719:	c9                   	leave  
  80071a:	c3                   	ret    

0080071b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80071b:	55                   	push   %ebp
  80071c:	89 e5                	mov    %esp,%ebp
  80071e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800724:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80072b:	00 00 00 
	b.cnt = 0;
  80072e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800735:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800738:	ff 75 0c             	pushl  0xc(%ebp)
  80073b:	ff 75 08             	pushl  0x8(%ebp)
  80073e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800744:	50                   	push   %eax
  800745:	68 b2 06 80 00       	push   $0x8006b2
  80074a:	e8 11 02 00 00       	call   800960 <vprintfmt>
  80074f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800752:	a0 24 30 80 00       	mov    0x803024,%al
  800757:	0f b6 c0             	movzbl %al,%eax
  80075a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800760:	83 ec 04             	sub    $0x4,%esp
  800763:	50                   	push   %eax
  800764:	52                   	push   %edx
  800765:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80076b:	83 c0 08             	add    $0x8,%eax
  80076e:	50                   	push   %eax
  80076f:	e8 57 10 00 00       	call   8017cb <sys_cputs>
  800774:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800777:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80077e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800784:	c9                   	leave  
  800785:	c3                   	ret    

00800786 <cprintf>:

int cprintf(const char *fmt, ...) {
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80078c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800793:	8d 45 0c             	lea    0xc(%ebp),%eax
  800796:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800799:	8b 45 08             	mov    0x8(%ebp),%eax
  80079c:	83 ec 08             	sub    $0x8,%esp
  80079f:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a2:	50                   	push   %eax
  8007a3:	e8 73 ff ff ff       	call   80071b <vcprintf>
  8007a8:	83 c4 10             	add    $0x10,%esp
  8007ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007b1:	c9                   	leave  
  8007b2:	c3                   	ret    

008007b3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007b3:	55                   	push   %ebp
  8007b4:	89 e5                	mov    %esp,%ebp
  8007b6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007b9:	e8 1e 12 00 00       	call   8019dc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8007be:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c7:	83 ec 08             	sub    $0x8,%esp
  8007ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cd:	50                   	push   %eax
  8007ce:	e8 48 ff ff ff       	call   80071b <vcprintf>
  8007d3:	83 c4 10             	add    $0x10,%esp
  8007d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007d9:	e8 18 12 00 00       	call   8019f6 <sys_enable_interrupt>
	return cnt;
  8007de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007e1:	c9                   	leave  
  8007e2:	c3                   	ret    

008007e3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007e3:	55                   	push   %ebp
  8007e4:	89 e5                	mov    %esp,%ebp
  8007e6:	53                   	push   %ebx
  8007e7:	83 ec 14             	sub    $0x14,%esp
  8007ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007f6:	8b 45 18             	mov    0x18(%ebp),%eax
  8007f9:	ba 00 00 00 00       	mov    $0x0,%edx
  8007fe:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800801:	77 55                	ja     800858 <printnum+0x75>
  800803:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800806:	72 05                	jb     80080d <printnum+0x2a>
  800808:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80080b:	77 4b                	ja     800858 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80080d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800810:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800813:	8b 45 18             	mov    0x18(%ebp),%eax
  800816:	ba 00 00 00 00       	mov    $0x0,%edx
  80081b:	52                   	push   %edx
  80081c:	50                   	push   %eax
  80081d:	ff 75 f4             	pushl  -0xc(%ebp)
  800820:	ff 75 f0             	pushl  -0x10(%ebp)
  800823:	e8 74 17 00 00       	call   801f9c <__udivdi3>
  800828:	83 c4 10             	add    $0x10,%esp
  80082b:	83 ec 04             	sub    $0x4,%esp
  80082e:	ff 75 20             	pushl  0x20(%ebp)
  800831:	53                   	push   %ebx
  800832:	ff 75 18             	pushl  0x18(%ebp)
  800835:	52                   	push   %edx
  800836:	50                   	push   %eax
  800837:	ff 75 0c             	pushl  0xc(%ebp)
  80083a:	ff 75 08             	pushl  0x8(%ebp)
  80083d:	e8 a1 ff ff ff       	call   8007e3 <printnum>
  800842:	83 c4 20             	add    $0x20,%esp
  800845:	eb 1a                	jmp    800861 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800847:	83 ec 08             	sub    $0x8,%esp
  80084a:	ff 75 0c             	pushl  0xc(%ebp)
  80084d:	ff 75 20             	pushl  0x20(%ebp)
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	ff d0                	call   *%eax
  800855:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800858:	ff 4d 1c             	decl   0x1c(%ebp)
  80085b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80085f:	7f e6                	jg     800847 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800861:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800864:	bb 00 00 00 00       	mov    $0x0,%ebx
  800869:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80086f:	53                   	push   %ebx
  800870:	51                   	push   %ecx
  800871:	52                   	push   %edx
  800872:	50                   	push   %eax
  800873:	e8 34 18 00 00       	call   8020ac <__umoddi3>
  800878:	83 c4 10             	add    $0x10,%esp
  80087b:	05 94 24 80 00       	add    $0x802494,%eax
  800880:	8a 00                	mov    (%eax),%al
  800882:	0f be c0             	movsbl %al,%eax
  800885:	83 ec 08             	sub    $0x8,%esp
  800888:	ff 75 0c             	pushl  0xc(%ebp)
  80088b:	50                   	push   %eax
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	ff d0                	call   *%eax
  800891:	83 c4 10             	add    $0x10,%esp
}
  800894:	90                   	nop
  800895:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800898:	c9                   	leave  
  800899:	c3                   	ret    

0080089a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80089a:	55                   	push   %ebp
  80089b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80089d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008a1:	7e 1c                	jle    8008bf <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	8b 00                	mov    (%eax),%eax
  8008a8:	8d 50 08             	lea    0x8(%eax),%edx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	89 10                	mov    %edx,(%eax)
  8008b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	83 e8 08             	sub    $0x8,%eax
  8008b8:	8b 50 04             	mov    0x4(%eax),%edx
  8008bb:	8b 00                	mov    (%eax),%eax
  8008bd:	eb 40                	jmp    8008ff <getuint+0x65>
	else if (lflag)
  8008bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008c3:	74 1e                	je     8008e3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	8b 00                	mov    (%eax),%eax
  8008ca:	8d 50 04             	lea    0x4(%eax),%edx
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	89 10                	mov    %edx,(%eax)
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	8b 00                	mov    (%eax),%eax
  8008d7:	83 e8 04             	sub    $0x4,%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	ba 00 00 00 00       	mov    $0x0,%edx
  8008e1:	eb 1c                	jmp    8008ff <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e6:	8b 00                	mov    (%eax),%eax
  8008e8:	8d 50 04             	lea    0x4(%eax),%edx
  8008eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ee:	89 10                	mov    %edx,(%eax)
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	8b 00                	mov    (%eax),%eax
  8008f5:	83 e8 04             	sub    $0x4,%eax
  8008f8:	8b 00                	mov    (%eax),%eax
  8008fa:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008ff:	5d                   	pop    %ebp
  800900:	c3                   	ret    

00800901 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800901:	55                   	push   %ebp
  800902:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800904:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800908:	7e 1c                	jle    800926 <getint+0x25>
		return va_arg(*ap, long long);
  80090a:	8b 45 08             	mov    0x8(%ebp),%eax
  80090d:	8b 00                	mov    (%eax),%eax
  80090f:	8d 50 08             	lea    0x8(%eax),%edx
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	89 10                	mov    %edx,(%eax)
  800917:	8b 45 08             	mov    0x8(%ebp),%eax
  80091a:	8b 00                	mov    (%eax),%eax
  80091c:	83 e8 08             	sub    $0x8,%eax
  80091f:	8b 50 04             	mov    0x4(%eax),%edx
  800922:	8b 00                	mov    (%eax),%eax
  800924:	eb 38                	jmp    80095e <getint+0x5d>
	else if (lflag)
  800926:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80092a:	74 1a                	je     800946 <getint+0x45>
		return va_arg(*ap, long);
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	8b 00                	mov    (%eax),%eax
  800931:	8d 50 04             	lea    0x4(%eax),%edx
  800934:	8b 45 08             	mov    0x8(%ebp),%eax
  800937:	89 10                	mov    %edx,(%eax)
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	8b 00                	mov    (%eax),%eax
  80093e:	83 e8 04             	sub    $0x4,%eax
  800941:	8b 00                	mov    (%eax),%eax
  800943:	99                   	cltd   
  800944:	eb 18                	jmp    80095e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	8b 00                	mov    (%eax),%eax
  80094b:	8d 50 04             	lea    0x4(%eax),%edx
  80094e:	8b 45 08             	mov    0x8(%ebp),%eax
  800951:	89 10                	mov    %edx,(%eax)
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	8b 00                	mov    (%eax),%eax
  800958:	83 e8 04             	sub    $0x4,%eax
  80095b:	8b 00                	mov    (%eax),%eax
  80095d:	99                   	cltd   
}
  80095e:	5d                   	pop    %ebp
  80095f:	c3                   	ret    

00800960 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800960:	55                   	push   %ebp
  800961:	89 e5                	mov    %esp,%ebp
  800963:	56                   	push   %esi
  800964:	53                   	push   %ebx
  800965:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800968:	eb 17                	jmp    800981 <vprintfmt+0x21>
			if (ch == '\0')
  80096a:	85 db                	test   %ebx,%ebx
  80096c:	0f 84 af 03 00 00    	je     800d21 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800972:	83 ec 08             	sub    $0x8,%esp
  800975:	ff 75 0c             	pushl  0xc(%ebp)
  800978:	53                   	push   %ebx
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	ff d0                	call   *%eax
  80097e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800981:	8b 45 10             	mov    0x10(%ebp),%eax
  800984:	8d 50 01             	lea    0x1(%eax),%edx
  800987:	89 55 10             	mov    %edx,0x10(%ebp)
  80098a:	8a 00                	mov    (%eax),%al
  80098c:	0f b6 d8             	movzbl %al,%ebx
  80098f:	83 fb 25             	cmp    $0x25,%ebx
  800992:	75 d6                	jne    80096a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800994:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800998:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80099f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009a6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b7:	8d 50 01             	lea    0x1(%eax),%edx
  8009ba:	89 55 10             	mov    %edx,0x10(%ebp)
  8009bd:	8a 00                	mov    (%eax),%al
  8009bf:	0f b6 d8             	movzbl %al,%ebx
  8009c2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009c5:	83 f8 55             	cmp    $0x55,%eax
  8009c8:	0f 87 2b 03 00 00    	ja     800cf9 <vprintfmt+0x399>
  8009ce:	8b 04 85 b8 24 80 00 	mov    0x8024b8(,%eax,4),%eax
  8009d5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009d7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009db:	eb d7                	jmp    8009b4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009dd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009e1:	eb d1                	jmp    8009b4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009e3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009ea:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ed:	89 d0                	mov    %edx,%eax
  8009ef:	c1 e0 02             	shl    $0x2,%eax
  8009f2:	01 d0                	add    %edx,%eax
  8009f4:	01 c0                	add    %eax,%eax
  8009f6:	01 d8                	add    %ebx,%eax
  8009f8:	83 e8 30             	sub    $0x30,%eax
  8009fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800a01:	8a 00                	mov    (%eax),%al
  800a03:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a06:	83 fb 2f             	cmp    $0x2f,%ebx
  800a09:	7e 3e                	jle    800a49 <vprintfmt+0xe9>
  800a0b:	83 fb 39             	cmp    $0x39,%ebx
  800a0e:	7f 39                	jg     800a49 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a10:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a13:	eb d5                	jmp    8009ea <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a15:	8b 45 14             	mov    0x14(%ebp),%eax
  800a18:	83 c0 04             	add    $0x4,%eax
  800a1b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a1e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a21:	83 e8 04             	sub    $0x4,%eax
  800a24:	8b 00                	mov    (%eax),%eax
  800a26:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a29:	eb 1f                	jmp    800a4a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a2b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2f:	79 83                	jns    8009b4 <vprintfmt+0x54>
				width = 0;
  800a31:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a38:	e9 77 ff ff ff       	jmp    8009b4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a3d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a44:	e9 6b ff ff ff       	jmp    8009b4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a49:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a4a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a4e:	0f 89 60 ff ff ff    	jns    8009b4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a54:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a57:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a5a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a61:	e9 4e ff ff ff       	jmp    8009b4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a66:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a69:	e9 46 ff ff ff       	jmp    8009b4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a71:	83 c0 04             	add    $0x4,%eax
  800a74:	89 45 14             	mov    %eax,0x14(%ebp)
  800a77:	8b 45 14             	mov    0x14(%ebp),%eax
  800a7a:	83 e8 04             	sub    $0x4,%eax
  800a7d:	8b 00                	mov    (%eax),%eax
  800a7f:	83 ec 08             	sub    $0x8,%esp
  800a82:	ff 75 0c             	pushl  0xc(%ebp)
  800a85:	50                   	push   %eax
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	ff d0                	call   *%eax
  800a8b:	83 c4 10             	add    $0x10,%esp
			break;
  800a8e:	e9 89 02 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a93:	8b 45 14             	mov    0x14(%ebp),%eax
  800a96:	83 c0 04             	add    $0x4,%eax
  800a99:	89 45 14             	mov    %eax,0x14(%ebp)
  800a9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9f:	83 e8 04             	sub    $0x4,%eax
  800aa2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800aa4:	85 db                	test   %ebx,%ebx
  800aa6:	79 02                	jns    800aaa <vprintfmt+0x14a>
				err = -err;
  800aa8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800aaa:	83 fb 64             	cmp    $0x64,%ebx
  800aad:	7f 0b                	jg     800aba <vprintfmt+0x15a>
  800aaf:	8b 34 9d 00 23 80 00 	mov    0x802300(,%ebx,4),%esi
  800ab6:	85 f6                	test   %esi,%esi
  800ab8:	75 19                	jne    800ad3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800aba:	53                   	push   %ebx
  800abb:	68 a5 24 80 00       	push   $0x8024a5
  800ac0:	ff 75 0c             	pushl  0xc(%ebp)
  800ac3:	ff 75 08             	pushl  0x8(%ebp)
  800ac6:	e8 5e 02 00 00       	call   800d29 <printfmt>
  800acb:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ace:	e9 49 02 00 00       	jmp    800d1c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ad3:	56                   	push   %esi
  800ad4:	68 ae 24 80 00       	push   $0x8024ae
  800ad9:	ff 75 0c             	pushl  0xc(%ebp)
  800adc:	ff 75 08             	pushl  0x8(%ebp)
  800adf:	e8 45 02 00 00       	call   800d29 <printfmt>
  800ae4:	83 c4 10             	add    $0x10,%esp
			break;
  800ae7:	e9 30 02 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800aec:	8b 45 14             	mov    0x14(%ebp),%eax
  800aef:	83 c0 04             	add    $0x4,%eax
  800af2:	89 45 14             	mov    %eax,0x14(%ebp)
  800af5:	8b 45 14             	mov    0x14(%ebp),%eax
  800af8:	83 e8 04             	sub    $0x4,%eax
  800afb:	8b 30                	mov    (%eax),%esi
  800afd:	85 f6                	test   %esi,%esi
  800aff:	75 05                	jne    800b06 <vprintfmt+0x1a6>
				p = "(null)";
  800b01:	be b1 24 80 00       	mov    $0x8024b1,%esi
			if (width > 0 && padc != '-')
  800b06:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b0a:	7e 6d                	jle    800b79 <vprintfmt+0x219>
  800b0c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b10:	74 67                	je     800b79 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b12:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	50                   	push   %eax
  800b19:	56                   	push   %esi
  800b1a:	e8 0c 03 00 00       	call   800e2b <strnlen>
  800b1f:	83 c4 10             	add    $0x10,%esp
  800b22:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b25:	eb 16                	jmp    800b3d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b27:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b2b:	83 ec 08             	sub    $0x8,%esp
  800b2e:	ff 75 0c             	pushl  0xc(%ebp)
  800b31:	50                   	push   %eax
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	ff d0                	call   *%eax
  800b37:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b3a:	ff 4d e4             	decl   -0x1c(%ebp)
  800b3d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b41:	7f e4                	jg     800b27 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b43:	eb 34                	jmp    800b79 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b45:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b49:	74 1c                	je     800b67 <vprintfmt+0x207>
  800b4b:	83 fb 1f             	cmp    $0x1f,%ebx
  800b4e:	7e 05                	jle    800b55 <vprintfmt+0x1f5>
  800b50:	83 fb 7e             	cmp    $0x7e,%ebx
  800b53:	7e 12                	jle    800b67 <vprintfmt+0x207>
					putch('?', putdat);
  800b55:	83 ec 08             	sub    $0x8,%esp
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	6a 3f                	push   $0x3f
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	ff d0                	call   *%eax
  800b62:	83 c4 10             	add    $0x10,%esp
  800b65:	eb 0f                	jmp    800b76 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	53                   	push   %ebx
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	ff d0                	call   *%eax
  800b73:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b76:	ff 4d e4             	decl   -0x1c(%ebp)
  800b79:	89 f0                	mov    %esi,%eax
  800b7b:	8d 70 01             	lea    0x1(%eax),%esi
  800b7e:	8a 00                	mov    (%eax),%al
  800b80:	0f be d8             	movsbl %al,%ebx
  800b83:	85 db                	test   %ebx,%ebx
  800b85:	74 24                	je     800bab <vprintfmt+0x24b>
  800b87:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b8b:	78 b8                	js     800b45 <vprintfmt+0x1e5>
  800b8d:	ff 4d e0             	decl   -0x20(%ebp)
  800b90:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b94:	79 af                	jns    800b45 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b96:	eb 13                	jmp    800bab <vprintfmt+0x24b>
				putch(' ', putdat);
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 0c             	pushl  0xc(%ebp)
  800b9e:	6a 20                	push   $0x20
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	ff d0                	call   *%eax
  800ba5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ba8:	ff 4d e4             	decl   -0x1c(%ebp)
  800bab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800baf:	7f e7                	jg     800b98 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800bb1:	e9 66 01 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800bb6:	83 ec 08             	sub    $0x8,%esp
  800bb9:	ff 75 e8             	pushl  -0x18(%ebp)
  800bbc:	8d 45 14             	lea    0x14(%ebp),%eax
  800bbf:	50                   	push   %eax
  800bc0:	e8 3c fd ff ff       	call   800901 <getint>
  800bc5:	83 c4 10             	add    $0x10,%esp
  800bc8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bcb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bd1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bd4:	85 d2                	test   %edx,%edx
  800bd6:	79 23                	jns    800bfb <vprintfmt+0x29b>
				putch('-', putdat);
  800bd8:	83 ec 08             	sub    $0x8,%esp
  800bdb:	ff 75 0c             	pushl  0xc(%ebp)
  800bde:	6a 2d                	push   $0x2d
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	ff d0                	call   *%eax
  800be5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800beb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bee:	f7 d8                	neg    %eax
  800bf0:	83 d2 00             	adc    $0x0,%edx
  800bf3:	f7 da                	neg    %edx
  800bf5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bfb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c02:	e9 bc 00 00 00       	jmp    800cc3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c07:	83 ec 08             	sub    $0x8,%esp
  800c0a:	ff 75 e8             	pushl  -0x18(%ebp)
  800c0d:	8d 45 14             	lea    0x14(%ebp),%eax
  800c10:	50                   	push   %eax
  800c11:	e8 84 fc ff ff       	call   80089a <getuint>
  800c16:	83 c4 10             	add    $0x10,%esp
  800c19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c1c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c1f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c26:	e9 98 00 00 00       	jmp    800cc3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c2b:	83 ec 08             	sub    $0x8,%esp
  800c2e:	ff 75 0c             	pushl  0xc(%ebp)
  800c31:	6a 58                	push   $0x58
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	ff d0                	call   *%eax
  800c38:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c3b:	83 ec 08             	sub    $0x8,%esp
  800c3e:	ff 75 0c             	pushl  0xc(%ebp)
  800c41:	6a 58                	push   $0x58
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	ff d0                	call   *%eax
  800c48:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c4b:	83 ec 08             	sub    $0x8,%esp
  800c4e:	ff 75 0c             	pushl  0xc(%ebp)
  800c51:	6a 58                	push   $0x58
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	ff d0                	call   *%eax
  800c58:	83 c4 10             	add    $0x10,%esp
			break;
  800c5b:	e9 bc 00 00 00       	jmp    800d1c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c60:	83 ec 08             	sub    $0x8,%esp
  800c63:	ff 75 0c             	pushl  0xc(%ebp)
  800c66:	6a 30                	push   $0x30
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	ff d0                	call   *%eax
  800c6d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c70:	83 ec 08             	sub    $0x8,%esp
  800c73:	ff 75 0c             	pushl  0xc(%ebp)
  800c76:	6a 78                	push   $0x78
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	ff d0                	call   *%eax
  800c7d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c80:	8b 45 14             	mov    0x14(%ebp),%eax
  800c83:	83 c0 04             	add    $0x4,%eax
  800c86:	89 45 14             	mov    %eax,0x14(%ebp)
  800c89:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8c:	83 e8 04             	sub    $0x4,%eax
  800c8f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c91:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c9b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ca2:	eb 1f                	jmp    800cc3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ca4:	83 ec 08             	sub    $0x8,%esp
  800ca7:	ff 75 e8             	pushl  -0x18(%ebp)
  800caa:	8d 45 14             	lea    0x14(%ebp),%eax
  800cad:	50                   	push   %eax
  800cae:	e8 e7 fb ff ff       	call   80089a <getuint>
  800cb3:	83 c4 10             	add    $0x10,%esp
  800cb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cb9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800cbc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800cc3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800cc7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cca:	83 ec 04             	sub    $0x4,%esp
  800ccd:	52                   	push   %edx
  800cce:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cd1:	50                   	push   %eax
  800cd2:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd5:	ff 75 f0             	pushl  -0x10(%ebp)
  800cd8:	ff 75 0c             	pushl  0xc(%ebp)
  800cdb:	ff 75 08             	pushl  0x8(%ebp)
  800cde:	e8 00 fb ff ff       	call   8007e3 <printnum>
  800ce3:	83 c4 20             	add    $0x20,%esp
			break;
  800ce6:	eb 34                	jmp    800d1c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ce8:	83 ec 08             	sub    $0x8,%esp
  800ceb:	ff 75 0c             	pushl  0xc(%ebp)
  800cee:	53                   	push   %ebx
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	ff d0                	call   *%eax
  800cf4:	83 c4 10             	add    $0x10,%esp
			break;
  800cf7:	eb 23                	jmp    800d1c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cf9:	83 ec 08             	sub    $0x8,%esp
  800cfc:	ff 75 0c             	pushl  0xc(%ebp)
  800cff:	6a 25                	push   $0x25
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	ff d0                	call   *%eax
  800d06:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d09:	ff 4d 10             	decl   0x10(%ebp)
  800d0c:	eb 03                	jmp    800d11 <vprintfmt+0x3b1>
  800d0e:	ff 4d 10             	decl   0x10(%ebp)
  800d11:	8b 45 10             	mov    0x10(%ebp),%eax
  800d14:	48                   	dec    %eax
  800d15:	8a 00                	mov    (%eax),%al
  800d17:	3c 25                	cmp    $0x25,%al
  800d19:	75 f3                	jne    800d0e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d1b:	90                   	nop
		}
	}
  800d1c:	e9 47 fc ff ff       	jmp    800968 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d21:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d22:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d25:	5b                   	pop    %ebx
  800d26:	5e                   	pop    %esi
  800d27:	5d                   	pop    %ebp
  800d28:	c3                   	ret    

00800d29 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d29:	55                   	push   %ebp
  800d2a:	89 e5                	mov    %esp,%ebp
  800d2c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d2f:	8d 45 10             	lea    0x10(%ebp),%eax
  800d32:	83 c0 04             	add    $0x4,%eax
  800d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d38:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d3e:	50                   	push   %eax
  800d3f:	ff 75 0c             	pushl  0xc(%ebp)
  800d42:	ff 75 08             	pushl  0x8(%ebp)
  800d45:	e8 16 fc ff ff       	call   800960 <vprintfmt>
  800d4a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d4d:	90                   	nop
  800d4e:	c9                   	leave  
  800d4f:	c3                   	ret    

00800d50 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d50:	55                   	push   %ebp
  800d51:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d56:	8b 40 08             	mov    0x8(%eax),%eax
  800d59:	8d 50 01             	lea    0x1(%eax),%edx
  800d5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d65:	8b 10                	mov    (%eax),%edx
  800d67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6a:	8b 40 04             	mov    0x4(%eax),%eax
  800d6d:	39 c2                	cmp    %eax,%edx
  800d6f:	73 12                	jae    800d83 <sprintputch+0x33>
		*b->buf++ = ch;
  800d71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d74:	8b 00                	mov    (%eax),%eax
  800d76:	8d 48 01             	lea    0x1(%eax),%ecx
  800d79:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d7c:	89 0a                	mov    %ecx,(%edx)
  800d7e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d81:	88 10                	mov    %dl,(%eax)
}
  800d83:	90                   	nop
  800d84:	5d                   	pop    %ebp
  800d85:	c3                   	ret    

00800d86 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d86:	55                   	push   %ebp
  800d87:	89 e5                	mov    %esp,%ebp
  800d89:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d95:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	01 d0                	add    %edx,%eax
  800d9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800da0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800da7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dab:	74 06                	je     800db3 <vsnprintf+0x2d>
  800dad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db1:	7f 07                	jg     800dba <vsnprintf+0x34>
		return -E_INVAL;
  800db3:	b8 03 00 00 00       	mov    $0x3,%eax
  800db8:	eb 20                	jmp    800dda <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800dba:	ff 75 14             	pushl  0x14(%ebp)
  800dbd:	ff 75 10             	pushl  0x10(%ebp)
  800dc0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800dc3:	50                   	push   %eax
  800dc4:	68 50 0d 80 00       	push   $0x800d50
  800dc9:	e8 92 fb ff ff       	call   800960 <vprintfmt>
  800dce:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800dd1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dd4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800dd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dda:	c9                   	leave  
  800ddb:	c3                   	ret    

00800ddc <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ddc:	55                   	push   %ebp
  800ddd:	89 e5                	mov    %esp,%ebp
  800ddf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800de2:	8d 45 10             	lea    0x10(%ebp),%eax
  800de5:	83 c0 04             	add    $0x4,%eax
  800de8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800deb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dee:	ff 75 f4             	pushl  -0xc(%ebp)
  800df1:	50                   	push   %eax
  800df2:	ff 75 0c             	pushl  0xc(%ebp)
  800df5:	ff 75 08             	pushl  0x8(%ebp)
  800df8:	e8 89 ff ff ff       	call   800d86 <vsnprintf>
  800dfd:	83 c4 10             	add    $0x10,%esp
  800e00:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e03:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e06:	c9                   	leave  
  800e07:	c3                   	ret    

00800e08 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e08:	55                   	push   %ebp
  800e09:	89 e5                	mov    %esp,%ebp
  800e0b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e15:	eb 06                	jmp    800e1d <strlen+0x15>
		n++;
  800e17:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e1a:	ff 45 08             	incl   0x8(%ebp)
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	8a 00                	mov    (%eax),%al
  800e22:	84 c0                	test   %al,%al
  800e24:	75 f1                	jne    800e17 <strlen+0xf>
		n++;
	return n;
  800e26:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e29:	c9                   	leave  
  800e2a:	c3                   	ret    

00800e2b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e2b:	55                   	push   %ebp
  800e2c:	89 e5                	mov    %esp,%ebp
  800e2e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e38:	eb 09                	jmp    800e43 <strnlen+0x18>
		n++;
  800e3a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e3d:	ff 45 08             	incl   0x8(%ebp)
  800e40:	ff 4d 0c             	decl   0xc(%ebp)
  800e43:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e47:	74 09                	je     800e52 <strnlen+0x27>
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	8a 00                	mov    (%eax),%al
  800e4e:	84 c0                	test   %al,%al
  800e50:	75 e8                	jne    800e3a <strnlen+0xf>
		n++;
	return n;
  800e52:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e55:	c9                   	leave  
  800e56:	c3                   	ret    

00800e57 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e57:	55                   	push   %ebp
  800e58:	89 e5                	mov    %esp,%ebp
  800e5a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e63:	90                   	nop
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8d 50 01             	lea    0x1(%eax),%edx
  800e6a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e70:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e73:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e76:	8a 12                	mov    (%edx),%dl
  800e78:	88 10                	mov    %dl,(%eax)
  800e7a:	8a 00                	mov    (%eax),%al
  800e7c:	84 c0                	test   %al,%al
  800e7e:	75 e4                	jne    800e64 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e80:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e83:	c9                   	leave  
  800e84:	c3                   	ret    

00800e85 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e85:	55                   	push   %ebp
  800e86:	89 e5                	mov    %esp,%ebp
  800e88:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e98:	eb 1f                	jmp    800eb9 <strncpy+0x34>
		*dst++ = *src;
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	8d 50 01             	lea    0x1(%eax),%edx
  800ea0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ea3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea6:	8a 12                	mov    (%edx),%dl
  800ea8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	84 c0                	test   %al,%al
  800eb1:	74 03                	je     800eb6 <strncpy+0x31>
			src++;
  800eb3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800eb6:	ff 45 fc             	incl   -0x4(%ebp)
  800eb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebc:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ebf:	72 d9                	jb     800e9a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ec1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ec4:	c9                   	leave  
  800ec5:	c3                   	ret    

00800ec6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ec6:	55                   	push   %ebp
  800ec7:	89 e5                	mov    %esp,%ebp
  800ec9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ed2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed6:	74 30                	je     800f08 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ed8:	eb 16                	jmp    800ef0 <strlcpy+0x2a>
			*dst++ = *src++;
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	8d 50 01             	lea    0x1(%eax),%edx
  800ee0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ee3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ee6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ee9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800eec:	8a 12                	mov    (%edx),%dl
  800eee:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ef0:	ff 4d 10             	decl   0x10(%ebp)
  800ef3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef7:	74 09                	je     800f02 <strlcpy+0x3c>
  800ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	84 c0                	test   %al,%al
  800f00:	75 d8                	jne    800eda <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f08:	8b 55 08             	mov    0x8(%ebp),%edx
  800f0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0e:	29 c2                	sub    %eax,%edx
  800f10:	89 d0                	mov    %edx,%eax
}
  800f12:	c9                   	leave  
  800f13:	c3                   	ret    

00800f14 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f14:	55                   	push   %ebp
  800f15:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f17:	eb 06                	jmp    800f1f <strcmp+0xb>
		p++, q++;
  800f19:	ff 45 08             	incl   0x8(%ebp)
  800f1c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	84 c0                	test   %al,%al
  800f26:	74 0e                	je     800f36 <strcmp+0x22>
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 10                	mov    (%eax),%dl
  800f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f30:	8a 00                	mov    (%eax),%al
  800f32:	38 c2                	cmp    %al,%dl
  800f34:	74 e3                	je     800f19 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	0f b6 d0             	movzbl %al,%edx
  800f3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	0f b6 c0             	movzbl %al,%eax
  800f46:	29 c2                	sub    %eax,%edx
  800f48:	89 d0                	mov    %edx,%eax
}
  800f4a:	5d                   	pop    %ebp
  800f4b:	c3                   	ret    

00800f4c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f4c:	55                   	push   %ebp
  800f4d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f4f:	eb 09                	jmp    800f5a <strncmp+0xe>
		n--, p++, q++;
  800f51:	ff 4d 10             	decl   0x10(%ebp)
  800f54:	ff 45 08             	incl   0x8(%ebp)
  800f57:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5e:	74 17                	je     800f77 <strncmp+0x2b>
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	84 c0                	test   %al,%al
  800f67:	74 0e                	je     800f77 <strncmp+0x2b>
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8a 10                	mov    (%eax),%dl
  800f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	38 c2                	cmp    %al,%dl
  800f75:	74 da                	je     800f51 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f7b:	75 07                	jne    800f84 <strncmp+0x38>
		return 0;
  800f7d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f82:	eb 14                	jmp    800f98 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	0f b6 d0             	movzbl %al,%edx
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	8a 00                	mov    (%eax),%al
  800f91:	0f b6 c0             	movzbl %al,%eax
  800f94:	29 c2                	sub    %eax,%edx
  800f96:	89 d0                	mov    %edx,%eax
}
  800f98:	5d                   	pop    %ebp
  800f99:	c3                   	ret    

00800f9a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f9a:	55                   	push   %ebp
  800f9b:	89 e5                	mov    %esp,%ebp
  800f9d:	83 ec 04             	sub    $0x4,%esp
  800fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fa6:	eb 12                	jmp    800fba <strchr+0x20>
		if (*s == c)
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fb0:	75 05                	jne    800fb7 <strchr+0x1d>
			return (char *) s;
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	eb 11                	jmp    800fc8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fb7:	ff 45 08             	incl   0x8(%ebp)
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	84 c0                	test   %al,%al
  800fc1:	75 e5                	jne    800fa8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fc3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fc8:	c9                   	leave  
  800fc9:	c3                   	ret    

00800fca <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fca:	55                   	push   %ebp
  800fcb:	89 e5                	mov    %esp,%ebp
  800fcd:	83 ec 04             	sub    $0x4,%esp
  800fd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fd6:	eb 0d                	jmp    800fe5 <strfind+0x1b>
		if (*s == c)
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fe0:	74 0e                	je     800ff0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fe2:	ff 45 08             	incl   0x8(%ebp)
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	84 c0                	test   %al,%al
  800fec:	75 ea                	jne    800fd8 <strfind+0xe>
  800fee:	eb 01                	jmp    800ff1 <strfind+0x27>
		if (*s == c)
			break;
  800ff0:	90                   	nop
	return (char *) s;
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff4:	c9                   	leave  
  800ff5:	c3                   	ret    

00800ff6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801002:	8b 45 10             	mov    0x10(%ebp),%eax
  801005:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801008:	eb 0e                	jmp    801018 <memset+0x22>
		*p++ = c;
  80100a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100d:	8d 50 01             	lea    0x1(%eax),%edx
  801010:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801013:	8b 55 0c             	mov    0xc(%ebp),%edx
  801016:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801018:	ff 4d f8             	decl   -0x8(%ebp)
  80101b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80101f:	79 e9                	jns    80100a <memset+0x14>
		*p++ = c;

	return v;
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801024:	c9                   	leave  
  801025:	c3                   	ret    

00801026 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801026:	55                   	push   %ebp
  801027:	89 e5                	mov    %esp,%ebp
  801029:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80102c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801038:	eb 16                	jmp    801050 <memcpy+0x2a>
		*d++ = *s++;
  80103a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103d:	8d 50 01             	lea    0x1(%eax),%edx
  801040:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801043:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801046:	8d 4a 01             	lea    0x1(%edx),%ecx
  801049:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80104c:	8a 12                	mov    (%edx),%dl
  80104e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801050:	8b 45 10             	mov    0x10(%ebp),%eax
  801053:	8d 50 ff             	lea    -0x1(%eax),%edx
  801056:	89 55 10             	mov    %edx,0x10(%ebp)
  801059:	85 c0                	test   %eax,%eax
  80105b:	75 dd                	jne    80103a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801060:	c9                   	leave  
  801061:	c3                   	ret    

00801062 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801062:	55                   	push   %ebp
  801063:	89 e5                	mov    %esp,%ebp
  801065:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801068:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801074:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801077:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80107a:	73 50                	jae    8010cc <memmove+0x6a>
  80107c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80107f:	8b 45 10             	mov    0x10(%ebp),%eax
  801082:	01 d0                	add    %edx,%eax
  801084:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801087:	76 43                	jbe    8010cc <memmove+0x6a>
		s += n;
  801089:	8b 45 10             	mov    0x10(%ebp),%eax
  80108c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80108f:	8b 45 10             	mov    0x10(%ebp),%eax
  801092:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801095:	eb 10                	jmp    8010a7 <memmove+0x45>
			*--d = *--s;
  801097:	ff 4d f8             	decl   -0x8(%ebp)
  80109a:	ff 4d fc             	decl   -0x4(%ebp)
  80109d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a0:	8a 10                	mov    (%eax),%dl
  8010a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010aa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b0:	85 c0                	test   %eax,%eax
  8010b2:	75 e3                	jne    801097 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010b4:	eb 23                	jmp    8010d9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b9:	8d 50 01             	lea    0x1(%eax),%edx
  8010bc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010c2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010c8:	8a 12                	mov    (%edx),%dl
  8010ca:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d5:	85 c0                	test   %eax,%eax
  8010d7:	75 dd                	jne    8010b6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010dc:	c9                   	leave  
  8010dd:	c3                   	ret    

008010de <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010de:	55                   	push   %ebp
  8010df:	89 e5                	mov    %esp,%ebp
  8010e1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ed:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010f0:	eb 2a                	jmp    80111c <memcmp+0x3e>
		if (*s1 != *s2)
  8010f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f5:	8a 10                	mov    (%eax),%dl
  8010f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fa:	8a 00                	mov    (%eax),%al
  8010fc:	38 c2                	cmp    %al,%dl
  8010fe:	74 16                	je     801116 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801100:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801103:	8a 00                	mov    (%eax),%al
  801105:	0f b6 d0             	movzbl %al,%edx
  801108:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110b:	8a 00                	mov    (%eax),%al
  80110d:	0f b6 c0             	movzbl %al,%eax
  801110:	29 c2                	sub    %eax,%edx
  801112:	89 d0                	mov    %edx,%eax
  801114:	eb 18                	jmp    80112e <memcmp+0x50>
		s1++, s2++;
  801116:	ff 45 fc             	incl   -0x4(%ebp)
  801119:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80111c:	8b 45 10             	mov    0x10(%ebp),%eax
  80111f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801122:	89 55 10             	mov    %edx,0x10(%ebp)
  801125:	85 c0                	test   %eax,%eax
  801127:	75 c9                	jne    8010f2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801129:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80112e:	c9                   	leave  
  80112f:	c3                   	ret    

00801130 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801130:	55                   	push   %ebp
  801131:	89 e5                	mov    %esp,%ebp
  801133:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801136:	8b 55 08             	mov    0x8(%ebp),%edx
  801139:	8b 45 10             	mov    0x10(%ebp),%eax
  80113c:	01 d0                	add    %edx,%eax
  80113e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801141:	eb 15                	jmp    801158 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	0f b6 d0             	movzbl %al,%edx
  80114b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114e:	0f b6 c0             	movzbl %al,%eax
  801151:	39 c2                	cmp    %eax,%edx
  801153:	74 0d                	je     801162 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801155:	ff 45 08             	incl   0x8(%ebp)
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80115e:	72 e3                	jb     801143 <memfind+0x13>
  801160:	eb 01                	jmp    801163 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801162:	90                   	nop
	return (void *) s;
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
  80116b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80116e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801175:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80117c:	eb 03                	jmp    801181 <strtol+0x19>
		s++;
  80117e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	3c 20                	cmp    $0x20,%al
  801188:	74 f4                	je     80117e <strtol+0x16>
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	3c 09                	cmp    $0x9,%al
  801191:	74 eb                	je     80117e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	8a 00                	mov    (%eax),%al
  801198:	3c 2b                	cmp    $0x2b,%al
  80119a:	75 05                	jne    8011a1 <strtol+0x39>
		s++;
  80119c:	ff 45 08             	incl   0x8(%ebp)
  80119f:	eb 13                	jmp    8011b4 <strtol+0x4c>
	else if (*s == '-')
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	3c 2d                	cmp    $0x2d,%al
  8011a8:	75 0a                	jne    8011b4 <strtol+0x4c>
		s++, neg = 1;
  8011aa:	ff 45 08             	incl   0x8(%ebp)
  8011ad:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b8:	74 06                	je     8011c0 <strtol+0x58>
  8011ba:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011be:	75 20                	jne    8011e0 <strtol+0x78>
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3c 30                	cmp    $0x30,%al
  8011c7:	75 17                	jne    8011e0 <strtol+0x78>
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	40                   	inc    %eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	3c 78                	cmp    $0x78,%al
  8011d1:	75 0d                	jne    8011e0 <strtol+0x78>
		s += 2, base = 16;
  8011d3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011d7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011de:	eb 28                	jmp    801208 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011e4:	75 15                	jne    8011fb <strtol+0x93>
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	3c 30                	cmp    $0x30,%al
  8011ed:	75 0c                	jne    8011fb <strtol+0x93>
		s++, base = 8;
  8011ef:	ff 45 08             	incl   0x8(%ebp)
  8011f2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011f9:	eb 0d                	jmp    801208 <strtol+0xa0>
	else if (base == 0)
  8011fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ff:	75 07                	jne    801208 <strtol+0xa0>
		base = 10;
  801201:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	3c 2f                	cmp    $0x2f,%al
  80120f:	7e 19                	jle    80122a <strtol+0xc2>
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	3c 39                	cmp    $0x39,%al
  801218:	7f 10                	jg     80122a <strtol+0xc2>
			dig = *s - '0';
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	0f be c0             	movsbl %al,%eax
  801222:	83 e8 30             	sub    $0x30,%eax
  801225:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801228:	eb 42                	jmp    80126c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	8a 00                	mov    (%eax),%al
  80122f:	3c 60                	cmp    $0x60,%al
  801231:	7e 19                	jle    80124c <strtol+0xe4>
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	3c 7a                	cmp    $0x7a,%al
  80123a:	7f 10                	jg     80124c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	8a 00                	mov    (%eax),%al
  801241:	0f be c0             	movsbl %al,%eax
  801244:	83 e8 57             	sub    $0x57,%eax
  801247:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80124a:	eb 20                	jmp    80126c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80124c:	8b 45 08             	mov    0x8(%ebp),%eax
  80124f:	8a 00                	mov    (%eax),%al
  801251:	3c 40                	cmp    $0x40,%al
  801253:	7e 39                	jle    80128e <strtol+0x126>
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	8a 00                	mov    (%eax),%al
  80125a:	3c 5a                	cmp    $0x5a,%al
  80125c:	7f 30                	jg     80128e <strtol+0x126>
			dig = *s - 'A' + 10;
  80125e:	8b 45 08             	mov    0x8(%ebp),%eax
  801261:	8a 00                	mov    (%eax),%al
  801263:	0f be c0             	movsbl %al,%eax
  801266:	83 e8 37             	sub    $0x37,%eax
  801269:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80126c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80126f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801272:	7d 19                	jge    80128d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801274:	ff 45 08             	incl   0x8(%ebp)
  801277:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80127e:	89 c2                	mov    %eax,%edx
  801280:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801283:	01 d0                	add    %edx,%eax
  801285:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801288:	e9 7b ff ff ff       	jmp    801208 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80128d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80128e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801292:	74 08                	je     80129c <strtol+0x134>
		*endptr = (char *) s;
  801294:	8b 45 0c             	mov    0xc(%ebp),%eax
  801297:	8b 55 08             	mov    0x8(%ebp),%edx
  80129a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80129c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012a0:	74 07                	je     8012a9 <strtol+0x141>
  8012a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a5:	f7 d8                	neg    %eax
  8012a7:	eb 03                	jmp    8012ac <strtol+0x144>
  8012a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <ltostr>:

void
ltostr(long value, char *str)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
  8012b1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012c6:	79 13                	jns    8012db <ltostr+0x2d>
	{
		neg = 1;
  8012c8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012d5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012d8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012e3:	99                   	cltd   
  8012e4:	f7 f9                	idiv   %ecx
  8012e6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ec:	8d 50 01             	lea    0x1(%eax),%edx
  8012ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012f2:	89 c2                	mov    %eax,%edx
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	01 d0                	add    %edx,%eax
  8012f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012fc:	83 c2 30             	add    $0x30,%edx
  8012ff:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801301:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801304:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801309:	f7 e9                	imul   %ecx
  80130b:	c1 fa 02             	sar    $0x2,%edx
  80130e:	89 c8                	mov    %ecx,%eax
  801310:	c1 f8 1f             	sar    $0x1f,%eax
  801313:	29 c2                	sub    %eax,%edx
  801315:	89 d0                	mov    %edx,%eax
  801317:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80131a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80131d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801322:	f7 e9                	imul   %ecx
  801324:	c1 fa 02             	sar    $0x2,%edx
  801327:	89 c8                	mov    %ecx,%eax
  801329:	c1 f8 1f             	sar    $0x1f,%eax
  80132c:	29 c2                	sub    %eax,%edx
  80132e:	89 d0                	mov    %edx,%eax
  801330:	c1 e0 02             	shl    $0x2,%eax
  801333:	01 d0                	add    %edx,%eax
  801335:	01 c0                	add    %eax,%eax
  801337:	29 c1                	sub    %eax,%ecx
  801339:	89 ca                	mov    %ecx,%edx
  80133b:	85 d2                	test   %edx,%edx
  80133d:	75 9c                	jne    8012db <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80133f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801346:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801349:	48                   	dec    %eax
  80134a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80134d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801351:	74 3d                	je     801390 <ltostr+0xe2>
		start = 1 ;
  801353:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80135a:	eb 34                	jmp    801390 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80135c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80135f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801362:	01 d0                	add    %edx,%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801369:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80136c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136f:	01 c2                	add    %eax,%edx
  801371:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801374:	8b 45 0c             	mov    0xc(%ebp),%eax
  801377:	01 c8                	add    %ecx,%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80137d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801380:	8b 45 0c             	mov    0xc(%ebp),%eax
  801383:	01 c2                	add    %eax,%edx
  801385:	8a 45 eb             	mov    -0x15(%ebp),%al
  801388:	88 02                	mov    %al,(%edx)
		start++ ;
  80138a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80138d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801390:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801393:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801396:	7c c4                	jl     80135c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801398:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80139b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139e:	01 d0                	add    %edx,%eax
  8013a0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013a3:	90                   	nop
  8013a4:	c9                   	leave  
  8013a5:	c3                   	ret    

008013a6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
  8013a9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013ac:	ff 75 08             	pushl  0x8(%ebp)
  8013af:	e8 54 fa ff ff       	call   800e08 <strlen>
  8013b4:	83 c4 04             	add    $0x4,%esp
  8013b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013ba:	ff 75 0c             	pushl  0xc(%ebp)
  8013bd:	e8 46 fa ff ff       	call   800e08 <strlen>
  8013c2:	83 c4 04             	add    $0x4,%esp
  8013c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013d6:	eb 17                	jmp    8013ef <strcconcat+0x49>
		final[s] = str1[s] ;
  8013d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013db:	8b 45 10             	mov    0x10(%ebp),%eax
  8013de:	01 c2                	add    %eax,%edx
  8013e0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	01 c8                	add    %ecx,%eax
  8013e8:	8a 00                	mov    (%eax),%al
  8013ea:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013ec:	ff 45 fc             	incl   -0x4(%ebp)
  8013ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013f5:	7c e1                	jl     8013d8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013f7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801405:	eb 1f                	jmp    801426 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140a:	8d 50 01             	lea    0x1(%eax),%edx
  80140d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801410:	89 c2                	mov    %eax,%edx
  801412:	8b 45 10             	mov    0x10(%ebp),%eax
  801415:	01 c2                	add    %eax,%edx
  801417:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80141a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141d:	01 c8                	add    %ecx,%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801423:	ff 45 f8             	incl   -0x8(%ebp)
  801426:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801429:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80142c:	7c d9                	jl     801407 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80142e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801431:	8b 45 10             	mov    0x10(%ebp),%eax
  801434:	01 d0                	add    %edx,%eax
  801436:	c6 00 00             	movb   $0x0,(%eax)
}
  801439:	90                   	nop
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80143f:	8b 45 14             	mov    0x14(%ebp),%eax
  801442:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801448:	8b 45 14             	mov    0x14(%ebp),%eax
  80144b:	8b 00                	mov    (%eax),%eax
  80144d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801454:	8b 45 10             	mov    0x10(%ebp),%eax
  801457:	01 d0                	add    %edx,%eax
  801459:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80145f:	eb 0c                	jmp    80146d <strsplit+0x31>
			*string++ = 0;
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	8d 50 01             	lea    0x1(%eax),%edx
  801467:	89 55 08             	mov    %edx,0x8(%ebp)
  80146a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	84 c0                	test   %al,%al
  801474:	74 18                	je     80148e <strsplit+0x52>
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	8a 00                	mov    (%eax),%al
  80147b:	0f be c0             	movsbl %al,%eax
  80147e:	50                   	push   %eax
  80147f:	ff 75 0c             	pushl  0xc(%ebp)
  801482:	e8 13 fb ff ff       	call   800f9a <strchr>
  801487:	83 c4 08             	add    $0x8,%esp
  80148a:	85 c0                	test   %eax,%eax
  80148c:	75 d3                	jne    801461 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80148e:	8b 45 08             	mov    0x8(%ebp),%eax
  801491:	8a 00                	mov    (%eax),%al
  801493:	84 c0                	test   %al,%al
  801495:	74 5a                	je     8014f1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801497:	8b 45 14             	mov    0x14(%ebp),%eax
  80149a:	8b 00                	mov    (%eax),%eax
  80149c:	83 f8 0f             	cmp    $0xf,%eax
  80149f:	75 07                	jne    8014a8 <strsplit+0x6c>
		{
			return 0;
  8014a1:	b8 00 00 00 00       	mov    $0x0,%eax
  8014a6:	eb 66                	jmp    80150e <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ab:	8b 00                	mov    (%eax),%eax
  8014ad:	8d 48 01             	lea    0x1(%eax),%ecx
  8014b0:	8b 55 14             	mov    0x14(%ebp),%edx
  8014b3:	89 0a                	mov    %ecx,(%edx)
  8014b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bf:	01 c2                	add    %eax,%edx
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c6:	eb 03                	jmp    8014cb <strsplit+0x8f>
			string++;
  8014c8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	8a 00                	mov    (%eax),%al
  8014d0:	84 c0                	test   %al,%al
  8014d2:	74 8b                	je     80145f <strsplit+0x23>
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	8a 00                	mov    (%eax),%al
  8014d9:	0f be c0             	movsbl %al,%eax
  8014dc:	50                   	push   %eax
  8014dd:	ff 75 0c             	pushl  0xc(%ebp)
  8014e0:	e8 b5 fa ff ff       	call   800f9a <strchr>
  8014e5:	83 c4 08             	add    $0x8,%esp
  8014e8:	85 c0                	test   %eax,%eax
  8014ea:	74 dc                	je     8014c8 <strsplit+0x8c>
			string++;
	}
  8014ec:	e9 6e ff ff ff       	jmp    80145f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014f1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f5:	8b 00                	mov    (%eax),%eax
  8014f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801509:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
  801513:	83 ec 18             	sub    $0x18,%esp
  801516:	8b 45 10             	mov    0x10(%ebp),%eax
  801519:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80151c:	83 ec 04             	sub    $0x4,%esp
  80151f:	68 10 26 80 00       	push   $0x802610
  801524:	6a 17                	push   $0x17
  801526:	68 2f 26 80 00       	push   $0x80262f
  80152b:	e8 8a 08 00 00       	call   801dba <_panic>

00801530 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
  801533:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801536:	83 ec 04             	sub    $0x4,%esp
  801539:	68 3b 26 80 00       	push   $0x80263b
  80153e:	6a 2f                	push   $0x2f
  801540:	68 2f 26 80 00       	push   $0x80262f
  801545:	e8 70 08 00 00       	call   801dba <_panic>

0080154a <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
  80154d:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801550:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801557:	8b 55 08             	mov    0x8(%ebp),%edx
  80155a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80155d:	01 d0                	add    %edx,%eax
  80155f:	48                   	dec    %eax
  801560:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801563:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801566:	ba 00 00 00 00       	mov    $0x0,%edx
  80156b:	f7 75 ec             	divl   -0x14(%ebp)
  80156e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801571:	29 d0                	sub    %edx,%eax
  801573:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	c1 e8 0c             	shr    $0xc,%eax
  80157c:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80157f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801586:	e9 c8 00 00 00       	jmp    801653 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80158b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801592:	eb 27                	jmp    8015bb <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801594:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801597:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80159a:	01 c2                	add    %eax,%edx
  80159c:	89 d0                	mov    %edx,%eax
  80159e:	01 c0                	add    %eax,%eax
  8015a0:	01 d0                	add    %edx,%eax
  8015a2:	c1 e0 02             	shl    $0x2,%eax
  8015a5:	05 48 30 80 00       	add    $0x803048,%eax
  8015aa:	8b 00                	mov    (%eax),%eax
  8015ac:	85 c0                	test   %eax,%eax
  8015ae:	74 08                	je     8015b8 <malloc+0x6e>
            	i += j;
  8015b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015b3:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8015b6:	eb 0b                	jmp    8015c3 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8015b8:	ff 45 f0             	incl   -0x10(%ebp)
  8015bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015be:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015c1:	72 d1                	jb     801594 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8015c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015c6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015c9:	0f 85 81 00 00 00    	jne    801650 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8015cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015d2:	05 00 00 08 00       	add    $0x80000,%eax
  8015d7:	c1 e0 0c             	shl    $0xc,%eax
  8015da:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8015dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015e4:	eb 1f                	jmp    801605 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8015e6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ec:	01 c2                	add    %eax,%edx
  8015ee:	89 d0                	mov    %edx,%eax
  8015f0:	01 c0                	add    %eax,%eax
  8015f2:	01 d0                	add    %edx,%eax
  8015f4:	c1 e0 02             	shl    $0x2,%eax
  8015f7:	05 48 30 80 00       	add    $0x803048,%eax
  8015fc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801602:	ff 45 f0             	incl   -0x10(%ebp)
  801605:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801608:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80160b:	72 d9                	jb     8015e6 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80160d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801610:	89 d0                	mov    %edx,%eax
  801612:	01 c0                	add    %eax,%eax
  801614:	01 d0                	add    %edx,%eax
  801616:	c1 e0 02             	shl    $0x2,%eax
  801619:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80161f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801622:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801624:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801627:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80162a:	89 c8                	mov    %ecx,%eax
  80162c:	01 c0                	add    %eax,%eax
  80162e:	01 c8                	add    %ecx,%eax
  801630:	c1 e0 02             	shl    $0x2,%eax
  801633:	05 44 30 80 00       	add    $0x803044,%eax
  801638:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80163a:	83 ec 08             	sub    $0x8,%esp
  80163d:	ff 75 08             	pushl  0x8(%ebp)
  801640:	ff 75 e0             	pushl  -0x20(%ebp)
  801643:	e8 2b 03 00 00       	call   801973 <sys_allocateMem>
  801648:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80164b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80164e:	eb 19                	jmp    801669 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801650:	ff 45 f4             	incl   -0xc(%ebp)
  801653:	a1 04 30 80 00       	mov    0x803004,%eax
  801658:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80165b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80165e:	0f 83 27 ff ff ff    	jae    80158b <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801664:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801669:	c9                   	leave  
  80166a:	c3                   	ret    

0080166b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
  80166e:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801671:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801675:	0f 84 e5 00 00 00    	je     801760 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801681:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801684:	05 00 00 00 80       	add    $0x80000000,%eax
  801689:	c1 e8 0c             	shr    $0xc,%eax
  80168c:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80168f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801692:	89 d0                	mov    %edx,%eax
  801694:	01 c0                	add    %eax,%eax
  801696:	01 d0                	add    %edx,%eax
  801698:	c1 e0 02             	shl    $0x2,%eax
  80169b:	05 40 30 80 00       	add    $0x803040,%eax
  8016a0:	8b 00                	mov    (%eax),%eax
  8016a2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016a5:	0f 85 b8 00 00 00    	jne    801763 <free+0xf8>
  8016ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016ae:	89 d0                	mov    %edx,%eax
  8016b0:	01 c0                	add    %eax,%eax
  8016b2:	01 d0                	add    %edx,%eax
  8016b4:	c1 e0 02             	shl    $0x2,%eax
  8016b7:	05 48 30 80 00       	add    $0x803048,%eax
  8016bc:	8b 00                	mov    (%eax),%eax
  8016be:	85 c0                	test   %eax,%eax
  8016c0:	0f 84 9d 00 00 00    	je     801763 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8016c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016c9:	89 d0                	mov    %edx,%eax
  8016cb:	01 c0                	add    %eax,%eax
  8016cd:	01 d0                	add    %edx,%eax
  8016cf:	c1 e0 02             	shl    $0x2,%eax
  8016d2:	05 44 30 80 00       	add    $0x803044,%eax
  8016d7:	8b 00                	mov    (%eax),%eax
  8016d9:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8016dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016df:	c1 e0 0c             	shl    $0xc,%eax
  8016e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8016e5:	83 ec 08             	sub    $0x8,%esp
  8016e8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016eb:	ff 75 f0             	pushl  -0x10(%ebp)
  8016ee:	e8 64 02 00 00       	call   801957 <sys_freeMem>
  8016f3:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8016f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8016fd:	eb 57                	jmp    801756 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8016ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801702:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801705:	01 c2                	add    %eax,%edx
  801707:	89 d0                	mov    %edx,%eax
  801709:	01 c0                	add    %eax,%eax
  80170b:	01 d0                	add    %edx,%eax
  80170d:	c1 e0 02             	shl    $0x2,%eax
  801710:	05 48 30 80 00       	add    $0x803048,%eax
  801715:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80171b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80171e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801721:	01 c2                	add    %eax,%edx
  801723:	89 d0                	mov    %edx,%eax
  801725:	01 c0                	add    %eax,%eax
  801727:	01 d0                	add    %edx,%eax
  801729:	c1 e0 02             	shl    $0x2,%eax
  80172c:	05 40 30 80 00       	add    $0x803040,%eax
  801731:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801737:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80173a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80173d:	01 c2                	add    %eax,%edx
  80173f:	89 d0                	mov    %edx,%eax
  801741:	01 c0                	add    %eax,%eax
  801743:	01 d0                	add    %edx,%eax
  801745:	c1 e0 02             	shl    $0x2,%eax
  801748:	05 44 30 80 00       	add    $0x803044,%eax
  80174d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801753:	ff 45 f4             	incl   -0xc(%ebp)
  801756:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801759:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80175c:	7c a1                	jl     8016ff <free+0x94>
  80175e:	eb 04                	jmp    801764 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801760:	90                   	nop
  801761:	eb 01                	jmp    801764 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801763:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801764:	c9                   	leave  
  801765:	c3                   	ret    

00801766 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
  801769:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80176c:	83 ec 04             	sub    $0x4,%esp
  80176f:	68 58 26 80 00       	push   $0x802658
  801774:	68 ae 00 00 00       	push   $0xae
  801779:	68 2f 26 80 00       	push   $0x80262f
  80177e:	e8 37 06 00 00       	call   801dba <_panic>

00801783 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
  801786:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801789:	83 ec 04             	sub    $0x4,%esp
  80178c:	68 78 26 80 00       	push   $0x802678
  801791:	68 ca 00 00 00       	push   $0xca
  801796:	68 2f 26 80 00       	push   $0x80262f
  80179b:	e8 1a 06 00 00       	call   801dba <_panic>

008017a0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
  8017a3:	57                   	push   %edi
  8017a4:	56                   	push   %esi
  8017a5:	53                   	push   %ebx
  8017a6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017b5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8017b8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8017bb:	cd 30                	int    $0x30
  8017bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017c3:	83 c4 10             	add    $0x10,%esp
  8017c6:	5b                   	pop    %ebx
  8017c7:	5e                   	pop    %esi
  8017c8:	5f                   	pop    %edi
  8017c9:	5d                   	pop    %ebp
  8017ca:	c3                   	ret    

008017cb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
  8017ce:	83 ec 04             	sub    $0x4,%esp
  8017d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017d7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017db:	8b 45 08             	mov    0x8(%ebp),%eax
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	52                   	push   %edx
  8017e3:	ff 75 0c             	pushl  0xc(%ebp)
  8017e6:	50                   	push   %eax
  8017e7:	6a 00                	push   $0x0
  8017e9:	e8 b2 ff ff ff       	call   8017a0 <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
}
  8017f1:	90                   	nop
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 01                	push   $0x1
  801803:	e8 98 ff ff ff       	call   8017a0 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	50                   	push   %eax
  80181c:	6a 05                	push   $0x5
  80181e:	e8 7d ff ff ff       	call   8017a0 <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
}
  801826:	c9                   	leave  
  801827:	c3                   	ret    

00801828 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801828:	55                   	push   %ebp
  801829:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 02                	push   $0x2
  801837:	e8 64 ff ff ff       	call   8017a0 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
}
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 03                	push   $0x3
  801850:	e8 4b ff ff ff       	call   8017a0 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 04                	push   $0x4
  801869:	e8 32 ff ff ff       	call   8017a0 <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
}
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_env_exit>:


void sys_env_exit(void)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 06                	push   $0x6
  801882:	e8 19 ff ff ff       	call   8017a0 <syscall>
  801887:	83 c4 18             	add    $0x18,%esp
}
  80188a:	90                   	nop
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801890:	8b 55 0c             	mov    0xc(%ebp),%edx
  801893:	8b 45 08             	mov    0x8(%ebp),%eax
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	52                   	push   %edx
  80189d:	50                   	push   %eax
  80189e:	6a 07                	push   $0x7
  8018a0:	e8 fb fe ff ff       	call   8017a0 <syscall>
  8018a5:	83 c4 18             	add    $0x18,%esp
}
  8018a8:	c9                   	leave  
  8018a9:	c3                   	ret    

008018aa <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018aa:	55                   	push   %ebp
  8018ab:	89 e5                	mov    %esp,%ebp
  8018ad:	56                   	push   %esi
  8018ae:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018af:	8b 75 18             	mov    0x18(%ebp),%esi
  8018b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	56                   	push   %esi
  8018bf:	53                   	push   %ebx
  8018c0:	51                   	push   %ecx
  8018c1:	52                   	push   %edx
  8018c2:	50                   	push   %eax
  8018c3:	6a 08                	push   $0x8
  8018c5:	e8 d6 fe ff ff       	call   8017a0 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018d0:	5b                   	pop    %ebx
  8018d1:	5e                   	pop    %esi
  8018d2:	5d                   	pop    %ebp
  8018d3:	c3                   	ret    

008018d4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018da:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	52                   	push   %edx
  8018e4:	50                   	push   %eax
  8018e5:	6a 09                	push   $0x9
  8018e7:	e8 b4 fe ff ff       	call   8017a0 <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	ff 75 0c             	pushl  0xc(%ebp)
  8018fd:	ff 75 08             	pushl  0x8(%ebp)
  801900:	6a 0a                	push   $0xa
  801902:	e8 99 fe ff ff       	call   8017a0 <syscall>
  801907:	83 c4 18             	add    $0x18,%esp
}
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 0b                	push   $0xb
  80191b:	e8 80 fe ff ff       	call   8017a0 <syscall>
  801920:	83 c4 18             	add    $0x18,%esp
}
  801923:	c9                   	leave  
  801924:	c3                   	ret    

00801925 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801925:	55                   	push   %ebp
  801926:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 0c                	push   $0xc
  801934:	e8 67 fe ff ff       	call   8017a0 <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
}
  80193c:	c9                   	leave  
  80193d:	c3                   	ret    

0080193e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 0d                	push   $0xd
  80194d:	e8 4e fe ff ff       	call   8017a0 <syscall>
  801952:	83 c4 18             	add    $0x18,%esp
}
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	ff 75 0c             	pushl  0xc(%ebp)
  801963:	ff 75 08             	pushl  0x8(%ebp)
  801966:	6a 11                	push   $0x11
  801968:	e8 33 fe ff ff       	call   8017a0 <syscall>
  80196d:	83 c4 18             	add    $0x18,%esp
	return;
  801970:	90                   	nop
}
  801971:	c9                   	leave  
  801972:	c3                   	ret    

00801973 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801973:	55                   	push   %ebp
  801974:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	ff 75 0c             	pushl  0xc(%ebp)
  80197f:	ff 75 08             	pushl  0x8(%ebp)
  801982:	6a 12                	push   $0x12
  801984:	e8 17 fe ff ff       	call   8017a0 <syscall>
  801989:	83 c4 18             	add    $0x18,%esp
	return ;
  80198c:	90                   	nop
}
  80198d:	c9                   	leave  
  80198e:	c3                   	ret    

0080198f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80198f:	55                   	push   %ebp
  801990:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 0e                	push   $0xe
  80199e:	e8 fd fd ff ff       	call   8017a0 <syscall>
  8019a3:	83 c4 18             	add    $0x18,%esp
}
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	ff 75 08             	pushl  0x8(%ebp)
  8019b6:	6a 0f                	push   $0xf
  8019b8:	e8 e3 fd ff ff       	call   8017a0 <syscall>
  8019bd:	83 c4 18             	add    $0x18,%esp
}
  8019c0:	c9                   	leave  
  8019c1:	c3                   	ret    

008019c2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019c2:	55                   	push   %ebp
  8019c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 10                	push   $0x10
  8019d1:	e8 ca fd ff ff       	call   8017a0 <syscall>
  8019d6:	83 c4 18             	add    $0x18,%esp
}
  8019d9:	90                   	nop
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 14                	push   $0x14
  8019eb:	e8 b0 fd ff ff       	call   8017a0 <syscall>
  8019f0:	83 c4 18             	add    $0x18,%esp
}
  8019f3:	90                   	nop
  8019f4:	c9                   	leave  
  8019f5:	c3                   	ret    

008019f6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8019f6:	55                   	push   %ebp
  8019f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 15                	push   $0x15
  801a05:	e8 96 fd ff ff       	call   8017a0 <syscall>
  801a0a:	83 c4 18             	add    $0x18,%esp
}
  801a0d:	90                   	nop
  801a0e:	c9                   	leave  
  801a0f:	c3                   	ret    

00801a10 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
  801a13:	83 ec 04             	sub    $0x4,%esp
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a1c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	50                   	push   %eax
  801a29:	6a 16                	push   $0x16
  801a2b:	e8 70 fd ff ff       	call   8017a0 <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
}
  801a33:	90                   	nop
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 17                	push   $0x17
  801a45:	e8 56 fd ff ff       	call   8017a0 <syscall>
  801a4a:	83 c4 18             	add    $0x18,%esp
}
  801a4d:	90                   	nop
  801a4e:	c9                   	leave  
  801a4f:	c3                   	ret    

00801a50 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a50:	55                   	push   %ebp
  801a51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a53:	8b 45 08             	mov    0x8(%ebp),%eax
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	ff 75 0c             	pushl  0xc(%ebp)
  801a5f:	50                   	push   %eax
  801a60:	6a 18                	push   $0x18
  801a62:	e8 39 fd ff ff       	call   8017a0 <syscall>
  801a67:	83 c4 18             	add    $0x18,%esp
}
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a72:	8b 45 08             	mov    0x8(%ebp),%eax
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	52                   	push   %edx
  801a7c:	50                   	push   %eax
  801a7d:	6a 1b                	push   $0x1b
  801a7f:	e8 1c fd ff ff       	call   8017a0 <syscall>
  801a84:	83 c4 18             	add    $0x18,%esp
}
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	52                   	push   %edx
  801a99:	50                   	push   %eax
  801a9a:	6a 19                	push   $0x19
  801a9c:	e8 ff fc ff ff       	call   8017a0 <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
}
  801aa4:	90                   	nop
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801aaa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aad:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	52                   	push   %edx
  801ab7:	50                   	push   %eax
  801ab8:	6a 1a                	push   $0x1a
  801aba:	e8 e1 fc ff ff       	call   8017a0 <syscall>
  801abf:	83 c4 18             	add    $0x18,%esp
}
  801ac2:	90                   	nop
  801ac3:	c9                   	leave  
  801ac4:	c3                   	ret    

00801ac5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ac5:	55                   	push   %ebp
  801ac6:	89 e5                	mov    %esp,%ebp
  801ac8:	83 ec 04             	sub    $0x4,%esp
  801acb:	8b 45 10             	mov    0x10(%ebp),%eax
  801ace:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ad1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ad4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  801adb:	6a 00                	push   $0x0
  801add:	51                   	push   %ecx
  801ade:	52                   	push   %edx
  801adf:	ff 75 0c             	pushl  0xc(%ebp)
  801ae2:	50                   	push   %eax
  801ae3:	6a 1c                	push   $0x1c
  801ae5:	e8 b6 fc ff ff       	call   8017a0 <syscall>
  801aea:	83 c4 18             	add    $0x18,%esp
}
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801af2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af5:	8b 45 08             	mov    0x8(%ebp),%eax
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	52                   	push   %edx
  801aff:	50                   	push   %eax
  801b00:	6a 1d                	push   $0x1d
  801b02:	e8 99 fc ff ff       	call   8017a0 <syscall>
  801b07:	83 c4 18             	add    $0x18,%esp
}
  801b0a:	c9                   	leave  
  801b0b:	c3                   	ret    

00801b0c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b0c:	55                   	push   %ebp
  801b0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b0f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b15:	8b 45 08             	mov    0x8(%ebp),%eax
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	51                   	push   %ecx
  801b1d:	52                   	push   %edx
  801b1e:	50                   	push   %eax
  801b1f:	6a 1e                	push   $0x1e
  801b21:	e8 7a fc ff ff       	call   8017a0 <syscall>
  801b26:	83 c4 18             	add    $0x18,%esp
}
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b31:	8b 45 08             	mov    0x8(%ebp),%eax
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	52                   	push   %edx
  801b3b:	50                   	push   %eax
  801b3c:	6a 1f                	push   $0x1f
  801b3e:	e8 5d fc ff ff       	call   8017a0 <syscall>
  801b43:	83 c4 18             	add    $0x18,%esp
}
  801b46:	c9                   	leave  
  801b47:	c3                   	ret    

00801b48 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 20                	push   $0x20
  801b57:	e8 44 fc ff ff       	call   8017a0 <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	c9                   	leave  
  801b60:	c3                   	ret    

00801b61 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801b64:	8b 45 08             	mov    0x8(%ebp),%eax
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	ff 75 10             	pushl  0x10(%ebp)
  801b6e:	ff 75 0c             	pushl  0xc(%ebp)
  801b71:	50                   	push   %eax
  801b72:	6a 21                	push   $0x21
  801b74:	e8 27 fc ff ff       	call   8017a0 <syscall>
  801b79:	83 c4 18             	add    $0x18,%esp
}
  801b7c:	c9                   	leave  
  801b7d:	c3                   	ret    

00801b7e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b81:	8b 45 08             	mov    0x8(%ebp),%eax
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	50                   	push   %eax
  801b8d:	6a 22                	push   $0x22
  801b8f:	e8 0c fc ff ff       	call   8017a0 <syscall>
  801b94:	83 c4 18             	add    $0x18,%esp
}
  801b97:	90                   	nop
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	50                   	push   %eax
  801ba9:	6a 23                	push   $0x23
  801bab:	e8 f0 fb ff ff       	call   8017a0 <syscall>
  801bb0:	83 c4 18             	add    $0x18,%esp
}
  801bb3:	90                   	nop
  801bb4:	c9                   	leave  
  801bb5:	c3                   	ret    

00801bb6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801bb6:	55                   	push   %ebp
  801bb7:	89 e5                	mov    %esp,%ebp
  801bb9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801bbc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bbf:	8d 50 04             	lea    0x4(%eax),%edx
  801bc2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	52                   	push   %edx
  801bcc:	50                   	push   %eax
  801bcd:	6a 24                	push   $0x24
  801bcf:	e8 cc fb ff ff       	call   8017a0 <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
	return result;
  801bd7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801bda:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bdd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801be0:	89 01                	mov    %eax,(%ecx)
  801be2:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801be5:	8b 45 08             	mov    0x8(%ebp),%eax
  801be8:	c9                   	leave  
  801be9:	c2 04 00             	ret    $0x4

00801bec <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801bec:	55                   	push   %ebp
  801bed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	ff 75 10             	pushl  0x10(%ebp)
  801bf6:	ff 75 0c             	pushl  0xc(%ebp)
  801bf9:	ff 75 08             	pushl  0x8(%ebp)
  801bfc:	6a 13                	push   $0x13
  801bfe:	e8 9d fb ff ff       	call   8017a0 <syscall>
  801c03:	83 c4 18             	add    $0x18,%esp
	return ;
  801c06:	90                   	nop
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 25                	push   $0x25
  801c18:	e8 83 fb ff ff       	call   8017a0 <syscall>
  801c1d:	83 c4 18             	add    $0x18,%esp
}
  801c20:	c9                   	leave  
  801c21:	c3                   	ret    

00801c22 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c22:	55                   	push   %ebp
  801c23:	89 e5                	mov    %esp,%ebp
  801c25:	83 ec 04             	sub    $0x4,%esp
  801c28:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c2e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	50                   	push   %eax
  801c3b:	6a 26                	push   $0x26
  801c3d:	e8 5e fb ff ff       	call   8017a0 <syscall>
  801c42:	83 c4 18             	add    $0x18,%esp
	return ;
  801c45:	90                   	nop
}
  801c46:	c9                   	leave  
  801c47:	c3                   	ret    

00801c48 <rsttst>:
void rsttst()
{
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 28                	push   $0x28
  801c57:	e8 44 fb ff ff       	call   8017a0 <syscall>
  801c5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801c5f:	90                   	nop
}
  801c60:	c9                   	leave  
  801c61:	c3                   	ret    

00801c62 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c62:	55                   	push   %ebp
  801c63:	89 e5                	mov    %esp,%ebp
  801c65:	83 ec 04             	sub    $0x4,%esp
  801c68:	8b 45 14             	mov    0x14(%ebp),%eax
  801c6b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c6e:	8b 55 18             	mov    0x18(%ebp),%edx
  801c71:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c75:	52                   	push   %edx
  801c76:	50                   	push   %eax
  801c77:	ff 75 10             	pushl  0x10(%ebp)
  801c7a:	ff 75 0c             	pushl  0xc(%ebp)
  801c7d:	ff 75 08             	pushl  0x8(%ebp)
  801c80:	6a 27                	push   $0x27
  801c82:	e8 19 fb ff ff       	call   8017a0 <syscall>
  801c87:	83 c4 18             	add    $0x18,%esp
	return ;
  801c8a:	90                   	nop
}
  801c8b:	c9                   	leave  
  801c8c:	c3                   	ret    

00801c8d <chktst>:
void chktst(uint32 n)
{
  801c8d:	55                   	push   %ebp
  801c8e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	ff 75 08             	pushl  0x8(%ebp)
  801c9b:	6a 29                	push   $0x29
  801c9d:	e8 fe fa ff ff       	call   8017a0 <syscall>
  801ca2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ca5:	90                   	nop
}
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <inctst>:

void inctst()
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 2a                	push   $0x2a
  801cb7:	e8 e4 fa ff ff       	call   8017a0 <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
	return ;
  801cbf:	90                   	nop
}
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <gettst>:
uint32 gettst()
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 2b                	push   $0x2b
  801cd1:	e8 ca fa ff ff       	call   8017a0 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
}
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
  801cde:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 2c                	push   $0x2c
  801ced:	e8 ae fa ff ff       	call   8017a0 <syscall>
  801cf2:	83 c4 18             	add    $0x18,%esp
  801cf5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801cf8:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801cfc:	75 07                	jne    801d05 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801cfe:	b8 01 00 00 00       	mov    $0x1,%eax
  801d03:	eb 05                	jmp    801d0a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d05:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d0a:	c9                   	leave  
  801d0b:	c3                   	ret    

00801d0c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d0c:	55                   	push   %ebp
  801d0d:	89 e5                	mov    %esp,%ebp
  801d0f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 2c                	push   $0x2c
  801d1e:	e8 7d fa ff ff       	call   8017a0 <syscall>
  801d23:	83 c4 18             	add    $0x18,%esp
  801d26:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d29:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d2d:	75 07                	jne    801d36 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d2f:	b8 01 00 00 00       	mov    $0x1,%eax
  801d34:	eb 05                	jmp    801d3b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d36:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d3b:	c9                   	leave  
  801d3c:	c3                   	ret    

00801d3d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d3d:	55                   	push   %ebp
  801d3e:	89 e5                	mov    %esp,%ebp
  801d40:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 2c                	push   $0x2c
  801d4f:	e8 4c fa ff ff       	call   8017a0 <syscall>
  801d54:	83 c4 18             	add    $0x18,%esp
  801d57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d5a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d5e:	75 07                	jne    801d67 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d60:	b8 01 00 00 00       	mov    $0x1,%eax
  801d65:	eb 05                	jmp    801d6c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
  801d71:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 2c                	push   $0x2c
  801d80:	e8 1b fa ff ff       	call   8017a0 <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
  801d88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d8b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d8f:	75 07                	jne    801d98 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d91:	b8 01 00 00 00       	mov    $0x1,%eax
  801d96:	eb 05                	jmp    801d9d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d98:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d9d:	c9                   	leave  
  801d9e:	c3                   	ret    

00801d9f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d9f:	55                   	push   %ebp
  801da0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	ff 75 08             	pushl  0x8(%ebp)
  801dad:	6a 2d                	push   $0x2d
  801daf:	e8 ec f9 ff ff       	call   8017a0 <syscall>
  801db4:	83 c4 18             	add    $0x18,%esp
	return ;
  801db7:	90                   	nop
}
  801db8:	c9                   	leave  
  801db9:	c3                   	ret    

00801dba <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801dba:	55                   	push   %ebp
  801dbb:	89 e5                	mov    %esp,%ebp
  801dbd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801dc0:	8d 45 10             	lea    0x10(%ebp),%eax
  801dc3:	83 c0 04             	add    $0x4,%eax
  801dc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801dc9:	a1 40 30 98 00       	mov    0x983040,%eax
  801dce:	85 c0                	test   %eax,%eax
  801dd0:	74 16                	je     801de8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801dd2:	a1 40 30 98 00       	mov    0x983040,%eax
  801dd7:	83 ec 08             	sub    $0x8,%esp
  801dda:	50                   	push   %eax
  801ddb:	68 9c 26 80 00       	push   $0x80269c
  801de0:	e8 a1 e9 ff ff       	call   800786 <cprintf>
  801de5:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801de8:	a1 00 30 80 00       	mov    0x803000,%eax
  801ded:	ff 75 0c             	pushl  0xc(%ebp)
  801df0:	ff 75 08             	pushl  0x8(%ebp)
  801df3:	50                   	push   %eax
  801df4:	68 a1 26 80 00       	push   $0x8026a1
  801df9:	e8 88 e9 ff ff       	call   800786 <cprintf>
  801dfe:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801e01:	8b 45 10             	mov    0x10(%ebp),%eax
  801e04:	83 ec 08             	sub    $0x8,%esp
  801e07:	ff 75 f4             	pushl  -0xc(%ebp)
  801e0a:	50                   	push   %eax
  801e0b:	e8 0b e9 ff ff       	call   80071b <vcprintf>
  801e10:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801e13:	83 ec 08             	sub    $0x8,%esp
  801e16:	6a 00                	push   $0x0
  801e18:	68 bd 26 80 00       	push   $0x8026bd
  801e1d:	e8 f9 e8 ff ff       	call   80071b <vcprintf>
  801e22:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801e25:	e8 7a e8 ff ff       	call   8006a4 <exit>

	// should not return here
	while (1) ;
  801e2a:	eb fe                	jmp    801e2a <_panic+0x70>

00801e2c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801e2c:	55                   	push   %ebp
  801e2d:	89 e5                	mov    %esp,%ebp
  801e2f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801e32:	a1 20 30 80 00       	mov    0x803020,%eax
  801e37:	8b 50 74             	mov    0x74(%eax),%edx
  801e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e3d:	39 c2                	cmp    %eax,%edx
  801e3f:	74 14                	je     801e55 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801e41:	83 ec 04             	sub    $0x4,%esp
  801e44:	68 c0 26 80 00       	push   $0x8026c0
  801e49:	6a 26                	push   $0x26
  801e4b:	68 0c 27 80 00       	push   $0x80270c
  801e50:	e8 65 ff ff ff       	call   801dba <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801e55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801e5c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801e63:	e9 c2 00 00 00       	jmp    801f2a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801e68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e6b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e72:	8b 45 08             	mov    0x8(%ebp),%eax
  801e75:	01 d0                	add    %edx,%eax
  801e77:	8b 00                	mov    (%eax),%eax
  801e79:	85 c0                	test   %eax,%eax
  801e7b:	75 08                	jne    801e85 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801e7d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801e80:	e9 a2 00 00 00       	jmp    801f27 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801e85:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e8c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801e93:	eb 69                	jmp    801efe <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801e95:	a1 20 30 80 00       	mov    0x803020,%eax
  801e9a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ea0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801ea3:	89 d0                	mov    %edx,%eax
  801ea5:	01 c0                	add    %eax,%eax
  801ea7:	01 d0                	add    %edx,%eax
  801ea9:	c1 e0 02             	shl    $0x2,%eax
  801eac:	01 c8                	add    %ecx,%eax
  801eae:	8a 40 04             	mov    0x4(%eax),%al
  801eb1:	84 c0                	test   %al,%al
  801eb3:	75 46                	jne    801efb <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801eb5:	a1 20 30 80 00       	mov    0x803020,%eax
  801eba:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ec0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801ec3:	89 d0                	mov    %edx,%eax
  801ec5:	01 c0                	add    %eax,%eax
  801ec7:	01 d0                	add    %edx,%eax
  801ec9:	c1 e0 02             	shl    $0x2,%eax
  801ecc:	01 c8                	add    %ecx,%eax
  801ece:	8b 00                	mov    (%eax),%eax
  801ed0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801ed3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ed6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801edb:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801edd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ee0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eea:	01 c8                	add    %ecx,%eax
  801eec:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801eee:	39 c2                	cmp    %eax,%edx
  801ef0:	75 09                	jne    801efb <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801ef2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801ef9:	eb 12                	jmp    801f0d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801efb:	ff 45 e8             	incl   -0x18(%ebp)
  801efe:	a1 20 30 80 00       	mov    0x803020,%eax
  801f03:	8b 50 74             	mov    0x74(%eax),%edx
  801f06:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f09:	39 c2                	cmp    %eax,%edx
  801f0b:	77 88                	ja     801e95 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801f0d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801f11:	75 14                	jne    801f27 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801f13:	83 ec 04             	sub    $0x4,%esp
  801f16:	68 18 27 80 00       	push   $0x802718
  801f1b:	6a 3a                	push   $0x3a
  801f1d:	68 0c 27 80 00       	push   $0x80270c
  801f22:	e8 93 fe ff ff       	call   801dba <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801f27:	ff 45 f0             	incl   -0x10(%ebp)
  801f2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f2d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801f30:	0f 8c 32 ff ff ff    	jl     801e68 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801f36:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f3d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801f44:	eb 26                	jmp    801f6c <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801f46:	a1 20 30 80 00       	mov    0x803020,%eax
  801f4b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801f51:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801f54:	89 d0                	mov    %edx,%eax
  801f56:	01 c0                	add    %eax,%eax
  801f58:	01 d0                	add    %edx,%eax
  801f5a:	c1 e0 02             	shl    $0x2,%eax
  801f5d:	01 c8                	add    %ecx,%eax
  801f5f:	8a 40 04             	mov    0x4(%eax),%al
  801f62:	3c 01                	cmp    $0x1,%al
  801f64:	75 03                	jne    801f69 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801f66:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f69:	ff 45 e0             	incl   -0x20(%ebp)
  801f6c:	a1 20 30 80 00       	mov    0x803020,%eax
  801f71:	8b 50 74             	mov    0x74(%eax),%edx
  801f74:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f77:	39 c2                	cmp    %eax,%edx
  801f79:	77 cb                	ja     801f46 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801f7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f7e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801f81:	74 14                	je     801f97 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801f83:	83 ec 04             	sub    $0x4,%esp
  801f86:	68 6c 27 80 00       	push   $0x80276c
  801f8b:	6a 44                	push   $0x44
  801f8d:	68 0c 27 80 00       	push   $0x80270c
  801f92:	e8 23 fe ff ff       	call   801dba <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801f97:	90                   	nop
  801f98:	c9                   	leave  
  801f99:	c3                   	ret    
  801f9a:	66 90                	xchg   %ax,%ax

00801f9c <__udivdi3>:
  801f9c:	55                   	push   %ebp
  801f9d:	57                   	push   %edi
  801f9e:	56                   	push   %esi
  801f9f:	53                   	push   %ebx
  801fa0:	83 ec 1c             	sub    $0x1c,%esp
  801fa3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fa7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801faf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fb3:	89 ca                	mov    %ecx,%edx
  801fb5:	89 f8                	mov    %edi,%eax
  801fb7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fbb:	85 f6                	test   %esi,%esi
  801fbd:	75 2d                	jne    801fec <__udivdi3+0x50>
  801fbf:	39 cf                	cmp    %ecx,%edi
  801fc1:	77 65                	ja     802028 <__udivdi3+0x8c>
  801fc3:	89 fd                	mov    %edi,%ebp
  801fc5:	85 ff                	test   %edi,%edi
  801fc7:	75 0b                	jne    801fd4 <__udivdi3+0x38>
  801fc9:	b8 01 00 00 00       	mov    $0x1,%eax
  801fce:	31 d2                	xor    %edx,%edx
  801fd0:	f7 f7                	div    %edi
  801fd2:	89 c5                	mov    %eax,%ebp
  801fd4:	31 d2                	xor    %edx,%edx
  801fd6:	89 c8                	mov    %ecx,%eax
  801fd8:	f7 f5                	div    %ebp
  801fda:	89 c1                	mov    %eax,%ecx
  801fdc:	89 d8                	mov    %ebx,%eax
  801fde:	f7 f5                	div    %ebp
  801fe0:	89 cf                	mov    %ecx,%edi
  801fe2:	89 fa                	mov    %edi,%edx
  801fe4:	83 c4 1c             	add    $0x1c,%esp
  801fe7:	5b                   	pop    %ebx
  801fe8:	5e                   	pop    %esi
  801fe9:	5f                   	pop    %edi
  801fea:	5d                   	pop    %ebp
  801feb:	c3                   	ret    
  801fec:	39 ce                	cmp    %ecx,%esi
  801fee:	77 28                	ja     802018 <__udivdi3+0x7c>
  801ff0:	0f bd fe             	bsr    %esi,%edi
  801ff3:	83 f7 1f             	xor    $0x1f,%edi
  801ff6:	75 40                	jne    802038 <__udivdi3+0x9c>
  801ff8:	39 ce                	cmp    %ecx,%esi
  801ffa:	72 0a                	jb     802006 <__udivdi3+0x6a>
  801ffc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802000:	0f 87 9e 00 00 00    	ja     8020a4 <__udivdi3+0x108>
  802006:	b8 01 00 00 00       	mov    $0x1,%eax
  80200b:	89 fa                	mov    %edi,%edx
  80200d:	83 c4 1c             	add    $0x1c,%esp
  802010:	5b                   	pop    %ebx
  802011:	5e                   	pop    %esi
  802012:	5f                   	pop    %edi
  802013:	5d                   	pop    %ebp
  802014:	c3                   	ret    
  802015:	8d 76 00             	lea    0x0(%esi),%esi
  802018:	31 ff                	xor    %edi,%edi
  80201a:	31 c0                	xor    %eax,%eax
  80201c:	89 fa                	mov    %edi,%edx
  80201e:	83 c4 1c             	add    $0x1c,%esp
  802021:	5b                   	pop    %ebx
  802022:	5e                   	pop    %esi
  802023:	5f                   	pop    %edi
  802024:	5d                   	pop    %ebp
  802025:	c3                   	ret    
  802026:	66 90                	xchg   %ax,%ax
  802028:	89 d8                	mov    %ebx,%eax
  80202a:	f7 f7                	div    %edi
  80202c:	31 ff                	xor    %edi,%edi
  80202e:	89 fa                	mov    %edi,%edx
  802030:	83 c4 1c             	add    $0x1c,%esp
  802033:	5b                   	pop    %ebx
  802034:	5e                   	pop    %esi
  802035:	5f                   	pop    %edi
  802036:	5d                   	pop    %ebp
  802037:	c3                   	ret    
  802038:	bd 20 00 00 00       	mov    $0x20,%ebp
  80203d:	89 eb                	mov    %ebp,%ebx
  80203f:	29 fb                	sub    %edi,%ebx
  802041:	89 f9                	mov    %edi,%ecx
  802043:	d3 e6                	shl    %cl,%esi
  802045:	89 c5                	mov    %eax,%ebp
  802047:	88 d9                	mov    %bl,%cl
  802049:	d3 ed                	shr    %cl,%ebp
  80204b:	89 e9                	mov    %ebp,%ecx
  80204d:	09 f1                	or     %esi,%ecx
  80204f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802053:	89 f9                	mov    %edi,%ecx
  802055:	d3 e0                	shl    %cl,%eax
  802057:	89 c5                	mov    %eax,%ebp
  802059:	89 d6                	mov    %edx,%esi
  80205b:	88 d9                	mov    %bl,%cl
  80205d:	d3 ee                	shr    %cl,%esi
  80205f:	89 f9                	mov    %edi,%ecx
  802061:	d3 e2                	shl    %cl,%edx
  802063:	8b 44 24 08          	mov    0x8(%esp),%eax
  802067:	88 d9                	mov    %bl,%cl
  802069:	d3 e8                	shr    %cl,%eax
  80206b:	09 c2                	or     %eax,%edx
  80206d:	89 d0                	mov    %edx,%eax
  80206f:	89 f2                	mov    %esi,%edx
  802071:	f7 74 24 0c          	divl   0xc(%esp)
  802075:	89 d6                	mov    %edx,%esi
  802077:	89 c3                	mov    %eax,%ebx
  802079:	f7 e5                	mul    %ebp
  80207b:	39 d6                	cmp    %edx,%esi
  80207d:	72 19                	jb     802098 <__udivdi3+0xfc>
  80207f:	74 0b                	je     80208c <__udivdi3+0xf0>
  802081:	89 d8                	mov    %ebx,%eax
  802083:	31 ff                	xor    %edi,%edi
  802085:	e9 58 ff ff ff       	jmp    801fe2 <__udivdi3+0x46>
  80208a:	66 90                	xchg   %ax,%ax
  80208c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802090:	89 f9                	mov    %edi,%ecx
  802092:	d3 e2                	shl    %cl,%edx
  802094:	39 c2                	cmp    %eax,%edx
  802096:	73 e9                	jae    802081 <__udivdi3+0xe5>
  802098:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80209b:	31 ff                	xor    %edi,%edi
  80209d:	e9 40 ff ff ff       	jmp    801fe2 <__udivdi3+0x46>
  8020a2:	66 90                	xchg   %ax,%ax
  8020a4:	31 c0                	xor    %eax,%eax
  8020a6:	e9 37 ff ff ff       	jmp    801fe2 <__udivdi3+0x46>
  8020ab:	90                   	nop

008020ac <__umoddi3>:
  8020ac:	55                   	push   %ebp
  8020ad:	57                   	push   %edi
  8020ae:	56                   	push   %esi
  8020af:	53                   	push   %ebx
  8020b0:	83 ec 1c             	sub    $0x1c,%esp
  8020b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020cb:	89 f3                	mov    %esi,%ebx
  8020cd:	89 fa                	mov    %edi,%edx
  8020cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020d3:	89 34 24             	mov    %esi,(%esp)
  8020d6:	85 c0                	test   %eax,%eax
  8020d8:	75 1a                	jne    8020f4 <__umoddi3+0x48>
  8020da:	39 f7                	cmp    %esi,%edi
  8020dc:	0f 86 a2 00 00 00    	jbe    802184 <__umoddi3+0xd8>
  8020e2:	89 c8                	mov    %ecx,%eax
  8020e4:	89 f2                	mov    %esi,%edx
  8020e6:	f7 f7                	div    %edi
  8020e8:	89 d0                	mov    %edx,%eax
  8020ea:	31 d2                	xor    %edx,%edx
  8020ec:	83 c4 1c             	add    $0x1c,%esp
  8020ef:	5b                   	pop    %ebx
  8020f0:	5e                   	pop    %esi
  8020f1:	5f                   	pop    %edi
  8020f2:	5d                   	pop    %ebp
  8020f3:	c3                   	ret    
  8020f4:	39 f0                	cmp    %esi,%eax
  8020f6:	0f 87 ac 00 00 00    	ja     8021a8 <__umoddi3+0xfc>
  8020fc:	0f bd e8             	bsr    %eax,%ebp
  8020ff:	83 f5 1f             	xor    $0x1f,%ebp
  802102:	0f 84 ac 00 00 00    	je     8021b4 <__umoddi3+0x108>
  802108:	bf 20 00 00 00       	mov    $0x20,%edi
  80210d:	29 ef                	sub    %ebp,%edi
  80210f:	89 fe                	mov    %edi,%esi
  802111:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802115:	89 e9                	mov    %ebp,%ecx
  802117:	d3 e0                	shl    %cl,%eax
  802119:	89 d7                	mov    %edx,%edi
  80211b:	89 f1                	mov    %esi,%ecx
  80211d:	d3 ef                	shr    %cl,%edi
  80211f:	09 c7                	or     %eax,%edi
  802121:	89 e9                	mov    %ebp,%ecx
  802123:	d3 e2                	shl    %cl,%edx
  802125:	89 14 24             	mov    %edx,(%esp)
  802128:	89 d8                	mov    %ebx,%eax
  80212a:	d3 e0                	shl    %cl,%eax
  80212c:	89 c2                	mov    %eax,%edx
  80212e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802132:	d3 e0                	shl    %cl,%eax
  802134:	89 44 24 04          	mov    %eax,0x4(%esp)
  802138:	8b 44 24 08          	mov    0x8(%esp),%eax
  80213c:	89 f1                	mov    %esi,%ecx
  80213e:	d3 e8                	shr    %cl,%eax
  802140:	09 d0                	or     %edx,%eax
  802142:	d3 eb                	shr    %cl,%ebx
  802144:	89 da                	mov    %ebx,%edx
  802146:	f7 f7                	div    %edi
  802148:	89 d3                	mov    %edx,%ebx
  80214a:	f7 24 24             	mull   (%esp)
  80214d:	89 c6                	mov    %eax,%esi
  80214f:	89 d1                	mov    %edx,%ecx
  802151:	39 d3                	cmp    %edx,%ebx
  802153:	0f 82 87 00 00 00    	jb     8021e0 <__umoddi3+0x134>
  802159:	0f 84 91 00 00 00    	je     8021f0 <__umoddi3+0x144>
  80215f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802163:	29 f2                	sub    %esi,%edx
  802165:	19 cb                	sbb    %ecx,%ebx
  802167:	89 d8                	mov    %ebx,%eax
  802169:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80216d:	d3 e0                	shl    %cl,%eax
  80216f:	89 e9                	mov    %ebp,%ecx
  802171:	d3 ea                	shr    %cl,%edx
  802173:	09 d0                	or     %edx,%eax
  802175:	89 e9                	mov    %ebp,%ecx
  802177:	d3 eb                	shr    %cl,%ebx
  802179:	89 da                	mov    %ebx,%edx
  80217b:	83 c4 1c             	add    $0x1c,%esp
  80217e:	5b                   	pop    %ebx
  80217f:	5e                   	pop    %esi
  802180:	5f                   	pop    %edi
  802181:	5d                   	pop    %ebp
  802182:	c3                   	ret    
  802183:	90                   	nop
  802184:	89 fd                	mov    %edi,%ebp
  802186:	85 ff                	test   %edi,%edi
  802188:	75 0b                	jne    802195 <__umoddi3+0xe9>
  80218a:	b8 01 00 00 00       	mov    $0x1,%eax
  80218f:	31 d2                	xor    %edx,%edx
  802191:	f7 f7                	div    %edi
  802193:	89 c5                	mov    %eax,%ebp
  802195:	89 f0                	mov    %esi,%eax
  802197:	31 d2                	xor    %edx,%edx
  802199:	f7 f5                	div    %ebp
  80219b:	89 c8                	mov    %ecx,%eax
  80219d:	f7 f5                	div    %ebp
  80219f:	89 d0                	mov    %edx,%eax
  8021a1:	e9 44 ff ff ff       	jmp    8020ea <__umoddi3+0x3e>
  8021a6:	66 90                	xchg   %ax,%ax
  8021a8:	89 c8                	mov    %ecx,%eax
  8021aa:	89 f2                	mov    %esi,%edx
  8021ac:	83 c4 1c             	add    $0x1c,%esp
  8021af:	5b                   	pop    %ebx
  8021b0:	5e                   	pop    %esi
  8021b1:	5f                   	pop    %edi
  8021b2:	5d                   	pop    %ebp
  8021b3:	c3                   	ret    
  8021b4:	3b 04 24             	cmp    (%esp),%eax
  8021b7:	72 06                	jb     8021bf <__umoddi3+0x113>
  8021b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021bd:	77 0f                	ja     8021ce <__umoddi3+0x122>
  8021bf:	89 f2                	mov    %esi,%edx
  8021c1:	29 f9                	sub    %edi,%ecx
  8021c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021c7:	89 14 24             	mov    %edx,(%esp)
  8021ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021d2:	8b 14 24             	mov    (%esp),%edx
  8021d5:	83 c4 1c             	add    $0x1c,%esp
  8021d8:	5b                   	pop    %ebx
  8021d9:	5e                   	pop    %esi
  8021da:	5f                   	pop    %edi
  8021db:	5d                   	pop    %ebp
  8021dc:	c3                   	ret    
  8021dd:	8d 76 00             	lea    0x0(%esi),%esi
  8021e0:	2b 04 24             	sub    (%esp),%eax
  8021e3:	19 fa                	sbb    %edi,%edx
  8021e5:	89 d1                	mov    %edx,%ecx
  8021e7:	89 c6                	mov    %eax,%esi
  8021e9:	e9 71 ff ff ff       	jmp    80215f <__umoddi3+0xb3>
  8021ee:	66 90                	xchg   %ax,%ax
  8021f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021f4:	72 ea                	jb     8021e0 <__umoddi3+0x134>
  8021f6:	89 d9                	mov    %ebx,%ecx
  8021f8:	e9 62 ff ff ff       	jmp    80215f <__umoddi3+0xb3>
