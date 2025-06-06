
obj/user/tst4:     file format elf32-i386


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
  800031:	e8 a9 08 00 00       	call   8008df <libmain>
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
  80003e:	81 ec cc 00 00 00    	sub    $0xcc,%esp
	

	rsttst();
  800044:	e8 2e 1f 00 00       	call   801f77 <rsttst>
	//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
	//and continue executing the remaining code
	sys_bypassPageFault(3);
  800049:	83 ec 0c             	sub    $0xc,%esp
  80004c:	6a 03                	push   $0x3
  80004e:	e8 fe 1e 00 00       	call   801f51 <sys_bypassPageFault>
  800053:	83 c4 10             	add    $0x10,%esp


	
	

	int Mega = 1024*1024;
  800056:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  80005d:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)

	int start_freeFrames = sys_calculate_free_frames() ;
  800064:	e8 d2 1b 00 00       	call   801c3b <sys_calculate_free_frames>
  800069:	89 45 dc             	mov    %eax,-0x24(%ebp)

	//ALLOCATE ALL
	void* ptr_allocations[20] = {0};
  80006c:	8d 55 80             	lea    -0x80(%ebp),%edx
  80006f:	b9 14 00 00 00       	mov    $0x14,%ecx
  800074:	b8 00 00 00 00       	mov    $0x0,%eax
  800079:	89 d7                	mov    %edx,%edi
  80007b:	f3 ab                	rep stos %eax,%es:(%edi)
	int lastIndices[20] = {0};
  80007d:	8d 95 30 ff ff ff    	lea    -0xd0(%ebp),%edx
  800083:	b9 14 00 00 00       	mov    $0x14,%ecx
  800088:	b8 00 00 00 00       	mov    $0x0,%eax
  80008d:	89 d7                	mov    %edx,%edi
  80008f:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  800091:	e8 a5 1b 00 00       	call   801c3b <sys_calculate_free_frames>
  800096:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800099:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80009c:	01 c0                	add    %eax,%eax
  80009e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000a1:	83 ec 0c             	sub    $0xc,%esp
  8000a4:	50                   	push   %eax
  8000a5:	e8 cf 17 00 00       	call   801879 <malloc>
  8000aa:	83 c4 10             	add    $0x10,%esp
  8000ad:	89 45 80             	mov    %eax,-0x80(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  8000b0:	8b 45 80             	mov    -0x80(%ebp),%eax
  8000b3:	83 ec 0c             	sub    $0xc,%esp
  8000b6:	6a 00                	push   $0x0
  8000b8:	6a 62                	push   $0x62
  8000ba:	68 00 10 00 80       	push   $0x80001000
  8000bf:	68 00 00 00 80       	push   $0x80000000
  8000c4:	50                   	push   %eax
  8000c5:	e8 c7 1e 00 00       	call   801f91 <tst>
  8000ca:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8000cd:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  8000d0:	e8 66 1b 00 00       	call   801c3b <sys_calculate_free_frames>
  8000d5:	29 c3                	sub    %eax,%ebx
  8000d7:	89 d8                	mov    %ebx,%eax
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	6a 00                	push   $0x0
  8000de:	6a 65                	push   $0x65
  8000e0:	6a 00                	push   $0x0
  8000e2:	68 01 02 00 00       	push   $0x201
  8000e7:	50                   	push   %eax
  8000e8:	e8 a4 1e 00 00       	call   801f91 <tst>
  8000ed:	83 c4 20             	add    $0x20,%esp
		lastIndices[0] = (2*Mega-kilo)/sizeof(char) - 1;
  8000f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f3:	01 c0                	add    %eax,%eax
  8000f5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000f8:	48                   	dec    %eax
  8000f9:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  8000ff:	e8 37 1b 00 00       	call   801c3b <sys_calculate_free_frames>
  800104:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800107:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80010a:	01 c0                	add    %eax,%eax
  80010c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	50                   	push   %eax
  800113:	e8 61 17 00 00       	call   801879 <malloc>
  800118:	83 c4 10             	add    $0x10,%esp
  80011b:	89 45 84             	mov    %eax,-0x7c(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
  80011e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800121:	01 c0                	add    %eax,%eax
  800123:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800129:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80012c:	01 c0                	add    %eax,%eax
  80012e:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800134:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	6a 00                	push   $0x0
  80013c:	6a 62                	push   $0x62
  80013e:	51                   	push   %ecx
  80013f:	52                   	push   %edx
  800140:	50                   	push   %eax
  800141:	e8 4b 1e 00 00       	call   801f91 <tst>
  800146:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  800149:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  80014c:	e8 ea 1a 00 00       	call   801c3b <sys_calculate_free_frames>
  800151:	29 c3                	sub    %eax,%ebx
  800153:	89 d8                	mov    %ebx,%eax
  800155:	83 ec 0c             	sub    $0xc,%esp
  800158:	6a 00                	push   $0x0
  80015a:	6a 65                	push   $0x65
  80015c:	6a 00                	push   $0x0
  80015e:	68 00 02 00 00       	push   $0x200
  800163:	50                   	push   %eax
  800164:	e8 28 1e 00 00       	call   801f91 <tst>
  800169:	83 c4 20             	add    $0x20,%esp
		lastIndices[1] = (2*Mega-kilo)/sizeof(char) - 1;
  80016c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80016f:	01 c0                	add    %eax,%eax
  800171:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800174:	48                   	dec    %eax
  800175:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)


		freeFrames = sys_calculate_free_frames() ;
  80017b:	e8 bb 1a 00 00       	call   801c3b <sys_calculate_free_frames>
  800180:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800183:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800186:	01 c0                	add    %eax,%eax
  800188:	83 ec 0c             	sub    $0xc,%esp
  80018b:	50                   	push   %eax
  80018c:	e8 e8 16 00 00       	call   801879 <malloc>
  800191:	83 c4 10             	add    $0x10,%esp
  800194:	89 45 88             	mov    %eax,-0x78(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  800197:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80019a:	c1 e0 02             	shl    $0x2,%eax
  80019d:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001a6:	c1 e0 02             	shl    $0x2,%eax
  8001a9:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8001af:	8b 45 88             	mov    -0x78(%ebp),%eax
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	6a 00                	push   $0x0
  8001b7:	6a 62                	push   $0x62
  8001b9:	51                   	push   %ecx
  8001ba:	52                   	push   %edx
  8001bb:	50                   	push   %eax
  8001bc:	e8 d0 1d 00 00       	call   801f91 <tst>
  8001c1:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);
  8001c4:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  8001c7:	e8 6f 1a 00 00       	call   801c3b <sys_calculate_free_frames>
  8001cc:	29 c3                	sub    %eax,%ebx
  8001ce:	89 d8                	mov    %ebx,%eax
  8001d0:	83 ec 0c             	sub    $0xc,%esp
  8001d3:	6a 00                	push   $0x0
  8001d5:	6a 65                	push   $0x65
  8001d7:	6a 00                	push   $0x0
  8001d9:	6a 02                	push   $0x2
  8001db:	50                   	push   %eax
  8001dc:	e8 b0 1d 00 00       	call   801f91 <tst>
  8001e1:	83 c4 20             	add    $0x20,%esp
		lastIndices[2] = (2*kilo)/sizeof(char) - 1;
  8001e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001e7:	01 c0                	add    %eax,%eax
  8001e9:	48                   	dec    %eax
  8001ea:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)


		freeFrames = sys_calculate_free_frames() ;
  8001f0:	e8 46 1a 00 00       	call   801c3b <sys_calculate_free_frames>
  8001f5:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8001f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001fb:	01 c0                	add    %eax,%eax
  8001fd:	83 ec 0c             	sub    $0xc,%esp
  800200:	50                   	push   %eax
  800201:	e8 73 16 00 00       	call   801879 <malloc>
  800206:	83 c4 10             	add    $0x10,%esp
  800209:	89 45 8c             	mov    %eax,-0x74(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega + 4*kilo,USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE, 'b', 0);
  80020c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80020f:	c1 e0 02             	shl    $0x2,%eax
  800212:	89 c2                	mov    %eax,%edx
  800214:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800217:	c1 e0 02             	shl    $0x2,%eax
  80021a:	01 d0                	add    %edx,%eax
  80021c:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800222:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800225:	c1 e0 02             	shl    $0x2,%eax
  800228:	89 c2                	mov    %eax,%edx
  80022a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80022d:	c1 e0 02             	shl    $0x2,%eax
  800230:	01 d0                	add    %edx,%eax
  800232:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800238:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	6a 00                	push   $0x0
  800240:	6a 62                	push   $0x62
  800242:	51                   	push   %ecx
  800243:	52                   	push   %edx
  800244:	50                   	push   %eax
  800245:	e8 47 1d 00 00       	call   801f91 <tst>
  80024a:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);
  80024d:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800250:	e8 e6 19 00 00       	call   801c3b <sys_calculate_free_frames>
  800255:	29 c3                	sub    %eax,%ebx
  800257:	89 d8                	mov    %ebx,%eax
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	6a 00                	push   $0x0
  80025e:	6a 65                	push   $0x65
  800260:	6a 00                	push   $0x0
  800262:	6a 01                	push   $0x1
  800264:	50                   	push   %eax
  800265:	e8 27 1d 00 00       	call   801f91 <tst>
  80026a:	83 c4 20             	add    $0x20,%esp
		lastIndices[3] = (2*kilo)/sizeof(char) - 1;
  80026d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800270:	01 c0                	add    %eax,%eax
  800272:	48                   	dec    %eax
  800273:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)


		freeFrames = sys_calculate_free_frames() ;
  800279:	e8 bd 19 00 00       	call   801c3b <sys_calculate_free_frames>
  80027e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800281:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800284:	89 d0                	mov    %edx,%eax
  800286:	01 c0                	add    %eax,%eax
  800288:	01 d0                	add    %edx,%eax
  80028a:	01 c0                	add    %eax,%eax
  80028c:	01 d0                	add    %edx,%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 e2 15 00 00       	call   801879 <malloc>
  800297:	83 c4 10             	add    $0x10,%esp
  80029a:	89 45 90             	mov    %eax,-0x70(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega + 8*kilo,USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE, 'b', 0);
  80029d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a0:	c1 e0 02             	shl    $0x2,%eax
  8002a3:	89 c2                	mov    %eax,%edx
  8002a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002a8:	c1 e0 03             	shl    $0x3,%eax
  8002ab:	01 d0                	add    %edx,%eax
  8002ad:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002b6:	c1 e0 02             	shl    $0x2,%eax
  8002b9:	89 c2                	mov    %eax,%edx
  8002bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002be:	c1 e0 03             	shl    $0x3,%eax
  8002c1:	01 d0                	add    %edx,%eax
  8002c3:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002c9:	8b 45 90             	mov    -0x70(%ebp),%eax
  8002cc:	83 ec 0c             	sub    $0xc,%esp
  8002cf:	6a 00                	push   $0x0
  8002d1:	6a 62                	push   $0x62
  8002d3:	51                   	push   %ecx
  8002d4:	52                   	push   %edx
  8002d5:	50                   	push   %eax
  8002d6:	e8 b6 1c 00 00       	call   801f91 <tst>
  8002db:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 2 ,0, 'e', 0);
  8002de:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  8002e1:	e8 55 19 00 00       	call   801c3b <sys_calculate_free_frames>
  8002e6:	29 c3                	sub    %eax,%ebx
  8002e8:	89 d8                	mov    %ebx,%eax
  8002ea:	83 ec 0c             	sub    $0xc,%esp
  8002ed:	6a 00                	push   $0x0
  8002ef:	6a 65                	push   $0x65
  8002f1:	6a 00                	push   $0x0
  8002f3:	6a 02                	push   $0x2
  8002f5:	50                   	push   %eax
  8002f6:	e8 96 1c 00 00       	call   801f91 <tst>
  8002fb:	83 c4 20             	add    $0x20,%esp
		lastIndices[4] = (7*kilo)/sizeof(char) - 1;
  8002fe:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800301:	89 d0                	mov    %edx,%eax
  800303:	01 c0                	add    %eax,%eax
  800305:	01 d0                	add    %edx,%eax
  800307:	01 c0                	add    %eax,%eax
  800309:	01 d0                	add    %edx,%eax
  80030b:	48                   	dec    %eax
  80030c:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)


		freeFrames = sys_calculate_free_frames() ;
  800312:	e8 24 19 00 00       	call   801c3b <sys_calculate_free_frames>
  800317:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  80031a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80031d:	89 c2                	mov    %eax,%edx
  80031f:	01 d2                	add    %edx,%edx
  800321:	01 d0                	add    %edx,%eax
  800323:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800326:	83 ec 0c             	sub    $0xc,%esp
  800329:	50                   	push   %eax
  80032a:	e8 4a 15 00 00       	call   801879 <malloc>
  80032f:	83 c4 10             	add    $0x10,%esp
  800332:	89 45 94             	mov    %eax,-0x6c(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega + 16*kilo,USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  800335:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800338:	c1 e0 02             	shl    $0x2,%eax
  80033b:	89 c2                	mov    %eax,%edx
  80033d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800340:	c1 e0 04             	shl    $0x4,%eax
  800343:	01 d0                	add    %edx,%eax
  800345:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  80034b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80034e:	c1 e0 02             	shl    $0x2,%eax
  800351:	89 c2                	mov    %eax,%edx
  800353:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800356:	c1 e0 04             	shl    $0x4,%eax
  800359:	01 d0                	add    %edx,%eax
  80035b:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800361:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800364:	83 ec 0c             	sub    $0xc,%esp
  800367:	6a 00                	push   $0x0
  800369:	6a 62                	push   $0x62
  80036b:	51                   	push   %ecx
  80036c:	52                   	push   %edx
  80036d:	50                   	push   %eax
  80036e:	e8 1e 1c 00 00       	call   801f91 <tst>
  800373:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);
  800376:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800379:	89 c2                	mov    %eax,%edx
  80037b:	01 d2                	add    %edx,%edx
  80037d:	01 d0                	add    %edx,%eax
  80037f:	85 c0                	test   %eax,%eax
  800381:	79 05                	jns    800388 <_main+0x350>
  800383:	05 ff 0f 00 00       	add    $0xfff,%eax
  800388:	c1 f8 0c             	sar    $0xc,%eax
  80038b:	89 c3                	mov    %eax,%ebx
  80038d:	8b 75 d8             	mov    -0x28(%ebp),%esi
  800390:	e8 a6 18 00 00       	call   801c3b <sys_calculate_free_frames>
  800395:	29 c6                	sub    %eax,%esi
  800397:	89 f0                	mov    %esi,%eax
  800399:	83 ec 0c             	sub    $0xc,%esp
  80039c:	6a 00                	push   $0x0
  80039e:	6a 65                	push   $0x65
  8003a0:	6a 00                	push   $0x0
  8003a2:	53                   	push   %ebx
  8003a3:	50                   	push   %eax
  8003a4:	e8 e8 1b 00 00       	call   801f91 <tst>
  8003a9:	83 c4 20             	add    $0x20,%esp
		lastIndices[5] = (3*Mega - kilo)/sizeof(char) - 1;
  8003ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003af:	89 c2                	mov    %eax,%edx
  8003b1:	01 d2                	add    %edx,%edx
  8003b3:	01 d0                	add    %edx,%eax
  8003b5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003b8:	48                   	dec    %eax
  8003b9:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)


		freeFrames = sys_calculate_free_frames() ;
  8003bf:	e8 77 18 00 00       	call   801c3b <sys_calculate_free_frames>
  8003c4:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  8003c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003ca:	01 c0                	add    %eax,%eax
  8003cc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003cf:	83 ec 0c             	sub    $0xc,%esp
  8003d2:	50                   	push   %eax
  8003d3:	e8 a1 14 00 00       	call   801879 <malloc>
  8003d8:	83 c4 10             	add    $0x10,%esp
  8003db:	89 45 98             	mov    %eax,-0x68(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega + 16*kilo,USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  8003de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003e1:	89 d0                	mov    %edx,%eax
  8003e3:	01 c0                	add    %eax,%eax
  8003e5:	01 d0                	add    %edx,%eax
  8003e7:	01 c0                	add    %eax,%eax
  8003e9:	01 d0                	add    %edx,%eax
  8003eb:	89 c2                	mov    %eax,%edx
  8003ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003f0:	c1 e0 04             	shl    $0x4,%eax
  8003f3:	01 d0                	add    %edx,%eax
  8003f5:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8003fb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003fe:	89 d0                	mov    %edx,%eax
  800400:	01 c0                	add    %eax,%eax
  800402:	01 d0                	add    %edx,%eax
  800404:	01 c0                	add    %eax,%eax
  800406:	01 d0                	add    %edx,%eax
  800408:	89 c2                	mov    %eax,%edx
  80040a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80040d:	c1 e0 04             	shl    $0x4,%eax
  800410:	01 d0                	add    %edx,%eax
  800412:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800418:	8b 45 98             	mov    -0x68(%ebp),%eax
  80041b:	83 ec 0c             	sub    $0xc,%esp
  80041e:	6a 00                	push   $0x0
  800420:	6a 62                	push   $0x62
  800422:	51                   	push   %ecx
  800423:	52                   	push   %edx
  800424:	50                   	push   %eax
  800425:	e8 67 1b 00 00       	call   801f91 <tst>
  80042a:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  80042d:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800430:	e8 06 18 00 00       	call   801c3b <sys_calculate_free_frames>
  800435:	29 c3                	sub    %eax,%ebx
  800437:	89 d8                	mov    %ebx,%eax
  800439:	83 ec 0c             	sub    $0xc,%esp
  80043c:	6a 00                	push   $0x0
  80043e:	6a 65                	push   $0x65
  800440:	6a 00                	push   $0x0
  800442:	68 01 02 00 00       	push   $0x201
  800447:	50                   	push   %eax
  800448:	e8 44 1b 00 00       	call   801f91 <tst>
  80044d:	83 c4 20             	add    $0x20,%esp
		lastIndices[6] = (2*Mega - kilo)/sizeof(char) - 1;
  800450:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800453:	01 c0                	add    %eax,%eax
  800455:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800458:	48                   	dec    %eax
  800459:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
	char x ;
	int y;
	char *byteArr ;
	//FREE ALL
	{
		int freeFrames = sys_calculate_free_frames() ;
  80045f:	e8 d7 17 00 00       	call   801c3b <sys_calculate_free_frames>
  800464:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[0]);
  800467:	8b 45 80             	mov    -0x80(%ebp),%eax
  80046a:	83 ec 0c             	sub    $0xc,%esp
  80046d:	50                   	push   %eax
  80046e:	e8 27 15 00 00       	call   80199a <free>
  800473:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512 ,0, 'e', 0);
  800476:	e8 c0 17 00 00       	call   801c3b <sys_calculate_free_frames>
  80047b:	89 c2                	mov    %eax,%edx
  80047d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800480:	29 c2                	sub    %eax,%edx
  800482:	89 d0                	mov    %edx,%eax
  800484:	83 ec 0c             	sub    $0xc,%esp
  800487:	6a 00                	push   $0x0
  800489:	6a 65                	push   $0x65
  80048b:	6a 00                	push   $0x0
  80048d:	68 00 02 00 00       	push   $0x200
  800492:	50                   	push   %eax
  800493:	e8 f9 1a 00 00       	call   801f91 <tst>
  800498:	83 c4 20             	add    $0x20,%esp
		byteArr = (char *) ptr_allocations[0];
  80049b:	8b 45 80             	mov    -0x80(%ebp),%eax
  80049e:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8004a1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004a4:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
  8004a7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  8004aa:	e8 89 1a 00 00       	call   801f38 <sys_rcr2>
  8004af:	83 ec 0c             	sub    $0xc,%esp
  8004b2:	6a 00                	push   $0x0
  8004b4:	6a 65                	push   $0x65
  8004b6:	6a 00                	push   $0x0
  8004b8:	53                   	push   %ebx
  8004b9:	50                   	push   %eax
  8004ba:	e8 d2 1a 00 00       	call   801f91 <tst>
  8004bf:	83 c4 20             	add    $0x20,%esp
		byteArr[lastIndices[0]] = 10;
  8004c2:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  8004c8:	89 c2                	mov    %eax,%edx
  8004ca:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004cd:	01 d0                	add    %edx,%eax
  8004cf:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[0]]) ,0, 'e', 0);
  8004d2:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  8004d8:	89 c2                	mov    %eax,%edx
  8004da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004dd:	01 d0                	add    %edx,%eax
  8004df:	89 c3                	mov    %eax,%ebx
  8004e1:	e8 52 1a 00 00       	call   801f38 <sys_rcr2>
  8004e6:	83 ec 0c             	sub    $0xc,%esp
  8004e9:	6a 00                	push   $0x0
  8004eb:	6a 65                	push   $0x65
  8004ed:	6a 00                	push   $0x0
  8004ef:	53                   	push   %ebx
  8004f0:	50                   	push   %eax
  8004f1:	e8 9b 1a 00 00       	call   801f91 <tst>
  8004f6:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8004f9:	e8 3d 17 00 00       	call   801c3b <sys_calculate_free_frames>
  8004fe:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[1]);
  800501:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800504:	83 ec 0c             	sub    $0xc,%esp
  800507:	50                   	push   %eax
  800508:	e8 8d 14 00 00       	call   80199a <free>
  80050d:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512 +1,0, 'e', 0);
  800510:	e8 26 17 00 00       	call   801c3b <sys_calculate_free_frames>
  800515:	89 c2                	mov    %eax,%edx
  800517:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80051a:	29 c2                	sub    %eax,%edx
  80051c:	89 d0                	mov    %edx,%eax
  80051e:	83 ec 0c             	sub    $0xc,%esp
  800521:	6a 00                	push   $0x0
  800523:	6a 65                	push   $0x65
  800525:	6a 00                	push   $0x0
  800527:	68 01 02 00 00       	push   $0x201
  80052c:	50                   	push   %eax
  80052d:	e8 5f 1a 00 00       	call   801f91 <tst>
  800532:	83 c4 20             	add    $0x20,%esp
		byteArr = (char *) ptr_allocations[1];
  800535:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800538:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80053b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80053e:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
  800541:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  800544:	e8 ef 19 00 00       	call   801f38 <sys_rcr2>
  800549:	83 ec 0c             	sub    $0xc,%esp
  80054c:	6a 00                	push   $0x0
  80054e:	6a 65                	push   $0x65
  800550:	6a 00                	push   $0x0
  800552:	53                   	push   %ebx
  800553:	50                   	push   %eax
  800554:	e8 38 1a 00 00       	call   801f91 <tst>
  800559:	83 c4 20             	add    $0x20,%esp
		byteArr[lastIndices[1]] = 10;
  80055c:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800562:	89 c2                	mov    %eax,%edx
  800564:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800567:	01 d0                	add    %edx,%eax
  800569:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[1]]) ,0, 'e', 0);
  80056c:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800572:	89 c2                	mov    %eax,%edx
  800574:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800577:	01 d0                	add    %edx,%eax
  800579:	89 c3                	mov    %eax,%ebx
  80057b:	e8 b8 19 00 00       	call   801f38 <sys_rcr2>
  800580:	83 ec 0c             	sub    $0xc,%esp
  800583:	6a 00                	push   $0x0
  800585:	6a 65                	push   $0x65
  800587:	6a 00                	push   $0x0
  800589:	53                   	push   %ebx
  80058a:	50                   	push   %eax
  80058b:	e8 01 1a 00 00       	call   801f91 <tst>
  800590:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800593:	e8 a3 16 00 00       	call   801c3b <sys_calculate_free_frames>
  800598:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[2]);
  80059b:	8b 45 88             	mov    -0x78(%ebp),%eax
  80059e:	83 ec 0c             	sub    $0xc,%esp
  8005a1:	50                   	push   %eax
  8005a2:	e8 f3 13 00 00       	call   80199a <free>
  8005a7:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 1 ,0, 'e', 0);
  8005aa:	e8 8c 16 00 00       	call   801c3b <sys_calculate_free_frames>
  8005af:	89 c2                	mov    %eax,%edx
  8005b1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b4:	29 c2                	sub    %eax,%edx
  8005b6:	89 d0                	mov    %edx,%eax
  8005b8:	83 ec 0c             	sub    $0xc,%esp
  8005bb:	6a 00                	push   $0x0
  8005bd:	6a 65                	push   $0x65
  8005bf:	6a 00                	push   $0x0
  8005c1:	6a 01                	push   $0x1
  8005c3:	50                   	push   %eax
  8005c4:	e8 c8 19 00 00       	call   801f91 <tst>
  8005c9:	83 c4 20             	add    $0x20,%esp
		byteArr = (char *) ptr_allocations[2];
  8005cc:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005cf:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8005d2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005d5:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
  8005d8:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  8005db:	e8 58 19 00 00       	call   801f38 <sys_rcr2>
  8005e0:	83 ec 0c             	sub    $0xc,%esp
  8005e3:	6a 00                	push   $0x0
  8005e5:	6a 65                	push   $0x65
  8005e7:	6a 00                	push   $0x0
  8005e9:	53                   	push   %ebx
  8005ea:	50                   	push   %eax
  8005eb:	e8 a1 19 00 00       	call   801f91 <tst>
  8005f0:	83 c4 20             	add    $0x20,%esp
		byteArr[lastIndices[2]] = 10;
  8005f3:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  8005f9:	89 c2                	mov    %eax,%edx
  8005fb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005fe:	01 d0                	add    %edx,%eax
  800600:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[2]]) ,0, 'e', 0);
  800603:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800609:	89 c2                	mov    %eax,%edx
  80060b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80060e:	01 d0                	add    %edx,%eax
  800610:	89 c3                	mov    %eax,%ebx
  800612:	e8 21 19 00 00       	call   801f38 <sys_rcr2>
  800617:	83 ec 0c             	sub    $0xc,%esp
  80061a:	6a 00                	push   $0x0
  80061c:	6a 65                	push   $0x65
  80061e:	6a 00                	push   $0x0
  800620:	53                   	push   %ebx
  800621:	50                   	push   %eax
  800622:	e8 6a 19 00 00       	call   801f91 <tst>
  800627:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80062a:	e8 0c 16 00 00       	call   801c3b <sys_calculate_free_frames>
  80062f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[3]);
  800632:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800635:	83 ec 0c             	sub    $0xc,%esp
  800638:	50                   	push   %eax
  800639:	e8 5c 13 00 00       	call   80199a <free>
  80063e:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 1 ,0, 'e', 0);
  800641:	e8 f5 15 00 00       	call   801c3b <sys_calculate_free_frames>
  800646:	89 c2                	mov    %eax,%edx
  800648:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80064b:	29 c2                	sub    %eax,%edx
  80064d:	89 d0                	mov    %edx,%eax
  80064f:	83 ec 0c             	sub    $0xc,%esp
  800652:	6a 00                	push   $0x0
  800654:	6a 65                	push   $0x65
  800656:	6a 00                	push   $0x0
  800658:	6a 01                	push   $0x1
  80065a:	50                   	push   %eax
  80065b:	e8 31 19 00 00       	call   801f91 <tst>
  800660:	83 c4 20             	add    $0x20,%esp
		byteArr = (char *) ptr_allocations[3];
  800663:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800666:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800669:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80066c:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
  80066f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  800672:	e8 c1 18 00 00       	call   801f38 <sys_rcr2>
  800677:	83 ec 0c             	sub    $0xc,%esp
  80067a:	6a 00                	push   $0x0
  80067c:	6a 65                	push   $0x65
  80067e:	6a 00                	push   $0x0
  800680:	53                   	push   %ebx
  800681:	50                   	push   %eax
  800682:	e8 0a 19 00 00       	call   801f91 <tst>
  800687:	83 c4 20             	add    $0x20,%esp
		byteArr[lastIndices[3]] = 10;
  80068a:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800690:	89 c2                	mov    %eax,%edx
  800692:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800695:	01 d0                	add    %edx,%eax
  800697:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[3]]) ,0, 'e', 0);
  80069a:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  8006a0:	89 c2                	mov    %eax,%edx
  8006a2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8006a5:	01 d0                	add    %edx,%eax
  8006a7:	89 c3                	mov    %eax,%ebx
  8006a9:	e8 8a 18 00 00       	call   801f38 <sys_rcr2>
  8006ae:	83 ec 0c             	sub    $0xc,%esp
  8006b1:	6a 00                	push   $0x0
  8006b3:	6a 65                	push   $0x65
  8006b5:	6a 00                	push   $0x0
  8006b7:	53                   	push   %ebx
  8006b8:	50                   	push   %eax
  8006b9:	e8 d3 18 00 00       	call   801f91 <tst>
  8006be:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8006c1:	e8 75 15 00 00       	call   801c3b <sys_calculate_free_frames>
  8006c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[4]);
  8006c9:	8b 45 90             	mov    -0x70(%ebp),%eax
  8006cc:	83 ec 0c             	sub    $0xc,%esp
  8006cf:	50                   	push   %eax
  8006d0:	e8 c5 12 00 00       	call   80199a <free>
  8006d5:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 2 ,0, 'e', 0);
  8006d8:	e8 5e 15 00 00       	call   801c3b <sys_calculate_free_frames>
  8006dd:	89 c2                	mov    %eax,%edx
  8006df:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e2:	29 c2                	sub    %eax,%edx
  8006e4:	89 d0                	mov    %edx,%eax
  8006e6:	83 ec 0c             	sub    $0xc,%esp
  8006e9:	6a 00                	push   $0x0
  8006eb:	6a 65                	push   $0x65
  8006ed:	6a 00                	push   $0x0
  8006ef:	6a 02                	push   $0x2
  8006f1:	50                   	push   %eax
  8006f2:	e8 9a 18 00 00       	call   801f91 <tst>
  8006f7:	83 c4 20             	add    $0x20,%esp
		byteArr = (char *) ptr_allocations[4];
  8006fa:	8b 45 90             	mov    -0x70(%ebp),%eax
  8006fd:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800700:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800703:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
  800706:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  800709:	e8 2a 18 00 00       	call   801f38 <sys_rcr2>
  80070e:	83 ec 0c             	sub    $0xc,%esp
  800711:	6a 00                	push   $0x0
  800713:	6a 65                	push   $0x65
  800715:	6a 00                	push   $0x0
  800717:	53                   	push   %ebx
  800718:	50                   	push   %eax
  800719:	e8 73 18 00 00       	call   801f91 <tst>
  80071e:	83 c4 20             	add    $0x20,%esp
		byteArr[lastIndices[4]] = 10;
  800721:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800727:	89 c2                	mov    %eax,%edx
  800729:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80072c:	01 d0                	add    %edx,%eax
  80072e:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[4]]) ,0, 'e', 0);
  800731:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800737:	89 c2                	mov    %eax,%edx
  800739:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80073c:	01 d0                	add    %edx,%eax
  80073e:	89 c3                	mov    %eax,%ebx
  800740:	e8 f3 17 00 00       	call   801f38 <sys_rcr2>
  800745:	83 ec 0c             	sub    $0xc,%esp
  800748:	6a 00                	push   $0x0
  80074a:	6a 65                	push   $0x65
  80074c:	6a 00                	push   $0x0
  80074e:	53                   	push   %ebx
  80074f:	50                   	push   %eax
  800750:	e8 3c 18 00 00       	call   801f91 <tst>
  800755:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800758:	e8 de 14 00 00       	call   801c3b <sys_calculate_free_frames>
  80075d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[5]);
  800760:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800763:	83 ec 0c             	sub    $0xc,%esp
  800766:	50                   	push   %eax
  800767:	e8 2e 12 00 00       	call   80199a <free>
  80076c:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 3*Mega/4096 ,0, 'e', 0);
  80076f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800772:	89 c2                	mov    %eax,%edx
  800774:	01 d2                	add    %edx,%edx
  800776:	01 d0                	add    %edx,%eax
  800778:	85 c0                	test   %eax,%eax
  80077a:	79 05                	jns    800781 <_main+0x749>
  80077c:	05 ff 0f 00 00       	add    $0xfff,%eax
  800781:	c1 f8 0c             	sar    $0xc,%eax
  800784:	89 c3                	mov    %eax,%ebx
  800786:	e8 b0 14 00 00       	call   801c3b <sys_calculate_free_frames>
  80078b:	89 c2                	mov    %eax,%edx
  80078d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800790:	29 c2                	sub    %eax,%edx
  800792:	89 d0                	mov    %edx,%eax
  800794:	83 ec 0c             	sub    $0xc,%esp
  800797:	6a 00                	push   $0x0
  800799:	6a 65                	push   $0x65
  80079b:	6a 00                	push   $0x0
  80079d:	53                   	push   %ebx
  80079e:	50                   	push   %eax
  80079f:	e8 ed 17 00 00       	call   801f91 <tst>
  8007a4:	83 c4 20             	add    $0x20,%esp
		byteArr = (char *) ptr_allocations[5];
  8007a7:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8007aa:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8007ad:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b0:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
  8007b3:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  8007b6:	e8 7d 17 00 00       	call   801f38 <sys_rcr2>
  8007bb:	83 ec 0c             	sub    $0xc,%esp
  8007be:	6a 00                	push   $0x0
  8007c0:	6a 65                	push   $0x65
  8007c2:	6a 00                	push   $0x0
  8007c4:	53                   	push   %ebx
  8007c5:	50                   	push   %eax
  8007c6:	e8 c6 17 00 00       	call   801f91 <tst>
  8007cb:	83 c4 20             	add    $0x20,%esp
		byteArr[lastIndices[5]] = 10;
  8007ce:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  8007d4:	89 c2                	mov    %eax,%edx
  8007d6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007d9:	01 d0                	add    %edx,%eax
  8007db:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[5]]) ,0, 'e', 0);
  8007de:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  8007e4:	89 c2                	mov    %eax,%edx
  8007e6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007e9:	01 d0                	add    %edx,%eax
  8007eb:	89 c3                	mov    %eax,%ebx
  8007ed:	e8 46 17 00 00       	call   801f38 <sys_rcr2>
  8007f2:	83 ec 0c             	sub    $0xc,%esp
  8007f5:	6a 00                	push   $0x0
  8007f7:	6a 65                	push   $0x65
  8007f9:	6a 00                	push   $0x0
  8007fb:	53                   	push   %ebx
  8007fc:	50                   	push   %eax
  8007fd:	e8 8f 17 00 00       	call   801f91 <tst>
  800802:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800805:	e8 31 14 00 00       	call   801c3b <sys_calculate_free_frames>
  80080a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[6]);
  80080d:	8b 45 98             	mov    -0x68(%ebp),%eax
  800810:	83 ec 0c             	sub    $0xc,%esp
  800813:	50                   	push   %eax
  800814:	e8 81 11 00 00       	call   80199a <free>
  800819:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512+2,0, 'e', 0);
  80081c:	e8 1a 14 00 00       	call   801c3b <sys_calculate_free_frames>
  800821:	89 c2                	mov    %eax,%edx
  800823:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800826:	29 c2                	sub    %eax,%edx
  800828:	89 d0                	mov    %edx,%eax
  80082a:	83 ec 0c             	sub    $0xc,%esp
  80082d:	6a 00                	push   $0x0
  80082f:	6a 65                	push   $0x65
  800831:	6a 00                	push   $0x0
  800833:	68 02 02 00 00       	push   $0x202
  800838:	50                   	push   %eax
  800839:	e8 53 17 00 00       	call   801f91 <tst>
  80083e:	83 c4 20             	add    $0x20,%esp
		byteArr = (char *) ptr_allocations[6];
  800841:	8b 45 98             	mov    -0x68(%ebp),%eax
  800844:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800847:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80084a:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
  80084d:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  800850:	e8 e3 16 00 00       	call   801f38 <sys_rcr2>
  800855:	83 ec 0c             	sub    $0xc,%esp
  800858:	6a 00                	push   $0x0
  80085a:	6a 65                	push   $0x65
  80085c:	6a 00                	push   $0x0
  80085e:	53                   	push   %ebx
  80085f:	50                   	push   %eax
  800860:	e8 2c 17 00 00       	call   801f91 <tst>
  800865:	83 c4 20             	add    $0x20,%esp
		byteArr[lastIndices[6]] = 10;
  800868:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  80086e:	89 c2                	mov    %eax,%edx
  800870:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800873:	01 d0                	add    %edx,%eax
  800875:	c6 00 0a             	movb   $0xa,(%eax)
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[6]]) ,0, 'e', 0);
  800878:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  80087e:	89 c2                	mov    %eax,%edx
  800880:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800883:	01 d0                	add    %edx,%eax
  800885:	89 c3                	mov    %eax,%ebx
  800887:	e8 ac 16 00 00       	call   801f38 <sys_rcr2>
  80088c:	83 ec 0c             	sub    $0xc,%esp
  80088f:	6a 00                	push   $0x0
  800891:	6a 65                	push   $0x65
  800893:	6a 00                	push   $0x0
  800895:	53                   	push   %ebx
  800896:	50                   	push   %eax
  800897:	e8 f5 16 00 00       	call   801f91 <tst>
  80089c:	83 c4 20             	add    $0x20,%esp

		tst(start_freeFrames, sys_calculate_free_frames() ,0, 'e', 0);
  80089f:	e8 97 13 00 00       	call   801c3b <sys_calculate_free_frames>
  8008a4:	89 c2                	mov    %eax,%edx
  8008a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008a9:	83 ec 0c             	sub    $0xc,%esp
  8008ac:	6a 00                	push   $0x0
  8008ae:	6a 65                	push   $0x65
  8008b0:	6a 00                	push   $0x0
  8008b2:	52                   	push   %edx
  8008b3:	50                   	push   %eax
  8008b4:	e8 d8 16 00 00       	call   801f91 <tst>
  8008b9:	83 c4 20             	add    $0x20,%esp
	}

	//set it to 0 again to cancel the bypassing option
	sys_bypassPageFault(0);
  8008bc:	83 ec 0c             	sub    $0xc,%esp
  8008bf:	6a 00                	push   $0x0
  8008c1:	e8 8b 16 00 00       	call   801f51 <sys_bypassPageFault>
  8008c6:	83 c4 10             	add    $0x10,%esp

	chktst(36);
  8008c9:	83 ec 0c             	sub    $0xc,%esp
  8008cc:	6a 24                	push   $0x24
  8008ce:	e8 e9 16 00 00       	call   801fbc <chktst>
  8008d3:	83 c4 10             	add    $0x10,%esp

	return;
  8008d6:	90                   	nop
}
  8008d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8008da:	5b                   	pop    %ebx
  8008db:	5e                   	pop    %esi
  8008dc:	5f                   	pop    %edi
  8008dd:	5d                   	pop    %ebp
  8008de:	c3                   	ret    

