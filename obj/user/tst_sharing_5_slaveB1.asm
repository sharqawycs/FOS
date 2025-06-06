
obj/user/tst_sharing_5_slaveB1:     file format elf32-i386


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
  800031:	e8 05 01 00 00       	call   80013b <libmain>
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
  80003b:	83 ec 18             	sub    $0x18,%esp
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
  80008c:	68 40 1e 80 00       	push   $0x801e40
  800091:	6a 12                	push   $0x12
  800093:	68 5c 1e 80 00       	push   $0x801e5c
  800098:	e8 a0 01 00 00       	call   80023d <_panic>
	}
	uint32 *x;
	x = sget(sys_getparentenvid(),"x");
  80009d:	e8 23 15 00 00       	call   8015c5 <sys_getparentenvid>
  8000a2:	83 ec 08             	sub    $0x8,%esp
  8000a5:	68 79 1e 80 00       	push   $0x801e79
  8000aa:	50                   	push   %eax
  8000ab:	e8 eb 11 00 00       	call   80129b <sget>
  8000b0:	83 c4 10             	add    $0x10,%esp
  8000b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("Slave B1 env used x (getSharedObject)\n");
  8000b6:	83 ec 0c             	sub    $0xc,%esp
  8000b9:	68 7c 1e 80 00       	push   $0x801e7c
  8000be:	e8 2e 04 00 00       	call   8004f1 <cprintf>
  8000c3:	83 c4 10             	add    $0x10,%esp

	cprintf("Slave B1 please be patient ...\n");
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	68 a4 1e 80 00       	push   $0x801ea4
  8000ce:	e8 1e 04 00 00       	call   8004f1 <cprintf>
  8000d3:	83 c4 10             	add    $0x10,%esp

	env_sleep(6000);
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	68 70 17 00 00       	push   $0x1770
  8000de:	e8 42 1a 00 00       	call   801b25 <env_sleep>
  8000e3:	83 c4 10             	add    $0x10,%esp
	int freeFrames = sys_calculate_free_frames() ;
  8000e6:	e8 8c 15 00 00       	call   801677 <sys_calculate_free_frames>
  8000eb:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sfree(x);
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	ff 75 ec             	pushl  -0x14(%ebp)
  8000f4:	e8 d8 13 00 00       	call   8014d1 <sfree>
  8000f9:	83 c4 10             	add    $0x10,%esp
	cprintf("Slave B1 env removed x\n");
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	68 c4 1e 80 00       	push   $0x801ec4
  800104:	e8 e8 03 00 00       	call   8004f1 <cprintf>
  800109:	83 c4 10             	add    $0x10,%esp

	if ((sys_calculate_free_frames() - freeFrames) !=  4) panic("B1 wrong free: frames removed not equal 4 !, correct frames to be removed are 4:\nfrom the env: 1 table and 1 for frame of x\nframes_storage of x: should be cleared now\n");
  80010c:	e8 66 15 00 00       	call   801677 <sys_calculate_free_frames>
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800116:	29 c2                	sub    %eax,%edx
  800118:	89 d0                	mov    %edx,%eax
  80011a:	83 f8 04             	cmp    $0x4,%eax
  80011d:	74 14                	je     800133 <_main+0xfb>
  80011f:	83 ec 04             	sub    $0x4,%esp
  800122:	68 dc 1e 80 00       	push   $0x801edc
  800127:	6a 20                	push   $0x20
  800129:	68 5c 1e 80 00       	push   $0x801e5c
  80012e:	e8 0a 01 00 00       	call   80023d <_panic>

	//To indicate that it's completed successfully
	inctst();
  800133:	e8 db 18 00 00       	call   801a13 <inctst>
	return;
  800138:	90                   	nop
}
  800139:	c9                   	leave  
  80013a:	c3                   	ret    

0080013b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80013b:	55                   	push   %ebp
  80013c:	89 e5                	mov    %esp,%ebp
  80013e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800141:	e8 66 14 00 00       	call   8015ac <sys_getenvindex>
  800146:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800149:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80014c:	89 d0                	mov    %edx,%eax
  80014e:	01 c0                	add    %eax,%eax
  800150:	01 d0                	add    %edx,%eax
  800152:	c1 e0 02             	shl    $0x2,%eax
  800155:	01 d0                	add    %edx,%eax
  800157:	c1 e0 06             	shl    $0x6,%eax
  80015a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80015f:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800164:	a1 20 30 80 00       	mov    0x803020,%eax
  800169:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80016f:	84 c0                	test   %al,%al
  800171:	74 0f                	je     800182 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800173:	a1 20 30 80 00       	mov    0x803020,%eax
  800178:	05 f4 02 00 00       	add    $0x2f4,%eax
  80017d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800182:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800186:	7e 0a                	jle    800192 <libmain+0x57>
		binaryname = argv[0];
  800188:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018b:	8b 00                	mov    (%eax),%eax
  80018d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800192:	83 ec 08             	sub    $0x8,%esp
  800195:	ff 75 0c             	pushl  0xc(%ebp)
  800198:	ff 75 08             	pushl  0x8(%ebp)
  80019b:	e8 98 fe ff ff       	call   800038 <_main>
  8001a0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a3:	e8 9f 15 00 00       	call   801747 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a8:	83 ec 0c             	sub    $0xc,%esp
  8001ab:	68 9c 1f 80 00       	push   $0x801f9c
  8001b0:	e8 3c 03 00 00       	call   8004f1 <cprintf>
  8001b5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c8:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001ce:	83 ec 04             	sub    $0x4,%esp
  8001d1:	52                   	push   %edx
  8001d2:	50                   	push   %eax
  8001d3:	68 c4 1f 80 00       	push   $0x801fc4
  8001d8:	e8 14 03 00 00       	call   8004f1 <cprintf>
  8001dd:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e5:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001eb:	83 ec 08             	sub    $0x8,%esp
  8001ee:	50                   	push   %eax
  8001ef:	68 e9 1f 80 00       	push   $0x801fe9
  8001f4:	e8 f8 02 00 00       	call   8004f1 <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001fc:	83 ec 0c             	sub    $0xc,%esp
  8001ff:	68 9c 1f 80 00       	push   $0x801f9c
  800204:	e8 e8 02 00 00       	call   8004f1 <cprintf>
  800209:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80020c:	e8 50 15 00 00       	call   801761 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800211:	e8 19 00 00 00       	call   80022f <exit>
}
  800216:	90                   	nop
  800217:	c9                   	leave  
  800218:	c3                   	ret    

00800219 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800219:	55                   	push   %ebp
  80021a:	89 e5                	mov    %esp,%ebp
  80021c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80021f:	83 ec 0c             	sub    $0xc,%esp
  800222:	6a 00                	push   $0x0
  800224:	e8 4f 13 00 00       	call   801578 <sys_env_destroy>
  800229:	83 c4 10             	add    $0x10,%esp
}
  80022c:	90                   	nop
  80022d:	c9                   	leave  
  80022e:	c3                   	ret    

0080022f <exit>:

void
exit(void)
{
  80022f:	55                   	push   %ebp
  800230:	89 e5                	mov    %esp,%ebp
  800232:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800235:	e8 a4 13 00 00       	call   8015de <sys_env_exit>
}
  80023a:	90                   	nop
  80023b:	c9                   	leave  
  80023c:	c3                   	ret    

0080023d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80023d:	55                   	push   %ebp
  80023e:	89 e5                	mov    %esp,%ebp
  800240:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800243:	8d 45 10             	lea    0x10(%ebp),%eax
  800246:	83 c0 04             	add    $0x4,%eax
  800249:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80024c:	a1 30 30 80 00       	mov    0x803030,%eax
  800251:	85 c0                	test   %eax,%eax
  800253:	74 16                	je     80026b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800255:	a1 30 30 80 00       	mov    0x803030,%eax
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	50                   	push   %eax
  80025e:	68 00 20 80 00       	push   $0x802000
  800263:	e8 89 02 00 00       	call   8004f1 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80026b:	a1 00 30 80 00       	mov    0x803000,%eax
  800270:	ff 75 0c             	pushl  0xc(%ebp)
  800273:	ff 75 08             	pushl  0x8(%ebp)
  800276:	50                   	push   %eax
  800277:	68 05 20 80 00       	push   $0x802005
  80027c:	e8 70 02 00 00       	call   8004f1 <cprintf>
  800281:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800284:	8b 45 10             	mov    0x10(%ebp),%eax
  800287:	83 ec 08             	sub    $0x8,%esp
  80028a:	ff 75 f4             	pushl  -0xc(%ebp)
  80028d:	50                   	push   %eax
  80028e:	e8 f3 01 00 00       	call   800486 <vcprintf>
  800293:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800296:	83 ec 08             	sub    $0x8,%esp
  800299:	6a 00                	push   $0x0
  80029b:	68 21 20 80 00       	push   $0x802021
  8002a0:	e8 e1 01 00 00       	call   800486 <vcprintf>
  8002a5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002a8:	e8 82 ff ff ff       	call   80022f <exit>

	// should not return here
	while (1) ;
  8002ad:	eb fe                	jmp    8002ad <_panic+0x70>

