
obj/user/tst_semaphore_2slave:     file format elf32-i386


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
  800031:	e8 8a 00 00 00       	call   8000c0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int id = sys_getenvindex();
  80003e:	e8 7e 10 00 00       	call   8010c1 <sys_getenvindex>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int32 parentenvID = sys_getparentenvid();
  800046:	e8 8f 10 00 00       	call   8010da <sys_getparentenvid>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//cprintf("Cust %d: outside the shop\n", id);

	sys_waitSemaphore(parentenvID, "shopCapacity") ;
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	68 60 19 80 00       	push   $0x801960
  800056:	ff 75 f0             	pushl  -0x10(%ebp)
  800059:	e8 ab 12 00 00       	call   801309 <sys_waitSemaphore>
  80005e:	83 c4 10             	add    $0x10,%esp
		cprintf("Cust %d: inside the shop\n", id) ;
  800061:	83 ec 08             	sub    $0x8,%esp
  800064:	ff 75 f4             	pushl  -0xc(%ebp)
  800067:	68 6d 19 80 00       	push   $0x80196d
  80006c:	e8 25 02 00 00       	call   800296 <cprintf>
  800071:	83 c4 10             	add    $0x10,%esp
		env_sleep(1000) ;
  800074:	83 ec 0c             	sub    $0xc,%esp
  800077:	68 e8 03 00 00       	push   $0x3e8
  80007c:	e8 b9 15 00 00       	call   80163a <env_sleep>
  800081:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "shopCapacity") ;
  800084:	83 ec 08             	sub    $0x8,%esp
  800087:	68 60 19 80 00       	push   $0x801960
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	e8 93 12 00 00       	call   801327 <sys_signalSemaphore>
  800094:	83 c4 10             	add    $0x10,%esp

	cprintf("Cust %d: exit the shop\n", id);
  800097:	83 ec 08             	sub    $0x8,%esp
  80009a:	ff 75 f4             	pushl  -0xc(%ebp)
  80009d:	68 87 19 80 00       	push   $0x801987
  8000a2:	e8 ef 01 00 00       	call   800296 <cprintf>
  8000a7:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "depend") ;
  8000aa:	83 ec 08             	sub    $0x8,%esp
  8000ad:	68 9f 19 80 00       	push   $0x80199f
  8000b2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b5:	e8 6d 12 00 00       	call   801327 <sys_signalSemaphore>
  8000ba:	83 c4 10             	add    $0x10,%esp
	return;
  8000bd:	90                   	nop
}
  8000be:	c9                   	leave  
  8000bf:	c3                   	ret    

008000c0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c0:	55                   	push   %ebp
  8000c1:	89 e5                	mov    %esp,%ebp
  8000c3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c6:	e8 f6 0f 00 00       	call   8010c1 <sys_getenvindex>
  8000cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d1:	89 d0                	mov    %edx,%eax
  8000d3:	01 c0                	add    %eax,%eax
  8000d5:	01 d0                	add    %edx,%eax
  8000d7:	c1 e0 02             	shl    $0x2,%eax
  8000da:	01 d0                	add    %edx,%eax
  8000dc:	c1 e0 06             	shl    $0x6,%eax
  8000df:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000e4:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000e9:	a1 04 20 80 00       	mov    0x802004,%eax
  8000ee:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000f4:	84 c0                	test   %al,%al
  8000f6:	74 0f                	je     800107 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000f8:	a1 04 20 80 00       	mov    0x802004,%eax
  8000fd:	05 f4 02 00 00       	add    $0x2f4,%eax
  800102:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800107:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80010b:	7e 0a                	jle    800117 <libmain+0x57>
		binaryname = argv[0];
  80010d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800110:	8b 00                	mov    (%eax),%eax
  800112:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800117:	83 ec 08             	sub    $0x8,%esp
  80011a:	ff 75 0c             	pushl  0xc(%ebp)
  80011d:	ff 75 08             	pushl  0x8(%ebp)
  800120:	e8 13 ff ff ff       	call   800038 <_main>
  800125:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800128:	e8 2f 11 00 00       	call   80125c <sys_disable_interrupt>
	cprintf("**************************************\n");
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	68 c0 19 80 00       	push   $0x8019c0
  800135:	e8 5c 01 00 00       	call   800296 <cprintf>
  80013a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80013d:	a1 04 20 80 00       	mov    0x802004,%eax
  800142:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800148:	a1 04 20 80 00       	mov    0x802004,%eax
  80014d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800153:	83 ec 04             	sub    $0x4,%esp
  800156:	52                   	push   %edx
  800157:	50                   	push   %eax
  800158:	68 e8 19 80 00       	push   $0x8019e8
  80015d:	e8 34 01 00 00       	call   800296 <cprintf>
  800162:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800165:	a1 04 20 80 00       	mov    0x802004,%eax
  80016a:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	50                   	push   %eax
  800174:	68 0d 1a 80 00       	push   $0x801a0d
  800179:	e8 18 01 00 00       	call   800296 <cprintf>
  80017e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800181:	83 ec 0c             	sub    $0xc,%esp
  800184:	68 c0 19 80 00       	push   $0x8019c0
  800189:	e8 08 01 00 00       	call   800296 <cprintf>
  80018e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800191:	e8 e0 10 00 00       	call   801276 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800196:	e8 19 00 00 00       	call   8001b4 <exit>
}
  80019b:	90                   	nop
  80019c:	c9                   	leave  
  80019d:	c3                   	ret    

0080019e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80019e:	55                   	push   %ebp
  80019f:	89 e5                	mov    %esp,%ebp
  8001a1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001a4:	83 ec 0c             	sub    $0xc,%esp
  8001a7:	6a 00                	push   $0x0
  8001a9:	e8 df 0e 00 00       	call   80108d <sys_env_destroy>
  8001ae:	83 c4 10             	add    $0x10,%esp
}
  8001b1:	90                   	nop
  8001b2:	c9                   	leave  
  8001b3:	c3                   	ret    

008001b4 <exit>:

void
exit(void)
{
  8001b4:	55                   	push   %ebp
  8001b5:	89 e5                	mov    %esp,%ebp
  8001b7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001ba:	e8 34 0f 00 00       	call   8010f3 <sys_env_exit>
}
  8001bf:	90                   	nop
  8001c0:	c9                   	leave  
  8001c1:	c3                   	ret    

008001c2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001c2:	55                   	push   %ebp
  8001c3:	89 e5                	mov    %esp,%ebp
  8001c5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001cb:	8b 00                	mov    (%eax),%eax
  8001cd:	8d 48 01             	lea    0x1(%eax),%ecx
  8001d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d3:	89 0a                	mov    %ecx,(%edx)
  8001d5:	8b 55 08             	mov    0x8(%ebp),%edx
  8001d8:	88 d1                	mov    %dl,%cl
  8001da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001dd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e4:	8b 00                	mov    (%eax),%eax
  8001e6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001eb:	75 2c                	jne    800219 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001ed:	a0 08 20 80 00       	mov    0x802008,%al
  8001f2:	0f b6 c0             	movzbl %al,%eax
  8001f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f8:	8b 12                	mov    (%edx),%edx
  8001fa:	89 d1                	mov    %edx,%ecx
  8001fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ff:	83 c2 08             	add    $0x8,%edx
  800202:	83 ec 04             	sub    $0x4,%esp
  800205:	50                   	push   %eax
  800206:	51                   	push   %ecx
  800207:	52                   	push   %edx
  800208:	e8 3e 0e 00 00       	call   80104b <sys_cputs>
  80020d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800210:	8b 45 0c             	mov    0xc(%ebp),%eax
  800213:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800219:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021c:	8b 40 04             	mov    0x4(%eax),%eax
  80021f:	8d 50 01             	lea    0x1(%eax),%edx
  800222:	8b 45 0c             	mov    0xc(%ebp),%eax
  800225:	89 50 04             	mov    %edx,0x4(%eax)
}
  800228:	90                   	nop
  800229:	c9                   	leave  
  80022a:	c3                   	ret    

0080022b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80022b:	55                   	push   %ebp
  80022c:	89 e5                	mov    %esp,%ebp
  80022e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800234:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80023b:	00 00 00 
	b.cnt = 0;
  80023e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800245:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800248:	ff 75 0c             	pushl  0xc(%ebp)
  80024b:	ff 75 08             	pushl  0x8(%ebp)
  80024e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800254:	50                   	push   %eax
  800255:	68 c2 01 80 00       	push   $0x8001c2
  80025a:	e8 11 02 00 00       	call   800470 <vprintfmt>
  80025f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800262:	a0 08 20 80 00       	mov    0x802008,%al
  800267:	0f b6 c0             	movzbl %al,%eax
  80026a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800270:	83 ec 04             	sub    $0x4,%esp
  800273:	50                   	push   %eax
  800274:	52                   	push   %edx
  800275:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80027b:	83 c0 08             	add    $0x8,%eax
  80027e:	50                   	push   %eax
  80027f:	e8 c7 0d 00 00       	call   80104b <sys_cputs>
  800284:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800287:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  80028e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800294:	c9                   	leave  
  800295:	c3                   	ret    

00800296 <cprintf>:

int cprintf(const char *fmt, ...) {
  800296:	55                   	push   %ebp
  800297:	89 e5                	mov    %esp,%ebp
  800299:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80029c:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002a3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ac:	83 ec 08             	sub    $0x8,%esp
  8002af:	ff 75 f4             	pushl  -0xc(%ebp)
  8002b2:	50                   	push   %eax
  8002b3:	e8 73 ff ff ff       	call   80022b <vcprintf>
  8002b8:	83 c4 10             	add    $0x10,%esp
  8002bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002be:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002c1:	c9                   	leave  
  8002c2:	c3                   	ret    

008002c3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002c3:	55                   	push   %ebp
  8002c4:	89 e5                	mov    %esp,%ebp
  8002c6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002c9:	e8 8e 0f 00 00       	call   80125c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002ce:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d7:	83 ec 08             	sub    $0x8,%esp
  8002da:	ff 75 f4             	pushl  -0xc(%ebp)
  8002dd:	50                   	push   %eax
  8002de:	e8 48 ff ff ff       	call   80022b <vcprintf>
  8002e3:	83 c4 10             	add    $0x10,%esp
  8002e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002e9:	e8 88 0f 00 00       	call   801276 <sys_enable_interrupt>
	return cnt;
  8002ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002f1:	c9                   	leave  
  8002f2:	c3                   	ret    

008002f3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002f3:	55                   	push   %ebp
  8002f4:	89 e5                	mov    %esp,%ebp
  8002f6:	53                   	push   %ebx
  8002f7:	83 ec 14             	sub    $0x14,%esp
  8002fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8002fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800300:	8b 45 14             	mov    0x14(%ebp),%eax
  800303:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800306:	8b 45 18             	mov    0x18(%ebp),%eax
  800309:	ba 00 00 00 00       	mov    $0x0,%edx
  80030e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800311:	77 55                	ja     800368 <printnum+0x75>
  800313:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800316:	72 05                	jb     80031d <printnum+0x2a>
  800318:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031b:	77 4b                	ja     800368 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80031d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800320:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800323:	8b 45 18             	mov    0x18(%ebp),%eax
  800326:	ba 00 00 00 00       	mov    $0x0,%edx
  80032b:	52                   	push   %edx
  80032c:	50                   	push   %eax
  80032d:	ff 75 f4             	pushl  -0xc(%ebp)
  800330:	ff 75 f0             	pushl  -0x10(%ebp)
  800333:	e8 b8 13 00 00       	call   8016f0 <__udivdi3>
  800338:	83 c4 10             	add    $0x10,%esp
  80033b:	83 ec 04             	sub    $0x4,%esp
  80033e:	ff 75 20             	pushl  0x20(%ebp)
  800341:	53                   	push   %ebx
  800342:	ff 75 18             	pushl  0x18(%ebp)
  800345:	52                   	push   %edx
  800346:	50                   	push   %eax
  800347:	ff 75 0c             	pushl  0xc(%ebp)
  80034a:	ff 75 08             	pushl  0x8(%ebp)
  80034d:	e8 a1 ff ff ff       	call   8002f3 <printnum>
  800352:	83 c4 20             	add    $0x20,%esp
  800355:	eb 1a                	jmp    800371 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800357:	83 ec 08             	sub    $0x8,%esp
  80035a:	ff 75 0c             	pushl  0xc(%ebp)
  80035d:	ff 75 20             	pushl  0x20(%ebp)
  800360:	8b 45 08             	mov    0x8(%ebp),%eax
  800363:	ff d0                	call   *%eax
  800365:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800368:	ff 4d 1c             	decl   0x1c(%ebp)
  80036b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80036f:	7f e6                	jg     800357 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800371:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800374:	bb 00 00 00 00       	mov    $0x0,%ebx
  800379:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80037f:	53                   	push   %ebx
  800380:	51                   	push   %ecx
  800381:	52                   	push   %edx
  800382:	50                   	push   %eax
  800383:	e8 78 14 00 00       	call   801800 <__umoddi3>
  800388:	83 c4 10             	add    $0x10,%esp
  80038b:	05 54 1c 80 00       	add    $0x801c54,%eax
  800390:	8a 00                	mov    (%eax),%al
  800392:	0f be c0             	movsbl %al,%eax
  800395:	83 ec 08             	sub    $0x8,%esp
  800398:	ff 75 0c             	pushl  0xc(%ebp)
  80039b:	50                   	push   %eax
  80039c:	8b 45 08             	mov    0x8(%ebp),%eax
  80039f:	ff d0                	call   *%eax
  8003a1:	83 c4 10             	add    $0x10,%esp
}
  8003a4:	90                   	nop
  8003a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003a8:	c9                   	leave  
  8003a9:	c3                   	ret    