008008df <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8008df:	55                   	push   %ebp
  8008e0:	89 e5                	mov    %esp,%ebp
  8008e2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8008e5:	e8 86 12 00 00       	call   801b70 <sys_getenvindex>
  8008ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8008ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008f0:	89 d0                	mov    %edx,%eax
  8008f2:	01 c0                	add    %eax,%eax
  8008f4:	01 d0                	add    %edx,%eax
  8008f6:	c1 e0 02             	shl    $0x2,%eax
  8008f9:	01 d0                	add    %edx,%eax
  8008fb:	c1 e0 06             	shl    $0x6,%eax
  8008fe:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800903:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800908:	a1 20 30 80 00       	mov    0x803020,%eax
  80090d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800913:	84 c0                	test   %al,%al
  800915:	74 0f                	je     800926 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800917:	a1 20 30 80 00       	mov    0x803020,%eax
  80091c:	05 f4 02 00 00       	add    $0x2f4,%eax
  800921:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800926:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80092a:	7e 0a                	jle    800936 <libmain+0x57>
		binaryname = argv[0];
  80092c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092f:	8b 00                	mov    (%eax),%eax
  800931:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800936:	83 ec 08             	sub    $0x8,%esp
  800939:	ff 75 0c             	pushl  0xc(%ebp)
  80093c:	ff 75 08             	pushl  0x8(%ebp)
  80093f:	e8 f4 f6 ff ff       	call   800038 <_main>
  800944:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800947:	e8 bf 13 00 00       	call   801d0b <sys_disable_interrupt>
	cprintf("**************************************\n");
  80094c:	83 ec 0c             	sub    $0xc,%esp
  80094f:	68 58 25 80 00       	push   $0x802558
  800954:	e8 5c 01 00 00       	call   800ab5 <cprintf>
  800959:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80095c:	a1 20 30 80 00       	mov    0x803020,%eax
  800961:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800967:	a1 20 30 80 00       	mov    0x803020,%eax
  80096c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800972:	83 ec 04             	sub    $0x4,%esp
  800975:	52                   	push   %edx
  800976:	50                   	push   %eax
  800977:	68 80 25 80 00       	push   $0x802580
  80097c:	e8 34 01 00 00       	call   800ab5 <cprintf>
  800981:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800984:	a1 20 30 80 00       	mov    0x803020,%eax
  800989:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80098f:	83 ec 08             	sub    $0x8,%esp
  800992:	50                   	push   %eax
  800993:	68 a5 25 80 00       	push   $0x8025a5
  800998:	e8 18 01 00 00       	call   800ab5 <cprintf>
  80099d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8009a0:	83 ec 0c             	sub    $0xc,%esp
  8009a3:	68 58 25 80 00       	push   $0x802558
  8009a8:	e8 08 01 00 00       	call   800ab5 <cprintf>
  8009ad:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009b0:	e8 70 13 00 00       	call   801d25 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009b5:	e8 19 00 00 00       	call   8009d3 <exit>
}
  8009ba:	90                   	nop
  8009bb:	c9                   	leave  
  8009bc:	c3                   	ret    

