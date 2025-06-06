
obj/user/tst_invalid_access:     file format elf32-i386


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
  800031:	e8 57 00 00 00       	call   80008d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp

	uint32 kilo = 1024;
  80003e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	
	

	/// testing illegal memory access
	{
		uint32 size = 4*kilo;
  800045:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800048:	c1 e0 02             	shl    $0x2,%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)


		unsigned char *x = (unsigned char *)0x80000000;
  80004e:	c7 45 e8 00 00 00 80 	movl   $0x80000000,-0x18(%ebp)

		int i=0;
  800055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< size+20;i++)
  80005c:	eb 0e                	jmp    80006c <_main+0x34>
		{
			x[i]=-1;
  80005e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800061:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800064:	01 d0                	add    %edx,%eax
  800066:	c6 00 ff             	movb   $0xff,(%eax)


		unsigned char *x = (unsigned char *)0x80000000;

		int i=0;
		for(;i< size+20;i++)
  800069:	ff 45 f4             	incl   -0xc(%ebp)
  80006c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80006f:	8d 50 14             	lea    0x14(%eax),%edx
  800072:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800075:	39 c2                	cmp    %eax,%edx
  800077:	77 e5                	ja     80005e <_main+0x26>
		{
			x[i]=-1;
		}

		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for new stack pages\n");
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	68 60 1a 80 00       	push   $0x801a60
  800081:	6a 1f                	push   $0x1f
  800083:	68 69 1b 80 00       	push   $0x801b69
  800088:	e8 02 01 00 00       	call   80018f <_panic>

0080008d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80008d:	55                   	push   %ebp
  80008e:	89 e5                	mov    %esp,%ebp
  800090:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800093:	e8 d6 11 00 00       	call   80126e <sys_getenvindex>
  800098:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80009b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009e:	89 d0                	mov    %edx,%eax
  8000a0:	01 c0                	add    %eax,%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	c1 e0 02             	shl    $0x2,%eax
  8000a7:	01 d0                	add    %edx,%eax
  8000a9:	c1 e0 06             	shl    $0x6,%eax
  8000ac:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000b1:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000b6:	a1 04 30 80 00       	mov    0x803004,%eax
  8000bb:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000c1:	84 c0                	test   %al,%al
  8000c3:	74 0f                	je     8000d4 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000c5:	a1 04 30 80 00       	mov    0x803004,%eax
  8000ca:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000cf:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000d8:	7e 0a                	jle    8000e4 <libmain+0x57>
		binaryname = argv[0];
  8000da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000dd:	8b 00                	mov    (%eax),%eax
  8000df:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8000e4:	83 ec 08             	sub    $0x8,%esp
  8000e7:	ff 75 0c             	pushl  0xc(%ebp)
  8000ea:	ff 75 08             	pushl  0x8(%ebp)
  8000ed:	e8 46 ff ff ff       	call   800038 <_main>
  8000f2:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000f5:	e8 0f 13 00 00       	call   801409 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000fa:	83 ec 0c             	sub    $0xc,%esp
  8000fd:	68 9c 1b 80 00       	push   $0x801b9c
  800102:	e8 3c 03 00 00       	call   800443 <cprintf>
  800107:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80010a:	a1 04 30 80 00       	mov    0x803004,%eax
  80010f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800115:	a1 04 30 80 00       	mov    0x803004,%eax
  80011a:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800120:	83 ec 04             	sub    $0x4,%esp
  800123:	52                   	push   %edx
  800124:	50                   	push   %eax
  800125:	68 c4 1b 80 00       	push   $0x801bc4
  80012a:	e8 14 03 00 00       	call   800443 <cprintf>
  80012f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800132:	a1 04 30 80 00       	mov    0x803004,%eax
  800137:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80013d:	83 ec 08             	sub    $0x8,%esp
  800140:	50                   	push   %eax
  800141:	68 e9 1b 80 00       	push   $0x801be9
  800146:	e8 f8 02 00 00       	call   800443 <cprintf>
  80014b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80014e:	83 ec 0c             	sub    $0xc,%esp
  800151:	68 9c 1b 80 00       	push   $0x801b9c
  800156:	e8 e8 02 00 00       	call   800443 <cprintf>
  80015b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80015e:	e8 c0 12 00 00       	call   801423 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800163:	e8 19 00 00 00       	call   800181 <exit>
}
  800168:	90                   	nop
  800169:	c9                   	leave  
  80016a:	c3                   	ret    

0080016b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80016b:	55                   	push   %ebp
  80016c:	89 e5                	mov    %esp,%ebp
  80016e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800171:	83 ec 0c             	sub    $0xc,%esp
  800174:	6a 00                	push   $0x0
  800176:	e8 bf 10 00 00       	call   80123a <sys_env_destroy>
  80017b:	83 c4 10             	add    $0x10,%esp
}
  80017e:	90                   	nop
  80017f:	c9                   	leave  
  800180:	c3                   	ret    

00800181 <exit>:

void
exit(void)
{
  800181:	55                   	push   %ebp
  800182:	89 e5                	mov    %esp,%ebp
  800184:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800187:	e8 14 11 00 00       	call   8012a0 <sys_env_exit>
}
  80018c:	90                   	nop
  80018d:	c9                   	leave  
  80018e:	c3                   	ret    

0080018f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80018f:	55                   	push   %ebp
  800190:	89 e5                	mov    %esp,%ebp
  800192:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800195:	8d 45 10             	lea    0x10(%ebp),%eax
  800198:	83 c0 04             	add    $0x4,%eax
  80019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80019e:	a1 14 30 80 00       	mov    0x803014,%eax
  8001a3:	85 c0                	test   %eax,%eax
  8001a5:	74 16                	je     8001bd <_panic+0x2e>
		cprintf("%s: ", argv0);
  8001a7:	a1 14 30 80 00       	mov    0x803014,%eax
  8001ac:	83 ec 08             	sub    $0x8,%esp
  8001af:	50                   	push   %eax
  8001b0:	68 00 1c 80 00       	push   $0x801c00
  8001b5:	e8 89 02 00 00       	call   800443 <cprintf>
  8001ba:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8001bd:	a1 00 30 80 00       	mov    0x803000,%eax
  8001c2:	ff 75 0c             	pushl  0xc(%ebp)
  8001c5:	ff 75 08             	pushl  0x8(%ebp)
  8001c8:	50                   	push   %eax
  8001c9:	68 05 1c 80 00       	push   $0x801c05
  8001ce:	e8 70 02 00 00       	call   800443 <cprintf>
  8001d3:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8001d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8001d9:	83 ec 08             	sub    $0x8,%esp
  8001dc:	ff 75 f4             	pushl  -0xc(%ebp)
  8001df:	50                   	push   %eax
  8001e0:	e8 f3 01 00 00       	call   8003d8 <vcprintf>
  8001e5:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	6a 00                	push   $0x0
  8001ed:	68 21 1c 80 00       	push   $0x801c21
  8001f2:	e8 e1 01 00 00       	call   8003d8 <vcprintf>
  8001f7:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8001fa:	e8 82 ff ff ff       	call   800181 <exit>

	// should not return here
	while (1) ;
  8001ff:	eb fe                	jmp    8001ff <_panic+0x70>

