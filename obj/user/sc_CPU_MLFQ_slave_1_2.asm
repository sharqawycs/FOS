
obj/user/sc_CPU_MLFQ_slave_1_2:     file format elf32-i386


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
  800031:	e8 3d 00 00 00       	call   800073 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
	int sum = 0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(int i = 0; i < 5; i++)
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004c:	eb 09                	jmp    800057 <_main+0x1f>
		sum+=i;
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	01 45 f4             	add    %eax,-0xc(%ebp)
_main(void)
{
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
	int sum = 0;
	for(int i = 0; i < 5; i++)
  800054:	ff 45 f0             	incl   -0x10(%ebp)
  800057:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  80005b:	7e f1                	jle    80004e <_main+0x16>
		sum+=i;

	//int x = busy_wait(RAND(500000, 1000000));
	int x = busy_wait(100000);
  80005d:	83 ec 0c             	sub    $0xc,%esp
  800060:	68 a0 86 01 00       	push   $0x186a0
  800065:	e8 18 16 00 00       	call   801682 <busy_wait>
  80006a:	83 c4 10             	add    $0x10,%esp
  80006d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//env_sleep(10);
}
  800070:	90                   	nop
  800071:	c9                   	leave  
  800072:	c3                   	ret    

00800073 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800073:	55                   	push   %ebp
  800074:	89 e5                	mov    %esp,%ebp
  800076:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800079:	e8 f6 0f 00 00       	call   801074 <sys_getenvindex>
  80007e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800081:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800084:	89 d0                	mov    %edx,%eax
  800086:	01 c0                	add    %eax,%eax
  800088:	01 d0                	add    %edx,%eax
  80008a:	c1 e0 02             	shl    $0x2,%eax
  80008d:	01 d0                	add    %edx,%eax
  80008f:	c1 e0 06             	shl    $0x6,%eax
  800092:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800097:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80009c:	a1 04 20 80 00       	mov    0x802004,%eax
  8000a1:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000a7:	84 c0                	test   %al,%al
  8000a9:	74 0f                	je     8000ba <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000ab:	a1 04 20 80 00       	mov    0x802004,%eax
  8000b0:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000b5:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000be:	7e 0a                	jle    8000ca <libmain+0x57>
		binaryname = argv[0];
  8000c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000c3:	8b 00                	mov    (%eax),%eax
  8000c5:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000ca:	83 ec 08             	sub    $0x8,%esp
  8000cd:	ff 75 0c             	pushl  0xc(%ebp)
  8000d0:	ff 75 08             	pushl  0x8(%ebp)
  8000d3:	e8 60 ff ff ff       	call   800038 <_main>
  8000d8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000db:	e8 2f 11 00 00       	call   80120f <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000e0:	83 ec 0c             	sub    $0xc,%esp
  8000e3:	68 38 19 80 00       	push   $0x801938
  8000e8:	e8 5c 01 00 00       	call   800249 <cprintf>
  8000ed:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000f0:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f5:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8000fb:	a1 04 20 80 00       	mov    0x802004,%eax
  800100:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800106:	83 ec 04             	sub    $0x4,%esp
  800109:	52                   	push   %edx
  80010a:	50                   	push   %eax
  80010b:	68 60 19 80 00       	push   $0x801960
  800110:	e8 34 01 00 00       	call   800249 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800118:	a1 04 20 80 00       	mov    0x802004,%eax
  80011d:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800123:	83 ec 08             	sub    $0x8,%esp
  800126:	50                   	push   %eax
  800127:	68 85 19 80 00       	push   $0x801985
  80012c:	e8 18 01 00 00       	call   800249 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 38 19 80 00       	push   $0x801938
  80013c:	e8 08 01 00 00       	call   800249 <cprintf>
  800141:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800144:	e8 e0 10 00 00       	call   801229 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800149:	e8 19 00 00 00       	call   800167 <exit>
}
  80014e:	90                   	nop
  80014f:	c9                   	leave  
  800150:	c3                   	ret    

00800151 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800151:	55                   	push   %ebp
  800152:	89 e5                	mov    %esp,%ebp
  800154:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800157:	83 ec 0c             	sub    $0xc,%esp
  80015a:	6a 00                	push   $0x0
  80015c:	e8 df 0e 00 00       	call   801040 <sys_env_destroy>
  800161:	83 c4 10             	add    $0x10,%esp
}
  800164:	90                   	nop
  800165:	c9                   	leave  
  800166:	c3                   	ret    

00800167 <exit>:

void
exit(void)
{
  800167:	55                   	push   %ebp
  800168:	89 e5                	mov    %esp,%ebp
  80016a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80016d:	e8 34 0f 00 00       	call   8010a6 <sys_env_exit>
}
  800172:	90                   	nop
  800173:	c9                   	leave  
  800174:	c3                   	ret    

00800175 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800175:	55                   	push   %ebp
  800176:	89 e5                	mov    %esp,%ebp
  800178:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80017b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80017e:	8b 00                	mov    (%eax),%eax
  800180:	8d 48 01             	lea    0x1(%eax),%ecx
  800183:	8b 55 0c             	mov    0xc(%ebp),%edx
  800186:	89 0a                	mov    %ecx,(%edx)
  800188:	8b 55 08             	mov    0x8(%ebp),%edx
  80018b:	88 d1                	mov    %dl,%cl
  80018d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800190:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800194:	8b 45 0c             	mov    0xc(%ebp),%eax
  800197:	8b 00                	mov    (%eax),%eax
  800199:	3d ff 00 00 00       	cmp    $0xff,%eax
  80019e:	75 2c                	jne    8001cc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001a0:	a0 08 20 80 00       	mov    0x802008,%al
  8001a5:	0f b6 c0             	movzbl %al,%eax
  8001a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ab:	8b 12                	mov    (%edx),%edx
  8001ad:	89 d1                	mov    %edx,%ecx
  8001af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b2:	83 c2 08             	add    $0x8,%edx
  8001b5:	83 ec 04             	sub    $0x4,%esp
  8001b8:	50                   	push   %eax
  8001b9:	51                   	push   %ecx
  8001ba:	52                   	push   %edx
  8001bb:	e8 3e 0e 00 00       	call   800ffe <sys_cputs>
  8001c0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001cf:	8b 40 04             	mov    0x4(%eax),%eax
  8001d2:	8d 50 01             	lea    0x1(%eax),%edx
  8001d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d8:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001db:	90                   	nop
  8001dc:	c9                   	leave  
  8001dd:	c3                   	ret    

008001de <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001de:	55                   	push   %ebp
  8001df:	89 e5                	mov    %esp,%ebp
  8001e1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001e7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001ee:	00 00 00 
	b.cnt = 0;
  8001f1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001f8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001fb:	ff 75 0c             	pushl  0xc(%ebp)
  8001fe:	ff 75 08             	pushl  0x8(%ebp)
  800201:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800207:	50                   	push   %eax
  800208:	68 75 01 80 00       	push   $0x800175
  80020d:	e8 11 02 00 00       	call   800423 <vprintfmt>
  800212:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800215:	a0 08 20 80 00       	mov    0x802008,%al
  80021a:	0f b6 c0             	movzbl %al,%eax
  80021d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800223:	83 ec 04             	sub    $0x4,%esp
  800226:	50                   	push   %eax
  800227:	52                   	push   %edx
  800228:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80022e:	83 c0 08             	add    $0x8,%eax
  800231:	50                   	push   %eax
  800232:	e8 c7 0d 00 00       	call   800ffe <sys_cputs>
  800237:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80023a:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800241:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800247:	c9                   	leave  
  800248:	c3                   	ret    

00800249 <cprintf>:

int cprintf(const char *fmt, ...) {
  800249:	55                   	push   %ebp
  80024a:	89 e5                	mov    %esp,%ebp
  80024c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80024f:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800256:	8d 45 0c             	lea    0xc(%ebp),%eax
  800259:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80025c:	8b 45 08             	mov    0x8(%ebp),%eax
  80025f:	83 ec 08             	sub    $0x8,%esp
  800262:	ff 75 f4             	pushl  -0xc(%ebp)
  800265:	50                   	push   %eax
  800266:	e8 73 ff ff ff       	call   8001de <vcprintf>
  80026b:	83 c4 10             	add    $0x10,%esp
  80026e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800271:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800274:	c9                   	leave  
  800275:	c3                   	ret    

00800276 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800276:	55                   	push   %ebp
  800277:	89 e5                	mov    %esp,%ebp
  800279:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80027c:	e8 8e 0f 00 00       	call   80120f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800281:	8d 45 0c             	lea    0xc(%ebp),%eax
  800284:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800287:	8b 45 08             	mov    0x8(%ebp),%eax
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	ff 75 f4             	pushl  -0xc(%ebp)
  800290:	50                   	push   %eax
  800291:	e8 48 ff ff ff       	call   8001de <vcprintf>
  800296:	83 c4 10             	add    $0x10,%esp
  800299:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80029c:	e8 88 0f 00 00       	call   801229 <sys_enable_interrupt>
	return cnt;
  8002a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002a4:	c9                   	leave  
  8002a5:	c3                   	ret    

008002a6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002a6:	55                   	push   %ebp
  8002a7:	89 e5                	mov    %esp,%ebp
  8002a9:	53                   	push   %ebx
  8002aa:	83 ec 14             	sub    $0x14,%esp
  8002ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8002b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002b9:	8b 45 18             	mov    0x18(%ebp),%eax
  8002bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8002c1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002c4:	77 55                	ja     80031b <printnum+0x75>
  8002c6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002c9:	72 05                	jb     8002d0 <printnum+0x2a>
  8002cb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002ce:	77 4b                	ja     80031b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002d0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002d3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002d6:	8b 45 18             	mov    0x18(%ebp),%eax
  8002d9:	ba 00 00 00 00       	mov    $0x0,%edx
  8002de:	52                   	push   %edx
  8002df:	50                   	push   %eax
  8002e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e3:	ff 75 f0             	pushl  -0x10(%ebp)
  8002e6:	e8 b9 13 00 00       	call   8016a4 <__udivdi3>
  8002eb:	83 c4 10             	add    $0x10,%esp
  8002ee:	83 ec 04             	sub    $0x4,%esp
  8002f1:	ff 75 20             	pushl  0x20(%ebp)
  8002f4:	53                   	push   %ebx
  8002f5:	ff 75 18             	pushl  0x18(%ebp)
  8002f8:	52                   	push   %edx
  8002f9:	50                   	push   %eax
  8002fa:	ff 75 0c             	pushl  0xc(%ebp)
  8002fd:	ff 75 08             	pushl  0x8(%ebp)
  800300:	e8 a1 ff ff ff       	call   8002a6 <printnum>
  800305:	83 c4 20             	add    $0x20,%esp
  800308:	eb 1a                	jmp    800324 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80030a:	83 ec 08             	sub    $0x8,%esp
  80030d:	ff 75 0c             	pushl  0xc(%ebp)
  800310:	ff 75 20             	pushl  0x20(%ebp)
  800313:	8b 45 08             	mov    0x8(%ebp),%eax
  800316:	ff d0                	call   *%eax
  800318:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80031b:	ff 4d 1c             	decl   0x1c(%ebp)
  80031e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800322:	7f e6                	jg     80030a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800324:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800327:	bb 00 00 00 00       	mov    $0x0,%ebx
  80032c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800332:	53                   	push   %ebx
  800333:	51                   	push   %ecx
  800334:	52                   	push   %edx
  800335:	50                   	push   %eax
  800336:	e8 79 14 00 00       	call   8017b4 <__umoddi3>
  80033b:	83 c4 10             	add    $0x10,%esp
  80033e:	05 b4 1b 80 00       	add    $0x801bb4,%eax
  800343:	8a 00                	mov    (%eax),%al
  800345:	0f be c0             	movsbl %al,%eax
  800348:	83 ec 08             	sub    $0x8,%esp
  80034b:	ff 75 0c             	pushl  0xc(%ebp)
  80034e:	50                   	push   %eax
  80034f:	8b 45 08             	mov    0x8(%ebp),%eax
  800352:	ff d0                	call   *%eax
  800354:	83 c4 10             	add    $0x10,%esp
}
  800357:	90                   	nop
  800358:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80035b:	c9                   	leave  
  80035c:	c3                   	ret    

