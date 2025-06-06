
obj/user/tst_envfree2:     file format elf32-i386


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
  800031:	e8 1c 01 00 00       	call   800152 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing scenario 2: using dynamic allocation and free
	// Testing removing the allocated pages (static & dynamic) in mem, WS, mapped page tables, env's directory and env's page file

	int freeFrames_before = sys_calculate_free_frames() ;
  80003e:	e8 bb 13 00 00       	call   8013fe <sys_calculate_free_frames>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800046:	e8 36 14 00 00       	call   801481 <sys_pf_calculate_allocated_pages>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f4             	pushl  -0xc(%ebp)
  800054:	68 e0 1b 80 00       	push   $0x801be0
  800059:	e8 aa 04 00 00       	call   800508 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	/*[4] CREATE AND RUN ProcessA & ProcessB*/
	//Create 3 processes
	int32 envIdProcessA = sys_create_env("ef_ms1", 10, 50);
  800061:	83 ec 04             	sub    $0x4,%esp
  800064:	6a 32                	push   $0x32
  800066:	6a 0a                	push   $0xa
  800068:	68 13 1c 80 00       	push   $0x801c13
  80006d:	e8 e1 15 00 00       	call   801653 <sys_create_env>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int32 envIdProcessB = sys_create_env("ef_ms2", 7, 50);
  800078:	83 ec 04             	sub    $0x4,%esp
  80007b:	6a 32                	push   $0x32
  80007d:	6a 07                	push   $0x7
  80007f:	68 1a 1c 80 00       	push   $0x801c1a
  800084:	e8 ca 15 00 00       	call   801653 <sys_create_env>
  800089:	83 c4 10             	add    $0x10,%esp
  80008c:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Run 3 processes
	sys_run_env(envIdProcessA);
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	ff 75 ec             	pushl  -0x14(%ebp)
  800095:	e8 d6 15 00 00       	call   801670 <sys_run_env>
  80009a:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  80009d:	83 ec 0c             	sub    $0xc,%esp
  8000a0:	ff 75 e8             	pushl  -0x18(%ebp)
  8000a3:	e8 c8 15 00 00       	call   801670 <sys_run_env>
  8000a8:	83 c4 10             	add    $0x10,%esp

	env_sleep(30000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 30 75 00 00       	push   $0x7530
  8000b3:	e8 f4 17 00 00       	call   8018ac <env_sleep>
  8000b8:	83 c4 10             	add    $0x10,%esp
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000bb:	e8 3e 13 00 00       	call   8013fe <sys_calculate_free_frames>
  8000c0:	83 ec 08             	sub    $0x8,%esp
  8000c3:	50                   	push   %eax
  8000c4:	68 24 1c 80 00       	push   $0x801c24
  8000c9:	e8 3a 04 00 00       	call   800508 <cprintf>
  8000ce:	83 c4 10             	add    $0x10,%esp

	//Kill the 3 processes
	sys_free_env(envIdProcessA);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d7:	e8 b0 15 00 00       	call   80168c <sys_free_env>
  8000dc:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 e8             	pushl  -0x18(%ebp)
  8000e5:	e8 a2 15 00 00       	call   80168c <sys_free_env>
  8000ea:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  8000ed:	e8 0c 13 00 00       	call   8013fe <sys_calculate_free_frames>
  8000f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  8000f5:	e8 87 13 00 00       	call   801481 <sys_pf_calculate_allocated_pages>
  8000fa:	89 45 e0             	mov    %eax,-0x20(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  8000fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800100:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800103:	74 27                	je     80012c <_main+0xf4>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n",
  800105:	83 ec 08             	sub    $0x8,%esp
  800108:	ff 75 e4             	pushl  -0x1c(%ebp)
  80010b:	68 58 1c 80 00       	push   $0x801c58
  800110:	e8 f3 03 00 00       	call   800508 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
				freeFrames_after);
		panic("env_free() does not work correctly... check it again.");
  800118:	83 ec 04             	sub    $0x4,%esp
  80011b:	68 a8 1c 80 00       	push   $0x801ca8
  800120:	6a 24                	push   $0x24
  800122:	68 de 1c 80 00       	push   $0x801cde
  800127:	e8 28 01 00 00       	call   800254 <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80012c:	83 ec 08             	sub    $0x8,%esp
  80012f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800132:	68 f4 1c 80 00       	push   $0x801cf4
  800137:	e8 cc 03 00 00       	call   800508 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 2 for envfree completed successfully.\n");
  80013f:	83 ec 0c             	sub    $0xc,%esp
  800142:	68 54 1d 80 00       	push   $0x801d54
  800147:	e8 bc 03 00 00       	call   800508 <cprintf>
  80014c:	83 c4 10             	add    $0x10,%esp
	return;
  80014f:	90                   	nop
}
  800150:	c9                   	leave  
  800151:	c3                   	ret    

00800152 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800152:	55                   	push   %ebp
  800153:	89 e5                	mov    %esp,%ebp
  800155:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800158:	e8 d6 11 00 00       	call   801333 <sys_getenvindex>
  80015d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800160:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800163:	89 d0                	mov    %edx,%eax
  800165:	01 c0                	add    %eax,%eax
  800167:	01 d0                	add    %edx,%eax
  800169:	c1 e0 02             	shl    $0x2,%eax
  80016c:	01 d0                	add    %edx,%eax
  80016e:	c1 e0 06             	shl    $0x6,%eax
  800171:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800176:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80017b:	a1 04 30 80 00       	mov    0x803004,%eax
  800180:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800186:	84 c0                	test   %al,%al
  800188:	74 0f                	je     800199 <libmain+0x47>
		binaryname = myEnv->prog_name;
  80018a:	a1 04 30 80 00       	mov    0x803004,%eax
  80018f:	05 f4 02 00 00       	add    $0x2f4,%eax
  800194:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800199:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80019d:	7e 0a                	jle    8001a9 <libmain+0x57>
		binaryname = argv[0];
  80019f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001a2:	8b 00                	mov    (%eax),%eax
  8001a4:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001a9:	83 ec 08             	sub    $0x8,%esp
  8001ac:	ff 75 0c             	pushl  0xc(%ebp)
  8001af:	ff 75 08             	pushl  0x8(%ebp)
  8001b2:	e8 81 fe ff ff       	call   800038 <_main>
  8001b7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001ba:	e8 0f 13 00 00       	call   8014ce <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001bf:	83 ec 0c             	sub    $0xc,%esp
  8001c2:	68 b8 1d 80 00       	push   $0x801db8
  8001c7:	e8 3c 03 00 00       	call   800508 <cprintf>
  8001cc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001cf:	a1 04 30 80 00       	mov    0x803004,%eax
  8001d4:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001da:	a1 04 30 80 00       	mov    0x803004,%eax
  8001df:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001e5:	83 ec 04             	sub    $0x4,%esp
  8001e8:	52                   	push   %edx
  8001e9:	50                   	push   %eax
  8001ea:	68 e0 1d 80 00       	push   $0x801de0
  8001ef:	e8 14 03 00 00       	call   800508 <cprintf>
  8001f4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001f7:	a1 04 30 80 00       	mov    0x803004,%eax
  8001fc:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800202:	83 ec 08             	sub    $0x8,%esp
  800205:	50                   	push   %eax
  800206:	68 05 1e 80 00       	push   $0x801e05
  80020b:	e8 f8 02 00 00       	call   800508 <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 b8 1d 80 00       	push   $0x801db8
  80021b:	e8 e8 02 00 00       	call   800508 <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800223:	e8 c0 12 00 00       	call   8014e8 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800228:	e8 19 00 00 00       	call   800246 <exit>
}
  80022d:	90                   	nop
  80022e:	c9                   	leave  
  80022f:	c3                   	ret    

00800230 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800230:	55                   	push   %ebp
  800231:	89 e5                	mov    %esp,%ebp
  800233:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800236:	83 ec 0c             	sub    $0xc,%esp
  800239:	6a 00                	push   $0x0
  80023b:	e8 bf 10 00 00       	call   8012ff <sys_env_destroy>
  800240:	83 c4 10             	add    $0x10,%esp
}
  800243:	90                   	nop
  800244:	c9                   	leave  
  800245:	c3                   	ret    

00800246 <exit>:

void
exit(void)
{
  800246:	55                   	push   %ebp
  800247:	89 e5                	mov    %esp,%ebp
  800249:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80024c:	e8 14 11 00 00       	call   801365 <sys_env_exit>
}
  800251:	90                   	nop
  800252:	c9                   	leave  
  800253:	c3                   	ret    

00800254 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800254:	55                   	push   %ebp
  800255:	89 e5                	mov    %esp,%ebp
  800257:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80025a:	8d 45 10             	lea    0x10(%ebp),%eax
  80025d:	83 c0 04             	add    $0x4,%eax
  800260:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800263:	a1 14 30 80 00       	mov    0x803014,%eax
  800268:	85 c0                	test   %eax,%eax
  80026a:	74 16                	je     800282 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80026c:	a1 14 30 80 00       	mov    0x803014,%eax
  800271:	83 ec 08             	sub    $0x8,%esp
  800274:	50                   	push   %eax
  800275:	68 1c 1e 80 00       	push   $0x801e1c
  80027a:	e8 89 02 00 00       	call   800508 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800282:	a1 00 30 80 00       	mov    0x803000,%eax
  800287:	ff 75 0c             	pushl  0xc(%ebp)
  80028a:	ff 75 08             	pushl  0x8(%ebp)
  80028d:	50                   	push   %eax
  80028e:	68 21 1e 80 00       	push   $0x801e21
  800293:	e8 70 02 00 00       	call   800508 <cprintf>
  800298:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80029b:	8b 45 10             	mov    0x10(%ebp),%eax
  80029e:	83 ec 08             	sub    $0x8,%esp
  8002a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8002a4:	50                   	push   %eax
  8002a5:	e8 f3 01 00 00       	call   80049d <vcprintf>
  8002aa:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002ad:	83 ec 08             	sub    $0x8,%esp
  8002b0:	6a 00                	push   $0x0
  8002b2:	68 3d 1e 80 00       	push   $0x801e3d
  8002b7:	e8 e1 01 00 00       	call   80049d <vcprintf>
  8002bc:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002bf:	e8 82 ff ff ff       	call   800246 <exit>

	// should not return here
	while (1) ;
  8002c4:	eb fe                	jmp    8002c4 <_panic+0x70>

