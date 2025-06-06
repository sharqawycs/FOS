
obj/user/tst_envfree1:     file format elf32-i386


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
  800031:	e8 3c 01 00 00       	call   800172 <libmain>
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
	// Testing scenario 1: without using dynamic allocation/de-allocation, shared variables and semaphores
	// Testing removing the allocated pages in mem, WS, mapped page tables, env's directory and env's page file

	int freeFrames_before = sys_calculate_free_frames() ;
  80003e:	e8 db 13 00 00       	call   80141e <sys_calculate_free_frames>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800046:	e8 56 14 00 00       	call   8014a1 <sys_pf_calculate_allocated_pages>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f4             	pushl  -0xc(%ebp)
  800054:	68 00 1c 80 00       	push   $0x801c00
  800059:	e8 ca 04 00 00       	call   800528 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	/*[4] CREATE AND RUN ProcessA & ProcessB*/
	//Create 3 processes
	int32 envIdProcessA = sys_create_env("ef_fib", 5, 50);
  800061:	83 ec 04             	sub    $0x4,%esp
  800064:	6a 32                	push   $0x32
  800066:	6a 05                	push   $0x5
  800068:	68 33 1c 80 00       	push   $0x801c33
  80006d:	e8 01 16 00 00       	call   801673 <sys_create_env>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int32 envIdProcessB = sys_create_env("ef_fact", 4, 50);
  800078:	83 ec 04             	sub    $0x4,%esp
  80007b:	6a 32                	push   $0x32
  80007d:	6a 04                	push   $0x4
  80007f:	68 3a 1c 80 00       	push   $0x801c3a
  800084:	e8 ea 15 00 00       	call   801673 <sys_create_env>
  800089:	83 c4 10             	add    $0x10,%esp
  80008c:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 envIdProcessC = sys_create_env("ef_fos_add", 30, 50);
  80008f:	83 ec 04             	sub    $0x4,%esp
  800092:	6a 32                	push   $0x32
  800094:	6a 1e                	push   $0x1e
  800096:	68 42 1c 80 00       	push   $0x801c42
  80009b:	e8 d3 15 00 00       	call   801673 <sys_create_env>
  8000a0:	83 c4 10             	add    $0x10,%esp
  8000a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Run 3 processes
	sys_run_env(envIdProcessA);
  8000a6:	83 ec 0c             	sub    $0xc,%esp
  8000a9:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ac:	e8 df 15 00 00       	call   801690 <sys_run_env>
  8000b1:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000b4:	83 ec 0c             	sub    $0xc,%esp
  8000b7:	ff 75 e8             	pushl  -0x18(%ebp)
  8000ba:	e8 d1 15 00 00       	call   801690 <sys_run_env>
  8000bf:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessC);
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000c8:	e8 c3 15 00 00       	call   801690 <sys_run_env>
  8000cd:	83 c4 10             	add    $0x10,%esp

	env_sleep(6000);
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 70 17 00 00       	push   $0x1770
  8000d8:	e8 ef 17 00 00       	call   8018cc <env_sleep>
  8000dd:	83 c4 10             	add    $0x10,%esp
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000e0:	e8 39 13 00 00       	call   80141e <sys_calculate_free_frames>
  8000e5:	83 ec 08             	sub    $0x8,%esp
  8000e8:	50                   	push   %eax
  8000e9:	68 50 1c 80 00       	push   $0x801c50
  8000ee:	e8 35 04 00 00       	call   800528 <cprintf>
  8000f3:	83 c4 10             	add    $0x10,%esp

	//Kill the 3 processes
	sys_free_env(envIdProcessA);
  8000f6:	83 ec 0c             	sub    $0xc,%esp
  8000f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8000fc:	e8 ab 15 00 00       	call   8016ac <sys_free_env>
  800101:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	ff 75 e8             	pushl  -0x18(%ebp)
  80010a:	e8 9d 15 00 00       	call   8016ac <sys_free_env>
  80010f:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessC);
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	ff 75 e4             	pushl  -0x1c(%ebp)
  800118:	e8 8f 15 00 00       	call   8016ac <sys_free_env>
  80011d:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  800120:	e8 f9 12 00 00       	call   80141e <sys_calculate_free_frames>
  800125:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  800128:	e8 74 13 00 00       	call   8014a1 <sys_pf_calculate_allocated_pages>
  80012d:	89 45 dc             	mov    %eax,-0x24(%ebp)

	if((freeFrames_after - freeFrames_before) !=0)
  800130:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800133:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800136:	74 14                	je     80014c <_main+0x114>
		panic("env_free() does not work correctly... check it again.") ;
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 84 1c 80 00       	push   $0x801c84
  800140:	6a 25                	push   $0x25
  800142:	68 ba 1c 80 00       	push   $0x801cba
  800147:	e8 28 01 00 00       	call   800274 <_panic>

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80014c:	83 ec 08             	sub    $0x8,%esp
  80014f:	ff 75 e0             	pushl  -0x20(%ebp)
  800152:	68 d0 1c 80 00       	push   $0x801cd0
  800157:	e8 cc 03 00 00       	call   800528 <cprintf>
  80015c:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 1 for envfree completed successfully.\n");
  80015f:	83 ec 0c             	sub    $0xc,%esp
  800162:	68 30 1d 80 00       	push   $0x801d30
  800167:	e8 bc 03 00 00       	call   800528 <cprintf>
  80016c:	83 c4 10             	add    $0x10,%esp
	return;
  80016f:	90                   	nop
}
  800170:	c9                   	leave  
  800171:	c3                   	ret    

00800172 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800172:	55                   	push   %ebp
  800173:	89 e5                	mov    %esp,%ebp
  800175:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800178:	e8 d6 11 00 00       	call   801353 <sys_getenvindex>
  80017d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800180:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800183:	89 d0                	mov    %edx,%eax
  800185:	01 c0                	add    %eax,%eax
  800187:	01 d0                	add    %edx,%eax
  800189:	c1 e0 02             	shl    $0x2,%eax
  80018c:	01 d0                	add    %edx,%eax
  80018e:	c1 e0 06             	shl    $0x6,%eax
  800191:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800196:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80019b:	a1 04 30 80 00       	mov    0x803004,%eax
  8001a0:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8001a6:	84 c0                	test   %al,%al
  8001a8:	74 0f                	je     8001b9 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8001aa:	a1 04 30 80 00       	mov    0x803004,%eax
  8001af:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001b4:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001b9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001bd:	7e 0a                	jle    8001c9 <libmain+0x57>
		binaryname = argv[0];
  8001bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c2:	8b 00                	mov    (%eax),%eax
  8001c4:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001c9:	83 ec 08             	sub    $0x8,%esp
  8001cc:	ff 75 0c             	pushl  0xc(%ebp)
  8001cf:	ff 75 08             	pushl  0x8(%ebp)
  8001d2:	e8 61 fe ff ff       	call   800038 <_main>
  8001d7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001da:	e8 0f 13 00 00       	call   8014ee <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001df:	83 ec 0c             	sub    $0xc,%esp
  8001e2:	68 94 1d 80 00       	push   $0x801d94
  8001e7:	e8 3c 03 00 00       	call   800528 <cprintf>
  8001ec:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001ef:	a1 04 30 80 00       	mov    0x803004,%eax
  8001f4:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001fa:	a1 04 30 80 00       	mov    0x803004,%eax
  8001ff:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800205:	83 ec 04             	sub    $0x4,%esp
  800208:	52                   	push   %edx
  800209:	50                   	push   %eax
  80020a:	68 bc 1d 80 00       	push   $0x801dbc
  80020f:	e8 14 03 00 00       	call   800528 <cprintf>
  800214:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800217:	a1 04 30 80 00       	mov    0x803004,%eax
  80021c:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800222:	83 ec 08             	sub    $0x8,%esp
  800225:	50                   	push   %eax
  800226:	68 e1 1d 80 00       	push   $0x801de1
  80022b:	e8 f8 02 00 00       	call   800528 <cprintf>
  800230:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800233:	83 ec 0c             	sub    $0xc,%esp
  800236:	68 94 1d 80 00       	push   $0x801d94
  80023b:	e8 e8 02 00 00       	call   800528 <cprintf>
  800240:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800243:	e8 c0 12 00 00       	call   801508 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800248:	e8 19 00 00 00       	call   800266 <exit>
}
  80024d:	90                   	nop
  80024e:	c9                   	leave  
  80024f:	c3                   	ret    

00800250 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800250:	55                   	push   %ebp
  800251:	89 e5                	mov    %esp,%ebp
  800253:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800256:	83 ec 0c             	sub    $0xc,%esp
  800259:	6a 00                	push   $0x0
  80025b:	e8 bf 10 00 00       	call   80131f <sys_env_destroy>
  800260:	83 c4 10             	add    $0x10,%esp
}
  800263:	90                   	nop
  800264:	c9                   	leave  
  800265:	c3                   	ret    

00800266 <exit>:

void
exit(void)
{
  800266:	55                   	push   %ebp
  800267:	89 e5                	mov    %esp,%ebp
  800269:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80026c:	e8 14 11 00 00       	call   801385 <sys_env_exit>
}
  800271:	90                   	nop
  800272:	c9                   	leave  
  800273:	c3                   	ret    

00800274 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800274:	55                   	push   %ebp
  800275:	89 e5                	mov    %esp,%ebp
  800277:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80027a:	8d 45 10             	lea    0x10(%ebp),%eax
  80027d:	83 c0 04             	add    $0x4,%eax
  800280:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800283:	a1 14 30 80 00       	mov    0x803014,%eax
  800288:	85 c0                	test   %eax,%eax
  80028a:	74 16                	je     8002a2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80028c:	a1 14 30 80 00       	mov    0x803014,%eax
  800291:	83 ec 08             	sub    $0x8,%esp
  800294:	50                   	push   %eax
  800295:	68 f8 1d 80 00       	push   $0x801df8
  80029a:	e8 89 02 00 00       	call   800528 <cprintf>
  80029f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002a2:	a1 00 30 80 00       	mov    0x803000,%eax
  8002a7:	ff 75 0c             	pushl  0xc(%ebp)
  8002aa:	ff 75 08             	pushl  0x8(%ebp)
  8002ad:	50                   	push   %eax
  8002ae:	68 fd 1d 80 00       	push   $0x801dfd
  8002b3:	e8 70 02 00 00       	call   800528 <cprintf>
  8002b8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8002be:	83 ec 08             	sub    $0x8,%esp
  8002c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c4:	50                   	push   %eax
  8002c5:	e8 f3 01 00 00       	call   8004bd <vcprintf>
  8002ca:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002cd:	83 ec 08             	sub    $0x8,%esp
  8002d0:	6a 00                	push   $0x0
  8002d2:	68 19 1e 80 00       	push   $0x801e19
  8002d7:	e8 e1 01 00 00       	call   8004bd <vcprintf>
  8002dc:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002df:	e8 82 ff ff ff       	call   800266 <exit>

	// should not return here
	while (1) ;
  8002e4:	eb fe                	jmp    8002e4 <_panic+0x70>