0080035d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80035d:	55                   	push   %ebp
  80035e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800360:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800364:	7e 1c                	jle    800382 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	8b 00                	mov    (%eax),%eax
  80036b:	8d 50 08             	lea    0x8(%eax),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	89 10                	mov    %edx,(%eax)
  800373:	8b 45 08             	mov    0x8(%ebp),%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	83 e8 08             	sub    $0x8,%eax
  80037b:	8b 50 04             	mov    0x4(%eax),%edx
  80037e:	8b 00                	mov    (%eax),%eax
  800380:	eb 40                	jmp    8003c2 <getuint+0x65>
	else if (lflag)
  800382:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800386:	74 1e                	je     8003a6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	8b 00                	mov    (%eax),%eax
  80038d:	8d 50 04             	lea    0x4(%eax),%edx
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	89 10                	mov    %edx,(%eax)
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	8b 00                	mov    (%eax),%eax
  80039a:	83 e8 04             	sub    $0x4,%eax
  80039d:	8b 00                	mov    (%eax),%eax
  80039f:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a4:	eb 1c                	jmp    8003c2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a9:	8b 00                	mov    (%eax),%eax
  8003ab:	8d 50 04             	lea    0x4(%eax),%edx
  8003ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b1:	89 10                	mov    %edx,(%eax)
  8003b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b6:	8b 00                	mov    (%eax),%eax
  8003b8:	83 e8 04             	sub    $0x4,%eax
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003c2:	5d                   	pop    %ebp
  8003c3:	c3                   	ret    

008003c4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003c4:	55                   	push   %ebp
  8003c5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003cb:	7e 1c                	jle    8003e9 <getint+0x25>
		return va_arg(*ap, long long);
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	8d 50 08             	lea    0x8(%eax),%edx
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	89 10                	mov    %edx,(%eax)
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	83 e8 08             	sub    $0x8,%eax
  8003e2:	8b 50 04             	mov    0x4(%eax),%edx
  8003e5:	8b 00                	mov    (%eax),%eax
  8003e7:	eb 38                	jmp    800421 <getint+0x5d>
	else if (lflag)
  8003e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003ed:	74 1a                	je     800409 <getint+0x45>
		return va_arg(*ap, long);
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	8b 00                	mov    (%eax),%eax
  8003f4:	8d 50 04             	lea    0x4(%eax),%edx
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	89 10                	mov    %edx,(%eax)
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	83 e8 04             	sub    $0x4,%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	99                   	cltd   
  800407:	eb 18                	jmp    800421 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	8d 50 04             	lea    0x4(%eax),%edx
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	89 10                	mov    %edx,(%eax)
  800416:	8b 45 08             	mov    0x8(%ebp),%eax
  800419:	8b 00                	mov    (%eax),%eax
  80041b:	83 e8 04             	sub    $0x4,%eax
  80041e:	8b 00                	mov    (%eax),%eax
  800420:	99                   	cltd   
}
  800421:	5d                   	pop    %ebp
  800422:	c3                   	ret    

00800423 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800423:	55                   	push   %ebp
  800424:	89 e5                	mov    %esp,%ebp
  800426:	56                   	push   %esi
  800427:	53                   	push   %ebx
  800428:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80042b:	eb 17                	jmp    800444 <vprintfmt+0x21>
			if (ch == '\0')
  80042d:	85 db                	test   %ebx,%ebx
  80042f:	0f 84 af 03 00 00    	je     8007e4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800435:	83 ec 08             	sub    $0x8,%esp
  800438:	ff 75 0c             	pushl  0xc(%ebp)
  80043b:	53                   	push   %ebx
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	ff d0                	call   *%eax
  800441:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800444:	8b 45 10             	mov    0x10(%ebp),%eax
  800447:	8d 50 01             	lea    0x1(%eax),%edx
  80044a:	89 55 10             	mov    %edx,0x10(%ebp)
  80044d:	8a 00                	mov    (%eax),%al
  80044f:	0f b6 d8             	movzbl %al,%ebx
  800452:	83 fb 25             	cmp    $0x25,%ebx
  800455:	75 d6                	jne    80042d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800457:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80045b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800462:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800469:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800470:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800477:	8b 45 10             	mov    0x10(%ebp),%eax
  80047a:	8d 50 01             	lea    0x1(%eax),%edx
  80047d:	89 55 10             	mov    %edx,0x10(%ebp)
  800480:	8a 00                	mov    (%eax),%al
  800482:	0f b6 d8             	movzbl %al,%ebx
  800485:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800488:	83 f8 55             	cmp    $0x55,%eax
  80048b:	0f 87 2b 03 00 00    	ja     8007bc <vprintfmt+0x399>
  800491:	8b 04 85 d8 1b 80 00 	mov    0x801bd8(,%eax,4),%eax
  800498:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80049a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80049e:	eb d7                	jmp    800477 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004a0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004a4:	eb d1                	jmp    800477 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004a6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004ad:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004b0:	89 d0                	mov    %edx,%eax
  8004b2:	c1 e0 02             	shl    $0x2,%eax
  8004b5:	01 d0                	add    %edx,%eax
  8004b7:	01 c0                	add    %eax,%eax
  8004b9:	01 d8                	add    %ebx,%eax
  8004bb:	83 e8 30             	sub    $0x30,%eax
  8004be:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c4:	8a 00                	mov    (%eax),%al
  8004c6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004c9:	83 fb 2f             	cmp    $0x2f,%ebx
  8004cc:	7e 3e                	jle    80050c <vprintfmt+0xe9>
  8004ce:	83 fb 39             	cmp    $0x39,%ebx
  8004d1:	7f 39                	jg     80050c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004d3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004d6:	eb d5                	jmp    8004ad <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8004db:	83 c0 04             	add    $0x4,%eax
  8004de:	89 45 14             	mov    %eax,0x14(%ebp)
  8004e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8004e4:	83 e8 04             	sub    $0x4,%eax
  8004e7:	8b 00                	mov    (%eax),%eax
  8004e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004ec:	eb 1f                	jmp    80050d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004f2:	79 83                	jns    800477 <vprintfmt+0x54>
				width = 0;
  8004f4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004fb:	e9 77 ff ff ff       	jmp    800477 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800500:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800507:	e9 6b ff ff ff       	jmp    800477 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80050c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80050d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800511:	0f 89 60 ff ff ff    	jns    800477 <vprintfmt+0x54>
				width = precision, precision = -1;
  800517:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80051a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80051d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800524:	e9 4e ff ff ff       	jmp    800477 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800529:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80052c:	e9 46 ff ff ff       	jmp    800477 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800531:	8b 45 14             	mov    0x14(%ebp),%eax
  800534:	83 c0 04             	add    $0x4,%eax
  800537:	89 45 14             	mov    %eax,0x14(%ebp)
  80053a:	8b 45 14             	mov    0x14(%ebp),%eax
  80053d:	83 e8 04             	sub    $0x4,%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	83 ec 08             	sub    $0x8,%esp
  800545:	ff 75 0c             	pushl  0xc(%ebp)
  800548:	50                   	push   %eax
  800549:	8b 45 08             	mov    0x8(%ebp),%eax
  80054c:	ff d0                	call   *%eax
  80054e:	83 c4 10             	add    $0x10,%esp
			break;
  800551:	e9 89 02 00 00       	jmp    8007df <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800556:	8b 45 14             	mov    0x14(%ebp),%eax
  800559:	83 c0 04             	add    $0x4,%eax
  80055c:	89 45 14             	mov    %eax,0x14(%ebp)
  80055f:	8b 45 14             	mov    0x14(%ebp),%eax
  800562:	83 e8 04             	sub    $0x4,%eax
  800565:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800567:	85 db                	test   %ebx,%ebx
  800569:	79 02                	jns    80056d <vprintfmt+0x14a>
				err = -err;
  80056b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80056d:	83 fb 64             	cmp    $0x64,%ebx
  800570:	7f 0b                	jg     80057d <vprintfmt+0x15a>
  800572:	8b 34 9d 20 1a 80 00 	mov    0x801a20(,%ebx,4),%esi
  800579:	85 f6                	test   %esi,%esi
  80057b:	75 19                	jne    800596 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80057d:	53                   	push   %ebx
  80057e:	68 c5 1b 80 00       	push   $0x801bc5
  800583:	ff 75 0c             	pushl  0xc(%ebp)
  800586:	ff 75 08             	pushl  0x8(%ebp)
  800589:	e8 5e 02 00 00       	call   8007ec <printfmt>
  80058e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800591:	e9 49 02 00 00       	jmp    8007df <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800596:	56                   	push   %esi
  800597:	68 ce 1b 80 00       	push   $0x801bce
  80059c:	ff 75 0c             	pushl  0xc(%ebp)
  80059f:	ff 75 08             	pushl  0x8(%ebp)
  8005a2:	e8 45 02 00 00       	call   8007ec <printfmt>
  8005a7:	83 c4 10             	add    $0x10,%esp
			break;
  8005aa:	e9 30 02 00 00       	jmp    8007df <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005af:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b2:	83 c0 04             	add    $0x4,%eax
  8005b5:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bb:	83 e8 04             	sub    $0x4,%eax
  8005be:	8b 30                	mov    (%eax),%esi
  8005c0:	85 f6                	test   %esi,%esi
  8005c2:	75 05                	jne    8005c9 <vprintfmt+0x1a6>
				p = "(null)";
  8005c4:	be d1 1b 80 00       	mov    $0x801bd1,%esi
			if (width > 0 && padc != '-')
  8005c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005cd:	7e 6d                	jle    80063c <vprintfmt+0x219>
  8005cf:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005d3:	74 67                	je     80063c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d8:	83 ec 08             	sub    $0x8,%esp
  8005db:	50                   	push   %eax
  8005dc:	56                   	push   %esi
  8005dd:	e8 0c 03 00 00       	call   8008ee <strnlen>
  8005e2:	83 c4 10             	add    $0x10,%esp
  8005e5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005e8:	eb 16                	jmp    800600 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005ea:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005ee:	83 ec 08             	sub    $0x8,%esp
  8005f1:	ff 75 0c             	pushl  0xc(%ebp)
  8005f4:	50                   	push   %eax
  8005f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f8:	ff d0                	call   *%eax
  8005fa:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005fd:	ff 4d e4             	decl   -0x1c(%ebp)
  800600:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800604:	7f e4                	jg     8005ea <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800606:	eb 34                	jmp    80063c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800608:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80060c:	74 1c                	je     80062a <vprintfmt+0x207>
  80060e:	83 fb 1f             	cmp    $0x1f,%ebx
  800611:	7e 05                	jle    800618 <vprintfmt+0x1f5>
  800613:	83 fb 7e             	cmp    $0x7e,%ebx
  800616:	7e 12                	jle    80062a <vprintfmt+0x207>
					putch('?', putdat);
  800618:	83 ec 08             	sub    $0x8,%esp
  80061b:	ff 75 0c             	pushl  0xc(%ebp)
  80061e:	6a 3f                	push   $0x3f
  800620:	8b 45 08             	mov    0x8(%ebp),%eax
  800623:	ff d0                	call   *%eax
  800625:	83 c4 10             	add    $0x10,%esp
  800628:	eb 0f                	jmp    800639 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80062a:	83 ec 08             	sub    $0x8,%esp
  80062d:	ff 75 0c             	pushl  0xc(%ebp)
  800630:	53                   	push   %ebx
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	ff d0                	call   *%eax
  800636:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800639:	ff 4d e4             	decl   -0x1c(%ebp)
  80063c:	89 f0                	mov    %esi,%eax
  80063e:	8d 70 01             	lea    0x1(%eax),%esi
  800641:	8a 00                	mov    (%eax),%al
  800643:	0f be d8             	movsbl %al,%ebx
  800646:	85 db                	test   %ebx,%ebx
  800648:	74 24                	je     80066e <vprintfmt+0x24b>
  80064a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80064e:	78 b8                	js     800608 <vprintfmt+0x1e5>
  800650:	ff 4d e0             	decl   -0x20(%ebp)
  800653:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800657:	79 af                	jns    800608 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800659:	eb 13                	jmp    80066e <vprintfmt+0x24b>
				putch(' ', putdat);
  80065b:	83 ec 08             	sub    $0x8,%esp
  80065e:	ff 75 0c             	pushl  0xc(%ebp)
  800661:	6a 20                	push   $0x20
  800663:	8b 45 08             	mov    0x8(%ebp),%eax
  800666:	ff d0                	call   *%eax
  800668:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80066b:	ff 4d e4             	decl   -0x1c(%ebp)
  80066e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800672:	7f e7                	jg     80065b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800674:	e9 66 01 00 00       	jmp    8007df <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800679:	83 ec 08             	sub    $0x8,%esp
  80067c:	ff 75 e8             	pushl  -0x18(%ebp)
  80067f:	8d 45 14             	lea    0x14(%ebp),%eax
  800682:	50                   	push   %eax
  800683:	e8 3c fd ff ff       	call   8003c4 <getint>
  800688:	83 c4 10             	add    $0x10,%esp
  80068b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80068e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800691:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800694:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800697:	85 d2                	test   %edx,%edx
  800699:	79 23                	jns    8006be <vprintfmt+0x29b>
				putch('-', putdat);
  80069b:	83 ec 08             	sub    $0x8,%esp
  80069e:	ff 75 0c             	pushl  0xc(%ebp)
  8006a1:	6a 2d                	push   $0x2d
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	ff d0                	call   *%eax
  8006a8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b1:	f7 d8                	neg    %eax
  8006b3:	83 d2 00             	adc    $0x0,%edx
  8006b6:	f7 da                	neg    %edx
  8006b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006be:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006c5:	e9 bc 00 00 00       	jmp    800786 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006ca:	83 ec 08             	sub    $0x8,%esp
  8006cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8006d0:	8d 45 14             	lea    0x14(%ebp),%eax
  8006d3:	50                   	push   %eax
  8006d4:	e8 84 fc ff ff       	call   80035d <getuint>
  8006d9:	83 c4 10             	add    $0x10,%esp
  8006dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006df:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006e2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006e9:	e9 98 00 00 00       	jmp    800786 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006ee:	83 ec 08             	sub    $0x8,%esp
  8006f1:	ff 75 0c             	pushl  0xc(%ebp)
  8006f4:	6a 58                	push   $0x58
  8006f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f9:	ff d0                	call   *%eax
  8006fb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006fe:	83 ec 08             	sub    $0x8,%esp
  800701:	ff 75 0c             	pushl  0xc(%ebp)
  800704:	6a 58                	push   $0x58
  800706:	8b 45 08             	mov    0x8(%ebp),%eax
  800709:	ff d0                	call   *%eax
  80070b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	6a 58                	push   $0x58
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	ff d0                	call   *%eax
  80071b:	83 c4 10             	add    $0x10,%esp
			break;
  80071e:	e9 bc 00 00 00       	jmp    8007df <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800723:	83 ec 08             	sub    $0x8,%esp
  800726:	ff 75 0c             	pushl  0xc(%ebp)
  800729:	6a 30                	push   $0x30
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	ff d0                	call   *%eax
  800730:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800733:	83 ec 08             	sub    $0x8,%esp
  800736:	ff 75 0c             	pushl  0xc(%ebp)
  800739:	6a 78                	push   $0x78
  80073b:	8b 45 08             	mov    0x8(%ebp),%eax
  80073e:	ff d0                	call   *%eax
  800740:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800743:	8b 45 14             	mov    0x14(%ebp),%eax
  800746:	83 c0 04             	add    $0x4,%eax
  800749:	89 45 14             	mov    %eax,0x14(%ebp)
  80074c:	8b 45 14             	mov    0x14(%ebp),%eax
  80074f:	83 e8 04             	sub    $0x4,%eax
  800752:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800754:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80075e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800765:	eb 1f                	jmp    800786 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800767:	83 ec 08             	sub    $0x8,%esp
  80076a:	ff 75 e8             	pushl  -0x18(%ebp)
  80076d:	8d 45 14             	lea    0x14(%ebp),%eax
  800770:	50                   	push   %eax
  800771:	e8 e7 fb ff ff       	call   80035d <getuint>
  800776:	83 c4 10             	add    $0x10,%esp
  800779:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80077f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800786:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80078a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80078d:	83 ec 04             	sub    $0x4,%esp
  800790:	52                   	push   %edx
  800791:	ff 75 e4             	pushl  -0x1c(%ebp)
  800794:	50                   	push   %eax
  800795:	ff 75 f4             	pushl  -0xc(%ebp)
  800798:	ff 75 f0             	pushl  -0x10(%ebp)
  80079b:	ff 75 0c             	pushl  0xc(%ebp)
  80079e:	ff 75 08             	pushl  0x8(%ebp)
  8007a1:	e8 00 fb ff ff       	call   8002a6 <printnum>
  8007a6:	83 c4 20             	add    $0x20,%esp
			break;
  8007a9:	eb 34                	jmp    8007df <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007ab:	83 ec 08             	sub    $0x8,%esp
  8007ae:	ff 75 0c             	pushl  0xc(%ebp)
  8007b1:	53                   	push   %ebx
  8007b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b5:	ff d0                	call   *%eax
  8007b7:	83 c4 10             	add    $0x10,%esp
			break;
  8007ba:	eb 23                	jmp    8007df <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007bc:	83 ec 08             	sub    $0x8,%esp
  8007bf:	ff 75 0c             	pushl  0xc(%ebp)
  8007c2:	6a 25                	push   $0x25
  8007c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c7:	ff d0                	call   *%eax
  8007c9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007cc:	ff 4d 10             	decl   0x10(%ebp)
  8007cf:	eb 03                	jmp    8007d4 <vprintfmt+0x3b1>
  8007d1:	ff 4d 10             	decl   0x10(%ebp)
  8007d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d7:	48                   	dec    %eax
  8007d8:	8a 00                	mov    (%eax),%al
  8007da:	3c 25                	cmp    $0x25,%al
  8007dc:	75 f3                	jne    8007d1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007de:	90                   	nop
		}
	}
  8007df:	e9 47 fc ff ff       	jmp    80042b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007e4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007e8:	5b                   	pop    %ebx
  8007e9:	5e                   	pop    %esi
  8007ea:	5d                   	pop    %ebp
  8007eb:	c3                   	ret    

