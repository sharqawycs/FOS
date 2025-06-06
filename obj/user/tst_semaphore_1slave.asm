
obj/user/tst_semaphore_1slave:     file format elf32-i386


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
  800031:	e8 e0 00 00 00       	call   800116 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Slave program: enter critical section, print it's ID, exit and signal the master program
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 cd 12 00 00       	call   801310 <sys_getparentenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int id = sys_getenvindex();
  800046:	e8 ac 12 00 00       	call   8012f7 <sys_getenvindex>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("%d: before the critical section\n", id);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f0             	pushl  -0x10(%ebp)
  800054:	68 a0 1b 80 00       	push   $0x801ba0
  800059:	e8 6e 04 00 00       	call   8004cc <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	sys_waitSemaphore(parentenvID, "cs1") ;
  800061:	83 ec 08             	sub    $0x8,%esp
  800064:	68 c1 1b 80 00       	push   $0x801bc1
  800069:	ff 75 f4             	pushl  -0xc(%ebp)
  80006c:	e8 ce 14 00 00       	call   80153f <sys_waitSemaphore>
  800071:	83 c4 10             	add    $0x10,%esp
		cprintf("%d: inside the critical section\n", id) ;
  800074:	83 ec 08             	sub    $0x8,%esp
  800077:	ff 75 f0             	pushl  -0x10(%ebp)
  80007a:	68 c8 1b 80 00       	push   $0x801bc8
  80007f:	e8 48 04 00 00       	call   8004cc <cprintf>
  800084:	83 c4 10             	add    $0x10,%esp
		cprintf("my ID is %d\n", id);
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	ff 75 f0             	pushl  -0x10(%ebp)
  80008d:	68 e9 1b 80 00       	push   $0x801be9
  800092:	e8 35 04 00 00       	call   8004cc <cprintf>
  800097:	83 c4 10             	add    $0x10,%esp
		int sem1val = sys_getSemaphoreValue(parentenvID, "cs1");
  80009a:	83 ec 08             	sub    $0x8,%esp
  80009d:	68 c1 1b 80 00       	push   $0x801bc1
  8000a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8000a5:	e8 78 14 00 00       	call   801522 <sys_getSemaphoreValue>
  8000aa:	83 c4 10             	add    $0x10,%esp
  8000ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (sem1val > 0)
  8000b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8000b4:	7e 14                	jle    8000ca <_main+0x92>
			panic("Error: more than 1 process inside the CS... please review your semaphore code again...");
  8000b6:	83 ec 04             	sub    $0x4,%esp
  8000b9:	68 f8 1b 80 00       	push   $0x801bf8
  8000be:	6a 11                	push   $0x11
  8000c0:	68 4f 1c 80 00       	push   $0x801c4f
  8000c5:	e8 4e 01 00 00       	call   800218 <_panic>
		env_sleep(1000) ;
  8000ca:	83 ec 0c             	sub    $0xc,%esp
  8000cd:	68 e8 03 00 00       	push   $0x3e8
  8000d2:	e8 99 17 00 00       	call   801870 <env_sleep>
  8000d7:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "cs1") ;
  8000da:	83 ec 08             	sub    $0x8,%esp
  8000dd:	68 c1 1b 80 00       	push   $0x801bc1
  8000e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8000e5:	e8 73 14 00 00       	call   80155d <sys_signalSemaphore>
  8000ea:	83 c4 10             	add    $0x10,%esp

	cprintf("%d: after the critical section\n", id);
  8000ed:	83 ec 08             	sub    $0x8,%esp
  8000f0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000f3:	68 6c 1c 80 00       	push   $0x801c6c
  8000f8:	e8 cf 03 00 00       	call   8004cc <cprintf>
  8000fd:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "depend1") ;
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	68 8c 1c 80 00       	push   $0x801c8c
  800108:	ff 75 f4             	pushl  -0xc(%ebp)
  80010b:	e8 4d 14 00 00       	call   80155d <sys_signalSemaphore>
  800110:	83 c4 10             	add    $0x10,%esp
	return;
  800113:	90                   	nop
}
  800114:	c9                   	leave  
  800115:	c3                   	ret    

00800116 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800116:	55                   	push   %ebp
  800117:	89 e5                	mov    %esp,%ebp
  800119:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80011c:	e8 d6 11 00 00       	call   8012f7 <sys_getenvindex>
  800121:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800124:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800127:	89 d0                	mov    %edx,%eax
  800129:	01 c0                	add    %eax,%eax
  80012b:	01 d0                	add    %edx,%eax
  80012d:	c1 e0 02             	shl    $0x2,%eax
  800130:	01 d0                	add    %edx,%eax
  800132:	c1 e0 06             	shl    $0x6,%eax
  800135:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80013a:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80013f:	a1 04 30 80 00       	mov    0x803004,%eax
  800144:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80014a:	84 c0                	test   %al,%al
  80014c:	74 0f                	je     80015d <libmain+0x47>
		binaryname = myEnv->prog_name;
  80014e:	a1 04 30 80 00       	mov    0x803004,%eax
  800153:	05 f4 02 00 00       	add    $0x2f4,%eax
  800158:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80015d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800161:	7e 0a                	jle    80016d <libmain+0x57>
		binaryname = argv[0];
  800163:	8b 45 0c             	mov    0xc(%ebp),%eax
  800166:	8b 00                	mov    (%eax),%eax
  800168:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80016d:	83 ec 08             	sub    $0x8,%esp
  800170:	ff 75 0c             	pushl  0xc(%ebp)
  800173:	ff 75 08             	pushl  0x8(%ebp)
  800176:	e8 bd fe ff ff       	call   800038 <_main>
  80017b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80017e:	e8 0f 13 00 00       	call   801492 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800183:	83 ec 0c             	sub    $0xc,%esp
  800186:	68 ac 1c 80 00       	push   $0x801cac
  80018b:	e8 3c 03 00 00       	call   8004cc <cprintf>
  800190:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800193:	a1 04 30 80 00       	mov    0x803004,%eax
  800198:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80019e:	a1 04 30 80 00       	mov    0x803004,%eax
  8001a3:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001a9:	83 ec 04             	sub    $0x4,%esp
  8001ac:	52                   	push   %edx
  8001ad:	50                   	push   %eax
  8001ae:	68 d4 1c 80 00       	push   $0x801cd4
  8001b3:	e8 14 03 00 00       	call   8004cc <cprintf>
  8001b8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001bb:	a1 04 30 80 00       	mov    0x803004,%eax
  8001c0:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001c6:	83 ec 08             	sub    $0x8,%esp
  8001c9:	50                   	push   %eax
  8001ca:	68 f9 1c 80 00       	push   $0x801cf9
  8001cf:	e8 f8 02 00 00       	call   8004cc <cprintf>
  8001d4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001d7:	83 ec 0c             	sub    $0xc,%esp
  8001da:	68 ac 1c 80 00       	push   $0x801cac
  8001df:	e8 e8 02 00 00       	call   8004cc <cprintf>
  8001e4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001e7:	e8 c0 12 00 00       	call   8014ac <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001ec:	e8 19 00 00 00       	call   80020a <exit>
}
  8001f1:	90                   	nop
  8001f2:	c9                   	leave  
  8001f3:	c3                   	ret    

008001f4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001f4:	55                   	push   %ebp
  8001f5:	89 e5                	mov    %esp,%ebp
  8001f7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001fa:	83 ec 0c             	sub    $0xc,%esp
  8001fd:	6a 00                	push   $0x0
  8001ff:	e8 bf 10 00 00       	call   8012c3 <sys_env_destroy>
  800204:	83 c4 10             	add    $0x10,%esp
}
  800207:	90                   	nop
  800208:	c9                   	leave  
  800209:	c3                   	ret    

0080020a <exit>:

void
exit(void)
{
  80020a:	55                   	push   %ebp
  80020b:	89 e5                	mov    %esp,%ebp
  80020d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800210:	e8 14 11 00 00       	call   801329 <sys_env_exit>
}
  800215:	90                   	nop
  800216:	c9                   	leave  
  800217:	c3                   	ret    

00800218 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800218:	55                   	push   %ebp
  800219:	89 e5                	mov    %esp,%ebp
  80021b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80021e:	8d 45 10             	lea    0x10(%ebp),%eax
  800221:	83 c0 04             	add    $0x4,%eax
  800224:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800227:	a1 14 30 80 00       	mov    0x803014,%eax
  80022c:	85 c0                	test   %eax,%eax
  80022e:	74 16                	je     800246 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800230:	a1 14 30 80 00       	mov    0x803014,%eax
  800235:	83 ec 08             	sub    $0x8,%esp
  800238:	50                   	push   %eax
  800239:	68 10 1d 80 00       	push   $0x801d10
  80023e:	e8 89 02 00 00       	call   8004cc <cprintf>
  800243:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800246:	a1 00 30 80 00       	mov    0x803000,%eax
  80024b:	ff 75 0c             	pushl  0xc(%ebp)
  80024e:	ff 75 08             	pushl  0x8(%ebp)
  800251:	50                   	push   %eax
  800252:	68 15 1d 80 00       	push   $0x801d15
  800257:	e8 70 02 00 00       	call   8004cc <cprintf>
  80025c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80025f:	8b 45 10             	mov    0x10(%ebp),%eax
  800262:	83 ec 08             	sub    $0x8,%esp
  800265:	ff 75 f4             	pushl  -0xc(%ebp)
  800268:	50                   	push   %eax
  800269:	e8 f3 01 00 00       	call   800461 <vcprintf>
  80026e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800271:	83 ec 08             	sub    $0x8,%esp
  800274:	6a 00                	push   $0x0
  800276:	68 31 1d 80 00       	push   $0x801d31
  80027b:	e8 e1 01 00 00       	call   800461 <vcprintf>
  800280:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800283:	e8 82 ff ff ff       	call   80020a <exit>

	// should not return here
	while (1) ;
  800288:	eb fe                	jmp    800288 <_panic+0x70>

0080028a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80028a:	55                   	push   %ebp
  80028b:	89 e5                	mov    %esp,%ebp
  80028d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800290:	a1 04 30 80 00       	mov    0x803004,%eax
  800295:	8b 50 74             	mov    0x74(%eax),%edx
  800298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029b:	39 c2                	cmp    %eax,%edx
  80029d:	74 14                	je     8002b3 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80029f:	83 ec 04             	sub    $0x4,%esp
  8002a2:	68 34 1d 80 00       	push   $0x801d34
  8002a7:	6a 26                	push   $0x26
  8002a9:	68 80 1d 80 00       	push   $0x801d80
  8002ae:	e8 65 ff ff ff       	call   800218 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002c1:	e9 c2 00 00 00       	jmp    800388 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d3:	01 d0                	add    %edx,%eax
  8002d5:	8b 00                	mov    (%eax),%eax
  8002d7:	85 c0                	test   %eax,%eax
  8002d9:	75 08                	jne    8002e3 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002db:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002de:	e9 a2 00 00 00       	jmp    800385 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8002e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002ea:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002f1:	eb 69                	jmp    80035c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002f3:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8002fe:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800301:	89 d0                	mov    %edx,%eax
  800303:	01 c0                	add    %eax,%eax
  800305:	01 d0                	add    %edx,%eax
  800307:	c1 e0 02             	shl    $0x2,%eax
  80030a:	01 c8                	add    %ecx,%eax
  80030c:	8a 40 04             	mov    0x4(%eax),%al
  80030f:	84 c0                	test   %al,%al
  800311:	75 46                	jne    800359 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800313:	a1 04 30 80 00       	mov    0x803004,%eax
  800318:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80031e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800321:	89 d0                	mov    %edx,%eax
  800323:	01 c0                	add    %eax,%eax
  800325:	01 d0                	add    %edx,%eax
  800327:	c1 e0 02             	shl    $0x2,%eax
  80032a:	01 c8                	add    %ecx,%eax
  80032c:	8b 00                	mov    (%eax),%eax
  80032e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800331:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800334:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800339:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80033b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800345:	8b 45 08             	mov    0x8(%ebp),%eax
  800348:	01 c8                	add    %ecx,%eax
  80034a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80034c:	39 c2                	cmp    %eax,%edx
  80034e:	75 09                	jne    800359 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800350:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800357:	eb 12                	jmp    80036b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800359:	ff 45 e8             	incl   -0x18(%ebp)
  80035c:	a1 04 30 80 00       	mov    0x803004,%eax
  800361:	8b 50 74             	mov    0x74(%eax),%edx
  800364:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800367:	39 c2                	cmp    %eax,%edx
  800369:	77 88                	ja     8002f3 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80036b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80036f:	75 14                	jne    800385 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800371:	83 ec 04             	sub    $0x4,%esp
  800374:	68 8c 1d 80 00       	push   $0x801d8c
  800379:	6a 3a                	push   $0x3a
  80037b:	68 80 1d 80 00       	push   $0x801d80
  800380:	e8 93 fe ff ff       	call   800218 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800385:	ff 45 f0             	incl   -0x10(%ebp)
  800388:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80038b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80038e:	0f 8c 32 ff ff ff    	jl     8002c6 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800394:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80039b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003a2:	eb 26                	jmp    8003ca <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003a4:	a1 04 30 80 00       	mov    0x803004,%eax
  8003a9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003af:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003b2:	89 d0                	mov    %edx,%eax
  8003b4:	01 c0                	add    %eax,%eax
  8003b6:	01 d0                	add    %edx,%eax
  8003b8:	c1 e0 02             	shl    $0x2,%eax
  8003bb:	01 c8                	add    %ecx,%eax
  8003bd:	8a 40 04             	mov    0x4(%eax),%al
  8003c0:	3c 01                	cmp    $0x1,%al
  8003c2:	75 03                	jne    8003c7 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003c4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c7:	ff 45 e0             	incl   -0x20(%ebp)
  8003ca:	a1 04 30 80 00       	mov    0x803004,%eax
  8003cf:	8b 50 74             	mov    0x74(%eax),%edx
  8003d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003d5:	39 c2                	cmp    %eax,%edx
  8003d7:	77 cb                	ja     8003a4 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003dc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003df:	74 14                	je     8003f5 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8003e1:	83 ec 04             	sub    $0x4,%esp
  8003e4:	68 e0 1d 80 00       	push   $0x801de0
  8003e9:	6a 44                	push   $0x44
  8003eb:	68 80 1d 80 00       	push   $0x801d80
  8003f0:	e8 23 fe ff ff       	call   800218 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8003f5:	90                   	nop
  8003f6:	c9                   	leave  
  8003f7:	c3                   	ret    

