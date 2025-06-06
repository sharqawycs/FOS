
obj/user/tst_sharing_5_slave:     file format elf32-i386


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
  800031:	e8 e9 00 00 00       	call   80011f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003e:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800049:	eb 29                	jmp    800074 <_main+0x3c>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004b:	a1 20 30 80 00       	mov    0x803020,%eax
  800050:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800056:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800059:	89 d0                	mov    %edx,%eax
  80005b:	01 c0                	add    %eax,%eax
  80005d:	01 d0                	add    %edx,%eax
  80005f:	c1 e0 02             	shl    $0x2,%eax
  800062:	01 c8                	add    %ecx,%eax
  800064:	8a 40 04             	mov    0x4(%eax),%al
  800067:	84 c0                	test   %al,%al
  800069:	74 06                	je     800071 <_main+0x39>
			{
				fullWS = 0;
  80006b:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006f:	eb 12                	jmp    800083 <_main+0x4b>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800071:	ff 45 f0             	incl   -0x10(%ebp)
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 50 74             	mov    0x74(%eax),%edx
  80007c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007f:	39 c2                	cmp    %eax,%edx
  800081:	77 c8                	ja     80004b <_main+0x13>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800083:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800087:	74 14                	je     80009d <_main+0x65>
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	68 80 1d 80 00       	push   $0x801d80
  800091:	6a 12                	push   $0x12
  800093:	68 9c 1d 80 00       	push   $0x801d9c
  800098:	e8 84 01 00 00       	call   800221 <_panic>
	}

	uint32 *x;
	x = sget(sys_getparentenvid(),"x");
  80009d:	e8 07 15 00 00       	call   8015a9 <sys_getparentenvid>
  8000a2:	83 ec 08             	sub    $0x8,%esp
  8000a5:	68 b7 1d 80 00       	push   $0x801db7
  8000aa:	50                   	push   %eax
  8000ab:	e8 cf 11 00 00       	call   80127f <sget>
  8000b0:	83 c4 10             	add    $0x10,%esp
  8000b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int freeFrames = sys_calculate_free_frames() ;
  8000b6:	e8 a0 15 00 00       	call   80165b <sys_calculate_free_frames>
  8000bb:	89 45 e8             	mov    %eax,-0x18(%ebp)

	cprintf("Slave env used x (getSharedObject)\n");
  8000be:	83 ec 0c             	sub    $0xc,%esp
  8000c1:	68 bc 1d 80 00       	push   $0x801dbc
  8000c6:	e8 0a 04 00 00       	call   8004d5 <cprintf>
  8000cb:	83 c4 10             	add    $0x10,%esp

	sfree(x);
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d4:	e8 dc 13 00 00       	call   8014b5 <sfree>
  8000d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Slave env removed x\n");
  8000dc:	83 ec 0c             	sub    $0xc,%esp
  8000df:	68 e0 1d 80 00       	push   $0x801de0
  8000e4:	e8 ec 03 00 00       	call   8004d5 <cprintf>
  8000e9:	83 c4 10             	add    $0x10,%esp

	int diff = (sys_calculate_free_frames() - freeFrames);
  8000ec:	e8 6a 15 00 00       	call   80165b <sys_calculate_free_frames>
  8000f1:	89 c2                	mov    %eax,%edx
  8000f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f6:	29 c2                	sub    %eax,%edx
  8000f8:	89 d0                	mov    %edx,%eax
  8000fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (diff != 1) panic("wrong free: frames removed not equal 1 !, correct frames to be removed is 1:\nfrom the env: 1 table for x\nframes_storage: not cleared yet\n");
  8000fd:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  800101:	74 14                	je     800117 <_main+0xdf>
  800103:	83 ec 04             	sub    $0x4,%esp
  800106:	68 f8 1d 80 00       	push   $0x801df8
  80010b:	6a 1f                	push   $0x1f
  80010d:	68 9c 1d 80 00       	push   $0x801d9c
  800112:	e8 0a 01 00 00       	call   800221 <_panic>

	//to ensure that this environment is completed successfully
	inctst();
  800117:	e8 db 18 00 00       	call   8019f7 <inctst>

	return;
  80011c:	90                   	nop
}
  80011d:	c9                   	leave  
  80011e:	c3                   	ret    

0080011f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80011f:	55                   	push   %ebp
  800120:	89 e5                	mov    %esp,%ebp
  800122:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800125:	e8 66 14 00 00       	call   801590 <sys_getenvindex>
  80012a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80012d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800130:	89 d0                	mov    %edx,%eax
  800132:	01 c0                	add    %eax,%eax
  800134:	01 d0                	add    %edx,%eax
  800136:	c1 e0 02             	shl    $0x2,%eax
  800139:	01 d0                	add    %edx,%eax
  80013b:	c1 e0 06             	shl    $0x6,%eax
  80013e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800143:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800148:	a1 20 30 80 00       	mov    0x803020,%eax
  80014d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800153:	84 c0                	test   %al,%al
  800155:	74 0f                	je     800166 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800157:	a1 20 30 80 00       	mov    0x803020,%eax
  80015c:	05 f4 02 00 00       	add    $0x2f4,%eax
  800161:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800166:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80016a:	7e 0a                	jle    800176 <libmain+0x57>
		binaryname = argv[0];
  80016c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80016f:	8b 00                	mov    (%eax),%eax
  800171:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800176:	83 ec 08             	sub    $0x8,%esp
  800179:	ff 75 0c             	pushl  0xc(%ebp)
  80017c:	ff 75 08             	pushl  0x8(%ebp)
  80017f:	e8 b4 fe ff ff       	call   800038 <_main>
  800184:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800187:	e8 9f 15 00 00       	call   80172b <sys_disable_interrupt>
	cprintf("**************************************\n");
  80018c:	83 ec 0c             	sub    $0xc,%esp
  80018f:	68 9c 1e 80 00       	push   $0x801e9c
  800194:	e8 3c 03 00 00       	call   8004d5 <cprintf>
  800199:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80019c:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a1:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ac:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001b2:	83 ec 04             	sub    $0x4,%esp
  8001b5:	52                   	push   %edx
  8001b6:	50                   	push   %eax
  8001b7:	68 c4 1e 80 00       	push   $0x801ec4
  8001bc:	e8 14 03 00 00       	call   8004d5 <cprintf>
  8001c1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c9:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001cf:	83 ec 08             	sub    $0x8,%esp
  8001d2:	50                   	push   %eax
  8001d3:	68 e9 1e 80 00       	push   $0x801ee9
  8001d8:	e8 f8 02 00 00       	call   8004d5 <cprintf>
  8001dd:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001e0:	83 ec 0c             	sub    $0xc,%esp
  8001e3:	68 9c 1e 80 00       	push   $0x801e9c
  8001e8:	e8 e8 02 00 00       	call   8004d5 <cprintf>
  8001ed:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001f0:	e8 50 15 00 00       	call   801745 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001f5:	e8 19 00 00 00       	call   800213 <exit>
}
  8001fa:	90                   	nop
  8001fb:	c9                   	leave  
  8001fc:	c3                   	ret    

008001fd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001fd:	55                   	push   %ebp
  8001fe:	89 e5                	mov    %esp,%ebp
  800200:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	6a 00                	push   $0x0
  800208:	e8 4f 13 00 00       	call   80155c <sys_env_destroy>
  80020d:	83 c4 10             	add    $0x10,%esp
}
  800210:	90                   	nop
  800211:	c9                   	leave  
  800212:	c3                   	ret    

00800213 <exit>:

void
exit(void)
{
  800213:	55                   	push   %ebp
  800214:	89 e5                	mov    %esp,%ebp
  800216:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800219:	e8 a4 13 00 00       	call   8015c2 <sys_env_exit>
}
  80021e:	90                   	nop
  80021f:	c9                   	leave  
  800220:	c3                   	ret    

00800221 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800221:	55                   	push   %ebp
  800222:	89 e5                	mov    %esp,%ebp
  800224:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800227:	8d 45 10             	lea    0x10(%ebp),%eax
  80022a:	83 c0 04             	add    $0x4,%eax
  80022d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800230:	a1 30 30 80 00       	mov    0x803030,%eax
  800235:	85 c0                	test   %eax,%eax
  800237:	74 16                	je     80024f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800239:	a1 30 30 80 00       	mov    0x803030,%eax
  80023e:	83 ec 08             	sub    $0x8,%esp
  800241:	50                   	push   %eax
  800242:	68 00 1f 80 00       	push   $0x801f00
  800247:	e8 89 02 00 00       	call   8004d5 <cprintf>
  80024c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80024f:	a1 00 30 80 00       	mov    0x803000,%eax
  800254:	ff 75 0c             	pushl  0xc(%ebp)
  800257:	ff 75 08             	pushl  0x8(%ebp)
  80025a:	50                   	push   %eax
  80025b:	68 05 1f 80 00       	push   $0x801f05
  800260:	e8 70 02 00 00       	call   8004d5 <cprintf>
  800265:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800268:	8b 45 10             	mov    0x10(%ebp),%eax
  80026b:	83 ec 08             	sub    $0x8,%esp
  80026e:	ff 75 f4             	pushl  -0xc(%ebp)
  800271:	50                   	push   %eax
  800272:	e8 f3 01 00 00       	call   80046a <vcprintf>
  800277:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80027a:	83 ec 08             	sub    $0x8,%esp
  80027d:	6a 00                	push   $0x0
  80027f:	68 21 1f 80 00       	push   $0x801f21
  800284:	e8 e1 01 00 00       	call   80046a <vcprintf>
  800289:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80028c:	e8 82 ff ff ff       	call   800213 <exit>

	// should not return here
	while (1) ;
  800291:	eb fe                	jmp    800291 <_panic+0x70>