008002c6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002c6:	55                   	push   %ebp
  8002c7:	89 e5                	mov    %esp,%ebp
  8002c9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002cc:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d1:	8b 50 74             	mov    0x74(%eax),%edx
  8002d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d7:	39 c2                	cmp    %eax,%edx
  8002d9:	74 14                	je     8002ef <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 40 1e 80 00       	push   $0x801e40
  8002e3:	6a 26                	push   $0x26
  8002e5:	68 8c 1e 80 00       	push   $0x801e8c
  8002ea:	e8 65 ff ff ff       	call   800254 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002fd:	e9 c2 00 00 00       	jmp    8003c4 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800302:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800305:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030c:	8b 45 08             	mov    0x8(%ebp),%eax
  80030f:	01 d0                	add    %edx,%eax
  800311:	8b 00                	mov    (%eax),%eax
  800313:	85 c0                	test   %eax,%eax
  800315:	75 08                	jne    80031f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800317:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80031a:	e9 a2 00 00 00       	jmp    8003c1 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80031f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800326:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80032d:	eb 69                	jmp    800398 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80032f:	a1 04 30 80 00       	mov    0x803004,%eax
  800334:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80033a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80033d:	89 d0                	mov    %edx,%eax
  80033f:	01 c0                	add    %eax,%eax
  800341:	01 d0                	add    %edx,%eax
  800343:	c1 e0 02             	shl    $0x2,%eax
  800346:	01 c8                	add    %ecx,%eax
  800348:	8a 40 04             	mov    0x4(%eax),%al
  80034b:	84 c0                	test   %al,%al
  80034d:	75 46                	jne    800395 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80034f:	a1 04 30 80 00       	mov    0x803004,%eax
  800354:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80035a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035d:	89 d0                	mov    %edx,%eax
  80035f:	01 c0                	add    %eax,%eax
  800361:	01 d0                	add    %edx,%eax
  800363:	c1 e0 02             	shl    $0x2,%eax
  800366:	01 c8                	add    %ecx,%eax
  800368:	8b 00                	mov    (%eax),%eax
  80036a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80036d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800370:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800375:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800377:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800381:	8b 45 08             	mov    0x8(%ebp),%eax
  800384:	01 c8                	add    %ecx,%eax
  800386:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800388:	39 c2                	cmp    %eax,%edx
  80038a:	75 09                	jne    800395 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80038c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800393:	eb 12                	jmp    8003a7 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800395:	ff 45 e8             	incl   -0x18(%ebp)
  800398:	a1 04 30 80 00       	mov    0x803004,%eax
  80039d:	8b 50 74             	mov    0x74(%eax),%edx
  8003a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a3:	39 c2                	cmp    %eax,%edx
  8003a5:	77 88                	ja     80032f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003a7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003ab:	75 14                	jne    8003c1 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8003ad:	83 ec 04             	sub    $0x4,%esp
  8003b0:	68 98 1e 80 00       	push   $0x801e98
  8003b5:	6a 3a                	push   $0x3a
  8003b7:	68 8c 1e 80 00       	push   $0x801e8c
  8003bc:	e8 93 fe ff ff       	call   800254 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003c1:	ff 45 f0             	incl   -0x10(%ebp)
  8003c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003ca:	0f 8c 32 ff ff ff    	jl     800302 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003d0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003de:	eb 26                	jmp    800406 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003e0:	a1 04 30 80 00       	mov    0x803004,%eax
  8003e5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003eb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003ee:	89 d0                	mov    %edx,%eax
  8003f0:	01 c0                	add    %eax,%eax
  8003f2:	01 d0                	add    %edx,%eax
  8003f4:	c1 e0 02             	shl    $0x2,%eax
  8003f7:	01 c8                	add    %ecx,%eax
  8003f9:	8a 40 04             	mov    0x4(%eax),%al
  8003fc:	3c 01                	cmp    $0x1,%al
  8003fe:	75 03                	jne    800403 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800400:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800403:	ff 45 e0             	incl   -0x20(%ebp)
  800406:	a1 04 30 80 00       	mov    0x803004,%eax
  80040b:	8b 50 74             	mov    0x74(%eax),%edx
  80040e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800411:	39 c2                	cmp    %eax,%edx
  800413:	77 cb                	ja     8003e0 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800415:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800418:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80041b:	74 14                	je     800431 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80041d:	83 ec 04             	sub    $0x4,%esp
  800420:	68 ec 1e 80 00       	push   $0x801eec
  800425:	6a 44                	push   $0x44
  800427:	68 8c 1e 80 00       	push   $0x801e8c
  80042c:	e8 23 fe ff ff       	call   800254 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800431:	90                   	nop
  800432:	c9                   	leave  
  800433:	c3                   	ret    

00800434 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800434:	55                   	push   %ebp
  800435:	89 e5                	mov    %esp,%ebp
  800437:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80043a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	8d 48 01             	lea    0x1(%eax),%ecx
  800442:	8b 55 0c             	mov    0xc(%ebp),%edx
  800445:	89 0a                	mov    %ecx,(%edx)
  800447:	8b 55 08             	mov    0x8(%ebp),%edx
  80044a:	88 d1                	mov    %dl,%cl
  80044c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80044f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800453:	8b 45 0c             	mov    0xc(%ebp),%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	3d ff 00 00 00       	cmp    $0xff,%eax
  80045d:	75 2c                	jne    80048b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80045f:	a0 08 30 80 00       	mov    0x803008,%al
  800464:	0f b6 c0             	movzbl %al,%eax
  800467:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046a:	8b 12                	mov    (%edx),%edx
  80046c:	89 d1                	mov    %edx,%ecx
  80046e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800471:	83 c2 08             	add    $0x8,%edx
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	50                   	push   %eax
  800478:	51                   	push   %ecx
  800479:	52                   	push   %edx
  80047a:	e8 3e 0e 00 00       	call   8012bd <sys_cputs>
  80047f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800482:	8b 45 0c             	mov    0xc(%ebp),%eax
  800485:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80048b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048e:	8b 40 04             	mov    0x4(%eax),%eax
  800491:	8d 50 01             	lea    0x1(%eax),%edx
  800494:	8b 45 0c             	mov    0xc(%ebp),%eax
  800497:	89 50 04             	mov    %edx,0x4(%eax)
}
  80049a:	90                   	nop
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004a6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004ad:	00 00 00 
	b.cnt = 0;
  8004b0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004b7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004ba:	ff 75 0c             	pushl  0xc(%ebp)
  8004bd:	ff 75 08             	pushl  0x8(%ebp)
  8004c0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004c6:	50                   	push   %eax
  8004c7:	68 34 04 80 00       	push   $0x800434
  8004cc:	e8 11 02 00 00       	call   8006e2 <vprintfmt>
  8004d1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004d4:	a0 08 30 80 00       	mov    0x803008,%al
  8004d9:	0f b6 c0             	movzbl %al,%eax
  8004dc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004e2:	83 ec 04             	sub    $0x4,%esp
  8004e5:	50                   	push   %eax
  8004e6:	52                   	push   %edx
  8004e7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004ed:	83 c0 08             	add    $0x8,%eax
  8004f0:	50                   	push   %eax
  8004f1:	e8 c7 0d 00 00       	call   8012bd <sys_cputs>
  8004f6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004f9:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  800500:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800506:	c9                   	leave  
  800507:	c3                   	ret    

00800508 <cprintf>:

int cprintf(const char *fmt, ...) {
  800508:	55                   	push   %ebp
  800509:	89 e5                	mov    %esp,%ebp
  80050b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80050e:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800515:	8d 45 0c             	lea    0xc(%ebp),%eax
  800518:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	83 ec 08             	sub    $0x8,%esp
  800521:	ff 75 f4             	pushl  -0xc(%ebp)
  800524:	50                   	push   %eax
  800525:	e8 73 ff ff ff       	call   80049d <vcprintf>
  80052a:	83 c4 10             	add    $0x10,%esp
  80052d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800530:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800533:	c9                   	leave  
  800534:	c3                   	ret    

00800535 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800535:	55                   	push   %ebp
  800536:	89 e5                	mov    %esp,%ebp
  800538:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80053b:	e8 8e 0f 00 00       	call   8014ce <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800540:	8d 45 0c             	lea    0xc(%ebp),%eax
  800543:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800546:	8b 45 08             	mov    0x8(%ebp),%eax
  800549:	83 ec 08             	sub    $0x8,%esp
  80054c:	ff 75 f4             	pushl  -0xc(%ebp)
  80054f:	50                   	push   %eax
  800550:	e8 48 ff ff ff       	call   80049d <vcprintf>
  800555:	83 c4 10             	add    $0x10,%esp
  800558:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80055b:	e8 88 0f 00 00       	call   8014e8 <sys_enable_interrupt>
	return cnt;
  800560:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800563:	c9                   	leave  
  800564:	c3                   	ret    

00800565 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800565:	55                   	push   %ebp
  800566:	89 e5                	mov    %esp,%ebp
  800568:	53                   	push   %ebx
  800569:	83 ec 14             	sub    $0x14,%esp
  80056c:	8b 45 10             	mov    0x10(%ebp),%eax
  80056f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800572:	8b 45 14             	mov    0x14(%ebp),%eax
  800575:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800578:	8b 45 18             	mov    0x18(%ebp),%eax
  80057b:	ba 00 00 00 00       	mov    $0x0,%edx
  800580:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800583:	77 55                	ja     8005da <printnum+0x75>
  800585:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800588:	72 05                	jb     80058f <printnum+0x2a>
  80058a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80058d:	77 4b                	ja     8005da <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80058f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800592:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800595:	8b 45 18             	mov    0x18(%ebp),%eax
  800598:	ba 00 00 00 00       	mov    $0x0,%edx
  80059d:	52                   	push   %edx
  80059e:	50                   	push   %eax
  80059f:	ff 75 f4             	pushl  -0xc(%ebp)
  8005a2:	ff 75 f0             	pushl  -0x10(%ebp)
  8005a5:	e8 b6 13 00 00       	call   801960 <__udivdi3>
  8005aa:	83 c4 10             	add    $0x10,%esp
  8005ad:	83 ec 04             	sub    $0x4,%esp
  8005b0:	ff 75 20             	pushl  0x20(%ebp)
  8005b3:	53                   	push   %ebx
  8005b4:	ff 75 18             	pushl  0x18(%ebp)
  8005b7:	52                   	push   %edx
  8005b8:	50                   	push   %eax
  8005b9:	ff 75 0c             	pushl  0xc(%ebp)
  8005bc:	ff 75 08             	pushl  0x8(%ebp)
  8005bf:	e8 a1 ff ff ff       	call   800565 <printnum>
  8005c4:	83 c4 20             	add    $0x20,%esp
  8005c7:	eb 1a                	jmp    8005e3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005c9:	83 ec 08             	sub    $0x8,%esp
  8005cc:	ff 75 0c             	pushl  0xc(%ebp)
  8005cf:	ff 75 20             	pushl  0x20(%ebp)
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	ff d0                	call   *%eax
  8005d7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005da:	ff 4d 1c             	decl   0x1c(%ebp)
  8005dd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005e1:	7f e6                	jg     8005c9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005e3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005e6:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005f1:	53                   	push   %ebx
  8005f2:	51                   	push   %ecx
  8005f3:	52                   	push   %edx
  8005f4:	50                   	push   %eax
  8005f5:	e8 76 14 00 00       	call   801a70 <__umoddi3>
  8005fa:	83 c4 10             	add    $0x10,%esp
  8005fd:	05 54 21 80 00       	add    $0x802154,%eax
  800602:	8a 00                	mov    (%eax),%al
  800604:	0f be c0             	movsbl %al,%eax
  800607:	83 ec 08             	sub    $0x8,%esp
  80060a:	ff 75 0c             	pushl  0xc(%ebp)
  80060d:	50                   	push   %eax
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	ff d0                	call   *%eax
  800613:	83 c4 10             	add    $0x10,%esp
}
  800616:	90                   	nop
  800617:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80061a:	c9                   	leave  
  80061b:	c3                   	ret    

0080061c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80061c:	55                   	push   %ebp
  80061d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80061f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800623:	7e 1c                	jle    800641 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800625:	8b 45 08             	mov    0x8(%ebp),%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	8d 50 08             	lea    0x8(%eax),%edx
  80062d:	8b 45 08             	mov    0x8(%ebp),%eax
  800630:	89 10                	mov    %edx,(%eax)
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	8b 00                	mov    (%eax),%eax
  800637:	83 e8 08             	sub    $0x8,%eax
  80063a:	8b 50 04             	mov    0x4(%eax),%edx
  80063d:	8b 00                	mov    (%eax),%eax
  80063f:	eb 40                	jmp    800681 <getuint+0x65>
	else if (lflag)
  800641:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800645:	74 1e                	je     800665 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800647:	8b 45 08             	mov    0x8(%ebp),%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	8d 50 04             	lea    0x4(%eax),%edx
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	89 10                	mov    %edx,(%eax)
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	83 e8 04             	sub    $0x4,%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	ba 00 00 00 00       	mov    $0x0,%edx
  800663:	eb 1c                	jmp    800681 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	8b 00                	mov    (%eax),%eax
  80066a:	8d 50 04             	lea    0x4(%eax),%edx
  80066d:	8b 45 08             	mov    0x8(%ebp),%eax
  800670:	89 10                	mov    %edx,(%eax)
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8b 00                	mov    (%eax),%eax
  800677:	83 e8 04             	sub    $0x4,%eax
  80067a:	8b 00                	mov    (%eax),%eax
  80067c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800681:	5d                   	pop    %ebp
  800682:	c3                   	ret    

00800683 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800686:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80068a:	7e 1c                	jle    8006a8 <getint+0x25>
		return va_arg(*ap, long long);
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	8d 50 08             	lea    0x8(%eax),%edx
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	89 10                	mov    %edx,(%eax)
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	83 e8 08             	sub    $0x8,%eax
  8006a1:	8b 50 04             	mov    0x4(%eax),%edx
  8006a4:	8b 00                	mov    (%eax),%eax
  8006a6:	eb 38                	jmp    8006e0 <getint+0x5d>
	else if (lflag)
  8006a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ac:	74 1a                	je     8006c8 <getint+0x45>
		return va_arg(*ap, long);
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	8d 50 04             	lea    0x4(%eax),%edx
  8006b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b9:	89 10                	mov    %edx,(%eax)
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	83 e8 04             	sub    $0x4,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	99                   	cltd   
  8006c6:	eb 18                	jmp    8006e0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	8b 00                	mov    (%eax),%eax
  8006cd:	8d 50 04             	lea    0x4(%eax),%edx
  8006d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d3:	89 10                	mov    %edx,(%eax)
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	8b 00                	mov    (%eax),%eax
  8006da:	83 e8 04             	sub    $0x4,%eax
  8006dd:	8b 00                	mov    (%eax),%eax
  8006df:	99                   	cltd   
}
  8006e0:	5d                   	pop    %ebp
  8006e1:	c3                   	ret    

