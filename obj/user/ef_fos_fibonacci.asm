
obj/user/ef_fos_fibonacci:     file format elf32-i386


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
  800031:	e8 82 00 00 00       	call   8000b8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int fibonacci(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	i1 = 20;
  800048:	c7 45 f4 14 00 00 00 	movl   $0x14,-0xc(%ebp)

	int res = fibonacci(i1) ;
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	e8 1f 00 00 00       	call   800079 <fibonacci>
  80005a:	83 c4 10             	add    $0x10,%esp
  80005d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	ff 75 f0             	pushl  -0x10(%ebp)
  800066:	ff 75 f4             	pushl  -0xc(%ebp)
  800069:	68 a0 18 80 00       	push   $0x8018a0
  80006e:	e8 48 02 00 00       	call   8002bb <atomic_cprintf>
  800073:	83 c4 10             	add    $0x10,%esp

	return;
  800076:	90                   	nop
}
  800077:	c9                   	leave  
  800078:	c3                   	ret    

00800079 <fibonacci>:


int fibonacci(int n)
{
  800079:	55                   	push   %ebp
  80007a:	89 e5                	mov    %esp,%ebp
  80007c:	53                   	push   %ebx
  80007d:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  800080:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800084:	7f 07                	jg     80008d <fibonacci+0x14>
		return 1 ;
  800086:	b8 01 00 00 00       	mov    $0x1,%eax
  80008b:	eb 26                	jmp    8000b3 <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  80008d:	8b 45 08             	mov    0x8(%ebp),%eax
  800090:	48                   	dec    %eax
  800091:	83 ec 0c             	sub    $0xc,%esp
  800094:	50                   	push   %eax
  800095:	e8 df ff ff ff       	call   800079 <fibonacci>
  80009a:	83 c4 10             	add    $0x10,%esp
  80009d:	89 c3                	mov    %eax,%ebx
  80009f:	8b 45 08             	mov    0x8(%ebp),%eax
  8000a2:	83 e8 02             	sub    $0x2,%eax
  8000a5:	83 ec 0c             	sub    $0xc,%esp
  8000a8:	50                   	push   %eax
  8000a9:	e8 cb ff ff ff       	call   800079 <fibonacci>
  8000ae:	83 c4 10             	add    $0x10,%esp
  8000b1:	01 d8                	add    %ebx,%eax
}
  8000b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000b6:	c9                   	leave  
  8000b7:	c3                   	ret    

008000b8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000b8:	55                   	push   %ebp
  8000b9:	89 e5                	mov    %esp,%ebp
  8000bb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000be:	e8 f6 0f 00 00       	call   8010b9 <sys_getenvindex>
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c9:	89 d0                	mov    %edx,%eax
  8000cb:	01 c0                	add    %eax,%eax
  8000cd:	01 d0                	add    %edx,%eax
  8000cf:	c1 e0 02             	shl    $0x2,%eax
  8000d2:	01 d0                	add    %edx,%eax
  8000d4:	c1 e0 06             	shl    $0x6,%eax
  8000d7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000dc:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000e1:	a1 04 20 80 00       	mov    0x802004,%eax
  8000e6:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000ec:	84 c0                	test   %al,%al
  8000ee:	74 0f                	je     8000ff <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000f0:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f5:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000fa:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800103:	7e 0a                	jle    80010f <libmain+0x57>
		binaryname = argv[0];
  800105:	8b 45 0c             	mov    0xc(%ebp),%eax
  800108:	8b 00                	mov    (%eax),%eax
  80010a:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80010f:	83 ec 08             	sub    $0x8,%esp
  800112:	ff 75 0c             	pushl  0xc(%ebp)
  800115:	ff 75 08             	pushl  0x8(%ebp)
  800118:	e8 1b ff ff ff       	call   800038 <_main>
  80011d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800120:	e8 2f 11 00 00       	call   801254 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800125:	83 ec 0c             	sub    $0xc,%esp
  800128:	68 cc 18 80 00       	push   $0x8018cc
  80012d:	e8 5c 01 00 00       	call   80028e <cprintf>
  800132:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800135:	a1 04 20 80 00       	mov    0x802004,%eax
  80013a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800140:	a1 04 20 80 00       	mov    0x802004,%eax
  800145:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80014b:	83 ec 04             	sub    $0x4,%esp
  80014e:	52                   	push   %edx
  80014f:	50                   	push   %eax
  800150:	68 f4 18 80 00       	push   $0x8018f4
  800155:	e8 34 01 00 00       	call   80028e <cprintf>
  80015a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80015d:	a1 04 20 80 00       	mov    0x802004,%eax
  800162:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800168:	83 ec 08             	sub    $0x8,%esp
  80016b:	50                   	push   %eax
  80016c:	68 19 19 80 00       	push   $0x801919
  800171:	e8 18 01 00 00       	call   80028e <cprintf>
  800176:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800179:	83 ec 0c             	sub    $0xc,%esp
  80017c:	68 cc 18 80 00       	push   $0x8018cc
  800181:	e8 08 01 00 00       	call   80028e <cprintf>
  800186:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800189:	e8 e0 10 00 00       	call   80126e <sys_enable_interrupt>

	// exit gracefully
	exit();
  80018e:	e8 19 00 00 00       	call   8001ac <exit>
}
  800193:	90                   	nop
  800194:	c9                   	leave  
  800195:	c3                   	ret    

00800196 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800196:	55                   	push   %ebp
  800197:	89 e5                	mov    %esp,%ebp
  800199:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80019c:	83 ec 0c             	sub    $0xc,%esp
  80019f:	6a 00                	push   $0x0
  8001a1:	e8 df 0e 00 00       	call   801085 <sys_env_destroy>
  8001a6:	83 c4 10             	add    $0x10,%esp
}
  8001a9:	90                   	nop
  8001aa:	c9                   	leave  
  8001ab:	c3                   	ret    

008001ac <exit>:

void
exit(void)
{
  8001ac:	55                   	push   %ebp
  8001ad:	89 e5                	mov    %esp,%ebp
  8001af:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001b2:	e8 34 0f 00 00       	call   8010eb <sys_env_exit>
}
  8001b7:	90                   	nop
  8001b8:	c9                   	leave  
  8001b9:	c3                   	ret    

008001ba <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001ba:	55                   	push   %ebp
  8001bb:	89 e5                	mov    %esp,%ebp
  8001bd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	8d 48 01             	lea    0x1(%eax),%ecx
  8001c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001cb:	89 0a                	mov    %ecx,(%edx)
  8001cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8001d0:	88 d1                	mov    %dl,%cl
  8001d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001dc:	8b 00                	mov    (%eax),%eax
  8001de:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001e3:	75 2c                	jne    800211 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001e5:	a0 08 20 80 00       	mov    0x802008,%al
  8001ea:	0f b6 c0             	movzbl %al,%eax
  8001ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f0:	8b 12                	mov    (%edx),%edx
  8001f2:	89 d1                	mov    %edx,%ecx
  8001f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f7:	83 c2 08             	add    $0x8,%edx
  8001fa:	83 ec 04             	sub    $0x4,%esp
  8001fd:	50                   	push   %eax
  8001fe:	51                   	push   %ecx
  8001ff:	52                   	push   %edx
  800200:	e8 3e 0e 00 00       	call   801043 <sys_cputs>
  800205:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800211:	8b 45 0c             	mov    0xc(%ebp),%eax
  800214:	8b 40 04             	mov    0x4(%eax),%eax
  800217:	8d 50 01             	lea    0x1(%eax),%edx
  80021a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800220:	90                   	nop
  800221:	c9                   	leave  
  800222:	c3                   	ret    

00800223 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800223:	55                   	push   %ebp
  800224:	89 e5                	mov    %esp,%ebp
  800226:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80022c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800233:	00 00 00 
	b.cnt = 0;
  800236:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80023d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800240:	ff 75 0c             	pushl  0xc(%ebp)
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80024c:	50                   	push   %eax
  80024d:	68 ba 01 80 00       	push   $0x8001ba
  800252:	e8 11 02 00 00       	call   800468 <vprintfmt>
  800257:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80025a:	a0 08 20 80 00       	mov    0x802008,%al
  80025f:	0f b6 c0             	movzbl %al,%eax
  800262:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800268:	83 ec 04             	sub    $0x4,%esp
  80026b:	50                   	push   %eax
  80026c:	52                   	push   %edx
  80026d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800273:	83 c0 08             	add    $0x8,%eax
  800276:	50                   	push   %eax
  800277:	e8 c7 0d 00 00       	call   801043 <sys_cputs>
  80027c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80027f:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800286:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80028c:	c9                   	leave  
  80028d:	c3                   	ret    

0080028e <cprintf>:

int cprintf(const char *fmt, ...) {
  80028e:	55                   	push   %ebp
  80028f:	89 e5                	mov    %esp,%ebp
  800291:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800294:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  80029b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80029e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a4:	83 ec 08             	sub    $0x8,%esp
  8002a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002aa:	50                   	push   %eax
  8002ab:	e8 73 ff ff ff       	call   800223 <vcprintf>
  8002b0:	83 c4 10             	add    $0x10,%esp
  8002b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002b9:	c9                   	leave  
  8002ba:	c3                   	ret    

008002bb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002bb:	55                   	push   %ebp
  8002bc:	89 e5                	mov    %esp,%ebp
  8002be:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002c1:	e8 8e 0f 00 00       	call   801254 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002c6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8002cf:	83 ec 08             	sub    $0x8,%esp
  8002d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d5:	50                   	push   %eax
  8002d6:	e8 48 ff ff ff       	call   800223 <vcprintf>
  8002db:	83 c4 10             	add    $0x10,%esp
  8002de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002e1:	e8 88 0f 00 00       	call   80126e <sys_enable_interrupt>
	return cnt;
  8002e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e9:	c9                   	leave  
  8002ea:	c3                   	ret    

008002eb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002eb:	55                   	push   %ebp
  8002ec:	89 e5                	mov    %esp,%ebp
  8002ee:	53                   	push   %ebx
  8002ef:	83 ec 14             	sub    $0x14,%esp
  8002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8002fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002fe:	8b 45 18             	mov    0x18(%ebp),%eax
  800301:	ba 00 00 00 00       	mov    $0x0,%edx
  800306:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800309:	77 55                	ja     800360 <printnum+0x75>
  80030b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80030e:	72 05                	jb     800315 <printnum+0x2a>
  800310:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800313:	77 4b                	ja     800360 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800315:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800318:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80031b:	8b 45 18             	mov    0x18(%ebp),%eax
  80031e:	ba 00 00 00 00       	mov    $0x0,%edx
  800323:	52                   	push   %edx
  800324:	50                   	push   %eax
  800325:	ff 75 f4             	pushl  -0xc(%ebp)
  800328:	ff 75 f0             	pushl  -0x10(%ebp)
  80032b:	e8 04 13 00 00       	call   801634 <__udivdi3>
  800330:	83 c4 10             	add    $0x10,%esp
  800333:	83 ec 04             	sub    $0x4,%esp
  800336:	ff 75 20             	pushl  0x20(%ebp)
  800339:	53                   	push   %ebx
  80033a:	ff 75 18             	pushl  0x18(%ebp)
  80033d:	52                   	push   %edx
  80033e:	50                   	push   %eax
  80033f:	ff 75 0c             	pushl  0xc(%ebp)
  800342:	ff 75 08             	pushl  0x8(%ebp)
  800345:	e8 a1 ff ff ff       	call   8002eb <printnum>
  80034a:	83 c4 20             	add    $0x20,%esp
  80034d:	eb 1a                	jmp    800369 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80034f:	83 ec 08             	sub    $0x8,%esp
  800352:	ff 75 0c             	pushl  0xc(%ebp)
  800355:	ff 75 20             	pushl  0x20(%ebp)
  800358:	8b 45 08             	mov    0x8(%ebp),%eax
  80035b:	ff d0                	call   *%eax
  80035d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800360:	ff 4d 1c             	decl   0x1c(%ebp)
  800363:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800367:	7f e6                	jg     80034f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800369:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80036c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800371:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800374:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800377:	53                   	push   %ebx
  800378:	51                   	push   %ecx
  800379:	52                   	push   %edx
  80037a:	50                   	push   %eax
  80037b:	e8 c4 13 00 00       	call   801744 <__umoddi3>
  800380:	83 c4 10             	add    $0x10,%esp
  800383:	05 54 1b 80 00       	add    $0x801b54,%eax
  800388:	8a 00                	mov    (%eax),%al
  80038a:	0f be c0             	movsbl %al,%eax
  80038d:	83 ec 08             	sub    $0x8,%esp
  800390:	ff 75 0c             	pushl  0xc(%ebp)
  800393:	50                   	push   %eax
  800394:	8b 45 08             	mov    0x8(%ebp),%eax
  800397:	ff d0                	call   *%eax
  800399:	83 c4 10             	add    $0x10,%esp
}
  80039c:	90                   	nop
  80039d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003a0:	c9                   	leave  
  8003a1:	c3                   	ret    