008007ec <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007ec:	55                   	push   %ebp
  8007ed:	89 e5                	mov    %esp,%ebp
  8007ef:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007f2:	8d 45 10             	lea    0x10(%ebp),%eax
  8007f5:	83 c0 04             	add    $0x4,%eax
  8007f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8007fe:	ff 75 f4             	pushl  -0xc(%ebp)
  800801:	50                   	push   %eax
  800802:	ff 75 0c             	pushl  0xc(%ebp)
  800805:	ff 75 08             	pushl  0x8(%ebp)
  800808:	e8 16 fc ff ff       	call   800423 <vprintfmt>
  80080d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800810:	90                   	nop
  800811:	c9                   	leave  
  800812:	c3                   	ret    

00800813 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800813:	55                   	push   %ebp
  800814:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800816:	8b 45 0c             	mov    0xc(%ebp),%eax
  800819:	8b 40 08             	mov    0x8(%eax),%eax
  80081c:	8d 50 01             	lea    0x1(%eax),%edx
  80081f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800822:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800825:	8b 45 0c             	mov    0xc(%ebp),%eax
  800828:	8b 10                	mov    (%eax),%edx
  80082a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082d:	8b 40 04             	mov    0x4(%eax),%eax
  800830:	39 c2                	cmp    %eax,%edx
  800832:	73 12                	jae    800846 <sprintputch+0x33>
		*b->buf++ = ch;
  800834:	8b 45 0c             	mov    0xc(%ebp),%eax
  800837:	8b 00                	mov    (%eax),%eax
  800839:	8d 48 01             	lea    0x1(%eax),%ecx
  80083c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80083f:	89 0a                	mov    %ecx,(%edx)
  800841:	8b 55 08             	mov    0x8(%ebp),%edx
  800844:	88 10                	mov    %dl,(%eax)
}
  800846:	90                   	nop
  800847:	5d                   	pop    %ebp
  800848:	c3                   	ret    

00800849 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800849:	55                   	push   %ebp
  80084a:	89 e5                	mov    %esp,%ebp
  80084c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800855:	8b 45 0c             	mov    0xc(%ebp),%eax
  800858:	8d 50 ff             	lea    -0x1(%eax),%edx
  80085b:	8b 45 08             	mov    0x8(%ebp),%eax
  80085e:	01 d0                	add    %edx,%eax
  800860:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800863:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80086a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80086e:	74 06                	je     800876 <vsnprintf+0x2d>
  800870:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800874:	7f 07                	jg     80087d <vsnprintf+0x34>
		return -E_INVAL;
  800876:	b8 03 00 00 00       	mov    $0x3,%eax
  80087b:	eb 20                	jmp    80089d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80087d:	ff 75 14             	pushl  0x14(%ebp)
  800880:	ff 75 10             	pushl  0x10(%ebp)
  800883:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800886:	50                   	push   %eax
  800887:	68 13 08 80 00       	push   $0x800813
  80088c:	e8 92 fb ff ff       	call   800423 <vprintfmt>
  800891:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800894:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800897:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80089a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80089d:	c9                   	leave  
  80089e:	c3                   	ret    

0080089f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80089f:	55                   	push   %ebp
  8008a0:	89 e5                	mov    %esp,%ebp
  8008a2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008a5:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a8:	83 c0 04             	add    $0x4,%eax
  8008ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8008b4:	50                   	push   %eax
  8008b5:	ff 75 0c             	pushl  0xc(%ebp)
  8008b8:	ff 75 08             	pushl  0x8(%ebp)
  8008bb:	e8 89 ff ff ff       	call   800849 <vsnprintf>
  8008c0:	83 c4 10             	add    $0x10,%esp
  8008c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008c9:	c9                   	leave  
  8008ca:	c3                   	ret    

008008cb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008cb:	55                   	push   %ebp
  8008cc:	89 e5                	mov    %esp,%ebp
  8008ce:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008d8:	eb 06                	jmp    8008e0 <strlen+0x15>
		n++;
  8008da:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008dd:	ff 45 08             	incl   0x8(%ebp)
  8008e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e3:	8a 00                	mov    (%eax),%al
  8008e5:	84 c0                	test   %al,%al
  8008e7:	75 f1                	jne    8008da <strlen+0xf>
		n++;
	return n;
  8008e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
  8008f1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008fb:	eb 09                	jmp    800906 <strnlen+0x18>
		n++;
  8008fd:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800900:	ff 45 08             	incl   0x8(%ebp)
  800903:	ff 4d 0c             	decl   0xc(%ebp)
  800906:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80090a:	74 09                	je     800915 <strnlen+0x27>
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	8a 00                	mov    (%eax),%al
  800911:	84 c0                	test   %al,%al
  800913:	75 e8                	jne    8008fd <strnlen+0xf>
		n++;
	return n;
  800915:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800918:	c9                   	leave  
  800919:	c3                   	ret    

0080091a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80091a:	55                   	push   %ebp
  80091b:	89 e5                	mov    %esp,%ebp
  80091d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800926:	90                   	nop
  800927:	8b 45 08             	mov    0x8(%ebp),%eax
  80092a:	8d 50 01             	lea    0x1(%eax),%edx
  80092d:	89 55 08             	mov    %edx,0x8(%ebp)
  800930:	8b 55 0c             	mov    0xc(%ebp),%edx
  800933:	8d 4a 01             	lea    0x1(%edx),%ecx
  800936:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800939:	8a 12                	mov    (%edx),%dl
  80093b:	88 10                	mov    %dl,(%eax)
  80093d:	8a 00                	mov    (%eax),%al
  80093f:	84 c0                	test   %al,%al
  800941:	75 e4                	jne    800927 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800943:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800946:	c9                   	leave  
  800947:	c3                   	ret    

00800948 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800948:	55                   	push   %ebp
  800949:	89 e5                	mov    %esp,%ebp
  80094b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80094e:	8b 45 08             	mov    0x8(%ebp),%eax
  800951:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800954:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80095b:	eb 1f                	jmp    80097c <strncpy+0x34>
		*dst++ = *src;
  80095d:	8b 45 08             	mov    0x8(%ebp),%eax
  800960:	8d 50 01             	lea    0x1(%eax),%edx
  800963:	89 55 08             	mov    %edx,0x8(%ebp)
  800966:	8b 55 0c             	mov    0xc(%ebp),%edx
  800969:	8a 12                	mov    (%edx),%dl
  80096b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80096d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800970:	8a 00                	mov    (%eax),%al
  800972:	84 c0                	test   %al,%al
  800974:	74 03                	je     800979 <strncpy+0x31>
			src++;
  800976:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800979:	ff 45 fc             	incl   -0x4(%ebp)
  80097c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80097f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800982:	72 d9                	jb     80095d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800984:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800987:	c9                   	leave  
  800988:	c3                   	ret    

