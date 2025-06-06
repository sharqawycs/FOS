
obj/user/fos_factorial:     file format elf32-i386


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
  800031:	e8 95 00 00 00       	call   8000cb <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int factorial(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	atomic_readline("Please enter a number:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 60 1b 80 00       	push   $0x801b60
  800057:	e8 c5 09 00 00       	call   800a21 <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 17 0e 00 00       	call   800e89 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = factorial(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <factorial>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Factorial %d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 77 1b 80 00       	push   $0x801b77
  800097:	e8 32 02 00 00       	call   8002ce <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <factorial>:


int factorial(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	83 ec 08             	sub    $0x8,%esp
	if (n <= 1)
  8000a8:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ac:	7f 07                	jg     8000b5 <factorial+0x13>
		return 1 ;
  8000ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b3:	eb 14                	jmp    8000c9 <factorial+0x27>
	return n * factorial(n-1) ;
  8000b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b8:	48                   	dec    %eax
  8000b9:	83 ec 0c             	sub    $0xc,%esp
  8000bc:	50                   	push   %eax
  8000bd:	e8 e0 ff ff ff       	call   8000a2 <factorial>
  8000c2:	83 c4 10             	add    $0x10,%esp
  8000c5:	0f af 45 08          	imul   0x8(%ebp),%eax
}
  8000c9:	c9                   	leave  
  8000ca:	c3                   	ret    

008000cb <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000cb:	55                   	push   %ebp
  8000cc:	89 e5                	mov    %esp,%ebp
  8000ce:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000d1:	e8 fc 11 00 00       	call   8012d2 <sys_getenvindex>
  8000d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000dc:	89 d0                	mov    %edx,%eax
  8000de:	01 c0                	add    %eax,%eax
  8000e0:	01 d0                	add    %edx,%eax
  8000e2:	c1 e0 02             	shl    $0x2,%eax
  8000e5:	01 d0                	add    %edx,%eax
  8000e7:	c1 e0 06             	shl    $0x6,%eax
  8000ea:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000ef:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000f4:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f9:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000ff:	84 c0                	test   %al,%al
  800101:	74 0f                	je     800112 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800103:	a1 04 20 80 00       	mov    0x802004,%eax
  800108:	05 f4 02 00 00       	add    $0x2f4,%eax
  80010d:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800112:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800116:	7e 0a                	jle    800122 <libmain+0x57>
		binaryname = argv[0];
  800118:	8b 45 0c             	mov    0xc(%ebp),%eax
  80011b:	8b 00                	mov    (%eax),%eax
  80011d:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800122:	83 ec 08             	sub    $0x8,%esp
  800125:	ff 75 0c             	pushl  0xc(%ebp)
  800128:	ff 75 08             	pushl  0x8(%ebp)
  80012b:	e8 08 ff ff ff       	call   800038 <_main>
  800130:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800133:	e8 35 13 00 00       	call   80146d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800138:	83 ec 0c             	sub    $0xc,%esp
  80013b:	68 a4 1b 80 00       	push   $0x801ba4
  800140:	e8 5c 01 00 00       	call   8002a1 <cprintf>
  800145:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800148:	a1 04 20 80 00       	mov    0x802004,%eax
  80014d:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800153:	a1 04 20 80 00       	mov    0x802004,%eax
  800158:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80015e:	83 ec 04             	sub    $0x4,%esp
  800161:	52                   	push   %edx
  800162:	50                   	push   %eax
  800163:	68 cc 1b 80 00       	push   $0x801bcc
  800168:	e8 34 01 00 00       	call   8002a1 <cprintf>
  80016d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800170:	a1 04 20 80 00       	mov    0x802004,%eax
  800175:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80017b:	83 ec 08             	sub    $0x8,%esp
  80017e:	50                   	push   %eax
  80017f:	68 f1 1b 80 00       	push   $0x801bf1
  800184:	e8 18 01 00 00       	call   8002a1 <cprintf>
  800189:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80018c:	83 ec 0c             	sub    $0xc,%esp
  80018f:	68 a4 1b 80 00       	push   $0x801ba4
  800194:	e8 08 01 00 00       	call   8002a1 <cprintf>
  800199:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80019c:	e8 e6 12 00 00       	call   801487 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001a1:	e8 19 00 00 00       	call   8001bf <exit>
}
  8001a6:	90                   	nop
  8001a7:	c9                   	leave  
  8001a8:	c3                   	ret    

008001a9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001a9:	55                   	push   %ebp
  8001aa:	89 e5                	mov    %esp,%ebp
  8001ac:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001af:	83 ec 0c             	sub    $0xc,%esp
  8001b2:	6a 00                	push   $0x0
  8001b4:	e8 e5 10 00 00       	call   80129e <sys_env_destroy>
  8001b9:	83 c4 10             	add    $0x10,%esp
}
  8001bc:	90                   	nop
  8001bd:	c9                   	leave  
  8001be:	c3                   	ret    

008001bf <exit>:

void
exit(void)
{
  8001bf:	55                   	push   %ebp
  8001c0:	89 e5                	mov    %esp,%ebp
  8001c2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001c5:	e8 3a 11 00 00       	call   801304 <sys_env_exit>
}
  8001ca:	90                   	nop
  8001cb:	c9                   	leave  
  8001cc:	c3                   	ret    

008001cd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001cd:	55                   	push   %ebp
  8001ce:	89 e5                	mov    %esp,%ebp
  8001d0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d6:	8b 00                	mov    (%eax),%eax
  8001d8:	8d 48 01             	lea    0x1(%eax),%ecx
  8001db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001de:	89 0a                	mov    %ecx,(%edx)
  8001e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8001e3:	88 d1                	mov    %dl,%cl
  8001e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ef:	8b 00                	mov    (%eax),%eax
  8001f1:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001f6:	75 2c                	jne    800224 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001f8:	a0 08 20 80 00       	mov    0x802008,%al
  8001fd:	0f b6 c0             	movzbl %al,%eax
  800200:	8b 55 0c             	mov    0xc(%ebp),%edx
  800203:	8b 12                	mov    (%edx),%edx
  800205:	89 d1                	mov    %edx,%ecx
  800207:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020a:	83 c2 08             	add    $0x8,%edx
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	50                   	push   %eax
  800211:	51                   	push   %ecx
  800212:	52                   	push   %edx
  800213:	e8 44 10 00 00       	call   80125c <sys_cputs>
  800218:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80021b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800224:	8b 45 0c             	mov    0xc(%ebp),%eax
  800227:	8b 40 04             	mov    0x4(%eax),%eax
  80022a:	8d 50 01             	lea    0x1(%eax),%edx
  80022d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800230:	89 50 04             	mov    %edx,0x4(%eax)
}
  800233:	90                   	nop
  800234:	c9                   	leave  
  800235:	c3                   	ret    

00800236 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800236:	55                   	push   %ebp
  800237:	89 e5                	mov    %esp,%ebp
  800239:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80023f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800246:	00 00 00 
	b.cnt = 0;
  800249:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800250:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800253:	ff 75 0c             	pushl  0xc(%ebp)
  800256:	ff 75 08             	pushl  0x8(%ebp)
  800259:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80025f:	50                   	push   %eax
  800260:	68 cd 01 80 00       	push   $0x8001cd
  800265:	e8 11 02 00 00       	call   80047b <vprintfmt>
  80026a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80026d:	a0 08 20 80 00       	mov    0x802008,%al
  800272:	0f b6 c0             	movzbl %al,%eax
  800275:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80027b:	83 ec 04             	sub    $0x4,%esp
  80027e:	50                   	push   %eax
  80027f:	52                   	push   %edx
  800280:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800286:	83 c0 08             	add    $0x8,%eax
  800289:	50                   	push   %eax
  80028a:	e8 cd 0f 00 00       	call   80125c <sys_cputs>
  80028f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800292:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800299:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80029f:	c9                   	leave  
  8002a0:	c3                   	ret    

008002a1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002a1:	55                   	push   %ebp
  8002a2:	89 e5                	mov    %esp,%ebp
  8002a4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002a7:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002ae:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b7:	83 ec 08             	sub    $0x8,%esp
  8002ba:	ff 75 f4             	pushl  -0xc(%ebp)
  8002bd:	50                   	push   %eax
  8002be:	e8 73 ff ff ff       	call   800236 <vcprintf>
  8002c3:	83 c4 10             	add    $0x10,%esp
  8002c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002cc:	c9                   	leave  
  8002cd:	c3                   	ret    

008002ce <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002ce:	55                   	push   %ebp
  8002cf:	89 e5                	mov    %esp,%ebp
  8002d1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002d4:	e8 94 11 00 00       	call   80146d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002d9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002df:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e2:	83 ec 08             	sub    $0x8,%esp
  8002e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e8:	50                   	push   %eax
  8002e9:	e8 48 ff ff ff       	call   800236 <vcprintf>
  8002ee:	83 c4 10             	add    $0x10,%esp
  8002f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002f4:	e8 8e 11 00 00       	call   801487 <sys_enable_interrupt>
	return cnt;
  8002f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002fc:	c9                   	leave  
  8002fd:	c3                   	ret    

008002fe <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002fe:	55                   	push   %ebp
  8002ff:	89 e5                	mov    %esp,%ebp
  800301:	53                   	push   %ebx
  800302:	83 ec 14             	sub    $0x14,%esp
  800305:	8b 45 10             	mov    0x10(%ebp),%eax
  800308:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80030b:	8b 45 14             	mov    0x14(%ebp),%eax
  80030e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800311:	8b 45 18             	mov    0x18(%ebp),%eax
  800314:	ba 00 00 00 00       	mov    $0x0,%edx
  800319:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80031c:	77 55                	ja     800373 <printnum+0x75>
  80031e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800321:	72 05                	jb     800328 <printnum+0x2a>
  800323:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800326:	77 4b                	ja     800373 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800328:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80032b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80032e:	8b 45 18             	mov    0x18(%ebp),%eax
  800331:	ba 00 00 00 00       	mov    $0x0,%edx
  800336:	52                   	push   %edx
  800337:	50                   	push   %eax
  800338:	ff 75 f4             	pushl  -0xc(%ebp)
  80033b:	ff 75 f0             	pushl  -0x10(%ebp)
  80033e:	e8 a9 15 00 00       	call   8018ec <__udivdi3>
  800343:	83 c4 10             	add    $0x10,%esp
  800346:	83 ec 04             	sub    $0x4,%esp
  800349:	ff 75 20             	pushl  0x20(%ebp)
  80034c:	53                   	push   %ebx
  80034d:	ff 75 18             	pushl  0x18(%ebp)
  800350:	52                   	push   %edx
  800351:	50                   	push   %eax
  800352:	ff 75 0c             	pushl  0xc(%ebp)
  800355:	ff 75 08             	pushl  0x8(%ebp)
  800358:	e8 a1 ff ff ff       	call   8002fe <printnum>
  80035d:	83 c4 20             	add    $0x20,%esp
  800360:	eb 1a                	jmp    80037c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800362:	83 ec 08             	sub    $0x8,%esp
  800365:	ff 75 0c             	pushl  0xc(%ebp)
  800368:	ff 75 20             	pushl  0x20(%ebp)
  80036b:	8b 45 08             	mov    0x8(%ebp),%eax
  80036e:	ff d0                	call   *%eax
  800370:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800373:	ff 4d 1c             	decl   0x1c(%ebp)
  800376:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80037a:	7f e6                	jg     800362 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80037c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80037f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800384:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800387:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80038a:	53                   	push   %ebx
  80038b:	51                   	push   %ecx
  80038c:	52                   	push   %edx
  80038d:	50                   	push   %eax
  80038e:	e8 69 16 00 00       	call   8019fc <__umoddi3>
  800393:	83 c4 10             	add    $0x10,%esp
  800396:	05 34 1e 80 00       	add    $0x801e34,%eax
  80039b:	8a 00                	mov    (%eax),%al
  80039d:	0f be c0             	movsbl %al,%eax
  8003a0:	83 ec 08             	sub    $0x8,%esp
  8003a3:	ff 75 0c             	pushl  0xc(%ebp)
  8003a6:	50                   	push   %eax
  8003a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003aa:	ff d0                	call   *%eax
  8003ac:	83 c4 10             	add    $0x10,%esp
}
  8003af:	90                   	nop
  8003b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003b3:	c9                   	leave  
  8003b4:	c3                   	ret    