008003f8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8003f8:	55                   	push   %ebp
  8003f9:	89 e5                	mov    %esp,%ebp
  8003fb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8003fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800401:	8b 00                	mov    (%eax),%eax
  800403:	8d 48 01             	lea    0x1(%eax),%ecx
  800406:	8b 55 0c             	mov    0xc(%ebp),%edx
  800409:	89 0a                	mov    %ecx,(%edx)
  80040b:	8b 55 08             	mov    0x8(%ebp),%edx
  80040e:	88 d1                	mov    %dl,%cl
  800410:	8b 55 0c             	mov    0xc(%ebp),%edx
  800413:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800417:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800421:	75 2c                	jne    80044f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800423:	a0 08 30 80 00       	mov    0x803008,%al
  800428:	0f b6 c0             	movzbl %al,%eax
  80042b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80042e:	8b 12                	mov    (%edx),%edx
  800430:	89 d1                	mov    %edx,%ecx
  800432:	8b 55 0c             	mov    0xc(%ebp),%edx
  800435:	83 c2 08             	add    $0x8,%edx
  800438:	83 ec 04             	sub    $0x4,%esp
  80043b:	50                   	push   %eax
  80043c:	51                   	push   %ecx
  80043d:	52                   	push   %edx
  80043e:	e8 3e 0e 00 00       	call   801281 <sys_cputs>
  800443:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800446:	8b 45 0c             	mov    0xc(%ebp),%eax
  800449:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80044f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800452:	8b 40 04             	mov    0x4(%eax),%eax
  800455:	8d 50 01             	lea    0x1(%eax),%edx
  800458:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80045e:	90                   	nop
  80045f:	c9                   	leave  
  800460:	c3                   	ret    

00800461 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800461:	55                   	push   %ebp
  800462:	89 e5                	mov    %esp,%ebp
  800464:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80046a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800471:	00 00 00 
	b.cnt = 0;
  800474:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80047b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80047e:	ff 75 0c             	pushl  0xc(%ebp)
  800481:	ff 75 08             	pushl  0x8(%ebp)
  800484:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80048a:	50                   	push   %eax
  80048b:	68 f8 03 80 00       	push   $0x8003f8
  800490:	e8 11 02 00 00       	call   8006a6 <vprintfmt>
  800495:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800498:	a0 08 30 80 00       	mov    0x803008,%al
  80049d:	0f b6 c0             	movzbl %al,%eax
  8004a0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004a6:	83 ec 04             	sub    $0x4,%esp
  8004a9:	50                   	push   %eax
  8004aa:	52                   	push   %edx
  8004ab:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004b1:	83 c0 08             	add    $0x8,%eax
  8004b4:	50                   	push   %eax
  8004b5:	e8 c7 0d 00 00       	call   801281 <sys_cputs>
  8004ba:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004bd:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  8004c4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004ca:	c9                   	leave  
  8004cb:	c3                   	ret    

008004cc <cprintf>:

int cprintf(const char *fmt, ...) {
  8004cc:	55                   	push   %ebp
  8004cd:	89 e5                	mov    %esp,%ebp
  8004cf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004d2:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  8004d9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004df:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e2:	83 ec 08             	sub    $0x8,%esp
  8004e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004e8:	50                   	push   %eax
  8004e9:	e8 73 ff ff ff       	call   800461 <vcprintf>
  8004ee:	83 c4 10             	add    $0x10,%esp
  8004f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004f7:	c9                   	leave  
  8004f8:	c3                   	ret    

008004f9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8004f9:	55                   	push   %ebp
  8004fa:	89 e5                	mov    %esp,%ebp
  8004fc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004ff:	e8 8e 0f 00 00       	call   801492 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800504:	8d 45 0c             	lea    0xc(%ebp),%eax
  800507:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80050a:	8b 45 08             	mov    0x8(%ebp),%eax
  80050d:	83 ec 08             	sub    $0x8,%esp
  800510:	ff 75 f4             	pushl  -0xc(%ebp)
  800513:	50                   	push   %eax
  800514:	e8 48 ff ff ff       	call   800461 <vcprintf>
  800519:	83 c4 10             	add    $0x10,%esp
  80051c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80051f:	e8 88 0f 00 00       	call   8014ac <sys_enable_interrupt>
	return cnt;
  800524:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800527:	c9                   	leave  
  800528:	c3                   	ret    

00800529 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800529:	55                   	push   %ebp
  80052a:	89 e5                	mov    %esp,%ebp
  80052c:	53                   	push   %ebx
  80052d:	83 ec 14             	sub    $0x14,%esp
  800530:	8b 45 10             	mov    0x10(%ebp),%eax
  800533:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800536:	8b 45 14             	mov    0x14(%ebp),%eax
  800539:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80053c:	8b 45 18             	mov    0x18(%ebp),%eax
  80053f:	ba 00 00 00 00       	mov    $0x0,%edx
  800544:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800547:	77 55                	ja     80059e <printnum+0x75>
  800549:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80054c:	72 05                	jb     800553 <printnum+0x2a>
  80054e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800551:	77 4b                	ja     80059e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800553:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800556:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800559:	8b 45 18             	mov    0x18(%ebp),%eax
  80055c:	ba 00 00 00 00       	mov    $0x0,%edx
  800561:	52                   	push   %edx
  800562:	50                   	push   %eax
  800563:	ff 75 f4             	pushl  -0xc(%ebp)
  800566:	ff 75 f0             	pushl  -0x10(%ebp)
  800569:	e8 b6 13 00 00       	call   801924 <__udivdi3>
  80056e:	83 c4 10             	add    $0x10,%esp
  800571:	83 ec 04             	sub    $0x4,%esp
  800574:	ff 75 20             	pushl  0x20(%ebp)
  800577:	53                   	push   %ebx
  800578:	ff 75 18             	pushl  0x18(%ebp)
  80057b:	52                   	push   %edx
  80057c:	50                   	push   %eax
  80057d:	ff 75 0c             	pushl  0xc(%ebp)
  800580:	ff 75 08             	pushl  0x8(%ebp)
  800583:	e8 a1 ff ff ff       	call   800529 <printnum>
  800588:	83 c4 20             	add    $0x20,%esp
  80058b:	eb 1a                	jmp    8005a7 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80058d:	83 ec 08             	sub    $0x8,%esp
  800590:	ff 75 0c             	pushl  0xc(%ebp)
  800593:	ff 75 20             	pushl  0x20(%ebp)
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	ff d0                	call   *%eax
  80059b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80059e:	ff 4d 1c             	decl   0x1c(%ebp)
  8005a1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005a5:	7f e6                	jg     80058d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005a7:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005aa:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005af:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005b5:	53                   	push   %ebx
  8005b6:	51                   	push   %ecx
  8005b7:	52                   	push   %edx
  8005b8:	50                   	push   %eax
  8005b9:	e8 76 14 00 00       	call   801a34 <__umoddi3>
  8005be:	83 c4 10             	add    $0x10,%esp
  8005c1:	05 54 20 80 00       	add    $0x802054,%eax
  8005c6:	8a 00                	mov    (%eax),%al
  8005c8:	0f be c0             	movsbl %al,%eax
  8005cb:	83 ec 08             	sub    $0x8,%esp
  8005ce:	ff 75 0c             	pushl  0xc(%ebp)
  8005d1:	50                   	push   %eax
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	ff d0                	call   *%eax
  8005d7:	83 c4 10             	add    $0x10,%esp
}
  8005da:	90                   	nop
  8005db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005de:	c9                   	leave  
  8005df:	c3                   	ret    

008005e0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005e0:	55                   	push   %ebp
  8005e1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005e3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005e7:	7e 1c                	jle    800605 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	8b 00                	mov    (%eax),%eax
  8005ee:	8d 50 08             	lea    0x8(%eax),%edx
  8005f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f4:	89 10                	mov    %edx,(%eax)
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	8b 00                	mov    (%eax),%eax
  8005fb:	83 e8 08             	sub    $0x8,%eax
  8005fe:	8b 50 04             	mov    0x4(%eax),%edx
  800601:	8b 00                	mov    (%eax),%eax
  800603:	eb 40                	jmp    800645 <getuint+0x65>
	else if (lflag)
  800605:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800609:	74 1e                	je     800629 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80060b:	8b 45 08             	mov    0x8(%ebp),%eax
  80060e:	8b 00                	mov    (%eax),%eax
  800610:	8d 50 04             	lea    0x4(%eax),%edx
  800613:	8b 45 08             	mov    0x8(%ebp),%eax
  800616:	89 10                	mov    %edx,(%eax)
  800618:	8b 45 08             	mov    0x8(%ebp),%eax
  80061b:	8b 00                	mov    (%eax),%eax
  80061d:	83 e8 04             	sub    $0x4,%eax
  800620:	8b 00                	mov    (%eax),%eax
  800622:	ba 00 00 00 00       	mov    $0x0,%edx
  800627:	eb 1c                	jmp    800645 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800629:	8b 45 08             	mov    0x8(%ebp),%eax
  80062c:	8b 00                	mov    (%eax),%eax
  80062e:	8d 50 04             	lea    0x4(%eax),%edx
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	89 10                	mov    %edx,(%eax)
  800636:	8b 45 08             	mov    0x8(%ebp),%eax
  800639:	8b 00                	mov    (%eax),%eax
  80063b:	83 e8 04             	sub    $0x4,%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800645:	5d                   	pop    %ebp
  800646:	c3                   	ret    

00800647 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800647:	55                   	push   %ebp
  800648:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80064a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80064e:	7e 1c                	jle    80066c <getint+0x25>
		return va_arg(*ap, long long);
  800650:	8b 45 08             	mov    0x8(%ebp),%eax
  800653:	8b 00                	mov    (%eax),%eax
  800655:	8d 50 08             	lea    0x8(%eax),%edx
  800658:	8b 45 08             	mov    0x8(%ebp),%eax
  80065b:	89 10                	mov    %edx,(%eax)
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	8b 00                	mov    (%eax),%eax
  800662:	83 e8 08             	sub    $0x8,%eax
  800665:	8b 50 04             	mov    0x4(%eax),%edx
  800668:	8b 00                	mov    (%eax),%eax
  80066a:	eb 38                	jmp    8006a4 <getint+0x5d>
	else if (lflag)
  80066c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800670:	74 1a                	je     80068c <getint+0x45>
		return va_arg(*ap, long);
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8b 00                	mov    (%eax),%eax
  800677:	8d 50 04             	lea    0x4(%eax),%edx
  80067a:	8b 45 08             	mov    0x8(%ebp),%eax
  80067d:	89 10                	mov    %edx,(%eax)
  80067f:	8b 45 08             	mov    0x8(%ebp),%eax
  800682:	8b 00                	mov    (%eax),%eax
  800684:	83 e8 04             	sub    $0x4,%eax
  800687:	8b 00                	mov    (%eax),%eax
  800689:	99                   	cltd   
  80068a:	eb 18                	jmp    8006a4 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	8d 50 04             	lea    0x4(%eax),%edx
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	89 10                	mov    %edx,(%eax)
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	83 e8 04             	sub    $0x4,%eax
  8006a1:	8b 00                	mov    (%eax),%eax
  8006a3:	99                   	cltd   
}
  8006a4:	5d                   	pop    %ebp
  8006a5:	c3                   	ret    