008003aa <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003aa:	55                   	push   %ebp
  8003ab:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003ad:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003b1:	7e 1c                	jle    8003cf <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b6:	8b 00                	mov    (%eax),%eax
  8003b8:	8d 50 08             	lea    0x8(%eax),%edx
  8003bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003be:	89 10                	mov    %edx,(%eax)
  8003c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c3:	8b 00                	mov    (%eax),%eax
  8003c5:	83 e8 08             	sub    $0x8,%eax
  8003c8:	8b 50 04             	mov    0x4(%eax),%edx
  8003cb:	8b 00                	mov    (%eax),%eax
  8003cd:	eb 40                	jmp    80040f <getuint+0x65>
	else if (lflag)
  8003cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003d3:	74 1e                	je     8003f3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	8b 00                	mov    (%eax),%eax
  8003da:	8d 50 04             	lea    0x4(%eax),%edx
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	89 10                	mov    %edx,(%eax)
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	8b 00                	mov    (%eax),%eax
  8003e7:	83 e8 04             	sub    $0x4,%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	ba 00 00 00 00       	mov    $0x0,%edx
  8003f1:	eb 1c                	jmp    80040f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	8b 00                	mov    (%eax),%eax
  8003f8:	8d 50 04             	lea    0x4(%eax),%edx
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	89 10                	mov    %edx,(%eax)
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	8b 00                	mov    (%eax),%eax
  800405:	83 e8 04             	sub    $0x4,%eax
  800408:	8b 00                	mov    (%eax),%eax
  80040a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80040f:	5d                   	pop    %ebp
  800410:	c3                   	ret    

00800411 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800411:	55                   	push   %ebp
  800412:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800414:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800418:	7e 1c                	jle    800436 <getint+0x25>
		return va_arg(*ap, long long);
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	8b 00                	mov    (%eax),%eax
  80041f:	8d 50 08             	lea    0x8(%eax),%edx
  800422:	8b 45 08             	mov    0x8(%ebp),%eax
  800425:	89 10                	mov    %edx,(%eax)
  800427:	8b 45 08             	mov    0x8(%ebp),%eax
  80042a:	8b 00                	mov    (%eax),%eax
  80042c:	83 e8 08             	sub    $0x8,%eax
  80042f:	8b 50 04             	mov    0x4(%eax),%edx
  800432:	8b 00                	mov    (%eax),%eax
  800434:	eb 38                	jmp    80046e <getint+0x5d>
	else if (lflag)
  800436:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80043a:	74 1a                	je     800456 <getint+0x45>
		return va_arg(*ap, long);
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	8d 50 04             	lea    0x4(%eax),%edx
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	89 10                	mov    %edx,(%eax)
  800449:	8b 45 08             	mov    0x8(%ebp),%eax
  80044c:	8b 00                	mov    (%eax),%eax
  80044e:	83 e8 04             	sub    $0x4,%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	99                   	cltd   
  800454:	eb 18                	jmp    80046e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800456:	8b 45 08             	mov    0x8(%ebp),%eax
  800459:	8b 00                	mov    (%eax),%eax
  80045b:	8d 50 04             	lea    0x4(%eax),%edx
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	89 10                	mov    %edx,(%eax)
  800463:	8b 45 08             	mov    0x8(%ebp),%eax
  800466:	8b 00                	mov    (%eax),%eax
  800468:	83 e8 04             	sub    $0x4,%eax
  80046b:	8b 00                	mov    (%eax),%eax
  80046d:	99                   	cltd   
}
  80046e:	5d                   	pop    %ebp
  80046f:	c3                   	ret    