008003a2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003a2:	55                   	push   %ebp
  8003a3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003a5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003a9:	7e 1c                	jle    8003c7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ae:	8b 00                	mov    (%eax),%eax
  8003b0:	8d 50 08             	lea    0x8(%eax),%edx
  8003b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b6:	89 10                	mov    %edx,(%eax)
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	83 e8 08             	sub    $0x8,%eax
  8003c0:	8b 50 04             	mov    0x4(%eax),%edx
  8003c3:	8b 00                	mov    (%eax),%eax
  8003c5:	eb 40                	jmp    800407 <getuint+0x65>
	else if (lflag)
  8003c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003cb:	74 1e                	je     8003eb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	8d 50 04             	lea    0x4(%eax),%edx
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	89 10                	mov    %edx,(%eax)
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	83 e8 04             	sub    $0x4,%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	ba 00 00 00 00       	mov    $0x0,%edx
  8003e9:	eb 1c                	jmp    800407 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ee:	8b 00                	mov    (%eax),%eax
  8003f0:	8d 50 04             	lea    0x4(%eax),%edx
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	89 10                	mov    %edx,(%eax)
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	8b 00                	mov    (%eax),%eax
  8003fd:	83 e8 04             	sub    $0x4,%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800407:	5d                   	pop    %ebp
  800408:	c3                   	ret    

00800409 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800409:	55                   	push   %ebp
  80040a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80040c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800410:	7e 1c                	jle    80042e <getint+0x25>
		return va_arg(*ap, long long);
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	8b 00                	mov    (%eax),%eax
  800417:	8d 50 08             	lea    0x8(%eax),%edx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	89 10                	mov    %edx,(%eax)
  80041f:	8b 45 08             	mov    0x8(%ebp),%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	83 e8 08             	sub    $0x8,%eax
  800427:	8b 50 04             	mov    0x4(%eax),%edx
  80042a:	8b 00                	mov    (%eax),%eax
  80042c:	eb 38                	jmp    800466 <getint+0x5d>
	else if (lflag)
  80042e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800432:	74 1a                	je     80044e <getint+0x45>
		return va_arg(*ap, long);
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	8b 00                	mov    (%eax),%eax
  800439:	8d 50 04             	lea    0x4(%eax),%edx
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	89 10                	mov    %edx,(%eax)
  800441:	8b 45 08             	mov    0x8(%ebp),%eax
  800444:	8b 00                	mov    (%eax),%eax
  800446:	83 e8 04             	sub    $0x4,%eax
  800449:	8b 00                	mov    (%eax),%eax
  80044b:	99                   	cltd   
  80044c:	eb 18                	jmp    800466 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	8d 50 04             	lea    0x4(%eax),%edx
  800456:	8b 45 08             	mov    0x8(%ebp),%eax
  800459:	89 10                	mov    %edx,(%eax)
  80045b:	8b 45 08             	mov    0x8(%ebp),%eax
  80045e:	8b 00                	mov    (%eax),%eax
  800460:	83 e8 04             	sub    $0x4,%eax
  800463:	8b 00                	mov    (%eax),%eax
  800465:	99                   	cltd   
}
  800466:	5d                   	pop    %ebp
  800467:	c3                   	ret    