008006a6 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006a6:	55                   	push   %ebp
  8006a7:	89 e5                	mov    %esp,%ebp
  8006a9:	56                   	push   %esi
  8006aa:	53                   	push   %ebx
  8006ab:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ae:	eb 17                	jmp    8006c7 <vprintfmt+0x21>
			if (ch == '\0')
  8006b0:	85 db                	test   %ebx,%ebx
  8006b2:	0f 84 af 03 00 00    	je     800a67 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006b8:	83 ec 08             	sub    $0x8,%esp
  8006bb:	ff 75 0c             	pushl  0xc(%ebp)
  8006be:	53                   	push   %ebx
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	ff d0                	call   *%eax
  8006c4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ca:	8d 50 01             	lea    0x1(%eax),%edx
  8006cd:	89 55 10             	mov    %edx,0x10(%ebp)
  8006d0:	8a 00                	mov    (%eax),%al
  8006d2:	0f b6 d8             	movzbl %al,%ebx
  8006d5:	83 fb 25             	cmp    $0x25,%ebx
  8006d8:	75 d6                	jne    8006b0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006da:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006de:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006e5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006ec:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006f3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8006fd:	8d 50 01             	lea    0x1(%eax),%edx
  800700:	89 55 10             	mov    %edx,0x10(%ebp)
  800703:	8a 00                	mov    (%eax),%al
  800705:	0f b6 d8             	movzbl %al,%ebx
  800708:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80070b:	83 f8 55             	cmp    $0x55,%eax
  80070e:	0f 87 2b 03 00 00    	ja     800a3f <vprintfmt+0x399>
  800714:	8b 04 85 78 20 80 00 	mov    0x802078(,%eax,4),%eax
  80071b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80071d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800721:	eb d7                	jmp    8006fa <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800723:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800727:	eb d1                	jmp    8006fa <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800729:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800730:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800733:	89 d0                	mov    %edx,%eax
  800735:	c1 e0 02             	shl    $0x2,%eax
  800738:	01 d0                	add    %edx,%eax
  80073a:	01 c0                	add    %eax,%eax
  80073c:	01 d8                	add    %ebx,%eax
  80073e:	83 e8 30             	sub    $0x30,%eax
  800741:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800744:	8b 45 10             	mov    0x10(%ebp),%eax
  800747:	8a 00                	mov    (%eax),%al
  800749:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80074c:	83 fb 2f             	cmp    $0x2f,%ebx
  80074f:	7e 3e                	jle    80078f <vprintfmt+0xe9>
  800751:	83 fb 39             	cmp    $0x39,%ebx
  800754:	7f 39                	jg     80078f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800756:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800759:	eb d5                	jmp    800730 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80075b:	8b 45 14             	mov    0x14(%ebp),%eax
  80075e:	83 c0 04             	add    $0x4,%eax
  800761:	89 45 14             	mov    %eax,0x14(%ebp)
  800764:	8b 45 14             	mov    0x14(%ebp),%eax
  800767:	83 e8 04             	sub    $0x4,%eax
  80076a:	8b 00                	mov    (%eax),%eax
  80076c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80076f:	eb 1f                	jmp    800790 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800771:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800775:	79 83                	jns    8006fa <vprintfmt+0x54>
				width = 0;
  800777:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80077e:	e9 77 ff ff ff       	jmp    8006fa <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800783:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80078a:	e9 6b ff ff ff       	jmp    8006fa <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80078f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800790:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800794:	0f 89 60 ff ff ff    	jns    8006fa <vprintfmt+0x54>
				width = precision, precision = -1;
  80079a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80079d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007a0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007a7:	e9 4e ff ff ff       	jmp    8006fa <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007ac:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007af:	e9 46 ff ff ff       	jmp    8006fa <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b7:	83 c0 04             	add    $0x4,%eax
  8007ba:	89 45 14             	mov    %eax,0x14(%ebp)
  8007bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c0:	83 e8 04             	sub    $0x4,%eax
  8007c3:	8b 00                	mov    (%eax),%eax
  8007c5:	83 ec 08             	sub    $0x8,%esp
  8007c8:	ff 75 0c             	pushl  0xc(%ebp)
  8007cb:	50                   	push   %eax
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	ff d0                	call   *%eax
  8007d1:	83 c4 10             	add    $0x10,%esp
			break;
  8007d4:	e9 89 02 00 00       	jmp    800a62 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007dc:	83 c0 04             	add    $0x4,%eax
  8007df:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e5:	83 e8 04             	sub    $0x4,%eax
  8007e8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007ea:	85 db                	test   %ebx,%ebx
  8007ec:	79 02                	jns    8007f0 <vprintfmt+0x14a>
				err = -err;
  8007ee:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007f0:	83 fb 64             	cmp    $0x64,%ebx
  8007f3:	7f 0b                	jg     800800 <vprintfmt+0x15a>
  8007f5:	8b 34 9d c0 1e 80 00 	mov    0x801ec0(,%ebx,4),%esi
  8007fc:	85 f6                	test   %esi,%esi
  8007fe:	75 19                	jne    800819 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800800:	53                   	push   %ebx
  800801:	68 65 20 80 00       	push   $0x802065
  800806:	ff 75 0c             	pushl  0xc(%ebp)
  800809:	ff 75 08             	pushl  0x8(%ebp)
  80080c:	e8 5e 02 00 00       	call   800a6f <printfmt>
  800811:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800814:	e9 49 02 00 00       	jmp    800a62 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800819:	56                   	push   %esi
  80081a:	68 6e 20 80 00       	push   $0x80206e
  80081f:	ff 75 0c             	pushl  0xc(%ebp)
  800822:	ff 75 08             	pushl  0x8(%ebp)
  800825:	e8 45 02 00 00       	call   800a6f <printfmt>
  80082a:	83 c4 10             	add    $0x10,%esp
			break;
  80082d:	e9 30 02 00 00       	jmp    800a62 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800832:	8b 45 14             	mov    0x14(%ebp),%eax
  800835:	83 c0 04             	add    $0x4,%eax
  800838:	89 45 14             	mov    %eax,0x14(%ebp)
  80083b:	8b 45 14             	mov    0x14(%ebp),%eax
  80083e:	83 e8 04             	sub    $0x4,%eax
  800841:	8b 30                	mov    (%eax),%esi
  800843:	85 f6                	test   %esi,%esi
  800845:	75 05                	jne    80084c <vprintfmt+0x1a6>
				p = "(null)";
  800847:	be 71 20 80 00       	mov    $0x802071,%esi
			if (width > 0 && padc != '-')
  80084c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800850:	7e 6d                	jle    8008bf <vprintfmt+0x219>
  800852:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800856:	74 67                	je     8008bf <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800858:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80085b:	83 ec 08             	sub    $0x8,%esp
  80085e:	50                   	push   %eax
  80085f:	56                   	push   %esi
  800860:	e8 0c 03 00 00       	call   800b71 <strnlen>
  800865:	83 c4 10             	add    $0x10,%esp
  800868:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80086b:	eb 16                	jmp    800883 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80086d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800871:	83 ec 08             	sub    $0x8,%esp
  800874:	ff 75 0c             	pushl  0xc(%ebp)
  800877:	50                   	push   %eax
  800878:	8b 45 08             	mov    0x8(%ebp),%eax
  80087b:	ff d0                	call   *%eax
  80087d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800880:	ff 4d e4             	decl   -0x1c(%ebp)
  800883:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800887:	7f e4                	jg     80086d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800889:	eb 34                	jmp    8008bf <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80088b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80088f:	74 1c                	je     8008ad <vprintfmt+0x207>
  800891:	83 fb 1f             	cmp    $0x1f,%ebx
  800894:	7e 05                	jle    80089b <vprintfmt+0x1f5>
  800896:	83 fb 7e             	cmp    $0x7e,%ebx
  800899:	7e 12                	jle    8008ad <vprintfmt+0x207>
					putch('?', putdat);
  80089b:	83 ec 08             	sub    $0x8,%esp
  80089e:	ff 75 0c             	pushl  0xc(%ebp)
  8008a1:	6a 3f                	push   $0x3f
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	ff d0                	call   *%eax
  8008a8:	83 c4 10             	add    $0x10,%esp
  8008ab:	eb 0f                	jmp    8008bc <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008ad:	83 ec 08             	sub    $0x8,%esp
  8008b0:	ff 75 0c             	pushl  0xc(%ebp)
  8008b3:	53                   	push   %ebx
  8008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b7:	ff d0                	call   *%eax
  8008b9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008bc:	ff 4d e4             	decl   -0x1c(%ebp)
  8008bf:	89 f0                	mov    %esi,%eax
  8008c1:	8d 70 01             	lea    0x1(%eax),%esi
  8008c4:	8a 00                	mov    (%eax),%al
  8008c6:	0f be d8             	movsbl %al,%ebx
  8008c9:	85 db                	test   %ebx,%ebx
  8008cb:	74 24                	je     8008f1 <vprintfmt+0x24b>
  8008cd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008d1:	78 b8                	js     80088b <vprintfmt+0x1e5>
  8008d3:	ff 4d e0             	decl   -0x20(%ebp)
  8008d6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008da:	79 af                	jns    80088b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008dc:	eb 13                	jmp    8008f1 <vprintfmt+0x24b>
				putch(' ', putdat);
  8008de:	83 ec 08             	sub    $0x8,%esp
  8008e1:	ff 75 0c             	pushl  0xc(%ebp)
  8008e4:	6a 20                	push   $0x20
  8008e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e9:	ff d0                	call   *%eax
  8008eb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008ee:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f5:	7f e7                	jg     8008de <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008f7:	e9 66 01 00 00       	jmp    800a62 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008fc:	83 ec 08             	sub    $0x8,%esp
  8008ff:	ff 75 e8             	pushl  -0x18(%ebp)
  800902:	8d 45 14             	lea    0x14(%ebp),%eax
  800905:	50                   	push   %eax
  800906:	e8 3c fd ff ff       	call   800647 <getint>
  80090b:	83 c4 10             	add    $0x10,%esp
  80090e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800911:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800914:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800917:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80091a:	85 d2                	test   %edx,%edx
  80091c:	79 23                	jns    800941 <vprintfmt+0x29b>
				putch('-', putdat);
  80091e:	83 ec 08             	sub    $0x8,%esp
  800921:	ff 75 0c             	pushl  0xc(%ebp)
  800924:	6a 2d                	push   $0x2d
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	ff d0                	call   *%eax
  80092b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80092e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800931:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800934:	f7 d8                	neg    %eax
  800936:	83 d2 00             	adc    $0x0,%edx
  800939:	f7 da                	neg    %edx
  80093b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80093e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800941:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800948:	e9 bc 00 00 00       	jmp    800a09 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80094d:	83 ec 08             	sub    $0x8,%esp
  800950:	ff 75 e8             	pushl  -0x18(%ebp)
  800953:	8d 45 14             	lea    0x14(%ebp),%eax
  800956:	50                   	push   %eax
  800957:	e8 84 fc ff ff       	call   8005e0 <getuint>
  80095c:	83 c4 10             	add    $0x10,%esp
  80095f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800962:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800965:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80096c:	e9 98 00 00 00       	jmp    800a09 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800971:	83 ec 08             	sub    $0x8,%esp
  800974:	ff 75 0c             	pushl  0xc(%ebp)
  800977:	6a 58                	push   $0x58
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	ff d0                	call   *%eax
  80097e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800981:	83 ec 08             	sub    $0x8,%esp
  800984:	ff 75 0c             	pushl  0xc(%ebp)
  800987:	6a 58                	push   $0x58
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	ff d0                	call   *%eax
  80098e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800991:	83 ec 08             	sub    $0x8,%esp
  800994:	ff 75 0c             	pushl  0xc(%ebp)
  800997:	6a 58                	push   $0x58
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	ff d0                	call   *%eax
  80099e:	83 c4 10             	add    $0x10,%esp
			break;
  8009a1:	e9 bc 00 00 00       	jmp    800a62 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009a6:	83 ec 08             	sub    $0x8,%esp
  8009a9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ac:	6a 30                	push   $0x30
  8009ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b1:	ff d0                	call   *%eax
  8009b3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009b6:	83 ec 08             	sub    $0x8,%esp
  8009b9:	ff 75 0c             	pushl  0xc(%ebp)
  8009bc:	6a 78                	push   $0x78
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	ff d0                	call   *%eax
  8009c3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c9:	83 c0 04             	add    $0x4,%eax
  8009cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8009cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d2:	83 e8 04             	sub    $0x4,%eax
  8009d5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009e1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009e8:	eb 1f                	jmp    800a09 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009ea:	83 ec 08             	sub    $0x8,%esp
  8009ed:	ff 75 e8             	pushl  -0x18(%ebp)
  8009f0:	8d 45 14             	lea    0x14(%ebp),%eax
  8009f3:	50                   	push   %eax
  8009f4:	e8 e7 fb ff ff       	call   8005e0 <getuint>
  8009f9:	83 c4 10             	add    $0x10,%esp
  8009fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ff:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a02:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a09:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a10:	83 ec 04             	sub    $0x4,%esp
  800a13:	52                   	push   %edx
  800a14:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a17:	50                   	push   %eax
  800a18:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1b:	ff 75 f0             	pushl  -0x10(%ebp)
  800a1e:	ff 75 0c             	pushl  0xc(%ebp)
  800a21:	ff 75 08             	pushl  0x8(%ebp)
  800a24:	e8 00 fb ff ff       	call   800529 <printnum>
  800a29:	83 c4 20             	add    $0x20,%esp
			break;
  800a2c:	eb 34                	jmp    800a62 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a2e:	83 ec 08             	sub    $0x8,%esp
  800a31:	ff 75 0c             	pushl  0xc(%ebp)
  800a34:	53                   	push   %ebx
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	ff d0                	call   *%eax
  800a3a:	83 c4 10             	add    $0x10,%esp
			break;
  800a3d:	eb 23                	jmp    800a62 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	6a 25                	push   $0x25
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	ff d0                	call   *%eax
  800a4c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a4f:	ff 4d 10             	decl   0x10(%ebp)
  800a52:	eb 03                	jmp    800a57 <vprintfmt+0x3b1>
  800a54:	ff 4d 10             	decl   0x10(%ebp)
  800a57:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5a:	48                   	dec    %eax
  800a5b:	8a 00                	mov    (%eax),%al
  800a5d:	3c 25                	cmp    $0x25,%al
  800a5f:	75 f3                	jne    800a54 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a61:	90                   	nop
		}
	}
  800a62:	e9 47 fc ff ff       	jmp    8006ae <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a67:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a68:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a6b:	5b                   	pop    %ebx
  800a6c:	5e                   	pop    %esi
  800a6d:	5d                   	pop    %ebp
  800a6e:	c3                   	ret    