008006e2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006e2:	55                   	push   %ebp
  8006e3:	89 e5                	mov    %esp,%ebp
  8006e5:	56                   	push   %esi
  8006e6:	53                   	push   %ebx
  8006e7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ea:	eb 17                	jmp    800703 <vprintfmt+0x21>
			if (ch == '\0')
  8006ec:	85 db                	test   %ebx,%ebx
  8006ee:	0f 84 af 03 00 00    	je     800aa3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006f4:	83 ec 08             	sub    $0x8,%esp
  8006f7:	ff 75 0c             	pushl  0xc(%ebp)
  8006fa:	53                   	push   %ebx
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	ff d0                	call   *%eax
  800700:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800703:	8b 45 10             	mov    0x10(%ebp),%eax
  800706:	8d 50 01             	lea    0x1(%eax),%edx
  800709:	89 55 10             	mov    %edx,0x10(%ebp)
  80070c:	8a 00                	mov    (%eax),%al
  80070e:	0f b6 d8             	movzbl %al,%ebx
  800711:	83 fb 25             	cmp    $0x25,%ebx
  800714:	75 d6                	jne    8006ec <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800716:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80071a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800721:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800728:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80072f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800736:	8b 45 10             	mov    0x10(%ebp),%eax
  800739:	8d 50 01             	lea    0x1(%eax),%edx
  80073c:	89 55 10             	mov    %edx,0x10(%ebp)
  80073f:	8a 00                	mov    (%eax),%al
  800741:	0f b6 d8             	movzbl %al,%ebx
  800744:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800747:	83 f8 55             	cmp    $0x55,%eax
  80074a:	0f 87 2b 03 00 00    	ja     800a7b <vprintfmt+0x399>
  800750:	8b 04 85 78 21 80 00 	mov    0x802178(,%eax,4),%eax
  800757:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800759:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80075d:	eb d7                	jmp    800736 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80075f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800763:	eb d1                	jmp    800736 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800765:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80076c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80076f:	89 d0                	mov    %edx,%eax
  800771:	c1 e0 02             	shl    $0x2,%eax
  800774:	01 d0                	add    %edx,%eax
  800776:	01 c0                	add    %eax,%eax
  800778:	01 d8                	add    %ebx,%eax
  80077a:	83 e8 30             	sub    $0x30,%eax
  80077d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800780:	8b 45 10             	mov    0x10(%ebp),%eax
  800783:	8a 00                	mov    (%eax),%al
  800785:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800788:	83 fb 2f             	cmp    $0x2f,%ebx
  80078b:	7e 3e                	jle    8007cb <vprintfmt+0xe9>
  80078d:	83 fb 39             	cmp    $0x39,%ebx
  800790:	7f 39                	jg     8007cb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800792:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800795:	eb d5                	jmp    80076c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800797:	8b 45 14             	mov    0x14(%ebp),%eax
  80079a:	83 c0 04             	add    $0x4,%eax
  80079d:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a3:	83 e8 04             	sub    $0x4,%eax
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007ab:	eb 1f                	jmp    8007cc <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007b1:	79 83                	jns    800736 <vprintfmt+0x54>
				width = 0;
  8007b3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007ba:	e9 77 ff ff ff       	jmp    800736 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007bf:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007c6:	e9 6b ff ff ff       	jmp    800736 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007cb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d0:	0f 89 60 ff ff ff    	jns    800736 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007dc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007e3:	e9 4e ff ff ff       	jmp    800736 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007e8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007eb:	e9 46 ff ff ff       	jmp    800736 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f3:	83 c0 04             	add    $0x4,%eax
  8007f6:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007fc:	83 e8 04             	sub    $0x4,%eax
  8007ff:	8b 00                	mov    (%eax),%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 0c             	pushl  0xc(%ebp)
  800807:	50                   	push   %eax
  800808:	8b 45 08             	mov    0x8(%ebp),%eax
  80080b:	ff d0                	call   *%eax
  80080d:	83 c4 10             	add    $0x10,%esp
			break;
  800810:	e9 89 02 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800815:	8b 45 14             	mov    0x14(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 14             	mov    %eax,0x14(%ebp)
  80081e:	8b 45 14             	mov    0x14(%ebp),%eax
  800821:	83 e8 04             	sub    $0x4,%eax
  800824:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800826:	85 db                	test   %ebx,%ebx
  800828:	79 02                	jns    80082c <vprintfmt+0x14a>
				err = -err;
  80082a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80082c:	83 fb 64             	cmp    $0x64,%ebx
  80082f:	7f 0b                	jg     80083c <vprintfmt+0x15a>
  800831:	8b 34 9d c0 1f 80 00 	mov    0x801fc0(,%ebx,4),%esi
  800838:	85 f6                	test   %esi,%esi
  80083a:	75 19                	jne    800855 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80083c:	53                   	push   %ebx
  80083d:	68 65 21 80 00       	push   $0x802165
  800842:	ff 75 0c             	pushl  0xc(%ebp)
  800845:	ff 75 08             	pushl  0x8(%ebp)
  800848:	e8 5e 02 00 00       	call   800aab <printfmt>
  80084d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800850:	e9 49 02 00 00       	jmp    800a9e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800855:	56                   	push   %esi
  800856:	68 6e 21 80 00       	push   $0x80216e
  80085b:	ff 75 0c             	pushl  0xc(%ebp)
  80085e:	ff 75 08             	pushl  0x8(%ebp)
  800861:	e8 45 02 00 00       	call   800aab <printfmt>
  800866:	83 c4 10             	add    $0x10,%esp
			break;
  800869:	e9 30 02 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80086e:	8b 45 14             	mov    0x14(%ebp),%eax
  800871:	83 c0 04             	add    $0x4,%eax
  800874:	89 45 14             	mov    %eax,0x14(%ebp)
  800877:	8b 45 14             	mov    0x14(%ebp),%eax
  80087a:	83 e8 04             	sub    $0x4,%eax
  80087d:	8b 30                	mov    (%eax),%esi
  80087f:	85 f6                	test   %esi,%esi
  800881:	75 05                	jne    800888 <vprintfmt+0x1a6>
				p = "(null)";
  800883:	be 71 21 80 00       	mov    $0x802171,%esi
			if (width > 0 && padc != '-')
  800888:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80088c:	7e 6d                	jle    8008fb <vprintfmt+0x219>
  80088e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800892:	74 67                	je     8008fb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800894:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800897:	83 ec 08             	sub    $0x8,%esp
  80089a:	50                   	push   %eax
  80089b:	56                   	push   %esi
  80089c:	e8 0c 03 00 00       	call   800bad <strnlen>
  8008a1:	83 c4 10             	add    $0x10,%esp
  8008a4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008a7:	eb 16                	jmp    8008bf <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008a9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008ad:	83 ec 08             	sub    $0x8,%esp
  8008b0:	ff 75 0c             	pushl  0xc(%ebp)
  8008b3:	50                   	push   %eax
  8008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b7:	ff d0                	call   *%eax
  8008b9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008bc:	ff 4d e4             	decl   -0x1c(%ebp)
  8008bf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008c3:	7f e4                	jg     8008a9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008c5:	eb 34                	jmp    8008fb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008c7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008cb:	74 1c                	je     8008e9 <vprintfmt+0x207>
  8008cd:	83 fb 1f             	cmp    $0x1f,%ebx
  8008d0:	7e 05                	jle    8008d7 <vprintfmt+0x1f5>
  8008d2:	83 fb 7e             	cmp    $0x7e,%ebx
  8008d5:	7e 12                	jle    8008e9 <vprintfmt+0x207>
					putch('?', putdat);
  8008d7:	83 ec 08             	sub    $0x8,%esp
  8008da:	ff 75 0c             	pushl  0xc(%ebp)
  8008dd:	6a 3f                	push   $0x3f
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	ff d0                	call   *%eax
  8008e4:	83 c4 10             	add    $0x10,%esp
  8008e7:	eb 0f                	jmp    8008f8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008e9:	83 ec 08             	sub    $0x8,%esp
  8008ec:	ff 75 0c             	pushl  0xc(%ebp)
  8008ef:	53                   	push   %ebx
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	ff d0                	call   *%eax
  8008f5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008f8:	ff 4d e4             	decl   -0x1c(%ebp)
  8008fb:	89 f0                	mov    %esi,%eax
  8008fd:	8d 70 01             	lea    0x1(%eax),%esi
  800900:	8a 00                	mov    (%eax),%al
  800902:	0f be d8             	movsbl %al,%ebx
  800905:	85 db                	test   %ebx,%ebx
  800907:	74 24                	je     80092d <vprintfmt+0x24b>
  800909:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80090d:	78 b8                	js     8008c7 <vprintfmt+0x1e5>
  80090f:	ff 4d e0             	decl   -0x20(%ebp)
  800912:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800916:	79 af                	jns    8008c7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800918:	eb 13                	jmp    80092d <vprintfmt+0x24b>
				putch(' ', putdat);
  80091a:	83 ec 08             	sub    $0x8,%esp
  80091d:	ff 75 0c             	pushl  0xc(%ebp)
  800920:	6a 20                	push   $0x20
  800922:	8b 45 08             	mov    0x8(%ebp),%eax
  800925:	ff d0                	call   *%eax
  800927:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80092a:	ff 4d e4             	decl   -0x1c(%ebp)
  80092d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800931:	7f e7                	jg     80091a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800933:	e9 66 01 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800938:	83 ec 08             	sub    $0x8,%esp
  80093b:	ff 75 e8             	pushl  -0x18(%ebp)
  80093e:	8d 45 14             	lea    0x14(%ebp),%eax
  800941:	50                   	push   %eax
  800942:	e8 3c fd ff ff       	call   800683 <getint>
  800947:	83 c4 10             	add    $0x10,%esp
  80094a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80094d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800950:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800953:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800956:	85 d2                	test   %edx,%edx
  800958:	79 23                	jns    80097d <vprintfmt+0x29b>
				putch('-', putdat);
  80095a:	83 ec 08             	sub    $0x8,%esp
  80095d:	ff 75 0c             	pushl  0xc(%ebp)
  800960:	6a 2d                	push   $0x2d
  800962:	8b 45 08             	mov    0x8(%ebp),%eax
  800965:	ff d0                	call   *%eax
  800967:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80096a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80096d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800970:	f7 d8                	neg    %eax
  800972:	83 d2 00             	adc    $0x0,%edx
  800975:	f7 da                	neg    %edx
  800977:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80097d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800984:	e9 bc 00 00 00       	jmp    800a45 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800989:	83 ec 08             	sub    $0x8,%esp
  80098c:	ff 75 e8             	pushl  -0x18(%ebp)
  80098f:	8d 45 14             	lea    0x14(%ebp),%eax
  800992:	50                   	push   %eax
  800993:	e8 84 fc ff ff       	call   80061c <getuint>
  800998:	83 c4 10             	add    $0x10,%esp
  80099b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009a1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a8:	e9 98 00 00 00       	jmp    800a45 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009ad:	83 ec 08             	sub    $0x8,%esp
  8009b0:	ff 75 0c             	pushl  0xc(%ebp)
  8009b3:	6a 58                	push   $0x58
  8009b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b8:	ff d0                	call   *%eax
  8009ba:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009bd:	83 ec 08             	sub    $0x8,%esp
  8009c0:	ff 75 0c             	pushl  0xc(%ebp)
  8009c3:	6a 58                	push   $0x58
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	ff d0                	call   *%eax
  8009ca:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 0c             	pushl  0xc(%ebp)
  8009d3:	6a 58                	push   $0x58
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	ff d0                	call   *%eax
  8009da:	83 c4 10             	add    $0x10,%esp
			break;
  8009dd:	e9 bc 00 00 00       	jmp    800a9e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009e2:	83 ec 08             	sub    $0x8,%esp
  8009e5:	ff 75 0c             	pushl  0xc(%ebp)
  8009e8:	6a 30                	push   $0x30
  8009ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ed:	ff d0                	call   *%eax
  8009ef:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009f2:	83 ec 08             	sub    $0x8,%esp
  8009f5:	ff 75 0c             	pushl  0xc(%ebp)
  8009f8:	6a 78                	push   $0x78
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	ff d0                	call   *%eax
  8009ff:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a02:	8b 45 14             	mov    0x14(%ebp),%eax
  800a05:	83 c0 04             	add    $0x4,%eax
  800a08:	89 45 14             	mov    %eax,0x14(%ebp)
  800a0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0e:	83 e8 04             	sub    $0x4,%eax
  800a11:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a1d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a24:	eb 1f                	jmp    800a45 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a26:	83 ec 08             	sub    $0x8,%esp
  800a29:	ff 75 e8             	pushl  -0x18(%ebp)
  800a2c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a2f:	50                   	push   %eax
  800a30:	e8 e7 fb ff ff       	call   80061c <getuint>
  800a35:	83 c4 10             	add    $0x10,%esp
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a3e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a45:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a49:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a4c:	83 ec 04             	sub    $0x4,%esp
  800a4f:	52                   	push   %edx
  800a50:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a53:	50                   	push   %eax
  800a54:	ff 75 f4             	pushl  -0xc(%ebp)
  800a57:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5a:	ff 75 0c             	pushl  0xc(%ebp)
  800a5d:	ff 75 08             	pushl  0x8(%ebp)
  800a60:	e8 00 fb ff ff       	call   800565 <printnum>
  800a65:	83 c4 20             	add    $0x20,%esp
			break;
  800a68:	eb 34                	jmp    800a9e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a6a:	83 ec 08             	sub    $0x8,%esp
  800a6d:	ff 75 0c             	pushl  0xc(%ebp)
  800a70:	53                   	push   %ebx
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	ff d0                	call   *%eax
  800a76:	83 c4 10             	add    $0x10,%esp
			break;
  800a79:	eb 23                	jmp    800a9e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a7b:	83 ec 08             	sub    $0x8,%esp
  800a7e:	ff 75 0c             	pushl  0xc(%ebp)
  800a81:	6a 25                	push   $0x25
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	ff d0                	call   *%eax
  800a88:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a8b:	ff 4d 10             	decl   0x10(%ebp)
  800a8e:	eb 03                	jmp    800a93 <vprintfmt+0x3b1>
  800a90:	ff 4d 10             	decl   0x10(%ebp)
  800a93:	8b 45 10             	mov    0x10(%ebp),%eax
  800a96:	48                   	dec    %eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	3c 25                	cmp    $0x25,%al
  800a9b:	75 f3                	jne    800a90 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a9d:	90                   	nop
		}
	}
  800a9e:	e9 47 fc ff ff       	jmp    8006ea <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800aa3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800aa4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aa7:	5b                   	pop    %ebx
  800aa8:	5e                   	pop    %esi
  800aa9:	5d                   	pop    %ebp
  800aaa:	c3                   	ret    