008003b5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003b5:	55                   	push   %ebp
  8003b6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003b8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003bc:	7e 1c                	jle    8003da <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	8b 00                	mov    (%eax),%eax
  8003c3:	8d 50 08             	lea    0x8(%eax),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	89 10                	mov    %edx,(%eax)
  8003cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ce:	8b 00                	mov    (%eax),%eax
  8003d0:	83 e8 08             	sub    $0x8,%eax
  8003d3:	8b 50 04             	mov    0x4(%eax),%edx
  8003d6:	8b 00                	mov    (%eax),%eax
  8003d8:	eb 40                	jmp    80041a <getuint+0x65>
	else if (lflag)
  8003da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003de:	74 1e                	je     8003fe <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e3:	8b 00                	mov    (%eax),%eax
  8003e5:	8d 50 04             	lea    0x4(%eax),%edx
  8003e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003eb:	89 10                	mov    %edx,(%eax)
  8003ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f0:	8b 00                	mov    (%eax),%eax
  8003f2:	83 e8 04             	sub    $0x4,%eax
  8003f5:	8b 00                	mov    (%eax),%eax
  8003f7:	ba 00 00 00 00       	mov    $0x0,%edx
  8003fc:	eb 1c                	jmp    80041a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800401:	8b 00                	mov    (%eax),%eax
  800403:	8d 50 04             	lea    0x4(%eax),%edx
  800406:	8b 45 08             	mov    0x8(%ebp),%eax
  800409:	89 10                	mov    %edx,(%eax)
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	8b 00                	mov    (%eax),%eax
  800410:	83 e8 04             	sub    $0x4,%eax
  800413:	8b 00                	mov    (%eax),%eax
  800415:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80041a:	5d                   	pop    %ebp
  80041b:	c3                   	ret    

0080041c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80041c:	55                   	push   %ebp
  80041d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80041f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800423:	7e 1c                	jle    800441 <getint+0x25>
		return va_arg(*ap, long long);
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	8d 50 08             	lea    0x8(%eax),%edx
  80042d:	8b 45 08             	mov    0x8(%ebp),%eax
  800430:	89 10                	mov    %edx,(%eax)
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	8b 00                	mov    (%eax),%eax
  800437:	83 e8 08             	sub    $0x8,%eax
  80043a:	8b 50 04             	mov    0x4(%eax),%edx
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	eb 38                	jmp    800479 <getint+0x5d>
	else if (lflag)
  800441:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800445:	74 1a                	je     800461 <getint+0x45>
		return va_arg(*ap, long);
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	8b 00                	mov    (%eax),%eax
  80044c:	8d 50 04             	lea    0x4(%eax),%edx
  80044f:	8b 45 08             	mov    0x8(%ebp),%eax
  800452:	89 10                	mov    %edx,(%eax)
  800454:	8b 45 08             	mov    0x8(%ebp),%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	83 e8 04             	sub    $0x4,%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	99                   	cltd   
  80045f:	eb 18                	jmp    800479 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	8d 50 04             	lea    0x4(%eax),%edx
  800469:	8b 45 08             	mov    0x8(%ebp),%eax
  80046c:	89 10                	mov    %edx,(%eax)
  80046e:	8b 45 08             	mov    0x8(%ebp),%eax
  800471:	8b 00                	mov    (%eax),%eax
  800473:	83 e8 04             	sub    $0x4,%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	99                   	cltd   
}
  800479:	5d                   	pop    %ebp
  80047a:	c3                   	ret    

0080047b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80047b:	55                   	push   %ebp
  80047c:	89 e5                	mov    %esp,%ebp
  80047e:	56                   	push   %esi
  80047f:	53                   	push   %ebx
  800480:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800483:	eb 17                	jmp    80049c <vprintfmt+0x21>
			if (ch == '\0')
  800485:	85 db                	test   %ebx,%ebx
  800487:	0f 84 af 03 00 00    	je     80083c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80048d:	83 ec 08             	sub    $0x8,%esp
  800490:	ff 75 0c             	pushl  0xc(%ebp)
  800493:	53                   	push   %ebx
  800494:	8b 45 08             	mov    0x8(%ebp),%eax
  800497:	ff d0                	call   *%eax
  800499:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80049c:	8b 45 10             	mov    0x10(%ebp),%eax
  80049f:	8d 50 01             	lea    0x1(%eax),%edx
  8004a2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004a5:	8a 00                	mov    (%eax),%al
  8004a7:	0f b6 d8             	movzbl %al,%ebx
  8004aa:	83 fb 25             	cmp    $0x25,%ebx
  8004ad:	75 d6                	jne    800485 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004af:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004b3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004ba:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004c1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004c8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d2:	8d 50 01             	lea    0x1(%eax),%edx
  8004d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d8:	8a 00                	mov    (%eax),%al
  8004da:	0f b6 d8             	movzbl %al,%ebx
  8004dd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004e0:	83 f8 55             	cmp    $0x55,%eax
  8004e3:	0f 87 2b 03 00 00    	ja     800814 <vprintfmt+0x399>
  8004e9:	8b 04 85 58 1e 80 00 	mov    0x801e58(,%eax,4),%eax
  8004f0:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004f2:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004f6:	eb d7                	jmp    8004cf <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004f8:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004fc:	eb d1                	jmp    8004cf <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004fe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800505:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800508:	89 d0                	mov    %edx,%eax
  80050a:	c1 e0 02             	shl    $0x2,%eax
  80050d:	01 d0                	add    %edx,%eax
  80050f:	01 c0                	add    %eax,%eax
  800511:	01 d8                	add    %ebx,%eax
  800513:	83 e8 30             	sub    $0x30,%eax
  800516:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800519:	8b 45 10             	mov    0x10(%ebp),%eax
  80051c:	8a 00                	mov    (%eax),%al
  80051e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800521:	83 fb 2f             	cmp    $0x2f,%ebx
  800524:	7e 3e                	jle    800564 <vprintfmt+0xe9>
  800526:	83 fb 39             	cmp    $0x39,%ebx
  800529:	7f 39                	jg     800564 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80052b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80052e:	eb d5                	jmp    800505 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800530:	8b 45 14             	mov    0x14(%ebp),%eax
  800533:	83 c0 04             	add    $0x4,%eax
  800536:	89 45 14             	mov    %eax,0x14(%ebp)
  800539:	8b 45 14             	mov    0x14(%ebp),%eax
  80053c:	83 e8 04             	sub    $0x4,%eax
  80053f:	8b 00                	mov    (%eax),%eax
  800541:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800544:	eb 1f                	jmp    800565 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800546:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80054a:	79 83                	jns    8004cf <vprintfmt+0x54>
				width = 0;
  80054c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800553:	e9 77 ff ff ff       	jmp    8004cf <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800558:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80055f:	e9 6b ff ff ff       	jmp    8004cf <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800564:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800565:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800569:	0f 89 60 ff ff ff    	jns    8004cf <vprintfmt+0x54>
				width = precision, precision = -1;
  80056f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800572:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800575:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80057c:	e9 4e ff ff ff       	jmp    8004cf <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800581:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800584:	e9 46 ff ff ff       	jmp    8004cf <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800589:	8b 45 14             	mov    0x14(%ebp),%eax
  80058c:	83 c0 04             	add    $0x4,%eax
  80058f:	89 45 14             	mov    %eax,0x14(%ebp)
  800592:	8b 45 14             	mov    0x14(%ebp),%eax
  800595:	83 e8 04             	sub    $0x4,%eax
  800598:	8b 00                	mov    (%eax),%eax
  80059a:	83 ec 08             	sub    $0x8,%esp
  80059d:	ff 75 0c             	pushl  0xc(%ebp)
  8005a0:	50                   	push   %eax
  8005a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a4:	ff d0                	call   *%eax
  8005a6:	83 c4 10             	add    $0x10,%esp
			break;
  8005a9:	e9 89 02 00 00       	jmp    800837 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b1:	83 c0 04             	add    $0x4,%eax
  8005b4:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ba:	83 e8 04             	sub    $0x4,%eax
  8005bd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005bf:	85 db                	test   %ebx,%ebx
  8005c1:	79 02                	jns    8005c5 <vprintfmt+0x14a>
				err = -err;
  8005c3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005c5:	83 fb 64             	cmp    $0x64,%ebx
  8005c8:	7f 0b                	jg     8005d5 <vprintfmt+0x15a>
  8005ca:	8b 34 9d a0 1c 80 00 	mov    0x801ca0(,%ebx,4),%esi
  8005d1:	85 f6                	test   %esi,%esi
  8005d3:	75 19                	jne    8005ee <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005d5:	53                   	push   %ebx
  8005d6:	68 45 1e 80 00       	push   $0x801e45
  8005db:	ff 75 0c             	pushl  0xc(%ebp)
  8005de:	ff 75 08             	pushl  0x8(%ebp)
  8005e1:	e8 5e 02 00 00       	call   800844 <printfmt>
  8005e6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005e9:	e9 49 02 00 00       	jmp    800837 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005ee:	56                   	push   %esi
  8005ef:	68 4e 1e 80 00       	push   $0x801e4e
  8005f4:	ff 75 0c             	pushl  0xc(%ebp)
  8005f7:	ff 75 08             	pushl  0x8(%ebp)
  8005fa:	e8 45 02 00 00       	call   800844 <printfmt>
  8005ff:	83 c4 10             	add    $0x10,%esp
			break;
  800602:	e9 30 02 00 00       	jmp    800837 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800607:	8b 45 14             	mov    0x14(%ebp),%eax
  80060a:	83 c0 04             	add    $0x4,%eax
  80060d:	89 45 14             	mov    %eax,0x14(%ebp)
  800610:	8b 45 14             	mov    0x14(%ebp),%eax
  800613:	83 e8 04             	sub    $0x4,%eax
  800616:	8b 30                	mov    (%eax),%esi
  800618:	85 f6                	test   %esi,%esi
  80061a:	75 05                	jne    800621 <vprintfmt+0x1a6>
				p = "(null)";
  80061c:	be 51 1e 80 00       	mov    $0x801e51,%esi
			if (width > 0 && padc != '-')
  800621:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800625:	7e 6d                	jle    800694 <vprintfmt+0x219>
  800627:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80062b:	74 67                	je     800694 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80062d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800630:	83 ec 08             	sub    $0x8,%esp
  800633:	50                   	push   %eax
  800634:	56                   	push   %esi
  800635:	e8 12 05 00 00       	call   800b4c <strnlen>
  80063a:	83 c4 10             	add    $0x10,%esp
  80063d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800640:	eb 16                	jmp    800658 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800642:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800646:	83 ec 08             	sub    $0x8,%esp
  800649:	ff 75 0c             	pushl  0xc(%ebp)
  80064c:	50                   	push   %eax
  80064d:	8b 45 08             	mov    0x8(%ebp),%eax
  800650:	ff d0                	call   *%eax
  800652:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800655:	ff 4d e4             	decl   -0x1c(%ebp)
  800658:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80065c:	7f e4                	jg     800642 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80065e:	eb 34                	jmp    800694 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800660:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800664:	74 1c                	je     800682 <vprintfmt+0x207>
  800666:	83 fb 1f             	cmp    $0x1f,%ebx
  800669:	7e 05                	jle    800670 <vprintfmt+0x1f5>
  80066b:	83 fb 7e             	cmp    $0x7e,%ebx
  80066e:	7e 12                	jle    800682 <vprintfmt+0x207>
					putch('?', putdat);
  800670:	83 ec 08             	sub    $0x8,%esp
  800673:	ff 75 0c             	pushl  0xc(%ebp)
  800676:	6a 3f                	push   $0x3f
  800678:	8b 45 08             	mov    0x8(%ebp),%eax
  80067b:	ff d0                	call   *%eax
  80067d:	83 c4 10             	add    $0x10,%esp
  800680:	eb 0f                	jmp    800691 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800682:	83 ec 08             	sub    $0x8,%esp
  800685:	ff 75 0c             	pushl  0xc(%ebp)
  800688:	53                   	push   %ebx
  800689:	8b 45 08             	mov    0x8(%ebp),%eax
  80068c:	ff d0                	call   *%eax
  80068e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800691:	ff 4d e4             	decl   -0x1c(%ebp)
  800694:	89 f0                	mov    %esi,%eax
  800696:	8d 70 01             	lea    0x1(%eax),%esi
  800699:	8a 00                	mov    (%eax),%al
  80069b:	0f be d8             	movsbl %al,%ebx
  80069e:	85 db                	test   %ebx,%ebx
  8006a0:	74 24                	je     8006c6 <vprintfmt+0x24b>
  8006a2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006a6:	78 b8                	js     800660 <vprintfmt+0x1e5>
  8006a8:	ff 4d e0             	decl   -0x20(%ebp)
  8006ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006af:	79 af                	jns    800660 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006b1:	eb 13                	jmp    8006c6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006b3:	83 ec 08             	sub    $0x8,%esp
  8006b6:	ff 75 0c             	pushl  0xc(%ebp)
  8006b9:	6a 20                	push   $0x20
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	ff d0                	call   *%eax
  8006c0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006c3:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ca:	7f e7                	jg     8006b3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006cc:	e9 66 01 00 00       	jmp    800837 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006d1:	83 ec 08             	sub    $0x8,%esp
  8006d4:	ff 75 e8             	pushl  -0x18(%ebp)
  8006d7:	8d 45 14             	lea    0x14(%ebp),%eax
  8006da:	50                   	push   %eax
  8006db:	e8 3c fd ff ff       	call   80041c <getint>
  8006e0:	83 c4 10             	add    $0x10,%esp
  8006e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ef:	85 d2                	test   %edx,%edx
  8006f1:	79 23                	jns    800716 <vprintfmt+0x29b>
				putch('-', putdat);
  8006f3:	83 ec 08             	sub    $0x8,%esp
  8006f6:	ff 75 0c             	pushl  0xc(%ebp)
  8006f9:	6a 2d                	push   $0x2d
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	ff d0                	call   *%eax
  800700:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800703:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800706:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800709:	f7 d8                	neg    %eax
  80070b:	83 d2 00             	adc    $0x0,%edx
  80070e:	f7 da                	neg    %edx
  800710:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800713:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800716:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80071d:	e9 bc 00 00 00       	jmp    8007de <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800722:	83 ec 08             	sub    $0x8,%esp
  800725:	ff 75 e8             	pushl  -0x18(%ebp)
  800728:	8d 45 14             	lea    0x14(%ebp),%eax
  80072b:	50                   	push   %eax
  80072c:	e8 84 fc ff ff       	call   8003b5 <getuint>
  800731:	83 c4 10             	add    $0x10,%esp
  800734:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800737:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80073a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800741:	e9 98 00 00 00       	jmp    8007de <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800746:	83 ec 08             	sub    $0x8,%esp
  800749:	ff 75 0c             	pushl  0xc(%ebp)
  80074c:	6a 58                	push   $0x58
  80074e:	8b 45 08             	mov    0x8(%ebp),%eax
  800751:	ff d0                	call   *%eax
  800753:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800756:	83 ec 08             	sub    $0x8,%esp
  800759:	ff 75 0c             	pushl  0xc(%ebp)
  80075c:	6a 58                	push   $0x58
  80075e:	8b 45 08             	mov    0x8(%ebp),%eax
  800761:	ff d0                	call   *%eax
  800763:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800766:	83 ec 08             	sub    $0x8,%esp
  800769:	ff 75 0c             	pushl  0xc(%ebp)
  80076c:	6a 58                	push   $0x58
  80076e:	8b 45 08             	mov    0x8(%ebp),%eax
  800771:	ff d0                	call   *%eax
  800773:	83 c4 10             	add    $0x10,%esp
			break;
  800776:	e9 bc 00 00 00       	jmp    800837 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80077b:	83 ec 08             	sub    $0x8,%esp
  80077e:	ff 75 0c             	pushl  0xc(%ebp)
  800781:	6a 30                	push   $0x30
  800783:	8b 45 08             	mov    0x8(%ebp),%eax
  800786:	ff d0                	call   *%eax
  800788:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80078b:	83 ec 08             	sub    $0x8,%esp
  80078e:	ff 75 0c             	pushl  0xc(%ebp)
  800791:	6a 78                	push   $0x78
  800793:	8b 45 08             	mov    0x8(%ebp),%eax
  800796:	ff d0                	call   *%eax
  800798:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80079b:	8b 45 14             	mov    0x14(%ebp),%eax
  80079e:	83 c0 04             	add    $0x4,%eax
  8007a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a7:	83 e8 04             	sub    $0x4,%eax
  8007aa:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007b6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007bd:	eb 1f                	jmp    8007de <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	ff 75 e8             	pushl  -0x18(%ebp)
  8007c5:	8d 45 14             	lea    0x14(%ebp),%eax
  8007c8:	50                   	push   %eax
  8007c9:	e8 e7 fb ff ff       	call   8003b5 <getuint>
  8007ce:	83 c4 10             	add    $0x10,%esp
  8007d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007d7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007de:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007e5:	83 ec 04             	sub    $0x4,%esp
  8007e8:	52                   	push   %edx
  8007e9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007ec:	50                   	push   %eax
  8007ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f0:	ff 75 f0             	pushl  -0x10(%ebp)
  8007f3:	ff 75 0c             	pushl  0xc(%ebp)
  8007f6:	ff 75 08             	pushl  0x8(%ebp)
  8007f9:	e8 00 fb ff ff       	call   8002fe <printnum>
  8007fe:	83 c4 20             	add    $0x20,%esp
			break;
  800801:	eb 34                	jmp    800837 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800803:	83 ec 08             	sub    $0x8,%esp
  800806:	ff 75 0c             	pushl  0xc(%ebp)
  800809:	53                   	push   %ebx
  80080a:	8b 45 08             	mov    0x8(%ebp),%eax
  80080d:	ff d0                	call   *%eax
  80080f:	83 c4 10             	add    $0x10,%esp
			break;
  800812:	eb 23                	jmp    800837 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800814:	83 ec 08             	sub    $0x8,%esp
  800817:	ff 75 0c             	pushl  0xc(%ebp)
  80081a:	6a 25                	push   $0x25
  80081c:	8b 45 08             	mov    0x8(%ebp),%eax
  80081f:	ff d0                	call   *%eax
  800821:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800824:	ff 4d 10             	decl   0x10(%ebp)
  800827:	eb 03                	jmp    80082c <vprintfmt+0x3b1>
  800829:	ff 4d 10             	decl   0x10(%ebp)
  80082c:	8b 45 10             	mov    0x10(%ebp),%eax
  80082f:	48                   	dec    %eax
  800830:	8a 00                	mov    (%eax),%al
  800832:	3c 25                	cmp    $0x25,%al
  800834:	75 f3                	jne    800829 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800836:	90                   	nop
		}
	}
  800837:	e9 47 fc ff ff       	jmp    800483 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80083c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80083d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800840:	5b                   	pop    %ebx
  800841:	5e                   	pop    %esi
  800842:	5d                   	pop    %ebp
  800843:	c3                   	ret    

