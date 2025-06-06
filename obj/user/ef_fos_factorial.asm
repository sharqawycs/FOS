
obj/user/ef_fos_factorial:     file format elf32-i386


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
  800031:	e8 6c 00 00 00       	call   8000a2 <libmain>
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
	//atomic_readline("Please enter a number:", buff1);
	i1 = 10;
  800048:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)

	int res = factorial(i1) ;
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	e8 1f 00 00 00       	call   800079 <factorial>
  80005a:	83 c4 10             	add    $0x10,%esp
  80005d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Factorial %d = %d\n",i1, res);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	ff 75 f0             	pushl  -0x10(%ebp)
  800066:	ff 75 f4             	pushl  -0xc(%ebp)
  800069:	68 80 18 80 00       	push   $0x801880
  80006e:	e8 32 02 00 00       	call   8002a5 <atomic_cprintf>
  800073:	83 c4 10             	add    $0x10,%esp

	return;
  800076:	90                   	nop
}
  800077:	c9                   	leave  
  800078:	c3                   	ret    

00800079 <factorial>:


int factorial(int n)
{
  800079:	55                   	push   %ebp
  80007a:	89 e5                	mov    %esp,%ebp
  80007c:	83 ec 08             	sub    $0x8,%esp
	if (n <= 1)
  80007f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800083:	7f 07                	jg     80008c <factorial+0x13>
		return 1 ;
  800085:	b8 01 00 00 00       	mov    $0x1,%eax
  80008a:	eb 14                	jmp    8000a0 <factorial+0x27>
	return n * factorial(n-1) ;
  80008c:	8b 45 08             	mov    0x8(%ebp),%eax
  80008f:	48                   	dec    %eax
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	50                   	push   %eax
  800094:	e8 e0 ff ff ff       	call   800079 <factorial>
  800099:	83 c4 10             	add    $0x10,%esp
  80009c:	0f af 45 08          	imul   0x8(%ebp),%eax
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000a8:	e8 f6 0f 00 00       	call   8010a3 <sys_getenvindex>
  8000ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000b3:	89 d0                	mov    %edx,%eax
  8000b5:	01 c0                	add    %eax,%eax
  8000b7:	01 d0                	add    %edx,%eax
  8000b9:	c1 e0 02             	shl    $0x2,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	c1 e0 06             	shl    $0x6,%eax
  8000c1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000c6:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000cb:	a1 04 20 80 00       	mov    0x802004,%eax
  8000d0:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000d6:	84 c0                	test   %al,%al
  8000d8:	74 0f                	je     8000e9 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000da:	a1 04 20 80 00       	mov    0x802004,%eax
  8000df:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000e4:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000ed:	7e 0a                	jle    8000f9 <libmain+0x57>
		binaryname = argv[0];
  8000ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f2:	8b 00                	mov    (%eax),%eax
  8000f4:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000f9:	83 ec 08             	sub    $0x8,%esp
  8000fc:	ff 75 0c             	pushl  0xc(%ebp)
  8000ff:	ff 75 08             	pushl  0x8(%ebp)
  800102:	e8 31 ff ff ff       	call   800038 <_main>
  800107:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80010a:	e8 2f 11 00 00       	call   80123e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 ac 18 80 00       	push   $0x8018ac
  800117:	e8 5c 01 00 00       	call   800278 <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80011f:	a1 04 20 80 00       	mov    0x802004,%eax
  800124:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80012a:	a1 04 20 80 00       	mov    0x802004,%eax
  80012f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	52                   	push   %edx
  800139:	50                   	push   %eax
  80013a:	68 d4 18 80 00       	push   $0x8018d4
  80013f:	e8 34 01 00 00       	call   800278 <cprintf>
  800144:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800147:	a1 04 20 80 00       	mov    0x802004,%eax
  80014c:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800152:	83 ec 08             	sub    $0x8,%esp
  800155:	50                   	push   %eax
  800156:	68 f9 18 80 00       	push   $0x8018f9
  80015b:	e8 18 01 00 00       	call   800278 <cprintf>
  800160:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800163:	83 ec 0c             	sub    $0xc,%esp
  800166:	68 ac 18 80 00       	push   $0x8018ac
  80016b:	e8 08 01 00 00       	call   800278 <cprintf>
  800170:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800173:	e8 e0 10 00 00       	call   801258 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800178:	e8 19 00 00 00       	call   800196 <exit>
}
  80017d:	90                   	nop
  80017e:	c9                   	leave  
  80017f:	c3                   	ret    

00800180 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800180:	55                   	push   %ebp
  800181:	89 e5                	mov    %esp,%ebp
  800183:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800186:	83 ec 0c             	sub    $0xc,%esp
  800189:	6a 00                	push   $0x0
  80018b:	e8 df 0e 00 00       	call   80106f <sys_env_destroy>
  800190:	83 c4 10             	add    $0x10,%esp
}
  800193:	90                   	nop
  800194:	c9                   	leave  
  800195:	c3                   	ret    

00800196 <exit>:

void
exit(void)
{
  800196:	55                   	push   %ebp
  800197:	89 e5                	mov    %esp,%ebp
  800199:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80019c:	e8 34 0f 00 00       	call   8010d5 <sys_env_exit>
}
  8001a1:	90                   	nop
  8001a2:	c9                   	leave  
  8001a3:	c3                   	ret    

008001a4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001a4:	55                   	push   %ebp
  8001a5:	89 e5                	mov    %esp,%ebp
  8001a7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ad:	8b 00                	mov    (%eax),%eax
  8001af:	8d 48 01             	lea    0x1(%eax),%ecx
  8001b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b5:	89 0a                	mov    %ecx,(%edx)
  8001b7:	8b 55 08             	mov    0x8(%ebp),%edx
  8001ba:	88 d1                	mov    %dl,%cl
  8001bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001bf:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c6:	8b 00                	mov    (%eax),%eax
  8001c8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001cd:	75 2c                	jne    8001fb <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001cf:	a0 08 20 80 00       	mov    0x802008,%al
  8001d4:	0f b6 c0             	movzbl %al,%eax
  8001d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001da:	8b 12                	mov    (%edx),%edx
  8001dc:	89 d1                	mov    %edx,%ecx
  8001de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e1:	83 c2 08             	add    $0x8,%edx
  8001e4:	83 ec 04             	sub    $0x4,%esp
  8001e7:	50                   	push   %eax
  8001e8:	51                   	push   %ecx
  8001e9:	52                   	push   %edx
  8001ea:	e8 3e 0e 00 00       	call   80102d <sys_cputs>
  8001ef:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fe:	8b 40 04             	mov    0x4(%eax),%eax
  800201:	8d 50 01             	lea    0x1(%eax),%edx
  800204:	8b 45 0c             	mov    0xc(%ebp),%eax
  800207:	89 50 04             	mov    %edx,0x4(%eax)
}
  80020a:	90                   	nop
  80020b:	c9                   	leave  
  80020c:	c3                   	ret    

0080020d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80020d:	55                   	push   %ebp
  80020e:	89 e5                	mov    %esp,%ebp
  800210:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800216:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80021d:	00 00 00 
	b.cnt = 0;
  800220:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800227:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80022a:	ff 75 0c             	pushl  0xc(%ebp)
  80022d:	ff 75 08             	pushl  0x8(%ebp)
  800230:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800236:	50                   	push   %eax
  800237:	68 a4 01 80 00       	push   $0x8001a4
  80023c:	e8 11 02 00 00       	call   800452 <vprintfmt>
  800241:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800244:	a0 08 20 80 00       	mov    0x802008,%al
  800249:	0f b6 c0             	movzbl %al,%eax
  80024c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800252:	83 ec 04             	sub    $0x4,%esp
  800255:	50                   	push   %eax
  800256:	52                   	push   %edx
  800257:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80025d:	83 c0 08             	add    $0x8,%eax
  800260:	50                   	push   %eax
  800261:	e8 c7 0d 00 00       	call   80102d <sys_cputs>
  800266:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800269:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800270:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800276:	c9                   	leave  
  800277:	c3                   	ret    

00800278 <cprintf>:

int cprintf(const char *fmt, ...) {
  800278:	55                   	push   %ebp
  800279:	89 e5                	mov    %esp,%ebp
  80027b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80027e:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800285:	8d 45 0c             	lea    0xc(%ebp),%eax
  800288:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80028b:	8b 45 08             	mov    0x8(%ebp),%eax
  80028e:	83 ec 08             	sub    $0x8,%esp
  800291:	ff 75 f4             	pushl  -0xc(%ebp)
  800294:	50                   	push   %eax
  800295:	e8 73 ff ff ff       	call   80020d <vcprintf>
  80029a:	83 c4 10             	add    $0x10,%esp
  80029d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002a3:	c9                   	leave  
  8002a4:	c3                   	ret    

008002a5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002a5:	55                   	push   %ebp
  8002a6:	89 e5                	mov    %esp,%ebp
  8002a8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002ab:	e8 8e 0f 00 00       	call   80123e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002b0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b9:	83 ec 08             	sub    $0x8,%esp
  8002bc:	ff 75 f4             	pushl  -0xc(%ebp)
  8002bf:	50                   	push   %eax
  8002c0:	e8 48 ff ff ff       	call   80020d <vcprintf>
  8002c5:	83 c4 10             	add    $0x10,%esp
  8002c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002cb:	e8 88 0f 00 00       	call   801258 <sys_enable_interrupt>
	return cnt;
  8002d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002d3:	c9                   	leave  
  8002d4:	c3                   	ret    

008002d5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002d5:	55                   	push   %ebp
  8002d6:	89 e5                	mov    %esp,%ebp
  8002d8:	53                   	push   %ebx
  8002d9:	83 ec 14             	sub    $0x14,%esp
  8002dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8002df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8002e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002e8:	8b 45 18             	mov    0x18(%ebp),%eax
  8002eb:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002f3:	77 55                	ja     80034a <printnum+0x75>
  8002f5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002f8:	72 05                	jb     8002ff <printnum+0x2a>
  8002fa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002fd:	77 4b                	ja     80034a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002ff:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800302:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800305:	8b 45 18             	mov    0x18(%ebp),%eax
  800308:	ba 00 00 00 00       	mov    $0x0,%edx
  80030d:	52                   	push   %edx
  80030e:	50                   	push   %eax
  80030f:	ff 75 f4             	pushl  -0xc(%ebp)
  800312:	ff 75 f0             	pushl  -0x10(%ebp)
  800315:	e8 02 13 00 00       	call   80161c <__udivdi3>
  80031a:	83 c4 10             	add    $0x10,%esp
  80031d:	83 ec 04             	sub    $0x4,%esp
  800320:	ff 75 20             	pushl  0x20(%ebp)
  800323:	53                   	push   %ebx
  800324:	ff 75 18             	pushl  0x18(%ebp)
  800327:	52                   	push   %edx
  800328:	50                   	push   %eax
  800329:	ff 75 0c             	pushl  0xc(%ebp)
  80032c:	ff 75 08             	pushl  0x8(%ebp)
  80032f:	e8 a1 ff ff ff       	call   8002d5 <printnum>
  800334:	83 c4 20             	add    $0x20,%esp
  800337:	eb 1a                	jmp    800353 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800339:	83 ec 08             	sub    $0x8,%esp
  80033c:	ff 75 0c             	pushl  0xc(%ebp)
  80033f:	ff 75 20             	pushl  0x20(%ebp)
  800342:	8b 45 08             	mov    0x8(%ebp),%eax
  800345:	ff d0                	call   *%eax
  800347:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80034a:	ff 4d 1c             	decl   0x1c(%ebp)
  80034d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800351:	7f e6                	jg     800339 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800353:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800356:	bb 00 00 00 00       	mov    $0x0,%ebx
  80035b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80035e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800361:	53                   	push   %ebx
  800362:	51                   	push   %ecx
  800363:	52                   	push   %edx
  800364:	50                   	push   %eax
  800365:	e8 c2 13 00 00       	call   80172c <__umoddi3>
  80036a:	83 c4 10             	add    $0x10,%esp
  80036d:	05 34 1b 80 00       	add    $0x801b34,%eax
  800372:	8a 00                	mov    (%eax),%al
  800374:	0f be c0             	movsbl %al,%eax
  800377:	83 ec 08             	sub    $0x8,%esp
  80037a:	ff 75 0c             	pushl  0xc(%ebp)
  80037d:	50                   	push   %eax
  80037e:	8b 45 08             	mov    0x8(%ebp),%eax
  800381:	ff d0                	call   *%eax
  800383:	83 c4 10             	add    $0x10,%esp
}
  800386:	90                   	nop
  800387:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80038a:	c9                   	leave  
  80038b:	c3                   	ret    