00800989 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800989:	55                   	push   %ebp
  80098a:	89 e5                	mov    %esp,%ebp
  80098c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80098f:	8b 45 08             	mov    0x8(%ebp),%eax
  800992:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800995:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800999:	74 30                	je     8009cb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80099b:	eb 16                	jmp    8009b3 <strlcpy+0x2a>
			*dst++ = *src++;
  80099d:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a0:	8d 50 01             	lea    0x1(%eax),%edx
  8009a3:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009ac:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009af:	8a 12                	mov    (%edx),%dl
  8009b1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009b3:	ff 4d 10             	decl   0x10(%ebp)
  8009b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ba:	74 09                	je     8009c5 <strlcpy+0x3c>
  8009bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bf:	8a 00                	mov    (%eax),%al
  8009c1:	84 c0                	test   %al,%al
  8009c3:	75 d8                	jne    80099d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009cb:	8b 55 08             	mov    0x8(%ebp),%edx
  8009ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009d1:	29 c2                	sub    %eax,%edx
  8009d3:	89 d0                	mov    %edx,%eax
}
  8009d5:	c9                   	leave  
  8009d6:	c3                   	ret    

008009d7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009d7:	55                   	push   %ebp
  8009d8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009da:	eb 06                	jmp    8009e2 <strcmp+0xb>
		p++, q++;
  8009dc:	ff 45 08             	incl   0x8(%ebp)
  8009df:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	8a 00                	mov    (%eax),%al
  8009e7:	84 c0                	test   %al,%al
  8009e9:	74 0e                	je     8009f9 <strcmp+0x22>
  8009eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ee:	8a 10                	mov    (%eax),%dl
  8009f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f3:	8a 00                	mov    (%eax),%al
  8009f5:	38 c2                	cmp    %al,%dl
  8009f7:	74 e3                	je     8009dc <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8a 00                	mov    (%eax),%al
  8009fe:	0f b6 d0             	movzbl %al,%edx
  800a01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a04:	8a 00                	mov    (%eax),%al
  800a06:	0f b6 c0             	movzbl %al,%eax
  800a09:	29 c2                	sub    %eax,%edx
  800a0b:	89 d0                	mov    %edx,%eax
}
  800a0d:	5d                   	pop    %ebp
  800a0e:	c3                   	ret    

00800a0f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a0f:	55                   	push   %ebp
  800a10:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a12:	eb 09                	jmp    800a1d <strncmp+0xe>
		n--, p++, q++;
  800a14:	ff 4d 10             	decl   0x10(%ebp)
  800a17:	ff 45 08             	incl   0x8(%ebp)
  800a1a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a21:	74 17                	je     800a3a <strncmp+0x2b>
  800a23:	8b 45 08             	mov    0x8(%ebp),%eax
  800a26:	8a 00                	mov    (%eax),%al
  800a28:	84 c0                	test   %al,%al
  800a2a:	74 0e                	je     800a3a <strncmp+0x2b>
  800a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2f:	8a 10                	mov    (%eax),%dl
  800a31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a34:	8a 00                	mov    (%eax),%al
  800a36:	38 c2                	cmp    %al,%dl
  800a38:	74 da                	je     800a14 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a3e:	75 07                	jne    800a47 <strncmp+0x38>
		return 0;
  800a40:	b8 00 00 00 00       	mov    $0x0,%eax
  800a45:	eb 14                	jmp    800a5b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	8a 00                	mov    (%eax),%al
  800a4c:	0f b6 d0             	movzbl %al,%edx
  800a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a52:	8a 00                	mov    (%eax),%al
  800a54:	0f b6 c0             	movzbl %al,%eax
  800a57:	29 c2                	sub    %eax,%edx
  800a59:	89 d0                	mov    %edx,%eax
}
  800a5b:	5d                   	pop    %ebp
  800a5c:	c3                   	ret    

00800a5d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a5d:	55                   	push   %ebp
  800a5e:	89 e5                	mov    %esp,%ebp
  800a60:	83 ec 04             	sub    $0x4,%esp
  800a63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a66:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a69:	eb 12                	jmp    800a7d <strchr+0x20>
		if (*s == c)
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	8a 00                	mov    (%eax),%al
  800a70:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a73:	75 05                	jne    800a7a <strchr+0x1d>
			return (char *) s;
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	eb 11                	jmp    800a8b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a7a:	ff 45 08             	incl   0x8(%ebp)
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	8a 00                	mov    (%eax),%al
  800a82:	84 c0                	test   %al,%al
  800a84:	75 e5                	jne    800a6b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a86:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a8b:	c9                   	leave  
  800a8c:	c3                   	ret    

00800a8d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a8d:	55                   	push   %ebp
  800a8e:	89 e5                	mov    %esp,%ebp
  800a90:	83 ec 04             	sub    $0x4,%esp
  800a93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a96:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a99:	eb 0d                	jmp    800aa8 <strfind+0x1b>
		if (*s == c)
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	8a 00                	mov    (%eax),%al
  800aa0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aa3:	74 0e                	je     800ab3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aa5:	ff 45 08             	incl   0x8(%ebp)
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	8a 00                	mov    (%eax),%al
  800aad:	84 c0                	test   %al,%al
  800aaf:	75 ea                	jne    800a9b <strfind+0xe>
  800ab1:	eb 01                	jmp    800ab4 <strfind+0x27>
		if (*s == c)
			break;
  800ab3:	90                   	nop
	return (char *) s;
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ab7:	c9                   	leave  
  800ab8:	c3                   	ret    

00800ab9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ab9:	55                   	push   %ebp
  800aba:	89 e5                	mov    %esp,%ebp
  800abc:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ac5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800acb:	eb 0e                	jmp    800adb <memset+0x22>
		*p++ = c;
  800acd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ad0:	8d 50 01             	lea    0x1(%eax),%edx
  800ad3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ad6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800adb:	ff 4d f8             	decl   -0x8(%ebp)
  800ade:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ae2:	79 e9                	jns    800acd <memset+0x14>
		*p++ = c;

	return v;
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ae7:	c9                   	leave  
  800ae8:	c3                   	ret    

00800ae9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ae9:	55                   	push   %ebp
  800aea:	89 e5                	mov    %esp,%ebp
  800aec:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800aef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800afb:	eb 16                	jmp    800b13 <memcpy+0x2a>
		*d++ = *s++;
  800afd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b00:	8d 50 01             	lea    0x1(%eax),%edx
  800b03:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b06:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b09:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b0c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b0f:	8a 12                	mov    (%edx),%dl
  800b11:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b13:	8b 45 10             	mov    0x10(%ebp),%eax
  800b16:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b19:	89 55 10             	mov    %edx,0x10(%ebp)
  800b1c:	85 c0                	test   %eax,%eax
  800b1e:	75 dd                	jne    800afd <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b23:	c9                   	leave  
  800b24:	c3                   	ret    

00800b25 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b25:	55                   	push   %ebp
  800b26:	89 e5                	mov    %esp,%ebp
  800b28:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b37:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b3a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b3d:	73 50                	jae    800b8f <memmove+0x6a>
  800b3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b42:	8b 45 10             	mov    0x10(%ebp),%eax
  800b45:	01 d0                	add    %edx,%eax
  800b47:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b4a:	76 43                	jbe    800b8f <memmove+0x6a>
		s += n;
  800b4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b52:	8b 45 10             	mov    0x10(%ebp),%eax
  800b55:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b58:	eb 10                	jmp    800b6a <memmove+0x45>
			*--d = *--s;
  800b5a:	ff 4d f8             	decl   -0x8(%ebp)
  800b5d:	ff 4d fc             	decl   -0x4(%ebp)
  800b60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b63:	8a 10                	mov    (%eax),%dl
  800b65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b68:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b70:	89 55 10             	mov    %edx,0x10(%ebp)
  800b73:	85 c0                	test   %eax,%eax
  800b75:	75 e3                	jne    800b5a <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b77:	eb 23                	jmp    800b9c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b7c:	8d 50 01             	lea    0x1(%eax),%edx
  800b7f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b82:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b85:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b88:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b8b:	8a 12                	mov    (%edx),%dl
  800b8d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b92:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b95:	89 55 10             	mov    %edx,0x10(%ebp)
  800b98:	85 c0                	test   %eax,%eax
  800b9a:	75 dd                	jne    800b79 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b9f:	c9                   	leave  
  800ba0:	c3                   	ret    

00800ba1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ba1:	55                   	push   %ebp
  800ba2:	89 e5                	mov    %esp,%ebp
  800ba4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bb3:	eb 2a                	jmp    800bdf <memcmp+0x3e>
		if (*s1 != *s2)
  800bb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb8:	8a 10                	mov    (%eax),%dl
  800bba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bbd:	8a 00                	mov    (%eax),%al
  800bbf:	38 c2                	cmp    %al,%dl
  800bc1:	74 16                	je     800bd9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	0f b6 d0             	movzbl %al,%edx
  800bcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bce:	8a 00                	mov    (%eax),%al
  800bd0:	0f b6 c0             	movzbl %al,%eax
  800bd3:	29 c2                	sub    %eax,%edx
  800bd5:	89 d0                	mov    %edx,%eax
  800bd7:	eb 18                	jmp    800bf1 <memcmp+0x50>
		s1++, s2++;
  800bd9:	ff 45 fc             	incl   -0x4(%ebp)
  800bdc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800be2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be5:	89 55 10             	mov    %edx,0x10(%ebp)
  800be8:	85 c0                	test   %eax,%eax
  800bea:	75 c9                	jne    800bb5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bf1:	c9                   	leave  
  800bf2:	c3                   	ret    

00800bf3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bf3:	55                   	push   %ebp
  800bf4:	89 e5                	mov    %esp,%ebp
  800bf6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bf9:	8b 55 08             	mov    0x8(%ebp),%edx
  800bfc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bff:	01 d0                	add    %edx,%eax
  800c01:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c04:	eb 15                	jmp    800c1b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8a 00                	mov    (%eax),%al
  800c0b:	0f b6 d0             	movzbl %al,%edx
  800c0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c11:	0f b6 c0             	movzbl %al,%eax
  800c14:	39 c2                	cmp    %eax,%edx
  800c16:	74 0d                	je     800c25 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c18:	ff 45 08             	incl   0x8(%ebp)
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c21:	72 e3                	jb     800c06 <memfind+0x13>
  800c23:	eb 01                	jmp    800c26 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c25:	90                   	nop
	return (void *) s;
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c29:	c9                   	leave  
  800c2a:	c3                   	ret    