008002e6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002e6:	55                   	push   %ebp
  8002e7:	89 e5                	mov    %esp,%ebp
  8002e9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002ec:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f1:	8b 50 74             	mov    0x74(%eax),%edx
  8002f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f7:	39 c2                	cmp    %eax,%edx
  8002f9:	74 14                	je     80030f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002fb:	83 ec 04             	sub    $0x4,%esp
  8002fe:	68 1c 1e 80 00       	push   $0x801e1c
  800303:	6a 26                	push   $0x26
  800305:	68 68 1e 80 00       	push   $0x801e68
  80030a:	e8 65 ff ff ff       	call   800274 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80030f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800316:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80031d:	e9 c2 00 00 00       	jmp    8003e4 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800322:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800325:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032c:	8b 45 08             	mov    0x8(%ebp),%eax
  80032f:	01 d0                	add    %edx,%eax
  800331:	8b 00                	mov    (%eax),%eax
  800333:	85 c0                	test   %eax,%eax
  800335:	75 08                	jne    80033f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800337:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80033a:	e9 a2 00 00 00       	jmp    8003e1 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80033f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800346:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80034d:	eb 69                	jmp    8003b8 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80034f:	a1 04 30 80 00       	mov    0x803004,%eax
  800354:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80035a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035d:	89 d0                	mov    %edx,%eax
  80035f:	01 c0                	add    %eax,%eax
  800361:	01 d0                	add    %edx,%eax
  800363:	c1 e0 02             	shl    $0x2,%eax
  800366:	01 c8                	add    %ecx,%eax
  800368:	8a 40 04             	mov    0x4(%eax),%al
  80036b:	84 c0                	test   %al,%al
  80036d:	75 46                	jne    8003b5 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80036f:	a1 04 30 80 00       	mov    0x803004,%eax
  800374:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80037a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80037d:	89 d0                	mov    %edx,%eax
  80037f:	01 c0                	add    %eax,%eax
  800381:	01 d0                	add    %edx,%eax
  800383:	c1 e0 02             	shl    $0x2,%eax
  800386:	01 c8                	add    %ecx,%eax
  800388:	8b 00                	mov    (%eax),%eax
  80038a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80038d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800390:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800395:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800397:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80039a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	01 c8                	add    %ecx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003a8:	39 c2                	cmp    %eax,%edx
  8003aa:	75 09                	jne    8003b5 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8003ac:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003b3:	eb 12                	jmp    8003c7 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003b5:	ff 45 e8             	incl   -0x18(%ebp)
  8003b8:	a1 04 30 80 00       	mov    0x803004,%eax
  8003bd:	8b 50 74             	mov    0x74(%eax),%edx
  8003c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003c3:	39 c2                	cmp    %eax,%edx
  8003c5:	77 88                	ja     80034f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003cb:	75 14                	jne    8003e1 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8003cd:	83 ec 04             	sub    $0x4,%esp
  8003d0:	68 74 1e 80 00       	push   $0x801e74
  8003d5:	6a 3a                	push   $0x3a
  8003d7:	68 68 1e 80 00       	push   $0x801e68
  8003dc:	e8 93 fe ff ff       	call   800274 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003e1:	ff 45 f0             	incl   -0x10(%ebp)
  8003e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003ea:	0f 8c 32 ff ff ff    	jl     800322 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003f7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003fe:	eb 26                	jmp    800426 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800400:	a1 04 30 80 00       	mov    0x803004,%eax
  800405:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80040b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80040e:	89 d0                	mov    %edx,%eax
  800410:	01 c0                	add    %eax,%eax
  800412:	01 d0                	add    %edx,%eax
  800414:	c1 e0 02             	shl    $0x2,%eax
  800417:	01 c8                	add    %ecx,%eax
  800419:	8a 40 04             	mov    0x4(%eax),%al
  80041c:	3c 01                	cmp    $0x1,%al
  80041e:	75 03                	jne    800423 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800420:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800423:	ff 45 e0             	incl   -0x20(%ebp)
  800426:	a1 04 30 80 00       	mov    0x803004,%eax
  80042b:	8b 50 74             	mov    0x74(%eax),%edx
  80042e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800431:	39 c2                	cmp    %eax,%edx
  800433:	77 cb                	ja     800400 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800435:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800438:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80043b:	74 14                	je     800451 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80043d:	83 ec 04             	sub    $0x4,%esp
  800440:	68 c8 1e 80 00       	push   $0x801ec8
  800445:	6a 44                	push   $0x44
  800447:	68 68 1e 80 00       	push   $0x801e68
  80044c:	e8 23 fe ff ff       	call   800274 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800451:	90                   	nop
  800452:	c9                   	leave  
  800453:	c3                   	ret    

00800454 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800454:	55                   	push   %ebp
  800455:	89 e5                	mov    %esp,%ebp
  800457:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80045a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045d:	8b 00                	mov    (%eax),%eax
  80045f:	8d 48 01             	lea    0x1(%eax),%ecx
  800462:	8b 55 0c             	mov    0xc(%ebp),%edx
  800465:	89 0a                	mov    %ecx,(%edx)
  800467:	8b 55 08             	mov    0x8(%ebp),%edx
  80046a:	88 d1                	mov    %dl,%cl
  80046c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800473:	8b 45 0c             	mov    0xc(%ebp),%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	3d ff 00 00 00       	cmp    $0xff,%eax
  80047d:	75 2c                	jne    8004ab <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80047f:	a0 08 30 80 00       	mov    0x803008,%al
  800484:	0f b6 c0             	movzbl %al,%eax
  800487:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048a:	8b 12                	mov    (%edx),%edx
  80048c:	89 d1                	mov    %edx,%ecx
  80048e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800491:	83 c2 08             	add    $0x8,%edx
  800494:	83 ec 04             	sub    $0x4,%esp
  800497:	50                   	push   %eax
  800498:	51                   	push   %ecx
  800499:	52                   	push   %edx
  80049a:	e8 3e 0e 00 00       	call   8012dd <sys_cputs>
  80049f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ae:	8b 40 04             	mov    0x4(%eax),%eax
  8004b1:	8d 50 01             	lea    0x1(%eax),%edx
  8004b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b7:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004ba:	90                   	nop
  8004bb:	c9                   	leave  
  8004bc:	c3                   	ret    

008004bd <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004bd:	55                   	push   %ebp
  8004be:	89 e5                	mov    %esp,%ebp
  8004c0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004c6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004cd:	00 00 00 
	b.cnt = 0;
  8004d0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004d7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004da:	ff 75 0c             	pushl  0xc(%ebp)
  8004dd:	ff 75 08             	pushl  0x8(%ebp)
  8004e0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e6:	50                   	push   %eax
  8004e7:	68 54 04 80 00       	push   $0x800454
  8004ec:	e8 11 02 00 00       	call   800702 <vprintfmt>
  8004f1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004f4:	a0 08 30 80 00       	mov    0x803008,%al
  8004f9:	0f b6 c0             	movzbl %al,%eax
  8004fc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800502:	83 ec 04             	sub    $0x4,%esp
  800505:	50                   	push   %eax
  800506:	52                   	push   %edx
  800507:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80050d:	83 c0 08             	add    $0x8,%eax
  800510:	50                   	push   %eax
  800511:	e8 c7 0d 00 00       	call   8012dd <sys_cputs>
  800516:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800519:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  800520:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800526:	c9                   	leave  
  800527:	c3                   	ret    

00800528 <cprintf>:

int cprintf(const char *fmt, ...) {
  800528:	55                   	push   %ebp
  800529:	89 e5                	mov    %esp,%ebp
  80052b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80052e:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800535:	8d 45 0c             	lea    0xc(%ebp),%eax
  800538:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053b:	8b 45 08             	mov    0x8(%ebp),%eax
  80053e:	83 ec 08             	sub    $0x8,%esp
  800541:	ff 75 f4             	pushl  -0xc(%ebp)
  800544:	50                   	push   %eax
  800545:	e8 73 ff ff ff       	call   8004bd <vcprintf>
  80054a:	83 c4 10             	add    $0x10,%esp
  80054d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800550:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800553:	c9                   	leave  
  800554:	c3                   	ret    

00800555 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800555:	55                   	push   %ebp
  800556:	89 e5                	mov    %esp,%ebp
  800558:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80055b:	e8 8e 0f 00 00       	call   8014ee <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800560:	8d 45 0c             	lea    0xc(%ebp),%eax
  800563:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800566:	8b 45 08             	mov    0x8(%ebp),%eax
  800569:	83 ec 08             	sub    $0x8,%esp
  80056c:	ff 75 f4             	pushl  -0xc(%ebp)
  80056f:	50                   	push   %eax
  800570:	e8 48 ff ff ff       	call   8004bd <vcprintf>
  800575:	83 c4 10             	add    $0x10,%esp
  800578:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80057b:	e8 88 0f 00 00       	call   801508 <sys_enable_interrupt>
	return cnt;
  800580:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800583:	c9                   	leave  
  800584:	c3                   	ret    

00800585 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800585:	55                   	push   %ebp
  800586:	89 e5                	mov    %esp,%ebp
  800588:	53                   	push   %ebx
  800589:	83 ec 14             	sub    $0x14,%esp
  80058c:	8b 45 10             	mov    0x10(%ebp),%eax
  80058f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800592:	8b 45 14             	mov    0x14(%ebp),%eax
  800595:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800598:	8b 45 18             	mov    0x18(%ebp),%eax
  80059b:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a3:	77 55                	ja     8005fa <printnum+0x75>
  8005a5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a8:	72 05                	jb     8005af <printnum+0x2a>
  8005aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005ad:	77 4b                	ja     8005fa <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005af:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005b2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005b5:	8b 45 18             	mov    0x18(%ebp),%eax
  8005b8:	ba 00 00 00 00       	mov    $0x0,%edx
  8005bd:	52                   	push   %edx
  8005be:	50                   	push   %eax
  8005bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c2:	ff 75 f0             	pushl  -0x10(%ebp)
  8005c5:	e8 b6 13 00 00       	call   801980 <__udivdi3>
  8005ca:	83 c4 10             	add    $0x10,%esp
  8005cd:	83 ec 04             	sub    $0x4,%esp
  8005d0:	ff 75 20             	pushl  0x20(%ebp)
  8005d3:	53                   	push   %ebx
  8005d4:	ff 75 18             	pushl  0x18(%ebp)
  8005d7:	52                   	push   %edx
  8005d8:	50                   	push   %eax
  8005d9:	ff 75 0c             	pushl  0xc(%ebp)
  8005dc:	ff 75 08             	pushl  0x8(%ebp)
  8005df:	e8 a1 ff ff ff       	call   800585 <printnum>
  8005e4:	83 c4 20             	add    $0x20,%esp
  8005e7:	eb 1a                	jmp    800603 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005e9:	83 ec 08             	sub    $0x8,%esp
  8005ec:	ff 75 0c             	pushl  0xc(%ebp)
  8005ef:	ff 75 20             	pushl  0x20(%ebp)
  8005f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f5:	ff d0                	call   *%eax
  8005f7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005fa:	ff 4d 1c             	decl   0x1c(%ebp)
  8005fd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800601:	7f e6                	jg     8005e9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800603:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800606:	bb 00 00 00 00       	mov    $0x0,%ebx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800611:	53                   	push   %ebx
  800612:	51                   	push   %ecx
  800613:	52                   	push   %edx
  800614:	50                   	push   %eax
  800615:	e8 76 14 00 00       	call   801a90 <__umoddi3>
  80061a:	83 c4 10             	add    $0x10,%esp
  80061d:	05 34 21 80 00       	add    $0x802134,%eax
  800622:	8a 00                	mov    (%eax),%al
  800624:	0f be c0             	movsbl %al,%eax
  800627:	83 ec 08             	sub    $0x8,%esp
  80062a:	ff 75 0c             	pushl  0xc(%ebp)
  80062d:	50                   	push   %eax
  80062e:	8b 45 08             	mov    0x8(%ebp),%eax
  800631:	ff d0                	call   *%eax
  800633:	83 c4 10             	add    $0x10,%esp
}
  800636:	90                   	nop
  800637:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80063a:	c9                   	leave  
  80063b:	c3                   	ret    

0080063c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80063c:	55                   	push   %ebp
  80063d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80063f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800643:	7e 1c                	jle    800661 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800645:	8b 45 08             	mov    0x8(%ebp),%eax
  800648:	8b 00                	mov    (%eax),%eax
  80064a:	8d 50 08             	lea    0x8(%eax),%edx
  80064d:	8b 45 08             	mov    0x8(%ebp),%eax
  800650:	89 10                	mov    %edx,(%eax)
  800652:	8b 45 08             	mov    0x8(%ebp),%eax
  800655:	8b 00                	mov    (%eax),%eax
  800657:	83 e8 08             	sub    $0x8,%eax
  80065a:	8b 50 04             	mov    0x4(%eax),%edx
  80065d:	8b 00                	mov    (%eax),%eax
  80065f:	eb 40                	jmp    8006a1 <getuint+0x65>
	else if (lflag)
  800661:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800665:	74 1e                	je     800685 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	8b 00                	mov    (%eax),%eax
  80066c:	8d 50 04             	lea    0x4(%eax),%edx
  80066f:	8b 45 08             	mov    0x8(%ebp),%eax
  800672:	89 10                	mov    %edx,(%eax)
  800674:	8b 45 08             	mov    0x8(%ebp),%eax
  800677:	8b 00                	mov    (%eax),%eax
  800679:	83 e8 04             	sub    $0x4,%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	ba 00 00 00 00       	mov    $0x0,%edx
  800683:	eb 1c                	jmp    8006a1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	8b 00                	mov    (%eax),%eax
  80068a:	8d 50 04             	lea    0x4(%eax),%edx
  80068d:	8b 45 08             	mov    0x8(%ebp),%eax
  800690:	89 10                	mov    %edx,(%eax)
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	8b 00                	mov    (%eax),%eax
  800697:	83 e8 04             	sub    $0x4,%eax
  80069a:	8b 00                	mov    (%eax),%eax
  80069c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006a1:	5d                   	pop    %ebp
  8006a2:	c3                   	ret    