00800a6f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a6f:	55                   	push   %ebp
  800a70:	89 e5                	mov    %esp,%ebp
  800a72:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a75:	8d 45 10             	lea    0x10(%ebp),%eax
  800a78:	83 c0 04             	add    $0x4,%eax
  800a7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a81:	ff 75 f4             	pushl  -0xc(%ebp)
  800a84:	50                   	push   %eax
  800a85:	ff 75 0c             	pushl  0xc(%ebp)
  800a88:	ff 75 08             	pushl  0x8(%ebp)
  800a8b:	e8 16 fc ff ff       	call   8006a6 <vprintfmt>
  800a90:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a93:	90                   	nop
  800a94:	c9                   	leave  
  800a95:	c3                   	ret    

00800a96 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a96:	55                   	push   %ebp
  800a97:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9c:	8b 40 08             	mov    0x8(%eax),%eax
  800a9f:	8d 50 01             	lea    0x1(%eax),%edx
  800aa2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa5:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800aa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aab:	8b 10                	mov    (%eax),%edx
  800aad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab0:	8b 40 04             	mov    0x4(%eax),%eax
  800ab3:	39 c2                	cmp    %eax,%edx
  800ab5:	73 12                	jae    800ac9 <sprintputch+0x33>
		*b->buf++ = ch;
  800ab7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aba:	8b 00                	mov    (%eax),%eax
  800abc:	8d 48 01             	lea    0x1(%eax),%ecx
  800abf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac2:	89 0a                	mov    %ecx,(%edx)
  800ac4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ac7:	88 10                	mov    %dl,(%eax)
}
  800ac9:	90                   	nop
  800aca:	5d                   	pop    %ebp
  800acb:	c3                   	ret    

00800acc <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800acc:	55                   	push   %ebp
  800acd:	89 e5                	mov    %esp,%ebp
  800acf:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	01 d0                	add    %edx,%eax
  800ae3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800aed:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800af1:	74 06                	je     800af9 <vsnprintf+0x2d>
  800af3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af7:	7f 07                	jg     800b00 <vsnprintf+0x34>
		return -E_INVAL;
  800af9:	b8 03 00 00 00       	mov    $0x3,%eax
  800afe:	eb 20                	jmp    800b20 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b00:	ff 75 14             	pushl  0x14(%ebp)
  800b03:	ff 75 10             	pushl  0x10(%ebp)
  800b06:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b09:	50                   	push   %eax
  800b0a:	68 96 0a 80 00       	push   $0x800a96
  800b0f:	e8 92 fb ff ff       	call   8006a6 <vprintfmt>
  800b14:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b17:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b1a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b20:	c9                   	leave  
  800b21:	c3                   	ret    

00800b22 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b22:	55                   	push   %ebp
  800b23:	89 e5                	mov    %esp,%ebp
  800b25:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b28:	8d 45 10             	lea    0x10(%ebp),%eax
  800b2b:	83 c0 04             	add    $0x4,%eax
  800b2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b31:	8b 45 10             	mov    0x10(%ebp),%eax
  800b34:	ff 75 f4             	pushl  -0xc(%ebp)
  800b37:	50                   	push   %eax
  800b38:	ff 75 0c             	pushl  0xc(%ebp)
  800b3b:	ff 75 08             	pushl  0x8(%ebp)
  800b3e:	e8 89 ff ff ff       	call   800acc <vsnprintf>
  800b43:	83 c4 10             	add    $0x10,%esp
  800b46:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b4c:	c9                   	leave  
  800b4d:	c3                   	ret    

00800b4e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b4e:	55                   	push   %ebp
  800b4f:	89 e5                	mov    %esp,%ebp
  800b51:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b5b:	eb 06                	jmp    800b63 <strlen+0x15>
		n++;
  800b5d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b60:	ff 45 08             	incl   0x8(%ebp)
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8a 00                	mov    (%eax),%al
  800b68:	84 c0                	test   %al,%al
  800b6a:	75 f1                	jne    800b5d <strlen+0xf>
		n++;
	return n;
  800b6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b6f:	c9                   	leave  
  800b70:	c3                   	ret    

00800b71 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
  800b74:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b7e:	eb 09                	jmp    800b89 <strnlen+0x18>
		n++;
  800b80:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b83:	ff 45 08             	incl   0x8(%ebp)
  800b86:	ff 4d 0c             	decl   0xc(%ebp)
  800b89:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b8d:	74 09                	je     800b98 <strnlen+0x27>
  800b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b92:	8a 00                	mov    (%eax),%al
  800b94:	84 c0                	test   %al,%al
  800b96:	75 e8                	jne    800b80 <strnlen+0xf>
		n++;
	return n;
  800b98:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b9b:	c9                   	leave  
  800b9c:	c3                   	ret    

00800b9d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b9d:	55                   	push   %ebp
  800b9e:	89 e5                	mov    %esp,%ebp
  800ba0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ba9:	90                   	nop
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	8d 50 01             	lea    0x1(%eax),%edx
  800bb0:	89 55 08             	mov    %edx,0x8(%ebp)
  800bb3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bb6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bbc:	8a 12                	mov    (%edx),%dl
  800bbe:	88 10                	mov    %dl,(%eax)
  800bc0:	8a 00                	mov    (%eax),%al
  800bc2:	84 c0                	test   %al,%al
  800bc4:	75 e4                	jne    800baa <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bc9:	c9                   	leave  
  800bca:	c3                   	ret    

00800bcb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bcb:	55                   	push   %ebp
  800bcc:	89 e5                	mov    %esp,%ebp
  800bce:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bd7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bde:	eb 1f                	jmp    800bff <strncpy+0x34>
		*dst++ = *src;
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	8d 50 01             	lea    0x1(%eax),%edx
  800be6:	89 55 08             	mov    %edx,0x8(%ebp)
  800be9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bec:	8a 12                	mov    (%edx),%dl
  800bee:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf3:	8a 00                	mov    (%eax),%al
  800bf5:	84 c0                	test   %al,%al
  800bf7:	74 03                	je     800bfc <strncpy+0x31>
			src++;
  800bf9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bfc:	ff 45 fc             	incl   -0x4(%ebp)
  800bff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c02:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c05:	72 d9                	jb     800be0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c07:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c0a:	c9                   	leave  
  800c0b:	c3                   	ret    

00800c0c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c0c:	55                   	push   %ebp
  800c0d:	89 e5                	mov    %esp,%ebp
  800c0f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c1c:	74 30                	je     800c4e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c1e:	eb 16                	jmp    800c36 <strlcpy+0x2a>
			*dst++ = *src++;
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	8d 50 01             	lea    0x1(%eax),%edx
  800c26:	89 55 08             	mov    %edx,0x8(%ebp)
  800c29:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c2f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c32:	8a 12                	mov    (%edx),%dl
  800c34:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c36:	ff 4d 10             	decl   0x10(%ebp)
  800c39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c3d:	74 09                	je     800c48 <strlcpy+0x3c>
  800c3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c42:	8a 00                	mov    (%eax),%al
  800c44:	84 c0                	test   %al,%al
  800c46:	75 d8                	jne    800c20 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c4e:	8b 55 08             	mov    0x8(%ebp),%edx
  800c51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c54:	29 c2                	sub    %eax,%edx
  800c56:	89 d0                	mov    %edx,%eax
}
  800c58:	c9                   	leave  
  800c59:	c3                   	ret    

00800c5a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c5a:	55                   	push   %ebp
  800c5b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c5d:	eb 06                	jmp    800c65 <strcmp+0xb>
		p++, q++;
  800c5f:	ff 45 08             	incl   0x8(%ebp)
  800c62:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	84 c0                	test   %al,%al
  800c6c:	74 0e                	je     800c7c <strcmp+0x22>
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	8a 10                	mov    (%eax),%dl
  800c73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c76:	8a 00                	mov    (%eax),%al
  800c78:	38 c2                	cmp    %al,%dl
  800c7a:	74 e3                	je     800c5f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	0f b6 d0             	movzbl %al,%edx
  800c84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	0f b6 c0             	movzbl %al,%eax
  800c8c:	29 c2                	sub    %eax,%edx
  800c8e:	89 d0                	mov    %edx,%eax
}
  800c90:	5d                   	pop    %ebp
  800c91:	c3                   	ret    

00800c92 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c95:	eb 09                	jmp    800ca0 <strncmp+0xe>
		n--, p++, q++;
  800c97:	ff 4d 10             	decl   0x10(%ebp)
  800c9a:	ff 45 08             	incl   0x8(%ebp)
  800c9d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ca0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca4:	74 17                	je     800cbd <strncmp+0x2b>
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	84 c0                	test   %al,%al
  800cad:	74 0e                	je     800cbd <strncmp+0x2b>
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 10                	mov    (%eax),%dl
  800cb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	38 c2                	cmp    %al,%dl
  800cbb:	74 da                	je     800c97 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cbd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc1:	75 07                	jne    800cca <strncmp+0x38>
		return 0;
  800cc3:	b8 00 00 00 00       	mov    $0x0,%eax
  800cc8:	eb 14                	jmp    800cde <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8a 00                	mov    (%eax),%al
  800ccf:	0f b6 d0             	movzbl %al,%edx
  800cd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	0f b6 c0             	movzbl %al,%eax
  800cda:	29 c2                	sub    %eax,%edx
  800cdc:	89 d0                	mov    %edx,%eax
}
  800cde:	5d                   	pop    %ebp
  800cdf:	c3                   	ret    

00800ce0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ce0:	55                   	push   %ebp
  800ce1:	89 e5                	mov    %esp,%ebp
  800ce3:	83 ec 04             	sub    $0x4,%esp
  800ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cec:	eb 12                	jmp    800d00 <strchr+0x20>
		if (*s == c)
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cf6:	75 05                	jne    800cfd <strchr+0x1d>
			return (char *) s;
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	eb 11                	jmp    800d0e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cfd:	ff 45 08             	incl   0x8(%ebp)
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	84 c0                	test   %al,%al
  800d07:	75 e5                	jne    800cee <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d09:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d0e:	c9                   	leave  
  800d0f:	c3                   	ret    

00800d10 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d10:	55                   	push   %ebp
  800d11:	89 e5                	mov    %esp,%ebp
  800d13:	83 ec 04             	sub    $0x4,%esp
  800d16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d19:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d1c:	eb 0d                	jmp    800d2b <strfind+0x1b>
		if (*s == c)
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	8a 00                	mov    (%eax),%al
  800d23:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d26:	74 0e                	je     800d36 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d28:	ff 45 08             	incl   0x8(%ebp)
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	84 c0                	test   %al,%al
  800d32:	75 ea                	jne    800d1e <strfind+0xe>
  800d34:	eb 01                	jmp    800d37 <strfind+0x27>
		if (*s == c)
			break;
  800d36:	90                   	nop
	return (char *) s;
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d3a:	c9                   	leave  
  800d3b:	c3                   	ret    

00800d3c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d3c:	55                   	push   %ebp
  800d3d:	89 e5                	mov    %esp,%ebp
  800d3f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d48:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d4e:	eb 0e                	jmp    800d5e <memset+0x22>
		*p++ = c;
  800d50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d53:	8d 50 01             	lea    0x1(%eax),%edx
  800d56:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d59:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d5e:	ff 4d f8             	decl   -0x8(%ebp)
  800d61:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d65:	79 e9                	jns    800d50 <memset+0x14>
		*p++ = c;

	return v;
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d6a:	c9                   	leave  
  800d6b:	c3                   	ret    

