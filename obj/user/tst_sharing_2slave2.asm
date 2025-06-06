
obj/user/tst_sharing_2slave2:     file format elf32-i386


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
  800031:	e8 b6 01 00 00       	call   8001ec <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Slave program2: Get 2 shared variables, edit the writable one, and attempt to edit the readOnly one
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 29                	jmp    800075 <_main+0x3d>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	89 d0                	mov    %edx,%eax
  80005c:	01 c0                	add    %eax,%eax
  80005e:	01 d0                	add    %edx,%eax
  800060:	c1 e0 02             	shl    $0x2,%eax
  800063:	01 c8                	add    %ecx,%eax
  800065:	8a 40 04             	mov    0x4(%eax),%al
  800068:	84 c0                	test   %al,%al
  80006a:	74 06                	je     800072 <_main+0x3a>
			{
				fullWS = 0;
  80006c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800070:	eb 12                	jmp    800084 <_main+0x4c>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800072:	ff 45 f0             	incl   -0x10(%ebp)
  800075:	a1 20 30 80 00       	mov    0x803020,%eax
  80007a:	8b 50 74             	mov    0x74(%eax),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	39 c2                	cmp    %eax,%edx
  800082:	77 c8                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800084:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800088:	74 14                	je     80009e <_main+0x66>
  80008a:	83 ec 04             	sub    $0x4,%esp
  80008d:	68 40 1e 80 00       	push   $0x801e40
  800092:	6a 13                	push   $0x13
  800094:	68 5c 1e 80 00       	push   $0x801e5c
  800099:	e8 50 02 00 00       	call   8002ee <_panic>
	}

	int32 parentenvID = sys_getparentenvid();
  80009e:	e8 d3 15 00 00       	call   801676 <sys_getparentenvid>
  8000a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
	uint32 *x, *z;

	//GET: z then x, opposite to creation order (x then y then z)
	//So, addresses here will be different from the OWNER addresses
	sys_disable_interrupt();
  8000a6:	e8 4d 17 00 00       	call   8017f8 <sys_disable_interrupt>
	int freeFrames = sys_calculate_free_frames() ;
  8000ab:	e8 78 16 00 00       	call   801728 <sys_calculate_free_frames>
  8000b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
	z = sget(parentenvID,"z");
  8000b3:	83 ec 08             	sub    $0x8,%esp
  8000b6:	68 77 1e 80 00       	push   $0x801e77
  8000bb:	ff 75 ec             	pushl  -0x14(%ebp)
  8000be:	e8 89 12 00 00       	call   80134c <sget>
  8000c3:	83 c4 10             	add    $0x10,%esp
  8000c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (z != (uint32*)(USER_HEAP_START + 0 * PAGE_SIZE)) panic("Get(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8000c9:	81 7d e4 00 00 00 80 	cmpl   $0x80000000,-0x1c(%ebp)
  8000d0:	74 14                	je     8000e6 <_main+0xae>
  8000d2:	83 ec 04             	sub    $0x4,%esp
  8000d5:	68 7c 1e 80 00       	push   $0x801e7c
  8000da:	6a 1e                	push   $0x1e
  8000dc:	68 5c 1e 80 00       	push   $0x801e5c
  8000e1:	e8 08 02 00 00       	call   8002ee <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1) panic("Get(): Wrong sharing- make sure that you share the required space in the current user environment using the correct frames (from frames_storage)");
  8000e6:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000e9:	e8 3a 16 00 00       	call   801728 <sys_calculate_free_frames>
  8000ee:	29 c3                	sub    %eax,%ebx
  8000f0:	89 d8                	mov    %ebx,%eax
  8000f2:	83 f8 01             	cmp    $0x1,%eax
  8000f5:	74 14                	je     80010b <_main+0xd3>
  8000f7:	83 ec 04             	sub    $0x4,%esp
  8000fa:	68 dc 1e 80 00       	push   $0x801edc
  8000ff:	6a 1f                	push   $0x1f
  800101:	68 5c 1e 80 00       	push   $0x801e5c
  800106:	e8 e3 01 00 00       	call   8002ee <_panic>
	sys_enable_interrupt();
  80010b:	e8 02 17 00 00       	call   801812 <sys_enable_interrupt>

	sys_disable_interrupt();
  800110:	e8 e3 16 00 00       	call   8017f8 <sys_disable_interrupt>
	freeFrames = sys_calculate_free_frames() ;
  800115:	e8 0e 16 00 00       	call   801728 <sys_calculate_free_frames>
  80011a:	89 45 e8             	mov    %eax,-0x18(%ebp)
	x = sget(parentenvID,"x");
  80011d:	83 ec 08             	sub    $0x8,%esp
  800120:	68 6d 1f 80 00       	push   $0x801f6d
  800125:	ff 75 ec             	pushl  -0x14(%ebp)
  800128:	e8 1f 12 00 00       	call   80134c <sget>
  80012d:	83 c4 10             	add    $0x10,%esp
  800130:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (x != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Get(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  800133:	81 7d e0 00 10 00 80 	cmpl   $0x80001000,-0x20(%ebp)
  80013a:	74 14                	je     800150 <_main+0x118>
  80013c:	83 ec 04             	sub    $0x4,%esp
  80013f:	68 7c 1e 80 00       	push   $0x801e7c
  800144:	6a 25                	push   $0x25
  800146:	68 5c 1e 80 00       	push   $0x801e5c
  80014b:	e8 9e 01 00 00       	call   8002ee <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Get(): Wrong sharing- make sure that you share the required space in the current user environment using the correct frames (from frames_storage)");
  800150:	e8 d3 15 00 00       	call   801728 <sys_calculate_free_frames>
  800155:	89 c2                	mov    %eax,%edx
  800157:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80015a:	39 c2                	cmp    %eax,%edx
  80015c:	74 14                	je     800172 <_main+0x13a>
  80015e:	83 ec 04             	sub    $0x4,%esp
  800161:	68 dc 1e 80 00       	push   $0x801edc
  800166:	6a 26                	push   $0x26
  800168:	68 5c 1e 80 00       	push   $0x801e5c
  80016d:	e8 7c 01 00 00       	call   8002ee <_panic>
	sys_enable_interrupt();
  800172:	e8 9b 16 00 00       	call   801812 <sys_enable_interrupt>

	if (*x != 10) panic("Get(): Shared Variable is not created or got correctly") ;
  800177:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80017a:	8b 00                	mov    (%eax),%eax
  80017c:	83 f8 0a             	cmp    $0xa,%eax
  80017f:	74 14                	je     800195 <_main+0x15d>
  800181:	83 ec 04             	sub    $0x4,%esp
  800184:	68 70 1f 80 00       	push   $0x801f70
  800189:	6a 29                	push   $0x29
  80018b:	68 5c 1e 80 00       	push   $0x801e5c
  800190:	e8 59 01 00 00       	call   8002ee <_panic>

	//Edit the writable object
	*z = 30;
  800195:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800198:	c7 00 1e 00 00 00    	movl   $0x1e,(%eax)
	if (*z != 30) panic("Get(): Shared Variable is not created or got correctly") ;
  80019e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001a1:	8b 00                	mov    (%eax),%eax
  8001a3:	83 f8 1e             	cmp    $0x1e,%eax
  8001a6:	74 14                	je     8001bc <_main+0x184>
  8001a8:	83 ec 04             	sub    $0x4,%esp
  8001ab:	68 70 1f 80 00       	push   $0x801f70
  8001b0:	6a 2d                	push   $0x2d
  8001b2:	68 5c 1e 80 00       	push   $0x801e5c
  8001b7:	e8 32 01 00 00       	call   8002ee <_panic>

	//Attempt to edit the ReadOnly object, it should panic
	cprintf("Attempt to edit the ReadOnly object @ va = %x\n", x);
  8001bc:	83 ec 08             	sub    $0x8,%esp
  8001bf:	ff 75 e0             	pushl  -0x20(%ebp)
  8001c2:	68 a8 1f 80 00       	push   $0x801fa8
  8001c7:	e8 d6 03 00 00       	call   8005a2 <cprintf>
  8001cc:	83 c4 10             	add    $0x10,%esp
	*x = 100;
  8001cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d2:	c7 00 64 00 00 00    	movl   $0x64,(%eax)

	panic("Test FAILED! it should panic early and not reach this line of code") ;
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	68 d8 1f 80 00       	push   $0x801fd8
  8001e0:	6a 33                	push   $0x33
  8001e2:	68 5c 1e 80 00       	push   $0x801e5c
  8001e7:	e8 02 01 00 00       	call   8002ee <_panic>

008001ec <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001ec:	55                   	push   %ebp
  8001ed:	89 e5                	mov    %esp,%ebp
  8001ef:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001f2:	e8 66 14 00 00       	call   80165d <sys_getenvindex>
  8001f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001fd:	89 d0                	mov    %edx,%eax
  8001ff:	01 c0                	add    %eax,%eax
  800201:	01 d0                	add    %edx,%eax
  800203:	c1 e0 02             	shl    $0x2,%eax
  800206:	01 d0                	add    %edx,%eax
  800208:	c1 e0 06             	shl    $0x6,%eax
  80020b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800210:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800215:	a1 20 30 80 00       	mov    0x803020,%eax
  80021a:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800220:	84 c0                	test   %al,%al
  800222:	74 0f                	je     800233 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800224:	a1 20 30 80 00       	mov    0x803020,%eax
  800229:	05 f4 02 00 00       	add    $0x2f4,%eax
  80022e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800233:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800237:	7e 0a                	jle    800243 <libmain+0x57>
		binaryname = argv[0];
  800239:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023c:	8b 00                	mov    (%eax),%eax
  80023e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800243:	83 ec 08             	sub    $0x8,%esp
  800246:	ff 75 0c             	pushl  0xc(%ebp)
  800249:	ff 75 08             	pushl  0x8(%ebp)
  80024c:	e8 e7 fd ff ff       	call   800038 <_main>
  800251:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800254:	e8 9f 15 00 00       	call   8017f8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	68 34 20 80 00       	push   $0x802034
  800261:	e8 3c 03 00 00       	call   8005a2 <cprintf>
  800266:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800269:	a1 20 30 80 00       	mov    0x803020,%eax
  80026e:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800274:	a1 20 30 80 00       	mov    0x803020,%eax
  800279:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	52                   	push   %edx
  800283:	50                   	push   %eax
  800284:	68 5c 20 80 00       	push   $0x80205c
  800289:	e8 14 03 00 00       	call   8005a2 <cprintf>
  80028e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800291:	a1 20 30 80 00       	mov    0x803020,%eax
  800296:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80029c:	83 ec 08             	sub    $0x8,%esp
  80029f:	50                   	push   %eax
  8002a0:	68 81 20 80 00       	push   $0x802081
  8002a5:	e8 f8 02 00 00       	call   8005a2 <cprintf>
  8002aa:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ad:	83 ec 0c             	sub    $0xc,%esp
  8002b0:	68 34 20 80 00       	push   $0x802034
  8002b5:	e8 e8 02 00 00       	call   8005a2 <cprintf>
  8002ba:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002bd:	e8 50 15 00 00       	call   801812 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002c2:	e8 19 00 00 00       	call   8002e0 <exit>
}
  8002c7:	90                   	nop
  8002c8:	c9                   	leave  
  8002c9:	c3                   	ret    

008002ca <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002ca:	55                   	push   %ebp
  8002cb:	89 e5                	mov    %esp,%ebp
  8002cd:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002d0:	83 ec 0c             	sub    $0xc,%esp
  8002d3:	6a 00                	push   $0x0
  8002d5:	e8 4f 13 00 00       	call   801629 <sys_env_destroy>
  8002da:	83 c4 10             	add    $0x10,%esp
}
  8002dd:	90                   	nop
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <exit>:

void
exit(void)
{
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002e6:	e8 a4 13 00 00       	call   80168f <sys_env_exit>
}
  8002eb:	90                   	nop
  8002ec:	c9                   	leave  
  8002ed:	c3                   	ret    

008002ee <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002ee:	55                   	push   %ebp
  8002ef:	89 e5                	mov    %esp,%ebp
  8002f1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002f4:	8d 45 10             	lea    0x10(%ebp),%eax
  8002f7:	83 c0 04             	add    $0x4,%eax
  8002fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002fd:	a1 30 30 80 00       	mov    0x803030,%eax
  800302:	85 c0                	test   %eax,%eax
  800304:	74 16                	je     80031c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800306:	a1 30 30 80 00       	mov    0x803030,%eax
  80030b:	83 ec 08             	sub    $0x8,%esp
  80030e:	50                   	push   %eax
  80030f:	68 98 20 80 00       	push   $0x802098
  800314:	e8 89 02 00 00       	call   8005a2 <cprintf>
  800319:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80031c:	a1 00 30 80 00       	mov    0x803000,%eax
  800321:	ff 75 0c             	pushl  0xc(%ebp)
  800324:	ff 75 08             	pushl  0x8(%ebp)
  800327:	50                   	push   %eax
  800328:	68 9d 20 80 00       	push   $0x80209d
  80032d:	e8 70 02 00 00       	call   8005a2 <cprintf>
  800332:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800335:	8b 45 10             	mov    0x10(%ebp),%eax
  800338:	83 ec 08             	sub    $0x8,%esp
  80033b:	ff 75 f4             	pushl  -0xc(%ebp)
  80033e:	50                   	push   %eax
  80033f:	e8 f3 01 00 00       	call   800537 <vcprintf>
  800344:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800347:	83 ec 08             	sub    $0x8,%esp
  80034a:	6a 00                	push   $0x0
  80034c:	68 b9 20 80 00       	push   $0x8020b9
  800351:	e8 e1 01 00 00       	call   800537 <vcprintf>
  800356:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800359:	e8 82 ff ff ff       	call   8002e0 <exit>

	// should not return here
	while (1) ;
  80035e:	eb fe                	jmp    80035e <_panic+0x70>