00800293 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800293:	55                   	push   %ebp
  800294:	89 e5                	mov    %esp,%ebp
  800296:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800299:	a1 20 30 80 00       	mov    0x803020,%eax
  80029e:	8b 50 74             	mov    0x74(%eax),%edx
  8002a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a4:	39 c2                	cmp    %eax,%edx
  8002a6:	74 14                	je     8002bc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002a8:	83 ec 04             	sub    $0x4,%esp
  8002ab:	68 24 1f 80 00       	push   $0x801f24
  8002b0:	6a 26                	push   $0x26
  8002b2:	68 70 1f 80 00       	push   $0x801f70
  8002b7:	e8 65 ff ff ff       	call   800221 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002ca:	e9 c2 00 00 00       	jmp    800391 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002dc:	01 d0                	add    %edx,%eax
  8002de:	8b 00                	mov    (%eax),%eax
  8002e0:	85 c0                	test   %eax,%eax
  8002e2:	75 08                	jne    8002ec <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002e4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002e7:	e9 a2 00 00 00       	jmp    80038e <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8002ec:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002f3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002fa:	eb 69                	jmp    800365 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800301:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800307:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80030a:	89 d0                	mov    %edx,%eax
  80030c:	01 c0                	add    %eax,%eax
  80030e:	01 d0                	add    %edx,%eax
  800310:	c1 e0 02             	shl    $0x2,%eax
  800313:	01 c8                	add    %ecx,%eax
  800315:	8a 40 04             	mov    0x4(%eax),%al
  800318:	84 c0                	test   %al,%al
  80031a:	75 46                	jne    800362 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80031c:	a1 20 30 80 00       	mov    0x803020,%eax
  800321:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800327:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80032a:	89 d0                	mov    %edx,%eax
  80032c:	01 c0                	add    %eax,%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	c1 e0 02             	shl    $0x2,%eax
  800333:	01 c8                	add    %ecx,%eax
  800335:	8b 00                	mov    (%eax),%eax
  800337:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80033a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80033d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800342:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800344:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800355:	39 c2                	cmp    %eax,%edx
  800357:	75 09                	jne    800362 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800359:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800360:	eb 12                	jmp    800374 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800362:	ff 45 e8             	incl   -0x18(%ebp)
  800365:	a1 20 30 80 00       	mov    0x803020,%eax
  80036a:	8b 50 74             	mov    0x74(%eax),%edx
  80036d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800370:	39 c2                	cmp    %eax,%edx
  800372:	77 88                	ja     8002fc <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800374:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800378:	75 14                	jne    80038e <CheckWSWithoutLastIndex+0xfb>
			panic(
  80037a:	83 ec 04             	sub    $0x4,%esp
  80037d:	68 7c 1f 80 00       	push   $0x801f7c
  800382:	6a 3a                	push   $0x3a
  800384:	68 70 1f 80 00       	push   $0x801f70
  800389:	e8 93 fe ff ff       	call   800221 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80038e:	ff 45 f0             	incl   -0x10(%ebp)
  800391:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800394:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800397:	0f 8c 32 ff ff ff    	jl     8002cf <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80039d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003ab:	eb 26                	jmp    8003d3 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003b8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003bb:	89 d0                	mov    %edx,%eax
  8003bd:	01 c0                	add    %eax,%eax
  8003bf:	01 d0                	add    %edx,%eax
  8003c1:	c1 e0 02             	shl    $0x2,%eax
  8003c4:	01 c8                	add    %ecx,%eax
  8003c6:	8a 40 04             	mov    0x4(%eax),%al
  8003c9:	3c 01                	cmp    $0x1,%al
  8003cb:	75 03                	jne    8003d0 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003cd:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d0:	ff 45 e0             	incl   -0x20(%ebp)
  8003d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d8:	8b 50 74             	mov    0x74(%eax),%edx
  8003db:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003de:	39 c2                	cmp    %eax,%edx
  8003e0:	77 cb                	ja     8003ad <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003e8:	74 14                	je     8003fe <CheckWSWithoutLastIndex+0x16b>
		panic(
  8003ea:	83 ec 04             	sub    $0x4,%esp
  8003ed:	68 d0 1f 80 00       	push   $0x801fd0
  8003f2:	6a 44                	push   $0x44
  8003f4:	68 70 1f 80 00       	push   $0x801f70
  8003f9:	e8 23 fe ff ff       	call   800221 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8003fe:	90                   	nop
  8003ff:	c9                   	leave  
  800400:	c3                   	ret    

00800401 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800401:	55                   	push   %ebp
  800402:	89 e5                	mov    %esp,%ebp
  800404:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800407:	8b 45 0c             	mov    0xc(%ebp),%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	8d 48 01             	lea    0x1(%eax),%ecx
  80040f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800412:	89 0a                	mov    %ecx,(%edx)
  800414:	8b 55 08             	mov    0x8(%ebp),%edx
  800417:	88 d1                	mov    %dl,%cl
  800419:	8b 55 0c             	mov    0xc(%ebp),%edx
  80041c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800420:	8b 45 0c             	mov    0xc(%ebp),%eax
  800423:	8b 00                	mov    (%eax),%eax
  800425:	3d ff 00 00 00       	cmp    $0xff,%eax
  80042a:	75 2c                	jne    800458 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80042c:	a0 24 30 80 00       	mov    0x803024,%al
  800431:	0f b6 c0             	movzbl %al,%eax
  800434:	8b 55 0c             	mov    0xc(%ebp),%edx
  800437:	8b 12                	mov    (%edx),%edx
  800439:	89 d1                	mov    %edx,%ecx
  80043b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80043e:	83 c2 08             	add    $0x8,%edx
  800441:	83 ec 04             	sub    $0x4,%esp
  800444:	50                   	push   %eax
  800445:	51                   	push   %ecx
  800446:	52                   	push   %edx
  800447:	e8 ce 10 00 00       	call   80151a <sys_cputs>
  80044c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80044f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800452:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800458:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045b:	8b 40 04             	mov    0x4(%eax),%eax
  80045e:	8d 50 01             	lea    0x1(%eax),%edx
  800461:	8b 45 0c             	mov    0xc(%ebp),%eax
  800464:	89 50 04             	mov    %edx,0x4(%eax)
}
  800467:	90                   	nop
  800468:	c9                   	leave  
  800469:	c3                   	ret    

0080046a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80046a:	55                   	push   %ebp
  80046b:	89 e5                	mov    %esp,%ebp
  80046d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800473:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80047a:	00 00 00 
	b.cnt = 0;
  80047d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800484:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800487:	ff 75 0c             	pushl  0xc(%ebp)
  80048a:	ff 75 08             	pushl  0x8(%ebp)
  80048d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800493:	50                   	push   %eax
  800494:	68 01 04 80 00       	push   $0x800401
  800499:	e8 11 02 00 00       	call   8006af <vprintfmt>
  80049e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004a1:	a0 24 30 80 00       	mov    0x803024,%al
  8004a6:	0f b6 c0             	movzbl %al,%eax
  8004a9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004af:	83 ec 04             	sub    $0x4,%esp
  8004b2:	50                   	push   %eax
  8004b3:	52                   	push   %edx
  8004b4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004ba:	83 c0 08             	add    $0x8,%eax
  8004bd:	50                   	push   %eax
  8004be:	e8 57 10 00 00       	call   80151a <sys_cputs>
  8004c3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004c6:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004cd:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004d3:	c9                   	leave  
  8004d4:	c3                   	ret    

008004d5 <cprintf>:

int cprintf(const char *fmt, ...) {
  8004d5:	55                   	push   %ebp
  8004d6:	89 e5                	mov    %esp,%ebp
  8004d8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004db:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8004e2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004eb:	83 ec 08             	sub    $0x8,%esp
  8004ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f1:	50                   	push   %eax
  8004f2:	e8 73 ff ff ff       	call   80046a <vcprintf>
  8004f7:	83 c4 10             	add    $0x10,%esp
  8004fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800500:	c9                   	leave  
  800501:	c3                   	ret    

00800502 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800508:	e8 1e 12 00 00       	call   80172b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80050d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800510:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800513:	8b 45 08             	mov    0x8(%ebp),%eax
  800516:	83 ec 08             	sub    $0x8,%esp
  800519:	ff 75 f4             	pushl  -0xc(%ebp)
  80051c:	50                   	push   %eax
  80051d:	e8 48 ff ff ff       	call   80046a <vcprintf>
  800522:	83 c4 10             	add    $0x10,%esp
  800525:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800528:	e8 18 12 00 00       	call   801745 <sys_enable_interrupt>
	return cnt;
  80052d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800530:	c9                   	leave  
  800531:	c3                   	ret    

00800532 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800532:	55                   	push   %ebp
  800533:	89 e5                	mov    %esp,%ebp
  800535:	53                   	push   %ebx
  800536:	83 ec 14             	sub    $0x14,%esp
  800539:	8b 45 10             	mov    0x10(%ebp),%eax
  80053c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80053f:	8b 45 14             	mov    0x14(%ebp),%eax
  800542:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800545:	8b 45 18             	mov    0x18(%ebp),%eax
  800548:	ba 00 00 00 00       	mov    $0x0,%edx
  80054d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800550:	77 55                	ja     8005a7 <printnum+0x75>
  800552:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800555:	72 05                	jb     80055c <printnum+0x2a>
  800557:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80055a:	77 4b                	ja     8005a7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80055c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80055f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800562:	8b 45 18             	mov    0x18(%ebp),%eax
  800565:	ba 00 00 00 00       	mov    $0x0,%edx
  80056a:	52                   	push   %edx
  80056b:	50                   	push   %eax
  80056c:	ff 75 f4             	pushl  -0xc(%ebp)
  80056f:	ff 75 f0             	pushl  -0x10(%ebp)
  800572:	e8 95 15 00 00       	call   801b0c <__udivdi3>
  800577:	83 c4 10             	add    $0x10,%esp
  80057a:	83 ec 04             	sub    $0x4,%esp
  80057d:	ff 75 20             	pushl  0x20(%ebp)
  800580:	53                   	push   %ebx
  800581:	ff 75 18             	pushl  0x18(%ebp)
  800584:	52                   	push   %edx
  800585:	50                   	push   %eax
  800586:	ff 75 0c             	pushl  0xc(%ebp)
  800589:	ff 75 08             	pushl  0x8(%ebp)
  80058c:	e8 a1 ff ff ff       	call   800532 <printnum>
  800591:	83 c4 20             	add    $0x20,%esp
  800594:	eb 1a                	jmp    8005b0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800596:	83 ec 08             	sub    $0x8,%esp
  800599:	ff 75 0c             	pushl  0xc(%ebp)
  80059c:	ff 75 20             	pushl  0x20(%ebp)
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	ff d0                	call   *%eax
  8005a4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005a7:	ff 4d 1c             	decl   0x1c(%ebp)
  8005aa:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005ae:	7f e6                	jg     800596 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005b0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005b3:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005be:	53                   	push   %ebx
  8005bf:	51                   	push   %ecx
  8005c0:	52                   	push   %edx
  8005c1:	50                   	push   %eax
  8005c2:	e8 55 16 00 00       	call   801c1c <__umoddi3>
  8005c7:	83 c4 10             	add    $0x10,%esp
  8005ca:	05 34 22 80 00       	add    $0x802234,%eax
  8005cf:	8a 00                	mov    (%eax),%al
  8005d1:	0f be c0             	movsbl %al,%eax
  8005d4:	83 ec 08             	sub    $0x8,%esp
  8005d7:	ff 75 0c             	pushl  0xc(%ebp)
  8005da:	50                   	push   %eax
  8005db:	8b 45 08             	mov    0x8(%ebp),%eax
  8005de:	ff d0                	call   *%eax
  8005e0:	83 c4 10             	add    $0x10,%esp
}
  8005e3:	90                   	nop
  8005e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005e7:	c9                   	leave  
  8005e8:	c3                   	ret    

008005e9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005e9:	55                   	push   %ebp
  8005ea:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005ec:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005f0:	7e 1c                	jle    80060e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f5:	8b 00                	mov    (%eax),%eax
  8005f7:	8d 50 08             	lea    0x8(%eax),%edx
  8005fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fd:	89 10                	mov    %edx,(%eax)
  8005ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800602:	8b 00                	mov    (%eax),%eax
  800604:	83 e8 08             	sub    $0x8,%eax
  800607:	8b 50 04             	mov    0x4(%eax),%edx
  80060a:	8b 00                	mov    (%eax),%eax
  80060c:	eb 40                	jmp    80064e <getuint+0x65>
	else if (lflag)
  80060e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800612:	74 1e                	je     800632 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800614:	8b 45 08             	mov    0x8(%ebp),%eax
  800617:	8b 00                	mov    (%eax),%eax
  800619:	8d 50 04             	lea    0x4(%eax),%edx
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	89 10                	mov    %edx,(%eax)
  800621:	8b 45 08             	mov    0x8(%ebp),%eax
  800624:	8b 00                	mov    (%eax),%eax
  800626:	83 e8 04             	sub    $0x4,%eax
  800629:	8b 00                	mov    (%eax),%eax
  80062b:	ba 00 00 00 00       	mov    $0x0,%edx
  800630:	eb 1c                	jmp    80064e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	8b 00                	mov    (%eax),%eax
  800637:	8d 50 04             	lea    0x4(%eax),%edx
  80063a:	8b 45 08             	mov    0x8(%ebp),%eax
  80063d:	89 10                	mov    %edx,(%eax)
  80063f:	8b 45 08             	mov    0x8(%ebp),%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	83 e8 04             	sub    $0x4,%eax
  800647:	8b 00                	mov    (%eax),%eax
  800649:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80064e:	5d                   	pop    %ebp
  80064f:	c3                   	ret    

00800650 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800650:	55                   	push   %ebp
  800651:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800653:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800657:	7e 1c                	jle    800675 <getint+0x25>
		return va_arg(*ap, long long);
  800659:	8b 45 08             	mov    0x8(%ebp),%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	8d 50 08             	lea    0x8(%eax),%edx
  800661:	8b 45 08             	mov    0x8(%ebp),%eax
  800664:	89 10                	mov    %edx,(%eax)
  800666:	8b 45 08             	mov    0x8(%ebp),%eax
  800669:	8b 00                	mov    (%eax),%eax
  80066b:	83 e8 08             	sub    $0x8,%eax
  80066e:	8b 50 04             	mov    0x4(%eax),%edx
  800671:	8b 00                	mov    (%eax),%eax
  800673:	eb 38                	jmp    8006ad <getint+0x5d>
	else if (lflag)
  800675:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800679:	74 1a                	je     800695 <getint+0x45>
		return va_arg(*ap, long);
  80067b:	8b 45 08             	mov    0x8(%ebp),%eax
  80067e:	8b 00                	mov    (%eax),%eax
  800680:	8d 50 04             	lea    0x4(%eax),%edx
  800683:	8b 45 08             	mov    0x8(%ebp),%eax
  800686:	89 10                	mov    %edx,(%eax)
  800688:	8b 45 08             	mov    0x8(%ebp),%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	83 e8 04             	sub    $0x4,%eax
  800690:	8b 00                	mov    (%eax),%eax
  800692:	99                   	cltd   
  800693:	eb 18                	jmp    8006ad <getint+0x5d>
	else
		return va_arg(*ap, int);
  800695:	8b 45 08             	mov    0x8(%ebp),%eax
  800698:	8b 00                	mov    (%eax),%eax
  80069a:	8d 50 04             	lea    0x4(%eax),%edx
  80069d:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a0:	89 10                	mov    %edx,(%eax)
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	8b 00                	mov    (%eax),%eax
  8006a7:	83 e8 04             	sub    $0x4,%eax
  8006aa:	8b 00                	mov    (%eax),%eax
  8006ac:	99                   	cltd   
}
  8006ad:	5d                   	pop    %ebp
  8006ae:	c3                   	ret    