0080038c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80038c:	55                   	push   %ebp
  80038d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80038f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800393:	7e 1c                	jle    8003b1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	8b 00                	mov    (%eax),%eax
  80039a:	8d 50 08             	lea    0x8(%eax),%edx
  80039d:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a0:	89 10                	mov    %edx,(%eax)
  8003a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a5:	8b 00                	mov    (%eax),%eax
  8003a7:	83 e8 08             	sub    $0x8,%eax
  8003aa:	8b 50 04             	mov    0x4(%eax),%edx
  8003ad:	8b 00                	mov    (%eax),%eax
  8003af:	eb 40                	jmp    8003f1 <getuint+0x65>
	else if (lflag)
  8003b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003b5:	74 1e                	je     8003d5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ba:	8b 00                	mov    (%eax),%eax
  8003bc:	8d 50 04             	lea    0x4(%eax),%edx
  8003bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c2:	89 10                	mov    %edx,(%eax)
  8003c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c7:	8b 00                	mov    (%eax),%eax
  8003c9:	83 e8 04             	sub    $0x4,%eax
  8003cc:	8b 00                	mov    (%eax),%eax
  8003ce:	ba 00 00 00 00       	mov    $0x0,%edx
  8003d3:	eb 1c                	jmp    8003f1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  8003f1:	5d                   	pop    %ebp
  8003f2:	c3                   	ret    

008003f3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003f3:	55                   	push   %ebp
  8003f4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003f6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003fa:	7e 1c                	jle    800418 <getint+0x25>
		return va_arg(*ap, long long);
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	8d 50 08             	lea    0x8(%eax),%edx
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	89 10                	mov    %edx,(%eax)
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	83 e8 08             	sub    $0x8,%eax
  800411:	8b 50 04             	mov    0x4(%eax),%edx
  800414:	8b 00                	mov    (%eax),%eax
  800416:	eb 38                	jmp    800450 <getint+0x5d>
	else if (lflag)
  800418:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80041c:	74 1a                	je     800438 <getint+0x45>
		return va_arg(*ap, long);
  80041e:	8b 45 08             	mov    0x8(%ebp),%eax
  800421:	8b 00                	mov    (%eax),%eax
  800423:	8d 50 04             	lea    0x4(%eax),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	89 10                	mov    %edx,(%eax)
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	83 e8 04             	sub    $0x4,%eax
  800433:	8b 00                	mov    (%eax),%eax
  800435:	99                   	cltd   
  800436:	eb 18                	jmp    800450 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	8b 00                	mov    (%eax),%eax
  80043d:	8d 50 04             	lea    0x4(%eax),%edx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	89 10                	mov    %edx,(%eax)
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	83 e8 04             	sub    $0x4,%eax
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	99                   	cltd   
}
  800450:	5d                   	pop    %ebp
  800451:	c3                   	ret    

00800452 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800452:	55                   	push   %ebp
  800453:	89 e5                	mov    %esp,%ebp
  800455:	56                   	push   %esi
  800456:	53                   	push   %ebx
  800457:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80045a:	eb 17                	jmp    800473 <vprintfmt+0x21>
			if (ch == '\0')
  80045c:	85 db                	test   %ebx,%ebx
  80045e:	0f 84 af 03 00 00    	je     800813 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	ff 75 0c             	pushl  0xc(%ebp)
  80046a:	53                   	push   %ebx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	ff d0                	call   *%eax
  800470:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800473:	8b 45 10             	mov    0x10(%ebp),%eax
  800476:	8d 50 01             	lea    0x1(%eax),%edx
  800479:	89 55 10             	mov    %edx,0x10(%ebp)
  80047c:	8a 00                	mov    (%eax),%al
  80047e:	0f b6 d8             	movzbl %al,%ebx
  800481:	83 fb 25             	cmp    $0x25,%ebx
  800484:	75 d6                	jne    80045c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800486:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80048a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800491:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800498:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80049f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a9:	8d 50 01             	lea    0x1(%eax),%edx
  8004ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8004af:	8a 00                	mov    (%eax),%al
  8004b1:	0f b6 d8             	movzbl %al,%ebx
  8004b4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004b7:	83 f8 55             	cmp    $0x55,%eax
  8004ba:	0f 87 2b 03 00 00    	ja     8007eb <vprintfmt+0x399>
  8004c0:	8b 04 85 58 1b 80 00 	mov    0x801b58(,%eax,4),%eax
  8004c7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004c9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004cd:	eb d7                	jmp    8004a6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004cf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004d3:	eb d1                	jmp    8004a6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004d5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004dc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004df:	89 d0                	mov    %edx,%eax
  8004e1:	c1 e0 02             	shl    $0x2,%eax
  8004e4:	01 d0                	add    %edx,%eax
  8004e6:	01 c0                	add    %eax,%eax
  8004e8:	01 d8                	add    %ebx,%eax
  8004ea:	83 e8 30             	sub    $0x30,%eax
  8004ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f3:	8a 00                	mov    (%eax),%al
  8004f5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004f8:	83 fb 2f             	cmp    $0x2f,%ebx
  8004fb:	7e 3e                	jle    80053b <vprintfmt+0xe9>
  8004fd:	83 fb 39             	cmp    $0x39,%ebx
  800500:	7f 39                	jg     80053b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800502:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800505:	eb d5                	jmp    8004dc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800507:	8b 45 14             	mov    0x14(%ebp),%eax
  80050a:	83 c0 04             	add    $0x4,%eax
  80050d:	89 45 14             	mov    %eax,0x14(%ebp)
  800510:	8b 45 14             	mov    0x14(%ebp),%eax
  800513:	83 e8 04             	sub    $0x4,%eax
  800516:	8b 00                	mov    (%eax),%eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80051b:	eb 1f                	jmp    80053c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80051d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800521:	79 83                	jns    8004a6 <vprintfmt+0x54>
				width = 0;
  800523:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80052a:	e9 77 ff ff ff       	jmp    8004a6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80052f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800536:	e9 6b ff ff ff       	jmp    8004a6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80053b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80053c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800540:	0f 89 60 ff ff ff    	jns    8004a6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800546:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800549:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80054c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800553:	e9 4e ff ff ff       	jmp    8004a6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800558:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80055b:	e9 46 ff ff ff       	jmp    8004a6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800560:	8b 45 14             	mov    0x14(%ebp),%eax
  800563:	83 c0 04             	add    $0x4,%eax
  800566:	89 45 14             	mov    %eax,0x14(%ebp)
  800569:	8b 45 14             	mov    0x14(%ebp),%eax
  80056c:	83 e8 04             	sub    $0x4,%eax
  80056f:	8b 00                	mov    (%eax),%eax
  800571:	83 ec 08             	sub    $0x8,%esp
  800574:	ff 75 0c             	pushl  0xc(%ebp)
  800577:	50                   	push   %eax
  800578:	8b 45 08             	mov    0x8(%ebp),%eax
  80057b:	ff d0                	call   *%eax
  80057d:	83 c4 10             	add    $0x10,%esp
			break;
  800580:	e9 89 02 00 00       	jmp    80080e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800585:	8b 45 14             	mov    0x14(%ebp),%eax
  800588:	83 c0 04             	add    $0x4,%eax
  80058b:	89 45 14             	mov    %eax,0x14(%ebp)
  80058e:	8b 45 14             	mov    0x14(%ebp),%eax
  800591:	83 e8 04             	sub    $0x4,%eax
  800594:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800596:	85 db                	test   %ebx,%ebx
  800598:	79 02                	jns    80059c <vprintfmt+0x14a>
				err = -err;
  80059a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80059c:	83 fb 64             	cmp    $0x64,%ebx
  80059f:	7f 0b                	jg     8005ac <vprintfmt+0x15a>
  8005a1:	8b 34 9d a0 19 80 00 	mov    0x8019a0(,%ebx,4),%esi
  8005a8:	85 f6                	test   %esi,%esi
  8005aa:	75 19                	jne    8005c5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005ac:	53                   	push   %ebx
  8005ad:	68 45 1b 80 00       	push   $0x801b45
  8005b2:	ff 75 0c             	pushl  0xc(%ebp)
  8005b5:	ff 75 08             	pushl  0x8(%ebp)
  8005b8:	e8 5e 02 00 00       	call   80081b <printfmt>
  8005bd:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005c0:	e9 49 02 00 00       	jmp    80080e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005c5:	56                   	push   %esi
  8005c6:	68 4e 1b 80 00       	push   $0x801b4e
  8005cb:	ff 75 0c             	pushl  0xc(%ebp)
  8005ce:	ff 75 08             	pushl  0x8(%ebp)
  8005d1:	e8 45 02 00 00       	call   80081b <printfmt>
  8005d6:	83 c4 10             	add    $0x10,%esp
			break;
  8005d9:	e9 30 02 00 00       	jmp    80080e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005de:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e1:	83 c0 04             	add    $0x4,%eax
  8005e4:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ea:	83 e8 04             	sub    $0x4,%eax
  8005ed:	8b 30                	mov    (%eax),%esi
  8005ef:	85 f6                	test   %esi,%esi
  8005f1:	75 05                	jne    8005f8 <vprintfmt+0x1a6>
				p = "(null)";
  8005f3:	be 51 1b 80 00       	mov    $0x801b51,%esi
			if (width > 0 && padc != '-')
  8005f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005fc:	7e 6d                	jle    80066b <vprintfmt+0x219>
  8005fe:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800602:	74 67                	je     80066b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800604:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800607:	83 ec 08             	sub    $0x8,%esp
  80060a:	50                   	push   %eax
  80060b:	56                   	push   %esi
  80060c:	e8 0c 03 00 00       	call   80091d <strnlen>
  800611:	83 c4 10             	add    $0x10,%esp
  800614:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800617:	eb 16                	jmp    80062f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800619:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80061d:	83 ec 08             	sub    $0x8,%esp
  800620:	ff 75 0c             	pushl  0xc(%ebp)
  800623:	50                   	push   %eax
  800624:	8b 45 08             	mov    0x8(%ebp),%eax
  800627:	ff d0                	call   *%eax
  800629:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80062c:	ff 4d e4             	decl   -0x1c(%ebp)
  80062f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800633:	7f e4                	jg     800619 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800635:	eb 34                	jmp    80066b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800637:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80063b:	74 1c                	je     800659 <vprintfmt+0x207>
  80063d:	83 fb 1f             	cmp    $0x1f,%ebx
  800640:	7e 05                	jle    800647 <vprintfmt+0x1f5>
  800642:	83 fb 7e             	cmp    $0x7e,%ebx
  800645:	7e 12                	jle    800659 <vprintfmt+0x207>
					putch('?', putdat);
  800647:	83 ec 08             	sub    $0x8,%esp
  80064a:	ff 75 0c             	pushl  0xc(%ebp)
  80064d:	6a 3f                	push   $0x3f
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	ff d0                	call   *%eax
  800654:	83 c4 10             	add    $0x10,%esp
  800657:	eb 0f                	jmp    800668 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800659:	83 ec 08             	sub    $0x8,%esp
  80065c:	ff 75 0c             	pushl  0xc(%ebp)
  80065f:	53                   	push   %ebx
  800660:	8b 45 08             	mov    0x8(%ebp),%eax
  800663:	ff d0                	call   *%eax
  800665:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800668:	ff 4d e4             	decl   -0x1c(%ebp)
  80066b:	89 f0                	mov    %esi,%eax
  80066d:	8d 70 01             	lea    0x1(%eax),%esi
  800670:	8a 00                	mov    (%eax),%al
  800672:	0f be d8             	movsbl %al,%ebx
  800675:	85 db                	test   %ebx,%ebx
  800677:	74 24                	je     80069d <vprintfmt+0x24b>
  800679:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80067d:	78 b8                	js     800637 <vprintfmt+0x1e5>
  80067f:	ff 4d e0             	decl   -0x20(%ebp)
  800682:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800686:	79 af                	jns    800637 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800688:	eb 13                	jmp    80069d <vprintfmt+0x24b>
				putch(' ', putdat);
  80068a:	83 ec 08             	sub    $0x8,%esp
  80068d:	ff 75 0c             	pushl  0xc(%ebp)
  800690:	6a 20                	push   $0x20
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	ff d0                	call   *%eax
  800697:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80069a:	ff 4d e4             	decl   -0x1c(%ebp)
  80069d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a1:	7f e7                	jg     80068a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006a3:	e9 66 01 00 00       	jmp    80080e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006a8:	83 ec 08             	sub    $0x8,%esp
  8006ab:	ff 75 e8             	pushl  -0x18(%ebp)
  8006ae:	8d 45 14             	lea    0x14(%ebp),%eax
  8006b1:	50                   	push   %eax
  8006b2:	e8 3c fd ff ff       	call   8003f3 <getint>
  8006b7:	83 c4 10             	add    $0x10,%esp
  8006ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006c6:	85 d2                	test   %edx,%edx
  8006c8:	79 23                	jns    8006ed <vprintfmt+0x29b>
				putch('-', putdat);
  8006ca:	83 ec 08             	sub    $0x8,%esp
  8006cd:	ff 75 0c             	pushl  0xc(%ebp)
  8006d0:	6a 2d                	push   $0x2d
  8006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d5:	ff d0                	call   *%eax
  8006d7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e0:	f7 d8                	neg    %eax
  8006e2:	83 d2 00             	adc    $0x0,%edx
  8006e5:	f7 da                	neg    %edx
  8006e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006ed:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006f4:	e9 bc 00 00 00       	jmp    8007b5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006f9:	83 ec 08             	sub    $0x8,%esp
  8006fc:	ff 75 e8             	pushl  -0x18(%ebp)
  8006ff:	8d 45 14             	lea    0x14(%ebp),%eax
  800702:	50                   	push   %eax
  800703:	e8 84 fc ff ff       	call   80038c <getuint>
  800708:	83 c4 10             	add    $0x10,%esp
  80070b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80070e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800711:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800718:	e9 98 00 00 00       	jmp    8007b5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80071d:	83 ec 08             	sub    $0x8,%esp
  800720:	ff 75 0c             	pushl  0xc(%ebp)
  800723:	6a 58                	push   $0x58
  800725:	8b 45 08             	mov    0x8(%ebp),%eax
  800728:	ff d0                	call   *%eax
  80072a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80072d:	83 ec 08             	sub    $0x8,%esp
  800730:	ff 75 0c             	pushl  0xc(%ebp)
  800733:	6a 58                	push   $0x58
  800735:	8b 45 08             	mov    0x8(%ebp),%eax
  800738:	ff d0                	call   *%eax
  80073a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80073d:	83 ec 08             	sub    $0x8,%esp
  800740:	ff 75 0c             	pushl  0xc(%ebp)
  800743:	6a 58                	push   $0x58
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	ff d0                	call   *%eax
  80074a:	83 c4 10             	add    $0x10,%esp
			break;
  80074d:	e9 bc 00 00 00       	jmp    80080e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800752:	83 ec 08             	sub    $0x8,%esp
  800755:	ff 75 0c             	pushl  0xc(%ebp)
  800758:	6a 30                	push   $0x30
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	ff d0                	call   *%eax
  80075f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800762:	83 ec 08             	sub    $0x8,%esp
  800765:	ff 75 0c             	pushl  0xc(%ebp)
  800768:	6a 78                	push   $0x78
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	ff d0                	call   *%eax
  80076f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800772:	8b 45 14             	mov    0x14(%ebp),%eax
  800775:	83 c0 04             	add    $0x4,%eax
  800778:	89 45 14             	mov    %eax,0x14(%ebp)
  80077b:	8b 45 14             	mov    0x14(%ebp),%eax
  80077e:	83 e8 04             	sub    $0x4,%eax
  800781:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800783:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800786:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80078d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800794:	eb 1f                	jmp    8007b5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 e8             	pushl  -0x18(%ebp)
  80079c:	8d 45 14             	lea    0x14(%ebp),%eax
  80079f:	50                   	push   %eax
  8007a0:	e8 e7 fb ff ff       	call   80038c <getuint>
  8007a5:	83 c4 10             	add    $0x10,%esp
  8007a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007ae:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007b5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007bc:	83 ec 04             	sub    $0x4,%esp
  8007bf:	52                   	push   %edx
  8007c0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007c3:	50                   	push   %eax
  8007c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8007ca:	ff 75 0c             	pushl  0xc(%ebp)
  8007cd:	ff 75 08             	pushl  0x8(%ebp)
  8007d0:	e8 00 fb ff ff       	call   8002d5 <printnum>
  8007d5:	83 c4 20             	add    $0x20,%esp
			break;
  8007d8:	eb 34                	jmp    80080e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007da:	83 ec 08             	sub    $0x8,%esp
  8007dd:	ff 75 0c             	pushl  0xc(%ebp)
  8007e0:	53                   	push   %ebx
  8007e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e4:	ff d0                	call   *%eax
  8007e6:	83 c4 10             	add    $0x10,%esp
			break;
  8007e9:	eb 23                	jmp    80080e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007eb:	83 ec 08             	sub    $0x8,%esp
  8007ee:	ff 75 0c             	pushl  0xc(%ebp)
  8007f1:	6a 25                	push   $0x25
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	ff d0                	call   *%eax
  8007f8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007fb:	ff 4d 10             	decl   0x10(%ebp)
  8007fe:	eb 03                	jmp    800803 <vprintfmt+0x3b1>
  800800:	ff 4d 10             	decl   0x10(%ebp)
  800803:	8b 45 10             	mov    0x10(%ebp),%eax
  800806:	48                   	dec    %eax
  800807:	8a 00                	mov    (%eax),%al
  800809:	3c 25                	cmp    $0x25,%al
  80080b:	75 f3                	jne    800800 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80080d:	90                   	nop
		}
	}
  80080e:	e9 47 fc ff ff       	jmp    80045a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800813:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800814:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800817:	5b                   	pop    %ebx
  800818:	5e                   	pop    %esi
  800819:	5d                   	pop    %ebp
  80081a:	c3                   	ret    