00800360 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800360:	55                   	push   %ebp
  800361:	89 e5                	mov    %esp,%ebp
  800363:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800366:	a1 20 30 80 00       	mov    0x803020,%eax
  80036b:	8b 50 74             	mov    0x74(%eax),%edx
  80036e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800371:	39 c2                	cmp    %eax,%edx
  800373:	74 14                	je     800389 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800375:	83 ec 04             	sub    $0x4,%esp
  800378:	68 bc 20 80 00       	push   $0x8020bc
  80037d:	6a 26                	push   $0x26
  80037f:	68 08 21 80 00       	push   $0x802108
  800384:	e8 65 ff ff ff       	call   8002ee <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800389:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800390:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800397:	e9 c2 00 00 00       	jmp    80045e <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80039c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80039f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a9:	01 d0                	add    %edx,%eax
  8003ab:	8b 00                	mov    (%eax),%eax
  8003ad:	85 c0                	test   %eax,%eax
  8003af:	75 08                	jne    8003b9 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003b1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003b4:	e9 a2 00 00 00       	jmp    80045b <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8003b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003c7:	eb 69                	jmp    800432 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ce:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003d4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003d7:	89 d0                	mov    %edx,%eax
  8003d9:	01 c0                	add    %eax,%eax
  8003db:	01 d0                	add    %edx,%eax
  8003dd:	c1 e0 02             	shl    $0x2,%eax
  8003e0:	01 c8                	add    %ecx,%eax
  8003e2:	8a 40 04             	mov    0x4(%eax),%al
  8003e5:	84 c0                	test   %al,%al
  8003e7:	75 46                	jne    80042f <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ee:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003f4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003f7:	89 d0                	mov    %edx,%eax
  8003f9:	01 c0                	add    %eax,%eax
  8003fb:	01 d0                	add    %edx,%eax
  8003fd:	c1 e0 02             	shl    $0x2,%eax
  800400:	01 c8                	add    %ecx,%eax
  800402:	8b 00                	mov    (%eax),%eax
  800404:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800407:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80040a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80040f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800411:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800414:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80041b:	8b 45 08             	mov    0x8(%ebp),%eax
  80041e:	01 c8                	add    %ecx,%eax
  800420:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800422:	39 c2                	cmp    %eax,%edx
  800424:	75 09                	jne    80042f <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800426:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80042d:	eb 12                	jmp    800441 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80042f:	ff 45 e8             	incl   -0x18(%ebp)
  800432:	a1 20 30 80 00       	mov    0x803020,%eax
  800437:	8b 50 74             	mov    0x74(%eax),%edx
  80043a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80043d:	39 c2                	cmp    %eax,%edx
  80043f:	77 88                	ja     8003c9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800441:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800445:	75 14                	jne    80045b <CheckWSWithoutLastIndex+0xfb>
			panic(
  800447:	83 ec 04             	sub    $0x4,%esp
  80044a:	68 14 21 80 00       	push   $0x802114
  80044f:	6a 3a                	push   $0x3a
  800451:	68 08 21 80 00       	push   $0x802108
  800456:	e8 93 fe ff ff       	call   8002ee <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80045b:	ff 45 f0             	incl   -0x10(%ebp)
  80045e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800461:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800464:	0f 8c 32 ff ff ff    	jl     80039c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80046a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800471:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800478:	eb 26                	jmp    8004a0 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80047a:	a1 20 30 80 00       	mov    0x803020,%eax
  80047f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800485:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800488:	89 d0                	mov    %edx,%eax
  80048a:	01 c0                	add    %eax,%eax
  80048c:	01 d0                	add    %edx,%eax
  80048e:	c1 e0 02             	shl    $0x2,%eax
  800491:	01 c8                	add    %ecx,%eax
  800493:	8a 40 04             	mov    0x4(%eax),%al
  800496:	3c 01                	cmp    $0x1,%al
  800498:	75 03                	jne    80049d <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80049a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80049d:	ff 45 e0             	incl   -0x20(%ebp)
  8004a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a5:	8b 50 74             	mov    0x74(%eax),%edx
  8004a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004ab:	39 c2                	cmp    %eax,%edx
  8004ad:	77 cb                	ja     80047a <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004b2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004b5:	74 14                	je     8004cb <CheckWSWithoutLastIndex+0x16b>
		panic(
  8004b7:	83 ec 04             	sub    $0x4,%esp
  8004ba:	68 68 21 80 00       	push   $0x802168
  8004bf:	6a 44                	push   $0x44
  8004c1:	68 08 21 80 00       	push   $0x802108
  8004c6:	e8 23 fe ff ff       	call   8002ee <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004cb:	90                   	nop
  8004cc:	c9                   	leave  
  8004cd:	c3                   	ret    

008004ce <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004ce:	55                   	push   %ebp
  8004cf:	89 e5                	mov    %esp,%ebp
  8004d1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d7:	8b 00                	mov    (%eax),%eax
  8004d9:	8d 48 01             	lea    0x1(%eax),%ecx
  8004dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004df:	89 0a                	mov    %ecx,(%edx)
  8004e1:	8b 55 08             	mov    0x8(%ebp),%edx
  8004e4:	88 d1                	mov    %dl,%cl
  8004e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004e9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f0:	8b 00                	mov    (%eax),%eax
  8004f2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004f7:	75 2c                	jne    800525 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004f9:	a0 24 30 80 00       	mov    0x803024,%al
  8004fe:	0f b6 c0             	movzbl %al,%eax
  800501:	8b 55 0c             	mov    0xc(%ebp),%edx
  800504:	8b 12                	mov    (%edx),%edx
  800506:	89 d1                	mov    %edx,%ecx
  800508:	8b 55 0c             	mov    0xc(%ebp),%edx
  80050b:	83 c2 08             	add    $0x8,%edx
  80050e:	83 ec 04             	sub    $0x4,%esp
  800511:	50                   	push   %eax
  800512:	51                   	push   %ecx
  800513:	52                   	push   %edx
  800514:	e8 ce 10 00 00       	call   8015e7 <sys_cputs>
  800519:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80051c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800525:	8b 45 0c             	mov    0xc(%ebp),%eax
  800528:	8b 40 04             	mov    0x4(%eax),%eax
  80052b:	8d 50 01             	lea    0x1(%eax),%edx
  80052e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800531:	89 50 04             	mov    %edx,0x4(%eax)
}
  800534:	90                   	nop
  800535:	c9                   	leave  
  800536:	c3                   	ret    

00800537 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800537:	55                   	push   %ebp
  800538:	89 e5                	mov    %esp,%ebp
  80053a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800540:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800547:	00 00 00 
	b.cnt = 0;
  80054a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800551:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800554:	ff 75 0c             	pushl  0xc(%ebp)
  800557:	ff 75 08             	pushl  0x8(%ebp)
  80055a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800560:	50                   	push   %eax
  800561:	68 ce 04 80 00       	push   $0x8004ce
  800566:	e8 11 02 00 00       	call   80077c <vprintfmt>
  80056b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80056e:	a0 24 30 80 00       	mov    0x803024,%al
  800573:	0f b6 c0             	movzbl %al,%eax
  800576:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	50                   	push   %eax
  800580:	52                   	push   %edx
  800581:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800587:	83 c0 08             	add    $0x8,%eax
  80058a:	50                   	push   %eax
  80058b:	e8 57 10 00 00       	call   8015e7 <sys_cputs>
  800590:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800593:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80059a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005a0:	c9                   	leave  
  8005a1:	c3                   	ret    

008005a2 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005a2:	55                   	push   %ebp
  8005a3:	89 e5                	mov    %esp,%ebp
  8005a5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005a8:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005af:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b8:	83 ec 08             	sub    $0x8,%esp
  8005bb:	ff 75 f4             	pushl  -0xc(%ebp)
  8005be:	50                   	push   %eax
  8005bf:	e8 73 ff ff ff       	call   800537 <vcprintf>
  8005c4:	83 c4 10             	add    $0x10,%esp
  8005c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005cd:	c9                   	leave  
  8005ce:	c3                   	ret    

008005cf <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005cf:	55                   	push   %ebp
  8005d0:	89 e5                	mov    %esp,%ebp
  8005d2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005d5:	e8 1e 12 00 00       	call   8017f8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005da:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e3:	83 ec 08             	sub    $0x8,%esp
  8005e6:	ff 75 f4             	pushl  -0xc(%ebp)
  8005e9:	50                   	push   %eax
  8005ea:	e8 48 ff ff ff       	call   800537 <vcprintf>
  8005ef:	83 c4 10             	add    $0x10,%esp
  8005f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005f5:	e8 18 12 00 00       	call   801812 <sys_enable_interrupt>
	return cnt;
  8005fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005fd:	c9                   	leave  
  8005fe:	c3                   	ret    

008005ff <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005ff:	55                   	push   %ebp
  800600:	89 e5                	mov    %esp,%ebp
  800602:	53                   	push   %ebx
  800603:	83 ec 14             	sub    $0x14,%esp
  800606:	8b 45 10             	mov    0x10(%ebp),%eax
  800609:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80060c:	8b 45 14             	mov    0x14(%ebp),%eax
  80060f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800612:	8b 45 18             	mov    0x18(%ebp),%eax
  800615:	ba 00 00 00 00       	mov    $0x0,%edx
  80061a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80061d:	77 55                	ja     800674 <printnum+0x75>
  80061f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800622:	72 05                	jb     800629 <printnum+0x2a>
  800624:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800627:	77 4b                	ja     800674 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800629:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80062c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80062f:	8b 45 18             	mov    0x18(%ebp),%eax
  800632:	ba 00 00 00 00       	mov    $0x0,%edx
  800637:	52                   	push   %edx
  800638:	50                   	push   %eax
  800639:	ff 75 f4             	pushl  -0xc(%ebp)
  80063c:	ff 75 f0             	pushl  -0x10(%ebp)
  80063f:	e8 94 15 00 00       	call   801bd8 <__udivdi3>
  800644:	83 c4 10             	add    $0x10,%esp
  800647:	83 ec 04             	sub    $0x4,%esp
  80064a:	ff 75 20             	pushl  0x20(%ebp)
  80064d:	53                   	push   %ebx
  80064e:	ff 75 18             	pushl  0x18(%ebp)
  800651:	52                   	push   %edx
  800652:	50                   	push   %eax
  800653:	ff 75 0c             	pushl  0xc(%ebp)
  800656:	ff 75 08             	pushl  0x8(%ebp)
  800659:	e8 a1 ff ff ff       	call   8005ff <printnum>
  80065e:	83 c4 20             	add    $0x20,%esp
  800661:	eb 1a                	jmp    80067d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800663:	83 ec 08             	sub    $0x8,%esp
  800666:	ff 75 0c             	pushl  0xc(%ebp)
  800669:	ff 75 20             	pushl  0x20(%ebp)
  80066c:	8b 45 08             	mov    0x8(%ebp),%eax
  80066f:	ff d0                	call   *%eax
  800671:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800674:	ff 4d 1c             	decl   0x1c(%ebp)
  800677:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80067b:	7f e6                	jg     800663 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80067d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800680:	bb 00 00 00 00       	mov    $0x0,%ebx
  800685:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800688:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80068b:	53                   	push   %ebx
  80068c:	51                   	push   %ecx
  80068d:	52                   	push   %edx
  80068e:	50                   	push   %eax
  80068f:	e8 54 16 00 00       	call   801ce8 <__umoddi3>
  800694:	83 c4 10             	add    $0x10,%esp
  800697:	05 d4 23 80 00       	add    $0x8023d4,%eax
  80069c:	8a 00                	mov    (%eax),%al
  80069e:	0f be c0             	movsbl %al,%eax
  8006a1:	83 ec 08             	sub    $0x8,%esp
  8006a4:	ff 75 0c             	pushl  0xc(%ebp)
  8006a7:	50                   	push   %eax
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	ff d0                	call   *%eax
  8006ad:	83 c4 10             	add    $0x10,%esp
}
  8006b0:	90                   	nop
  8006b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006b4:	c9                   	leave  
  8006b5:	c3                   	ret    

008006b6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006b6:	55                   	push   %ebp
  8006b7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006b9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006bd:	7e 1c                	jle    8006db <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	8b 00                	mov    (%eax),%eax
  8006c4:	8d 50 08             	lea    0x8(%eax),%edx
  8006c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ca:	89 10                	mov    %edx,(%eax)
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	8b 00                	mov    (%eax),%eax
  8006d1:	83 e8 08             	sub    $0x8,%eax
  8006d4:	8b 50 04             	mov    0x4(%eax),%edx
  8006d7:	8b 00                	mov    (%eax),%eax
  8006d9:	eb 40                	jmp    80071b <getuint+0x65>
	else if (lflag)
  8006db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006df:	74 1e                	je     8006ff <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e4:	8b 00                	mov    (%eax),%eax
  8006e6:	8d 50 04             	lea    0x4(%eax),%edx
  8006e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ec:	89 10                	mov    %edx,(%eax)
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	8b 00                	mov    (%eax),%eax
  8006f3:	83 e8 04             	sub    $0x4,%eax
  8006f6:	8b 00                	mov    (%eax),%eax
  8006f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8006fd:	eb 1c                	jmp    80071b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800702:	8b 00                	mov    (%eax),%eax
  800704:	8d 50 04             	lea    0x4(%eax),%edx
  800707:	8b 45 08             	mov    0x8(%ebp),%eax
  80070a:	89 10                	mov    %edx,(%eax)
  80070c:	8b 45 08             	mov    0x8(%ebp),%eax
  80070f:	8b 00                	mov    (%eax),%eax
  800711:	83 e8 04             	sub    $0x4,%eax
  800714:	8b 00                	mov    (%eax),%eax
  800716:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80071b:	5d                   	pop    %ebp
  80071c:	c3                   	ret    