00800d6c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d6c:	55                   	push   %ebp
  800d6d:	89 e5                	mov    %esp,%ebp
  800d6f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d7e:	eb 16                	jmp    800d96 <memcpy+0x2a>
		*d++ = *s++;
  800d80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d83:	8d 50 01             	lea    0x1(%eax),%edx
  800d86:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d8c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d8f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d92:	8a 12                	mov    (%edx),%dl
  800d94:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d96:	8b 45 10             	mov    0x10(%ebp),%eax
  800d99:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d9c:	89 55 10             	mov    %edx,0x10(%ebp)
  800d9f:	85 c0                	test   %eax,%eax
  800da1:	75 dd                	jne    800d80 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da6:	c9                   	leave  
  800da7:	c3                   	ret    

00800da8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
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
	if (s < d && s + n > d) {
  800dba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dc0:	73 50                	jae    800e12 <memmove+0x6a>
  800dc2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc8:	01 d0                	add    %edx,%eax
  800dca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dcd:	76 43                	jbe    800e12 <memmove+0x6a>
		s += n;
  800dcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ddb:	eb 10                	jmp    800ded <memmove+0x45>
			*--d = *--s;
  800ddd:	ff 4d f8             	decl   -0x8(%ebp)
  800de0:	ff 4d fc             	decl   -0x4(%ebp)
  800de3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de6:	8a 10                	mov    (%eax),%dl
  800de8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800deb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ded:	8b 45 10             	mov    0x10(%ebp),%eax
  800df0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df3:	89 55 10             	mov    %edx,0x10(%ebp)
  800df6:	85 c0                	test   %eax,%eax
  800df8:	75 e3                	jne    800ddd <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dfa:	eb 23                	jmp    800e1f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dff:	8d 50 01             	lea    0x1(%eax),%edx
  800e02:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e05:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e08:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e0b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e0e:	8a 12                	mov    (%edx),%dl
  800e10:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e12:	8b 45 10             	mov    0x10(%ebp),%eax
  800e15:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e18:	89 55 10             	mov    %edx,0x10(%ebp)
  800e1b:	85 c0                	test   %eax,%eax
  800e1d:	75 dd                	jne    800dfc <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e22:	c9                   	leave  
  800e23:	c3                   	ret    

00800e24 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e24:	55                   	push   %ebp
  800e25:	89 e5                	mov    %esp,%ebp
  800e27:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e33:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e36:	eb 2a                	jmp    800e62 <memcmp+0x3e>
		if (*s1 != *s2)
  800e38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e3b:	8a 10                	mov    (%eax),%dl
  800e3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e40:	8a 00                	mov    (%eax),%al
  800e42:	38 c2                	cmp    %al,%dl
  800e44:	74 16                	je     800e5c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e46:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e49:	8a 00                	mov    (%eax),%al
  800e4b:	0f b6 d0             	movzbl %al,%edx
  800e4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e51:	8a 00                	mov    (%eax),%al
  800e53:	0f b6 c0             	movzbl %al,%eax
  800e56:	29 c2                	sub    %eax,%edx
  800e58:	89 d0                	mov    %edx,%eax
  800e5a:	eb 18                	jmp    800e74 <memcmp+0x50>
		s1++, s2++;
  800e5c:	ff 45 fc             	incl   -0x4(%ebp)
  800e5f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e62:	8b 45 10             	mov    0x10(%ebp),%eax
  800e65:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e68:	89 55 10             	mov    %edx,0x10(%ebp)
  800e6b:	85 c0                	test   %eax,%eax
  800e6d:	75 c9                	jne    800e38 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e6f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e74:	c9                   	leave  
  800e75:	c3                   	ret    

00800e76 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e76:	55                   	push   %ebp
  800e77:	89 e5                	mov    %esp,%ebp
  800e79:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e7c:	8b 55 08             	mov    0x8(%ebp),%edx
  800e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e82:	01 d0                	add    %edx,%eax
  800e84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e87:	eb 15                	jmp    800e9e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	8a 00                	mov    (%eax),%al
  800e8e:	0f b6 d0             	movzbl %al,%edx
  800e91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e94:	0f b6 c0             	movzbl %al,%eax
  800e97:	39 c2                	cmp    %eax,%edx
  800e99:	74 0d                	je     800ea8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e9b:	ff 45 08             	incl   0x8(%ebp)
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ea4:	72 e3                	jb     800e89 <memfind+0x13>
  800ea6:	eb 01                	jmp    800ea9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ea8:	90                   	nop
	return (void *) s;
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eac:	c9                   	leave  
  800ead:	c3                   	ret    

00800eae <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eae:	55                   	push   %ebp
  800eaf:	89 e5                	mov    %esp,%ebp
  800eb1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800eb4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ebb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec2:	eb 03                	jmp    800ec7 <strtol+0x19>
		s++;
  800ec4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eca:	8a 00                	mov    (%eax),%al
  800ecc:	3c 20                	cmp    $0x20,%al
  800ece:	74 f4                	je     800ec4 <strtol+0x16>
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	8a 00                	mov    (%eax),%al
  800ed5:	3c 09                	cmp    $0x9,%al
  800ed7:	74 eb                	je     800ec4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	3c 2b                	cmp    $0x2b,%al
  800ee0:	75 05                	jne    800ee7 <strtol+0x39>
		s++;
  800ee2:	ff 45 08             	incl   0x8(%ebp)
  800ee5:	eb 13                	jmp    800efa <strtol+0x4c>
	else if (*s == '-')
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	8a 00                	mov    (%eax),%al
  800eec:	3c 2d                	cmp    $0x2d,%al
  800eee:	75 0a                	jne    800efa <strtol+0x4c>
		s++, neg = 1;
  800ef0:	ff 45 08             	incl   0x8(%ebp)
  800ef3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800efa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800efe:	74 06                	je     800f06 <strtol+0x58>
  800f00:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f04:	75 20                	jne    800f26 <strtol+0x78>
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	8a 00                	mov    (%eax),%al
  800f0b:	3c 30                	cmp    $0x30,%al
  800f0d:	75 17                	jne    800f26 <strtol+0x78>
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	40                   	inc    %eax
  800f13:	8a 00                	mov    (%eax),%al
  800f15:	3c 78                	cmp    $0x78,%al
  800f17:	75 0d                	jne    800f26 <strtol+0x78>
		s += 2, base = 16;
  800f19:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f1d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f24:	eb 28                	jmp    800f4e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2a:	75 15                	jne    800f41 <strtol+0x93>
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	3c 30                	cmp    $0x30,%al
  800f33:	75 0c                	jne    800f41 <strtol+0x93>
		s++, base = 8;
  800f35:	ff 45 08             	incl   0x8(%ebp)
  800f38:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f3f:	eb 0d                	jmp    800f4e <strtol+0xa0>
	else if (base == 0)
  800f41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f45:	75 07                	jne    800f4e <strtol+0xa0>
		base = 10;
  800f47:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	3c 2f                	cmp    $0x2f,%al
  800f55:	7e 19                	jle    800f70 <strtol+0xc2>
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	3c 39                	cmp    $0x39,%al
  800f5e:	7f 10                	jg     800f70 <strtol+0xc2>
			dig = *s - '0';
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	0f be c0             	movsbl %al,%eax
  800f68:	83 e8 30             	sub    $0x30,%eax
  800f6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f6e:	eb 42                	jmp    800fb2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	3c 60                	cmp    $0x60,%al
  800f77:	7e 19                	jle    800f92 <strtol+0xe4>
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	3c 7a                	cmp    $0x7a,%al
  800f80:	7f 10                	jg     800f92 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	0f be c0             	movsbl %al,%eax
  800f8a:	83 e8 57             	sub    $0x57,%eax
  800f8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f90:	eb 20                	jmp    800fb2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	3c 40                	cmp    $0x40,%al
  800f99:	7e 39                	jle    800fd4 <strtol+0x126>
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	8a 00                	mov    (%eax),%al
  800fa0:	3c 5a                	cmp    $0x5a,%al
  800fa2:	7f 30                	jg     800fd4 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	0f be c0             	movsbl %al,%eax
  800fac:	83 e8 37             	sub    $0x37,%eax
  800faf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fb8:	7d 19                	jge    800fd3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fba:	ff 45 08             	incl   0x8(%ebp)
  800fbd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc0:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fc4:	89 c2                	mov    %eax,%edx
  800fc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc9:	01 d0                	add    %edx,%eax
  800fcb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fce:	e9 7b ff ff ff       	jmp    800f4e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fd3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fd4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd8:	74 08                	je     800fe2 <strtol+0x134>
		*endptr = (char *) s;
  800fda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdd:	8b 55 08             	mov    0x8(%ebp),%edx
  800fe0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fe2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fe6:	74 07                	je     800fef <strtol+0x141>
  800fe8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800feb:	f7 d8                	neg    %eax
  800fed:	eb 03                	jmp    800ff2 <strtol+0x144>
  800fef:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ff2:	c9                   	leave  
  800ff3:	c3                   	ret    

00800ff4 <ltostr>:

void
ltostr(long value, char *str)
{
  800ff4:	55                   	push   %ebp
  800ff5:	89 e5                	mov    %esp,%ebp
  800ff7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ffa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801001:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801008:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80100c:	79 13                	jns    801021 <ltostr+0x2d>
	{
		neg = 1;
  80100e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801015:	8b 45 0c             	mov    0xc(%ebp),%eax
  801018:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80101b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80101e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801029:	99                   	cltd   
  80102a:	f7 f9                	idiv   %ecx
  80102c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80102f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801032:	8d 50 01             	lea    0x1(%eax),%edx
  801035:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801038:	89 c2                	mov    %eax,%edx
  80103a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103d:	01 d0                	add    %edx,%eax
  80103f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801042:	83 c2 30             	add    $0x30,%edx
  801045:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801047:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80104a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80104f:	f7 e9                	imul   %ecx
  801051:	c1 fa 02             	sar    $0x2,%edx
  801054:	89 c8                	mov    %ecx,%eax
  801056:	c1 f8 1f             	sar    $0x1f,%eax
  801059:	29 c2                	sub    %eax,%edx
  80105b:	89 d0                	mov    %edx,%eax
  80105d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801060:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801063:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801068:	f7 e9                	imul   %ecx
  80106a:	c1 fa 02             	sar    $0x2,%edx
  80106d:	89 c8                	mov    %ecx,%eax
  80106f:	c1 f8 1f             	sar    $0x1f,%eax
  801072:	29 c2                	sub    %eax,%edx
  801074:	89 d0                	mov    %edx,%eax
  801076:	c1 e0 02             	shl    $0x2,%eax
  801079:	01 d0                	add    %edx,%eax
  80107b:	01 c0                	add    %eax,%eax
  80107d:	29 c1                	sub    %eax,%ecx
  80107f:	89 ca                	mov    %ecx,%edx
  801081:	85 d2                	test   %edx,%edx
  801083:	75 9c                	jne    801021 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801085:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80108c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108f:	48                   	dec    %eax
  801090:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801093:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801097:	74 3d                	je     8010d6 <ltostr+0xe2>
		start = 1 ;
  801099:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010a0:	eb 34                	jmp    8010d6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a8:	01 d0                	add    %edx,%eax
  8010aa:	8a 00                	mov    (%eax),%al
  8010ac:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b5:	01 c2                	add    %eax,%edx
  8010b7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bd:	01 c8                	add    %ecx,%eax
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010c3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c9:	01 c2                	add    %eax,%edx
  8010cb:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010ce:	88 02                	mov    %al,(%edx)
		start++ ;
  8010d0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010d3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010dc:	7c c4                	jl     8010a2 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010de:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e4:	01 d0                	add    %edx,%eax
  8010e6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010e9:	90                   	nop
  8010ea:	c9                   	leave  
  8010eb:	c3                   	ret    

008010ec <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010ec:	55                   	push   %ebp
  8010ed:	89 e5                	mov    %esp,%ebp
  8010ef:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010f2:	ff 75 08             	pushl  0x8(%ebp)
  8010f5:	e8 54 fa ff ff       	call   800b4e <strlen>
  8010fa:	83 c4 04             	add    $0x4,%esp
  8010fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801100:	ff 75 0c             	pushl  0xc(%ebp)
  801103:	e8 46 fa ff ff       	call   800b4e <strlen>
  801108:	83 c4 04             	add    $0x4,%esp
  80110b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80110e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801115:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80111c:	eb 17                	jmp    801135 <strcconcat+0x49>
		final[s] = str1[s] ;
  80111e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801121:	8b 45 10             	mov    0x10(%ebp),%eax
  801124:	01 c2                	add    %eax,%edx
  801126:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	01 c8                	add    %ecx,%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801132:	ff 45 fc             	incl   -0x4(%ebp)
  801135:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801138:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80113b:	7c e1                	jl     80111e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80113d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801144:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80114b:	eb 1f                	jmp    80116c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80114d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801150:	8d 50 01             	lea    0x1(%eax),%edx
  801153:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801156:	89 c2                	mov    %eax,%edx
  801158:	8b 45 10             	mov    0x10(%ebp),%eax
  80115b:	01 c2                	add    %eax,%edx
  80115d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801160:	8b 45 0c             	mov    0xc(%ebp),%eax
  801163:	01 c8                	add    %ecx,%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801169:	ff 45 f8             	incl   -0x8(%ebp)
  80116c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801172:	7c d9                	jl     80114d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801174:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801177:	8b 45 10             	mov    0x10(%ebp),%eax
  80117a:	01 d0                	add    %edx,%eax
  80117c:	c6 00 00             	movb   $0x0,(%eax)
}
  80117f:	90                   	nop
  801180:	c9                   	leave  
  801181:	c3                   	ret    

00801182 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801185:	8b 45 14             	mov    0x14(%ebp),%eax
  801188:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80118e:	8b 45 14             	mov    0x14(%ebp),%eax
  801191:	8b 00                	mov    (%eax),%eax
  801193:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80119a:	8b 45 10             	mov    0x10(%ebp),%eax
  80119d:	01 d0                	add    %edx,%eax
  80119f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011a5:	eb 0c                	jmp    8011b3 <strsplit+0x31>
			*string++ = 0;
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	8d 50 01             	lea    0x1(%eax),%edx
  8011ad:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	8a 00                	mov    (%eax),%al
  8011b8:	84 c0                	test   %al,%al
  8011ba:	74 18                	je     8011d4 <strsplit+0x52>
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	8a 00                	mov    (%eax),%al
  8011c1:	0f be c0             	movsbl %al,%eax
  8011c4:	50                   	push   %eax
  8011c5:	ff 75 0c             	pushl  0xc(%ebp)
  8011c8:	e8 13 fb ff ff       	call   800ce0 <strchr>
  8011cd:	83 c4 08             	add    $0x8,%esp
  8011d0:	85 c0                	test   %eax,%eax
  8011d2:	75 d3                	jne    8011a7 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d7:	8a 00                	mov    (%eax),%al
  8011d9:	84 c0                	test   %al,%al
  8011db:	74 5a                	je     801237 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e0:	8b 00                	mov    (%eax),%eax
  8011e2:	83 f8 0f             	cmp    $0xf,%eax
  8011e5:	75 07                	jne    8011ee <strsplit+0x6c>
		{
			return 0;
  8011e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8011ec:	eb 66                	jmp    801254 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f1:	8b 00                	mov    (%eax),%eax
  8011f3:	8d 48 01             	lea    0x1(%eax),%ecx
  8011f6:	8b 55 14             	mov    0x14(%ebp),%edx
  8011f9:	89 0a                	mov    %ecx,(%edx)
  8011fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801202:	8b 45 10             	mov    0x10(%ebp),%eax
  801205:	01 c2                	add    %eax,%edx
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80120c:	eb 03                	jmp    801211 <strsplit+0x8f>
			string++;
  80120e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	84 c0                	test   %al,%al
  801218:	74 8b                	je     8011a5 <strsplit+0x23>
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	0f be c0             	movsbl %al,%eax
  801222:	50                   	push   %eax
  801223:	ff 75 0c             	pushl  0xc(%ebp)
  801226:	e8 b5 fa ff ff       	call   800ce0 <strchr>
  80122b:	83 c4 08             	add    $0x8,%esp
  80122e:	85 c0                	test   %eax,%eax
  801230:	74 dc                	je     80120e <strsplit+0x8c>
			string++;
	}
  801232:	e9 6e ff ff ff       	jmp    8011a5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801237:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801238:	8b 45 14             	mov    0x14(%ebp),%eax
  80123b:	8b 00                	mov    (%eax),%eax
  80123d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801244:	8b 45 10             	mov    0x10(%ebp),%eax
  801247:	01 d0                	add    %edx,%eax
  801249:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80124f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801254:	c9                   	leave  
  801255:	c3                   	ret    

00801256 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801256:	55                   	push   %ebp
  801257:	89 e5                	mov    %esp,%ebp
  801259:	57                   	push   %edi
  80125a:	56                   	push   %esi
  80125b:	53                   	push   %ebx
  80125c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80125f:	8b 45 08             	mov    0x8(%ebp),%eax
  801262:	8b 55 0c             	mov    0xc(%ebp),%edx
  801265:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801268:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80126b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80126e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801271:	cd 30                	int    $0x30
  801273:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801276:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801279:	83 c4 10             	add    $0x10,%esp
  80127c:	5b                   	pop    %ebx
  80127d:	5e                   	pop    %esi
  80127e:	5f                   	pop    %edi
  80127f:	5d                   	pop    %ebp
  801280:	c3                   	ret    

00801281 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801281:	55                   	push   %ebp
  801282:	89 e5                	mov    %esp,%ebp
  801284:	83 ec 04             	sub    $0x4,%esp
  801287:	8b 45 10             	mov    0x10(%ebp),%eax
  80128a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80128d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801291:	8b 45 08             	mov    0x8(%ebp),%eax
  801294:	6a 00                	push   $0x0
  801296:	6a 00                	push   $0x0
  801298:	52                   	push   %edx
  801299:	ff 75 0c             	pushl  0xc(%ebp)
  80129c:	50                   	push   %eax
  80129d:	6a 00                	push   $0x0
  80129f:	e8 b2 ff ff ff       	call   801256 <syscall>
  8012a4:	83 c4 18             	add    $0x18,%esp
}
  8012a7:	90                   	nop
  8012a8:	c9                   	leave  
  8012a9:	c3                   	ret    

008012aa <sys_cgetc>:

int
sys_cgetc(void)
{
  8012aa:	55                   	push   %ebp
  8012ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 00                	push   $0x0
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 01                	push   $0x1
  8012b9:	e8 98 ff ff ff       	call   801256 <syscall>
  8012be:	83 c4 18             	add    $0x18,%esp
}
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	50                   	push   %eax
  8012d2:	6a 05                	push   $0x5
  8012d4:	e8 7d ff ff ff       	call   801256 <syscall>
  8012d9:	83 c4 18             	add    $0x18,%esp
}
  8012dc:	c9                   	leave  
  8012dd:	c3                   	ret    