00800468 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800468:	55                   	push   %ebp
  800469:	89 e5                	mov    %esp,%ebp
  80046b:	56                   	push   %esi
  80046c:	53                   	push   %ebx
  80046d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800470:	eb 17                	jmp    800489 <vprintfmt+0x21>
			if (ch == '\0')
  800472:	85 db                	test   %ebx,%ebx
  800474:	0f 84 af 03 00 00    	je     800829 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80047a:	83 ec 08             	sub    $0x8,%esp
  80047d:	ff 75 0c             	pushl  0xc(%ebp)
  800480:	53                   	push   %ebx
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	ff d0                	call   *%eax
  800486:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800489:	8b 45 10             	mov    0x10(%ebp),%eax
  80048c:	8d 50 01             	lea    0x1(%eax),%edx
  80048f:	89 55 10             	mov    %edx,0x10(%ebp)
  800492:	8a 00                	mov    (%eax),%al
  800494:	0f b6 d8             	movzbl %al,%ebx
  800497:	83 fb 25             	cmp    $0x25,%ebx
  80049a:	75 d6                	jne    800472 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80049c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004a0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004a7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004b5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bf:	8d 50 01             	lea    0x1(%eax),%edx
  8004c2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c5:	8a 00                	mov    (%eax),%al
  8004c7:	0f b6 d8             	movzbl %al,%ebx
  8004ca:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004cd:	83 f8 55             	cmp    $0x55,%eax
  8004d0:	0f 87 2b 03 00 00    	ja     800801 <vprintfmt+0x399>
  8004d6:	8b 04 85 78 1b 80 00 	mov    0x801b78(,%eax,4),%eax
  8004dd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004df:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004e3:	eb d7                	jmp    8004bc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004e5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004e9:	eb d1                	jmp    8004bc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004eb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004f5:	89 d0                	mov    %edx,%eax
  8004f7:	c1 e0 02             	shl    $0x2,%eax
  8004fa:	01 d0                	add    %edx,%eax
  8004fc:	01 c0                	add    %eax,%eax
  8004fe:	01 d8                	add    %ebx,%eax
  800500:	83 e8 30             	sub    $0x30,%eax
  800503:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800506:	8b 45 10             	mov    0x10(%ebp),%eax
  800509:	8a 00                	mov    (%eax),%al
  80050b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80050e:	83 fb 2f             	cmp    $0x2f,%ebx
  800511:	7e 3e                	jle    800551 <vprintfmt+0xe9>
  800513:	83 fb 39             	cmp    $0x39,%ebx
  800516:	7f 39                	jg     800551 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800518:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80051b:	eb d5                	jmp    8004f2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80051d:	8b 45 14             	mov    0x14(%ebp),%eax
  800520:	83 c0 04             	add    $0x4,%eax
  800523:	89 45 14             	mov    %eax,0x14(%ebp)
  800526:	8b 45 14             	mov    0x14(%ebp),%eax
  800529:	83 e8 04             	sub    $0x4,%eax
  80052c:	8b 00                	mov    (%eax),%eax
  80052e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800531:	eb 1f                	jmp    800552 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800533:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800537:	79 83                	jns    8004bc <vprintfmt+0x54>
				width = 0;
  800539:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800540:	e9 77 ff ff ff       	jmp    8004bc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800545:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80054c:	e9 6b ff ff ff       	jmp    8004bc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800551:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800552:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800556:	0f 89 60 ff ff ff    	jns    8004bc <vprintfmt+0x54>
				width = precision, precision = -1;
  80055c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80055f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800562:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800569:	e9 4e ff ff ff       	jmp    8004bc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80056e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800571:	e9 46 ff ff ff       	jmp    8004bc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800576:	8b 45 14             	mov    0x14(%ebp),%eax
  800579:	83 c0 04             	add    $0x4,%eax
  80057c:	89 45 14             	mov    %eax,0x14(%ebp)
  80057f:	8b 45 14             	mov    0x14(%ebp),%eax
  800582:	83 e8 04             	sub    $0x4,%eax
  800585:	8b 00                	mov    (%eax),%eax
  800587:	83 ec 08             	sub    $0x8,%esp
  80058a:	ff 75 0c             	pushl  0xc(%ebp)
  80058d:	50                   	push   %eax
  80058e:	8b 45 08             	mov    0x8(%ebp),%eax
  800591:	ff d0                	call   *%eax
  800593:	83 c4 10             	add    $0x10,%esp
			break;
  800596:	e9 89 02 00 00       	jmp    800824 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80059b:	8b 45 14             	mov    0x14(%ebp),%eax
  80059e:	83 c0 04             	add    $0x4,%eax
  8005a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a7:	83 e8 04             	sub    $0x4,%eax
  8005aa:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005ac:	85 db                	test   %ebx,%ebx
  8005ae:	79 02                	jns    8005b2 <vprintfmt+0x14a>
				err = -err;
  8005b0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005b2:	83 fb 64             	cmp    $0x64,%ebx
  8005b5:	7f 0b                	jg     8005c2 <vprintfmt+0x15a>
  8005b7:	8b 34 9d c0 19 80 00 	mov    0x8019c0(,%ebx,4),%esi
  8005be:	85 f6                	test   %esi,%esi
  8005c0:	75 19                	jne    8005db <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005c2:	53                   	push   %ebx
  8005c3:	68 65 1b 80 00       	push   $0x801b65
  8005c8:	ff 75 0c             	pushl  0xc(%ebp)
  8005cb:	ff 75 08             	pushl  0x8(%ebp)
  8005ce:	e8 5e 02 00 00       	call   800831 <printfmt>
  8005d3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005d6:	e9 49 02 00 00       	jmp    800824 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005db:	56                   	push   %esi
  8005dc:	68 6e 1b 80 00       	push   $0x801b6e
  8005e1:	ff 75 0c             	pushl  0xc(%ebp)
  8005e4:	ff 75 08             	pushl  0x8(%ebp)
  8005e7:	e8 45 02 00 00       	call   800831 <printfmt>
  8005ec:	83 c4 10             	add    $0x10,%esp
			break;
  8005ef:	e9 30 02 00 00       	jmp    800824 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f7:	83 c0 04             	add    $0x4,%eax
  8005fa:	89 45 14             	mov    %eax,0x14(%ebp)
  8005fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800600:	83 e8 04             	sub    $0x4,%eax
  800603:	8b 30                	mov    (%eax),%esi
  800605:	85 f6                	test   %esi,%esi
  800607:	75 05                	jne    80060e <vprintfmt+0x1a6>
				p = "(null)";
  800609:	be 71 1b 80 00       	mov    $0x801b71,%esi
			if (width > 0 && padc != '-')
  80060e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800612:	7e 6d                	jle    800681 <vprintfmt+0x219>
  800614:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800618:	74 67                	je     800681 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80061a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80061d:	83 ec 08             	sub    $0x8,%esp
  800620:	50                   	push   %eax
  800621:	56                   	push   %esi
  800622:	e8 0c 03 00 00       	call   800933 <strnlen>
  800627:	83 c4 10             	add    $0x10,%esp
  80062a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80062d:	eb 16                	jmp    800645 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80062f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800633:	83 ec 08             	sub    $0x8,%esp
  800636:	ff 75 0c             	pushl  0xc(%ebp)
  800639:	50                   	push   %eax
  80063a:	8b 45 08             	mov    0x8(%ebp),%eax
  80063d:	ff d0                	call   *%eax
  80063f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800642:	ff 4d e4             	decl   -0x1c(%ebp)
  800645:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800649:	7f e4                	jg     80062f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80064b:	eb 34                	jmp    800681 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80064d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800651:	74 1c                	je     80066f <vprintfmt+0x207>
  800653:	83 fb 1f             	cmp    $0x1f,%ebx
  800656:	7e 05                	jle    80065d <vprintfmt+0x1f5>
  800658:	83 fb 7e             	cmp    $0x7e,%ebx
  80065b:	7e 12                	jle    80066f <vprintfmt+0x207>
					putch('?', putdat);
  80065d:	83 ec 08             	sub    $0x8,%esp
  800660:	ff 75 0c             	pushl  0xc(%ebp)
  800663:	6a 3f                	push   $0x3f
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	ff d0                	call   *%eax
  80066a:	83 c4 10             	add    $0x10,%esp
  80066d:	eb 0f                	jmp    80067e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80066f:	83 ec 08             	sub    $0x8,%esp
  800672:	ff 75 0c             	pushl  0xc(%ebp)
  800675:	53                   	push   %ebx
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	ff d0                	call   *%eax
  80067b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80067e:	ff 4d e4             	decl   -0x1c(%ebp)
  800681:	89 f0                	mov    %esi,%eax
  800683:	8d 70 01             	lea    0x1(%eax),%esi
  800686:	8a 00                	mov    (%eax),%al
  800688:	0f be d8             	movsbl %al,%ebx
  80068b:	85 db                	test   %ebx,%ebx
  80068d:	74 24                	je     8006b3 <vprintfmt+0x24b>
  80068f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800693:	78 b8                	js     80064d <vprintfmt+0x1e5>
  800695:	ff 4d e0             	decl   -0x20(%ebp)
  800698:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80069c:	79 af                	jns    80064d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80069e:	eb 13                	jmp    8006b3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006a0:	83 ec 08             	sub    $0x8,%esp
  8006a3:	ff 75 0c             	pushl  0xc(%ebp)
  8006a6:	6a 20                	push   $0x20
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	ff d0                	call   *%eax
  8006ad:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006b0:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b7:	7f e7                	jg     8006a0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006b9:	e9 66 01 00 00       	jmp    800824 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006be:	83 ec 08             	sub    $0x8,%esp
  8006c1:	ff 75 e8             	pushl  -0x18(%ebp)
  8006c4:	8d 45 14             	lea    0x14(%ebp),%eax
  8006c7:	50                   	push   %eax
  8006c8:	e8 3c fd ff ff       	call   800409 <getint>
  8006cd:	83 c4 10             	add    $0x10,%esp
  8006d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006dc:	85 d2                	test   %edx,%edx
  8006de:	79 23                	jns    800703 <vprintfmt+0x29b>
				putch('-', putdat);
  8006e0:	83 ec 08             	sub    $0x8,%esp
  8006e3:	ff 75 0c             	pushl  0xc(%ebp)
  8006e6:	6a 2d                	push   $0x2d
  8006e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006eb:	ff d0                	call   *%eax
  8006ed:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f6:	f7 d8                	neg    %eax
  8006f8:	83 d2 00             	adc    $0x0,%edx
  8006fb:	f7 da                	neg    %edx
  8006fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800700:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800703:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80070a:	e9 bc 00 00 00       	jmp    8007cb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80070f:	83 ec 08             	sub    $0x8,%esp
  800712:	ff 75 e8             	pushl  -0x18(%ebp)
  800715:	8d 45 14             	lea    0x14(%ebp),%eax
  800718:	50                   	push   %eax
  800719:	e8 84 fc ff ff       	call   8003a2 <getuint>
  80071e:	83 c4 10             	add    $0x10,%esp
  800721:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800724:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800727:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072e:	e9 98 00 00 00       	jmp    8007cb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800733:	83 ec 08             	sub    $0x8,%esp
  800736:	ff 75 0c             	pushl  0xc(%ebp)
  800739:	6a 58                	push   $0x58
  80073b:	8b 45 08             	mov    0x8(%ebp),%eax
  80073e:	ff d0                	call   *%eax
  800740:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800743:	83 ec 08             	sub    $0x8,%esp
  800746:	ff 75 0c             	pushl  0xc(%ebp)
  800749:	6a 58                	push   $0x58
  80074b:	8b 45 08             	mov    0x8(%ebp),%eax
  80074e:	ff d0                	call   *%eax
  800750:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800753:	83 ec 08             	sub    $0x8,%esp
  800756:	ff 75 0c             	pushl  0xc(%ebp)
  800759:	6a 58                	push   $0x58
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	ff d0                	call   *%eax
  800760:	83 c4 10             	add    $0x10,%esp
			break;
  800763:	e9 bc 00 00 00       	jmp    800824 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800768:	83 ec 08             	sub    $0x8,%esp
  80076b:	ff 75 0c             	pushl  0xc(%ebp)
  80076e:	6a 30                	push   $0x30
  800770:	8b 45 08             	mov    0x8(%ebp),%eax
  800773:	ff d0                	call   *%eax
  800775:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800778:	83 ec 08             	sub    $0x8,%esp
  80077b:	ff 75 0c             	pushl  0xc(%ebp)
  80077e:	6a 78                	push   $0x78
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	ff d0                	call   *%eax
  800785:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800788:	8b 45 14             	mov    0x14(%ebp),%eax
  80078b:	83 c0 04             	add    $0x4,%eax
  80078e:	89 45 14             	mov    %eax,0x14(%ebp)
  800791:	8b 45 14             	mov    0x14(%ebp),%eax
  800794:	83 e8 04             	sub    $0x4,%eax
  800797:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800799:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80079c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007a3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007aa:	eb 1f                	jmp    8007cb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007ac:	83 ec 08             	sub    $0x8,%esp
  8007af:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b2:	8d 45 14             	lea    0x14(%ebp),%eax
  8007b5:	50                   	push   %eax
  8007b6:	e8 e7 fb ff ff       	call   8003a2 <getuint>
  8007bb:	83 c4 10             	add    $0x10,%esp
  8007be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007c4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007cb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d2:	83 ec 04             	sub    $0x4,%esp
  8007d5:	52                   	push   %edx
  8007d6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007d9:	50                   	push   %eax
  8007da:	ff 75 f4             	pushl  -0xc(%ebp)
  8007dd:	ff 75 f0             	pushl  -0x10(%ebp)
  8007e0:	ff 75 0c             	pushl  0xc(%ebp)
  8007e3:	ff 75 08             	pushl  0x8(%ebp)
  8007e6:	e8 00 fb ff ff       	call   8002eb <printnum>
  8007eb:	83 c4 20             	add    $0x20,%esp
			break;
  8007ee:	eb 34                	jmp    800824 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007f0:	83 ec 08             	sub    $0x8,%esp
  8007f3:	ff 75 0c             	pushl  0xc(%ebp)
  8007f6:	53                   	push   %ebx
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	ff d0                	call   *%eax
  8007fc:	83 c4 10             	add    $0x10,%esp
			break;
  8007ff:	eb 23                	jmp    800824 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 0c             	pushl  0xc(%ebp)
  800807:	6a 25                	push   $0x25
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	ff d0                	call   *%eax
  80080e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800811:	ff 4d 10             	decl   0x10(%ebp)
  800814:	eb 03                	jmp    800819 <vprintfmt+0x3b1>
  800816:	ff 4d 10             	decl   0x10(%ebp)
  800819:	8b 45 10             	mov    0x10(%ebp),%eax
  80081c:	48                   	dec    %eax
  80081d:	8a 00                	mov    (%eax),%al
  80081f:	3c 25                	cmp    $0x25,%al
  800821:	75 f3                	jne    800816 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800823:	90                   	nop
		}
	}
  800824:	e9 47 fc ff ff       	jmp    800470 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800829:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80082a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80082d:	5b                   	pop    %ebx
  80082e:	5e                   	pop    %esi
  80082f:	5d                   	pop    %ebp
  800830:	c3                   	ret    

00800831 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800831:	55                   	push   %ebp
  800832:	89 e5                	mov    %esp,%ebp
  800834:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800837:	8d 45 10             	lea    0x10(%ebp),%eax
  80083a:	83 c0 04             	add    $0x4,%eax
  80083d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800840:	8b 45 10             	mov    0x10(%ebp),%eax
  800843:	ff 75 f4             	pushl  -0xc(%ebp)
  800846:	50                   	push   %eax
  800847:	ff 75 0c             	pushl  0xc(%ebp)
  80084a:	ff 75 08             	pushl  0x8(%ebp)
  80084d:	e8 16 fc ff ff       	call   800468 <vprintfmt>
  800852:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800855:	90                   	nop
  800856:	c9                   	leave  
  800857:	c3                   	ret    

00800858 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800858:	55                   	push   %ebp
  800859:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80085b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085e:	8b 40 08             	mov    0x8(%eax),%eax
  800861:	8d 50 01             	lea    0x1(%eax),%edx
  800864:	8b 45 0c             	mov    0xc(%ebp),%eax
  800867:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80086a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086d:	8b 10                	mov    (%eax),%edx
  80086f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800872:	8b 40 04             	mov    0x4(%eax),%eax
  800875:	39 c2                	cmp    %eax,%edx
  800877:	73 12                	jae    80088b <sprintputch+0x33>
		*b->buf++ = ch;
  800879:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087c:	8b 00                	mov    (%eax),%eax
  80087e:	8d 48 01             	lea    0x1(%eax),%ecx
  800881:	8b 55 0c             	mov    0xc(%ebp),%edx
  800884:	89 0a                	mov    %ecx,(%edx)
  800886:	8b 55 08             	mov    0x8(%ebp),%edx
  800889:	88 10                	mov    %dl,(%eax)
}
  80088b:	90                   	nop
  80088c:	5d                   	pop    %ebp
  80088d:	c3                   	ret    

0080088e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80088e:	55                   	push   %ebp
  80088f:	89 e5                	mov    %esp,%ebp
  800891:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80089a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089d:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a3:	01 d0                	add    %edx,%eax
  8008a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008af:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008b3:	74 06                	je     8008bb <vsnprintf+0x2d>
  8008b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b9:	7f 07                	jg     8008c2 <vsnprintf+0x34>
		return -E_INVAL;
  8008bb:	b8 03 00 00 00       	mov    $0x3,%eax
  8008c0:	eb 20                	jmp    8008e2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008c2:	ff 75 14             	pushl  0x14(%ebp)
  8008c5:	ff 75 10             	pushl  0x10(%ebp)
  8008c8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008cb:	50                   	push   %eax
  8008cc:	68 58 08 80 00       	push   $0x800858
  8008d1:	e8 92 fb ff ff       	call   800468 <vprintfmt>
  8008d6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008dc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008df:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008e2:	c9                   	leave  
  8008e3:	c3                   	ret    

008008e4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008e4:	55                   	push   %ebp
  8008e5:	89 e5                	mov    %esp,%ebp
  8008e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ed:	83 c0 04             	add    $0x4,%eax
  8008f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f9:	50                   	push   %eax
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	ff 75 08             	pushl  0x8(%ebp)
  800900:	e8 89 ff ff ff       	call   80088e <vsnprintf>
  800905:	83 c4 10             	add    $0x10,%esp
  800908:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80090b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80090e:	c9                   	leave  
  80090f:	c3                   	ret    

00800910 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800910:	55                   	push   %ebp
  800911:	89 e5                	mov    %esp,%ebp
  800913:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800916:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80091d:	eb 06                	jmp    800925 <strlen+0x15>
		n++;
  80091f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800922:	ff 45 08             	incl   0x8(%ebp)
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	8a 00                	mov    (%eax),%al
  80092a:	84 c0                	test   %al,%al
  80092c:	75 f1                	jne    80091f <strlen+0xf>
		n++;
	return n;
  80092e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800931:	c9                   	leave  
  800932:	c3                   	ret    