00800844 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800844:	55                   	push   %ebp
  800845:	89 e5                	mov    %esp,%ebp
  800847:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80084a:	8d 45 10             	lea    0x10(%ebp),%eax
  80084d:	83 c0 04             	add    $0x4,%eax
  800850:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800853:	8b 45 10             	mov    0x10(%ebp),%eax
  800856:	ff 75 f4             	pushl  -0xc(%ebp)
  800859:	50                   	push   %eax
  80085a:	ff 75 0c             	pushl  0xc(%ebp)
  80085d:	ff 75 08             	pushl  0x8(%ebp)
  800860:	e8 16 fc ff ff       	call   80047b <vprintfmt>
  800865:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800868:	90                   	nop
  800869:	c9                   	leave  
  80086a:	c3                   	ret    

0080086b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80086b:	55                   	push   %ebp
  80086c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80086e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800871:	8b 40 08             	mov    0x8(%eax),%eax
  800874:	8d 50 01             	lea    0x1(%eax),%edx
  800877:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80087d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800880:	8b 10                	mov    (%eax),%edx
  800882:	8b 45 0c             	mov    0xc(%ebp),%eax
  800885:	8b 40 04             	mov    0x4(%eax),%eax
  800888:	39 c2                	cmp    %eax,%edx
  80088a:	73 12                	jae    80089e <sprintputch+0x33>
		*b->buf++ = ch;
  80088c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088f:	8b 00                	mov    (%eax),%eax
  800891:	8d 48 01             	lea    0x1(%eax),%ecx
  800894:	8b 55 0c             	mov    0xc(%ebp),%edx
  800897:	89 0a                	mov    %ecx,(%edx)
  800899:	8b 55 08             	mov    0x8(%ebp),%edx
  80089c:	88 10                	mov    %dl,(%eax)
}
  80089e:	90                   	nop
  80089f:	5d                   	pop    %ebp
  8008a0:	c3                   	ret    

008008a1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008a1:	55                   	push   %ebp
  8008a2:	89 e5                	mov    %esp,%ebp
  8008a4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b6:	01 d0                	add    %edx,%eax
  8008b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008c6:	74 06                	je     8008ce <vsnprintf+0x2d>
  8008c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008cc:	7f 07                	jg     8008d5 <vsnprintf+0x34>
		return -E_INVAL;
  8008ce:	b8 03 00 00 00       	mov    $0x3,%eax
  8008d3:	eb 20                	jmp    8008f5 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008d5:	ff 75 14             	pushl  0x14(%ebp)
  8008d8:	ff 75 10             	pushl  0x10(%ebp)
  8008db:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008de:	50                   	push   %eax
  8008df:	68 6b 08 80 00       	push   $0x80086b
  8008e4:	e8 92 fb ff ff       	call   80047b <vprintfmt>
  8008e9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ef:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008f5:	c9                   	leave  
  8008f6:	c3                   	ret    

008008f7 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008f7:	55                   	push   %ebp
  8008f8:	89 e5                	mov    %esp,%ebp
  8008fa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008fd:	8d 45 10             	lea    0x10(%ebp),%eax
  800900:	83 c0 04             	add    $0x4,%eax
  800903:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800906:	8b 45 10             	mov    0x10(%ebp),%eax
  800909:	ff 75 f4             	pushl  -0xc(%ebp)
  80090c:	50                   	push   %eax
  80090d:	ff 75 0c             	pushl  0xc(%ebp)
  800910:	ff 75 08             	pushl  0x8(%ebp)
  800913:	e8 89 ff ff ff       	call   8008a1 <vsnprintf>
  800918:	83 c4 10             	add    $0x10,%esp
  80091b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80091e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800921:	c9                   	leave  
  800922:	c3                   	ret    

00800923 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800923:	55                   	push   %ebp
  800924:	89 e5                	mov    %esp,%ebp
  800926:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800929:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80092d:	74 13                	je     800942 <readline+0x1f>
		cprintf("%s", prompt);
  80092f:	83 ec 08             	sub    $0x8,%esp
  800932:	ff 75 08             	pushl  0x8(%ebp)
  800935:	68 b0 1f 80 00       	push   $0x801fb0
  80093a:	e8 62 f9 ff ff       	call   8002a1 <cprintf>
  80093f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800942:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800949:	83 ec 0c             	sub    $0xc,%esp
  80094c:	6a 00                	push   $0x0
  80094e:	e8 8e 0f 00 00       	call   8018e1 <iscons>
  800953:	83 c4 10             	add    $0x10,%esp
  800956:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800959:	e8 35 0f 00 00       	call   801893 <getchar>
  80095e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800961:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800965:	79 22                	jns    800989 <readline+0x66>
			if (c != -E_EOF)
  800967:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80096b:	0f 84 ad 00 00 00    	je     800a1e <readline+0xfb>
				cprintf("read error: %e\n", c);
  800971:	83 ec 08             	sub    $0x8,%esp
  800974:	ff 75 ec             	pushl  -0x14(%ebp)
  800977:	68 b3 1f 80 00       	push   $0x801fb3
  80097c:	e8 20 f9 ff ff       	call   8002a1 <cprintf>
  800981:	83 c4 10             	add    $0x10,%esp
			return;
  800984:	e9 95 00 00 00       	jmp    800a1e <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800989:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80098d:	7e 34                	jle    8009c3 <readline+0xa0>
  80098f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800996:	7f 2b                	jg     8009c3 <readline+0xa0>
			if (echoing)
  800998:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80099c:	74 0e                	je     8009ac <readline+0x89>
				cputchar(c);
  80099e:	83 ec 0c             	sub    $0xc,%esp
  8009a1:	ff 75 ec             	pushl  -0x14(%ebp)
  8009a4:	e8 a2 0e 00 00       	call   80184b <cputchar>
  8009a9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009af:	8d 50 01             	lea    0x1(%eax),%edx
  8009b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009b5:	89 c2                	mov    %eax,%edx
  8009b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ba:	01 d0                	add    %edx,%eax
  8009bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009bf:	88 10                	mov    %dl,(%eax)
  8009c1:	eb 56                	jmp    800a19 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009c3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009c7:	75 1f                	jne    8009e8 <readline+0xc5>
  8009c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009cd:	7e 19                	jle    8009e8 <readline+0xc5>
			if (echoing)
  8009cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009d3:	74 0e                	je     8009e3 <readline+0xc0>
				cputchar(c);
  8009d5:	83 ec 0c             	sub    $0xc,%esp
  8009d8:	ff 75 ec             	pushl  -0x14(%ebp)
  8009db:	e8 6b 0e 00 00       	call   80184b <cputchar>
  8009e0:	83 c4 10             	add    $0x10,%esp

			i--;
  8009e3:	ff 4d f4             	decl   -0xc(%ebp)
  8009e6:	eb 31                	jmp    800a19 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8009e8:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8009ec:	74 0a                	je     8009f8 <readline+0xd5>
  8009ee:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8009f2:	0f 85 61 ff ff ff    	jne    800959 <readline+0x36>
			if (echoing)
  8009f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009fc:	74 0e                	je     800a0c <readline+0xe9>
				cputchar(c);
  8009fe:	83 ec 0c             	sub    $0xc,%esp
  800a01:	ff 75 ec             	pushl  -0x14(%ebp)
  800a04:	e8 42 0e 00 00       	call   80184b <cputchar>
  800a09:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a12:	01 d0                	add    %edx,%eax
  800a14:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a17:	eb 06                	jmp    800a1f <readline+0xfc>
		}
	}
  800a19:	e9 3b ff ff ff       	jmp    800959 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a1e:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a1f:	c9                   	leave  
  800a20:	c3                   	ret    