008009bd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009bd:	55                   	push   %ebp
  8009be:	89 e5                	mov    %esp,%ebp
  8009c0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009c3:	83 ec 0c             	sub    $0xc,%esp
  8009c6:	6a 00                	push   $0x0
  8009c8:	e8 6f 11 00 00       	call   801b3c <sys_env_destroy>
  8009cd:	83 c4 10             	add    $0x10,%esp
}
  8009d0:	90                   	nop
  8009d1:	c9                   	leave  
  8009d2:	c3                   	ret    

008009d3 <exit>:

void
exit(void)
{
  8009d3:	55                   	push   %ebp
  8009d4:	89 e5                	mov    %esp,%ebp
  8009d6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009d9:	e8 c4 11 00 00       	call   801ba2 <sys_env_exit>
}
  8009de:	90                   	nop
  8009df:	c9                   	leave  
  8009e0:	c3                   	ret    

008009e1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009e1:	55                   	push   %ebp
  8009e2:	89 e5                	mov    %esp,%ebp
  8009e4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ea:	8b 00                	mov    (%eax),%eax
  8009ec:	8d 48 01             	lea    0x1(%eax),%ecx
  8009ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f2:	89 0a                	mov    %ecx,(%edx)
  8009f4:	8b 55 08             	mov    0x8(%ebp),%edx
  8009f7:	88 d1                	mov    %dl,%cl
  8009f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a03:	8b 00                	mov    (%eax),%eax
  800a05:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a0a:	75 2c                	jne    800a38 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a0c:	a0 24 30 80 00       	mov    0x803024,%al
  800a11:	0f b6 c0             	movzbl %al,%eax
  800a14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a17:	8b 12                	mov    (%edx),%edx
  800a19:	89 d1                	mov    %edx,%ecx
  800a1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1e:	83 c2 08             	add    $0x8,%edx
  800a21:	83 ec 04             	sub    $0x4,%esp
  800a24:	50                   	push   %eax
  800a25:	51                   	push   %ecx
  800a26:	52                   	push   %edx
  800a27:	e8 ce 10 00 00       	call   801afa <sys_cputs>
  800a2c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a32:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3b:	8b 40 04             	mov    0x4(%eax),%eax
  800a3e:	8d 50 01             	lea    0x1(%eax),%edx
  800a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a44:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a47:	90                   	nop
  800a48:	c9                   	leave  
  800a49:	c3                   	ret    

00800a4a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a4a:	55                   	push   %ebp
  800a4b:	89 e5                	mov    %esp,%ebp
  800a4d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a53:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a5a:	00 00 00 
	b.cnt = 0;
  800a5d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a64:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a67:	ff 75 0c             	pushl  0xc(%ebp)
  800a6a:	ff 75 08             	pushl  0x8(%ebp)
  800a6d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a73:	50                   	push   %eax
  800a74:	68 e1 09 80 00       	push   $0x8009e1
  800a79:	e8 11 02 00 00       	call   800c8f <vprintfmt>
  800a7e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a81:	a0 24 30 80 00       	mov    0x803024,%al
  800a86:	0f b6 c0             	movzbl %al,%eax
  800a89:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a8f:	83 ec 04             	sub    $0x4,%esp
  800a92:	50                   	push   %eax
  800a93:	52                   	push   %edx
  800a94:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a9a:	83 c0 08             	add    $0x8,%eax
  800a9d:	50                   	push   %eax
  800a9e:	e8 57 10 00 00       	call   801afa <sys_cputs>
  800aa3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800aa6:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800aad:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ab3:	c9                   	leave  
  800ab4:	c3                   	ret    

00800ab5 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ab5:	55                   	push   %ebp
  800ab6:	89 e5                	mov    %esp,%ebp
  800ab8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800abb:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ac2:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ac5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  800acb:	83 ec 08             	sub    $0x8,%esp
  800ace:	ff 75 f4             	pushl  -0xc(%ebp)
  800ad1:	50                   	push   %eax
  800ad2:	e8 73 ff ff ff       	call   800a4a <vcprintf>
  800ad7:	83 c4 10             	add    $0x10,%esp
  800ada:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800add:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ae0:	c9                   	leave  
  800ae1:	c3                   	ret    

00800ae2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ae2:	55                   	push   %ebp
  800ae3:	89 e5                	mov    %esp,%ebp
  800ae5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ae8:	e8 1e 12 00 00       	call   801d0b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800aed:	8d 45 0c             	lea    0xc(%ebp),%eax
  800af0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	83 ec 08             	sub    $0x8,%esp
  800af9:	ff 75 f4             	pushl  -0xc(%ebp)
  800afc:	50                   	push   %eax
  800afd:	e8 48 ff ff ff       	call   800a4a <vcprintf>
  800b02:	83 c4 10             	add    $0x10,%esp
  800b05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b08:	e8 18 12 00 00       	call   801d25 <sys_enable_interrupt>
	return cnt;
  800b0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b10:	c9                   	leave  
  800b11:	c3                   	ret    

00800b12 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b12:	55                   	push   %ebp
  800b13:	89 e5                	mov    %esp,%ebp
  800b15:	53                   	push   %ebx
  800b16:	83 ec 14             	sub    $0x14,%esp
  800b19:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b22:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b25:	8b 45 18             	mov    0x18(%ebp),%eax
  800b28:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b30:	77 55                	ja     800b87 <printnum+0x75>
  800b32:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b35:	72 05                	jb     800b3c <printnum+0x2a>
  800b37:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b3a:	77 4b                	ja     800b87 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b3c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b3f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b42:	8b 45 18             	mov    0x18(%ebp),%eax
  800b45:	ba 00 00 00 00       	mov    $0x0,%edx
  800b4a:	52                   	push   %edx
  800b4b:	50                   	push   %eax
  800b4c:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4f:	ff 75 f0             	pushl  -0x10(%ebp)
  800b52:	e8 75 17 00 00       	call   8022cc <__udivdi3>
  800b57:	83 c4 10             	add    $0x10,%esp
  800b5a:	83 ec 04             	sub    $0x4,%esp
  800b5d:	ff 75 20             	pushl  0x20(%ebp)
  800b60:	53                   	push   %ebx
  800b61:	ff 75 18             	pushl  0x18(%ebp)
  800b64:	52                   	push   %edx
  800b65:	50                   	push   %eax
  800b66:	ff 75 0c             	pushl  0xc(%ebp)
  800b69:	ff 75 08             	pushl  0x8(%ebp)
  800b6c:	e8 a1 ff ff ff       	call   800b12 <printnum>
  800b71:	83 c4 20             	add    $0x20,%esp
  800b74:	eb 1a                	jmp    800b90 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b76:	83 ec 08             	sub    $0x8,%esp
  800b79:	ff 75 0c             	pushl  0xc(%ebp)
  800b7c:	ff 75 20             	pushl  0x20(%ebp)
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	ff d0                	call   *%eax
  800b84:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b87:	ff 4d 1c             	decl   0x1c(%ebp)
  800b8a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b8e:	7f e6                	jg     800b76 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b90:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b93:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b9b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b9e:	53                   	push   %ebx
  800b9f:	51                   	push   %ecx
  800ba0:	52                   	push   %edx
  800ba1:	50                   	push   %eax
  800ba2:	e8 35 18 00 00       	call   8023dc <__umoddi3>
  800ba7:	83 c4 10             	add    $0x10,%esp
  800baa:	05 d4 27 80 00       	add    $0x8027d4,%eax
  800baf:	8a 00                	mov    (%eax),%al
  800bb1:	0f be c0             	movsbl %al,%eax
  800bb4:	83 ec 08             	sub    $0x8,%esp
  800bb7:	ff 75 0c             	pushl  0xc(%ebp)
  800bba:	50                   	push   %eax
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	ff d0                	call   *%eax
  800bc0:	83 c4 10             	add    $0x10,%esp
}
  800bc3:	90                   	nop
  800bc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bc7:	c9                   	leave  
  800bc8:	c3                   	ret    

00800bc9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bc9:	55                   	push   %ebp
  800bca:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bcc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bd0:	7e 1c                	jle    800bee <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd5:	8b 00                	mov    (%eax),%eax
  800bd7:	8d 50 08             	lea    0x8(%eax),%edx
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	89 10                	mov    %edx,(%eax)
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	8b 00                	mov    (%eax),%eax
  800be4:	83 e8 08             	sub    $0x8,%eax
  800be7:	8b 50 04             	mov    0x4(%eax),%edx
  800bea:	8b 00                	mov    (%eax),%eax
  800bec:	eb 40                	jmp    800c2e <getuint+0x65>
	else if (lflag)
  800bee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bf2:	74 1e                	je     800c12 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	8b 00                	mov    (%eax),%eax
  800bf9:	8d 50 04             	lea    0x4(%eax),%edx
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	89 10                	mov    %edx,(%eax)
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	8b 00                	mov    (%eax),%eax
  800c06:	83 e8 04             	sub    $0x4,%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	ba 00 00 00 00       	mov    $0x0,%edx
  800c10:	eb 1c                	jmp    800c2e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	8b 00                	mov    (%eax),%eax
  800c17:	8d 50 04             	lea    0x4(%eax),%edx
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	89 10                	mov    %edx,(%eax)
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	8b 00                	mov    (%eax),%eax
  800c24:	83 e8 04             	sub    $0x4,%eax
  800c27:	8b 00                	mov    (%eax),%eax
  800c29:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c2e:	5d                   	pop    %ebp
  800c2f:	c3                   	ret    

00800c30 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c30:	55                   	push   %ebp
  800c31:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c33:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c37:	7e 1c                	jle    800c55 <getint+0x25>
		return va_arg(*ap, long long);
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	8b 00                	mov    (%eax),%eax
  800c3e:	8d 50 08             	lea    0x8(%eax),%edx
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	89 10                	mov    %edx,(%eax)
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	8b 00                	mov    (%eax),%eax
  800c4b:	83 e8 08             	sub    $0x8,%eax
  800c4e:	8b 50 04             	mov    0x4(%eax),%edx
  800c51:	8b 00                	mov    (%eax),%eax
  800c53:	eb 38                	jmp    800c8d <getint+0x5d>
	else if (lflag)
  800c55:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c59:	74 1a                	je     800c75 <getint+0x45>
		return va_arg(*ap, long);
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	8b 00                	mov    (%eax),%eax
  800c60:	8d 50 04             	lea    0x4(%eax),%edx
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	89 10                	mov    %edx,(%eax)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8b 00                	mov    (%eax),%eax
  800c6d:	83 e8 04             	sub    $0x4,%eax
  800c70:	8b 00                	mov    (%eax),%eax
  800c72:	99                   	cltd   
  800c73:	eb 18                	jmp    800c8d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
  800c78:	8b 00                	mov    (%eax),%eax
  800c7a:	8d 50 04             	lea    0x4(%eax),%edx
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	89 10                	mov    %edx,(%eax)
  800c82:	8b 45 08             	mov    0x8(%ebp),%eax
  800c85:	8b 00                	mov    (%eax),%eax
  800c87:	83 e8 04             	sub    $0x4,%eax
  800c8a:	8b 00                	mov    (%eax),%eax
  800c8c:	99                   	cltd   
}
  800c8d:	5d                   	pop    %ebp
  800c8e:	c3                   	ret    