008006a3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006a3:	55                   	push   %ebp
  8006a4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006a6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006aa:	7e 1c                	jle    8006c8 <getint+0x25>
		return va_arg(*ap, long long);
  8006ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8006af:	8b 00                	mov    (%eax),%eax
  8006b1:	8d 50 08             	lea    0x8(%eax),%edx
  8006b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b7:	89 10                	mov    %edx,(%eax)
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	8b 00                	mov    (%eax),%eax
  8006be:	83 e8 08             	sub    $0x8,%eax
  8006c1:	8b 50 04             	mov    0x4(%eax),%edx
  8006c4:	8b 00                	mov    (%eax),%eax
  8006c6:	eb 38                	jmp    800700 <getint+0x5d>
	else if (lflag)
  8006c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006cc:	74 1a                	je     8006e8 <getint+0x45>
		return va_arg(*ap, long);
  8006ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d1:	8b 00                	mov    (%eax),%eax
  8006d3:	8d 50 04             	lea    0x4(%eax),%edx
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	89 10                	mov    %edx,(%eax)
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	8b 00                	mov    (%eax),%eax
  8006e0:	83 e8 04             	sub    $0x4,%eax
  8006e3:	8b 00                	mov    (%eax),%eax
  8006e5:	99                   	cltd   
  8006e6:	eb 18                	jmp    800700 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006eb:	8b 00                	mov    (%eax),%eax
  8006ed:	8d 50 04             	lea    0x4(%eax),%edx
  8006f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f3:	89 10                	mov    %edx,(%eax)
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	8b 00                	mov    (%eax),%eax
  8006fa:	83 e8 04             	sub    $0x4,%eax
  8006fd:	8b 00                	mov    (%eax),%eax
  8006ff:	99                   	cltd   
}
  800700:	5d                   	pop    %ebp
  800701:	c3                   	ret    

00800702 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800702:	55                   	push   %ebp
  800703:	89 e5                	mov    %esp,%ebp
  800705:	56                   	push   %esi
  800706:	53                   	push   %ebx
  800707:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80070a:	eb 17                	jmp    800723 <vprintfmt+0x21>
			if (ch == '\0')
  80070c:	85 db                	test   %ebx,%ebx
  80070e:	0f 84 af 03 00 00    	je     800ac3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800714:	83 ec 08             	sub    $0x8,%esp
  800717:	ff 75 0c             	pushl  0xc(%ebp)
  80071a:	53                   	push   %ebx
  80071b:	8b 45 08             	mov    0x8(%ebp),%eax
  80071e:	ff d0                	call   *%eax
  800720:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800723:	8b 45 10             	mov    0x10(%ebp),%eax
  800726:	8d 50 01             	lea    0x1(%eax),%edx
  800729:	89 55 10             	mov    %edx,0x10(%ebp)
  80072c:	8a 00                	mov    (%eax),%al
  80072e:	0f b6 d8             	movzbl %al,%ebx
  800731:	83 fb 25             	cmp    $0x25,%ebx
  800734:	75 d6                	jne    80070c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800736:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80073a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800741:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800748:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80074f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800756:	8b 45 10             	mov    0x10(%ebp),%eax
  800759:	8d 50 01             	lea    0x1(%eax),%edx
  80075c:	89 55 10             	mov    %edx,0x10(%ebp)
  80075f:	8a 00                	mov    (%eax),%al
  800761:	0f b6 d8             	movzbl %al,%ebx
  800764:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800767:	83 f8 55             	cmp    $0x55,%eax
  80076a:	0f 87 2b 03 00 00    	ja     800a9b <vprintfmt+0x399>
  800770:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
  800777:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800779:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80077d:	eb d7                	jmp    800756 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80077f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800783:	eb d1                	jmp    800756 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800785:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80078c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80078f:	89 d0                	mov    %edx,%eax
  800791:	c1 e0 02             	shl    $0x2,%eax
  800794:	01 d0                	add    %edx,%eax
  800796:	01 c0                	add    %eax,%eax
  800798:	01 d8                	add    %ebx,%eax
  80079a:	83 e8 30             	sub    $0x30,%eax
  80079d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a3:	8a 00                	mov    (%eax),%al
  8007a5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007a8:	83 fb 2f             	cmp    $0x2f,%ebx
  8007ab:	7e 3e                	jle    8007eb <vprintfmt+0xe9>
  8007ad:	83 fb 39             	cmp    $0x39,%ebx
  8007b0:	7f 39                	jg     8007eb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007b5:	eb d5                	jmp    80078c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ba:	83 c0 04             	add    $0x4,%eax
  8007bd:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c3:	83 e8 04             	sub    $0x4,%eax
  8007c6:	8b 00                	mov    (%eax),%eax
  8007c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007cb:	eb 1f                	jmp    8007ec <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d1:	79 83                	jns    800756 <vprintfmt+0x54>
				width = 0;
  8007d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007da:	e9 77 ff ff ff       	jmp    800756 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007df:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007e6:	e9 6b ff ff ff       	jmp    800756 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007eb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f0:	0f 89 60 ff ff ff    	jns    800756 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007fc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800803:	e9 4e ff ff ff       	jmp    800756 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800808:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80080b:	e9 46 ff ff ff       	jmp    800756 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800810:	8b 45 14             	mov    0x14(%ebp),%eax
  800813:	83 c0 04             	add    $0x4,%eax
  800816:	89 45 14             	mov    %eax,0x14(%ebp)
  800819:	8b 45 14             	mov    0x14(%ebp),%eax
  80081c:	83 e8 04             	sub    $0x4,%eax
  80081f:	8b 00                	mov    (%eax),%eax
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 0c             	pushl  0xc(%ebp)
  800827:	50                   	push   %eax
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	ff d0                	call   *%eax
  80082d:	83 c4 10             	add    $0x10,%esp
			break;
  800830:	e9 89 02 00 00       	jmp    800abe <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800835:	8b 45 14             	mov    0x14(%ebp),%eax
  800838:	83 c0 04             	add    $0x4,%eax
  80083b:	89 45 14             	mov    %eax,0x14(%ebp)
  80083e:	8b 45 14             	mov    0x14(%ebp),%eax
  800841:	83 e8 04             	sub    $0x4,%eax
  800844:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800846:	85 db                	test   %ebx,%ebx
  800848:	79 02                	jns    80084c <vprintfmt+0x14a>
				err = -err;
  80084a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80084c:	83 fb 64             	cmp    $0x64,%ebx
  80084f:	7f 0b                	jg     80085c <vprintfmt+0x15a>
  800851:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  800858:	85 f6                	test   %esi,%esi
  80085a:	75 19                	jne    800875 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80085c:	53                   	push   %ebx
  80085d:	68 45 21 80 00       	push   $0x802145
  800862:	ff 75 0c             	pushl  0xc(%ebp)
  800865:	ff 75 08             	pushl  0x8(%ebp)
  800868:	e8 5e 02 00 00       	call   800acb <printfmt>
  80086d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800870:	e9 49 02 00 00       	jmp    800abe <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800875:	56                   	push   %esi
  800876:	68 4e 21 80 00       	push   $0x80214e
  80087b:	ff 75 0c             	pushl  0xc(%ebp)
  80087e:	ff 75 08             	pushl  0x8(%ebp)
  800881:	e8 45 02 00 00       	call   800acb <printfmt>
  800886:	83 c4 10             	add    $0x10,%esp
			break;
  800889:	e9 30 02 00 00       	jmp    800abe <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80088e:	8b 45 14             	mov    0x14(%ebp),%eax
  800891:	83 c0 04             	add    $0x4,%eax
  800894:	89 45 14             	mov    %eax,0x14(%ebp)
  800897:	8b 45 14             	mov    0x14(%ebp),%eax
  80089a:	83 e8 04             	sub    $0x4,%eax
  80089d:	8b 30                	mov    (%eax),%esi
  80089f:	85 f6                	test   %esi,%esi
  8008a1:	75 05                	jne    8008a8 <vprintfmt+0x1a6>
				p = "(null)";
  8008a3:	be 51 21 80 00       	mov    $0x802151,%esi
			if (width > 0 && padc != '-')
  8008a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ac:	7e 6d                	jle    80091b <vprintfmt+0x219>
  8008ae:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008b2:	74 67                	je     80091b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b7:	83 ec 08             	sub    $0x8,%esp
  8008ba:	50                   	push   %eax
  8008bb:	56                   	push   %esi
  8008bc:	e8 0c 03 00 00       	call   800bcd <strnlen>
  8008c1:	83 c4 10             	add    $0x10,%esp
  8008c4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008c7:	eb 16                	jmp    8008df <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008c9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008cd:	83 ec 08             	sub    $0x8,%esp
  8008d0:	ff 75 0c             	pushl  0xc(%ebp)
  8008d3:	50                   	push   %eax
  8008d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d7:	ff d0                	call   *%eax
  8008d9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008dc:	ff 4d e4             	decl   -0x1c(%ebp)
  8008df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e3:	7f e4                	jg     8008c9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008e5:	eb 34                	jmp    80091b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008e7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008eb:	74 1c                	je     800909 <vprintfmt+0x207>
  8008ed:	83 fb 1f             	cmp    $0x1f,%ebx
  8008f0:	7e 05                	jle    8008f7 <vprintfmt+0x1f5>
  8008f2:	83 fb 7e             	cmp    $0x7e,%ebx
  8008f5:	7e 12                	jle    800909 <vprintfmt+0x207>
					putch('?', putdat);
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	6a 3f                	push   $0x3f
  8008ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800902:	ff d0                	call   *%eax
  800904:	83 c4 10             	add    $0x10,%esp
  800907:	eb 0f                	jmp    800918 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800909:	83 ec 08             	sub    $0x8,%esp
  80090c:	ff 75 0c             	pushl  0xc(%ebp)
  80090f:	53                   	push   %ebx
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	ff d0                	call   *%eax
  800915:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800918:	ff 4d e4             	decl   -0x1c(%ebp)
  80091b:	89 f0                	mov    %esi,%eax
  80091d:	8d 70 01             	lea    0x1(%eax),%esi
  800920:	8a 00                	mov    (%eax),%al
  800922:	0f be d8             	movsbl %al,%ebx
  800925:	85 db                	test   %ebx,%ebx
  800927:	74 24                	je     80094d <vprintfmt+0x24b>
  800929:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80092d:	78 b8                	js     8008e7 <vprintfmt+0x1e5>
  80092f:	ff 4d e0             	decl   -0x20(%ebp)
  800932:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800936:	79 af                	jns    8008e7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800938:	eb 13                	jmp    80094d <vprintfmt+0x24b>
				putch(' ', putdat);
  80093a:	83 ec 08             	sub    $0x8,%esp
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	6a 20                	push   $0x20
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	ff d0                	call   *%eax
  800947:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094a:	ff 4d e4             	decl   -0x1c(%ebp)
  80094d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800951:	7f e7                	jg     80093a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800953:	e9 66 01 00 00       	jmp    800abe <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800958:	83 ec 08             	sub    $0x8,%esp
  80095b:	ff 75 e8             	pushl  -0x18(%ebp)
  80095e:	8d 45 14             	lea    0x14(%ebp),%eax
  800961:	50                   	push   %eax
  800962:	e8 3c fd ff ff       	call   8006a3 <getint>
  800967:	83 c4 10             	add    $0x10,%esp
  80096a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800970:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800973:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800976:	85 d2                	test   %edx,%edx
  800978:	79 23                	jns    80099d <vprintfmt+0x29b>
				putch('-', putdat);
  80097a:	83 ec 08             	sub    $0x8,%esp
  80097d:	ff 75 0c             	pushl  0xc(%ebp)
  800980:	6a 2d                	push   $0x2d
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	ff d0                	call   *%eax
  800987:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80098a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80098d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800990:	f7 d8                	neg    %eax
  800992:	83 d2 00             	adc    $0x0,%edx
  800995:	f7 da                	neg    %edx
  800997:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80099d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a4:	e9 bc 00 00 00       	jmp    800a65 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009a9:	83 ec 08             	sub    $0x8,%esp
  8009ac:	ff 75 e8             	pushl  -0x18(%ebp)
  8009af:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b2:	50                   	push   %eax
  8009b3:	e8 84 fc ff ff       	call   80063c <getuint>
  8009b8:	83 c4 10             	add    $0x10,%esp
  8009bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009be:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009c1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009c8:	e9 98 00 00 00       	jmp    800a65 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 0c             	pushl  0xc(%ebp)
  8009d3:	6a 58                	push   $0x58
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	ff d0                	call   *%eax
  8009da:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009dd:	83 ec 08             	sub    $0x8,%esp
  8009e0:	ff 75 0c             	pushl  0xc(%ebp)
  8009e3:	6a 58                	push   $0x58
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	ff d0                	call   *%eax
  8009ea:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ed:	83 ec 08             	sub    $0x8,%esp
  8009f0:	ff 75 0c             	pushl  0xc(%ebp)
  8009f3:	6a 58                	push   $0x58
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	ff d0                	call   *%eax
  8009fa:	83 c4 10             	add    $0x10,%esp
			break;
  8009fd:	e9 bc 00 00 00       	jmp    800abe <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a02:	83 ec 08             	sub    $0x8,%esp
  800a05:	ff 75 0c             	pushl  0xc(%ebp)
  800a08:	6a 30                	push   $0x30
  800a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0d:	ff d0                	call   *%eax
  800a0f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a12:	83 ec 08             	sub    $0x8,%esp
  800a15:	ff 75 0c             	pushl  0xc(%ebp)
  800a18:	6a 78                	push   $0x78
  800a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1d:	ff d0                	call   *%eax
  800a1f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a22:	8b 45 14             	mov    0x14(%ebp),%eax
  800a25:	83 c0 04             	add    $0x4,%eax
  800a28:	89 45 14             	mov    %eax,0x14(%ebp)
  800a2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2e:	83 e8 04             	sub    $0x4,%eax
  800a31:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a3d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a44:	eb 1f                	jmp    800a65 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a46:	83 ec 08             	sub    $0x8,%esp
  800a49:	ff 75 e8             	pushl  -0x18(%ebp)
  800a4c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a4f:	50                   	push   %eax
  800a50:	e8 e7 fb ff ff       	call   80063c <getuint>
  800a55:	83 c4 10             	add    $0x10,%esp
  800a58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a5e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a65:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a69:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a6c:	83 ec 04             	sub    $0x4,%esp
  800a6f:	52                   	push   %edx
  800a70:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a73:	50                   	push   %eax
  800a74:	ff 75 f4             	pushl  -0xc(%ebp)
  800a77:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	ff 75 08             	pushl  0x8(%ebp)
  800a80:	e8 00 fb ff ff       	call   800585 <printnum>
  800a85:	83 c4 20             	add    $0x20,%esp
			break;
  800a88:	eb 34                	jmp    800abe <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a8a:	83 ec 08             	sub    $0x8,%esp
  800a8d:	ff 75 0c             	pushl  0xc(%ebp)
  800a90:	53                   	push   %ebx
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	ff d0                	call   *%eax
  800a96:	83 c4 10             	add    $0x10,%esp
			break;
  800a99:	eb 23                	jmp    800abe <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a9b:	83 ec 08             	sub    $0x8,%esp
  800a9e:	ff 75 0c             	pushl  0xc(%ebp)
  800aa1:	6a 25                	push   $0x25
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	ff d0                	call   *%eax
  800aa8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800aab:	ff 4d 10             	decl   0x10(%ebp)
  800aae:	eb 03                	jmp    800ab3 <vprintfmt+0x3b1>
  800ab0:	ff 4d 10             	decl   0x10(%ebp)
  800ab3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab6:	48                   	dec    %eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	3c 25                	cmp    $0x25,%al
  800abb:	75 f3                	jne    800ab0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800abd:	90                   	nop
		}
	}
  800abe:	e9 47 fc ff ff       	jmp    80070a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ac3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ac4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ac7:	5b                   	pop    %ebx
  800ac8:	5e                   	pop    %esi
  800ac9:	5d                   	pop    %ebp
  800aca:	c3                   	ret    