008006af <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	56                   	push   %esi
  8006b3:	53                   	push   %ebx
  8006b4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006b7:	eb 17                	jmp    8006d0 <vprintfmt+0x21>
			if (ch == '\0')
  8006b9:	85 db                	test   %ebx,%ebx
  8006bb:	0f 84 af 03 00 00    	je     800a70 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006c1:	83 ec 08             	sub    $0x8,%esp
  8006c4:	ff 75 0c             	pushl  0xc(%ebp)
  8006c7:	53                   	push   %ebx
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	ff d0                	call   *%eax
  8006cd:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 10             	mov    %edx,0x10(%ebp)
  8006d9:	8a 00                	mov    (%eax),%al
  8006db:	0f b6 d8             	movzbl %al,%ebx
  8006de:	83 fb 25             	cmp    $0x25,%ebx
  8006e1:	75 d6                	jne    8006b9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006e3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006e7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006ee:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006f5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006fc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800703:	8b 45 10             	mov    0x10(%ebp),%eax
  800706:	8d 50 01             	lea    0x1(%eax),%edx
  800709:	89 55 10             	mov    %edx,0x10(%ebp)
  80070c:	8a 00                	mov    (%eax),%al
  80070e:	0f b6 d8             	movzbl %al,%ebx
  800711:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800714:	83 f8 55             	cmp    $0x55,%eax
  800717:	0f 87 2b 03 00 00    	ja     800a48 <vprintfmt+0x399>
  80071d:	8b 04 85 58 22 80 00 	mov    0x802258(,%eax,4),%eax
  800724:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800726:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80072a:	eb d7                	jmp    800703 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80072c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800730:	eb d1                	jmp    800703 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800732:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800739:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80073c:	89 d0                	mov    %edx,%eax
  80073e:	c1 e0 02             	shl    $0x2,%eax
  800741:	01 d0                	add    %edx,%eax
  800743:	01 c0                	add    %eax,%eax
  800745:	01 d8                	add    %ebx,%eax
  800747:	83 e8 30             	sub    $0x30,%eax
  80074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80074d:	8b 45 10             	mov    0x10(%ebp),%eax
  800750:	8a 00                	mov    (%eax),%al
  800752:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800755:	83 fb 2f             	cmp    $0x2f,%ebx
  800758:	7e 3e                	jle    800798 <vprintfmt+0xe9>
  80075a:	83 fb 39             	cmp    $0x39,%ebx
  80075d:	7f 39                	jg     800798 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80075f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800762:	eb d5                	jmp    800739 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800764:	8b 45 14             	mov    0x14(%ebp),%eax
  800767:	83 c0 04             	add    $0x4,%eax
  80076a:	89 45 14             	mov    %eax,0x14(%ebp)
  80076d:	8b 45 14             	mov    0x14(%ebp),%eax
  800770:	83 e8 04             	sub    $0x4,%eax
  800773:	8b 00                	mov    (%eax),%eax
  800775:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800778:	eb 1f                	jmp    800799 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80077a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80077e:	79 83                	jns    800703 <vprintfmt+0x54>
				width = 0;
  800780:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800787:	e9 77 ff ff ff       	jmp    800703 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80078c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800793:	e9 6b ff ff ff       	jmp    800703 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800798:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800799:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80079d:	0f 89 60 ff ff ff    	jns    800703 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007a9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007b0:	e9 4e ff ff ff       	jmp    800703 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007b5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007b8:	e9 46 ff ff ff       	jmp    800703 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c0:	83 c0 04             	add    $0x4,%eax
  8007c3:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c9:	83 e8 04             	sub    $0x4,%eax
  8007cc:	8b 00                	mov    (%eax),%eax
  8007ce:	83 ec 08             	sub    $0x8,%esp
  8007d1:	ff 75 0c             	pushl  0xc(%ebp)
  8007d4:	50                   	push   %eax
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	ff d0                	call   *%eax
  8007da:	83 c4 10             	add    $0x10,%esp
			break;
  8007dd:	e9 89 02 00 00       	jmp    800a6b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e5:	83 c0 04             	add    $0x4,%eax
  8007e8:	89 45 14             	mov    %eax,0x14(%ebp)
  8007eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ee:	83 e8 04             	sub    $0x4,%eax
  8007f1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007f3:	85 db                	test   %ebx,%ebx
  8007f5:	79 02                	jns    8007f9 <vprintfmt+0x14a>
				err = -err;
  8007f7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007f9:	83 fb 64             	cmp    $0x64,%ebx
  8007fc:	7f 0b                	jg     800809 <vprintfmt+0x15a>
  8007fe:	8b 34 9d a0 20 80 00 	mov    0x8020a0(,%ebx,4),%esi
  800805:	85 f6                	test   %esi,%esi
  800807:	75 19                	jne    800822 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800809:	53                   	push   %ebx
  80080a:	68 45 22 80 00       	push   $0x802245
  80080f:	ff 75 0c             	pushl  0xc(%ebp)
  800812:	ff 75 08             	pushl  0x8(%ebp)
  800815:	e8 5e 02 00 00       	call   800a78 <printfmt>
  80081a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80081d:	e9 49 02 00 00       	jmp    800a6b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800822:	56                   	push   %esi
  800823:	68 4e 22 80 00       	push   $0x80224e
  800828:	ff 75 0c             	pushl  0xc(%ebp)
  80082b:	ff 75 08             	pushl  0x8(%ebp)
  80082e:	e8 45 02 00 00       	call   800a78 <printfmt>
  800833:	83 c4 10             	add    $0x10,%esp
			break;
  800836:	e9 30 02 00 00       	jmp    800a6b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80083b:	8b 45 14             	mov    0x14(%ebp),%eax
  80083e:	83 c0 04             	add    $0x4,%eax
  800841:	89 45 14             	mov    %eax,0x14(%ebp)
  800844:	8b 45 14             	mov    0x14(%ebp),%eax
  800847:	83 e8 04             	sub    $0x4,%eax
  80084a:	8b 30                	mov    (%eax),%esi
  80084c:	85 f6                	test   %esi,%esi
  80084e:	75 05                	jne    800855 <vprintfmt+0x1a6>
				p = "(null)";
  800850:	be 51 22 80 00       	mov    $0x802251,%esi
			if (width > 0 && padc != '-')
  800855:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800859:	7e 6d                	jle    8008c8 <vprintfmt+0x219>
  80085b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80085f:	74 67                	je     8008c8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800861:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800864:	83 ec 08             	sub    $0x8,%esp
  800867:	50                   	push   %eax
  800868:	56                   	push   %esi
  800869:	e8 0c 03 00 00       	call   800b7a <strnlen>
  80086e:	83 c4 10             	add    $0x10,%esp
  800871:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800874:	eb 16                	jmp    80088c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800876:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80087a:	83 ec 08             	sub    $0x8,%esp
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	50                   	push   %eax
  800881:	8b 45 08             	mov    0x8(%ebp),%eax
  800884:	ff d0                	call   *%eax
  800886:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800889:	ff 4d e4             	decl   -0x1c(%ebp)
  80088c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800890:	7f e4                	jg     800876 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800892:	eb 34                	jmp    8008c8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800894:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800898:	74 1c                	je     8008b6 <vprintfmt+0x207>
  80089a:	83 fb 1f             	cmp    $0x1f,%ebx
  80089d:	7e 05                	jle    8008a4 <vprintfmt+0x1f5>
  80089f:	83 fb 7e             	cmp    $0x7e,%ebx
  8008a2:	7e 12                	jle    8008b6 <vprintfmt+0x207>
					putch('?', putdat);
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	ff 75 0c             	pushl  0xc(%ebp)
  8008aa:	6a 3f                	push   $0x3f
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	ff d0                	call   *%eax
  8008b1:	83 c4 10             	add    $0x10,%esp
  8008b4:	eb 0f                	jmp    8008c5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008b6:	83 ec 08             	sub    $0x8,%esp
  8008b9:	ff 75 0c             	pushl  0xc(%ebp)
  8008bc:	53                   	push   %ebx
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	ff d0                	call   *%eax
  8008c2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008c5:	ff 4d e4             	decl   -0x1c(%ebp)
  8008c8:	89 f0                	mov    %esi,%eax
  8008ca:	8d 70 01             	lea    0x1(%eax),%esi
  8008cd:	8a 00                	mov    (%eax),%al
  8008cf:	0f be d8             	movsbl %al,%ebx
  8008d2:	85 db                	test   %ebx,%ebx
  8008d4:	74 24                	je     8008fa <vprintfmt+0x24b>
  8008d6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008da:	78 b8                	js     800894 <vprintfmt+0x1e5>
  8008dc:	ff 4d e0             	decl   -0x20(%ebp)
  8008df:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008e3:	79 af                	jns    800894 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008e5:	eb 13                	jmp    8008fa <vprintfmt+0x24b>
				putch(' ', putdat);
  8008e7:	83 ec 08             	sub    $0x8,%esp
  8008ea:	ff 75 0c             	pushl  0xc(%ebp)
  8008ed:	6a 20                	push   $0x20
  8008ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f2:	ff d0                	call   *%eax
  8008f4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008f7:	ff 4d e4             	decl   -0x1c(%ebp)
  8008fa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008fe:	7f e7                	jg     8008e7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800900:	e9 66 01 00 00       	jmp    800a6b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800905:	83 ec 08             	sub    $0x8,%esp
  800908:	ff 75 e8             	pushl  -0x18(%ebp)
  80090b:	8d 45 14             	lea    0x14(%ebp),%eax
  80090e:	50                   	push   %eax
  80090f:	e8 3c fd ff ff       	call   800650 <getint>
  800914:	83 c4 10             	add    $0x10,%esp
  800917:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80091a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80091d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800920:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800923:	85 d2                	test   %edx,%edx
  800925:	79 23                	jns    80094a <vprintfmt+0x29b>
				putch('-', putdat);
  800927:	83 ec 08             	sub    $0x8,%esp
  80092a:	ff 75 0c             	pushl  0xc(%ebp)
  80092d:	6a 2d                	push   $0x2d
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	ff d0                	call   *%eax
  800934:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800937:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80093d:	f7 d8                	neg    %eax
  80093f:	83 d2 00             	adc    $0x0,%edx
  800942:	f7 da                	neg    %edx
  800944:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800947:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80094a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800951:	e9 bc 00 00 00       	jmp    800a12 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800956:	83 ec 08             	sub    $0x8,%esp
  800959:	ff 75 e8             	pushl  -0x18(%ebp)
  80095c:	8d 45 14             	lea    0x14(%ebp),%eax
  80095f:	50                   	push   %eax
  800960:	e8 84 fc ff ff       	call   8005e9 <getuint>
  800965:	83 c4 10             	add    $0x10,%esp
  800968:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80096e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800975:	e9 98 00 00 00       	jmp    800a12 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80097a:	83 ec 08             	sub    $0x8,%esp
  80097d:	ff 75 0c             	pushl  0xc(%ebp)
  800980:	6a 58                	push   $0x58
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	ff d0                	call   *%eax
  800987:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80098a:	83 ec 08             	sub    $0x8,%esp
  80098d:	ff 75 0c             	pushl  0xc(%ebp)
  800990:	6a 58                	push   $0x58
  800992:	8b 45 08             	mov    0x8(%ebp),%eax
  800995:	ff d0                	call   *%eax
  800997:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80099a:	83 ec 08             	sub    $0x8,%esp
  80099d:	ff 75 0c             	pushl  0xc(%ebp)
  8009a0:	6a 58                	push   $0x58
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	ff d0                	call   *%eax
  8009a7:	83 c4 10             	add    $0x10,%esp
			break;
  8009aa:	e9 bc 00 00 00       	jmp    800a6b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009af:	83 ec 08             	sub    $0x8,%esp
  8009b2:	ff 75 0c             	pushl  0xc(%ebp)
  8009b5:	6a 30                	push   $0x30
  8009b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ba:	ff d0                	call   *%eax
  8009bc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009bf:	83 ec 08             	sub    $0x8,%esp
  8009c2:	ff 75 0c             	pushl  0xc(%ebp)
  8009c5:	6a 78                	push   $0x78
  8009c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ca:	ff d0                	call   *%eax
  8009cc:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d2:	83 c0 04             	add    $0x4,%eax
  8009d5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009db:	83 e8 04             	sub    $0x4,%eax
  8009de:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009ea:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009f1:	eb 1f                	jmp    800a12 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009f3:	83 ec 08             	sub    $0x8,%esp
  8009f6:	ff 75 e8             	pushl  -0x18(%ebp)
  8009f9:	8d 45 14             	lea    0x14(%ebp),%eax
  8009fc:	50                   	push   %eax
  8009fd:	e8 e7 fb ff ff       	call   8005e9 <getuint>
  800a02:	83 c4 10             	add    $0x10,%esp
  800a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a08:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a0b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a12:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a16:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a19:	83 ec 04             	sub    $0x4,%esp
  800a1c:	52                   	push   %edx
  800a1d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a20:	50                   	push   %eax
  800a21:	ff 75 f4             	pushl  -0xc(%ebp)
  800a24:	ff 75 f0             	pushl  -0x10(%ebp)
  800a27:	ff 75 0c             	pushl  0xc(%ebp)
  800a2a:	ff 75 08             	pushl  0x8(%ebp)
  800a2d:	e8 00 fb ff ff       	call   800532 <printnum>
  800a32:	83 c4 20             	add    $0x20,%esp
			break;
  800a35:	eb 34                	jmp    800a6b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a37:	83 ec 08             	sub    $0x8,%esp
  800a3a:	ff 75 0c             	pushl  0xc(%ebp)
  800a3d:	53                   	push   %ebx
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	ff d0                	call   *%eax
  800a43:	83 c4 10             	add    $0x10,%esp
			break;
  800a46:	eb 23                	jmp    800a6b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a48:	83 ec 08             	sub    $0x8,%esp
  800a4b:	ff 75 0c             	pushl  0xc(%ebp)
  800a4e:	6a 25                	push   $0x25
  800a50:	8b 45 08             	mov    0x8(%ebp),%eax
  800a53:	ff d0                	call   *%eax
  800a55:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a58:	ff 4d 10             	decl   0x10(%ebp)
  800a5b:	eb 03                	jmp    800a60 <vprintfmt+0x3b1>
  800a5d:	ff 4d 10             	decl   0x10(%ebp)
  800a60:	8b 45 10             	mov    0x10(%ebp),%eax
  800a63:	48                   	dec    %eax
  800a64:	8a 00                	mov    (%eax),%al
  800a66:	3c 25                	cmp    $0x25,%al
  800a68:	75 f3                	jne    800a5d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a6a:	90                   	nop
		}
	}
  800a6b:	e9 47 fc ff ff       	jmp    8006b7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a70:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a71:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a74:	5b                   	pop    %ebx
  800a75:	5e                   	pop    %esi
  800a76:	5d                   	pop    %ebp
  800a77:	c3                   	ret    

00800a78 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a78:	55                   	push   %ebp
  800a79:	89 e5                	mov    %esp,%ebp
  800a7b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a7e:	8d 45 10             	lea    0x10(%ebp),%eax
  800a81:	83 c0 04             	add    $0x4,%eax
  800a84:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a87:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a8d:	50                   	push   %eax
  800a8e:	ff 75 0c             	pushl  0xc(%ebp)
  800a91:	ff 75 08             	pushl  0x8(%ebp)
  800a94:	e8 16 fc ff ff       	call   8006af <vprintfmt>
  800a99:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a9c:	90                   	nop
  800a9d:	c9                   	leave  
  800a9e:	c3                   	ret    