00800470 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800470:	55                   	push   %ebp
  800471:	89 e5                	mov    %esp,%ebp
  800473:	56                   	push   %esi
  800474:	53                   	push   %ebx
  800475:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800478:	eb 17                	jmp    800491 <vprintfmt+0x21>
			if (ch == '\0')
  80047a:	85 db                	test   %ebx,%ebx
  80047c:	0f 84 af 03 00 00    	je     800831 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800482:	83 ec 08             	sub    $0x8,%esp
  800485:	ff 75 0c             	pushl  0xc(%ebp)
  800488:	53                   	push   %ebx
  800489:	8b 45 08             	mov    0x8(%ebp),%eax
  80048c:	ff d0                	call   *%eax
  80048e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800491:	8b 45 10             	mov    0x10(%ebp),%eax
  800494:	8d 50 01             	lea    0x1(%eax),%edx
  800497:	89 55 10             	mov    %edx,0x10(%ebp)
  80049a:	8a 00                	mov    (%eax),%al
  80049c:	0f b6 d8             	movzbl %al,%ebx
  80049f:	83 fb 25             	cmp    $0x25,%ebx
  8004a2:	75 d6                	jne    80047a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004a4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004a8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004af:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004b6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004bd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c7:	8d 50 01             	lea    0x1(%eax),%edx
  8004ca:	89 55 10             	mov    %edx,0x10(%ebp)
  8004cd:	8a 00                	mov    (%eax),%al
  8004cf:	0f b6 d8             	movzbl %al,%ebx
  8004d2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004d5:	83 f8 55             	cmp    $0x55,%eax
  8004d8:	0f 87 2b 03 00 00    	ja     800809 <vprintfmt+0x399>
  8004de:	8b 04 85 78 1c 80 00 	mov    0x801c78(,%eax,4),%eax
  8004e5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004e7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004eb:	eb d7                	jmp    8004c4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004ed:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004f1:	eb d1                	jmp    8004c4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004f3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004fa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004fd:	89 d0                	mov    %edx,%eax
  8004ff:	c1 e0 02             	shl    $0x2,%eax
  800502:	01 d0                	add    %edx,%eax
  800504:	01 c0                	add    %eax,%eax
  800506:	01 d8                	add    %ebx,%eax
  800508:	83 e8 30             	sub    $0x30,%eax
  80050b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80050e:	8b 45 10             	mov    0x10(%ebp),%eax
  800511:	8a 00                	mov    (%eax),%al
  800513:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800516:	83 fb 2f             	cmp    $0x2f,%ebx
  800519:	7e 3e                	jle    800559 <vprintfmt+0xe9>
  80051b:	83 fb 39             	cmp    $0x39,%ebx
  80051e:	7f 39                	jg     800559 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800520:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800523:	eb d5                	jmp    8004fa <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800525:	8b 45 14             	mov    0x14(%ebp),%eax
  800528:	83 c0 04             	add    $0x4,%eax
  80052b:	89 45 14             	mov    %eax,0x14(%ebp)
  80052e:	8b 45 14             	mov    0x14(%ebp),%eax
  800531:	83 e8 04             	sub    $0x4,%eax
  800534:	8b 00                	mov    (%eax),%eax
  800536:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800539:	eb 1f                	jmp    80055a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80053b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80053f:	79 83                	jns    8004c4 <vprintfmt+0x54>
				width = 0;
  800541:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800548:	e9 77 ff ff ff       	jmp    8004c4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80054d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800554:	e9 6b ff ff ff       	jmp    8004c4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800559:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80055a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80055e:	0f 89 60 ff ff ff    	jns    8004c4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800564:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800567:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80056a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800571:	e9 4e ff ff ff       	jmp    8004c4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800576:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800579:	e9 46 ff ff ff       	jmp    8004c4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80057e:	8b 45 14             	mov    0x14(%ebp),%eax
  800581:	83 c0 04             	add    $0x4,%eax
  800584:	89 45 14             	mov    %eax,0x14(%ebp)
  800587:	8b 45 14             	mov    0x14(%ebp),%eax
  80058a:	83 e8 04             	sub    $0x4,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	83 ec 08             	sub    $0x8,%esp
  800592:	ff 75 0c             	pushl  0xc(%ebp)
  800595:	50                   	push   %eax
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	ff d0                	call   *%eax
  80059b:	83 c4 10             	add    $0x10,%esp
			break;
  80059e:	e9 89 02 00 00       	jmp    80082c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a6:	83 c0 04             	add    $0x4,%eax
  8005a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8005af:	83 e8 04             	sub    $0x4,%eax
  8005b2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005b4:	85 db                	test   %ebx,%ebx
  8005b6:	79 02                	jns    8005ba <vprintfmt+0x14a>
				err = -err;
  8005b8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005ba:	83 fb 64             	cmp    $0x64,%ebx
  8005bd:	7f 0b                	jg     8005ca <vprintfmt+0x15a>
  8005bf:	8b 34 9d c0 1a 80 00 	mov    0x801ac0(,%ebx,4),%esi
  8005c6:	85 f6                	test   %esi,%esi
  8005c8:	75 19                	jne    8005e3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005ca:	53                   	push   %ebx
  8005cb:	68 65 1c 80 00       	push   $0x801c65
  8005d0:	ff 75 0c             	pushl  0xc(%ebp)
  8005d3:	ff 75 08             	pushl  0x8(%ebp)
  8005d6:	e8 5e 02 00 00       	call   800839 <printfmt>
  8005db:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005de:	e9 49 02 00 00       	jmp    80082c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005e3:	56                   	push   %esi
  8005e4:	68 6e 1c 80 00       	push   $0x801c6e
  8005e9:	ff 75 0c             	pushl  0xc(%ebp)
  8005ec:	ff 75 08             	pushl  0x8(%ebp)
  8005ef:	e8 45 02 00 00       	call   800839 <printfmt>
  8005f4:	83 c4 10             	add    $0x10,%esp
			break;
  8005f7:	e9 30 02 00 00       	jmp    80082c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ff:	83 c0 04             	add    $0x4,%eax
  800602:	89 45 14             	mov    %eax,0x14(%ebp)
  800605:	8b 45 14             	mov    0x14(%ebp),%eax
  800608:	83 e8 04             	sub    $0x4,%eax
  80060b:	8b 30                	mov    (%eax),%esi
  80060d:	85 f6                	test   %esi,%esi
  80060f:	75 05                	jne    800616 <vprintfmt+0x1a6>
				p = "(null)";
  800611:	be 71 1c 80 00       	mov    $0x801c71,%esi
			if (width > 0 && padc != '-')
  800616:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80061a:	7e 6d                	jle    800689 <vprintfmt+0x219>
  80061c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800620:	74 67                	je     800689 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800622:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800625:	83 ec 08             	sub    $0x8,%esp
  800628:	50                   	push   %eax
  800629:	56                   	push   %esi
  80062a:	e8 0c 03 00 00       	call   80093b <strnlen>
  80062f:	83 c4 10             	add    $0x10,%esp
  800632:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800635:	eb 16                	jmp    80064d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800637:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80063b:	83 ec 08             	sub    $0x8,%esp
  80063e:	ff 75 0c             	pushl  0xc(%ebp)
  800641:	50                   	push   %eax
  800642:	8b 45 08             	mov    0x8(%ebp),%eax
  800645:	ff d0                	call   *%eax
  800647:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80064a:	ff 4d e4             	decl   -0x1c(%ebp)
  80064d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800651:	7f e4                	jg     800637 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800653:	eb 34                	jmp    800689 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800655:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800659:	74 1c                	je     800677 <vprintfmt+0x207>
  80065b:	83 fb 1f             	cmp    $0x1f,%ebx
  80065e:	7e 05                	jle    800665 <vprintfmt+0x1f5>
  800660:	83 fb 7e             	cmp    $0x7e,%ebx
  800663:	7e 12                	jle    800677 <vprintfmt+0x207>
					putch('?', putdat);
  800665:	83 ec 08             	sub    $0x8,%esp
  800668:	ff 75 0c             	pushl  0xc(%ebp)
  80066b:	6a 3f                	push   $0x3f
  80066d:	8b 45 08             	mov    0x8(%ebp),%eax
  800670:	ff d0                	call   *%eax
  800672:	83 c4 10             	add    $0x10,%esp
  800675:	eb 0f                	jmp    800686 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800677:	83 ec 08             	sub    $0x8,%esp
  80067a:	ff 75 0c             	pushl  0xc(%ebp)
  80067d:	53                   	push   %ebx
  80067e:	8b 45 08             	mov    0x8(%ebp),%eax
  800681:	ff d0                	call   *%eax
  800683:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800686:	ff 4d e4             	decl   -0x1c(%ebp)
  800689:	89 f0                	mov    %esi,%eax
  80068b:	8d 70 01             	lea    0x1(%eax),%esi
  80068e:	8a 00                	mov    (%eax),%al
  800690:	0f be d8             	movsbl %al,%ebx
  800693:	85 db                	test   %ebx,%ebx
  800695:	74 24                	je     8006bb <vprintfmt+0x24b>
  800697:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80069b:	78 b8                	js     800655 <vprintfmt+0x1e5>
  80069d:	ff 4d e0             	decl   -0x20(%ebp)
  8006a0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006a4:	79 af                	jns    800655 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a6:	eb 13                	jmp    8006bb <vprintfmt+0x24b>
				putch(' ', putdat);
  8006a8:	83 ec 08             	sub    $0x8,%esp
  8006ab:	ff 75 0c             	pushl  0xc(%ebp)
  8006ae:	6a 20                	push   $0x20
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	ff d0                	call   *%eax
  8006b5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006b8:	ff 4d e4             	decl   -0x1c(%ebp)
  8006bb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006bf:	7f e7                	jg     8006a8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006c1:	e9 66 01 00 00       	jmp    80082c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006c6:	83 ec 08             	sub    $0x8,%esp
  8006c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8006cc:	8d 45 14             	lea    0x14(%ebp),%eax
  8006cf:	50                   	push   %eax
  8006d0:	e8 3c fd ff ff       	call   800411 <getint>
  8006d5:	83 c4 10             	add    $0x10,%esp
  8006d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006db:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e4:	85 d2                	test   %edx,%edx
  8006e6:	79 23                	jns    80070b <vprintfmt+0x29b>
				putch('-', putdat);
  8006e8:	83 ec 08             	sub    $0x8,%esp
  8006eb:	ff 75 0c             	pushl  0xc(%ebp)
  8006ee:	6a 2d                	push   $0x2d
  8006f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f3:	ff d0                	call   *%eax
  8006f5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006fe:	f7 d8                	neg    %eax
  800700:	83 d2 00             	adc    $0x0,%edx
  800703:	f7 da                	neg    %edx
  800705:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800708:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80070b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800712:	e9 bc 00 00 00       	jmp    8007d3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	ff 75 e8             	pushl  -0x18(%ebp)
  80071d:	8d 45 14             	lea    0x14(%ebp),%eax
  800720:	50                   	push   %eax
  800721:	e8 84 fc ff ff       	call   8003aa <getuint>
  800726:	83 c4 10             	add    $0x10,%esp
  800729:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80072c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80072f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800736:	e9 98 00 00 00       	jmp    8007d3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80073b:	83 ec 08             	sub    $0x8,%esp
  80073e:	ff 75 0c             	pushl  0xc(%ebp)
  800741:	6a 58                	push   $0x58
  800743:	8b 45 08             	mov    0x8(%ebp),%eax
  800746:	ff d0                	call   *%eax
  800748:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80074b:	83 ec 08             	sub    $0x8,%esp
  80074e:	ff 75 0c             	pushl  0xc(%ebp)
  800751:	6a 58                	push   $0x58
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	ff d0                	call   *%eax
  800758:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 0c             	pushl  0xc(%ebp)
  800761:	6a 58                	push   $0x58
  800763:	8b 45 08             	mov    0x8(%ebp),%eax
  800766:	ff d0                	call   *%eax
  800768:	83 c4 10             	add    $0x10,%esp
			break;
  80076b:	e9 bc 00 00 00       	jmp    80082c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	6a 30                	push   $0x30
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	ff d0                	call   *%eax
  80077d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	ff 75 0c             	pushl  0xc(%ebp)
  800786:	6a 78                	push   $0x78
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	ff d0                	call   *%eax
  80078d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800790:	8b 45 14             	mov    0x14(%ebp),%eax
  800793:	83 c0 04             	add    $0x4,%eax
  800796:	89 45 14             	mov    %eax,0x14(%ebp)
  800799:	8b 45 14             	mov    0x14(%ebp),%eax
  80079c:	83 e8 04             	sub    $0x4,%eax
  80079f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007ab:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007b2:	eb 1f                	jmp    8007d3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007b4:	83 ec 08             	sub    $0x8,%esp
  8007b7:	ff 75 e8             	pushl  -0x18(%ebp)
  8007ba:	8d 45 14             	lea    0x14(%ebp),%eax
  8007bd:	50                   	push   %eax
  8007be:	e8 e7 fb ff ff       	call   8003aa <getuint>
  8007c3:	83 c4 10             	add    $0x10,%esp
  8007c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007cc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007d3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007da:	83 ec 04             	sub    $0x4,%esp
  8007dd:	52                   	push   %edx
  8007de:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007e1:	50                   	push   %eax
  8007e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e5:	ff 75 f0             	pushl  -0x10(%ebp)
  8007e8:	ff 75 0c             	pushl  0xc(%ebp)
  8007eb:	ff 75 08             	pushl  0x8(%ebp)
  8007ee:	e8 00 fb ff ff       	call   8002f3 <printnum>
  8007f3:	83 c4 20             	add    $0x20,%esp
			break;
  8007f6:	eb 34                	jmp    80082c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007f8:	83 ec 08             	sub    $0x8,%esp
  8007fb:	ff 75 0c             	pushl  0xc(%ebp)
  8007fe:	53                   	push   %ebx
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	ff d0                	call   *%eax
  800804:	83 c4 10             	add    $0x10,%esp
			break;
  800807:	eb 23                	jmp    80082c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800809:	83 ec 08             	sub    $0x8,%esp
  80080c:	ff 75 0c             	pushl  0xc(%ebp)
  80080f:	6a 25                	push   $0x25
  800811:	8b 45 08             	mov    0x8(%ebp),%eax
  800814:	ff d0                	call   *%eax
  800816:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800819:	ff 4d 10             	decl   0x10(%ebp)
  80081c:	eb 03                	jmp    800821 <vprintfmt+0x3b1>
  80081e:	ff 4d 10             	decl   0x10(%ebp)
  800821:	8b 45 10             	mov    0x10(%ebp),%eax
  800824:	48                   	dec    %eax
  800825:	8a 00                	mov    (%eax),%al
  800827:	3c 25                	cmp    $0x25,%al
  800829:	75 f3                	jne    80081e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80082b:	90                   	nop
		}
	}
  80082c:	e9 47 fc ff ff       	jmp    800478 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800831:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800832:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800835:	5b                   	pop    %ebx
  800836:	5e                   	pop    %esi
  800837:	5d                   	pop    %ebp
  800838:	c3                   	ret    

00800839 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800839:	55                   	push   %ebp
  80083a:	89 e5                	mov    %esp,%ebp
  80083c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80083f:	8d 45 10             	lea    0x10(%ebp),%eax
  800842:	83 c0 04             	add    $0x4,%eax
  800845:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800848:	8b 45 10             	mov    0x10(%ebp),%eax
  80084b:	ff 75 f4             	pushl  -0xc(%ebp)
  80084e:	50                   	push   %eax
  80084f:	ff 75 0c             	pushl  0xc(%ebp)
  800852:	ff 75 08             	pushl  0x8(%ebp)
  800855:	e8 16 fc ff ff       	call   800470 <vprintfmt>
  80085a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80085d:	90                   	nop
  80085e:	c9                   	leave  
  80085f:	c3                   	ret    

00800860 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800860:	55                   	push   %ebp
  800861:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800863:	8b 45 0c             	mov    0xc(%ebp),%eax
  800866:	8b 40 08             	mov    0x8(%eax),%eax
  800869:	8d 50 01             	lea    0x1(%eax),%edx
  80086c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800872:	8b 45 0c             	mov    0xc(%ebp),%eax
  800875:	8b 10                	mov    (%eax),%edx
  800877:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087a:	8b 40 04             	mov    0x4(%eax),%eax
  80087d:	39 c2                	cmp    %eax,%edx
  80087f:	73 12                	jae    800893 <sprintputch+0x33>
		*b->buf++ = ch;
  800881:	8b 45 0c             	mov    0xc(%ebp),%eax
  800884:	8b 00                	mov    (%eax),%eax
  800886:	8d 48 01             	lea    0x1(%eax),%ecx
  800889:	8b 55 0c             	mov    0xc(%ebp),%edx
  80088c:	89 0a                	mov    %ecx,(%edx)
  80088e:	8b 55 08             	mov    0x8(%ebp),%edx
  800891:	88 10                	mov    %dl,(%eax)
}
  800893:	90                   	nop
  800894:	5d                   	pop    %ebp
  800895:	c3                   	ret    

00800896 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800896:	55                   	push   %ebp
  800897:	89 e5                	mov    %esp,%ebp
  800899:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80089c:	8b 45 08             	mov    0x8(%ebp),%eax
  80089f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	01 d0                	add    %edx,%eax
  8008ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008bb:	74 06                	je     8008c3 <vsnprintf+0x2d>
  8008bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008c1:	7f 07                	jg     8008ca <vsnprintf+0x34>
		return -E_INVAL;
  8008c3:	b8 03 00 00 00       	mov    $0x3,%eax
  8008c8:	eb 20                	jmp    8008ea <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ca:	ff 75 14             	pushl  0x14(%ebp)
  8008cd:	ff 75 10             	pushl  0x10(%ebp)
  8008d0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008d3:	50                   	push   %eax
  8008d4:	68 60 08 80 00       	push   $0x800860
  8008d9:	e8 92 fb ff ff       	call   800470 <vprintfmt>
  8008de:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008e4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008ea:	c9                   	leave  
  8008eb:	c3                   	ret    

008008ec <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008ec:	55                   	push   %ebp
  8008ed:	89 e5                	mov    %esp,%ebp
  8008ef:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008f2:	8d 45 10             	lea    0x10(%ebp),%eax
  8008f5:	83 c0 04             	add    $0x4,%eax
  8008f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8008fe:	ff 75 f4             	pushl  -0xc(%ebp)
  800901:	50                   	push   %eax
  800902:	ff 75 0c             	pushl  0xc(%ebp)
  800905:	ff 75 08             	pushl  0x8(%ebp)
  800908:	e8 89 ff ff ff       	call   800896 <vsnprintf>
  80090d:	83 c4 10             	add    $0x10,%esp
  800910:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800913:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800916:	c9                   	leave  
  800917:	c3                   	ret    

00800918 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800918:	55                   	push   %ebp
  800919:	89 e5                	mov    %esp,%ebp
  80091b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80091e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800925:	eb 06                	jmp    80092d <strlen+0x15>
		n++;
  800927:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80092a:	ff 45 08             	incl   0x8(%ebp)
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	8a 00                	mov    (%eax),%al
  800932:	84 c0                	test   %al,%al
  800934:	75 f1                	jne    800927 <strlen+0xf>
		n++;
	return n;
  800936:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800939:	c9                   	leave  
  80093a:	c3                   	ret    