00800c2b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c2b:	55                   	push   %ebp
  800c2c:	89 e5                	mov    %esp,%ebp
  800c2e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c38:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c3f:	eb 03                	jmp    800c44 <strtol+0x19>
		s++;
  800c41:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	8a 00                	mov    (%eax),%al
  800c49:	3c 20                	cmp    $0x20,%al
  800c4b:	74 f4                	je     800c41 <strtol+0x16>
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	8a 00                	mov    (%eax),%al
  800c52:	3c 09                	cmp    $0x9,%al
  800c54:	74 eb                	je     800c41 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	3c 2b                	cmp    $0x2b,%al
  800c5d:	75 05                	jne    800c64 <strtol+0x39>
		s++;
  800c5f:	ff 45 08             	incl   0x8(%ebp)
  800c62:	eb 13                	jmp    800c77 <strtol+0x4c>
	else if (*s == '-')
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	3c 2d                	cmp    $0x2d,%al
  800c6b:	75 0a                	jne    800c77 <strtol+0x4c>
		s++, neg = 1;
  800c6d:	ff 45 08             	incl   0x8(%ebp)
  800c70:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7b:	74 06                	je     800c83 <strtol+0x58>
  800c7d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c81:	75 20                	jne    800ca3 <strtol+0x78>
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8a 00                	mov    (%eax),%al
  800c88:	3c 30                	cmp    $0x30,%al
  800c8a:	75 17                	jne    800ca3 <strtol+0x78>
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	40                   	inc    %eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	3c 78                	cmp    $0x78,%al
  800c94:	75 0d                	jne    800ca3 <strtol+0x78>
		s += 2, base = 16;
  800c96:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c9a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ca1:	eb 28                	jmp    800ccb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ca3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca7:	75 15                	jne    800cbe <strtol+0x93>
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	3c 30                	cmp    $0x30,%al
  800cb0:	75 0c                	jne    800cbe <strtol+0x93>
		s++, base = 8;
  800cb2:	ff 45 08             	incl   0x8(%ebp)
  800cb5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cbc:	eb 0d                	jmp    800ccb <strtol+0xa0>
	else if (base == 0)
  800cbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc2:	75 07                	jne    800ccb <strtol+0xa0>
		base = 10;
  800cc4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	3c 2f                	cmp    $0x2f,%al
  800cd2:	7e 19                	jle    800ced <strtol+0xc2>
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8a 00                	mov    (%eax),%al
  800cd9:	3c 39                	cmp    $0x39,%al
  800cdb:	7f 10                	jg     800ced <strtol+0xc2>
			dig = *s - '0';
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	0f be c0             	movsbl %al,%eax
  800ce5:	83 e8 30             	sub    $0x30,%eax
  800ce8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ceb:	eb 42                	jmp    800d2f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	3c 60                	cmp    $0x60,%al
  800cf4:	7e 19                	jle    800d0f <strtol+0xe4>
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	8a 00                	mov    (%eax),%al
  800cfb:	3c 7a                	cmp    $0x7a,%al
  800cfd:	7f 10                	jg     800d0f <strtol+0xe4>
			dig = *s - 'a' + 10;
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	0f be c0             	movsbl %al,%eax
  800d07:	83 e8 57             	sub    $0x57,%eax
  800d0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d0d:	eb 20                	jmp    800d2f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	3c 40                	cmp    $0x40,%al
  800d16:	7e 39                	jle    800d51 <strtol+0x126>
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8a 00                	mov    (%eax),%al
  800d1d:	3c 5a                	cmp    $0x5a,%al
  800d1f:	7f 30                	jg     800d51 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	0f be c0             	movsbl %al,%eax
  800d29:	83 e8 37             	sub    $0x37,%eax
  800d2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d32:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d35:	7d 19                	jge    800d50 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d37:	ff 45 08             	incl   0x8(%ebp)
  800d3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d3d:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d41:	89 c2                	mov    %eax,%edx
  800d43:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d46:	01 d0                	add    %edx,%eax
  800d48:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d4b:	e9 7b ff ff ff       	jmp    800ccb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d50:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d51:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d55:	74 08                	je     800d5f <strtol+0x134>
		*endptr = (char *) s;
  800d57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5a:	8b 55 08             	mov    0x8(%ebp),%edx
  800d5d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d5f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d63:	74 07                	je     800d6c <strtol+0x141>
  800d65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d68:	f7 d8                	neg    %eax
  800d6a:	eb 03                	jmp    800d6f <strtol+0x144>
  800d6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d6f:	c9                   	leave  
  800d70:	c3                   	ret    

00800d71 <ltostr>:

void
ltostr(long value, char *str)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d7e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d85:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d89:	79 13                	jns    800d9e <ltostr+0x2d>
	{
		neg = 1;
  800d8b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d95:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d98:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d9b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800da6:	99                   	cltd   
  800da7:	f7 f9                	idiv   %ecx
  800da9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800daf:	8d 50 01             	lea    0x1(%eax),%edx
  800db2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800db5:	89 c2                	mov    %eax,%edx
  800db7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dba:	01 d0                	add    %edx,%eax
  800dbc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dbf:	83 c2 30             	add    $0x30,%edx
  800dc2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dc4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dc7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dcc:	f7 e9                	imul   %ecx
  800dce:	c1 fa 02             	sar    $0x2,%edx
  800dd1:	89 c8                	mov    %ecx,%eax
  800dd3:	c1 f8 1f             	sar    $0x1f,%eax
  800dd6:	29 c2                	sub    %eax,%edx
  800dd8:	89 d0                	mov    %edx,%eax
  800dda:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ddd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800de0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800de5:	f7 e9                	imul   %ecx
  800de7:	c1 fa 02             	sar    $0x2,%edx
  800dea:	89 c8                	mov    %ecx,%eax
  800dec:	c1 f8 1f             	sar    $0x1f,%eax
  800def:	29 c2                	sub    %eax,%edx
  800df1:	89 d0                	mov    %edx,%eax
  800df3:	c1 e0 02             	shl    $0x2,%eax
  800df6:	01 d0                	add    %edx,%eax
  800df8:	01 c0                	add    %eax,%eax
  800dfa:	29 c1                	sub    %eax,%ecx
  800dfc:	89 ca                	mov    %ecx,%edx
  800dfe:	85 d2                	test   %edx,%edx
  800e00:	75 9c                	jne    800d9e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0c:	48                   	dec    %eax
  800e0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e10:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e14:	74 3d                	je     800e53 <ltostr+0xe2>
		start = 1 ;
  800e16:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e1d:	eb 34                	jmp    800e53 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	01 d0                	add    %edx,%eax
  800e27:	8a 00                	mov    (%eax),%al
  800e29:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e32:	01 c2                	add    %eax,%edx
  800e34:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3a:	01 c8                	add    %ecx,%eax
  800e3c:	8a 00                	mov    (%eax),%al
  800e3e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e40:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e46:	01 c2                	add    %eax,%edx
  800e48:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e4b:	88 02                	mov    %al,(%edx)
		start++ ;
  800e4d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e50:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e59:	7c c4                	jl     800e1f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e5b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e61:	01 d0                	add    %edx,%eax
  800e63:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e66:	90                   	nop
  800e67:	c9                   	leave  
  800e68:	c3                   	ret    

00800e69 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e69:	55                   	push   %ebp
  800e6a:	89 e5                	mov    %esp,%ebp
  800e6c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e6f:	ff 75 08             	pushl  0x8(%ebp)
  800e72:	e8 54 fa ff ff       	call   8008cb <strlen>
  800e77:	83 c4 04             	add    $0x4,%esp
  800e7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e7d:	ff 75 0c             	pushl  0xc(%ebp)
  800e80:	e8 46 fa ff ff       	call   8008cb <strlen>
  800e85:	83 c4 04             	add    $0x4,%esp
  800e88:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e99:	eb 17                	jmp    800eb2 <strcconcat+0x49>
		final[s] = str1[s] ;
  800e9b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea1:	01 c2                	add    %eax,%edx
  800ea3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	01 c8                	add    %ecx,%eax
  800eab:	8a 00                	mov    (%eax),%al
  800ead:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eaf:	ff 45 fc             	incl   -0x4(%ebp)
  800eb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eb8:	7c e1                	jl     800e9b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800eba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ec1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ec8:	eb 1f                	jmp    800ee9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800eca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ecd:	8d 50 01             	lea    0x1(%eax),%edx
  800ed0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ed3:	89 c2                	mov    %eax,%edx
  800ed5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed8:	01 c2                	add    %eax,%edx
  800eda:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800edd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee0:	01 c8                	add    %ecx,%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ee6:	ff 45 f8             	incl   -0x8(%ebp)
  800ee9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eef:	7c d9                	jl     800eca <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ef1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ef4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef7:	01 d0                	add    %edx,%eax
  800ef9:	c6 00 00             	movb   $0x0,(%eax)
}
  800efc:	90                   	nop
  800efd:	c9                   	leave  
  800efe:	c3                   	ret    

00800eff <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800eff:	55                   	push   %ebp
  800f00:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f02:	8b 45 14             	mov    0x14(%ebp),%eax
  800f05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0e:	8b 00                	mov    (%eax),%eax
  800f10:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f17:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1a:	01 d0                	add    %edx,%eax
  800f1c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f22:	eb 0c                	jmp    800f30 <strsplit+0x31>
			*string++ = 0;
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	8d 50 01             	lea    0x1(%eax),%edx
  800f2a:	89 55 08             	mov    %edx,0x8(%ebp)
  800f2d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	8a 00                	mov    (%eax),%al
  800f35:	84 c0                	test   %al,%al
  800f37:	74 18                	je     800f51 <strsplit+0x52>
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	0f be c0             	movsbl %al,%eax
  800f41:	50                   	push   %eax
  800f42:	ff 75 0c             	pushl  0xc(%ebp)
  800f45:	e8 13 fb ff ff       	call   800a5d <strchr>
  800f4a:	83 c4 08             	add    $0x8,%esp
  800f4d:	85 c0                	test   %eax,%eax
  800f4f:	75 d3                	jne    800f24 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	8a 00                	mov    (%eax),%al
  800f56:	84 c0                	test   %al,%al
  800f58:	74 5a                	je     800fb4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5d:	8b 00                	mov    (%eax),%eax
  800f5f:	83 f8 0f             	cmp    $0xf,%eax
  800f62:	75 07                	jne    800f6b <strsplit+0x6c>
		{
			return 0;
  800f64:	b8 00 00 00 00       	mov    $0x0,%eax
  800f69:	eb 66                	jmp    800fd1 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6e:	8b 00                	mov    (%eax),%eax
  800f70:	8d 48 01             	lea    0x1(%eax),%ecx
  800f73:	8b 55 14             	mov    0x14(%ebp),%edx
  800f76:	89 0a                	mov    %ecx,(%edx)
  800f78:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f82:	01 c2                	add    %eax,%edx
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f89:	eb 03                	jmp    800f8e <strsplit+0x8f>
			string++;
  800f8b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	84 c0                	test   %al,%al
  800f95:	74 8b                	je     800f22 <strsplit+0x23>
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	0f be c0             	movsbl %al,%eax
  800f9f:	50                   	push   %eax
  800fa0:	ff 75 0c             	pushl  0xc(%ebp)
  800fa3:	e8 b5 fa ff ff       	call   800a5d <strchr>
  800fa8:	83 c4 08             	add    $0x8,%esp
  800fab:	85 c0                	test   %eax,%eax
  800fad:	74 dc                	je     800f8b <strsplit+0x8c>
			string++;
	}
  800faf:	e9 6e ff ff ff       	jmp    800f22 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fb4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fb5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb8:	8b 00                	mov    (%eax),%eax
  800fba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc4:	01 d0                	add    %edx,%eax
  800fc6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fcc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fd1:	c9                   	leave  
  800fd2:	c3                   	ret    

00800fd3 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fd3:	55                   	push   %ebp
  800fd4:	89 e5                	mov    %esp,%ebp
  800fd6:	57                   	push   %edi
  800fd7:	56                   	push   %esi
  800fd8:	53                   	push   %ebx
  800fd9:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fe2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fe5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fe8:	8b 7d 18             	mov    0x18(%ebp),%edi
  800feb:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fee:	cd 30                	int    $0x30
  800ff0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800ff3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff6:	83 c4 10             	add    $0x10,%esp
  800ff9:	5b                   	pop    %ebx
  800ffa:	5e                   	pop    %esi
  800ffb:	5f                   	pop    %edi
  800ffc:	5d                   	pop    %ebp
  800ffd:	c3                   	ret    

00800ffe <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800ffe:	55                   	push   %ebp
  800fff:	89 e5                	mov    %esp,%ebp
  801001:	83 ec 04             	sub    $0x4,%esp
  801004:	8b 45 10             	mov    0x10(%ebp),%eax
  801007:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80100a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	6a 00                	push   $0x0
  801013:	6a 00                	push   $0x0
  801015:	52                   	push   %edx
  801016:	ff 75 0c             	pushl  0xc(%ebp)
  801019:	50                   	push   %eax
  80101a:	6a 00                	push   $0x0
  80101c:	e8 b2 ff ff ff       	call   800fd3 <syscall>
  801021:	83 c4 18             	add    $0x18,%esp
}
  801024:	90                   	nop
  801025:	c9                   	leave  
  801026:	c3                   	ret    

00801027 <sys_cgetc>:

int
sys_cgetc(void)
{
  801027:	55                   	push   %ebp
  801028:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80102a:	6a 00                	push   $0x0
  80102c:	6a 00                	push   $0x0
  80102e:	6a 00                	push   $0x0
  801030:	6a 00                	push   $0x0
  801032:	6a 00                	push   $0x0
  801034:	6a 01                	push   $0x1
  801036:	e8 98 ff ff ff       	call   800fd3 <syscall>
  80103b:	83 c4 18             	add    $0x18,%esp
}
  80103e:	c9                   	leave  
  80103f:	c3                   	ret    