00800acb <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800acb:	55                   	push   %ebp
  800acc:	89 e5                	mov    %esp,%ebp
  800ace:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ad1:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad4:	83 c0 04             	add    $0x4,%eax
  800ad7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ada:	8b 45 10             	mov    0x10(%ebp),%eax
  800add:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae0:	50                   	push   %eax
  800ae1:	ff 75 0c             	pushl  0xc(%ebp)
  800ae4:	ff 75 08             	pushl  0x8(%ebp)
  800ae7:	e8 16 fc ff ff       	call   800702 <vprintfmt>
  800aec:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800aef:	90                   	nop
  800af0:	c9                   	leave  
  800af1:	c3                   	ret    

00800af2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800af2:	55                   	push   %ebp
  800af3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800af5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af8:	8b 40 08             	mov    0x8(%eax),%eax
  800afb:	8d 50 01             	lea    0x1(%eax),%edx
  800afe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b01:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b07:	8b 10                	mov    (%eax),%edx
  800b09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0c:	8b 40 04             	mov    0x4(%eax),%eax
  800b0f:	39 c2                	cmp    %eax,%edx
  800b11:	73 12                	jae    800b25 <sprintputch+0x33>
		*b->buf++ = ch;
  800b13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b16:	8b 00                	mov    (%eax),%eax
  800b18:	8d 48 01             	lea    0x1(%eax),%ecx
  800b1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b1e:	89 0a                	mov    %ecx,(%edx)
  800b20:	8b 55 08             	mov    0x8(%ebp),%edx
  800b23:	88 10                	mov    %dl,(%eax)
}
  800b25:	90                   	nop
  800b26:	5d                   	pop    %ebp
  800b27:	c3                   	ret    

00800b28 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b28:	55                   	push   %ebp
  800b29:	89 e5                	mov    %esp,%ebp
  800b2b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b37:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	01 d0                	add    %edx,%eax
  800b3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b42:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b49:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b4d:	74 06                	je     800b55 <vsnprintf+0x2d>
  800b4f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b53:	7f 07                	jg     800b5c <vsnprintf+0x34>
		return -E_INVAL;
  800b55:	b8 03 00 00 00       	mov    $0x3,%eax
  800b5a:	eb 20                	jmp    800b7c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b5c:	ff 75 14             	pushl  0x14(%ebp)
  800b5f:	ff 75 10             	pushl  0x10(%ebp)
  800b62:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b65:	50                   	push   %eax
  800b66:	68 f2 0a 80 00       	push   $0x800af2
  800b6b:	e8 92 fb ff ff       	call   800702 <vprintfmt>
  800b70:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b73:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b76:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b7c:	c9                   	leave  
  800b7d:	c3                   	ret    

00800b7e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b7e:	55                   	push   %ebp
  800b7f:	89 e5                	mov    %esp,%ebp
  800b81:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b84:	8d 45 10             	lea    0x10(%ebp),%eax
  800b87:	83 c0 04             	add    $0x4,%eax
  800b8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b90:	ff 75 f4             	pushl  -0xc(%ebp)
  800b93:	50                   	push   %eax
  800b94:	ff 75 0c             	pushl  0xc(%ebp)
  800b97:	ff 75 08             	pushl  0x8(%ebp)
  800b9a:	e8 89 ff ff ff       	call   800b28 <vsnprintf>
  800b9f:	83 c4 10             	add    $0x10,%esp
  800ba2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ba5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ba8:	c9                   	leave  
  800ba9:	c3                   	ret    

00800baa <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800baa:	55                   	push   %ebp
  800bab:	89 e5                	mov    %esp,%ebp
  800bad:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bb0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb7:	eb 06                	jmp    800bbf <strlen+0x15>
		n++;
  800bb9:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bbc:	ff 45 08             	incl   0x8(%ebp)
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	8a 00                	mov    (%eax),%al
  800bc4:	84 c0                	test   %al,%al
  800bc6:	75 f1                	jne    800bb9 <strlen+0xf>
		n++;
	return n;
  800bc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcb:	c9                   	leave  
  800bcc:	c3                   	ret    

00800bcd <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bcd:	55                   	push   %ebp
  800bce:	89 e5                	mov    %esp,%ebp
  800bd0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bd3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bda:	eb 09                	jmp    800be5 <strnlen+0x18>
		n++;
  800bdc:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bdf:	ff 45 08             	incl   0x8(%ebp)
  800be2:	ff 4d 0c             	decl   0xc(%ebp)
  800be5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800be9:	74 09                	je     800bf4 <strnlen+0x27>
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	8a 00                	mov    (%eax),%al
  800bf0:	84 c0                	test   %al,%al
  800bf2:	75 e8                	jne    800bdc <strnlen+0xf>
		n++;
	return n;
  800bf4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bf7:	c9                   	leave  
  800bf8:	c3                   	ret    

00800bf9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c05:	90                   	nop
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8d 50 01             	lea    0x1(%eax),%edx
  800c0c:	89 55 08             	mov    %edx,0x8(%ebp)
  800c0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c12:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c15:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c18:	8a 12                	mov    (%edx),%dl
  800c1a:	88 10                	mov    %dl,(%eax)
  800c1c:	8a 00                	mov    (%eax),%al
  800c1e:	84 c0                	test   %al,%al
  800c20:	75 e4                	jne    800c06 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c22:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c25:	c9                   	leave  
  800c26:	c3                   	ret    

00800c27 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c27:	55                   	push   %ebp
  800c28:	89 e5                	mov    %esp,%ebp
  800c2a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c33:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3a:	eb 1f                	jmp    800c5b <strncpy+0x34>
		*dst++ = *src;
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	8d 50 01             	lea    0x1(%eax),%edx
  800c42:	89 55 08             	mov    %edx,0x8(%ebp)
  800c45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c48:	8a 12                	mov    (%edx),%dl
  800c4a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4f:	8a 00                	mov    (%eax),%al
  800c51:	84 c0                	test   %al,%al
  800c53:	74 03                	je     800c58 <strncpy+0x31>
			src++;
  800c55:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c58:	ff 45 fc             	incl   -0x4(%ebp)
  800c5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c5e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c61:	72 d9                	jb     800c3c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c63:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c66:	c9                   	leave  
  800c67:	c3                   	ret    

00800c68 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c68:	55                   	push   %ebp
  800c69:	89 e5                	mov    %esp,%ebp
  800c6b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c78:	74 30                	je     800caa <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c7a:	eb 16                	jmp    800c92 <strlcpy+0x2a>
			*dst++ = *src++;
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	8d 50 01             	lea    0x1(%eax),%edx
  800c82:	89 55 08             	mov    %edx,0x8(%ebp)
  800c85:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c88:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c8b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c8e:	8a 12                	mov    (%edx),%dl
  800c90:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c92:	ff 4d 10             	decl   0x10(%ebp)
  800c95:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c99:	74 09                	je     800ca4 <strlcpy+0x3c>
  800c9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	84 c0                	test   %al,%al
  800ca2:	75 d8                	jne    800c7c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800caa:	8b 55 08             	mov    0x8(%ebp),%edx
  800cad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb0:	29 c2                	sub    %eax,%edx
  800cb2:	89 d0                	mov    %edx,%eax
}
  800cb4:	c9                   	leave  
  800cb5:	c3                   	ret    

00800cb6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cb6:	55                   	push   %ebp
  800cb7:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cb9:	eb 06                	jmp    800cc1 <strcmp+0xb>
		p++, q++;
  800cbb:	ff 45 08             	incl   0x8(%ebp)
  800cbe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	8a 00                	mov    (%eax),%al
  800cc6:	84 c0                	test   %al,%al
  800cc8:	74 0e                	je     800cd8 <strcmp+0x22>
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8a 10                	mov    (%eax),%dl
  800ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd2:	8a 00                	mov    (%eax),%al
  800cd4:	38 c2                	cmp    %al,%dl
  800cd6:	74 e3                	je     800cbb <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	0f b6 d0             	movzbl %al,%edx
  800ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	0f b6 c0             	movzbl %al,%eax
  800ce8:	29 c2                	sub    %eax,%edx
  800cea:	89 d0                	mov    %edx,%eax
}
  800cec:	5d                   	pop    %ebp
  800ced:	c3                   	ret    

00800cee <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cee:	55                   	push   %ebp
  800cef:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cf1:	eb 09                	jmp    800cfc <strncmp+0xe>
		n--, p++, q++;
  800cf3:	ff 4d 10             	decl   0x10(%ebp)
  800cf6:	ff 45 08             	incl   0x8(%ebp)
  800cf9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cfc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d00:	74 17                	je     800d19 <strncmp+0x2b>
  800d02:	8b 45 08             	mov    0x8(%ebp),%eax
  800d05:	8a 00                	mov    (%eax),%al
  800d07:	84 c0                	test   %al,%al
  800d09:	74 0e                	je     800d19 <strncmp+0x2b>
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8a 10                	mov    (%eax),%dl
  800d10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	38 c2                	cmp    %al,%dl
  800d17:	74 da                	je     800cf3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1d:	75 07                	jne    800d26 <strncmp+0x38>
		return 0;
  800d1f:	b8 00 00 00 00       	mov    $0x0,%eax
  800d24:	eb 14                	jmp    800d3a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	0f b6 d0             	movzbl %al,%edx
  800d2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d31:	8a 00                	mov    (%eax),%al
  800d33:	0f b6 c0             	movzbl %al,%eax
  800d36:	29 c2                	sub    %eax,%edx
  800d38:	89 d0                	mov    %edx,%eax
}
  800d3a:	5d                   	pop    %ebp
  800d3b:	c3                   	ret    

00800d3c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d3c:	55                   	push   %ebp
  800d3d:	89 e5                	mov    %esp,%ebp
  800d3f:	83 ec 04             	sub    $0x4,%esp
  800d42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d45:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d48:	eb 12                	jmp    800d5c <strchr+0x20>
		if (*s == c)
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	8a 00                	mov    (%eax),%al
  800d4f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d52:	75 05                	jne    800d59 <strchr+0x1d>
			return (char *) s;
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	eb 11                	jmp    800d6a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d59:	ff 45 08             	incl   0x8(%ebp)
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	84 c0                	test   %al,%al
  800d63:	75 e5                	jne    800d4a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d65:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d6a:	c9                   	leave  
  800d6b:	c3                   	ret    