0080081b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80081b:	55                   	push   %ebp
  80081c:	89 e5                	mov    %esp,%ebp
  80081e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800821:	8d 45 10             	lea    0x10(%ebp),%eax
  800824:	83 c0 04             	add    $0x4,%eax
  800827:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80082a:	8b 45 10             	mov    0x10(%ebp),%eax
  80082d:	ff 75 f4             	pushl  -0xc(%ebp)
  800830:	50                   	push   %eax
  800831:	ff 75 0c             	pushl  0xc(%ebp)
  800834:	ff 75 08             	pushl  0x8(%ebp)
  800837:	e8 16 fc ff ff       	call   800452 <vprintfmt>
  80083c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80083f:	90                   	nop
  800840:	c9                   	leave  
  800841:	c3                   	ret    

00800842 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800842:	55                   	push   %ebp
  800843:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800845:	8b 45 0c             	mov    0xc(%ebp),%eax
  800848:	8b 40 08             	mov    0x8(%eax),%eax
  80084b:	8d 50 01             	lea    0x1(%eax),%edx
  80084e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800851:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800854:	8b 45 0c             	mov    0xc(%ebp),%eax
  800857:	8b 10                	mov    (%eax),%edx
  800859:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085c:	8b 40 04             	mov    0x4(%eax),%eax
  80085f:	39 c2                	cmp    %eax,%edx
  800861:	73 12                	jae    800875 <sprintputch+0x33>
		*b->buf++ = ch;
  800863:	8b 45 0c             	mov    0xc(%ebp),%eax
  800866:	8b 00                	mov    (%eax),%eax
  800868:	8d 48 01             	lea    0x1(%eax),%ecx
  80086b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80086e:	89 0a                	mov    %ecx,(%edx)
  800870:	8b 55 08             	mov    0x8(%ebp),%edx
  800873:	88 10                	mov    %dl,(%eax)
}
  800875:	90                   	nop
  800876:	5d                   	pop    %ebp
  800877:	c3                   	ret    

00800878 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800878:	55                   	push   %ebp
  800879:	89 e5                	mov    %esp,%ebp
  80087b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80087e:	8b 45 08             	mov    0x8(%ebp),%eax
  800881:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800884:	8b 45 0c             	mov    0xc(%ebp),%eax
  800887:	8d 50 ff             	lea    -0x1(%eax),%edx
  80088a:	8b 45 08             	mov    0x8(%ebp),%eax
  80088d:	01 d0                	add    %edx,%eax
  80088f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800892:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800899:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80089d:	74 06                	je     8008a5 <vsnprintf+0x2d>
  80089f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a3:	7f 07                	jg     8008ac <vsnprintf+0x34>
		return -E_INVAL;
  8008a5:	b8 03 00 00 00       	mov    $0x3,%eax
  8008aa:	eb 20                	jmp    8008cc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ac:	ff 75 14             	pushl  0x14(%ebp)
  8008af:	ff 75 10             	pushl  0x10(%ebp)
  8008b2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008b5:	50                   	push   %eax
  8008b6:	68 42 08 80 00       	push   $0x800842
  8008bb:	e8 92 fb ff ff       	call   800452 <vprintfmt>
  8008c0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008c6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008cc:	c9                   	leave  
  8008cd:	c3                   	ret    

008008ce <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008ce:	55                   	push   %ebp
  8008cf:	89 e5                	mov    %esp,%ebp
  8008d1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008d4:	8d 45 10             	lea    0x10(%ebp),%eax
  8008d7:	83 c0 04             	add    $0x4,%eax
  8008da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008e3:	50                   	push   %eax
  8008e4:	ff 75 0c             	pushl  0xc(%ebp)
  8008e7:	ff 75 08             	pushl  0x8(%ebp)
  8008ea:	e8 89 ff ff ff       	call   800878 <vsnprintf>
  8008ef:	83 c4 10             	add    $0x10,%esp
  8008f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008f8:	c9                   	leave  
  8008f9:	c3                   	ret    

008008fa <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008fa:	55                   	push   %ebp
  8008fb:	89 e5                	mov    %esp,%ebp
  8008fd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800900:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800907:	eb 06                	jmp    80090f <strlen+0x15>
		n++;
  800909:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80090c:	ff 45 08             	incl   0x8(%ebp)
  80090f:	8b 45 08             	mov    0x8(%ebp),%eax
  800912:	8a 00                	mov    (%eax),%al
  800914:	84 c0                	test   %al,%al
  800916:	75 f1                	jne    800909 <strlen+0xf>
		n++;
	return n;
  800918:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80091b:	c9                   	leave  
  80091c:	c3                   	ret    

0080091d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80091d:	55                   	push   %ebp
  80091e:	89 e5                	mov    %esp,%ebp
  800920:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800923:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80092a:	eb 09                	jmp    800935 <strnlen+0x18>
		n++;
  80092c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80092f:	ff 45 08             	incl   0x8(%ebp)
  800932:	ff 4d 0c             	decl   0xc(%ebp)
  800935:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800939:	74 09                	je     800944 <strnlen+0x27>
  80093b:	8b 45 08             	mov    0x8(%ebp),%eax
  80093e:	8a 00                	mov    (%eax),%al
  800940:	84 c0                	test   %al,%al
  800942:	75 e8                	jne    80092c <strnlen+0xf>
		n++;
	return n;
  800944:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800947:	c9                   	leave  
  800948:	c3                   	ret    