00800a21 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a21:	55                   	push   %ebp
  800a22:	89 e5                	mov    %esp,%ebp
  800a24:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a27:	e8 41 0a 00 00       	call   80146d <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a2c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a30:	74 13                	je     800a45 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a32:	83 ec 08             	sub    $0x8,%esp
  800a35:	ff 75 08             	pushl  0x8(%ebp)
  800a38:	68 b0 1f 80 00       	push   $0x801fb0
  800a3d:	e8 5f f8 ff ff       	call   8002a1 <cprintf>
  800a42:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a4c:	83 ec 0c             	sub    $0xc,%esp
  800a4f:	6a 00                	push   $0x0
  800a51:	e8 8b 0e 00 00       	call   8018e1 <iscons>
  800a56:	83 c4 10             	add    $0x10,%esp
  800a59:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a5c:	e8 32 0e 00 00       	call   801893 <getchar>
  800a61:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a64:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a68:	79 23                	jns    800a8d <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a6a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a6e:	74 13                	je     800a83 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a70:	83 ec 08             	sub    $0x8,%esp
  800a73:	ff 75 ec             	pushl  -0x14(%ebp)
  800a76:	68 b3 1f 80 00       	push   $0x801fb3
  800a7b:	e8 21 f8 ff ff       	call   8002a1 <cprintf>
  800a80:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800a83:	e8 ff 09 00 00       	call   801487 <sys_enable_interrupt>
			return;
  800a88:	e9 9a 00 00 00       	jmp    800b27 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800a8d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800a91:	7e 34                	jle    800ac7 <atomic_readline+0xa6>
  800a93:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800a9a:	7f 2b                	jg     800ac7 <atomic_readline+0xa6>
			if (echoing)
  800a9c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800aa0:	74 0e                	je     800ab0 <atomic_readline+0x8f>
				cputchar(c);
  800aa2:	83 ec 0c             	sub    $0xc,%esp
  800aa5:	ff 75 ec             	pushl  -0x14(%ebp)
  800aa8:	e8 9e 0d 00 00       	call   80184b <cputchar>
  800aad:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ab3:	8d 50 01             	lea    0x1(%eax),%edx
  800ab6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ab9:	89 c2                	mov    %eax,%edx
  800abb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abe:	01 d0                	add    %edx,%eax
  800ac0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ac3:	88 10                	mov    %dl,(%eax)
  800ac5:	eb 5b                	jmp    800b22 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800ac7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800acb:	75 1f                	jne    800aec <atomic_readline+0xcb>
  800acd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800ad1:	7e 19                	jle    800aec <atomic_readline+0xcb>
			if (echoing)
  800ad3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ad7:	74 0e                	je     800ae7 <atomic_readline+0xc6>
				cputchar(c);
  800ad9:	83 ec 0c             	sub    $0xc,%esp
  800adc:	ff 75 ec             	pushl  -0x14(%ebp)
  800adf:	e8 67 0d 00 00       	call   80184b <cputchar>
  800ae4:	83 c4 10             	add    $0x10,%esp
			i--;
  800ae7:	ff 4d f4             	decl   -0xc(%ebp)
  800aea:	eb 36                	jmp    800b22 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800aec:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800af0:	74 0a                	je     800afc <atomic_readline+0xdb>
  800af2:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800af6:	0f 85 60 ff ff ff    	jne    800a5c <atomic_readline+0x3b>
			if (echoing)
  800afc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b00:	74 0e                	je     800b10 <atomic_readline+0xef>
				cputchar(c);
  800b02:	83 ec 0c             	sub    $0xc,%esp
  800b05:	ff 75 ec             	pushl  -0x14(%ebp)
  800b08:	e8 3e 0d 00 00       	call   80184b <cputchar>
  800b0d:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b16:	01 d0                	add    %edx,%eax
  800b18:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b1b:	e8 67 09 00 00       	call   801487 <sys_enable_interrupt>
			return;
  800b20:	eb 05                	jmp    800b27 <atomic_readline+0x106>
		}
	}
  800b22:	e9 35 ff ff ff       	jmp    800a5c <atomic_readline+0x3b>
}
  800b27:	c9                   	leave  
  800b28:	c3                   	ret    

00800b29 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b29:	55                   	push   %ebp
  800b2a:	89 e5                	mov    %esp,%ebp
  800b2c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b36:	eb 06                	jmp    800b3e <strlen+0x15>
		n++;
  800b38:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b3b:	ff 45 08             	incl   0x8(%ebp)
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8a 00                	mov    (%eax),%al
  800b43:	84 c0                	test   %al,%al
  800b45:	75 f1                	jne    800b38 <strlen+0xf>
		n++;
	return n;
  800b47:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b4a:	c9                   	leave  
  800b4b:	c3                   	ret    

00800b4c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b4c:	55                   	push   %ebp
  800b4d:	89 e5                	mov    %esp,%ebp
  800b4f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b52:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b59:	eb 09                	jmp    800b64 <strnlen+0x18>
		n++;
  800b5b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b5e:	ff 45 08             	incl   0x8(%ebp)
  800b61:	ff 4d 0c             	decl   0xc(%ebp)
  800b64:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b68:	74 09                	je     800b73 <strnlen+0x27>
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	8a 00                	mov    (%eax),%al
  800b6f:	84 c0                	test   %al,%al
  800b71:	75 e8                	jne    800b5b <strnlen+0xf>
		n++;
	return n;
  800b73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b76:	c9                   	leave  
  800b77:	c3                   	ret    

00800b78 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b78:	55                   	push   %ebp
  800b79:	89 e5                	mov    %esp,%ebp
  800b7b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b84:	90                   	nop
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	8d 50 01             	lea    0x1(%eax),%edx
  800b8b:	89 55 08             	mov    %edx,0x8(%ebp)
  800b8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b94:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b97:	8a 12                	mov    (%edx),%dl
  800b99:	88 10                	mov    %dl,(%eax)
  800b9b:	8a 00                	mov    (%eax),%al
  800b9d:	84 c0                	test   %al,%al
  800b9f:	75 e4                	jne    800b85 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ba1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba4:	c9                   	leave  
  800ba5:	c3                   	ret    

00800ba6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ba6:	55                   	push   %ebp
  800ba7:	89 e5                	mov    %esp,%ebp
  800ba9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb9:	eb 1f                	jmp    800bda <strncpy+0x34>
		*dst++ = *src;
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	8d 50 01             	lea    0x1(%eax),%edx
  800bc1:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc7:	8a 12                	mov    (%edx),%dl
  800bc9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bce:	8a 00                	mov    (%eax),%al
  800bd0:	84 c0                	test   %al,%al
  800bd2:	74 03                	je     800bd7 <strncpy+0x31>
			src++;
  800bd4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bd7:	ff 45 fc             	incl   -0x4(%ebp)
  800bda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bdd:	3b 45 10             	cmp    0x10(%ebp),%eax
  800be0:	72 d9                	jb     800bbb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800be2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800be5:	c9                   	leave  
  800be6:	c3                   	ret    

00800be7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
  800bea:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bf3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bf7:	74 30                	je     800c29 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bf9:	eb 16                	jmp    800c11 <strlcpy+0x2a>
			*dst++ = *src++;
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	8d 50 01             	lea    0x1(%eax),%edx
  800c01:	89 55 08             	mov    %edx,0x8(%ebp)
  800c04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c07:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c0a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c0d:	8a 12                	mov    (%edx),%dl
  800c0f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c11:	ff 4d 10             	decl   0x10(%ebp)
  800c14:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c18:	74 09                	je     800c23 <strlcpy+0x3c>
  800c1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1d:	8a 00                	mov    (%eax),%al
  800c1f:	84 c0                	test   %al,%al
  800c21:	75 d8                	jne    800bfb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c23:	8b 45 08             	mov    0x8(%ebp),%eax
  800c26:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c29:	8b 55 08             	mov    0x8(%ebp),%edx
  800c2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2f:	29 c2                	sub    %eax,%edx
  800c31:	89 d0                	mov    %edx,%eax
}
  800c33:	c9                   	leave  
  800c34:	c3                   	ret    

00800c35 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c35:	55                   	push   %ebp
  800c36:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c38:	eb 06                	jmp    800c40 <strcmp+0xb>
		p++, q++;
  800c3a:	ff 45 08             	incl   0x8(%ebp)
  800c3d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	8a 00                	mov    (%eax),%al
  800c45:	84 c0                	test   %al,%al
  800c47:	74 0e                	je     800c57 <strcmp+0x22>
  800c49:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4c:	8a 10                	mov    (%eax),%dl
  800c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	38 c2                	cmp    %al,%dl
  800c55:	74 e3                	je     800c3a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	8a 00                	mov    (%eax),%al
  800c5c:	0f b6 d0             	movzbl %al,%edx
  800c5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c62:	8a 00                	mov    (%eax),%al
  800c64:	0f b6 c0             	movzbl %al,%eax
  800c67:	29 c2                	sub    %eax,%edx
  800c69:	89 d0                	mov    %edx,%eax
}
  800c6b:	5d                   	pop    %ebp
  800c6c:	c3                   	ret    

00800c6d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c6d:	55                   	push   %ebp
  800c6e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c70:	eb 09                	jmp    800c7b <strncmp+0xe>
		n--, p++, q++;
  800c72:	ff 4d 10             	decl   0x10(%ebp)
  800c75:	ff 45 08             	incl   0x8(%ebp)
  800c78:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7f:	74 17                	je     800c98 <strncmp+0x2b>
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	8a 00                	mov    (%eax),%al
  800c86:	84 c0                	test   %al,%al
  800c88:	74 0e                	je     800c98 <strncmp+0x2b>
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 10                	mov    (%eax),%dl
  800c8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c92:	8a 00                	mov    (%eax),%al
  800c94:	38 c2                	cmp    %al,%dl
  800c96:	74 da                	je     800c72 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c98:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9c:	75 07                	jne    800ca5 <strncmp+0x38>
		return 0;
  800c9e:	b8 00 00 00 00       	mov    $0x0,%eax
  800ca3:	eb 14                	jmp    800cb9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca8:	8a 00                	mov    (%eax),%al
  800caa:	0f b6 d0             	movzbl %al,%edx
  800cad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb0:	8a 00                	mov    (%eax),%al
  800cb2:	0f b6 c0             	movzbl %al,%eax
  800cb5:	29 c2                	sub    %eax,%edx
  800cb7:	89 d0                	mov    %edx,%eax
}
  800cb9:	5d                   	pop    %ebp
  800cba:	c3                   	ret    

00800cbb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
  800cbe:	83 ec 04             	sub    $0x4,%esp
  800cc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cc7:	eb 12                	jmp    800cdb <strchr+0x20>
		if (*s == c)
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8a 00                	mov    (%eax),%al
  800cce:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cd1:	75 05                	jne    800cd8 <strchr+0x1d>
			return (char *) s;
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	eb 11                	jmp    800ce9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cd8:	ff 45 08             	incl   0x8(%ebp)
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	84 c0                	test   %al,%al
  800ce2:	75 e5                	jne    800cc9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ce4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ce9:	c9                   	leave  
  800cea:	c3                   	ret    

00800ceb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	83 ec 04             	sub    $0x4,%esp
  800cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cf7:	eb 0d                	jmp    800d06 <strfind+0x1b>
		if (*s == c)
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	8a 00                	mov    (%eax),%al
  800cfe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d01:	74 0e                	je     800d11 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d03:	ff 45 08             	incl   0x8(%ebp)
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	84 c0                	test   %al,%al
  800d0d:	75 ea                	jne    800cf9 <strfind+0xe>
  800d0f:	eb 01                	jmp    800d12 <strfind+0x27>
		if (*s == c)
			break;
  800d11:	90                   	nop
	return (char *) s;
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d15:	c9                   	leave  
  800d16:	c3                   	ret    