00800933 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800933:	55                   	push   %ebp
  800934:	89 e5                	mov    %esp,%ebp
  800936:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800939:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800940:	eb 09                	jmp    80094b <strnlen+0x18>
		n++;
  800942:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800945:	ff 45 08             	incl   0x8(%ebp)
  800948:	ff 4d 0c             	decl   0xc(%ebp)
  80094b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80094f:	74 09                	je     80095a <strnlen+0x27>
  800951:	8b 45 08             	mov    0x8(%ebp),%eax
  800954:	8a 00                	mov    (%eax),%al
  800956:	84 c0                	test   %al,%al
  800958:	75 e8                	jne    800942 <strnlen+0xf>
		n++;
	return n;
  80095a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80095d:	c9                   	leave  
  80095e:	c3                   	ret    

0080095f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80095f:	55                   	push   %ebp
  800960:	89 e5                	mov    %esp,%ebp
  800962:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80096b:	90                   	nop
  80096c:	8b 45 08             	mov    0x8(%ebp),%eax
  80096f:	8d 50 01             	lea    0x1(%eax),%edx
  800972:	89 55 08             	mov    %edx,0x8(%ebp)
  800975:	8b 55 0c             	mov    0xc(%ebp),%edx
  800978:	8d 4a 01             	lea    0x1(%edx),%ecx
  80097b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80097e:	8a 12                	mov    (%edx),%dl
  800980:	88 10                	mov    %dl,(%eax)
  800982:	8a 00                	mov    (%eax),%al
  800984:	84 c0                	test   %al,%al
  800986:	75 e4                	jne    80096c <strcpy+0xd>
		/* do nothing */;
	return ret;
  800988:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80098b:	c9                   	leave  
  80098c:	c3                   	ret    

0080098d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
  800990:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800999:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009a0:	eb 1f                	jmp    8009c1 <strncpy+0x34>
		*dst++ = *src;
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	8d 50 01             	lea    0x1(%eax),%edx
  8009a8:	89 55 08             	mov    %edx,0x8(%ebp)
  8009ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ae:	8a 12                	mov    (%edx),%dl
  8009b0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b5:	8a 00                	mov    (%eax),%al
  8009b7:	84 c0                	test   %al,%al
  8009b9:	74 03                	je     8009be <strncpy+0x31>
			src++;
  8009bb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009be:	ff 45 fc             	incl   -0x4(%ebp)
  8009c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009c4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009c7:	72 d9                	jb     8009a2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009cc:	c9                   	leave  
  8009cd:	c3                   	ret    

008009ce <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009ce:	55                   	push   %ebp
  8009cf:	89 e5                	mov    %esp,%ebp
  8009d1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009de:	74 30                	je     800a10 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009e0:	eb 16                	jmp    8009f8 <strlcpy+0x2a>
			*dst++ = *src++;
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	8d 50 01             	lea    0x1(%eax),%edx
  8009e8:	89 55 08             	mov    %edx,0x8(%ebp)
  8009eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ee:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009f1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009f4:	8a 12                	mov    (%edx),%dl
  8009f6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009f8:	ff 4d 10             	decl   0x10(%ebp)
  8009fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ff:	74 09                	je     800a0a <strlcpy+0x3c>
  800a01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a04:	8a 00                	mov    (%eax),%al
  800a06:	84 c0                	test   %al,%al
  800a08:	75 d8                	jne    8009e2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a10:	8b 55 08             	mov    0x8(%ebp),%edx
  800a13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a16:	29 c2                	sub    %eax,%edx
  800a18:	89 d0                	mov    %edx,%eax
}
  800a1a:	c9                   	leave  
  800a1b:	c3                   	ret    

00800a1c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a1c:	55                   	push   %ebp
  800a1d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a1f:	eb 06                	jmp    800a27 <strcmp+0xb>
		p++, q++;
  800a21:	ff 45 08             	incl   0x8(%ebp)
  800a24:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	8a 00                	mov    (%eax),%al
  800a2c:	84 c0                	test   %al,%al
  800a2e:	74 0e                	je     800a3e <strcmp+0x22>
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	8a 10                	mov    (%eax),%dl
  800a35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a38:	8a 00                	mov    (%eax),%al
  800a3a:	38 c2                	cmp    %al,%dl
  800a3c:	74 e3                	je     800a21 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	8a 00                	mov    (%eax),%al
  800a43:	0f b6 d0             	movzbl %al,%edx
  800a46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a49:	8a 00                	mov    (%eax),%al
  800a4b:	0f b6 c0             	movzbl %al,%eax
  800a4e:	29 c2                	sub    %eax,%edx
  800a50:	89 d0                	mov    %edx,%eax
}
  800a52:	5d                   	pop    %ebp
  800a53:	c3                   	ret    

00800a54 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a54:	55                   	push   %ebp
  800a55:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a57:	eb 09                	jmp    800a62 <strncmp+0xe>
		n--, p++, q++;
  800a59:	ff 4d 10             	decl   0x10(%ebp)
  800a5c:	ff 45 08             	incl   0x8(%ebp)
  800a5f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a66:	74 17                	je     800a7f <strncmp+0x2b>
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	8a 00                	mov    (%eax),%al
  800a6d:	84 c0                	test   %al,%al
  800a6f:	74 0e                	je     800a7f <strncmp+0x2b>
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	8a 10                	mov    (%eax),%dl
  800a76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a79:	8a 00                	mov    (%eax),%al
  800a7b:	38 c2                	cmp    %al,%dl
  800a7d:	74 da                	je     800a59 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a83:	75 07                	jne    800a8c <strncmp+0x38>
		return 0;
  800a85:	b8 00 00 00 00       	mov    $0x0,%eax
  800a8a:	eb 14                	jmp    800aa0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	8a 00                	mov    (%eax),%al
  800a91:	0f b6 d0             	movzbl %al,%edx
  800a94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	0f b6 c0             	movzbl %al,%eax
  800a9c:	29 c2                	sub    %eax,%edx
  800a9e:	89 d0                	mov    %edx,%eax
}
  800aa0:	5d                   	pop    %ebp
  800aa1:	c3                   	ret    

00800aa2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aa2:	55                   	push   %ebp
  800aa3:	89 e5                	mov    %esp,%ebp
  800aa5:	83 ec 04             	sub    $0x4,%esp
  800aa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aab:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aae:	eb 12                	jmp    800ac2 <strchr+0x20>
		if (*s == c)
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	8a 00                	mov    (%eax),%al
  800ab5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ab8:	75 05                	jne    800abf <strchr+0x1d>
			return (char *) s;
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	eb 11                	jmp    800ad0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800abf:	ff 45 08             	incl   0x8(%ebp)
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	8a 00                	mov    (%eax),%al
  800ac7:	84 c0                	test   %al,%al
  800ac9:	75 e5                	jne    800ab0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800acb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ad0:	c9                   	leave  
  800ad1:	c3                   	ret    

00800ad2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ad2:	55                   	push   %ebp
  800ad3:	89 e5                	mov    %esp,%ebp
  800ad5:	83 ec 04             	sub    $0x4,%esp
  800ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ade:	eb 0d                	jmp    800aed <strfind+0x1b>
		if (*s == c)
  800ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae3:	8a 00                	mov    (%eax),%al
  800ae5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ae8:	74 0e                	je     800af8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aea:	ff 45 08             	incl   0x8(%ebp)
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	8a 00                	mov    (%eax),%al
  800af2:	84 c0                	test   %al,%al
  800af4:	75 ea                	jne    800ae0 <strfind+0xe>
  800af6:	eb 01                	jmp    800af9 <strfind+0x27>
		if (*s == c)
			break;
  800af8:	90                   	nop
	return (char *) s;
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800afc:	c9                   	leave  
  800afd:	c3                   	ret    

00800afe <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800afe:	55                   	push   %ebp
  800aff:	89 e5                	mov    %esp,%ebp
  800b01:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b0a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b10:	eb 0e                	jmp    800b20 <memset+0x22>
		*p++ = c;
  800b12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b15:	8d 50 01             	lea    0x1(%eax),%edx
  800b18:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b1e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b20:	ff 4d f8             	decl   -0x8(%ebp)
  800b23:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b27:	79 e9                	jns    800b12 <memset+0x14>
		*p++ = c;

	return v;
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b2c:	c9                   	leave  
  800b2d:	c3                   	ret    

00800b2e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b2e:	55                   	push   %ebp
  800b2f:	89 e5                	mov    %esp,%ebp
  800b31:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b37:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b40:	eb 16                	jmp    800b58 <memcpy+0x2a>
		*d++ = *s++;
  800b42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b45:	8d 50 01             	lea    0x1(%eax),%edx
  800b48:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b4e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b51:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b54:	8a 12                	mov    (%edx),%dl
  800b56:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b58:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b5e:	89 55 10             	mov    %edx,0x10(%ebp)
  800b61:	85 c0                	test   %eax,%eax
  800b63:	75 dd                	jne    800b42 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b68:	c9                   	leave  
  800b69:	c3                   	ret    

00800b6a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b6a:	55                   	push   %ebp
  800b6b:	89 e5                	mov    %esp,%ebp
  800b6d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
  800b79:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b7f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b82:	73 50                	jae    800bd4 <memmove+0x6a>
  800b84:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b87:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8a:	01 d0                	add    %edx,%eax
  800b8c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b8f:	76 43                	jbe    800bd4 <memmove+0x6a>
		s += n;
  800b91:	8b 45 10             	mov    0x10(%ebp),%eax
  800b94:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b97:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b9d:	eb 10                	jmp    800baf <memmove+0x45>
			*--d = *--s;
  800b9f:	ff 4d f8             	decl   -0x8(%ebp)
  800ba2:	ff 4d fc             	decl   -0x4(%ebp)
  800ba5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba8:	8a 10                	mov    (%eax),%dl
  800baa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bad:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800baf:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bb5:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb8:	85 c0                	test   %eax,%eax
  800bba:	75 e3                	jne    800b9f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bbc:	eb 23                	jmp    800be1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc1:	8d 50 01             	lea    0x1(%eax),%edx
  800bc4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bc7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bca:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bcd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bd0:	8a 12                	mov    (%edx),%dl
  800bd2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bda:	89 55 10             	mov    %edx,0x10(%ebp)
  800bdd:	85 c0                	test   %eax,%eax
  800bdf:	75 dd                	jne    800bbe <memmove+0x54>
			*d++ = *s++;

	return dst;
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be4:	c9                   	leave  
  800be5:	c3                   	ret    

00800be6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800be6:	55                   	push   %ebp
  800be7:	89 e5                	mov    %esp,%ebp
  800be9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bf8:	eb 2a                	jmp    800c24 <memcmp+0x3e>
		if (*s1 != *s2)
  800bfa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfd:	8a 10                	mov    (%eax),%dl
  800bff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c02:	8a 00                	mov    (%eax),%al
  800c04:	38 c2                	cmp    %al,%dl
  800c06:	74 16                	je     800c1e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0b:	8a 00                	mov    (%eax),%al
  800c0d:	0f b6 d0             	movzbl %al,%edx
  800c10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	0f b6 c0             	movzbl %al,%eax
  800c18:	29 c2                	sub    %eax,%edx
  800c1a:	89 d0                	mov    %edx,%eax
  800c1c:	eb 18                	jmp    800c36 <memcmp+0x50>
		s1++, s2++;
  800c1e:	ff 45 fc             	incl   -0x4(%ebp)
  800c21:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c24:	8b 45 10             	mov    0x10(%ebp),%eax
  800c27:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c2a:	89 55 10             	mov    %edx,0x10(%ebp)
  800c2d:	85 c0                	test   %eax,%eax
  800c2f:	75 c9                	jne    800bfa <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c31:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c36:	c9                   	leave  
  800c37:	c3                   	ret    