0080071d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80071d:	55                   	push   %ebp
  80071e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800720:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800724:	7e 1c                	jle    800742 <getint+0x25>
		return va_arg(*ap, long long);
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	8b 00                	mov    (%eax),%eax
  80072b:	8d 50 08             	lea    0x8(%eax),%edx
  80072e:	8b 45 08             	mov    0x8(%ebp),%eax
  800731:	89 10                	mov    %edx,(%eax)
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	8b 00                	mov    (%eax),%eax
  800738:	83 e8 08             	sub    $0x8,%eax
  80073b:	8b 50 04             	mov    0x4(%eax),%edx
  80073e:	8b 00                	mov    (%eax),%eax
  800740:	eb 38                	jmp    80077a <getint+0x5d>
	else if (lflag)
  800742:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800746:	74 1a                	je     800762 <getint+0x45>
		return va_arg(*ap, long);
  800748:	8b 45 08             	mov    0x8(%ebp),%eax
  80074b:	8b 00                	mov    (%eax),%eax
  80074d:	8d 50 04             	lea    0x4(%eax),%edx
  800750:	8b 45 08             	mov    0x8(%ebp),%eax
  800753:	89 10                	mov    %edx,(%eax)
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	8b 00                	mov    (%eax),%eax
  80075a:	83 e8 04             	sub    $0x4,%eax
  80075d:	8b 00                	mov    (%eax),%eax
  80075f:	99                   	cltd   
  800760:	eb 18                	jmp    80077a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800762:	8b 45 08             	mov    0x8(%ebp),%eax
  800765:	8b 00                	mov    (%eax),%eax
  800767:	8d 50 04             	lea    0x4(%eax),%edx
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	89 10                	mov    %edx,(%eax)
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	8b 00                	mov    (%eax),%eax
  800774:	83 e8 04             	sub    $0x4,%eax
  800777:	8b 00                	mov    (%eax),%eax
  800779:	99                   	cltd   
}
  80077a:	5d                   	pop    %ebp
  80077b:	c3                   	ret    

0080077c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80077c:	55                   	push   %ebp
  80077d:	89 e5                	mov    %esp,%ebp
  80077f:	56                   	push   %esi
  800780:	53                   	push   %ebx
  800781:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800784:	eb 17                	jmp    80079d <vprintfmt+0x21>
			if (ch == '\0')
  800786:	85 db                	test   %ebx,%ebx
  800788:	0f 84 af 03 00 00    	je     800b3d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80078e:	83 ec 08             	sub    $0x8,%esp
  800791:	ff 75 0c             	pushl  0xc(%ebp)
  800794:	53                   	push   %ebx
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	ff d0                	call   *%eax
  80079a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80079d:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a0:	8d 50 01             	lea    0x1(%eax),%edx
  8007a3:	89 55 10             	mov    %edx,0x10(%ebp)
  8007a6:	8a 00                	mov    (%eax),%al
  8007a8:	0f b6 d8             	movzbl %al,%ebx
  8007ab:	83 fb 25             	cmp    $0x25,%ebx
  8007ae:	75 d6                	jne    800786 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007b0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007b4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007bb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007c2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007c9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d3:	8d 50 01             	lea    0x1(%eax),%edx
  8007d6:	89 55 10             	mov    %edx,0x10(%ebp)
  8007d9:	8a 00                	mov    (%eax),%al
  8007db:	0f b6 d8             	movzbl %al,%ebx
  8007de:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007e1:	83 f8 55             	cmp    $0x55,%eax
  8007e4:	0f 87 2b 03 00 00    	ja     800b15 <vprintfmt+0x399>
  8007ea:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  8007f1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007f3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007f7:	eb d7                	jmp    8007d0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007f9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007fd:	eb d1                	jmp    8007d0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007ff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800806:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800809:	89 d0                	mov    %edx,%eax
  80080b:	c1 e0 02             	shl    $0x2,%eax
  80080e:	01 d0                	add    %edx,%eax
  800810:	01 c0                	add    %eax,%eax
  800812:	01 d8                	add    %ebx,%eax
  800814:	83 e8 30             	sub    $0x30,%eax
  800817:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80081a:	8b 45 10             	mov    0x10(%ebp),%eax
  80081d:	8a 00                	mov    (%eax),%al
  80081f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800822:	83 fb 2f             	cmp    $0x2f,%ebx
  800825:	7e 3e                	jle    800865 <vprintfmt+0xe9>
  800827:	83 fb 39             	cmp    $0x39,%ebx
  80082a:	7f 39                	jg     800865 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80082c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80082f:	eb d5                	jmp    800806 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800831:	8b 45 14             	mov    0x14(%ebp),%eax
  800834:	83 c0 04             	add    $0x4,%eax
  800837:	89 45 14             	mov    %eax,0x14(%ebp)
  80083a:	8b 45 14             	mov    0x14(%ebp),%eax
  80083d:	83 e8 04             	sub    $0x4,%eax
  800840:	8b 00                	mov    (%eax),%eax
  800842:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800845:	eb 1f                	jmp    800866 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800847:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80084b:	79 83                	jns    8007d0 <vprintfmt+0x54>
				width = 0;
  80084d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800854:	e9 77 ff ff ff       	jmp    8007d0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800859:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800860:	e9 6b ff ff ff       	jmp    8007d0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800865:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800866:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80086a:	0f 89 60 ff ff ff    	jns    8007d0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800870:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800873:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800876:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80087d:	e9 4e ff ff ff       	jmp    8007d0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800882:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800885:	e9 46 ff ff ff       	jmp    8007d0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80088a:	8b 45 14             	mov    0x14(%ebp),%eax
  80088d:	83 c0 04             	add    $0x4,%eax
  800890:	89 45 14             	mov    %eax,0x14(%ebp)
  800893:	8b 45 14             	mov    0x14(%ebp),%eax
  800896:	83 e8 04             	sub    $0x4,%eax
  800899:	8b 00                	mov    (%eax),%eax
  80089b:	83 ec 08             	sub    $0x8,%esp
  80089e:	ff 75 0c             	pushl  0xc(%ebp)
  8008a1:	50                   	push   %eax
  8008a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a5:	ff d0                	call   *%eax
  8008a7:	83 c4 10             	add    $0x10,%esp
			break;
  8008aa:	e9 89 02 00 00       	jmp    800b38 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008af:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b2:	83 c0 04             	add    $0x4,%eax
  8008b5:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008bb:	83 e8 04             	sub    $0x4,%eax
  8008be:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008c0:	85 db                	test   %ebx,%ebx
  8008c2:	79 02                	jns    8008c6 <vprintfmt+0x14a>
				err = -err;
  8008c4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008c6:	83 fb 64             	cmp    $0x64,%ebx
  8008c9:	7f 0b                	jg     8008d6 <vprintfmt+0x15a>
  8008cb:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  8008d2:	85 f6                	test   %esi,%esi
  8008d4:	75 19                	jne    8008ef <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008d6:	53                   	push   %ebx
  8008d7:	68 e5 23 80 00       	push   $0x8023e5
  8008dc:	ff 75 0c             	pushl  0xc(%ebp)
  8008df:	ff 75 08             	pushl  0x8(%ebp)
  8008e2:	e8 5e 02 00 00       	call   800b45 <printfmt>
  8008e7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008ea:	e9 49 02 00 00       	jmp    800b38 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008ef:	56                   	push   %esi
  8008f0:	68 ee 23 80 00       	push   $0x8023ee
  8008f5:	ff 75 0c             	pushl  0xc(%ebp)
  8008f8:	ff 75 08             	pushl  0x8(%ebp)
  8008fb:	e8 45 02 00 00       	call   800b45 <printfmt>
  800900:	83 c4 10             	add    $0x10,%esp
			break;
  800903:	e9 30 02 00 00       	jmp    800b38 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800908:	8b 45 14             	mov    0x14(%ebp),%eax
  80090b:	83 c0 04             	add    $0x4,%eax
  80090e:	89 45 14             	mov    %eax,0x14(%ebp)
  800911:	8b 45 14             	mov    0x14(%ebp),%eax
  800914:	83 e8 04             	sub    $0x4,%eax
  800917:	8b 30                	mov    (%eax),%esi
  800919:	85 f6                	test   %esi,%esi
  80091b:	75 05                	jne    800922 <vprintfmt+0x1a6>
				p = "(null)";
  80091d:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  800922:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800926:	7e 6d                	jle    800995 <vprintfmt+0x219>
  800928:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80092c:	74 67                	je     800995 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80092e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800931:	83 ec 08             	sub    $0x8,%esp
  800934:	50                   	push   %eax
  800935:	56                   	push   %esi
  800936:	e8 0c 03 00 00       	call   800c47 <strnlen>
  80093b:	83 c4 10             	add    $0x10,%esp
  80093e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800941:	eb 16                	jmp    800959 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800943:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800947:	83 ec 08             	sub    $0x8,%esp
  80094a:	ff 75 0c             	pushl  0xc(%ebp)
  80094d:	50                   	push   %eax
  80094e:	8b 45 08             	mov    0x8(%ebp),%eax
  800951:	ff d0                	call   *%eax
  800953:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800956:	ff 4d e4             	decl   -0x1c(%ebp)
  800959:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80095d:	7f e4                	jg     800943 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80095f:	eb 34                	jmp    800995 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800961:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800965:	74 1c                	je     800983 <vprintfmt+0x207>
  800967:	83 fb 1f             	cmp    $0x1f,%ebx
  80096a:	7e 05                	jle    800971 <vprintfmt+0x1f5>
  80096c:	83 fb 7e             	cmp    $0x7e,%ebx
  80096f:	7e 12                	jle    800983 <vprintfmt+0x207>
					putch('?', putdat);
  800971:	83 ec 08             	sub    $0x8,%esp
  800974:	ff 75 0c             	pushl  0xc(%ebp)
  800977:	6a 3f                	push   $0x3f
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	ff d0                	call   *%eax
  80097e:	83 c4 10             	add    $0x10,%esp
  800981:	eb 0f                	jmp    800992 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800983:	83 ec 08             	sub    $0x8,%esp
  800986:	ff 75 0c             	pushl  0xc(%ebp)
  800989:	53                   	push   %ebx
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	ff d0                	call   *%eax
  80098f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800992:	ff 4d e4             	decl   -0x1c(%ebp)
  800995:	89 f0                	mov    %esi,%eax
  800997:	8d 70 01             	lea    0x1(%eax),%esi
  80099a:	8a 00                	mov    (%eax),%al
  80099c:	0f be d8             	movsbl %al,%ebx
  80099f:	85 db                	test   %ebx,%ebx
  8009a1:	74 24                	je     8009c7 <vprintfmt+0x24b>
  8009a3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009a7:	78 b8                	js     800961 <vprintfmt+0x1e5>
  8009a9:	ff 4d e0             	decl   -0x20(%ebp)
  8009ac:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009b0:	79 af                	jns    800961 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009b2:	eb 13                	jmp    8009c7 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009b4:	83 ec 08             	sub    $0x8,%esp
  8009b7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ba:	6a 20                	push   $0x20
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	ff d0                	call   *%eax
  8009c1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009c4:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009cb:	7f e7                	jg     8009b4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009cd:	e9 66 01 00 00       	jmp    800b38 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009d2:	83 ec 08             	sub    $0x8,%esp
  8009d5:	ff 75 e8             	pushl  -0x18(%ebp)
  8009d8:	8d 45 14             	lea    0x14(%ebp),%eax
  8009db:	50                   	push   %eax
  8009dc:	e8 3c fd ff ff       	call   80071d <getint>
  8009e1:	83 c4 10             	add    $0x10,%esp
  8009e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f0:	85 d2                	test   %edx,%edx
  8009f2:	79 23                	jns    800a17 <vprintfmt+0x29b>
				putch('-', putdat);
  8009f4:	83 ec 08             	sub    $0x8,%esp
  8009f7:	ff 75 0c             	pushl  0xc(%ebp)
  8009fa:	6a 2d                	push   $0x2d
  8009fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ff:	ff d0                	call   *%eax
  800a01:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a0a:	f7 d8                	neg    %eax
  800a0c:	83 d2 00             	adc    $0x0,%edx
  800a0f:	f7 da                	neg    %edx
  800a11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a14:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a17:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a1e:	e9 bc 00 00 00       	jmp    800adf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a23:	83 ec 08             	sub    $0x8,%esp
  800a26:	ff 75 e8             	pushl  -0x18(%ebp)
  800a29:	8d 45 14             	lea    0x14(%ebp),%eax
  800a2c:	50                   	push   %eax
  800a2d:	e8 84 fc ff ff       	call   8006b6 <getuint>
  800a32:	83 c4 10             	add    $0x10,%esp
  800a35:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a38:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a3b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a42:	e9 98 00 00 00       	jmp    800adf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a47:	83 ec 08             	sub    $0x8,%esp
  800a4a:	ff 75 0c             	pushl  0xc(%ebp)
  800a4d:	6a 58                	push   $0x58
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	ff d0                	call   *%eax
  800a54:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a57:	83 ec 08             	sub    $0x8,%esp
  800a5a:	ff 75 0c             	pushl  0xc(%ebp)
  800a5d:	6a 58                	push   $0x58
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	ff d0                	call   *%eax
  800a64:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a67:	83 ec 08             	sub    $0x8,%esp
  800a6a:	ff 75 0c             	pushl  0xc(%ebp)
  800a6d:	6a 58                	push   $0x58
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	ff d0                	call   *%eax
  800a74:	83 c4 10             	add    $0x10,%esp
			break;
  800a77:	e9 bc 00 00 00       	jmp    800b38 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a7c:	83 ec 08             	sub    $0x8,%esp
  800a7f:	ff 75 0c             	pushl  0xc(%ebp)
  800a82:	6a 30                	push   $0x30
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	ff d0                	call   *%eax
  800a89:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a8c:	83 ec 08             	sub    $0x8,%esp
  800a8f:	ff 75 0c             	pushl  0xc(%ebp)
  800a92:	6a 78                	push   $0x78
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	ff d0                	call   *%eax
  800a99:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9f:	83 c0 04             	add    $0x4,%eax
  800aa2:	89 45 14             	mov    %eax,0x14(%ebp)
  800aa5:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa8:	83 e8 04             	sub    $0x4,%eax
  800aab:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800aad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ab7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800abe:	eb 1f                	jmp    800adf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ac0:	83 ec 08             	sub    $0x8,%esp
  800ac3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ac6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ac9:	50                   	push   %eax
  800aca:	e8 e7 fb ff ff       	call   8006b6 <getuint>
  800acf:	83 c4 10             	add    $0x10,%esp
  800ad2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ad8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800adf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ae3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ae6:	83 ec 04             	sub    $0x4,%esp
  800ae9:	52                   	push   %edx
  800aea:	ff 75 e4             	pushl  -0x1c(%ebp)
  800aed:	50                   	push   %eax
  800aee:	ff 75 f4             	pushl  -0xc(%ebp)
  800af1:	ff 75 f0             	pushl  -0x10(%ebp)
  800af4:	ff 75 0c             	pushl  0xc(%ebp)
  800af7:	ff 75 08             	pushl  0x8(%ebp)
  800afa:	e8 00 fb ff ff       	call   8005ff <printnum>
  800aff:	83 c4 20             	add    $0x20,%esp
			break;
  800b02:	eb 34                	jmp    800b38 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b04:	83 ec 08             	sub    $0x8,%esp
  800b07:	ff 75 0c             	pushl  0xc(%ebp)
  800b0a:	53                   	push   %ebx
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	ff d0                	call   *%eax
  800b10:	83 c4 10             	add    $0x10,%esp
			break;
  800b13:	eb 23                	jmp    800b38 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	6a 25                	push   $0x25
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	ff d0                	call   *%eax
  800b22:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b25:	ff 4d 10             	decl   0x10(%ebp)
  800b28:	eb 03                	jmp    800b2d <vprintfmt+0x3b1>
  800b2a:	ff 4d 10             	decl   0x10(%ebp)
  800b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b30:	48                   	dec    %eax
  800b31:	8a 00                	mov    (%eax),%al
  800b33:	3c 25                	cmp    $0x25,%al
  800b35:	75 f3                	jne    800b2a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b37:	90                   	nop
		}
	}
  800b38:	e9 47 fc ff ff       	jmp    800784 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b3d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b41:	5b                   	pop    %ebx
  800b42:	5e                   	pop    %esi
  800b43:	5d                   	pop    %ebp
  800b44:	c3                   	ret    