00800201 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800201:	55                   	push   %ebp
  800202:	89 e5                	mov    %esp,%ebp
  800204:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800207:	a1 04 30 80 00       	mov    0x803004,%eax
  80020c:	8b 50 74             	mov    0x74(%eax),%edx
  80020f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800212:	39 c2                	cmp    %eax,%edx
  800214:	74 14                	je     80022a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800216:	83 ec 04             	sub    $0x4,%esp
  800219:	68 24 1c 80 00       	push   $0x801c24
  80021e:	6a 26                	push   $0x26
  800220:	68 70 1c 80 00       	push   $0x801c70
  800225:	e8 65 ff ff ff       	call   80018f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80022a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800231:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800238:	e9 c2 00 00 00       	jmp    8002ff <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80023d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800240:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800247:	8b 45 08             	mov    0x8(%ebp),%eax
  80024a:	01 d0                	add    %edx,%eax
  80024c:	8b 00                	mov    (%eax),%eax
  80024e:	85 c0                	test   %eax,%eax
  800250:	75 08                	jne    80025a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800252:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800255:	e9 a2 00 00 00       	jmp    8002fc <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80025a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800261:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800268:	eb 69                	jmp    8002d3 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80026a:	a1 04 30 80 00       	mov    0x803004,%eax
  80026f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800275:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800278:	89 d0                	mov    %edx,%eax
  80027a:	01 c0                	add    %eax,%eax
  80027c:	01 d0                	add    %edx,%eax
  80027e:	c1 e0 02             	shl    $0x2,%eax
  800281:	01 c8                	add    %ecx,%eax
  800283:	8a 40 04             	mov    0x4(%eax),%al
  800286:	84 c0                	test   %al,%al
  800288:	75 46                	jne    8002d0 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80028a:	a1 04 30 80 00       	mov    0x803004,%eax
  80028f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800295:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800298:	89 d0                	mov    %edx,%eax
  80029a:	01 c0                	add    %eax,%eax
  80029c:	01 d0                	add    %edx,%eax
  80029e:	c1 e0 02             	shl    $0x2,%eax
  8002a1:	01 c8                	add    %ecx,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8002a8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8002b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8002bf:	01 c8                	add    %ecx,%eax
  8002c1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002c3:	39 c2                	cmp    %eax,%edx
  8002c5:	75 09                	jne    8002d0 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8002c7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8002ce:	eb 12                	jmp    8002e2 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002d0:	ff 45 e8             	incl   -0x18(%ebp)
  8002d3:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d8:	8b 50 74             	mov    0x74(%eax),%edx
  8002db:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002de:	39 c2                	cmp    %eax,%edx
  8002e0:	77 88                	ja     80026a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8002e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8002e6:	75 14                	jne    8002fc <CheckWSWithoutLastIndex+0xfb>
			panic(
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 7c 1c 80 00       	push   $0x801c7c
  8002f0:	6a 3a                	push   $0x3a
  8002f2:	68 70 1c 80 00       	push   $0x801c70
  8002f7:	e8 93 fe ff ff       	call   80018f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8002fc:	ff 45 f0             	incl   -0x10(%ebp)
  8002ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800302:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800305:	0f 8c 32 ff ff ff    	jl     80023d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80030b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800312:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800319:	eb 26                	jmp    800341 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80031b:	a1 04 30 80 00       	mov    0x803004,%eax
  800320:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800326:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800329:	89 d0                	mov    %edx,%eax
  80032b:	01 c0                	add    %eax,%eax
  80032d:	01 d0                	add    %edx,%eax
  80032f:	c1 e0 02             	shl    $0x2,%eax
  800332:	01 c8                	add    %ecx,%eax
  800334:	8a 40 04             	mov    0x4(%eax),%al
  800337:	3c 01                	cmp    $0x1,%al
  800339:	75 03                	jne    80033e <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80033b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80033e:	ff 45 e0             	incl   -0x20(%ebp)
  800341:	a1 04 30 80 00       	mov    0x803004,%eax
  800346:	8b 50 74             	mov    0x74(%eax),%edx
  800349:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80034c:	39 c2                	cmp    %eax,%edx
  80034e:	77 cb                	ja     80031b <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800350:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800353:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800356:	74 14                	je     80036c <CheckWSWithoutLastIndex+0x16b>
		panic(
  800358:	83 ec 04             	sub    $0x4,%esp
  80035b:	68 d0 1c 80 00       	push   $0x801cd0
  800360:	6a 44                	push   $0x44
  800362:	68 70 1c 80 00       	push   $0x801c70
  800367:	e8 23 fe ff ff       	call   80018f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80036c:	90                   	nop
  80036d:	c9                   	leave  
  80036e:	c3                   	ret    

0080036f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80036f:	55                   	push   %ebp
  800370:	89 e5                	mov    %esp,%ebp
  800372:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800375:	8b 45 0c             	mov    0xc(%ebp),%eax
  800378:	8b 00                	mov    (%eax),%eax
  80037a:	8d 48 01             	lea    0x1(%eax),%ecx
  80037d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800380:	89 0a                	mov    %ecx,(%edx)
  800382:	8b 55 08             	mov    0x8(%ebp),%edx
  800385:	88 d1                	mov    %dl,%cl
  800387:	8b 55 0c             	mov    0xc(%ebp),%edx
  80038a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80038e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800391:	8b 00                	mov    (%eax),%eax
  800393:	3d ff 00 00 00       	cmp    $0xff,%eax
  800398:	75 2c                	jne    8003c6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80039a:	a0 08 30 80 00       	mov    0x803008,%al
  80039f:	0f b6 c0             	movzbl %al,%eax
  8003a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003a5:	8b 12                	mov    (%edx),%edx
  8003a7:	89 d1                	mov    %edx,%ecx
  8003a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003ac:	83 c2 08             	add    $0x8,%edx
  8003af:	83 ec 04             	sub    $0x4,%esp
  8003b2:	50                   	push   %eax
  8003b3:	51                   	push   %ecx
  8003b4:	52                   	push   %edx
  8003b5:	e8 3e 0e 00 00       	call   8011f8 <sys_cputs>
  8003ba:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c9:	8b 40 04             	mov    0x4(%eax),%eax
  8003cc:	8d 50 01             	lea    0x1(%eax),%edx
  8003cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003d5:	90                   	nop
  8003d6:	c9                   	leave  
  8003d7:	c3                   	ret    

008003d8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003d8:	55                   	push   %ebp
  8003d9:	89 e5                	mov    %esp,%ebp
  8003db:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003e1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003e8:	00 00 00 
	b.cnt = 0;
  8003eb:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003f2:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003f5:	ff 75 0c             	pushl  0xc(%ebp)
  8003f8:	ff 75 08             	pushl  0x8(%ebp)
  8003fb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800401:	50                   	push   %eax
  800402:	68 6f 03 80 00       	push   $0x80036f
  800407:	e8 11 02 00 00       	call   80061d <vprintfmt>
  80040c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80040f:	a0 08 30 80 00       	mov    0x803008,%al
  800414:	0f b6 c0             	movzbl %al,%eax
  800417:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80041d:	83 ec 04             	sub    $0x4,%esp
  800420:	50                   	push   %eax
  800421:	52                   	push   %edx
  800422:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800428:	83 c0 08             	add    $0x8,%eax
  80042b:	50                   	push   %eax
  80042c:	e8 c7 0d 00 00       	call   8011f8 <sys_cputs>
  800431:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800434:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80043b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800441:	c9                   	leave  
  800442:	c3                   	ret    

00800443 <cprintf>:

int cprintf(const char *fmt, ...) {
  800443:	55                   	push   %ebp
  800444:	89 e5                	mov    %esp,%ebp
  800446:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800449:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800450:	8d 45 0c             	lea    0xc(%ebp),%eax
  800453:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800456:	8b 45 08             	mov    0x8(%ebp),%eax
  800459:	83 ec 08             	sub    $0x8,%esp
  80045c:	ff 75 f4             	pushl  -0xc(%ebp)
  80045f:	50                   	push   %eax
  800460:	e8 73 ff ff ff       	call   8003d8 <vcprintf>
  800465:	83 c4 10             	add    $0x10,%esp
  800468:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80046b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80046e:	c9                   	leave  
  80046f:	c3                   	ret    

00800470 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800470:	55                   	push   %ebp
  800471:	89 e5                	mov    %esp,%ebp
  800473:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800476:	e8 8e 0f 00 00       	call   801409 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80047b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80047e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	83 ec 08             	sub    $0x8,%esp
  800487:	ff 75 f4             	pushl  -0xc(%ebp)
  80048a:	50                   	push   %eax
  80048b:	e8 48 ff ff ff       	call   8003d8 <vcprintf>
  800490:	83 c4 10             	add    $0x10,%esp
  800493:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800496:	e8 88 0f 00 00       	call   801423 <sys_enable_interrupt>
	return cnt;
  80049b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80049e:	c9                   	leave  
  80049f:	c3                   	ret    

008004a0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004a0:	55                   	push   %ebp
  8004a1:	89 e5                	mov    %esp,%ebp
  8004a3:	53                   	push   %ebx
  8004a4:	83 ec 14             	sub    $0x14,%esp
  8004a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8004b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004b3:	8b 45 18             	mov    0x18(%ebp),%eax
  8004b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8004bb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004be:	77 55                	ja     800515 <printnum+0x75>
  8004c0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004c3:	72 05                	jb     8004ca <printnum+0x2a>
  8004c5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004c8:	77 4b                	ja     800515 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004ca:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004cd:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004d0:	8b 45 18             	mov    0x18(%ebp),%eax
  8004d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8004d8:	52                   	push   %edx
  8004d9:	50                   	push   %eax
  8004da:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dd:	ff 75 f0             	pushl  -0x10(%ebp)
  8004e0:	e8 03 13 00 00       	call   8017e8 <__udivdi3>
  8004e5:	83 c4 10             	add    $0x10,%esp
  8004e8:	83 ec 04             	sub    $0x4,%esp
  8004eb:	ff 75 20             	pushl  0x20(%ebp)
  8004ee:	53                   	push   %ebx
  8004ef:	ff 75 18             	pushl  0x18(%ebp)
  8004f2:	52                   	push   %edx
  8004f3:	50                   	push   %eax
  8004f4:	ff 75 0c             	pushl  0xc(%ebp)
  8004f7:	ff 75 08             	pushl  0x8(%ebp)
  8004fa:	e8 a1 ff ff ff       	call   8004a0 <printnum>
  8004ff:	83 c4 20             	add    $0x20,%esp
  800502:	eb 1a                	jmp    80051e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800504:	83 ec 08             	sub    $0x8,%esp
  800507:	ff 75 0c             	pushl  0xc(%ebp)
  80050a:	ff 75 20             	pushl  0x20(%ebp)
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	ff d0                	call   *%eax
  800512:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800515:	ff 4d 1c             	decl   0x1c(%ebp)
  800518:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80051c:	7f e6                	jg     800504 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80051e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800521:	bb 00 00 00 00       	mov    $0x0,%ebx
  800526:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800529:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80052c:	53                   	push   %ebx
  80052d:	51                   	push   %ecx
  80052e:	52                   	push   %edx
  80052f:	50                   	push   %eax
  800530:	e8 c3 13 00 00       	call   8018f8 <__umoddi3>
  800535:	83 c4 10             	add    $0x10,%esp
  800538:	05 34 1f 80 00       	add    $0x801f34,%eax
  80053d:	8a 00                	mov    (%eax),%al
  80053f:	0f be c0             	movsbl %al,%eax
  800542:	83 ec 08             	sub    $0x8,%esp
  800545:	ff 75 0c             	pushl  0xc(%ebp)
  800548:	50                   	push   %eax
  800549:	8b 45 08             	mov    0x8(%ebp),%eax
  80054c:	ff d0                	call   *%eax
  80054e:	83 c4 10             	add    $0x10,%esp
}
  800551:	90                   	nop
  800552:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800555:	c9                   	leave  
  800556:	c3                   	ret    

00800557 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800557:	55                   	push   %ebp
  800558:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80055a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80055e:	7e 1c                	jle    80057c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	8d 50 08             	lea    0x8(%eax),%edx
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	89 10                	mov    %edx,(%eax)
  80056d:	8b 45 08             	mov    0x8(%ebp),%eax
  800570:	8b 00                	mov    (%eax),%eax
  800572:	83 e8 08             	sub    $0x8,%eax
  800575:	8b 50 04             	mov    0x4(%eax),%edx
  800578:	8b 00                	mov    (%eax),%eax
  80057a:	eb 40                	jmp    8005bc <getuint+0x65>
	else if (lflag)
  80057c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800580:	74 1e                	je     8005a0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	8b 00                	mov    (%eax),%eax
  800587:	8d 50 04             	lea    0x4(%eax),%edx
  80058a:	8b 45 08             	mov    0x8(%ebp),%eax
  80058d:	89 10                	mov    %edx,(%eax)
  80058f:	8b 45 08             	mov    0x8(%ebp),%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	83 e8 04             	sub    $0x4,%eax
  800597:	8b 00                	mov    (%eax),%eax
  800599:	ba 00 00 00 00       	mov    $0x0,%edx
  80059e:	eb 1c                	jmp    8005bc <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a3:	8b 00                	mov    (%eax),%eax
  8005a5:	8d 50 04             	lea    0x4(%eax),%edx
  8005a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ab:	89 10                	mov    %edx,(%eax)
  8005ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b0:	8b 00                	mov    (%eax),%eax
  8005b2:	83 e8 04             	sub    $0x4,%eax
  8005b5:	8b 00                	mov    (%eax),%eax
  8005b7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005bc:	5d                   	pop    %ebp
  8005bd:	c3                   	ret    

008005be <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005be:	55                   	push   %ebp
  8005bf:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005c1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005c5:	7e 1c                	jle    8005e3 <getint+0x25>
		return va_arg(*ap, long long);
  8005c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ca:	8b 00                	mov    (%eax),%eax
  8005cc:	8d 50 08             	lea    0x8(%eax),%edx
  8005cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d2:	89 10                	mov    %edx,(%eax)
  8005d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d7:	8b 00                	mov    (%eax),%eax
  8005d9:	83 e8 08             	sub    $0x8,%eax
  8005dc:	8b 50 04             	mov    0x4(%eax),%edx
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	eb 38                	jmp    80061b <getint+0x5d>
	else if (lflag)
  8005e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005e7:	74 1a                	je     800603 <getint+0x45>
		return va_arg(*ap, long);
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	8b 00                	mov    (%eax),%eax
  8005ee:	8d 50 04             	lea    0x4(%eax),%edx
  8005f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f4:	89 10                	mov    %edx,(%eax)
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	8b 00                	mov    (%eax),%eax
  8005fb:	83 e8 04             	sub    $0x4,%eax
  8005fe:	8b 00                	mov    (%eax),%eax
  800600:	99                   	cltd   
  800601:	eb 18                	jmp    80061b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	8b 00                	mov    (%eax),%eax
  800608:	8d 50 04             	lea    0x4(%eax),%edx
  80060b:	8b 45 08             	mov    0x8(%ebp),%eax
  80060e:	89 10                	mov    %edx,(%eax)
  800610:	8b 45 08             	mov    0x8(%ebp),%eax
  800613:	8b 00                	mov    (%eax),%eax
  800615:	83 e8 04             	sub    $0x4,%eax
  800618:	8b 00                	mov    (%eax),%eax
  80061a:	99                   	cltd   
}
  80061b:	5d                   	pop    %ebp
  80061c:	c3                   	ret    

0080061d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80061d:	55                   	push   %ebp
  80061e:	89 e5                	mov    %esp,%ebp
  800620:	56                   	push   %esi
  800621:	53                   	push   %ebx
  800622:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800625:	eb 17                	jmp    80063e <vprintfmt+0x21>
			if (ch == '\0')
  800627:	85 db                	test   %ebx,%ebx
  800629:	0f 84 af 03 00 00    	je     8009de <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80062f:	83 ec 08             	sub    $0x8,%esp
  800632:	ff 75 0c             	pushl  0xc(%ebp)
  800635:	53                   	push   %ebx
  800636:	8b 45 08             	mov    0x8(%ebp),%eax
  800639:	ff d0                	call   *%eax
  80063b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80063e:	8b 45 10             	mov    0x10(%ebp),%eax
  800641:	8d 50 01             	lea    0x1(%eax),%edx
  800644:	89 55 10             	mov    %edx,0x10(%ebp)
  800647:	8a 00                	mov    (%eax),%al
  800649:	0f b6 d8             	movzbl %al,%ebx
  80064c:	83 fb 25             	cmp    $0x25,%ebx
  80064f:	75 d6                	jne    800627 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800651:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800655:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80065c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800663:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80066a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800671:	8b 45 10             	mov    0x10(%ebp),%eax
  800674:	8d 50 01             	lea    0x1(%eax),%edx
  800677:	89 55 10             	mov    %edx,0x10(%ebp)
  80067a:	8a 00                	mov    (%eax),%al
  80067c:	0f b6 d8             	movzbl %al,%ebx
  80067f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800682:	83 f8 55             	cmp    $0x55,%eax
  800685:	0f 87 2b 03 00 00    	ja     8009b6 <vprintfmt+0x399>
  80068b:	8b 04 85 58 1f 80 00 	mov    0x801f58(,%eax,4),%eax
  800692:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800694:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800698:	eb d7                	jmp    800671 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80069a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80069e:	eb d1                	jmp    800671 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006a0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006a7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006aa:	89 d0                	mov    %edx,%eax
  8006ac:	c1 e0 02             	shl    $0x2,%eax
  8006af:	01 d0                	add    %edx,%eax
  8006b1:	01 c0                	add    %eax,%eax
  8006b3:	01 d8                	add    %ebx,%eax
  8006b5:	83 e8 30             	sub    $0x30,%eax
  8006b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8006be:	8a 00                	mov    (%eax),%al
  8006c0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006c3:	83 fb 2f             	cmp    $0x2f,%ebx
  8006c6:	7e 3e                	jle    800706 <vprintfmt+0xe9>
  8006c8:	83 fb 39             	cmp    $0x39,%ebx
  8006cb:	7f 39                	jg     800706 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006cd:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006d0:	eb d5                	jmp    8006a7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d5:	83 c0 04             	add    $0x4,%eax
  8006d8:	89 45 14             	mov    %eax,0x14(%ebp)
  8006db:	8b 45 14             	mov    0x14(%ebp),%eax
  8006de:	83 e8 04             	sub    $0x4,%eax
  8006e1:	8b 00                	mov    (%eax),%eax
  8006e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006e6:	eb 1f                	jmp    800707 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ec:	79 83                	jns    800671 <vprintfmt+0x54>
				width = 0;
  8006ee:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8006f5:	e9 77 ff ff ff       	jmp    800671 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8006fa:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800701:	e9 6b ff ff ff       	jmp    800671 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800706:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800707:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80070b:	0f 89 60 ff ff ff    	jns    800671 <vprintfmt+0x54>
				width = precision, precision = -1;
  800711:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800714:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800717:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80071e:	e9 4e ff ff ff       	jmp    800671 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800723:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800726:	e9 46 ff ff ff       	jmp    800671 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80072b:	8b 45 14             	mov    0x14(%ebp),%eax
  80072e:	83 c0 04             	add    $0x4,%eax
  800731:	89 45 14             	mov    %eax,0x14(%ebp)
  800734:	8b 45 14             	mov    0x14(%ebp),%eax
  800737:	83 e8 04             	sub    $0x4,%eax
  80073a:	8b 00                	mov    (%eax),%eax
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	ff 75 0c             	pushl  0xc(%ebp)
  800742:	50                   	push   %eax
  800743:	8b 45 08             	mov    0x8(%ebp),%eax
  800746:	ff d0                	call   *%eax
  800748:	83 c4 10             	add    $0x10,%esp
			break;
  80074b:	e9 89 02 00 00       	jmp    8009d9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800750:	8b 45 14             	mov    0x14(%ebp),%eax
  800753:	83 c0 04             	add    $0x4,%eax
  800756:	89 45 14             	mov    %eax,0x14(%ebp)
  800759:	8b 45 14             	mov    0x14(%ebp),%eax
  80075c:	83 e8 04             	sub    $0x4,%eax
  80075f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800761:	85 db                	test   %ebx,%ebx
  800763:	79 02                	jns    800767 <vprintfmt+0x14a>
				err = -err;
  800765:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800767:	83 fb 64             	cmp    $0x64,%ebx
  80076a:	7f 0b                	jg     800777 <vprintfmt+0x15a>
  80076c:	8b 34 9d a0 1d 80 00 	mov    0x801da0(,%ebx,4),%esi
  800773:	85 f6                	test   %esi,%esi
  800775:	75 19                	jne    800790 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800777:	53                   	push   %ebx
  800778:	68 45 1f 80 00       	push   $0x801f45
  80077d:	ff 75 0c             	pushl  0xc(%ebp)
  800780:	ff 75 08             	pushl  0x8(%ebp)
  800783:	e8 5e 02 00 00       	call   8009e6 <printfmt>
  800788:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80078b:	e9 49 02 00 00       	jmp    8009d9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800790:	56                   	push   %esi
  800791:	68 4e 1f 80 00       	push   $0x801f4e
  800796:	ff 75 0c             	pushl  0xc(%ebp)
  800799:	ff 75 08             	pushl  0x8(%ebp)
  80079c:	e8 45 02 00 00       	call   8009e6 <printfmt>
  8007a1:	83 c4 10             	add    $0x10,%esp
			break;
  8007a4:	e9 30 02 00 00       	jmp    8009d9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ac:	83 c0 04             	add    $0x4,%eax
  8007af:	89 45 14             	mov    %eax,0x14(%ebp)
  8007b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b5:	83 e8 04             	sub    $0x4,%eax
  8007b8:	8b 30                	mov    (%eax),%esi
  8007ba:	85 f6                	test   %esi,%esi
  8007bc:	75 05                	jne    8007c3 <vprintfmt+0x1a6>
				p = "(null)";
  8007be:	be 51 1f 80 00       	mov    $0x801f51,%esi
			if (width > 0 && padc != '-')
  8007c3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007c7:	7e 6d                	jle    800836 <vprintfmt+0x219>
  8007c9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007cd:	74 67                	je     800836 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007d2:	83 ec 08             	sub    $0x8,%esp
  8007d5:	50                   	push   %eax
  8007d6:	56                   	push   %esi
  8007d7:	e8 0c 03 00 00       	call   800ae8 <strnlen>
  8007dc:	83 c4 10             	add    $0x10,%esp
  8007df:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007e2:	eb 16                	jmp    8007fa <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007e4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007e8:	83 ec 08             	sub    $0x8,%esp
  8007eb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ee:	50                   	push   %eax
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	ff d0                	call   *%eax
  8007f4:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8007f7:	ff 4d e4             	decl   -0x1c(%ebp)
  8007fa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007fe:	7f e4                	jg     8007e4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800800:	eb 34                	jmp    800836 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800802:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800806:	74 1c                	je     800824 <vprintfmt+0x207>
  800808:	83 fb 1f             	cmp    $0x1f,%ebx
  80080b:	7e 05                	jle    800812 <vprintfmt+0x1f5>
  80080d:	83 fb 7e             	cmp    $0x7e,%ebx
  800810:	7e 12                	jle    800824 <vprintfmt+0x207>
					putch('?', putdat);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 0c             	pushl  0xc(%ebp)
  800818:	6a 3f                	push   $0x3f
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	ff d0                	call   *%eax
  80081f:	83 c4 10             	add    $0x10,%esp
  800822:	eb 0f                	jmp    800833 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800824:	83 ec 08             	sub    $0x8,%esp
  800827:	ff 75 0c             	pushl  0xc(%ebp)
  80082a:	53                   	push   %ebx
  80082b:	8b 45 08             	mov    0x8(%ebp),%eax
  80082e:	ff d0                	call   *%eax
  800830:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800833:	ff 4d e4             	decl   -0x1c(%ebp)
  800836:	89 f0                	mov    %esi,%eax
  800838:	8d 70 01             	lea    0x1(%eax),%esi
  80083b:	8a 00                	mov    (%eax),%al
  80083d:	0f be d8             	movsbl %al,%ebx
  800840:	85 db                	test   %ebx,%ebx
  800842:	74 24                	je     800868 <vprintfmt+0x24b>
  800844:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800848:	78 b8                	js     800802 <vprintfmt+0x1e5>
  80084a:	ff 4d e0             	decl   -0x20(%ebp)
  80084d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800851:	79 af                	jns    800802 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800853:	eb 13                	jmp    800868 <vprintfmt+0x24b>
				putch(' ', putdat);
  800855:	83 ec 08             	sub    $0x8,%esp
  800858:	ff 75 0c             	pushl  0xc(%ebp)
  80085b:	6a 20                	push   $0x20
  80085d:	8b 45 08             	mov    0x8(%ebp),%eax
  800860:	ff d0                	call   *%eax
  800862:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800865:	ff 4d e4             	decl   -0x1c(%ebp)
  800868:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80086c:	7f e7                	jg     800855 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80086e:	e9 66 01 00 00       	jmp    8009d9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800873:	83 ec 08             	sub    $0x8,%esp
  800876:	ff 75 e8             	pushl  -0x18(%ebp)
  800879:	8d 45 14             	lea    0x14(%ebp),%eax
  80087c:	50                   	push   %eax
  80087d:	e8 3c fd ff ff       	call   8005be <getint>
  800882:	83 c4 10             	add    $0x10,%esp
  800885:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800888:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80088b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80088e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800891:	85 d2                	test   %edx,%edx
  800893:	79 23                	jns    8008b8 <vprintfmt+0x29b>
				putch('-', putdat);
  800895:	83 ec 08             	sub    $0x8,%esp
  800898:	ff 75 0c             	pushl  0xc(%ebp)
  80089b:	6a 2d                	push   $0x2d
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	ff d0                	call   *%eax
  8008a2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ab:	f7 d8                	neg    %eax
  8008ad:	83 d2 00             	adc    $0x0,%edx
  8008b0:	f7 da                	neg    %edx
  8008b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008b8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008bf:	e9 bc 00 00 00       	jmp    800980 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008c4:	83 ec 08             	sub    $0x8,%esp
  8008c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8008ca:	8d 45 14             	lea    0x14(%ebp),%eax
  8008cd:	50                   	push   %eax
  8008ce:	e8 84 fc ff ff       	call   800557 <getuint>
  8008d3:	83 c4 10             	add    $0x10,%esp
  8008d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008dc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008e3:	e9 98 00 00 00       	jmp    800980 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008e8:	83 ec 08             	sub    $0x8,%esp
  8008eb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ee:	6a 58                	push   $0x58
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	ff d0                	call   *%eax
  8008f5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008f8:	83 ec 08             	sub    $0x8,%esp
  8008fb:	ff 75 0c             	pushl  0xc(%ebp)
  8008fe:	6a 58                	push   $0x58
  800900:	8b 45 08             	mov    0x8(%ebp),%eax
  800903:	ff d0                	call   *%eax
  800905:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800908:	83 ec 08             	sub    $0x8,%esp
  80090b:	ff 75 0c             	pushl  0xc(%ebp)
  80090e:	6a 58                	push   $0x58
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	ff d0                	call   *%eax
  800915:	83 c4 10             	add    $0x10,%esp
			break;
  800918:	e9 bc 00 00 00       	jmp    8009d9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80091d:	83 ec 08             	sub    $0x8,%esp
  800920:	ff 75 0c             	pushl  0xc(%ebp)
  800923:	6a 30                	push   $0x30
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	ff d0                	call   *%eax
  80092a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80092d:	83 ec 08             	sub    $0x8,%esp
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	6a 78                	push   $0x78
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	ff d0                	call   *%eax
  80093a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80093d:	8b 45 14             	mov    0x14(%ebp),%eax
  800940:	83 c0 04             	add    $0x4,%eax
  800943:	89 45 14             	mov    %eax,0x14(%ebp)
  800946:	8b 45 14             	mov    0x14(%ebp),%eax
  800949:	83 e8 04             	sub    $0x4,%eax
  80094c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80094e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800951:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800958:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80095f:	eb 1f                	jmp    800980 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800961:	83 ec 08             	sub    $0x8,%esp
  800964:	ff 75 e8             	pushl  -0x18(%ebp)
  800967:	8d 45 14             	lea    0x14(%ebp),%eax
  80096a:	50                   	push   %eax
  80096b:	e8 e7 fb ff ff       	call   800557 <getuint>
  800970:	83 c4 10             	add    $0x10,%esp
  800973:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800976:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800979:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800980:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800984:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800987:	83 ec 04             	sub    $0x4,%esp
  80098a:	52                   	push   %edx
  80098b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80098e:	50                   	push   %eax
  80098f:	ff 75 f4             	pushl  -0xc(%ebp)
  800992:	ff 75 f0             	pushl  -0x10(%ebp)
  800995:	ff 75 0c             	pushl  0xc(%ebp)
  800998:	ff 75 08             	pushl  0x8(%ebp)
  80099b:	e8 00 fb ff ff       	call   8004a0 <printnum>
  8009a0:	83 c4 20             	add    $0x20,%esp
			break;
  8009a3:	eb 34                	jmp    8009d9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009a5:	83 ec 08             	sub    $0x8,%esp
  8009a8:	ff 75 0c             	pushl  0xc(%ebp)
  8009ab:	53                   	push   %ebx
  8009ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8009af:	ff d0                	call   *%eax
  8009b1:	83 c4 10             	add    $0x10,%esp
			break;
  8009b4:	eb 23                	jmp    8009d9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009b6:	83 ec 08             	sub    $0x8,%esp
  8009b9:	ff 75 0c             	pushl  0xc(%ebp)
  8009bc:	6a 25                	push   $0x25
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	ff d0                	call   *%eax
  8009c3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009c6:	ff 4d 10             	decl   0x10(%ebp)
  8009c9:	eb 03                	jmp    8009ce <vprintfmt+0x3b1>
  8009cb:	ff 4d 10             	decl   0x10(%ebp)
  8009ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8009d1:	48                   	dec    %eax
  8009d2:	8a 00                	mov    (%eax),%al
  8009d4:	3c 25                	cmp    $0x25,%al
  8009d6:	75 f3                	jne    8009cb <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8009d8:	90                   	nop
		}
	}
  8009d9:	e9 47 fc ff ff       	jmp    800625 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009de:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009df:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009e2:	5b                   	pop    %ebx
  8009e3:	5e                   	pop    %esi
  8009e4:	5d                   	pop    %ebp
  8009e5:	c3                   	ret    