00800c38 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c38:	55                   	push   %ebp
  800c39:	89 e5                	mov    %esp,%ebp
  800c3b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c3e:	8b 55 08             	mov    0x8(%ebp),%edx
  800c41:	8b 45 10             	mov    0x10(%ebp),%eax
  800c44:	01 d0                	add    %edx,%eax
  800c46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c49:	eb 15                	jmp    800c60 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	8a 00                	mov    (%eax),%al
  800c50:	0f b6 d0             	movzbl %al,%edx
  800c53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c56:	0f b6 c0             	movzbl %al,%eax
  800c59:	39 c2                	cmp    %eax,%edx
  800c5b:	74 0d                	je     800c6a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c5d:	ff 45 08             	incl   0x8(%ebp)
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c66:	72 e3                	jb     800c4b <memfind+0x13>
  800c68:	eb 01                	jmp    800c6b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c6a:	90                   	nop
	return (void *) s;
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c6e:	c9                   	leave  
  800c6f:	c3                   	ret    

00800c70 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c70:	55                   	push   %ebp
  800c71:	89 e5                	mov    %esp,%ebp
  800c73:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c7d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c84:	eb 03                	jmp    800c89 <strtol+0x19>
		s++;
  800c86:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	8a 00                	mov    (%eax),%al
  800c8e:	3c 20                	cmp    $0x20,%al
  800c90:	74 f4                	je     800c86 <strtol+0x16>
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	8a 00                	mov    (%eax),%al
  800c97:	3c 09                	cmp    $0x9,%al
  800c99:	74 eb                	je     800c86 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	3c 2b                	cmp    $0x2b,%al
  800ca2:	75 05                	jne    800ca9 <strtol+0x39>
		s++;
  800ca4:	ff 45 08             	incl   0x8(%ebp)
  800ca7:	eb 13                	jmp    800cbc <strtol+0x4c>
	else if (*s == '-')
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	3c 2d                	cmp    $0x2d,%al
  800cb0:	75 0a                	jne    800cbc <strtol+0x4c>
		s++, neg = 1;
  800cb2:	ff 45 08             	incl   0x8(%ebp)
  800cb5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cbc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc0:	74 06                	je     800cc8 <strtol+0x58>
  800cc2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cc6:	75 20                	jne    800ce8 <strtol+0x78>
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	3c 30                	cmp    $0x30,%al
  800ccf:	75 17                	jne    800ce8 <strtol+0x78>
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	40                   	inc    %eax
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	3c 78                	cmp    $0x78,%al
  800cd9:	75 0d                	jne    800ce8 <strtol+0x78>
		s += 2, base = 16;
  800cdb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cdf:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ce6:	eb 28                	jmp    800d10 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ce8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cec:	75 15                	jne    800d03 <strtol+0x93>
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	3c 30                	cmp    $0x30,%al
  800cf5:	75 0c                	jne    800d03 <strtol+0x93>
		s++, base = 8;
  800cf7:	ff 45 08             	incl   0x8(%ebp)
  800cfa:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d01:	eb 0d                	jmp    800d10 <strtol+0xa0>
	else if (base == 0)
  800d03:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d07:	75 07                	jne    800d10 <strtol+0xa0>
		base = 10;
  800d09:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	3c 2f                	cmp    $0x2f,%al
  800d17:	7e 19                	jle    800d32 <strtol+0xc2>
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	3c 39                	cmp    $0x39,%al
  800d20:	7f 10                	jg     800d32 <strtol+0xc2>
			dig = *s - '0';
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8a 00                	mov    (%eax),%al
  800d27:	0f be c0             	movsbl %al,%eax
  800d2a:	83 e8 30             	sub    $0x30,%eax
  800d2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d30:	eb 42                	jmp    800d74 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	3c 60                	cmp    $0x60,%al
  800d39:	7e 19                	jle    800d54 <strtol+0xe4>
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	3c 7a                	cmp    $0x7a,%al
  800d42:	7f 10                	jg     800d54 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	0f be c0             	movsbl %al,%eax
  800d4c:	83 e8 57             	sub    $0x57,%eax
  800d4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d52:	eb 20                	jmp    800d74 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	3c 40                	cmp    $0x40,%al
  800d5b:	7e 39                	jle    800d96 <strtol+0x126>
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8a 00                	mov    (%eax),%al
  800d62:	3c 5a                	cmp    $0x5a,%al
  800d64:	7f 30                	jg     800d96 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	8a 00                	mov    (%eax),%al
  800d6b:	0f be c0             	movsbl %al,%eax
  800d6e:	83 e8 37             	sub    $0x37,%eax
  800d71:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d74:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d77:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d7a:	7d 19                	jge    800d95 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d7c:	ff 45 08             	incl   0x8(%ebp)
  800d7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d82:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d86:	89 c2                	mov    %eax,%edx
  800d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d8b:	01 d0                	add    %edx,%eax
  800d8d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d90:	e9 7b ff ff ff       	jmp    800d10 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d95:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d96:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d9a:	74 08                	je     800da4 <strtol+0x134>
		*endptr = (char *) s;
  800d9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800da2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800da4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800da8:	74 07                	je     800db1 <strtol+0x141>
  800daa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dad:	f7 d8                	neg    %eax
  800daf:	eb 03                	jmp    800db4 <strtol+0x144>
  800db1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db4:	c9                   	leave  
  800db5:	c3                   	ret    

00800db6 <ltostr>:

void
ltostr(long value, char *str)
{
  800db6:	55                   	push   %ebp
  800db7:	89 e5                	mov    %esp,%ebp
  800db9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dbc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dc3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dce:	79 13                	jns    800de3 <ltostr+0x2d>
	{
		neg = 1;
  800dd0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dda:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ddd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800de0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800deb:	99                   	cltd   
  800dec:	f7 f9                	idiv   %ecx
  800dee:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800df1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df4:	8d 50 01             	lea    0x1(%eax),%edx
  800df7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dfa:	89 c2                	mov    %eax,%edx
  800dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dff:	01 d0                	add    %edx,%eax
  800e01:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e04:	83 c2 30             	add    $0x30,%edx
  800e07:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e09:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e0c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e11:	f7 e9                	imul   %ecx
  800e13:	c1 fa 02             	sar    $0x2,%edx
  800e16:	89 c8                	mov    %ecx,%eax
  800e18:	c1 f8 1f             	sar    $0x1f,%eax
  800e1b:	29 c2                	sub    %eax,%edx
  800e1d:	89 d0                	mov    %edx,%eax
  800e1f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e22:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e25:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e2a:	f7 e9                	imul   %ecx
  800e2c:	c1 fa 02             	sar    $0x2,%edx
  800e2f:	89 c8                	mov    %ecx,%eax
  800e31:	c1 f8 1f             	sar    $0x1f,%eax
  800e34:	29 c2                	sub    %eax,%edx
  800e36:	89 d0                	mov    %edx,%eax
  800e38:	c1 e0 02             	shl    $0x2,%eax
  800e3b:	01 d0                	add    %edx,%eax
  800e3d:	01 c0                	add    %eax,%eax
  800e3f:	29 c1                	sub    %eax,%ecx
  800e41:	89 ca                	mov    %ecx,%edx
  800e43:	85 d2                	test   %edx,%edx
  800e45:	75 9c                	jne    800de3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e51:	48                   	dec    %eax
  800e52:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e55:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e59:	74 3d                	je     800e98 <ltostr+0xe2>
		start = 1 ;
  800e5b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e62:	eb 34                	jmp    800e98 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6a:	01 d0                	add    %edx,%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e71:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	01 c2                	add    %eax,%edx
  800e79:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7f:	01 c8                	add    %ecx,%eax
  800e81:	8a 00                	mov    (%eax),%al
  800e83:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e85:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8b:	01 c2                	add    %eax,%edx
  800e8d:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e90:	88 02                	mov    %al,(%edx)
		start++ ;
  800e92:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e95:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e98:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e9b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e9e:	7c c4                	jl     800e64 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ea0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ea3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea6:	01 d0                	add    %edx,%eax
  800ea8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eab:	90                   	nop
  800eac:	c9                   	leave  
  800ead:	c3                   	ret    

00800eae <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800eae:	55                   	push   %ebp
  800eaf:	89 e5                	mov    %esp,%ebp
  800eb1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800eb4:	ff 75 08             	pushl  0x8(%ebp)
  800eb7:	e8 54 fa ff ff       	call   800910 <strlen>
  800ebc:	83 c4 04             	add    $0x4,%esp
  800ebf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ec2:	ff 75 0c             	pushl  0xc(%ebp)
  800ec5:	e8 46 fa ff ff       	call   800910 <strlen>
  800eca:	83 c4 04             	add    $0x4,%esp
  800ecd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ed0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ed7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ede:	eb 17                	jmp    800ef7 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ee0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee6:	01 c2                	add    %eax,%edx
  800ee8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	01 c8                	add    %ecx,%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ef4:	ff 45 fc             	incl   -0x4(%ebp)
  800ef7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800efd:	7c e1                	jl     800ee0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800eff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f06:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f0d:	eb 1f                	jmp    800f2e <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f12:	8d 50 01             	lea    0x1(%eax),%edx
  800f15:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f18:	89 c2                	mov    %eax,%edx
  800f1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1d:	01 c2                	add    %eax,%edx
  800f1f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f25:	01 c8                	add    %ecx,%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f2b:	ff 45 f8             	incl   -0x8(%ebp)
  800f2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f31:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f34:	7c d9                	jl     800f0f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f36:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f39:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3c:	01 d0                	add    %edx,%eax
  800f3e:	c6 00 00             	movb   $0x0,(%eax)
}
  800f41:	90                   	nop
  800f42:	c9                   	leave  
  800f43:	c3                   	ret    

00800f44 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f44:	55                   	push   %ebp
  800f45:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f47:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f50:	8b 45 14             	mov    0x14(%ebp),%eax
  800f53:	8b 00                	mov    (%eax),%eax
  800f55:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5f:	01 d0                	add    %edx,%eax
  800f61:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f67:	eb 0c                	jmp    800f75 <strsplit+0x31>
			*string++ = 0;
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8d 50 01             	lea    0x1(%eax),%edx
  800f6f:	89 55 08             	mov    %edx,0x8(%ebp)
  800f72:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	84 c0                	test   %al,%al
  800f7c:	74 18                	je     800f96 <strsplit+0x52>
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	8a 00                	mov    (%eax),%al
  800f83:	0f be c0             	movsbl %al,%eax
  800f86:	50                   	push   %eax
  800f87:	ff 75 0c             	pushl  0xc(%ebp)
  800f8a:	e8 13 fb ff ff       	call   800aa2 <strchr>
  800f8f:	83 c4 08             	add    $0x8,%esp
  800f92:	85 c0                	test   %eax,%eax
  800f94:	75 d3                	jne    800f69 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	84 c0                	test   %al,%al
  800f9d:	74 5a                	je     800ff9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa2:	8b 00                	mov    (%eax),%eax
  800fa4:	83 f8 0f             	cmp    $0xf,%eax
  800fa7:	75 07                	jne    800fb0 <strsplit+0x6c>
		{
			return 0;
  800fa9:	b8 00 00 00 00       	mov    $0x0,%eax
  800fae:	eb 66                	jmp    801016 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb3:	8b 00                	mov    (%eax),%eax
  800fb5:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb8:	8b 55 14             	mov    0x14(%ebp),%edx
  800fbb:	89 0a                	mov    %ecx,(%edx)
  800fbd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc7:	01 c2                	add    %eax,%edx
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fce:	eb 03                	jmp    800fd3 <strsplit+0x8f>
			string++;
  800fd0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	84 c0                	test   %al,%al
  800fda:	74 8b                	je     800f67 <strsplit+0x23>
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8a 00                	mov    (%eax),%al
  800fe1:	0f be c0             	movsbl %al,%eax
  800fe4:	50                   	push   %eax
  800fe5:	ff 75 0c             	pushl  0xc(%ebp)
  800fe8:	e8 b5 fa ff ff       	call   800aa2 <strchr>
  800fed:	83 c4 08             	add    $0x8,%esp
  800ff0:	85 c0                	test   %eax,%eax
  800ff2:	74 dc                	je     800fd0 <strsplit+0x8c>
			string++;
	}
  800ff4:	e9 6e ff ff ff       	jmp    800f67 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800ff9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800ffa:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffd:	8b 00                	mov    (%eax),%eax
  800fff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801006:	8b 45 10             	mov    0x10(%ebp),%eax
  801009:	01 d0                	add    %edx,%eax
  80100b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801011:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801016:	c9                   	leave  
  801017:	c3                   	ret    

00801018 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	57                   	push   %edi
  80101c:	56                   	push   %esi
  80101d:	53                   	push   %ebx
  80101e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	8b 55 0c             	mov    0xc(%ebp),%edx
  801027:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80102a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80102d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801030:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801033:	cd 30                	int    $0x30
  801035:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801038:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103b:	83 c4 10             	add    $0x10,%esp
  80103e:	5b                   	pop    %ebx
  80103f:	5e                   	pop    %esi
  801040:	5f                   	pop    %edi
  801041:	5d                   	pop    %ebp
  801042:	c3                   	ret    

00801043 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801043:	55                   	push   %ebp
  801044:	89 e5                	mov    %esp,%ebp
  801046:	83 ec 04             	sub    $0x4,%esp
  801049:	8b 45 10             	mov    0x10(%ebp),%eax
  80104c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80104f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	6a 00                	push   $0x0
  801058:	6a 00                	push   $0x0
  80105a:	52                   	push   %edx
  80105b:	ff 75 0c             	pushl  0xc(%ebp)
  80105e:	50                   	push   %eax
  80105f:	6a 00                	push   $0x0
  801061:	e8 b2 ff ff ff       	call   801018 <syscall>
  801066:	83 c4 18             	add    $0x18,%esp
}
  801069:	90                   	nop
  80106a:	c9                   	leave  
  80106b:	c3                   	ret    