00800a9f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a9f:	55                   	push   %ebp
  800aa0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800aa2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa5:	8b 40 08             	mov    0x8(%eax),%eax
  800aa8:	8d 50 01             	lea    0x1(%eax),%edx
  800aab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aae:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab4:	8b 10                	mov    (%eax),%edx
  800ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab9:	8b 40 04             	mov    0x4(%eax),%eax
  800abc:	39 c2                	cmp    %eax,%edx
  800abe:	73 12                	jae    800ad2 <sprintputch+0x33>
		*b->buf++ = ch;
  800ac0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac3:	8b 00                	mov    (%eax),%eax
  800ac5:	8d 48 01             	lea    0x1(%eax),%ecx
  800ac8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800acb:	89 0a                	mov    %ecx,(%edx)
  800acd:	8b 55 08             	mov    0x8(%ebp),%edx
  800ad0:	88 10                	mov    %dl,(%eax)
}
  800ad2:	90                   	nop
  800ad3:	5d                   	pop    %ebp
  800ad4:	c3                   	ret    

00800ad5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ad5:	55                   	push   %ebp
  800ad6:	89 e5                	mov    %esp,%ebp
  800ad8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ae1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	01 d0                	add    %edx,%eax
  800aec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800af6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800afa:	74 06                	je     800b02 <vsnprintf+0x2d>
  800afc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b00:	7f 07                	jg     800b09 <vsnprintf+0x34>
		return -E_INVAL;
  800b02:	b8 03 00 00 00       	mov    $0x3,%eax
  800b07:	eb 20                	jmp    800b29 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b09:	ff 75 14             	pushl  0x14(%ebp)
  800b0c:	ff 75 10             	pushl  0x10(%ebp)
  800b0f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b12:	50                   	push   %eax
  800b13:	68 9f 0a 80 00       	push   $0x800a9f
  800b18:	e8 92 fb ff ff       	call   8006af <vprintfmt>
  800b1d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b20:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b23:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b26:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b29:	c9                   	leave  
  800b2a:	c3                   	ret    

00800b2b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b2b:	55                   	push   %ebp
  800b2c:	89 e5                	mov    %esp,%ebp
  800b2e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b31:	8d 45 10             	lea    0x10(%ebp),%eax
  800b34:	83 c0 04             	add    $0x4,%eax
  800b37:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b40:	50                   	push   %eax
  800b41:	ff 75 0c             	pushl  0xc(%ebp)
  800b44:	ff 75 08             	pushl  0x8(%ebp)
  800b47:	e8 89 ff ff ff       	call   800ad5 <vsnprintf>
  800b4c:	83 c4 10             	add    $0x10,%esp
  800b4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b52:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b55:	c9                   	leave  
  800b56:	c3                   	ret    

00800b57 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b57:	55                   	push   %ebp
  800b58:	89 e5                	mov    %esp,%ebp
  800b5a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b5d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b64:	eb 06                	jmp    800b6c <strlen+0x15>
		n++;
  800b66:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b69:	ff 45 08             	incl   0x8(%ebp)
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	8a 00                	mov    (%eax),%al
  800b71:	84 c0                	test   %al,%al
  800b73:	75 f1                	jne    800b66 <strlen+0xf>
		n++;
	return n;
  800b75:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b78:	c9                   	leave  
  800b79:	c3                   	ret    

00800b7a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b7a:	55                   	push   %ebp
  800b7b:	89 e5                	mov    %esp,%ebp
  800b7d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b80:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b87:	eb 09                	jmp    800b92 <strnlen+0x18>
		n++;
  800b89:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b8c:	ff 45 08             	incl   0x8(%ebp)
  800b8f:	ff 4d 0c             	decl   0xc(%ebp)
  800b92:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b96:	74 09                	je     800ba1 <strnlen+0x27>
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	8a 00                	mov    (%eax),%al
  800b9d:	84 c0                	test   %al,%al
  800b9f:	75 e8                	jne    800b89 <strnlen+0xf>
		n++;
	return n;
  800ba1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba4:	c9                   	leave  
  800ba5:	c3                   	ret    

00800ba6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ba6:	55                   	push   %ebp
  800ba7:	89 e5                	mov    %esp,%ebp
  800ba9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bb2:	90                   	nop
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	8d 50 01             	lea    0x1(%eax),%edx
  800bb9:	89 55 08             	mov    %edx,0x8(%ebp)
  800bbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bc5:	8a 12                	mov    (%edx),%dl
  800bc7:	88 10                	mov    %dl,(%eax)
  800bc9:	8a 00                	mov    (%eax),%al
  800bcb:	84 c0                	test   %al,%al
  800bcd:	75 e4                	jne    800bb3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd2:	c9                   	leave  
  800bd3:	c3                   	ret    

00800bd4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bd4:	55                   	push   %ebp
  800bd5:	89 e5                	mov    %esp,%ebp
  800bd7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800be0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800be7:	eb 1f                	jmp    800c08 <strncpy+0x34>
		*dst++ = *src;
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	8d 50 01             	lea    0x1(%eax),%edx
  800bef:	89 55 08             	mov    %edx,0x8(%ebp)
  800bf2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf5:	8a 12                	mov    (%edx),%dl
  800bf7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfc:	8a 00                	mov    (%eax),%al
  800bfe:	84 c0                	test   %al,%al
  800c00:	74 03                	je     800c05 <strncpy+0x31>
			src++;
  800c02:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c05:	ff 45 fc             	incl   -0x4(%ebp)
  800c08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c0e:	72 d9                	jb     800be9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c10:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c13:	c9                   	leave  
  800c14:	c3                   	ret    

00800c15 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c15:	55                   	push   %ebp
  800c16:	89 e5                	mov    %esp,%ebp
  800c18:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c21:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c25:	74 30                	je     800c57 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c27:	eb 16                	jmp    800c3f <strlcpy+0x2a>
			*dst++ = *src++;
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	8d 50 01             	lea    0x1(%eax),%edx
  800c2f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c32:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c35:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c38:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c3b:	8a 12                	mov    (%edx),%dl
  800c3d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c3f:	ff 4d 10             	decl   0x10(%ebp)
  800c42:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c46:	74 09                	je     800c51 <strlcpy+0x3c>
  800c48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4b:	8a 00                	mov    (%eax),%al
  800c4d:	84 c0                	test   %al,%al
  800c4f:	75 d8                	jne    800c29 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c57:	8b 55 08             	mov    0x8(%ebp),%edx
  800c5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c5d:	29 c2                	sub    %eax,%edx
  800c5f:	89 d0                	mov    %edx,%eax
}
  800c61:	c9                   	leave  
  800c62:	c3                   	ret    

00800c63 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c63:	55                   	push   %ebp
  800c64:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c66:	eb 06                	jmp    800c6e <strcmp+0xb>
		p++, q++;
  800c68:	ff 45 08             	incl   0x8(%ebp)
  800c6b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	8a 00                	mov    (%eax),%al
  800c73:	84 c0                	test   %al,%al
  800c75:	74 0e                	je     800c85 <strcmp+0x22>
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	8a 10                	mov    (%eax),%dl
  800c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	38 c2                	cmp    %al,%dl
  800c83:	74 e3                	je     800c68 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	8a 00                	mov    (%eax),%al
  800c8a:	0f b6 d0             	movzbl %al,%edx
  800c8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	0f b6 c0             	movzbl %al,%eax
  800c95:	29 c2                	sub    %eax,%edx
  800c97:	89 d0                	mov    %edx,%eax
}
  800c99:	5d                   	pop    %ebp
  800c9a:	c3                   	ret    

00800c9b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c9b:	55                   	push   %ebp
  800c9c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c9e:	eb 09                	jmp    800ca9 <strncmp+0xe>
		n--, p++, q++;
  800ca0:	ff 4d 10             	decl   0x10(%ebp)
  800ca3:	ff 45 08             	incl   0x8(%ebp)
  800ca6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ca9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cad:	74 17                	je     800cc6 <strncmp+0x2b>
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	84 c0                	test   %al,%al
  800cb6:	74 0e                	je     800cc6 <strncmp+0x2b>
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8a 10                	mov    (%eax),%dl
  800cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	38 c2                	cmp    %al,%dl
  800cc4:	74 da                	je     800ca0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cca:	75 07                	jne    800cd3 <strncmp+0x38>
		return 0;
  800ccc:	b8 00 00 00 00       	mov    $0x0,%eax
  800cd1:	eb 14                	jmp    800ce7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	8a 00                	mov    (%eax),%al
  800cd8:	0f b6 d0             	movzbl %al,%edx
  800cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	0f b6 c0             	movzbl %al,%eax
  800ce3:	29 c2                	sub    %eax,%edx
  800ce5:	89 d0                	mov    %edx,%eax
}
  800ce7:	5d                   	pop    %ebp
  800ce8:	c3                   	ret    

00800ce9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ce9:	55                   	push   %ebp
  800cea:	89 e5                	mov    %esp,%ebp
  800cec:	83 ec 04             	sub    $0x4,%esp
  800cef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cf5:	eb 12                	jmp    800d09 <strchr+0x20>
		if (*s == c)
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cff:	75 05                	jne    800d06 <strchr+0x1d>
			return (char *) s;
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	eb 11                	jmp    800d17 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d06:	ff 45 08             	incl   0x8(%ebp)
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8a 00                	mov    (%eax),%al
  800d0e:	84 c0                	test   %al,%al
  800d10:	75 e5                	jne    800cf7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d17:	c9                   	leave  
  800d18:	c3                   	ret    

00800d19 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d19:	55                   	push   %ebp
  800d1a:	89 e5                	mov    %esp,%ebp
  800d1c:	83 ec 04             	sub    $0x4,%esp
  800d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d22:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d25:	eb 0d                	jmp    800d34 <strfind+0x1b>
		if (*s == c)
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	8a 00                	mov    (%eax),%al
  800d2c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d2f:	74 0e                	je     800d3f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d31:	ff 45 08             	incl   0x8(%ebp)
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	8a 00                	mov    (%eax),%al
  800d39:	84 c0                	test   %al,%al
  800d3b:	75 ea                	jne    800d27 <strfind+0xe>
  800d3d:	eb 01                	jmp    800d40 <strfind+0x27>
		if (*s == c)
			break;
  800d3f:	90                   	nop
	return (char *) s;
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d43:	c9                   	leave  
  800d44:	c3                   	ret    

00800d45 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d45:	55                   	push   %ebp
  800d46:	89 e5                	mov    %esp,%ebp
  800d48:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d51:	8b 45 10             	mov    0x10(%ebp),%eax
  800d54:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d57:	eb 0e                	jmp    800d67 <memset+0x22>
		*p++ = c;
  800d59:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5c:	8d 50 01             	lea    0x1(%eax),%edx
  800d5f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d62:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d65:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d67:	ff 4d f8             	decl   -0x8(%ebp)
  800d6a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d6e:	79 e9                	jns    800d59 <memset+0x14>
		*p++ = c;

	return v;
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d73:	c9                   	leave  
  800d74:	c3                   	ret    

00800d75 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d75:	55                   	push   %ebp
  800d76:	89 e5                	mov    %esp,%ebp
  800d78:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d87:	eb 16                	jmp    800d9f <memcpy+0x2a>
		*d++ = *s++;
  800d89:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8c:	8d 50 01             	lea    0x1(%eax),%edx
  800d8f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d92:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d95:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d98:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d9b:	8a 12                	mov    (%edx),%dl
  800d9d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800da2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800da5:	89 55 10             	mov    %edx,0x10(%ebp)
  800da8:	85 c0                	test   %eax,%eax
  800daa:	75 dd                	jne    800d89 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800daf:	c9                   	leave  
  800db0:	c3                   	ret    

00800db1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800db1:	55                   	push   %ebp
  800db2:	89 e5                	mov    %esp,%ebp
  800db4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800db7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dc9:	73 50                	jae    800e1b <memmove+0x6a>
  800dcb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dce:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd1:	01 d0                	add    %edx,%eax
  800dd3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd6:	76 43                	jbe    800e1b <memmove+0x6a>
		s += n;
  800dd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dde:	8b 45 10             	mov    0x10(%ebp),%eax
  800de1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800de4:	eb 10                	jmp    800df6 <memmove+0x45>
			*--d = *--s;
  800de6:	ff 4d f8             	decl   -0x8(%ebp)
  800de9:	ff 4d fc             	decl   -0x4(%ebp)
  800dec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800def:	8a 10                	mov    (%eax),%dl
  800df1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800df6:	8b 45 10             	mov    0x10(%ebp),%eax
  800df9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfc:	89 55 10             	mov    %edx,0x10(%ebp)
  800dff:	85 c0                	test   %eax,%eax
  800e01:	75 e3                	jne    800de6 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e03:	eb 23                	jmp    800e28 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e05:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e08:	8d 50 01             	lea    0x1(%eax),%edx
  800e0b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e0e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e11:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e14:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e17:	8a 12                	mov    (%edx),%dl
  800e19:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e21:	89 55 10             	mov    %edx,0x10(%ebp)
  800e24:	85 c0                	test   %eax,%eax
  800e26:	75 dd                	jne    800e05 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e2b:	c9                   	leave  
  800e2c:	c3                   	ret    