008002af <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002af:	55                   	push   %ebp
  8002b0:	89 e5                	mov    %esp,%ebp
  8002b2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ba:	8b 50 74             	mov    0x74(%eax),%edx
  8002bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c0:	39 c2                	cmp    %eax,%edx
  8002c2:	74 14                	je     8002d8 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002c4:	83 ec 04             	sub    $0x4,%esp
  8002c7:	68 24 20 80 00       	push   $0x802024
  8002cc:	6a 26                	push   $0x26
  8002ce:	68 70 20 80 00       	push   $0x802070
  8002d3:	e8 65 ff ff ff       	call   80023d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002e6:	e9 c2 00 00 00       	jmp    8003ad <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f8:	01 d0                	add    %edx,%eax
  8002fa:	8b 00                	mov    (%eax),%eax
  8002fc:	85 c0                	test   %eax,%eax
  8002fe:	75 08                	jne    800308 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800300:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800303:	e9 a2 00 00 00       	jmp    8003aa <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800308:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80030f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800316:	eb 69                	jmp    800381 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800318:	a1 20 30 80 00       	mov    0x803020,%eax
  80031d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800323:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800326:	89 d0                	mov    %edx,%eax
  800328:	01 c0                	add    %eax,%eax
  80032a:	01 d0                	add    %edx,%eax
  80032c:	c1 e0 02             	shl    $0x2,%eax
  80032f:	01 c8                	add    %ecx,%eax
  800331:	8a 40 04             	mov    0x4(%eax),%al
  800334:	84 c0                	test   %al,%al
  800336:	75 46                	jne    80037e <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800338:	a1 20 30 80 00       	mov    0x803020,%eax
  80033d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800343:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800346:	89 d0                	mov    %edx,%eax
  800348:	01 c0                	add    %eax,%eax
  80034a:	01 d0                	add    %edx,%eax
  80034c:	c1 e0 02             	shl    $0x2,%eax
  80034f:	01 c8                	add    %ecx,%eax
  800351:	8b 00                	mov    (%eax),%eax
  800353:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800356:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800359:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800360:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800363:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80036a:	8b 45 08             	mov    0x8(%ebp),%eax
  80036d:	01 c8                	add    %ecx,%eax
  80036f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800371:	39 c2                	cmp    %eax,%edx
  800373:	75 09                	jne    80037e <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800375:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80037c:	eb 12                	jmp    800390 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80037e:	ff 45 e8             	incl   -0x18(%ebp)
  800381:	a1 20 30 80 00       	mov    0x803020,%eax
  800386:	8b 50 74             	mov    0x74(%eax),%edx
  800389:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80038c:	39 c2                	cmp    %eax,%edx
  80038e:	77 88                	ja     800318 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800390:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800394:	75 14                	jne    8003aa <CheckWSWithoutLastIndex+0xfb>
			panic(
  800396:	83 ec 04             	sub    $0x4,%esp
  800399:	68 7c 20 80 00       	push   $0x80207c
  80039e:	6a 3a                	push   $0x3a
  8003a0:	68 70 20 80 00       	push   $0x802070
  8003a5:	e8 93 fe ff ff       	call   80023d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003aa:	ff 45 f0             	incl   -0x10(%ebp)
  8003ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003b3:	0f 8c 32 ff ff ff    	jl     8002eb <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003b9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003c7:	eb 26                	jmp    8003ef <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ce:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003d7:	89 d0                	mov    %edx,%eax
  8003d9:	01 c0                	add    %eax,%eax
  8003db:	01 d0                	add    %edx,%eax
  8003dd:	c1 e0 02             	shl    $0x2,%eax
  8003e0:	01 c8                	add    %ecx,%eax
  8003e2:	8a 40 04             	mov    0x4(%eax),%al
  8003e5:	3c 01                	cmp    $0x1,%al
  8003e7:	75 03                	jne    8003ec <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003e9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ec:	ff 45 e0             	incl   -0x20(%ebp)
  8003ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f4:	8b 50 74             	mov    0x74(%eax),%edx
  8003f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003fa:	39 c2                	cmp    %eax,%edx
  8003fc:	77 cb                	ja     8003c9 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800401:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800404:	74 14                	je     80041a <CheckWSWithoutLastIndex+0x16b>
		panic(
  800406:	83 ec 04             	sub    $0x4,%esp
  800409:	68 d0 20 80 00       	push   $0x8020d0
  80040e:	6a 44                	push   $0x44
  800410:	68 70 20 80 00       	push   $0x802070
  800415:	e8 23 fe ff ff       	call   80023d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80041a:	90                   	nop
  80041b:	c9                   	leave  
  80041c:	c3                   	ret    

0080041d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80041d:	55                   	push   %ebp
  80041e:	89 e5                	mov    %esp,%ebp
  800420:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800423:	8b 45 0c             	mov    0xc(%ebp),%eax
  800426:	8b 00                	mov    (%eax),%eax
  800428:	8d 48 01             	lea    0x1(%eax),%ecx
  80042b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80042e:	89 0a                	mov    %ecx,(%edx)
  800430:	8b 55 08             	mov    0x8(%ebp),%edx
  800433:	88 d1                	mov    %dl,%cl
  800435:	8b 55 0c             	mov    0xc(%ebp),%edx
  800438:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80043c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	3d ff 00 00 00       	cmp    $0xff,%eax
  800446:	75 2c                	jne    800474 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800448:	a0 24 30 80 00       	mov    0x803024,%al
  80044d:	0f b6 c0             	movzbl %al,%eax
  800450:	8b 55 0c             	mov    0xc(%ebp),%edx
  800453:	8b 12                	mov    (%edx),%edx
  800455:	89 d1                	mov    %edx,%ecx
  800457:	8b 55 0c             	mov    0xc(%ebp),%edx
  80045a:	83 c2 08             	add    $0x8,%edx
  80045d:	83 ec 04             	sub    $0x4,%esp
  800460:	50                   	push   %eax
  800461:	51                   	push   %ecx
  800462:	52                   	push   %edx
  800463:	e8 ce 10 00 00       	call   801536 <sys_cputs>
  800468:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80046b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800474:	8b 45 0c             	mov    0xc(%ebp),%eax
  800477:	8b 40 04             	mov    0x4(%eax),%eax
  80047a:	8d 50 01             	lea    0x1(%eax),%edx
  80047d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800480:	89 50 04             	mov    %edx,0x4(%eax)
}
  800483:	90                   	nop
  800484:	c9                   	leave  
  800485:	c3                   	ret    

00800486 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800486:	55                   	push   %ebp
  800487:	89 e5                	mov    %esp,%ebp
  800489:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80048f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800496:	00 00 00 
	b.cnt = 0;
  800499:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004a0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004a3:	ff 75 0c             	pushl  0xc(%ebp)
  8004a6:	ff 75 08             	pushl  0x8(%ebp)
  8004a9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004af:	50                   	push   %eax
  8004b0:	68 1d 04 80 00       	push   $0x80041d
  8004b5:	e8 11 02 00 00       	call   8006cb <vprintfmt>
  8004ba:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004bd:	a0 24 30 80 00       	mov    0x803024,%al
  8004c2:	0f b6 c0             	movzbl %al,%eax
  8004c5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004cb:	83 ec 04             	sub    $0x4,%esp
  8004ce:	50                   	push   %eax
  8004cf:	52                   	push   %edx
  8004d0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004d6:	83 c0 08             	add    $0x8,%eax
  8004d9:	50                   	push   %eax
  8004da:	e8 57 10 00 00       	call   801536 <sys_cputs>
  8004df:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004e2:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004e9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004ef:	c9                   	leave  
  8004f0:	c3                   	ret    

008004f1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8004f1:	55                   	push   %ebp
  8004f2:	89 e5                	mov    %esp,%ebp
  8004f4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004f7:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8004fe:	8d 45 0c             	lea    0xc(%ebp),%eax
  800501:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800504:	8b 45 08             	mov    0x8(%ebp),%eax
  800507:	83 ec 08             	sub    $0x8,%esp
  80050a:	ff 75 f4             	pushl  -0xc(%ebp)
  80050d:	50                   	push   %eax
  80050e:	e8 73 ff ff ff       	call   800486 <vcprintf>
  800513:	83 c4 10             	add    $0x10,%esp
  800516:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800519:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80051c:	c9                   	leave  
  80051d:	c3                   	ret    

0080051e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80051e:	55                   	push   %ebp
  80051f:	89 e5                	mov    %esp,%ebp
  800521:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800524:	e8 1e 12 00 00       	call   801747 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800529:	8d 45 0c             	lea    0xc(%ebp),%eax
  80052c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	83 ec 08             	sub    $0x8,%esp
  800535:	ff 75 f4             	pushl  -0xc(%ebp)
  800538:	50                   	push   %eax
  800539:	e8 48 ff ff ff       	call   800486 <vcprintf>
  80053e:	83 c4 10             	add    $0x10,%esp
  800541:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800544:	e8 18 12 00 00       	call   801761 <sys_enable_interrupt>
	return cnt;
  800549:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80054c:	c9                   	leave  
  80054d:	c3                   	ret    

0080054e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80054e:	55                   	push   %ebp
  80054f:	89 e5                	mov    %esp,%ebp
  800551:	53                   	push   %ebx
  800552:	83 ec 14             	sub    $0x14,%esp
  800555:	8b 45 10             	mov    0x10(%ebp),%eax
  800558:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80055b:	8b 45 14             	mov    0x14(%ebp),%eax
  80055e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800561:	8b 45 18             	mov    0x18(%ebp),%eax
  800564:	ba 00 00 00 00       	mov    $0x0,%edx
  800569:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80056c:	77 55                	ja     8005c3 <printnum+0x75>
  80056e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800571:	72 05                	jb     800578 <printnum+0x2a>
  800573:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800576:	77 4b                	ja     8005c3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800578:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80057b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80057e:	8b 45 18             	mov    0x18(%ebp),%eax
  800581:	ba 00 00 00 00       	mov    $0x0,%edx
  800586:	52                   	push   %edx
  800587:	50                   	push   %eax
  800588:	ff 75 f4             	pushl  -0xc(%ebp)
  80058b:	ff 75 f0             	pushl  -0x10(%ebp)
  80058e:	e8 49 16 00 00       	call   801bdc <__udivdi3>
  800593:	83 c4 10             	add    $0x10,%esp
  800596:	83 ec 04             	sub    $0x4,%esp
  800599:	ff 75 20             	pushl  0x20(%ebp)
  80059c:	53                   	push   %ebx
  80059d:	ff 75 18             	pushl  0x18(%ebp)
  8005a0:	52                   	push   %edx
  8005a1:	50                   	push   %eax
  8005a2:	ff 75 0c             	pushl  0xc(%ebp)
  8005a5:	ff 75 08             	pushl  0x8(%ebp)
  8005a8:	e8 a1 ff ff ff       	call   80054e <printnum>
  8005ad:	83 c4 20             	add    $0x20,%esp
  8005b0:	eb 1a                	jmp    8005cc <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005b2:	83 ec 08             	sub    $0x8,%esp
  8005b5:	ff 75 0c             	pushl  0xc(%ebp)
  8005b8:	ff 75 20             	pushl  0x20(%ebp)
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	ff d0                	call   *%eax
  8005c0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005c3:	ff 4d 1c             	decl   0x1c(%ebp)
  8005c6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005ca:	7f e6                	jg     8005b2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005cc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005cf:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005da:	53                   	push   %ebx
  8005db:	51                   	push   %ecx
  8005dc:	52                   	push   %edx
  8005dd:	50                   	push   %eax
  8005de:	e8 09 17 00 00       	call   801cec <__umoddi3>
  8005e3:	83 c4 10             	add    $0x10,%esp
  8005e6:	05 34 23 80 00       	add    $0x802334,%eax
  8005eb:	8a 00                	mov    (%eax),%al
  8005ed:	0f be c0             	movsbl %al,%eax
  8005f0:	83 ec 08             	sub    $0x8,%esp
  8005f3:	ff 75 0c             	pushl  0xc(%ebp)
  8005f6:	50                   	push   %eax
  8005f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fa:	ff d0                	call   *%eax
  8005fc:	83 c4 10             	add    $0x10,%esp
}
  8005ff:	90                   	nop
  800600:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800603:	c9                   	leave  
  800604:	c3                   	ret    

00800605 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800605:	55                   	push   %ebp
  800606:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800608:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80060c:	7e 1c                	jle    80062a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	8b 00                	mov    (%eax),%eax
  800613:	8d 50 08             	lea    0x8(%eax),%edx
  800616:	8b 45 08             	mov    0x8(%ebp),%eax
  800619:	89 10                	mov    %edx,(%eax)
  80061b:	8b 45 08             	mov    0x8(%ebp),%eax
  80061e:	8b 00                	mov    (%eax),%eax
  800620:	83 e8 08             	sub    $0x8,%eax
  800623:	8b 50 04             	mov    0x4(%eax),%edx
  800626:	8b 00                	mov    (%eax),%eax
  800628:	eb 40                	jmp    80066a <getuint+0x65>
	else if (lflag)
  80062a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80062e:	74 1e                	je     80064e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	8b 00                	mov    (%eax),%eax
  800635:	8d 50 04             	lea    0x4(%eax),%edx
  800638:	8b 45 08             	mov    0x8(%ebp),%eax
  80063b:	89 10                	mov    %edx,(%eax)
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8b 00                	mov    (%eax),%eax
  800642:	83 e8 04             	sub    $0x4,%eax
  800645:	8b 00                	mov    (%eax),%eax
  800647:	ba 00 00 00 00       	mov    $0x0,%edx
  80064c:	eb 1c                	jmp    80066a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80064e:	8b 45 08             	mov    0x8(%ebp),%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	8d 50 04             	lea    0x4(%eax),%edx
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	89 10                	mov    %edx,(%eax)
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	83 e8 04             	sub    $0x4,%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80066a:	5d                   	pop    %ebp
  80066b:	c3                   	ret    

0080066c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80066c:	55                   	push   %ebp
  80066d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80066f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800673:	7e 1c                	jle    800691 <getint+0x25>
		return va_arg(*ap, long long);
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	8b 00                	mov    (%eax),%eax
  80067a:	8d 50 08             	lea    0x8(%eax),%edx
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	89 10                	mov    %edx,(%eax)
  800682:	8b 45 08             	mov    0x8(%ebp),%eax
  800685:	8b 00                	mov    (%eax),%eax
  800687:	83 e8 08             	sub    $0x8,%eax
  80068a:	8b 50 04             	mov    0x4(%eax),%edx
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	eb 38                	jmp    8006c9 <getint+0x5d>
	else if (lflag)
  800691:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800695:	74 1a                	je     8006b1 <getint+0x45>
		return va_arg(*ap, long);
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	8b 00                	mov    (%eax),%eax
  80069c:	8d 50 04             	lea    0x4(%eax),%edx
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	89 10                	mov    %edx,(%eax)
  8006a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a7:	8b 00                	mov    (%eax),%eax
  8006a9:	83 e8 04             	sub    $0x4,%eax
  8006ac:	8b 00                	mov    (%eax),%eax
  8006ae:	99                   	cltd   
  8006af:	eb 18                	jmp    8006c9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	8b 00                	mov    (%eax),%eax
  8006b6:	8d 50 04             	lea    0x4(%eax),%edx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	89 10                	mov    %edx,(%eax)
  8006be:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c1:	8b 00                	mov    (%eax),%eax
  8006c3:	83 e8 04             	sub    $0x4,%eax
  8006c6:	8b 00                	mov    (%eax),%eax
  8006c8:	99                   	cltd   
}
  8006c9:	5d                   	pop    %ebp
  8006ca:	c3                   	ret    