0080106c <sys_cgetc>:

int
sys_cgetc(void)
{
  80106c:	55                   	push   %ebp
  80106d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80106f:	6a 00                	push   $0x0
  801071:	6a 00                	push   $0x0
  801073:	6a 00                	push   $0x0
  801075:	6a 00                	push   $0x0
  801077:	6a 00                	push   $0x0
  801079:	6a 01                	push   $0x1
  80107b:	e8 98 ff ff ff       	call   801018 <syscall>
  801080:	83 c4 18             	add    $0x18,%esp
}
  801083:	c9                   	leave  
  801084:	c3                   	ret    

00801085 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801085:	55                   	push   %ebp
  801086:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	6a 00                	push   $0x0
  801093:	50                   	push   %eax
  801094:	6a 05                	push   $0x5
  801096:	e8 7d ff ff ff       	call   801018 <syscall>
  80109b:	83 c4 18             	add    $0x18,%esp
}
  80109e:	c9                   	leave  
  80109f:	c3                   	ret    

008010a0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010a0:	55                   	push   %ebp
  8010a1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 00                	push   $0x0
  8010ad:	6a 02                	push   $0x2
  8010af:	e8 64 ff ff ff       	call   801018 <syscall>
  8010b4:	83 c4 18             	add    $0x18,%esp
}
  8010b7:	c9                   	leave  
  8010b8:	c3                   	ret    

008010b9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010b9:	55                   	push   %ebp
  8010ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010bc:	6a 00                	push   $0x0
  8010be:	6a 00                	push   $0x0
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 03                	push   $0x3
  8010c8:	e8 4b ff ff ff       	call   801018 <syscall>
  8010cd:	83 c4 18             	add    $0x18,%esp
}
  8010d0:	c9                   	leave  
  8010d1:	c3                   	ret    

008010d2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010d2:	55                   	push   %ebp
  8010d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010d5:	6a 00                	push   $0x0
  8010d7:	6a 00                	push   $0x0
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 04                	push   $0x4
  8010e1:	e8 32 ff ff ff       	call   801018 <syscall>
  8010e6:	83 c4 18             	add    $0x18,%esp
}
  8010e9:	c9                   	leave  
  8010ea:	c3                   	ret    

008010eb <sys_env_exit>:


void sys_env_exit(void)
{
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 00                	push   $0x0
  8010f8:	6a 06                	push   $0x6
  8010fa:	e8 19 ff ff ff       	call   801018 <syscall>
  8010ff:	83 c4 18             	add    $0x18,%esp
}
  801102:	90                   	nop
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801108:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	6a 00                	push   $0x0
  801110:	6a 00                	push   $0x0
  801112:	6a 00                	push   $0x0
  801114:	52                   	push   %edx
  801115:	50                   	push   %eax
  801116:	6a 07                	push   $0x7
  801118:	e8 fb fe ff ff       	call   801018 <syscall>
  80111d:	83 c4 18             	add    $0x18,%esp
}
  801120:	c9                   	leave  
  801121:	c3                   	ret    

00801122 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801122:	55                   	push   %ebp
  801123:	89 e5                	mov    %esp,%ebp
  801125:	56                   	push   %esi
  801126:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801127:	8b 75 18             	mov    0x18(%ebp),%esi
  80112a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80112d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801130:	8b 55 0c             	mov    0xc(%ebp),%edx
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	56                   	push   %esi
  801137:	53                   	push   %ebx
  801138:	51                   	push   %ecx
  801139:	52                   	push   %edx
  80113a:	50                   	push   %eax
  80113b:	6a 08                	push   $0x8
  80113d:	e8 d6 fe ff ff       	call   801018 <syscall>
  801142:	83 c4 18             	add    $0x18,%esp
}
  801145:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801148:	5b                   	pop    %ebx
  801149:	5e                   	pop    %esi
  80114a:	5d                   	pop    %ebp
  80114b:	c3                   	ret    

0080114c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80114f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801152:	8b 45 08             	mov    0x8(%ebp),%eax
  801155:	6a 00                	push   $0x0
  801157:	6a 00                	push   $0x0
  801159:	6a 00                	push   $0x0
  80115b:	52                   	push   %edx
  80115c:	50                   	push   %eax
  80115d:	6a 09                	push   $0x9
  80115f:	e8 b4 fe ff ff       	call   801018 <syscall>
  801164:	83 c4 18             	add    $0x18,%esp
}
  801167:	c9                   	leave  
  801168:	c3                   	ret    

00801169 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801169:	55                   	push   %ebp
  80116a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80116c:	6a 00                	push   $0x0
  80116e:	6a 00                	push   $0x0
  801170:	6a 00                	push   $0x0
  801172:	ff 75 0c             	pushl  0xc(%ebp)
  801175:	ff 75 08             	pushl  0x8(%ebp)
  801178:	6a 0a                	push   $0xa
  80117a:	e8 99 fe ff ff       	call   801018 <syscall>
  80117f:	83 c4 18             	add    $0x18,%esp
}
  801182:	c9                   	leave  
  801183:	c3                   	ret    

00801184 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801184:	55                   	push   %ebp
  801185:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801187:	6a 00                	push   $0x0
  801189:	6a 00                	push   $0x0
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 0b                	push   $0xb
  801193:	e8 80 fe ff ff       	call   801018 <syscall>
  801198:	83 c4 18             	add    $0x18,%esp
}
  80119b:	c9                   	leave  
  80119c:	c3                   	ret    

0080119d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80119d:	55                   	push   %ebp
  80119e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 00                	push   $0x0
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 0c                	push   $0xc
  8011ac:	e8 67 fe ff ff       	call   801018 <syscall>
  8011b1:	83 c4 18             	add    $0x18,%esp
}
  8011b4:	c9                   	leave  
  8011b5:	c3                   	ret    

008011b6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011b6:	55                   	push   %ebp
  8011b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 0d                	push   $0xd
  8011c5:	e8 4e fe ff ff       	call   801018 <syscall>
  8011ca:	83 c4 18             	add    $0x18,%esp
}
  8011cd:	c9                   	leave  
  8011ce:	c3                   	ret    

008011cf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011cf:	55                   	push   %ebp
  8011d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	ff 75 0c             	pushl  0xc(%ebp)
  8011db:	ff 75 08             	pushl  0x8(%ebp)
  8011de:	6a 11                	push   $0x11
  8011e0:	e8 33 fe ff ff       	call   801018 <syscall>
  8011e5:	83 c4 18             	add    $0x18,%esp
	return;
  8011e8:	90                   	nop
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	ff 75 0c             	pushl  0xc(%ebp)
  8011f7:	ff 75 08             	pushl  0x8(%ebp)
  8011fa:	6a 12                	push   $0x12
  8011fc:	e8 17 fe ff ff       	call   801018 <syscall>
  801201:	83 c4 18             	add    $0x18,%esp
	return ;
  801204:	90                   	nop
}
  801205:	c9                   	leave  
  801206:	c3                   	ret    

00801207 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 00                	push   $0x0
  801210:	6a 00                	push   $0x0
  801212:	6a 00                	push   $0x0
  801214:	6a 0e                	push   $0xe
  801216:	e8 fd fd ff ff       	call   801018 <syscall>
  80121b:	83 c4 18             	add    $0x18,%esp
}
  80121e:	c9                   	leave  
  80121f:	c3                   	ret    

00801220 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801220:	55                   	push   %ebp
  801221:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801223:	6a 00                	push   $0x0
  801225:	6a 00                	push   $0x0
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	ff 75 08             	pushl  0x8(%ebp)
  80122e:	6a 0f                	push   $0xf
  801230:	e8 e3 fd ff ff       	call   801018 <syscall>
  801235:	83 c4 18             	add    $0x18,%esp
}
  801238:	c9                   	leave  
  801239:	c3                   	ret    

0080123a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80123a:	55                   	push   %ebp
  80123b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 00                	push   $0x0
  801247:	6a 10                	push   $0x10
  801249:	e8 ca fd ff ff       	call   801018 <syscall>
  80124e:	83 c4 18             	add    $0x18,%esp
}
  801251:	90                   	nop
  801252:	c9                   	leave  
  801253:	c3                   	ret    

00801254 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801254:	55                   	push   %ebp
  801255:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 00                	push   $0x0
  801261:	6a 14                	push   $0x14
  801263:	e8 b0 fd ff ff       	call   801018 <syscall>
  801268:	83 c4 18             	add    $0x18,%esp
}
  80126b:	90                   	nop
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 00                	push   $0x0
  80127b:	6a 15                	push   $0x15
  80127d:	e8 96 fd ff ff       	call   801018 <syscall>
  801282:	83 c4 18             	add    $0x18,%esp
}
  801285:	90                   	nop
  801286:	c9                   	leave  
  801287:	c3                   	ret    

00801288 <sys_cputc>:


void
sys_cputc(const char c)
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
  80128b:	83 ec 04             	sub    $0x4,%esp
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801294:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	50                   	push   %eax
  8012a1:	6a 16                	push   $0x16
  8012a3:	e8 70 fd ff ff       	call   801018 <syscall>
  8012a8:	83 c4 18             	add    $0x18,%esp
}
  8012ab:	90                   	nop
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 00                	push   $0x0
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 17                	push   $0x17
  8012bd:	e8 56 fd ff ff       	call   801018 <syscall>
  8012c2:	83 c4 18             	add    $0x18,%esp
}
  8012c5:	90                   	nop
  8012c6:	c9                   	leave  
  8012c7:	c3                   	ret    

008012c8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	ff 75 0c             	pushl  0xc(%ebp)
  8012d7:	50                   	push   %eax
  8012d8:	6a 18                	push   $0x18
  8012da:	e8 39 fd ff ff       	call   801018 <syscall>
  8012df:	83 c4 18             	add    $0x18,%esp
}
  8012e2:	c9                   	leave  
  8012e3:	c3                   	ret    