00801040 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801040:	55                   	push   %ebp
  801041:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	6a 00                	push   $0x0
  801048:	6a 00                	push   $0x0
  80104a:	6a 00                	push   $0x0
  80104c:	6a 00                	push   $0x0
  80104e:	50                   	push   %eax
  80104f:	6a 05                	push   $0x5
  801051:	e8 7d ff ff ff       	call   800fd3 <syscall>
  801056:	83 c4 18             	add    $0x18,%esp
}
  801059:	c9                   	leave  
  80105a:	c3                   	ret    

0080105b <sys_getenvid>:

int32 sys_getenvid(void)
{
  80105b:	55                   	push   %ebp
  80105c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80105e:	6a 00                	push   $0x0
  801060:	6a 00                	push   $0x0
  801062:	6a 00                	push   $0x0
  801064:	6a 00                	push   $0x0
  801066:	6a 00                	push   $0x0
  801068:	6a 02                	push   $0x2
  80106a:	e8 64 ff ff ff       	call   800fd3 <syscall>
  80106f:	83 c4 18             	add    $0x18,%esp
}
  801072:	c9                   	leave  
  801073:	c3                   	ret    

00801074 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801074:	55                   	push   %ebp
  801075:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801077:	6a 00                	push   $0x0
  801079:	6a 00                	push   $0x0
  80107b:	6a 00                	push   $0x0
  80107d:	6a 00                	push   $0x0
  80107f:	6a 00                	push   $0x0
  801081:	6a 03                	push   $0x3
  801083:	e8 4b ff ff ff       	call   800fd3 <syscall>
  801088:	83 c4 18             	add    $0x18,%esp
}
  80108b:	c9                   	leave  
  80108c:	c3                   	ret    

0080108d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80108d:	55                   	push   %ebp
  80108e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801090:	6a 00                	push   $0x0
  801092:	6a 00                	push   $0x0
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 00                	push   $0x0
  80109a:	6a 04                	push   $0x4
  80109c:	e8 32 ff ff ff       	call   800fd3 <syscall>
  8010a1:	83 c4 18             	add    $0x18,%esp
}
  8010a4:	c9                   	leave  
  8010a5:	c3                   	ret    

008010a6 <sys_env_exit>:


void sys_env_exit(void)
{
  8010a6:	55                   	push   %ebp
  8010a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 00                	push   $0x0
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 00                	push   $0x0
  8010b3:	6a 06                	push   $0x6
  8010b5:	e8 19 ff ff ff       	call   800fd3 <syscall>
  8010ba:	83 c4 18             	add    $0x18,%esp
}
  8010bd:	90                   	nop
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	6a 00                	push   $0x0
  8010cb:	6a 00                	push   $0x0
  8010cd:	6a 00                	push   $0x0
  8010cf:	52                   	push   %edx
  8010d0:	50                   	push   %eax
  8010d1:	6a 07                	push   $0x7
  8010d3:	e8 fb fe ff ff       	call   800fd3 <syscall>
  8010d8:	83 c4 18             	add    $0x18,%esp
}
  8010db:	c9                   	leave  
  8010dc:	c3                   	ret    

008010dd <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010dd:	55                   	push   %ebp
  8010de:	89 e5                	mov    %esp,%ebp
  8010e0:	56                   	push   %esi
  8010e1:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010e2:	8b 75 18             	mov    0x18(%ebp),%esi
  8010e5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	56                   	push   %esi
  8010f2:	53                   	push   %ebx
  8010f3:	51                   	push   %ecx
  8010f4:	52                   	push   %edx
  8010f5:	50                   	push   %eax
  8010f6:	6a 08                	push   $0x8
  8010f8:	e8 d6 fe ff ff       	call   800fd3 <syscall>
  8010fd:	83 c4 18             	add    $0x18,%esp
}
  801100:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801103:	5b                   	pop    %ebx
  801104:	5e                   	pop    %esi
  801105:	5d                   	pop    %ebp
  801106:	c3                   	ret    

00801107 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801107:	55                   	push   %ebp
  801108:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80110a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	6a 00                	push   $0x0
  801112:	6a 00                	push   $0x0
  801114:	6a 00                	push   $0x0
  801116:	52                   	push   %edx
  801117:	50                   	push   %eax
  801118:	6a 09                	push   $0x9
  80111a:	e8 b4 fe ff ff       	call   800fd3 <syscall>
  80111f:	83 c4 18             	add    $0x18,%esp
}
  801122:	c9                   	leave  
  801123:	c3                   	ret    

00801124 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801124:	55                   	push   %ebp
  801125:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801127:	6a 00                	push   $0x0
  801129:	6a 00                	push   $0x0
  80112b:	6a 00                	push   $0x0
  80112d:	ff 75 0c             	pushl  0xc(%ebp)
  801130:	ff 75 08             	pushl  0x8(%ebp)
  801133:	6a 0a                	push   $0xa
  801135:	e8 99 fe ff ff       	call   800fd3 <syscall>
  80113a:	83 c4 18             	add    $0x18,%esp
}
  80113d:	c9                   	leave  
  80113e:	c3                   	ret    

0080113f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80113f:	55                   	push   %ebp
  801140:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801142:	6a 00                	push   $0x0
  801144:	6a 00                	push   $0x0
  801146:	6a 00                	push   $0x0
  801148:	6a 00                	push   $0x0
  80114a:	6a 00                	push   $0x0
  80114c:	6a 0b                	push   $0xb
  80114e:	e8 80 fe ff ff       	call   800fd3 <syscall>
  801153:	83 c4 18             	add    $0x18,%esp
}
  801156:	c9                   	leave  
  801157:	c3                   	ret    

00801158 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801158:	55                   	push   %ebp
  801159:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80115b:	6a 00                	push   $0x0
  80115d:	6a 00                	push   $0x0
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	6a 00                	push   $0x0
  801165:	6a 0c                	push   $0xc
  801167:	e8 67 fe ff ff       	call   800fd3 <syscall>
  80116c:	83 c4 18             	add    $0x18,%esp
}
  80116f:	c9                   	leave  
  801170:	c3                   	ret    

00801171 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801171:	55                   	push   %ebp
  801172:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801174:	6a 00                	push   $0x0
  801176:	6a 00                	push   $0x0
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 00                	push   $0x0
  80117e:	6a 0d                	push   $0xd
  801180:	e8 4e fe ff ff       	call   800fd3 <syscall>
  801185:	83 c4 18             	add    $0x18,%esp
}
  801188:	c9                   	leave  
  801189:	c3                   	ret    

0080118a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80118a:	55                   	push   %ebp
  80118b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	ff 75 0c             	pushl  0xc(%ebp)
  801196:	ff 75 08             	pushl  0x8(%ebp)
  801199:	6a 11                	push   $0x11
  80119b:	e8 33 fe ff ff       	call   800fd3 <syscall>
  8011a0:	83 c4 18             	add    $0x18,%esp
	return;
  8011a3:	90                   	nop
}
  8011a4:	c9                   	leave  
  8011a5:	c3                   	ret    

008011a6 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011a6:	55                   	push   %ebp
  8011a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011a9:	6a 00                	push   $0x0
  8011ab:	6a 00                	push   $0x0
  8011ad:	6a 00                	push   $0x0
  8011af:	ff 75 0c             	pushl  0xc(%ebp)
  8011b2:	ff 75 08             	pushl  0x8(%ebp)
  8011b5:	6a 12                	push   $0x12
  8011b7:	e8 17 fe ff ff       	call   800fd3 <syscall>
  8011bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8011bf:	90                   	nop
}
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 00                	push   $0x0
  8011c9:	6a 00                	push   $0x0
  8011cb:	6a 00                	push   $0x0
  8011cd:	6a 00                	push   $0x0
  8011cf:	6a 0e                	push   $0xe
  8011d1:	e8 fd fd ff ff       	call   800fd3 <syscall>
  8011d6:	83 c4 18             	add    $0x18,%esp
}
  8011d9:	c9                   	leave  
  8011da:	c3                   	ret    

008011db <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011db:	55                   	push   %ebp
  8011dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011de:	6a 00                	push   $0x0
  8011e0:	6a 00                	push   $0x0
  8011e2:	6a 00                	push   $0x0
  8011e4:	6a 00                	push   $0x0
  8011e6:	ff 75 08             	pushl  0x8(%ebp)
  8011e9:	6a 0f                	push   $0xf
  8011eb:	e8 e3 fd ff ff       	call   800fd3 <syscall>
  8011f0:	83 c4 18             	add    $0x18,%esp
}
  8011f3:	c9                   	leave  
  8011f4:	c3                   	ret    

008011f5 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011f5:	55                   	push   %ebp
  8011f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 00                	push   $0x0
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 10                	push   $0x10
  801204:	e8 ca fd ff ff       	call   800fd3 <syscall>
  801209:	83 c4 18             	add    $0x18,%esp
}
  80120c:	90                   	nop
  80120d:	c9                   	leave  
  80120e:	c3                   	ret    

0080120f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80120f:	55                   	push   %ebp
  801210:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801212:	6a 00                	push   $0x0
  801214:	6a 00                	push   $0x0
  801216:	6a 00                	push   $0x0
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	6a 14                	push   $0x14
  80121e:	e8 b0 fd ff ff       	call   800fd3 <syscall>
  801223:	83 c4 18             	add    $0x18,%esp
}
  801226:	90                   	nop
  801227:	c9                   	leave  
  801228:	c3                   	ret    

00801229 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80122c:	6a 00                	push   $0x0
  80122e:	6a 00                	push   $0x0
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	6a 15                	push   $0x15
  801238:	e8 96 fd ff ff       	call   800fd3 <syscall>
  80123d:	83 c4 18             	add    $0x18,%esp
}
  801240:	90                   	nop
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <sys_cputc>:


void
sys_cputc(const char c)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
  801246:	83 ec 04             	sub    $0x4,%esp
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80124f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	50                   	push   %eax
  80125c:	6a 16                	push   $0x16
  80125e:	e8 70 fd ff ff       	call   800fd3 <syscall>
  801263:	83 c4 18             	add    $0x18,%esp
}
  801266:	90                   	nop
  801267:	c9                   	leave  
  801268:	c3                   	ret    

00801269 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801269:	55                   	push   %ebp
  80126a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	6a 00                	push   $0x0
  801274:	6a 00                	push   $0x0
  801276:	6a 17                	push   $0x17
  801278:	e8 56 fd ff ff       	call   800fd3 <syscall>
  80127d:	83 c4 18             	add    $0x18,%esp
}
  801280:	90                   	nop
  801281:	c9                   	leave  
  801282:	c3                   	ret    

00801283 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801286:	8b 45 08             	mov    0x8(%ebp),%eax
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	ff 75 0c             	pushl  0xc(%ebp)
  801292:	50                   	push   %eax
  801293:	6a 18                	push   $0x18
  801295:	e8 39 fd ff ff       	call   800fd3 <syscall>
  80129a:	83 c4 18             	add    $0x18,%esp
}
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 00                	push   $0x0
  8012ae:	52                   	push   %edx
  8012af:	50                   	push   %eax
  8012b0:	6a 1b                	push   $0x1b
  8012b2:	e8 1c fd ff ff       	call   800fd3 <syscall>
  8012b7:	83 c4 18             	add    $0x18,%esp
}
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	52                   	push   %edx
  8012cc:	50                   	push   %eax
  8012cd:	6a 19                	push   $0x19
  8012cf:	e8 ff fc ff ff       	call   800fd3 <syscall>
  8012d4:	83 c4 18             	add    $0x18,%esp
}
  8012d7:	90                   	nop
  8012d8:	c9                   	leave  
  8012d9:	c3                   	ret    

008012da <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012da:	55                   	push   %ebp
  8012db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	52                   	push   %edx
  8012ea:	50                   	push   %eax
  8012eb:	6a 1a                	push   $0x1a
  8012ed:	e8 e1 fc ff ff       	call   800fd3 <syscall>
  8012f2:	83 c4 18             	add    $0x18,%esp
}
  8012f5:	90                   	nop
  8012f6:	c9                   	leave  
  8012f7:	c3                   	ret    

008012f8 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012f8:	55                   	push   %ebp
  8012f9:	89 e5                	mov    %esp,%ebp
  8012fb:	83 ec 04             	sub    $0x4,%esp
  8012fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801301:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801304:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801307:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	6a 00                	push   $0x0
  801310:	51                   	push   %ecx
  801311:	52                   	push   %edx
  801312:	ff 75 0c             	pushl  0xc(%ebp)
  801315:	50                   	push   %eax
  801316:	6a 1c                	push   $0x1c
  801318:	e8 b6 fc ff ff       	call   800fd3 <syscall>
  80131d:	83 c4 18             	add    $0x18,%esp
}
  801320:	c9                   	leave  
  801321:	c3                   	ret    