00800aab <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aab:	55                   	push   %ebp
  800aac:	89 e5                	mov    %esp,%ebp
  800aae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ab1:	8d 45 10             	lea    0x10(%ebp),%eax
  800ab4:	83 c0 04             	add    $0x4,%eax
  800ab7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800aba:	8b 45 10             	mov    0x10(%ebp),%eax
  800abd:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac0:	50                   	push   %eax
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	ff 75 08             	pushl  0x8(%ebp)
  800ac7:	e8 16 fc ff ff       	call   8006e2 <vprintfmt>
  800acc:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800acf:	90                   	nop
  800ad0:	c9                   	leave  
  800ad1:	c3                   	ret    

00800ad2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ad2:	55                   	push   %ebp
  800ad3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad8:	8b 40 08             	mov    0x8(%eax),%eax
  800adb:	8d 50 01             	lea    0x1(%eax),%edx
  800ade:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ae4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae7:	8b 10                	mov    (%eax),%edx
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8b 40 04             	mov    0x4(%eax),%eax
  800aef:	39 c2                	cmp    %eax,%edx
  800af1:	73 12                	jae    800b05 <sprintputch+0x33>
		*b->buf++ = ch;
  800af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	8d 48 01             	lea    0x1(%eax),%ecx
  800afb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800afe:	89 0a                	mov    %ecx,(%edx)
  800b00:	8b 55 08             	mov    0x8(%ebp),%edx
  800b03:	88 10                	mov    %dl,(%eax)
}
  800b05:	90                   	nop
  800b06:	5d                   	pop    %ebp
  800b07:	c3                   	ret    

00800b08 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b08:	55                   	push   %ebp
  800b09:	89 e5                	mov    %esp,%ebp
  800b0b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b17:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	01 d0                	add    %edx,%eax
  800b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b29:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b2d:	74 06                	je     800b35 <vsnprintf+0x2d>
  800b2f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b33:	7f 07                	jg     800b3c <vsnprintf+0x34>
		return -E_INVAL;
  800b35:	b8 03 00 00 00       	mov    $0x3,%eax
  800b3a:	eb 20                	jmp    800b5c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b3c:	ff 75 14             	pushl  0x14(%ebp)
  800b3f:	ff 75 10             	pushl  0x10(%ebp)
  800b42:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b45:	50                   	push   %eax
  800b46:	68 d2 0a 80 00       	push   $0x800ad2
  800b4b:	e8 92 fb ff ff       	call   8006e2 <vprintfmt>
  800b50:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b56:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b5c:	c9                   	leave  
  800b5d:	c3                   	ret    

00800b5e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
  800b61:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b64:	8d 45 10             	lea    0x10(%ebp),%eax
  800b67:	83 c0 04             	add    $0x4,%eax
  800b6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b70:	ff 75 f4             	pushl  -0xc(%ebp)
  800b73:	50                   	push   %eax
  800b74:	ff 75 0c             	pushl  0xc(%ebp)
  800b77:	ff 75 08             	pushl  0x8(%ebp)
  800b7a:	e8 89 ff ff ff       	call   800b08 <vsnprintf>
  800b7f:	83 c4 10             	add    $0x10,%esp
  800b82:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b88:	c9                   	leave  
  800b89:	c3                   	ret    

00800b8a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b8a:	55                   	push   %ebp
  800b8b:	89 e5                	mov    %esp,%ebp
  800b8d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b97:	eb 06                	jmp    800b9f <strlen+0x15>
		n++;
  800b99:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b9c:	ff 45 08             	incl   0x8(%ebp)
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	8a 00                	mov    (%eax),%al
  800ba4:	84 c0                	test   %al,%al
  800ba6:	75 f1                	jne    800b99 <strlen+0xf>
		n++;
	return n;
  800ba8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bab:	c9                   	leave  
  800bac:	c3                   	ret    

00800bad <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bad:	55                   	push   %ebp
  800bae:	89 e5                	mov    %esp,%ebp
  800bb0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bba:	eb 09                	jmp    800bc5 <strnlen+0x18>
		n++;
  800bbc:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bbf:	ff 45 08             	incl   0x8(%ebp)
  800bc2:	ff 4d 0c             	decl   0xc(%ebp)
  800bc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc9:	74 09                	je     800bd4 <strnlen+0x27>
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8a 00                	mov    (%eax),%al
  800bd0:	84 c0                	test   %al,%al
  800bd2:	75 e8                	jne    800bbc <strnlen+0xf>
		n++;
	return n;
  800bd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd7:	c9                   	leave  
  800bd8:	c3                   	ret    

00800bd9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bd9:	55                   	push   %ebp
  800bda:	89 e5                	mov    %esp,%ebp
  800bdc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800be5:	90                   	nop
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	8d 50 01             	lea    0x1(%eax),%edx
  800bec:	89 55 08             	mov    %edx,0x8(%ebp)
  800bef:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bf8:	8a 12                	mov    (%edx),%dl
  800bfa:	88 10                	mov    %dl,(%eax)
  800bfc:	8a 00                	mov    (%eax),%al
  800bfe:	84 c0                	test   %al,%al
  800c00:	75 e4                	jne    800be6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c02:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c05:	c9                   	leave  
  800c06:	c3                   	ret    

00800c07 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c07:	55                   	push   %ebp
  800c08:	89 e5                	mov    %esp,%ebp
  800c0a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c1a:	eb 1f                	jmp    800c3b <strncpy+0x34>
		*dst++ = *src;
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	8d 50 01             	lea    0x1(%eax),%edx
  800c22:	89 55 08             	mov    %edx,0x8(%ebp)
  800c25:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c28:	8a 12                	mov    (%edx),%dl
  800c2a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	84 c0                	test   %al,%al
  800c33:	74 03                	je     800c38 <strncpy+0x31>
			src++;
  800c35:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c38:	ff 45 fc             	incl   -0x4(%ebp)
  800c3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c41:	72 d9                	jb     800c1c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c43:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c46:	c9                   	leave  
  800c47:	c3                   	ret    

00800c48 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c48:	55                   	push   %ebp
  800c49:	89 e5                	mov    %esp,%ebp
  800c4b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c58:	74 30                	je     800c8a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c5a:	eb 16                	jmp    800c72 <strlcpy+0x2a>
			*dst++ = *src++;
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	8d 50 01             	lea    0x1(%eax),%edx
  800c62:	89 55 08             	mov    %edx,0x8(%ebp)
  800c65:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c68:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c6b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c6e:	8a 12                	mov    (%edx),%dl
  800c70:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c72:	ff 4d 10             	decl   0x10(%ebp)
  800c75:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c79:	74 09                	je     800c84 <strlcpy+0x3c>
  800c7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	84 c0                	test   %al,%al
  800c82:	75 d8                	jne    800c5c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c8a:	8b 55 08             	mov    0x8(%ebp),%edx
  800c8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c90:	29 c2                	sub    %eax,%edx
  800c92:	89 d0                	mov    %edx,%eax
}
  800c94:	c9                   	leave  
  800c95:	c3                   	ret    

00800c96 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c96:	55                   	push   %ebp
  800c97:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c99:	eb 06                	jmp    800ca1 <strcmp+0xb>
		p++, q++;
  800c9b:	ff 45 08             	incl   0x8(%ebp)
  800c9e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	84 c0                	test   %al,%al
  800ca8:	74 0e                	je     800cb8 <strcmp+0x22>
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	8a 10                	mov    (%eax),%dl
  800caf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	38 c2                	cmp    %al,%dl
  800cb6:	74 e3                	je     800c9b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8a 00                	mov    (%eax),%al
  800cbd:	0f b6 d0             	movzbl %al,%edx
  800cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	0f b6 c0             	movzbl %al,%eax
  800cc8:	29 c2                	sub    %eax,%edx
  800cca:	89 d0                	mov    %edx,%eax
}
  800ccc:	5d                   	pop    %ebp
  800ccd:	c3                   	ret    

00800cce <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cce:	55                   	push   %ebp
  800ccf:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cd1:	eb 09                	jmp    800cdc <strncmp+0xe>
		n--, p++, q++;
  800cd3:	ff 4d 10             	decl   0x10(%ebp)
  800cd6:	ff 45 08             	incl   0x8(%ebp)
  800cd9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cdc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce0:	74 17                	je     800cf9 <strncmp+0x2b>
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	84 c0                	test   %al,%al
  800ce9:	74 0e                	je     800cf9 <strncmp+0x2b>
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8a 10                	mov    (%eax),%dl
  800cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf3:	8a 00                	mov    (%eax),%al
  800cf5:	38 c2                	cmp    %al,%dl
  800cf7:	74 da                	je     800cd3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cf9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cfd:	75 07                	jne    800d06 <strncmp+0x38>
		return 0;
  800cff:	b8 00 00 00 00       	mov    $0x0,%eax
  800d04:	eb 14                	jmp    800d1a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f b6 d0             	movzbl %al,%edx
  800d0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d11:	8a 00                	mov    (%eax),%al
  800d13:	0f b6 c0             	movzbl %al,%eax
  800d16:	29 c2                	sub    %eax,%edx
  800d18:	89 d0                	mov    %edx,%eax
}
  800d1a:	5d                   	pop    %ebp
  800d1b:	c3                   	ret    

00800d1c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d1c:	55                   	push   %ebp
  800d1d:	89 e5                	mov    %esp,%ebp
  800d1f:	83 ec 04             	sub    $0x4,%esp
  800d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d25:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d28:	eb 12                	jmp    800d3c <strchr+0x20>
		if (*s == c)
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d32:	75 05                	jne    800d39 <strchr+0x1d>
			return (char *) s;
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	eb 11                	jmp    800d4a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d39:	ff 45 08             	incl   0x8(%ebp)
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	84 c0                	test   %al,%al
  800d43:	75 e5                	jne    800d2a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d4a:	c9                   	leave  
  800d4b:	c3                   	ret    