00800b45 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
  800b48:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b4b:	8d 45 10             	lea    0x10(%ebp),%eax
  800b4e:	83 c0 04             	add    $0x4,%eax
  800b51:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b54:	8b 45 10             	mov    0x10(%ebp),%eax
  800b57:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5a:	50                   	push   %eax
  800b5b:	ff 75 0c             	pushl  0xc(%ebp)
  800b5e:	ff 75 08             	pushl  0x8(%ebp)
  800b61:	e8 16 fc ff ff       	call   80077c <vprintfmt>
  800b66:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b69:	90                   	nop
  800b6a:	c9                   	leave  
  800b6b:	c3                   	ret    

00800b6c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b6c:	55                   	push   %ebp
  800b6d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b72:	8b 40 08             	mov    0x8(%eax),%eax
  800b75:	8d 50 01             	lea    0x1(%eax),%edx
  800b78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b81:	8b 10                	mov    (%eax),%edx
  800b83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b86:	8b 40 04             	mov    0x4(%eax),%eax
  800b89:	39 c2                	cmp    %eax,%edx
  800b8b:	73 12                	jae    800b9f <sprintputch+0x33>
		*b->buf++ = ch;
  800b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b90:	8b 00                	mov    (%eax),%eax
  800b92:	8d 48 01             	lea    0x1(%eax),%ecx
  800b95:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b98:	89 0a                	mov    %ecx,(%edx)
  800b9a:	8b 55 08             	mov    0x8(%ebp),%edx
  800b9d:	88 10                	mov    %dl,(%eax)
}
  800b9f:	90                   	nop
  800ba0:	5d                   	pop    %ebp
  800ba1:	c3                   	ret    

00800ba2 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
  800ba5:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	01 d0                	add    %edx,%eax
  800bb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bbc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bc3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bc7:	74 06                	je     800bcf <vsnprintf+0x2d>
  800bc9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bcd:	7f 07                	jg     800bd6 <vsnprintf+0x34>
		return -E_INVAL;
  800bcf:	b8 03 00 00 00       	mov    $0x3,%eax
  800bd4:	eb 20                	jmp    800bf6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bd6:	ff 75 14             	pushl  0x14(%ebp)
  800bd9:	ff 75 10             	pushl  0x10(%ebp)
  800bdc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bdf:	50                   	push   %eax
  800be0:	68 6c 0b 80 00       	push   $0x800b6c
  800be5:	e8 92 fb ff ff       	call   80077c <vprintfmt>
  800bea:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bed:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bf0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bf6:	c9                   	leave  
  800bf7:	c3                   	ret    

00800bf8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bf8:	55                   	push   %ebp
  800bf9:	89 e5                	mov    %esp,%ebp
  800bfb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bfe:	8d 45 10             	lea    0x10(%ebp),%eax
  800c01:	83 c0 04             	add    $0x4,%eax
  800c04:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c07:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0a:	ff 75 f4             	pushl  -0xc(%ebp)
  800c0d:	50                   	push   %eax
  800c0e:	ff 75 0c             	pushl  0xc(%ebp)
  800c11:	ff 75 08             	pushl  0x8(%ebp)
  800c14:	e8 89 ff ff ff       	call   800ba2 <vsnprintf>
  800c19:	83 c4 10             	add    $0x10,%esp
  800c1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c22:	c9                   	leave  
  800c23:	c3                   	ret    

00800c24 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c24:	55                   	push   %ebp
  800c25:	89 e5                	mov    %esp,%ebp
  800c27:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c2a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c31:	eb 06                	jmp    800c39 <strlen+0x15>
		n++;
  800c33:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c36:	ff 45 08             	incl   0x8(%ebp)
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	8a 00                	mov    (%eax),%al
  800c3e:	84 c0                	test   %al,%al
  800c40:	75 f1                	jne    800c33 <strlen+0xf>
		n++;
	return n;
  800c42:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c45:	c9                   	leave  
  800c46:	c3                   	ret    

00800c47 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c47:	55                   	push   %ebp
  800c48:	89 e5                	mov    %esp,%ebp
  800c4a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c54:	eb 09                	jmp    800c5f <strnlen+0x18>
		n++;
  800c56:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c59:	ff 45 08             	incl   0x8(%ebp)
  800c5c:	ff 4d 0c             	decl   0xc(%ebp)
  800c5f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c63:	74 09                	je     800c6e <strnlen+0x27>
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	84 c0                	test   %al,%al
  800c6c:	75 e8                	jne    800c56 <strnlen+0xf>
		n++;
	return n;
  800c6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c71:	c9                   	leave  
  800c72:	c3                   	ret    

00800c73 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c73:	55                   	push   %ebp
  800c74:	89 e5                	mov    %esp,%ebp
  800c76:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c7f:	90                   	nop
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8d 50 01             	lea    0x1(%eax),%edx
  800c86:	89 55 08             	mov    %edx,0x8(%ebp)
  800c89:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c8f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c92:	8a 12                	mov    (%edx),%dl
  800c94:	88 10                	mov    %dl,(%eax)
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	84 c0                	test   %al,%al
  800c9a:	75 e4                	jne    800c80 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c9f:	c9                   	leave  
  800ca0:	c3                   	ret    

00800ca1 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ca1:	55                   	push   %ebp
  800ca2:	89 e5                	mov    %esp,%ebp
  800ca4:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cb4:	eb 1f                	jmp    800cd5 <strncpy+0x34>
		*dst++ = *src;
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8d 50 01             	lea    0x1(%eax),%edx
  800cbc:	89 55 08             	mov    %edx,0x8(%ebp)
  800cbf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cc2:	8a 12                	mov    (%edx),%dl
  800cc4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	84 c0                	test   %al,%al
  800ccd:	74 03                	je     800cd2 <strncpy+0x31>
			src++;
  800ccf:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cd2:	ff 45 fc             	incl   -0x4(%ebp)
  800cd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cdb:	72 d9                	jb     800cb6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cdd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ce0:	c9                   	leave  
  800ce1:	c3                   	ret    

00800ce2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ce2:	55                   	push   %ebp
  800ce3:	89 e5                	mov    %esp,%ebp
  800ce5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf2:	74 30                	je     800d24 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cf4:	eb 16                	jmp    800d0c <strlcpy+0x2a>
			*dst++ = *src++;
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	8d 50 01             	lea    0x1(%eax),%edx
  800cfc:	89 55 08             	mov    %edx,0x8(%ebp)
  800cff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d02:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d05:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d08:	8a 12                	mov    (%edx),%dl
  800d0a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d0c:	ff 4d 10             	decl   0x10(%ebp)
  800d0f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d13:	74 09                	je     800d1e <strlcpy+0x3c>
  800d15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d18:	8a 00                	mov    (%eax),%al
  800d1a:	84 c0                	test   %al,%al
  800d1c:	75 d8                	jne    800cf6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d24:	8b 55 08             	mov    0x8(%ebp),%edx
  800d27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2a:	29 c2                	sub    %eax,%edx
  800d2c:	89 d0                	mov    %edx,%eax
}
  800d2e:	c9                   	leave  
  800d2f:	c3                   	ret    

00800d30 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d30:	55                   	push   %ebp
  800d31:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d33:	eb 06                	jmp    800d3b <strcmp+0xb>
		p++, q++;
  800d35:	ff 45 08             	incl   0x8(%ebp)
  800d38:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	84 c0                	test   %al,%al
  800d42:	74 0e                	je     800d52 <strcmp+0x22>
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8a 10                	mov    (%eax),%dl
  800d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4c:	8a 00                	mov    (%eax),%al
  800d4e:	38 c2                	cmp    %al,%dl
  800d50:	74 e3                	je     800d35 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	0f b6 d0             	movzbl %al,%edx
  800d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5d:	8a 00                	mov    (%eax),%al
  800d5f:	0f b6 c0             	movzbl %al,%eax
  800d62:	29 c2                	sub    %eax,%edx
  800d64:	89 d0                	mov    %edx,%eax
}
  800d66:	5d                   	pop    %ebp
  800d67:	c3                   	ret    

00800d68 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d68:	55                   	push   %ebp
  800d69:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d6b:	eb 09                	jmp    800d76 <strncmp+0xe>
		n--, p++, q++;
  800d6d:	ff 4d 10             	decl   0x10(%ebp)
  800d70:	ff 45 08             	incl   0x8(%ebp)
  800d73:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d7a:	74 17                	je     800d93 <strncmp+0x2b>
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	84 c0                	test   %al,%al
  800d83:	74 0e                	je     800d93 <strncmp+0x2b>
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8a 10                	mov    (%eax),%dl
  800d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8d:	8a 00                	mov    (%eax),%al
  800d8f:	38 c2                	cmp    %al,%dl
  800d91:	74 da                	je     800d6d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d93:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d97:	75 07                	jne    800da0 <strncmp+0x38>
		return 0;
  800d99:	b8 00 00 00 00       	mov    $0x0,%eax
  800d9e:	eb 14                	jmp    800db4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	0f b6 d0             	movzbl %al,%edx
  800da8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dab:	8a 00                	mov    (%eax),%al
  800dad:	0f b6 c0             	movzbl %al,%eax
  800db0:	29 c2                	sub    %eax,%edx
  800db2:	89 d0                	mov    %edx,%eax
}
  800db4:	5d                   	pop    %ebp
  800db5:	c3                   	ret    

00800db6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800db6:	55                   	push   %ebp
  800db7:	89 e5                	mov    %esp,%ebp
  800db9:	83 ec 04             	sub    $0x4,%esp
  800dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dc2:	eb 12                	jmp    800dd6 <strchr+0x20>
		if (*s == c)
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	8a 00                	mov    (%eax),%al
  800dc9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dcc:	75 05                	jne    800dd3 <strchr+0x1d>
			return (char *) s;
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	eb 11                	jmp    800de4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dd3:	ff 45 08             	incl   0x8(%ebp)
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8a 00                	mov    (%eax),%al
  800ddb:	84 c0                	test   %al,%al
  800ddd:	75 e5                	jne    800dc4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ddf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800de4:	c9                   	leave  
  800de5:	c3                   	ret    

00800de6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800de6:	55                   	push   %ebp
  800de7:	89 e5                	mov    %esp,%ebp
  800de9:	83 ec 04             	sub    $0x4,%esp
  800dec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800def:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800df2:	eb 0d                	jmp    800e01 <strfind+0x1b>
		if (*s == c)
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	8a 00                	mov    (%eax),%al
  800df9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dfc:	74 0e                	je     800e0c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dfe:	ff 45 08             	incl   0x8(%ebp)
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	84 c0                	test   %al,%al
  800e08:	75 ea                	jne    800df4 <strfind+0xe>
  800e0a:	eb 01                	jmp    800e0d <strfind+0x27>
		if (*s == c)
			break;
  800e0c:	90                   	nop
	return (char *) s;
  800e0d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e10:	c9                   	leave  
  800e11:	c3                   	ret    

00800e12 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e12:	55                   	push   %ebp
  800e13:	89 e5                	mov    %esp,%ebp
  800e15:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e21:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e24:	eb 0e                	jmp    800e34 <memset+0x22>
		*p++ = c;
  800e26:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e29:	8d 50 01             	lea    0x1(%eax),%edx
  800e2c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e32:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e34:	ff 4d f8             	decl   -0x8(%ebp)
  800e37:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e3b:	79 e9                	jns    800e26 <memset+0x14>
		*p++ = c;

	return v;
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e40:	c9                   	leave  
  800e41:	c3                   	ret    