0080093b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80093b:	55                   	push   %ebp
  80093c:	89 e5                	mov    %esp,%ebp
  80093e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800941:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800948:	eb 09                	jmp    800953 <strnlen+0x18>
		n++;
  80094a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80094d:	ff 45 08             	incl   0x8(%ebp)
  800950:	ff 4d 0c             	decl   0xc(%ebp)
  800953:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800957:	74 09                	je     800962 <strnlen+0x27>
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	8a 00                	mov    (%eax),%al
  80095e:	84 c0                	test   %al,%al
  800960:	75 e8                	jne    80094a <strnlen+0xf>
		n++;
	return n;
  800962:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800965:	c9                   	leave  
  800966:	c3                   	ret    

00800967 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800967:	55                   	push   %ebp
  800968:	89 e5                	mov    %esp,%ebp
  80096a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80096d:	8b 45 08             	mov    0x8(%ebp),%eax
  800970:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800973:	90                   	nop
  800974:	8b 45 08             	mov    0x8(%ebp),%eax
  800977:	8d 50 01             	lea    0x1(%eax),%edx
  80097a:	89 55 08             	mov    %edx,0x8(%ebp)
  80097d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800980:	8d 4a 01             	lea    0x1(%edx),%ecx
  800983:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800986:	8a 12                	mov    (%edx),%dl
  800988:	88 10                	mov    %dl,(%eax)
  80098a:	8a 00                	mov    (%eax),%al
  80098c:	84 c0                	test   %al,%al
  80098e:	75 e4                	jne    800974 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800990:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800993:	c9                   	leave  
  800994:	c3                   	ret    

00800995 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800995:	55                   	push   %ebp
  800996:	89 e5                	mov    %esp,%ebp
  800998:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80099b:	8b 45 08             	mov    0x8(%ebp),%eax
  80099e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009a8:	eb 1f                	jmp    8009c9 <strncpy+0x34>
		*dst++ = *src;
  8009aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ad:	8d 50 01             	lea    0x1(%eax),%edx
  8009b0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b6:	8a 12                	mov    (%edx),%dl
  8009b8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bd:	8a 00                	mov    (%eax),%al
  8009bf:	84 c0                	test   %al,%al
  8009c1:	74 03                	je     8009c6 <strncpy+0x31>
			src++;
  8009c3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009c6:	ff 45 fc             	incl   -0x4(%ebp)
  8009c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009cc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009cf:	72 d9                	jb     8009aa <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009d4:	c9                   	leave  
  8009d5:	c3                   	ret    

008009d6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009d6:	55                   	push   %ebp
  8009d7:	89 e5                	mov    %esp,%ebp
  8009d9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009e6:	74 30                	je     800a18 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009e8:	eb 16                	jmp    800a00 <strlcpy+0x2a>
			*dst++ = *src++;
  8009ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ed:	8d 50 01             	lea    0x1(%eax),%edx
  8009f0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009f9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009fc:	8a 12                	mov    (%edx),%dl
  8009fe:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a00:	ff 4d 10             	decl   0x10(%ebp)
  800a03:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a07:	74 09                	je     800a12 <strlcpy+0x3c>
  800a09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0c:	8a 00                	mov    (%eax),%al
  800a0e:	84 c0                	test   %al,%al
  800a10:	75 d8                	jne    8009ea <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a12:	8b 45 08             	mov    0x8(%ebp),%eax
  800a15:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a18:	8b 55 08             	mov    0x8(%ebp),%edx
  800a1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a1e:	29 c2                	sub    %eax,%edx
  800a20:	89 d0                	mov    %edx,%eax
}
  800a22:	c9                   	leave  
  800a23:	c3                   	ret    

00800a24 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a24:	55                   	push   %ebp
  800a25:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a27:	eb 06                	jmp    800a2f <strcmp+0xb>
		p++, q++;
  800a29:	ff 45 08             	incl   0x8(%ebp)
  800a2c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a32:	8a 00                	mov    (%eax),%al
  800a34:	84 c0                	test   %al,%al
  800a36:	74 0e                	je     800a46 <strcmp+0x22>
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	8a 10                	mov    (%eax),%dl
  800a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a40:	8a 00                	mov    (%eax),%al
  800a42:	38 c2                	cmp    %al,%dl
  800a44:	74 e3                	je     800a29 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	8a 00                	mov    (%eax),%al
  800a4b:	0f b6 d0             	movzbl %al,%edx
  800a4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a51:	8a 00                	mov    (%eax),%al
  800a53:	0f b6 c0             	movzbl %al,%eax
  800a56:	29 c2                	sub    %eax,%edx
  800a58:	89 d0                	mov    %edx,%eax
}
  800a5a:	5d                   	pop    %ebp
  800a5b:	c3                   	ret    

00800a5c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a5c:	55                   	push   %ebp
  800a5d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a5f:	eb 09                	jmp    800a6a <strncmp+0xe>
		n--, p++, q++;
  800a61:	ff 4d 10             	decl   0x10(%ebp)
  800a64:	ff 45 08             	incl   0x8(%ebp)
  800a67:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6e:	74 17                	je     800a87 <strncmp+0x2b>
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	8a 00                	mov    (%eax),%al
  800a75:	84 c0                	test   %al,%al
  800a77:	74 0e                	je     800a87 <strncmp+0x2b>
  800a79:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7c:	8a 10                	mov    (%eax),%dl
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	8a 00                	mov    (%eax),%al
  800a83:	38 c2                	cmp    %al,%dl
  800a85:	74 da                	je     800a61 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a8b:	75 07                	jne    800a94 <strncmp+0x38>
		return 0;
  800a8d:	b8 00 00 00 00       	mov    $0x0,%eax
  800a92:	eb 14                	jmp    800aa8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	0f b6 d0             	movzbl %al,%edx
  800a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9f:	8a 00                	mov    (%eax),%al
  800aa1:	0f b6 c0             	movzbl %al,%eax
  800aa4:	29 c2                	sub    %eax,%edx
  800aa6:	89 d0                	mov    %edx,%eax
}
  800aa8:	5d                   	pop    %ebp
  800aa9:	c3                   	ret    

00800aaa <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aaa:	55                   	push   %ebp
  800aab:	89 e5                	mov    %esp,%ebp
  800aad:	83 ec 04             	sub    $0x4,%esp
  800ab0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ab6:	eb 12                	jmp    800aca <strchr+0x20>
		if (*s == c)
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  800abb:	8a 00                	mov    (%eax),%al
  800abd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ac0:	75 05                	jne    800ac7 <strchr+0x1d>
			return (char *) s;
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	eb 11                	jmp    800ad8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ac7:	ff 45 08             	incl   0x8(%ebp)
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8a 00                	mov    (%eax),%al
  800acf:	84 c0                	test   %al,%al
  800ad1:	75 e5                	jne    800ab8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ad3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ad8:	c9                   	leave  
  800ad9:	c3                   	ret    

00800ada <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ada:	55                   	push   %ebp
  800adb:	89 e5                	mov    %esp,%ebp
  800add:	83 ec 04             	sub    $0x4,%esp
  800ae0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ae6:	eb 0d                	jmp    800af5 <strfind+0x1b>
		if (*s == c)
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8a 00                	mov    (%eax),%al
  800aed:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800af0:	74 0e                	je     800b00 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800af2:	ff 45 08             	incl   0x8(%ebp)
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8a 00                	mov    (%eax),%al
  800afa:	84 c0                	test   %al,%al
  800afc:	75 ea                	jne    800ae8 <strfind+0xe>
  800afe:	eb 01                	jmp    800b01 <strfind+0x27>
		if (*s == c)
			break;
  800b00:	90                   	nop
	return (char *) s;
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b04:	c9                   	leave  
  800b05:	c3                   	ret    

00800b06 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b06:	55                   	push   %ebp
  800b07:	89 e5                	mov    %esp,%ebp
  800b09:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b12:	8b 45 10             	mov    0x10(%ebp),%eax
  800b15:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b18:	eb 0e                	jmp    800b28 <memset+0x22>
		*p++ = c;
  800b1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b1d:	8d 50 01             	lea    0x1(%eax),%edx
  800b20:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b23:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b26:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b28:	ff 4d f8             	decl   -0x8(%ebp)
  800b2b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b2f:	79 e9                	jns    800b1a <memset+0x14>
		*p++ = c;

	return v;
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b34:	c9                   	leave  
  800b35:	c3                   	ret    

00800b36 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b36:	55                   	push   %ebp
  800b37:	89 e5                	mov    %esp,%ebp
  800b39:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b48:	eb 16                	jmp    800b60 <memcpy+0x2a>
		*d++ = *s++;
  800b4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b4d:	8d 50 01             	lea    0x1(%eax),%edx
  800b50:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b53:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b56:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b59:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b5c:	8a 12                	mov    (%edx),%dl
  800b5e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b60:	8b 45 10             	mov    0x10(%ebp),%eax
  800b63:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b66:	89 55 10             	mov    %edx,0x10(%ebp)
  800b69:	85 c0                	test   %eax,%eax
  800b6b:	75 dd                	jne    800b4a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b70:	c9                   	leave  
  800b71:	c3                   	ret    

00800b72 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b72:	55                   	push   %ebp
  800b73:	89 e5                	mov    %esp,%ebp
  800b75:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b87:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b8a:	73 50                	jae    800bdc <memmove+0x6a>
  800b8c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b92:	01 d0                	add    %edx,%eax
  800b94:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b97:	76 43                	jbe    800bdc <memmove+0x6a>
		s += n;
  800b99:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ba5:	eb 10                	jmp    800bb7 <memmove+0x45>
			*--d = *--s;
  800ba7:	ff 4d f8             	decl   -0x8(%ebp)
  800baa:	ff 4d fc             	decl   -0x4(%ebp)
  800bad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb0:	8a 10                	mov    (%eax),%dl
  800bb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bb7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bba:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bbd:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc0:	85 c0                	test   %eax,%eax
  800bc2:	75 e3                	jne    800ba7 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bc4:	eb 23                	jmp    800be9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc9:	8d 50 01             	lea    0x1(%eax),%edx
  800bcc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bcf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bd2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bd5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bd8:	8a 12                	mov    (%edx),%dl
  800bda:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be2:	89 55 10             	mov    %edx,0x10(%ebp)
  800be5:	85 c0                	test   %eax,%eax
  800be7:	75 dd                	jne    800bc6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bec:	c9                   	leave  
  800bed:	c3                   	ret    

00800bee <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bee:	55                   	push   %ebp
  800bef:	89 e5                	mov    %esp,%ebp
  800bf1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfd:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c00:	eb 2a                	jmp    800c2c <memcmp+0x3e>
		if (*s1 != *s2)
  800c02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c05:	8a 10                	mov    (%eax),%dl
  800c07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	38 c2                	cmp    %al,%dl
  800c0e:	74 16                	je     800c26 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	0f b6 d0             	movzbl %al,%edx
  800c18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c1b:	8a 00                	mov    (%eax),%al
  800c1d:	0f b6 c0             	movzbl %al,%eax
  800c20:	29 c2                	sub    %eax,%edx
  800c22:	89 d0                	mov    %edx,%eax
  800c24:	eb 18                	jmp    800c3e <memcmp+0x50>
		s1++, s2++;
  800c26:	ff 45 fc             	incl   -0x4(%ebp)
  800c29:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c32:	89 55 10             	mov    %edx,0x10(%ebp)
  800c35:	85 c0                	test   %eax,%eax
  800c37:	75 c9                	jne    800c02 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c39:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c3e:	c9                   	leave  
  800c3f:	c3                   	ret    

00800c40 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c40:	55                   	push   %ebp
  800c41:	89 e5                	mov    %esp,%ebp
  800c43:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c46:	8b 55 08             	mov    0x8(%ebp),%edx
  800c49:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4c:	01 d0                	add    %edx,%eax
  800c4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c51:	eb 15                	jmp    800c68 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	8a 00                	mov    (%eax),%al
  800c58:	0f b6 d0             	movzbl %al,%edx
  800c5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5e:	0f b6 c0             	movzbl %al,%eax
  800c61:	39 c2                	cmp    %eax,%edx
  800c63:	74 0d                	je     800c72 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c65:	ff 45 08             	incl   0x8(%ebp)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c6e:	72 e3                	jb     800c53 <memfind+0x13>
  800c70:	eb 01                	jmp    800c73 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c72:	90                   	nop
	return (void *) s;
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c76:	c9                   	leave  
  800c77:	c3                   	ret    