00800949 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800949:	55                   	push   %ebp
  80094a:	89 e5                	mov    %esp,%ebp
  80094c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80094f:	8b 45 08             	mov    0x8(%ebp),%eax
  800952:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800955:	90                   	nop
  800956:	8b 45 08             	mov    0x8(%ebp),%eax
  800959:	8d 50 01             	lea    0x1(%eax),%edx
  80095c:	89 55 08             	mov    %edx,0x8(%ebp)
  80095f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800962:	8d 4a 01             	lea    0x1(%edx),%ecx
  800965:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800968:	8a 12                	mov    (%edx),%dl
  80096a:	88 10                	mov    %dl,(%eax)
  80096c:	8a 00                	mov    (%eax),%al
  80096e:	84 c0                	test   %al,%al
  800970:	75 e4                	jne    800956 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800972:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800975:	c9                   	leave  
  800976:	c3                   	ret    

00800977 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800977:	55                   	push   %ebp
  800978:	89 e5                	mov    %esp,%ebp
  80097a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80097d:	8b 45 08             	mov    0x8(%ebp),%eax
  800980:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800983:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80098a:	eb 1f                	jmp    8009ab <strncpy+0x34>
		*dst++ = *src;
  80098c:	8b 45 08             	mov    0x8(%ebp),%eax
  80098f:	8d 50 01             	lea    0x1(%eax),%edx
  800992:	89 55 08             	mov    %edx,0x8(%ebp)
  800995:	8b 55 0c             	mov    0xc(%ebp),%edx
  800998:	8a 12                	mov    (%edx),%dl
  80099a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80099c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099f:	8a 00                	mov    (%eax),%al
  8009a1:	84 c0                	test   %al,%al
  8009a3:	74 03                	je     8009a8 <strncpy+0x31>
			src++;
  8009a5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009a8:	ff 45 fc             	incl   -0x4(%ebp)
  8009ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009ae:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009b1:	72 d9                	jb     80098c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009b6:	c9                   	leave  
  8009b7:	c3                   	ret    

008009b8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009b8:	55                   	push   %ebp
  8009b9:	89 e5                	mov    %esp,%ebp
  8009bb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009c8:	74 30                	je     8009fa <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009ca:	eb 16                	jmp    8009e2 <strlcpy+0x2a>
			*dst++ = *src++;
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	8d 50 01             	lea    0x1(%eax),%edx
  8009d2:	89 55 08             	mov    %edx,0x8(%ebp)
  8009d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009db:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009de:	8a 12                	mov    (%edx),%dl
  8009e0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009e2:	ff 4d 10             	decl   0x10(%ebp)
  8009e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009e9:	74 09                	je     8009f4 <strlcpy+0x3c>
  8009eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ee:	8a 00                	mov    (%eax),%al
  8009f0:	84 c0                	test   %al,%al
  8009f2:	75 d8                	jne    8009cc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8009fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a00:	29 c2                	sub    %eax,%edx
  800a02:	89 d0                	mov    %edx,%eax
}
  800a04:	c9                   	leave  
  800a05:	c3                   	ret    

00800a06 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a06:	55                   	push   %ebp
  800a07:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a09:	eb 06                	jmp    800a11 <strcmp+0xb>
		p++, q++;
  800a0b:	ff 45 08             	incl   0x8(%ebp)
  800a0e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a11:	8b 45 08             	mov    0x8(%ebp),%eax
  800a14:	8a 00                	mov    (%eax),%al
  800a16:	84 c0                	test   %al,%al
  800a18:	74 0e                	je     800a28 <strcmp+0x22>
  800a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1d:	8a 10                	mov    (%eax),%dl
  800a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a22:	8a 00                	mov    (%eax),%al
  800a24:	38 c2                	cmp    %al,%dl
  800a26:	74 e3                	je     800a0b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a28:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2b:	8a 00                	mov    (%eax),%al
  800a2d:	0f b6 d0             	movzbl %al,%edx
  800a30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a33:	8a 00                	mov    (%eax),%al
  800a35:	0f b6 c0             	movzbl %al,%eax
  800a38:	29 c2                	sub    %eax,%edx
  800a3a:	89 d0                	mov    %edx,%eax
}
  800a3c:	5d                   	pop    %ebp
  800a3d:	c3                   	ret    

00800a3e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a3e:	55                   	push   %ebp
  800a3f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a41:	eb 09                	jmp    800a4c <strncmp+0xe>
		n--, p++, q++;
  800a43:	ff 4d 10             	decl   0x10(%ebp)
  800a46:	ff 45 08             	incl   0x8(%ebp)
  800a49:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a50:	74 17                	je     800a69 <strncmp+0x2b>
  800a52:	8b 45 08             	mov    0x8(%ebp),%eax
  800a55:	8a 00                	mov    (%eax),%al
  800a57:	84 c0                	test   %al,%al
  800a59:	74 0e                	je     800a69 <strncmp+0x2b>
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	8a 10                	mov    (%eax),%dl
  800a60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a63:	8a 00                	mov    (%eax),%al
  800a65:	38 c2                	cmp    %al,%dl
  800a67:	74 da                	je     800a43 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a69:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6d:	75 07                	jne    800a76 <strncmp+0x38>
		return 0;
  800a6f:	b8 00 00 00 00       	mov    $0x0,%eax
  800a74:	eb 14                	jmp    800a8a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	8a 00                	mov    (%eax),%al
  800a7b:	0f b6 d0             	movzbl %al,%edx
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	8a 00                	mov    (%eax),%al
  800a83:	0f b6 c0             	movzbl %al,%eax
  800a86:	29 c2                	sub    %eax,%edx
  800a88:	89 d0                	mov    %edx,%eax
}
  800a8a:	5d                   	pop    %ebp
  800a8b:	c3                   	ret    

00800a8c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a8c:	55                   	push   %ebp
  800a8d:	89 e5                	mov    %esp,%ebp
  800a8f:	83 ec 04             	sub    $0x4,%esp
  800a92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a95:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a98:	eb 12                	jmp    800aac <strchr+0x20>
		if (*s == c)
  800a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9d:	8a 00                	mov    (%eax),%al
  800a9f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aa2:	75 05                	jne    800aa9 <strchr+0x1d>
			return (char *) s;
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	eb 11                	jmp    800aba <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800aa9:	ff 45 08             	incl   0x8(%ebp)
  800aac:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaf:	8a 00                	mov    (%eax),%al
  800ab1:	84 c0                	test   %al,%al
  800ab3:	75 e5                	jne    800a9a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ab5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800aba:	c9                   	leave  
  800abb:	c3                   	ret    

00800abc <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800abc:	55                   	push   %ebp
  800abd:	89 e5                	mov    %esp,%ebp
  800abf:	83 ec 04             	sub    $0x4,%esp
  800ac2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ac8:	eb 0d                	jmp    800ad7 <strfind+0x1b>
		if (*s == c)
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8a 00                	mov    (%eax),%al
  800acf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad2:	74 0e                	je     800ae2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ad4:	ff 45 08             	incl   0x8(%ebp)
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	8a 00                	mov    (%eax),%al
  800adc:	84 c0                	test   %al,%al
  800ade:	75 ea                	jne    800aca <strfind+0xe>
  800ae0:	eb 01                	jmp    800ae3 <strfind+0x27>
		if (*s == c)
			break;
  800ae2:	90                   	nop
	return (char *) s;
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ae6:	c9                   	leave  
  800ae7:	c3                   	ret    

00800ae8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ae8:	55                   	push   %ebp
  800ae9:	89 e5                	mov    %esp,%ebp
  800aeb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800af4:	8b 45 10             	mov    0x10(%ebp),%eax
  800af7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800afa:	eb 0e                	jmp    800b0a <memset+0x22>
		*p++ = c;
  800afc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aff:	8d 50 01             	lea    0x1(%eax),%edx
  800b02:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b08:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b0a:	ff 4d f8             	decl   -0x8(%ebp)
  800b0d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b11:	79 e9                	jns    800afc <memset+0x14>
		*p++ = c;

	return v;
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b16:	c9                   	leave  
  800b17:	c3                   	ret    

00800b18 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b18:	55                   	push   %ebp
  800b19:	89 e5                	mov    %esp,%ebp
  800b1b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b2a:	eb 16                	jmp    800b42 <memcpy+0x2a>
		*d++ = *s++;
  800b2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b2f:	8d 50 01             	lea    0x1(%eax),%edx
  800b32:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b35:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b38:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b3b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b3e:	8a 12                	mov    (%edx),%dl
  800b40:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b42:	8b 45 10             	mov    0x10(%ebp),%eax
  800b45:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b48:	89 55 10             	mov    %edx,0x10(%ebp)
  800b4b:	85 c0                	test   %eax,%eax
  800b4d:	75 dd                	jne    800b2c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b52:	c9                   	leave  
  800b53:	c3                   	ret    

00800b54 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b54:	55                   	push   %ebp
  800b55:	89 e5                	mov    %esp,%ebp
  800b57:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b69:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b6c:	73 50                	jae    800bbe <memmove+0x6a>
  800b6e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b71:	8b 45 10             	mov    0x10(%ebp),%eax
  800b74:	01 d0                	add    %edx,%eax
  800b76:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b79:	76 43                	jbe    800bbe <memmove+0x6a>
		s += n;
  800b7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b81:	8b 45 10             	mov    0x10(%ebp),%eax
  800b84:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b87:	eb 10                	jmp    800b99 <memmove+0x45>
			*--d = *--s;
  800b89:	ff 4d f8             	decl   -0x8(%ebp)
  800b8c:	ff 4d fc             	decl   -0x4(%ebp)
  800b8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b92:	8a 10                	mov    (%eax),%dl
  800b94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b97:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b99:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b9f:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba2:	85 c0                	test   %eax,%eax
  800ba4:	75 e3                	jne    800b89 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ba6:	eb 23                	jmp    800bcb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ba8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bab:	8d 50 01             	lea    0x1(%eax),%edx
  800bae:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bb1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bb4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bba:	8a 12                	mov    (%edx),%dl
  800bbc:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc7:	85 c0                	test   %eax,%eax
  800bc9:	75 dd                	jne    800ba8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bce:	c9                   	leave  
  800bcf:	c3                   	ret    

00800bd0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bd0:	55                   	push   %ebp
  800bd1:	89 e5                	mov    %esp,%ebp
  800bd3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdf:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800be2:	eb 2a                	jmp    800c0e <memcmp+0x3e>
		if (*s1 != *s2)
  800be4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be7:	8a 10                	mov    (%eax),%dl
  800be9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bec:	8a 00                	mov    (%eax),%al
  800bee:	38 c2                	cmp    %al,%dl
  800bf0:	74 16                	je     800c08 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bf2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf5:	8a 00                	mov    (%eax),%al
  800bf7:	0f b6 d0             	movzbl %al,%edx
  800bfa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bfd:	8a 00                	mov    (%eax),%al
  800bff:	0f b6 c0             	movzbl %al,%eax
  800c02:	29 c2                	sub    %eax,%edx
  800c04:	89 d0                	mov    %edx,%eax
  800c06:	eb 18                	jmp    800c20 <memcmp+0x50>
		s1++, s2++;
  800c08:	ff 45 fc             	incl   -0x4(%ebp)
  800c0b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c11:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c14:	89 55 10             	mov    %edx,0x10(%ebp)
  800c17:	85 c0                	test   %eax,%eax
  800c19:	75 c9                	jne    800be4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c20:	c9                   	leave  
  800c21:	c3                   	ret    

00800c22 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c22:	55                   	push   %ebp
  800c23:	89 e5                	mov    %esp,%ebp
  800c25:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c28:	8b 55 08             	mov    0x8(%ebp),%edx
  800c2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2e:	01 d0                	add    %edx,%eax
  800c30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c33:	eb 15                	jmp    800c4a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	0f b6 d0             	movzbl %al,%edx
  800c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c40:	0f b6 c0             	movzbl %al,%eax
  800c43:	39 c2                	cmp    %eax,%edx
  800c45:	74 0d                	je     800c54 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c47:	ff 45 08             	incl   0x8(%ebp)
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c50:	72 e3                	jb     800c35 <memfind+0x13>
  800c52:	eb 01                	jmp    800c55 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c54:	90                   	nop
	return (void *) s;
  800c55:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c58:	c9                   	leave  
  800c59:	c3                   	ret    