00800e42 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e42:	55                   	push   %ebp
  800e43:	89 e5                	mov    %esp,%ebp
  800e45:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e51:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e54:	eb 16                	jmp    800e6c <memcpy+0x2a>
		*d++ = *s++;
  800e56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e59:	8d 50 01             	lea    0x1(%eax),%edx
  800e5c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e5f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e62:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e65:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e68:	8a 12                	mov    (%edx),%dl
  800e6a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e72:	89 55 10             	mov    %edx,0x10(%ebp)
  800e75:	85 c0                	test   %eax,%eax
  800e77:	75 dd                	jne    800e56 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e7c:	c9                   	leave  
  800e7d:	c3                   	ret    

00800e7e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e7e:	55                   	push   %ebp
  800e7f:	89 e5                	mov    %esp,%ebp
  800e81:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e93:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e96:	73 50                	jae    800ee8 <memmove+0x6a>
  800e98:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9e:	01 d0                	add    %edx,%eax
  800ea0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ea3:	76 43                	jbe    800ee8 <memmove+0x6a>
		s += n;
  800ea5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800eab:	8b 45 10             	mov    0x10(%ebp),%eax
  800eae:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800eb1:	eb 10                	jmp    800ec3 <memmove+0x45>
			*--d = *--s;
  800eb3:	ff 4d f8             	decl   -0x8(%ebp)
  800eb6:	ff 4d fc             	decl   -0x4(%ebp)
  800eb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebc:	8a 10                	mov    (%eax),%dl
  800ebe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ec3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecc:	85 c0                	test   %eax,%eax
  800ece:	75 e3                	jne    800eb3 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ed0:	eb 23                	jmp    800ef5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ed2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed5:	8d 50 01             	lea    0x1(%eax),%edx
  800ed8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800edb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ede:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ee1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ee4:	8a 12                	mov    (%edx),%dl
  800ee6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ee8:	8b 45 10             	mov    0x10(%ebp),%eax
  800eeb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eee:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef1:	85 c0                	test   %eax,%eax
  800ef3:	75 dd                	jne    800ed2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef8:	c9                   	leave  
  800ef9:	c3                   	ret    

00800efa <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800efa:	55                   	push   %ebp
  800efb:	89 e5                	mov    %esp,%ebp
  800efd:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f00:	8b 45 08             	mov    0x8(%ebp),%eax
  800f03:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f09:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f0c:	eb 2a                	jmp    800f38 <memcmp+0x3e>
		if (*s1 != *s2)
  800f0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f11:	8a 10                	mov    (%eax),%dl
  800f13:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f16:	8a 00                	mov    (%eax),%al
  800f18:	38 c2                	cmp    %al,%dl
  800f1a:	74 16                	je     800f32 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	0f b6 d0             	movzbl %al,%edx
  800f24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	0f b6 c0             	movzbl %al,%eax
  800f2c:	29 c2                	sub    %eax,%edx
  800f2e:	89 d0                	mov    %edx,%eax
  800f30:	eb 18                	jmp    800f4a <memcmp+0x50>
		s1++, s2++;
  800f32:	ff 45 fc             	incl   -0x4(%ebp)
  800f35:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f38:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f3e:	89 55 10             	mov    %edx,0x10(%ebp)
  800f41:	85 c0                	test   %eax,%eax
  800f43:	75 c9                	jne    800f0e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f4a:	c9                   	leave  
  800f4b:	c3                   	ret    

00800f4c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f4c:	55                   	push   %ebp
  800f4d:	89 e5                	mov    %esp,%ebp
  800f4f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f52:	8b 55 08             	mov    0x8(%ebp),%edx
  800f55:	8b 45 10             	mov    0x10(%ebp),%eax
  800f58:	01 d0                	add    %edx,%eax
  800f5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f5d:	eb 15                	jmp    800f74 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	0f b6 d0             	movzbl %al,%edx
  800f67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6a:	0f b6 c0             	movzbl %al,%eax
  800f6d:	39 c2                	cmp    %eax,%edx
  800f6f:	74 0d                	je     800f7e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f71:	ff 45 08             	incl   0x8(%ebp)
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f7a:	72 e3                	jb     800f5f <memfind+0x13>
  800f7c:	eb 01                	jmp    800f7f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f7e:	90                   	nop
	return (void *) s;
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f82:	c9                   	leave  
  800f83:	c3                   	ret    

00800f84 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f84:	55                   	push   %ebp
  800f85:	89 e5                	mov    %esp,%ebp
  800f87:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f91:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f98:	eb 03                	jmp    800f9d <strtol+0x19>
		s++;
  800f9a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	8a 00                	mov    (%eax),%al
  800fa2:	3c 20                	cmp    $0x20,%al
  800fa4:	74 f4                	je     800f9a <strtol+0x16>
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	3c 09                	cmp    $0x9,%al
  800fad:	74 eb                	je     800f9a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 2b                	cmp    $0x2b,%al
  800fb6:	75 05                	jne    800fbd <strtol+0x39>
		s++;
  800fb8:	ff 45 08             	incl   0x8(%ebp)
  800fbb:	eb 13                	jmp    800fd0 <strtol+0x4c>
	else if (*s == '-')
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	3c 2d                	cmp    $0x2d,%al
  800fc4:	75 0a                	jne    800fd0 <strtol+0x4c>
		s++, neg = 1;
  800fc6:	ff 45 08             	incl   0x8(%ebp)
  800fc9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd4:	74 06                	je     800fdc <strtol+0x58>
  800fd6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fda:	75 20                	jne    800ffc <strtol+0x78>
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8a 00                	mov    (%eax),%al
  800fe1:	3c 30                	cmp    $0x30,%al
  800fe3:	75 17                	jne    800ffc <strtol+0x78>
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	40                   	inc    %eax
  800fe9:	8a 00                	mov    (%eax),%al
  800feb:	3c 78                	cmp    $0x78,%al
  800fed:	75 0d                	jne    800ffc <strtol+0x78>
		s += 2, base = 16;
  800fef:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ff3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ffa:	eb 28                	jmp    801024 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ffc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801000:	75 15                	jne    801017 <strtol+0x93>
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	3c 30                	cmp    $0x30,%al
  801009:	75 0c                	jne    801017 <strtol+0x93>
		s++, base = 8;
  80100b:	ff 45 08             	incl   0x8(%ebp)
  80100e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801015:	eb 0d                	jmp    801024 <strtol+0xa0>
	else if (base == 0)
  801017:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80101b:	75 07                	jne    801024 <strtol+0xa0>
		base = 10;
  80101d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	8a 00                	mov    (%eax),%al
  801029:	3c 2f                	cmp    $0x2f,%al
  80102b:	7e 19                	jle    801046 <strtol+0xc2>
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	3c 39                	cmp    $0x39,%al
  801034:	7f 10                	jg     801046 <strtol+0xc2>
			dig = *s - '0';
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8a 00                	mov    (%eax),%al
  80103b:	0f be c0             	movsbl %al,%eax
  80103e:	83 e8 30             	sub    $0x30,%eax
  801041:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801044:	eb 42                	jmp    801088 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	8a 00                	mov    (%eax),%al
  80104b:	3c 60                	cmp    $0x60,%al
  80104d:	7e 19                	jle    801068 <strtol+0xe4>
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	8a 00                	mov    (%eax),%al
  801054:	3c 7a                	cmp    $0x7a,%al
  801056:	7f 10                	jg     801068 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	0f be c0             	movsbl %al,%eax
  801060:	83 e8 57             	sub    $0x57,%eax
  801063:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801066:	eb 20                	jmp    801088 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	8a 00                	mov    (%eax),%al
  80106d:	3c 40                	cmp    $0x40,%al
  80106f:	7e 39                	jle    8010aa <strtol+0x126>
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	3c 5a                	cmp    $0x5a,%al
  801078:	7f 30                	jg     8010aa <strtol+0x126>
			dig = *s - 'A' + 10;
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	8a 00                	mov    (%eax),%al
  80107f:	0f be c0             	movsbl %al,%eax
  801082:	83 e8 37             	sub    $0x37,%eax
  801085:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801088:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80108b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80108e:	7d 19                	jge    8010a9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801090:	ff 45 08             	incl   0x8(%ebp)
  801093:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801096:	0f af 45 10          	imul   0x10(%ebp),%eax
  80109a:	89 c2                	mov    %eax,%edx
  80109c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80109f:	01 d0                	add    %edx,%eax
  8010a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010a4:	e9 7b ff ff ff       	jmp    801024 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010a9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010ae:	74 08                	je     8010b8 <strtol+0x134>
		*endptr = (char *) s;
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8010b6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010b8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010bc:	74 07                	je     8010c5 <strtol+0x141>
  8010be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c1:	f7 d8                	neg    %eax
  8010c3:	eb 03                	jmp    8010c8 <strtol+0x144>
  8010c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010c8:	c9                   	leave  
  8010c9:	c3                   	ret    

008010ca <ltostr>:

void
ltostr(long value, char *str)
{
  8010ca:	55                   	push   %ebp
  8010cb:	89 e5                	mov    %esp,%ebp
  8010cd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010de:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010e2:	79 13                	jns    8010f7 <ltostr+0x2d>
	{
		neg = 1;
  8010e4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ee:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010f1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010f4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fa:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010ff:	99                   	cltd   
  801100:	f7 f9                	idiv   %ecx
  801102:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801105:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801108:	8d 50 01             	lea    0x1(%eax),%edx
  80110b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80110e:	89 c2                	mov    %eax,%edx
  801110:	8b 45 0c             	mov    0xc(%ebp),%eax
  801113:	01 d0                	add    %edx,%eax
  801115:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801118:	83 c2 30             	add    $0x30,%edx
  80111b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80111d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801120:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801125:	f7 e9                	imul   %ecx
  801127:	c1 fa 02             	sar    $0x2,%edx
  80112a:	89 c8                	mov    %ecx,%eax
  80112c:	c1 f8 1f             	sar    $0x1f,%eax
  80112f:	29 c2                	sub    %eax,%edx
  801131:	89 d0                	mov    %edx,%eax
  801133:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801136:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801139:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80113e:	f7 e9                	imul   %ecx
  801140:	c1 fa 02             	sar    $0x2,%edx
  801143:	89 c8                	mov    %ecx,%eax
  801145:	c1 f8 1f             	sar    $0x1f,%eax
  801148:	29 c2                	sub    %eax,%edx
  80114a:	89 d0                	mov    %edx,%eax
  80114c:	c1 e0 02             	shl    $0x2,%eax
  80114f:	01 d0                	add    %edx,%eax
  801151:	01 c0                	add    %eax,%eax
  801153:	29 c1                	sub    %eax,%ecx
  801155:	89 ca                	mov    %ecx,%edx
  801157:	85 d2                	test   %edx,%edx
  801159:	75 9c                	jne    8010f7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80115b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801162:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801165:	48                   	dec    %eax
  801166:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801169:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80116d:	74 3d                	je     8011ac <ltostr+0xe2>
		start = 1 ;
  80116f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801176:	eb 34                	jmp    8011ac <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801178:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80117b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117e:	01 d0                	add    %edx,%eax
  801180:	8a 00                	mov    (%eax),%al
  801182:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801185:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801188:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118b:	01 c2                	add    %eax,%edx
  80118d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801190:	8b 45 0c             	mov    0xc(%ebp),%eax
  801193:	01 c8                	add    %ecx,%eax
  801195:	8a 00                	mov    (%eax),%al
  801197:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801199:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80119c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119f:	01 c2                	add    %eax,%edx
  8011a1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011a4:	88 02                	mov    %al,(%edx)
		start++ ;
  8011a6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011a9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011b2:	7c c4                	jl     801178 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011b4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ba:	01 d0                	add    %edx,%eax
  8011bc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011bf:	90                   	nop
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
  8011c5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011c8:	ff 75 08             	pushl  0x8(%ebp)
  8011cb:	e8 54 fa ff ff       	call   800c24 <strlen>
  8011d0:	83 c4 04             	add    $0x4,%esp
  8011d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011d6:	ff 75 0c             	pushl  0xc(%ebp)
  8011d9:	e8 46 fa ff ff       	call   800c24 <strlen>
  8011de:	83 c4 04             	add    $0x4,%esp
  8011e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011f2:	eb 17                	jmp    80120b <strcconcat+0x49>
		final[s] = str1[s] ;
  8011f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fa:	01 c2                	add    %eax,%edx
  8011fc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	01 c8                	add    %ecx,%eax
  801204:	8a 00                	mov    (%eax),%al
  801206:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801208:	ff 45 fc             	incl   -0x4(%ebp)
  80120b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80120e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801211:	7c e1                	jl     8011f4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801213:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80121a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801221:	eb 1f                	jmp    801242 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801223:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801226:	8d 50 01             	lea    0x1(%eax),%edx
  801229:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80122c:	89 c2                	mov    %eax,%edx
  80122e:	8b 45 10             	mov    0x10(%ebp),%eax
  801231:	01 c2                	add    %eax,%edx
  801233:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801236:	8b 45 0c             	mov    0xc(%ebp),%eax
  801239:	01 c8                	add    %ecx,%eax
  80123b:	8a 00                	mov    (%eax),%al
  80123d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80123f:	ff 45 f8             	incl   -0x8(%ebp)
  801242:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801245:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801248:	7c d9                	jl     801223 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80124a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124d:	8b 45 10             	mov    0x10(%ebp),%eax
  801250:	01 d0                	add    %edx,%eax
  801252:	c6 00 00             	movb   $0x0,(%eax)
}
  801255:	90                   	nop
  801256:	c9                   	leave  
  801257:	c3                   	ret    

00801258 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801258:	55                   	push   %ebp
  801259:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80125b:	8b 45 14             	mov    0x14(%ebp),%eax
  80125e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801264:	8b 45 14             	mov    0x14(%ebp),%eax
  801267:	8b 00                	mov    (%eax),%eax
  801269:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801270:	8b 45 10             	mov    0x10(%ebp),%eax
  801273:	01 d0                	add    %edx,%eax
  801275:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80127b:	eb 0c                	jmp    801289 <strsplit+0x31>
			*string++ = 0;
  80127d:	8b 45 08             	mov    0x8(%ebp),%eax
  801280:	8d 50 01             	lea    0x1(%eax),%edx
  801283:	89 55 08             	mov    %edx,0x8(%ebp)
  801286:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
  80128c:	8a 00                	mov    (%eax),%al
  80128e:	84 c0                	test   %al,%al
  801290:	74 18                	je     8012aa <strsplit+0x52>
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	8a 00                	mov    (%eax),%al
  801297:	0f be c0             	movsbl %al,%eax
  80129a:	50                   	push   %eax
  80129b:	ff 75 0c             	pushl  0xc(%ebp)
  80129e:	e8 13 fb ff ff       	call   800db6 <strchr>
  8012a3:	83 c4 08             	add    $0x8,%esp
  8012a6:	85 c0                	test   %eax,%eax
  8012a8:	75 d3                	jne    80127d <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	8a 00                	mov    (%eax),%al
  8012af:	84 c0                	test   %al,%al
  8012b1:	74 5a                	je     80130d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8012b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b6:	8b 00                	mov    (%eax),%eax
  8012b8:	83 f8 0f             	cmp    $0xf,%eax
  8012bb:	75 07                	jne    8012c4 <strsplit+0x6c>
		{
			return 0;
  8012bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8012c2:	eb 66                	jmp    80132a <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c7:	8b 00                	mov    (%eax),%eax
  8012c9:	8d 48 01             	lea    0x1(%eax),%ecx
  8012cc:	8b 55 14             	mov    0x14(%ebp),%edx
  8012cf:	89 0a                	mov    %ecx,(%edx)
  8012d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012db:	01 c2                	add    %eax,%edx
  8012dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012e2:	eb 03                	jmp    8012e7 <strsplit+0x8f>
			string++;
  8012e4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	8a 00                	mov    (%eax),%al
  8012ec:	84 c0                	test   %al,%al
  8012ee:	74 8b                	je     80127b <strsplit+0x23>
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	8a 00                	mov    (%eax),%al
  8012f5:	0f be c0             	movsbl %al,%eax
  8012f8:	50                   	push   %eax
  8012f9:	ff 75 0c             	pushl  0xc(%ebp)
  8012fc:	e8 b5 fa ff ff       	call   800db6 <strchr>
  801301:	83 c4 08             	add    $0x8,%esp
  801304:	85 c0                	test   %eax,%eax
  801306:	74 dc                	je     8012e4 <strsplit+0x8c>
			string++;
	}
  801308:	e9 6e ff ff ff       	jmp    80127b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80130d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80130e:	8b 45 14             	mov    0x14(%ebp),%eax
  801311:	8b 00                	mov    (%eax),%eax
  801313:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80131a:	8b 45 10             	mov    0x10(%ebp),%eax
  80131d:	01 d0                	add    %edx,%eax
  80131f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801325:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
  80132f:	83 ec 18             	sub    $0x18,%esp
  801332:	8b 45 10             	mov    0x10(%ebp),%eax
  801335:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801338:	83 ec 04             	sub    $0x4,%esp
  80133b:	68 50 25 80 00       	push   $0x802550
  801340:	6a 17                	push   $0x17
  801342:	68 6f 25 80 00       	push   $0x80256f
  801347:	e8 a2 ef ff ff       	call   8002ee <_panic>

0080134c <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
  80134f:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801352:	83 ec 04             	sub    $0x4,%esp
  801355:	68 7b 25 80 00       	push   $0x80257b
  80135a:	6a 2f                	push   $0x2f
  80135c:	68 6f 25 80 00       	push   $0x80256f
  801361:	e8 88 ef ff ff       	call   8002ee <_panic>

00801366 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
  801369:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80136c:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801373:	8b 55 08             	mov    0x8(%ebp),%edx
  801376:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801379:	01 d0                	add    %edx,%eax
  80137b:	48                   	dec    %eax
  80137c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80137f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801382:	ba 00 00 00 00       	mov    $0x0,%edx
  801387:	f7 75 ec             	divl   -0x14(%ebp)
  80138a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80138d:	29 d0                	sub    %edx,%eax
  80138f:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	c1 e8 0c             	shr    $0xc,%eax
  801398:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80139b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8013a2:	e9 c8 00 00 00       	jmp    80146f <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8013a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8013ae:	eb 27                	jmp    8013d7 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8013b0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013b6:	01 c2                	add    %eax,%edx
  8013b8:	89 d0                	mov    %edx,%eax
  8013ba:	01 c0                	add    %eax,%eax
  8013bc:	01 d0                	add    %edx,%eax
  8013be:	c1 e0 02             	shl    $0x2,%eax
  8013c1:	05 48 30 80 00       	add    $0x803048,%eax
  8013c6:	8b 00                	mov    (%eax),%eax
  8013c8:	85 c0                	test   %eax,%eax
  8013ca:	74 08                	je     8013d4 <malloc+0x6e>
            	i += j;
  8013cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013cf:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8013d2:	eb 0b                	jmp    8013df <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8013d4:	ff 45 f0             	incl   -0x10(%ebp)
  8013d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013da:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8013dd:	72 d1                	jb     8013b0 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8013df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013e2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8013e5:	0f 85 81 00 00 00    	jne    80146c <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8013eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ee:	05 00 00 08 00       	add    $0x80000,%eax
  8013f3:	c1 e0 0c             	shl    $0xc,%eax
  8013f6:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8013f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801400:	eb 1f                	jmp    801421 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801402:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801405:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801408:	01 c2                	add    %eax,%edx
  80140a:	89 d0                	mov    %edx,%eax
  80140c:	01 c0                	add    %eax,%eax
  80140e:	01 d0                	add    %edx,%eax
  801410:	c1 e0 02             	shl    $0x2,%eax
  801413:	05 48 30 80 00       	add    $0x803048,%eax
  801418:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80141e:	ff 45 f0             	incl   -0x10(%ebp)
  801421:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801424:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801427:	72 d9                	jb     801402 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801429:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80142c:	89 d0                	mov    %edx,%eax
  80142e:	01 c0                	add    %eax,%eax
  801430:	01 d0                	add    %edx,%eax
  801432:	c1 e0 02             	shl    $0x2,%eax
  801435:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80143b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80143e:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801440:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801443:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801446:	89 c8                	mov    %ecx,%eax
  801448:	01 c0                	add    %eax,%eax
  80144a:	01 c8                	add    %ecx,%eax
  80144c:	c1 e0 02             	shl    $0x2,%eax
  80144f:	05 44 30 80 00       	add    $0x803044,%eax
  801454:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801456:	83 ec 08             	sub    $0x8,%esp
  801459:	ff 75 08             	pushl  0x8(%ebp)
  80145c:	ff 75 e0             	pushl  -0x20(%ebp)
  80145f:	e8 2b 03 00 00       	call   80178f <sys_allocateMem>
  801464:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801467:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80146a:	eb 19                	jmp    801485 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80146c:	ff 45 f4             	incl   -0xc(%ebp)
  80146f:	a1 04 30 80 00       	mov    0x803004,%eax
  801474:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801477:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80147a:	0f 83 27 ff ff ff    	jae    8013a7 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801480:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
  80148a:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80148d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801491:	0f 84 e5 00 00 00    	je     80157c <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80149d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014a0:	05 00 00 00 80       	add    $0x80000000,%eax
  8014a5:	c1 e8 0c             	shr    $0xc,%eax
  8014a8:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8014ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014ae:	89 d0                	mov    %edx,%eax
  8014b0:	01 c0                	add    %eax,%eax
  8014b2:	01 d0                	add    %edx,%eax
  8014b4:	c1 e0 02             	shl    $0x2,%eax
  8014b7:	05 40 30 80 00       	add    $0x803040,%eax
  8014bc:	8b 00                	mov    (%eax),%eax
  8014be:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014c1:	0f 85 b8 00 00 00    	jne    80157f <free+0xf8>
  8014c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014ca:	89 d0                	mov    %edx,%eax
  8014cc:	01 c0                	add    %eax,%eax
  8014ce:	01 d0                	add    %edx,%eax
  8014d0:	c1 e0 02             	shl    $0x2,%eax
  8014d3:	05 48 30 80 00       	add    $0x803048,%eax
  8014d8:	8b 00                	mov    (%eax),%eax
  8014da:	85 c0                	test   %eax,%eax
  8014dc:	0f 84 9d 00 00 00    	je     80157f <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8014e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014e5:	89 d0                	mov    %edx,%eax
  8014e7:	01 c0                	add    %eax,%eax
  8014e9:	01 d0                	add    %edx,%eax
  8014eb:	c1 e0 02             	shl    $0x2,%eax
  8014ee:	05 44 30 80 00       	add    $0x803044,%eax
  8014f3:	8b 00                	mov    (%eax),%eax
  8014f5:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8014f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014fb:	c1 e0 0c             	shl    $0xc,%eax
  8014fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801501:	83 ec 08             	sub    $0x8,%esp
  801504:	ff 75 e4             	pushl  -0x1c(%ebp)
  801507:	ff 75 f0             	pushl  -0x10(%ebp)
  80150a:	e8 64 02 00 00       	call   801773 <sys_freeMem>
  80150f:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801512:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801519:	eb 57                	jmp    801572 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80151b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801521:	01 c2                	add    %eax,%edx
  801523:	89 d0                	mov    %edx,%eax
  801525:	01 c0                	add    %eax,%eax
  801527:	01 d0                	add    %edx,%eax
  801529:	c1 e0 02             	shl    $0x2,%eax
  80152c:	05 48 30 80 00       	add    $0x803048,%eax
  801531:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801537:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80153a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80153d:	01 c2                	add    %eax,%edx
  80153f:	89 d0                	mov    %edx,%eax
  801541:	01 c0                	add    %eax,%eax
  801543:	01 d0                	add    %edx,%eax
  801545:	c1 e0 02             	shl    $0x2,%eax
  801548:	05 40 30 80 00       	add    $0x803040,%eax
  80154d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801553:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801556:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801559:	01 c2                	add    %eax,%edx
  80155b:	89 d0                	mov    %edx,%eax
  80155d:	01 c0                	add    %eax,%eax
  80155f:	01 d0                	add    %edx,%eax
  801561:	c1 e0 02             	shl    $0x2,%eax
  801564:	05 44 30 80 00       	add    $0x803044,%eax
  801569:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80156f:	ff 45 f4             	incl   -0xc(%ebp)
  801572:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801575:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801578:	7c a1                	jl     80151b <free+0x94>
  80157a:	eb 04                	jmp    801580 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80157c:	90                   	nop
  80157d:	eb 01                	jmp    801580 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  80157f:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801588:	83 ec 04             	sub    $0x4,%esp
  80158b:	68 98 25 80 00       	push   $0x802598
  801590:	68 ae 00 00 00       	push   $0xae
  801595:	68 6f 25 80 00       	push   $0x80256f
  80159a:	e8 4f ed ff ff       	call   8002ee <_panic>

0080159f <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
  8015a2:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8015a5:	83 ec 04             	sub    $0x4,%esp
  8015a8:	68 b8 25 80 00       	push   $0x8025b8
  8015ad:	68 ca 00 00 00       	push   $0xca
  8015b2:	68 6f 25 80 00       	push   $0x80256f
  8015b7:	e8 32 ed ff ff       	call   8002ee <_panic>

008015bc <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	57                   	push   %edi
  8015c0:	56                   	push   %esi
  8015c1:	53                   	push   %ebx
  8015c2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015ce:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015d1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015d4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015d7:	cd 30                	int    $0x30
  8015d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015df:	83 c4 10             	add    $0x10,%esp
  8015e2:	5b                   	pop    %ebx
  8015e3:	5e                   	pop    %esi
  8015e4:	5f                   	pop    %edi
  8015e5:	5d                   	pop    %ebp
  8015e6:	c3                   	ret    

008015e7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8015e7:	55                   	push   %ebp
  8015e8:	89 e5                	mov    %esp,%ebp
  8015ea:	83 ec 04             	sub    $0x4,%esp
  8015ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8015f3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	52                   	push   %edx
  8015ff:	ff 75 0c             	pushl  0xc(%ebp)
  801602:	50                   	push   %eax
  801603:	6a 00                	push   $0x0
  801605:	e8 b2 ff ff ff       	call   8015bc <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	90                   	nop
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_cgetc>:

int
sys_cgetc(void)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 01                	push   $0x1
  80161f:	e8 98 ff ff ff       	call   8015bc <syscall>
  801624:	83 c4 18             	add    $0x18,%esp
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	50                   	push   %eax
  801638:	6a 05                	push   $0x5
  80163a:	e8 7d ff ff ff       	call   8015bc <syscall>
  80163f:	83 c4 18             	add    $0x18,%esp
}
  801642:	c9                   	leave  
  801643:	c3                   	ret    

00801644 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801644:	55                   	push   %ebp
  801645:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 02                	push   $0x2
  801653:	e8 64 ff ff ff       	call   8015bc <syscall>
  801658:	83 c4 18             	add    $0x18,%esp
}
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 03                	push   $0x3
  80166c:	e8 4b ff ff ff       	call   8015bc <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 04                	push   $0x4
  801685:	e8 32 ff ff ff       	call   8015bc <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
}
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <sys_env_exit>:


void sys_env_exit(void)
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 06                	push   $0x6
  80169e:	e8 19 ff ff ff       	call   8015bc <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
}
  8016a6:	90                   	nop
  8016a7:	c9                   	leave  
  8016a8:	c3                   	ret    

008016a9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	52                   	push   %edx
  8016b9:	50                   	push   %eax
  8016ba:	6a 07                	push   $0x7
  8016bc:	e8 fb fe ff ff       	call   8015bc <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
}
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
  8016c9:	56                   	push   %esi
  8016ca:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016cb:	8b 75 18             	mov    0x18(%ebp),%esi
  8016ce:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016d1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	56                   	push   %esi
  8016db:	53                   	push   %ebx
  8016dc:	51                   	push   %ecx
  8016dd:	52                   	push   %edx
  8016de:	50                   	push   %eax
  8016df:	6a 08                	push   $0x8
  8016e1:	e8 d6 fe ff ff       	call   8015bc <syscall>
  8016e6:	83 c4 18             	add    $0x18,%esp
}
  8016e9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016ec:	5b                   	pop    %ebx
  8016ed:	5e                   	pop    %esi
  8016ee:	5d                   	pop    %ebp
  8016ef:	c3                   	ret    