008006cb <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006cb:	55                   	push   %ebp
  8006cc:	89 e5                	mov    %esp,%ebp
  8006ce:	56                   	push   %esi
  8006cf:	53                   	push   %ebx
  8006d0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006d3:	eb 17                	jmp    8006ec <vprintfmt+0x21>
			if (ch == '\0')
  8006d5:	85 db                	test   %ebx,%ebx
  8006d7:	0f 84 af 03 00 00    	je     800a8c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006dd:	83 ec 08             	sub    $0x8,%esp
  8006e0:	ff 75 0c             	pushl  0xc(%ebp)
  8006e3:	53                   	push   %ebx
  8006e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e7:	ff d0                	call   *%eax
  8006e9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ef:	8d 50 01             	lea    0x1(%eax),%edx
  8006f2:	89 55 10             	mov    %edx,0x10(%ebp)
  8006f5:	8a 00                	mov    (%eax),%al
  8006f7:	0f b6 d8             	movzbl %al,%ebx
  8006fa:	83 fb 25             	cmp    $0x25,%ebx
  8006fd:	75 d6                	jne    8006d5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006ff:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800703:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80070a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800711:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800718:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80071f:	8b 45 10             	mov    0x10(%ebp),%eax
  800722:	8d 50 01             	lea    0x1(%eax),%edx
  800725:	89 55 10             	mov    %edx,0x10(%ebp)
  800728:	8a 00                	mov    (%eax),%al
  80072a:	0f b6 d8             	movzbl %al,%ebx
  80072d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800730:	83 f8 55             	cmp    $0x55,%eax
  800733:	0f 87 2b 03 00 00    	ja     800a64 <vprintfmt+0x399>
  800739:	8b 04 85 58 23 80 00 	mov    0x802358(,%eax,4),%eax
  800740:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800742:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800746:	eb d7                	jmp    80071f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800748:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80074c:	eb d1                	jmp    80071f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80074e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800755:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800758:	89 d0                	mov    %edx,%eax
  80075a:	c1 e0 02             	shl    $0x2,%eax
  80075d:	01 d0                	add    %edx,%eax
  80075f:	01 c0                	add    %eax,%eax
  800761:	01 d8                	add    %ebx,%eax
  800763:	83 e8 30             	sub    $0x30,%eax
  800766:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800769:	8b 45 10             	mov    0x10(%ebp),%eax
  80076c:	8a 00                	mov    (%eax),%al
  80076e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800771:	83 fb 2f             	cmp    $0x2f,%ebx
  800774:	7e 3e                	jle    8007b4 <vprintfmt+0xe9>
  800776:	83 fb 39             	cmp    $0x39,%ebx
  800779:	7f 39                	jg     8007b4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80077b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80077e:	eb d5                	jmp    800755 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800780:	8b 45 14             	mov    0x14(%ebp),%eax
  800783:	83 c0 04             	add    $0x4,%eax
  800786:	89 45 14             	mov    %eax,0x14(%ebp)
  800789:	8b 45 14             	mov    0x14(%ebp),%eax
  80078c:	83 e8 04             	sub    $0x4,%eax
  80078f:	8b 00                	mov    (%eax),%eax
  800791:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800794:	eb 1f                	jmp    8007b5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800796:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80079a:	79 83                	jns    80071f <vprintfmt+0x54>
				width = 0;
  80079c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007a3:	e9 77 ff ff ff       	jmp    80071f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007a8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007af:	e9 6b ff ff ff       	jmp    80071f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007b4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007b5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007b9:	0f 89 60 ff ff ff    	jns    80071f <vprintfmt+0x54>
				width = precision, precision = -1;
  8007bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007c5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007cc:	e9 4e ff ff ff       	jmp    80071f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007d1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007d4:	e9 46 ff ff ff       	jmp    80071f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007dc:	83 c0 04             	add    $0x4,%eax
  8007df:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e5:	83 e8 04             	sub    $0x4,%eax
  8007e8:	8b 00                	mov    (%eax),%eax
  8007ea:	83 ec 08             	sub    $0x8,%esp
  8007ed:	ff 75 0c             	pushl  0xc(%ebp)
  8007f0:	50                   	push   %eax
  8007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f4:	ff d0                	call   *%eax
  8007f6:	83 c4 10             	add    $0x10,%esp
			break;
  8007f9:	e9 89 02 00 00       	jmp    800a87 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800801:	83 c0 04             	add    $0x4,%eax
  800804:	89 45 14             	mov    %eax,0x14(%ebp)
  800807:	8b 45 14             	mov    0x14(%ebp),%eax
  80080a:	83 e8 04             	sub    $0x4,%eax
  80080d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80080f:	85 db                	test   %ebx,%ebx
  800811:	79 02                	jns    800815 <vprintfmt+0x14a>
				err = -err;
  800813:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800815:	83 fb 64             	cmp    $0x64,%ebx
  800818:	7f 0b                	jg     800825 <vprintfmt+0x15a>
  80081a:	8b 34 9d a0 21 80 00 	mov    0x8021a0(,%ebx,4),%esi
  800821:	85 f6                	test   %esi,%esi
  800823:	75 19                	jne    80083e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800825:	53                   	push   %ebx
  800826:	68 45 23 80 00       	push   $0x802345
  80082b:	ff 75 0c             	pushl  0xc(%ebp)
  80082e:	ff 75 08             	pushl  0x8(%ebp)
  800831:	e8 5e 02 00 00       	call   800a94 <printfmt>
  800836:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800839:	e9 49 02 00 00       	jmp    800a87 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80083e:	56                   	push   %esi
  80083f:	68 4e 23 80 00       	push   $0x80234e
  800844:	ff 75 0c             	pushl  0xc(%ebp)
  800847:	ff 75 08             	pushl  0x8(%ebp)
  80084a:	e8 45 02 00 00       	call   800a94 <printfmt>
  80084f:	83 c4 10             	add    $0x10,%esp
			break;
  800852:	e9 30 02 00 00       	jmp    800a87 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800857:	8b 45 14             	mov    0x14(%ebp),%eax
  80085a:	83 c0 04             	add    $0x4,%eax
  80085d:	89 45 14             	mov    %eax,0x14(%ebp)
  800860:	8b 45 14             	mov    0x14(%ebp),%eax
  800863:	83 e8 04             	sub    $0x4,%eax
  800866:	8b 30                	mov    (%eax),%esi
  800868:	85 f6                	test   %esi,%esi
  80086a:	75 05                	jne    800871 <vprintfmt+0x1a6>
				p = "(null)";
  80086c:	be 51 23 80 00       	mov    $0x802351,%esi
			if (width > 0 && padc != '-')
  800871:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800875:	7e 6d                	jle    8008e4 <vprintfmt+0x219>
  800877:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80087b:	74 67                	je     8008e4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80087d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800880:	83 ec 08             	sub    $0x8,%esp
  800883:	50                   	push   %eax
  800884:	56                   	push   %esi
  800885:	e8 0c 03 00 00       	call   800b96 <strnlen>
  80088a:	83 c4 10             	add    $0x10,%esp
  80088d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800890:	eb 16                	jmp    8008a8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800892:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800896:	83 ec 08             	sub    $0x8,%esp
  800899:	ff 75 0c             	pushl  0xc(%ebp)
  80089c:	50                   	push   %eax
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	ff d0                	call   *%eax
  8008a2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008a5:	ff 4d e4             	decl   -0x1c(%ebp)
  8008a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ac:	7f e4                	jg     800892 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ae:	eb 34                	jmp    8008e4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008b0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008b4:	74 1c                	je     8008d2 <vprintfmt+0x207>
  8008b6:	83 fb 1f             	cmp    $0x1f,%ebx
  8008b9:	7e 05                	jle    8008c0 <vprintfmt+0x1f5>
  8008bb:	83 fb 7e             	cmp    $0x7e,%ebx
  8008be:	7e 12                	jle    8008d2 <vprintfmt+0x207>
					putch('?', putdat);
  8008c0:	83 ec 08             	sub    $0x8,%esp
  8008c3:	ff 75 0c             	pushl  0xc(%ebp)
  8008c6:	6a 3f                	push   $0x3f
  8008c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cb:	ff d0                	call   *%eax
  8008cd:	83 c4 10             	add    $0x10,%esp
  8008d0:	eb 0f                	jmp    8008e1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008d2:	83 ec 08             	sub    $0x8,%esp
  8008d5:	ff 75 0c             	pushl  0xc(%ebp)
  8008d8:	53                   	push   %ebx
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	ff d0                	call   *%eax
  8008de:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008e1:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e4:	89 f0                	mov    %esi,%eax
  8008e6:	8d 70 01             	lea    0x1(%eax),%esi
  8008e9:	8a 00                	mov    (%eax),%al
  8008eb:	0f be d8             	movsbl %al,%ebx
  8008ee:	85 db                	test   %ebx,%ebx
  8008f0:	74 24                	je     800916 <vprintfmt+0x24b>
  8008f2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008f6:	78 b8                	js     8008b0 <vprintfmt+0x1e5>
  8008f8:	ff 4d e0             	decl   -0x20(%ebp)
  8008fb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008ff:	79 af                	jns    8008b0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800901:	eb 13                	jmp    800916 <vprintfmt+0x24b>
				putch(' ', putdat);
  800903:	83 ec 08             	sub    $0x8,%esp
  800906:	ff 75 0c             	pushl  0xc(%ebp)
  800909:	6a 20                	push   $0x20
  80090b:	8b 45 08             	mov    0x8(%ebp),%eax
  80090e:	ff d0                	call   *%eax
  800910:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800913:	ff 4d e4             	decl   -0x1c(%ebp)
  800916:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80091a:	7f e7                	jg     800903 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80091c:	e9 66 01 00 00       	jmp    800a87 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800921:	83 ec 08             	sub    $0x8,%esp
  800924:	ff 75 e8             	pushl  -0x18(%ebp)
  800927:	8d 45 14             	lea    0x14(%ebp),%eax
  80092a:	50                   	push   %eax
  80092b:	e8 3c fd ff ff       	call   80066c <getint>
  800930:	83 c4 10             	add    $0x10,%esp
  800933:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800936:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800939:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80093f:	85 d2                	test   %edx,%edx
  800941:	79 23                	jns    800966 <vprintfmt+0x29b>
				putch('-', putdat);
  800943:	83 ec 08             	sub    $0x8,%esp
  800946:	ff 75 0c             	pushl  0xc(%ebp)
  800949:	6a 2d                	push   $0x2d
  80094b:	8b 45 08             	mov    0x8(%ebp),%eax
  80094e:	ff d0                	call   *%eax
  800950:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800953:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800956:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800959:	f7 d8                	neg    %eax
  80095b:	83 d2 00             	adc    $0x0,%edx
  80095e:	f7 da                	neg    %edx
  800960:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800963:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800966:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80096d:	e9 bc 00 00 00       	jmp    800a2e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800972:	83 ec 08             	sub    $0x8,%esp
  800975:	ff 75 e8             	pushl  -0x18(%ebp)
  800978:	8d 45 14             	lea    0x14(%ebp),%eax
  80097b:	50                   	push   %eax
  80097c:	e8 84 fc ff ff       	call   800605 <getuint>
  800981:	83 c4 10             	add    $0x10,%esp
  800984:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800987:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80098a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800991:	e9 98 00 00 00       	jmp    800a2e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800996:	83 ec 08             	sub    $0x8,%esp
  800999:	ff 75 0c             	pushl  0xc(%ebp)
  80099c:	6a 58                	push   $0x58
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	ff d0                	call   *%eax
  8009a3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009a6:	83 ec 08             	sub    $0x8,%esp
  8009a9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ac:	6a 58                	push   $0x58
  8009ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b1:	ff d0                	call   *%eax
  8009b3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b6:	83 ec 08             	sub    $0x8,%esp
  8009b9:	ff 75 0c             	pushl  0xc(%ebp)
  8009bc:	6a 58                	push   $0x58
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	ff d0                	call   *%eax
  8009c3:	83 c4 10             	add    $0x10,%esp
			break;
  8009c6:	e9 bc 00 00 00       	jmp    800a87 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	ff 75 0c             	pushl  0xc(%ebp)
  8009d1:	6a 30                	push   $0x30
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	ff d0                	call   *%eax
  8009d8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009db:	83 ec 08             	sub    $0x8,%esp
  8009de:	ff 75 0c             	pushl  0xc(%ebp)
  8009e1:	6a 78                	push   $0x78
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	ff d0                	call   *%eax
  8009e8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ee:	83 c0 04             	add    $0x4,%eax
  8009f1:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f7:	83 e8 04             	sub    $0x4,%eax
  8009fa:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a06:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a0d:	eb 1f                	jmp    800a2e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a0f:	83 ec 08             	sub    $0x8,%esp
  800a12:	ff 75 e8             	pushl  -0x18(%ebp)
  800a15:	8d 45 14             	lea    0x14(%ebp),%eax
  800a18:	50                   	push   %eax
  800a19:	e8 e7 fb ff ff       	call   800605 <getuint>
  800a1e:	83 c4 10             	add    $0x10,%esp
  800a21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a27:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a2e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a32:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a35:	83 ec 04             	sub    $0x4,%esp
  800a38:	52                   	push   %edx
  800a39:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a3c:	50                   	push   %eax
  800a3d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a40:	ff 75 f0             	pushl  -0x10(%ebp)
  800a43:	ff 75 0c             	pushl  0xc(%ebp)
  800a46:	ff 75 08             	pushl  0x8(%ebp)
  800a49:	e8 00 fb ff ff       	call   80054e <printnum>
  800a4e:	83 c4 20             	add    $0x20,%esp
			break;
  800a51:	eb 34                	jmp    800a87 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a53:	83 ec 08             	sub    $0x8,%esp
  800a56:	ff 75 0c             	pushl  0xc(%ebp)
  800a59:	53                   	push   %ebx
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	ff d0                	call   *%eax
  800a5f:	83 c4 10             	add    $0x10,%esp
			break;
  800a62:	eb 23                	jmp    800a87 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a64:	83 ec 08             	sub    $0x8,%esp
  800a67:	ff 75 0c             	pushl  0xc(%ebp)
  800a6a:	6a 25                	push   $0x25
  800a6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6f:	ff d0                	call   *%eax
  800a71:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a74:	ff 4d 10             	decl   0x10(%ebp)
  800a77:	eb 03                	jmp    800a7c <vprintfmt+0x3b1>
  800a79:	ff 4d 10             	decl   0x10(%ebp)
  800a7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a7f:	48                   	dec    %eax
  800a80:	8a 00                	mov    (%eax),%al
  800a82:	3c 25                	cmp    $0x25,%al
  800a84:	75 f3                	jne    800a79 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a86:	90                   	nop
		}
	}
  800a87:	e9 47 fc ff ff       	jmp    8006d3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a8c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a8d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a90:	5b                   	pop    %ebx
  800a91:	5e                   	pop    %esi
  800a92:	5d                   	pop    %ebp
  800a93:	c3                   	ret    

00800a94 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a94:	55                   	push   %ebp
  800a95:	89 e5                	mov    %esp,%ebp
  800a97:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a9a:	8d 45 10             	lea    0x10(%ebp),%eax
  800a9d:	83 c0 04             	add    $0x4,%eax
  800aa0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800aa3:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa6:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa9:	50                   	push   %eax
  800aaa:	ff 75 0c             	pushl  0xc(%ebp)
  800aad:	ff 75 08             	pushl  0x8(%ebp)
  800ab0:	e8 16 fc ff ff       	call   8006cb <vprintfmt>
  800ab5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ab8:	90                   	nop
  800ab9:	c9                   	leave  
  800aba:	c3                   	ret    

00800abb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800abe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac1:	8b 40 08             	mov    0x8(%eax),%eax
  800ac4:	8d 50 01             	lea    0x1(%eax),%edx
  800ac7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aca:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800acd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad0:	8b 10                	mov    (%eax),%edx
  800ad2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad5:	8b 40 04             	mov    0x4(%eax),%eax
  800ad8:	39 c2                	cmp    %eax,%edx
  800ada:	73 12                	jae    800aee <sprintputch+0x33>
		*b->buf++ = ch;
  800adc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	8d 48 01             	lea    0x1(%eax),%ecx
  800ae4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae7:	89 0a                	mov    %ecx,(%edx)
  800ae9:	8b 55 08             	mov    0x8(%ebp),%edx
  800aec:	88 10                	mov    %dl,(%eax)
}
  800aee:	90                   	nop
  800aef:	5d                   	pop    %ebp
  800af0:	c3                   	ret    