00800d17 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d17:	55                   	push   %ebp
  800d18:	89 e5                	mov    %esp,%ebp
  800d1a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d23:	8b 45 10             	mov    0x10(%ebp),%eax
  800d26:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d29:	eb 0e                	jmp    800d39 <memset+0x22>
		*p++ = c;
  800d2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2e:	8d 50 01             	lea    0x1(%eax),%edx
  800d31:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d37:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d39:	ff 4d f8             	decl   -0x8(%ebp)
  800d3c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d40:	79 e9                	jns    800d2b <memset+0x14>
		*p++ = c;

	return v;
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d45:	c9                   	leave  
  800d46:	c3                   	ret    

00800d47 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d47:	55                   	push   %ebp
  800d48:	89 e5                	mov    %esp,%ebp
  800d4a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d50:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d59:	eb 16                	jmp    800d71 <memcpy+0x2a>
		*d++ = *s++;
  800d5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d5e:	8d 50 01             	lea    0x1(%eax),%edx
  800d61:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d67:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d6a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d6d:	8a 12                	mov    (%edx),%dl
  800d6f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d71:	8b 45 10             	mov    0x10(%ebp),%eax
  800d74:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d77:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7a:	85 c0                	test   %eax,%eax
  800d7c:	75 dd                	jne    800d5b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d81:	c9                   	leave  
  800d82:	c3                   	ret    

00800d83 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d83:	55                   	push   %ebp
  800d84:	89 e5                	mov    %esp,%ebp
  800d86:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800d89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d98:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d9b:	73 50                	jae    800ded <memmove+0x6a>
  800d9d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800da0:	8b 45 10             	mov    0x10(%ebp),%eax
  800da3:	01 d0                	add    %edx,%eax
  800da5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800da8:	76 43                	jbe    800ded <memmove+0x6a>
		s += n;
  800daa:	8b 45 10             	mov    0x10(%ebp),%eax
  800dad:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800db0:	8b 45 10             	mov    0x10(%ebp),%eax
  800db3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800db6:	eb 10                	jmp    800dc8 <memmove+0x45>
			*--d = *--s;
  800db8:	ff 4d f8             	decl   -0x8(%ebp)
  800dbb:	ff 4d fc             	decl   -0x4(%ebp)
  800dbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc1:	8a 10                	mov    (%eax),%dl
  800dc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dce:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd1:	85 c0                	test   %eax,%eax
  800dd3:	75 e3                	jne    800db8 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dd5:	eb 23                	jmp    800dfa <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dda:	8d 50 01             	lea    0x1(%eax),%edx
  800ddd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800de3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800de6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800de9:	8a 12                	mov    (%edx),%dl
  800deb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ded:	8b 45 10             	mov    0x10(%ebp),%eax
  800df0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df3:	89 55 10             	mov    %edx,0x10(%ebp)
  800df6:	85 c0                	test   %eax,%eax
  800df8:	75 dd                	jne    800dd7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dfd:	c9                   	leave  
  800dfe:	c3                   	ret    

00800dff <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800dff:	55                   	push   %ebp
  800e00:	89 e5                	mov    %esp,%ebp
  800e02:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e11:	eb 2a                	jmp    800e3d <memcmp+0x3e>
		if (*s1 != *s2)
  800e13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e16:	8a 10                	mov    (%eax),%dl
  800e18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	38 c2                	cmp    %al,%dl
  800e1f:	74 16                	je     800e37 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e24:	8a 00                	mov    (%eax),%al
  800e26:	0f b6 d0             	movzbl %al,%edx
  800e29:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	0f b6 c0             	movzbl %al,%eax
  800e31:	29 c2                	sub    %eax,%edx
  800e33:	89 d0                	mov    %edx,%eax
  800e35:	eb 18                	jmp    800e4f <memcmp+0x50>
		s1++, s2++;
  800e37:	ff 45 fc             	incl   -0x4(%ebp)
  800e3a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e40:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e43:	89 55 10             	mov    %edx,0x10(%ebp)
  800e46:	85 c0                	test   %eax,%eax
  800e48:	75 c9                	jne    800e13 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e4f:	c9                   	leave  
  800e50:	c3                   	ret    

00800e51 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e51:	55                   	push   %ebp
  800e52:	89 e5                	mov    %esp,%ebp
  800e54:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e57:	8b 55 08             	mov    0x8(%ebp),%edx
  800e5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5d:	01 d0                	add    %edx,%eax
  800e5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e62:	eb 15                	jmp    800e79 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8a 00                	mov    (%eax),%al
  800e69:	0f b6 d0             	movzbl %al,%edx
  800e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6f:	0f b6 c0             	movzbl %al,%eax
  800e72:	39 c2                	cmp    %eax,%edx
  800e74:	74 0d                	je     800e83 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e76:	ff 45 08             	incl   0x8(%ebp)
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e7f:	72 e3                	jb     800e64 <memfind+0x13>
  800e81:	eb 01                	jmp    800e84 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e83:	90                   	nop
	return (void *) s;
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e87:	c9                   	leave  
  800e88:	c3                   	ret    

00800e89 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e89:	55                   	push   %ebp
  800e8a:	89 e5                	mov    %esp,%ebp
  800e8c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e8f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e96:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e9d:	eb 03                	jmp    800ea2 <strtol+0x19>
		s++;
  800e9f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	8a 00                	mov    (%eax),%al
  800ea7:	3c 20                	cmp    $0x20,%al
  800ea9:	74 f4                	je     800e9f <strtol+0x16>
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	8a 00                	mov    (%eax),%al
  800eb0:	3c 09                	cmp    $0x9,%al
  800eb2:	74 eb                	je     800e9f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	8a 00                	mov    (%eax),%al
  800eb9:	3c 2b                	cmp    $0x2b,%al
  800ebb:	75 05                	jne    800ec2 <strtol+0x39>
		s++;
  800ebd:	ff 45 08             	incl   0x8(%ebp)
  800ec0:	eb 13                	jmp    800ed5 <strtol+0x4c>
	else if (*s == '-')
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	3c 2d                	cmp    $0x2d,%al
  800ec9:	75 0a                	jne    800ed5 <strtol+0x4c>
		s++, neg = 1;
  800ecb:	ff 45 08             	incl   0x8(%ebp)
  800ece:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ed5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed9:	74 06                	je     800ee1 <strtol+0x58>
  800edb:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800edf:	75 20                	jne    800f01 <strtol+0x78>
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	3c 30                	cmp    $0x30,%al
  800ee8:	75 17                	jne    800f01 <strtol+0x78>
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	40                   	inc    %eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	3c 78                	cmp    $0x78,%al
  800ef2:	75 0d                	jne    800f01 <strtol+0x78>
		s += 2, base = 16;
  800ef4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ef8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800eff:	eb 28                	jmp    800f29 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f05:	75 15                	jne    800f1c <strtol+0x93>
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	3c 30                	cmp    $0x30,%al
  800f0e:	75 0c                	jne    800f1c <strtol+0x93>
		s++, base = 8;
  800f10:	ff 45 08             	incl   0x8(%ebp)
  800f13:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f1a:	eb 0d                	jmp    800f29 <strtol+0xa0>
	else if (base == 0)
  800f1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f20:	75 07                	jne    800f29 <strtol+0xa0>
		base = 10;
  800f22:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2c:	8a 00                	mov    (%eax),%al
  800f2e:	3c 2f                	cmp    $0x2f,%al
  800f30:	7e 19                	jle    800f4b <strtol+0xc2>
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	3c 39                	cmp    $0x39,%al
  800f39:	7f 10                	jg     800f4b <strtol+0xc2>
			dig = *s - '0';
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8a 00                	mov    (%eax),%al
  800f40:	0f be c0             	movsbl %al,%eax
  800f43:	83 e8 30             	sub    $0x30,%eax
  800f46:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f49:	eb 42                	jmp    800f8d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	8a 00                	mov    (%eax),%al
  800f50:	3c 60                	cmp    $0x60,%al
  800f52:	7e 19                	jle    800f6d <strtol+0xe4>
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	8a 00                	mov    (%eax),%al
  800f59:	3c 7a                	cmp    $0x7a,%al
  800f5b:	7f 10                	jg     800f6d <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	0f be c0             	movsbl %al,%eax
  800f65:	83 e8 57             	sub    $0x57,%eax
  800f68:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f6b:	eb 20                	jmp    800f8d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	3c 40                	cmp    $0x40,%al
  800f74:	7e 39                	jle    800faf <strtol+0x126>
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	3c 5a                	cmp    $0x5a,%al
  800f7d:	7f 30                	jg     800faf <strtol+0x126>
			dig = *s - 'A' + 10;
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	8a 00                	mov    (%eax),%al
  800f84:	0f be c0             	movsbl %al,%eax
  800f87:	83 e8 37             	sub    $0x37,%eax
  800f8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f90:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f93:	7d 19                	jge    800fae <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f95:	ff 45 08             	incl   0x8(%ebp)
  800f98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9b:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f9f:	89 c2                	mov    %eax,%edx
  800fa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa4:	01 d0                	add    %edx,%eax
  800fa6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fa9:	e9 7b ff ff ff       	jmp    800f29 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fae:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800faf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fb3:	74 08                	je     800fbd <strtol+0x134>
		*endptr = (char *) s;
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fbd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fc1:	74 07                	je     800fca <strtol+0x141>
  800fc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc6:	f7 d8                	neg    %eax
  800fc8:	eb 03                	jmp    800fcd <strtol+0x144>
  800fca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fcd:	c9                   	leave  
  800fce:	c3                   	ret    

00800fcf <ltostr>:

void
ltostr(long value, char *str)
{
  800fcf:	55                   	push   %ebp
  800fd0:	89 e5                	mov    %esp,%ebp
  800fd2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fd5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fdc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fe3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe7:	79 13                	jns    800ffc <ltostr+0x2d>
	{
		neg = 1;
  800fe9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ff6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ff9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801004:	99                   	cltd   
  801005:	f7 f9                	idiv   %ecx
  801007:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80100a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100d:	8d 50 01             	lea    0x1(%eax),%edx
  801010:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801013:	89 c2                	mov    %eax,%edx
  801015:	8b 45 0c             	mov    0xc(%ebp),%eax
  801018:	01 d0                	add    %edx,%eax
  80101a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80101d:	83 c2 30             	add    $0x30,%edx
  801020:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801022:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801025:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80102a:	f7 e9                	imul   %ecx
  80102c:	c1 fa 02             	sar    $0x2,%edx
  80102f:	89 c8                	mov    %ecx,%eax
  801031:	c1 f8 1f             	sar    $0x1f,%eax
  801034:	29 c2                	sub    %eax,%edx
  801036:	89 d0                	mov    %edx,%eax
  801038:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80103b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80103e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801043:	f7 e9                	imul   %ecx
  801045:	c1 fa 02             	sar    $0x2,%edx
  801048:	89 c8                	mov    %ecx,%eax
  80104a:	c1 f8 1f             	sar    $0x1f,%eax
  80104d:	29 c2                	sub    %eax,%edx
  80104f:	89 d0                	mov    %edx,%eax
  801051:	c1 e0 02             	shl    $0x2,%eax
  801054:	01 d0                	add    %edx,%eax
  801056:	01 c0                	add    %eax,%eax
  801058:	29 c1                	sub    %eax,%ecx
  80105a:	89 ca                	mov    %ecx,%edx
  80105c:	85 d2                	test   %edx,%edx
  80105e:	75 9c                	jne    800ffc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801060:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801067:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106a:	48                   	dec    %eax
  80106b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80106e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801072:	74 3d                	je     8010b1 <ltostr+0xe2>
		start = 1 ;
  801074:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80107b:	eb 34                	jmp    8010b1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80107d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801080:	8b 45 0c             	mov    0xc(%ebp),%eax
  801083:	01 d0                	add    %edx,%eax
  801085:	8a 00                	mov    (%eax),%al
  801087:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80108a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80108d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801090:	01 c2                	add    %eax,%edx
  801092:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801095:	8b 45 0c             	mov    0xc(%ebp),%eax
  801098:	01 c8                	add    %ecx,%eax
  80109a:	8a 00                	mov    (%eax),%al
  80109c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80109e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a4:	01 c2                	add    %eax,%edx
  8010a6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010a9:	88 02                	mov    %al,(%edx)
		start++ ;
  8010ab:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010ae:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010b7:	7c c4                	jl     80107d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010b9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bf:	01 d0                	add    %edx,%eax
  8010c1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010c4:	90                   	nop
  8010c5:	c9                   	leave  
  8010c6:	c3                   	ret    

008010c7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010c7:	55                   	push   %ebp
  8010c8:	89 e5                	mov    %esp,%ebp
  8010ca:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010cd:	ff 75 08             	pushl  0x8(%ebp)
  8010d0:	e8 54 fa ff ff       	call   800b29 <strlen>
  8010d5:	83 c4 04             	add    $0x4,%esp
  8010d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010db:	ff 75 0c             	pushl  0xc(%ebp)
  8010de:	e8 46 fa ff ff       	call   800b29 <strlen>
  8010e3:	83 c4 04             	add    $0x4,%esp
  8010e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010f7:	eb 17                	jmp    801110 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ff:	01 c2                	add    %eax,%edx
  801101:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	01 c8                	add    %ecx,%eax
  801109:	8a 00                	mov    (%eax),%al
  80110b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80110d:	ff 45 fc             	incl   -0x4(%ebp)
  801110:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801113:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801116:	7c e1                	jl     8010f9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801118:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80111f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801126:	eb 1f                	jmp    801147 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801128:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112b:	8d 50 01             	lea    0x1(%eax),%edx
  80112e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801131:	89 c2                	mov    %eax,%edx
  801133:	8b 45 10             	mov    0x10(%ebp),%eax
  801136:	01 c2                	add    %eax,%edx
  801138:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80113b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113e:	01 c8                	add    %ecx,%eax
  801140:	8a 00                	mov    (%eax),%al
  801142:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801144:	ff 45 f8             	incl   -0x8(%ebp)
  801147:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80114d:	7c d9                	jl     801128 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80114f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801152:	8b 45 10             	mov    0x10(%ebp),%eax
  801155:	01 d0                	add    %edx,%eax
  801157:	c6 00 00             	movb   $0x0,(%eax)
}
  80115a:	90                   	nop
  80115b:	c9                   	leave  
  80115c:	c3                   	ret    

0080115d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80115d:	55                   	push   %ebp
  80115e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801160:	8b 45 14             	mov    0x14(%ebp),%eax
  801163:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801169:	8b 45 14             	mov    0x14(%ebp),%eax
  80116c:	8b 00                	mov    (%eax),%eax
  80116e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801175:	8b 45 10             	mov    0x10(%ebp),%eax
  801178:	01 d0                	add    %edx,%eax
  80117a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801180:	eb 0c                	jmp    80118e <strsplit+0x31>
			*string++ = 0;
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	8d 50 01             	lea    0x1(%eax),%edx
  801188:	89 55 08             	mov    %edx,0x8(%ebp)
  80118b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80118e:	8b 45 08             	mov    0x8(%ebp),%eax
  801191:	8a 00                	mov    (%eax),%al
  801193:	84 c0                	test   %al,%al
  801195:	74 18                	je     8011af <strsplit+0x52>
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	8a 00                	mov    (%eax),%al
  80119c:	0f be c0             	movsbl %al,%eax
  80119f:	50                   	push   %eax
  8011a0:	ff 75 0c             	pushl  0xc(%ebp)
  8011a3:	e8 13 fb ff ff       	call   800cbb <strchr>
  8011a8:	83 c4 08             	add    $0x8,%esp
  8011ab:	85 c0                	test   %eax,%eax
  8011ad:	75 d3                	jne    801182 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	8a 00                	mov    (%eax),%al
  8011b4:	84 c0                	test   %al,%al
  8011b6:	74 5a                	je     801212 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bb:	8b 00                	mov    (%eax),%eax
  8011bd:	83 f8 0f             	cmp    $0xf,%eax
  8011c0:	75 07                	jne    8011c9 <strsplit+0x6c>
		{
			return 0;
  8011c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8011c7:	eb 66                	jmp    80122f <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cc:	8b 00                	mov    (%eax),%eax
  8011ce:	8d 48 01             	lea    0x1(%eax),%ecx
  8011d1:	8b 55 14             	mov    0x14(%ebp),%edx
  8011d4:	89 0a                	mov    %ecx,(%edx)
  8011d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e0:	01 c2                	add    %eax,%edx
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011e7:	eb 03                	jmp    8011ec <strsplit+0x8f>
			string++;
  8011e9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ef:	8a 00                	mov    (%eax),%al
  8011f1:	84 c0                	test   %al,%al
  8011f3:	74 8b                	je     801180 <strsplit+0x23>
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	0f be c0             	movsbl %al,%eax
  8011fd:	50                   	push   %eax
  8011fe:	ff 75 0c             	pushl  0xc(%ebp)
  801201:	e8 b5 fa ff ff       	call   800cbb <strchr>
  801206:	83 c4 08             	add    $0x8,%esp
  801209:	85 c0                	test   %eax,%eax
  80120b:	74 dc                	je     8011e9 <strsplit+0x8c>
			string++;
	}
  80120d:	e9 6e ff ff ff       	jmp    801180 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801212:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801213:	8b 45 14             	mov    0x14(%ebp),%eax
  801216:	8b 00                	mov    (%eax),%eax
  801218:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80121f:	8b 45 10             	mov    0x10(%ebp),%eax
  801222:	01 d0                	add    %edx,%eax
  801224:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80122a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
  801234:	57                   	push   %edi
  801235:	56                   	push   %esi
  801236:	53                   	push   %ebx
  801237:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801240:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801243:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801246:	8b 7d 18             	mov    0x18(%ebp),%edi
  801249:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80124c:	cd 30                	int    $0x30
  80124e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801251:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801254:	83 c4 10             	add    $0x10,%esp
  801257:	5b                   	pop    %ebx
  801258:	5e                   	pop    %esi
  801259:	5f                   	pop    %edi
  80125a:	5d                   	pop    %ebp
  80125b:	c3                   	ret    

0080125c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
  80125f:	83 ec 04             	sub    $0x4,%esp
  801262:	8b 45 10             	mov    0x10(%ebp),%eax
  801265:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801268:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80126c:	8b 45 08             	mov    0x8(%ebp),%eax
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	52                   	push   %edx
  801274:	ff 75 0c             	pushl  0xc(%ebp)
  801277:	50                   	push   %eax
  801278:	6a 00                	push   $0x0
  80127a:	e8 b2 ff ff ff       	call   801231 <syscall>
  80127f:	83 c4 18             	add    $0x18,%esp
}
  801282:	90                   	nop
  801283:	c9                   	leave  
  801284:	c3                   	ret    

00801285 <sys_cgetc>:

int
sys_cgetc(void)
{
  801285:	55                   	push   %ebp
  801286:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801288:	6a 00                	push   $0x0
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 01                	push   $0x1
  801294:	e8 98 ff ff ff       	call   801231 <syscall>
  801299:	83 c4 18             	add    $0x18,%esp
}
  80129c:	c9                   	leave  
  80129d:	c3                   	ret    

0080129e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80129e:	55                   	push   %ebp
  80129f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	50                   	push   %eax
  8012ad:	6a 05                	push   $0x5
  8012af:	e8 7d ff ff ff       	call   801231 <syscall>
  8012b4:	83 c4 18             	add    $0x18,%esp
}
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 02                	push   $0x2
  8012c8:	e8 64 ff ff ff       	call   801231 <syscall>
  8012cd:	83 c4 18             	add    $0x18,%esp
}
  8012d0:	c9                   	leave  
  8012d1:	c3                   	ret    

008012d2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012d2:	55                   	push   %ebp
  8012d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 03                	push   $0x3
  8012e1:	e8 4b ff ff ff       	call   801231 <syscall>
  8012e6:	83 c4 18             	add    $0x18,%esp
}
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 04                	push   $0x4
  8012fa:	e8 32 ff ff ff       	call   801231 <syscall>
  8012ff:	83 c4 18             	add    $0x18,%esp
}
  801302:	c9                   	leave  
  801303:	c3                   	ret    

00801304 <sys_env_exit>:


void sys_env_exit(void)
{
  801304:	55                   	push   %ebp
  801305:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 06                	push   $0x6
  801313:	e8 19 ff ff ff       	call   801231 <syscall>
  801318:	83 c4 18             	add    $0x18,%esp
}
  80131b:	90                   	nop
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801321:	8b 55 0c             	mov    0xc(%ebp),%edx
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	52                   	push   %edx
  80132e:	50                   	push   %eax
  80132f:	6a 07                	push   $0x7
  801331:	e8 fb fe ff ff       	call   801231 <syscall>
  801336:	83 c4 18             	add    $0x18,%esp
}
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
  80133e:	56                   	push   %esi
  80133f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801340:	8b 75 18             	mov    0x18(%ebp),%esi
  801343:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801346:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801349:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134c:	8b 45 08             	mov    0x8(%ebp),%eax
  80134f:	56                   	push   %esi
  801350:	53                   	push   %ebx
  801351:	51                   	push   %ecx
  801352:	52                   	push   %edx
  801353:	50                   	push   %eax
  801354:	6a 08                	push   $0x8
  801356:	e8 d6 fe ff ff       	call   801231 <syscall>
  80135b:	83 c4 18             	add    $0x18,%esp
}
  80135e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801361:	5b                   	pop    %ebx
  801362:	5e                   	pop    %esi
  801363:	5d                   	pop    %ebp
  801364:	c3                   	ret    

00801365 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801368:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	52                   	push   %edx
  801375:	50                   	push   %eax
  801376:	6a 09                	push   $0x9
  801378:	e8 b4 fe ff ff       	call   801231 <syscall>
  80137d:	83 c4 18             	add    $0x18,%esp
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	ff 75 0c             	pushl  0xc(%ebp)
  80138e:	ff 75 08             	pushl  0x8(%ebp)
  801391:	6a 0a                	push   $0xa
  801393:	e8 99 fe ff ff       	call   801231 <syscall>
  801398:	83 c4 18             	add    $0x18,%esp
}
  80139b:	c9                   	leave  
  80139c:	c3                   	ret    

0080139d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80139d:	55                   	push   %ebp
  80139e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 0b                	push   $0xb
  8013ac:	e8 80 fe ff ff       	call   801231 <syscall>
  8013b1:	83 c4 18             	add    $0x18,%esp
}
  8013b4:	c9                   	leave  
  8013b5:	c3                   	ret    

008013b6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 0c                	push   $0xc
  8013c5:	e8 67 fe ff ff       	call   801231 <syscall>
  8013ca:	83 c4 18             	add    $0x18,%esp
}
  8013cd:	c9                   	leave  
  8013ce:	c3                   	ret    

008013cf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013cf:	55                   	push   %ebp
  8013d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 0d                	push   $0xd
  8013de:	e8 4e fe ff ff       	call   801231 <syscall>
  8013e3:	83 c4 18             	add    $0x18,%esp
}
  8013e6:	c9                   	leave  
  8013e7:	c3                   	ret    

008013e8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013e8:	55                   	push   %ebp
  8013e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	ff 75 0c             	pushl  0xc(%ebp)
  8013f4:	ff 75 08             	pushl  0x8(%ebp)
  8013f7:	6a 11                	push   $0x11
  8013f9:	e8 33 fe ff ff       	call   801231 <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
	return;
  801401:	90                   	nop
}
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	ff 75 0c             	pushl  0xc(%ebp)
  801410:	ff 75 08             	pushl  0x8(%ebp)
  801413:	6a 12                	push   $0x12
  801415:	e8 17 fe ff ff       	call   801231 <syscall>
  80141a:	83 c4 18             	add    $0x18,%esp
	return ;
  80141d:	90                   	nop
}
  80141e:	c9                   	leave  
  80141f:	c3                   	ret    

00801420 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801420:	55                   	push   %ebp
  801421:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 0e                	push   $0xe
  80142f:	e8 fd fd ff ff       	call   801231 <syscall>
  801434:	83 c4 18             	add    $0x18,%esp
}
  801437:	c9                   	leave  
  801438:	c3                   	ret    