008012e4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012e4:	55                   	push   %ebp
  8012e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	52                   	push   %edx
  8012f4:	50                   	push   %eax
  8012f5:	6a 1b                	push   $0x1b
  8012f7:	e8 1c fd ff ff       	call   801018 <syscall>
  8012fc:	83 c4 18             	add    $0x18,%esp
}
  8012ff:	c9                   	leave  
  801300:	c3                   	ret    

00801301 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801301:	55                   	push   %ebp
  801302:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801304:	8b 55 0c             	mov    0xc(%ebp),%edx
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	52                   	push   %edx
  801311:	50                   	push   %eax
  801312:	6a 19                	push   $0x19
  801314:	e8 ff fc ff ff       	call   801018 <syscall>
  801319:	83 c4 18             	add    $0x18,%esp
}
  80131c:	90                   	nop
  80131d:	c9                   	leave  
  80131e:	c3                   	ret    

0080131f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801322:	8b 55 0c             	mov    0xc(%ebp),%edx
  801325:	8b 45 08             	mov    0x8(%ebp),%eax
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	52                   	push   %edx
  80132f:	50                   	push   %eax
  801330:	6a 1a                	push   $0x1a
  801332:	e8 e1 fc ff ff       	call   801018 <syscall>
  801337:	83 c4 18             	add    $0x18,%esp
}
  80133a:	90                   	nop
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
  801340:	83 ec 04             	sub    $0x4,%esp
  801343:	8b 45 10             	mov    0x10(%ebp),%eax
  801346:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801349:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80134c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	6a 00                	push   $0x0
  801355:	51                   	push   %ecx
  801356:	52                   	push   %edx
  801357:	ff 75 0c             	pushl  0xc(%ebp)
  80135a:	50                   	push   %eax
  80135b:	6a 1c                	push   $0x1c
  80135d:	e8 b6 fc ff ff       	call   801018 <syscall>
  801362:	83 c4 18             	add    $0x18,%esp
}
  801365:	c9                   	leave  
  801366:	c3                   	ret    

00801367 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801367:	55                   	push   %ebp
  801368:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80136a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	52                   	push   %edx
  801377:	50                   	push   %eax
  801378:	6a 1d                	push   $0x1d
  80137a:	e8 99 fc ff ff       	call   801018 <syscall>
  80137f:	83 c4 18             	add    $0x18,%esp
}
  801382:	c9                   	leave  
  801383:	c3                   	ret    

00801384 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801384:	55                   	push   %ebp
  801385:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801387:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80138a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	6a 00                	push   $0x0
  801392:	6a 00                	push   $0x0
  801394:	51                   	push   %ecx
  801395:	52                   	push   %edx
  801396:	50                   	push   %eax
  801397:	6a 1e                	push   $0x1e
  801399:	e8 7a fc ff ff       	call   801018 <syscall>
  80139e:	83 c4 18             	add    $0x18,%esp
}
  8013a1:	c9                   	leave  
  8013a2:	c3                   	ret    

008013a3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	6a 00                	push   $0x0
  8013b2:	52                   	push   %edx
  8013b3:	50                   	push   %eax
  8013b4:	6a 1f                	push   $0x1f
  8013b6:	e8 5d fc ff ff       	call   801018 <syscall>
  8013bb:	83 c4 18             	add    $0x18,%esp
}
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 20                	push   $0x20
  8013cf:	e8 44 fc ff ff       	call   801018 <syscall>
  8013d4:	83 c4 18             	add    $0x18,%esp
}
  8013d7:	c9                   	leave  
  8013d8:	c3                   	ret    

008013d9 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013d9:	55                   	push   %ebp
  8013da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	ff 75 10             	pushl  0x10(%ebp)
  8013e6:	ff 75 0c             	pushl  0xc(%ebp)
  8013e9:	50                   	push   %eax
  8013ea:	6a 21                	push   $0x21
  8013ec:	e8 27 fc ff ff       	call   801018 <syscall>
  8013f1:	83 c4 18             	add    $0x18,%esp
}
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	50                   	push   %eax
  801405:	6a 22                	push   $0x22
  801407:	e8 0c fc ff ff       	call   801018 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	90                   	nop
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	50                   	push   %eax
  801421:	6a 23                	push   $0x23
  801423:	e8 f0 fb ff ff       	call   801018 <syscall>
  801428:	83 c4 18             	add    $0x18,%esp
}
  80142b:	90                   	nop
  80142c:	c9                   	leave  
  80142d:	c3                   	ret    

0080142e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
  801431:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801434:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801437:	8d 50 04             	lea    0x4(%eax),%edx
  80143a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	52                   	push   %edx
  801444:	50                   	push   %eax
  801445:	6a 24                	push   $0x24
  801447:	e8 cc fb ff ff       	call   801018 <syscall>
  80144c:	83 c4 18             	add    $0x18,%esp
	return result;
  80144f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801452:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801455:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801458:	89 01                	mov    %eax,(%ecx)
  80145a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	c9                   	leave  
  801461:	c2 04 00             	ret    $0x4

00801464 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801464:	55                   	push   %ebp
  801465:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	ff 75 10             	pushl  0x10(%ebp)
  80146e:	ff 75 0c             	pushl  0xc(%ebp)
  801471:	ff 75 08             	pushl  0x8(%ebp)
  801474:	6a 13                	push   $0x13
  801476:	e8 9d fb ff ff       	call   801018 <syscall>
  80147b:	83 c4 18             	add    $0x18,%esp
	return ;
  80147e:	90                   	nop
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <sys_rcr2>:
uint32 sys_rcr2()
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 25                	push   $0x25
  801490:	e8 83 fb ff ff       	call   801018 <syscall>
  801495:	83 c4 18             	add    $0x18,%esp
}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
  80149d:	83 ec 04             	sub    $0x4,%esp
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014a6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	50                   	push   %eax
  8014b3:	6a 26                	push   $0x26
  8014b5:	e8 5e fb ff ff       	call   801018 <syscall>
  8014ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8014bd:	90                   	nop
}
  8014be:	c9                   	leave  
  8014bf:	c3                   	ret    

008014c0 <rsttst>:
void rsttst()
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 28                	push   $0x28
  8014cf:	e8 44 fb ff ff       	call   801018 <syscall>
  8014d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d7:	90                   	nop
}
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	83 ec 04             	sub    $0x4,%esp
  8014e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014e6:	8b 55 18             	mov    0x18(%ebp),%edx
  8014e9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ed:	52                   	push   %edx
  8014ee:	50                   	push   %eax
  8014ef:	ff 75 10             	pushl  0x10(%ebp)
  8014f2:	ff 75 0c             	pushl  0xc(%ebp)
  8014f5:	ff 75 08             	pushl  0x8(%ebp)
  8014f8:	6a 27                	push   $0x27
  8014fa:	e8 19 fb ff ff       	call   801018 <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801502:	90                   	nop
}
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <chktst>:
void chktst(uint32 n)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	ff 75 08             	pushl  0x8(%ebp)
  801513:	6a 29                	push   $0x29
  801515:	e8 fe fa ff ff       	call   801018 <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
	return ;
  80151d:	90                   	nop
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <inctst>:

void inctst()
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 2a                	push   $0x2a
  80152f:	e8 e4 fa ff ff       	call   801018 <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
	return ;
  801537:	90                   	nop
}
  801538:	c9                   	leave  
  801539:	c3                   	ret    

0080153a <gettst>:
uint32 gettst()
{
  80153a:	55                   	push   %ebp
  80153b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 2b                	push   $0x2b
  801549:	e8 ca fa ff ff       	call   801018 <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
  801556:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 2c                	push   $0x2c
  801565:	e8 ae fa ff ff       	call   801018 <syscall>
  80156a:	83 c4 18             	add    $0x18,%esp
  80156d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801570:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801574:	75 07                	jne    80157d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801576:	b8 01 00 00 00       	mov    $0x1,%eax
  80157b:	eb 05                	jmp    801582 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80157d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
  801587:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 2c                	push   $0x2c
  801596:	e8 7d fa ff ff       	call   801018 <syscall>
  80159b:	83 c4 18             	add    $0x18,%esp
  80159e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015a1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015a5:	75 07                	jne    8015ae <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ac:	eb 05                	jmp    8015b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b3:	c9                   	leave  
  8015b4:	c3                   	ret    

008015b5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015b5:	55                   	push   %ebp
  8015b6:	89 e5                	mov    %esp,%ebp
  8015b8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 2c                	push   $0x2c
  8015c7:	e8 4c fa ff ff       	call   801018 <syscall>
  8015cc:	83 c4 18             	add    $0x18,%esp
  8015cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015d2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015d6:	75 07                	jne    8015df <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015d8:	b8 01 00 00 00       	mov    $0x1,%eax
  8015dd:	eb 05                	jmp    8015e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e4:	c9                   	leave  
  8015e5:	c3                   	ret    

008015e6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015e6:	55                   	push   %ebp
  8015e7:	89 e5                	mov    %esp,%ebp
  8015e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 2c                	push   $0x2c
  8015f8:	e8 1b fa ff ff       	call   801018 <syscall>
  8015fd:	83 c4 18             	add    $0x18,%esp
  801600:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801603:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801607:	75 07                	jne    801610 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801609:	b8 01 00 00 00       	mov    $0x1,%eax
  80160e:	eb 05                	jmp    801615 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801610:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	ff 75 08             	pushl  0x8(%ebp)
  801625:	6a 2d                	push   $0x2d
  801627:	e8 ec f9 ff ff       	call   801018 <syscall>
  80162c:	83 c4 18             	add    $0x18,%esp
	return ;
  80162f:	90                   	nop
}
  801630:	c9                   	leave  
  801631:	c3                   	ret    
  801632:	66 90                	xchg   %ax,%ax