008009e6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8009e6:	55                   	push   %ebp
  8009e7:	89 e5                	mov    %esp,%ebp
  8009e9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8009ec:	8d 45 10             	lea    0x10(%ebp),%eax
  8009ef:	83 c0 04             	add    $0x4,%eax
  8009f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8009f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fb:	50                   	push   %eax
  8009fc:	ff 75 0c             	pushl  0xc(%ebp)
  8009ff:	ff 75 08             	pushl  0x8(%ebp)
  800a02:	e8 16 fc ff ff       	call   80061d <vprintfmt>
  800a07:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a0a:	90                   	nop
  800a0b:	c9                   	leave  
  800a0c:	c3                   	ret    

00800a0d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a0d:	55                   	push   %ebp
  800a0e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a13:	8b 40 08             	mov    0x8(%eax),%eax
  800a16:	8d 50 01             	lea    0x1(%eax),%edx
  800a19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a22:	8b 10                	mov    (%eax),%edx
  800a24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a27:	8b 40 04             	mov    0x4(%eax),%eax
  800a2a:	39 c2                	cmp    %eax,%edx
  800a2c:	73 12                	jae    800a40 <sprintputch+0x33>
		*b->buf++ = ch;
  800a2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a31:	8b 00                	mov    (%eax),%eax
  800a33:	8d 48 01             	lea    0x1(%eax),%ecx
  800a36:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a39:	89 0a                	mov    %ecx,(%edx)
  800a3b:	8b 55 08             	mov    0x8(%ebp),%edx
  800a3e:	88 10                	mov    %dl,(%eax)
}
  800a40:	90                   	nop
  800a41:	5d                   	pop    %ebp
  800a42:	c3                   	ret    