00800c8f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c8f:	55                   	push   %ebp
  800c90:	89 e5                	mov    %esp,%ebp
  800c92:	56                   	push   %esi
  800c93:	53                   	push   %ebx
  800c94:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c97:	eb 17                	jmp    800cb0 <vprintfmt+0x21>
			if (ch == '\0')
  800c99:	85 db                	test   %ebx,%ebx
  800c9b:	0f 84 af 03 00 00    	je     801050 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ca1:	83 ec 08             	sub    $0x8,%esp
  800ca4:	ff 75 0c             	pushl  0xc(%ebp)
  800ca7:	53                   	push   %ebx
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	ff d0                	call   *%eax
  800cad:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb3:	8d 50 01             	lea    0x1(%eax),%edx
  800cb6:	89 55 10             	mov    %edx,0x10(%ebp)
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	0f b6 d8             	movzbl %al,%ebx
  800cbe:	83 fb 25             	cmp    $0x25,%ebx
  800cc1:	75 d6                	jne    800c99 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cc3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cc7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cce:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cd5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cdc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ce3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce6:	8d 50 01             	lea    0x1(%eax),%edx
  800ce9:	89 55 10             	mov    %edx,0x10(%ebp)
  800cec:	8a 00                	mov    (%eax),%al
  800cee:	0f b6 d8             	movzbl %al,%ebx
  800cf1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cf4:	83 f8 55             	cmp    $0x55,%eax
  800cf7:	0f 87 2b 03 00 00    	ja     801028 <vprintfmt+0x399>
  800cfd:	8b 04 85 f8 27 80 00 	mov    0x8027f8(,%eax,4),%eax
  800d04:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d06:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d0a:	eb d7                	jmp    800ce3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d0c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d10:	eb d1                	jmp    800ce3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d12:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d19:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d1c:	89 d0                	mov    %edx,%eax
  800d1e:	c1 e0 02             	shl    $0x2,%eax
  800d21:	01 d0                	add    %edx,%eax
  800d23:	01 c0                	add    %eax,%eax
  800d25:	01 d8                	add    %ebx,%eax
  800d27:	83 e8 30             	sub    $0x30,%eax
  800d2a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d35:	83 fb 2f             	cmp    $0x2f,%ebx
  800d38:	7e 3e                	jle    800d78 <vprintfmt+0xe9>
  800d3a:	83 fb 39             	cmp    $0x39,%ebx
  800d3d:	7f 39                	jg     800d78 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d3f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d42:	eb d5                	jmp    800d19 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d44:	8b 45 14             	mov    0x14(%ebp),%eax
  800d47:	83 c0 04             	add    $0x4,%eax
  800d4a:	89 45 14             	mov    %eax,0x14(%ebp)
  800d4d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d50:	83 e8 04             	sub    $0x4,%eax
  800d53:	8b 00                	mov    (%eax),%eax
  800d55:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d58:	eb 1f                	jmp    800d79 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d5a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5e:	79 83                	jns    800ce3 <vprintfmt+0x54>
				width = 0;
  800d60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d67:	e9 77 ff ff ff       	jmp    800ce3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d6c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d73:	e9 6b ff ff ff       	jmp    800ce3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d78:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7d:	0f 89 60 ff ff ff    	jns    800ce3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d83:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d86:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d89:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d90:	e9 4e ff ff ff       	jmp    800ce3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d95:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d98:	e9 46 ff ff ff       	jmp    800ce3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800da0:	83 c0 04             	add    $0x4,%eax
  800da3:	89 45 14             	mov    %eax,0x14(%ebp)
  800da6:	8b 45 14             	mov    0x14(%ebp),%eax
  800da9:	83 e8 04             	sub    $0x4,%eax
  800dac:	8b 00                	mov    (%eax),%eax
  800dae:	83 ec 08             	sub    $0x8,%esp
  800db1:	ff 75 0c             	pushl  0xc(%ebp)
  800db4:	50                   	push   %eax
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	ff d0                	call   *%eax
  800dba:	83 c4 10             	add    $0x10,%esp
			break;
  800dbd:	e9 89 02 00 00       	jmp    80104b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800dc2:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc5:	83 c0 04             	add    $0x4,%eax
  800dc8:	89 45 14             	mov    %eax,0x14(%ebp)
  800dcb:	8b 45 14             	mov    0x14(%ebp),%eax
  800dce:	83 e8 04             	sub    $0x4,%eax
  800dd1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dd3:	85 db                	test   %ebx,%ebx
  800dd5:	79 02                	jns    800dd9 <vprintfmt+0x14a>
				err = -err;
  800dd7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dd9:	83 fb 64             	cmp    $0x64,%ebx
  800ddc:	7f 0b                	jg     800de9 <vprintfmt+0x15a>
  800dde:	8b 34 9d 40 26 80 00 	mov    0x802640(,%ebx,4),%esi
  800de5:	85 f6                	test   %esi,%esi
  800de7:	75 19                	jne    800e02 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800de9:	53                   	push   %ebx
  800dea:	68 e5 27 80 00       	push   $0x8027e5
  800def:	ff 75 0c             	pushl  0xc(%ebp)
  800df2:	ff 75 08             	pushl  0x8(%ebp)
  800df5:	e8 5e 02 00 00       	call   801058 <printfmt>
  800dfa:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800dfd:	e9 49 02 00 00       	jmp    80104b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e02:	56                   	push   %esi
  800e03:	68 ee 27 80 00       	push   $0x8027ee
  800e08:	ff 75 0c             	pushl  0xc(%ebp)
  800e0b:	ff 75 08             	pushl  0x8(%ebp)
  800e0e:	e8 45 02 00 00       	call   801058 <printfmt>
  800e13:	83 c4 10             	add    $0x10,%esp
			break;
  800e16:	e9 30 02 00 00       	jmp    80104b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1e:	83 c0 04             	add    $0x4,%eax
  800e21:	89 45 14             	mov    %eax,0x14(%ebp)
  800e24:	8b 45 14             	mov    0x14(%ebp),%eax
  800e27:	83 e8 04             	sub    $0x4,%eax
  800e2a:	8b 30                	mov    (%eax),%esi
  800e2c:	85 f6                	test   %esi,%esi
  800e2e:	75 05                	jne    800e35 <vprintfmt+0x1a6>
				p = "(null)";
  800e30:	be f1 27 80 00       	mov    $0x8027f1,%esi
			if (width > 0 && padc != '-')
  800e35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e39:	7e 6d                	jle    800ea8 <vprintfmt+0x219>
  800e3b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e3f:	74 67                	je     800ea8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e41:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e44:	83 ec 08             	sub    $0x8,%esp
  800e47:	50                   	push   %eax
  800e48:	56                   	push   %esi
  800e49:	e8 0c 03 00 00       	call   80115a <strnlen>
  800e4e:	83 c4 10             	add    $0x10,%esp
  800e51:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e54:	eb 16                	jmp    800e6c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e56:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e5a:	83 ec 08             	sub    $0x8,%esp
  800e5d:	ff 75 0c             	pushl  0xc(%ebp)
  800e60:	50                   	push   %eax
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	ff d0                	call   *%eax
  800e66:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e69:	ff 4d e4             	decl   -0x1c(%ebp)
  800e6c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e70:	7f e4                	jg     800e56 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e72:	eb 34                	jmp    800ea8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e74:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e78:	74 1c                	je     800e96 <vprintfmt+0x207>
  800e7a:	83 fb 1f             	cmp    $0x1f,%ebx
  800e7d:	7e 05                	jle    800e84 <vprintfmt+0x1f5>
  800e7f:	83 fb 7e             	cmp    $0x7e,%ebx
  800e82:	7e 12                	jle    800e96 <vprintfmt+0x207>
					putch('?', putdat);
  800e84:	83 ec 08             	sub    $0x8,%esp
  800e87:	ff 75 0c             	pushl  0xc(%ebp)
  800e8a:	6a 3f                	push   $0x3f
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	ff d0                	call   *%eax
  800e91:	83 c4 10             	add    $0x10,%esp
  800e94:	eb 0f                	jmp    800ea5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e96:	83 ec 08             	sub    $0x8,%esp
  800e99:	ff 75 0c             	pushl  0xc(%ebp)
  800e9c:	53                   	push   %ebx
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	ff d0                	call   *%eax
  800ea2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ea5:	ff 4d e4             	decl   -0x1c(%ebp)
  800ea8:	89 f0                	mov    %esi,%eax
  800eaa:	8d 70 01             	lea    0x1(%eax),%esi
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	0f be d8             	movsbl %al,%ebx
  800eb2:	85 db                	test   %ebx,%ebx
  800eb4:	74 24                	je     800eda <vprintfmt+0x24b>
  800eb6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eba:	78 b8                	js     800e74 <vprintfmt+0x1e5>
  800ebc:	ff 4d e0             	decl   -0x20(%ebp)
  800ebf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ec3:	79 af                	jns    800e74 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ec5:	eb 13                	jmp    800eda <vprintfmt+0x24b>
				putch(' ', putdat);
  800ec7:	83 ec 08             	sub    $0x8,%esp
  800eca:	ff 75 0c             	pushl  0xc(%ebp)
  800ecd:	6a 20                	push   $0x20
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	ff d0                	call   *%eax
  800ed4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ed7:	ff 4d e4             	decl   -0x1c(%ebp)
  800eda:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ede:	7f e7                	jg     800ec7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ee0:	e9 66 01 00 00       	jmp    80104b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ee5:	83 ec 08             	sub    $0x8,%esp
  800ee8:	ff 75 e8             	pushl  -0x18(%ebp)
  800eeb:	8d 45 14             	lea    0x14(%ebp),%eax
  800eee:	50                   	push   %eax
  800eef:	e8 3c fd ff ff       	call   800c30 <getint>
  800ef4:	83 c4 10             	add    $0x10,%esp
  800ef7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800efa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800efd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f00:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f03:	85 d2                	test   %edx,%edx
  800f05:	79 23                	jns    800f2a <vprintfmt+0x29b>
				putch('-', putdat);
  800f07:	83 ec 08             	sub    $0x8,%esp
  800f0a:	ff 75 0c             	pushl  0xc(%ebp)
  800f0d:	6a 2d                	push   $0x2d
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	ff d0                	call   *%eax
  800f14:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1d:	f7 d8                	neg    %eax
  800f1f:	83 d2 00             	adc    $0x0,%edx
  800f22:	f7 da                	neg    %edx
  800f24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f27:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f2a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f31:	e9 bc 00 00 00       	jmp    800ff2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f36:	83 ec 08             	sub    $0x8,%esp
  800f39:	ff 75 e8             	pushl  -0x18(%ebp)
  800f3c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3f:	50                   	push   %eax
  800f40:	e8 84 fc ff ff       	call   800bc9 <getuint>
  800f45:	83 c4 10             	add    $0x10,%esp
  800f48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f4b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f4e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f55:	e9 98 00 00 00       	jmp    800ff2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f5a:	83 ec 08             	sub    $0x8,%esp
  800f5d:	ff 75 0c             	pushl  0xc(%ebp)
  800f60:	6a 58                	push   $0x58
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	ff d0                	call   *%eax
  800f67:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f6a:	83 ec 08             	sub    $0x8,%esp
  800f6d:	ff 75 0c             	pushl  0xc(%ebp)
  800f70:	6a 58                	push   $0x58
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	ff d0                	call   *%eax
  800f77:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f7a:	83 ec 08             	sub    $0x8,%esp
  800f7d:	ff 75 0c             	pushl  0xc(%ebp)
  800f80:	6a 58                	push   $0x58
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	ff d0                	call   *%eax
  800f87:	83 c4 10             	add    $0x10,%esp
			break;
  800f8a:	e9 bc 00 00 00       	jmp    80104b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f8f:	83 ec 08             	sub    $0x8,%esp
  800f92:	ff 75 0c             	pushl  0xc(%ebp)
  800f95:	6a 30                	push   $0x30
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	ff d0                	call   *%eax
  800f9c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f9f:	83 ec 08             	sub    $0x8,%esp
  800fa2:	ff 75 0c             	pushl  0xc(%ebp)
  800fa5:	6a 78                	push   $0x78
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	ff d0                	call   *%eax
  800fac:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800faf:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb2:	83 c0 04             	add    $0x4,%eax
  800fb5:	89 45 14             	mov    %eax,0x14(%ebp)
  800fb8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbb:	83 e8 04             	sub    $0x4,%eax
  800fbe:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fca:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fd1:	eb 1f                	jmp    800ff2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fd3:	83 ec 08             	sub    $0x8,%esp
  800fd6:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd9:	8d 45 14             	lea    0x14(%ebp),%eax
  800fdc:	50                   	push   %eax
  800fdd:	e8 e7 fb ff ff       	call   800bc9 <getuint>
  800fe2:	83 c4 10             	add    $0x10,%esp
  800fe5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800feb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ff2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ff6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ff9:	83 ec 04             	sub    $0x4,%esp
  800ffc:	52                   	push   %edx
  800ffd:	ff 75 e4             	pushl  -0x1c(%ebp)
  801000:	50                   	push   %eax
  801001:	ff 75 f4             	pushl  -0xc(%ebp)
  801004:	ff 75 f0             	pushl  -0x10(%ebp)
  801007:	ff 75 0c             	pushl  0xc(%ebp)
  80100a:	ff 75 08             	pushl  0x8(%ebp)
  80100d:	e8 00 fb ff ff       	call   800b12 <printnum>
  801012:	83 c4 20             	add    $0x20,%esp
			break;
  801015:	eb 34                	jmp    80104b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801017:	83 ec 08             	sub    $0x8,%esp
  80101a:	ff 75 0c             	pushl  0xc(%ebp)
  80101d:	53                   	push   %ebx
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	ff d0                	call   *%eax
  801023:	83 c4 10             	add    $0x10,%esp
			break;
  801026:	eb 23                	jmp    80104b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801028:	83 ec 08             	sub    $0x8,%esp
  80102b:	ff 75 0c             	pushl  0xc(%ebp)
  80102e:	6a 25                	push   $0x25
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	ff d0                	call   *%eax
  801035:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801038:	ff 4d 10             	decl   0x10(%ebp)
  80103b:	eb 03                	jmp    801040 <vprintfmt+0x3b1>
  80103d:	ff 4d 10             	decl   0x10(%ebp)
  801040:	8b 45 10             	mov    0x10(%ebp),%eax
  801043:	48                   	dec    %eax
  801044:	8a 00                	mov    (%eax),%al
  801046:	3c 25                	cmp    $0x25,%al
  801048:	75 f3                	jne    80103d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80104a:	90                   	nop
		}
	}
  80104b:	e9 47 fc ff ff       	jmp    800c97 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801050:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801051:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801054:	5b                   	pop    %ebx
  801055:	5e                   	pop    %esi
  801056:	5d                   	pop    %ebp
  801057:	c3                   	ret    

00801058 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801058:	55                   	push   %ebp
  801059:	89 e5                	mov    %esp,%ebp
  80105b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80105e:	8d 45 10             	lea    0x10(%ebp),%eax
  801061:	83 c0 04             	add    $0x4,%eax
  801064:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801067:	8b 45 10             	mov    0x10(%ebp),%eax
  80106a:	ff 75 f4             	pushl  -0xc(%ebp)
  80106d:	50                   	push   %eax
  80106e:	ff 75 0c             	pushl  0xc(%ebp)
  801071:	ff 75 08             	pushl  0x8(%ebp)
  801074:	e8 16 fc ff ff       	call   800c8f <vprintfmt>
  801079:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80107c:	90                   	nop
  80107d:	c9                   	leave  
  80107e:	c3                   	ret    

0080107f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80107f:	55                   	push   %ebp
  801080:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801082:	8b 45 0c             	mov    0xc(%ebp),%eax
  801085:	8b 40 08             	mov    0x8(%eax),%eax
  801088:	8d 50 01             	lea    0x1(%eax),%edx
  80108b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801091:	8b 45 0c             	mov    0xc(%ebp),%eax
  801094:	8b 10                	mov    (%eax),%edx
  801096:	8b 45 0c             	mov    0xc(%ebp),%eax
  801099:	8b 40 04             	mov    0x4(%eax),%eax
  80109c:	39 c2                	cmp    %eax,%edx
  80109e:	73 12                	jae    8010b2 <sprintputch+0x33>
		*b->buf++ = ch;
  8010a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a3:	8b 00                	mov    (%eax),%eax
  8010a5:	8d 48 01             	lea    0x1(%eax),%ecx
  8010a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ab:	89 0a                	mov    %ecx,(%edx)
  8010ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8010b0:	88 10                	mov    %dl,(%eax)
}
  8010b2:	90                   	nop
  8010b3:	5d                   	pop    %ebp
  8010b4:	c3                   	ret    

008010b5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010b5:	55                   	push   %ebp
  8010b6:	89 e5                	mov    %esp,%ebp
  8010b8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	01 d0                	add    %edx,%eax
  8010cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010da:	74 06                	je     8010e2 <vsnprintf+0x2d>
  8010dc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010e0:	7f 07                	jg     8010e9 <vsnprintf+0x34>
		return -E_INVAL;
  8010e2:	b8 03 00 00 00       	mov    $0x3,%eax
  8010e7:	eb 20                	jmp    801109 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010e9:	ff 75 14             	pushl  0x14(%ebp)
  8010ec:	ff 75 10             	pushl  0x10(%ebp)
  8010ef:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010f2:	50                   	push   %eax
  8010f3:	68 7f 10 80 00       	push   $0x80107f
  8010f8:	e8 92 fb ff ff       	call   800c8f <vprintfmt>
  8010fd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801100:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801103:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801106:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801109:	c9                   	leave  
  80110a:	c3                   	ret    

0080110b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
  80110e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801111:	8d 45 10             	lea    0x10(%ebp),%eax
  801114:	83 c0 04             	add    $0x4,%eax
  801117:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80111a:	8b 45 10             	mov    0x10(%ebp),%eax
  80111d:	ff 75 f4             	pushl  -0xc(%ebp)
  801120:	50                   	push   %eax
  801121:	ff 75 0c             	pushl  0xc(%ebp)
  801124:	ff 75 08             	pushl  0x8(%ebp)
  801127:	e8 89 ff ff ff       	call   8010b5 <vsnprintf>
  80112c:	83 c4 10             	add    $0x10,%esp
  80112f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801132:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801135:	c9                   	leave  
  801136:	c3                   	ret    

00801137 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801137:	55                   	push   %ebp
  801138:	89 e5                	mov    %esp,%ebp
  80113a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80113d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801144:	eb 06                	jmp    80114c <strlen+0x15>
		n++;
  801146:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801149:	ff 45 08             	incl   0x8(%ebp)
  80114c:	8b 45 08             	mov    0x8(%ebp),%eax
  80114f:	8a 00                	mov    (%eax),%al
  801151:	84 c0                	test   %al,%al
  801153:	75 f1                	jne    801146 <strlen+0xf>
		n++;
	return n;
  801155:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801158:	c9                   	leave  
  801159:	c3                   	ret    

0080115a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80115a:	55                   	push   %ebp
  80115b:	89 e5                	mov    %esp,%ebp
  80115d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801160:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801167:	eb 09                	jmp    801172 <strnlen+0x18>
		n++;
  801169:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80116c:	ff 45 08             	incl   0x8(%ebp)
  80116f:	ff 4d 0c             	decl   0xc(%ebp)
  801172:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801176:	74 09                	je     801181 <strnlen+0x27>
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	84 c0                	test   %al,%al
  80117f:	75 e8                	jne    801169 <strnlen+0xf>
		n++;
	return n;
  801181:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801184:	c9                   	leave  
  801185:	c3                   	ret    

00801186 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801186:	55                   	push   %ebp
  801187:	89 e5                	mov    %esp,%ebp
  801189:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801192:	90                   	nop
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	8d 50 01             	lea    0x1(%eax),%edx
  801199:	89 55 08             	mov    %edx,0x8(%ebp)
  80119c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80119f:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011a2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011a5:	8a 12                	mov    (%edx),%dl
  8011a7:	88 10                	mov    %dl,(%eax)
  8011a9:	8a 00                	mov    (%eax),%al
  8011ab:	84 c0                	test   %al,%al
  8011ad:	75 e4                	jne    801193 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8011af:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
  8011b7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8011c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011c7:	eb 1f                	jmp    8011e8 <strncpy+0x34>
		*dst++ = *src;
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8d 50 01             	lea    0x1(%eax),%edx
  8011cf:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011d5:	8a 12                	mov    (%edx),%dl
  8011d7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8011d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dc:	8a 00                	mov    (%eax),%al
  8011de:	84 c0                	test   %al,%al
  8011e0:	74 03                	je     8011e5 <strncpy+0x31>
			src++;
  8011e2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8011e5:	ff 45 fc             	incl   -0x4(%ebp)
  8011e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011eb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ee:	72 d9                	jb     8011c9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8011f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011f3:	c9                   	leave  
  8011f4:	c3                   	ret    