00800c78 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c78:	55                   	push   %ebp
  800c79:	89 e5                	mov    %esp,%ebp
  800c7b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c7e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c85:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c8c:	eb 03                	jmp    800c91 <strtol+0x19>
		s++;
  800c8e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8a 00                	mov    (%eax),%al
  800c96:	3c 20                	cmp    $0x20,%al
  800c98:	74 f4                	je     800c8e <strtol+0x16>
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8a 00                	mov    (%eax),%al
  800c9f:	3c 09                	cmp    $0x9,%al
  800ca1:	74 eb                	je     800c8e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	3c 2b                	cmp    $0x2b,%al
  800caa:	75 05                	jne    800cb1 <strtol+0x39>
		s++;
  800cac:	ff 45 08             	incl   0x8(%ebp)
  800caf:	eb 13                	jmp    800cc4 <strtol+0x4c>
	else if (*s == '-')
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	8a 00                	mov    (%eax),%al
  800cb6:	3c 2d                	cmp    $0x2d,%al
  800cb8:	75 0a                	jne    800cc4 <strtol+0x4c>
		s++, neg = 1;
  800cba:	ff 45 08             	incl   0x8(%ebp)
  800cbd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cc4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc8:	74 06                	je     800cd0 <strtol+0x58>
  800cca:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cce:	75 20                	jne    800cf0 <strtol+0x78>
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	8a 00                	mov    (%eax),%al
  800cd5:	3c 30                	cmp    $0x30,%al
  800cd7:	75 17                	jne    800cf0 <strtol+0x78>
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	40                   	inc    %eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	3c 78                	cmp    $0x78,%al
  800ce1:	75 0d                	jne    800cf0 <strtol+0x78>
		s += 2, base = 16;
  800ce3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ce7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cee:	eb 28                	jmp    800d18 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cf0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf4:	75 15                	jne    800d0b <strtol+0x93>
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	8a 00                	mov    (%eax),%al
  800cfb:	3c 30                	cmp    $0x30,%al
  800cfd:	75 0c                	jne    800d0b <strtol+0x93>
		s++, base = 8;
  800cff:	ff 45 08             	incl   0x8(%ebp)
  800d02:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d09:	eb 0d                	jmp    800d18 <strtol+0xa0>
	else if (base == 0)
  800d0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0f:	75 07                	jne    800d18 <strtol+0xa0>
		base = 10;
  800d11:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8a 00                	mov    (%eax),%al
  800d1d:	3c 2f                	cmp    $0x2f,%al
  800d1f:	7e 19                	jle    800d3a <strtol+0xc2>
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	3c 39                	cmp    $0x39,%al
  800d28:	7f 10                	jg     800d3a <strtol+0xc2>
			dig = *s - '0';
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	0f be c0             	movsbl %al,%eax
  800d32:	83 e8 30             	sub    $0x30,%eax
  800d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d38:	eb 42                	jmp    800d7c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	3c 60                	cmp    $0x60,%al
  800d41:	7e 19                	jle    800d5c <strtol+0xe4>
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	3c 7a                	cmp    $0x7a,%al
  800d4a:	7f 10                	jg     800d5c <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	0f be c0             	movsbl %al,%eax
  800d54:	83 e8 57             	sub    $0x57,%eax
  800d57:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d5a:	eb 20                	jmp    800d7c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	3c 40                	cmp    $0x40,%al
  800d63:	7e 39                	jle    800d9e <strtol+0x126>
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	8a 00                	mov    (%eax),%al
  800d6a:	3c 5a                	cmp    $0x5a,%al
  800d6c:	7f 30                	jg     800d9e <strtol+0x126>
			dig = *s - 'A' + 10;
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	0f be c0             	movsbl %al,%eax
  800d76:	83 e8 37             	sub    $0x37,%eax
  800d79:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d7f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d82:	7d 19                	jge    800d9d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d84:	ff 45 08             	incl   0x8(%ebp)
  800d87:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8a:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d8e:	89 c2                	mov    %eax,%edx
  800d90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d93:	01 d0                	add    %edx,%eax
  800d95:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d98:	e9 7b ff ff ff       	jmp    800d18 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d9d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d9e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da2:	74 08                	je     800dac <strtol+0x134>
		*endptr = (char *) s;
  800da4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da7:	8b 55 08             	mov    0x8(%ebp),%edx
  800daa:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dac:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800db0:	74 07                	je     800db9 <strtol+0x141>
  800db2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db5:	f7 d8                	neg    %eax
  800db7:	eb 03                	jmp    800dbc <strtol+0x144>
  800db9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dbc:	c9                   	leave  
  800dbd:	c3                   	ret    

00800dbe <ltostr>:

void
ltostr(long value, char *str)
{
  800dbe:	55                   	push   %ebp
  800dbf:	89 e5                	mov    %esp,%ebp
  800dc1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dc4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dcb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dd2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dd6:	79 13                	jns    800deb <ltostr+0x2d>
	{
		neg = 1;
  800dd8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800de5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800de8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800df3:	99                   	cltd   
  800df4:	f7 f9                	idiv   %ecx
  800df6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800df9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dfc:	8d 50 01             	lea    0x1(%eax),%edx
  800dff:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e02:	89 c2                	mov    %eax,%edx
  800e04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e07:	01 d0                	add    %edx,%eax
  800e09:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e0c:	83 c2 30             	add    $0x30,%edx
  800e0f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e11:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e14:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e19:	f7 e9                	imul   %ecx
  800e1b:	c1 fa 02             	sar    $0x2,%edx
  800e1e:	89 c8                	mov    %ecx,%eax
  800e20:	c1 f8 1f             	sar    $0x1f,%eax
  800e23:	29 c2                	sub    %eax,%edx
  800e25:	89 d0                	mov    %edx,%eax
  800e27:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e2a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e2d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e32:	f7 e9                	imul   %ecx
  800e34:	c1 fa 02             	sar    $0x2,%edx
  800e37:	89 c8                	mov    %ecx,%eax
  800e39:	c1 f8 1f             	sar    $0x1f,%eax
  800e3c:	29 c2                	sub    %eax,%edx
  800e3e:	89 d0                	mov    %edx,%eax
  800e40:	c1 e0 02             	shl    $0x2,%eax
  800e43:	01 d0                	add    %edx,%eax
  800e45:	01 c0                	add    %eax,%eax
  800e47:	29 c1                	sub    %eax,%ecx
  800e49:	89 ca                	mov    %ecx,%edx
  800e4b:	85 d2                	test   %edx,%edx
  800e4d:	75 9c                	jne    800deb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e4f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e59:	48                   	dec    %eax
  800e5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e5d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e61:	74 3d                	je     800ea0 <ltostr+0xe2>
		start = 1 ;
  800e63:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e6a:	eb 34                	jmp    800ea0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e72:	01 d0                	add    %edx,%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e79:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7f:	01 c2                	add    %eax,%edx
  800e81:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e87:	01 c8                	add    %ecx,%eax
  800e89:	8a 00                	mov    (%eax),%al
  800e8b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e8d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e93:	01 c2                	add    %eax,%edx
  800e95:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e98:	88 02                	mov    %al,(%edx)
		start++ ;
  800e9a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e9d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ea0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ea3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ea6:	7c c4                	jl     800e6c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ea8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800eab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eae:	01 d0                	add    %edx,%eax
  800eb0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eb3:	90                   	nop
  800eb4:	c9                   	leave  
  800eb5:	c3                   	ret    

00800eb6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800eb6:	55                   	push   %ebp
  800eb7:	89 e5                	mov    %esp,%ebp
  800eb9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ebc:	ff 75 08             	pushl  0x8(%ebp)
  800ebf:	e8 54 fa ff ff       	call   800918 <strlen>
  800ec4:	83 c4 04             	add    $0x4,%esp
  800ec7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eca:	ff 75 0c             	pushl  0xc(%ebp)
  800ecd:	e8 46 fa ff ff       	call   800918 <strlen>
  800ed2:	83 c4 04             	add    $0x4,%esp
  800ed5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ed8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800edf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee6:	eb 17                	jmp    800eff <strcconcat+0x49>
		final[s] = str1[s] ;
  800ee8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eeb:	8b 45 10             	mov    0x10(%ebp),%eax
  800eee:	01 c2                	add    %eax,%edx
  800ef0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	01 c8                	add    %ecx,%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800efc:	ff 45 fc             	incl   -0x4(%ebp)
  800eff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f02:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f05:	7c e1                	jl     800ee8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f07:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f0e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f15:	eb 1f                	jmp    800f36 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1a:	8d 50 01             	lea    0x1(%eax),%edx
  800f1d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f20:	89 c2                	mov    %eax,%edx
  800f22:	8b 45 10             	mov    0x10(%ebp),%eax
  800f25:	01 c2                	add    %eax,%edx
  800f27:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2d:	01 c8                	add    %ecx,%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f33:	ff 45 f8             	incl   -0x8(%ebp)
  800f36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f39:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f3c:	7c d9                	jl     800f17 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f3e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f41:	8b 45 10             	mov    0x10(%ebp),%eax
  800f44:	01 d0                	add    %edx,%eax
  800f46:	c6 00 00             	movb   $0x0,(%eax)
}
  800f49:	90                   	nop
  800f4a:	c9                   	leave  
  800f4b:	c3                   	ret    

00800f4c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f4c:	55                   	push   %ebp
  800f4d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f58:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5b:	8b 00                	mov    (%eax),%eax
  800f5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f64:	8b 45 10             	mov    0x10(%ebp),%eax
  800f67:	01 d0                	add    %edx,%eax
  800f69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f6f:	eb 0c                	jmp    800f7d <strsplit+0x31>
			*string++ = 0;
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8d 50 01             	lea    0x1(%eax),%edx
  800f77:	89 55 08             	mov    %edx,0x8(%ebp)
  800f7a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	84 c0                	test   %al,%al
  800f84:	74 18                	je     800f9e <strsplit+0x52>
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	0f be c0             	movsbl %al,%eax
  800f8e:	50                   	push   %eax
  800f8f:	ff 75 0c             	pushl  0xc(%ebp)
  800f92:	e8 13 fb ff ff       	call   800aaa <strchr>
  800f97:	83 c4 08             	add    $0x8,%esp
  800f9a:	85 c0                	test   %eax,%eax
  800f9c:	75 d3                	jne    800f71 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	8a 00                	mov    (%eax),%al
  800fa3:	84 c0                	test   %al,%al
  800fa5:	74 5a                	je     801001 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800fa7:	8b 45 14             	mov    0x14(%ebp),%eax
  800faa:	8b 00                	mov    (%eax),%eax
  800fac:	83 f8 0f             	cmp    $0xf,%eax
  800faf:	75 07                	jne    800fb8 <strsplit+0x6c>
		{
			return 0;
  800fb1:	b8 00 00 00 00       	mov    $0x0,%eax
  800fb6:	eb 66                	jmp    80101e <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fb8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbb:	8b 00                	mov    (%eax),%eax
  800fbd:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc0:	8b 55 14             	mov    0x14(%ebp),%edx
  800fc3:	89 0a                	mov    %ecx,(%edx)
  800fc5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcf:	01 c2                	add    %eax,%edx
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fd6:	eb 03                	jmp    800fdb <strsplit+0x8f>
			string++;
  800fd8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	8a 00                	mov    (%eax),%al
  800fe0:	84 c0                	test   %al,%al
  800fe2:	74 8b                	je     800f6f <strsplit+0x23>
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	0f be c0             	movsbl %al,%eax
  800fec:	50                   	push   %eax
  800fed:	ff 75 0c             	pushl  0xc(%ebp)
  800ff0:	e8 b5 fa ff ff       	call   800aaa <strchr>
  800ff5:	83 c4 08             	add    $0x8,%esp
  800ff8:	85 c0                	test   %eax,%eax
  800ffa:	74 dc                	je     800fd8 <strsplit+0x8c>
			string++;
	}
  800ffc:	e9 6e ff ff ff       	jmp    800f6f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801001:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801002:	8b 45 14             	mov    0x14(%ebp),%eax
  801005:	8b 00                	mov    (%eax),%eax
  801007:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80100e:	8b 45 10             	mov    0x10(%ebp),%eax
  801011:	01 d0                	add    %edx,%eax
  801013:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801019:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80101e:	c9                   	leave  
  80101f:	c3                   	ret    

00801020 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801020:	55                   	push   %ebp
  801021:	89 e5                	mov    %esp,%ebp
  801023:	57                   	push   %edi
  801024:	56                   	push   %esi
  801025:	53                   	push   %ebx
  801026:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80102f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801032:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801035:	8b 7d 18             	mov    0x18(%ebp),%edi
  801038:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80103b:	cd 30                	int    $0x30
  80103d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801040:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801043:	83 c4 10             	add    $0x10,%esp
  801046:	5b                   	pop    %ebx
  801047:	5e                   	pop    %esi
  801048:	5f                   	pop    %edi
  801049:	5d                   	pop    %ebp
  80104a:	c3                   	ret    

0080104b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80104b:	55                   	push   %ebp
  80104c:	89 e5                	mov    %esp,%ebp
  80104e:	83 ec 04             	sub    $0x4,%esp
  801051:	8b 45 10             	mov    0x10(%ebp),%eax
  801054:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801057:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	6a 00                	push   $0x0
  801060:	6a 00                	push   $0x0
  801062:	52                   	push   %edx
  801063:	ff 75 0c             	pushl  0xc(%ebp)
  801066:	50                   	push   %eax
  801067:	6a 00                	push   $0x0
  801069:	e8 b2 ff ff ff       	call   801020 <syscall>
  80106e:	83 c4 18             	add    $0x18,%esp
}
  801071:	90                   	nop
  801072:	c9                   	leave  
  801073:	c3                   	ret    