00800e2d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e2d:	55                   	push   %ebp
  800e2e:	89 e5                	mov    %esp,%ebp
  800e30:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e33:	8b 45 08             	mov    0x8(%ebp),%eax
  800e36:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e3f:	eb 2a                	jmp    800e6b <memcmp+0x3e>
		if (*s1 != *s2)
  800e41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e44:	8a 10                	mov    (%eax),%dl
  800e46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e49:	8a 00                	mov    (%eax),%al
  800e4b:	38 c2                	cmp    %al,%dl
  800e4d:	74 16                	je     800e65 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e52:	8a 00                	mov    (%eax),%al
  800e54:	0f b6 d0             	movzbl %al,%edx
  800e57:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5a:	8a 00                	mov    (%eax),%al
  800e5c:	0f b6 c0             	movzbl %al,%eax
  800e5f:	29 c2                	sub    %eax,%edx
  800e61:	89 d0                	mov    %edx,%eax
  800e63:	eb 18                	jmp    800e7d <memcmp+0x50>
		s1++, s2++;
  800e65:	ff 45 fc             	incl   -0x4(%ebp)
  800e68:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e71:	89 55 10             	mov    %edx,0x10(%ebp)
  800e74:	85 c0                	test   %eax,%eax
  800e76:	75 c9                	jne    800e41 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e78:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e7d:	c9                   	leave  
  800e7e:	c3                   	ret    

00800e7f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e7f:	55                   	push   %ebp
  800e80:	89 e5                	mov    %esp,%ebp
  800e82:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e85:	8b 55 08             	mov    0x8(%ebp),%edx
  800e88:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8b:	01 d0                	add    %edx,%eax
  800e8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e90:	eb 15                	jmp    800ea7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	0f b6 d0             	movzbl %al,%edx
  800e9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9d:	0f b6 c0             	movzbl %al,%eax
  800ea0:	39 c2                	cmp    %eax,%edx
  800ea2:	74 0d                	je     800eb1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ea4:	ff 45 08             	incl   0x8(%ebp)
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ead:	72 e3                	jb     800e92 <memfind+0x13>
  800eaf:	eb 01                	jmp    800eb2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800eb1:	90                   	nop
	return (void *) s;
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb5:	c9                   	leave  
  800eb6:	c3                   	ret    

00800eb7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eb7:	55                   	push   %ebp
  800eb8:	89 e5                	mov    %esp,%ebp
  800eba:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ebd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ec4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ecb:	eb 03                	jmp    800ed0 <strtol+0x19>
		s++;
  800ecd:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	8a 00                	mov    (%eax),%al
  800ed5:	3c 20                	cmp    $0x20,%al
  800ed7:	74 f4                	je     800ecd <strtol+0x16>
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	3c 09                	cmp    $0x9,%al
  800ee0:	74 eb                	je     800ecd <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	8a 00                	mov    (%eax),%al
  800ee7:	3c 2b                	cmp    $0x2b,%al
  800ee9:	75 05                	jne    800ef0 <strtol+0x39>
		s++;
  800eeb:	ff 45 08             	incl   0x8(%ebp)
  800eee:	eb 13                	jmp    800f03 <strtol+0x4c>
	else if (*s == '-')
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	3c 2d                	cmp    $0x2d,%al
  800ef7:	75 0a                	jne    800f03 <strtol+0x4c>
		s++, neg = 1;
  800ef9:	ff 45 08             	incl   0x8(%ebp)
  800efc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f03:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f07:	74 06                	je     800f0f <strtol+0x58>
  800f09:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f0d:	75 20                	jne    800f2f <strtol+0x78>
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	3c 30                	cmp    $0x30,%al
  800f16:	75 17                	jne    800f2f <strtol+0x78>
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	40                   	inc    %eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	3c 78                	cmp    $0x78,%al
  800f20:	75 0d                	jne    800f2f <strtol+0x78>
		s += 2, base = 16;
  800f22:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f26:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f2d:	eb 28                	jmp    800f57 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f2f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f33:	75 15                	jne    800f4a <strtol+0x93>
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	3c 30                	cmp    $0x30,%al
  800f3c:	75 0c                	jne    800f4a <strtol+0x93>
		s++, base = 8;
  800f3e:	ff 45 08             	incl   0x8(%ebp)
  800f41:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f48:	eb 0d                	jmp    800f57 <strtol+0xa0>
	else if (base == 0)
  800f4a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4e:	75 07                	jne    800f57 <strtol+0xa0>
		base = 10;
  800f50:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	3c 2f                	cmp    $0x2f,%al
  800f5e:	7e 19                	jle    800f79 <strtol+0xc2>
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	3c 39                	cmp    $0x39,%al
  800f67:	7f 10                	jg     800f79 <strtol+0xc2>
			dig = *s - '0';
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8a 00                	mov    (%eax),%al
  800f6e:	0f be c0             	movsbl %al,%eax
  800f71:	83 e8 30             	sub    $0x30,%eax
  800f74:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f77:	eb 42                	jmp    800fbb <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	3c 60                	cmp    $0x60,%al
  800f80:	7e 19                	jle    800f9b <strtol+0xe4>
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	3c 7a                	cmp    $0x7a,%al
  800f89:	7f 10                	jg     800f9b <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	0f be c0             	movsbl %al,%eax
  800f93:	83 e8 57             	sub    $0x57,%eax
  800f96:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f99:	eb 20                	jmp    800fbb <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	8a 00                	mov    (%eax),%al
  800fa0:	3c 40                	cmp    $0x40,%al
  800fa2:	7e 39                	jle    800fdd <strtol+0x126>
  800fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	3c 5a                	cmp    $0x5a,%al
  800fab:	7f 30                	jg     800fdd <strtol+0x126>
			dig = *s - 'A' + 10;
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	8a 00                	mov    (%eax),%al
  800fb2:	0f be c0             	movsbl %al,%eax
  800fb5:	83 e8 37             	sub    $0x37,%eax
  800fb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fbe:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fc1:	7d 19                	jge    800fdc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fc3:	ff 45 08             	incl   0x8(%ebp)
  800fc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc9:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fcd:	89 c2                	mov    %eax,%edx
  800fcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd2:	01 d0                	add    %edx,%eax
  800fd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fd7:	e9 7b ff ff ff       	jmp    800f57 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fdc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fdd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe1:	74 08                	je     800feb <strtol+0x134>
		*endptr = (char *) s;
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	8b 55 08             	mov    0x8(%ebp),%edx
  800fe9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800feb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fef:	74 07                	je     800ff8 <strtol+0x141>
  800ff1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff4:	f7 d8                	neg    %eax
  800ff6:	eb 03                	jmp    800ffb <strtol+0x144>
  800ff8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ffb:	c9                   	leave  
  800ffc:	c3                   	ret    

00800ffd <ltostr>:

void
ltostr(long value, char *str)
{
  800ffd:	55                   	push   %ebp
  800ffe:	89 e5                	mov    %esp,%ebp
  801000:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801003:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80100a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801011:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801015:	79 13                	jns    80102a <ltostr+0x2d>
	{
		neg = 1;
  801017:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80101e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801021:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801024:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801027:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801032:	99                   	cltd   
  801033:	f7 f9                	idiv   %ecx
  801035:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801038:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103b:	8d 50 01             	lea    0x1(%eax),%edx
  80103e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801041:	89 c2                	mov    %eax,%edx
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	01 d0                	add    %edx,%eax
  801048:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80104b:	83 c2 30             	add    $0x30,%edx
  80104e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801050:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801053:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801058:	f7 e9                	imul   %ecx
  80105a:	c1 fa 02             	sar    $0x2,%edx
  80105d:	89 c8                	mov    %ecx,%eax
  80105f:	c1 f8 1f             	sar    $0x1f,%eax
  801062:	29 c2                	sub    %eax,%edx
  801064:	89 d0                	mov    %edx,%eax
  801066:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801069:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80106c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801071:	f7 e9                	imul   %ecx
  801073:	c1 fa 02             	sar    $0x2,%edx
  801076:	89 c8                	mov    %ecx,%eax
  801078:	c1 f8 1f             	sar    $0x1f,%eax
  80107b:	29 c2                	sub    %eax,%edx
  80107d:	89 d0                	mov    %edx,%eax
  80107f:	c1 e0 02             	shl    $0x2,%eax
  801082:	01 d0                	add    %edx,%eax
  801084:	01 c0                	add    %eax,%eax
  801086:	29 c1                	sub    %eax,%ecx
  801088:	89 ca                	mov    %ecx,%edx
  80108a:	85 d2                	test   %edx,%edx
  80108c:	75 9c                	jne    80102a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80108e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801095:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801098:	48                   	dec    %eax
  801099:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80109c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010a0:	74 3d                	je     8010df <ltostr+0xe2>
		start = 1 ;
  8010a2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010a9:	eb 34                	jmp    8010df <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b1:	01 d0                	add    %edx,%eax
  8010b3:	8a 00                	mov    (%eax),%al
  8010b5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010be:	01 c2                	add    %eax,%edx
  8010c0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c6:	01 c8                	add    %ecx,%eax
  8010c8:	8a 00                	mov    (%eax),%al
  8010ca:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010cc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d2:	01 c2                	add    %eax,%edx
  8010d4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010d7:	88 02                	mov    %al,(%edx)
		start++ ;
  8010d9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010dc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010e5:	7c c4                	jl     8010ab <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010e7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ed:	01 d0                	add    %edx,%eax
  8010ef:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010f2:	90                   	nop
  8010f3:	c9                   	leave  
  8010f4:	c3                   	ret    

008010f5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010f5:	55                   	push   %ebp
  8010f6:	89 e5                	mov    %esp,%ebp
  8010f8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010fb:	ff 75 08             	pushl  0x8(%ebp)
  8010fe:	e8 54 fa ff ff       	call   800b57 <strlen>
  801103:	83 c4 04             	add    $0x4,%esp
  801106:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801109:	ff 75 0c             	pushl  0xc(%ebp)
  80110c:	e8 46 fa ff ff       	call   800b57 <strlen>
  801111:	83 c4 04             	add    $0x4,%esp
  801114:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801117:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80111e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801125:	eb 17                	jmp    80113e <strcconcat+0x49>
		final[s] = str1[s] ;
  801127:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80112a:	8b 45 10             	mov    0x10(%ebp),%eax
  80112d:	01 c2                	add    %eax,%edx
  80112f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	01 c8                	add    %ecx,%eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80113b:	ff 45 fc             	incl   -0x4(%ebp)
  80113e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801141:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801144:	7c e1                	jl     801127 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801146:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80114d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801154:	eb 1f                	jmp    801175 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801156:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801159:	8d 50 01             	lea    0x1(%eax),%edx
  80115c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80115f:	89 c2                	mov    %eax,%edx
  801161:	8b 45 10             	mov    0x10(%ebp),%eax
  801164:	01 c2                	add    %eax,%edx
  801166:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116c:	01 c8                	add    %ecx,%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801172:	ff 45 f8             	incl   -0x8(%ebp)
  801175:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801178:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80117b:	7c d9                	jl     801156 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80117d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801180:	8b 45 10             	mov    0x10(%ebp),%eax
  801183:	01 d0                	add    %edx,%eax
  801185:	c6 00 00             	movb   $0x0,(%eax)
}
  801188:	90                   	nop
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80118e:	8b 45 14             	mov    0x14(%ebp),%eax
  801191:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801197:	8b 45 14             	mov    0x14(%ebp),%eax
  80119a:	8b 00                	mov    (%eax),%eax
  80119c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a6:	01 d0                	add    %edx,%eax
  8011a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ae:	eb 0c                	jmp    8011bc <strsplit+0x31>
			*string++ = 0;
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	8d 50 01             	lea    0x1(%eax),%edx
  8011b6:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	8a 00                	mov    (%eax),%al
  8011c1:	84 c0                	test   %al,%al
  8011c3:	74 18                	je     8011dd <strsplit+0x52>
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	0f be c0             	movsbl %al,%eax
  8011cd:	50                   	push   %eax
  8011ce:	ff 75 0c             	pushl  0xc(%ebp)
  8011d1:	e8 13 fb ff ff       	call   800ce9 <strchr>
  8011d6:	83 c4 08             	add    $0x8,%esp
  8011d9:	85 c0                	test   %eax,%eax
  8011db:	75 d3                	jne    8011b0 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e0:	8a 00                	mov    (%eax),%al
  8011e2:	84 c0                	test   %al,%al
  8011e4:	74 5a                	je     801240 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e9:	8b 00                	mov    (%eax),%eax
  8011eb:	83 f8 0f             	cmp    $0xf,%eax
  8011ee:	75 07                	jne    8011f7 <strsplit+0x6c>
		{
			return 0;
  8011f0:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f5:	eb 66                	jmp    80125d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011fa:	8b 00                	mov    (%eax),%eax
  8011fc:	8d 48 01             	lea    0x1(%eax),%ecx
  8011ff:	8b 55 14             	mov    0x14(%ebp),%edx
  801202:	89 0a                	mov    %ecx,(%edx)
  801204:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80120b:	8b 45 10             	mov    0x10(%ebp),%eax
  80120e:	01 c2                	add    %eax,%edx
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801215:	eb 03                	jmp    80121a <strsplit+0x8f>
			string++;
  801217:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	84 c0                	test   %al,%al
  801221:	74 8b                	je     8011ae <strsplit+0x23>
  801223:	8b 45 08             	mov    0x8(%ebp),%eax
  801226:	8a 00                	mov    (%eax),%al
  801228:	0f be c0             	movsbl %al,%eax
  80122b:	50                   	push   %eax
  80122c:	ff 75 0c             	pushl  0xc(%ebp)
  80122f:	e8 b5 fa ff ff       	call   800ce9 <strchr>
  801234:	83 c4 08             	add    $0x8,%esp
  801237:	85 c0                	test   %eax,%eax
  801239:	74 dc                	je     801217 <strsplit+0x8c>
			string++;
	}
  80123b:	e9 6e ff ff ff       	jmp    8011ae <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801240:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801241:	8b 45 14             	mov    0x14(%ebp),%eax
  801244:	8b 00                	mov    (%eax),%eax
  801246:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80124d:	8b 45 10             	mov    0x10(%ebp),%eax
  801250:	01 d0                	add    %edx,%eax
  801252:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801258:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
  801262:	83 ec 18             	sub    $0x18,%esp
  801265:	8b 45 10             	mov    0x10(%ebp),%eax
  801268:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80126b:	83 ec 04             	sub    $0x4,%esp
  80126e:	68 b0 23 80 00       	push   $0x8023b0
  801273:	6a 17                	push   $0x17
  801275:	68 cf 23 80 00       	push   $0x8023cf
  80127a:	e8 a2 ef ff ff       	call   800221 <_panic>

0080127f <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80127f:	55                   	push   %ebp
  801280:	89 e5                	mov    %esp,%ebp
  801282:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801285:	83 ec 04             	sub    $0x4,%esp
  801288:	68 db 23 80 00       	push   $0x8023db
  80128d:	6a 2f                	push   $0x2f
  80128f:	68 cf 23 80 00       	push   $0x8023cf
  801294:	e8 88 ef ff ff       	call   800221 <_panic>

00801299 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
  80129c:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80129f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8012a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8012a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012ac:	01 d0                	add    %edx,%eax
  8012ae:	48                   	dec    %eax
  8012af:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8012b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8012b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8012ba:	f7 75 ec             	divl   -0x14(%ebp)
  8012bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8012c0:	29 d0                	sub    %edx,%eax
  8012c2:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8012c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c8:	c1 e8 0c             	shr    $0xc,%eax
  8012cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8012ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8012d5:	e9 c8 00 00 00       	jmp    8013a2 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8012da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8012e1:	eb 27                	jmp    80130a <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8012e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012e9:	01 c2                	add    %eax,%edx
  8012eb:	89 d0                	mov    %edx,%eax
  8012ed:	01 c0                	add    %eax,%eax
  8012ef:	01 d0                	add    %edx,%eax
  8012f1:	c1 e0 02             	shl    $0x2,%eax
  8012f4:	05 48 30 80 00       	add    $0x803048,%eax
  8012f9:	8b 00                	mov    (%eax),%eax
  8012fb:	85 c0                	test   %eax,%eax
  8012fd:	74 08                	je     801307 <malloc+0x6e>
            	i += j;
  8012ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801302:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801305:	eb 0b                	jmp    801312 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801307:	ff 45 f0             	incl   -0x10(%ebp)
  80130a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80130d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801310:	72 d1                	jb     8012e3 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801312:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801315:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801318:	0f 85 81 00 00 00    	jne    80139f <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80131e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801321:	05 00 00 08 00       	add    $0x80000,%eax
  801326:	c1 e0 0c             	shl    $0xc,%eax
  801329:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80132c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801333:	eb 1f                	jmp    801354 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801335:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801338:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80133b:	01 c2                	add    %eax,%edx
  80133d:	89 d0                	mov    %edx,%eax
  80133f:	01 c0                	add    %eax,%eax
  801341:	01 d0                	add    %edx,%eax
  801343:	c1 e0 02             	shl    $0x2,%eax
  801346:	05 48 30 80 00       	add    $0x803048,%eax
  80134b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801351:	ff 45 f0             	incl   -0x10(%ebp)
  801354:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801357:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80135a:	72 d9                	jb     801335 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80135c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80135f:	89 d0                	mov    %edx,%eax
  801361:	01 c0                	add    %eax,%eax
  801363:	01 d0                	add    %edx,%eax
  801365:	c1 e0 02             	shl    $0x2,%eax
  801368:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80136e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801371:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801373:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801376:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801379:	89 c8                	mov    %ecx,%eax
  80137b:	01 c0                	add    %eax,%eax
  80137d:	01 c8                	add    %ecx,%eax
  80137f:	c1 e0 02             	shl    $0x2,%eax
  801382:	05 44 30 80 00       	add    $0x803044,%eax
  801387:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801389:	83 ec 08             	sub    $0x8,%esp
  80138c:	ff 75 08             	pushl  0x8(%ebp)
  80138f:	ff 75 e0             	pushl  -0x20(%ebp)
  801392:	e8 2b 03 00 00       	call   8016c2 <sys_allocateMem>
  801397:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80139a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80139d:	eb 19                	jmp    8013b8 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80139f:	ff 45 f4             	incl   -0xc(%ebp)
  8013a2:	a1 04 30 80 00       	mov    0x803004,%eax
  8013a7:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8013aa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013ad:	0f 83 27 ff ff ff    	jae    8012da <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8013b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013b8:	c9                   	leave  
  8013b9:	c3                   	ret    

008013ba <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8013ba:	55                   	push   %ebp
  8013bb:	89 e5                	mov    %esp,%ebp
  8013bd:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8013c0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013c4:	0f 84 e5 00 00 00    	je     8014af <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8013d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013d3:	05 00 00 00 80       	add    $0x80000000,%eax
  8013d8:	c1 e8 0c             	shr    $0xc,%eax
  8013db:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8013de:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013e1:	89 d0                	mov    %edx,%eax
  8013e3:	01 c0                	add    %eax,%eax
  8013e5:	01 d0                	add    %edx,%eax
  8013e7:	c1 e0 02             	shl    $0x2,%eax
  8013ea:	05 40 30 80 00       	add    $0x803040,%eax
  8013ef:	8b 00                	mov    (%eax),%eax
  8013f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013f4:	0f 85 b8 00 00 00    	jne    8014b2 <free+0xf8>
  8013fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013fd:	89 d0                	mov    %edx,%eax
  8013ff:	01 c0                	add    %eax,%eax
  801401:	01 d0                	add    %edx,%eax
  801403:	c1 e0 02             	shl    $0x2,%eax
  801406:	05 48 30 80 00       	add    $0x803048,%eax
  80140b:	8b 00                	mov    (%eax),%eax
  80140d:	85 c0                	test   %eax,%eax
  80140f:	0f 84 9d 00 00 00    	je     8014b2 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801415:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801418:	89 d0                	mov    %edx,%eax
  80141a:	01 c0                	add    %eax,%eax
  80141c:	01 d0                	add    %edx,%eax
  80141e:	c1 e0 02             	shl    $0x2,%eax
  801421:	05 44 30 80 00       	add    $0x803044,%eax
  801426:	8b 00                	mov    (%eax),%eax
  801428:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80142b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80142e:	c1 e0 0c             	shl    $0xc,%eax
  801431:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801434:	83 ec 08             	sub    $0x8,%esp
  801437:	ff 75 e4             	pushl  -0x1c(%ebp)
  80143a:	ff 75 f0             	pushl  -0x10(%ebp)
  80143d:	e8 64 02 00 00       	call   8016a6 <sys_freeMem>
  801442:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801445:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80144c:	eb 57                	jmp    8014a5 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80144e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801451:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801454:	01 c2                	add    %eax,%edx
  801456:	89 d0                	mov    %edx,%eax
  801458:	01 c0                	add    %eax,%eax
  80145a:	01 d0                	add    %edx,%eax
  80145c:	c1 e0 02             	shl    $0x2,%eax
  80145f:	05 48 30 80 00       	add    $0x803048,%eax
  801464:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80146a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801470:	01 c2                	add    %eax,%edx
  801472:	89 d0                	mov    %edx,%eax
  801474:	01 c0                	add    %eax,%eax
  801476:	01 d0                	add    %edx,%eax
  801478:	c1 e0 02             	shl    $0x2,%eax
  80147b:	05 40 30 80 00       	add    $0x803040,%eax
  801480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801486:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801489:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80148c:	01 c2                	add    %eax,%edx
  80148e:	89 d0                	mov    %edx,%eax
  801490:	01 c0                	add    %eax,%eax
  801492:	01 d0                	add    %edx,%eax
  801494:	c1 e0 02             	shl    $0x2,%eax
  801497:	05 44 30 80 00       	add    $0x803044,%eax
  80149c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8014a2:	ff 45 f4             	incl   -0xc(%ebp)
  8014a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8014ab:	7c a1                	jl     80144e <free+0x94>
  8014ad:	eb 04                	jmp    8014b3 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8014af:	90                   	nop
  8014b0:	eb 01                	jmp    8014b3 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8014b2:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
  8014b8:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8014bb:	83 ec 04             	sub    $0x4,%esp
  8014be:	68 f8 23 80 00       	push   $0x8023f8
  8014c3:	68 ae 00 00 00       	push   $0xae
  8014c8:	68 cf 23 80 00       	push   $0x8023cf
  8014cd:	e8 4f ed ff ff       	call   800221 <_panic>

008014d2 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
  8014d5:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8014d8:	83 ec 04             	sub    $0x4,%esp
  8014db:	68 18 24 80 00       	push   $0x802418
  8014e0:	68 ca 00 00 00       	push   $0xca
  8014e5:	68 cf 23 80 00       	push   $0x8023cf
  8014ea:	e8 32 ed ff ff       	call   800221 <_panic>

008014ef <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
  8014f2:	57                   	push   %edi
  8014f3:	56                   	push   %esi
  8014f4:	53                   	push   %ebx
  8014f5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801501:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801504:	8b 7d 18             	mov    0x18(%ebp),%edi
  801507:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80150a:	cd 30                	int    $0x30
  80150c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80150f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801512:	83 c4 10             	add    $0x10,%esp
  801515:	5b                   	pop    %ebx
  801516:	5e                   	pop    %esi
  801517:	5f                   	pop    %edi
  801518:	5d                   	pop    %ebp
  801519:	c3                   	ret    

0080151a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
  80151d:	83 ec 04             	sub    $0x4,%esp
  801520:	8b 45 10             	mov    0x10(%ebp),%eax
  801523:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801526:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	52                   	push   %edx
  801532:	ff 75 0c             	pushl  0xc(%ebp)
  801535:	50                   	push   %eax
  801536:	6a 00                	push   $0x0
  801538:	e8 b2 ff ff ff       	call   8014ef <syscall>
  80153d:	83 c4 18             	add    $0x18,%esp
}
  801540:	90                   	nop
  801541:	c9                   	leave  
  801542:	c3                   	ret    

00801543 <sys_cgetc>:

int
sys_cgetc(void)
{
  801543:	55                   	push   %ebp
  801544:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 01                	push   $0x1
  801552:	e8 98 ff ff ff       	call   8014ef <syscall>
  801557:	83 c4 18             	add    $0x18,%esp
}
  80155a:	c9                   	leave  
  80155b:	c3                   	ret    

0080155c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80155c:	55                   	push   %ebp
  80155d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80155f:	8b 45 08             	mov    0x8(%ebp),%eax
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	50                   	push   %eax
  80156b:	6a 05                	push   $0x5
  80156d:	e8 7d ff ff ff       	call   8014ef <syscall>
  801572:	83 c4 18             	add    $0x18,%esp
}
  801575:	c9                   	leave  
  801576:	c3                   	ret    

00801577 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801577:	55                   	push   %ebp
  801578:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 02                	push   $0x2
  801586:	e8 64 ff ff ff       	call   8014ef <syscall>
  80158b:	83 c4 18             	add    $0x18,%esp
}
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 03                	push   $0x3
  80159f:	e8 4b ff ff ff       	call   8014ef <syscall>
  8015a4:	83 c4 18             	add    $0x18,%esp
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 04                	push   $0x4
  8015b8:	e8 32 ff ff ff       	call   8014ef <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
}
  8015c0:	c9                   	leave  
  8015c1:	c3                   	ret    

008015c2 <sys_env_exit>:


void sys_env_exit(void)
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 06                	push   $0x6
  8015d1:	e8 19 ff ff ff       	call   8014ef <syscall>
  8015d6:	83 c4 18             	add    $0x18,%esp
}
  8015d9:	90                   	nop
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	52                   	push   %edx
  8015ec:	50                   	push   %eax
  8015ed:	6a 07                	push   $0x7
  8015ef:	e8 fb fe ff ff       	call   8014ef <syscall>
  8015f4:	83 c4 18             	add    $0x18,%esp
}
  8015f7:	c9                   	leave  
  8015f8:	c3                   	ret    

008015f9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015f9:	55                   	push   %ebp
  8015fa:	89 e5                	mov    %esp,%ebp
  8015fc:	56                   	push   %esi
  8015fd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015fe:	8b 75 18             	mov    0x18(%ebp),%esi
  801601:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801604:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801607:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
  80160d:	56                   	push   %esi
  80160e:	53                   	push   %ebx
  80160f:	51                   	push   %ecx
  801610:	52                   	push   %edx
  801611:	50                   	push   %eax
  801612:	6a 08                	push   $0x8
  801614:	e8 d6 fe ff ff       	call   8014ef <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
}
  80161c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80161f:	5b                   	pop    %ebx
  801620:	5e                   	pop    %esi
  801621:	5d                   	pop    %ebp
  801622:	c3                   	ret    

00801623 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801623:	55                   	push   %ebp
  801624:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801626:	8b 55 0c             	mov    0xc(%ebp),%edx
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	52                   	push   %edx
  801633:	50                   	push   %eax
  801634:	6a 09                	push   $0x9
  801636:	e8 b4 fe ff ff       	call   8014ef <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	ff 75 0c             	pushl  0xc(%ebp)
  80164c:	ff 75 08             	pushl  0x8(%ebp)
  80164f:	6a 0a                	push   $0xa
  801651:	e8 99 fe ff ff       	call   8014ef <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 0b                	push   $0xb
  80166a:	e8 80 fe ff ff       	call   8014ef <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	c9                   	leave  
  801673:	c3                   	ret    

00801674 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 0c                	push   $0xc
  801683:	e8 67 fe ff ff       	call   8014ef <syscall>
  801688:	83 c4 18             	add    $0x18,%esp
}
  80168b:	c9                   	leave  
  80168c:	c3                   	ret    

0080168d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80168d:	55                   	push   %ebp
  80168e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 0d                	push   $0xd
  80169c:	e8 4e fe ff ff       	call   8014ef <syscall>
  8016a1:	83 c4 18             	add    $0x18,%esp
}
  8016a4:	c9                   	leave  
  8016a5:	c3                   	ret    