008011f5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8011f5:	55                   	push   %ebp
  8011f6:	89 e5                	mov    %esp,%ebp
  8011f8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8011fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801201:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801205:	74 30                	je     801237 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801207:	eb 16                	jmp    80121f <strlcpy+0x2a>
			*dst++ = *src++;
  801209:	8b 45 08             	mov    0x8(%ebp),%eax
  80120c:	8d 50 01             	lea    0x1(%eax),%edx
  80120f:	89 55 08             	mov    %edx,0x8(%ebp)
  801212:	8b 55 0c             	mov    0xc(%ebp),%edx
  801215:	8d 4a 01             	lea    0x1(%edx),%ecx
  801218:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80121b:	8a 12                	mov    (%edx),%dl
  80121d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80121f:	ff 4d 10             	decl   0x10(%ebp)
  801222:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801226:	74 09                	je     801231 <strlcpy+0x3c>
  801228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	84 c0                	test   %al,%al
  80122f:	75 d8                	jne    801209 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801231:	8b 45 08             	mov    0x8(%ebp),%eax
  801234:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801237:	8b 55 08             	mov    0x8(%ebp),%edx
  80123a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123d:	29 c2                	sub    %eax,%edx
  80123f:	89 d0                	mov    %edx,%eax
}
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801246:	eb 06                	jmp    80124e <strcmp+0xb>
		p++, q++;
  801248:	ff 45 08             	incl   0x8(%ebp)
  80124b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	84 c0                	test   %al,%al
  801255:	74 0e                	je     801265 <strcmp+0x22>
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8a 10                	mov    (%eax),%dl
  80125c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125f:	8a 00                	mov    (%eax),%al
  801261:	38 c2                	cmp    %al,%dl
  801263:	74 e3                	je     801248 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	8a 00                	mov    (%eax),%al
  80126a:	0f b6 d0             	movzbl %al,%edx
  80126d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801270:	8a 00                	mov    (%eax),%al
  801272:	0f b6 c0             	movzbl %al,%eax
  801275:	29 c2                	sub    %eax,%edx
  801277:	89 d0                	mov    %edx,%eax
}
  801279:	5d                   	pop    %ebp
  80127a:	c3                   	ret    

0080127b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80127e:	eb 09                	jmp    801289 <strncmp+0xe>
		n--, p++, q++;
  801280:	ff 4d 10             	decl   0x10(%ebp)
  801283:	ff 45 08             	incl   0x8(%ebp)
  801286:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801289:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80128d:	74 17                	je     8012a6 <strncmp+0x2b>
  80128f:	8b 45 08             	mov    0x8(%ebp),%eax
  801292:	8a 00                	mov    (%eax),%al
  801294:	84 c0                	test   %al,%al
  801296:	74 0e                	je     8012a6 <strncmp+0x2b>
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
  80129b:	8a 10                	mov    (%eax),%dl
  80129d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	38 c2                	cmp    %al,%dl
  8012a4:	74 da                	je     801280 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8012a6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012aa:	75 07                	jne    8012b3 <strncmp+0x38>
		return 0;
  8012ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8012b1:	eb 14                	jmp    8012c7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	8a 00                	mov    (%eax),%al
  8012b8:	0f b6 d0             	movzbl %al,%edx
  8012bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012be:	8a 00                	mov    (%eax),%al
  8012c0:	0f b6 c0             	movzbl %al,%eax
  8012c3:	29 c2                	sub    %eax,%edx
  8012c5:	89 d0                	mov    %edx,%eax
}
  8012c7:	5d                   	pop    %ebp
  8012c8:	c3                   	ret    

008012c9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8012c9:	55                   	push   %ebp
  8012ca:	89 e5                	mov    %esp,%ebp
  8012cc:	83 ec 04             	sub    $0x4,%esp
  8012cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012d5:	eb 12                	jmp    8012e9 <strchr+0x20>
		if (*s == c)
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	8a 00                	mov    (%eax),%al
  8012dc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012df:	75 05                	jne    8012e6 <strchr+0x1d>
			return (char *) s;
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	eb 11                	jmp    8012f7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8012e6:	ff 45 08             	incl   0x8(%ebp)
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	84 c0                	test   %al,%al
  8012f0:	75 e5                	jne    8012d7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8012f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
  8012fc:	83 ec 04             	sub    $0x4,%esp
  8012ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801302:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801305:	eb 0d                	jmp    801314 <strfind+0x1b>
		if (*s == c)
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	8a 00                	mov    (%eax),%al
  80130c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80130f:	74 0e                	je     80131f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801311:	ff 45 08             	incl   0x8(%ebp)
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	8a 00                	mov    (%eax),%al
  801319:	84 c0                	test   %al,%al
  80131b:	75 ea                	jne    801307 <strfind+0xe>
  80131d:	eb 01                	jmp    801320 <strfind+0x27>
		if (*s == c)
			break;
  80131f:	90                   	nop
	return (char *) s;
  801320:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801331:	8b 45 10             	mov    0x10(%ebp),%eax
  801334:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801337:	eb 0e                	jmp    801347 <memset+0x22>
		*p++ = c;
  801339:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133c:	8d 50 01             	lea    0x1(%eax),%edx
  80133f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801342:	8b 55 0c             	mov    0xc(%ebp),%edx
  801345:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801347:	ff 4d f8             	decl   -0x8(%ebp)
  80134a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80134e:	79 e9                	jns    801339 <memset+0x14>
		*p++ = c;

	return v;
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801353:	c9                   	leave  
  801354:	c3                   	ret    

00801355 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801355:	55                   	push   %ebp
  801356:	89 e5                	mov    %esp,%ebp
  801358:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80135b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801367:	eb 16                	jmp    80137f <memcpy+0x2a>
		*d++ = *s++;
  801369:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80136c:	8d 50 01             	lea    0x1(%eax),%edx
  80136f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801372:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801375:	8d 4a 01             	lea    0x1(%edx),%ecx
  801378:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80137b:	8a 12                	mov    (%edx),%dl
  80137d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80137f:	8b 45 10             	mov    0x10(%ebp),%eax
  801382:	8d 50 ff             	lea    -0x1(%eax),%edx
  801385:	89 55 10             	mov    %edx,0x10(%ebp)
  801388:	85 c0                	test   %eax,%eax
  80138a:	75 dd                	jne    801369 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80138c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
  801394:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8013a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013a9:	73 50                	jae    8013fb <memmove+0x6a>
  8013ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b1:	01 d0                	add    %edx,%eax
  8013b3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013b6:	76 43                	jbe    8013fb <memmove+0x6a>
		s += n;
  8013b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013bb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8013be:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8013c4:	eb 10                	jmp    8013d6 <memmove+0x45>
			*--d = *--s;
  8013c6:	ff 4d f8             	decl   -0x8(%ebp)
  8013c9:	ff 4d fc             	decl   -0x4(%ebp)
  8013cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013cf:	8a 10                	mov    (%eax),%dl
  8013d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8013d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013dc:	89 55 10             	mov    %edx,0x10(%ebp)
  8013df:	85 c0                	test   %eax,%eax
  8013e1:	75 e3                	jne    8013c6 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8013e3:	eb 23                	jmp    801408 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8013e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e8:	8d 50 01             	lea    0x1(%eax),%edx
  8013eb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013f1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013f4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013f7:	8a 12                	mov    (%edx),%dl
  8013f9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8013fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801401:	89 55 10             	mov    %edx,0x10(%ebp)
  801404:	85 c0                	test   %eax,%eax
  801406:	75 dd                	jne    8013e5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
  801410:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801413:	8b 45 08             	mov    0x8(%ebp),%eax
  801416:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801419:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80141f:	eb 2a                	jmp    80144b <memcmp+0x3e>
		if (*s1 != *s2)
  801421:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801424:	8a 10                	mov    (%eax),%dl
  801426:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801429:	8a 00                	mov    (%eax),%al
  80142b:	38 c2                	cmp    %al,%dl
  80142d:	74 16                	je     801445 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80142f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	0f b6 d0             	movzbl %al,%edx
  801437:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143a:	8a 00                	mov    (%eax),%al
  80143c:	0f b6 c0             	movzbl %al,%eax
  80143f:	29 c2                	sub    %eax,%edx
  801441:	89 d0                	mov    %edx,%eax
  801443:	eb 18                	jmp    80145d <memcmp+0x50>
		s1++, s2++;
  801445:	ff 45 fc             	incl   -0x4(%ebp)
  801448:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80144b:	8b 45 10             	mov    0x10(%ebp),%eax
  80144e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801451:	89 55 10             	mov    %edx,0x10(%ebp)
  801454:	85 c0                	test   %eax,%eax
  801456:	75 c9                	jne    801421 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801458:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80145d:	c9                   	leave  
  80145e:	c3                   	ret    

0080145f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80145f:	55                   	push   %ebp
  801460:	89 e5                	mov    %esp,%ebp
  801462:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801465:	8b 55 08             	mov    0x8(%ebp),%edx
  801468:	8b 45 10             	mov    0x10(%ebp),%eax
  80146b:	01 d0                	add    %edx,%eax
  80146d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801470:	eb 15                	jmp    801487 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801472:	8b 45 08             	mov    0x8(%ebp),%eax
  801475:	8a 00                	mov    (%eax),%al
  801477:	0f b6 d0             	movzbl %al,%edx
  80147a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147d:	0f b6 c0             	movzbl %al,%eax
  801480:	39 c2                	cmp    %eax,%edx
  801482:	74 0d                	je     801491 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801484:	ff 45 08             	incl   0x8(%ebp)
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80148d:	72 e3                	jb     801472 <memfind+0x13>
  80148f:	eb 01                	jmp    801492 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801491:	90                   	nop
	return (void *) s;
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
  80149a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80149d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8014a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014ab:	eb 03                	jmp    8014b0 <strtol+0x19>
		s++;
  8014ad:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	3c 20                	cmp    $0x20,%al
  8014b7:	74 f4                	je     8014ad <strtol+0x16>
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	3c 09                	cmp    $0x9,%al
  8014c0:	74 eb                	je     8014ad <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	8a 00                	mov    (%eax),%al
  8014c7:	3c 2b                	cmp    $0x2b,%al
  8014c9:	75 05                	jne    8014d0 <strtol+0x39>
		s++;
  8014cb:	ff 45 08             	incl   0x8(%ebp)
  8014ce:	eb 13                	jmp    8014e3 <strtol+0x4c>
	else if (*s == '-')
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	8a 00                	mov    (%eax),%al
  8014d5:	3c 2d                	cmp    $0x2d,%al
  8014d7:	75 0a                	jne    8014e3 <strtol+0x4c>
		s++, neg = 1;
  8014d9:	ff 45 08             	incl   0x8(%ebp)
  8014dc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8014e3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e7:	74 06                	je     8014ef <strtol+0x58>
  8014e9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8014ed:	75 20                	jne    80150f <strtol+0x78>
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	3c 30                	cmp    $0x30,%al
  8014f6:	75 17                	jne    80150f <strtol+0x78>
  8014f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fb:	40                   	inc    %eax
  8014fc:	8a 00                	mov    (%eax),%al
  8014fe:	3c 78                	cmp    $0x78,%al
  801500:	75 0d                	jne    80150f <strtol+0x78>
		s += 2, base = 16;
  801502:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801506:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80150d:	eb 28                	jmp    801537 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80150f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801513:	75 15                	jne    80152a <strtol+0x93>
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	8a 00                	mov    (%eax),%al
  80151a:	3c 30                	cmp    $0x30,%al
  80151c:	75 0c                	jne    80152a <strtol+0x93>
		s++, base = 8;
  80151e:	ff 45 08             	incl   0x8(%ebp)
  801521:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801528:	eb 0d                	jmp    801537 <strtol+0xa0>
	else if (base == 0)
  80152a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80152e:	75 07                	jne    801537 <strtol+0xa0>
		base = 10;
  801530:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801537:	8b 45 08             	mov    0x8(%ebp),%eax
  80153a:	8a 00                	mov    (%eax),%al
  80153c:	3c 2f                	cmp    $0x2f,%al
  80153e:	7e 19                	jle    801559 <strtol+0xc2>
  801540:	8b 45 08             	mov    0x8(%ebp),%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	3c 39                	cmp    $0x39,%al
  801547:	7f 10                	jg     801559 <strtol+0xc2>
			dig = *s - '0';
  801549:	8b 45 08             	mov    0x8(%ebp),%eax
  80154c:	8a 00                	mov    (%eax),%al
  80154e:	0f be c0             	movsbl %al,%eax
  801551:	83 e8 30             	sub    $0x30,%eax
  801554:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801557:	eb 42                	jmp    80159b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	8a 00                	mov    (%eax),%al
  80155e:	3c 60                	cmp    $0x60,%al
  801560:	7e 19                	jle    80157b <strtol+0xe4>
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	8a 00                	mov    (%eax),%al
  801567:	3c 7a                	cmp    $0x7a,%al
  801569:	7f 10                	jg     80157b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	0f be c0             	movsbl %al,%eax
  801573:	83 e8 57             	sub    $0x57,%eax
  801576:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801579:	eb 20                	jmp    80159b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
  80157e:	8a 00                	mov    (%eax),%al
  801580:	3c 40                	cmp    $0x40,%al
  801582:	7e 39                	jle    8015bd <strtol+0x126>
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	8a 00                	mov    (%eax),%al
  801589:	3c 5a                	cmp    $0x5a,%al
  80158b:	7f 30                	jg     8015bd <strtol+0x126>
			dig = *s - 'A' + 10;
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	8a 00                	mov    (%eax),%al
  801592:	0f be c0             	movsbl %al,%eax
  801595:	83 e8 37             	sub    $0x37,%eax
  801598:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80159e:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015a1:	7d 19                	jge    8015bc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8015a3:	ff 45 08             	incl   0x8(%ebp)
  8015a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a9:	0f af 45 10          	imul   0x10(%ebp),%eax
  8015ad:	89 c2                	mov    %eax,%edx
  8015af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015b2:	01 d0                	add    %edx,%eax
  8015b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8015b7:	e9 7b ff ff ff       	jmp    801537 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8015bc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8015bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015c1:	74 08                	je     8015cb <strtol+0x134>
		*endptr = (char *) s;
  8015c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c6:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8015cb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015cf:	74 07                	je     8015d8 <strtol+0x141>
  8015d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d4:	f7 d8                	neg    %eax
  8015d6:	eb 03                	jmp    8015db <strtol+0x144>
  8015d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <ltostr>:

void
ltostr(long value, char *str)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
  8015e0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8015e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8015ea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8015f1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015f5:	79 13                	jns    80160a <ltostr+0x2d>
	{
		neg = 1;
  8015f7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8015fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801601:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801604:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801607:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
  80160d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801612:	99                   	cltd   
  801613:	f7 f9                	idiv   %ecx
  801615:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801618:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161b:	8d 50 01             	lea    0x1(%eax),%edx
  80161e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801621:	89 c2                	mov    %eax,%edx
  801623:	8b 45 0c             	mov    0xc(%ebp),%eax
  801626:	01 d0                	add    %edx,%eax
  801628:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80162b:	83 c2 30             	add    $0x30,%edx
  80162e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801630:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801633:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801638:	f7 e9                	imul   %ecx
  80163a:	c1 fa 02             	sar    $0x2,%edx
  80163d:	89 c8                	mov    %ecx,%eax
  80163f:	c1 f8 1f             	sar    $0x1f,%eax
  801642:	29 c2                	sub    %eax,%edx
  801644:	89 d0                	mov    %edx,%eax
  801646:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801649:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80164c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801651:	f7 e9                	imul   %ecx
  801653:	c1 fa 02             	sar    $0x2,%edx
  801656:	89 c8                	mov    %ecx,%eax
  801658:	c1 f8 1f             	sar    $0x1f,%eax
  80165b:	29 c2                	sub    %eax,%edx
  80165d:	89 d0                	mov    %edx,%eax
  80165f:	c1 e0 02             	shl    $0x2,%eax
  801662:	01 d0                	add    %edx,%eax
  801664:	01 c0                	add    %eax,%eax
  801666:	29 c1                	sub    %eax,%ecx
  801668:	89 ca                	mov    %ecx,%edx
  80166a:	85 d2                	test   %edx,%edx
  80166c:	75 9c                	jne    80160a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80166e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801675:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801678:	48                   	dec    %eax
  801679:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80167c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801680:	74 3d                	je     8016bf <ltostr+0xe2>
		start = 1 ;
  801682:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801689:	eb 34                	jmp    8016bf <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80168b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80168e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801691:	01 d0                	add    %edx,%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801698:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80169b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80169e:	01 c2                	add    %eax,%edx
  8016a0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8016a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a6:	01 c8                	add    %ecx,%eax
  8016a8:	8a 00                	mov    (%eax),%al
  8016aa:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8016ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b2:	01 c2                	add    %eax,%edx
  8016b4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8016b7:	88 02                	mov    %al,(%edx)
		start++ ;
  8016b9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8016bc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8016bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016c5:	7c c4                	jl     80168b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8016c7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8016ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cd:	01 d0                	add    %edx,%eax
  8016cf:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8016d2:	90                   	nop
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
  8016d8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8016db:	ff 75 08             	pushl  0x8(%ebp)
  8016de:	e8 54 fa ff ff       	call   801137 <strlen>
  8016e3:	83 c4 04             	add    $0x4,%esp
  8016e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8016e9:	ff 75 0c             	pushl  0xc(%ebp)
  8016ec:	e8 46 fa ff ff       	call   801137 <strlen>
  8016f1:	83 c4 04             	add    $0x4,%esp
  8016f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8016f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8016fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801705:	eb 17                	jmp    80171e <strcconcat+0x49>
		final[s] = str1[s] ;
  801707:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80170a:	8b 45 10             	mov    0x10(%ebp),%eax
  80170d:	01 c2                	add    %eax,%edx
  80170f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801712:	8b 45 08             	mov    0x8(%ebp),%eax
  801715:	01 c8                	add    %ecx,%eax
  801717:	8a 00                	mov    (%eax),%al
  801719:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80171b:	ff 45 fc             	incl   -0x4(%ebp)
  80171e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801721:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801724:	7c e1                	jl     801707 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801726:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80172d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801734:	eb 1f                	jmp    801755 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801736:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801739:	8d 50 01             	lea    0x1(%eax),%edx
  80173c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80173f:	89 c2                	mov    %eax,%edx
  801741:	8b 45 10             	mov    0x10(%ebp),%eax
  801744:	01 c2                	add    %eax,%edx
  801746:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801749:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174c:	01 c8                	add    %ecx,%eax
  80174e:	8a 00                	mov    (%eax),%al
  801750:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801752:	ff 45 f8             	incl   -0x8(%ebp)
  801755:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801758:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80175b:	7c d9                	jl     801736 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80175d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801760:	8b 45 10             	mov    0x10(%ebp),%eax
  801763:	01 d0                	add    %edx,%eax
  801765:	c6 00 00             	movb   $0x0,(%eax)
}
  801768:	90                   	nop
  801769:	c9                   	leave  
  80176a:	c3                   	ret    