00800af1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800af1:	55                   	push   %ebp
  800af2:	89 e5                	mov    %esp,%ebp
  800af4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800afd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b00:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	01 d0                	add    %edx,%eax
  800b08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b12:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b16:	74 06                	je     800b1e <vsnprintf+0x2d>
  800b18:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1c:	7f 07                	jg     800b25 <vsnprintf+0x34>
		return -E_INVAL;
  800b1e:	b8 03 00 00 00       	mov    $0x3,%eax
  800b23:	eb 20                	jmp    800b45 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b25:	ff 75 14             	pushl  0x14(%ebp)
  800b28:	ff 75 10             	pushl  0x10(%ebp)
  800b2b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b2e:	50                   	push   %eax
  800b2f:	68 bb 0a 80 00       	push   $0x800abb
  800b34:	e8 92 fb ff ff       	call   8006cb <vprintfmt>
  800b39:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b3f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b45:	c9                   	leave  
  800b46:	c3                   	ret    

00800b47 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b47:	55                   	push   %ebp
  800b48:	89 e5                	mov    %esp,%ebp
  800b4a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b4d:	8d 45 10             	lea    0x10(%ebp),%eax
  800b50:	83 c0 04             	add    $0x4,%eax
  800b53:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b56:	8b 45 10             	mov    0x10(%ebp),%eax
  800b59:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5c:	50                   	push   %eax
  800b5d:	ff 75 0c             	pushl  0xc(%ebp)
  800b60:	ff 75 08             	pushl  0x8(%ebp)
  800b63:	e8 89 ff ff ff       	call   800af1 <vsnprintf>
  800b68:	83 c4 10             	add    $0x10,%esp
  800b6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b71:	c9                   	leave  
  800b72:	c3                   	ret    

00800b73 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b73:	55                   	push   %ebp
  800b74:	89 e5                	mov    %esp,%ebp
  800b76:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b80:	eb 06                	jmp    800b88 <strlen+0x15>
		n++;
  800b82:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b85:	ff 45 08             	incl   0x8(%ebp)
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8a 00                	mov    (%eax),%al
  800b8d:	84 c0                	test   %al,%al
  800b8f:	75 f1                	jne    800b82 <strlen+0xf>
		n++;
	return n;
  800b91:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b94:	c9                   	leave  
  800b95:	c3                   	ret    

00800b96 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b96:	55                   	push   %ebp
  800b97:	89 e5                	mov    %esp,%ebp
  800b99:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b9c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ba3:	eb 09                	jmp    800bae <strnlen+0x18>
		n++;
  800ba5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ba8:	ff 45 08             	incl   0x8(%ebp)
  800bab:	ff 4d 0c             	decl   0xc(%ebp)
  800bae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bb2:	74 09                	je     800bbd <strnlen+0x27>
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	8a 00                	mov    (%eax),%al
  800bb9:	84 c0                	test   %al,%al
  800bbb:	75 e8                	jne    800ba5 <strnlen+0xf>
		n++;
	return n;
  800bbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bc0:	c9                   	leave  
  800bc1:	c3                   	ret    

00800bc2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bc2:	55                   	push   %ebp
  800bc3:	89 e5                	mov    %esp,%ebp
  800bc5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bce:	90                   	nop
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd2:	8d 50 01             	lea    0x1(%eax),%edx
  800bd5:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bdb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bde:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800be1:	8a 12                	mov    (%edx),%dl
  800be3:	88 10                	mov    %dl,(%eax)
  800be5:	8a 00                	mov    (%eax),%al
  800be7:	84 c0                	test   %al,%al
  800be9:	75 e4                	jne    800bcf <strcpy+0xd>
		/* do nothing */;
	return ret;
  800beb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bee:	c9                   	leave  
  800bef:	c3                   	ret    

00800bf0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bf0:	55                   	push   %ebp
  800bf1:	89 e5                	mov    %esp,%ebp
  800bf3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bfc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c03:	eb 1f                	jmp    800c24 <strncpy+0x34>
		*dst++ = *src;
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	8d 50 01             	lea    0x1(%eax),%edx
  800c0b:	89 55 08             	mov    %edx,0x8(%ebp)
  800c0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c11:	8a 12                	mov    (%edx),%dl
  800c13:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c18:	8a 00                	mov    (%eax),%al
  800c1a:	84 c0                	test   %al,%al
  800c1c:	74 03                	je     800c21 <strncpy+0x31>
			src++;
  800c1e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c21:	ff 45 fc             	incl   -0x4(%ebp)
  800c24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c27:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c2a:	72 d9                	jb     800c05 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c2f:	c9                   	leave  
  800c30:	c3                   	ret    

00800c31 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c31:	55                   	push   %ebp
  800c32:	89 e5                	mov    %esp,%ebp
  800c34:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c3d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c41:	74 30                	je     800c73 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c43:	eb 16                	jmp    800c5b <strlcpy+0x2a>
			*dst++ = *src++;
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	8d 50 01             	lea    0x1(%eax),%edx
  800c4b:	89 55 08             	mov    %edx,0x8(%ebp)
  800c4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c51:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c54:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c57:	8a 12                	mov    (%edx),%dl
  800c59:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c5b:	ff 4d 10             	decl   0x10(%ebp)
  800c5e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c62:	74 09                	je     800c6d <strlcpy+0x3c>
  800c64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	84 c0                	test   %al,%al
  800c6b:	75 d8                	jne    800c45 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c73:	8b 55 08             	mov    0x8(%ebp),%edx
  800c76:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c79:	29 c2                	sub    %eax,%edx
  800c7b:	89 d0                	mov    %edx,%eax
}
  800c7d:	c9                   	leave  
  800c7e:	c3                   	ret    

00800c7f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c7f:	55                   	push   %ebp
  800c80:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c82:	eb 06                	jmp    800c8a <strcmp+0xb>
		p++, q++;
  800c84:	ff 45 08             	incl   0x8(%ebp)
  800c87:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	84 c0                	test   %al,%al
  800c91:	74 0e                	je     800ca1 <strcmp+0x22>
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	8a 10                	mov    (%eax),%dl
  800c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	38 c2                	cmp    %al,%dl
  800c9f:	74 e3                	je     800c84 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	0f b6 d0             	movzbl %al,%edx
  800ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	0f b6 c0             	movzbl %al,%eax
  800cb1:	29 c2                	sub    %eax,%edx
  800cb3:	89 d0                	mov    %edx,%eax
}
  800cb5:	5d                   	pop    %ebp
  800cb6:	c3                   	ret    

00800cb7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cb7:	55                   	push   %ebp
  800cb8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cba:	eb 09                	jmp    800cc5 <strncmp+0xe>
		n--, p++, q++;
  800cbc:	ff 4d 10             	decl   0x10(%ebp)
  800cbf:	ff 45 08             	incl   0x8(%ebp)
  800cc2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cc5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc9:	74 17                	je     800ce2 <strncmp+0x2b>
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	84 c0                	test   %al,%al
  800cd2:	74 0e                	je     800ce2 <strncmp+0x2b>
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8a 10                	mov    (%eax),%dl
  800cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	38 c2                	cmp    %al,%dl
  800ce0:	74 da                	je     800cbc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ce2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce6:	75 07                	jne    800cef <strncmp+0x38>
		return 0;
  800ce8:	b8 00 00 00 00       	mov    $0x0,%eax
  800ced:	eb 14                	jmp    800d03 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	0f b6 d0             	movzbl %al,%edx
  800cf7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	0f b6 c0             	movzbl %al,%eax
  800cff:	29 c2                	sub    %eax,%edx
  800d01:	89 d0                	mov    %edx,%eax
}
  800d03:	5d                   	pop    %ebp
  800d04:	c3                   	ret    

00800d05 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d05:	55                   	push   %ebp
  800d06:	89 e5                	mov    %esp,%ebp
  800d08:	83 ec 04             	sub    $0x4,%esp
  800d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d11:	eb 12                	jmp    800d25 <strchr+0x20>
		if (*s == c)
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d1b:	75 05                	jne    800d22 <strchr+0x1d>
			return (char *) s;
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	eb 11                	jmp    800d33 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d22:	ff 45 08             	incl   0x8(%ebp)
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8a 00                	mov    (%eax),%al
  800d2a:	84 c0                	test   %al,%al
  800d2c:	75 e5                	jne    800d13 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d33:	c9                   	leave  
  800d34:	c3                   	ret    

00800d35 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d35:	55                   	push   %ebp
  800d36:	89 e5                	mov    %esp,%ebp
  800d38:	83 ec 04             	sub    $0x4,%esp
  800d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d41:	eb 0d                	jmp    800d50 <strfind+0x1b>
		if (*s == c)
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d4b:	74 0e                	je     800d5b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d4d:	ff 45 08             	incl   0x8(%ebp)
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	8a 00                	mov    (%eax),%al
  800d55:	84 c0                	test   %al,%al
  800d57:	75 ea                	jne    800d43 <strfind+0xe>
  800d59:	eb 01                	jmp    800d5c <strfind+0x27>
		if (*s == c)
			break;
  800d5b:	90                   	nop
	return (char *) s;
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d5f:	c9                   	leave  
  800d60:	c3                   	ret    

00800d61 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d61:	55                   	push   %ebp
  800d62:	89 e5                	mov    %esp,%ebp
  800d64:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d73:	eb 0e                	jmp    800d83 <memset+0x22>
		*p++ = c;
  800d75:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d78:	8d 50 01             	lea    0x1(%eax),%edx
  800d7b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d81:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d83:	ff 4d f8             	decl   -0x8(%ebp)
  800d86:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d8a:	79 e9                	jns    800d75 <memset+0x14>
		*p++ = c;

	return v;
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d8f:	c9                   	leave  
  800d90:	c3                   	ret    

00800d91 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d91:	55                   	push   %ebp
  800d92:	89 e5                	mov    %esp,%ebp
  800d94:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800da3:	eb 16                	jmp    800dbb <memcpy+0x2a>
		*d++ = *s++;
  800da5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da8:	8d 50 01             	lea    0x1(%eax),%edx
  800dab:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dae:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800db1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800db4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800db7:	8a 12                	mov    (%edx),%dl
  800db9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dc1:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc4:	85 c0                	test   %eax,%eax
  800dc6:	75 dd                	jne    800da5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dcb:	c9                   	leave  
  800dcc:	c3                   	ret    

00800dcd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dcd:	55                   	push   %ebp
  800dce:	89 e5                	mov    %esp,%ebp
  800dd0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ddf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800de5:	73 50                	jae    800e37 <memmove+0x6a>
  800de7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dea:	8b 45 10             	mov    0x10(%ebp),%eax
  800ded:	01 d0                	add    %edx,%eax
  800def:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df2:	76 43                	jbe    800e37 <memmove+0x6a>
		s += n;
  800df4:	8b 45 10             	mov    0x10(%ebp),%eax
  800df7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dfa:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e00:	eb 10                	jmp    800e12 <memmove+0x45>
			*--d = *--s;
  800e02:	ff 4d f8             	decl   -0x8(%ebp)
  800e05:	ff 4d fc             	decl   -0x4(%ebp)
  800e08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e0b:	8a 10                	mov    (%eax),%dl
  800e0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e10:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e12:	8b 45 10             	mov    0x10(%ebp),%eax
  800e15:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e18:	89 55 10             	mov    %edx,0x10(%ebp)
  800e1b:	85 c0                	test   %eax,%eax
  800e1d:	75 e3                	jne    800e02 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e1f:	eb 23                	jmp    800e44 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e21:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e24:	8d 50 01             	lea    0x1(%eax),%edx
  800e27:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e2a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e2d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e30:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e33:	8a 12                	mov    (%edx),%dl
  800e35:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e37:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e40:	85 c0                	test   %eax,%eax
  800e42:	75 dd                	jne    800e21 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e47:	c9                   	leave  
  800e48:	c3                   	ret    

00800e49 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e49:	55                   	push   %ebp
  800e4a:	89 e5                	mov    %esp,%ebp
  800e4c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e58:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e5b:	eb 2a                	jmp    800e87 <memcmp+0x3e>
		if (*s1 != *s2)
  800e5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e60:	8a 10                	mov    (%eax),%dl
  800e62:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	38 c2                	cmp    %al,%dl
  800e69:	74 16                	je     800e81 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6e:	8a 00                	mov    (%eax),%al
  800e70:	0f b6 d0             	movzbl %al,%edx
  800e73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e76:	8a 00                	mov    (%eax),%al
  800e78:	0f b6 c0             	movzbl %al,%eax
  800e7b:	29 c2                	sub    %eax,%edx
  800e7d:	89 d0                	mov    %edx,%eax
  800e7f:	eb 18                	jmp    800e99 <memcmp+0x50>
		s1++, s2++;
  800e81:	ff 45 fc             	incl   -0x4(%ebp)
  800e84:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e87:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e8d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e90:	85 c0                	test   %eax,%eax
  800e92:	75 c9                	jne    800e5d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e99:	c9                   	leave  
  800e9a:	c3                   	ret    