008016a6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016a6:	55                   	push   %ebp
  8016a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	ff 75 0c             	pushl  0xc(%ebp)
  8016b2:	ff 75 08             	pushl  0x8(%ebp)
  8016b5:	6a 11                	push   $0x11
  8016b7:	e8 33 fe ff ff       	call   8014ef <syscall>
  8016bc:	83 c4 18             	add    $0x18,%esp
	return;
  8016bf:	90                   	nop
}
  8016c0:	c9                   	leave  
  8016c1:	c3                   	ret    

008016c2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016c2:	55                   	push   %ebp
  8016c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	ff 75 0c             	pushl  0xc(%ebp)
  8016ce:	ff 75 08             	pushl  0x8(%ebp)
  8016d1:	6a 12                	push   $0x12
  8016d3:	e8 17 fe ff ff       	call   8014ef <syscall>
  8016d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016db:	90                   	nop
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 0e                	push   $0xe
  8016ed:	e8 fd fd ff ff       	call   8014ef <syscall>
  8016f2:	83 c4 18             	add    $0x18,%esp
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	ff 75 08             	pushl  0x8(%ebp)
  801705:	6a 0f                	push   $0xf
  801707:	e8 e3 fd ff ff       	call   8014ef <syscall>
  80170c:	83 c4 18             	add    $0x18,%esp
}
  80170f:	c9                   	leave  
  801710:	c3                   	ret    

00801711 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 10                	push   $0x10
  801720:	e8 ca fd ff ff       	call   8014ef <syscall>
  801725:	83 c4 18             	add    $0x18,%esp
}
  801728:	90                   	nop
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 14                	push   $0x14
  80173a:	e8 b0 fd ff ff       	call   8014ef <syscall>
  80173f:	83 c4 18             	add    $0x18,%esp
}
  801742:	90                   	nop
  801743:	c9                   	leave  
  801744:	c3                   	ret    

00801745 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801745:	55                   	push   %ebp
  801746:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 15                	push   $0x15
  801754:	e8 96 fd ff ff       	call   8014ef <syscall>
  801759:	83 c4 18             	add    $0x18,%esp
}
  80175c:	90                   	nop
  80175d:	c9                   	leave  
  80175e:	c3                   	ret    

0080175f <sys_cputc>:


void
sys_cputc(const char c)
{
  80175f:	55                   	push   %ebp
  801760:	89 e5                	mov    %esp,%ebp
  801762:	83 ec 04             	sub    $0x4,%esp
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
  801768:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80176b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	50                   	push   %eax
  801778:	6a 16                	push   $0x16
  80177a:	e8 70 fd ff ff       	call   8014ef <syscall>
  80177f:	83 c4 18             	add    $0x18,%esp
}
  801782:	90                   	nop
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 17                	push   $0x17
  801794:	e8 56 fd ff ff       	call   8014ef <syscall>
  801799:	83 c4 18             	add    $0x18,%esp
}
  80179c:	90                   	nop
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	ff 75 0c             	pushl  0xc(%ebp)
  8017ae:	50                   	push   %eax
  8017af:	6a 18                	push   $0x18
  8017b1:	e8 39 fd ff ff       	call   8014ef <syscall>
  8017b6:	83 c4 18             	add    $0x18,%esp
}
  8017b9:	c9                   	leave  
  8017ba:	c3                   	ret    

008017bb <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017bb:	55                   	push   %ebp
  8017bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	52                   	push   %edx
  8017cb:	50                   	push   %eax
  8017cc:	6a 1b                	push   $0x1b
  8017ce:	e8 1c fd ff ff       	call   8014ef <syscall>
  8017d3:	83 c4 18             	add    $0x18,%esp
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017de:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	52                   	push   %edx
  8017e8:	50                   	push   %eax
  8017e9:	6a 19                	push   $0x19
  8017eb:	e8 ff fc ff ff       	call   8014ef <syscall>
  8017f0:	83 c4 18             	add    $0x18,%esp
}
  8017f3:	90                   	nop
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	52                   	push   %edx
  801806:	50                   	push   %eax
  801807:	6a 1a                	push   $0x1a
  801809:	e8 e1 fc ff ff       	call   8014ef <syscall>
  80180e:	83 c4 18             	add    $0x18,%esp
}
  801811:	90                   	nop
  801812:	c9                   	leave  
  801813:	c3                   	ret    

00801814 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801814:	55                   	push   %ebp
  801815:	89 e5                	mov    %esp,%ebp
  801817:	83 ec 04             	sub    $0x4,%esp
  80181a:	8b 45 10             	mov    0x10(%ebp),%eax
  80181d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801820:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801823:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801827:	8b 45 08             	mov    0x8(%ebp),%eax
  80182a:	6a 00                	push   $0x0
  80182c:	51                   	push   %ecx
  80182d:	52                   	push   %edx
  80182e:	ff 75 0c             	pushl  0xc(%ebp)
  801831:	50                   	push   %eax
  801832:	6a 1c                	push   $0x1c
  801834:	e8 b6 fc ff ff       	call   8014ef <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
}
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801841:	8b 55 0c             	mov    0xc(%ebp),%edx
  801844:	8b 45 08             	mov    0x8(%ebp),%eax
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	52                   	push   %edx
  80184e:	50                   	push   %eax
  80184f:	6a 1d                	push   $0x1d
  801851:	e8 99 fc ff ff       	call   8014ef <syscall>
  801856:	83 c4 18             	add    $0x18,%esp
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80185e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801861:	8b 55 0c             	mov    0xc(%ebp),%edx
  801864:	8b 45 08             	mov    0x8(%ebp),%eax
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	51                   	push   %ecx
  80186c:	52                   	push   %edx
  80186d:	50                   	push   %eax
  80186e:	6a 1e                	push   $0x1e
  801870:	e8 7a fc ff ff       	call   8014ef <syscall>
  801875:	83 c4 18             	add    $0x18,%esp
}
  801878:	c9                   	leave  
  801879:	c3                   	ret    

0080187a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80187a:	55                   	push   %ebp
  80187b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80187d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	52                   	push   %edx
  80188a:	50                   	push   %eax
  80188b:	6a 1f                	push   $0x1f
  80188d:	e8 5d fc ff ff       	call   8014ef <syscall>
  801892:	83 c4 18             	add    $0x18,%esp
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 20                	push   $0x20
  8018a6:	e8 44 fc ff ff       	call   8014ef <syscall>
  8018ab:	83 c4 18             	add    $0x18,%esp
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8018b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	ff 75 10             	pushl  0x10(%ebp)
  8018bd:	ff 75 0c             	pushl  0xc(%ebp)
  8018c0:	50                   	push   %eax
  8018c1:	6a 21                	push   $0x21
  8018c3:	e8 27 fc ff ff       	call   8014ef <syscall>
  8018c8:	83 c4 18             	add    $0x18,%esp
}
  8018cb:	c9                   	leave  
  8018cc:	c3                   	ret    

008018cd <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018cd:	55                   	push   %ebp
  8018ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	50                   	push   %eax
  8018dc:	6a 22                	push   $0x22
  8018de:	e8 0c fc ff ff       	call   8014ef <syscall>
  8018e3:	83 c4 18             	add    $0x18,%esp
}
  8018e6:	90                   	nop
  8018e7:	c9                   	leave  
  8018e8:	c3                   	ret    

008018e9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018e9:	55                   	push   %ebp
  8018ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	50                   	push   %eax
  8018f8:	6a 23                	push   $0x23
  8018fa:	e8 f0 fb ff ff       	call   8014ef <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
}
  801902:	90                   	nop
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
  801908:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80190b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80190e:	8d 50 04             	lea    0x4(%eax),%edx
  801911:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	52                   	push   %edx
  80191b:	50                   	push   %eax
  80191c:	6a 24                	push   $0x24
  80191e:	e8 cc fb ff ff       	call   8014ef <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
	return result;
  801926:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801929:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80192c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80192f:	89 01                	mov    %eax,(%ecx)
  801931:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801934:	8b 45 08             	mov    0x8(%ebp),%eax
  801937:	c9                   	leave  
  801938:	c2 04 00             	ret    $0x4

0080193b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	ff 75 10             	pushl  0x10(%ebp)
  801945:	ff 75 0c             	pushl  0xc(%ebp)
  801948:	ff 75 08             	pushl  0x8(%ebp)
  80194b:	6a 13                	push   $0x13
  80194d:	e8 9d fb ff ff       	call   8014ef <syscall>
  801952:	83 c4 18             	add    $0x18,%esp
	return ;
  801955:	90                   	nop
}
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <sys_rcr2>:
uint32 sys_rcr2()
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 25                	push   $0x25
  801967:	e8 83 fb ff ff       	call   8014ef <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
}
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
  801974:	83 ec 04             	sub    $0x4,%esp
  801977:	8b 45 08             	mov    0x8(%ebp),%eax
  80197a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80197d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	50                   	push   %eax
  80198a:	6a 26                	push   $0x26
  80198c:	e8 5e fb ff ff       	call   8014ef <syscall>
  801991:	83 c4 18             	add    $0x18,%esp
	return ;
  801994:	90                   	nop
}
  801995:	c9                   	leave  
  801996:	c3                   	ret    

00801997 <rsttst>:
void rsttst()
{
  801997:	55                   	push   %ebp
  801998:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 28                	push   $0x28
  8019a6:	e8 44 fb ff ff       	call   8014ef <syscall>
  8019ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ae:	90                   	nop
}
  8019af:	c9                   	leave  
  8019b0:	c3                   	ret    

008019b1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019b1:	55                   	push   %ebp
  8019b2:	89 e5                	mov    %esp,%ebp
  8019b4:	83 ec 04             	sub    $0x4,%esp
  8019b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8019ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019bd:	8b 55 18             	mov    0x18(%ebp),%edx
  8019c0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019c4:	52                   	push   %edx
  8019c5:	50                   	push   %eax
  8019c6:	ff 75 10             	pushl  0x10(%ebp)
  8019c9:	ff 75 0c             	pushl  0xc(%ebp)
  8019cc:	ff 75 08             	pushl  0x8(%ebp)
  8019cf:	6a 27                	push   $0x27
  8019d1:	e8 19 fb ff ff       	call   8014ef <syscall>
  8019d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d9:	90                   	nop
}
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <chktst>:
void chktst(uint32 n)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	ff 75 08             	pushl  0x8(%ebp)
  8019ea:	6a 29                	push   $0x29
  8019ec:	e8 fe fa ff ff       	call   8014ef <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f4:	90                   	nop
}
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <inctst>:

void inctst()
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 2a                	push   $0x2a
  801a06:	e8 e4 fa ff ff       	call   8014ef <syscall>
  801a0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a0e:	90                   	nop
}
  801a0f:	c9                   	leave  
  801a10:	c3                   	ret    

00801a11 <gettst>:
uint32 gettst()
{
  801a11:	55                   	push   %ebp
  801a12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 2b                	push   $0x2b
  801a20:	e8 ca fa ff ff       	call   8014ef <syscall>
  801a25:	83 c4 18             	add    $0x18,%esp
}
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 2c                	push   $0x2c
  801a3c:	e8 ae fa ff ff       	call   8014ef <syscall>
  801a41:	83 c4 18             	add    $0x18,%esp
  801a44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a47:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a4b:	75 07                	jne    801a54 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a52:	eb 05                	jmp    801a59 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a59:	c9                   	leave  
  801a5a:	c3                   	ret    

00801a5b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
  801a5e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 2c                	push   $0x2c
  801a6d:	e8 7d fa ff ff       	call   8014ef <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
  801a75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a78:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a7c:	75 07                	jne    801a85 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a83:	eb 05                	jmp    801a8a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a8a:	c9                   	leave  
  801a8b:	c3                   	ret    

00801a8c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a8c:	55                   	push   %ebp
  801a8d:	89 e5                	mov    %esp,%ebp
  801a8f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 2c                	push   $0x2c
  801a9e:	e8 4c fa ff ff       	call   8014ef <syscall>
  801aa3:	83 c4 18             	add    $0x18,%esp
  801aa6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801aa9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801aad:	75 07                	jne    801ab6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801aaf:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab4:	eb 05                	jmp    801abb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ab6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801abb:	c9                   	leave  
  801abc:	c3                   	ret    

00801abd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801abd:	55                   	push   %ebp
  801abe:	89 e5                	mov    %esp,%ebp
  801ac0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 2c                	push   $0x2c
  801acf:	e8 1b fa ff ff       	call   8014ef <syscall>
  801ad4:	83 c4 18             	add    $0x18,%esp
  801ad7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ada:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ade:	75 07                	jne    801ae7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ae0:	b8 01 00 00 00       	mov    $0x1,%eax
  801ae5:	eb 05                	jmp    801aec <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ae7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	ff 75 08             	pushl  0x8(%ebp)
  801afc:	6a 2d                	push   $0x2d
  801afe:	e8 ec f9 ff ff       	call   8014ef <syscall>
  801b03:	83 c4 18             	add    $0x18,%esp
	return ;
  801b06:	90                   	nop
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    
  801b09:	66 90                	xchg   %ax,%ax
  801b0b:	90                   	nop