008012de <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012de:	55                   	push   %ebp
  8012df:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 02                	push   $0x2
  8012ed:	e8 64 ff ff ff       	call   801256 <syscall>
  8012f2:	83 c4 18             	add    $0x18,%esp
}
  8012f5:	c9                   	leave  
  8012f6:	c3                   	ret    

008012f7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012f7:	55                   	push   %ebp
  8012f8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	6a 03                	push   $0x3
  801306:	e8 4b ff ff ff       	call   801256 <syscall>
  80130b:	83 c4 18             	add    $0x18,%esp
}
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 04                	push   $0x4
  80131f:	e8 32 ff ff ff       	call   801256 <syscall>
  801324:	83 c4 18             	add    $0x18,%esp
}
  801327:	c9                   	leave  
  801328:	c3                   	ret    

00801329 <sys_env_exit>:


void sys_env_exit(void)
{
  801329:	55                   	push   %ebp
  80132a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 06                	push   $0x6
  801338:	e8 19 ff ff ff       	call   801256 <syscall>
  80133d:	83 c4 18             	add    $0x18,%esp
}
  801340:	90                   	nop
  801341:	c9                   	leave  
  801342:	c3                   	ret    

00801343 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801343:	55                   	push   %ebp
  801344:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801346:	8b 55 0c             	mov    0xc(%ebp),%edx
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	52                   	push   %edx
  801353:	50                   	push   %eax
  801354:	6a 07                	push   $0x7
  801356:	e8 fb fe ff ff       	call   801256 <syscall>
  80135b:	83 c4 18             	add    $0x18,%esp
}
  80135e:	c9                   	leave  
  80135f:	c3                   	ret    

00801360 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
  801363:	56                   	push   %esi
  801364:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801365:	8b 75 18             	mov    0x18(%ebp),%esi
  801368:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80136b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80136e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	56                   	push   %esi
  801375:	53                   	push   %ebx
  801376:	51                   	push   %ecx
  801377:	52                   	push   %edx
  801378:	50                   	push   %eax
  801379:	6a 08                	push   $0x8
  80137b:	e8 d6 fe ff ff       	call   801256 <syscall>
  801380:	83 c4 18             	add    $0x18,%esp
}
  801383:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801386:	5b                   	pop    %ebx
  801387:	5e                   	pop    %esi
  801388:	5d                   	pop    %ebp
  801389:	c3                   	ret    

0080138a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80138a:	55                   	push   %ebp
  80138b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80138d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	6a 00                	push   $0x0
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	52                   	push   %edx
  80139a:	50                   	push   %eax
  80139b:	6a 09                	push   $0x9
  80139d:	e8 b4 fe ff ff       	call   801256 <syscall>
  8013a2:	83 c4 18             	add    $0x18,%esp
}
  8013a5:	c9                   	leave  
  8013a6:	c3                   	ret    

008013a7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013a7:	55                   	push   %ebp
  8013a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	ff 75 0c             	pushl  0xc(%ebp)
  8013b3:	ff 75 08             	pushl  0x8(%ebp)
  8013b6:	6a 0a                	push   $0xa
  8013b8:	e8 99 fe ff ff       	call   801256 <syscall>
  8013bd:	83 c4 18             	add    $0x18,%esp
}
  8013c0:	c9                   	leave  
  8013c1:	c3                   	ret    

008013c2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013c2:	55                   	push   %ebp
  8013c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 0b                	push   $0xb
  8013d1:	e8 80 fe ff ff       	call   801256 <syscall>
  8013d6:	83 c4 18             	add    $0x18,%esp
}
  8013d9:	c9                   	leave  
  8013da:	c3                   	ret    

008013db <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013db:	55                   	push   %ebp
  8013dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 0c                	push   $0xc
  8013ea:	e8 67 fe ff ff       	call   801256 <syscall>
  8013ef:	83 c4 18             	add    $0x18,%esp
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 0d                	push   $0xd
  801403:	e8 4e fe ff ff       	call   801256 <syscall>
  801408:	83 c4 18             	add    $0x18,%esp
}
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	ff 75 0c             	pushl  0xc(%ebp)
  801419:	ff 75 08             	pushl  0x8(%ebp)
  80141c:	6a 11                	push   $0x11
  80141e:	e8 33 fe ff ff       	call   801256 <syscall>
  801423:	83 c4 18             	add    $0x18,%esp
	return;
  801426:	90                   	nop
}
  801427:	c9                   	leave  
  801428:	c3                   	ret    

00801429 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801429:	55                   	push   %ebp
  80142a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	ff 75 0c             	pushl  0xc(%ebp)
  801435:	ff 75 08             	pushl  0x8(%ebp)
  801438:	6a 12                	push   $0x12
  80143a:	e8 17 fe ff ff       	call   801256 <syscall>
  80143f:	83 c4 18             	add    $0x18,%esp
	return ;
  801442:	90                   	nop
}
  801443:	c9                   	leave  
  801444:	c3                   	ret    

00801445 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801445:	55                   	push   %ebp
  801446:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	6a 0e                	push   $0xe
  801454:	e8 fd fd ff ff       	call   801256 <syscall>
  801459:	83 c4 18             	add    $0x18,%esp
}
  80145c:	c9                   	leave  
  80145d:	c3                   	ret    

0080145e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80145e:	55                   	push   %ebp
  80145f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	ff 75 08             	pushl  0x8(%ebp)
  80146c:	6a 0f                	push   $0xf
  80146e:	e8 e3 fd ff ff       	call   801256 <syscall>
  801473:	83 c4 18             	add    $0x18,%esp
}
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 10                	push   $0x10
  801487:	e8 ca fd ff ff       	call   801256 <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
}
  80148f:	90                   	nop
  801490:	c9                   	leave  
  801491:	c3                   	ret    

00801492 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 14                	push   $0x14
  8014a1:	e8 b0 fd ff ff       	call   801256 <syscall>
  8014a6:	83 c4 18             	add    $0x18,%esp
}
  8014a9:	90                   	nop
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 15                	push   $0x15
  8014bb:	e8 96 fd ff ff       	call   801256 <syscall>
  8014c0:	83 c4 18             	add    $0x18,%esp
}
  8014c3:	90                   	nop
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
  8014c9:	83 ec 04             	sub    $0x4,%esp
  8014cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014d2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	50                   	push   %eax
  8014df:	6a 16                	push   $0x16
  8014e1:	e8 70 fd ff ff       	call   801256 <syscall>
  8014e6:	83 c4 18             	add    $0x18,%esp
}
  8014e9:	90                   	nop
  8014ea:	c9                   	leave  
  8014eb:	c3                   	ret    