00800c5a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c5a:	55                   	push   %ebp
  800c5b:	89 e5                	mov    %esp,%ebp
  800c5d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c67:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c6e:	eb 03                	jmp    800c73 <strtol+0x19>
		s++;
  800c70:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	8a 00                	mov    (%eax),%al
  800c78:	3c 20                	cmp    $0x20,%al
  800c7a:	74 f4                	je     800c70 <strtol+0x16>
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	3c 09                	cmp    $0x9,%al
  800c83:	74 eb                	je     800c70 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	8a 00                	mov    (%eax),%al
  800c8a:	3c 2b                	cmp    $0x2b,%al
  800c8c:	75 05                	jne    800c93 <strtol+0x39>
		s++;
  800c8e:	ff 45 08             	incl   0x8(%ebp)
  800c91:	eb 13                	jmp    800ca6 <strtol+0x4c>
	else if (*s == '-')
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	3c 2d                	cmp    $0x2d,%al
  800c9a:	75 0a                	jne    800ca6 <strtol+0x4c>
		s++, neg = 1;
  800c9c:	ff 45 08             	incl   0x8(%ebp)
  800c9f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ca6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800caa:	74 06                	je     800cb2 <strtol+0x58>
  800cac:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cb0:	75 20                	jne    800cd2 <strtol+0x78>
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	3c 30                	cmp    $0x30,%al
  800cb9:	75 17                	jne    800cd2 <strtol+0x78>
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	40                   	inc    %eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	3c 78                	cmp    $0x78,%al
  800cc3:	75 0d                	jne    800cd2 <strtol+0x78>
		s += 2, base = 16;
  800cc5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cc9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cd0:	eb 28                	jmp    800cfa <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cd2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd6:	75 15                	jne    800ced <strtol+0x93>
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	3c 30                	cmp    $0x30,%al
  800cdf:	75 0c                	jne    800ced <strtol+0x93>
		s++, base = 8;
  800ce1:	ff 45 08             	incl   0x8(%ebp)
  800ce4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ceb:	eb 0d                	jmp    800cfa <strtol+0xa0>
	else if (base == 0)
  800ced:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf1:	75 07                	jne    800cfa <strtol+0xa0>
		base = 10;
  800cf3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	3c 2f                	cmp    $0x2f,%al
  800d01:	7e 19                	jle    800d1c <strtol+0xc2>
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	3c 39                	cmp    $0x39,%al
  800d0a:	7f 10                	jg     800d1c <strtol+0xc2>
			dig = *s - '0';
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8a 00                	mov    (%eax),%al
  800d11:	0f be c0             	movsbl %al,%eax
  800d14:	83 e8 30             	sub    $0x30,%eax
  800d17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d1a:	eb 42                	jmp    800d5e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	3c 60                	cmp    $0x60,%al
  800d23:	7e 19                	jle    800d3e <strtol+0xe4>
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8a 00                	mov    (%eax),%al
  800d2a:	3c 7a                	cmp    $0x7a,%al
  800d2c:	7f 10                	jg     800d3e <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	8a 00                	mov    (%eax),%al
  800d33:	0f be c0             	movsbl %al,%eax
  800d36:	83 e8 57             	sub    $0x57,%eax
  800d39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d3c:	eb 20                	jmp    800d5e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 00                	mov    (%eax),%al
  800d43:	3c 40                	cmp    $0x40,%al
  800d45:	7e 39                	jle    800d80 <strtol+0x126>
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	3c 5a                	cmp    $0x5a,%al
  800d4e:	7f 30                	jg     800d80 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	8a 00                	mov    (%eax),%al
  800d55:	0f be c0             	movsbl %al,%eax
  800d58:	83 e8 37             	sub    $0x37,%eax
  800d5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d61:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d64:	7d 19                	jge    800d7f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d66:	ff 45 08             	incl   0x8(%ebp)
  800d69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6c:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d70:	89 c2                	mov    %eax,%edx
  800d72:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d75:	01 d0                	add    %edx,%eax
  800d77:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d7a:	e9 7b ff ff ff       	jmp    800cfa <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d7f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d80:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d84:	74 08                	je     800d8e <strtol+0x134>
		*endptr = (char *) s;
  800d86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d89:	8b 55 08             	mov    0x8(%ebp),%edx
  800d8c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d8e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d92:	74 07                	je     800d9b <strtol+0x141>
  800d94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d97:	f7 d8                	neg    %eax
  800d99:	eb 03                	jmp    800d9e <strtol+0x144>
  800d9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d9e:	c9                   	leave  
  800d9f:	c3                   	ret    

00800da0 <ltostr>:

void
ltostr(long value, char *str)
{
  800da0:	55                   	push   %ebp
  800da1:	89 e5                	mov    %esp,%ebp
  800da3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800da6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dad:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800db4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800db8:	79 13                	jns    800dcd <ltostr+0x2d>
	{
		neg = 1;
  800dba:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dc7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dca:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dd5:	99                   	cltd   
  800dd6:	f7 f9                	idiv   %ecx
  800dd8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ddb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dde:	8d 50 01             	lea    0x1(%eax),%edx
  800de1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de4:	89 c2                	mov    %eax,%edx
  800de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de9:	01 d0                	add    %edx,%eax
  800deb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dee:	83 c2 30             	add    $0x30,%edx
  800df1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800df3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800df6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dfb:	f7 e9                	imul   %ecx
  800dfd:	c1 fa 02             	sar    $0x2,%edx
  800e00:	89 c8                	mov    %ecx,%eax
  800e02:	c1 f8 1f             	sar    $0x1f,%eax
  800e05:	29 c2                	sub    %eax,%edx
  800e07:	89 d0                	mov    %edx,%eax
  800e09:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e0c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e0f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e14:	f7 e9                	imul   %ecx
  800e16:	c1 fa 02             	sar    $0x2,%edx
  800e19:	89 c8                	mov    %ecx,%eax
  800e1b:	c1 f8 1f             	sar    $0x1f,%eax
  800e1e:	29 c2                	sub    %eax,%edx
  800e20:	89 d0                	mov    %edx,%eax
  800e22:	c1 e0 02             	shl    $0x2,%eax
  800e25:	01 d0                	add    %edx,%eax
  800e27:	01 c0                	add    %eax,%eax
  800e29:	29 c1                	sub    %eax,%ecx
  800e2b:	89 ca                	mov    %ecx,%edx
  800e2d:	85 d2                	test   %edx,%edx
  800e2f:	75 9c                	jne    800dcd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e38:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3b:	48                   	dec    %eax
  800e3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e3f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e43:	74 3d                	je     800e82 <ltostr+0xe2>
		start = 1 ;
  800e45:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e4c:	eb 34                	jmp    800e82 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e54:	01 d0                	add    %edx,%eax
  800e56:	8a 00                	mov    (%eax),%al
  800e58:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e61:	01 c2                	add    %eax,%edx
  800e63:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	01 c8                	add    %ecx,%eax
  800e6b:	8a 00                	mov    (%eax),%al
  800e6d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e6f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e75:	01 c2                	add    %eax,%edx
  800e77:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e7a:	88 02                	mov    %al,(%edx)
		start++ ;
  800e7c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e7f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e82:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e85:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e88:	7c c4                	jl     800e4e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e8a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e90:	01 d0                	add    %edx,%eax
  800e92:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e95:	90                   	nop
  800e96:	c9                   	leave  
  800e97:	c3                   	ret    

00800e98 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e98:	55                   	push   %ebp
  800e99:	89 e5                	mov    %esp,%ebp
  800e9b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e9e:	ff 75 08             	pushl  0x8(%ebp)
  800ea1:	e8 54 fa ff ff       	call   8008fa <strlen>
  800ea6:	83 c4 04             	add    $0x4,%esp
  800ea9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eac:	ff 75 0c             	pushl  0xc(%ebp)
  800eaf:	e8 46 fa ff ff       	call   8008fa <strlen>
  800eb4:	83 c4 04             	add    $0x4,%esp
  800eb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800eba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ec1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ec8:	eb 17                	jmp    800ee1 <strcconcat+0x49>
		final[s] = str1[s] ;
  800eca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ecd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed0:	01 c2                	add    %eax,%edx
  800ed2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed8:	01 c8                	add    %ecx,%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ede:	ff 45 fc             	incl   -0x4(%ebp)
  800ee1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ee7:	7c e1                	jl     800eca <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ee9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ef0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ef7:	eb 1f                	jmp    800f18 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ef9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efc:	8d 50 01             	lea    0x1(%eax),%edx
  800eff:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f02:	89 c2                	mov    %eax,%edx
  800f04:	8b 45 10             	mov    0x10(%ebp),%eax
  800f07:	01 c2                	add    %eax,%edx
  800f09:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0f:	01 c8                	add    %ecx,%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f15:	ff 45 f8             	incl   -0x8(%ebp)
  800f18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f1b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f1e:	7c d9                	jl     800ef9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f23:	8b 45 10             	mov    0x10(%ebp),%eax
  800f26:	01 d0                	add    %edx,%eax
  800f28:	c6 00 00             	movb   $0x0,(%eax)
}
  800f2b:	90                   	nop
  800f2c:	c9                   	leave  
  800f2d:	c3                   	ret    

00800f2e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f31:	8b 45 14             	mov    0x14(%ebp),%eax
  800f34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f3a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3d:	8b 00                	mov    (%eax),%eax
  800f3f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f46:	8b 45 10             	mov    0x10(%ebp),%eax
  800f49:	01 d0                	add    %edx,%eax
  800f4b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f51:	eb 0c                	jmp    800f5f <strsplit+0x31>
			*string++ = 0;
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8d 50 01             	lea    0x1(%eax),%edx
  800f59:	89 55 08             	mov    %edx,0x8(%ebp)
  800f5c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	84 c0                	test   %al,%al
  800f66:	74 18                	je     800f80 <strsplit+0x52>
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	0f be c0             	movsbl %al,%eax
  800f70:	50                   	push   %eax
  800f71:	ff 75 0c             	pushl  0xc(%ebp)
  800f74:	e8 13 fb ff ff       	call   800a8c <strchr>
  800f79:	83 c4 08             	add    $0x8,%esp
  800f7c:	85 c0                	test   %eax,%eax
  800f7e:	75 d3                	jne    800f53 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	84 c0                	test   %al,%al
  800f87:	74 5a                	je     800fe3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f89:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8c:	8b 00                	mov    (%eax),%eax
  800f8e:	83 f8 0f             	cmp    $0xf,%eax
  800f91:	75 07                	jne    800f9a <strsplit+0x6c>
		{
			return 0;
  800f93:	b8 00 00 00 00       	mov    $0x0,%eax
  800f98:	eb 66                	jmp    801000 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9d:	8b 00                	mov    (%eax),%eax
  800f9f:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa2:	8b 55 14             	mov    0x14(%ebp),%edx
  800fa5:	89 0a                	mov    %ecx,(%edx)
  800fa7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fae:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb1:	01 c2                	add    %eax,%edx
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fb8:	eb 03                	jmp    800fbd <strsplit+0x8f>
			string++;
  800fba:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	84 c0                	test   %al,%al
  800fc4:	74 8b                	je     800f51 <strsplit+0x23>
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	8a 00                	mov    (%eax),%al
  800fcb:	0f be c0             	movsbl %al,%eax
  800fce:	50                   	push   %eax
  800fcf:	ff 75 0c             	pushl  0xc(%ebp)
  800fd2:	e8 b5 fa ff ff       	call   800a8c <strchr>
  800fd7:	83 c4 08             	add    $0x8,%esp
  800fda:	85 c0                	test   %eax,%eax
  800fdc:	74 dc                	je     800fba <strsplit+0x8c>
			string++;
	}
  800fde:	e9 6e ff ff ff       	jmp    800f51 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fe3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fe4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe7:	8b 00                	mov    (%eax),%eax
  800fe9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff3:	01 d0                	add    %edx,%eax
  800ff5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800ffb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801000:	c9                   	leave  
  801001:	c3                   	ret    

00801002 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801002:	55                   	push   %ebp
  801003:	89 e5                	mov    %esp,%ebp
  801005:	57                   	push   %edi
  801006:	56                   	push   %esi
  801007:	53                   	push   %ebx
  801008:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801011:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801014:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801017:	8b 7d 18             	mov    0x18(%ebp),%edi
  80101a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80101d:	cd 30                	int    $0x30
  80101f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801022:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801025:	83 c4 10             	add    $0x10,%esp
  801028:	5b                   	pop    %ebx
  801029:	5e                   	pop    %esi
  80102a:	5f                   	pop    %edi
  80102b:	5d                   	pop    %ebp
  80102c:	c3                   	ret    

0080102d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80102d:	55                   	push   %ebp
  80102e:	89 e5                	mov    %esp,%ebp
  801030:	83 ec 04             	sub    $0x4,%esp
  801033:	8b 45 10             	mov    0x10(%ebp),%eax
  801036:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801039:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	6a 00                	push   $0x0
  801042:	6a 00                	push   $0x0
  801044:	52                   	push   %edx
  801045:	ff 75 0c             	pushl  0xc(%ebp)
  801048:	50                   	push   %eax
  801049:	6a 00                	push   $0x0
  80104b:	e8 b2 ff ff ff       	call   801002 <syscall>
  801050:	83 c4 18             	add    $0x18,%esp
}
  801053:	90                   	nop
  801054:	c9                   	leave  
  801055:	c3                   	ret    