00801b0c <__udivdi3>:
  801b0c:	55                   	push   %ebp
  801b0d:	57                   	push   %edi
  801b0e:	56                   	push   %esi
  801b0f:	53                   	push   %ebx
  801b10:	83 ec 1c             	sub    $0x1c,%esp
  801b13:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b17:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b1f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b23:	89 ca                	mov    %ecx,%edx
  801b25:	89 f8                	mov    %edi,%eax
  801b27:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b2b:	85 f6                	test   %esi,%esi
  801b2d:	75 2d                	jne    801b5c <__udivdi3+0x50>
  801b2f:	39 cf                	cmp    %ecx,%edi
  801b31:	77 65                	ja     801b98 <__udivdi3+0x8c>
  801b33:	89 fd                	mov    %edi,%ebp
  801b35:	85 ff                	test   %edi,%edi
  801b37:	75 0b                	jne    801b44 <__udivdi3+0x38>
  801b39:	b8 01 00 00 00       	mov    $0x1,%eax
  801b3e:	31 d2                	xor    %edx,%edx
  801b40:	f7 f7                	div    %edi
  801b42:	89 c5                	mov    %eax,%ebp
  801b44:	31 d2                	xor    %edx,%edx
  801b46:	89 c8                	mov    %ecx,%eax
  801b48:	f7 f5                	div    %ebp
  801b4a:	89 c1                	mov    %eax,%ecx
  801b4c:	89 d8                	mov    %ebx,%eax
  801b4e:	f7 f5                	div    %ebp
  801b50:	89 cf                	mov    %ecx,%edi
  801b52:	89 fa                	mov    %edi,%edx
  801b54:	83 c4 1c             	add    $0x1c,%esp
  801b57:	5b                   	pop    %ebx
  801b58:	5e                   	pop    %esi
  801b59:	5f                   	pop    %edi
  801b5a:	5d                   	pop    %ebp
  801b5b:	c3                   	ret    
  801b5c:	39 ce                	cmp    %ecx,%esi
  801b5e:	77 28                	ja     801b88 <__udivdi3+0x7c>
  801b60:	0f bd fe             	bsr    %esi,%edi
  801b63:	83 f7 1f             	xor    $0x1f,%edi
  801b66:	75 40                	jne    801ba8 <__udivdi3+0x9c>
  801b68:	39 ce                	cmp    %ecx,%esi
  801b6a:	72 0a                	jb     801b76 <__udivdi3+0x6a>
  801b6c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b70:	0f 87 9e 00 00 00    	ja     801c14 <__udivdi3+0x108>
  801b76:	b8 01 00 00 00       	mov    $0x1,%eax
  801b7b:	89 fa                	mov    %edi,%edx
  801b7d:	83 c4 1c             	add    $0x1c,%esp
  801b80:	5b                   	pop    %ebx
  801b81:	5e                   	pop    %esi
  801b82:	5f                   	pop    %edi
  801b83:	5d                   	pop    %ebp
  801b84:	c3                   	ret    
  801b85:	8d 76 00             	lea    0x0(%esi),%esi
  801b88:	31 ff                	xor    %edi,%edi
  801b8a:	31 c0                	xor    %eax,%eax
  801b8c:	89 fa                	mov    %edi,%edx
  801b8e:	83 c4 1c             	add    $0x1c,%esp
  801b91:	5b                   	pop    %ebx
  801b92:	5e                   	pop    %esi
  801b93:	5f                   	pop    %edi
  801b94:	5d                   	pop    %ebp
  801b95:	c3                   	ret    
  801b96:	66 90                	xchg   %ax,%ax
  801b98:	89 d8                	mov    %ebx,%eax
  801b9a:	f7 f7                	div    %edi
  801b9c:	31 ff                	xor    %edi,%edi
  801b9e:	89 fa                	mov    %edi,%edx
  801ba0:	83 c4 1c             	add    $0x1c,%esp
  801ba3:	5b                   	pop    %ebx
  801ba4:	5e                   	pop    %esi
  801ba5:	5f                   	pop    %edi
  801ba6:	5d                   	pop    %ebp
  801ba7:	c3                   	ret    
  801ba8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801bad:	89 eb                	mov    %ebp,%ebx
  801baf:	29 fb                	sub    %edi,%ebx
  801bb1:	89 f9                	mov    %edi,%ecx
  801bb3:	d3 e6                	shl    %cl,%esi
  801bb5:	89 c5                	mov    %eax,%ebp
  801bb7:	88 d9                	mov    %bl,%cl
  801bb9:	d3 ed                	shr    %cl,%ebp
  801bbb:	89 e9                	mov    %ebp,%ecx
  801bbd:	09 f1                	or     %esi,%ecx
  801bbf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bc3:	89 f9                	mov    %edi,%ecx
  801bc5:	d3 e0                	shl    %cl,%eax
  801bc7:	89 c5                	mov    %eax,%ebp
  801bc9:	89 d6                	mov    %edx,%esi
  801bcb:	88 d9                	mov    %bl,%cl
  801bcd:	d3 ee                	shr    %cl,%esi
  801bcf:	89 f9                	mov    %edi,%ecx
  801bd1:	d3 e2                	shl    %cl,%edx
  801bd3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd7:	88 d9                	mov    %bl,%cl
  801bd9:	d3 e8                	shr    %cl,%eax
  801bdb:	09 c2                	or     %eax,%edx
  801bdd:	89 d0                	mov    %edx,%eax
  801bdf:	89 f2                	mov    %esi,%edx
  801be1:	f7 74 24 0c          	divl   0xc(%esp)
  801be5:	89 d6                	mov    %edx,%esi
  801be7:	89 c3                	mov    %eax,%ebx
  801be9:	f7 e5                	mul    %ebp
  801beb:	39 d6                	cmp    %edx,%esi
  801bed:	72 19                	jb     801c08 <__udivdi3+0xfc>
  801bef:	74 0b                	je     801bfc <__udivdi3+0xf0>
  801bf1:	89 d8                	mov    %ebx,%eax
  801bf3:	31 ff                	xor    %edi,%edi
  801bf5:	e9 58 ff ff ff       	jmp    801b52 <__udivdi3+0x46>
  801bfa:	66 90                	xchg   %ax,%ax
  801bfc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c00:	89 f9                	mov    %edi,%ecx
  801c02:	d3 e2                	shl    %cl,%edx
  801c04:	39 c2                	cmp    %eax,%edx
  801c06:	73 e9                	jae    801bf1 <__udivdi3+0xe5>
  801c08:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c0b:	31 ff                	xor    %edi,%edi
  801c0d:	e9 40 ff ff ff       	jmp    801b52 <__udivdi3+0x46>
  801c12:	66 90                	xchg   %ax,%ax
  801c14:	31 c0                	xor    %eax,%eax
  801c16:	e9 37 ff ff ff       	jmp    801b52 <__udivdi3+0x46>
  801c1b:	90                   	nop

00801c1c <__umoddi3>:
  801c1c:	55                   	push   %ebp
  801c1d:	57                   	push   %edi
  801c1e:	56                   	push   %esi
  801c1f:	53                   	push   %ebx
  801c20:	83 ec 1c             	sub    $0x1c,%esp
  801c23:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c27:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c2f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c37:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c3b:	89 f3                	mov    %esi,%ebx
  801c3d:	89 fa                	mov    %edi,%edx
  801c3f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c43:	89 34 24             	mov    %esi,(%esp)
  801c46:	85 c0                	test   %eax,%eax
  801c48:	75 1a                	jne    801c64 <__umoddi3+0x48>
  801c4a:	39 f7                	cmp    %esi,%edi
  801c4c:	0f 86 a2 00 00 00    	jbe    801cf4 <__umoddi3+0xd8>
  801c52:	89 c8                	mov    %ecx,%eax
  801c54:	89 f2                	mov    %esi,%edx
  801c56:	f7 f7                	div    %edi
  801c58:	89 d0                	mov    %edx,%eax
  801c5a:	31 d2                	xor    %edx,%edx
  801c5c:	83 c4 1c             	add    $0x1c,%esp
  801c5f:	5b                   	pop    %ebx
  801c60:	5e                   	pop    %esi
  801c61:	5f                   	pop    %edi
  801c62:	5d                   	pop    %ebp
  801c63:	c3                   	ret    
  801c64:	39 f0                	cmp    %esi,%eax
  801c66:	0f 87 ac 00 00 00    	ja     801d18 <__umoddi3+0xfc>
  801c6c:	0f bd e8             	bsr    %eax,%ebp
  801c6f:	83 f5 1f             	xor    $0x1f,%ebp
  801c72:	0f 84 ac 00 00 00    	je     801d24 <__umoddi3+0x108>
  801c78:	bf 20 00 00 00       	mov    $0x20,%edi
  801c7d:	29 ef                	sub    %ebp,%edi
  801c7f:	89 fe                	mov    %edi,%esi
  801c81:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c85:	89 e9                	mov    %ebp,%ecx
  801c87:	d3 e0                	shl    %cl,%eax
  801c89:	89 d7                	mov    %edx,%edi
  801c8b:	89 f1                	mov    %esi,%ecx
  801c8d:	d3 ef                	shr    %cl,%edi
  801c8f:	09 c7                	or     %eax,%edi
  801c91:	89 e9                	mov    %ebp,%ecx
  801c93:	d3 e2                	shl    %cl,%edx
  801c95:	89 14 24             	mov    %edx,(%esp)
  801c98:	89 d8                	mov    %ebx,%eax
  801c9a:	d3 e0                	shl    %cl,%eax
  801c9c:	89 c2                	mov    %eax,%edx
  801c9e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ca2:	d3 e0                	shl    %cl,%eax
  801ca4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ca8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cac:	89 f1                	mov    %esi,%ecx
  801cae:	d3 e8                	shr    %cl,%eax
  801cb0:	09 d0                	or     %edx,%eax
  801cb2:	d3 eb                	shr    %cl,%ebx
  801cb4:	89 da                	mov    %ebx,%edx
  801cb6:	f7 f7                	div    %edi
  801cb8:	89 d3                	mov    %edx,%ebx
  801cba:	f7 24 24             	mull   (%esp)
  801cbd:	89 c6                	mov    %eax,%esi
  801cbf:	89 d1                	mov    %edx,%ecx
  801cc1:	39 d3                	cmp    %edx,%ebx
  801cc3:	0f 82 87 00 00 00    	jb     801d50 <__umoddi3+0x134>
  801cc9:	0f 84 91 00 00 00    	je     801d60 <__umoddi3+0x144>
  801ccf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801cd3:	29 f2                	sub    %esi,%edx
  801cd5:	19 cb                	sbb    %ecx,%ebx
  801cd7:	89 d8                	mov    %ebx,%eax
  801cd9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cdd:	d3 e0                	shl    %cl,%eax
  801cdf:	89 e9                	mov    %ebp,%ecx
  801ce1:	d3 ea                	shr    %cl,%edx
  801ce3:	09 d0                	or     %edx,%eax
  801ce5:	89 e9                	mov    %ebp,%ecx
  801ce7:	d3 eb                	shr    %cl,%ebx
  801ce9:	89 da                	mov    %ebx,%edx
  801ceb:	83 c4 1c             	add    $0x1c,%esp
  801cee:	5b                   	pop    %ebx
  801cef:	5e                   	pop    %esi
  801cf0:	5f                   	pop    %edi
  801cf1:	5d                   	pop    %ebp
  801cf2:	c3                   	ret    
  801cf3:	90                   	nop
  801cf4:	89 fd                	mov    %edi,%ebp
  801cf6:	85 ff                	test   %edi,%edi
  801cf8:	75 0b                	jne    801d05 <__umoddi3+0xe9>
  801cfa:	b8 01 00 00 00       	mov    $0x1,%eax
  801cff:	31 d2                	xor    %edx,%edx
  801d01:	f7 f7                	div    %edi
  801d03:	89 c5                	mov    %eax,%ebp
  801d05:	89 f0                	mov    %esi,%eax
  801d07:	31 d2                	xor    %edx,%edx
  801d09:	f7 f5                	div    %ebp
  801d0b:	89 c8                	mov    %ecx,%eax
  801d0d:	f7 f5                	div    %ebp
  801d0f:	89 d0                	mov    %edx,%eax
  801d11:	e9 44 ff ff ff       	jmp    801c5a <__umoddi3+0x3e>
  801d16:	66 90                	xchg   %ax,%ax
  801d18:	89 c8                	mov    %ecx,%eax
  801d1a:	89 f2                	mov    %esi,%edx
  801d1c:	83 c4 1c             	add    $0x1c,%esp
  801d1f:	5b                   	pop    %ebx
  801d20:	5e                   	pop    %esi
  801d21:	5f                   	pop    %edi
  801d22:	5d                   	pop    %ebp
  801d23:	c3                   	ret    
  801d24:	3b 04 24             	cmp    (%esp),%eax
  801d27:	72 06                	jb     801d2f <__umoddi3+0x113>
  801d29:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d2d:	77 0f                	ja     801d3e <__umoddi3+0x122>
  801d2f:	89 f2                	mov    %esi,%edx
  801d31:	29 f9                	sub    %edi,%ecx
  801d33:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d37:	89 14 24             	mov    %edx,(%esp)
  801d3a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d3e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d42:	8b 14 24             	mov    (%esp),%edx
  801d45:	83 c4 1c             	add    $0x1c,%esp
  801d48:	5b                   	pop    %ebx
  801d49:	5e                   	pop    %esi
  801d4a:	5f                   	pop    %edi
  801d4b:	5d                   	pop    %ebp
  801d4c:	c3                   	ret    
  801d4d:	8d 76 00             	lea    0x0(%esi),%esi
  801d50:	2b 04 24             	sub    (%esp),%eax
  801d53:	19 fa                	sbb    %edi,%edx
  801d55:	89 d1                	mov    %edx,%ecx
  801d57:	89 c6                	mov    %eax,%esi
  801d59:	e9 71 ff ff ff       	jmp    801ccf <__umoddi3+0xb3>
  801d5e:	66 90                	xchg   %ax,%ax
  801d60:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d64:	72 ea                	jb     801d50 <__umoddi3+0x134>
  801d66:	89 d9                	mov    %ebx,%ecx
  801d68:	e9 62 ff ff ff       	jmp    801ccf <__umoddi3+0xb3>