008014ec <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014ec:	55                   	push   %ebp
  8014ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 17                	push   $0x17
  8014fb:	e8 56 fd ff ff       	call   801256 <syscall>
  801500:	83 c4 18             	add    $0x18,%esp
}
  801503:	90                   	nop
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	ff 75 0c             	pushl  0xc(%ebp)
  801515:	50                   	push   %eax
  801516:	6a 18                	push   $0x18
  801518:	e8 39 fd ff ff       	call   801256 <syscall>
  80151d:	83 c4 18             	add    $0x18,%esp
}
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801525:	8b 55 0c             	mov    0xc(%ebp),%edx
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	52                   	push   %edx
  801532:	50                   	push   %eax
  801533:	6a 1b                	push   $0x1b
  801535:	e8 1c fd ff ff       	call   801256 <syscall>
  80153a:	83 c4 18             	add    $0x18,%esp
}
  80153d:	c9                   	leave  
  80153e:	c3                   	ret    

0080153f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80153f:	55                   	push   %ebp
  801540:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801542:	8b 55 0c             	mov    0xc(%ebp),%edx
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	52                   	push   %edx
  80154f:	50                   	push   %eax
  801550:	6a 19                	push   $0x19
  801552:	e8 ff fc ff ff       	call   801256 <syscall>
  801557:	83 c4 18             	add    $0x18,%esp
}
  80155a:	90                   	nop
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801560:	8b 55 0c             	mov    0xc(%ebp),%edx
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	52                   	push   %edx
  80156d:	50                   	push   %eax
  80156e:	6a 1a                	push   $0x1a
  801570:	e8 e1 fc ff ff       	call   801256 <syscall>
  801575:	83 c4 18             	add    $0x18,%esp
}
  801578:	90                   	nop
  801579:	c9                   	leave  
  80157a:	c3                   	ret    

0080157b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
  80157e:	83 ec 04             	sub    $0x4,%esp
  801581:	8b 45 10             	mov    0x10(%ebp),%eax
  801584:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801587:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80158a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
  801591:	6a 00                	push   $0x0
  801593:	51                   	push   %ecx
  801594:	52                   	push   %edx
  801595:	ff 75 0c             	pushl  0xc(%ebp)
  801598:	50                   	push   %eax
  801599:	6a 1c                	push   $0x1c
  80159b:	e8 b6 fc ff ff       	call   801256 <syscall>
  8015a0:	83 c4 18             	add    $0x18,%esp
}
  8015a3:	c9                   	leave  
  8015a4:	c3                   	ret    

008015a5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015a5:	55                   	push   %ebp
  8015a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	52                   	push   %edx
  8015b5:	50                   	push   %eax
  8015b6:	6a 1d                	push   $0x1d
  8015b8:	e8 99 fc ff ff       	call   801256 <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
}
  8015c0:	c9                   	leave  
  8015c1:	c3                   	ret    

008015c2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	51                   	push   %ecx
  8015d3:	52                   	push   %edx
  8015d4:	50                   	push   %eax
  8015d5:	6a 1e                	push   $0x1e
  8015d7:	e8 7a fc ff ff       	call   801256 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	52                   	push   %edx
  8015f1:	50                   	push   %eax
  8015f2:	6a 1f                	push   $0x1f
  8015f4:	e8 5d fc ff ff       	call   801256 <syscall>
  8015f9:	83 c4 18             	add    $0x18,%esp
}
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 20                	push   $0x20
  80160d:	e8 44 fc ff ff       	call   801256 <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	ff 75 10             	pushl  0x10(%ebp)
  801624:	ff 75 0c             	pushl  0xc(%ebp)
  801627:	50                   	push   %eax
  801628:	6a 21                	push   $0x21
  80162a:	e8 27 fc ff ff       	call   801256 <syscall>
  80162f:	83 c4 18             	add    $0x18,%esp
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	50                   	push   %eax
  801643:	6a 22                	push   $0x22
  801645:	e8 0c fc ff ff       	call   801256 <syscall>
  80164a:	83 c4 18             	add    $0x18,%esp
}
  80164d:	90                   	nop
  80164e:	c9                   	leave  
  80164f:	c3                   	ret    

00801650 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801650:	55                   	push   %ebp
  801651:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	50                   	push   %eax
  80165f:	6a 23                	push   $0x23
  801661:	e8 f0 fb ff ff       	call   801256 <syscall>
  801666:	83 c4 18             	add    $0x18,%esp
}
  801669:	90                   	nop
  80166a:	c9                   	leave  
  80166b:	c3                   	ret    

0080166c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80166c:	55                   	push   %ebp
  80166d:	89 e5                	mov    %esp,%ebp
  80166f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801672:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801675:	8d 50 04             	lea    0x4(%eax),%edx
  801678:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	52                   	push   %edx
  801682:	50                   	push   %eax
  801683:	6a 24                	push   $0x24
  801685:	e8 cc fb ff ff       	call   801256 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
	return result;
  80168d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801690:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801693:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801696:	89 01                	mov    %eax,(%ecx)
  801698:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	c9                   	leave  
  80169f:	c2 04 00             	ret    $0x4

008016a2 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	ff 75 10             	pushl  0x10(%ebp)
  8016ac:	ff 75 0c             	pushl  0xc(%ebp)
  8016af:	ff 75 08             	pushl  0x8(%ebp)
  8016b2:	6a 13                	push   $0x13
  8016b4:	e8 9d fb ff ff       	call   801256 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016bc:	90                   	nop
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_rcr2>:
uint32 sys_rcr2()
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 25                	push   $0x25
  8016ce:	e8 83 fb ff ff       	call   801256 <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
  8016db:	83 ec 04             	sub    $0x4,%esp
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016e4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	50                   	push   %eax
  8016f1:	6a 26                	push   $0x26
  8016f3:	e8 5e fb ff ff       	call   801256 <syscall>
  8016f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016fb:	90                   	nop
}
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <rsttst>:
void rsttst()
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 28                	push   $0x28
  80170d:	e8 44 fb ff ff       	call   801256 <syscall>
  801712:	83 c4 18             	add    $0x18,%esp
	return ;
  801715:	90                   	nop
}
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	83 ec 04             	sub    $0x4,%esp
  80171e:	8b 45 14             	mov    0x14(%ebp),%eax
  801721:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801724:	8b 55 18             	mov    0x18(%ebp),%edx
  801727:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80172b:	52                   	push   %edx
  80172c:	50                   	push   %eax
  80172d:	ff 75 10             	pushl  0x10(%ebp)
  801730:	ff 75 0c             	pushl  0xc(%ebp)
  801733:	ff 75 08             	pushl  0x8(%ebp)
  801736:	6a 27                	push   $0x27
  801738:	e8 19 fb ff ff       	call   801256 <syscall>
  80173d:	83 c4 18             	add    $0x18,%esp
	return ;
  801740:	90                   	nop
}
  801741:	c9                   	leave  
  801742:	c3                   	ret    

00801743 <chktst>:
void chktst(uint32 n)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	ff 75 08             	pushl  0x8(%ebp)
  801751:	6a 29                	push   $0x29
  801753:	e8 fe fa ff ff       	call   801256 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
	return ;
  80175b:	90                   	nop
}
  80175c:	c9                   	leave  
  80175d:	c3                   	ret    

0080175e <inctst>:

void inctst()
{
  80175e:	55                   	push   %ebp
  80175f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 2a                	push   $0x2a
  80176d:	e8 e4 fa ff ff       	call   801256 <syscall>
  801772:	83 c4 18             	add    $0x18,%esp
	return ;
  801775:	90                   	nop
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <gettst>:
uint32 gettst()
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 2b                	push   $0x2b
  801787:	e8 ca fa ff ff       	call   801256 <syscall>
  80178c:	83 c4 18             	add    $0x18,%esp
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
  801794:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 2c                	push   $0x2c
  8017a3:	e8 ae fa ff ff       	call   801256 <syscall>
  8017a8:	83 c4 18             	add    $0x18,%esp
  8017ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017ae:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017b2:	75 07                	jne    8017bb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017b4:	b8 01 00 00 00       	mov    $0x1,%eax
  8017b9:	eb 05                	jmp    8017c0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c0:	c9                   	leave  
  8017c1:	c3                   	ret    

008017c2 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
  8017c5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 2c                	push   $0x2c
  8017d4:	e8 7d fa ff ff       	call   801256 <syscall>
  8017d9:	83 c4 18             	add    $0x18,%esp
  8017dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017df:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017e3:	75 07                	jne    8017ec <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ea:	eb 05                	jmp    8017f1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f1:	c9                   	leave  
  8017f2:	c3                   	ret    

008017f3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
  8017f6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 2c                	push   $0x2c
  801805:	e8 4c fa ff ff       	call   801256 <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
  80180d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801810:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801814:	75 07                	jne    80181d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801816:	b8 01 00 00 00       	mov    $0x1,%eax
  80181b:	eb 05                	jmp    801822 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80181d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801822:	c9                   	leave  
  801823:	c3                   	ret    

00801824 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801824:	55                   	push   %ebp
  801825:	89 e5                	mov    %esp,%ebp
  801827:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 2c                	push   $0x2c
  801836:	e8 1b fa ff ff       	call   801256 <syscall>
  80183b:	83 c4 18             	add    $0x18,%esp
  80183e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801841:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801845:	75 07                	jne    80184e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801847:	b8 01 00 00 00       	mov    $0x1,%eax
  80184c:	eb 05                	jmp    801853 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80184e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	ff 75 08             	pushl  0x8(%ebp)
  801863:	6a 2d                	push   $0x2d
  801865:	e8 ec f9 ff ff       	call   801256 <syscall>
  80186a:	83 c4 18             	add    $0x18,%esp
	return ;
  80186d:	90                   	nop
}
  80186e:	c9                   	leave  
  80186f:	c3                   	ret    