00800e9b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e9b:	55                   	push   %ebp
  800e9c:	89 e5                	mov    %esp,%ebp
  800e9e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ea1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ea4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea7:	01 d0                	add    %edx,%eax
  800ea9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800eac:	eb 15                	jmp    800ec3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	0f b6 d0             	movzbl %al,%edx
  800eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb9:	0f b6 c0             	movzbl %al,%eax
  800ebc:	39 c2                	cmp    %eax,%edx
  800ebe:	74 0d                	je     800ecd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ec0:	ff 45 08             	incl   0x8(%ebp)
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ec9:	72 e3                	jb     800eae <memfind+0x13>
  800ecb:	eb 01                	jmp    800ece <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ecd:	90                   	nop
	return (void *) s;
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed1:	c9                   	leave  
  800ed2:	c3                   	ret    

00800ed3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ed3:	55                   	push   %ebp
  800ed4:	89 e5                	mov    %esp,%ebp
  800ed6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ed9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ee0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ee7:	eb 03                	jmp    800eec <strtol+0x19>
		s++;
  800ee9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	3c 20                	cmp    $0x20,%al
  800ef3:	74 f4                	je     800ee9 <strtol+0x16>
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	3c 09                	cmp    $0x9,%al
  800efc:	74 eb                	je     800ee9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	3c 2b                	cmp    $0x2b,%al
  800f05:	75 05                	jne    800f0c <strtol+0x39>
		s++;
  800f07:	ff 45 08             	incl   0x8(%ebp)
  800f0a:	eb 13                	jmp    800f1f <strtol+0x4c>
	else if (*s == '-')
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	3c 2d                	cmp    $0x2d,%al
  800f13:	75 0a                	jne    800f1f <strtol+0x4c>
		s++, neg = 1;
  800f15:	ff 45 08             	incl   0x8(%ebp)
  800f18:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f1f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f23:	74 06                	je     800f2b <strtol+0x58>
  800f25:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f29:	75 20                	jne    800f4b <strtol+0x78>
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	8a 00                	mov    (%eax),%al
  800f30:	3c 30                	cmp    $0x30,%al
  800f32:	75 17                	jne    800f4b <strtol+0x78>
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	40                   	inc    %eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	3c 78                	cmp    $0x78,%al
  800f3c:	75 0d                	jne    800f4b <strtol+0x78>
		s += 2, base = 16;
  800f3e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f42:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f49:	eb 28                	jmp    800f73 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f4b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4f:	75 15                	jne    800f66 <strtol+0x93>
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	8a 00                	mov    (%eax),%al
  800f56:	3c 30                	cmp    $0x30,%al
  800f58:	75 0c                	jne    800f66 <strtol+0x93>
		s++, base = 8;
  800f5a:	ff 45 08             	incl   0x8(%ebp)
  800f5d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f64:	eb 0d                	jmp    800f73 <strtol+0xa0>
	else if (base == 0)
  800f66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6a:	75 07                	jne    800f73 <strtol+0xa0>
		base = 10;
  800f6c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	3c 2f                	cmp    $0x2f,%al
  800f7a:	7e 19                	jle    800f95 <strtol+0xc2>
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	8a 00                	mov    (%eax),%al
  800f81:	3c 39                	cmp    $0x39,%al
  800f83:	7f 10                	jg     800f95 <strtol+0xc2>
			dig = *s - '0';
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	0f be c0             	movsbl %al,%eax
  800f8d:	83 e8 30             	sub    $0x30,%eax
  800f90:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f93:	eb 42                	jmp    800fd7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	3c 60                	cmp    $0x60,%al
  800f9c:	7e 19                	jle    800fb7 <strtol+0xe4>
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	8a 00                	mov    (%eax),%al
  800fa3:	3c 7a                	cmp    $0x7a,%al
  800fa5:	7f 10                	jg     800fb7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	0f be c0             	movsbl %al,%eax
  800faf:	83 e8 57             	sub    $0x57,%eax
  800fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb5:	eb 20                	jmp    800fd7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	3c 40                	cmp    $0x40,%al
  800fbe:	7e 39                	jle    800ff9 <strtol+0x126>
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	3c 5a                	cmp    $0x5a,%al
  800fc7:	7f 30                	jg     800ff9 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	0f be c0             	movsbl %al,%eax
  800fd1:	83 e8 37             	sub    $0x37,%eax
  800fd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fda:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fdd:	7d 19                	jge    800ff8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fdf:	ff 45 08             	incl   0x8(%ebp)
  800fe2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe5:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fe9:	89 c2                	mov    %eax,%edx
  800feb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fee:	01 d0                	add    %edx,%eax
  800ff0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ff3:	e9 7b ff ff ff       	jmp    800f73 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800ff8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800ff9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffd:	74 08                	je     801007 <strtol+0x134>
		*endptr = (char *) s;
  800fff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801002:	8b 55 08             	mov    0x8(%ebp),%edx
  801005:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801007:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80100b:	74 07                	je     801014 <strtol+0x141>
  80100d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801010:	f7 d8                	neg    %eax
  801012:	eb 03                	jmp    801017 <strtol+0x144>
  801014:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801017:	c9                   	leave  
  801018:	c3                   	ret    

00801019 <ltostr>:

void
ltostr(long value, char *str)
{
  801019:	55                   	push   %ebp
  80101a:	89 e5                	mov    %esp,%ebp
  80101c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80101f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801026:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80102d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801031:	79 13                	jns    801046 <ltostr+0x2d>
	{
		neg = 1;
  801033:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80103a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801040:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801043:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80104e:	99                   	cltd   
  80104f:	f7 f9                	idiv   %ecx
  801051:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801054:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801057:	8d 50 01             	lea    0x1(%eax),%edx
  80105a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80105d:	89 c2                	mov    %eax,%edx
  80105f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801062:	01 d0                	add    %edx,%eax
  801064:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801067:	83 c2 30             	add    $0x30,%edx
  80106a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80106c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80106f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801074:	f7 e9                	imul   %ecx
  801076:	c1 fa 02             	sar    $0x2,%edx
  801079:	89 c8                	mov    %ecx,%eax
  80107b:	c1 f8 1f             	sar    $0x1f,%eax
  80107e:	29 c2                	sub    %eax,%edx
  801080:	89 d0                	mov    %edx,%eax
  801082:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801085:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801088:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80108d:	f7 e9                	imul   %ecx
  80108f:	c1 fa 02             	sar    $0x2,%edx
  801092:	89 c8                	mov    %ecx,%eax
  801094:	c1 f8 1f             	sar    $0x1f,%eax
  801097:	29 c2                	sub    %eax,%edx
  801099:	89 d0                	mov    %edx,%eax
  80109b:	c1 e0 02             	shl    $0x2,%eax
  80109e:	01 d0                	add    %edx,%eax
  8010a0:	01 c0                	add    %eax,%eax
  8010a2:	29 c1                	sub    %eax,%ecx
  8010a4:	89 ca                	mov    %ecx,%edx
  8010a6:	85 d2                	test   %edx,%edx
  8010a8:	75 9c                	jne    801046 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b4:	48                   	dec    %eax
  8010b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010b8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010bc:	74 3d                	je     8010fb <ltostr+0xe2>
		start = 1 ;
  8010be:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010c5:	eb 34                	jmp    8010fb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cd:	01 d0                	add    %edx,%eax
  8010cf:	8a 00                	mov    (%eax),%al
  8010d1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010da:	01 c2                	add    %eax,%edx
  8010dc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	01 c8                	add    %ecx,%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010e8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ee:	01 c2                	add    %eax,%edx
  8010f0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010f3:	88 02                	mov    %al,(%edx)
		start++ ;
  8010f5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010f8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801101:	7c c4                	jl     8010c7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801103:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801106:	8b 45 0c             	mov    0xc(%ebp),%eax
  801109:	01 d0                	add    %edx,%eax
  80110b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80110e:	90                   	nop
  80110f:	c9                   	leave  
  801110:	c3                   	ret    

00801111 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801111:	55                   	push   %ebp
  801112:	89 e5                	mov    %esp,%ebp
  801114:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801117:	ff 75 08             	pushl  0x8(%ebp)
  80111a:	e8 54 fa ff ff       	call   800b73 <strlen>
  80111f:	83 c4 04             	add    $0x4,%esp
  801122:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801125:	ff 75 0c             	pushl  0xc(%ebp)
  801128:	e8 46 fa ff ff       	call   800b73 <strlen>
  80112d:	83 c4 04             	add    $0x4,%esp
  801130:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801133:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80113a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801141:	eb 17                	jmp    80115a <strcconcat+0x49>
		final[s] = str1[s] ;
  801143:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801146:	8b 45 10             	mov    0x10(%ebp),%eax
  801149:	01 c2                	add    %eax,%edx
  80114b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	01 c8                	add    %ecx,%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801157:	ff 45 fc             	incl   -0x4(%ebp)
  80115a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801160:	7c e1                	jl     801143 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801162:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801169:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801170:	eb 1f                	jmp    801191 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801172:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801175:	8d 50 01             	lea    0x1(%eax),%edx
  801178:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80117b:	89 c2                	mov    %eax,%edx
  80117d:	8b 45 10             	mov    0x10(%ebp),%eax
  801180:	01 c2                	add    %eax,%edx
  801182:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801185:	8b 45 0c             	mov    0xc(%ebp),%eax
  801188:	01 c8                	add    %ecx,%eax
  80118a:	8a 00                	mov    (%eax),%al
  80118c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80118e:	ff 45 f8             	incl   -0x8(%ebp)
  801191:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801194:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801197:	7c d9                	jl     801172 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801199:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80119c:	8b 45 10             	mov    0x10(%ebp),%eax
  80119f:	01 d0                	add    %edx,%eax
  8011a1:	c6 00 00             	movb   $0x0,(%eax)
}
  8011a4:	90                   	nop
  8011a5:	c9                   	leave  
  8011a6:	c3                   	ret    

008011a7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011a7:	55                   	push   %ebp
  8011a8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b6:	8b 00                	mov    (%eax),%eax
  8011b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c2:	01 d0                	add    %edx,%eax
  8011c4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ca:	eb 0c                	jmp    8011d8 <strsplit+0x31>
			*string++ = 0;
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	8d 50 01             	lea    0x1(%eax),%edx
  8011d2:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	84 c0                	test   %al,%al
  8011df:	74 18                	je     8011f9 <strsplit+0x52>
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	0f be c0             	movsbl %al,%eax
  8011e9:	50                   	push   %eax
  8011ea:	ff 75 0c             	pushl  0xc(%ebp)
  8011ed:	e8 13 fb ff ff       	call   800d05 <strchr>
  8011f2:	83 c4 08             	add    $0x8,%esp
  8011f5:	85 c0                	test   %eax,%eax
  8011f7:	75 d3                	jne    8011cc <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	8a 00                	mov    (%eax),%al
  8011fe:	84 c0                	test   %al,%al
  801200:	74 5a                	je     80125c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801202:	8b 45 14             	mov    0x14(%ebp),%eax
  801205:	8b 00                	mov    (%eax),%eax
  801207:	83 f8 0f             	cmp    $0xf,%eax
  80120a:	75 07                	jne    801213 <strsplit+0x6c>
		{
			return 0;
  80120c:	b8 00 00 00 00       	mov    $0x0,%eax
  801211:	eb 66                	jmp    801279 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801213:	8b 45 14             	mov    0x14(%ebp),%eax
  801216:	8b 00                	mov    (%eax),%eax
  801218:	8d 48 01             	lea    0x1(%eax),%ecx
  80121b:	8b 55 14             	mov    0x14(%ebp),%edx
  80121e:	89 0a                	mov    %ecx,(%edx)
  801220:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801227:	8b 45 10             	mov    0x10(%ebp),%eax
  80122a:	01 c2                	add    %eax,%edx
  80122c:	8b 45 08             	mov    0x8(%ebp),%eax
  80122f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801231:	eb 03                	jmp    801236 <strsplit+0x8f>
			string++;
  801233:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	8a 00                	mov    (%eax),%al
  80123b:	84 c0                	test   %al,%al
  80123d:	74 8b                	je     8011ca <strsplit+0x23>
  80123f:	8b 45 08             	mov    0x8(%ebp),%eax
  801242:	8a 00                	mov    (%eax),%al
  801244:	0f be c0             	movsbl %al,%eax
  801247:	50                   	push   %eax
  801248:	ff 75 0c             	pushl  0xc(%ebp)
  80124b:	e8 b5 fa ff ff       	call   800d05 <strchr>
  801250:	83 c4 08             	add    $0x8,%esp
  801253:	85 c0                	test   %eax,%eax
  801255:	74 dc                	je     801233 <strsplit+0x8c>
			string++;
	}
  801257:	e9 6e ff ff ff       	jmp    8011ca <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80125c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80125d:	8b 45 14             	mov    0x14(%ebp),%eax
  801260:	8b 00                	mov    (%eax),%eax
  801262:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801269:	8b 45 10             	mov    0x10(%ebp),%eax
  80126c:	01 d0                	add    %edx,%eax
  80126e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801274:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
  80127e:	83 ec 18             	sub    $0x18,%esp
  801281:	8b 45 10             	mov    0x10(%ebp),%eax
  801284:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801287:	83 ec 04             	sub    $0x4,%esp
  80128a:	68 b0 24 80 00       	push   $0x8024b0
  80128f:	6a 17                	push   $0x17
  801291:	68 cf 24 80 00       	push   $0x8024cf
  801296:	e8 a2 ef ff ff       	call   80023d <_panic>

0080129b <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
  80129e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8012a1:	83 ec 04             	sub    $0x4,%esp
  8012a4:	68 db 24 80 00       	push   $0x8024db
  8012a9:	6a 2f                	push   $0x2f
  8012ab:	68 cf 24 80 00       	push   $0x8024cf
  8012b0:	e8 88 ef ff ff       	call   80023d <_panic>

008012b5 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
  8012b8:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8012bb:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8012c2:	8b 55 08             	mov    0x8(%ebp),%edx
  8012c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012c8:	01 d0                	add    %edx,%eax
  8012ca:	48                   	dec    %eax
  8012cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8012ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8012d1:	ba 00 00 00 00       	mov    $0x0,%edx
  8012d6:	f7 75 ec             	divl   -0x14(%ebp)
  8012d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8012dc:	29 d0                	sub    %edx,%eax
  8012de:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	c1 e8 0c             	shr    $0xc,%eax
  8012e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8012ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8012f1:	e9 c8 00 00 00       	jmp    8013be <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8012f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8012fd:	eb 27                	jmp    801326 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8012ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801302:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801305:	01 c2                	add    %eax,%edx
  801307:	89 d0                	mov    %edx,%eax
  801309:	01 c0                	add    %eax,%eax
  80130b:	01 d0                	add    %edx,%eax
  80130d:	c1 e0 02             	shl    $0x2,%eax
  801310:	05 48 30 80 00       	add    $0x803048,%eax
  801315:	8b 00                	mov    (%eax),%eax
  801317:	85 c0                	test   %eax,%eax
  801319:	74 08                	je     801323 <malloc+0x6e>
            	i += j;
  80131b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80131e:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801321:	eb 0b                	jmp    80132e <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801323:	ff 45 f0             	incl   -0x10(%ebp)
  801326:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801329:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80132c:	72 d1                	jb     8012ff <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80132e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801331:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801334:	0f 85 81 00 00 00    	jne    8013bb <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80133a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80133d:	05 00 00 08 00       	add    $0x80000,%eax
  801342:	c1 e0 0c             	shl    $0xc,%eax
  801345:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801348:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80134f:	eb 1f                	jmp    801370 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801351:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801354:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801357:	01 c2                	add    %eax,%edx
  801359:	89 d0                	mov    %edx,%eax
  80135b:	01 c0                	add    %eax,%eax
  80135d:	01 d0                	add    %edx,%eax
  80135f:	c1 e0 02             	shl    $0x2,%eax
  801362:	05 48 30 80 00       	add    $0x803048,%eax
  801367:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80136d:	ff 45 f0             	incl   -0x10(%ebp)
  801370:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801373:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801376:	72 d9                	jb     801351 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801378:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80137b:	89 d0                	mov    %edx,%eax
  80137d:	01 c0                	add    %eax,%eax
  80137f:	01 d0                	add    %edx,%eax
  801381:	c1 e0 02             	shl    $0x2,%eax
  801384:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80138a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80138d:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80138f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801392:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801395:	89 c8                	mov    %ecx,%eax
  801397:	01 c0                	add    %eax,%eax
  801399:	01 c8                	add    %ecx,%eax
  80139b:	c1 e0 02             	shl    $0x2,%eax
  80139e:	05 44 30 80 00       	add    $0x803044,%eax
  8013a3:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8013a5:	83 ec 08             	sub    $0x8,%esp
  8013a8:	ff 75 08             	pushl  0x8(%ebp)
  8013ab:	ff 75 e0             	pushl  -0x20(%ebp)
  8013ae:	e8 2b 03 00 00       	call   8016de <sys_allocateMem>
  8013b3:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8013b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8013b9:	eb 19                	jmp    8013d4 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8013bb:	ff 45 f4             	incl   -0xc(%ebp)
  8013be:	a1 04 30 80 00       	mov    0x803004,%eax
  8013c3:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8013c6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013c9:	0f 83 27 ff ff ff    	jae    8012f6 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8013cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
  8013d9:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8013dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013e0:	0f 84 e5 00 00 00    	je     8014cb <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8013ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013ef:	05 00 00 00 80       	add    $0x80000000,%eax
  8013f4:	c1 e8 0c             	shr    $0xc,%eax
  8013f7:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8013fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013fd:	89 d0                	mov    %edx,%eax
  8013ff:	01 c0                	add    %eax,%eax
  801401:	01 d0                	add    %edx,%eax
  801403:	c1 e0 02             	shl    $0x2,%eax
  801406:	05 40 30 80 00       	add    $0x803040,%eax
  80140b:	8b 00                	mov    (%eax),%eax
  80140d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801410:	0f 85 b8 00 00 00    	jne    8014ce <free+0xf8>
  801416:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801419:	89 d0                	mov    %edx,%eax
  80141b:	01 c0                	add    %eax,%eax
  80141d:	01 d0                	add    %edx,%eax
  80141f:	c1 e0 02             	shl    $0x2,%eax
  801422:	05 48 30 80 00       	add    $0x803048,%eax
  801427:	8b 00                	mov    (%eax),%eax
  801429:	85 c0                	test   %eax,%eax
  80142b:	0f 84 9d 00 00 00    	je     8014ce <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801431:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801434:	89 d0                	mov    %edx,%eax
  801436:	01 c0                	add    %eax,%eax
  801438:	01 d0                	add    %edx,%eax
  80143a:	c1 e0 02             	shl    $0x2,%eax
  80143d:	05 44 30 80 00       	add    $0x803044,%eax
  801442:	8b 00                	mov    (%eax),%eax
  801444:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801447:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80144a:	c1 e0 0c             	shl    $0xc,%eax
  80144d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801450:	83 ec 08             	sub    $0x8,%esp
  801453:	ff 75 e4             	pushl  -0x1c(%ebp)
  801456:	ff 75 f0             	pushl  -0x10(%ebp)
  801459:	e8 64 02 00 00       	call   8016c2 <sys_freeMem>
  80145e:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801461:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801468:	eb 57                	jmp    8014c1 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80146a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801470:	01 c2                	add    %eax,%edx
  801472:	89 d0                	mov    %edx,%eax
  801474:	01 c0                	add    %eax,%eax
  801476:	01 d0                	add    %edx,%eax
  801478:	c1 e0 02             	shl    $0x2,%eax
  80147b:	05 48 30 80 00       	add    $0x803048,%eax
  801480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801486:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801489:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80148c:	01 c2                	add    %eax,%edx
  80148e:	89 d0                	mov    %edx,%eax
  801490:	01 c0                	add    %eax,%eax
  801492:	01 d0                	add    %edx,%eax
  801494:	c1 e0 02             	shl    $0x2,%eax
  801497:	05 40 30 80 00       	add    $0x803040,%eax
  80149c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8014a2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a8:	01 c2                	add    %eax,%edx
  8014aa:	89 d0                	mov    %edx,%eax
  8014ac:	01 c0                	add    %eax,%eax
  8014ae:	01 d0                	add    %edx,%eax
  8014b0:	c1 e0 02             	shl    $0x2,%eax
  8014b3:	05 44 30 80 00       	add    $0x803044,%eax
  8014b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8014be:	ff 45 f4             	incl   -0xc(%ebp)
  8014c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014c4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8014c7:	7c a1                	jl     80146a <free+0x94>
  8014c9:	eb 04                	jmp    8014cf <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8014cb:	90                   	nop
  8014cc:	eb 01                	jmp    8014cf <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8014ce:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
  8014d4:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8014d7:	83 ec 04             	sub    $0x4,%esp
  8014da:	68 f8 24 80 00       	push   $0x8024f8
  8014df:	68 ae 00 00 00       	push   $0xae
  8014e4:	68 cf 24 80 00       	push   $0x8024cf
  8014e9:	e8 4f ed ff ff       	call   80023d <_panic>

008014ee <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
  8014f1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8014f4:	83 ec 04             	sub    $0x4,%esp
  8014f7:	68 18 25 80 00       	push   $0x802518
  8014fc:	68 ca 00 00 00       	push   $0xca
  801501:	68 cf 24 80 00       	push   $0x8024cf
  801506:	e8 32 ed ff ff       	call   80023d <_panic>

0080150b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
  80150e:	57                   	push   %edi
  80150f:	56                   	push   %esi
  801510:	53                   	push   %ebx
  801511:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	8b 55 0c             	mov    0xc(%ebp),%edx
  80151a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80151d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801520:	8b 7d 18             	mov    0x18(%ebp),%edi
  801523:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801526:	cd 30                	int    $0x30
  801528:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80152b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80152e:	83 c4 10             	add    $0x10,%esp
  801531:	5b                   	pop    %ebx
  801532:	5e                   	pop    %esi
  801533:	5f                   	pop    %edi
  801534:	5d                   	pop    %ebp
  801535:	c3                   	ret    

00801536 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801536:	55                   	push   %ebp
  801537:	89 e5                	mov    %esp,%ebp
  801539:	83 ec 04             	sub    $0x4,%esp
  80153c:	8b 45 10             	mov    0x10(%ebp),%eax
  80153f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801542:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	52                   	push   %edx
  80154e:	ff 75 0c             	pushl  0xc(%ebp)
  801551:	50                   	push   %eax
  801552:	6a 00                	push   $0x0
  801554:	e8 b2 ff ff ff       	call   80150b <syscall>
  801559:	83 c4 18             	add    $0x18,%esp
}
  80155c:	90                   	nop
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <sys_cgetc>:

int
sys_cgetc(void)
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 01                	push   $0x1
  80156e:	e8 98 ff ff ff       	call   80150b <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	50                   	push   %eax
  801587:	6a 05                	push   $0x5
  801589:	e8 7d ff ff ff       	call   80150b <syscall>
  80158e:	83 c4 18             	add    $0x18,%esp
}
  801591:	c9                   	leave  
  801592:	c3                   	ret    

00801593 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 02                	push   $0x2
  8015a2:	e8 64 ff ff ff       	call   80150b <syscall>
  8015a7:	83 c4 18             	add    $0x18,%esp
}
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 03                	push   $0x3
  8015bb:	e8 4b ff ff ff       	call   80150b <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 04                	push   $0x4
  8015d4:	e8 32 ff ff ff       	call   80150b <syscall>
  8015d9:	83 c4 18             	add    $0x18,%esp
}
  8015dc:	c9                   	leave  
  8015dd:	c3                   	ret    

008015de <sys_env_exit>:


void sys_env_exit(void)
{
  8015de:	55                   	push   %ebp
  8015df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 06                	push   $0x6
  8015ed:	e8 19 ff ff ff       	call   80150b <syscall>
  8015f2:	83 c4 18             	add    $0x18,%esp
}
  8015f5:	90                   	nop
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	52                   	push   %edx
  801608:	50                   	push   %eax
  801609:	6a 07                	push   $0x7
  80160b:	e8 fb fe ff ff       	call   80150b <syscall>
  801610:	83 c4 18             	add    $0x18,%esp
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
  801618:	56                   	push   %esi
  801619:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80161a:	8b 75 18             	mov    0x18(%ebp),%esi
  80161d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801620:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801623:	8b 55 0c             	mov    0xc(%ebp),%edx
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	56                   	push   %esi
  80162a:	53                   	push   %ebx
  80162b:	51                   	push   %ecx
  80162c:	52                   	push   %edx
  80162d:	50                   	push   %eax
  80162e:	6a 08                	push   $0x8
  801630:	e8 d6 fe ff ff       	call   80150b <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80163b:	5b                   	pop    %ebx
  80163c:	5e                   	pop    %esi
  80163d:	5d                   	pop    %ebp
  80163e:	c3                   	ret    

0080163f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80163f:	55                   	push   %ebp
  801640:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801642:	8b 55 0c             	mov    0xc(%ebp),%edx
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	52                   	push   %edx
  80164f:	50                   	push   %eax
  801650:	6a 09                	push   $0x9
  801652:	e8 b4 fe ff ff       	call   80150b <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	ff 75 0c             	pushl  0xc(%ebp)
  801668:	ff 75 08             	pushl  0x8(%ebp)
  80166b:	6a 0a                	push   $0xa
  80166d:	e8 99 fe ff ff       	call   80150b <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
}
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 0b                	push   $0xb
  801686:	e8 80 fe ff ff       	call   80150b <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 0c                	push   $0xc
  80169f:	e8 67 fe ff ff       	call   80150b <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
}
  8016a7:	c9                   	leave  
  8016a8:	c3                   	ret    

008016a9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 0d                	push   $0xd
  8016b8:	e8 4e fe ff ff       	call   80150b <syscall>
  8016bd:	83 c4 18             	add    $0x18,%esp
}
  8016c0:	c9                   	leave  
  8016c1:	c3                   	ret    

008016c2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016c2:	55                   	push   %ebp
  8016c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	ff 75 0c             	pushl  0xc(%ebp)
  8016ce:	ff 75 08             	pushl  0x8(%ebp)
  8016d1:	6a 11                	push   $0x11
  8016d3:	e8 33 fe ff ff       	call   80150b <syscall>
  8016d8:	83 c4 18             	add    $0x18,%esp
	return;
  8016db:	90                   	nop
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	ff 75 0c             	pushl  0xc(%ebp)
  8016ea:	ff 75 08             	pushl  0x8(%ebp)
  8016ed:	6a 12                	push   $0x12
  8016ef:	e8 17 fe ff ff       	call   80150b <syscall>
  8016f4:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f7:	90                   	nop
}
  8016f8:	c9                   	leave  
  8016f9:	c3                   	ret    

008016fa <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016fa:	55                   	push   %ebp
  8016fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 0e                	push   $0xe
  801709:	e8 fd fd ff ff       	call   80150b <syscall>
  80170e:	83 c4 18             	add    $0x18,%esp
}
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	ff 75 08             	pushl  0x8(%ebp)
  801721:	6a 0f                	push   $0xf
  801723:	e8 e3 fd ff ff       	call   80150b <syscall>
  801728:	83 c4 18             	add    $0x18,%esp
}
  80172b:	c9                   	leave  
  80172c:	c3                   	ret    