00801074 <sys_cgetc>:

int
sys_cgetc(void)
{
  801074:	55                   	push   %ebp
  801075:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801077:	6a 00                	push   $0x0
  801079:	6a 00                	push   $0x0
  80107b:	6a 00                	push   $0x0
  80107d:	6a 00                	push   $0x0
  80107f:	6a 00                	push   $0x0
  801081:	6a 01                	push   $0x1
  801083:	e8 98 ff ff ff       	call   801020 <syscall>
  801088:	83 c4 18             	add    $0x18,%esp
}
  80108b:	c9                   	leave  
  80108c:	c3                   	ret    

0080108d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80108d:	55                   	push   %ebp
  80108e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	6a 00                	push   $0x0
  801095:	6a 00                	push   $0x0
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	50                   	push   %eax
  80109c:	6a 05                	push   $0x5
  80109e:	e8 7d ff ff ff       	call   801020 <syscall>
  8010a3:	83 c4 18             	add    $0x18,%esp
}
  8010a6:	c9                   	leave  
  8010a7:	c3                   	ret    

008010a8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010a8:	55                   	push   %ebp
  8010a9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010ab:	6a 00                	push   $0x0
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 00                	push   $0x0
  8010b3:	6a 00                	push   $0x0
  8010b5:	6a 02                	push   $0x2
  8010b7:	e8 64 ff ff ff       	call   801020 <syscall>
  8010bc:	83 c4 18             	add    $0x18,%esp
}
  8010bf:	c9                   	leave  
  8010c0:	c3                   	ret    

008010c1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010c1:	55                   	push   %ebp
  8010c2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 00                	push   $0x0
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 03                	push   $0x3
  8010d0:	e8 4b ff ff ff       	call   801020 <syscall>
  8010d5:	83 c4 18             	add    $0x18,%esp
}
  8010d8:	c9                   	leave  
  8010d9:	c3                   	ret    

008010da <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010da:	55                   	push   %ebp
  8010db:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 00                	push   $0x0
  8010e1:	6a 00                	push   $0x0
  8010e3:	6a 00                	push   $0x0
  8010e5:	6a 00                	push   $0x0
  8010e7:	6a 04                	push   $0x4
  8010e9:	e8 32 ff ff ff       	call   801020 <syscall>
  8010ee:	83 c4 18             	add    $0x18,%esp
}
  8010f1:	c9                   	leave  
  8010f2:	c3                   	ret    

008010f3 <sys_env_exit>:


void sys_env_exit(void)
{
  8010f3:	55                   	push   %ebp
  8010f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010f6:	6a 00                	push   $0x0
  8010f8:	6a 00                	push   $0x0
  8010fa:	6a 00                	push   $0x0
  8010fc:	6a 00                	push   $0x0
  8010fe:	6a 00                	push   $0x0
  801100:	6a 06                	push   $0x6
  801102:	e8 19 ff ff ff       	call   801020 <syscall>
  801107:	83 c4 18             	add    $0x18,%esp
}
  80110a:	90                   	nop
  80110b:	c9                   	leave  
  80110c:	c3                   	ret    

0080110d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80110d:	55                   	push   %ebp
  80110e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801110:	8b 55 0c             	mov    0xc(%ebp),%edx
  801113:	8b 45 08             	mov    0x8(%ebp),%eax
  801116:	6a 00                	push   $0x0
  801118:	6a 00                	push   $0x0
  80111a:	6a 00                	push   $0x0
  80111c:	52                   	push   %edx
  80111d:	50                   	push   %eax
  80111e:	6a 07                	push   $0x7
  801120:	e8 fb fe ff ff       	call   801020 <syscall>
  801125:	83 c4 18             	add    $0x18,%esp
}
  801128:	c9                   	leave  
  801129:	c3                   	ret    

0080112a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
  80112d:	56                   	push   %esi
  80112e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80112f:	8b 75 18             	mov    0x18(%ebp),%esi
  801132:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801135:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801138:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	56                   	push   %esi
  80113f:	53                   	push   %ebx
  801140:	51                   	push   %ecx
  801141:	52                   	push   %edx
  801142:	50                   	push   %eax
  801143:	6a 08                	push   $0x8
  801145:	e8 d6 fe ff ff       	call   801020 <syscall>
  80114a:	83 c4 18             	add    $0x18,%esp
}
  80114d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801150:	5b                   	pop    %ebx
  801151:	5e                   	pop    %esi
  801152:	5d                   	pop    %ebp
  801153:	c3                   	ret    

00801154 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801157:	8b 55 0c             	mov    0xc(%ebp),%edx
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	6a 00                	push   $0x0
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	52                   	push   %edx
  801164:	50                   	push   %eax
  801165:	6a 09                	push   $0x9
  801167:	e8 b4 fe ff ff       	call   801020 <syscall>
  80116c:	83 c4 18             	add    $0x18,%esp
}
  80116f:	c9                   	leave  
  801170:	c3                   	ret    

00801171 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801171:	55                   	push   %ebp
  801172:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801174:	6a 00                	push   $0x0
  801176:	6a 00                	push   $0x0
  801178:	6a 00                	push   $0x0
  80117a:	ff 75 0c             	pushl  0xc(%ebp)
  80117d:	ff 75 08             	pushl  0x8(%ebp)
  801180:	6a 0a                	push   $0xa
  801182:	e8 99 fe ff ff       	call   801020 <syscall>
  801187:	83 c4 18             	add    $0x18,%esp
}
  80118a:	c9                   	leave  
  80118b:	c3                   	ret    

0080118c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80118c:	55                   	push   %ebp
  80118d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 00                	push   $0x0
  801197:	6a 00                	push   $0x0
  801199:	6a 0b                	push   $0xb
  80119b:	e8 80 fe ff ff       	call   801020 <syscall>
  8011a0:	83 c4 18             	add    $0x18,%esp
}
  8011a3:	c9                   	leave  
  8011a4:	c3                   	ret    

008011a5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011a5:	55                   	push   %ebp
  8011a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 00                	push   $0x0
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 0c                	push   $0xc
  8011b4:	e8 67 fe ff ff       	call   801020 <syscall>
  8011b9:	83 c4 18             	add    $0x18,%esp
}
  8011bc:	c9                   	leave  
  8011bd:	c3                   	ret    

008011be <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011be:	55                   	push   %ebp
  8011bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 00                	push   $0x0
  8011c9:	6a 00                	push   $0x0
  8011cb:	6a 0d                	push   $0xd
  8011cd:	e8 4e fe ff ff       	call   801020 <syscall>
  8011d2:	83 c4 18             	add    $0x18,%esp
}
  8011d5:	c9                   	leave  
  8011d6:	c3                   	ret    

008011d7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011d7:	55                   	push   %ebp
  8011d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 00                	push   $0x0
  8011de:	6a 00                	push   $0x0
  8011e0:	ff 75 0c             	pushl  0xc(%ebp)
  8011e3:	ff 75 08             	pushl  0x8(%ebp)
  8011e6:	6a 11                	push   $0x11
  8011e8:	e8 33 fe ff ff       	call   801020 <syscall>
  8011ed:	83 c4 18             	add    $0x18,%esp
	return;
  8011f0:	90                   	nop
}
  8011f1:	c9                   	leave  
  8011f2:	c3                   	ret    

008011f3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011f3:	55                   	push   %ebp
  8011f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 00                	push   $0x0
  8011fc:	ff 75 0c             	pushl  0xc(%ebp)
  8011ff:	ff 75 08             	pushl  0x8(%ebp)
  801202:	6a 12                	push   $0x12
  801204:	e8 17 fe ff ff       	call   801020 <syscall>
  801209:	83 c4 18             	add    $0x18,%esp
	return ;
  80120c:	90                   	nop
}
  80120d:	c9                   	leave  
  80120e:	c3                   	ret    

0080120f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80120f:	55                   	push   %ebp
  801210:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801212:	6a 00                	push   $0x0
  801214:	6a 00                	push   $0x0
  801216:	6a 00                	push   $0x0
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	6a 0e                	push   $0xe
  80121e:	e8 fd fd ff ff       	call   801020 <syscall>
  801223:	83 c4 18             	add    $0x18,%esp
}
  801226:	c9                   	leave  
  801227:	c3                   	ret    

00801228 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801228:	55                   	push   %ebp
  801229:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80122b:	6a 00                	push   $0x0
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	ff 75 08             	pushl  0x8(%ebp)
  801236:	6a 0f                	push   $0xf
  801238:	e8 e3 fd ff ff       	call   801020 <syscall>
  80123d:	83 c4 18             	add    $0x18,%esp
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	6a 00                	push   $0x0
  80124b:	6a 00                	push   $0x0
  80124d:	6a 00                	push   $0x0
  80124f:	6a 10                	push   $0x10
  801251:	e8 ca fd ff ff       	call   801020 <syscall>
  801256:	83 c4 18             	add    $0x18,%esp
}
  801259:	90                   	nop
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80125f:	6a 00                	push   $0x0
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 14                	push   $0x14
  80126b:	e8 b0 fd ff ff       	call   801020 <syscall>
  801270:	83 c4 18             	add    $0x18,%esp
}
  801273:	90                   	nop
  801274:	c9                   	leave  
  801275:	c3                   	ret    

00801276 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801276:	55                   	push   %ebp
  801277:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801279:	6a 00                	push   $0x0
  80127b:	6a 00                	push   $0x0
  80127d:	6a 00                	push   $0x0
  80127f:	6a 00                	push   $0x0
  801281:	6a 00                	push   $0x0
  801283:	6a 15                	push   $0x15
  801285:	e8 96 fd ff ff       	call   801020 <syscall>
  80128a:	83 c4 18             	add    $0x18,%esp
}
  80128d:	90                   	nop
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <sys_cputc>:


void
sys_cputc(const char c)
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
  801293:	83 ec 04             	sub    $0x4,%esp
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80129c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	50                   	push   %eax
  8012a9:	6a 16                	push   $0x16
  8012ab:	e8 70 fd ff ff       	call   801020 <syscall>
  8012b0:	83 c4 18             	add    $0x18,%esp
}
  8012b3:	90                   	nop
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 17                	push   $0x17
  8012c5:	e8 56 fd ff ff       	call   801020 <syscall>
  8012ca:	83 c4 18             	add    $0x18,%esp
}
  8012cd:	90                   	nop
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	ff 75 0c             	pushl  0xc(%ebp)
  8012df:	50                   	push   %eax
  8012e0:	6a 18                	push   $0x18
  8012e2:	e8 39 fd ff ff       	call   801020 <syscall>
  8012e7:	83 c4 18             	add    $0x18,%esp
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 00                	push   $0x0
  8012fb:	52                   	push   %edx
  8012fc:	50                   	push   %eax
  8012fd:	6a 1b                	push   $0x1b
  8012ff:	e8 1c fd ff ff       	call   801020 <syscall>
  801304:	83 c4 18             	add    $0x18,%esp
}
  801307:	c9                   	leave  
  801308:	c3                   	ret    