00800a43 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a43:	55                   	push   %ebp
  800a44:	89 e5                	mov    %esp,%ebp
  800a46:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a52:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	01 d0                	add    %edx,%eax
  800a5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a64:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a68:	74 06                	je     800a70 <vsnprintf+0x2d>
  800a6a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a6e:	7f 07                	jg     800a77 <vsnprintf+0x34>
		return -E_INVAL;
  800a70:	b8 03 00 00 00       	mov    $0x3,%eax
  800a75:	eb 20                	jmp    800a97 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a77:	ff 75 14             	pushl  0x14(%ebp)
  800a7a:	ff 75 10             	pushl  0x10(%ebp)
  800a7d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a80:	50                   	push   %eax
  800a81:	68 0d 0a 80 00       	push   $0x800a0d
  800a86:	e8 92 fb ff ff       	call   80061d <vprintfmt>
  800a8b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a91:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a97:	c9                   	leave  
  800a98:	c3                   	ret    

00800a99 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a99:	55                   	push   %ebp
  800a9a:	89 e5                	mov    %esp,%ebp
  800a9c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a9f:	8d 45 10             	lea    0x10(%ebp),%eax
  800aa2:	83 c0 04             	add    $0x4,%eax
  800aa5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800aa8:	8b 45 10             	mov    0x10(%ebp),%eax
  800aab:	ff 75 f4             	pushl  -0xc(%ebp)
  800aae:	50                   	push   %eax
  800aaf:	ff 75 0c             	pushl  0xc(%ebp)
  800ab2:	ff 75 08             	pushl  0x8(%ebp)
  800ab5:	e8 89 ff ff ff       	call   800a43 <vsnprintf>
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac3:	c9                   	leave  
  800ac4:	c3                   	ret    

00800ac5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ac5:	55                   	push   %ebp
  800ac6:	89 e5                	mov    %esp,%ebp
  800ac8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800acb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ad2:	eb 06                	jmp    800ada <strlen+0x15>
		n++;
  800ad4:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ad7:	ff 45 08             	incl   0x8(%ebp)
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	8a 00                	mov    (%eax),%al
  800adf:	84 c0                	test   %al,%al
  800ae1:	75 f1                	jne    800ad4 <strlen+0xf>
		n++;
	return n;
  800ae3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ae6:	c9                   	leave  
  800ae7:	c3                   	ret    

00800ae8 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ae8:	55                   	push   %ebp
  800ae9:	89 e5                	mov    %esp,%ebp
  800aeb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800aee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800af5:	eb 09                	jmp    800b00 <strnlen+0x18>
		n++;
  800af7:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800afa:	ff 45 08             	incl   0x8(%ebp)
  800afd:	ff 4d 0c             	decl   0xc(%ebp)
  800b00:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b04:	74 09                	je     800b0f <strnlen+0x27>
  800b06:	8b 45 08             	mov    0x8(%ebp),%eax
  800b09:	8a 00                	mov    (%eax),%al
  800b0b:	84 c0                	test   %al,%al
  800b0d:	75 e8                	jne    800af7 <strnlen+0xf>
		n++;
	return n;
  800b0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b12:	c9                   	leave  
  800b13:	c3                   	ret    

00800b14 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b14:	55                   	push   %ebp
  800b15:	89 e5                	mov    %esp,%ebp
  800b17:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b20:	90                   	nop
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	8d 50 01             	lea    0x1(%eax),%edx
  800b27:	89 55 08             	mov    %edx,0x8(%ebp)
  800b2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b30:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b33:	8a 12                	mov    (%edx),%dl
  800b35:	88 10                	mov    %dl,(%eax)
  800b37:	8a 00                	mov    (%eax),%al
  800b39:	84 c0                	test   %al,%al
  800b3b:	75 e4                	jne    800b21 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b40:	c9                   	leave  
  800b41:	c3                   	ret    

00800b42 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b42:	55                   	push   %ebp
  800b43:	89 e5                	mov    %esp,%ebp
  800b45:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b4e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b55:	eb 1f                	jmp    800b76 <strncpy+0x34>
		*dst++ = *src;
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	8d 50 01             	lea    0x1(%eax),%edx
  800b5d:	89 55 08             	mov    %edx,0x8(%ebp)
  800b60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b63:	8a 12                	mov    (%edx),%dl
  800b65:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6a:	8a 00                	mov    (%eax),%al
  800b6c:	84 c0                	test   %al,%al
  800b6e:	74 03                	je     800b73 <strncpy+0x31>
			src++;
  800b70:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b73:	ff 45 fc             	incl   -0x4(%ebp)
  800b76:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b79:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b7c:	72 d9                	jb     800b57 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b81:	c9                   	leave  
  800b82:	c3                   	ret    

00800b83 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b83:	55                   	push   %ebp
  800b84:	89 e5                	mov    %esp,%ebp
  800b86:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b93:	74 30                	je     800bc5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b95:	eb 16                	jmp    800bad <strlcpy+0x2a>
			*dst++ = *src++;
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	8d 50 01             	lea    0x1(%eax),%edx
  800b9d:	89 55 08             	mov    %edx,0x8(%ebp)
  800ba0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ba6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ba9:	8a 12                	mov    (%edx),%dl
  800bab:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bad:	ff 4d 10             	decl   0x10(%ebp)
  800bb0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb4:	74 09                	je     800bbf <strlcpy+0x3c>
  800bb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb9:	8a 00                	mov    (%eax),%al
  800bbb:	84 c0                	test   %al,%al
  800bbd:	75 d8                	jne    800b97 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bc5:	8b 55 08             	mov    0x8(%ebp),%edx
  800bc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bcb:	29 c2                	sub    %eax,%edx
  800bcd:	89 d0                	mov    %edx,%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bd4:	eb 06                	jmp    800bdc <strcmp+0xb>
		p++, q++;
  800bd6:	ff 45 08             	incl   0x8(%ebp)
  800bd9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	8a 00                	mov    (%eax),%al
  800be1:	84 c0                	test   %al,%al
  800be3:	74 0e                	je     800bf3 <strcmp+0x22>
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	8a 10                	mov    (%eax),%dl
  800bea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bed:	8a 00                	mov    (%eax),%al
  800bef:	38 c2                	cmp    %al,%dl
  800bf1:	74 e3                	je     800bd6 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	8a 00                	mov    (%eax),%al
  800bf8:	0f b6 d0             	movzbl %al,%edx
  800bfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfe:	8a 00                	mov    (%eax),%al
  800c00:	0f b6 c0             	movzbl %al,%eax
  800c03:	29 c2                	sub    %eax,%edx
  800c05:	89 d0                	mov    %edx,%eax
}
  800c07:	5d                   	pop    %ebp
  800c08:	c3                   	ret    

00800c09 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c0c:	eb 09                	jmp    800c17 <strncmp+0xe>
		n--, p++, q++;
  800c0e:	ff 4d 10             	decl   0x10(%ebp)
  800c11:	ff 45 08             	incl   0x8(%ebp)
  800c14:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c17:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c1b:	74 17                	je     800c34 <strncmp+0x2b>
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	8a 00                	mov    (%eax),%al
  800c22:	84 c0                	test   %al,%al
  800c24:	74 0e                	je     800c34 <strncmp+0x2b>
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
  800c29:	8a 10                	mov    (%eax),%dl
  800c2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2e:	8a 00                	mov    (%eax),%al
  800c30:	38 c2                	cmp    %al,%dl
  800c32:	74 da                	je     800c0e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c38:	75 07                	jne    800c41 <strncmp+0x38>
		return 0;
  800c3a:	b8 00 00 00 00       	mov    $0x0,%eax
  800c3f:	eb 14                	jmp    800c55 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8a 00                	mov    (%eax),%al
  800c46:	0f b6 d0             	movzbl %al,%edx
  800c49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4c:	8a 00                	mov    (%eax),%al
  800c4e:	0f b6 c0             	movzbl %al,%eax
  800c51:	29 c2                	sub    %eax,%edx
  800c53:	89 d0                	mov    %edx,%eax
}
  800c55:	5d                   	pop    %ebp
  800c56:	c3                   	ret    

00800c57 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c57:	55                   	push   %ebp
  800c58:	89 e5                	mov    %esp,%ebp
  800c5a:	83 ec 04             	sub    $0x4,%esp
  800c5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c60:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c63:	eb 12                	jmp    800c77 <strchr+0x20>
		if (*s == c)
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c6d:	75 05                	jne    800c74 <strchr+0x1d>
			return (char *) s;
  800c6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c72:	eb 11                	jmp    800c85 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c74:	ff 45 08             	incl   0x8(%ebp)
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	8a 00                	mov    (%eax),%al
  800c7c:	84 c0                	test   %al,%al
  800c7e:	75 e5                	jne    800c65 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c85:	c9                   	leave  
  800c86:	c3                   	ret    

00800c87 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c87:	55                   	push   %ebp
  800c88:	89 e5                	mov    %esp,%ebp
  800c8a:	83 ec 04             	sub    $0x4,%esp
  800c8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c90:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c93:	eb 0d                	jmp    800ca2 <strfind+0x1b>
		if (*s == c)
  800c95:	8b 45 08             	mov    0x8(%ebp),%eax
  800c98:	8a 00                	mov    (%eax),%al
  800c9a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c9d:	74 0e                	je     800cad <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c9f:	ff 45 08             	incl   0x8(%ebp)
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8a 00                	mov    (%eax),%al
  800ca7:	84 c0                	test   %al,%al
  800ca9:	75 ea                	jne    800c95 <strfind+0xe>
  800cab:	eb 01                	jmp    800cae <strfind+0x27>
		if (*s == c)
			break;
  800cad:	90                   	nop
	return (char *) s;
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cb1:	c9                   	leave  
  800cb2:	c3                   	ret    