00800d4c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d4c:	55                   	push   %ebp
  800d4d:	89 e5                	mov    %esp,%ebp
  800d4f:	83 ec 04             	sub    $0x4,%esp
  800d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d55:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d58:	eb 0d                	jmp    800d67 <strfind+0x1b>
		if (*s == c)
  800d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5d:	8a 00                	mov    (%eax),%al
  800d5f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d62:	74 0e                	je     800d72 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d64:	ff 45 08             	incl   0x8(%ebp)
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	8a 00                	mov    (%eax),%al
  800d6c:	84 c0                	test   %al,%al
  800d6e:	75 ea                	jne    800d5a <strfind+0xe>
  800d70:	eb 01                	jmp    800d73 <strfind+0x27>
		if (*s == c)
			break;
  800d72:	90                   	nop
	return (char *) s;
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d76:	c9                   	leave  
  800d77:	c3                   	ret    

00800d78 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
  800d7b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d84:	8b 45 10             	mov    0x10(%ebp),%eax
  800d87:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d8a:	eb 0e                	jmp    800d9a <memset+0x22>
		*p++ = c;
  800d8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8f:	8d 50 01             	lea    0x1(%eax),%edx
  800d92:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d95:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d98:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d9a:	ff 4d f8             	decl   -0x8(%ebp)
  800d9d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800da1:	79 e9                	jns    800d8c <memset+0x14>
		*p++ = c;

	return v;
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da6:	c9                   	leave  
  800da7:	c3                   	ret    

00800da8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800da8:	55                   	push   %ebp
  800da9:	89 e5                	mov    %esp,%ebp
  800dab:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dba:	eb 16                	jmp    800dd2 <memcpy+0x2a>
		*d++ = *s++;
  800dbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dbf:	8d 50 01             	lea    0x1(%eax),%edx
  800dc2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dc5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dcb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dce:	8a 12                	mov    (%edx),%dl
  800dd0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ddb:	85 c0                	test   %eax,%eax
  800ddd:	75 dd                	jne    800dbc <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de2:	c9                   	leave  
  800de3:	c3                   	ret    

00800de4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
  800de7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800dea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ded:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800df6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dfc:	73 50                	jae    800e4e <memmove+0x6a>
  800dfe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e01:	8b 45 10             	mov    0x10(%ebp),%eax
  800e04:	01 d0                	add    %edx,%eax
  800e06:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e09:	76 43                	jbe    800e4e <memmove+0x6a>
		s += n;
  800e0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e11:	8b 45 10             	mov    0x10(%ebp),%eax
  800e14:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e17:	eb 10                	jmp    800e29 <memmove+0x45>
			*--d = *--s;
  800e19:	ff 4d f8             	decl   -0x8(%ebp)
  800e1c:	ff 4d fc             	decl   -0x4(%ebp)
  800e1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e22:	8a 10                	mov    (%eax),%dl
  800e24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e27:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e29:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e2f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e32:	85 c0                	test   %eax,%eax
  800e34:	75 e3                	jne    800e19 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e36:	eb 23                	jmp    800e5b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e38:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3b:	8d 50 01             	lea    0x1(%eax),%edx
  800e3e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e41:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e44:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e47:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e4a:	8a 12                	mov    (%edx),%dl
  800e4c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e51:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e54:	89 55 10             	mov    %edx,0x10(%ebp)
  800e57:	85 c0                	test   %eax,%eax
  800e59:	75 dd                	jne    800e38 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e5e:	c9                   	leave  
  800e5f:	c3                   	ret    

00800e60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e60:	55                   	push   %ebp
  800e61:	89 e5                	mov    %esp,%ebp
  800e63:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e72:	eb 2a                	jmp    800e9e <memcmp+0x3e>
		if (*s1 != *s2)
  800e74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e77:	8a 10                	mov    (%eax),%dl
  800e79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7c:	8a 00                	mov    (%eax),%al
  800e7e:	38 c2                	cmp    %al,%dl
  800e80:	74 16                	je     800e98 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e82:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	0f b6 d0             	movzbl %al,%edx
  800e8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	0f b6 c0             	movzbl %al,%eax
  800e92:	29 c2                	sub    %eax,%edx
  800e94:	89 d0                	mov    %edx,%eax
  800e96:	eb 18                	jmp    800eb0 <memcmp+0x50>
		s1++, s2++;
  800e98:	ff 45 fc             	incl   -0x4(%ebp)
  800e9b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea4:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea7:	85 c0                	test   %eax,%eax
  800ea9:	75 c9                	jne    800e74 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb0:	c9                   	leave  
  800eb1:	c3                   	ret    

00800eb2 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eb2:	55                   	push   %ebp
  800eb3:	89 e5                	mov    %esp,%ebp
  800eb5:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eb8:	8b 55 08             	mov    0x8(%ebp),%edx
  800ebb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ebe:	01 d0                	add    %edx,%eax
  800ec0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ec3:	eb 15                	jmp    800eda <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	0f b6 d0             	movzbl %al,%edx
  800ecd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed0:	0f b6 c0             	movzbl %al,%eax
  800ed3:	39 c2                	cmp    %eax,%edx
  800ed5:	74 0d                	je     800ee4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ed7:	ff 45 08             	incl   0x8(%ebp)
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ee0:	72 e3                	jb     800ec5 <memfind+0x13>
  800ee2:	eb 01                	jmp    800ee5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ee4:	90                   	nop
	return (void *) s;
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee8:	c9                   	leave  
  800ee9:	c3                   	ret    

00800eea <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eea:	55                   	push   %ebp
  800eeb:	89 e5                	mov    %esp,%ebp
  800eed:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ef0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ef7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800efe:	eb 03                	jmp    800f03 <strtol+0x19>
		s++;
  800f00:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f03:	8b 45 08             	mov    0x8(%ebp),%eax
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	3c 20                	cmp    $0x20,%al
  800f0a:	74 f4                	je     800f00 <strtol+0x16>
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	3c 09                	cmp    $0x9,%al
  800f13:	74 eb                	je     800f00 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	3c 2b                	cmp    $0x2b,%al
  800f1c:	75 05                	jne    800f23 <strtol+0x39>
		s++;
  800f1e:	ff 45 08             	incl   0x8(%ebp)
  800f21:	eb 13                	jmp    800f36 <strtol+0x4c>
	else if (*s == '-')
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8a 00                	mov    (%eax),%al
  800f28:	3c 2d                	cmp    $0x2d,%al
  800f2a:	75 0a                	jne    800f36 <strtol+0x4c>
		s++, neg = 1;
  800f2c:	ff 45 08             	incl   0x8(%ebp)
  800f2f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3a:	74 06                	je     800f42 <strtol+0x58>
  800f3c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f40:	75 20                	jne    800f62 <strtol+0x78>
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	8a 00                	mov    (%eax),%al
  800f47:	3c 30                	cmp    $0x30,%al
  800f49:	75 17                	jne    800f62 <strtol+0x78>
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	40                   	inc    %eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	3c 78                	cmp    $0x78,%al
  800f53:	75 0d                	jne    800f62 <strtol+0x78>
		s += 2, base = 16;
  800f55:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f59:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f60:	eb 28                	jmp    800f8a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f66:	75 15                	jne    800f7d <strtol+0x93>
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	3c 30                	cmp    $0x30,%al
  800f6f:	75 0c                	jne    800f7d <strtol+0x93>
		s++, base = 8;
  800f71:	ff 45 08             	incl   0x8(%ebp)
  800f74:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f7b:	eb 0d                	jmp    800f8a <strtol+0xa0>
	else if (base == 0)
  800f7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f81:	75 07                	jne    800f8a <strtol+0xa0>
		base = 10;
  800f83:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 2f                	cmp    $0x2f,%al
  800f91:	7e 19                	jle    800fac <strtol+0xc2>
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	3c 39                	cmp    $0x39,%al
  800f9a:	7f 10                	jg     800fac <strtol+0xc2>
			dig = *s - '0';
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	0f be c0             	movsbl %al,%eax
  800fa4:	83 e8 30             	sub    $0x30,%eax
  800fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800faa:	eb 42                	jmp    800fee <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 60                	cmp    $0x60,%al
  800fb3:	7e 19                	jle    800fce <strtol+0xe4>
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	3c 7a                	cmp    $0x7a,%al
  800fbc:	7f 10                	jg     800fce <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	0f be c0             	movsbl %al,%eax
  800fc6:	83 e8 57             	sub    $0x57,%eax
  800fc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcc:	eb 20                	jmp    800fee <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	3c 40                	cmp    $0x40,%al
  800fd5:	7e 39                	jle    801010 <strtol+0x126>
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3c 5a                	cmp    $0x5a,%al
  800fde:	7f 30                	jg     801010 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	0f be c0             	movsbl %al,%eax
  800fe8:	83 e8 37             	sub    $0x37,%eax
  800feb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ff1:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ff4:	7d 19                	jge    80100f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ff6:	ff 45 08             	incl   0x8(%ebp)
  800ff9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffc:	0f af 45 10          	imul   0x10(%ebp),%eax
  801000:	89 c2                	mov    %eax,%edx
  801002:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801005:	01 d0                	add    %edx,%eax
  801007:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80100a:	e9 7b ff ff ff       	jmp    800f8a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80100f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801010:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801014:	74 08                	je     80101e <strtol+0x134>
		*endptr = (char *) s;
  801016:	8b 45 0c             	mov    0xc(%ebp),%eax
  801019:	8b 55 08             	mov    0x8(%ebp),%edx
  80101c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80101e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801022:	74 07                	je     80102b <strtol+0x141>
  801024:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801027:	f7 d8                	neg    %eax
  801029:	eb 03                	jmp    80102e <strtol+0x144>
  80102b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80102e:	c9                   	leave  
  80102f:	c3                   	ret    

00801030 <ltostr>:

void
ltostr(long value, char *str)
{
  801030:	55                   	push   %ebp
  801031:	89 e5                	mov    %esp,%ebp
  801033:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801036:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80103d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801044:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801048:	79 13                	jns    80105d <ltostr+0x2d>
	{
		neg = 1;
  80104a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801051:	8b 45 0c             	mov    0xc(%ebp),%eax
  801054:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801057:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80105a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801065:	99                   	cltd   
  801066:	f7 f9                	idiv   %ecx
  801068:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80106b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106e:	8d 50 01             	lea    0x1(%eax),%edx
  801071:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801074:	89 c2                	mov    %eax,%edx
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	01 d0                	add    %edx,%eax
  80107b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80107e:	83 c2 30             	add    $0x30,%edx
  801081:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801083:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801086:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80108b:	f7 e9                	imul   %ecx
  80108d:	c1 fa 02             	sar    $0x2,%edx
  801090:	89 c8                	mov    %ecx,%eax
  801092:	c1 f8 1f             	sar    $0x1f,%eax
  801095:	29 c2                	sub    %eax,%edx
  801097:	89 d0                	mov    %edx,%eax
  801099:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80109c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80109f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010a4:	f7 e9                	imul   %ecx
  8010a6:	c1 fa 02             	sar    $0x2,%edx
  8010a9:	89 c8                	mov    %ecx,%eax
  8010ab:	c1 f8 1f             	sar    $0x1f,%eax
  8010ae:	29 c2                	sub    %eax,%edx
  8010b0:	89 d0                	mov    %edx,%eax
  8010b2:	c1 e0 02             	shl    $0x2,%eax
  8010b5:	01 d0                	add    %edx,%eax
  8010b7:	01 c0                	add    %eax,%eax
  8010b9:	29 c1                	sub    %eax,%ecx
  8010bb:	89 ca                	mov    %ecx,%edx
  8010bd:	85 d2                	test   %edx,%edx
  8010bf:	75 9c                	jne    80105d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010cb:	48                   	dec    %eax
  8010cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010d3:	74 3d                	je     801112 <ltostr+0xe2>
		start = 1 ;
  8010d5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010dc:	eb 34                	jmp    801112 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e4:	01 d0                	add    %edx,%eax
  8010e6:	8a 00                	mov    (%eax),%al
  8010e8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	01 c2                	add    %eax,%edx
  8010f3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f9:	01 c8                	add    %ecx,%eax
  8010fb:	8a 00                	mov    (%eax),%al
  8010fd:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801102:	8b 45 0c             	mov    0xc(%ebp),%eax
  801105:	01 c2                	add    %eax,%edx
  801107:	8a 45 eb             	mov    -0x15(%ebp),%al
  80110a:	88 02                	mov    %al,(%edx)
		start++ ;
  80110c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80110f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801112:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801115:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801118:	7c c4                	jl     8010de <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80111a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80111d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801120:	01 d0                	add    %edx,%eax
  801122:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801125:	90                   	nop
  801126:	c9                   	leave  
  801127:	c3                   	ret    

00801128 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
  80112b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80112e:	ff 75 08             	pushl  0x8(%ebp)
  801131:	e8 54 fa ff ff       	call   800b8a <strlen>
  801136:	83 c4 04             	add    $0x4,%esp
  801139:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80113c:	ff 75 0c             	pushl  0xc(%ebp)
  80113f:	e8 46 fa ff ff       	call   800b8a <strlen>
  801144:	83 c4 04             	add    $0x4,%esp
  801147:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80114a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801151:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801158:	eb 17                	jmp    801171 <strcconcat+0x49>
		final[s] = str1[s] ;
  80115a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80115d:	8b 45 10             	mov    0x10(%ebp),%eax
  801160:	01 c2                	add    %eax,%edx
  801162:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	01 c8                	add    %ecx,%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80116e:	ff 45 fc             	incl   -0x4(%ebp)
  801171:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801174:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801177:	7c e1                	jl     80115a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801179:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801180:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801187:	eb 1f                	jmp    8011a8 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801189:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80118c:	8d 50 01             	lea    0x1(%eax),%edx
  80118f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801192:	89 c2                	mov    %eax,%edx
  801194:	8b 45 10             	mov    0x10(%ebp),%eax
  801197:	01 c2                	add    %eax,%edx
  801199:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80119c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119f:	01 c8                	add    %ecx,%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011a5:	ff 45 f8             	incl   -0x8(%ebp)
  8011a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ae:	7c d9                	jl     801189 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b6:	01 d0                	add    %edx,%eax
  8011b8:	c6 00 00             	movb   $0x0,(%eax)
}
  8011bb:	90                   	nop
  8011bc:	c9                   	leave  
  8011bd:	c3                   	ret    

008011be <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011be:	55                   	push   %ebp
  8011bf:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cd:	8b 00                	mov    (%eax),%eax
  8011cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d9:	01 d0                	add    %edx,%eax
  8011db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e1:	eb 0c                	jmp    8011ef <strsplit+0x31>
			*string++ = 0;
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	8d 50 01             	lea    0x1(%eax),%edx
  8011e9:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ec:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	84 c0                	test   %al,%al
  8011f6:	74 18                	je     801210 <strsplit+0x52>
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	0f be c0             	movsbl %al,%eax
  801200:	50                   	push   %eax
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	e8 13 fb ff ff       	call   800d1c <strchr>
  801209:	83 c4 08             	add    $0x8,%esp
  80120c:	85 c0                	test   %eax,%eax
  80120e:	75 d3                	jne    8011e3 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	84 c0                	test   %al,%al
  801217:	74 5a                	je     801273 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801219:	8b 45 14             	mov    0x14(%ebp),%eax
  80121c:	8b 00                	mov    (%eax),%eax
  80121e:	83 f8 0f             	cmp    $0xf,%eax
  801221:	75 07                	jne    80122a <strsplit+0x6c>
		{
			return 0;
  801223:	b8 00 00 00 00       	mov    $0x0,%eax
  801228:	eb 66                	jmp    801290 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80122a:	8b 45 14             	mov    0x14(%ebp),%eax
  80122d:	8b 00                	mov    (%eax),%eax
  80122f:	8d 48 01             	lea    0x1(%eax),%ecx
  801232:	8b 55 14             	mov    0x14(%ebp),%edx
  801235:	89 0a                	mov    %ecx,(%edx)
  801237:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80123e:	8b 45 10             	mov    0x10(%ebp),%eax
  801241:	01 c2                	add    %eax,%edx
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801248:	eb 03                	jmp    80124d <strsplit+0x8f>
			string++;
  80124a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	8a 00                	mov    (%eax),%al
  801252:	84 c0                	test   %al,%al
  801254:	74 8b                	je     8011e1 <strsplit+0x23>
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	0f be c0             	movsbl %al,%eax
  80125e:	50                   	push   %eax
  80125f:	ff 75 0c             	pushl  0xc(%ebp)
  801262:	e8 b5 fa ff ff       	call   800d1c <strchr>
  801267:	83 c4 08             	add    $0x8,%esp
  80126a:	85 c0                	test   %eax,%eax
  80126c:	74 dc                	je     80124a <strsplit+0x8c>
			string++;
	}
  80126e:	e9 6e ff ff ff       	jmp    8011e1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801273:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801274:	8b 45 14             	mov    0x14(%ebp),%eax
  801277:	8b 00                	mov    (%eax),%eax
  801279:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801280:	8b 45 10             	mov    0x10(%ebp),%eax
  801283:	01 d0                	add    %edx,%eax
  801285:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80128b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801290:	c9                   	leave  
  801291:	c3                   	ret    

00801292 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
  801295:	57                   	push   %edi
  801296:	56                   	push   %esi
  801297:	53                   	push   %ebx
  801298:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012a4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012a7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012aa:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012ad:	cd 30                	int    $0x30
  8012af:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b5:	83 c4 10             	add    $0x10,%esp
  8012b8:	5b                   	pop    %ebx
  8012b9:	5e                   	pop    %esi
  8012ba:	5f                   	pop    %edi
  8012bb:	5d                   	pop    %ebp
  8012bc:	c3                   	ret    

008012bd <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012bd:	55                   	push   %ebp
  8012be:	89 e5                	mov    %esp,%ebp
  8012c0:	83 ec 04             	sub    $0x4,%esp
  8012c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012c9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	52                   	push   %edx
  8012d5:	ff 75 0c             	pushl  0xc(%ebp)
  8012d8:	50                   	push   %eax
  8012d9:	6a 00                	push   $0x0
  8012db:	e8 b2 ff ff ff       	call   801292 <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	90                   	nop
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 01                	push   $0x1
  8012f5:	e8 98 ff ff ff       	call   801292 <syscall>
  8012fa:	83 c4 18             	add    $0x18,%esp
}
  8012fd:	c9                   	leave  
  8012fe:	c3                   	ret    

008012ff <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012ff:	55                   	push   %ebp
  801300:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	50                   	push   %eax
  80130e:	6a 05                	push   $0x5
  801310:	e8 7d ff ff ff       	call   801292 <syscall>
  801315:	83 c4 18             	add    $0x18,%esp
}
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 02                	push   $0x2
  801329:	e8 64 ff ff ff       	call   801292 <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	c9                   	leave  
  801332:	c3                   	ret    

00801333 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 03                	push   $0x3
  801342:	e8 4b ff ff ff       	call   801292 <syscall>
  801347:	83 c4 18             	add    $0x18,%esp
}
  80134a:	c9                   	leave  
  80134b:	c3                   	ret    

0080134c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	6a 00                	push   $0x0
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 04                	push   $0x4
  80135b:	e8 32 ff ff ff       	call   801292 <syscall>
  801360:	83 c4 18             	add    $0x18,%esp
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <sys_env_exit>:


void sys_env_exit(void)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 06                	push   $0x6
  801374:	e8 19 ff ff ff       	call   801292 <syscall>
  801379:	83 c4 18             	add    $0x18,%esp
}
  80137c:	90                   	nop
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801382:	8b 55 0c             	mov    0xc(%ebp),%edx
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	52                   	push   %edx
  80138f:	50                   	push   %eax
  801390:	6a 07                	push   $0x7
  801392:	e8 fb fe ff ff       	call   801292 <syscall>
  801397:	83 c4 18             	add    $0x18,%esp
}
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
  80139f:	56                   	push   %esi
  8013a0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013a1:	8b 75 18             	mov    0x18(%ebp),%esi
  8013a4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	56                   	push   %esi
  8013b1:	53                   	push   %ebx
  8013b2:	51                   	push   %ecx
  8013b3:	52                   	push   %edx
  8013b4:	50                   	push   %eax
  8013b5:	6a 08                	push   $0x8
  8013b7:	e8 d6 fe ff ff       	call   801292 <syscall>
  8013bc:	83 c4 18             	add    $0x18,%esp
}
  8013bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013c2:	5b                   	pop    %ebx
  8013c3:	5e                   	pop    %esi
  8013c4:	5d                   	pop    %ebp
  8013c5:	c3                   	ret    

008013c6 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	52                   	push   %edx
  8013d6:	50                   	push   %eax
  8013d7:	6a 09                	push   $0x9
  8013d9:	e8 b4 fe ff ff       	call   801292 <syscall>
  8013de:	83 c4 18             	add    $0x18,%esp
}
  8013e1:	c9                   	leave  
  8013e2:	c3                   	ret    

008013e3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013e3:	55                   	push   %ebp
  8013e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	ff 75 0c             	pushl  0xc(%ebp)
  8013ef:	ff 75 08             	pushl  0x8(%ebp)
  8013f2:	6a 0a                	push   $0xa
  8013f4:	e8 99 fe ff ff       	call   801292 <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 0b                	push   $0xb
  80140d:	e8 80 fe ff ff       	call   801292 <syscall>
  801412:	83 c4 18             	add    $0x18,%esp
}
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 0c                	push   $0xc
  801426:	e8 67 fe ff ff       	call   801292 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 0d                	push   $0xd
  80143f:	e8 4e fe ff ff       	call   801292 <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	ff 75 0c             	pushl  0xc(%ebp)
  801455:	ff 75 08             	pushl  0x8(%ebp)
  801458:	6a 11                	push   $0x11
  80145a:	e8 33 fe ff ff       	call   801292 <syscall>
  80145f:	83 c4 18             	add    $0x18,%esp
	return;
  801462:	90                   	nop
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	ff 75 0c             	pushl  0xc(%ebp)
  801471:	ff 75 08             	pushl  0x8(%ebp)
  801474:	6a 12                	push   $0x12
  801476:	e8 17 fe ff ff       	call   801292 <syscall>
  80147b:	83 c4 18             	add    $0x18,%esp
	return ;
  80147e:	90                   	nop
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 0e                	push   $0xe
  801490:	e8 fd fd ff ff       	call   801292 <syscall>
  801495:	83 c4 18             	add    $0x18,%esp
}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	ff 75 08             	pushl  0x8(%ebp)
  8014a8:	6a 0f                	push   $0xf
  8014aa:	e8 e3 fd ff ff       	call   801292 <syscall>
  8014af:	83 c4 18             	add    $0x18,%esp
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 10                	push   $0x10
  8014c3:	e8 ca fd ff ff       	call   801292 <syscall>
  8014c8:	83 c4 18             	add    $0x18,%esp
}
  8014cb:	90                   	nop
  8014cc:	c9                   	leave  
  8014cd:	c3                   	ret    

008014ce <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014ce:	55                   	push   %ebp
  8014cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 14                	push   $0x14
  8014dd:	e8 b0 fd ff ff       	call   801292 <syscall>
  8014e2:	83 c4 18             	add    $0x18,%esp
}
  8014e5:	90                   	nop
  8014e6:	c9                   	leave  
  8014e7:	c3                   	ret    

008014e8 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014e8:	55                   	push   %ebp
  8014e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 15                	push   $0x15
  8014f7:	e8 96 fd ff ff       	call   801292 <syscall>
  8014fc:	83 c4 18             	add    $0x18,%esp
}
  8014ff:	90                   	nop
  801500:	c9                   	leave  
  801501:	c3                   	ret    

00801502 <sys_cputc>:


void
sys_cputc(const char c)
{
  801502:	55                   	push   %ebp
  801503:	89 e5                	mov    %esp,%ebp
  801505:	83 ec 04             	sub    $0x4,%esp
  801508:	8b 45 08             	mov    0x8(%ebp),%eax
  80150b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80150e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	50                   	push   %eax
  80151b:	6a 16                	push   $0x16
  80151d:	e8 70 fd ff ff       	call   801292 <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	90                   	nop
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 17                	push   $0x17
  801537:	e8 56 fd ff ff       	call   801292 <syscall>
  80153c:	83 c4 18             	add    $0x18,%esp
}
  80153f:	90                   	nop
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	ff 75 0c             	pushl  0xc(%ebp)
  801551:	50                   	push   %eax
  801552:	6a 18                	push   $0x18
  801554:	e8 39 fd ff ff       	call   801292 <syscall>
  801559:	83 c4 18             	add    $0x18,%esp
}
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801561:	8b 55 0c             	mov    0xc(%ebp),%edx
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	52                   	push   %edx
  80156e:	50                   	push   %eax
  80156f:	6a 1b                	push   $0x1b
  801571:	e8 1c fd ff ff       	call   801292 <syscall>
  801576:	83 c4 18             	add    $0x18,%esp
}
  801579:	c9                   	leave  
  80157a:	c3                   	ret    