0080176b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80176b:	55                   	push   %ebp
  80176c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80176e:	8b 45 14             	mov    0x14(%ebp),%eax
  801771:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801777:	8b 45 14             	mov    0x14(%ebp),%eax
  80177a:	8b 00                	mov    (%eax),%eax
  80177c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801783:	8b 45 10             	mov    0x10(%ebp),%eax
  801786:	01 d0                	add    %edx,%eax
  801788:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80178e:	eb 0c                	jmp    80179c <strsplit+0x31>
			*string++ = 0;
  801790:	8b 45 08             	mov    0x8(%ebp),%eax
  801793:	8d 50 01             	lea    0x1(%eax),%edx
  801796:	89 55 08             	mov    %edx,0x8(%ebp)
  801799:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	8a 00                	mov    (%eax),%al
  8017a1:	84 c0                	test   %al,%al
  8017a3:	74 18                	je     8017bd <strsplit+0x52>
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	8a 00                	mov    (%eax),%al
  8017aa:	0f be c0             	movsbl %al,%eax
  8017ad:	50                   	push   %eax
  8017ae:	ff 75 0c             	pushl  0xc(%ebp)
  8017b1:	e8 13 fb ff ff       	call   8012c9 <strchr>
  8017b6:	83 c4 08             	add    $0x8,%esp
  8017b9:	85 c0                	test   %eax,%eax
  8017bb:	75 d3                	jne    801790 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8017bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c0:	8a 00                	mov    (%eax),%al
  8017c2:	84 c0                	test   %al,%al
  8017c4:	74 5a                	je     801820 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8017c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8017c9:	8b 00                	mov    (%eax),%eax
  8017cb:	83 f8 0f             	cmp    $0xf,%eax
  8017ce:	75 07                	jne    8017d7 <strsplit+0x6c>
		{
			return 0;
  8017d0:	b8 00 00 00 00       	mov    $0x0,%eax
  8017d5:	eb 66                	jmp    80183d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8017d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8017da:	8b 00                	mov    (%eax),%eax
  8017dc:	8d 48 01             	lea    0x1(%eax),%ecx
  8017df:	8b 55 14             	mov    0x14(%ebp),%edx
  8017e2:	89 0a                	mov    %ecx,(%edx)
  8017e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ee:	01 c2                	add    %eax,%edx
  8017f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017f5:	eb 03                	jmp    8017fa <strsplit+0x8f>
			string++;
  8017f7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fd:	8a 00                	mov    (%eax),%al
  8017ff:	84 c0                	test   %al,%al
  801801:	74 8b                	je     80178e <strsplit+0x23>
  801803:	8b 45 08             	mov    0x8(%ebp),%eax
  801806:	8a 00                	mov    (%eax),%al
  801808:	0f be c0             	movsbl %al,%eax
  80180b:	50                   	push   %eax
  80180c:	ff 75 0c             	pushl  0xc(%ebp)
  80180f:	e8 b5 fa ff ff       	call   8012c9 <strchr>
  801814:	83 c4 08             	add    $0x8,%esp
  801817:	85 c0                	test   %eax,%eax
  801819:	74 dc                	je     8017f7 <strsplit+0x8c>
			string++;
	}
  80181b:	e9 6e ff ff ff       	jmp    80178e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801820:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801821:	8b 45 14             	mov    0x14(%ebp),%eax
  801824:	8b 00                	mov    (%eax),%eax
  801826:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80182d:	8b 45 10             	mov    0x10(%ebp),%eax
  801830:	01 d0                	add    %edx,%eax
  801832:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801838:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
  801842:	83 ec 18             	sub    $0x18,%esp
  801845:	8b 45 10             	mov    0x10(%ebp),%eax
  801848:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80184b:	83 ec 04             	sub    $0x4,%esp
  80184e:	68 50 29 80 00       	push   $0x802950
  801853:	6a 17                	push   $0x17
  801855:	68 6f 29 80 00       	push   $0x80296f
  80185a:	e8 8a 08 00 00       	call   8020e9 <_panic>

0080185f <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80185f:	55                   	push   %ebp
  801860:	89 e5                	mov    %esp,%ebp
  801862:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801865:	83 ec 04             	sub    $0x4,%esp
  801868:	68 7b 29 80 00       	push   $0x80297b
  80186d:	6a 2f                	push   $0x2f
  80186f:	68 6f 29 80 00       	push   $0x80296f
  801874:	e8 70 08 00 00       	call   8020e9 <_panic>

00801879 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
  80187c:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80187f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801886:	8b 55 08             	mov    0x8(%ebp),%edx
  801889:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80188c:	01 d0                	add    %edx,%eax
  80188e:	48                   	dec    %eax
  80188f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801892:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801895:	ba 00 00 00 00       	mov    $0x0,%edx
  80189a:	f7 75 ec             	divl   -0x14(%ebp)
  80189d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018a0:	29 d0                	sub    %edx,%eax
  8018a2:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8018a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a8:	c1 e8 0c             	shr    $0xc,%eax
  8018ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8018ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8018b5:	e9 c8 00 00 00       	jmp    801982 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8018ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018c1:	eb 27                	jmp    8018ea <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8018c3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c9:	01 c2                	add    %eax,%edx
  8018cb:	89 d0                	mov    %edx,%eax
  8018cd:	01 c0                	add    %eax,%eax
  8018cf:	01 d0                	add    %edx,%eax
  8018d1:	c1 e0 02             	shl    $0x2,%eax
  8018d4:	05 48 30 80 00       	add    $0x803048,%eax
  8018d9:	8b 00                	mov    (%eax),%eax
  8018db:	85 c0                	test   %eax,%eax
  8018dd:	74 08                	je     8018e7 <malloc+0x6e>
            	i += j;
  8018df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018e2:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8018e5:	eb 0b                	jmp    8018f2 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8018e7:	ff 45 f0             	incl   -0x10(%ebp)
  8018ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018ed:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8018f0:	72 d1                	jb     8018c3 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8018f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018f5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8018f8:	0f 85 81 00 00 00    	jne    80197f <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8018fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801901:	05 00 00 08 00       	add    $0x80000,%eax
  801906:	c1 e0 0c             	shl    $0xc,%eax
  801909:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80190c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801913:	eb 1f                	jmp    801934 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801915:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801918:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80191b:	01 c2                	add    %eax,%edx
  80191d:	89 d0                	mov    %edx,%eax
  80191f:	01 c0                	add    %eax,%eax
  801921:	01 d0                	add    %edx,%eax
  801923:	c1 e0 02             	shl    $0x2,%eax
  801926:	05 48 30 80 00       	add    $0x803048,%eax
  80192b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801931:	ff 45 f0             	incl   -0x10(%ebp)
  801934:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801937:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80193a:	72 d9                	jb     801915 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80193c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80193f:	89 d0                	mov    %edx,%eax
  801941:	01 c0                	add    %eax,%eax
  801943:	01 d0                	add    %edx,%eax
  801945:	c1 e0 02             	shl    $0x2,%eax
  801948:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80194e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801951:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801953:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801956:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801959:	89 c8                	mov    %ecx,%eax
  80195b:	01 c0                	add    %eax,%eax
  80195d:	01 c8                	add    %ecx,%eax
  80195f:	c1 e0 02             	shl    $0x2,%eax
  801962:	05 44 30 80 00       	add    $0x803044,%eax
  801967:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801969:	83 ec 08             	sub    $0x8,%esp
  80196c:	ff 75 08             	pushl  0x8(%ebp)
  80196f:	ff 75 e0             	pushl  -0x20(%ebp)
  801972:	e8 2b 03 00 00       	call   801ca2 <sys_allocateMem>
  801977:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80197a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80197d:	eb 19                	jmp    801998 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80197f:	ff 45 f4             	incl   -0xc(%ebp)
  801982:	a1 04 30 80 00       	mov    0x803004,%eax
  801987:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80198a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80198d:	0f 83 27 ff ff ff    	jae    8018ba <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801993:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
  80199d:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8019a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019a4:	0f 84 e5 00 00 00    	je     801a8f <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8019aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8019b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019b3:	05 00 00 00 80       	add    $0x80000000,%eax
  8019b8:	c1 e8 0c             	shr    $0xc,%eax
  8019bb:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8019be:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019c1:	89 d0                	mov    %edx,%eax
  8019c3:	01 c0                	add    %eax,%eax
  8019c5:	01 d0                	add    %edx,%eax
  8019c7:	c1 e0 02             	shl    $0x2,%eax
  8019ca:	05 40 30 80 00       	add    $0x803040,%eax
  8019cf:	8b 00                	mov    (%eax),%eax
  8019d1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019d4:	0f 85 b8 00 00 00    	jne    801a92 <free+0xf8>
  8019da:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019dd:	89 d0                	mov    %edx,%eax
  8019df:	01 c0                	add    %eax,%eax
  8019e1:	01 d0                	add    %edx,%eax
  8019e3:	c1 e0 02             	shl    $0x2,%eax
  8019e6:	05 48 30 80 00       	add    $0x803048,%eax
  8019eb:	8b 00                	mov    (%eax),%eax
  8019ed:	85 c0                	test   %eax,%eax
  8019ef:	0f 84 9d 00 00 00    	je     801a92 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8019f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019f8:	89 d0                	mov    %edx,%eax
  8019fa:	01 c0                	add    %eax,%eax
  8019fc:	01 d0                	add    %edx,%eax
  8019fe:	c1 e0 02             	shl    $0x2,%eax
  801a01:	05 44 30 80 00       	add    $0x803044,%eax
  801a06:	8b 00                	mov    (%eax),%eax
  801a08:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801a0b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a0e:	c1 e0 0c             	shl    $0xc,%eax
  801a11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801a14:	83 ec 08             	sub    $0x8,%esp
  801a17:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a1a:	ff 75 f0             	pushl  -0x10(%ebp)
  801a1d:	e8 64 02 00 00       	call   801c86 <sys_freeMem>
  801a22:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801a25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a2c:	eb 57                	jmp    801a85 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801a2e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a34:	01 c2                	add    %eax,%edx
  801a36:	89 d0                	mov    %edx,%eax
  801a38:	01 c0                	add    %eax,%eax
  801a3a:	01 d0                	add    %edx,%eax
  801a3c:	c1 e0 02             	shl    $0x2,%eax
  801a3f:	05 48 30 80 00       	add    $0x803048,%eax
  801a44:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801a4a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a50:	01 c2                	add    %eax,%edx
  801a52:	89 d0                	mov    %edx,%eax
  801a54:	01 c0                	add    %eax,%eax
  801a56:	01 d0                	add    %edx,%eax
  801a58:	c1 e0 02             	shl    $0x2,%eax
  801a5b:	05 40 30 80 00       	add    $0x803040,%eax
  801a60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801a66:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a6c:	01 c2                	add    %eax,%edx
  801a6e:	89 d0                	mov    %edx,%eax
  801a70:	01 c0                	add    %eax,%eax
  801a72:	01 d0                	add    %edx,%eax
  801a74:	c1 e0 02             	shl    $0x2,%eax
  801a77:	05 44 30 80 00       	add    $0x803044,%eax
  801a7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801a82:	ff 45 f4             	incl   -0xc(%ebp)
  801a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a88:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a8b:	7c a1                	jl     801a2e <free+0x94>
  801a8d:	eb 04                	jmp    801a93 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801a8f:	90                   	nop
  801a90:	eb 01                	jmp    801a93 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801a92:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801a93:	c9                   	leave  
  801a94:	c3                   	ret    

00801a95 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801a95:	55                   	push   %ebp
  801a96:	89 e5                	mov    %esp,%ebp
  801a98:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801a9b:	83 ec 04             	sub    $0x4,%esp
  801a9e:	68 98 29 80 00       	push   $0x802998
  801aa3:	68 ae 00 00 00       	push   $0xae
  801aa8:	68 6f 29 80 00       	push   $0x80296f
  801aad:	e8 37 06 00 00       	call   8020e9 <_panic>

00801ab2 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
  801ab5:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801ab8:	83 ec 04             	sub    $0x4,%esp
  801abb:	68 b8 29 80 00       	push   $0x8029b8
  801ac0:	68 ca 00 00 00       	push   $0xca
  801ac5:	68 6f 29 80 00       	push   $0x80296f
  801aca:	e8 1a 06 00 00       	call   8020e9 <_panic>

00801acf <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
  801ad2:	57                   	push   %edi
  801ad3:	56                   	push   %esi
  801ad4:	53                   	push   %ebx
  801ad5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  801adb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ade:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ae1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ae4:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ae7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801aea:	cd 30                	int    $0x30
  801aec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801aef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801af2:	83 c4 10             	add    $0x10,%esp
  801af5:	5b                   	pop    %ebx
  801af6:	5e                   	pop    %esi
  801af7:	5f                   	pop    %edi
  801af8:	5d                   	pop    %ebp
  801af9:	c3                   	ret    

00801afa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
  801afd:	83 ec 04             	sub    $0x4,%esp
  801b00:	8b 45 10             	mov    0x10(%ebp),%eax
  801b03:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b06:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	52                   	push   %edx
  801b12:	ff 75 0c             	pushl  0xc(%ebp)
  801b15:	50                   	push   %eax
  801b16:	6a 00                	push   $0x0
  801b18:	e8 b2 ff ff ff       	call   801acf <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
}
  801b20:	90                   	nop
  801b21:	c9                   	leave  
  801b22:	c3                   	ret    

00801b23 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b23:	55                   	push   %ebp
  801b24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 01                	push   $0x1
  801b32:	e8 98 ff ff ff       	call   801acf <syscall>
  801b37:	83 c4 18             	add    $0x18,%esp
}
  801b3a:	c9                   	leave  
  801b3b:	c3                   	ret    

00801b3c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b3c:	55                   	push   %ebp
  801b3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	50                   	push   %eax
  801b4b:	6a 05                	push   $0x5
  801b4d:	e8 7d ff ff ff       	call   801acf <syscall>
  801b52:	83 c4 18             	add    $0x18,%esp
}
  801b55:	c9                   	leave  
  801b56:	c3                   	ret    

00801b57 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b57:	55                   	push   %ebp
  801b58:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 02                	push   $0x2
  801b66:	e8 64 ff ff ff       	call   801acf <syscall>
  801b6b:	83 c4 18             	add    $0x18,%esp
}
  801b6e:	c9                   	leave  
  801b6f:	c3                   	ret    

00801b70 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b70:	55                   	push   %ebp
  801b71:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 03                	push   $0x3
  801b7f:	e8 4b ff ff ff       	call   801acf <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
}
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 04                	push   $0x4
  801b98:	e8 32 ff ff ff       	call   801acf <syscall>
  801b9d:	83 c4 18             	add    $0x18,%esp
}
  801ba0:	c9                   	leave  
  801ba1:	c3                   	ret    

00801ba2 <sys_env_exit>:


void sys_env_exit(void)
{
  801ba2:	55                   	push   %ebp
  801ba3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 06                	push   $0x6
  801bb1:	e8 19 ff ff ff       	call   801acf <syscall>
  801bb6:	83 c4 18             	add    $0x18,%esp
}
  801bb9:	90                   	nop
  801bba:	c9                   	leave  
  801bbb:	c3                   	ret    

00801bbc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bbc:	55                   	push   %ebp
  801bbd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bbf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	52                   	push   %edx
  801bcc:	50                   	push   %eax
  801bcd:	6a 07                	push   $0x7
  801bcf:	e8 fb fe ff ff       	call   801acf <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    

00801bd9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
  801bdc:	56                   	push   %esi
  801bdd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bde:	8b 75 18             	mov    0x18(%ebp),%esi
  801be1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801be4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801be7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bea:	8b 45 08             	mov    0x8(%ebp),%eax
  801bed:	56                   	push   %esi
  801bee:	53                   	push   %ebx
  801bef:	51                   	push   %ecx
  801bf0:	52                   	push   %edx
  801bf1:	50                   	push   %eax
  801bf2:	6a 08                	push   $0x8
  801bf4:	e8 d6 fe ff ff       	call   801acf <syscall>
  801bf9:	83 c4 18             	add    $0x18,%esp
}
  801bfc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bff:	5b                   	pop    %ebx
  801c00:	5e                   	pop    %esi
  801c01:	5d                   	pop    %ebp
  801c02:	c3                   	ret    

00801c03 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c03:	55                   	push   %ebp
  801c04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c06:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c09:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	52                   	push   %edx
  801c13:	50                   	push   %eax
  801c14:	6a 09                	push   $0x9
  801c16:	e8 b4 fe ff ff       	call   801acf <syscall>
  801c1b:	83 c4 18             	add    $0x18,%esp
}
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	ff 75 0c             	pushl  0xc(%ebp)
  801c2c:	ff 75 08             	pushl  0x8(%ebp)
  801c2f:	6a 0a                	push   $0xa
  801c31:	e8 99 fe ff ff       	call   801acf <syscall>
  801c36:	83 c4 18             	add    $0x18,%esp
}
  801c39:	c9                   	leave  
  801c3a:	c3                   	ret    

00801c3b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c3b:	55                   	push   %ebp
  801c3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 0b                	push   $0xb
  801c4a:	e8 80 fe ff ff       	call   801acf <syscall>
  801c4f:	83 c4 18             	add    $0x18,%esp
}
  801c52:	c9                   	leave  
  801c53:	c3                   	ret    

00801c54 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c54:	55                   	push   %ebp
  801c55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 0c                	push   $0xc
  801c63:	e8 67 fe ff ff       	call   801acf <syscall>
  801c68:	83 c4 18             	add    $0x18,%esp
}
  801c6b:	c9                   	leave  
  801c6c:	c3                   	ret    