00801309 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80130c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	52                   	push   %edx
  801319:	50                   	push   %eax
  80131a:	6a 19                	push   $0x19
  80131c:	e8 ff fc ff ff       	call   801020 <syscall>
  801321:	83 c4 18             	add    $0x18,%esp
}
  801324:	90                   	nop
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80132a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	52                   	push   %edx
  801337:	50                   	push   %eax
  801338:	6a 1a                	push   $0x1a
  80133a:	e8 e1 fc ff ff       	call   801020 <syscall>
  80133f:	83 c4 18             	add    $0x18,%esp
}
  801342:	90                   	nop
  801343:	c9                   	leave  
  801344:	c3                   	ret    

00801345 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801345:	55                   	push   %ebp
  801346:	89 e5                	mov    %esp,%ebp
  801348:	83 ec 04             	sub    $0x4,%esp
  80134b:	8b 45 10             	mov    0x10(%ebp),%eax
  80134e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801351:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801354:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	6a 00                	push   $0x0
  80135d:	51                   	push   %ecx
  80135e:	52                   	push   %edx
  80135f:	ff 75 0c             	pushl  0xc(%ebp)
  801362:	50                   	push   %eax
  801363:	6a 1c                	push   $0x1c
  801365:	e8 b6 fc ff ff       	call   801020 <syscall>
  80136a:	83 c4 18             	add    $0x18,%esp
}
  80136d:	c9                   	leave  
  80136e:	c3                   	ret    

0080136f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80136f:	55                   	push   %ebp
  801370:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801372:	8b 55 0c             	mov    0xc(%ebp),%edx
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	52                   	push   %edx
  80137f:	50                   	push   %eax
  801380:	6a 1d                	push   $0x1d
  801382:	e8 99 fc ff ff       	call   801020 <syscall>
  801387:	83 c4 18             	add    $0x18,%esp
}
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80138f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801392:	8b 55 0c             	mov    0xc(%ebp),%edx
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	51                   	push   %ecx
  80139d:	52                   	push   %edx
  80139e:	50                   	push   %eax
  80139f:	6a 1e                	push   $0x1e
  8013a1:	e8 7a fc ff ff       	call   801020 <syscall>
  8013a6:	83 c4 18             	add    $0x18,%esp
}
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	52                   	push   %edx
  8013bb:	50                   	push   %eax
  8013bc:	6a 1f                	push   $0x1f
  8013be:	e8 5d fc ff ff       	call   801020 <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
}
  8013c6:	c9                   	leave  
  8013c7:	c3                   	ret    

008013c8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013c8:	55                   	push   %ebp
  8013c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 20                	push   $0x20
  8013d7:	e8 44 fc ff ff       	call   801020 <syscall>
  8013dc:	83 c4 18             	add    $0x18,%esp
}
  8013df:	c9                   	leave  
  8013e0:	c3                   	ret    

008013e1 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013e1:	55                   	push   %ebp
  8013e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	ff 75 10             	pushl  0x10(%ebp)
  8013ee:	ff 75 0c             	pushl  0xc(%ebp)
  8013f1:	50                   	push   %eax
  8013f2:	6a 21                	push   $0x21
  8013f4:	e8 27 fc ff ff       	call   801020 <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	50                   	push   %eax
  80140d:	6a 22                	push   $0x22
  80140f:	e8 0c fc ff ff       	call   801020 <syscall>
  801414:	83 c4 18             	add    $0x18,%esp
}
  801417:	90                   	nop
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	50                   	push   %eax
  801429:	6a 23                	push   $0x23
  80142b:	e8 f0 fb ff ff       	call   801020 <syscall>
  801430:	83 c4 18             	add    $0x18,%esp
}
  801433:	90                   	nop
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
  801439:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80143c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80143f:	8d 50 04             	lea    0x4(%eax),%edx
  801442:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	52                   	push   %edx
  80144c:	50                   	push   %eax
  80144d:	6a 24                	push   $0x24
  80144f:	e8 cc fb ff ff       	call   801020 <syscall>
  801454:	83 c4 18             	add    $0x18,%esp
	return result;
  801457:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80145a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801460:	89 01                	mov    %eax,(%ecx)
  801462:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	c9                   	leave  
  801469:	c2 04 00             	ret    $0x4

0080146c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	ff 75 10             	pushl  0x10(%ebp)
  801476:	ff 75 0c             	pushl  0xc(%ebp)
  801479:	ff 75 08             	pushl  0x8(%ebp)
  80147c:	6a 13                	push   $0x13
  80147e:	e8 9d fb ff ff       	call   801020 <syscall>
  801483:	83 c4 18             	add    $0x18,%esp
	return ;
  801486:	90                   	nop
}
  801487:	c9                   	leave  
  801488:	c3                   	ret    

00801489 <sys_rcr2>:
uint32 sys_rcr2()
{
  801489:	55                   	push   %ebp
  80148a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 25                	push   $0x25
  801498:	e8 83 fb ff ff       	call   801020 <syscall>
  80149d:	83 c4 18             	add    $0x18,%esp
}
  8014a0:	c9                   	leave  
  8014a1:	c3                   	ret    

008014a2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014a2:	55                   	push   %ebp
  8014a3:	89 e5                	mov    %esp,%ebp
  8014a5:	83 ec 04             	sub    $0x4,%esp
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014ae:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	50                   	push   %eax
  8014bb:	6a 26                	push   $0x26
  8014bd:	e8 5e fb ff ff       	call   801020 <syscall>
  8014c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c5:	90                   	nop
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <rsttst>:
void rsttst()
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 28                	push   $0x28
  8014d7:	e8 44 fb ff ff       	call   801020 <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8014df:	90                   	nop
}
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
  8014e5:	83 ec 04             	sub    $0x4,%esp
  8014e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014ee:	8b 55 18             	mov    0x18(%ebp),%edx
  8014f1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014f5:	52                   	push   %edx
  8014f6:	50                   	push   %eax
  8014f7:	ff 75 10             	pushl  0x10(%ebp)
  8014fa:	ff 75 0c             	pushl  0xc(%ebp)
  8014fd:	ff 75 08             	pushl  0x8(%ebp)
  801500:	6a 27                	push   $0x27
  801502:	e8 19 fb ff ff       	call   801020 <syscall>
  801507:	83 c4 18             	add    $0x18,%esp
	return ;
  80150a:	90                   	nop
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <chktst>:
void chktst(uint32 n)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	ff 75 08             	pushl  0x8(%ebp)
  80151b:	6a 29                	push   $0x29
  80151d:	e8 fe fa ff ff       	call   801020 <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
	return ;
  801525:	90                   	nop
}
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <inctst>:

void inctst()
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 2a                	push   $0x2a
  801537:	e8 e4 fa ff ff       	call   801020 <syscall>
  80153c:	83 c4 18             	add    $0x18,%esp
	return ;
  80153f:	90                   	nop
}
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <gettst>:
uint32 gettst()
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 2b                	push   $0x2b
  801551:	e8 ca fa ff ff       	call   801020 <syscall>
  801556:	83 c4 18             	add    $0x18,%esp
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
  80155e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 2c                	push   $0x2c
  80156d:	e8 ae fa ff ff       	call   801020 <syscall>
  801572:	83 c4 18             	add    $0x18,%esp
  801575:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801578:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80157c:	75 07                	jne    801585 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80157e:	b8 01 00 00 00       	mov    $0x1,%eax
  801583:	eb 05                	jmp    80158a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801585:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80158a:	c9                   	leave  
  80158b:	c3                   	ret    

0080158c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
  80158f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 2c                	push   $0x2c
  80159e:	e8 7d fa ff ff       	call   801020 <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
  8015a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015a9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015ad:	75 07                	jne    8015b6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015af:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b4:	eb 05                	jmp    8015bb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
  8015c0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 2c                	push   $0x2c
  8015cf:	e8 4c fa ff ff       	call   801020 <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
  8015d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015da:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015de:	75 07                	jne    8015e7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015e0:	b8 01 00 00 00       	mov    $0x1,%eax
  8015e5:	eb 05                	jmp    8015ec <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
  8015f1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 2c                	push   $0x2c
  801600:	e8 1b fa ff ff       	call   801020 <syscall>
  801605:	83 c4 18             	add    $0x18,%esp
  801608:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80160b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80160f:	75 07                	jne    801618 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801611:	b8 01 00 00 00       	mov    $0x1,%eax
  801616:	eb 05                	jmp    80161d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801618:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	ff 75 08             	pushl  0x8(%ebp)
  80162d:	6a 2d                	push   $0x2d
  80162f:	e8 ec f9 ff ff       	call   801020 <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
	return ;
  801637:	90                   	nop
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
  80163d:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801640:	8b 55 08             	mov    0x8(%ebp),%edx
  801643:	89 d0                	mov    %edx,%eax
  801645:	c1 e0 02             	shl    $0x2,%eax
  801648:	01 d0                	add    %edx,%eax
  80164a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801651:	01 d0                	add    %edx,%eax
  801653:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80165a:	01 d0                	add    %edx,%eax
  80165c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801663:	01 d0                	add    %edx,%eax
  801665:	c1 e0 04             	shl    $0x4,%eax
  801668:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80166b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801672:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801675:	83 ec 0c             	sub    $0xc,%esp
  801678:	50                   	push   %eax
  801679:	e8 b8 fd ff ff       	call   801436 <sys_get_virtual_time>
  80167e:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801681:	eb 41                	jmp    8016c4 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801683:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801686:	83 ec 0c             	sub    $0xc,%esp
  801689:	50                   	push   %eax
  80168a:	e8 a7 fd ff ff       	call   801436 <sys_get_virtual_time>
  80168f:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801692:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801695:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801698:	29 c2                	sub    %eax,%edx
  80169a:	89 d0                	mov    %edx,%eax
  80169c:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80169f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8016a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016a5:	89 d1                	mov    %edx,%ecx
  8016a7:	29 c1                	sub    %eax,%ecx
  8016a9:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8016ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016af:	39 c2                	cmp    %eax,%edx
  8016b1:	0f 97 c0             	seta   %al
  8016b4:	0f b6 c0             	movzbl %al,%eax
  8016b7:	29 c1                	sub    %eax,%ecx
  8016b9:	89 c8                	mov    %ecx,%eax
  8016bb:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8016be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8016c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8016c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016ca:	72 b7                	jb     801683 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8016cc:	90                   	nop
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
  8016d2:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8016d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8016dc:	eb 03                	jmp    8016e1 <busy_wait+0x12>
  8016de:	ff 45 fc             	incl   -0x4(%ebp)
  8016e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e4:	3b 45 08             	cmp    0x8(%ebp),%eax
  8016e7:	72 f5                	jb     8016de <busy_wait+0xf>
	return i;
  8016e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    
  8016ee:	66 90                	xchg   %ax,%ax