00800cb3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800cb3:	55                   	push   %ebp
  800cb4:	89 e5                	mov    %esp,%ebp
  800cb6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800cbf:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800cc5:	eb 0e                	jmp    800cd5 <memset+0x22>
		*p++ = c;
  800cc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cca:	8d 50 01             	lea    0x1(%eax),%edx
  800ccd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800cd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd3:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800cd5:	ff 4d f8             	decl   -0x8(%ebp)
  800cd8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800cdc:	79 e9                	jns    800cc7 <memset+0x14>
		*p++ = c;

	return v;
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ce1:	c9                   	leave  
  800ce2:	c3                   	ret    

00800ce3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ce3:	55                   	push   %ebp
  800ce4:	89 e5                	mov    %esp,%ebp
  800ce6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800cf5:	eb 16                	jmp    800d0d <memcpy+0x2a>
		*d++ = *s++;
  800cf7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cfa:	8d 50 01             	lea    0x1(%eax),%edx
  800cfd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d00:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d03:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d06:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d09:	8a 12                	mov    (%edx),%dl
  800d0b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d10:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d13:	89 55 10             	mov    %edx,0x10(%ebp)
  800d16:	85 c0                	test   %eax,%eax
  800d18:	75 dd                	jne    800cf7 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d1d:	c9                   	leave  
  800d1e:	c3                   	ret    

00800d1f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d1f:	55                   	push   %ebp
  800d20:	89 e5                	mov    %esp,%ebp
  800d22:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800d25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d31:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d34:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d37:	73 50                	jae    800d89 <memmove+0x6a>
  800d39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3f:	01 d0                	add    %edx,%eax
  800d41:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d44:	76 43                	jbe    800d89 <memmove+0x6a>
		s += n;
  800d46:	8b 45 10             	mov    0x10(%ebp),%eax
  800d49:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d52:	eb 10                	jmp    800d64 <memmove+0x45>
			*--d = *--s;
  800d54:	ff 4d f8             	decl   -0x8(%ebp)
  800d57:	ff 4d fc             	decl   -0x4(%ebp)
  800d5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5d:	8a 10                	mov    (%eax),%dl
  800d5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d62:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d64:	8b 45 10             	mov    0x10(%ebp),%eax
  800d67:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d6a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d6d:	85 c0                	test   %eax,%eax
  800d6f:	75 e3                	jne    800d54 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d71:	eb 23                	jmp    800d96 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d76:	8d 50 01             	lea    0x1(%eax),%edx
  800d79:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d7c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d7f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d82:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d85:	8a 12                	mov    (%edx),%dl
  800d87:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800d89:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d8f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d92:	85 c0                	test   %eax,%eax
  800d94:	75 dd                	jne    800d73 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d99:	c9                   	leave  
  800d9a:	c3                   	ret    

00800d9b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800d9b:	55                   	push   %ebp
  800d9c:	89 e5                	mov    %esp,%ebp
  800d9e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800da7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daa:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800dad:	eb 2a                	jmp    800dd9 <memcmp+0x3e>
		if (*s1 != *s2)
  800daf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db2:	8a 10                	mov    (%eax),%dl
  800db4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db7:	8a 00                	mov    (%eax),%al
  800db9:	38 c2                	cmp    %al,%dl
  800dbb:	74 16                	je     800dd3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800dbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc0:	8a 00                	mov    (%eax),%al
  800dc2:	0f b6 d0             	movzbl %al,%edx
  800dc5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc8:	8a 00                	mov    (%eax),%al
  800dca:	0f b6 c0             	movzbl %al,%eax
  800dcd:	29 c2                	sub    %eax,%edx
  800dcf:	89 d0                	mov    %edx,%eax
  800dd1:	eb 18                	jmp    800deb <memcmp+0x50>
		s1++, s2++;
  800dd3:	ff 45 fc             	incl   -0x4(%ebp)
  800dd6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800dd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddf:	89 55 10             	mov    %edx,0x10(%ebp)
  800de2:	85 c0                	test   %eax,%eax
  800de4:	75 c9                	jne    800daf <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800de6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800deb:	c9                   	leave  
  800dec:	c3                   	ret    

00800ded <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ded:	55                   	push   %ebp
  800dee:	89 e5                	mov    %esp,%ebp
  800df0:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800df3:	8b 55 08             	mov    0x8(%ebp),%edx
  800df6:	8b 45 10             	mov    0x10(%ebp),%eax
  800df9:	01 d0                	add    %edx,%eax
  800dfb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800dfe:	eb 15                	jmp    800e15 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	0f b6 d0             	movzbl %al,%edx
  800e08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0b:	0f b6 c0             	movzbl %al,%eax
  800e0e:	39 c2                	cmp    %eax,%edx
  800e10:	74 0d                	je     800e1f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e12:	ff 45 08             	incl   0x8(%ebp)
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e1b:	72 e3                	jb     800e00 <memfind+0x13>
  800e1d:	eb 01                	jmp    800e20 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e1f:	90                   	nop
	return (void *) s;
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e23:	c9                   	leave  
  800e24:	c3                   	ret    

00800e25 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e25:	55                   	push   %ebp
  800e26:	89 e5                	mov    %esp,%ebp
  800e28:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e2b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e32:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e39:	eb 03                	jmp    800e3e <strtol+0x19>
		s++;
  800e3b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	3c 20                	cmp    $0x20,%al
  800e45:	74 f4                	je     800e3b <strtol+0x16>
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	3c 09                	cmp    $0x9,%al
  800e4e:	74 eb                	je     800e3b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	8a 00                	mov    (%eax),%al
  800e55:	3c 2b                	cmp    $0x2b,%al
  800e57:	75 05                	jne    800e5e <strtol+0x39>
		s++;
  800e59:	ff 45 08             	incl   0x8(%ebp)
  800e5c:	eb 13                	jmp    800e71 <strtol+0x4c>
	else if (*s == '-')
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	8a 00                	mov    (%eax),%al
  800e63:	3c 2d                	cmp    $0x2d,%al
  800e65:	75 0a                	jne    800e71 <strtol+0x4c>
		s++, neg = 1;
  800e67:	ff 45 08             	incl   0x8(%ebp)
  800e6a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e75:	74 06                	je     800e7d <strtol+0x58>
  800e77:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e7b:	75 20                	jne    800e9d <strtol+0x78>
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	8a 00                	mov    (%eax),%al
  800e82:	3c 30                	cmp    $0x30,%al
  800e84:	75 17                	jne    800e9d <strtol+0x78>
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	40                   	inc    %eax
  800e8a:	8a 00                	mov    (%eax),%al
  800e8c:	3c 78                	cmp    $0x78,%al
  800e8e:	75 0d                	jne    800e9d <strtol+0x78>
		s += 2, base = 16;
  800e90:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800e94:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800e9b:	eb 28                	jmp    800ec5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800e9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea1:	75 15                	jne    800eb8 <strtol+0x93>
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	3c 30                	cmp    $0x30,%al
  800eaa:	75 0c                	jne    800eb8 <strtol+0x93>
		s++, base = 8;
  800eac:	ff 45 08             	incl   0x8(%ebp)
  800eaf:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800eb6:	eb 0d                	jmp    800ec5 <strtol+0xa0>
	else if (base == 0)
  800eb8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ebc:	75 07                	jne    800ec5 <strtol+0xa0>
		base = 10;
  800ebe:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	3c 2f                	cmp    $0x2f,%al
  800ecc:	7e 19                	jle    800ee7 <strtol+0xc2>
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	3c 39                	cmp    $0x39,%al
  800ed5:	7f 10                	jg     800ee7 <strtol+0xc2>
			dig = *s - '0';
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	0f be c0             	movsbl %al,%eax
  800edf:	83 e8 30             	sub    $0x30,%eax
  800ee2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ee5:	eb 42                	jmp    800f29 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	8a 00                	mov    (%eax),%al
  800eec:	3c 60                	cmp    $0x60,%al
  800eee:	7e 19                	jle    800f09 <strtol+0xe4>
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	3c 7a                	cmp    $0x7a,%al
  800ef7:	7f 10                	jg     800f09 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	0f be c0             	movsbl %al,%eax
  800f01:	83 e8 57             	sub    $0x57,%eax
  800f04:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f07:	eb 20                	jmp    800f29 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	8a 00                	mov    (%eax),%al
  800f0e:	3c 40                	cmp    $0x40,%al
  800f10:	7e 39                	jle    800f4b <strtol+0x126>
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	8a 00                	mov    (%eax),%al
  800f17:	3c 5a                	cmp    $0x5a,%al
  800f19:	7f 30                	jg     800f4b <strtol+0x126>
			dig = *s - 'A' + 10;
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	0f be c0             	movsbl %al,%eax
  800f23:	83 e8 37             	sub    $0x37,%eax
  800f26:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f29:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f2c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f2f:	7d 19                	jge    800f4a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f31:	ff 45 08             	incl   0x8(%ebp)
  800f34:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f37:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f3b:	89 c2                	mov    %eax,%edx
  800f3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f40:	01 d0                	add    %edx,%eax
  800f42:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f45:	e9 7b ff ff ff       	jmp    800ec5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f4a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f4f:	74 08                	je     800f59 <strtol+0x134>
		*endptr = (char *) s;
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	8b 55 08             	mov    0x8(%ebp),%edx
  800f57:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f59:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f5d:	74 07                	je     800f66 <strtol+0x141>
  800f5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f62:	f7 d8                	neg    %eax
  800f64:	eb 03                	jmp    800f69 <strtol+0x144>
  800f66:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f69:	c9                   	leave  
  800f6a:	c3                   	ret    

00800f6b <ltostr>:

void
ltostr(long value, char *str)
{
  800f6b:	55                   	push   %ebp
  800f6c:	89 e5                	mov    %esp,%ebp
  800f6e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f78:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f83:	79 13                	jns    800f98 <ltostr+0x2d>
	{
		neg = 1;
  800f85:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800f92:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800f95:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800fa0:	99                   	cltd   
  800fa1:	f7 f9                	idiv   %ecx
  800fa3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800fa6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa9:	8d 50 01             	lea    0x1(%eax),%edx
  800fac:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800faf:	89 c2                	mov    %eax,%edx
  800fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb4:	01 d0                	add    %edx,%eax
  800fb6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800fb9:	83 c2 30             	add    $0x30,%edx
  800fbc:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800fbe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fc1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fc6:	f7 e9                	imul   %ecx
  800fc8:	c1 fa 02             	sar    $0x2,%edx
  800fcb:	89 c8                	mov    %ecx,%eax
  800fcd:	c1 f8 1f             	sar    $0x1f,%eax
  800fd0:	29 c2                	sub    %eax,%edx
  800fd2:	89 d0                	mov    %edx,%eax
  800fd4:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800fd7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fda:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fdf:	f7 e9                	imul   %ecx
  800fe1:	c1 fa 02             	sar    $0x2,%edx
  800fe4:	89 c8                	mov    %ecx,%eax
  800fe6:	c1 f8 1f             	sar    $0x1f,%eax
  800fe9:	29 c2                	sub    %eax,%edx
  800feb:	89 d0                	mov    %edx,%eax
  800fed:	c1 e0 02             	shl    $0x2,%eax
  800ff0:	01 d0                	add    %edx,%eax
  800ff2:	01 c0                	add    %eax,%eax
  800ff4:	29 c1                	sub    %eax,%ecx
  800ff6:	89 ca                	mov    %ecx,%edx
  800ff8:	85 d2                	test   %edx,%edx
  800ffa:	75 9c                	jne    800f98 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ffc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801003:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801006:	48                   	dec    %eax
  801007:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80100a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80100e:	74 3d                	je     80104d <ltostr+0xe2>
		start = 1 ;
  801010:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801017:	eb 34                	jmp    80104d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801019:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80101c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101f:	01 d0                	add    %edx,%eax
  801021:	8a 00                	mov    (%eax),%al
  801023:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801026:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801029:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102c:	01 c2                	add    %eax,%edx
  80102e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801031:	8b 45 0c             	mov    0xc(%ebp),%eax
  801034:	01 c8                	add    %ecx,%eax
  801036:	8a 00                	mov    (%eax),%al
  801038:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80103a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80103d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801040:	01 c2                	add    %eax,%edx
  801042:	8a 45 eb             	mov    -0x15(%ebp),%al
  801045:	88 02                	mov    %al,(%edx)
		start++ ;
  801047:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80104a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80104d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801050:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801053:	7c c4                	jl     801019 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801055:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801058:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105b:	01 d0                	add    %edx,%eax
  80105d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801060:	90                   	nop
  801061:	c9                   	leave  
  801062:	c3                   	ret    

00801063 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801063:	55                   	push   %ebp
  801064:	89 e5                	mov    %esp,%ebp
  801066:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801069:	ff 75 08             	pushl  0x8(%ebp)
  80106c:	e8 54 fa ff ff       	call   800ac5 <strlen>
  801071:	83 c4 04             	add    $0x4,%esp
  801074:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801077:	ff 75 0c             	pushl  0xc(%ebp)
  80107a:	e8 46 fa ff ff       	call   800ac5 <strlen>
  80107f:	83 c4 04             	add    $0x4,%esp
  801082:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801085:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80108c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801093:	eb 17                	jmp    8010ac <strcconcat+0x49>
		final[s] = str1[s] ;
  801095:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801098:	8b 45 10             	mov    0x10(%ebp),%eax
  80109b:	01 c2                	add    %eax,%edx
  80109d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	01 c8                	add    %ecx,%eax
  8010a5:	8a 00                	mov    (%eax),%al
  8010a7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010a9:	ff 45 fc             	incl   -0x4(%ebp)
  8010ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010af:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010b2:	7c e1                	jl     801095 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010c2:	eb 1f                	jmp    8010e3 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c7:	8d 50 01             	lea    0x1(%eax),%edx
  8010ca:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010cd:	89 c2                	mov    %eax,%edx
  8010cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d2:	01 c2                	add    %eax,%edx
  8010d4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8010d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010da:	01 c8                	add    %ecx,%eax
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8010e0:	ff 45 f8             	incl   -0x8(%ebp)
  8010e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010e9:	7c d9                	jl     8010c4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8010eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f1:	01 d0                	add    %edx,%eax
  8010f3:	c6 00 00             	movb   $0x0,(%eax)
}
  8010f6:	90                   	nop
  8010f7:	c9                   	leave  
  8010f8:	c3                   	ret    

008010f9 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8010f9:	55                   	push   %ebp
  8010fa:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8010fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8010ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801105:	8b 45 14             	mov    0x14(%ebp),%eax
  801108:	8b 00                	mov    (%eax),%eax
  80110a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801111:	8b 45 10             	mov    0x10(%ebp),%eax
  801114:	01 d0                	add    %edx,%eax
  801116:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80111c:	eb 0c                	jmp    80112a <strsplit+0x31>
			*string++ = 0;
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	8d 50 01             	lea    0x1(%eax),%edx
  801124:	89 55 08             	mov    %edx,0x8(%ebp)
  801127:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	84 c0                	test   %al,%al
  801131:	74 18                	je     80114b <strsplit+0x52>
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	0f be c0             	movsbl %al,%eax
  80113b:	50                   	push   %eax
  80113c:	ff 75 0c             	pushl  0xc(%ebp)
  80113f:	e8 13 fb ff ff       	call   800c57 <strchr>
  801144:	83 c4 08             	add    $0x8,%esp
  801147:	85 c0                	test   %eax,%eax
  801149:	75 d3                	jne    80111e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	84 c0                	test   %al,%al
  801152:	74 5a                	je     8011ae <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801154:	8b 45 14             	mov    0x14(%ebp),%eax
  801157:	8b 00                	mov    (%eax),%eax
  801159:	83 f8 0f             	cmp    $0xf,%eax
  80115c:	75 07                	jne    801165 <strsplit+0x6c>
		{
			return 0;
  80115e:	b8 00 00 00 00       	mov    $0x0,%eax
  801163:	eb 66                	jmp    8011cb <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801165:	8b 45 14             	mov    0x14(%ebp),%eax
  801168:	8b 00                	mov    (%eax),%eax
  80116a:	8d 48 01             	lea    0x1(%eax),%ecx
  80116d:	8b 55 14             	mov    0x14(%ebp),%edx
  801170:	89 0a                	mov    %ecx,(%edx)
  801172:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801179:	8b 45 10             	mov    0x10(%ebp),%eax
  80117c:	01 c2                	add    %eax,%edx
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801183:	eb 03                	jmp    801188 <strsplit+0x8f>
			string++;
  801185:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	84 c0                	test   %al,%al
  80118f:	74 8b                	je     80111c <strsplit+0x23>
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	8a 00                	mov    (%eax),%al
  801196:	0f be c0             	movsbl %al,%eax
  801199:	50                   	push   %eax
  80119a:	ff 75 0c             	pushl  0xc(%ebp)
  80119d:	e8 b5 fa ff ff       	call   800c57 <strchr>
  8011a2:	83 c4 08             	add    $0x8,%esp
  8011a5:	85 c0                	test   %eax,%eax
  8011a7:	74 dc                	je     801185 <strsplit+0x8c>
			string++;
	}
  8011a9:	e9 6e ff ff ff       	jmp    80111c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011ae:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011af:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b2:	8b 00                	mov    (%eax),%eax
  8011b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011be:	01 d0                	add    %edx,%eax
  8011c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011c6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011cb:	c9                   	leave  
  8011cc:	c3                   	ret    

008011cd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011cd:	55                   	push   %ebp
  8011ce:	89 e5                	mov    %esp,%ebp
  8011d0:	57                   	push   %edi
  8011d1:	56                   	push   %esi
  8011d2:	53                   	push   %ebx
  8011d3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011dc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011df:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011e2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8011e5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8011e8:	cd 30                	int    $0x30
  8011ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8011ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011f0:	83 c4 10             	add    $0x10,%esp
  8011f3:	5b                   	pop    %ebx
  8011f4:	5e                   	pop    %esi
  8011f5:	5f                   	pop    %edi
  8011f6:	5d                   	pop    %ebp
  8011f7:	c3                   	ret    

008011f8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8011f8:	55                   	push   %ebp
  8011f9:	89 e5                	mov    %esp,%ebp
  8011fb:	83 ec 04             	sub    $0x4,%esp
  8011fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801201:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801204:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	6a 00                	push   $0x0
  80120d:	6a 00                	push   $0x0
  80120f:	52                   	push   %edx
  801210:	ff 75 0c             	pushl  0xc(%ebp)
  801213:	50                   	push   %eax
  801214:	6a 00                	push   $0x0
  801216:	e8 b2 ff ff ff       	call   8011cd <syscall>
  80121b:	83 c4 18             	add    $0x18,%esp
}
  80121e:	90                   	nop
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <sys_cgetc>:

int
sys_cgetc(void)
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 00                	push   $0x0
  80122c:	6a 00                	push   $0x0
  80122e:	6a 01                	push   $0x1
  801230:	e8 98 ff ff ff       	call   8011cd <syscall>
  801235:	83 c4 18             	add    $0x18,%esp
}
  801238:	c9                   	leave  
  801239:	c3                   	ret    

0080123a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80123a:	55                   	push   %ebp
  80123b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	6a 00                	push   $0x0
  801248:	50                   	push   %eax
  801249:	6a 05                	push   $0x5
  80124b:	e8 7d ff ff ff       	call   8011cd <syscall>
  801250:	83 c4 18             	add    $0x18,%esp
}
  801253:	c9                   	leave  
  801254:	c3                   	ret    

00801255 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801255:	55                   	push   %ebp
  801256:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 02                	push   $0x2
  801264:	e8 64 ff ff ff       	call   8011cd <syscall>
  801269:	83 c4 18             	add    $0x18,%esp
}
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 00                	push   $0x0
  80127b:	6a 03                	push   $0x3
  80127d:	e8 4b ff ff ff       	call   8011cd <syscall>
  801282:	83 c4 18             	add    $0x18,%esp
}
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 00                	push   $0x0
  801294:	6a 04                	push   $0x4
  801296:	e8 32 ff ff ff       	call   8011cd <syscall>
  80129b:	83 c4 18             	add    $0x18,%esp
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <sys_env_exit>:


void sys_env_exit(void)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 06                	push   $0x6
  8012af:	e8 19 ff ff ff       	call   8011cd <syscall>
  8012b4:	83 c4 18             	add    $0x18,%esp
}
  8012b7:	90                   	nop
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8012bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	52                   	push   %edx
  8012ca:	50                   	push   %eax
  8012cb:	6a 07                	push   $0x7
  8012cd:	e8 fb fe ff ff       	call   8011cd <syscall>
  8012d2:	83 c4 18             	add    $0x18,%esp
}
  8012d5:	c9                   	leave  
  8012d6:	c3                   	ret    

008012d7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8012d7:	55                   	push   %ebp
  8012d8:	89 e5                	mov    %esp,%ebp
  8012da:	56                   	push   %esi
  8012db:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8012dc:	8b 75 18             	mov    0x18(%ebp),%esi
  8012df:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012e2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	56                   	push   %esi
  8012ec:	53                   	push   %ebx
  8012ed:	51                   	push   %ecx
  8012ee:	52                   	push   %edx
  8012ef:	50                   	push   %eax
  8012f0:	6a 08                	push   $0x8
  8012f2:	e8 d6 fe ff ff       	call   8011cd <syscall>
  8012f7:	83 c4 18             	add    $0x18,%esp
}
  8012fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8012fd:	5b                   	pop    %ebx
  8012fe:	5e                   	pop    %esi
  8012ff:	5d                   	pop    %ebp
  801300:	c3                   	ret    

00801301 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801301:	55                   	push   %ebp
  801302:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801304:	8b 55 0c             	mov    0xc(%ebp),%edx
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	52                   	push   %edx
  801311:	50                   	push   %eax
  801312:	6a 09                	push   $0x9
  801314:	e8 b4 fe ff ff       	call   8011cd <syscall>
  801319:	83 c4 18             	add    $0x18,%esp
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	ff 75 0c             	pushl  0xc(%ebp)
  80132a:	ff 75 08             	pushl  0x8(%ebp)
  80132d:	6a 0a                	push   $0xa
  80132f:	e8 99 fe ff ff       	call   8011cd <syscall>
  801334:	83 c4 18             	add    $0x18,%esp
}
  801337:	c9                   	leave  
  801338:	c3                   	ret    

00801339 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801339:	55                   	push   %ebp
  80133a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 0b                	push   $0xb
  801348:	e8 80 fe ff ff       	call   8011cd <syscall>
  80134d:	83 c4 18             	add    $0x18,%esp
}
  801350:	c9                   	leave  
  801351:	c3                   	ret    

00801352 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801352:	55                   	push   %ebp
  801353:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 00                	push   $0x0
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 0c                	push   $0xc
  801361:	e8 67 fe ff ff       	call   8011cd <syscall>
  801366:	83 c4 18             	add    $0x18,%esp
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 0d                	push   $0xd
  80137a:	e8 4e fe ff ff       	call   8011cd <syscall>
  80137f:	83 c4 18             	add    $0x18,%esp
}
  801382:	c9                   	leave  
  801383:	c3                   	ret    

00801384 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801384:	55                   	push   %ebp
  801385:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	6a 00                	push   $0x0
  80138d:	ff 75 0c             	pushl  0xc(%ebp)
  801390:	ff 75 08             	pushl  0x8(%ebp)
  801393:	6a 11                	push   $0x11
  801395:	e8 33 fe ff ff       	call   8011cd <syscall>
  80139a:	83 c4 18             	add    $0x18,%esp
	return;
  80139d:	90                   	nop
}
  80139e:	c9                   	leave  
  80139f:	c3                   	ret    

008013a0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8013a0:	55                   	push   %ebp
  8013a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	ff 75 0c             	pushl  0xc(%ebp)
  8013ac:	ff 75 08             	pushl  0x8(%ebp)
  8013af:	6a 12                	push   $0x12
  8013b1:	e8 17 fe ff ff       	call   8011cd <syscall>
  8013b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8013b9:	90                   	nop
}
  8013ba:	c9                   	leave  
  8013bb:	c3                   	ret    

008013bc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013bc:	55                   	push   %ebp
  8013bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 0e                	push   $0xe
  8013cb:	e8 fd fd ff ff       	call   8011cd <syscall>
  8013d0:	83 c4 18             	add    $0x18,%esp
}
  8013d3:	c9                   	leave  
  8013d4:	c3                   	ret    

008013d5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013d5:	55                   	push   %ebp
  8013d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	ff 75 08             	pushl  0x8(%ebp)
  8013e3:	6a 0f                	push   $0xf
  8013e5:	e8 e3 fd ff ff       	call   8011cd <syscall>
  8013ea:	83 c4 18             	add    $0x18,%esp
}
  8013ed:	c9                   	leave  
  8013ee:	c3                   	ret    