00801056 <sys_cgetc>:

int
sys_cgetc(void)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801059:	6a 00                	push   $0x0
  80105b:	6a 00                	push   $0x0
  80105d:	6a 00                	push   $0x0
  80105f:	6a 00                	push   $0x0
  801061:	6a 00                	push   $0x0
  801063:	6a 01                	push   $0x1
  801065:	e8 98 ff ff ff       	call   801002 <syscall>
  80106a:	83 c4 18             	add    $0x18,%esp
}
  80106d:	c9                   	leave  
  80106e:	c3                   	ret    

0080106f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80106f:	55                   	push   %ebp
  801070:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	6a 00                	push   $0x0
  801077:	6a 00                	push   $0x0
  801079:	6a 00                	push   $0x0
  80107b:	6a 00                	push   $0x0
  80107d:	50                   	push   %eax
  80107e:	6a 05                	push   $0x5
  801080:	e8 7d ff ff ff       	call   801002 <syscall>
  801085:	83 c4 18             	add    $0x18,%esp
}
  801088:	c9                   	leave  
  801089:	c3                   	ret    

0080108a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80108a:	55                   	push   %ebp
  80108b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	6a 00                	push   $0x0
  801093:	6a 00                	push   $0x0
  801095:	6a 00                	push   $0x0
  801097:	6a 02                	push   $0x2
  801099:	e8 64 ff ff ff       	call   801002 <syscall>
  80109e:	83 c4 18             	add    $0x18,%esp
}
  8010a1:	c9                   	leave  
  8010a2:	c3                   	ret    

008010a3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010a3:	55                   	push   %ebp
  8010a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010a6:	6a 00                	push   $0x0
  8010a8:	6a 00                	push   $0x0
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 00                	push   $0x0
  8010b0:	6a 03                	push   $0x3
  8010b2:	e8 4b ff ff ff       	call   801002 <syscall>
  8010b7:	83 c4 18             	add    $0x18,%esp
}
  8010ba:	c9                   	leave  
  8010bb:	c3                   	ret    

008010bc <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010bc:	55                   	push   %ebp
  8010bd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 00                	push   $0x0
  8010c5:	6a 00                	push   $0x0
  8010c7:	6a 00                	push   $0x0
  8010c9:	6a 04                	push   $0x4
  8010cb:	e8 32 ff ff ff       	call   801002 <syscall>
  8010d0:	83 c4 18             	add    $0x18,%esp
}
  8010d3:	c9                   	leave  
  8010d4:	c3                   	ret    

008010d5 <sys_env_exit>:


void sys_env_exit(void)
{
  8010d5:	55                   	push   %ebp
  8010d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 00                	push   $0x0
  8010dc:	6a 00                	push   $0x0
  8010de:	6a 00                	push   $0x0
  8010e0:	6a 00                	push   $0x0
  8010e2:	6a 06                	push   $0x6
  8010e4:	e8 19 ff ff ff       	call   801002 <syscall>
  8010e9:	83 c4 18             	add    $0x18,%esp
}
  8010ec:	90                   	nop
  8010ed:	c9                   	leave  
  8010ee:	c3                   	ret    

008010ef <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010ef:	55                   	push   %ebp
  8010f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	6a 00                	push   $0x0
  8010fa:	6a 00                	push   $0x0
  8010fc:	6a 00                	push   $0x0
  8010fe:	52                   	push   %edx
  8010ff:	50                   	push   %eax
  801100:	6a 07                	push   $0x7
  801102:	e8 fb fe ff ff       	call   801002 <syscall>
  801107:	83 c4 18             	add    $0x18,%esp
}
  80110a:	c9                   	leave  
  80110b:	c3                   	ret    

0080110c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80110c:	55                   	push   %ebp
  80110d:	89 e5                	mov    %esp,%ebp
  80110f:	56                   	push   %esi
  801110:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801111:	8b 75 18             	mov    0x18(%ebp),%esi
  801114:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801117:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80111a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	56                   	push   %esi
  801121:	53                   	push   %ebx
  801122:	51                   	push   %ecx
  801123:	52                   	push   %edx
  801124:	50                   	push   %eax
  801125:	6a 08                	push   $0x8
  801127:	e8 d6 fe ff ff       	call   801002 <syscall>
  80112c:	83 c4 18             	add    $0x18,%esp
}
  80112f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801132:	5b                   	pop    %ebx
  801133:	5e                   	pop    %esi
  801134:	5d                   	pop    %ebp
  801135:	c3                   	ret    

00801136 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801139:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	6a 00                	push   $0x0
  801141:	6a 00                	push   $0x0
  801143:	6a 00                	push   $0x0
  801145:	52                   	push   %edx
  801146:	50                   	push   %eax
  801147:	6a 09                	push   $0x9
  801149:	e8 b4 fe ff ff       	call   801002 <syscall>
  80114e:	83 c4 18             	add    $0x18,%esp
}
  801151:	c9                   	leave  
  801152:	c3                   	ret    

00801153 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801156:	6a 00                	push   $0x0
  801158:	6a 00                	push   $0x0
  80115a:	6a 00                	push   $0x0
  80115c:	ff 75 0c             	pushl  0xc(%ebp)
  80115f:	ff 75 08             	pushl  0x8(%ebp)
  801162:	6a 0a                	push   $0xa
  801164:	e8 99 fe ff ff       	call   801002 <syscall>
  801169:	83 c4 18             	add    $0x18,%esp
}
  80116c:	c9                   	leave  
  80116d:	c3                   	ret    

0080116e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801171:	6a 00                	push   $0x0
  801173:	6a 00                	push   $0x0
  801175:	6a 00                	push   $0x0
  801177:	6a 00                	push   $0x0
  801179:	6a 00                	push   $0x0
  80117b:	6a 0b                	push   $0xb
  80117d:	e8 80 fe ff ff       	call   801002 <syscall>
  801182:	83 c4 18             	add    $0x18,%esp
}
  801185:	c9                   	leave  
  801186:	c3                   	ret    

00801187 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80118a:	6a 00                	push   $0x0
  80118c:	6a 00                	push   $0x0
  80118e:	6a 00                	push   $0x0
  801190:	6a 00                	push   $0x0
  801192:	6a 00                	push   $0x0
  801194:	6a 0c                	push   $0xc
  801196:	e8 67 fe ff ff       	call   801002 <syscall>
  80119b:	83 c4 18             	add    $0x18,%esp
}
  80119e:	c9                   	leave  
  80119f:	c3                   	ret    

008011a0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011a0:	55                   	push   %ebp
  8011a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	6a 00                	push   $0x0
  8011a9:	6a 00                	push   $0x0
  8011ab:	6a 00                	push   $0x0
  8011ad:	6a 0d                	push   $0xd
  8011af:	e8 4e fe ff ff       	call   801002 <syscall>
  8011b4:	83 c4 18             	add    $0x18,%esp
}
  8011b7:	c9                   	leave  
  8011b8:	c3                   	ret    

008011b9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011b9:	55                   	push   %ebp
  8011ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	ff 75 0c             	pushl  0xc(%ebp)
  8011c5:	ff 75 08             	pushl  0x8(%ebp)
  8011c8:	6a 11                	push   $0x11
  8011ca:	e8 33 fe ff ff       	call   801002 <syscall>
  8011cf:	83 c4 18             	add    $0x18,%esp
	return;
  8011d2:	90                   	nop
}
  8011d3:	c9                   	leave  
  8011d4:	c3                   	ret    

008011d5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011d5:	55                   	push   %ebp
  8011d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 00                	push   $0x0
  8011de:	ff 75 0c             	pushl  0xc(%ebp)
  8011e1:	ff 75 08             	pushl  0x8(%ebp)
  8011e4:	6a 12                	push   $0x12
  8011e6:	e8 17 fe ff ff       	call   801002 <syscall>
  8011eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8011ee:	90                   	nop
}
  8011ef:	c9                   	leave  
  8011f0:	c3                   	ret    

008011f1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011f1:	55                   	push   %ebp
  8011f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 00                	push   $0x0
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 0e                	push   $0xe
  801200:	e8 fd fd ff ff       	call   801002 <syscall>
  801205:	83 c4 18             	add    $0x18,%esp
}
  801208:	c9                   	leave  
  801209:	c3                   	ret    

0080120a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80120a:	55                   	push   %ebp
  80120b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80120d:	6a 00                	push   $0x0
  80120f:	6a 00                	push   $0x0
  801211:	6a 00                	push   $0x0
  801213:	6a 00                	push   $0x0
  801215:	ff 75 08             	pushl  0x8(%ebp)
  801218:	6a 0f                	push   $0xf
  80121a:	e8 e3 fd ff ff       	call   801002 <syscall>
  80121f:	83 c4 18             	add    $0x18,%esp
}
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	6a 00                	push   $0x0
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 10                	push   $0x10
  801233:	e8 ca fd ff ff       	call   801002 <syscall>
  801238:	83 c4 18             	add    $0x18,%esp
}
  80123b:	90                   	nop
  80123c:	c9                   	leave  
  80123d:	c3                   	ret    

0080123e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80123e:	55                   	push   %ebp
  80123f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	6a 00                	push   $0x0
  80124b:	6a 14                	push   $0x14
  80124d:	e8 b0 fd ff ff       	call   801002 <syscall>
  801252:	83 c4 18             	add    $0x18,%esp
}
  801255:	90                   	nop
  801256:	c9                   	leave  
  801257:	c3                   	ret    

00801258 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801258:	55                   	push   %ebp
  801259:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 00                	push   $0x0
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 15                	push   $0x15
  801267:	e8 96 fd ff ff       	call   801002 <syscall>
  80126c:	83 c4 18             	add    $0x18,%esp
}
  80126f:	90                   	nop
  801270:	c9                   	leave  
  801271:	c3                   	ret    

00801272 <sys_cputc>:


void
sys_cputc(const char c)
{
  801272:	55                   	push   %ebp
  801273:	89 e5                	mov    %esp,%ebp
  801275:	83 ec 04             	sub    $0x4,%esp
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80127e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	50                   	push   %eax
  80128b:	6a 16                	push   $0x16
  80128d:	e8 70 fd ff ff       	call   801002 <syscall>
  801292:	83 c4 18             	add    $0x18,%esp
}
  801295:	90                   	nop
  801296:	c9                   	leave  
  801297:	c3                   	ret    