00800d6c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d6c:	55                   	push   %ebp
  800d6d:	89 e5                	mov    %esp,%ebp
  800d6f:	83 ec 04             	sub    $0x4,%esp
  800d72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d75:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d78:	eb 0d                	jmp    800d87 <strfind+0x1b>
		if (*s == c)
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d82:	74 0e                	je     800d92 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d84:	ff 45 08             	incl   0x8(%ebp)
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	84 c0                	test   %al,%al
  800d8e:	75 ea                	jne    800d7a <strfind+0xe>
  800d90:	eb 01                	jmp    800d93 <strfind+0x27>
		if (*s == c)
			break;
  800d92:	90                   	nop
	return (char *) s;
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d96:	c9                   	leave  
  800d97:	c3                   	ret    

00800d98 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d98:	55                   	push   %ebp
  800d99:	89 e5                	mov    %esp,%ebp
  800d9b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800da4:	8b 45 10             	mov    0x10(%ebp),%eax
  800da7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800daa:	eb 0e                	jmp    800dba <memset+0x22>
		*p++ = c;
  800dac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800daf:	8d 50 01             	lea    0x1(%eax),%edx
  800db2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800db5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800db8:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dba:	ff 4d f8             	decl   -0x8(%ebp)
  800dbd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dc1:	79 e9                	jns    800dac <memset+0x14>
		*p++ = c;

	return v;
  800dc3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc6:	c9                   	leave  
  800dc7:	c3                   	ret    

00800dc8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dc8:	55                   	push   %ebp
  800dc9:	89 e5                	mov    %esp,%ebp
  800dcb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dda:	eb 16                	jmp    800df2 <memcpy+0x2a>
		*d++ = *s++;
  800ddc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddf:	8d 50 01             	lea    0x1(%eax),%edx
  800de2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800de8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800deb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dee:	8a 12                	mov    (%edx),%dl
  800df0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800df2:	8b 45 10             	mov    0x10(%ebp),%eax
  800df5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df8:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfb:	85 c0                	test   %eax,%eax
  800dfd:	75 dd                	jne    800ddc <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e02:	c9                   	leave  
  800e03:	c3                   	ret    

00800e04 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e04:	55                   	push   %ebp
  800e05:	89 e5                	mov    %esp,%ebp
  800e07:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e19:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e1c:	73 50                	jae    800e6e <memmove+0x6a>
  800e1e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e21:	8b 45 10             	mov    0x10(%ebp),%eax
  800e24:	01 d0                	add    %edx,%eax
  800e26:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e29:	76 43                	jbe    800e6e <memmove+0x6a>
		s += n;
  800e2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e31:	8b 45 10             	mov    0x10(%ebp),%eax
  800e34:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e37:	eb 10                	jmp    800e49 <memmove+0x45>
			*--d = *--s;
  800e39:	ff 4d f8             	decl   -0x8(%ebp)
  800e3c:	ff 4d fc             	decl   -0x4(%ebp)
  800e3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e42:	8a 10                	mov    (%eax),%dl
  800e44:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e47:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e49:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e52:	85 c0                	test   %eax,%eax
  800e54:	75 e3                	jne    800e39 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e56:	eb 23                	jmp    800e7b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e58:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5b:	8d 50 01             	lea    0x1(%eax),%edx
  800e5e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e61:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e64:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e67:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6a:	8a 12                	mov    (%edx),%dl
  800e6c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e71:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e74:	89 55 10             	mov    %edx,0x10(%ebp)
  800e77:	85 c0                	test   %eax,%eax
  800e79:	75 dd                	jne    800e58 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e7e:	c9                   	leave  
  800e7f:	c3                   	ret    

00800e80 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e80:	55                   	push   %ebp
  800e81:	89 e5                	mov    %esp,%ebp
  800e83:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e92:	eb 2a                	jmp    800ebe <memcmp+0x3e>
		if (*s1 != *s2)
  800e94:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e97:	8a 10                	mov    (%eax),%dl
  800e99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9c:	8a 00                	mov    (%eax),%al
  800e9e:	38 c2                	cmp    %al,%dl
  800ea0:	74 16                	je     800eb8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea5:	8a 00                	mov    (%eax),%al
  800ea7:	0f b6 d0             	movzbl %al,%edx
  800eaa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	0f b6 c0             	movzbl %al,%eax
  800eb2:	29 c2                	sub    %eax,%edx
  800eb4:	89 d0                	mov    %edx,%eax
  800eb6:	eb 18                	jmp    800ed0 <memcmp+0x50>
		s1++, s2++;
  800eb8:	ff 45 fc             	incl   -0x4(%ebp)
  800ebb:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ebe:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec4:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec7:	85 c0                	test   %eax,%eax
  800ec9:	75 c9                	jne    800e94 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ecb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed0:	c9                   	leave  
  800ed1:	c3                   	ret    

00800ed2 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed2:	55                   	push   %ebp
  800ed3:	89 e5                	mov    %esp,%ebp
  800ed5:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ed8:	8b 55 08             	mov    0x8(%ebp),%edx
  800edb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ede:	01 d0                	add    %edx,%eax
  800ee0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee3:	eb 15                	jmp    800efa <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	0f b6 d0             	movzbl %al,%edx
  800eed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef0:	0f b6 c0             	movzbl %al,%eax
  800ef3:	39 c2                	cmp    %eax,%edx
  800ef5:	74 0d                	je     800f04 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ef7:	ff 45 08             	incl   0x8(%ebp)
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f00:	72 e3                	jb     800ee5 <memfind+0x13>
  800f02:	eb 01                	jmp    800f05 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f04:	90                   	nop
	return (void *) s;
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f08:	c9                   	leave  
  800f09:	c3                   	ret    

00800f0a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0a:	55                   	push   %ebp
  800f0b:	89 e5                	mov    %esp,%ebp
  800f0d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f10:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f17:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f1e:	eb 03                	jmp    800f23 <strtol+0x19>
		s++;
  800f20:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8a 00                	mov    (%eax),%al
  800f28:	3c 20                	cmp    $0x20,%al
  800f2a:	74 f4                	je     800f20 <strtol+0x16>
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	3c 09                	cmp    $0x9,%al
  800f33:	74 eb                	je     800f20 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	3c 2b                	cmp    $0x2b,%al
  800f3c:	75 05                	jne    800f43 <strtol+0x39>
		s++;
  800f3e:	ff 45 08             	incl   0x8(%ebp)
  800f41:	eb 13                	jmp    800f56 <strtol+0x4c>
	else if (*s == '-')
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	8a 00                	mov    (%eax),%al
  800f48:	3c 2d                	cmp    $0x2d,%al
  800f4a:	75 0a                	jne    800f56 <strtol+0x4c>
		s++, neg = 1;
  800f4c:	ff 45 08             	incl   0x8(%ebp)
  800f4f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5a:	74 06                	je     800f62 <strtol+0x58>
  800f5c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f60:	75 20                	jne    800f82 <strtol+0x78>
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	3c 30                	cmp    $0x30,%al
  800f69:	75 17                	jne    800f82 <strtol+0x78>
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	40                   	inc    %eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	3c 78                	cmp    $0x78,%al
  800f73:	75 0d                	jne    800f82 <strtol+0x78>
		s += 2, base = 16;
  800f75:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f79:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f80:	eb 28                	jmp    800faa <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f82:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f86:	75 15                	jne    800f9d <strtol+0x93>
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	3c 30                	cmp    $0x30,%al
  800f8f:	75 0c                	jne    800f9d <strtol+0x93>
		s++, base = 8;
  800f91:	ff 45 08             	incl   0x8(%ebp)
  800f94:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f9b:	eb 0d                	jmp    800faa <strtol+0xa0>
	else if (base == 0)
  800f9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa1:	75 07                	jne    800faa <strtol+0xa0>
		base = 10;
  800fa3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
  800fad:	8a 00                	mov    (%eax),%al
  800faf:	3c 2f                	cmp    $0x2f,%al
  800fb1:	7e 19                	jle    800fcc <strtol+0xc2>
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	3c 39                	cmp    $0x39,%al
  800fba:	7f 10                	jg     800fcc <strtol+0xc2>
			dig = *s - '0';
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	8a 00                	mov    (%eax),%al
  800fc1:	0f be c0             	movsbl %al,%eax
  800fc4:	83 e8 30             	sub    $0x30,%eax
  800fc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fca:	eb 42                	jmp    80100e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	3c 60                	cmp    $0x60,%al
  800fd3:	7e 19                	jle    800fee <strtol+0xe4>
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	8a 00                	mov    (%eax),%al
  800fda:	3c 7a                	cmp    $0x7a,%al
  800fdc:	7f 10                	jg     800fee <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	8a 00                	mov    (%eax),%al
  800fe3:	0f be c0             	movsbl %al,%eax
  800fe6:	83 e8 57             	sub    $0x57,%eax
  800fe9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fec:	eb 20                	jmp    80100e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff1:	8a 00                	mov    (%eax),%al
  800ff3:	3c 40                	cmp    $0x40,%al
  800ff5:	7e 39                	jle    801030 <strtol+0x126>
  800ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffa:	8a 00                	mov    (%eax),%al
  800ffc:	3c 5a                	cmp    $0x5a,%al
  800ffe:	7f 30                	jg     801030 <strtol+0x126>
			dig = *s - 'A' + 10;
  801000:	8b 45 08             	mov    0x8(%ebp),%eax
  801003:	8a 00                	mov    (%eax),%al
  801005:	0f be c0             	movsbl %al,%eax
  801008:	83 e8 37             	sub    $0x37,%eax
  80100b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80100e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801011:	3b 45 10             	cmp    0x10(%ebp),%eax
  801014:	7d 19                	jge    80102f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801016:	ff 45 08             	incl   0x8(%ebp)
  801019:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801020:	89 c2                	mov    %eax,%edx
  801022:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801025:	01 d0                	add    %edx,%eax
  801027:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102a:	e9 7b ff ff ff       	jmp    800faa <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80102f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801030:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801034:	74 08                	je     80103e <strtol+0x134>
		*endptr = (char *) s;
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	8b 55 08             	mov    0x8(%ebp),%edx
  80103c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80103e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801042:	74 07                	je     80104b <strtol+0x141>
  801044:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801047:	f7 d8                	neg    %eax
  801049:	eb 03                	jmp    80104e <strtol+0x144>
  80104b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80104e:	c9                   	leave  
  80104f:	c3                   	ret    

00801050 <ltostr>:

void
ltostr(long value, char *str)
{
  801050:	55                   	push   %ebp
  801051:	89 e5                	mov    %esp,%ebp
  801053:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801056:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80105d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801064:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801068:	79 13                	jns    80107d <ltostr+0x2d>
	{
		neg = 1;
  80106a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801071:	8b 45 0c             	mov    0xc(%ebp),%eax
  801074:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801077:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801085:	99                   	cltd   
  801086:	f7 f9                	idiv   %ecx
  801088:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80108b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108e:	8d 50 01             	lea    0x1(%eax),%edx
  801091:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801094:	89 c2                	mov    %eax,%edx
  801096:	8b 45 0c             	mov    0xc(%ebp),%eax
  801099:	01 d0                	add    %edx,%eax
  80109b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80109e:	83 c2 30             	add    $0x30,%edx
  8010a1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010a6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010ab:	f7 e9                	imul   %ecx
  8010ad:	c1 fa 02             	sar    $0x2,%edx
  8010b0:	89 c8                	mov    %ecx,%eax
  8010b2:	c1 f8 1f             	sar    $0x1f,%eax
  8010b5:	29 c2                	sub    %eax,%edx
  8010b7:	89 d0                	mov    %edx,%eax
  8010b9:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010bf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c4:	f7 e9                	imul   %ecx
  8010c6:	c1 fa 02             	sar    $0x2,%edx
  8010c9:	89 c8                	mov    %ecx,%eax
  8010cb:	c1 f8 1f             	sar    $0x1f,%eax
  8010ce:	29 c2                	sub    %eax,%edx
  8010d0:	89 d0                	mov    %edx,%eax
  8010d2:	c1 e0 02             	shl    $0x2,%eax
  8010d5:	01 d0                	add    %edx,%eax
  8010d7:	01 c0                	add    %eax,%eax
  8010d9:	29 c1                	sub    %eax,%ecx
  8010db:	89 ca                	mov    %ecx,%edx
  8010dd:	85 d2                	test   %edx,%edx
  8010df:	75 9c                	jne    80107d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010eb:	48                   	dec    %eax
  8010ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f3:	74 3d                	je     801132 <ltostr+0xe2>
		start = 1 ;
  8010f5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010fc:	eb 34                	jmp    801132 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801101:	8b 45 0c             	mov    0xc(%ebp),%eax
  801104:	01 d0                	add    %edx,%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80110b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80110e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801111:	01 c2                	add    %eax,%edx
  801113:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801116:	8b 45 0c             	mov    0xc(%ebp),%eax
  801119:	01 c8                	add    %ecx,%eax
  80111b:	8a 00                	mov    (%eax),%al
  80111d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80111f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801122:	8b 45 0c             	mov    0xc(%ebp),%eax
  801125:	01 c2                	add    %eax,%edx
  801127:	8a 45 eb             	mov    -0x15(%ebp),%al
  80112a:	88 02                	mov    %al,(%edx)
		start++ ;
  80112c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80112f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801132:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801135:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801138:	7c c4                	jl     8010fe <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80113a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80113d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801140:	01 d0                	add    %edx,%eax
  801142:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801145:	90                   	nop
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
  80114b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80114e:	ff 75 08             	pushl  0x8(%ebp)
  801151:	e8 54 fa ff ff       	call   800baa <strlen>
  801156:	83 c4 04             	add    $0x4,%esp
  801159:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80115c:	ff 75 0c             	pushl  0xc(%ebp)
  80115f:	e8 46 fa ff ff       	call   800baa <strlen>
  801164:	83 c4 04             	add    $0x4,%esp
  801167:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80116a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801171:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801178:	eb 17                	jmp    801191 <strcconcat+0x49>
		final[s] = str1[s] ;
  80117a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80117d:	8b 45 10             	mov    0x10(%ebp),%eax
  801180:	01 c2                	add    %eax,%edx
  801182:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	01 c8                	add    %ecx,%eax
  80118a:	8a 00                	mov    (%eax),%al
  80118c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80118e:	ff 45 fc             	incl   -0x4(%ebp)
  801191:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801194:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801197:	7c e1                	jl     80117a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801199:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011a7:	eb 1f                	jmp    8011c8 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ac:	8d 50 01             	lea    0x1(%eax),%edx
  8011af:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011b2:	89 c2                	mov    %eax,%edx
  8011b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b7:	01 c2                	add    %eax,%edx
  8011b9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bf:	01 c8                	add    %ecx,%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011c5:	ff 45 f8             	incl   -0x8(%ebp)
  8011c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ce:	7c d9                	jl     8011a9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d6:	01 d0                	add    %edx,%eax
  8011d8:	c6 00 00             	movb   $0x0,(%eax)
}
  8011db:	90                   	nop
  8011dc:	c9                   	leave  
  8011dd:	c3                   	ret    

008011de <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011de:	55                   	push   %ebp
  8011df:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ed:	8b 00                	mov    (%eax),%eax
  8011ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f9:	01 d0                	add    %edx,%eax
  8011fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801201:	eb 0c                	jmp    80120f <strsplit+0x31>
			*string++ = 0;
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	8d 50 01             	lea    0x1(%eax),%edx
  801209:	89 55 08             	mov    %edx,0x8(%ebp)
  80120c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
  801212:	8a 00                	mov    (%eax),%al
  801214:	84 c0                	test   %al,%al
  801216:	74 18                	je     801230 <strsplit+0x52>
  801218:	8b 45 08             	mov    0x8(%ebp),%eax
  80121b:	8a 00                	mov    (%eax),%al
  80121d:	0f be c0             	movsbl %al,%eax
  801220:	50                   	push   %eax
  801221:	ff 75 0c             	pushl  0xc(%ebp)
  801224:	e8 13 fb ff ff       	call   800d3c <strchr>
  801229:	83 c4 08             	add    $0x8,%esp
  80122c:	85 c0                	test   %eax,%eax
  80122e:	75 d3                	jne    801203 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	8a 00                	mov    (%eax),%al
  801235:	84 c0                	test   %al,%al
  801237:	74 5a                	je     801293 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801239:	8b 45 14             	mov    0x14(%ebp),%eax
  80123c:	8b 00                	mov    (%eax),%eax
  80123e:	83 f8 0f             	cmp    $0xf,%eax
  801241:	75 07                	jne    80124a <strsplit+0x6c>
		{
			return 0;
  801243:	b8 00 00 00 00       	mov    $0x0,%eax
  801248:	eb 66                	jmp    8012b0 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80124a:	8b 45 14             	mov    0x14(%ebp),%eax
  80124d:	8b 00                	mov    (%eax),%eax
  80124f:	8d 48 01             	lea    0x1(%eax),%ecx
  801252:	8b 55 14             	mov    0x14(%ebp),%edx
  801255:	89 0a                	mov    %ecx,(%edx)
  801257:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80125e:	8b 45 10             	mov    0x10(%ebp),%eax
  801261:	01 c2                	add    %eax,%edx
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801268:	eb 03                	jmp    80126d <strsplit+0x8f>
			string++;
  80126a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	8a 00                	mov    (%eax),%al
  801272:	84 c0                	test   %al,%al
  801274:	74 8b                	je     801201 <strsplit+0x23>
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	8a 00                	mov    (%eax),%al
  80127b:	0f be c0             	movsbl %al,%eax
  80127e:	50                   	push   %eax
  80127f:	ff 75 0c             	pushl  0xc(%ebp)
  801282:	e8 b5 fa ff ff       	call   800d3c <strchr>
  801287:	83 c4 08             	add    $0x8,%esp
  80128a:	85 c0                	test   %eax,%eax
  80128c:	74 dc                	je     80126a <strsplit+0x8c>
			string++;
	}
  80128e:	e9 6e ff ff ff       	jmp    801201 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801293:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801294:	8b 45 14             	mov    0x14(%ebp),%eax
  801297:	8b 00                	mov    (%eax),%eax
  801299:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a3:	01 d0                	add    %edx,%eax
  8012a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012ab:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b0:	c9                   	leave  
  8012b1:	c3                   	ret    

008012b2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012b2:	55                   	push   %ebp
  8012b3:	89 e5                	mov    %esp,%ebp
  8012b5:	57                   	push   %edi
  8012b6:	56                   	push   %esi
  8012b7:	53                   	push   %ebx
  8012b8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012c4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012c7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012ca:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012cd:	cd 30                	int    $0x30
  8012cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012d5:	83 c4 10             	add    $0x10,%esp
  8012d8:	5b                   	pop    %ebx
  8012d9:	5e                   	pop    %esi
  8012da:	5f                   	pop    %edi
  8012db:	5d                   	pop    %ebp
  8012dc:	c3                   	ret    

008012dd <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012dd:	55                   	push   %ebp
  8012de:	89 e5                	mov    %esp,%ebp
  8012e0:	83 ec 04             	sub    $0x4,%esp
  8012e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012e9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	52                   	push   %edx
  8012f5:	ff 75 0c             	pushl  0xc(%ebp)
  8012f8:	50                   	push   %eax
  8012f9:	6a 00                	push   $0x0
  8012fb:	e8 b2 ff ff ff       	call   8012b2 <syscall>
  801300:	83 c4 18             	add    $0x18,%esp
}
  801303:	90                   	nop
  801304:	c9                   	leave  
  801305:	c3                   	ret    

00801306 <sys_cgetc>:

int
sys_cgetc(void)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 00                	push   $0x0
  801313:	6a 01                	push   $0x1
  801315:	e8 98 ff ff ff       	call   8012b2 <syscall>
  80131a:	83 c4 18             	add    $0x18,%esp
}
  80131d:	c9                   	leave  
  80131e:	c3                   	ret    

0080131f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	50                   	push   %eax
  80132e:	6a 05                	push   $0x5
  801330:	e8 7d ff ff ff       	call   8012b2 <syscall>
  801335:	83 c4 18             	add    $0x18,%esp
}
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 02                	push   $0x2
  801349:	e8 64 ff ff ff       	call   8012b2 <syscall>
  80134e:	83 c4 18             	add    $0x18,%esp
}
  801351:	c9                   	leave  
  801352:	c3                   	ret    

00801353 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801353:	55                   	push   %ebp
  801354:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 03                	push   $0x3
  801362:	e8 4b ff ff ff       	call   8012b2 <syscall>
  801367:	83 c4 18             	add    $0x18,%esp
}
  80136a:	c9                   	leave  
  80136b:	c3                   	ret    

0080136c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80136c:	55                   	push   %ebp
  80136d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	6a 04                	push   $0x4
  80137b:	e8 32 ff ff ff       	call   8012b2 <syscall>
  801380:	83 c4 18             	add    $0x18,%esp
}
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <sys_env_exit>:


void sys_env_exit(void)
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	6a 06                	push   $0x6
  801394:	e8 19 ff ff ff       	call   8012b2 <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	90                   	nop
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	52                   	push   %edx
  8013af:	50                   	push   %eax
  8013b0:	6a 07                	push   $0x7
  8013b2:	e8 fb fe ff ff       	call   8012b2 <syscall>
  8013b7:	83 c4 18             	add    $0x18,%esp
}
  8013ba:	c9                   	leave  
  8013bb:	c3                   	ret    

008013bc <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013bc:	55                   	push   %ebp
  8013bd:	89 e5                	mov    %esp,%ebp
  8013bf:	56                   	push   %esi
  8013c0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013c1:	8b 75 18             	mov    0x18(%ebp),%esi
  8013c4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	56                   	push   %esi
  8013d1:	53                   	push   %ebx
  8013d2:	51                   	push   %ecx
  8013d3:	52                   	push   %edx
  8013d4:	50                   	push   %eax
  8013d5:	6a 08                	push   $0x8
  8013d7:	e8 d6 fe ff ff       	call   8012b2 <syscall>
  8013dc:	83 c4 18             	add    $0x18,%esp
}
  8013df:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013e2:	5b                   	pop    %ebx
  8013e3:	5e                   	pop    %esi
  8013e4:	5d                   	pop    %ebp
  8013e5:	c3                   	ret    

008013e6 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013e6:	55                   	push   %ebp
  8013e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	52                   	push   %edx
  8013f6:	50                   	push   %eax
  8013f7:	6a 09                	push   $0x9
  8013f9:	e8 b4 fe ff ff       	call   8012b2 <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
}
  801401:	c9                   	leave  
  801402:	c3                   	ret    

00801403 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801403:	55                   	push   %ebp
  801404:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	ff 75 0c             	pushl  0xc(%ebp)
  80140f:	ff 75 08             	pushl  0x8(%ebp)
  801412:	6a 0a                	push   $0xa
  801414:	e8 99 fe ff ff       	call   8012b2 <syscall>
  801419:	83 c4 18             	add    $0x18,%esp
}
  80141c:	c9                   	leave  
  80141d:	c3                   	ret    

0080141e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 0b                	push   $0xb
  80142d:	e8 80 fe ff ff       	call   8012b2 <syscall>
  801432:	83 c4 18             	add    $0x18,%esp
}
  801435:	c9                   	leave  
  801436:	c3                   	ret    

00801437 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801437:	55                   	push   %ebp
  801438:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 0c                	push   $0xc
  801446:	e8 67 fe ff ff       	call   8012b2 <syscall>
  80144b:	83 c4 18             	add    $0x18,%esp
}
  80144e:	c9                   	leave  
  80144f:	c3                   	ret    

00801450 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 0d                	push   $0xd
  80145f:	e8 4e fe ff ff       	call   8012b2 <syscall>
  801464:	83 c4 18             	add    $0x18,%esp
}
  801467:	c9                   	leave  
  801468:	c3                   	ret    

00801469 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801469:	55                   	push   %ebp
  80146a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	ff 75 0c             	pushl  0xc(%ebp)
  801475:	ff 75 08             	pushl  0x8(%ebp)
  801478:	6a 11                	push   $0x11
  80147a:	e8 33 fe ff ff       	call   8012b2 <syscall>
  80147f:	83 c4 18             	add    $0x18,%esp
	return;
  801482:	90                   	nop
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	ff 75 0c             	pushl  0xc(%ebp)
  801491:	ff 75 08             	pushl  0x8(%ebp)
  801494:	6a 12                	push   $0x12
  801496:	e8 17 fe ff ff       	call   8012b2 <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
	return ;
  80149e:	90                   	nop
}
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 0e                	push   $0xe
  8014b0:	e8 fd fd ff ff       	call   8012b2 <syscall>
  8014b5:	83 c4 18             	add    $0x18,%esp
}
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	ff 75 08             	pushl  0x8(%ebp)
  8014c8:	6a 0f                	push   $0xf
  8014ca:	e8 e3 fd ff ff       	call   8012b2 <syscall>
  8014cf:	83 c4 18             	add    $0x18,%esp
}
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 10                	push   $0x10
  8014e3:	e8 ca fd ff ff       	call   8012b2 <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
}
  8014eb:	90                   	nop
  8014ec:	c9                   	leave  
  8014ed:	c3                   	ret    

008014ee <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 14                	push   $0x14
  8014fd:	e8 b0 fd ff ff       	call   8012b2 <syscall>
  801502:	83 c4 18             	add    $0x18,%esp
}
  801505:	90                   	nop
  801506:	c9                   	leave  
  801507:	c3                   	ret    

00801508 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801508:	55                   	push   %ebp
  801509:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 15                	push   $0x15
  801517:	e8 96 fd ff ff       	call   8012b2 <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
}
  80151f:	90                   	nop
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <sys_cputc>:


void
sys_cputc(const char c)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
  801525:	83 ec 04             	sub    $0x4,%esp
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80152e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	50                   	push   %eax
  80153b:	6a 16                	push   $0x16
  80153d:	e8 70 fd ff ff       	call   8012b2 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	90                   	nop
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 17                	push   $0x17
  801557:	e8 56 fd ff ff       	call   8012b2 <syscall>
  80155c:	83 c4 18             	add    $0x18,%esp
}
  80155f:	90                   	nop
  801560:	c9                   	leave  
  801561:	c3                   	ret    

00801562 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	ff 75 0c             	pushl  0xc(%ebp)
  801571:	50                   	push   %eax
  801572:	6a 18                	push   $0x18
  801574:	e8 39 fd ff ff       	call   8012b2 <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801581:	8b 55 0c             	mov    0xc(%ebp),%edx
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	52                   	push   %edx
  80158e:	50                   	push   %eax
  80158f:	6a 1b                	push   $0x1b
  801591:	e8 1c fd ff ff       	call   8012b2 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80159e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	52                   	push   %edx
  8015ab:	50                   	push   %eax
  8015ac:	6a 19                	push   $0x19
  8015ae:	e8 ff fc ff ff       	call   8012b2 <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
}
  8015b6:	90                   	nop
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	52                   	push   %edx
  8015c9:	50                   	push   %eax
  8015ca:	6a 1a                	push   $0x1a
  8015cc:	e8 e1 fc ff ff       	call   8012b2 <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	90                   	nop
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
  8015da:	83 ec 04             	sub    $0x4,%esp
  8015dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015e3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015e6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	6a 00                	push   $0x0
  8015ef:	51                   	push   %ecx
  8015f0:	52                   	push   %edx
  8015f1:	ff 75 0c             	pushl  0xc(%ebp)
  8015f4:	50                   	push   %eax
  8015f5:	6a 1c                	push   $0x1c
  8015f7:	e8 b6 fc ff ff       	call   8012b2 <syscall>
  8015fc:	83 c4 18             	add    $0x18,%esp
}
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801604:	8b 55 0c             	mov    0xc(%ebp),%edx
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	52                   	push   %edx
  801611:	50                   	push   %eax
  801612:	6a 1d                	push   $0x1d
  801614:	e8 99 fc ff ff       	call   8012b2 <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
}
  80161c:	c9                   	leave  
  80161d:	c3                   	ret    

0080161e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801621:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801624:	8b 55 0c             	mov    0xc(%ebp),%edx
  801627:	8b 45 08             	mov    0x8(%ebp),%eax
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	51                   	push   %ecx
  80162f:	52                   	push   %edx
  801630:	50                   	push   %eax
  801631:	6a 1e                	push   $0x1e
  801633:	e8 7a fc ff ff       	call   8012b2 <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801640:	8b 55 0c             	mov    0xc(%ebp),%edx
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	52                   	push   %edx
  80164d:	50                   	push   %eax
  80164e:	6a 1f                	push   $0x1f
  801650:	e8 5d fc ff ff       	call   8012b2 <syscall>
  801655:	83 c4 18             	add    $0x18,%esp
}
  801658:	c9                   	leave  
  801659:	c3                   	ret    

0080165a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80165a:	55                   	push   %ebp
  80165b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 20                	push   $0x20
  801669:	e8 44 fc ff ff       	call   8012b2 <syscall>
  80166e:	83 c4 18             	add    $0x18,%esp
}
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	ff 75 10             	pushl  0x10(%ebp)
  801680:	ff 75 0c             	pushl  0xc(%ebp)
  801683:	50                   	push   %eax
  801684:	6a 21                	push   $0x21
  801686:	e8 27 fc ff ff       	call   8012b2 <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	50                   	push   %eax
  80169f:	6a 22                	push   $0x22
  8016a1:	e8 0c fc ff ff       	call   8012b2 <syscall>
  8016a6:	83 c4 18             	add    $0x18,%esp
}
  8016a9:	90                   	nop
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	50                   	push   %eax
  8016bb:	6a 23                	push   $0x23
  8016bd:	e8 f0 fb ff ff       	call   8012b2 <syscall>
  8016c2:	83 c4 18             	add    $0x18,%esp
}
  8016c5:	90                   	nop
  8016c6:	c9                   	leave  
  8016c7:	c3                   	ret    

008016c8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
  8016cb:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016ce:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016d1:	8d 50 04             	lea    0x4(%eax),%edx
  8016d4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	52                   	push   %edx
  8016de:	50                   	push   %eax
  8016df:	6a 24                	push   $0x24
  8016e1:	e8 cc fb ff ff       	call   8012b2 <syscall>
  8016e6:	83 c4 18             	add    $0x18,%esp
	return result;
  8016e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016f2:	89 01                	mov    %eax,(%ecx)
  8016f4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	c9                   	leave  
  8016fb:	c2 04 00             	ret    $0x4

008016fe <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	ff 75 10             	pushl  0x10(%ebp)
  801708:	ff 75 0c             	pushl  0xc(%ebp)
  80170b:	ff 75 08             	pushl  0x8(%ebp)
  80170e:	6a 13                	push   $0x13
  801710:	e8 9d fb ff ff       	call   8012b2 <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
	return ;
  801718:	90                   	nop
}
  801719:	c9                   	leave  
  80171a:	c3                   	ret    

0080171b <sys_rcr2>:
uint32 sys_rcr2()
{
  80171b:	55                   	push   %ebp
  80171c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 25                	push   $0x25
  80172a:	e8 83 fb ff ff       	call   8012b2 <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
}
  801732:	c9                   	leave  
  801733:	c3                   	ret    

00801734 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801734:	55                   	push   %ebp
  801735:	89 e5                	mov    %esp,%ebp
  801737:	83 ec 04             	sub    $0x4,%esp
  80173a:	8b 45 08             	mov    0x8(%ebp),%eax
  80173d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801740:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	50                   	push   %eax
  80174d:	6a 26                	push   $0x26
  80174f:	e8 5e fb ff ff       	call   8012b2 <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
	return ;
  801757:	90                   	nop
}
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <rsttst>:
void rsttst()
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 28                	push   $0x28
  801769:	e8 44 fb ff ff       	call   8012b2 <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
	return ;
  801771:	90                   	nop
}
  801772:	c9                   	leave  
  801773:	c3                   	ret    

00801774 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
  801777:	83 ec 04             	sub    $0x4,%esp
  80177a:	8b 45 14             	mov    0x14(%ebp),%eax
  80177d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801780:	8b 55 18             	mov    0x18(%ebp),%edx
  801783:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801787:	52                   	push   %edx
  801788:	50                   	push   %eax
  801789:	ff 75 10             	pushl  0x10(%ebp)
  80178c:	ff 75 0c             	pushl  0xc(%ebp)
  80178f:	ff 75 08             	pushl  0x8(%ebp)
  801792:	6a 27                	push   $0x27
  801794:	e8 19 fb ff ff       	call   8012b2 <syscall>
  801799:	83 c4 18             	add    $0x18,%esp
	return ;
  80179c:	90                   	nop
}
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <chktst>:
void chktst(uint32 n)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	ff 75 08             	pushl  0x8(%ebp)
  8017ad:	6a 29                	push   $0x29
  8017af:	e8 fe fa ff ff       	call   8012b2 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b7:	90                   	nop
}
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <inctst>:

void inctst()
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 2a                	push   $0x2a
  8017c9:	e8 e4 fa ff ff       	call   8012b2 <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d1:	90                   	nop
}
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <gettst>:
uint32 gettst()
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 2b                	push   $0x2b
  8017e3:	e8 ca fa ff ff       	call   8012b2 <syscall>
  8017e8:	83 c4 18             	add    $0x18,%esp
}
  8017eb:	c9                   	leave  
  8017ec:	c3                   	ret    

008017ed <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017ed:	55                   	push   %ebp
  8017ee:	89 e5                	mov    %esp,%ebp
  8017f0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 2c                	push   $0x2c
  8017ff:	e8 ae fa ff ff       	call   8012b2 <syscall>
  801804:	83 c4 18             	add    $0x18,%esp
  801807:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80180a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80180e:	75 07                	jne    801817 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801810:	b8 01 00 00 00       	mov    $0x1,%eax
  801815:	eb 05                	jmp    80181c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801817:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80181c:	c9                   	leave  
  80181d:	c3                   	ret    

0080181e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
  801821:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 2c                	push   $0x2c
  801830:	e8 7d fa ff ff       	call   8012b2 <syscall>
  801835:	83 c4 18             	add    $0x18,%esp
  801838:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80183b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80183f:	75 07                	jne    801848 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801841:	b8 01 00 00 00       	mov    $0x1,%eax
  801846:	eb 05                	jmp    80184d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801848:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
  801852:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 2c                	push   $0x2c
  801861:	e8 4c fa ff ff       	call   8012b2 <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
  801869:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80186c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801870:	75 07                	jne    801879 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801872:	b8 01 00 00 00       	mov    $0x1,%eax
  801877:	eb 05                	jmp    80187e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801879:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80187e:	c9                   	leave  
  80187f:	c3                   	ret    

00801880 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801880:	55                   	push   %ebp
  801881:	89 e5                	mov    %esp,%ebp
  801883:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 2c                	push   $0x2c
  801892:	e8 1b fa ff ff       	call   8012b2 <syscall>
  801897:	83 c4 18             	add    $0x18,%esp
  80189a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80189d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8018a1:	75 07                	jne    8018aa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8018a3:	b8 01 00 00 00       	mov    $0x1,%eax
  8018a8:	eb 05                	jmp    8018af <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8018aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	ff 75 08             	pushl  0x8(%ebp)
  8018bf:	6a 2d                	push   $0x2d
  8018c1:	e8 ec f9 ff ff       	call   8012b2 <syscall>
  8018c6:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c9:	90                   	nop
}
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
  8018cf:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8018d5:	89 d0                	mov    %edx,%eax
  8018d7:	c1 e0 02             	shl    $0x2,%eax
  8018da:	01 d0                	add    %edx,%eax
  8018dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018e3:	01 d0                	add    %edx,%eax
  8018e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ec:	01 d0                	add    %edx,%eax
  8018ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f5:	01 d0                	add    %edx,%eax
  8018f7:	c1 e0 04             	shl    $0x4,%eax
  8018fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801904:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801907:	83 ec 0c             	sub    $0xc,%esp
  80190a:	50                   	push   %eax
  80190b:	e8 b8 fd ff ff       	call   8016c8 <sys_get_virtual_time>
  801910:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801913:	eb 41                	jmp    801956 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801915:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801918:	83 ec 0c             	sub    $0xc,%esp
  80191b:	50                   	push   %eax
  80191c:	e8 a7 fd ff ff       	call   8016c8 <sys_get_virtual_time>
  801921:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801924:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801927:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80192a:	29 c2                	sub    %eax,%edx
  80192c:	89 d0                	mov    %edx,%eax
  80192e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801931:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801934:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801937:	89 d1                	mov    %edx,%ecx
  801939:	29 c1                	sub    %eax,%ecx
  80193b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80193e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801941:	39 c2                	cmp    %eax,%edx
  801943:	0f 97 c0             	seta   %al
  801946:	0f b6 c0             	movzbl %al,%eax
  801949:	29 c1                	sub    %eax,%ecx
  80194b:	89 c8                	mov    %ecx,%eax
  80194d:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801950:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801953:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801956:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801959:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80195c:	72 b7                	jb     801915 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80195e:	90                   	nop
  80195f:	c9                   	leave  
  801960:	c3                   	ret    

00801961 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
  801964:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801967:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80196e:	eb 03                	jmp    801973 <busy_wait+0x12>
  801970:	ff 45 fc             	incl   -0x4(%ebp)
  801973:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801976:	3b 45 08             	cmp    0x8(%ebp),%eax
  801979:	72 f5                	jb     801970 <busy_wait+0xf>
	return i;
  80197b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80197e:	c9                   	leave  
  80197f:	c3                   	ret    