00801870 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801870:	55                   	push   %ebp
  801871:	89 e5                	mov    %esp,%ebp
  801873:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801876:	8b 55 08             	mov    0x8(%ebp),%edx
  801879:	89 d0                	mov    %edx,%eax
  80187b:	c1 e0 02             	shl    $0x2,%eax
  80187e:	01 d0                	add    %edx,%eax
  801880:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801887:	01 d0                	add    %edx,%eax
  801889:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801890:	01 d0                	add    %edx,%eax
  801892:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801899:	01 d0                	add    %edx,%eax
  80189b:	c1 e0 04             	shl    $0x4,%eax
  80189e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018a8:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018ab:	83 ec 0c             	sub    $0xc,%esp
  8018ae:	50                   	push   %eax
  8018af:	e8 b8 fd ff ff       	call   80166c <sys_get_virtual_time>
  8018b4:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018b7:	eb 41                	jmp    8018fa <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018bc:	83 ec 0c             	sub    $0xc,%esp
  8018bf:	50                   	push   %eax
  8018c0:	e8 a7 fd ff ff       	call   80166c <sys_get_virtual_time>
  8018c5:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8018c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018ce:	29 c2                	sub    %eax,%edx
  8018d0:	89 d0                	mov    %edx,%eax
  8018d2:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8018d5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8018d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8018db:	89 d1                	mov    %edx,%ecx
  8018dd:	29 c1                	sub    %eax,%ecx
  8018df:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8018e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018e5:	39 c2                	cmp    %eax,%edx
  8018e7:	0f 97 c0             	seta   %al
  8018ea:	0f b6 c0             	movzbl %al,%eax
  8018ed:	29 c1                	sub    %eax,%ecx
  8018ef:	89 c8                	mov    %ecx,%eax
  8018f1:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8018f4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8018f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8018fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018fd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801900:	72 b7                	jb     8018b9 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801902:	90                   	nop
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
  801908:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80190b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801912:	eb 03                	jmp    801917 <busy_wait+0x12>
  801914:	ff 45 fc             	incl   -0x4(%ebp)
  801917:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80191a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80191d:	72 f5                	jb     801914 <busy_wait+0xf>
	return i;
  80191f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <__udivdi3>:
  801924:	55                   	push   %ebp
  801925:	57                   	push   %edi
  801926:	56                   	push   %esi
  801927:	53                   	push   %ebx
  801928:	83 ec 1c             	sub    $0x1c,%esp
  80192b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80192f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801933:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801937:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80193b:	89 ca                	mov    %ecx,%edx
  80193d:	89 f8                	mov    %edi,%eax
  80193f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801943:	85 f6                	test   %esi,%esi
  801945:	75 2d                	jne    801974 <__udivdi3+0x50>
  801947:	39 cf                	cmp    %ecx,%edi
  801949:	77 65                	ja     8019b0 <__udivdi3+0x8c>
  80194b:	89 fd                	mov    %edi,%ebp
  80194d:	85 ff                	test   %edi,%edi
  80194f:	75 0b                	jne    80195c <__udivdi3+0x38>
  801951:	b8 01 00 00 00       	mov    $0x1,%eax
  801956:	31 d2                	xor    %edx,%edx
  801958:	f7 f7                	div    %edi
  80195a:	89 c5                	mov    %eax,%ebp
  80195c:	31 d2                	xor    %edx,%edx
  80195e:	89 c8                	mov    %ecx,%eax
  801960:	f7 f5                	div    %ebp
  801962:	89 c1                	mov    %eax,%ecx
  801964:	89 d8                	mov    %ebx,%eax
  801966:	f7 f5                	div    %ebp
  801968:	89 cf                	mov    %ecx,%edi
  80196a:	89 fa                	mov    %edi,%edx
  80196c:	83 c4 1c             	add    $0x1c,%esp
  80196f:	5b                   	pop    %ebx
  801970:	5e                   	pop    %esi
  801971:	5f                   	pop    %edi
  801972:	5d                   	pop    %ebp
  801973:	c3                   	ret    
  801974:	39 ce                	cmp    %ecx,%esi
  801976:	77 28                	ja     8019a0 <__udivdi3+0x7c>
  801978:	0f bd fe             	bsr    %esi,%edi
  80197b:	83 f7 1f             	xor    $0x1f,%edi
  80197e:	75 40                	jne    8019c0 <__udivdi3+0x9c>
  801980:	39 ce                	cmp    %ecx,%esi
  801982:	72 0a                	jb     80198e <__udivdi3+0x6a>
  801984:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801988:	0f 87 9e 00 00 00    	ja     801a2c <__udivdi3+0x108>
  80198e:	b8 01 00 00 00       	mov    $0x1,%eax
  801993:	89 fa                	mov    %edi,%edx
  801995:	83 c4 1c             	add    $0x1c,%esp
  801998:	5b                   	pop    %ebx
  801999:	5e                   	pop    %esi
  80199a:	5f                   	pop    %edi
  80199b:	5d                   	pop    %ebp
  80199c:	c3                   	ret    
  80199d:	8d 76 00             	lea    0x0(%esi),%esi
  8019a0:	31 ff                	xor    %edi,%edi
  8019a2:	31 c0                	xor    %eax,%eax
  8019a4:	89 fa                	mov    %edi,%edx
  8019a6:	83 c4 1c             	add    $0x1c,%esp
  8019a9:	5b                   	pop    %ebx
  8019aa:	5e                   	pop    %esi
  8019ab:	5f                   	pop    %edi
  8019ac:	5d                   	pop    %ebp
  8019ad:	c3                   	ret    
  8019ae:	66 90                	xchg   %ax,%ax
  8019b0:	89 d8                	mov    %ebx,%eax
  8019b2:	f7 f7                	div    %edi
  8019b4:	31 ff                	xor    %edi,%edi
  8019b6:	89 fa                	mov    %edi,%edx
  8019b8:	83 c4 1c             	add    $0x1c,%esp
  8019bb:	5b                   	pop    %ebx
  8019bc:	5e                   	pop    %esi
  8019bd:	5f                   	pop    %edi
  8019be:	5d                   	pop    %ebp
  8019bf:	c3                   	ret    
  8019c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019c5:	89 eb                	mov    %ebp,%ebx
  8019c7:	29 fb                	sub    %edi,%ebx
  8019c9:	89 f9                	mov    %edi,%ecx
  8019cb:	d3 e6                	shl    %cl,%esi
  8019cd:	89 c5                	mov    %eax,%ebp
  8019cf:	88 d9                	mov    %bl,%cl
  8019d1:	d3 ed                	shr    %cl,%ebp
  8019d3:	89 e9                	mov    %ebp,%ecx
  8019d5:	09 f1                	or     %esi,%ecx
  8019d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019db:	89 f9                	mov    %edi,%ecx
  8019dd:	d3 e0                	shl    %cl,%eax
  8019df:	89 c5                	mov    %eax,%ebp
  8019e1:	89 d6                	mov    %edx,%esi
  8019e3:	88 d9                	mov    %bl,%cl
  8019e5:	d3 ee                	shr    %cl,%esi
  8019e7:	89 f9                	mov    %edi,%ecx
  8019e9:	d3 e2                	shl    %cl,%edx
  8019eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019ef:	88 d9                	mov    %bl,%cl
  8019f1:	d3 e8                	shr    %cl,%eax
  8019f3:	09 c2                	or     %eax,%edx
  8019f5:	89 d0                	mov    %edx,%eax
  8019f7:	89 f2                	mov    %esi,%edx
  8019f9:	f7 74 24 0c          	divl   0xc(%esp)
  8019fd:	89 d6                	mov    %edx,%esi
  8019ff:	89 c3                	mov    %eax,%ebx
  801a01:	f7 e5                	mul    %ebp
  801a03:	39 d6                	cmp    %edx,%esi
  801a05:	72 19                	jb     801a20 <__udivdi3+0xfc>
  801a07:	74 0b                	je     801a14 <__udivdi3+0xf0>
  801a09:	89 d8                	mov    %ebx,%eax
  801a0b:	31 ff                	xor    %edi,%edi
  801a0d:	e9 58 ff ff ff       	jmp    80196a <__udivdi3+0x46>
  801a12:	66 90                	xchg   %ax,%ax
  801a14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a18:	89 f9                	mov    %edi,%ecx
  801a1a:	d3 e2                	shl    %cl,%edx
  801a1c:	39 c2                	cmp    %eax,%edx
  801a1e:	73 e9                	jae    801a09 <__udivdi3+0xe5>
  801a20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a23:	31 ff                	xor    %edi,%edi
  801a25:	e9 40 ff ff ff       	jmp    80196a <__udivdi3+0x46>
  801a2a:	66 90                	xchg   %ax,%ax
  801a2c:	31 c0                	xor    %eax,%eax
  801a2e:	e9 37 ff ff ff       	jmp    80196a <__udivdi3+0x46>
  801a33:	90                   	nop

00801a34 <__umoddi3>:
  801a34:	55                   	push   %ebp
  801a35:	57                   	push   %edi
  801a36:	56                   	push   %esi
  801a37:	53                   	push   %ebx
  801a38:	83 ec 1c             	sub    $0x1c,%esp
  801a3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a53:	89 f3                	mov    %esi,%ebx
  801a55:	89 fa                	mov    %edi,%edx
  801a57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a5b:	89 34 24             	mov    %esi,(%esp)
  801a5e:	85 c0                	test   %eax,%eax
  801a60:	75 1a                	jne    801a7c <__umoddi3+0x48>
  801a62:	39 f7                	cmp    %esi,%edi
  801a64:	0f 86 a2 00 00 00    	jbe    801b0c <__umoddi3+0xd8>
  801a6a:	89 c8                	mov    %ecx,%eax
  801a6c:	89 f2                	mov    %esi,%edx
  801a6e:	f7 f7                	div    %edi
  801a70:	89 d0                	mov    %edx,%eax
  801a72:	31 d2                	xor    %edx,%edx
  801a74:	83 c4 1c             	add    $0x1c,%esp
  801a77:	5b                   	pop    %ebx
  801a78:	5e                   	pop    %esi
  801a79:	5f                   	pop    %edi
  801a7a:	5d                   	pop    %ebp
  801a7b:	c3                   	ret    
  801a7c:	39 f0                	cmp    %esi,%eax
  801a7e:	0f 87 ac 00 00 00    	ja     801b30 <__umoddi3+0xfc>
  801a84:	0f bd e8             	bsr    %eax,%ebp
  801a87:	83 f5 1f             	xor    $0x1f,%ebp
  801a8a:	0f 84 ac 00 00 00    	je     801b3c <__umoddi3+0x108>
  801a90:	bf 20 00 00 00       	mov    $0x20,%edi
  801a95:	29 ef                	sub    %ebp,%edi
  801a97:	89 fe                	mov    %edi,%esi
  801a99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a9d:	89 e9                	mov    %ebp,%ecx
  801a9f:	d3 e0                	shl    %cl,%eax
  801aa1:	89 d7                	mov    %edx,%edi
  801aa3:	89 f1                	mov    %esi,%ecx
  801aa5:	d3 ef                	shr    %cl,%edi
  801aa7:	09 c7                	or     %eax,%edi
  801aa9:	89 e9                	mov    %ebp,%ecx
  801aab:	d3 e2                	shl    %cl,%edx
  801aad:	89 14 24             	mov    %edx,(%esp)
  801ab0:	89 d8                	mov    %ebx,%eax
  801ab2:	d3 e0                	shl    %cl,%eax
  801ab4:	89 c2                	mov    %eax,%edx
  801ab6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aba:	d3 e0                	shl    %cl,%eax
  801abc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ac0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ac4:	89 f1                	mov    %esi,%ecx
  801ac6:	d3 e8                	shr    %cl,%eax
  801ac8:	09 d0                	or     %edx,%eax
  801aca:	d3 eb                	shr    %cl,%ebx
  801acc:	89 da                	mov    %ebx,%edx
  801ace:	f7 f7                	div    %edi
  801ad0:	89 d3                	mov    %edx,%ebx
  801ad2:	f7 24 24             	mull   (%esp)
  801ad5:	89 c6                	mov    %eax,%esi
  801ad7:	89 d1                	mov    %edx,%ecx
  801ad9:	39 d3                	cmp    %edx,%ebx
  801adb:	0f 82 87 00 00 00    	jb     801b68 <__umoddi3+0x134>
  801ae1:	0f 84 91 00 00 00    	je     801b78 <__umoddi3+0x144>
  801ae7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801aeb:	29 f2                	sub    %esi,%edx
  801aed:	19 cb                	sbb    %ecx,%ebx
  801aef:	89 d8                	mov    %ebx,%eax
  801af1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801af5:	d3 e0                	shl    %cl,%eax
  801af7:	89 e9                	mov    %ebp,%ecx
  801af9:	d3 ea                	shr    %cl,%edx
  801afb:	09 d0                	or     %edx,%eax
  801afd:	89 e9                	mov    %ebp,%ecx
  801aff:	d3 eb                	shr    %cl,%ebx
  801b01:	89 da                	mov    %ebx,%edx
  801b03:	83 c4 1c             	add    $0x1c,%esp
  801b06:	5b                   	pop    %ebx
  801b07:	5e                   	pop    %esi
  801b08:	5f                   	pop    %edi
  801b09:	5d                   	pop    %ebp
  801b0a:	c3                   	ret    
  801b0b:	90                   	nop
  801b0c:	89 fd                	mov    %edi,%ebp
  801b0e:	85 ff                	test   %edi,%edi
  801b10:	75 0b                	jne    801b1d <__umoddi3+0xe9>
  801b12:	b8 01 00 00 00       	mov    $0x1,%eax
  801b17:	31 d2                	xor    %edx,%edx
  801b19:	f7 f7                	div    %edi
  801b1b:	89 c5                	mov    %eax,%ebp
  801b1d:	89 f0                	mov    %esi,%eax
  801b1f:	31 d2                	xor    %edx,%edx
  801b21:	f7 f5                	div    %ebp
  801b23:	89 c8                	mov    %ecx,%eax
  801b25:	f7 f5                	div    %ebp
  801b27:	89 d0                	mov    %edx,%eax
  801b29:	e9 44 ff ff ff       	jmp    801a72 <__umoddi3+0x3e>
  801b2e:	66 90                	xchg   %ax,%ax
  801b30:	89 c8                	mov    %ecx,%eax
  801b32:	89 f2                	mov    %esi,%edx
  801b34:	83 c4 1c             	add    $0x1c,%esp
  801b37:	5b                   	pop    %ebx
  801b38:	5e                   	pop    %esi
  801b39:	5f                   	pop    %edi
  801b3a:	5d                   	pop    %ebp
  801b3b:	c3                   	ret    
  801b3c:	3b 04 24             	cmp    (%esp),%eax
  801b3f:	72 06                	jb     801b47 <__umoddi3+0x113>
  801b41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b45:	77 0f                	ja     801b56 <__umoddi3+0x122>
  801b47:	89 f2                	mov    %esi,%edx
  801b49:	29 f9                	sub    %edi,%ecx
  801b4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b4f:	89 14 24             	mov    %edx,(%esp)
  801b52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b5a:	8b 14 24             	mov    (%esp),%edx
  801b5d:	83 c4 1c             	add    $0x1c,%esp
  801b60:	5b                   	pop    %ebx
  801b61:	5e                   	pop    %esi
  801b62:	5f                   	pop    %edi
  801b63:	5d                   	pop    %ebp
  801b64:	c3                   	ret    
  801b65:	8d 76 00             	lea    0x0(%esi),%esi
  801b68:	2b 04 24             	sub    (%esp),%eax
  801b6b:	19 fa                	sbb    %edi,%edx
  801b6d:	89 d1                	mov    %edx,%ecx
  801b6f:	89 c6                	mov    %eax,%esi
  801b71:	e9 71 ff ff ff       	jmp    801ae7 <__umoddi3+0xb3>
  801b76:	66 90                	xchg   %ax,%ax
  801b78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b7c:	72 ea                	jb     801b68 <__umoddi3+0x134>
  801b7e:	89 d9                	mov    %ebx,%ecx
  801b80:	e9 62 ff ff ff       	jmp    801ae7 <__umoddi3+0xb3>