00801298 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801298:	55                   	push   %ebp
  801299:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 00                	push   $0x0
  8012a1:	6a 00                	push   $0x0
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 17                	push   $0x17
  8012a7:	e8 56 fd ff ff       	call   801002 <syscall>
  8012ac:	83 c4 18             	add    $0x18,%esp
}
  8012af:	90                   	nop
  8012b0:	c9                   	leave  
  8012b1:	c3                   	ret    

008012b2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012b2:	55                   	push   %ebp
  8012b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	ff 75 0c             	pushl  0xc(%ebp)
  8012c1:	50                   	push   %eax
  8012c2:	6a 18                	push   $0x18
  8012c4:	e8 39 fd ff ff       	call   801002 <syscall>
  8012c9:	83 c4 18             	add    $0x18,%esp
}
  8012cc:	c9                   	leave  
  8012cd:	c3                   	ret    

008012ce <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012ce:	55                   	push   %ebp
  8012cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	52                   	push   %edx
  8012de:	50                   	push   %eax
  8012df:	6a 1b                	push   $0x1b
  8012e1:	e8 1c fd ff ff       	call   801002 <syscall>
  8012e6:	83 c4 18             	add    $0x18,%esp
}
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	52                   	push   %edx
  8012fb:	50                   	push   %eax
  8012fc:	6a 19                	push   $0x19
  8012fe:	e8 ff fc ff ff       	call   801002 <syscall>
  801303:	83 c4 18             	add    $0x18,%esp
}
  801306:	90                   	nop
  801307:	c9                   	leave  
  801308:	c3                   	ret    

00801309 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80130c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	52                   	push   %edx
  801319:	50                   	push   %eax
  80131a:	6a 1a                	push   $0x1a
  80131c:	e8 e1 fc ff ff       	call   801002 <syscall>
  801321:	83 c4 18             	add    $0x18,%esp
}
  801324:	90                   	nop
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
  80132a:	83 ec 04             	sub    $0x4,%esp
  80132d:	8b 45 10             	mov    0x10(%ebp),%eax
  801330:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801333:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801336:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	6a 00                	push   $0x0
  80133f:	51                   	push   %ecx
  801340:	52                   	push   %edx
  801341:	ff 75 0c             	pushl  0xc(%ebp)
  801344:	50                   	push   %eax
  801345:	6a 1c                	push   $0x1c
  801347:	e8 b6 fc ff ff       	call   801002 <syscall>
  80134c:	83 c4 18             	add    $0x18,%esp
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801354:	8b 55 0c             	mov    0xc(%ebp),%edx
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	52                   	push   %edx
  801361:	50                   	push   %eax
  801362:	6a 1d                	push   $0x1d
  801364:	e8 99 fc ff ff       	call   801002 <syscall>
  801369:	83 c4 18             	add    $0x18,%esp
}
  80136c:	c9                   	leave  
  80136d:	c3                   	ret    

0080136e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80136e:	55                   	push   %ebp
  80136f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801371:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801374:	8b 55 0c             	mov    0xc(%ebp),%edx
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	51                   	push   %ecx
  80137f:	52                   	push   %edx
  801380:	50                   	push   %eax
  801381:	6a 1e                	push   $0x1e
  801383:	e8 7a fc ff ff       	call   801002 <syscall>
  801388:	83 c4 18             	add    $0x18,%esp
}
  80138b:	c9                   	leave  
  80138c:	c3                   	ret    

0080138d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80138d:	55                   	push   %ebp
  80138e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801390:	8b 55 0c             	mov    0xc(%ebp),%edx
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	52                   	push   %edx
  80139d:	50                   	push   %eax
  80139e:	6a 1f                	push   $0x1f
  8013a0:	e8 5d fc ff ff       	call   801002 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 20                	push   $0x20
  8013b9:	e8 44 fc ff ff       	call   801002 <syscall>
  8013be:	83 c4 18             	add    $0x18,%esp
}
  8013c1:	c9                   	leave  
  8013c2:	c3                   	ret    

008013c3 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013c3:	55                   	push   %ebp
  8013c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	ff 75 10             	pushl  0x10(%ebp)
  8013d0:	ff 75 0c             	pushl  0xc(%ebp)
  8013d3:	50                   	push   %eax
  8013d4:	6a 21                	push   $0x21
  8013d6:	e8 27 fc ff ff       	call   801002 <syscall>
  8013db:	83 c4 18             	add    $0x18,%esp
}
  8013de:	c9                   	leave  
  8013df:	c3                   	ret    

008013e0 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	50                   	push   %eax
  8013ef:	6a 22                	push   $0x22
  8013f1:	e8 0c fc ff ff       	call   801002 <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	90                   	nop
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	50                   	push   %eax
  80140b:	6a 23                	push   $0x23
  80140d:	e8 f0 fb ff ff       	call   801002 <syscall>
  801412:	83 c4 18             	add    $0x18,%esp
}
  801415:	90                   	nop
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80141e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801421:	8d 50 04             	lea    0x4(%eax),%edx
  801424:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	52                   	push   %edx
  80142e:	50                   	push   %eax
  80142f:	6a 24                	push   $0x24
  801431:	e8 cc fb ff ff       	call   801002 <syscall>
  801436:	83 c4 18             	add    $0x18,%esp
	return result;
  801439:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80143c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801442:	89 01                	mov    %eax,(%ecx)
  801444:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	c9                   	leave  
  80144b:	c2 04 00             	ret    $0x4

0080144e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	ff 75 10             	pushl  0x10(%ebp)
  801458:	ff 75 0c             	pushl  0xc(%ebp)
  80145b:	ff 75 08             	pushl  0x8(%ebp)
  80145e:	6a 13                	push   $0x13
  801460:	e8 9d fb ff ff       	call   801002 <syscall>
  801465:	83 c4 18             	add    $0x18,%esp
	return ;
  801468:	90                   	nop
}
  801469:	c9                   	leave  
  80146a:	c3                   	ret    

0080146b <sys_rcr2>:
uint32 sys_rcr2()
{
  80146b:	55                   	push   %ebp
  80146c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 25                	push   $0x25
  80147a:	e8 83 fb ff ff       	call   801002 <syscall>
  80147f:	83 c4 18             	add    $0x18,%esp
}
  801482:	c9                   	leave  
  801483:	c3                   	ret    

00801484 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801484:	55                   	push   %ebp
  801485:	89 e5                	mov    %esp,%ebp
  801487:	83 ec 04             	sub    $0x4,%esp
  80148a:	8b 45 08             	mov    0x8(%ebp),%eax
  80148d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801490:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	50                   	push   %eax
  80149d:	6a 26                	push   $0x26
  80149f:	e8 5e fb ff ff       	call   801002 <syscall>
  8014a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a7:	90                   	nop
}
  8014a8:	c9                   	leave  
  8014a9:	c3                   	ret    

008014aa <rsttst>:
void rsttst()
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 28                	push   $0x28
  8014b9:	e8 44 fb ff ff       	call   801002 <syscall>
  8014be:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c1:	90                   	nop
}
  8014c2:	c9                   	leave  
  8014c3:	c3                   	ret    

008014c4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
  8014c7:	83 ec 04             	sub    $0x4,%esp
  8014ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8014cd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014d0:	8b 55 18             	mov    0x18(%ebp),%edx
  8014d3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014d7:	52                   	push   %edx
  8014d8:	50                   	push   %eax
  8014d9:	ff 75 10             	pushl  0x10(%ebp)
  8014dc:	ff 75 0c             	pushl  0xc(%ebp)
  8014df:	ff 75 08             	pushl  0x8(%ebp)
  8014e2:	6a 27                	push   $0x27
  8014e4:	e8 19 fb ff ff       	call   801002 <syscall>
  8014e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ec:	90                   	nop
}
  8014ed:	c9                   	leave  
  8014ee:	c3                   	ret    

008014ef <chktst>:
void chktst(uint32 n)
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	ff 75 08             	pushl  0x8(%ebp)
  8014fd:	6a 29                	push   $0x29
  8014ff:	e8 fe fa ff ff       	call   801002 <syscall>
  801504:	83 c4 18             	add    $0x18,%esp
	return ;
  801507:	90                   	nop
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <inctst>:

void inctst()
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 2a                	push   $0x2a
  801519:	e8 e4 fa ff ff       	call   801002 <syscall>
  80151e:	83 c4 18             	add    $0x18,%esp
	return ;
  801521:	90                   	nop
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <gettst>:
uint32 gettst()
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 2b                	push   $0x2b
  801533:	e8 ca fa ff ff       	call   801002 <syscall>
  801538:	83 c4 18             	add    $0x18,%esp
}
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
  801540:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 2c                	push   $0x2c
  80154f:	e8 ae fa ff ff       	call   801002 <syscall>
  801554:	83 c4 18             	add    $0x18,%esp
  801557:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80155a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80155e:	75 07                	jne    801567 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801560:	b8 01 00 00 00       	mov    $0x1,%eax
  801565:	eb 05                	jmp    80156c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801567:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156c:	c9                   	leave  
  80156d:	c3                   	ret    

0080156e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
  801571:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 2c                	push   $0x2c
  801580:	e8 7d fa ff ff       	call   801002 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
  801588:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80158b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80158f:	75 07                	jne    801598 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801591:	b8 01 00 00 00       	mov    $0x1,%eax
  801596:	eb 05                	jmp    80159d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801598:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80159d:	c9                   	leave  
  80159e:	c3                   	ret    