008016f0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8016f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	52                   	push   %edx
  801700:	50                   	push   %eax
  801701:	6a 09                	push   $0x9
  801703:	e8 b4 fe ff ff       	call   8015bc <syscall>
  801708:	83 c4 18             	add    $0x18,%esp
}
  80170b:	c9                   	leave  
  80170c:	c3                   	ret    

0080170d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	ff 75 0c             	pushl  0xc(%ebp)
  801719:	ff 75 08             	pushl  0x8(%ebp)
  80171c:	6a 0a                	push   $0xa
  80171e:	e8 99 fe ff ff       	call   8015bc <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 0b                	push   $0xb
  801737:	e8 80 fe ff ff       	call   8015bc <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
}
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 0c                	push   $0xc
  801750:	e8 67 fe ff ff       	call   8015bc <syscall>
  801755:	83 c4 18             	add    $0x18,%esp
}
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 0d                	push   $0xd
  801769:	e8 4e fe ff ff       	call   8015bc <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	ff 75 0c             	pushl  0xc(%ebp)
  80177f:	ff 75 08             	pushl  0x8(%ebp)
  801782:	6a 11                	push   $0x11
  801784:	e8 33 fe ff ff       	call   8015bc <syscall>
  801789:	83 c4 18             	add    $0x18,%esp
	return;
  80178c:	90                   	nop
}
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	ff 75 0c             	pushl  0xc(%ebp)
  80179b:	ff 75 08             	pushl  0x8(%ebp)
  80179e:	6a 12                	push   $0x12
  8017a0:	e8 17 fe ff ff       	call   8015bc <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a8:	90                   	nop
}
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 0e                	push   $0xe
  8017ba:	e8 fd fd ff ff       	call   8015bc <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	ff 75 08             	pushl  0x8(%ebp)
  8017d2:	6a 0f                	push   $0xf
  8017d4:	e8 e3 fd ff ff       	call   8015bc <syscall>
  8017d9:	83 c4 18             	add    $0x18,%esp
}
  8017dc:	c9                   	leave  
  8017dd:	c3                   	ret    

008017de <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017de:	55                   	push   %ebp
  8017df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 10                	push   $0x10
  8017ed:	e8 ca fd ff ff       	call   8015bc <syscall>
  8017f2:	83 c4 18             	add    $0x18,%esp
}
  8017f5:	90                   	nop
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 14                	push   $0x14
  801807:	e8 b0 fd ff ff       	call   8015bc <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	90                   	nop
  801810:	c9                   	leave  
  801811:	c3                   	ret    

00801812 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801812:	55                   	push   %ebp
  801813:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 15                	push   $0x15
  801821:	e8 96 fd ff ff       	call   8015bc <syscall>
  801826:	83 c4 18             	add    $0x18,%esp
}
  801829:	90                   	nop
  80182a:	c9                   	leave  
  80182b:	c3                   	ret    

0080182c <sys_cputc>:


void
sys_cputc(const char c)
{
  80182c:	55                   	push   %ebp
  80182d:	89 e5                	mov    %esp,%ebp
  80182f:	83 ec 04             	sub    $0x4,%esp
  801832:	8b 45 08             	mov    0x8(%ebp),%eax
  801835:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801838:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	50                   	push   %eax
  801845:	6a 16                	push   $0x16
  801847:	e8 70 fd ff ff       	call   8015bc <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
}
  80184f:	90                   	nop
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 17                	push   $0x17
  801861:	e8 56 fd ff ff       	call   8015bc <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	90                   	nop
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80186f:	8b 45 08             	mov    0x8(%ebp),%eax
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	ff 75 0c             	pushl  0xc(%ebp)
  80187b:	50                   	push   %eax
  80187c:	6a 18                	push   $0x18
  80187e:	e8 39 fd ff ff       	call   8015bc <syscall>
  801883:	83 c4 18             	add    $0x18,%esp
}
  801886:	c9                   	leave  
  801887:	c3                   	ret    

00801888 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801888:	55                   	push   %ebp
  801889:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80188b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	52                   	push   %edx
  801898:	50                   	push   %eax
  801899:	6a 1b                	push   $0x1b
  80189b:	e8 1c fd ff ff       	call   8015bc <syscall>
  8018a0:	83 c4 18             	add    $0x18,%esp
}
  8018a3:	c9                   	leave  
  8018a4:	c3                   	ret    

008018a5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018a5:	55                   	push   %ebp
  8018a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	52                   	push   %edx
  8018b5:	50                   	push   %eax
  8018b6:	6a 19                	push   $0x19
  8018b8:	e8 ff fc ff ff       	call   8015bc <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
}
  8018c0:	90                   	nop
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	52                   	push   %edx
  8018d3:	50                   	push   %eax
  8018d4:	6a 1a                	push   $0x1a
  8018d6:	e8 e1 fc ff ff       	call   8015bc <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
}
  8018de:	90                   	nop
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
  8018e4:	83 ec 04             	sub    $0x4,%esp
  8018e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ea:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8018ed:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018f0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f7:	6a 00                	push   $0x0
  8018f9:	51                   	push   %ecx
  8018fa:	52                   	push   %edx
  8018fb:	ff 75 0c             	pushl  0xc(%ebp)
  8018fe:	50                   	push   %eax
  8018ff:	6a 1c                	push   $0x1c
  801901:	e8 b6 fc ff ff       	call   8015bc <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
}
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80190e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	52                   	push   %edx
  80191b:	50                   	push   %eax
  80191c:	6a 1d                	push   $0x1d
  80191e:	e8 99 fc ff ff       	call   8015bc <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80192b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80192e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	51                   	push   %ecx
  801939:	52                   	push   %edx
  80193a:	50                   	push   %eax
  80193b:	6a 1e                	push   $0x1e
  80193d:	e8 7a fc ff ff       	call   8015bc <syscall>
  801942:	83 c4 18             	add    $0x18,%esp
}
  801945:	c9                   	leave  
  801946:	c3                   	ret    

00801947 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801947:	55                   	push   %ebp
  801948:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80194a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194d:	8b 45 08             	mov    0x8(%ebp),%eax
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	52                   	push   %edx
  801957:	50                   	push   %eax
  801958:	6a 1f                	push   $0x1f
  80195a:	e8 5d fc ff ff       	call   8015bc <syscall>
  80195f:	83 c4 18             	add    $0x18,%esp
}
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 20                	push   $0x20
  801973:	e8 44 fc ff ff       	call   8015bc <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801980:	8b 45 08             	mov    0x8(%ebp),%eax
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	ff 75 10             	pushl  0x10(%ebp)
  80198a:	ff 75 0c             	pushl  0xc(%ebp)
  80198d:	50                   	push   %eax
  80198e:	6a 21                	push   $0x21
  801990:	e8 27 fc ff ff       	call   8015bc <syscall>
  801995:	83 c4 18             	add    $0x18,%esp
}
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80199d:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	50                   	push   %eax
  8019a9:	6a 22                	push   $0x22
  8019ab:	e8 0c fc ff ff       	call   8015bc <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
}
  8019b3:	90                   	nop
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	50                   	push   %eax
  8019c5:	6a 23                	push   $0x23
  8019c7:	e8 f0 fb ff ff       	call   8015bc <syscall>
  8019cc:	83 c4 18             	add    $0x18,%esp
}
  8019cf:	90                   	nop
  8019d0:	c9                   	leave  
  8019d1:	c3                   	ret    

008019d2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
  8019d5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019d8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019db:	8d 50 04             	lea    0x4(%eax),%edx
  8019de:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	52                   	push   %edx
  8019e8:	50                   	push   %eax
  8019e9:	6a 24                	push   $0x24
  8019eb:	e8 cc fb ff ff       	call   8015bc <syscall>
  8019f0:	83 c4 18             	add    $0x18,%esp
	return result;
  8019f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019fc:	89 01                	mov    %eax,(%ecx)
  8019fe:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a01:	8b 45 08             	mov    0x8(%ebp),%eax
  801a04:	c9                   	leave  
  801a05:	c2 04 00             	ret    $0x4

00801a08 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	ff 75 10             	pushl  0x10(%ebp)
  801a12:	ff 75 0c             	pushl  0xc(%ebp)
  801a15:	ff 75 08             	pushl  0x8(%ebp)
  801a18:	6a 13                	push   $0x13
  801a1a:	e8 9d fb ff ff       	call   8015bc <syscall>
  801a1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a22:	90                   	nop
}
  801a23:	c9                   	leave  
  801a24:	c3                   	ret    

00801a25 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a25:	55                   	push   %ebp
  801a26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 25                	push   $0x25
  801a34:	e8 83 fb ff ff       	call   8015bc <syscall>
  801a39:	83 c4 18             	add    $0x18,%esp
}
  801a3c:	c9                   	leave  
  801a3d:	c3                   	ret    

00801a3e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a3e:	55                   	push   %ebp
  801a3f:	89 e5                	mov    %esp,%ebp
  801a41:	83 ec 04             	sub    $0x4,%esp
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a4a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	50                   	push   %eax
  801a57:	6a 26                	push   $0x26
  801a59:	e8 5e fb ff ff       	call   8015bc <syscall>
  801a5e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a61:	90                   	nop
}
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <rsttst>:
void rsttst()
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 28                	push   $0x28
  801a73:	e8 44 fb ff ff       	call   8015bc <syscall>
  801a78:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7b:	90                   	nop
}
  801a7c:	c9                   	leave  
  801a7d:	c3                   	ret    

00801a7e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a7e:	55                   	push   %ebp
  801a7f:	89 e5                	mov    %esp,%ebp
  801a81:	83 ec 04             	sub    $0x4,%esp
  801a84:	8b 45 14             	mov    0x14(%ebp),%eax
  801a87:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a8a:	8b 55 18             	mov    0x18(%ebp),%edx
  801a8d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a91:	52                   	push   %edx
  801a92:	50                   	push   %eax
  801a93:	ff 75 10             	pushl  0x10(%ebp)
  801a96:	ff 75 0c             	pushl  0xc(%ebp)
  801a99:	ff 75 08             	pushl  0x8(%ebp)
  801a9c:	6a 27                	push   $0x27
  801a9e:	e8 19 fb ff ff       	call   8015bc <syscall>
  801aa3:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa6:	90                   	nop
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <chktst>:
void chktst(uint32 n)
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	ff 75 08             	pushl  0x8(%ebp)
  801ab7:	6a 29                	push   $0x29
  801ab9:	e8 fe fa ff ff       	call   8015bc <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac1:	90                   	nop
}
  801ac2:	c9                   	leave  
  801ac3:	c3                   	ret    

00801ac4 <inctst>:

void inctst()
{
  801ac4:	55                   	push   %ebp
  801ac5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 2a                	push   $0x2a
  801ad3:	e8 e4 fa ff ff       	call   8015bc <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
	return ;
  801adb:	90                   	nop
}
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <gettst>:
uint32 gettst()
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 2b                	push   $0x2b
  801aed:	e8 ca fa ff ff       	call   8015bc <syscall>
  801af2:	83 c4 18             	add    $0x18,%esp
}
  801af5:	c9                   	leave  
  801af6:	c3                   	ret    

00801af7 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801af7:	55                   	push   %ebp
  801af8:	89 e5                	mov    %esp,%ebp
  801afa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 2c                	push   $0x2c
  801b09:	e8 ae fa ff ff       	call   8015bc <syscall>
  801b0e:	83 c4 18             	add    $0x18,%esp
  801b11:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b14:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b18:	75 07                	jne    801b21 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b1a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b1f:	eb 05                	jmp    801b26 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b21:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
  801b2b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 2c                	push   $0x2c
  801b3a:	e8 7d fa ff ff       	call   8015bc <syscall>
  801b3f:	83 c4 18             	add    $0x18,%esp
  801b42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b45:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b49:	75 07                	jne    801b52 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b4b:	b8 01 00 00 00       	mov    $0x1,%eax
  801b50:	eb 05                	jmp    801b57 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b52:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b57:	c9                   	leave  
  801b58:	c3                   	ret    

00801b59 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
  801b5c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 2c                	push   $0x2c
  801b6b:	e8 4c fa ff ff       	call   8015bc <syscall>
  801b70:	83 c4 18             	add    $0x18,%esp
  801b73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b76:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b7a:	75 07                	jne    801b83 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b7c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b81:	eb 05                	jmp    801b88 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
  801b8d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 2c                	push   $0x2c
  801b9c:	e8 1b fa ff ff       	call   8015bc <syscall>
  801ba1:	83 c4 18             	add    $0x18,%esp
  801ba4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ba7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bab:	75 07                	jne    801bb4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bad:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb2:	eb 05                	jmp    801bb9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bb4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bb9:	c9                   	leave  
  801bba:	c3                   	ret    

00801bbb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bbb:	55                   	push   %ebp
  801bbc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	ff 75 08             	pushl  0x8(%ebp)
  801bc9:	6a 2d                	push   $0x2d
  801bcb:	e8 ec f9 ff ff       	call   8015bc <syscall>
  801bd0:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd3:	90                   	nop
}
  801bd4:	c9                   	leave  
  801bd5:	c3                   	ret    
  801bd6:	66 90                	xchg   %ax,%ax