00801439 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801439:	55                   	push   %ebp
  80143a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	ff 75 08             	pushl  0x8(%ebp)
  801447:	6a 0f                	push   $0xf
  801449:	e8 e3 fd ff ff       	call   801231 <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
}
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 10                	push   $0x10
  801462:	e8 ca fd ff ff       	call   801231 <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
}
  80146a:	90                   	nop
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 14                	push   $0x14
  80147c:	e8 b0 fd ff ff       	call   801231 <syscall>
  801481:	83 c4 18             	add    $0x18,%esp
}
  801484:	90                   	nop
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 15                	push   $0x15
  801496:	e8 96 fd ff ff       	call   801231 <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
}
  80149e:	90                   	nop
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
  8014a4:	83 ec 04             	sub    $0x4,%esp
  8014a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014aa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014ad:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	50                   	push   %eax
  8014ba:	6a 16                	push   $0x16
  8014bc:	e8 70 fd ff ff       	call   801231 <syscall>
  8014c1:	83 c4 18             	add    $0x18,%esp
}
  8014c4:	90                   	nop
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 17                	push   $0x17
  8014d6:	e8 56 fd ff ff       	call   801231 <syscall>
  8014db:	83 c4 18             	add    $0x18,%esp
}
  8014de:	90                   	nop
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	ff 75 0c             	pushl  0xc(%ebp)
  8014f0:	50                   	push   %eax
  8014f1:	6a 18                	push   $0x18
  8014f3:	e8 39 fd ff ff       	call   801231 <syscall>
  8014f8:	83 c4 18             	add    $0x18,%esp
}
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801500:	8b 55 0c             	mov    0xc(%ebp),%edx
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	52                   	push   %edx
  80150d:	50                   	push   %eax
  80150e:	6a 1b                	push   $0x1b
  801510:	e8 1c fd ff ff       	call   801231 <syscall>
  801515:	83 c4 18             	add    $0x18,%esp
}
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80151d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801520:	8b 45 08             	mov    0x8(%ebp),%eax
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	52                   	push   %edx
  80152a:	50                   	push   %eax
  80152b:	6a 19                	push   $0x19
  80152d:	e8 ff fc ff ff       	call   801231 <syscall>
  801532:	83 c4 18             	add    $0x18,%esp
}
  801535:	90                   	nop
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80153b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153e:	8b 45 08             	mov    0x8(%ebp),%eax
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	52                   	push   %edx
  801548:	50                   	push   %eax
  801549:	6a 1a                	push   $0x1a
  80154b:	e8 e1 fc ff ff       	call   801231 <syscall>
  801550:	83 c4 18             	add    $0x18,%esp
}
  801553:	90                   	nop
  801554:	c9                   	leave  
  801555:	c3                   	ret    

00801556 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801556:	55                   	push   %ebp
  801557:	89 e5                	mov    %esp,%ebp
  801559:	83 ec 04             	sub    $0x4,%esp
  80155c:	8b 45 10             	mov    0x10(%ebp),%eax
  80155f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801562:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801565:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801569:	8b 45 08             	mov    0x8(%ebp),%eax
  80156c:	6a 00                	push   $0x0
  80156e:	51                   	push   %ecx
  80156f:	52                   	push   %edx
  801570:	ff 75 0c             	pushl  0xc(%ebp)
  801573:	50                   	push   %eax
  801574:	6a 1c                	push   $0x1c
  801576:	e8 b6 fc ff ff       	call   801231 <syscall>
  80157b:	83 c4 18             	add    $0x18,%esp
}
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801583:	8b 55 0c             	mov    0xc(%ebp),%edx
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	52                   	push   %edx
  801590:	50                   	push   %eax
  801591:	6a 1d                	push   $0x1d
  801593:	e8 99 fc ff ff       	call   801231 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	51                   	push   %ecx
  8015ae:	52                   	push   %edx
  8015af:	50                   	push   %eax
  8015b0:	6a 1e                	push   $0x1e
  8015b2:	e8 7a fc ff ff       	call   801231 <syscall>
  8015b7:	83 c4 18             	add    $0x18,%esp
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	52                   	push   %edx
  8015cc:	50                   	push   %eax
  8015cd:	6a 1f                	push   $0x1f
  8015cf:	e8 5d fc ff ff       	call   801231 <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 20                	push   $0x20
  8015e8:	e8 44 fc ff ff       	call   801231 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	ff 75 10             	pushl  0x10(%ebp)
  8015ff:	ff 75 0c             	pushl  0xc(%ebp)
  801602:	50                   	push   %eax
  801603:	6a 21                	push   $0x21
  801605:	e8 27 fc ff ff       	call   801231 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	50                   	push   %eax
  80161e:	6a 22                	push   $0x22
  801620:	e8 0c fc ff ff       	call   801231 <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
}
  801628:	90                   	nop
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80162e:	8b 45 08             	mov    0x8(%ebp),%eax
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	50                   	push   %eax
  80163a:	6a 23                	push   $0x23
  80163c:	e8 f0 fb ff ff       	call   801231 <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
}
  801644:	90                   	nop
  801645:	c9                   	leave  
  801646:	c3                   	ret    

00801647 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801647:	55                   	push   %ebp
  801648:	89 e5                	mov    %esp,%ebp
  80164a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80164d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801650:	8d 50 04             	lea    0x4(%eax),%edx
  801653:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	52                   	push   %edx
  80165d:	50                   	push   %eax
  80165e:	6a 24                	push   $0x24
  801660:	e8 cc fb ff ff       	call   801231 <syscall>
  801665:	83 c4 18             	add    $0x18,%esp
	return result;
  801668:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80166b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80166e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801671:	89 01                	mov    %eax,(%ecx)
  801673:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	c9                   	leave  
  80167a:	c2 04 00             	ret    $0x4

0080167d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80167d:	55                   	push   %ebp
  80167e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	ff 75 10             	pushl  0x10(%ebp)
  801687:	ff 75 0c             	pushl  0xc(%ebp)
  80168a:	ff 75 08             	pushl  0x8(%ebp)
  80168d:	6a 13                	push   $0x13
  80168f:	e8 9d fb ff ff       	call   801231 <syscall>
  801694:	83 c4 18             	add    $0x18,%esp
	return ;
  801697:	90                   	nop
}
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <sys_rcr2>:
uint32 sys_rcr2()
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 25                	push   $0x25
  8016a9:	e8 83 fb ff ff       	call   801231 <syscall>
  8016ae:	83 c4 18             	add    $0x18,%esp
}
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
  8016b6:	83 ec 04             	sub    $0x4,%esp
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016bf:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	50                   	push   %eax
  8016cc:	6a 26                	push   $0x26
  8016ce:	e8 5e fb ff ff       	call   801231 <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d6:	90                   	nop
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <rsttst>:
void rsttst()
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 28                	push   $0x28
  8016e8:	e8 44 fb ff ff       	call   801231 <syscall>
  8016ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f0:	90                   	nop
}
  8016f1:	c9                   	leave  
  8016f2:	c3                   	ret    

008016f3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016f3:	55                   	push   %ebp
  8016f4:	89 e5                	mov    %esp,%ebp
  8016f6:	83 ec 04             	sub    $0x4,%esp
  8016f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8016fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016ff:	8b 55 18             	mov    0x18(%ebp),%edx
  801702:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801706:	52                   	push   %edx
  801707:	50                   	push   %eax
  801708:	ff 75 10             	pushl  0x10(%ebp)
  80170b:	ff 75 0c             	pushl  0xc(%ebp)
  80170e:	ff 75 08             	pushl  0x8(%ebp)
  801711:	6a 27                	push   $0x27
  801713:	e8 19 fb ff ff       	call   801231 <syscall>
  801718:	83 c4 18             	add    $0x18,%esp
	return ;
  80171b:	90                   	nop
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <chktst>:
void chktst(uint32 n)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	ff 75 08             	pushl  0x8(%ebp)
  80172c:	6a 29                	push   $0x29
  80172e:	e8 fe fa ff ff       	call   801231 <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
	return ;
  801736:	90                   	nop
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <inctst>:

void inctst()
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 2a                	push   $0x2a
  801748:	e8 e4 fa ff ff       	call   801231 <syscall>
  80174d:	83 c4 18             	add    $0x18,%esp
	return ;
  801750:	90                   	nop
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <gettst>:
uint32 gettst()
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 2b                	push   $0x2b
  801762:	e8 ca fa ff ff       	call   801231 <syscall>
  801767:	83 c4 18             	add    $0x18,%esp
}
  80176a:	c9                   	leave  
  80176b:	c3                   	ret    

0080176c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80176c:	55                   	push   %ebp
  80176d:	89 e5                	mov    %esp,%ebp
  80176f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 2c                	push   $0x2c
  80177e:	e8 ae fa ff ff       	call   801231 <syscall>
  801783:	83 c4 18             	add    $0x18,%esp
  801786:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801789:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80178d:	75 07                	jne    801796 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80178f:	b8 01 00 00 00       	mov    $0x1,%eax
  801794:	eb 05                	jmp    80179b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801796:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80179b:	c9                   	leave  
  80179c:	c3                   	ret    

0080179d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
  8017a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 2c                	push   $0x2c
  8017af:	e8 7d fa ff ff       	call   801231 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
  8017b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017ba:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017be:	75 07                	jne    8017c7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c5:	eb 05                	jmp    8017cc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017cc:	c9                   	leave  
  8017cd:	c3                   	ret    

008017ce <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017ce:	55                   	push   %ebp
  8017cf:	89 e5                	mov    %esp,%ebp
  8017d1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 2c                	push   $0x2c
  8017e0:	e8 4c fa ff ff       	call   801231 <syscall>
  8017e5:	83 c4 18             	add    $0x18,%esp
  8017e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017eb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017ef:	75 07                	jne    8017f8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f6:	eb 05                	jmp    8017fd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
  801802:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 2c                	push   $0x2c
  801811:	e8 1b fa ff ff       	call   801231 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
  801819:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80181c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801820:	75 07                	jne    801829 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801822:	b8 01 00 00 00       	mov    $0x1,%eax
  801827:	eb 05                	jmp    80182e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801829:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	ff 75 08             	pushl  0x8(%ebp)
  80183e:	6a 2d                	push   $0x2d
  801840:	e8 ec f9 ff ff       	call   801231 <syscall>
  801845:	83 c4 18             	add    $0x18,%esp
	return ;
  801848:	90                   	nop
}
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
  80184e:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801857:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80185b:	83 ec 0c             	sub    $0xc,%esp
  80185e:	50                   	push   %eax
  80185f:	e8 3d fc ff ff       	call   8014a1 <sys_cputc>
  801864:	83 c4 10             	add    $0x10,%esp
}
  801867:	90                   	nop
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
  80186d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801870:	e8 f8 fb ff ff       	call   80146d <sys_disable_interrupt>
	char c = ch;
  801875:	8b 45 08             	mov    0x8(%ebp),%eax
  801878:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80187b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80187f:	83 ec 0c             	sub    $0xc,%esp
  801882:	50                   	push   %eax
  801883:	e8 19 fc ff ff       	call   8014a1 <sys_cputc>
  801888:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80188b:	e8 f7 fb ff ff       	call   801487 <sys_enable_interrupt>
}
  801890:	90                   	nop
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <getchar>:

int
getchar(void)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
  801896:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  801899:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018a0:	eb 08                	jmp    8018aa <getchar+0x17>
	{
		c = sys_cgetc();
  8018a2:	e8 de f9 ff ff       	call   801285 <sys_cgetc>
  8018a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8018aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018ae:	74 f2                	je     8018a2 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8018b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <atomic_getchar>:

int
atomic_getchar(void)
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
  8018b8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8018bb:	e8 ad fb ff ff       	call   80146d <sys_disable_interrupt>
	int c=0;
  8018c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018c7:	eb 08                	jmp    8018d1 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8018c9:	e8 b7 f9 ff ff       	call   801285 <sys_cgetc>
  8018ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8018d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018d5:	74 f2                	je     8018c9 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8018d7:	e8 ab fb ff ff       	call   801487 <sys_enable_interrupt>
	return c;
  8018dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <iscons>:

int iscons(int fdnum)
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8018e4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8018e9:	5d                   	pop    %ebp
  8018ea:	c3                   	ret    
  8018eb:	90                   	nop

008018ec <__udivdi3>:
  8018ec:	55                   	push   %ebp
  8018ed:	57                   	push   %edi
  8018ee:	56                   	push   %esi
  8018ef:	53                   	push   %ebx
  8018f0:	83 ec 1c             	sub    $0x1c,%esp
  8018f3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8018f7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8018fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8018ff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801903:	89 ca                	mov    %ecx,%edx
  801905:	89 f8                	mov    %edi,%eax
  801907:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80190b:	85 f6                	test   %esi,%esi
  80190d:	75 2d                	jne    80193c <__udivdi3+0x50>
  80190f:	39 cf                	cmp    %ecx,%edi
  801911:	77 65                	ja     801978 <__udivdi3+0x8c>
  801913:	89 fd                	mov    %edi,%ebp
  801915:	85 ff                	test   %edi,%edi
  801917:	75 0b                	jne    801924 <__udivdi3+0x38>
  801919:	b8 01 00 00 00       	mov    $0x1,%eax
  80191e:	31 d2                	xor    %edx,%edx
  801920:	f7 f7                	div    %edi
  801922:	89 c5                	mov    %eax,%ebp
  801924:	31 d2                	xor    %edx,%edx
  801926:	89 c8                	mov    %ecx,%eax
  801928:	f7 f5                	div    %ebp
  80192a:	89 c1                	mov    %eax,%ecx
  80192c:	89 d8                	mov    %ebx,%eax
  80192e:	f7 f5                	div    %ebp
  801930:	89 cf                	mov    %ecx,%edi
  801932:	89 fa                	mov    %edi,%edx
  801934:	83 c4 1c             	add    $0x1c,%esp
  801937:	5b                   	pop    %ebx
  801938:	5e                   	pop    %esi
  801939:	5f                   	pop    %edi
  80193a:	5d                   	pop    %ebp
  80193b:	c3                   	ret    
  80193c:	39 ce                	cmp    %ecx,%esi
  80193e:	77 28                	ja     801968 <__udivdi3+0x7c>
  801940:	0f bd fe             	bsr    %esi,%edi
  801943:	83 f7 1f             	xor    $0x1f,%edi
  801946:	75 40                	jne    801988 <__udivdi3+0x9c>
  801948:	39 ce                	cmp    %ecx,%esi
  80194a:	72 0a                	jb     801956 <__udivdi3+0x6a>
  80194c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801950:	0f 87 9e 00 00 00    	ja     8019f4 <__udivdi3+0x108>
  801956:	b8 01 00 00 00       	mov    $0x1,%eax
  80195b:	89 fa                	mov    %edi,%edx
  80195d:	83 c4 1c             	add    $0x1c,%esp
  801960:	5b                   	pop    %ebx
  801961:	5e                   	pop    %esi
  801962:	5f                   	pop    %edi
  801963:	5d                   	pop    %ebp
  801964:	c3                   	ret    
  801965:	8d 76 00             	lea    0x0(%esi),%esi
  801968:	31 ff                	xor    %edi,%edi
  80196a:	31 c0                	xor    %eax,%eax
  80196c:	89 fa                	mov    %edi,%edx
  80196e:	83 c4 1c             	add    $0x1c,%esp
  801971:	5b                   	pop    %ebx
  801972:	5e                   	pop    %esi
  801973:	5f                   	pop    %edi
  801974:	5d                   	pop    %ebp
  801975:	c3                   	ret    
  801976:	66 90                	xchg   %ax,%ax
  801978:	89 d8                	mov    %ebx,%eax
  80197a:	f7 f7                	div    %edi
  80197c:	31 ff                	xor    %edi,%edi
  80197e:	89 fa                	mov    %edi,%edx
  801980:	83 c4 1c             	add    $0x1c,%esp
  801983:	5b                   	pop    %ebx
  801984:	5e                   	pop    %esi
  801985:	5f                   	pop    %edi
  801986:	5d                   	pop    %ebp
  801987:	c3                   	ret    
  801988:	bd 20 00 00 00       	mov    $0x20,%ebp
  80198d:	89 eb                	mov    %ebp,%ebx
  80198f:	29 fb                	sub    %edi,%ebx
  801991:	89 f9                	mov    %edi,%ecx
  801993:	d3 e6                	shl    %cl,%esi
  801995:	89 c5                	mov    %eax,%ebp
  801997:	88 d9                	mov    %bl,%cl
  801999:	d3 ed                	shr    %cl,%ebp
  80199b:	89 e9                	mov    %ebp,%ecx
  80199d:	09 f1                	or     %esi,%ecx
  80199f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019a3:	89 f9                	mov    %edi,%ecx
  8019a5:	d3 e0                	shl    %cl,%eax
  8019a7:	89 c5                	mov    %eax,%ebp
  8019a9:	89 d6                	mov    %edx,%esi
  8019ab:	88 d9                	mov    %bl,%cl
  8019ad:	d3 ee                	shr    %cl,%esi
  8019af:	89 f9                	mov    %edi,%ecx
  8019b1:	d3 e2                	shl    %cl,%edx
  8019b3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019b7:	88 d9                	mov    %bl,%cl
  8019b9:	d3 e8                	shr    %cl,%eax
  8019bb:	09 c2                	or     %eax,%edx
  8019bd:	89 d0                	mov    %edx,%eax
  8019bf:	89 f2                	mov    %esi,%edx
  8019c1:	f7 74 24 0c          	divl   0xc(%esp)
  8019c5:	89 d6                	mov    %edx,%esi
  8019c7:	89 c3                	mov    %eax,%ebx
  8019c9:	f7 e5                	mul    %ebp
  8019cb:	39 d6                	cmp    %edx,%esi
  8019cd:	72 19                	jb     8019e8 <__udivdi3+0xfc>
  8019cf:	74 0b                	je     8019dc <__udivdi3+0xf0>
  8019d1:	89 d8                	mov    %ebx,%eax
  8019d3:	31 ff                	xor    %edi,%edi
  8019d5:	e9 58 ff ff ff       	jmp    801932 <__udivdi3+0x46>
  8019da:	66 90                	xchg   %ax,%ax
  8019dc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8019e0:	89 f9                	mov    %edi,%ecx
  8019e2:	d3 e2                	shl    %cl,%edx
  8019e4:	39 c2                	cmp    %eax,%edx
  8019e6:	73 e9                	jae    8019d1 <__udivdi3+0xe5>
  8019e8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8019eb:	31 ff                	xor    %edi,%edi
  8019ed:	e9 40 ff ff ff       	jmp    801932 <__udivdi3+0x46>
  8019f2:	66 90                	xchg   %ax,%ax
  8019f4:	31 c0                	xor    %eax,%eax
  8019f6:	e9 37 ff ff ff       	jmp    801932 <__udivdi3+0x46>
  8019fb:	90                   	nop

008019fc <__umoddi3>:
  8019fc:	55                   	push   %ebp
  8019fd:	57                   	push   %edi
  8019fe:	56                   	push   %esi
  8019ff:	53                   	push   %ebx
  801a00:	83 ec 1c             	sub    $0x1c,%esp
  801a03:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a07:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a0f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a13:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a17:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a1b:	89 f3                	mov    %esi,%ebx
  801a1d:	89 fa                	mov    %edi,%edx
  801a1f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a23:	89 34 24             	mov    %esi,(%esp)
  801a26:	85 c0                	test   %eax,%eax
  801a28:	75 1a                	jne    801a44 <__umoddi3+0x48>
  801a2a:	39 f7                	cmp    %esi,%edi
  801a2c:	0f 86 a2 00 00 00    	jbe    801ad4 <__umoddi3+0xd8>
  801a32:	89 c8                	mov    %ecx,%eax
  801a34:	89 f2                	mov    %esi,%edx
  801a36:	f7 f7                	div    %edi
  801a38:	89 d0                	mov    %edx,%eax
  801a3a:	31 d2                	xor    %edx,%edx
  801a3c:	83 c4 1c             	add    $0x1c,%esp
  801a3f:	5b                   	pop    %ebx
  801a40:	5e                   	pop    %esi
  801a41:	5f                   	pop    %edi
  801a42:	5d                   	pop    %ebp
  801a43:	c3                   	ret    
  801a44:	39 f0                	cmp    %esi,%eax
  801a46:	0f 87 ac 00 00 00    	ja     801af8 <__umoddi3+0xfc>
  801a4c:	0f bd e8             	bsr    %eax,%ebp
  801a4f:	83 f5 1f             	xor    $0x1f,%ebp
  801a52:	0f 84 ac 00 00 00    	je     801b04 <__umoddi3+0x108>
  801a58:	bf 20 00 00 00       	mov    $0x20,%edi
  801a5d:	29 ef                	sub    %ebp,%edi
  801a5f:	89 fe                	mov    %edi,%esi
  801a61:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a65:	89 e9                	mov    %ebp,%ecx
  801a67:	d3 e0                	shl    %cl,%eax
  801a69:	89 d7                	mov    %edx,%edi
  801a6b:	89 f1                	mov    %esi,%ecx
  801a6d:	d3 ef                	shr    %cl,%edi
  801a6f:	09 c7                	or     %eax,%edi
  801a71:	89 e9                	mov    %ebp,%ecx
  801a73:	d3 e2                	shl    %cl,%edx
  801a75:	89 14 24             	mov    %edx,(%esp)
  801a78:	89 d8                	mov    %ebx,%eax
  801a7a:	d3 e0                	shl    %cl,%eax
  801a7c:	89 c2                	mov    %eax,%edx
  801a7e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a82:	d3 e0                	shl    %cl,%eax
  801a84:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a88:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a8c:	89 f1                	mov    %esi,%ecx
  801a8e:	d3 e8                	shr    %cl,%eax
  801a90:	09 d0                	or     %edx,%eax
  801a92:	d3 eb                	shr    %cl,%ebx
  801a94:	89 da                	mov    %ebx,%edx
  801a96:	f7 f7                	div    %edi
  801a98:	89 d3                	mov    %edx,%ebx
  801a9a:	f7 24 24             	mull   (%esp)
  801a9d:	89 c6                	mov    %eax,%esi
  801a9f:	89 d1                	mov    %edx,%ecx
  801aa1:	39 d3                	cmp    %edx,%ebx
  801aa3:	0f 82 87 00 00 00    	jb     801b30 <__umoddi3+0x134>
  801aa9:	0f 84 91 00 00 00    	je     801b40 <__umoddi3+0x144>
  801aaf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ab3:	29 f2                	sub    %esi,%edx
  801ab5:	19 cb                	sbb    %ecx,%ebx
  801ab7:	89 d8                	mov    %ebx,%eax
  801ab9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801abd:	d3 e0                	shl    %cl,%eax
  801abf:	89 e9                	mov    %ebp,%ecx
  801ac1:	d3 ea                	shr    %cl,%edx
  801ac3:	09 d0                	or     %edx,%eax
  801ac5:	89 e9                	mov    %ebp,%ecx
  801ac7:	d3 eb                	shr    %cl,%ebx
  801ac9:	89 da                	mov    %ebx,%edx
  801acb:	83 c4 1c             	add    $0x1c,%esp
  801ace:	5b                   	pop    %ebx
  801acf:	5e                   	pop    %esi
  801ad0:	5f                   	pop    %edi
  801ad1:	5d                   	pop    %ebp
  801ad2:	c3                   	ret    
  801ad3:	90                   	nop
  801ad4:	89 fd                	mov    %edi,%ebp
  801ad6:	85 ff                	test   %edi,%edi
  801ad8:	75 0b                	jne    801ae5 <__umoddi3+0xe9>
  801ada:	b8 01 00 00 00       	mov    $0x1,%eax
  801adf:	31 d2                	xor    %edx,%edx
  801ae1:	f7 f7                	div    %edi
  801ae3:	89 c5                	mov    %eax,%ebp
  801ae5:	89 f0                	mov    %esi,%eax
  801ae7:	31 d2                	xor    %edx,%edx
  801ae9:	f7 f5                	div    %ebp
  801aeb:	89 c8                	mov    %ecx,%eax
  801aed:	f7 f5                	div    %ebp
  801aef:	89 d0                	mov    %edx,%eax
  801af1:	e9 44 ff ff ff       	jmp    801a3a <__umoddi3+0x3e>
  801af6:	66 90                	xchg   %ax,%ax
  801af8:	89 c8                	mov    %ecx,%eax
  801afa:	89 f2                	mov    %esi,%edx
  801afc:	83 c4 1c             	add    $0x1c,%esp
  801aff:	5b                   	pop    %ebx
  801b00:	5e                   	pop    %esi
  801b01:	5f                   	pop    %edi
  801b02:	5d                   	pop    %ebp
  801b03:	c3                   	ret    
  801b04:	3b 04 24             	cmp    (%esp),%eax
  801b07:	72 06                	jb     801b0f <__umoddi3+0x113>
  801b09:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b0d:	77 0f                	ja     801b1e <__umoddi3+0x122>
  801b0f:	89 f2                	mov    %esi,%edx
  801b11:	29 f9                	sub    %edi,%ecx
  801b13:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b17:	89 14 24             	mov    %edx,(%esp)
  801b1a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b1e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b22:	8b 14 24             	mov    (%esp),%edx
  801b25:	83 c4 1c             	add    $0x1c,%esp
  801b28:	5b                   	pop    %ebx
  801b29:	5e                   	pop    %esi
  801b2a:	5f                   	pop    %edi
  801b2b:	5d                   	pop    %ebp
  801b2c:	c3                   	ret    
  801b2d:	8d 76 00             	lea    0x0(%esi),%esi
  801b30:	2b 04 24             	sub    (%esp),%eax
  801b33:	19 fa                	sbb    %edi,%edx
  801b35:	89 d1                	mov    %edx,%ecx
  801b37:	89 c6                	mov    %eax,%esi
  801b39:	e9 71 ff ff ff       	jmp    801aaf <__umoddi3+0xb3>
  801b3e:	66 90                	xchg   %ax,%ax
  801b40:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b44:	72 ea                	jb     801b30 <__umoddi3+0x134>
  801b46:	89 d9                	mov    %ebx,%ecx
  801b48:	e9 62 ff ff ff       	jmp    801aaf <__umoddi3+0xb3>