0080157b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80157e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	52                   	push   %edx
  80158b:	50                   	push   %eax
  80158c:	6a 19                	push   $0x19
  80158e:	e8 ff fc ff ff       	call   801292 <syscall>
  801593:	83 c4 18             	add    $0x18,%esp
}
  801596:	90                   	nop
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80159c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	52                   	push   %edx
  8015a9:	50                   	push   %eax
  8015aa:	6a 1a                	push   $0x1a
  8015ac:	e8 e1 fc ff ff       	call   801292 <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	90                   	nop
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
  8015ba:	83 ec 04             	sub    $0x4,%esp
  8015bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015c3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015c6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	6a 00                	push   $0x0
  8015cf:	51                   	push   %ecx
  8015d0:	52                   	push   %edx
  8015d1:	ff 75 0c             	pushl  0xc(%ebp)
  8015d4:	50                   	push   %eax
  8015d5:	6a 1c                	push   $0x1c
  8015d7:	e8 b6 fc ff ff       	call   801292 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	52                   	push   %edx
  8015f1:	50                   	push   %eax
  8015f2:	6a 1d                	push   $0x1d
  8015f4:	e8 99 fc ff ff       	call   801292 <syscall>
  8015f9:	83 c4 18             	add    $0x18,%esp
}
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801601:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801604:	8b 55 0c             	mov    0xc(%ebp),%edx
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	51                   	push   %ecx
  80160f:	52                   	push   %edx
  801610:	50                   	push   %eax
  801611:	6a 1e                	push   $0x1e
  801613:	e8 7a fc ff ff       	call   801292 <syscall>
  801618:	83 c4 18             	add    $0x18,%esp
}
  80161b:	c9                   	leave  
  80161c:	c3                   	ret    

0080161d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801620:	8b 55 0c             	mov    0xc(%ebp),%edx
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	52                   	push   %edx
  80162d:	50                   	push   %eax
  80162e:	6a 1f                	push   $0x1f
  801630:	e8 5d fc ff ff       	call   801292 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 20                	push   $0x20
  801649:	e8 44 fc ff ff       	call   801292 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	c9                   	leave  
  801652:	c3                   	ret    

00801653 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801653:	55                   	push   %ebp
  801654:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	ff 75 10             	pushl  0x10(%ebp)
  801660:	ff 75 0c             	pushl  0xc(%ebp)
  801663:	50                   	push   %eax
  801664:	6a 21                	push   $0x21
  801666:	e8 27 fc ff ff       	call   801292 <syscall>
  80166b:	83 c4 18             	add    $0x18,%esp
}
  80166e:	c9                   	leave  
  80166f:	c3                   	ret    

00801670 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801670:	55                   	push   %ebp
  801671:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	50                   	push   %eax
  80167f:	6a 22                	push   $0x22
  801681:	e8 0c fc ff ff       	call   801292 <syscall>
  801686:	83 c4 18             	add    $0x18,%esp
}
  801689:	90                   	nop
  80168a:	c9                   	leave  
  80168b:	c3                   	ret    

0080168c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	50                   	push   %eax
  80169b:	6a 23                	push   $0x23
  80169d:	e8 f0 fb ff ff       	call   801292 <syscall>
  8016a2:	83 c4 18             	add    $0x18,%esp
}
  8016a5:	90                   	nop
  8016a6:	c9                   	leave  
  8016a7:	c3                   	ret    

008016a8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016a8:	55                   	push   %ebp
  8016a9:	89 e5                	mov    %esp,%ebp
  8016ab:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016ae:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b1:	8d 50 04             	lea    0x4(%eax),%edx
  8016b4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	52                   	push   %edx
  8016be:	50                   	push   %eax
  8016bf:	6a 24                	push   $0x24
  8016c1:	e8 cc fb ff ff       	call   801292 <syscall>
  8016c6:	83 c4 18             	add    $0x18,%esp
	return result;
  8016c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d2:	89 01                	mov    %eax,(%ecx)
  8016d4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	c9                   	leave  
  8016db:	c2 04 00             	ret    $0x4

008016de <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	ff 75 10             	pushl  0x10(%ebp)
  8016e8:	ff 75 0c             	pushl  0xc(%ebp)
  8016eb:	ff 75 08             	pushl  0x8(%ebp)
  8016ee:	6a 13                	push   $0x13
  8016f0:	e8 9d fb ff ff       	call   801292 <syscall>
  8016f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f8:	90                   	nop
}
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <sys_rcr2>:
uint32 sys_rcr2()
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 25                	push   $0x25
  80170a:	e8 83 fb ff ff       	call   801292 <syscall>
  80170f:	83 c4 18             	add    $0x18,%esp
}
  801712:	c9                   	leave  
  801713:	c3                   	ret    

00801714 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
  801717:	83 ec 04             	sub    $0x4,%esp
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801720:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	50                   	push   %eax
  80172d:	6a 26                	push   $0x26
  80172f:	e8 5e fb ff ff       	call   801292 <syscall>
  801734:	83 c4 18             	add    $0x18,%esp
	return ;
  801737:	90                   	nop
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <rsttst>:
void rsttst()
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 28                	push   $0x28
  801749:	e8 44 fb ff ff       	call   801292 <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
	return ;
  801751:	90                   	nop
}
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
  801757:	83 ec 04             	sub    $0x4,%esp
  80175a:	8b 45 14             	mov    0x14(%ebp),%eax
  80175d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801760:	8b 55 18             	mov    0x18(%ebp),%edx
  801763:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801767:	52                   	push   %edx
  801768:	50                   	push   %eax
  801769:	ff 75 10             	pushl  0x10(%ebp)
  80176c:	ff 75 0c             	pushl  0xc(%ebp)
  80176f:	ff 75 08             	pushl  0x8(%ebp)
  801772:	6a 27                	push   $0x27
  801774:	e8 19 fb ff ff       	call   801292 <syscall>
  801779:	83 c4 18             	add    $0x18,%esp
	return ;
  80177c:	90                   	nop
}
  80177d:	c9                   	leave  
  80177e:	c3                   	ret    

0080177f <chktst>:
void chktst(uint32 n)
{
  80177f:	55                   	push   %ebp
  801780:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	ff 75 08             	pushl  0x8(%ebp)
  80178d:	6a 29                	push   $0x29
  80178f:	e8 fe fa ff ff       	call   801292 <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
	return ;
  801797:	90                   	nop
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <inctst>:

void inctst()
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 2a                	push   $0x2a
  8017a9:	e8 e4 fa ff ff       	call   801292 <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b1:	90                   	nop
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <gettst>:
uint32 gettst()
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 2b                	push   $0x2b
  8017c3:	e8 ca fa ff ff       	call   801292 <syscall>
  8017c8:	83 c4 18             	add    $0x18,%esp
}
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
  8017d0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 2c                	push   $0x2c
  8017df:	e8 ae fa ff ff       	call   801292 <syscall>
  8017e4:	83 c4 18             	add    $0x18,%esp
  8017e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017ea:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017ee:	75 07                	jne    8017f7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017f0:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f5:	eb 05                	jmp    8017fc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017fc:	c9                   	leave  
  8017fd:	c3                   	ret    

008017fe <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
  801801:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 2c                	push   $0x2c
  801810:	e8 7d fa ff ff       	call   801292 <syscall>
  801815:	83 c4 18             	add    $0x18,%esp
  801818:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80181b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80181f:	75 07                	jne    801828 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801821:	b8 01 00 00 00       	mov    $0x1,%eax
  801826:	eb 05                	jmp    80182d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801828:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80182d:	c9                   	leave  
  80182e:	c3                   	ret    

0080182f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80182f:	55                   	push   %ebp
  801830:	89 e5                	mov    %esp,%ebp
  801832:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 2c                	push   $0x2c
  801841:	e8 4c fa ff ff       	call   801292 <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
  801849:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80184c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801850:	75 07                	jne    801859 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801852:	b8 01 00 00 00       	mov    $0x1,%eax
  801857:	eb 05                	jmp    80185e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801859:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185e:	c9                   	leave  
  80185f:	c3                   	ret    

00801860 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801860:	55                   	push   %ebp
  801861:	89 e5                	mov    %esp,%ebp
  801863:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 2c                	push   $0x2c
  801872:	e8 1b fa ff ff       	call   801292 <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
  80187a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80187d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801881:	75 07                	jne    80188a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801883:	b8 01 00 00 00       	mov    $0x1,%eax
  801888:	eb 05                	jmp    80188f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80188a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	ff 75 08             	pushl  0x8(%ebp)
  80189f:	6a 2d                	push   $0x2d
  8018a1:	e8 ec f9 ff ff       	call   801292 <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a9:	90                   	nop
}
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
  8018af:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018b2:	8b 55 08             	mov    0x8(%ebp),%edx
  8018b5:	89 d0                	mov    %edx,%eax
  8018b7:	c1 e0 02             	shl    $0x2,%eax
  8018ba:	01 d0                	add    %edx,%eax
  8018bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c3:	01 d0                	add    %edx,%eax
  8018c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018cc:	01 d0                	add    %edx,%eax
  8018ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d5:	01 d0                	add    %edx,%eax
  8018d7:	c1 e0 04             	shl    $0x4,%eax
  8018da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018e4:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018e7:	83 ec 0c             	sub    $0xc,%esp
  8018ea:	50                   	push   %eax
  8018eb:	e8 b8 fd ff ff       	call   8016a8 <sys_get_virtual_time>
  8018f0:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018f3:	eb 41                	jmp    801936 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018f5:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018f8:	83 ec 0c             	sub    $0xc,%esp
  8018fb:	50                   	push   %eax
  8018fc:	e8 a7 fd ff ff       	call   8016a8 <sys_get_virtual_time>
  801901:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801904:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801907:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80190a:	29 c2                	sub    %eax,%edx
  80190c:	89 d0                	mov    %edx,%eax
  80190e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801911:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801914:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801917:	89 d1                	mov    %edx,%ecx
  801919:	29 c1                	sub    %eax,%ecx
  80191b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80191e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801921:	39 c2                	cmp    %eax,%edx
  801923:	0f 97 c0             	seta   %al
  801926:	0f b6 c0             	movzbl %al,%eax
  801929:	29 c1                	sub    %eax,%ecx
  80192b:	89 c8                	mov    %ecx,%eax
  80192d:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801930:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801933:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801936:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801939:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80193c:	72 b7                	jb     8018f5 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80193e:	90                   	nop
  80193f:	c9                   	leave  
  801940:	c3                   	ret    