00801c6d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c6d:	55                   	push   %ebp
  801c6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 0d                	push   $0xd
  801c7c:	e8 4e fe ff ff       	call   801acf <syscall>
  801c81:	83 c4 18             	add    $0x18,%esp
}
  801c84:	c9                   	leave  
  801c85:	c3                   	ret    

00801c86 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c86:	55                   	push   %ebp
  801c87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	ff 75 0c             	pushl  0xc(%ebp)
  801c92:	ff 75 08             	pushl  0x8(%ebp)
  801c95:	6a 11                	push   $0x11
  801c97:	e8 33 fe ff ff       	call   801acf <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
	return;
  801c9f:	90                   	nop
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	ff 75 0c             	pushl  0xc(%ebp)
  801cae:	ff 75 08             	pushl  0x8(%ebp)
  801cb1:	6a 12                	push   $0x12
  801cb3:	e8 17 fe ff ff       	call   801acf <syscall>
  801cb8:	83 c4 18             	add    $0x18,%esp
	return ;
  801cbb:	90                   	nop
}
  801cbc:	c9                   	leave  
  801cbd:	c3                   	ret    

00801cbe <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 0e                	push   $0xe
  801ccd:	e8 fd fd ff ff       	call   801acf <syscall>
  801cd2:	83 c4 18             	add    $0x18,%esp
}
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	ff 75 08             	pushl  0x8(%ebp)
  801ce5:	6a 0f                	push   $0xf
  801ce7:	e8 e3 fd ff ff       	call   801acf <syscall>
  801cec:	83 c4 18             	add    $0x18,%esp
}
  801cef:	c9                   	leave  
  801cf0:	c3                   	ret    

00801cf1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cf1:	55                   	push   %ebp
  801cf2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 10                	push   $0x10
  801d00:	e8 ca fd ff ff       	call   801acf <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
}
  801d08:	90                   	nop
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 14                	push   $0x14
  801d1a:	e8 b0 fd ff ff       	call   801acf <syscall>
  801d1f:	83 c4 18             	add    $0x18,%esp
}
  801d22:	90                   	nop
  801d23:	c9                   	leave  
  801d24:	c3                   	ret    

00801d25 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d25:	55                   	push   %ebp
  801d26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 15                	push   $0x15
  801d34:	e8 96 fd ff ff       	call   801acf <syscall>
  801d39:	83 c4 18             	add    $0x18,%esp
}
  801d3c:	90                   	nop
  801d3d:	c9                   	leave  
  801d3e:	c3                   	ret    

00801d3f <sys_cputc>:


void
sys_cputc(const char c)
{
  801d3f:	55                   	push   %ebp
  801d40:	89 e5                	mov    %esp,%ebp
  801d42:	83 ec 04             	sub    $0x4,%esp
  801d45:	8b 45 08             	mov    0x8(%ebp),%eax
  801d48:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d4b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	50                   	push   %eax
  801d58:	6a 16                	push   $0x16
  801d5a:	e8 70 fd ff ff       	call   801acf <syscall>
  801d5f:	83 c4 18             	add    $0x18,%esp
}
  801d62:	90                   	nop
  801d63:	c9                   	leave  
  801d64:	c3                   	ret    

00801d65 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 17                	push   $0x17
  801d74:	e8 56 fd ff ff       	call   801acf <syscall>
  801d79:	83 c4 18             	add    $0x18,%esp
}
  801d7c:	90                   	nop
  801d7d:	c9                   	leave  
  801d7e:	c3                   	ret    

00801d7f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d7f:	55                   	push   %ebp
  801d80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d82:	8b 45 08             	mov    0x8(%ebp),%eax
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	ff 75 0c             	pushl  0xc(%ebp)
  801d8e:	50                   	push   %eax
  801d8f:	6a 18                	push   $0x18
  801d91:	e8 39 fd ff ff       	call   801acf <syscall>
  801d96:	83 c4 18             	add    $0x18,%esp
}
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801da1:	8b 45 08             	mov    0x8(%ebp),%eax
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	52                   	push   %edx
  801dab:	50                   	push   %eax
  801dac:	6a 1b                	push   $0x1b
  801dae:	e8 1c fd ff ff       	call   801acf <syscall>
  801db3:	83 c4 18             	add    $0x18,%esp
}
  801db6:	c9                   	leave  
  801db7:	c3                   	ret    

00801db8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801db8:	55                   	push   %ebp
  801db9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	52                   	push   %edx
  801dc8:	50                   	push   %eax
  801dc9:	6a 19                	push   $0x19
  801dcb:	e8 ff fc ff ff       	call   801acf <syscall>
  801dd0:	83 c4 18             	add    $0x18,%esp
}
  801dd3:	90                   	nop
  801dd4:	c9                   	leave  
  801dd5:	c3                   	ret    

00801dd6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dd6:	55                   	push   %ebp
  801dd7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	52                   	push   %edx
  801de6:	50                   	push   %eax
  801de7:	6a 1a                	push   $0x1a
  801de9:	e8 e1 fc ff ff       	call   801acf <syscall>
  801dee:	83 c4 18             	add    $0x18,%esp
}
  801df1:	90                   	nop
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
  801df7:	83 ec 04             	sub    $0x4,%esp
  801dfa:	8b 45 10             	mov    0x10(%ebp),%eax
  801dfd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e00:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e03:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e07:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0a:	6a 00                	push   $0x0
  801e0c:	51                   	push   %ecx
  801e0d:	52                   	push   %edx
  801e0e:	ff 75 0c             	pushl  0xc(%ebp)
  801e11:	50                   	push   %eax
  801e12:	6a 1c                	push   $0x1c
  801e14:	e8 b6 fc ff ff       	call   801acf <syscall>
  801e19:	83 c4 18             	add    $0x18,%esp
}
  801e1c:	c9                   	leave  
  801e1d:	c3                   	ret    

00801e1e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e1e:	55                   	push   %ebp
  801e1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e21:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e24:	8b 45 08             	mov    0x8(%ebp),%eax
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	52                   	push   %edx
  801e2e:	50                   	push   %eax
  801e2f:	6a 1d                	push   $0x1d
  801e31:	e8 99 fc ff ff       	call   801acf <syscall>
  801e36:	83 c4 18             	add    $0x18,%esp
}
  801e39:	c9                   	leave  
  801e3a:	c3                   	ret    

00801e3b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e3b:	55                   	push   %ebp
  801e3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e3e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e41:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e44:	8b 45 08             	mov    0x8(%ebp),%eax
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	51                   	push   %ecx
  801e4c:	52                   	push   %edx
  801e4d:	50                   	push   %eax
  801e4e:	6a 1e                	push   $0x1e
  801e50:	e8 7a fc ff ff       	call   801acf <syscall>
  801e55:	83 c4 18             	add    $0x18,%esp
}
  801e58:	c9                   	leave  
  801e59:	c3                   	ret    

00801e5a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e5a:	55                   	push   %ebp
  801e5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e60:	8b 45 08             	mov    0x8(%ebp),%eax
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	52                   	push   %edx
  801e6a:	50                   	push   %eax
  801e6b:	6a 1f                	push   $0x1f
  801e6d:	e8 5d fc ff ff       	call   801acf <syscall>
  801e72:	83 c4 18             	add    $0x18,%esp
}
  801e75:	c9                   	leave  
  801e76:	c3                   	ret    

00801e77 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e77:	55                   	push   %ebp
  801e78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 20                	push   $0x20
  801e86:	e8 44 fc ff ff       	call   801acf <syscall>
  801e8b:	83 c4 18             	add    $0x18,%esp
}
  801e8e:	c9                   	leave  
  801e8f:	c3                   	ret    

00801e90 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e90:	55                   	push   %ebp
  801e91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e93:	8b 45 08             	mov    0x8(%ebp),%eax
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	ff 75 10             	pushl  0x10(%ebp)
  801e9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ea0:	50                   	push   %eax
  801ea1:	6a 21                	push   $0x21
  801ea3:	e8 27 fc ff ff       	call   801acf <syscall>
  801ea8:	83 c4 18             	add    $0x18,%esp
}
  801eab:	c9                   	leave  
  801eac:	c3                   	ret    

00801ead <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ead:	55                   	push   %ebp
  801eae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	50                   	push   %eax
  801ebc:	6a 22                	push   $0x22
  801ebe:	e8 0c fc ff ff       	call   801acf <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	90                   	nop
  801ec7:	c9                   	leave  
  801ec8:	c3                   	ret    

00801ec9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ec9:	55                   	push   %ebp
  801eca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	50                   	push   %eax
  801ed8:	6a 23                	push   $0x23
  801eda:	e8 f0 fb ff ff       	call   801acf <syscall>
  801edf:	83 c4 18             	add    $0x18,%esp
}
  801ee2:	90                   	nop
  801ee3:	c9                   	leave  
  801ee4:	c3                   	ret    

00801ee5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ee5:	55                   	push   %ebp
  801ee6:	89 e5                	mov    %esp,%ebp
  801ee8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801eeb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801eee:	8d 50 04             	lea    0x4(%eax),%edx
  801ef1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	52                   	push   %edx
  801efb:	50                   	push   %eax
  801efc:	6a 24                	push   $0x24
  801efe:	e8 cc fb ff ff       	call   801acf <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
	return result;
  801f06:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f0c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f0f:	89 01                	mov    %eax,(%ecx)
  801f11:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f14:	8b 45 08             	mov    0x8(%ebp),%eax
  801f17:	c9                   	leave  
  801f18:	c2 04 00             	ret    $0x4

00801f1b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f1b:	55                   	push   %ebp
  801f1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	ff 75 10             	pushl  0x10(%ebp)
  801f25:	ff 75 0c             	pushl  0xc(%ebp)
  801f28:	ff 75 08             	pushl  0x8(%ebp)
  801f2b:	6a 13                	push   $0x13
  801f2d:	e8 9d fb ff ff       	call   801acf <syscall>
  801f32:	83 c4 18             	add    $0x18,%esp
	return ;
  801f35:	90                   	nop
}
  801f36:	c9                   	leave  
  801f37:	c3                   	ret    

00801f38 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f38:	55                   	push   %ebp
  801f39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 25                	push   $0x25
  801f47:	e8 83 fb ff ff       	call   801acf <syscall>
  801f4c:	83 c4 18             	add    $0x18,%esp
}
  801f4f:	c9                   	leave  
  801f50:	c3                   	ret    

00801f51 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f51:	55                   	push   %ebp
  801f52:	89 e5                	mov    %esp,%ebp
  801f54:	83 ec 04             	sub    $0x4,%esp
  801f57:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f5d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	50                   	push   %eax
  801f6a:	6a 26                	push   $0x26
  801f6c:	e8 5e fb ff ff       	call   801acf <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
	return ;
  801f74:	90                   	nop
}
  801f75:	c9                   	leave  
  801f76:	c3                   	ret    

00801f77 <rsttst>:
void rsttst()
{
  801f77:	55                   	push   %ebp
  801f78:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 28                	push   $0x28
  801f86:	e8 44 fb ff ff       	call   801acf <syscall>
  801f8b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8e:	90                   	nop
}
  801f8f:	c9                   	leave  
  801f90:	c3                   	ret    

00801f91 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f91:	55                   	push   %ebp
  801f92:	89 e5                	mov    %esp,%ebp
  801f94:	83 ec 04             	sub    $0x4,%esp
  801f97:	8b 45 14             	mov    0x14(%ebp),%eax
  801f9a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f9d:	8b 55 18             	mov    0x18(%ebp),%edx
  801fa0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fa4:	52                   	push   %edx
  801fa5:	50                   	push   %eax
  801fa6:	ff 75 10             	pushl  0x10(%ebp)
  801fa9:	ff 75 0c             	pushl  0xc(%ebp)
  801fac:	ff 75 08             	pushl  0x8(%ebp)
  801faf:	6a 27                	push   $0x27
  801fb1:	e8 19 fb ff ff       	call   801acf <syscall>
  801fb6:	83 c4 18             	add    $0x18,%esp
	return ;
  801fb9:	90                   	nop
}
  801fba:	c9                   	leave  
  801fbb:	c3                   	ret    

00801fbc <chktst>:
void chktst(uint32 n)
{
  801fbc:	55                   	push   %ebp
  801fbd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	ff 75 08             	pushl  0x8(%ebp)
  801fca:	6a 29                	push   $0x29
  801fcc:	e8 fe fa ff ff       	call   801acf <syscall>
  801fd1:	83 c4 18             	add    $0x18,%esp
	return ;
  801fd4:	90                   	nop
}
  801fd5:	c9                   	leave  
  801fd6:	c3                   	ret    

00801fd7 <inctst>:

void inctst()
{
  801fd7:	55                   	push   %ebp
  801fd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 2a                	push   $0x2a
  801fe6:	e8 e4 fa ff ff       	call   801acf <syscall>
  801feb:	83 c4 18             	add    $0x18,%esp
	return ;
  801fee:	90                   	nop
}
  801fef:	c9                   	leave  
  801ff0:	c3                   	ret    

00801ff1 <gettst>:
uint32 gettst()
{
  801ff1:	55                   	push   %ebp
  801ff2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 2b                	push   $0x2b
  802000:	e8 ca fa ff ff       	call   801acf <syscall>
  802005:	83 c4 18             	add    $0x18,%esp
}
  802008:	c9                   	leave  
  802009:	c3                   	ret    

0080200a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80200a:	55                   	push   %ebp
  80200b:	89 e5                	mov    %esp,%ebp
  80200d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 2c                	push   $0x2c
  80201c:	e8 ae fa ff ff       	call   801acf <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
  802024:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802027:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80202b:	75 07                	jne    802034 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80202d:	b8 01 00 00 00       	mov    $0x1,%eax
  802032:	eb 05                	jmp    802039 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802034:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802039:	c9                   	leave  
  80203a:	c3                   	ret    

0080203b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80203b:	55                   	push   %ebp
  80203c:	89 e5                	mov    %esp,%ebp
  80203e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 2c                	push   $0x2c
  80204d:	e8 7d fa ff ff       	call   801acf <syscall>
  802052:	83 c4 18             	add    $0x18,%esp
  802055:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802058:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80205c:	75 07                	jne    802065 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80205e:	b8 01 00 00 00       	mov    $0x1,%eax
  802063:	eb 05                	jmp    80206a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802065:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80206a:	c9                   	leave  
  80206b:	c3                   	ret    

0080206c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80206c:	55                   	push   %ebp
  80206d:	89 e5                	mov    %esp,%ebp
  80206f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 2c                	push   $0x2c
  80207e:	e8 4c fa ff ff       	call   801acf <syscall>
  802083:	83 c4 18             	add    $0x18,%esp
  802086:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802089:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80208d:	75 07                	jne    802096 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80208f:	b8 01 00 00 00       	mov    $0x1,%eax
  802094:	eb 05                	jmp    80209b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802096:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80209b:	c9                   	leave  
  80209c:	c3                   	ret    

0080209d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80209d:	55                   	push   %ebp
  80209e:	89 e5                	mov    %esp,%ebp
  8020a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 2c                	push   $0x2c
  8020af:	e8 1b fa ff ff       	call   801acf <syscall>
  8020b4:	83 c4 18             	add    $0x18,%esp
  8020b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020ba:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020be:	75 07                	jne    8020c7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8020c5:	eb 05                	jmp    8020cc <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020cc:	c9                   	leave  
  8020cd:	c3                   	ret    

008020ce <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020ce:	55                   	push   %ebp
  8020cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	ff 75 08             	pushl  0x8(%ebp)
  8020dc:	6a 2d                	push   $0x2d
  8020de:	e8 ec f9 ff ff       	call   801acf <syscall>
  8020e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e6:	90                   	nop
}
  8020e7:	c9                   	leave  
  8020e8:	c3                   	ret    

008020e9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8020e9:	55                   	push   %ebp
  8020ea:	89 e5                	mov    %esp,%ebp
  8020ec:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8020ef:	8d 45 10             	lea    0x10(%ebp),%eax
  8020f2:	83 c0 04             	add    $0x4,%eax
  8020f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8020f8:	a1 40 30 98 00       	mov    0x983040,%eax
  8020fd:	85 c0                	test   %eax,%eax
  8020ff:	74 16                	je     802117 <_panic+0x2e>
		cprintf("%s: ", argv0);
  802101:	a1 40 30 98 00       	mov    0x983040,%eax
  802106:	83 ec 08             	sub    $0x8,%esp
  802109:	50                   	push   %eax
  80210a:	68 dc 29 80 00       	push   $0x8029dc
  80210f:	e8 a1 e9 ff ff       	call   800ab5 <cprintf>
  802114:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  802117:	a1 00 30 80 00       	mov    0x803000,%eax
  80211c:	ff 75 0c             	pushl  0xc(%ebp)
  80211f:	ff 75 08             	pushl  0x8(%ebp)
  802122:	50                   	push   %eax
  802123:	68 e1 29 80 00       	push   $0x8029e1
  802128:	e8 88 e9 ff ff       	call   800ab5 <cprintf>
  80212d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  802130:	8b 45 10             	mov    0x10(%ebp),%eax
  802133:	83 ec 08             	sub    $0x8,%esp
  802136:	ff 75 f4             	pushl  -0xc(%ebp)
  802139:	50                   	push   %eax
  80213a:	e8 0b e9 ff ff       	call   800a4a <vcprintf>
  80213f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  802142:	83 ec 08             	sub    $0x8,%esp
  802145:	6a 00                	push   $0x0
  802147:	68 fd 29 80 00       	push   $0x8029fd
  80214c:	e8 f9 e8 ff ff       	call   800a4a <vcprintf>
  802151:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  802154:	e8 7a e8 ff ff       	call   8009d3 <exit>

	// should not return here
	while (1) ;
  802159:	eb fe                	jmp    802159 <_panic+0x70>