00801322 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801322:	55                   	push   %ebp
  801323:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801325:	8b 55 0c             	mov    0xc(%ebp),%edx
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	52                   	push   %edx
  801332:	50                   	push   %eax
  801333:	6a 1d                	push   $0x1d
  801335:	e8 99 fc ff ff       	call   800fd3 <syscall>
  80133a:	83 c4 18             	add    $0x18,%esp
}
  80133d:	c9                   	leave  
  80133e:	c3                   	ret    

0080133f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80133f:	55                   	push   %ebp
  801340:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801342:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801345:	8b 55 0c             	mov    0xc(%ebp),%edx
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	51                   	push   %ecx
  801350:	52                   	push   %edx
  801351:	50                   	push   %eax
  801352:	6a 1e                	push   $0x1e
  801354:	e8 7a fc ff ff       	call   800fd3 <syscall>
  801359:	83 c4 18             	add    $0x18,%esp
}
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801361:	8b 55 0c             	mov    0xc(%ebp),%edx
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	52                   	push   %edx
  80136e:	50                   	push   %eax
  80136f:	6a 1f                	push   $0x1f
  801371:	e8 5d fc ff ff       	call   800fd3 <syscall>
  801376:	83 c4 18             	add    $0x18,%esp
}
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 20                	push   $0x20
  80138a:	e8 44 fc ff ff       	call   800fd3 <syscall>
  80138f:	83 c4 18             	add    $0x18,%esp
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	ff 75 10             	pushl  0x10(%ebp)
  8013a1:	ff 75 0c             	pushl  0xc(%ebp)
  8013a4:	50                   	push   %eax
  8013a5:	6a 21                	push   $0x21
  8013a7:	e8 27 fc ff ff       	call   800fd3 <syscall>
  8013ac:	83 c4 18             	add    $0x18,%esp
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	50                   	push   %eax
  8013c0:	6a 22                	push   $0x22
  8013c2:	e8 0c fc ff ff       	call   800fd3 <syscall>
  8013c7:	83 c4 18             	add    $0x18,%esp
}
  8013ca:	90                   	nop
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	50                   	push   %eax
  8013dc:	6a 23                	push   $0x23
  8013de:	e8 f0 fb ff ff       	call   800fd3 <syscall>
  8013e3:	83 c4 18             	add    $0x18,%esp
}
  8013e6:	90                   	nop
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
  8013ec:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013ef:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013f2:	8d 50 04             	lea    0x4(%eax),%edx
  8013f5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	52                   	push   %edx
  8013ff:	50                   	push   %eax
  801400:	6a 24                	push   $0x24
  801402:	e8 cc fb ff ff       	call   800fd3 <syscall>
  801407:	83 c4 18             	add    $0x18,%esp
	return result;
  80140a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80140d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801410:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801413:	89 01                	mov    %eax,(%ecx)
  801415:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	c9                   	leave  
  80141c:	c2 04 00             	ret    $0x4

0080141f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80141f:	55                   	push   %ebp
  801420:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	ff 75 10             	pushl  0x10(%ebp)
  801429:	ff 75 0c             	pushl  0xc(%ebp)
  80142c:	ff 75 08             	pushl  0x8(%ebp)
  80142f:	6a 13                	push   $0x13
  801431:	e8 9d fb ff ff       	call   800fd3 <syscall>
  801436:	83 c4 18             	add    $0x18,%esp
	return ;
  801439:	90                   	nop
}
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <sys_rcr2>:
uint32 sys_rcr2()
{
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 25                	push   $0x25
  80144b:	e8 83 fb ff ff       	call   800fd3 <syscall>
  801450:	83 c4 18             	add    $0x18,%esp
}
  801453:	c9                   	leave  
  801454:	c3                   	ret    

00801455 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801455:	55                   	push   %ebp
  801456:	89 e5                	mov    %esp,%ebp
  801458:	83 ec 04             	sub    $0x4,%esp
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801461:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	50                   	push   %eax
  80146e:	6a 26                	push   $0x26
  801470:	e8 5e fb ff ff       	call   800fd3 <syscall>
  801475:	83 c4 18             	add    $0x18,%esp
	return ;
  801478:	90                   	nop
}
  801479:	c9                   	leave  
  80147a:	c3                   	ret    

0080147b <rsttst>:
void rsttst()
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 28                	push   $0x28
  80148a:	e8 44 fb ff ff       	call   800fd3 <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
	return ;
  801492:	90                   	nop
}
  801493:	c9                   	leave  
  801494:	c3                   	ret    

00801495 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801495:	55                   	push   %ebp
  801496:	89 e5                	mov    %esp,%ebp
  801498:	83 ec 04             	sub    $0x4,%esp
  80149b:	8b 45 14             	mov    0x14(%ebp),%eax
  80149e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014a1:	8b 55 18             	mov    0x18(%ebp),%edx
  8014a4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014a8:	52                   	push   %edx
  8014a9:	50                   	push   %eax
  8014aa:	ff 75 10             	pushl  0x10(%ebp)
  8014ad:	ff 75 0c             	pushl  0xc(%ebp)
  8014b0:	ff 75 08             	pushl  0x8(%ebp)
  8014b3:	6a 27                	push   $0x27
  8014b5:	e8 19 fb ff ff       	call   800fd3 <syscall>
  8014ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8014bd:	90                   	nop
}
  8014be:	c9                   	leave  
  8014bf:	c3                   	ret    

008014c0 <chktst>:
void chktst(uint32 n)
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	ff 75 08             	pushl  0x8(%ebp)
  8014ce:	6a 29                	push   $0x29
  8014d0:	e8 fe fa ff ff       	call   800fd3 <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d8:	90                   	nop
}
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <inctst>:

void inctst()
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 2a                	push   $0x2a
  8014ea:	e8 e4 fa ff ff       	call   800fd3 <syscall>
  8014ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f2:	90                   	nop
}
  8014f3:	c9                   	leave  
  8014f4:	c3                   	ret    

008014f5 <gettst>:
uint32 gettst()
{
  8014f5:	55                   	push   %ebp
  8014f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 2b                	push   $0x2b
  801504:	e8 ca fa ff ff       	call   800fd3 <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
  801511:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 2c                	push   $0x2c
  801520:	e8 ae fa ff ff       	call   800fd3 <syscall>
  801525:	83 c4 18             	add    $0x18,%esp
  801528:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80152b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80152f:	75 07                	jne    801538 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801531:	b8 01 00 00 00       	mov    $0x1,%eax
  801536:	eb 05                	jmp    80153d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801538:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80153d:	c9                   	leave  
  80153e:	c3                   	ret    

0080153f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80153f:	55                   	push   %ebp
  801540:	89 e5                	mov    %esp,%ebp
  801542:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 2c                	push   $0x2c
  801551:	e8 7d fa ff ff       	call   800fd3 <syscall>
  801556:	83 c4 18             	add    $0x18,%esp
  801559:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80155c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801560:	75 07                	jne    801569 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801562:	b8 01 00 00 00       	mov    $0x1,%eax
  801567:	eb 05                	jmp    80156e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801569:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156e:	c9                   	leave  
  80156f:	c3                   	ret    

00801570 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
  801573:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 2c                	push   $0x2c
  801582:	e8 4c fa ff ff       	call   800fd3 <syscall>
  801587:	83 c4 18             	add    $0x18,%esp
  80158a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80158d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801591:	75 07                	jne    80159a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801593:	b8 01 00 00 00       	mov    $0x1,%eax
  801598:	eb 05                	jmp    80159f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80159a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
  8015a4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 2c                	push   $0x2c
  8015b3:	e8 1b fa ff ff       	call   800fd3 <syscall>
  8015b8:	83 c4 18             	add    $0x18,%esp
  8015bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015be:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015c2:	75 07                	jne    8015cb <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015c4:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c9:	eb 05                	jmp    8015d0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	ff 75 08             	pushl  0x8(%ebp)
  8015e0:	6a 2d                	push   $0x2d
  8015e2:	e8 ec f9 ff ff       	call   800fd3 <syscall>
  8015e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ea:	90                   	nop
}
  8015eb:	c9                   	leave  
  8015ec:	c3                   	ret    

008015ed <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8015ed:	55                   	push   %ebp
  8015ee:	89 e5                	mov    %esp,%ebp
  8015f0:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8015f3:	8b 55 08             	mov    0x8(%ebp),%edx
  8015f6:	89 d0                	mov    %edx,%eax
  8015f8:	c1 e0 02             	shl    $0x2,%eax
  8015fb:	01 d0                	add    %edx,%eax
  8015fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801604:	01 d0                	add    %edx,%eax
  801606:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80160d:	01 d0                	add    %edx,%eax
  80160f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801616:	01 d0                	add    %edx,%eax
  801618:	c1 e0 04             	shl    $0x4,%eax
  80161b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80161e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801625:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801628:	83 ec 0c             	sub    $0xc,%esp
  80162b:	50                   	push   %eax
  80162c:	e8 b8 fd ff ff       	call   8013e9 <sys_get_virtual_time>
  801631:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801634:	eb 41                	jmp    801677 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801636:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801639:	83 ec 0c             	sub    $0xc,%esp
  80163c:	50                   	push   %eax
  80163d:	e8 a7 fd ff ff       	call   8013e9 <sys_get_virtual_time>
  801642:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801645:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801648:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80164b:	29 c2                	sub    %eax,%edx
  80164d:	89 d0                	mov    %edx,%eax
  80164f:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801652:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801655:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801658:	89 d1                	mov    %edx,%ecx
  80165a:	29 c1                	sub    %eax,%ecx
  80165c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80165f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801662:	39 c2                	cmp    %eax,%edx
  801664:	0f 97 c0             	seta   %al
  801667:	0f b6 c0             	movzbl %al,%eax
  80166a:	29 c1                	sub    %eax,%ecx
  80166c:	89 c8                	mov    %ecx,%eax
  80166e:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801671:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801674:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801677:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80167a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80167d:	72 b7                	jb     801636 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80167f:	90                   	nop
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
  801685:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801688:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80168f:	eb 03                	jmp    801694 <busy_wait+0x12>
  801691:	ff 45 fc             	incl   -0x4(%ebp)
  801694:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801697:	3b 45 08             	cmp    0x8(%ebp),%eax
  80169a:	72 f5                	jb     801691 <busy_wait+0xf>
	return i;
  80169c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80169f:	c9                   	leave  
  8016a0:	c3                   	ret    
  8016a1:	66 90                	xchg   %ax,%ax
  8016a3:	90                   	nop