00801980 <__udivdi3>:
  801980:	55                   	push   %ebp
  801981:	57                   	push   %edi
  801982:	56                   	push   %esi
  801983:	53                   	push   %ebx
  801984:	83 ec 1c             	sub    $0x1c,%esp
  801987:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80198b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80198f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801993:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801997:	89 ca                	mov    %ecx,%edx
  801999:	89 f8                	mov    %edi,%eax
  80199b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80199f:	85 f6                	test   %esi,%esi
  8019a1:	75 2d                	jne    8019d0 <__udivdi3+0x50>
  8019a3:	39 cf                	cmp    %ecx,%edi
  8019a5:	77 65                	ja     801a0c <__udivdi3+0x8c>
  8019a7:	89 fd                	mov    %edi,%ebp
  8019a9:	85 ff                	test   %edi,%edi
  8019ab:	75 0b                	jne    8019b8 <__udivdi3+0x38>
  8019ad:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b2:	31 d2                	xor    %edx,%edx
  8019b4:	f7 f7                	div    %edi
  8019b6:	89 c5                	mov    %eax,%ebp
  8019b8:	31 d2                	xor    %edx,%edx
  8019ba:	89 c8                	mov    %ecx,%eax
  8019bc:	f7 f5                	div    %ebp
  8019be:	89 c1                	mov    %eax,%ecx
  8019c0:	89 d8                	mov    %ebx,%eax
  8019c2:	f7 f5                	div    %ebp
  8019c4:	89 cf                	mov    %ecx,%edi
  8019c6:	89 fa                	mov    %edi,%edx
  8019c8:	83 c4 1c             	add    $0x1c,%esp
  8019cb:	5b                   	pop    %ebx
  8019cc:	5e                   	pop    %esi
  8019cd:	5f                   	pop    %edi
  8019ce:	5d                   	pop    %ebp
  8019cf:	c3                   	ret    
  8019d0:	39 ce                	cmp    %ecx,%esi
  8019d2:	77 28                	ja     8019fc <__udivdi3+0x7c>
  8019d4:	0f bd fe             	bsr    %esi,%edi
  8019d7:	83 f7 1f             	xor    $0x1f,%edi
  8019da:	75 40                	jne    801a1c <__udivdi3+0x9c>
  8019dc:	39 ce                	cmp    %ecx,%esi
  8019de:	72 0a                	jb     8019ea <__udivdi3+0x6a>
  8019e0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019e4:	0f 87 9e 00 00 00    	ja     801a88 <__udivdi3+0x108>
  8019ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ef:	89 fa                	mov    %edi,%edx
  8019f1:	83 c4 1c             	add    $0x1c,%esp
  8019f4:	5b                   	pop    %ebx
  8019f5:	5e                   	pop    %esi
  8019f6:	5f                   	pop    %edi
  8019f7:	5d                   	pop    %ebp
  8019f8:	c3                   	ret    
  8019f9:	8d 76 00             	lea    0x0(%esi),%esi
  8019fc:	31 ff                	xor    %edi,%edi
  8019fe:	31 c0                	xor    %eax,%eax
  801a00:	89 fa                	mov    %edi,%edx
  801a02:	83 c4 1c             	add    $0x1c,%esp
  801a05:	5b                   	pop    %ebx
  801a06:	5e                   	pop    %esi
  801a07:	5f                   	pop    %edi
  801a08:	5d                   	pop    %ebp
  801a09:	c3                   	ret    
  801a0a:	66 90                	xchg   %ax,%ax
  801a0c:	89 d8                	mov    %ebx,%eax
  801a0e:	f7 f7                	div    %edi
  801a10:	31 ff                	xor    %edi,%edi
  801a12:	89 fa                	mov    %edi,%edx
  801a14:	83 c4 1c             	add    $0x1c,%esp
  801a17:	5b                   	pop    %ebx
  801a18:	5e                   	pop    %esi
  801a19:	5f                   	pop    %edi
  801a1a:	5d                   	pop    %ebp
  801a1b:	c3                   	ret    
  801a1c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a21:	89 eb                	mov    %ebp,%ebx
  801a23:	29 fb                	sub    %edi,%ebx
  801a25:	89 f9                	mov    %edi,%ecx
  801a27:	d3 e6                	shl    %cl,%esi
  801a29:	89 c5                	mov    %eax,%ebp
  801a2b:	88 d9                	mov    %bl,%cl
  801a2d:	d3 ed                	shr    %cl,%ebp
  801a2f:	89 e9                	mov    %ebp,%ecx
  801a31:	09 f1                	or     %esi,%ecx
  801a33:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a37:	89 f9                	mov    %edi,%ecx
  801a39:	d3 e0                	shl    %cl,%eax
  801a3b:	89 c5                	mov    %eax,%ebp
  801a3d:	89 d6                	mov    %edx,%esi
  801a3f:	88 d9                	mov    %bl,%cl
  801a41:	d3 ee                	shr    %cl,%esi
  801a43:	89 f9                	mov    %edi,%ecx
  801a45:	d3 e2                	shl    %cl,%edx
  801a47:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a4b:	88 d9                	mov    %bl,%cl
  801a4d:	d3 e8                	shr    %cl,%eax
  801a4f:	09 c2                	or     %eax,%edx
  801a51:	89 d0                	mov    %edx,%eax
  801a53:	89 f2                	mov    %esi,%edx
  801a55:	f7 74 24 0c          	divl   0xc(%esp)
  801a59:	89 d6                	mov    %edx,%esi
  801a5b:	89 c3                	mov    %eax,%ebx
  801a5d:	f7 e5                	mul    %ebp
  801a5f:	39 d6                	cmp    %edx,%esi
  801a61:	72 19                	jb     801a7c <__udivdi3+0xfc>
  801a63:	74 0b                	je     801a70 <__udivdi3+0xf0>
  801a65:	89 d8                	mov    %ebx,%eax
  801a67:	31 ff                	xor    %edi,%edi
  801a69:	e9 58 ff ff ff       	jmp    8019c6 <__udivdi3+0x46>
  801a6e:	66 90                	xchg   %ax,%ax
  801a70:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a74:	89 f9                	mov    %edi,%ecx
  801a76:	d3 e2                	shl    %cl,%edx
  801a78:	39 c2                	cmp    %eax,%edx
  801a7a:	73 e9                	jae    801a65 <__udivdi3+0xe5>
  801a7c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a7f:	31 ff                	xor    %edi,%edi
  801a81:	e9 40 ff ff ff       	jmp    8019c6 <__udivdi3+0x46>
  801a86:	66 90                	xchg   %ax,%ax
  801a88:	31 c0                	xor    %eax,%eax
  801a8a:	e9 37 ff ff ff       	jmp    8019c6 <__udivdi3+0x46>
  801a8f:	90                   	nop

00801a90 <__umoddi3>:
  801a90:	55                   	push   %ebp
  801a91:	57                   	push   %edi
  801a92:	56                   	push   %esi
  801a93:	53                   	push   %ebx
  801a94:	83 ec 1c             	sub    $0x1c,%esp
  801a97:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a9b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a9f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aa3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801aa7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801aab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801aaf:	89 f3                	mov    %esi,%ebx
  801ab1:	89 fa                	mov    %edi,%edx
  801ab3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ab7:	89 34 24             	mov    %esi,(%esp)
  801aba:	85 c0                	test   %eax,%eax
  801abc:	75 1a                	jne    801ad8 <__umoddi3+0x48>
  801abe:	39 f7                	cmp    %esi,%edi
  801ac0:	0f 86 a2 00 00 00    	jbe    801b68 <__umoddi3+0xd8>
  801ac6:	89 c8                	mov    %ecx,%eax
  801ac8:	89 f2                	mov    %esi,%edx
  801aca:	f7 f7                	div    %edi
  801acc:	89 d0                	mov    %edx,%eax
  801ace:	31 d2                	xor    %edx,%edx
  801ad0:	83 c4 1c             	add    $0x1c,%esp
  801ad3:	5b                   	pop    %ebx
  801ad4:	5e                   	pop    %esi
  801ad5:	5f                   	pop    %edi
  801ad6:	5d                   	pop    %ebp
  801ad7:	c3                   	ret    
  801ad8:	39 f0                	cmp    %esi,%eax
  801ada:	0f 87 ac 00 00 00    	ja     801b8c <__umoddi3+0xfc>
  801ae0:	0f bd e8             	bsr    %eax,%ebp
  801ae3:	83 f5 1f             	xor    $0x1f,%ebp
  801ae6:	0f 84 ac 00 00 00    	je     801b98 <__umoddi3+0x108>
  801aec:	bf 20 00 00 00       	mov    $0x20,%edi
  801af1:	29 ef                	sub    %ebp,%edi
  801af3:	89 fe                	mov    %edi,%esi
  801af5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801af9:	89 e9                	mov    %ebp,%ecx
  801afb:	d3 e0                	shl    %cl,%eax
  801afd:	89 d7                	mov    %edx,%edi
  801aff:	89 f1                	mov    %esi,%ecx
  801b01:	d3 ef                	shr    %cl,%edi
  801b03:	09 c7                	or     %eax,%edi
  801b05:	89 e9                	mov    %ebp,%ecx
  801b07:	d3 e2                	shl    %cl,%edx
  801b09:	89 14 24             	mov    %edx,(%esp)
  801b0c:	89 d8                	mov    %ebx,%eax
  801b0e:	d3 e0                	shl    %cl,%eax
  801b10:	89 c2                	mov    %eax,%edx
  801b12:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b16:	d3 e0                	shl    %cl,%eax
  801b18:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b1c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b20:	89 f1                	mov    %esi,%ecx
  801b22:	d3 e8                	shr    %cl,%eax
  801b24:	09 d0                	or     %edx,%eax
  801b26:	d3 eb                	shr    %cl,%ebx
  801b28:	89 da                	mov    %ebx,%edx
  801b2a:	f7 f7                	div    %edi
  801b2c:	89 d3                	mov    %edx,%ebx
  801b2e:	f7 24 24             	mull   (%esp)
  801b31:	89 c6                	mov    %eax,%esi
  801b33:	89 d1                	mov    %edx,%ecx
  801b35:	39 d3                	cmp    %edx,%ebx
  801b37:	0f 82 87 00 00 00    	jb     801bc4 <__umoddi3+0x134>
  801b3d:	0f 84 91 00 00 00    	je     801bd4 <__umoddi3+0x144>
  801b43:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b47:	29 f2                	sub    %esi,%edx
  801b49:	19 cb                	sbb    %ecx,%ebx
  801b4b:	89 d8                	mov    %ebx,%eax
  801b4d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b51:	d3 e0                	shl    %cl,%eax
  801b53:	89 e9                	mov    %ebp,%ecx
  801b55:	d3 ea                	shr    %cl,%edx
  801b57:	09 d0                	or     %edx,%eax
  801b59:	89 e9                	mov    %ebp,%ecx
  801b5b:	d3 eb                	shr    %cl,%ebx
  801b5d:	89 da                	mov    %ebx,%edx
  801b5f:	83 c4 1c             	add    $0x1c,%esp
  801b62:	5b                   	pop    %ebx
  801b63:	5e                   	pop    %esi
  801b64:	5f                   	pop    %edi
  801b65:	5d                   	pop    %ebp
  801b66:	c3                   	ret    
  801b67:	90                   	nop
  801b68:	89 fd                	mov    %edi,%ebp
  801b6a:	85 ff                	test   %edi,%edi
  801b6c:	75 0b                	jne    801b79 <__umoddi3+0xe9>
  801b6e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b73:	31 d2                	xor    %edx,%edx
  801b75:	f7 f7                	div    %edi
  801b77:	89 c5                	mov    %eax,%ebp
  801b79:	89 f0                	mov    %esi,%eax
  801b7b:	31 d2                	xor    %edx,%edx
  801b7d:	f7 f5                	div    %ebp
  801b7f:	89 c8                	mov    %ecx,%eax
  801b81:	f7 f5                	div    %ebp
  801b83:	89 d0                	mov    %edx,%eax
  801b85:	e9 44 ff ff ff       	jmp    801ace <__umoddi3+0x3e>
  801b8a:	66 90                	xchg   %ax,%ax
  801b8c:	89 c8                	mov    %ecx,%eax
  801b8e:	89 f2                	mov    %esi,%edx
  801b90:	83 c4 1c             	add    $0x1c,%esp
  801b93:	5b                   	pop    %ebx
  801b94:	5e                   	pop    %esi
  801b95:	5f                   	pop    %edi
  801b96:	5d                   	pop    %ebp
  801b97:	c3                   	ret    
  801b98:	3b 04 24             	cmp    (%esp),%eax
  801b9b:	72 06                	jb     801ba3 <__umoddi3+0x113>
  801b9d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ba1:	77 0f                	ja     801bb2 <__umoddi3+0x122>
  801ba3:	89 f2                	mov    %esi,%edx
  801ba5:	29 f9                	sub    %edi,%ecx
  801ba7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bab:	89 14 24             	mov    %edx,(%esp)
  801bae:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bb2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bb6:	8b 14 24             	mov    (%esp),%edx
  801bb9:	83 c4 1c             	add    $0x1c,%esp
  801bbc:	5b                   	pop    %ebx
  801bbd:	5e                   	pop    %esi
  801bbe:	5f                   	pop    %edi
  801bbf:	5d                   	pop    %ebp
  801bc0:	c3                   	ret    
  801bc1:	8d 76 00             	lea    0x0(%esi),%esi
  801bc4:	2b 04 24             	sub    (%esp),%eax
  801bc7:	19 fa                	sbb    %edi,%edx
  801bc9:	89 d1                	mov    %edx,%ecx
  801bcb:	89 c6                	mov    %eax,%esi
  801bcd:	e9 71 ff ff ff       	jmp    801b43 <__umoddi3+0xb3>
  801bd2:	66 90                	xchg   %ax,%ax
  801bd4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bd8:	72 ea                	jb     801bc4 <__umoddi3+0x134>
  801bda:	89 d9                	mov    %ebx,%ecx
  801bdc:	e9 62 ff ff ff       	jmp    801b43 <__umoddi3+0xb3>