008013ef <sys_scarce_memory>:

void sys_scarce_memory()
{
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 10                	push   $0x10
  8013fe:	e8 ca fd ff ff       	call   8011cd <syscall>
  801403:	83 c4 18             	add    $0x18,%esp
}
  801406:	90                   	nop
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 14                	push   $0x14
  801418:	e8 b0 fd ff ff       	call   8011cd <syscall>
  80141d:	83 c4 18             	add    $0x18,%esp
}
  801420:	90                   	nop
  801421:	c9                   	leave  
  801422:	c3                   	ret    

00801423 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801423:	55                   	push   %ebp
  801424:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 15                	push   $0x15
  801432:	e8 96 fd ff ff       	call   8011cd <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
}
  80143a:	90                   	nop
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_cputc>:


void
sys_cputc(const char c)
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
  801440:	83 ec 04             	sub    $0x4,%esp
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801449:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	50                   	push   %eax
  801456:	6a 16                	push   $0x16
  801458:	e8 70 fd ff ff       	call   8011cd <syscall>
  80145d:	83 c4 18             	add    $0x18,%esp
}
  801460:	90                   	nop
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 17                	push   $0x17
  801472:	e8 56 fd ff ff       	call   8011cd <syscall>
  801477:	83 c4 18             	add    $0x18,%esp
}
  80147a:	90                   	nop
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	ff 75 0c             	pushl  0xc(%ebp)
  80148c:	50                   	push   %eax
  80148d:	6a 18                	push   $0x18
  80148f:	e8 39 fd ff ff       	call   8011cd <syscall>
  801494:	83 c4 18             	add    $0x18,%esp
}
  801497:	c9                   	leave  
  801498:	c3                   	ret    

00801499 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801499:	55                   	push   %ebp
  80149a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80149c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	52                   	push   %edx
  8014a9:	50                   	push   %eax
  8014aa:	6a 1b                	push   $0x1b
  8014ac:	e8 1c fd ff ff       	call   8011cd <syscall>
  8014b1:	83 c4 18             	add    $0x18,%esp
}
  8014b4:	c9                   	leave  
  8014b5:	c3                   	ret    

008014b6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	52                   	push   %edx
  8014c6:	50                   	push   %eax
  8014c7:	6a 19                	push   $0x19
  8014c9:	e8 ff fc ff ff       	call   8011cd <syscall>
  8014ce:	83 c4 18             	add    $0x18,%esp
}
  8014d1:	90                   	nop
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	52                   	push   %edx
  8014e4:	50                   	push   %eax
  8014e5:	6a 1a                	push   $0x1a
  8014e7:	e8 e1 fc ff ff       	call   8011cd <syscall>
  8014ec:	83 c4 18             	add    $0x18,%esp
}
  8014ef:	90                   	nop
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
  8014f5:	83 ec 04             	sub    $0x4,%esp
  8014f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8014fe:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801501:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801505:	8b 45 08             	mov    0x8(%ebp),%eax
  801508:	6a 00                	push   $0x0
  80150a:	51                   	push   %ecx
  80150b:	52                   	push   %edx
  80150c:	ff 75 0c             	pushl  0xc(%ebp)
  80150f:	50                   	push   %eax
  801510:	6a 1c                	push   $0x1c
  801512:	e8 b6 fc ff ff       	call   8011cd <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
}
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80151f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	52                   	push   %edx
  80152c:	50                   	push   %eax
  80152d:	6a 1d                	push   $0x1d
  80152f:	e8 99 fc ff ff       	call   8011cd <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80153c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80153f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	51                   	push   %ecx
  80154a:	52                   	push   %edx
  80154b:	50                   	push   %eax
  80154c:	6a 1e                	push   $0x1e
  80154e:	e8 7a fc ff ff       	call   8011cd <syscall>
  801553:	83 c4 18             	add    $0x18,%esp
}
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80155b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155e:	8b 45 08             	mov    0x8(%ebp),%eax
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	52                   	push   %edx
  801568:	50                   	push   %eax
  801569:	6a 1f                	push   $0x1f
  80156b:	e8 5d fc ff ff       	call   8011cd <syscall>
  801570:	83 c4 18             	add    $0x18,%esp
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 20                	push   $0x20
  801584:	e8 44 fc ff ff       	call   8011cd <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801591:	8b 45 08             	mov    0x8(%ebp),%eax
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	ff 75 10             	pushl  0x10(%ebp)
  80159b:	ff 75 0c             	pushl  0xc(%ebp)
  80159e:	50                   	push   %eax
  80159f:	6a 21                	push   $0x21
  8015a1:	e8 27 fc ff ff       	call   8011cd <syscall>
  8015a6:	83 c4 18             	add    $0x18,%esp
}
  8015a9:	c9                   	leave  
  8015aa:	c3                   	ret    

008015ab <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8015ab:	55                   	push   %ebp
  8015ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	50                   	push   %eax
  8015ba:	6a 22                	push   $0x22
  8015bc:	e8 0c fc ff ff       	call   8011cd <syscall>
  8015c1:	83 c4 18             	add    $0x18,%esp
}
  8015c4:	90                   	nop
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	50                   	push   %eax
  8015d6:	6a 23                	push   $0x23
  8015d8:	e8 f0 fb ff ff       	call   8011cd <syscall>
  8015dd:	83 c4 18             	add    $0x18,%esp
}
  8015e0:	90                   	nop
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
  8015e6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8015e9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015ec:	8d 50 04             	lea    0x4(%eax),%edx
  8015ef:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	52                   	push   %edx
  8015f9:	50                   	push   %eax
  8015fa:	6a 24                	push   $0x24
  8015fc:	e8 cc fb ff ff       	call   8011cd <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
	return result;
  801604:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801607:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80160a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80160d:	89 01                	mov    %eax,(%ecx)
  80160f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	c9                   	leave  
  801616:	c2 04 00             	ret    $0x4

00801619 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	ff 75 10             	pushl  0x10(%ebp)
  801623:	ff 75 0c             	pushl  0xc(%ebp)
  801626:	ff 75 08             	pushl  0x8(%ebp)
  801629:	6a 13                	push   $0x13
  80162b:	e8 9d fb ff ff       	call   8011cd <syscall>
  801630:	83 c4 18             	add    $0x18,%esp
	return ;
  801633:	90                   	nop
}
  801634:	c9                   	leave  
  801635:	c3                   	ret    

00801636 <sys_rcr2>:
uint32 sys_rcr2()
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 25                	push   $0x25
  801645:	e8 83 fb ff ff       	call   8011cd <syscall>
  80164a:	83 c4 18             	add    $0x18,%esp
}
  80164d:	c9                   	leave  
  80164e:	c3                   	ret    

0080164f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80164f:	55                   	push   %ebp
  801650:	89 e5                	mov    %esp,%ebp
  801652:	83 ec 04             	sub    $0x4,%esp
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80165b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	50                   	push   %eax
  801668:	6a 26                	push   $0x26
  80166a:	e8 5e fb ff ff       	call   8011cd <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
	return ;
  801672:	90                   	nop
}
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <rsttst>:
void rsttst()
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 28                	push   $0x28
  801684:	e8 44 fb ff ff       	call   8011cd <syscall>
  801689:	83 c4 18             	add    $0x18,%esp
	return ;
  80168c:	90                   	nop
}
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
  801692:	83 ec 04             	sub    $0x4,%esp
  801695:	8b 45 14             	mov    0x14(%ebp),%eax
  801698:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80169b:	8b 55 18             	mov    0x18(%ebp),%edx
  80169e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016a2:	52                   	push   %edx
  8016a3:	50                   	push   %eax
  8016a4:	ff 75 10             	pushl  0x10(%ebp)
  8016a7:	ff 75 0c             	pushl  0xc(%ebp)
  8016aa:	ff 75 08             	pushl  0x8(%ebp)
  8016ad:	6a 27                	push   $0x27
  8016af:	e8 19 fb ff ff       	call   8011cd <syscall>
  8016b4:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b7:	90                   	nop
}
  8016b8:	c9                   	leave  
  8016b9:	c3                   	ret    

008016ba <chktst>:
void chktst(uint32 n)
{
  8016ba:	55                   	push   %ebp
  8016bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	ff 75 08             	pushl  0x8(%ebp)
  8016c8:	6a 29                	push   $0x29
  8016ca:	e8 fe fa ff ff       	call   8011cd <syscall>
  8016cf:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d2:	90                   	nop
}
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <inctst>:

void inctst()
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 2a                	push   $0x2a
  8016e4:	e8 e4 fa ff ff       	call   8011cd <syscall>
  8016e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ec:	90                   	nop
}
  8016ed:	c9                   	leave  
  8016ee:	c3                   	ret    

008016ef <gettst>:
uint32 gettst()
{
  8016ef:	55                   	push   %ebp
  8016f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 2b                	push   $0x2b
  8016fe:	e8 ca fa ff ff       	call   8011cd <syscall>
  801703:	83 c4 18             	add    $0x18,%esp
}
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
  80170b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 2c                	push   $0x2c
  80171a:	e8 ae fa ff ff       	call   8011cd <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
  801722:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801725:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801729:	75 07                	jne    801732 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80172b:	b8 01 00 00 00       	mov    $0x1,%eax
  801730:	eb 05                	jmp    801737 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801732:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
  80173c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 2c                	push   $0x2c
  80174b:	e8 7d fa ff ff       	call   8011cd <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
  801753:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801756:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80175a:	75 07                	jne    801763 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80175c:	b8 01 00 00 00       	mov    $0x1,%eax
  801761:	eb 05                	jmp    801768 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801763:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 2c                	push   $0x2c
  80177c:	e8 4c fa ff ff       	call   8011cd <syscall>
  801781:	83 c4 18             	add    $0x18,%esp
  801784:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801787:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80178b:	75 07                	jne    801794 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80178d:	b8 01 00 00 00       	mov    $0x1,%eax
  801792:	eb 05                	jmp    801799 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801794:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
  80179e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 2c                	push   $0x2c
  8017ad:	e8 1b fa ff ff       	call   8011cd <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
  8017b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8017b8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8017bc:	75 07                	jne    8017c5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8017be:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c3:	eb 05                	jmp    8017ca <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8017c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	ff 75 08             	pushl  0x8(%ebp)
  8017da:	6a 2d                	push   $0x2d
  8017dc:	e8 ec f9 ff ff       	call   8011cd <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e4:	90                   	nop
}
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    
  8017e7:	90                   	nop