008016a4 <__udivdi3>:
  8016a4:	55                   	push   %ebp
  8016a5:	57                   	push   %edi
  8016a6:	56                   	push   %esi
  8016a7:	53                   	push   %ebx
  8016a8:	83 ec 1c             	sub    $0x1c,%esp
  8016ab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016af:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016b7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016bb:	89 ca                	mov    %ecx,%edx
  8016bd:	89 f8                	mov    %edi,%eax
  8016bf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016c3:	85 f6                	test   %esi,%esi
  8016c5:	75 2d                	jne    8016f4 <__udivdi3+0x50>
  8016c7:	39 cf                	cmp    %ecx,%edi
  8016c9:	77 65                	ja     801730 <__udivdi3+0x8c>
  8016cb:	89 fd                	mov    %edi,%ebp
  8016cd:	85 ff                	test   %edi,%edi
  8016cf:	75 0b                	jne    8016dc <__udivdi3+0x38>
  8016d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d6:	31 d2                	xor    %edx,%edx
  8016d8:	f7 f7                	div    %edi
  8016da:	89 c5                	mov    %eax,%ebp
  8016dc:	31 d2                	xor    %edx,%edx
  8016de:	89 c8                	mov    %ecx,%eax
  8016e0:	f7 f5                	div    %ebp
  8016e2:	89 c1                	mov    %eax,%ecx
  8016e4:	89 d8                	mov    %ebx,%eax
  8016e6:	f7 f5                	div    %ebp
  8016e8:	89 cf                	mov    %ecx,%edi
  8016ea:	89 fa                	mov    %edi,%edx
  8016ec:	83 c4 1c             	add    $0x1c,%esp
  8016ef:	5b                   	pop    %ebx
  8016f0:	5e                   	pop    %esi
  8016f1:	5f                   	pop    %edi
  8016f2:	5d                   	pop    %ebp
  8016f3:	c3                   	ret    
  8016f4:	39 ce                	cmp    %ecx,%esi
  8016f6:	77 28                	ja     801720 <__udivdi3+0x7c>
  8016f8:	0f bd fe             	bsr    %esi,%edi
  8016fb:	83 f7 1f             	xor    $0x1f,%edi
  8016fe:	75 40                	jne    801740 <__udivdi3+0x9c>
  801700:	39 ce                	cmp    %ecx,%esi
  801702:	72 0a                	jb     80170e <__udivdi3+0x6a>
  801704:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801708:	0f 87 9e 00 00 00    	ja     8017ac <__udivdi3+0x108>
  80170e:	b8 01 00 00 00       	mov    $0x1,%eax
  801713:	89 fa                	mov    %edi,%edx
  801715:	83 c4 1c             	add    $0x1c,%esp
  801718:	5b                   	pop    %ebx
  801719:	5e                   	pop    %esi
  80171a:	5f                   	pop    %edi
  80171b:	5d                   	pop    %ebp
  80171c:	c3                   	ret    
  80171d:	8d 76 00             	lea    0x0(%esi),%esi
  801720:	31 ff                	xor    %edi,%edi
  801722:	31 c0                	xor    %eax,%eax
  801724:	89 fa                	mov    %edi,%edx
  801726:	83 c4 1c             	add    $0x1c,%esp
  801729:	5b                   	pop    %ebx
  80172a:	5e                   	pop    %esi
  80172b:	5f                   	pop    %edi
  80172c:	5d                   	pop    %ebp
  80172d:	c3                   	ret    
  80172e:	66 90                	xchg   %ax,%ax
  801730:	89 d8                	mov    %ebx,%eax
  801732:	f7 f7                	div    %edi
  801734:	31 ff                	xor    %edi,%edi
  801736:	89 fa                	mov    %edi,%edx
  801738:	83 c4 1c             	add    $0x1c,%esp
  80173b:	5b                   	pop    %ebx
  80173c:	5e                   	pop    %esi
  80173d:	5f                   	pop    %edi
  80173e:	5d                   	pop    %ebp
  80173f:	c3                   	ret    
  801740:	bd 20 00 00 00       	mov    $0x20,%ebp
  801745:	89 eb                	mov    %ebp,%ebx
  801747:	29 fb                	sub    %edi,%ebx
  801749:	89 f9                	mov    %edi,%ecx
  80174b:	d3 e6                	shl    %cl,%esi
  80174d:	89 c5                	mov    %eax,%ebp
  80174f:	88 d9                	mov    %bl,%cl
  801751:	d3 ed                	shr    %cl,%ebp
  801753:	89 e9                	mov    %ebp,%ecx
  801755:	09 f1                	or     %esi,%ecx
  801757:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80175b:	89 f9                	mov    %edi,%ecx
  80175d:	d3 e0                	shl    %cl,%eax
  80175f:	89 c5                	mov    %eax,%ebp
  801761:	89 d6                	mov    %edx,%esi
  801763:	88 d9                	mov    %bl,%cl
  801765:	d3 ee                	shr    %cl,%esi
  801767:	89 f9                	mov    %edi,%ecx
  801769:	d3 e2                	shl    %cl,%edx
  80176b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80176f:	88 d9                	mov    %bl,%cl
  801771:	d3 e8                	shr    %cl,%eax
  801773:	09 c2                	or     %eax,%edx
  801775:	89 d0                	mov    %edx,%eax
  801777:	89 f2                	mov    %esi,%edx
  801779:	f7 74 24 0c          	divl   0xc(%esp)
  80177d:	89 d6                	mov    %edx,%esi
  80177f:	89 c3                	mov    %eax,%ebx
  801781:	f7 e5                	mul    %ebp
  801783:	39 d6                	cmp    %edx,%esi
  801785:	72 19                	jb     8017a0 <__udivdi3+0xfc>
  801787:	74 0b                	je     801794 <__udivdi3+0xf0>
  801789:	89 d8                	mov    %ebx,%eax
  80178b:	31 ff                	xor    %edi,%edi
  80178d:	e9 58 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  801792:	66 90                	xchg   %ax,%ax
  801794:	8b 54 24 08          	mov    0x8(%esp),%edx
  801798:	89 f9                	mov    %edi,%ecx
  80179a:	d3 e2                	shl    %cl,%edx
  80179c:	39 c2                	cmp    %eax,%edx
  80179e:	73 e9                	jae    801789 <__udivdi3+0xe5>
  8017a0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017a3:	31 ff                	xor    %edi,%edi
  8017a5:	e9 40 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  8017aa:	66 90                	xchg   %ax,%ax
  8017ac:	31 c0                	xor    %eax,%eax
  8017ae:	e9 37 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  8017b3:	90                   	nop

008017b4 <__umoddi3>:
  8017b4:	55                   	push   %ebp
  8017b5:	57                   	push   %edi
  8017b6:	56                   	push   %esi
  8017b7:	53                   	push   %ebx
  8017b8:	83 ec 1c             	sub    $0x1c,%esp
  8017bb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017bf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017c7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017cf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017d3:	89 f3                	mov    %esi,%ebx
  8017d5:	89 fa                	mov    %edi,%edx
  8017d7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017db:	89 34 24             	mov    %esi,(%esp)
  8017de:	85 c0                	test   %eax,%eax
  8017e0:	75 1a                	jne    8017fc <__umoddi3+0x48>
  8017e2:	39 f7                	cmp    %esi,%edi
  8017e4:	0f 86 a2 00 00 00    	jbe    80188c <__umoddi3+0xd8>
  8017ea:	89 c8                	mov    %ecx,%eax
  8017ec:	89 f2                	mov    %esi,%edx
  8017ee:	f7 f7                	div    %edi
  8017f0:	89 d0                	mov    %edx,%eax
  8017f2:	31 d2                	xor    %edx,%edx
  8017f4:	83 c4 1c             	add    $0x1c,%esp
  8017f7:	5b                   	pop    %ebx
  8017f8:	5e                   	pop    %esi
  8017f9:	5f                   	pop    %edi
  8017fa:	5d                   	pop    %ebp
  8017fb:	c3                   	ret    
  8017fc:	39 f0                	cmp    %esi,%eax
  8017fe:	0f 87 ac 00 00 00    	ja     8018b0 <__umoddi3+0xfc>
  801804:	0f bd e8             	bsr    %eax,%ebp
  801807:	83 f5 1f             	xor    $0x1f,%ebp
  80180a:	0f 84 ac 00 00 00    	je     8018bc <__umoddi3+0x108>
  801810:	bf 20 00 00 00       	mov    $0x20,%edi
  801815:	29 ef                	sub    %ebp,%edi
  801817:	89 fe                	mov    %edi,%esi
  801819:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80181d:	89 e9                	mov    %ebp,%ecx
  80181f:	d3 e0                	shl    %cl,%eax
  801821:	89 d7                	mov    %edx,%edi
  801823:	89 f1                	mov    %esi,%ecx
  801825:	d3 ef                	shr    %cl,%edi
  801827:	09 c7                	or     %eax,%edi
  801829:	89 e9                	mov    %ebp,%ecx
  80182b:	d3 e2                	shl    %cl,%edx
  80182d:	89 14 24             	mov    %edx,(%esp)
  801830:	89 d8                	mov    %ebx,%eax
  801832:	d3 e0                	shl    %cl,%eax
  801834:	89 c2                	mov    %eax,%edx
  801836:	8b 44 24 08          	mov    0x8(%esp),%eax
  80183a:	d3 e0                	shl    %cl,%eax
  80183c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801840:	8b 44 24 08          	mov    0x8(%esp),%eax
  801844:	89 f1                	mov    %esi,%ecx
  801846:	d3 e8                	shr    %cl,%eax
  801848:	09 d0                	or     %edx,%eax
  80184a:	d3 eb                	shr    %cl,%ebx
  80184c:	89 da                	mov    %ebx,%edx
  80184e:	f7 f7                	div    %edi
  801850:	89 d3                	mov    %edx,%ebx
  801852:	f7 24 24             	mull   (%esp)
  801855:	89 c6                	mov    %eax,%esi
  801857:	89 d1                	mov    %edx,%ecx
  801859:	39 d3                	cmp    %edx,%ebx
  80185b:	0f 82 87 00 00 00    	jb     8018e8 <__umoddi3+0x134>
  801861:	0f 84 91 00 00 00    	je     8018f8 <__umoddi3+0x144>
  801867:	8b 54 24 04          	mov    0x4(%esp),%edx
  80186b:	29 f2                	sub    %esi,%edx
  80186d:	19 cb                	sbb    %ecx,%ebx
  80186f:	89 d8                	mov    %ebx,%eax
  801871:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801875:	d3 e0                	shl    %cl,%eax
  801877:	89 e9                	mov    %ebp,%ecx
  801879:	d3 ea                	shr    %cl,%edx
  80187b:	09 d0                	or     %edx,%eax
  80187d:	89 e9                	mov    %ebp,%ecx
  80187f:	d3 eb                	shr    %cl,%ebx
  801881:	89 da                	mov    %ebx,%edx
  801883:	83 c4 1c             	add    $0x1c,%esp
  801886:	5b                   	pop    %ebx
  801887:	5e                   	pop    %esi
  801888:	5f                   	pop    %edi
  801889:	5d                   	pop    %ebp
  80188a:	c3                   	ret    
  80188b:	90                   	nop
  80188c:	89 fd                	mov    %edi,%ebp
  80188e:	85 ff                	test   %edi,%edi
  801890:	75 0b                	jne    80189d <__umoddi3+0xe9>
  801892:	b8 01 00 00 00       	mov    $0x1,%eax
  801897:	31 d2                	xor    %edx,%edx
  801899:	f7 f7                	div    %edi
  80189b:	89 c5                	mov    %eax,%ebp
  80189d:	89 f0                	mov    %esi,%eax
  80189f:	31 d2                	xor    %edx,%edx
  8018a1:	f7 f5                	div    %ebp
  8018a3:	89 c8                	mov    %ecx,%eax
  8018a5:	f7 f5                	div    %ebp
  8018a7:	89 d0                	mov    %edx,%eax
  8018a9:	e9 44 ff ff ff       	jmp    8017f2 <__umoddi3+0x3e>
  8018ae:	66 90                	xchg   %ax,%ax
  8018b0:	89 c8                	mov    %ecx,%eax
  8018b2:	89 f2                	mov    %esi,%edx
  8018b4:	83 c4 1c             	add    $0x1c,%esp
  8018b7:	5b                   	pop    %ebx
  8018b8:	5e                   	pop    %esi
  8018b9:	5f                   	pop    %edi
  8018ba:	5d                   	pop    %ebp
  8018bb:	c3                   	ret    
  8018bc:	3b 04 24             	cmp    (%esp),%eax
  8018bf:	72 06                	jb     8018c7 <__umoddi3+0x113>
  8018c1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018c5:	77 0f                	ja     8018d6 <__umoddi3+0x122>
  8018c7:	89 f2                	mov    %esi,%edx
  8018c9:	29 f9                	sub    %edi,%ecx
  8018cb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018cf:	89 14 24             	mov    %edx,(%esp)
  8018d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018d6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018da:	8b 14 24             	mov    (%esp),%edx
  8018dd:	83 c4 1c             	add    $0x1c,%esp
  8018e0:	5b                   	pop    %ebx
  8018e1:	5e                   	pop    %esi
  8018e2:	5f                   	pop    %edi
  8018e3:	5d                   	pop    %ebp
  8018e4:	c3                   	ret    
  8018e5:	8d 76 00             	lea    0x0(%esi),%esi
  8018e8:	2b 04 24             	sub    (%esp),%eax
  8018eb:	19 fa                	sbb    %edi,%edx
  8018ed:	89 d1                	mov    %edx,%ecx
  8018ef:	89 c6                	mov    %eax,%esi
  8018f1:	e9 71 ff ff ff       	jmp    801867 <__umoddi3+0xb3>
  8018f6:	66 90                	xchg   %ax,%ax
  8018f8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018fc:	72 ea                	jb     8018e8 <__umoddi3+0x134>
  8018fe:	89 d9                	mov    %ebx,%ecx
  801900:	e9 62 ff ff ff       	jmp    801867 <__umoddi3+0xb3>