0080215b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80215b:	55                   	push   %ebp
  80215c:	89 e5                	mov    %esp,%ebp
  80215e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  802161:	a1 20 30 80 00       	mov    0x803020,%eax
  802166:	8b 50 74             	mov    0x74(%eax),%edx
  802169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80216c:	39 c2                	cmp    %eax,%edx
  80216e:	74 14                	je     802184 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  802170:	83 ec 04             	sub    $0x4,%esp
  802173:	68 00 2a 80 00       	push   $0x802a00
  802178:	6a 26                	push   $0x26
  80217a:	68 4c 2a 80 00       	push   $0x802a4c
  80217f:	e8 65 ff ff ff       	call   8020e9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  802184:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80218b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802192:	e9 c2 00 00 00       	jmp    802259 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  802197:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80219a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8021a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a4:	01 d0                	add    %edx,%eax
  8021a6:	8b 00                	mov    (%eax),%eax
  8021a8:	85 c0                	test   %eax,%eax
  8021aa:	75 08                	jne    8021b4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8021ac:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8021af:	e9 a2 00 00 00       	jmp    802256 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8021b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8021bb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8021c2:	eb 69                	jmp    80222d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8021c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8021c9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8021cf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8021d2:	89 d0                	mov    %edx,%eax
  8021d4:	01 c0                	add    %eax,%eax
  8021d6:	01 d0                	add    %edx,%eax
  8021d8:	c1 e0 02             	shl    $0x2,%eax
  8021db:	01 c8                	add    %ecx,%eax
  8021dd:	8a 40 04             	mov    0x4(%eax),%al
  8021e0:	84 c0                	test   %al,%al
  8021e2:	75 46                	jne    80222a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8021e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8021e9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8021ef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8021f2:	89 d0                	mov    %edx,%eax
  8021f4:	01 c0                	add    %eax,%eax
  8021f6:	01 d0                	add    %edx,%eax
  8021f8:	c1 e0 02             	shl    $0x2,%eax
  8021fb:	01 c8                	add    %ecx,%eax
  8021fd:	8b 00                	mov    (%eax),%eax
  8021ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
  802202:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802205:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80220a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80220c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80220f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  802216:	8b 45 08             	mov    0x8(%ebp),%eax
  802219:	01 c8                	add    %ecx,%eax
  80221b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80221d:	39 c2                	cmp    %eax,%edx
  80221f:	75 09                	jne    80222a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  802221:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  802228:	eb 12                	jmp    80223c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80222a:	ff 45 e8             	incl   -0x18(%ebp)
  80222d:	a1 20 30 80 00       	mov    0x803020,%eax
  802232:	8b 50 74             	mov    0x74(%eax),%edx
  802235:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802238:	39 c2                	cmp    %eax,%edx
  80223a:	77 88                	ja     8021c4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80223c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  802240:	75 14                	jne    802256 <CheckWSWithoutLastIndex+0xfb>
			panic(
  802242:	83 ec 04             	sub    $0x4,%esp
  802245:	68 58 2a 80 00       	push   $0x802a58
  80224a:	6a 3a                	push   $0x3a
  80224c:	68 4c 2a 80 00       	push   $0x802a4c
  802251:	e8 93 fe ff ff       	call   8020e9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  802256:	ff 45 f0             	incl   -0x10(%ebp)
  802259:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80225c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80225f:	0f 8c 32 ff ff ff    	jl     802197 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  802265:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80226c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802273:	eb 26                	jmp    80229b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802275:	a1 20 30 80 00       	mov    0x803020,%eax
  80227a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  802280:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802283:	89 d0                	mov    %edx,%eax
  802285:	01 c0                	add    %eax,%eax
  802287:	01 d0                	add    %edx,%eax
  802289:	c1 e0 02             	shl    $0x2,%eax
  80228c:	01 c8                	add    %ecx,%eax
  80228e:	8a 40 04             	mov    0x4(%eax),%al
  802291:	3c 01                	cmp    $0x1,%al
  802293:	75 03                	jne    802298 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  802295:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802298:	ff 45 e0             	incl   -0x20(%ebp)
  80229b:	a1 20 30 80 00       	mov    0x803020,%eax
  8022a0:	8b 50 74             	mov    0x74(%eax),%edx
  8022a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8022a6:	39 c2                	cmp    %eax,%edx
  8022a8:	77 cb                	ja     802275 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8022aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022ad:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8022b0:	74 14                	je     8022c6 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8022b2:	83 ec 04             	sub    $0x4,%esp
  8022b5:	68 ac 2a 80 00       	push   $0x802aac
  8022ba:	6a 44                	push   $0x44
  8022bc:	68 4c 2a 80 00       	push   $0x802a4c
  8022c1:	e8 23 fe ff ff       	call   8020e9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8022c6:	90                   	nop
  8022c7:	c9                   	leave  
  8022c8:	c3                   	ret    
  8022c9:	66 90                	xchg   %ax,%ax
  8022cb:	90                   	nop

008022cc <__udivdi3>:
  8022cc:	55                   	push   %ebp
  8022cd:	57                   	push   %edi
  8022ce:	56                   	push   %esi
  8022cf:	53                   	push   %ebx
  8022d0:	83 ec 1c             	sub    $0x1c,%esp
  8022d3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022d7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022df:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022e3:	89 ca                	mov    %ecx,%edx
  8022e5:	89 f8                	mov    %edi,%eax
  8022e7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022eb:	85 f6                	test   %esi,%esi
  8022ed:	75 2d                	jne    80231c <__udivdi3+0x50>
  8022ef:	39 cf                	cmp    %ecx,%edi
  8022f1:	77 65                	ja     802358 <__udivdi3+0x8c>
  8022f3:	89 fd                	mov    %edi,%ebp
  8022f5:	85 ff                	test   %edi,%edi
  8022f7:	75 0b                	jne    802304 <__udivdi3+0x38>
  8022f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8022fe:	31 d2                	xor    %edx,%edx
  802300:	f7 f7                	div    %edi
  802302:	89 c5                	mov    %eax,%ebp
  802304:	31 d2                	xor    %edx,%edx
  802306:	89 c8                	mov    %ecx,%eax
  802308:	f7 f5                	div    %ebp
  80230a:	89 c1                	mov    %eax,%ecx
  80230c:	89 d8                	mov    %ebx,%eax
  80230e:	f7 f5                	div    %ebp
  802310:	89 cf                	mov    %ecx,%edi
  802312:	89 fa                	mov    %edi,%edx
  802314:	83 c4 1c             	add    $0x1c,%esp
  802317:	5b                   	pop    %ebx
  802318:	5e                   	pop    %esi
  802319:	5f                   	pop    %edi
  80231a:	5d                   	pop    %ebp
  80231b:	c3                   	ret    
  80231c:	39 ce                	cmp    %ecx,%esi
  80231e:	77 28                	ja     802348 <__udivdi3+0x7c>
  802320:	0f bd fe             	bsr    %esi,%edi
  802323:	83 f7 1f             	xor    $0x1f,%edi
  802326:	75 40                	jne    802368 <__udivdi3+0x9c>
  802328:	39 ce                	cmp    %ecx,%esi
  80232a:	72 0a                	jb     802336 <__udivdi3+0x6a>
  80232c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802330:	0f 87 9e 00 00 00    	ja     8023d4 <__udivdi3+0x108>
  802336:	b8 01 00 00 00       	mov    $0x1,%eax
  80233b:	89 fa                	mov    %edi,%edx
  80233d:	83 c4 1c             	add    $0x1c,%esp
  802340:	5b                   	pop    %ebx
  802341:	5e                   	pop    %esi
  802342:	5f                   	pop    %edi
  802343:	5d                   	pop    %ebp
  802344:	c3                   	ret    
  802345:	8d 76 00             	lea    0x0(%esi),%esi
  802348:	31 ff                	xor    %edi,%edi
  80234a:	31 c0                	xor    %eax,%eax
  80234c:	89 fa                	mov    %edi,%edx
  80234e:	83 c4 1c             	add    $0x1c,%esp
  802351:	5b                   	pop    %ebx
  802352:	5e                   	pop    %esi
  802353:	5f                   	pop    %edi
  802354:	5d                   	pop    %ebp
  802355:	c3                   	ret    
  802356:	66 90                	xchg   %ax,%ax
  802358:	89 d8                	mov    %ebx,%eax
  80235a:	f7 f7                	div    %edi
  80235c:	31 ff                	xor    %edi,%edi
  80235e:	89 fa                	mov    %edi,%edx
  802360:	83 c4 1c             	add    $0x1c,%esp
  802363:	5b                   	pop    %ebx
  802364:	5e                   	pop    %esi
  802365:	5f                   	pop    %edi
  802366:	5d                   	pop    %ebp
  802367:	c3                   	ret    
  802368:	bd 20 00 00 00       	mov    $0x20,%ebp
  80236d:	89 eb                	mov    %ebp,%ebx
  80236f:	29 fb                	sub    %edi,%ebx
  802371:	89 f9                	mov    %edi,%ecx
  802373:	d3 e6                	shl    %cl,%esi
  802375:	89 c5                	mov    %eax,%ebp
  802377:	88 d9                	mov    %bl,%cl
  802379:	d3 ed                	shr    %cl,%ebp
  80237b:	89 e9                	mov    %ebp,%ecx
  80237d:	09 f1                	or     %esi,%ecx
  80237f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802383:	89 f9                	mov    %edi,%ecx
  802385:	d3 e0                	shl    %cl,%eax
  802387:	89 c5                	mov    %eax,%ebp
  802389:	89 d6                	mov    %edx,%esi
  80238b:	88 d9                	mov    %bl,%cl
  80238d:	d3 ee                	shr    %cl,%esi
  80238f:	89 f9                	mov    %edi,%ecx
  802391:	d3 e2                	shl    %cl,%edx
  802393:	8b 44 24 08          	mov    0x8(%esp),%eax
  802397:	88 d9                	mov    %bl,%cl
  802399:	d3 e8                	shr    %cl,%eax
  80239b:	09 c2                	or     %eax,%edx
  80239d:	89 d0                	mov    %edx,%eax
  80239f:	89 f2                	mov    %esi,%edx
  8023a1:	f7 74 24 0c          	divl   0xc(%esp)
  8023a5:	89 d6                	mov    %edx,%esi
  8023a7:	89 c3                	mov    %eax,%ebx
  8023a9:	f7 e5                	mul    %ebp
  8023ab:	39 d6                	cmp    %edx,%esi
  8023ad:	72 19                	jb     8023c8 <__udivdi3+0xfc>
  8023af:	74 0b                	je     8023bc <__udivdi3+0xf0>
  8023b1:	89 d8                	mov    %ebx,%eax
  8023b3:	31 ff                	xor    %edi,%edi
  8023b5:	e9 58 ff ff ff       	jmp    802312 <__udivdi3+0x46>
  8023ba:	66 90                	xchg   %ax,%ax
  8023bc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023c0:	89 f9                	mov    %edi,%ecx
  8023c2:	d3 e2                	shl    %cl,%edx
  8023c4:	39 c2                	cmp    %eax,%edx
  8023c6:	73 e9                	jae    8023b1 <__udivdi3+0xe5>
  8023c8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023cb:	31 ff                	xor    %edi,%edi
  8023cd:	e9 40 ff ff ff       	jmp    802312 <__udivdi3+0x46>
  8023d2:	66 90                	xchg   %ax,%ax
  8023d4:	31 c0                	xor    %eax,%eax
  8023d6:	e9 37 ff ff ff       	jmp    802312 <__udivdi3+0x46>
  8023db:	90                   	nop

008023dc <__umoddi3>:
  8023dc:	55                   	push   %ebp
  8023dd:	57                   	push   %edi
  8023de:	56                   	push   %esi
  8023df:	53                   	push   %ebx
  8023e0:	83 ec 1c             	sub    $0x1c,%esp
  8023e3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023e7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023ef:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023f7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023fb:	89 f3                	mov    %esi,%ebx
  8023fd:	89 fa                	mov    %edi,%edx
  8023ff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802403:	89 34 24             	mov    %esi,(%esp)
  802406:	85 c0                	test   %eax,%eax
  802408:	75 1a                	jne    802424 <__umoddi3+0x48>
  80240a:	39 f7                	cmp    %esi,%edi
  80240c:	0f 86 a2 00 00 00    	jbe    8024b4 <__umoddi3+0xd8>
  802412:	89 c8                	mov    %ecx,%eax
  802414:	89 f2                	mov    %esi,%edx
  802416:	f7 f7                	div    %edi
  802418:	89 d0                	mov    %edx,%eax
  80241a:	31 d2                	xor    %edx,%edx
  80241c:	83 c4 1c             	add    $0x1c,%esp
  80241f:	5b                   	pop    %ebx
  802420:	5e                   	pop    %esi
  802421:	5f                   	pop    %edi
  802422:	5d                   	pop    %ebp
  802423:	c3                   	ret    
  802424:	39 f0                	cmp    %esi,%eax
  802426:	0f 87 ac 00 00 00    	ja     8024d8 <__umoddi3+0xfc>
  80242c:	0f bd e8             	bsr    %eax,%ebp
  80242f:	83 f5 1f             	xor    $0x1f,%ebp
  802432:	0f 84 ac 00 00 00    	je     8024e4 <__umoddi3+0x108>
  802438:	bf 20 00 00 00       	mov    $0x20,%edi
  80243d:	29 ef                	sub    %ebp,%edi
  80243f:	89 fe                	mov    %edi,%esi
  802441:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802445:	89 e9                	mov    %ebp,%ecx
  802447:	d3 e0                	shl    %cl,%eax
  802449:	89 d7                	mov    %edx,%edi
  80244b:	89 f1                	mov    %esi,%ecx
  80244d:	d3 ef                	shr    %cl,%edi
  80244f:	09 c7                	or     %eax,%edi
  802451:	89 e9                	mov    %ebp,%ecx
  802453:	d3 e2                	shl    %cl,%edx
  802455:	89 14 24             	mov    %edx,(%esp)
  802458:	89 d8                	mov    %ebx,%eax
  80245a:	d3 e0                	shl    %cl,%eax
  80245c:	89 c2                	mov    %eax,%edx
  80245e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802462:	d3 e0                	shl    %cl,%eax
  802464:	89 44 24 04          	mov    %eax,0x4(%esp)
  802468:	8b 44 24 08          	mov    0x8(%esp),%eax
  80246c:	89 f1                	mov    %esi,%ecx
  80246e:	d3 e8                	shr    %cl,%eax
  802470:	09 d0                	or     %edx,%eax
  802472:	d3 eb                	shr    %cl,%ebx
  802474:	89 da                	mov    %ebx,%edx
  802476:	f7 f7                	div    %edi
  802478:	89 d3                	mov    %edx,%ebx
  80247a:	f7 24 24             	mull   (%esp)
  80247d:	89 c6                	mov    %eax,%esi
  80247f:	89 d1                	mov    %edx,%ecx
  802481:	39 d3                	cmp    %edx,%ebx
  802483:	0f 82 87 00 00 00    	jb     802510 <__umoddi3+0x134>
  802489:	0f 84 91 00 00 00    	je     802520 <__umoddi3+0x144>
  80248f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802493:	29 f2                	sub    %esi,%edx
  802495:	19 cb                	sbb    %ecx,%ebx
  802497:	89 d8                	mov    %ebx,%eax
  802499:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80249d:	d3 e0                	shl    %cl,%eax
  80249f:	89 e9                	mov    %ebp,%ecx
  8024a1:	d3 ea                	shr    %cl,%edx
  8024a3:	09 d0                	or     %edx,%eax
  8024a5:	89 e9                	mov    %ebp,%ecx
  8024a7:	d3 eb                	shr    %cl,%ebx
  8024a9:	89 da                	mov    %ebx,%edx
  8024ab:	83 c4 1c             	add    $0x1c,%esp
  8024ae:	5b                   	pop    %ebx
  8024af:	5e                   	pop    %esi
  8024b0:	5f                   	pop    %edi
  8024b1:	5d                   	pop    %ebp
  8024b2:	c3                   	ret    
  8024b3:	90                   	nop
  8024b4:	89 fd                	mov    %edi,%ebp
  8024b6:	85 ff                	test   %edi,%edi
  8024b8:	75 0b                	jne    8024c5 <__umoddi3+0xe9>
  8024ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8024bf:	31 d2                	xor    %edx,%edx
  8024c1:	f7 f7                	div    %edi
  8024c3:	89 c5                	mov    %eax,%ebp
  8024c5:	89 f0                	mov    %esi,%eax
  8024c7:	31 d2                	xor    %edx,%edx
  8024c9:	f7 f5                	div    %ebp
  8024cb:	89 c8                	mov    %ecx,%eax
  8024cd:	f7 f5                	div    %ebp
  8024cf:	89 d0                	mov    %edx,%eax
  8024d1:	e9 44 ff ff ff       	jmp    80241a <__umoddi3+0x3e>
  8024d6:	66 90                	xchg   %ax,%ax
  8024d8:	89 c8                	mov    %ecx,%eax
  8024da:	89 f2                	mov    %esi,%edx
  8024dc:	83 c4 1c             	add    $0x1c,%esp
  8024df:	5b                   	pop    %ebx
  8024e0:	5e                   	pop    %esi
  8024e1:	5f                   	pop    %edi
  8024e2:	5d                   	pop    %ebp
  8024e3:	c3                   	ret    
  8024e4:	3b 04 24             	cmp    (%esp),%eax
  8024e7:	72 06                	jb     8024ef <__umoddi3+0x113>
  8024e9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024ed:	77 0f                	ja     8024fe <__umoddi3+0x122>
  8024ef:	89 f2                	mov    %esi,%edx
  8024f1:	29 f9                	sub    %edi,%ecx
  8024f3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024f7:	89 14 24             	mov    %edx,(%esp)
  8024fa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024fe:	8b 44 24 04          	mov    0x4(%esp),%eax
  802502:	8b 14 24             	mov    (%esp),%edx
  802505:	83 c4 1c             	add    $0x1c,%esp
  802508:	5b                   	pop    %ebx
  802509:	5e                   	pop    %esi
  80250a:	5f                   	pop    %edi
  80250b:	5d                   	pop    %ebp
  80250c:	c3                   	ret    
  80250d:	8d 76 00             	lea    0x0(%esi),%esi
  802510:	2b 04 24             	sub    (%esp),%eax
  802513:	19 fa                	sbb    %edi,%edx
  802515:	89 d1                	mov    %edx,%ecx
  802517:	89 c6                	mov    %eax,%esi
  802519:	e9 71 ff ff ff       	jmp    80248f <__umoddi3+0xb3>
  80251e:	66 90                	xchg   %ax,%ax
  802520:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802524:	72 ea                	jb     802510 <__umoddi3+0x134>
  802526:	89 d9                	mov    %ebx,%ecx
  802528:	e9 62 ff ff ff       	jmp    80248f <__umoddi3+0xb3>