00801941 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801941:	55                   	push   %ebp
  801942:	89 e5                	mov    %esp,%ebp
  801944:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801947:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80194e:	eb 03                	jmp    801953 <busy_wait+0x12>
  801950:	ff 45 fc             	incl   -0x4(%ebp)
  801953:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801956:	3b 45 08             	cmp    0x8(%ebp),%eax
  801959:	72 f5                	jb     801950 <busy_wait+0xf>
	return i;
  80195b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <__udivdi3>:
  801960:	55                   	push   %ebp
  801961:	57                   	push   %edi
  801962:	56                   	push   %esi
  801963:	53                   	push   %ebx
  801964:	83 ec 1c             	sub    $0x1c,%esp
  801967:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80196b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80196f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801973:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801977:	89 ca                	mov    %ecx,%edx
  801979:	89 f8                	mov    %edi,%eax
  80197b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80197f:	85 f6                	test   %esi,%esi
  801981:	75 2d                	jne    8019b0 <__udivdi3+0x50>
  801983:	39 cf                	cmp    %ecx,%edi
  801985:	77 65                	ja     8019ec <__udivdi3+0x8c>
  801987:	89 fd                	mov    %edi,%ebp
  801989:	85 ff                	test   %edi,%edi
  80198b:	75 0b                	jne    801998 <__udivdi3+0x38>
  80198d:	b8 01 00 00 00       	mov    $0x1,%eax
  801992:	31 d2                	xor    %edx,%edx
  801994:	f7 f7                	div    %edi
  801996:	89 c5                	mov    %eax,%ebp
  801998:	31 d2                	xor    %edx,%edx
  80199a:	89 c8                	mov    %ecx,%eax
  80199c:	f7 f5                	div    %ebp
  80199e:	89 c1                	mov    %eax,%ecx
  8019a0:	89 d8                	mov    %ebx,%eax
  8019a2:	f7 f5                	div    %ebp
  8019a4:	89 cf                	mov    %ecx,%edi
  8019a6:	89 fa                	mov    %edi,%edx
  8019a8:	83 c4 1c             	add    $0x1c,%esp
  8019ab:	5b                   	pop    %ebx
  8019ac:	5e                   	pop    %esi
  8019ad:	5f                   	pop    %edi
  8019ae:	5d                   	pop    %ebp
  8019af:	c3                   	ret    
  8019b0:	39 ce                	cmp    %ecx,%esi
  8019b2:	77 28                	ja     8019dc <__udivdi3+0x7c>
  8019b4:	0f bd fe             	bsr    %esi,%edi
  8019b7:	83 f7 1f             	xor    $0x1f,%edi
  8019ba:	75 40                	jne    8019fc <__udivdi3+0x9c>
  8019bc:	39 ce                	cmp    %ecx,%esi
  8019be:	72 0a                	jb     8019ca <__udivdi3+0x6a>
  8019c0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019c4:	0f 87 9e 00 00 00    	ja     801a68 <__udivdi3+0x108>
  8019ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8019cf:	89 fa                	mov    %edi,%edx
  8019d1:	83 c4 1c             	add    $0x1c,%esp
  8019d4:	5b                   	pop    %ebx
  8019d5:	5e                   	pop    %esi
  8019d6:	5f                   	pop    %edi
  8019d7:	5d                   	pop    %ebp
  8019d8:	c3                   	ret    
  8019d9:	8d 76 00             	lea    0x0(%esi),%esi
  8019dc:	31 ff                	xor    %edi,%edi
  8019de:	31 c0                	xor    %eax,%eax
  8019e0:	89 fa                	mov    %edi,%edx
  8019e2:	83 c4 1c             	add    $0x1c,%esp
  8019e5:	5b                   	pop    %ebx
  8019e6:	5e                   	pop    %esi
  8019e7:	5f                   	pop    %edi
  8019e8:	5d                   	pop    %ebp
  8019e9:	c3                   	ret    
  8019ea:	66 90                	xchg   %ax,%ax
  8019ec:	89 d8                	mov    %ebx,%eax
  8019ee:	f7 f7                	div    %edi
  8019f0:	31 ff                	xor    %edi,%edi
  8019f2:	89 fa                	mov    %edi,%edx
  8019f4:	83 c4 1c             	add    $0x1c,%esp
  8019f7:	5b                   	pop    %ebx
  8019f8:	5e                   	pop    %esi
  8019f9:	5f                   	pop    %edi
  8019fa:	5d                   	pop    %ebp
  8019fb:	c3                   	ret    
  8019fc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a01:	89 eb                	mov    %ebp,%ebx
  801a03:	29 fb                	sub    %edi,%ebx
  801a05:	89 f9                	mov    %edi,%ecx
  801a07:	d3 e6                	shl    %cl,%esi
  801a09:	89 c5                	mov    %eax,%ebp
  801a0b:	88 d9                	mov    %bl,%cl
  801a0d:	d3 ed                	shr    %cl,%ebp
  801a0f:	89 e9                	mov    %ebp,%ecx
  801a11:	09 f1                	or     %esi,%ecx
  801a13:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a17:	89 f9                	mov    %edi,%ecx
  801a19:	d3 e0                	shl    %cl,%eax
  801a1b:	89 c5                	mov    %eax,%ebp
  801a1d:	89 d6                	mov    %edx,%esi
  801a1f:	88 d9                	mov    %bl,%cl
  801a21:	d3 ee                	shr    %cl,%esi
  801a23:	89 f9                	mov    %edi,%ecx
  801a25:	d3 e2                	shl    %cl,%edx
  801a27:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a2b:	88 d9                	mov    %bl,%cl
  801a2d:	d3 e8                	shr    %cl,%eax
  801a2f:	09 c2                	or     %eax,%edx
  801a31:	89 d0                	mov    %edx,%eax
  801a33:	89 f2                	mov    %esi,%edx
  801a35:	f7 74 24 0c          	divl   0xc(%esp)
  801a39:	89 d6                	mov    %edx,%esi
  801a3b:	89 c3                	mov    %eax,%ebx
  801a3d:	f7 e5                	mul    %ebp
  801a3f:	39 d6                	cmp    %edx,%esi
  801a41:	72 19                	jb     801a5c <__udivdi3+0xfc>
  801a43:	74 0b                	je     801a50 <__udivdi3+0xf0>
  801a45:	89 d8                	mov    %ebx,%eax
  801a47:	31 ff                	xor    %edi,%edi
  801a49:	e9 58 ff ff ff       	jmp    8019a6 <__udivdi3+0x46>
  801a4e:	66 90                	xchg   %ax,%ax
  801a50:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a54:	89 f9                	mov    %edi,%ecx
  801a56:	d3 e2                	shl    %cl,%edx
  801a58:	39 c2                	cmp    %eax,%edx
  801a5a:	73 e9                	jae    801a45 <__udivdi3+0xe5>
  801a5c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a5f:	31 ff                	xor    %edi,%edi
  801a61:	e9 40 ff ff ff       	jmp    8019a6 <__udivdi3+0x46>
  801a66:	66 90                	xchg   %ax,%ax
  801a68:	31 c0                	xor    %eax,%eax
  801a6a:	e9 37 ff ff ff       	jmp    8019a6 <__udivdi3+0x46>
  801a6f:	90                   	nop

00801a70 <__umoddi3>:
  801a70:	55                   	push   %ebp
  801a71:	57                   	push   %edi
  801a72:	56                   	push   %esi
  801a73:	53                   	push   %ebx
  801a74:	83 ec 1c             	sub    $0x1c,%esp
  801a77:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a7b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a7f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a83:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a87:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a8b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a8f:	89 f3                	mov    %esi,%ebx
  801a91:	89 fa                	mov    %edi,%edx
  801a93:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a97:	89 34 24             	mov    %esi,(%esp)
  801a9a:	85 c0                	test   %eax,%eax
  801a9c:	75 1a                	jne    801ab8 <__umoddi3+0x48>
  801a9e:	39 f7                	cmp    %esi,%edi
  801aa0:	0f 86 a2 00 00 00    	jbe    801b48 <__umoddi3+0xd8>
  801aa6:	89 c8                	mov    %ecx,%eax
  801aa8:	89 f2                	mov    %esi,%edx
  801aaa:	f7 f7                	div    %edi
  801aac:	89 d0                	mov    %edx,%eax
  801aae:	31 d2                	xor    %edx,%edx
  801ab0:	83 c4 1c             	add    $0x1c,%esp
  801ab3:	5b                   	pop    %ebx
  801ab4:	5e                   	pop    %esi
  801ab5:	5f                   	pop    %edi
  801ab6:	5d                   	pop    %ebp
  801ab7:	c3                   	ret    
  801ab8:	39 f0                	cmp    %esi,%eax
  801aba:	0f 87 ac 00 00 00    	ja     801b6c <__umoddi3+0xfc>
  801ac0:	0f bd e8             	bsr    %eax,%ebp
  801ac3:	83 f5 1f             	xor    $0x1f,%ebp
  801ac6:	0f 84 ac 00 00 00    	je     801b78 <__umoddi3+0x108>
  801acc:	bf 20 00 00 00       	mov    $0x20,%edi
  801ad1:	29 ef                	sub    %ebp,%edi
  801ad3:	89 fe                	mov    %edi,%esi
  801ad5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ad9:	89 e9                	mov    %ebp,%ecx
  801adb:	d3 e0                	shl    %cl,%eax
  801add:	89 d7                	mov    %edx,%edi
  801adf:	89 f1                	mov    %esi,%ecx
  801ae1:	d3 ef                	shr    %cl,%edi
  801ae3:	09 c7                	or     %eax,%edi
  801ae5:	89 e9                	mov    %ebp,%ecx
  801ae7:	d3 e2                	shl    %cl,%edx
  801ae9:	89 14 24             	mov    %edx,(%esp)
  801aec:	89 d8                	mov    %ebx,%eax
  801aee:	d3 e0                	shl    %cl,%eax
  801af0:	89 c2                	mov    %eax,%edx
  801af2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801af6:	d3 e0                	shl    %cl,%eax
  801af8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801afc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b00:	89 f1                	mov    %esi,%ecx
  801b02:	d3 e8                	shr    %cl,%eax
  801b04:	09 d0                	or     %edx,%eax
  801b06:	d3 eb                	shr    %cl,%ebx
  801b08:	89 da                	mov    %ebx,%edx
  801b0a:	f7 f7                	div    %edi
  801b0c:	89 d3                	mov    %edx,%ebx
  801b0e:	f7 24 24             	mull   (%esp)
  801b11:	89 c6                	mov    %eax,%esi
  801b13:	89 d1                	mov    %edx,%ecx
  801b15:	39 d3                	cmp    %edx,%ebx
  801b17:	0f 82 87 00 00 00    	jb     801ba4 <__umoddi3+0x134>
  801b1d:	0f 84 91 00 00 00    	je     801bb4 <__umoddi3+0x144>
  801b23:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b27:	29 f2                	sub    %esi,%edx
  801b29:	19 cb                	sbb    %ecx,%ebx
  801b2b:	89 d8                	mov    %ebx,%eax
  801b2d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b31:	d3 e0                	shl    %cl,%eax
  801b33:	89 e9                	mov    %ebp,%ecx
  801b35:	d3 ea                	shr    %cl,%edx
  801b37:	09 d0                	or     %edx,%eax
  801b39:	89 e9                	mov    %ebp,%ecx
  801b3b:	d3 eb                	shr    %cl,%ebx
  801b3d:	89 da                	mov    %ebx,%edx
  801b3f:	83 c4 1c             	add    $0x1c,%esp
  801b42:	5b                   	pop    %ebx
  801b43:	5e                   	pop    %esi
  801b44:	5f                   	pop    %edi
  801b45:	5d                   	pop    %ebp
  801b46:	c3                   	ret    
  801b47:	90                   	nop
  801b48:	89 fd                	mov    %edi,%ebp
  801b4a:	85 ff                	test   %edi,%edi
  801b4c:	75 0b                	jne    801b59 <__umoddi3+0xe9>
  801b4e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b53:	31 d2                	xor    %edx,%edx
  801b55:	f7 f7                	div    %edi
  801b57:	89 c5                	mov    %eax,%ebp
  801b59:	89 f0                	mov    %esi,%eax
  801b5b:	31 d2                	xor    %edx,%edx
  801b5d:	f7 f5                	div    %ebp
  801b5f:	89 c8                	mov    %ecx,%eax
  801b61:	f7 f5                	div    %ebp
  801b63:	89 d0                	mov    %edx,%eax
  801b65:	e9 44 ff ff ff       	jmp    801aae <__umoddi3+0x3e>
  801b6a:	66 90                	xchg   %ax,%ax
  801b6c:	89 c8                	mov    %ecx,%eax
  801b6e:	89 f2                	mov    %esi,%edx
  801b70:	83 c4 1c             	add    $0x1c,%esp
  801b73:	5b                   	pop    %ebx
  801b74:	5e                   	pop    %esi
  801b75:	5f                   	pop    %edi
  801b76:	5d                   	pop    %ebp
  801b77:	c3                   	ret    
  801b78:	3b 04 24             	cmp    (%esp),%eax
  801b7b:	72 06                	jb     801b83 <__umoddi3+0x113>
  801b7d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b81:	77 0f                	ja     801b92 <__umoddi3+0x122>
  801b83:	89 f2                	mov    %esi,%edx
  801b85:	29 f9                	sub    %edi,%ecx
  801b87:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b8b:	89 14 24             	mov    %edx,(%esp)
  801b8e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b92:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b96:	8b 14 24             	mov    (%esp),%edx
  801b99:	83 c4 1c             	add    $0x1c,%esp
  801b9c:	5b                   	pop    %ebx
  801b9d:	5e                   	pop    %esi
  801b9e:	5f                   	pop    %edi
  801b9f:	5d                   	pop    %ebp
  801ba0:	c3                   	ret    
  801ba1:	8d 76 00             	lea    0x0(%esi),%esi
  801ba4:	2b 04 24             	sub    (%esp),%eax
  801ba7:	19 fa                	sbb    %edi,%edx
  801ba9:	89 d1                	mov    %edx,%ecx
  801bab:	89 c6                	mov    %eax,%esi
  801bad:	e9 71 ff ff ff       	jmp    801b23 <__umoddi3+0xb3>
  801bb2:	66 90                	xchg   %ax,%ax
  801bb4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bb8:	72 ea                	jb     801ba4 <__umoddi3+0x134>
  801bba:	89 d9                	mov    %ebx,%ecx
  801bbc:	e9 62 ff ff ff       	jmp    801b23 <__umoddi3+0xb3>