00801bd8 <__udivdi3>:
  801bd8:	55                   	push   %ebp
  801bd9:	57                   	push   %edi
  801bda:	56                   	push   %esi
  801bdb:	53                   	push   %ebx
  801bdc:	83 ec 1c             	sub    $0x1c,%esp
  801bdf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801be3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801be7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801beb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801bef:	89 ca                	mov    %ecx,%edx
  801bf1:	89 f8                	mov    %edi,%eax
  801bf3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801bf7:	85 f6                	test   %esi,%esi
  801bf9:	75 2d                	jne    801c28 <__udivdi3+0x50>
  801bfb:	39 cf                	cmp    %ecx,%edi
  801bfd:	77 65                	ja     801c64 <__udivdi3+0x8c>
  801bff:	89 fd                	mov    %edi,%ebp
  801c01:	85 ff                	test   %edi,%edi
  801c03:	75 0b                	jne    801c10 <__udivdi3+0x38>
  801c05:	b8 01 00 00 00       	mov    $0x1,%eax
  801c0a:	31 d2                	xor    %edx,%edx
  801c0c:	f7 f7                	div    %edi
  801c0e:	89 c5                	mov    %eax,%ebp
  801c10:	31 d2                	xor    %edx,%edx
  801c12:	89 c8                	mov    %ecx,%eax
  801c14:	f7 f5                	div    %ebp
  801c16:	89 c1                	mov    %eax,%ecx
  801c18:	89 d8                	mov    %ebx,%eax
  801c1a:	f7 f5                	div    %ebp
  801c1c:	89 cf                	mov    %ecx,%edi
  801c1e:	89 fa                	mov    %edi,%edx
  801c20:	83 c4 1c             	add    $0x1c,%esp
  801c23:	5b                   	pop    %ebx
  801c24:	5e                   	pop    %esi
  801c25:	5f                   	pop    %edi
  801c26:	5d                   	pop    %ebp
  801c27:	c3                   	ret    
  801c28:	39 ce                	cmp    %ecx,%esi
  801c2a:	77 28                	ja     801c54 <__udivdi3+0x7c>
  801c2c:	0f bd fe             	bsr    %esi,%edi
  801c2f:	83 f7 1f             	xor    $0x1f,%edi
  801c32:	75 40                	jne    801c74 <__udivdi3+0x9c>
  801c34:	39 ce                	cmp    %ecx,%esi
  801c36:	72 0a                	jb     801c42 <__udivdi3+0x6a>
  801c38:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c3c:	0f 87 9e 00 00 00    	ja     801ce0 <__udivdi3+0x108>
  801c42:	b8 01 00 00 00       	mov    $0x1,%eax
  801c47:	89 fa                	mov    %edi,%edx
  801c49:	83 c4 1c             	add    $0x1c,%esp
  801c4c:	5b                   	pop    %ebx
  801c4d:	5e                   	pop    %esi
  801c4e:	5f                   	pop    %edi
  801c4f:	5d                   	pop    %ebp
  801c50:	c3                   	ret    
  801c51:	8d 76 00             	lea    0x0(%esi),%esi
  801c54:	31 ff                	xor    %edi,%edi
  801c56:	31 c0                	xor    %eax,%eax
  801c58:	89 fa                	mov    %edi,%edx
  801c5a:	83 c4 1c             	add    $0x1c,%esp
  801c5d:	5b                   	pop    %ebx
  801c5e:	5e                   	pop    %esi
  801c5f:	5f                   	pop    %edi
  801c60:	5d                   	pop    %ebp
  801c61:	c3                   	ret    
  801c62:	66 90                	xchg   %ax,%ax
  801c64:	89 d8                	mov    %ebx,%eax
  801c66:	f7 f7                	div    %edi
  801c68:	31 ff                	xor    %edi,%edi
  801c6a:	89 fa                	mov    %edi,%edx
  801c6c:	83 c4 1c             	add    $0x1c,%esp
  801c6f:	5b                   	pop    %ebx
  801c70:	5e                   	pop    %esi
  801c71:	5f                   	pop    %edi
  801c72:	5d                   	pop    %ebp
  801c73:	c3                   	ret    
  801c74:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c79:	89 eb                	mov    %ebp,%ebx
  801c7b:	29 fb                	sub    %edi,%ebx
  801c7d:	89 f9                	mov    %edi,%ecx
  801c7f:	d3 e6                	shl    %cl,%esi
  801c81:	89 c5                	mov    %eax,%ebp
  801c83:	88 d9                	mov    %bl,%cl
  801c85:	d3 ed                	shr    %cl,%ebp
  801c87:	89 e9                	mov    %ebp,%ecx
  801c89:	09 f1                	or     %esi,%ecx
  801c8b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c8f:	89 f9                	mov    %edi,%ecx
  801c91:	d3 e0                	shl    %cl,%eax
  801c93:	89 c5                	mov    %eax,%ebp
  801c95:	89 d6                	mov    %edx,%esi
  801c97:	88 d9                	mov    %bl,%cl
  801c99:	d3 ee                	shr    %cl,%esi
  801c9b:	89 f9                	mov    %edi,%ecx
  801c9d:	d3 e2                	shl    %cl,%edx
  801c9f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ca3:	88 d9                	mov    %bl,%cl
  801ca5:	d3 e8                	shr    %cl,%eax
  801ca7:	09 c2                	or     %eax,%edx
  801ca9:	89 d0                	mov    %edx,%eax
  801cab:	89 f2                	mov    %esi,%edx
  801cad:	f7 74 24 0c          	divl   0xc(%esp)
  801cb1:	89 d6                	mov    %edx,%esi
  801cb3:	89 c3                	mov    %eax,%ebx
  801cb5:	f7 e5                	mul    %ebp
  801cb7:	39 d6                	cmp    %edx,%esi
  801cb9:	72 19                	jb     801cd4 <__udivdi3+0xfc>
  801cbb:	74 0b                	je     801cc8 <__udivdi3+0xf0>
  801cbd:	89 d8                	mov    %ebx,%eax
  801cbf:	31 ff                	xor    %edi,%edi
  801cc1:	e9 58 ff ff ff       	jmp    801c1e <__udivdi3+0x46>
  801cc6:	66 90                	xchg   %ax,%ax
  801cc8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ccc:	89 f9                	mov    %edi,%ecx
  801cce:	d3 e2                	shl    %cl,%edx
  801cd0:	39 c2                	cmp    %eax,%edx
  801cd2:	73 e9                	jae    801cbd <__udivdi3+0xe5>
  801cd4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801cd7:	31 ff                	xor    %edi,%edi
  801cd9:	e9 40 ff ff ff       	jmp    801c1e <__udivdi3+0x46>
  801cde:	66 90                	xchg   %ax,%ax
  801ce0:	31 c0                	xor    %eax,%eax
  801ce2:	e9 37 ff ff ff       	jmp    801c1e <__udivdi3+0x46>
  801ce7:	90                   	nop

00801ce8 <__umoddi3>:
  801ce8:	55                   	push   %ebp
  801ce9:	57                   	push   %edi
  801cea:	56                   	push   %esi
  801ceb:	53                   	push   %ebx
  801cec:	83 ec 1c             	sub    $0x1c,%esp
  801cef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801cf3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801cf7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cfb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801cff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d03:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d07:	89 f3                	mov    %esi,%ebx
  801d09:	89 fa                	mov    %edi,%edx
  801d0b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d0f:	89 34 24             	mov    %esi,(%esp)
  801d12:	85 c0                	test   %eax,%eax
  801d14:	75 1a                	jne    801d30 <__umoddi3+0x48>
  801d16:	39 f7                	cmp    %esi,%edi
  801d18:	0f 86 a2 00 00 00    	jbe    801dc0 <__umoddi3+0xd8>
  801d1e:	89 c8                	mov    %ecx,%eax
  801d20:	89 f2                	mov    %esi,%edx
  801d22:	f7 f7                	div    %edi
  801d24:	89 d0                	mov    %edx,%eax
  801d26:	31 d2                	xor    %edx,%edx
  801d28:	83 c4 1c             	add    $0x1c,%esp
  801d2b:	5b                   	pop    %ebx
  801d2c:	5e                   	pop    %esi
  801d2d:	5f                   	pop    %edi
  801d2e:	5d                   	pop    %ebp
  801d2f:	c3                   	ret    
  801d30:	39 f0                	cmp    %esi,%eax
  801d32:	0f 87 ac 00 00 00    	ja     801de4 <__umoddi3+0xfc>
  801d38:	0f bd e8             	bsr    %eax,%ebp
  801d3b:	83 f5 1f             	xor    $0x1f,%ebp
  801d3e:	0f 84 ac 00 00 00    	je     801df0 <__umoddi3+0x108>
  801d44:	bf 20 00 00 00       	mov    $0x20,%edi
  801d49:	29 ef                	sub    %ebp,%edi
  801d4b:	89 fe                	mov    %edi,%esi
  801d4d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d51:	89 e9                	mov    %ebp,%ecx
  801d53:	d3 e0                	shl    %cl,%eax
  801d55:	89 d7                	mov    %edx,%edi
  801d57:	89 f1                	mov    %esi,%ecx
  801d59:	d3 ef                	shr    %cl,%edi
  801d5b:	09 c7                	or     %eax,%edi
  801d5d:	89 e9                	mov    %ebp,%ecx
  801d5f:	d3 e2                	shl    %cl,%edx
  801d61:	89 14 24             	mov    %edx,(%esp)
  801d64:	89 d8                	mov    %ebx,%eax
  801d66:	d3 e0                	shl    %cl,%eax
  801d68:	89 c2                	mov    %eax,%edx
  801d6a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d6e:	d3 e0                	shl    %cl,%eax
  801d70:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d74:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d78:	89 f1                	mov    %esi,%ecx
  801d7a:	d3 e8                	shr    %cl,%eax
  801d7c:	09 d0                	or     %edx,%eax
  801d7e:	d3 eb                	shr    %cl,%ebx
  801d80:	89 da                	mov    %ebx,%edx
  801d82:	f7 f7                	div    %edi
  801d84:	89 d3                	mov    %edx,%ebx
  801d86:	f7 24 24             	mull   (%esp)
  801d89:	89 c6                	mov    %eax,%esi
  801d8b:	89 d1                	mov    %edx,%ecx
  801d8d:	39 d3                	cmp    %edx,%ebx
  801d8f:	0f 82 87 00 00 00    	jb     801e1c <__umoddi3+0x134>
  801d95:	0f 84 91 00 00 00    	je     801e2c <__umoddi3+0x144>
  801d9b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d9f:	29 f2                	sub    %esi,%edx
  801da1:	19 cb                	sbb    %ecx,%ebx
  801da3:	89 d8                	mov    %ebx,%eax
  801da5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801da9:	d3 e0                	shl    %cl,%eax
  801dab:	89 e9                	mov    %ebp,%ecx
  801dad:	d3 ea                	shr    %cl,%edx
  801daf:	09 d0                	or     %edx,%eax
  801db1:	89 e9                	mov    %ebp,%ecx
  801db3:	d3 eb                	shr    %cl,%ebx
  801db5:	89 da                	mov    %ebx,%edx
  801db7:	83 c4 1c             	add    $0x1c,%esp
  801dba:	5b                   	pop    %ebx
  801dbb:	5e                   	pop    %esi
  801dbc:	5f                   	pop    %edi
  801dbd:	5d                   	pop    %ebp
  801dbe:	c3                   	ret    
  801dbf:	90                   	nop
  801dc0:	89 fd                	mov    %edi,%ebp
  801dc2:	85 ff                	test   %edi,%edi
  801dc4:	75 0b                	jne    801dd1 <__umoddi3+0xe9>
  801dc6:	b8 01 00 00 00       	mov    $0x1,%eax
  801dcb:	31 d2                	xor    %edx,%edx
  801dcd:	f7 f7                	div    %edi
  801dcf:	89 c5                	mov    %eax,%ebp
  801dd1:	89 f0                	mov    %esi,%eax
  801dd3:	31 d2                	xor    %edx,%edx
  801dd5:	f7 f5                	div    %ebp
  801dd7:	89 c8                	mov    %ecx,%eax
  801dd9:	f7 f5                	div    %ebp
  801ddb:	89 d0                	mov    %edx,%eax
  801ddd:	e9 44 ff ff ff       	jmp    801d26 <__umoddi3+0x3e>
  801de2:	66 90                	xchg   %ax,%ax
  801de4:	89 c8                	mov    %ecx,%eax
  801de6:	89 f2                	mov    %esi,%edx
  801de8:	83 c4 1c             	add    $0x1c,%esp
  801deb:	5b                   	pop    %ebx
  801dec:	5e                   	pop    %esi
  801ded:	5f                   	pop    %edi
  801dee:	5d                   	pop    %ebp
  801def:	c3                   	ret    
  801df0:	3b 04 24             	cmp    (%esp),%eax
  801df3:	72 06                	jb     801dfb <__umoddi3+0x113>
  801df5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801df9:	77 0f                	ja     801e0a <__umoddi3+0x122>
  801dfb:	89 f2                	mov    %esi,%edx
  801dfd:	29 f9                	sub    %edi,%ecx
  801dff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e03:	89 14 24             	mov    %edx,(%esp)
  801e06:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e0a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e0e:	8b 14 24             	mov    (%esp),%edx
  801e11:	83 c4 1c             	add    $0x1c,%esp
  801e14:	5b                   	pop    %ebx
  801e15:	5e                   	pop    %esi
  801e16:	5f                   	pop    %edi
  801e17:	5d                   	pop    %ebp
  801e18:	c3                   	ret    
  801e19:	8d 76 00             	lea    0x0(%esi),%esi
  801e1c:	2b 04 24             	sub    (%esp),%eax
  801e1f:	19 fa                	sbb    %edi,%edx
  801e21:	89 d1                	mov    %edx,%ecx
  801e23:	89 c6                	mov    %eax,%esi
  801e25:	e9 71 ff ff ff       	jmp    801d9b <__umoddi3+0xb3>
  801e2a:	66 90                	xchg   %ax,%ax
  801e2c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e30:	72 ea                	jb     801e1c <__umoddi3+0x134>
  801e32:	89 d9                	mov    %ebx,%ecx
  801e34:	e9 62 ff ff ff       	jmp    801d9b <__umoddi3+0xb3>