00801634 <__udivdi3>:
  801634:	55                   	push   %ebp
  801635:	57                   	push   %edi
  801636:	56                   	push   %esi
  801637:	53                   	push   %ebx
  801638:	83 ec 1c             	sub    $0x1c,%esp
  80163b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80163f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801643:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801647:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80164b:	89 ca                	mov    %ecx,%edx
  80164d:	89 f8                	mov    %edi,%eax
  80164f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801653:	85 f6                	test   %esi,%esi
  801655:	75 2d                	jne    801684 <__udivdi3+0x50>
  801657:	39 cf                	cmp    %ecx,%edi
  801659:	77 65                	ja     8016c0 <__udivdi3+0x8c>
  80165b:	89 fd                	mov    %edi,%ebp
  80165d:	85 ff                	test   %edi,%edi
  80165f:	75 0b                	jne    80166c <__udivdi3+0x38>
  801661:	b8 01 00 00 00       	mov    $0x1,%eax
  801666:	31 d2                	xor    %edx,%edx
  801668:	f7 f7                	div    %edi
  80166a:	89 c5                	mov    %eax,%ebp
  80166c:	31 d2                	xor    %edx,%edx
  80166e:	89 c8                	mov    %ecx,%eax
  801670:	f7 f5                	div    %ebp
  801672:	89 c1                	mov    %eax,%ecx
  801674:	89 d8                	mov    %ebx,%eax
  801676:	f7 f5                	div    %ebp
  801678:	89 cf                	mov    %ecx,%edi
  80167a:	89 fa                	mov    %edi,%edx
  80167c:	83 c4 1c             	add    $0x1c,%esp
  80167f:	5b                   	pop    %ebx
  801680:	5e                   	pop    %esi
  801681:	5f                   	pop    %edi
  801682:	5d                   	pop    %ebp
  801683:	c3                   	ret    
  801684:	39 ce                	cmp    %ecx,%esi
  801686:	77 28                	ja     8016b0 <__udivdi3+0x7c>
  801688:	0f bd fe             	bsr    %esi,%edi
  80168b:	83 f7 1f             	xor    $0x1f,%edi
  80168e:	75 40                	jne    8016d0 <__udivdi3+0x9c>
  801690:	39 ce                	cmp    %ecx,%esi
  801692:	72 0a                	jb     80169e <__udivdi3+0x6a>
  801694:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801698:	0f 87 9e 00 00 00    	ja     80173c <__udivdi3+0x108>
  80169e:	b8 01 00 00 00       	mov    $0x1,%eax
  8016a3:	89 fa                	mov    %edi,%edx
  8016a5:	83 c4 1c             	add    $0x1c,%esp
  8016a8:	5b                   	pop    %ebx
  8016a9:	5e                   	pop    %esi
  8016aa:	5f                   	pop    %edi
  8016ab:	5d                   	pop    %ebp
  8016ac:	c3                   	ret    
  8016ad:	8d 76 00             	lea    0x0(%esi),%esi
  8016b0:	31 ff                	xor    %edi,%edi
  8016b2:	31 c0                	xor    %eax,%eax
  8016b4:	89 fa                	mov    %edi,%edx
  8016b6:	83 c4 1c             	add    $0x1c,%esp
  8016b9:	5b                   	pop    %ebx
  8016ba:	5e                   	pop    %esi
  8016bb:	5f                   	pop    %edi
  8016bc:	5d                   	pop    %ebp
  8016bd:	c3                   	ret    
  8016be:	66 90                	xchg   %ax,%ax
  8016c0:	89 d8                	mov    %ebx,%eax
  8016c2:	f7 f7                	div    %edi
  8016c4:	31 ff                	xor    %edi,%edi
  8016c6:	89 fa                	mov    %edi,%edx
  8016c8:	83 c4 1c             	add    $0x1c,%esp
  8016cb:	5b                   	pop    %ebx
  8016cc:	5e                   	pop    %esi
  8016cd:	5f                   	pop    %edi
  8016ce:	5d                   	pop    %ebp
  8016cf:	c3                   	ret    
  8016d0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016d5:	89 eb                	mov    %ebp,%ebx
  8016d7:	29 fb                	sub    %edi,%ebx
  8016d9:	89 f9                	mov    %edi,%ecx
  8016db:	d3 e6                	shl    %cl,%esi
  8016dd:	89 c5                	mov    %eax,%ebp
  8016df:	88 d9                	mov    %bl,%cl
  8016e1:	d3 ed                	shr    %cl,%ebp
  8016e3:	89 e9                	mov    %ebp,%ecx
  8016e5:	09 f1                	or     %esi,%ecx
  8016e7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016eb:	89 f9                	mov    %edi,%ecx
  8016ed:	d3 e0                	shl    %cl,%eax
  8016ef:	89 c5                	mov    %eax,%ebp
  8016f1:	89 d6                	mov    %edx,%esi
  8016f3:	88 d9                	mov    %bl,%cl
  8016f5:	d3 ee                	shr    %cl,%esi
  8016f7:	89 f9                	mov    %edi,%ecx
  8016f9:	d3 e2                	shl    %cl,%edx
  8016fb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016ff:	88 d9                	mov    %bl,%cl
  801701:	d3 e8                	shr    %cl,%eax
  801703:	09 c2                	or     %eax,%edx
  801705:	89 d0                	mov    %edx,%eax
  801707:	89 f2                	mov    %esi,%edx
  801709:	f7 74 24 0c          	divl   0xc(%esp)
  80170d:	89 d6                	mov    %edx,%esi
  80170f:	89 c3                	mov    %eax,%ebx
  801711:	f7 e5                	mul    %ebp
  801713:	39 d6                	cmp    %edx,%esi
  801715:	72 19                	jb     801730 <__udivdi3+0xfc>
  801717:	74 0b                	je     801724 <__udivdi3+0xf0>
  801719:	89 d8                	mov    %ebx,%eax
  80171b:	31 ff                	xor    %edi,%edi
  80171d:	e9 58 ff ff ff       	jmp    80167a <__udivdi3+0x46>
  801722:	66 90                	xchg   %ax,%ax
  801724:	8b 54 24 08          	mov    0x8(%esp),%edx
  801728:	89 f9                	mov    %edi,%ecx
  80172a:	d3 e2                	shl    %cl,%edx
  80172c:	39 c2                	cmp    %eax,%edx
  80172e:	73 e9                	jae    801719 <__udivdi3+0xe5>
  801730:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801733:	31 ff                	xor    %edi,%edi
  801735:	e9 40 ff ff ff       	jmp    80167a <__udivdi3+0x46>
  80173a:	66 90                	xchg   %ax,%ax
  80173c:	31 c0                	xor    %eax,%eax
  80173e:	e9 37 ff ff ff       	jmp    80167a <__udivdi3+0x46>
  801743:	90                   	nop

00801744 <__umoddi3>:
  801744:	55                   	push   %ebp
  801745:	57                   	push   %edi
  801746:	56                   	push   %esi
  801747:	53                   	push   %ebx
  801748:	83 ec 1c             	sub    $0x1c,%esp
  80174b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80174f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801753:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801757:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80175b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80175f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801763:	89 f3                	mov    %esi,%ebx
  801765:	89 fa                	mov    %edi,%edx
  801767:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80176b:	89 34 24             	mov    %esi,(%esp)
  80176e:	85 c0                	test   %eax,%eax
  801770:	75 1a                	jne    80178c <__umoddi3+0x48>
  801772:	39 f7                	cmp    %esi,%edi
  801774:	0f 86 a2 00 00 00    	jbe    80181c <__umoddi3+0xd8>
  80177a:	89 c8                	mov    %ecx,%eax
  80177c:	89 f2                	mov    %esi,%edx
  80177e:	f7 f7                	div    %edi
  801780:	89 d0                	mov    %edx,%eax
  801782:	31 d2                	xor    %edx,%edx
  801784:	83 c4 1c             	add    $0x1c,%esp
  801787:	5b                   	pop    %ebx
  801788:	5e                   	pop    %esi
  801789:	5f                   	pop    %edi
  80178a:	5d                   	pop    %ebp
  80178b:	c3                   	ret    
  80178c:	39 f0                	cmp    %esi,%eax
  80178e:	0f 87 ac 00 00 00    	ja     801840 <__umoddi3+0xfc>
  801794:	0f bd e8             	bsr    %eax,%ebp
  801797:	83 f5 1f             	xor    $0x1f,%ebp
  80179a:	0f 84 ac 00 00 00    	je     80184c <__umoddi3+0x108>
  8017a0:	bf 20 00 00 00       	mov    $0x20,%edi
  8017a5:	29 ef                	sub    %ebp,%edi
  8017a7:	89 fe                	mov    %edi,%esi
  8017a9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017ad:	89 e9                	mov    %ebp,%ecx
  8017af:	d3 e0                	shl    %cl,%eax
  8017b1:	89 d7                	mov    %edx,%edi
  8017b3:	89 f1                	mov    %esi,%ecx
  8017b5:	d3 ef                	shr    %cl,%edi
  8017b7:	09 c7                	or     %eax,%edi
  8017b9:	89 e9                	mov    %ebp,%ecx
  8017bb:	d3 e2                	shl    %cl,%edx
  8017bd:	89 14 24             	mov    %edx,(%esp)
  8017c0:	89 d8                	mov    %ebx,%eax
  8017c2:	d3 e0                	shl    %cl,%eax
  8017c4:	89 c2                	mov    %eax,%edx
  8017c6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017ca:	d3 e0                	shl    %cl,%eax
  8017cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017d0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017d4:	89 f1                	mov    %esi,%ecx
  8017d6:	d3 e8                	shr    %cl,%eax
  8017d8:	09 d0                	or     %edx,%eax
  8017da:	d3 eb                	shr    %cl,%ebx
  8017dc:	89 da                	mov    %ebx,%edx
  8017de:	f7 f7                	div    %edi
  8017e0:	89 d3                	mov    %edx,%ebx
  8017e2:	f7 24 24             	mull   (%esp)
  8017e5:	89 c6                	mov    %eax,%esi
  8017e7:	89 d1                	mov    %edx,%ecx
  8017e9:	39 d3                	cmp    %edx,%ebx
  8017eb:	0f 82 87 00 00 00    	jb     801878 <__umoddi3+0x134>
  8017f1:	0f 84 91 00 00 00    	je     801888 <__umoddi3+0x144>
  8017f7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8017fb:	29 f2                	sub    %esi,%edx
  8017fd:	19 cb                	sbb    %ecx,%ebx
  8017ff:	89 d8                	mov    %ebx,%eax
  801801:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801805:	d3 e0                	shl    %cl,%eax
  801807:	89 e9                	mov    %ebp,%ecx
  801809:	d3 ea                	shr    %cl,%edx
  80180b:	09 d0                	or     %edx,%eax
  80180d:	89 e9                	mov    %ebp,%ecx
  80180f:	d3 eb                	shr    %cl,%ebx
  801811:	89 da                	mov    %ebx,%edx
  801813:	83 c4 1c             	add    $0x1c,%esp
  801816:	5b                   	pop    %ebx
  801817:	5e                   	pop    %esi
  801818:	5f                   	pop    %edi
  801819:	5d                   	pop    %ebp
  80181a:	c3                   	ret    
  80181b:	90                   	nop
  80181c:	89 fd                	mov    %edi,%ebp
  80181e:	85 ff                	test   %edi,%edi
  801820:	75 0b                	jne    80182d <__umoddi3+0xe9>
  801822:	b8 01 00 00 00       	mov    $0x1,%eax
  801827:	31 d2                	xor    %edx,%edx
  801829:	f7 f7                	div    %edi
  80182b:	89 c5                	mov    %eax,%ebp
  80182d:	89 f0                	mov    %esi,%eax
  80182f:	31 d2                	xor    %edx,%edx
  801831:	f7 f5                	div    %ebp
  801833:	89 c8                	mov    %ecx,%eax
  801835:	f7 f5                	div    %ebp
  801837:	89 d0                	mov    %edx,%eax
  801839:	e9 44 ff ff ff       	jmp    801782 <__umoddi3+0x3e>
  80183e:	66 90                	xchg   %ax,%ax
  801840:	89 c8                	mov    %ecx,%eax
  801842:	89 f2                	mov    %esi,%edx
  801844:	83 c4 1c             	add    $0x1c,%esp
  801847:	5b                   	pop    %ebx
  801848:	5e                   	pop    %esi
  801849:	5f                   	pop    %edi
  80184a:	5d                   	pop    %ebp
  80184b:	c3                   	ret    
  80184c:	3b 04 24             	cmp    (%esp),%eax
  80184f:	72 06                	jb     801857 <__umoddi3+0x113>
  801851:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801855:	77 0f                	ja     801866 <__umoddi3+0x122>
  801857:	89 f2                	mov    %esi,%edx
  801859:	29 f9                	sub    %edi,%ecx
  80185b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80185f:	89 14 24             	mov    %edx,(%esp)
  801862:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801866:	8b 44 24 04          	mov    0x4(%esp),%eax
  80186a:	8b 14 24             	mov    (%esp),%edx
  80186d:	83 c4 1c             	add    $0x1c,%esp
  801870:	5b                   	pop    %ebx
  801871:	5e                   	pop    %esi
  801872:	5f                   	pop    %edi
  801873:	5d                   	pop    %ebp
  801874:	c3                   	ret    
  801875:	8d 76 00             	lea    0x0(%esi),%esi
  801878:	2b 04 24             	sub    (%esp),%eax
  80187b:	19 fa                	sbb    %edi,%edx
  80187d:	89 d1                	mov    %edx,%ecx
  80187f:	89 c6                	mov    %eax,%esi
  801881:	e9 71 ff ff ff       	jmp    8017f7 <__umoddi3+0xb3>
  801886:	66 90                	xchg   %ax,%ax
  801888:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80188c:	72 ea                	jb     801878 <__umoddi3+0x134>
  80188e:	89 d9                	mov    %ebx,%ecx
  801890:	e9 62 ff ff ff       	jmp    8017f7 <__umoddi3+0xb3>