0080159f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
  8015a2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 2c                	push   $0x2c
  8015b1:	e8 4c fa ff ff       	call   801002 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
  8015b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015bc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015c0:	75 07                	jne    8015c9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c7:	eb 05                	jmp    8015ce <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
  8015d3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 2c                	push   $0x2c
  8015e2:	e8 1b fa ff ff       	call   801002 <syscall>
  8015e7:	83 c4 18             	add    $0x18,%esp
  8015ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015ed:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015f1:	75 07                	jne    8015fa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015f3:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f8:	eb 05                	jmp    8015ff <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	ff 75 08             	pushl  0x8(%ebp)
  80160f:	6a 2d                	push   $0x2d
  801611:	e8 ec f9 ff ff       	call   801002 <syscall>
  801616:	83 c4 18             	add    $0x18,%esp
	return ;
  801619:	90                   	nop
}
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <__udivdi3>:
  80161c:	55                   	push   %ebp
  80161d:	57                   	push   %edi
  80161e:	56                   	push   %esi
  80161f:	53                   	push   %ebx
  801620:	83 ec 1c             	sub    $0x1c,%esp
  801623:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801627:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80162b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80162f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801633:	89 ca                	mov    %ecx,%edx
  801635:	89 f8                	mov    %edi,%eax
  801637:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80163b:	85 f6                	test   %esi,%esi
  80163d:	75 2d                	jne    80166c <__udivdi3+0x50>
  80163f:	39 cf                	cmp    %ecx,%edi
  801641:	77 65                	ja     8016a8 <__udivdi3+0x8c>
  801643:	89 fd                	mov    %edi,%ebp
  801645:	85 ff                	test   %edi,%edi
  801647:	75 0b                	jne    801654 <__udivdi3+0x38>
  801649:	b8 01 00 00 00       	mov    $0x1,%eax
  80164e:	31 d2                	xor    %edx,%edx
  801650:	f7 f7                	div    %edi
  801652:	89 c5                	mov    %eax,%ebp
  801654:	31 d2                	xor    %edx,%edx
  801656:	89 c8                	mov    %ecx,%eax
  801658:	f7 f5                	div    %ebp
  80165a:	89 c1                	mov    %eax,%ecx
  80165c:	89 d8                	mov    %ebx,%eax
  80165e:	f7 f5                	div    %ebp
  801660:	89 cf                	mov    %ecx,%edi
  801662:	89 fa                	mov    %edi,%edx
  801664:	83 c4 1c             	add    $0x1c,%esp
  801667:	5b                   	pop    %ebx
  801668:	5e                   	pop    %esi
  801669:	5f                   	pop    %edi
  80166a:	5d                   	pop    %ebp
  80166b:	c3                   	ret    
  80166c:	39 ce                	cmp    %ecx,%esi
  80166e:	77 28                	ja     801698 <__udivdi3+0x7c>
  801670:	0f bd fe             	bsr    %esi,%edi
  801673:	83 f7 1f             	xor    $0x1f,%edi
  801676:	75 40                	jne    8016b8 <__udivdi3+0x9c>
  801678:	39 ce                	cmp    %ecx,%esi
  80167a:	72 0a                	jb     801686 <__udivdi3+0x6a>
  80167c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801680:	0f 87 9e 00 00 00    	ja     801724 <__udivdi3+0x108>
  801686:	b8 01 00 00 00       	mov    $0x1,%eax
  80168b:	89 fa                	mov    %edi,%edx
  80168d:	83 c4 1c             	add    $0x1c,%esp
  801690:	5b                   	pop    %ebx
  801691:	5e                   	pop    %esi
  801692:	5f                   	pop    %edi
  801693:	5d                   	pop    %ebp
  801694:	c3                   	ret    
  801695:	8d 76 00             	lea    0x0(%esi),%esi
  801698:	31 ff                	xor    %edi,%edi
  80169a:	31 c0                	xor    %eax,%eax
  80169c:	89 fa                	mov    %edi,%edx
  80169e:	83 c4 1c             	add    $0x1c,%esp
  8016a1:	5b                   	pop    %ebx
  8016a2:	5e                   	pop    %esi
  8016a3:	5f                   	pop    %edi
  8016a4:	5d                   	pop    %ebp
  8016a5:	c3                   	ret    
  8016a6:	66 90                	xchg   %ax,%ax
  8016a8:	89 d8                	mov    %ebx,%eax
  8016aa:	f7 f7                	div    %edi
  8016ac:	31 ff                	xor    %edi,%edi
  8016ae:	89 fa                	mov    %edi,%edx
  8016b0:	83 c4 1c             	add    $0x1c,%esp
  8016b3:	5b                   	pop    %ebx
  8016b4:	5e                   	pop    %esi
  8016b5:	5f                   	pop    %edi
  8016b6:	5d                   	pop    %ebp
  8016b7:	c3                   	ret    
  8016b8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016bd:	89 eb                	mov    %ebp,%ebx
  8016bf:	29 fb                	sub    %edi,%ebx
  8016c1:	89 f9                	mov    %edi,%ecx
  8016c3:	d3 e6                	shl    %cl,%esi
  8016c5:	89 c5                	mov    %eax,%ebp
  8016c7:	88 d9                	mov    %bl,%cl
  8016c9:	d3 ed                	shr    %cl,%ebp
  8016cb:	89 e9                	mov    %ebp,%ecx
  8016cd:	09 f1                	or     %esi,%ecx
  8016cf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016d3:	89 f9                	mov    %edi,%ecx
  8016d5:	d3 e0                	shl    %cl,%eax
  8016d7:	89 c5                	mov    %eax,%ebp
  8016d9:	89 d6                	mov    %edx,%esi
  8016db:	88 d9                	mov    %bl,%cl
  8016dd:	d3 ee                	shr    %cl,%esi
  8016df:	89 f9                	mov    %edi,%ecx
  8016e1:	d3 e2                	shl    %cl,%edx
  8016e3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016e7:	88 d9                	mov    %bl,%cl
  8016e9:	d3 e8                	shr    %cl,%eax
  8016eb:	09 c2                	or     %eax,%edx
  8016ed:	89 d0                	mov    %edx,%eax
  8016ef:	89 f2                	mov    %esi,%edx
  8016f1:	f7 74 24 0c          	divl   0xc(%esp)
  8016f5:	89 d6                	mov    %edx,%esi
  8016f7:	89 c3                	mov    %eax,%ebx
  8016f9:	f7 e5                	mul    %ebp
  8016fb:	39 d6                	cmp    %edx,%esi
  8016fd:	72 19                	jb     801718 <__udivdi3+0xfc>
  8016ff:	74 0b                	je     80170c <__udivdi3+0xf0>
  801701:	89 d8                	mov    %ebx,%eax
  801703:	31 ff                	xor    %edi,%edi
  801705:	e9 58 ff ff ff       	jmp    801662 <__udivdi3+0x46>
  80170a:	66 90                	xchg   %ax,%ax
  80170c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801710:	89 f9                	mov    %edi,%ecx
  801712:	d3 e2                	shl    %cl,%edx
  801714:	39 c2                	cmp    %eax,%edx
  801716:	73 e9                	jae    801701 <__udivdi3+0xe5>
  801718:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80171b:	31 ff                	xor    %edi,%edi
  80171d:	e9 40 ff ff ff       	jmp    801662 <__udivdi3+0x46>
  801722:	66 90                	xchg   %ax,%ax
  801724:	31 c0                	xor    %eax,%eax
  801726:	e9 37 ff ff ff       	jmp    801662 <__udivdi3+0x46>
  80172b:	90                   	nop

0080172c <__umoddi3>:
  80172c:	55                   	push   %ebp
  80172d:	57                   	push   %edi
  80172e:	56                   	push   %esi
  80172f:	53                   	push   %ebx
  801730:	83 ec 1c             	sub    $0x1c,%esp
  801733:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801737:	8b 74 24 34          	mov    0x34(%esp),%esi
  80173b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80173f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801743:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801747:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80174b:	89 f3                	mov    %esi,%ebx
  80174d:	89 fa                	mov    %edi,%edx
  80174f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801753:	89 34 24             	mov    %esi,(%esp)
  801756:	85 c0                	test   %eax,%eax
  801758:	75 1a                	jne    801774 <__umoddi3+0x48>
  80175a:	39 f7                	cmp    %esi,%edi
  80175c:	0f 86 a2 00 00 00    	jbe    801804 <__umoddi3+0xd8>
  801762:	89 c8                	mov    %ecx,%eax
  801764:	89 f2                	mov    %esi,%edx
  801766:	f7 f7                	div    %edi
  801768:	89 d0                	mov    %edx,%eax
  80176a:	31 d2                	xor    %edx,%edx
  80176c:	83 c4 1c             	add    $0x1c,%esp
  80176f:	5b                   	pop    %ebx
  801770:	5e                   	pop    %esi
  801771:	5f                   	pop    %edi
  801772:	5d                   	pop    %ebp
  801773:	c3                   	ret    
  801774:	39 f0                	cmp    %esi,%eax
  801776:	0f 87 ac 00 00 00    	ja     801828 <__umoddi3+0xfc>
  80177c:	0f bd e8             	bsr    %eax,%ebp
  80177f:	83 f5 1f             	xor    $0x1f,%ebp
  801782:	0f 84 ac 00 00 00    	je     801834 <__umoddi3+0x108>
  801788:	bf 20 00 00 00       	mov    $0x20,%edi
  80178d:	29 ef                	sub    %ebp,%edi
  80178f:	89 fe                	mov    %edi,%esi
  801791:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801795:	89 e9                	mov    %ebp,%ecx
  801797:	d3 e0                	shl    %cl,%eax
  801799:	89 d7                	mov    %edx,%edi
  80179b:	89 f1                	mov    %esi,%ecx
  80179d:	d3 ef                	shr    %cl,%edi
  80179f:	09 c7                	or     %eax,%edi
  8017a1:	89 e9                	mov    %ebp,%ecx
  8017a3:	d3 e2                	shl    %cl,%edx
  8017a5:	89 14 24             	mov    %edx,(%esp)
  8017a8:	89 d8                	mov    %ebx,%eax
  8017aa:	d3 e0                	shl    %cl,%eax
  8017ac:	89 c2                	mov    %eax,%edx
  8017ae:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017b2:	d3 e0                	shl    %cl,%eax
  8017b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017b8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017bc:	89 f1                	mov    %esi,%ecx
  8017be:	d3 e8                	shr    %cl,%eax
  8017c0:	09 d0                	or     %edx,%eax
  8017c2:	d3 eb                	shr    %cl,%ebx
  8017c4:	89 da                	mov    %ebx,%edx
  8017c6:	f7 f7                	div    %edi
  8017c8:	89 d3                	mov    %edx,%ebx
  8017ca:	f7 24 24             	mull   (%esp)
  8017cd:	89 c6                	mov    %eax,%esi
  8017cf:	89 d1                	mov    %edx,%ecx
  8017d1:	39 d3                	cmp    %edx,%ebx
  8017d3:	0f 82 87 00 00 00    	jb     801860 <__umoddi3+0x134>
  8017d9:	0f 84 91 00 00 00    	je     801870 <__umoddi3+0x144>
  8017df:	8b 54 24 04          	mov    0x4(%esp),%edx
  8017e3:	29 f2                	sub    %esi,%edx
  8017e5:	19 cb                	sbb    %ecx,%ebx
  8017e7:	89 d8                	mov    %ebx,%eax
  8017e9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017ed:	d3 e0                	shl    %cl,%eax
  8017ef:	89 e9                	mov    %ebp,%ecx
  8017f1:	d3 ea                	shr    %cl,%edx
  8017f3:	09 d0                	or     %edx,%eax
  8017f5:	89 e9                	mov    %ebp,%ecx
  8017f7:	d3 eb                	shr    %cl,%ebx
  8017f9:	89 da                	mov    %ebx,%edx
  8017fb:	83 c4 1c             	add    $0x1c,%esp
  8017fe:	5b                   	pop    %ebx
  8017ff:	5e                   	pop    %esi
  801800:	5f                   	pop    %edi
  801801:	5d                   	pop    %ebp
  801802:	c3                   	ret    
  801803:	90                   	nop
  801804:	89 fd                	mov    %edi,%ebp
  801806:	85 ff                	test   %edi,%edi
  801808:	75 0b                	jne    801815 <__umoddi3+0xe9>
  80180a:	b8 01 00 00 00       	mov    $0x1,%eax
  80180f:	31 d2                	xor    %edx,%edx
  801811:	f7 f7                	div    %edi
  801813:	89 c5                	mov    %eax,%ebp
  801815:	89 f0                	mov    %esi,%eax
  801817:	31 d2                	xor    %edx,%edx
  801819:	f7 f5                	div    %ebp
  80181b:	89 c8                	mov    %ecx,%eax
  80181d:	f7 f5                	div    %ebp
  80181f:	89 d0                	mov    %edx,%eax
  801821:	e9 44 ff ff ff       	jmp    80176a <__umoddi3+0x3e>
  801826:	66 90                	xchg   %ax,%ax
  801828:	89 c8                	mov    %ecx,%eax
  80182a:	89 f2                	mov    %esi,%edx
  80182c:	83 c4 1c             	add    $0x1c,%esp
  80182f:	5b                   	pop    %ebx
  801830:	5e                   	pop    %esi
  801831:	5f                   	pop    %edi
  801832:	5d                   	pop    %ebp
  801833:	c3                   	ret    
  801834:	3b 04 24             	cmp    (%esp),%eax
  801837:	72 06                	jb     80183f <__umoddi3+0x113>
  801839:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80183d:	77 0f                	ja     80184e <__umoddi3+0x122>
  80183f:	89 f2                	mov    %esi,%edx
  801841:	29 f9                	sub    %edi,%ecx
  801843:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801847:	89 14 24             	mov    %edx,(%esp)
  80184a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80184e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801852:	8b 14 24             	mov    (%esp),%edx
  801855:	83 c4 1c             	add    $0x1c,%esp
  801858:	5b                   	pop    %ebx
  801859:	5e                   	pop    %esi
  80185a:	5f                   	pop    %edi
  80185b:	5d                   	pop    %ebp
  80185c:	c3                   	ret    
  80185d:	8d 76 00             	lea    0x0(%esi),%esi
  801860:	2b 04 24             	sub    (%esp),%eax
  801863:	19 fa                	sbb    %edi,%edx
  801865:	89 d1                	mov    %edx,%ecx
  801867:	89 c6                	mov    %eax,%esi
  801869:	e9 71 ff ff ff       	jmp    8017df <__umoddi3+0xb3>
  80186e:	66 90                	xchg   %ax,%ax
  801870:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801874:	72 ea                	jb     801860 <__umoddi3+0x134>
  801876:	89 d9                	mov    %ebx,%ecx
  801878:	e9 62 ff ff ff       	jmp    8017df <__umoddi3+0xb3>