008016f0 <__udivdi3>:
  8016f0:	55                   	push   %ebp
  8016f1:	57                   	push   %edi
  8016f2:	56                   	push   %esi
  8016f3:	53                   	push   %ebx
  8016f4:	83 ec 1c             	sub    $0x1c,%esp
  8016f7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016fb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801703:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801707:	89 ca                	mov    %ecx,%edx
  801709:	89 f8                	mov    %edi,%eax
  80170b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80170f:	85 f6                	test   %esi,%esi
  801711:	75 2d                	jne    801740 <__udivdi3+0x50>
  801713:	39 cf                	cmp    %ecx,%edi
  801715:	77 65                	ja     80177c <__udivdi3+0x8c>
  801717:	89 fd                	mov    %edi,%ebp
  801719:	85 ff                	test   %edi,%edi
  80171b:	75 0b                	jne    801728 <__udivdi3+0x38>
  80171d:	b8 01 00 00 00       	mov    $0x1,%eax
  801722:	31 d2                	xor    %edx,%edx
  801724:	f7 f7                	div    %edi
  801726:	89 c5                	mov    %eax,%ebp
  801728:	31 d2                	xor    %edx,%edx
  80172a:	89 c8                	mov    %ecx,%eax
  80172c:	f7 f5                	div    %ebp
  80172e:	89 c1                	mov    %eax,%ecx
  801730:	89 d8                	mov    %ebx,%eax
  801732:	f7 f5                	div    %ebp
  801734:	89 cf                	mov    %ecx,%edi
  801736:	89 fa                	mov    %edi,%edx
  801738:	83 c4 1c             	add    $0x1c,%esp
  80173b:	5b                   	pop    %ebx
  80173c:	5e                   	pop    %esi
  80173d:	5f                   	pop    %edi
  80173e:	5d                   	pop    %ebp
  80173f:	c3                   	ret    
  801740:	39 ce                	cmp    %ecx,%esi
  801742:	77 28                	ja     80176c <__udivdi3+0x7c>
  801744:	0f bd fe             	bsr    %esi,%edi
  801747:	83 f7 1f             	xor    $0x1f,%edi
  80174a:	75 40                	jne    80178c <__udivdi3+0x9c>
  80174c:	39 ce                	cmp    %ecx,%esi
  80174e:	72 0a                	jb     80175a <__udivdi3+0x6a>
  801750:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801754:	0f 87 9e 00 00 00    	ja     8017f8 <__udivdi3+0x108>
  80175a:	b8 01 00 00 00       	mov    $0x1,%eax
  80175f:	89 fa                	mov    %edi,%edx
  801761:	83 c4 1c             	add    $0x1c,%esp
  801764:	5b                   	pop    %ebx
  801765:	5e                   	pop    %esi
  801766:	5f                   	pop    %edi
  801767:	5d                   	pop    %ebp
  801768:	c3                   	ret    
  801769:	8d 76 00             	lea    0x0(%esi),%esi
  80176c:	31 ff                	xor    %edi,%edi
  80176e:	31 c0                	xor    %eax,%eax
  801770:	89 fa                	mov    %edi,%edx
  801772:	83 c4 1c             	add    $0x1c,%esp
  801775:	5b                   	pop    %ebx
  801776:	5e                   	pop    %esi
  801777:	5f                   	pop    %edi
  801778:	5d                   	pop    %ebp
  801779:	c3                   	ret    
  80177a:	66 90                	xchg   %ax,%ax
  80177c:	89 d8                	mov    %ebx,%eax
  80177e:	f7 f7                	div    %edi
  801780:	31 ff                	xor    %edi,%edi
  801782:	89 fa                	mov    %edi,%edx
  801784:	83 c4 1c             	add    $0x1c,%esp
  801787:	5b                   	pop    %ebx
  801788:	5e                   	pop    %esi
  801789:	5f                   	pop    %edi
  80178a:	5d                   	pop    %ebp
  80178b:	c3                   	ret    
  80178c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801791:	89 eb                	mov    %ebp,%ebx
  801793:	29 fb                	sub    %edi,%ebx
  801795:	89 f9                	mov    %edi,%ecx
  801797:	d3 e6                	shl    %cl,%esi
  801799:	89 c5                	mov    %eax,%ebp
  80179b:	88 d9                	mov    %bl,%cl
  80179d:	d3 ed                	shr    %cl,%ebp
  80179f:	89 e9                	mov    %ebp,%ecx
  8017a1:	09 f1                	or     %esi,%ecx
  8017a3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8017a7:	89 f9                	mov    %edi,%ecx
  8017a9:	d3 e0                	shl    %cl,%eax
  8017ab:	89 c5                	mov    %eax,%ebp
  8017ad:	89 d6                	mov    %edx,%esi
  8017af:	88 d9                	mov    %bl,%cl
  8017b1:	d3 ee                	shr    %cl,%esi
  8017b3:	89 f9                	mov    %edi,%ecx
  8017b5:	d3 e2                	shl    %cl,%edx
  8017b7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017bb:	88 d9                	mov    %bl,%cl
  8017bd:	d3 e8                	shr    %cl,%eax
  8017bf:	09 c2                	or     %eax,%edx
  8017c1:	89 d0                	mov    %edx,%eax
  8017c3:	89 f2                	mov    %esi,%edx
  8017c5:	f7 74 24 0c          	divl   0xc(%esp)
  8017c9:	89 d6                	mov    %edx,%esi
  8017cb:	89 c3                	mov    %eax,%ebx
  8017cd:	f7 e5                	mul    %ebp
  8017cf:	39 d6                	cmp    %edx,%esi
  8017d1:	72 19                	jb     8017ec <__udivdi3+0xfc>
  8017d3:	74 0b                	je     8017e0 <__udivdi3+0xf0>
  8017d5:	89 d8                	mov    %ebx,%eax
  8017d7:	31 ff                	xor    %edi,%edi
  8017d9:	e9 58 ff ff ff       	jmp    801736 <__udivdi3+0x46>
  8017de:	66 90                	xchg   %ax,%ax
  8017e0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017e4:	89 f9                	mov    %edi,%ecx
  8017e6:	d3 e2                	shl    %cl,%edx
  8017e8:	39 c2                	cmp    %eax,%edx
  8017ea:	73 e9                	jae    8017d5 <__udivdi3+0xe5>
  8017ec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017ef:	31 ff                	xor    %edi,%edi
  8017f1:	e9 40 ff ff ff       	jmp    801736 <__udivdi3+0x46>
  8017f6:	66 90                	xchg   %ax,%ax
  8017f8:	31 c0                	xor    %eax,%eax
  8017fa:	e9 37 ff ff ff       	jmp    801736 <__udivdi3+0x46>
  8017ff:	90                   	nop

00801800 <__umoddi3>:
  801800:	55                   	push   %ebp
  801801:	57                   	push   %edi
  801802:	56                   	push   %esi
  801803:	53                   	push   %ebx
  801804:	83 ec 1c             	sub    $0x1c,%esp
  801807:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80180b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80180f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801813:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801817:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80181b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80181f:	89 f3                	mov    %esi,%ebx
  801821:	89 fa                	mov    %edi,%edx
  801823:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801827:	89 34 24             	mov    %esi,(%esp)
  80182a:	85 c0                	test   %eax,%eax
  80182c:	75 1a                	jne    801848 <__umoddi3+0x48>
  80182e:	39 f7                	cmp    %esi,%edi
  801830:	0f 86 a2 00 00 00    	jbe    8018d8 <__umoddi3+0xd8>
  801836:	89 c8                	mov    %ecx,%eax
  801838:	89 f2                	mov    %esi,%edx
  80183a:	f7 f7                	div    %edi
  80183c:	89 d0                	mov    %edx,%eax
  80183e:	31 d2                	xor    %edx,%edx
  801840:	83 c4 1c             	add    $0x1c,%esp
  801843:	5b                   	pop    %ebx
  801844:	5e                   	pop    %esi
  801845:	5f                   	pop    %edi
  801846:	5d                   	pop    %ebp
  801847:	c3                   	ret    
  801848:	39 f0                	cmp    %esi,%eax
  80184a:	0f 87 ac 00 00 00    	ja     8018fc <__umoddi3+0xfc>
  801850:	0f bd e8             	bsr    %eax,%ebp
  801853:	83 f5 1f             	xor    $0x1f,%ebp
  801856:	0f 84 ac 00 00 00    	je     801908 <__umoddi3+0x108>
  80185c:	bf 20 00 00 00       	mov    $0x20,%edi
  801861:	29 ef                	sub    %ebp,%edi
  801863:	89 fe                	mov    %edi,%esi
  801865:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801869:	89 e9                	mov    %ebp,%ecx
  80186b:	d3 e0                	shl    %cl,%eax
  80186d:	89 d7                	mov    %edx,%edi
  80186f:	89 f1                	mov    %esi,%ecx
  801871:	d3 ef                	shr    %cl,%edi
  801873:	09 c7                	or     %eax,%edi
  801875:	89 e9                	mov    %ebp,%ecx
  801877:	d3 e2                	shl    %cl,%edx
  801879:	89 14 24             	mov    %edx,(%esp)
  80187c:	89 d8                	mov    %ebx,%eax
  80187e:	d3 e0                	shl    %cl,%eax
  801880:	89 c2                	mov    %eax,%edx
  801882:	8b 44 24 08          	mov    0x8(%esp),%eax
  801886:	d3 e0                	shl    %cl,%eax
  801888:	89 44 24 04          	mov    %eax,0x4(%esp)
  80188c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801890:	89 f1                	mov    %esi,%ecx
  801892:	d3 e8                	shr    %cl,%eax
  801894:	09 d0                	or     %edx,%eax
  801896:	d3 eb                	shr    %cl,%ebx
  801898:	89 da                	mov    %ebx,%edx
  80189a:	f7 f7                	div    %edi
  80189c:	89 d3                	mov    %edx,%ebx
  80189e:	f7 24 24             	mull   (%esp)
  8018a1:	89 c6                	mov    %eax,%esi
  8018a3:	89 d1                	mov    %edx,%ecx
  8018a5:	39 d3                	cmp    %edx,%ebx
  8018a7:	0f 82 87 00 00 00    	jb     801934 <__umoddi3+0x134>
  8018ad:	0f 84 91 00 00 00    	je     801944 <__umoddi3+0x144>
  8018b3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018b7:	29 f2                	sub    %esi,%edx
  8018b9:	19 cb                	sbb    %ecx,%ebx
  8018bb:	89 d8                	mov    %ebx,%eax
  8018bd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018c1:	d3 e0                	shl    %cl,%eax
  8018c3:	89 e9                	mov    %ebp,%ecx
  8018c5:	d3 ea                	shr    %cl,%edx
  8018c7:	09 d0                	or     %edx,%eax
  8018c9:	89 e9                	mov    %ebp,%ecx
  8018cb:	d3 eb                	shr    %cl,%ebx
  8018cd:	89 da                	mov    %ebx,%edx
  8018cf:	83 c4 1c             	add    $0x1c,%esp
  8018d2:	5b                   	pop    %ebx
  8018d3:	5e                   	pop    %esi
  8018d4:	5f                   	pop    %edi
  8018d5:	5d                   	pop    %ebp
  8018d6:	c3                   	ret    
  8018d7:	90                   	nop
  8018d8:	89 fd                	mov    %edi,%ebp
  8018da:	85 ff                	test   %edi,%edi
  8018dc:	75 0b                	jne    8018e9 <__umoddi3+0xe9>
  8018de:	b8 01 00 00 00       	mov    $0x1,%eax
  8018e3:	31 d2                	xor    %edx,%edx
  8018e5:	f7 f7                	div    %edi
  8018e7:	89 c5                	mov    %eax,%ebp
  8018e9:	89 f0                	mov    %esi,%eax
  8018eb:	31 d2                	xor    %edx,%edx
  8018ed:	f7 f5                	div    %ebp
  8018ef:	89 c8                	mov    %ecx,%eax
  8018f1:	f7 f5                	div    %ebp
  8018f3:	89 d0                	mov    %edx,%eax
  8018f5:	e9 44 ff ff ff       	jmp    80183e <__umoddi3+0x3e>
  8018fa:	66 90                	xchg   %ax,%ax
  8018fc:	89 c8                	mov    %ecx,%eax
  8018fe:	89 f2                	mov    %esi,%edx
  801900:	83 c4 1c             	add    $0x1c,%esp
  801903:	5b                   	pop    %ebx
  801904:	5e                   	pop    %esi
  801905:	5f                   	pop    %edi
  801906:	5d                   	pop    %ebp
  801907:	c3                   	ret    
  801908:	3b 04 24             	cmp    (%esp),%eax
  80190b:	72 06                	jb     801913 <__umoddi3+0x113>
  80190d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801911:	77 0f                	ja     801922 <__umoddi3+0x122>
  801913:	89 f2                	mov    %esi,%edx
  801915:	29 f9                	sub    %edi,%ecx
  801917:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80191b:	89 14 24             	mov    %edx,(%esp)
  80191e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801922:	8b 44 24 04          	mov    0x4(%esp),%eax
  801926:	8b 14 24             	mov    (%esp),%edx
  801929:	83 c4 1c             	add    $0x1c,%esp
  80192c:	5b                   	pop    %ebx
  80192d:	5e                   	pop    %esi
  80192e:	5f                   	pop    %edi
  80192f:	5d                   	pop    %ebp
  801930:	c3                   	ret    
  801931:	8d 76 00             	lea    0x0(%esi),%esi
  801934:	2b 04 24             	sub    (%esp),%eax
  801937:	19 fa                	sbb    %edi,%edx
  801939:	89 d1                	mov    %edx,%ecx
  80193b:	89 c6                	mov    %eax,%esi
  80193d:	e9 71 ff ff ff       	jmp    8018b3 <__umoddi3+0xb3>
  801942:	66 90                	xchg   %ax,%ax
  801944:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801948:	72 ea                	jb     801934 <__umoddi3+0x134>
  80194a:	89 d9                	mov    %ebx,%ecx
  80194c:	e9 62 ff ff ff       	jmp    8018b3 <__umoddi3+0xb3>