008017e8 <__udivdi3>:
  8017e8:	55                   	push   %ebp
  8017e9:	57                   	push   %edi
  8017ea:	56                   	push   %esi
  8017eb:	53                   	push   %ebx
  8017ec:	83 ec 1c             	sub    $0x1c,%esp
  8017ef:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8017f3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8017f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017fb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8017ff:	89 ca                	mov    %ecx,%edx
  801801:	89 f8                	mov    %edi,%eax
  801803:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801807:	85 f6                	test   %esi,%esi
  801809:	75 2d                	jne    801838 <__udivdi3+0x50>
  80180b:	39 cf                	cmp    %ecx,%edi
  80180d:	77 65                	ja     801874 <__udivdi3+0x8c>
  80180f:	89 fd                	mov    %edi,%ebp
  801811:	85 ff                	test   %edi,%edi
  801813:	75 0b                	jne    801820 <__udivdi3+0x38>
  801815:	b8 01 00 00 00       	mov    $0x1,%eax
  80181a:	31 d2                	xor    %edx,%edx
  80181c:	f7 f7                	div    %edi
  80181e:	89 c5                	mov    %eax,%ebp
  801820:	31 d2                	xor    %edx,%edx
  801822:	89 c8                	mov    %ecx,%eax
  801824:	f7 f5                	div    %ebp
  801826:	89 c1                	mov    %eax,%ecx
  801828:	89 d8                	mov    %ebx,%eax
  80182a:	f7 f5                	div    %ebp
  80182c:	89 cf                	mov    %ecx,%edi
  80182e:	89 fa                	mov    %edi,%edx
  801830:	83 c4 1c             	add    $0x1c,%esp
  801833:	5b                   	pop    %ebx
  801834:	5e                   	pop    %esi
  801835:	5f                   	pop    %edi
  801836:	5d                   	pop    %ebp
  801837:	c3                   	ret    
  801838:	39 ce                	cmp    %ecx,%esi
  80183a:	77 28                	ja     801864 <__udivdi3+0x7c>
  80183c:	0f bd fe             	bsr    %esi,%edi
  80183f:	83 f7 1f             	xor    $0x1f,%edi
  801842:	75 40                	jne    801884 <__udivdi3+0x9c>
  801844:	39 ce                	cmp    %ecx,%esi
  801846:	72 0a                	jb     801852 <__udivdi3+0x6a>
  801848:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80184c:	0f 87 9e 00 00 00    	ja     8018f0 <__udivdi3+0x108>
  801852:	b8 01 00 00 00       	mov    $0x1,%eax
  801857:	89 fa                	mov    %edi,%edx
  801859:	83 c4 1c             	add    $0x1c,%esp
  80185c:	5b                   	pop    %ebx
  80185d:	5e                   	pop    %esi
  80185e:	5f                   	pop    %edi
  80185f:	5d                   	pop    %ebp
  801860:	c3                   	ret    
  801861:	8d 76 00             	lea    0x0(%esi),%esi
  801864:	31 ff                	xor    %edi,%edi
  801866:	31 c0                	xor    %eax,%eax
  801868:	89 fa                	mov    %edi,%edx
  80186a:	83 c4 1c             	add    $0x1c,%esp
  80186d:	5b                   	pop    %ebx
  80186e:	5e                   	pop    %esi
  80186f:	5f                   	pop    %edi
  801870:	5d                   	pop    %ebp
  801871:	c3                   	ret    
  801872:	66 90                	xchg   %ax,%ax
  801874:	89 d8                	mov    %ebx,%eax
  801876:	f7 f7                	div    %edi
  801878:	31 ff                	xor    %edi,%edi
  80187a:	89 fa                	mov    %edi,%edx
  80187c:	83 c4 1c             	add    $0x1c,%esp
  80187f:	5b                   	pop    %ebx
  801880:	5e                   	pop    %esi
  801881:	5f                   	pop    %edi
  801882:	5d                   	pop    %ebp
  801883:	c3                   	ret    
  801884:	bd 20 00 00 00       	mov    $0x20,%ebp
  801889:	89 eb                	mov    %ebp,%ebx
  80188b:	29 fb                	sub    %edi,%ebx
  80188d:	89 f9                	mov    %edi,%ecx
  80188f:	d3 e6                	shl    %cl,%esi
  801891:	89 c5                	mov    %eax,%ebp
  801893:	88 d9                	mov    %bl,%cl
  801895:	d3 ed                	shr    %cl,%ebp
  801897:	89 e9                	mov    %ebp,%ecx
  801899:	09 f1                	or     %esi,%ecx
  80189b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80189f:	89 f9                	mov    %edi,%ecx
  8018a1:	d3 e0                	shl    %cl,%eax
  8018a3:	89 c5                	mov    %eax,%ebp
  8018a5:	89 d6                	mov    %edx,%esi
  8018a7:	88 d9                	mov    %bl,%cl
  8018a9:	d3 ee                	shr    %cl,%esi
  8018ab:	89 f9                	mov    %edi,%ecx
  8018ad:	d3 e2                	shl    %cl,%edx
  8018af:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018b3:	88 d9                	mov    %bl,%cl
  8018b5:	d3 e8                	shr    %cl,%eax
  8018b7:	09 c2                	or     %eax,%edx
  8018b9:	89 d0                	mov    %edx,%eax
  8018bb:	89 f2                	mov    %esi,%edx
  8018bd:	f7 74 24 0c          	divl   0xc(%esp)
  8018c1:	89 d6                	mov    %edx,%esi
  8018c3:	89 c3                	mov    %eax,%ebx
  8018c5:	f7 e5                	mul    %ebp
  8018c7:	39 d6                	cmp    %edx,%esi
  8018c9:	72 19                	jb     8018e4 <__udivdi3+0xfc>
  8018cb:	74 0b                	je     8018d8 <__udivdi3+0xf0>
  8018cd:	89 d8                	mov    %ebx,%eax
  8018cf:	31 ff                	xor    %edi,%edi
  8018d1:	e9 58 ff ff ff       	jmp    80182e <__udivdi3+0x46>
  8018d6:	66 90                	xchg   %ax,%ax
  8018d8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8018dc:	89 f9                	mov    %edi,%ecx
  8018de:	d3 e2                	shl    %cl,%edx
  8018e0:	39 c2                	cmp    %eax,%edx
  8018e2:	73 e9                	jae    8018cd <__udivdi3+0xe5>
  8018e4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8018e7:	31 ff                	xor    %edi,%edi
  8018e9:	e9 40 ff ff ff       	jmp    80182e <__udivdi3+0x46>
  8018ee:	66 90                	xchg   %ax,%ax
  8018f0:	31 c0                	xor    %eax,%eax
  8018f2:	e9 37 ff ff ff       	jmp    80182e <__udivdi3+0x46>
  8018f7:	90                   	nop

008018f8 <__umoddi3>:
  8018f8:	55                   	push   %ebp
  8018f9:	57                   	push   %edi
  8018fa:	56                   	push   %esi
  8018fb:	53                   	push   %ebx
  8018fc:	83 ec 1c             	sub    $0x1c,%esp
  8018ff:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801903:	8b 74 24 34          	mov    0x34(%esp),%esi
  801907:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80190b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80190f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801913:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801917:	89 f3                	mov    %esi,%ebx
  801919:	89 fa                	mov    %edi,%edx
  80191b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80191f:	89 34 24             	mov    %esi,(%esp)
  801922:	85 c0                	test   %eax,%eax
  801924:	75 1a                	jne    801940 <__umoddi3+0x48>
  801926:	39 f7                	cmp    %esi,%edi
  801928:	0f 86 a2 00 00 00    	jbe    8019d0 <__umoddi3+0xd8>
  80192e:	89 c8                	mov    %ecx,%eax
  801930:	89 f2                	mov    %esi,%edx
  801932:	f7 f7                	div    %edi
  801934:	89 d0                	mov    %edx,%eax
  801936:	31 d2                	xor    %edx,%edx
  801938:	83 c4 1c             	add    $0x1c,%esp
  80193b:	5b                   	pop    %ebx
  80193c:	5e                   	pop    %esi
  80193d:	5f                   	pop    %edi
  80193e:	5d                   	pop    %ebp
  80193f:	c3                   	ret    
  801940:	39 f0                	cmp    %esi,%eax
  801942:	0f 87 ac 00 00 00    	ja     8019f4 <__umoddi3+0xfc>
  801948:	0f bd e8             	bsr    %eax,%ebp
  80194b:	83 f5 1f             	xor    $0x1f,%ebp
  80194e:	0f 84 ac 00 00 00    	je     801a00 <__umoddi3+0x108>
  801954:	bf 20 00 00 00       	mov    $0x20,%edi
  801959:	29 ef                	sub    %ebp,%edi
  80195b:	89 fe                	mov    %edi,%esi
  80195d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801961:	89 e9                	mov    %ebp,%ecx
  801963:	d3 e0                	shl    %cl,%eax
  801965:	89 d7                	mov    %edx,%edi
  801967:	89 f1                	mov    %esi,%ecx
  801969:	d3 ef                	shr    %cl,%edi
  80196b:	09 c7                	or     %eax,%edi
  80196d:	89 e9                	mov    %ebp,%ecx
  80196f:	d3 e2                	shl    %cl,%edx
  801971:	89 14 24             	mov    %edx,(%esp)
  801974:	89 d8                	mov    %ebx,%eax
  801976:	d3 e0                	shl    %cl,%eax
  801978:	89 c2                	mov    %eax,%edx
  80197a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80197e:	d3 e0                	shl    %cl,%eax
  801980:	89 44 24 04          	mov    %eax,0x4(%esp)
  801984:	8b 44 24 08          	mov    0x8(%esp),%eax
  801988:	89 f1                	mov    %esi,%ecx
  80198a:	d3 e8                	shr    %cl,%eax
  80198c:	09 d0                	or     %edx,%eax
  80198e:	d3 eb                	shr    %cl,%ebx
  801990:	89 da                	mov    %ebx,%edx
  801992:	f7 f7                	div    %edi
  801994:	89 d3                	mov    %edx,%ebx
  801996:	f7 24 24             	mull   (%esp)
  801999:	89 c6                	mov    %eax,%esi
  80199b:	89 d1                	mov    %edx,%ecx
  80199d:	39 d3                	cmp    %edx,%ebx
  80199f:	0f 82 87 00 00 00    	jb     801a2c <__umoddi3+0x134>
  8019a5:	0f 84 91 00 00 00    	je     801a3c <__umoddi3+0x144>
  8019ab:	8b 54 24 04          	mov    0x4(%esp),%edx
  8019af:	29 f2                	sub    %esi,%edx
  8019b1:	19 cb                	sbb    %ecx,%ebx
  8019b3:	89 d8                	mov    %ebx,%eax
  8019b5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8019b9:	d3 e0                	shl    %cl,%eax
  8019bb:	89 e9                	mov    %ebp,%ecx
  8019bd:	d3 ea                	shr    %cl,%edx
  8019bf:	09 d0                	or     %edx,%eax
  8019c1:	89 e9                	mov    %ebp,%ecx
  8019c3:	d3 eb                	shr    %cl,%ebx
  8019c5:	89 da                	mov    %ebx,%edx
  8019c7:	83 c4 1c             	add    $0x1c,%esp
  8019ca:	5b                   	pop    %ebx
  8019cb:	5e                   	pop    %esi
  8019cc:	5f                   	pop    %edi
  8019cd:	5d                   	pop    %ebp
  8019ce:	c3                   	ret    
  8019cf:	90                   	nop
  8019d0:	89 fd                	mov    %edi,%ebp
  8019d2:	85 ff                	test   %edi,%edi
  8019d4:	75 0b                	jne    8019e1 <__umoddi3+0xe9>
  8019d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8019db:	31 d2                	xor    %edx,%edx
  8019dd:	f7 f7                	div    %edi
  8019df:	89 c5                	mov    %eax,%ebp
  8019e1:	89 f0                	mov    %esi,%eax
  8019e3:	31 d2                	xor    %edx,%edx
  8019e5:	f7 f5                	div    %ebp
  8019e7:	89 c8                	mov    %ecx,%eax
  8019e9:	f7 f5                	div    %ebp
  8019eb:	89 d0                	mov    %edx,%eax
  8019ed:	e9 44 ff ff ff       	jmp    801936 <__umoddi3+0x3e>
  8019f2:	66 90                	xchg   %ax,%ax
  8019f4:	89 c8                	mov    %ecx,%eax
  8019f6:	89 f2                	mov    %esi,%edx
  8019f8:	83 c4 1c             	add    $0x1c,%esp
  8019fb:	5b                   	pop    %ebx
  8019fc:	5e                   	pop    %esi
  8019fd:	5f                   	pop    %edi
  8019fe:	5d                   	pop    %ebp
  8019ff:	c3                   	ret    
  801a00:	3b 04 24             	cmp    (%esp),%eax
  801a03:	72 06                	jb     801a0b <__umoddi3+0x113>
  801a05:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a09:	77 0f                	ja     801a1a <__umoddi3+0x122>
  801a0b:	89 f2                	mov    %esi,%edx
  801a0d:	29 f9                	sub    %edi,%ecx
  801a0f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a13:	89 14 24             	mov    %edx,(%esp)
  801a16:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a1a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801a1e:	8b 14 24             	mov    (%esp),%edx
  801a21:	83 c4 1c             	add    $0x1c,%esp
  801a24:	5b                   	pop    %ebx
  801a25:	5e                   	pop    %esi
  801a26:	5f                   	pop    %edi
  801a27:	5d                   	pop    %ebp
  801a28:	c3                   	ret    
  801a29:	8d 76 00             	lea    0x0(%esi),%esi
  801a2c:	2b 04 24             	sub    (%esp),%eax
  801a2f:	19 fa                	sbb    %edi,%edx
  801a31:	89 d1                	mov    %edx,%ecx
  801a33:	89 c6                	mov    %eax,%esi
  801a35:	e9 71 ff ff ff       	jmp    8019ab <__umoddi3+0xb3>
  801a3a:	66 90                	xchg   %ax,%ax
  801a3c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801a40:	72 ea                	jb     801a2c <__umoddi3+0x134>
  801a42:	89 d9                	mov    %ebx,%ecx
  801a44:	e9 62 ff ff ff       	jmp    8019ab <__umoddi3+0xb3>