0080172d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 10                	push   $0x10
  80173c:	e8 ca fd ff ff       	call   80150b <syscall>
  801741:	83 c4 18             	add    $0x18,%esp
}
  801744:	90                   	nop
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 14                	push   $0x14
  801756:	e8 b0 fd ff ff       	call   80150b <syscall>
  80175b:	83 c4 18             	add    $0x18,%esp
}
  80175e:	90                   	nop
  80175f:	c9                   	leave  
  801760:	c3                   	ret    

00801761 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801761:	55                   	push   %ebp
  801762:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 15                	push   $0x15
  801770:	e8 96 fd ff ff       	call   80150b <syscall>
  801775:	83 c4 18             	add    $0x18,%esp
}
  801778:	90                   	nop
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sys_cputc>:


void
sys_cputc(const char c)
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
  80177e:	83 ec 04             	sub    $0x4,%esp
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801787:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	50                   	push   %eax
  801794:	6a 16                	push   $0x16
  801796:	e8 70 fd ff ff       	call   80150b <syscall>
  80179b:	83 c4 18             	add    $0x18,%esp
}
  80179e:	90                   	nop
  80179f:	c9                   	leave  
  8017a0:	c3                   	ret    

008017a1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017a1:	55                   	push   %ebp
  8017a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 17                	push   $0x17
  8017b0:	e8 56 fd ff ff       	call   80150b <syscall>
  8017b5:	83 c4 18             	add    $0x18,%esp
}
  8017b8:	90                   	nop
  8017b9:	c9                   	leave  
  8017ba:	c3                   	ret    

008017bb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017bb:	55                   	push   %ebp
  8017bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017be:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	ff 75 0c             	pushl  0xc(%ebp)
  8017ca:	50                   	push   %eax
  8017cb:	6a 18                	push   $0x18
  8017cd:	e8 39 fd ff ff       	call   80150b <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
}
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	52                   	push   %edx
  8017e7:	50                   	push   %eax
  8017e8:	6a 1b                	push   $0x1b
  8017ea:	e8 1c fd ff ff       	call   80150b <syscall>
  8017ef:	83 c4 18             	add    $0x18,%esp
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	52                   	push   %edx
  801804:	50                   	push   %eax
  801805:	6a 19                	push   $0x19
  801807:	e8 ff fc ff ff       	call   80150b <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	90                   	nop
  801810:	c9                   	leave  
  801811:	c3                   	ret    

00801812 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801812:	55                   	push   %ebp
  801813:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801815:	8b 55 0c             	mov    0xc(%ebp),%edx
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	52                   	push   %edx
  801822:	50                   	push   %eax
  801823:	6a 1a                	push   $0x1a
  801825:	e8 e1 fc ff ff       	call   80150b <syscall>
  80182a:	83 c4 18             	add    $0x18,%esp
}
  80182d:	90                   	nop
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
  801833:	83 ec 04             	sub    $0x4,%esp
  801836:	8b 45 10             	mov    0x10(%ebp),%eax
  801839:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80183c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80183f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	6a 00                	push   $0x0
  801848:	51                   	push   %ecx
  801849:	52                   	push   %edx
  80184a:	ff 75 0c             	pushl  0xc(%ebp)
  80184d:	50                   	push   %eax
  80184e:	6a 1c                	push   $0x1c
  801850:	e8 b6 fc ff ff       	call   80150b <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80185d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	52                   	push   %edx
  80186a:	50                   	push   %eax
  80186b:	6a 1d                	push   $0x1d
  80186d:	e8 99 fc ff ff       	call   80150b <syscall>
  801872:	83 c4 18             	add    $0x18,%esp
}
  801875:	c9                   	leave  
  801876:	c3                   	ret    

00801877 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80187a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80187d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	51                   	push   %ecx
  801888:	52                   	push   %edx
  801889:	50                   	push   %eax
  80188a:	6a 1e                	push   $0x1e
  80188c:	e8 7a fc ff ff       	call   80150b <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
}
  801894:	c9                   	leave  
  801895:	c3                   	ret    

00801896 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801899:	8b 55 0c             	mov    0xc(%ebp),%edx
  80189c:	8b 45 08             	mov    0x8(%ebp),%eax
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	52                   	push   %edx
  8018a6:	50                   	push   %eax
  8018a7:	6a 1f                	push   $0x1f
  8018a9:	e8 5d fc ff ff       	call   80150b <syscall>
  8018ae:	83 c4 18             	add    $0x18,%esp
}
  8018b1:	c9                   	leave  
  8018b2:	c3                   	ret    

008018b3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018b3:	55                   	push   %ebp
  8018b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 20                	push   $0x20
  8018c2:	e8 44 fc ff ff       	call   80150b <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
}
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8018cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	ff 75 10             	pushl  0x10(%ebp)
  8018d9:	ff 75 0c             	pushl  0xc(%ebp)
  8018dc:	50                   	push   %eax
  8018dd:	6a 21                	push   $0x21
  8018df:	e8 27 fc ff ff       	call   80150b <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
}
  8018e7:	c9                   	leave  
  8018e8:	c3                   	ret    

008018e9 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018e9:	55                   	push   %ebp
  8018ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	50                   	push   %eax
  8018f8:	6a 22                	push   $0x22
  8018fa:	e8 0c fc ff ff       	call   80150b <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
}
  801902:	90                   	nop
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801908:	8b 45 08             	mov    0x8(%ebp),%eax
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	50                   	push   %eax
  801914:	6a 23                	push   $0x23
  801916:	e8 f0 fb ff ff       	call   80150b <syscall>
  80191b:	83 c4 18             	add    $0x18,%esp
}
  80191e:	90                   	nop
  80191f:	c9                   	leave  
  801920:	c3                   	ret    

00801921 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
  801924:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801927:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80192a:	8d 50 04             	lea    0x4(%eax),%edx
  80192d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	52                   	push   %edx
  801937:	50                   	push   %eax
  801938:	6a 24                	push   $0x24
  80193a:	e8 cc fb ff ff       	call   80150b <syscall>
  80193f:	83 c4 18             	add    $0x18,%esp
	return result;
  801942:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801945:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801948:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80194b:	89 01                	mov    %eax,(%ecx)
  80194d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801950:	8b 45 08             	mov    0x8(%ebp),%eax
  801953:	c9                   	leave  
  801954:	c2 04 00             	ret    $0x4

00801957 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	ff 75 10             	pushl  0x10(%ebp)
  801961:	ff 75 0c             	pushl  0xc(%ebp)
  801964:	ff 75 08             	pushl  0x8(%ebp)
  801967:	6a 13                	push   $0x13
  801969:	e8 9d fb ff ff       	call   80150b <syscall>
  80196e:	83 c4 18             	add    $0x18,%esp
	return ;
  801971:	90                   	nop
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <sys_rcr2>:
uint32 sys_rcr2()
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 25                	push   $0x25
  801983:	e8 83 fb ff ff       	call   80150b <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
}
  80198b:	c9                   	leave  
  80198c:	c3                   	ret    

0080198d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
  801990:	83 ec 04             	sub    $0x4,%esp
  801993:	8b 45 08             	mov    0x8(%ebp),%eax
  801996:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801999:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	50                   	push   %eax
  8019a6:	6a 26                	push   $0x26
  8019a8:	e8 5e fb ff ff       	call   80150b <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b0:	90                   	nop
}
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <rsttst>:
void rsttst()
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 28                	push   $0x28
  8019c2:	e8 44 fb ff ff       	call   80150b <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ca:	90                   	nop
}
  8019cb:	c9                   	leave  
  8019cc:	c3                   	ret    

008019cd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019cd:	55                   	push   %ebp
  8019ce:	89 e5                	mov    %esp,%ebp
  8019d0:	83 ec 04             	sub    $0x4,%esp
  8019d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019d9:	8b 55 18             	mov    0x18(%ebp),%edx
  8019dc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019e0:	52                   	push   %edx
  8019e1:	50                   	push   %eax
  8019e2:	ff 75 10             	pushl  0x10(%ebp)
  8019e5:	ff 75 0c             	pushl  0xc(%ebp)
  8019e8:	ff 75 08             	pushl  0x8(%ebp)
  8019eb:	6a 27                	push   $0x27
  8019ed:	e8 19 fb ff ff       	call   80150b <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f5:	90                   	nop
}
  8019f6:	c9                   	leave  
  8019f7:	c3                   	ret    

008019f8 <chktst>:
void chktst(uint32 n)
{
  8019f8:	55                   	push   %ebp
  8019f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	ff 75 08             	pushl  0x8(%ebp)
  801a06:	6a 29                	push   $0x29
  801a08:	e8 fe fa ff ff       	call   80150b <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a10:	90                   	nop
}
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <inctst>:

void inctst()
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 2a                	push   $0x2a
  801a22:	e8 e4 fa ff ff       	call   80150b <syscall>
  801a27:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2a:	90                   	nop
}
  801a2b:	c9                   	leave  
  801a2c:	c3                   	ret    

00801a2d <gettst>:
uint32 gettst()
{
  801a2d:	55                   	push   %ebp
  801a2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 2b                	push   $0x2b
  801a3c:	e8 ca fa ff ff       	call   80150b <syscall>
  801a41:	83 c4 18             	add    $0x18,%esp
}
  801a44:	c9                   	leave  
  801a45:	c3                   	ret    

00801a46 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 2c                	push   $0x2c
  801a58:	e8 ae fa ff ff       	call   80150b <syscall>
  801a5d:	83 c4 18             	add    $0x18,%esp
  801a60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a63:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a67:	75 07                	jne    801a70 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a69:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6e:	eb 05                	jmp    801a75 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a70:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
  801a7a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 2c                	push   $0x2c
  801a89:	e8 7d fa ff ff       	call   80150b <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
  801a91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a94:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a98:	75 07                	jne    801aa1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9f:	eb 05                	jmp    801aa6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801aa1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
  801aab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 2c                	push   $0x2c
  801aba:	e8 4c fa ff ff       	call   80150b <syscall>
  801abf:	83 c4 18             	add    $0x18,%esp
  801ac2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ac5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ac9:	75 07                	jne    801ad2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801acb:	b8 01 00 00 00       	mov    $0x1,%eax
  801ad0:	eb 05                	jmp    801ad7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ad2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad7:	c9                   	leave  
  801ad8:	c3                   	ret    

00801ad9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ad9:	55                   	push   %ebp
  801ada:	89 e5                	mov    %esp,%ebp
  801adc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 2c                	push   $0x2c
  801aeb:	e8 1b fa ff ff       	call   80150b <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
  801af3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801af6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801afa:	75 07                	jne    801b03 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801afc:	b8 01 00 00 00       	mov    $0x1,%eax
  801b01:	eb 05                	jmp    801b08 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b08:	c9                   	leave  
  801b09:	c3                   	ret    

00801b0a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	ff 75 08             	pushl  0x8(%ebp)
  801b18:	6a 2d                	push   $0x2d
  801b1a:	e8 ec f9 ff ff       	call   80150b <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b22:	90                   	nop
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
  801b28:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801b2b:	8b 55 08             	mov    0x8(%ebp),%edx
  801b2e:	89 d0                	mov    %edx,%eax
  801b30:	c1 e0 02             	shl    $0x2,%eax
  801b33:	01 d0                	add    %edx,%eax
  801b35:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b3c:	01 d0                	add    %edx,%eax
  801b3e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b45:	01 d0                	add    %edx,%eax
  801b47:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b4e:	01 d0                	add    %edx,%eax
  801b50:	c1 e0 04             	shl    $0x4,%eax
  801b53:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801b56:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801b5d:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801b60:	83 ec 0c             	sub    $0xc,%esp
  801b63:	50                   	push   %eax
  801b64:	e8 b8 fd ff ff       	call   801921 <sys_get_virtual_time>
  801b69:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801b6c:	eb 41                	jmp    801baf <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801b6e:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801b71:	83 ec 0c             	sub    $0xc,%esp
  801b74:	50                   	push   %eax
  801b75:	e8 a7 fd ff ff       	call   801921 <sys_get_virtual_time>
  801b7a:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801b7d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801b80:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b83:	29 c2                	sub    %eax,%edx
  801b85:	89 d0                	mov    %edx,%eax
  801b87:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801b8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801b8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b90:	89 d1                	mov    %edx,%ecx
  801b92:	29 c1                	sub    %eax,%ecx
  801b94:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801b97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b9a:	39 c2                	cmp    %eax,%edx
  801b9c:	0f 97 c0             	seta   %al
  801b9f:	0f b6 c0             	movzbl %al,%eax
  801ba2:	29 c1                	sub    %eax,%ecx
  801ba4:	89 c8                	mov    %ecx,%eax
  801ba6:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801ba9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801bac:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bb2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bb5:	72 b7                	jb     801b6e <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801bb7:	90                   	nop
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
  801bbd:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801bc0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801bc7:	eb 03                	jmp    801bcc <busy_wait+0x12>
  801bc9:	ff 45 fc             	incl   -0x4(%ebp)
  801bcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bcf:	3b 45 08             	cmp    0x8(%ebp),%eax
  801bd2:	72 f5                	jb     801bc9 <busy_wait+0xf>
	return i;
  801bd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    
  801bd9:	66 90                	xchg   %ax,%ax
  801bdb:	90                   	nop

00801bdc <__udivdi3>:
  801bdc:	55                   	push   %ebp
  801bdd:	57                   	push   %edi
  801bde:	56                   	push   %esi
  801bdf:	53                   	push   %ebx
  801be0:	83 ec 1c             	sub    $0x1c,%esp
  801be3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801be7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801beb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801bf3:	89 ca                	mov    %ecx,%edx
  801bf5:	89 f8                	mov    %edi,%eax
  801bf7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801bfb:	85 f6                	test   %esi,%esi
  801bfd:	75 2d                	jne    801c2c <__udivdi3+0x50>
  801bff:	39 cf                	cmp    %ecx,%edi
  801c01:	77 65                	ja     801c68 <__udivdi3+0x8c>
  801c03:	89 fd                	mov    %edi,%ebp
  801c05:	85 ff                	test   %edi,%edi
  801c07:	75 0b                	jne    801c14 <__udivdi3+0x38>
  801c09:	b8 01 00 00 00       	mov    $0x1,%eax
  801c0e:	31 d2                	xor    %edx,%edx
  801c10:	f7 f7                	div    %edi
  801c12:	89 c5                	mov    %eax,%ebp
  801c14:	31 d2                	xor    %edx,%edx
  801c16:	89 c8                	mov    %ecx,%eax
  801c18:	f7 f5                	div    %ebp
  801c1a:	89 c1                	mov    %eax,%ecx
  801c1c:	89 d8                	mov    %ebx,%eax
  801c1e:	f7 f5                	div    %ebp
  801c20:	89 cf                	mov    %ecx,%edi
  801c22:	89 fa                	mov    %edi,%edx
  801c24:	83 c4 1c             	add    $0x1c,%esp
  801c27:	5b                   	pop    %ebx
  801c28:	5e                   	pop    %esi
  801c29:	5f                   	pop    %edi
  801c2a:	5d                   	pop    %ebp
  801c2b:	c3                   	ret    
  801c2c:	39 ce                	cmp    %ecx,%esi
  801c2e:	77 28                	ja     801c58 <__udivdi3+0x7c>
  801c30:	0f bd fe             	bsr    %esi,%edi
  801c33:	83 f7 1f             	xor    $0x1f,%edi
  801c36:	75 40                	jne    801c78 <__udivdi3+0x9c>
  801c38:	39 ce                	cmp    %ecx,%esi
  801c3a:	72 0a                	jb     801c46 <__udivdi3+0x6a>
  801c3c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c40:	0f 87 9e 00 00 00    	ja     801ce4 <__udivdi3+0x108>
  801c46:	b8 01 00 00 00       	mov    $0x1,%eax
  801c4b:	89 fa                	mov    %edi,%edx
  801c4d:	83 c4 1c             	add    $0x1c,%esp
  801c50:	5b                   	pop    %ebx
  801c51:	5e                   	pop    %esi
  801c52:	5f                   	pop    %edi
  801c53:	5d                   	pop    %ebp
  801c54:	c3                   	ret    
  801c55:	8d 76 00             	lea    0x0(%esi),%esi
  801c58:	31 ff                	xor    %edi,%edi
  801c5a:	31 c0                	xor    %eax,%eax
  801c5c:	89 fa                	mov    %edi,%edx
  801c5e:	83 c4 1c             	add    $0x1c,%esp
  801c61:	5b                   	pop    %ebx
  801c62:	5e                   	pop    %esi
  801c63:	5f                   	pop    %edi
  801c64:	5d                   	pop    %ebp
  801c65:	c3                   	ret    
  801c66:	66 90                	xchg   %ax,%ax
  801c68:	89 d8                	mov    %ebx,%eax
  801c6a:	f7 f7                	div    %edi
  801c6c:	31 ff                	xor    %edi,%edi
  801c6e:	89 fa                	mov    %edi,%edx
  801c70:	83 c4 1c             	add    $0x1c,%esp
  801c73:	5b                   	pop    %ebx
  801c74:	5e                   	pop    %esi
  801c75:	5f                   	pop    %edi
  801c76:	5d                   	pop    %ebp
  801c77:	c3                   	ret    
  801c78:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c7d:	89 eb                	mov    %ebp,%ebx
  801c7f:	29 fb                	sub    %edi,%ebx
  801c81:	89 f9                	mov    %edi,%ecx
  801c83:	d3 e6                	shl    %cl,%esi
  801c85:	89 c5                	mov    %eax,%ebp
  801c87:	88 d9                	mov    %bl,%cl
  801c89:	d3 ed                	shr    %cl,%ebp
  801c8b:	89 e9                	mov    %ebp,%ecx
  801c8d:	09 f1                	or     %esi,%ecx
  801c8f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c93:	89 f9                	mov    %edi,%ecx
  801c95:	d3 e0                	shl    %cl,%eax
  801c97:	89 c5                	mov    %eax,%ebp
  801c99:	89 d6                	mov    %edx,%esi
  801c9b:	88 d9                	mov    %bl,%cl
  801c9d:	d3 ee                	shr    %cl,%esi
  801c9f:	89 f9                	mov    %edi,%ecx
  801ca1:	d3 e2                	shl    %cl,%edx
  801ca3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ca7:	88 d9                	mov    %bl,%cl
  801ca9:	d3 e8                	shr    %cl,%eax
  801cab:	09 c2                	or     %eax,%edx
  801cad:	89 d0                	mov    %edx,%eax
  801caf:	89 f2                	mov    %esi,%edx
  801cb1:	f7 74 24 0c          	divl   0xc(%esp)
  801cb5:	89 d6                	mov    %edx,%esi
  801cb7:	89 c3                	mov    %eax,%ebx
  801cb9:	f7 e5                	mul    %ebp
  801cbb:	39 d6                	cmp    %edx,%esi
  801cbd:	72 19                	jb     801cd8 <__udivdi3+0xfc>
  801cbf:	74 0b                	je     801ccc <__udivdi3+0xf0>
  801cc1:	89 d8                	mov    %ebx,%eax
  801cc3:	31 ff                	xor    %edi,%edi
  801cc5:	e9 58 ff ff ff       	jmp    801c22 <__udivdi3+0x46>
  801cca:	66 90                	xchg   %ax,%ax
  801ccc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801cd0:	89 f9                	mov    %edi,%ecx
  801cd2:	d3 e2                	shl    %cl,%edx
  801cd4:	39 c2                	cmp    %eax,%edx
  801cd6:	73 e9                	jae    801cc1 <__udivdi3+0xe5>
  801cd8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801cdb:	31 ff                	xor    %edi,%edi
  801cdd:	e9 40 ff ff ff       	jmp    801c22 <__udivdi3+0x46>
  801ce2:	66 90                	xchg   %ax,%ax
  801ce4:	31 c0                	xor    %eax,%eax
  801ce6:	e9 37 ff ff ff       	jmp    801c22 <__udivdi3+0x46>
  801ceb:	90                   	nop

00801cec <__umoddi3>:
  801cec:	55                   	push   %ebp
  801ced:	57                   	push   %edi
  801cee:	56                   	push   %esi
  801cef:	53                   	push   %ebx
  801cf0:	83 ec 1c             	sub    $0x1c,%esp
  801cf3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801cf7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801cfb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d03:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d07:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d0b:	89 f3                	mov    %esi,%ebx
  801d0d:	89 fa                	mov    %edi,%edx
  801d0f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d13:	89 34 24             	mov    %esi,(%esp)
  801d16:	85 c0                	test   %eax,%eax
  801d18:	75 1a                	jne    801d34 <__umoddi3+0x48>
  801d1a:	39 f7                	cmp    %esi,%edi
  801d1c:	0f 86 a2 00 00 00    	jbe    801dc4 <__umoddi3+0xd8>
  801d22:	89 c8                	mov    %ecx,%eax
  801d24:	89 f2                	mov    %esi,%edx
  801d26:	f7 f7                	div    %edi
  801d28:	89 d0                	mov    %edx,%eax
  801d2a:	31 d2                	xor    %edx,%edx
  801d2c:	83 c4 1c             	add    $0x1c,%esp
  801d2f:	5b                   	pop    %ebx
  801d30:	5e                   	pop    %esi
  801d31:	5f                   	pop    %edi
  801d32:	5d                   	pop    %ebp
  801d33:	c3                   	ret    
  801d34:	39 f0                	cmp    %esi,%eax
  801d36:	0f 87 ac 00 00 00    	ja     801de8 <__umoddi3+0xfc>
  801d3c:	0f bd e8             	bsr    %eax,%ebp
  801d3f:	83 f5 1f             	xor    $0x1f,%ebp
  801d42:	0f 84 ac 00 00 00    	je     801df4 <__umoddi3+0x108>
  801d48:	bf 20 00 00 00       	mov    $0x20,%edi
  801d4d:	29 ef                	sub    %ebp,%edi
  801d4f:	89 fe                	mov    %edi,%esi
  801d51:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d55:	89 e9                	mov    %ebp,%ecx
  801d57:	d3 e0                	shl    %cl,%eax
  801d59:	89 d7                	mov    %edx,%edi
  801d5b:	89 f1                	mov    %esi,%ecx
  801d5d:	d3 ef                	shr    %cl,%edi
  801d5f:	09 c7                	or     %eax,%edi
  801d61:	89 e9                	mov    %ebp,%ecx
  801d63:	d3 e2                	shl    %cl,%edx
  801d65:	89 14 24             	mov    %edx,(%esp)
  801d68:	89 d8                	mov    %ebx,%eax
  801d6a:	d3 e0                	shl    %cl,%eax
  801d6c:	89 c2                	mov    %eax,%edx
  801d6e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d72:	d3 e0                	shl    %cl,%eax
  801d74:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d78:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d7c:	89 f1                	mov    %esi,%ecx
  801d7e:	d3 e8                	shr    %cl,%eax
  801d80:	09 d0                	or     %edx,%eax
  801d82:	d3 eb                	shr    %cl,%ebx
  801d84:	89 da                	mov    %ebx,%edx
  801d86:	f7 f7                	div    %edi
  801d88:	89 d3                	mov    %edx,%ebx
  801d8a:	f7 24 24             	mull   (%esp)
  801d8d:	89 c6                	mov    %eax,%esi
  801d8f:	89 d1                	mov    %edx,%ecx
  801d91:	39 d3                	cmp    %edx,%ebx
  801d93:	0f 82 87 00 00 00    	jb     801e20 <__umoddi3+0x134>
  801d99:	0f 84 91 00 00 00    	je     801e30 <__umoddi3+0x144>
  801d9f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801da3:	29 f2                	sub    %esi,%edx
  801da5:	19 cb                	sbb    %ecx,%ebx
  801da7:	89 d8                	mov    %ebx,%eax
  801da9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801dad:	d3 e0                	shl    %cl,%eax
  801daf:	89 e9                	mov    %ebp,%ecx
  801db1:	d3 ea                	shr    %cl,%edx
  801db3:	09 d0                	or     %edx,%eax
  801db5:	89 e9                	mov    %ebp,%ecx
  801db7:	d3 eb                	shr    %cl,%ebx
  801db9:	89 da                	mov    %ebx,%edx
  801dbb:	83 c4 1c             	add    $0x1c,%esp
  801dbe:	5b                   	pop    %ebx
  801dbf:	5e                   	pop    %esi
  801dc0:	5f                   	pop    %edi
  801dc1:	5d                   	pop    %ebp
  801dc2:	c3                   	ret    
  801dc3:	90                   	nop
  801dc4:	89 fd                	mov    %edi,%ebp
  801dc6:	85 ff                	test   %edi,%edi
  801dc8:	75 0b                	jne    801dd5 <__umoddi3+0xe9>
  801dca:	b8 01 00 00 00       	mov    $0x1,%eax
  801dcf:	31 d2                	xor    %edx,%edx
  801dd1:	f7 f7                	div    %edi
  801dd3:	89 c5                	mov    %eax,%ebp
  801dd5:	89 f0                	mov    %esi,%eax
  801dd7:	31 d2                	xor    %edx,%edx
  801dd9:	f7 f5                	div    %ebp
  801ddb:	89 c8                	mov    %ecx,%eax
  801ddd:	f7 f5                	div    %ebp
  801ddf:	89 d0                	mov    %edx,%eax
  801de1:	e9 44 ff ff ff       	jmp    801d2a <__umoddi3+0x3e>
  801de6:	66 90                	xchg   %ax,%ax
  801de8:	89 c8                	mov    %ecx,%eax
  801dea:	89 f2                	mov    %esi,%edx
  801dec:	83 c4 1c             	add    $0x1c,%esp
  801def:	5b                   	pop    %ebx
  801df0:	5e                   	pop    %esi
  801df1:	5f                   	pop    %edi
  801df2:	5d                   	pop    %ebp
  801df3:	c3                   	ret    
  801df4:	3b 04 24             	cmp    (%esp),%eax
  801df7:	72 06                	jb     801dff <__umoddi3+0x113>
  801df9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801dfd:	77 0f                	ja     801e0e <__umoddi3+0x122>
  801dff:	89 f2                	mov    %esi,%edx
  801e01:	29 f9                	sub    %edi,%ecx
  801e03:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e07:	89 14 24             	mov    %edx,(%esp)
  801e0a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e0e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e12:	8b 14 24             	mov    (%esp),%edx
  801e15:	83 c4 1c             	add    $0x1c,%esp
  801e18:	5b                   	pop    %ebx
  801e19:	5e                   	pop    %esi
  801e1a:	5f                   	pop    %edi
  801e1b:	5d                   	pop    %ebp
  801e1c:	c3                   	ret    
  801e1d:	8d 76 00             	lea    0x0(%esi),%esi
  801e20:	2b 04 24             	sub    (%esp),%eax
  801e23:	19 fa                	sbb    %edi,%edx
  801e25:	89 d1                	mov    %edx,%ecx
  801e27:	89 c6                	mov    %eax,%esi
  801e29:	e9 71 ff ff ff       	jmp    801d9f <__umoddi3+0xb3>
  801e2e:	66 90                	xchg   %ax,%ax
  801e30:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e34:	72 ea                	jb     801e20 <__umoddi3+0x134>
  801e36:	89 d9                	mov    %ebx,%ecx
  801e38:	e9 62 ff ff ff       	jmp    801d9f <__umoddi3+0xb3>
