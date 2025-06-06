
obj/user/fos_input:     file format elf32-i386


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
  800031:	e8 a5 00 00 00       	call   8000db <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 04 00 00    	sub    $0x418,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800048:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[512];
	char buff2[512];


	atomic_readline("Please enter first number :", buff1);
  80004f:	83 ec 08             	sub    $0x8,%esp
  800052:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800058:	50                   	push   %eax
  800059:	68 20 1c 80 00       	push   $0x801c20
  80005e:	e8 ce 09 00 00       	call   800a31 <atomic_readline>
  800063:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  800066:	83 ec 04             	sub    $0x4,%esp
  800069:	6a 0a                	push   $0xa
  80006b:	6a 00                	push   $0x0
  80006d:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800073:	50                   	push   %eax
  800074:	e8 20 0e 00 00       	call   800e99 <strtol>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	//sleep
	env_sleep(2800);
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 f0 0a 00 00       	push   $0xaf0
  800087:	e8 cf 17 00 00       	call   80185b <env_sleep>
  80008c:	83 c4 10             	add    $0x10,%esp

	atomic_readline("Please enter second number :", buff2);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  800098:	50                   	push   %eax
  800099:	68 3c 1c 80 00       	push   $0x801c3c
  80009e:	e8 8e 09 00 00       	call   800a31 <atomic_readline>
  8000a3:	83 c4 10             	add    $0x10,%esp
	
	i2 = strtol(buff2, NULL, 10);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 0a                	push   $0xa
  8000ab:	6a 00                	push   $0x0
  8000ad:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  8000b3:	50                   	push   %eax
  8000b4:	e8 e0 0d 00 00       	call   800e99 <strtol>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  8000bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	50                   	push   %eax
  8000cb:	68 59 1c 80 00       	push   $0x801c59
  8000d0:	e8 09 02 00 00       	call   8002de <atomic_cprintf>
  8000d5:	83 c4 10             	add    $0x10,%esp
	return;	
  8000d8:	90                   	nop
}
  8000d9:	c9                   	leave  
  8000da:	c3                   	ret    

008000db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000db:	55                   	push   %ebp
  8000dc:	89 e5                	mov    %esp,%ebp
  8000de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e1:	e8 fc 11 00 00       	call   8012e2 <sys_getenvindex>
  8000e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ec:	89 d0                	mov    %edx,%eax
  8000ee:	01 c0                	add    %eax,%eax
  8000f0:	01 d0                	add    %edx,%eax
  8000f2:	c1 e0 02             	shl    $0x2,%eax
  8000f5:	01 d0                	add    %edx,%eax
  8000f7:	c1 e0 06             	shl    $0x6,%eax
  8000fa:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000ff:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800104:	a1 04 30 80 00       	mov    0x803004,%eax
  800109:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80010f:	84 c0                	test   %al,%al
  800111:	74 0f                	je     800122 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800113:	a1 04 30 80 00       	mov    0x803004,%eax
  800118:	05 f4 02 00 00       	add    $0x2f4,%eax
  80011d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800122:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800126:	7e 0a                	jle    800132 <libmain+0x57>
		binaryname = argv[0];
  800128:	8b 45 0c             	mov    0xc(%ebp),%eax
  80012b:	8b 00                	mov    (%eax),%eax
  80012d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800132:	83 ec 08             	sub    $0x8,%esp
  800135:	ff 75 0c             	pushl  0xc(%ebp)
  800138:	ff 75 08             	pushl  0x8(%ebp)
  80013b:	e8 f8 fe ff ff       	call   800038 <_main>
  800140:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800143:	e8 35 13 00 00       	call   80147d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800148:	83 ec 0c             	sub    $0xc,%esp
  80014b:	68 8c 1c 80 00       	push   $0x801c8c
  800150:	e8 5c 01 00 00       	call   8002b1 <cprintf>
  800155:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800158:	a1 04 30 80 00       	mov    0x803004,%eax
  80015d:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800163:	a1 04 30 80 00       	mov    0x803004,%eax
  800168:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	52                   	push   %edx
  800172:	50                   	push   %eax
  800173:	68 b4 1c 80 00       	push   $0x801cb4
  800178:	e8 34 01 00 00       	call   8002b1 <cprintf>
  80017d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800180:	a1 04 30 80 00       	mov    0x803004,%eax
  800185:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80018b:	83 ec 08             	sub    $0x8,%esp
  80018e:	50                   	push   %eax
  80018f:	68 d9 1c 80 00       	push   $0x801cd9
  800194:	e8 18 01 00 00       	call   8002b1 <cprintf>
  800199:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80019c:	83 ec 0c             	sub    $0xc,%esp
  80019f:	68 8c 1c 80 00       	push   $0x801c8c
  8001a4:	e8 08 01 00 00       	call   8002b1 <cprintf>
  8001a9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001ac:	e8 e6 12 00 00       	call   801497 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001b1:	e8 19 00 00 00       	call   8001cf <exit>
}
  8001b6:	90                   	nop
  8001b7:	c9                   	leave  
  8001b8:	c3                   	ret    

008001b9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001b9:	55                   	push   %ebp
  8001ba:	89 e5                	mov    %esp,%ebp
  8001bc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001bf:	83 ec 0c             	sub    $0xc,%esp
  8001c2:	6a 00                	push   $0x0
  8001c4:	e8 e5 10 00 00       	call   8012ae <sys_env_destroy>
  8001c9:	83 c4 10             	add    $0x10,%esp
}
  8001cc:	90                   	nop
  8001cd:	c9                   	leave  
  8001ce:	c3                   	ret    

008001cf <exit>:

void
exit(void)
{
  8001cf:	55                   	push   %ebp
  8001d0:	89 e5                	mov    %esp,%ebp
  8001d2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001d5:	e8 3a 11 00 00       	call   801314 <sys_env_exit>
}
  8001da:	90                   	nop
  8001db:	c9                   	leave  
  8001dc:	c3                   	ret    

008001dd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001dd:	55                   	push   %ebp
  8001de:	89 e5                	mov    %esp,%ebp
  8001e0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e6:	8b 00                	mov    (%eax),%eax
  8001e8:	8d 48 01             	lea    0x1(%eax),%ecx
  8001eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ee:	89 0a                	mov    %ecx,(%edx)
  8001f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8001f3:	88 d1                	mov    %dl,%cl
  8001f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ff:	8b 00                	mov    (%eax),%eax
  800201:	3d ff 00 00 00       	cmp    $0xff,%eax
  800206:	75 2c                	jne    800234 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800208:	a0 08 30 80 00       	mov    0x803008,%al
  80020d:	0f b6 c0             	movzbl %al,%eax
  800210:	8b 55 0c             	mov    0xc(%ebp),%edx
  800213:	8b 12                	mov    (%edx),%edx
  800215:	89 d1                	mov    %edx,%ecx
  800217:	8b 55 0c             	mov    0xc(%ebp),%edx
  80021a:	83 c2 08             	add    $0x8,%edx
  80021d:	83 ec 04             	sub    $0x4,%esp
  800220:	50                   	push   %eax
  800221:	51                   	push   %ecx
  800222:	52                   	push   %edx
  800223:	e8 44 10 00 00       	call   80126c <sys_cputs>
  800228:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80022b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800234:	8b 45 0c             	mov    0xc(%ebp),%eax
  800237:	8b 40 04             	mov    0x4(%eax),%eax
  80023a:	8d 50 01             	lea    0x1(%eax),%edx
  80023d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800240:	89 50 04             	mov    %edx,0x4(%eax)
}
  800243:	90                   	nop
  800244:	c9                   	leave  
  800245:	c3                   	ret    

00800246 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800246:	55                   	push   %ebp
  800247:	89 e5                	mov    %esp,%ebp
  800249:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80024f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800256:	00 00 00 
	b.cnt = 0;
  800259:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800260:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800263:	ff 75 0c             	pushl  0xc(%ebp)
  800266:	ff 75 08             	pushl  0x8(%ebp)
  800269:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80026f:	50                   	push   %eax
  800270:	68 dd 01 80 00       	push   $0x8001dd
  800275:	e8 11 02 00 00       	call   80048b <vprintfmt>
  80027a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80027d:	a0 08 30 80 00       	mov    0x803008,%al
  800282:	0f b6 c0             	movzbl %al,%eax
  800285:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80028b:	83 ec 04             	sub    $0x4,%esp
  80028e:	50                   	push   %eax
  80028f:	52                   	push   %edx
  800290:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800296:	83 c0 08             	add    $0x8,%eax
  800299:	50                   	push   %eax
  80029a:	e8 cd 0f 00 00       	call   80126c <sys_cputs>
  80029f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002a2:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  8002a9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002af:	c9                   	leave  
  8002b0:	c3                   	ret    

008002b1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002b1:	55                   	push   %ebp
  8002b2:	89 e5                	mov    %esp,%ebp
  8002b4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002b7:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  8002be:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c7:	83 ec 08             	sub    $0x8,%esp
  8002ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8002cd:	50                   	push   %eax
  8002ce:	e8 73 ff ff ff       	call   800246 <vcprintf>
  8002d3:	83 c4 10             	add    $0x10,%esp
  8002d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002dc:	c9                   	leave  
  8002dd:	c3                   	ret    

008002de <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002de:	55                   	push   %ebp
  8002df:	89 e5                	mov    %esp,%ebp
  8002e1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002e4:	e8 94 11 00 00       	call   80147d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002e9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f2:	83 ec 08             	sub    $0x8,%esp
  8002f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f8:	50                   	push   %eax
  8002f9:	e8 48 ff ff ff       	call   800246 <vcprintf>
  8002fe:	83 c4 10             	add    $0x10,%esp
  800301:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800304:	e8 8e 11 00 00       	call   801497 <sys_enable_interrupt>
	return cnt;
  800309:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80030c:	c9                   	leave  
  80030d:	c3                   	ret    

0080030e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80030e:	55                   	push   %ebp
  80030f:	89 e5                	mov    %esp,%ebp
  800311:	53                   	push   %ebx
  800312:	83 ec 14             	sub    $0x14,%esp
  800315:	8b 45 10             	mov    0x10(%ebp),%eax
  800318:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80031b:	8b 45 14             	mov    0x14(%ebp),%eax
  80031e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800321:	8b 45 18             	mov    0x18(%ebp),%eax
  800324:	ba 00 00 00 00       	mov    $0x0,%edx
  800329:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80032c:	77 55                	ja     800383 <printnum+0x75>
  80032e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800331:	72 05                	jb     800338 <printnum+0x2a>
  800333:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800336:	77 4b                	ja     800383 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800338:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80033b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80033e:	8b 45 18             	mov    0x18(%ebp),%eax
  800341:	ba 00 00 00 00       	mov    $0x0,%edx
  800346:	52                   	push   %edx
  800347:	50                   	push   %eax
  800348:	ff 75 f4             	pushl  -0xc(%ebp)
  80034b:	ff 75 f0             	pushl  -0x10(%ebp)
  80034e:	e8 5d 16 00 00       	call   8019b0 <__udivdi3>
  800353:	83 c4 10             	add    $0x10,%esp
  800356:	83 ec 04             	sub    $0x4,%esp
  800359:	ff 75 20             	pushl  0x20(%ebp)
  80035c:	53                   	push   %ebx
  80035d:	ff 75 18             	pushl  0x18(%ebp)
  800360:	52                   	push   %edx
  800361:	50                   	push   %eax
  800362:	ff 75 0c             	pushl  0xc(%ebp)
  800365:	ff 75 08             	pushl  0x8(%ebp)
  800368:	e8 a1 ff ff ff       	call   80030e <printnum>
  80036d:	83 c4 20             	add    $0x20,%esp
  800370:	eb 1a                	jmp    80038c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800372:	83 ec 08             	sub    $0x8,%esp
  800375:	ff 75 0c             	pushl  0xc(%ebp)
  800378:	ff 75 20             	pushl  0x20(%ebp)
  80037b:	8b 45 08             	mov    0x8(%ebp),%eax
  80037e:	ff d0                	call   *%eax
  800380:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800383:	ff 4d 1c             	decl   0x1c(%ebp)
  800386:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80038a:	7f e6                	jg     800372 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80038c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80038f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800394:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800397:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80039a:	53                   	push   %ebx
  80039b:	51                   	push   %ecx
  80039c:	52                   	push   %edx
  80039d:	50                   	push   %eax
  80039e:	e8 1d 17 00 00       	call   801ac0 <__umoddi3>
  8003a3:	83 c4 10             	add    $0x10,%esp
  8003a6:	05 14 1f 80 00       	add    $0x801f14,%eax
  8003ab:	8a 00                	mov    (%eax),%al
  8003ad:	0f be c0             	movsbl %al,%eax
  8003b0:	83 ec 08             	sub    $0x8,%esp
  8003b3:	ff 75 0c             	pushl  0xc(%ebp)
  8003b6:	50                   	push   %eax
  8003b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ba:	ff d0                	call   *%eax
  8003bc:	83 c4 10             	add    $0x10,%esp
}
  8003bf:	90                   	nop
  8003c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003c3:	c9                   	leave  
  8003c4:	c3                   	ret    

008003c5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003cc:	7e 1c                	jle    8003ea <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d1:	8b 00                	mov    (%eax),%eax
  8003d3:	8d 50 08             	lea    0x8(%eax),%edx
  8003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d9:	89 10                	mov    %edx,(%eax)
  8003db:	8b 45 08             	mov    0x8(%ebp),%eax
  8003de:	8b 00                	mov    (%eax),%eax
  8003e0:	83 e8 08             	sub    $0x8,%eax
  8003e3:	8b 50 04             	mov    0x4(%eax),%edx
  8003e6:	8b 00                	mov    (%eax),%eax
  8003e8:	eb 40                	jmp    80042a <getuint+0x65>
	else if (lflag)
  8003ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003ee:	74 1e                	je     80040e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	8d 50 04             	lea    0x4(%eax),%edx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	89 10                	mov    %edx,(%eax)
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	83 e8 04             	sub    $0x4,%eax
  800405:	8b 00                	mov    (%eax),%eax
  800407:	ba 00 00 00 00       	mov    $0x0,%edx
  80040c:	eb 1c                	jmp    80042a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80040e:	8b 45 08             	mov    0x8(%ebp),%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	8d 50 04             	lea    0x4(%eax),%edx
  800416:	8b 45 08             	mov    0x8(%ebp),%eax
  800419:	89 10                	mov    %edx,(%eax)
  80041b:	8b 45 08             	mov    0x8(%ebp),%eax
  80041e:	8b 00                	mov    (%eax),%eax
  800420:	83 e8 04             	sub    $0x4,%eax
  800423:	8b 00                	mov    (%eax),%eax
  800425:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80042a:	5d                   	pop    %ebp
  80042b:	c3                   	ret    

0080042c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80042c:	55                   	push   %ebp
  80042d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80042f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800433:	7e 1c                	jle    800451 <getint+0x25>
		return va_arg(*ap, long long);
  800435:	8b 45 08             	mov    0x8(%ebp),%eax
  800438:	8b 00                	mov    (%eax),%eax
  80043a:	8d 50 08             	lea    0x8(%eax),%edx
  80043d:	8b 45 08             	mov    0x8(%ebp),%eax
  800440:	89 10                	mov    %edx,(%eax)
  800442:	8b 45 08             	mov    0x8(%ebp),%eax
  800445:	8b 00                	mov    (%eax),%eax
  800447:	83 e8 08             	sub    $0x8,%eax
  80044a:	8b 50 04             	mov    0x4(%eax),%edx
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	eb 38                	jmp    800489 <getint+0x5d>
	else if (lflag)
  800451:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800455:	74 1a                	je     800471 <getint+0x45>
		return va_arg(*ap, long);
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	8d 50 04             	lea    0x4(%eax),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	89 10                	mov    %edx,(%eax)
  800464:	8b 45 08             	mov    0x8(%ebp),%eax
  800467:	8b 00                	mov    (%eax),%eax
  800469:	83 e8 04             	sub    $0x4,%eax
  80046c:	8b 00                	mov    (%eax),%eax
  80046e:	99                   	cltd   
  80046f:	eb 18                	jmp    800489 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800471:	8b 45 08             	mov    0x8(%ebp),%eax
  800474:	8b 00                	mov    (%eax),%eax
  800476:	8d 50 04             	lea    0x4(%eax),%edx
  800479:	8b 45 08             	mov    0x8(%ebp),%eax
  80047c:	89 10                	mov    %edx,(%eax)
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	83 e8 04             	sub    $0x4,%eax
  800486:	8b 00                	mov    (%eax),%eax
  800488:	99                   	cltd   
}
  800489:	5d                   	pop    %ebp
  80048a:	c3                   	ret    

0080048b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80048b:	55                   	push   %ebp
  80048c:	89 e5                	mov    %esp,%ebp
  80048e:	56                   	push   %esi
  80048f:	53                   	push   %ebx
  800490:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800493:	eb 17                	jmp    8004ac <vprintfmt+0x21>
			if (ch == '\0')
  800495:	85 db                	test   %ebx,%ebx
  800497:	0f 84 af 03 00 00    	je     80084c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80049d:	83 ec 08             	sub    $0x8,%esp
  8004a0:	ff 75 0c             	pushl  0xc(%ebp)
  8004a3:	53                   	push   %ebx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	ff d0                	call   *%eax
  8004a9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8004af:	8d 50 01             	lea    0x1(%eax),%edx
  8004b2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b5:	8a 00                	mov    (%eax),%al
  8004b7:	0f b6 d8             	movzbl %al,%ebx
  8004ba:	83 fb 25             	cmp    $0x25,%ebx
  8004bd:	75 d6                	jne    800495 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004bf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004c3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004ca:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004d1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004d8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004df:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e2:	8d 50 01             	lea    0x1(%eax),%edx
  8004e5:	89 55 10             	mov    %edx,0x10(%ebp)
  8004e8:	8a 00                	mov    (%eax),%al
  8004ea:	0f b6 d8             	movzbl %al,%ebx
  8004ed:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004f0:	83 f8 55             	cmp    $0x55,%eax
  8004f3:	0f 87 2b 03 00 00    	ja     800824 <vprintfmt+0x399>
  8004f9:	8b 04 85 38 1f 80 00 	mov    0x801f38(,%eax,4),%eax
  800500:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800502:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800506:	eb d7                	jmp    8004df <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800508:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80050c:	eb d1                	jmp    8004df <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80050e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800515:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800518:	89 d0                	mov    %edx,%eax
  80051a:	c1 e0 02             	shl    $0x2,%eax
  80051d:	01 d0                	add    %edx,%eax
  80051f:	01 c0                	add    %eax,%eax
  800521:	01 d8                	add    %ebx,%eax
  800523:	83 e8 30             	sub    $0x30,%eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800529:	8b 45 10             	mov    0x10(%ebp),%eax
  80052c:	8a 00                	mov    (%eax),%al
  80052e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800531:	83 fb 2f             	cmp    $0x2f,%ebx
  800534:	7e 3e                	jle    800574 <vprintfmt+0xe9>
  800536:	83 fb 39             	cmp    $0x39,%ebx
  800539:	7f 39                	jg     800574 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80053b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80053e:	eb d5                	jmp    800515 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800540:	8b 45 14             	mov    0x14(%ebp),%eax
  800543:	83 c0 04             	add    $0x4,%eax
  800546:	89 45 14             	mov    %eax,0x14(%ebp)
  800549:	8b 45 14             	mov    0x14(%ebp),%eax
  80054c:	83 e8 04             	sub    $0x4,%eax
  80054f:	8b 00                	mov    (%eax),%eax
  800551:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800554:	eb 1f                	jmp    800575 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800556:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80055a:	79 83                	jns    8004df <vprintfmt+0x54>
				width = 0;
  80055c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800563:	e9 77 ff ff ff       	jmp    8004df <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800568:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80056f:	e9 6b ff ff ff       	jmp    8004df <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800574:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800575:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800579:	0f 89 60 ff ff ff    	jns    8004df <vprintfmt+0x54>
				width = precision, precision = -1;
  80057f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800582:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800585:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80058c:	e9 4e ff ff ff       	jmp    8004df <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800591:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800594:	e9 46 ff ff ff       	jmp    8004df <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800599:	8b 45 14             	mov    0x14(%ebp),%eax
  80059c:	83 c0 04             	add    $0x4,%eax
  80059f:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a5:	83 e8 04             	sub    $0x4,%eax
  8005a8:	8b 00                	mov    (%eax),%eax
  8005aa:	83 ec 08             	sub    $0x8,%esp
  8005ad:	ff 75 0c             	pushl  0xc(%ebp)
  8005b0:	50                   	push   %eax
  8005b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b4:	ff d0                	call   *%eax
  8005b6:	83 c4 10             	add    $0x10,%esp
			break;
  8005b9:	e9 89 02 00 00       	jmp    800847 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005be:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c1:	83 c0 04             	add    $0x4,%eax
  8005c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ca:	83 e8 04             	sub    $0x4,%eax
  8005cd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005cf:	85 db                	test   %ebx,%ebx
  8005d1:	79 02                	jns    8005d5 <vprintfmt+0x14a>
				err = -err;
  8005d3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005d5:	83 fb 64             	cmp    $0x64,%ebx
  8005d8:	7f 0b                	jg     8005e5 <vprintfmt+0x15a>
  8005da:	8b 34 9d 80 1d 80 00 	mov    0x801d80(,%ebx,4),%esi
  8005e1:	85 f6                	test   %esi,%esi
  8005e3:	75 19                	jne    8005fe <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005e5:	53                   	push   %ebx
  8005e6:	68 25 1f 80 00       	push   $0x801f25
  8005eb:	ff 75 0c             	pushl  0xc(%ebp)
  8005ee:	ff 75 08             	pushl  0x8(%ebp)
  8005f1:	e8 5e 02 00 00       	call   800854 <printfmt>
  8005f6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005f9:	e9 49 02 00 00       	jmp    800847 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005fe:	56                   	push   %esi
  8005ff:	68 2e 1f 80 00       	push   $0x801f2e
  800604:	ff 75 0c             	pushl  0xc(%ebp)
  800607:	ff 75 08             	pushl  0x8(%ebp)
  80060a:	e8 45 02 00 00       	call   800854 <printfmt>
  80060f:	83 c4 10             	add    $0x10,%esp
			break;
  800612:	e9 30 02 00 00       	jmp    800847 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800617:	8b 45 14             	mov    0x14(%ebp),%eax
  80061a:	83 c0 04             	add    $0x4,%eax
  80061d:	89 45 14             	mov    %eax,0x14(%ebp)
  800620:	8b 45 14             	mov    0x14(%ebp),%eax
  800623:	83 e8 04             	sub    $0x4,%eax
  800626:	8b 30                	mov    (%eax),%esi
  800628:	85 f6                	test   %esi,%esi
  80062a:	75 05                	jne    800631 <vprintfmt+0x1a6>
				p = "(null)";
  80062c:	be 31 1f 80 00       	mov    $0x801f31,%esi
			if (width > 0 && padc != '-')
  800631:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800635:	7e 6d                	jle    8006a4 <vprintfmt+0x219>
  800637:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80063b:	74 67                	je     8006a4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80063d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800640:	83 ec 08             	sub    $0x8,%esp
  800643:	50                   	push   %eax
  800644:	56                   	push   %esi
  800645:	e8 12 05 00 00       	call   800b5c <strnlen>
  80064a:	83 c4 10             	add    $0x10,%esp
  80064d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800650:	eb 16                	jmp    800668 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800652:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800656:	83 ec 08             	sub    $0x8,%esp
  800659:	ff 75 0c             	pushl  0xc(%ebp)
  80065c:	50                   	push   %eax
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	ff d0                	call   *%eax
  800662:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800665:	ff 4d e4             	decl   -0x1c(%ebp)
  800668:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066c:	7f e4                	jg     800652 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80066e:	eb 34                	jmp    8006a4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800670:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800674:	74 1c                	je     800692 <vprintfmt+0x207>
  800676:	83 fb 1f             	cmp    $0x1f,%ebx
  800679:	7e 05                	jle    800680 <vprintfmt+0x1f5>
  80067b:	83 fb 7e             	cmp    $0x7e,%ebx
  80067e:	7e 12                	jle    800692 <vprintfmt+0x207>
					putch('?', putdat);
  800680:	83 ec 08             	sub    $0x8,%esp
  800683:	ff 75 0c             	pushl  0xc(%ebp)
  800686:	6a 3f                	push   $0x3f
  800688:	8b 45 08             	mov    0x8(%ebp),%eax
  80068b:	ff d0                	call   *%eax
  80068d:	83 c4 10             	add    $0x10,%esp
  800690:	eb 0f                	jmp    8006a1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800692:	83 ec 08             	sub    $0x8,%esp
  800695:	ff 75 0c             	pushl  0xc(%ebp)
  800698:	53                   	push   %ebx
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	ff d0                	call   *%eax
  80069e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006a1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a4:	89 f0                	mov    %esi,%eax
  8006a6:	8d 70 01             	lea    0x1(%eax),%esi
  8006a9:	8a 00                	mov    (%eax),%al
  8006ab:	0f be d8             	movsbl %al,%ebx
  8006ae:	85 db                	test   %ebx,%ebx
  8006b0:	74 24                	je     8006d6 <vprintfmt+0x24b>
  8006b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b6:	78 b8                	js     800670 <vprintfmt+0x1e5>
  8006b8:	ff 4d e0             	decl   -0x20(%ebp)
  8006bb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006bf:	79 af                	jns    800670 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006c1:	eb 13                	jmp    8006d6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006c3:	83 ec 08             	sub    $0x8,%esp
  8006c6:	ff 75 0c             	pushl  0xc(%ebp)
  8006c9:	6a 20                	push   $0x20
  8006cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ce:	ff d0                	call   *%eax
  8006d0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d3:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006da:	7f e7                	jg     8006c3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006dc:	e9 66 01 00 00       	jmp    800847 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006e1:	83 ec 08             	sub    $0x8,%esp
  8006e4:	ff 75 e8             	pushl  -0x18(%ebp)
  8006e7:	8d 45 14             	lea    0x14(%ebp),%eax
  8006ea:	50                   	push   %eax
  8006eb:	e8 3c fd ff ff       	call   80042c <getint>
  8006f0:	83 c4 10             	add    $0x10,%esp
  8006f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ff:	85 d2                	test   %edx,%edx
  800701:	79 23                	jns    800726 <vprintfmt+0x29b>
				putch('-', putdat);
  800703:	83 ec 08             	sub    $0x8,%esp
  800706:	ff 75 0c             	pushl  0xc(%ebp)
  800709:	6a 2d                	push   $0x2d
  80070b:	8b 45 08             	mov    0x8(%ebp),%eax
  80070e:	ff d0                	call   *%eax
  800710:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800713:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800716:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800719:	f7 d8                	neg    %eax
  80071b:	83 d2 00             	adc    $0x0,%edx
  80071e:	f7 da                	neg    %edx
  800720:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800723:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800726:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072d:	e9 bc 00 00 00       	jmp    8007ee <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800732:	83 ec 08             	sub    $0x8,%esp
  800735:	ff 75 e8             	pushl  -0x18(%ebp)
  800738:	8d 45 14             	lea    0x14(%ebp),%eax
  80073b:	50                   	push   %eax
  80073c:	e8 84 fc ff ff       	call   8003c5 <getuint>
  800741:	83 c4 10             	add    $0x10,%esp
  800744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800747:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80074a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800751:	e9 98 00 00 00       	jmp    8007ee <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	ff 75 0c             	pushl  0xc(%ebp)
  80077c:	6a 58                	push   $0x58
  80077e:	8b 45 08             	mov    0x8(%ebp),%eax
  800781:	ff d0                	call   *%eax
  800783:	83 c4 10             	add    $0x10,%esp
			break;
  800786:	e9 bc 00 00 00       	jmp    800847 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80078b:	83 ec 08             	sub    $0x8,%esp
  80078e:	ff 75 0c             	pushl  0xc(%ebp)
  800791:	6a 30                	push   $0x30
  800793:	8b 45 08             	mov    0x8(%ebp),%eax
  800796:	ff d0                	call   *%eax
  800798:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80079b:	83 ec 08             	sub    $0x8,%esp
  80079e:	ff 75 0c             	pushl  0xc(%ebp)
  8007a1:	6a 78                	push   $0x78
  8007a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a6:	ff d0                	call   *%eax
  8007a8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ae:	83 c0 04             	add    $0x4,%eax
  8007b1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b7:	83 e8 04             	sub    $0x4,%eax
  8007ba:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007c6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007cd:	eb 1f                	jmp    8007ee <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007cf:	83 ec 08             	sub    $0x8,%esp
  8007d2:	ff 75 e8             	pushl  -0x18(%ebp)
  8007d5:	8d 45 14             	lea    0x14(%ebp),%eax
  8007d8:	50                   	push   %eax
  8007d9:	e8 e7 fb ff ff       	call   8003c5 <getuint>
  8007de:	83 c4 10             	add    $0x10,%esp
  8007e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007e7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007ee:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007f5:	83 ec 04             	sub    $0x4,%esp
  8007f8:	52                   	push   %edx
  8007f9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007fc:	50                   	push   %eax
  8007fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800800:	ff 75 f0             	pushl  -0x10(%ebp)
  800803:	ff 75 0c             	pushl  0xc(%ebp)
  800806:	ff 75 08             	pushl  0x8(%ebp)
  800809:	e8 00 fb ff ff       	call   80030e <printnum>
  80080e:	83 c4 20             	add    $0x20,%esp
			break;
  800811:	eb 34                	jmp    800847 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800813:	83 ec 08             	sub    $0x8,%esp
  800816:	ff 75 0c             	pushl  0xc(%ebp)
  800819:	53                   	push   %ebx
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	ff d0                	call   *%eax
  80081f:	83 c4 10             	add    $0x10,%esp
			break;
  800822:	eb 23                	jmp    800847 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800824:	83 ec 08             	sub    $0x8,%esp
  800827:	ff 75 0c             	pushl  0xc(%ebp)
  80082a:	6a 25                	push   $0x25
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	ff d0                	call   *%eax
  800831:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800834:	ff 4d 10             	decl   0x10(%ebp)
  800837:	eb 03                	jmp    80083c <vprintfmt+0x3b1>
  800839:	ff 4d 10             	decl   0x10(%ebp)
  80083c:	8b 45 10             	mov    0x10(%ebp),%eax
  80083f:	48                   	dec    %eax
  800840:	8a 00                	mov    (%eax),%al
  800842:	3c 25                	cmp    $0x25,%al
  800844:	75 f3                	jne    800839 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800846:	90                   	nop
		}
	}
  800847:	e9 47 fc ff ff       	jmp    800493 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80084c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80084d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800850:	5b                   	pop    %ebx
  800851:	5e                   	pop    %esi
  800852:	5d                   	pop    %ebp
  800853:	c3                   	ret    

00800854 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800854:	55                   	push   %ebp
  800855:	89 e5                	mov    %esp,%ebp
  800857:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80085a:	8d 45 10             	lea    0x10(%ebp),%eax
  80085d:	83 c0 04             	add    $0x4,%eax
  800860:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800863:	8b 45 10             	mov    0x10(%ebp),%eax
  800866:	ff 75 f4             	pushl  -0xc(%ebp)
  800869:	50                   	push   %eax
  80086a:	ff 75 0c             	pushl  0xc(%ebp)
  80086d:	ff 75 08             	pushl  0x8(%ebp)
  800870:	e8 16 fc ff ff       	call   80048b <vprintfmt>
  800875:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800878:	90                   	nop
  800879:	c9                   	leave  
  80087a:	c3                   	ret    

0080087b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80087b:	55                   	push   %ebp
  80087c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80087e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800881:	8b 40 08             	mov    0x8(%eax),%eax
  800884:	8d 50 01             	lea    0x1(%eax),%edx
  800887:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80088d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800890:	8b 10                	mov    (%eax),%edx
  800892:	8b 45 0c             	mov    0xc(%ebp),%eax
  800895:	8b 40 04             	mov    0x4(%eax),%eax
  800898:	39 c2                	cmp    %eax,%edx
  80089a:	73 12                	jae    8008ae <sprintputch+0x33>
		*b->buf++ = ch;
  80089c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089f:	8b 00                	mov    (%eax),%eax
  8008a1:	8d 48 01             	lea    0x1(%eax),%ecx
  8008a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a7:	89 0a                	mov    %ecx,(%edx)
  8008a9:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ac:	88 10                	mov    %dl,(%eax)
}
  8008ae:	90                   	nop
  8008af:	5d                   	pop    %ebp
  8008b0:	c3                   	ret    

008008b1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008b1:	55                   	push   %ebp
  8008b2:	89 e5                	mov    %esp,%ebp
  8008b4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	01 d0                	add    %edx,%eax
  8008c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008d2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008d6:	74 06                	je     8008de <vsnprintf+0x2d>
  8008d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008dc:	7f 07                	jg     8008e5 <vsnprintf+0x34>
		return -E_INVAL;
  8008de:	b8 03 00 00 00       	mov    $0x3,%eax
  8008e3:	eb 20                	jmp    800905 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008e5:	ff 75 14             	pushl  0x14(%ebp)
  8008e8:	ff 75 10             	pushl  0x10(%ebp)
  8008eb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008ee:	50                   	push   %eax
  8008ef:	68 7b 08 80 00       	push   $0x80087b
  8008f4:	e8 92 fb ff ff       	call   80048b <vprintfmt>
  8008f9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ff:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800902:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800905:	c9                   	leave  
  800906:	c3                   	ret    

00800907 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800907:	55                   	push   %ebp
  800908:	89 e5                	mov    %esp,%ebp
  80090a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80090d:	8d 45 10             	lea    0x10(%ebp),%eax
  800910:	83 c0 04             	add    $0x4,%eax
  800913:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800916:	8b 45 10             	mov    0x10(%ebp),%eax
  800919:	ff 75 f4             	pushl  -0xc(%ebp)
  80091c:	50                   	push   %eax
  80091d:	ff 75 0c             	pushl  0xc(%ebp)
  800920:	ff 75 08             	pushl  0x8(%ebp)
  800923:	e8 89 ff ff ff       	call   8008b1 <vsnprintf>
  800928:	83 c4 10             	add    $0x10,%esp
  80092b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80092e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800931:	c9                   	leave  
  800932:	c3                   	ret    

00800933 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800933:	55                   	push   %ebp
  800934:	89 e5                	mov    %esp,%ebp
  800936:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800939:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80093d:	74 13                	je     800952 <readline+0x1f>
		cprintf("%s", prompt);
  80093f:	83 ec 08             	sub    $0x8,%esp
  800942:	ff 75 08             	pushl  0x8(%ebp)
  800945:	68 90 20 80 00       	push   $0x802090
  80094a:	e8 62 f9 ff ff       	call   8002b1 <cprintf>
  80094f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800952:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800959:	83 ec 0c             	sub    $0xc,%esp
  80095c:	6a 00                	push   $0x0
  80095e:	e8 42 10 00 00       	call   8019a5 <iscons>
  800963:	83 c4 10             	add    $0x10,%esp
  800966:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800969:	e8 e9 0f 00 00       	call   801957 <getchar>
  80096e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800971:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800975:	79 22                	jns    800999 <readline+0x66>
			if (c != -E_EOF)
  800977:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80097b:	0f 84 ad 00 00 00    	je     800a2e <readline+0xfb>
				cprintf("read error: %e\n", c);
  800981:	83 ec 08             	sub    $0x8,%esp
  800984:	ff 75 ec             	pushl  -0x14(%ebp)
  800987:	68 93 20 80 00       	push   $0x802093
  80098c:	e8 20 f9 ff ff       	call   8002b1 <cprintf>
  800991:	83 c4 10             	add    $0x10,%esp
			return;
  800994:	e9 95 00 00 00       	jmp    800a2e <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800999:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80099d:	7e 34                	jle    8009d3 <readline+0xa0>
  80099f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009a6:	7f 2b                	jg     8009d3 <readline+0xa0>
			if (echoing)
  8009a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009ac:	74 0e                	je     8009bc <readline+0x89>
				cputchar(c);
  8009ae:	83 ec 0c             	sub    $0xc,%esp
  8009b1:	ff 75 ec             	pushl  -0x14(%ebp)
  8009b4:	e8 56 0f 00 00       	call   80190f <cputchar>
  8009b9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009bf:	8d 50 01             	lea    0x1(%eax),%edx
  8009c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009c5:	89 c2                	mov    %eax,%edx
  8009c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ca:	01 d0                	add    %edx,%eax
  8009cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009cf:	88 10                	mov    %dl,(%eax)
  8009d1:	eb 56                	jmp    800a29 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009d3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009d7:	75 1f                	jne    8009f8 <readline+0xc5>
  8009d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009dd:	7e 19                	jle    8009f8 <readline+0xc5>
			if (echoing)
  8009df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009e3:	74 0e                	je     8009f3 <readline+0xc0>
				cputchar(c);
  8009e5:	83 ec 0c             	sub    $0xc,%esp
  8009e8:	ff 75 ec             	pushl  -0x14(%ebp)
  8009eb:	e8 1f 0f 00 00       	call   80190f <cputchar>
  8009f0:	83 c4 10             	add    $0x10,%esp

			i--;
  8009f3:	ff 4d f4             	decl   -0xc(%ebp)
  8009f6:	eb 31                	jmp    800a29 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8009f8:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8009fc:	74 0a                	je     800a08 <readline+0xd5>
  8009fe:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a02:	0f 85 61 ff ff ff    	jne    800969 <readline+0x36>
			if (echoing)
  800a08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a0c:	74 0e                	je     800a1c <readline+0xe9>
				cputchar(c);
  800a0e:	83 ec 0c             	sub    $0xc,%esp
  800a11:	ff 75 ec             	pushl  -0x14(%ebp)
  800a14:	e8 f6 0e 00 00       	call   80190f <cputchar>
  800a19:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a22:	01 d0                	add    %edx,%eax
  800a24:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a27:	eb 06                	jmp    800a2f <readline+0xfc>
		}
	}
  800a29:	e9 3b ff ff ff       	jmp    800969 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a2e:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a2f:	c9                   	leave  
  800a30:	c3                   	ret    

00800a31 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a31:	55                   	push   %ebp
  800a32:	89 e5                	mov    %esp,%ebp
  800a34:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a37:	e8 41 0a 00 00       	call   80147d <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a3c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a40:	74 13                	je     800a55 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a42:	83 ec 08             	sub    $0x8,%esp
  800a45:	ff 75 08             	pushl  0x8(%ebp)
  800a48:	68 90 20 80 00       	push   $0x802090
  800a4d:	e8 5f f8 ff ff       	call   8002b1 <cprintf>
  800a52:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a5c:	83 ec 0c             	sub    $0xc,%esp
  800a5f:	6a 00                	push   $0x0
  800a61:	e8 3f 0f 00 00       	call   8019a5 <iscons>
  800a66:	83 c4 10             	add    $0x10,%esp
  800a69:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a6c:	e8 e6 0e 00 00       	call   801957 <getchar>
  800a71:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a74:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a78:	79 23                	jns    800a9d <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a7a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a7e:	74 13                	je     800a93 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a80:	83 ec 08             	sub    $0x8,%esp
  800a83:	ff 75 ec             	pushl  -0x14(%ebp)
  800a86:	68 93 20 80 00       	push   $0x802093
  800a8b:	e8 21 f8 ff ff       	call   8002b1 <cprintf>
  800a90:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800a93:	e8 ff 09 00 00       	call   801497 <sys_enable_interrupt>
			return;
  800a98:	e9 9a 00 00 00       	jmp    800b37 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800a9d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800aa1:	7e 34                	jle    800ad7 <atomic_readline+0xa6>
  800aa3:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800aaa:	7f 2b                	jg     800ad7 <atomic_readline+0xa6>
			if (echoing)
  800aac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ab0:	74 0e                	je     800ac0 <atomic_readline+0x8f>
				cputchar(c);
  800ab2:	83 ec 0c             	sub    $0xc,%esp
  800ab5:	ff 75 ec             	pushl  -0x14(%ebp)
  800ab8:	e8 52 0e 00 00       	call   80190f <cputchar>
  800abd:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ac3:	8d 50 01             	lea    0x1(%eax),%edx
  800ac6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ac9:	89 c2                	mov    %eax,%edx
  800acb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ace:	01 d0                	add    %edx,%eax
  800ad0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ad3:	88 10                	mov    %dl,(%eax)
  800ad5:	eb 5b                	jmp    800b32 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800ad7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800adb:	75 1f                	jne    800afc <atomic_readline+0xcb>
  800add:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800ae1:	7e 19                	jle    800afc <atomic_readline+0xcb>
			if (echoing)
  800ae3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ae7:	74 0e                	je     800af7 <atomic_readline+0xc6>
				cputchar(c);
  800ae9:	83 ec 0c             	sub    $0xc,%esp
  800aec:	ff 75 ec             	pushl  -0x14(%ebp)
  800aef:	e8 1b 0e 00 00       	call   80190f <cputchar>
  800af4:	83 c4 10             	add    $0x10,%esp
			i--;
  800af7:	ff 4d f4             	decl   -0xc(%ebp)
  800afa:	eb 36                	jmp    800b32 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800afc:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b00:	74 0a                	je     800b0c <atomic_readline+0xdb>
  800b02:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b06:	0f 85 60 ff ff ff    	jne    800a6c <atomic_readline+0x3b>
			if (echoing)
  800b0c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b10:	74 0e                	je     800b20 <atomic_readline+0xef>
				cputchar(c);
  800b12:	83 ec 0c             	sub    $0xc,%esp
  800b15:	ff 75 ec             	pushl  -0x14(%ebp)
  800b18:	e8 f2 0d 00 00       	call   80190f <cputchar>
  800b1d:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b20:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b26:	01 d0                	add    %edx,%eax
  800b28:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b2b:	e8 67 09 00 00       	call   801497 <sys_enable_interrupt>
			return;
  800b30:	eb 05                	jmp    800b37 <atomic_readline+0x106>
		}
	}
  800b32:	e9 35 ff ff ff       	jmp    800a6c <atomic_readline+0x3b>
}
  800b37:	c9                   	leave  
  800b38:	c3                   	ret    

00800b39 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
  800b3c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b3f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b46:	eb 06                	jmp    800b4e <strlen+0x15>
		n++;
  800b48:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b4b:	ff 45 08             	incl   0x8(%ebp)
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	8a 00                	mov    (%eax),%al
  800b53:	84 c0                	test   %al,%al
  800b55:	75 f1                	jne    800b48 <strlen+0xf>
		n++;
	return n;
  800b57:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b5a:	c9                   	leave  
  800b5b:	c3                   	ret    

00800b5c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b5c:	55                   	push   %ebp
  800b5d:	89 e5                	mov    %esp,%ebp
  800b5f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b69:	eb 09                	jmp    800b74 <strnlen+0x18>
		n++;
  800b6b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b6e:	ff 45 08             	incl   0x8(%ebp)
  800b71:	ff 4d 0c             	decl   0xc(%ebp)
  800b74:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b78:	74 09                	je     800b83 <strnlen+0x27>
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	8a 00                	mov    (%eax),%al
  800b7f:	84 c0                	test   %al,%al
  800b81:	75 e8                	jne    800b6b <strnlen+0xf>
		n++;
	return n;
  800b83:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b86:	c9                   	leave  
  800b87:	c3                   	ret    

00800b88 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b88:	55                   	push   %ebp
  800b89:	89 e5                	mov    %esp,%ebp
  800b8b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b94:	90                   	nop
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	8d 50 01             	lea    0x1(%eax),%edx
  800b9b:	89 55 08             	mov    %edx,0x8(%ebp)
  800b9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ba4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ba7:	8a 12                	mov    (%edx),%dl
  800ba9:	88 10                	mov    %dl,(%eax)
  800bab:	8a 00                	mov    (%eax),%al
  800bad:	84 c0                	test   %al,%al
  800baf:	75 e4                	jne    800b95 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bb4:	c9                   	leave  
  800bb5:	c3                   	ret    

00800bb6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bb6:	55                   	push   %ebp
  800bb7:	89 e5                	mov    %esp,%ebp
  800bb9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bc2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bc9:	eb 1f                	jmp    800bea <strncpy+0x34>
		*dst++ = *src;
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8d 50 01             	lea    0x1(%eax),%edx
  800bd1:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd7:	8a 12                	mov    (%edx),%dl
  800bd9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bde:	8a 00                	mov    (%eax),%al
  800be0:	84 c0                	test   %al,%al
  800be2:	74 03                	je     800be7 <strncpy+0x31>
			src++;
  800be4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800be7:	ff 45 fc             	incl   -0x4(%ebp)
  800bea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bed:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bf0:	72 d9                	jb     800bcb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bf2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bf5:	c9                   	leave  
  800bf6:	c3                   	ret    

00800bf7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bf7:	55                   	push   %ebp
  800bf8:	89 e5                	mov    %esp,%ebp
  800bfa:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800c00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c03:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c07:	74 30                	je     800c39 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c09:	eb 16                	jmp    800c21 <strlcpy+0x2a>
			*dst++ = *src++;
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	8d 50 01             	lea    0x1(%eax),%edx
  800c11:	89 55 08             	mov    %edx,0x8(%ebp)
  800c14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c17:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c1a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1d:	8a 12                	mov    (%edx),%dl
  800c1f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c21:	ff 4d 10             	decl   0x10(%ebp)
  800c24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c28:	74 09                	je     800c33 <strlcpy+0x3c>
  800c2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	84 c0                	test   %al,%al
  800c31:	75 d8                	jne    800c0b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c39:	8b 55 08             	mov    0x8(%ebp),%edx
  800c3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3f:	29 c2                	sub    %eax,%edx
  800c41:	89 d0                	mov    %edx,%eax
}
  800c43:	c9                   	leave  
  800c44:	c3                   	ret    

00800c45 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c48:	eb 06                	jmp    800c50 <strcmp+0xb>
		p++, q++;
  800c4a:	ff 45 08             	incl   0x8(%ebp)
  800c4d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c50:	8b 45 08             	mov    0x8(%ebp),%eax
  800c53:	8a 00                	mov    (%eax),%al
  800c55:	84 c0                	test   %al,%al
  800c57:	74 0e                	je     800c67 <strcmp+0x22>
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	8a 10                	mov    (%eax),%dl
  800c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c61:	8a 00                	mov    (%eax),%al
  800c63:	38 c2                	cmp    %al,%dl
  800c65:	74 e3                	je     800c4a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	8a 00                	mov    (%eax),%al
  800c6c:	0f b6 d0             	movzbl %al,%edx
  800c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c72:	8a 00                	mov    (%eax),%al
  800c74:	0f b6 c0             	movzbl %al,%eax
  800c77:	29 c2                	sub    %eax,%edx
  800c79:	89 d0                	mov    %edx,%eax
}
  800c7b:	5d                   	pop    %ebp
  800c7c:	c3                   	ret    

00800c7d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c7d:	55                   	push   %ebp
  800c7e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c80:	eb 09                	jmp    800c8b <strncmp+0xe>
		n--, p++, q++;
  800c82:	ff 4d 10             	decl   0x10(%ebp)
  800c85:	ff 45 08             	incl   0x8(%ebp)
  800c88:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c8f:	74 17                	je     800ca8 <strncmp+0x2b>
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8a 00                	mov    (%eax),%al
  800c96:	84 c0                	test   %al,%al
  800c98:	74 0e                	je     800ca8 <strncmp+0x2b>
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8a 10                	mov    (%eax),%dl
  800c9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	38 c2                	cmp    %al,%dl
  800ca6:	74 da                	je     800c82 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ca8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cac:	75 07                	jne    800cb5 <strncmp+0x38>
		return 0;
  800cae:	b8 00 00 00 00       	mov    $0x0,%eax
  800cb3:	eb 14                	jmp    800cc9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	8a 00                	mov    (%eax),%al
  800cba:	0f b6 d0             	movzbl %al,%edx
  800cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	0f b6 c0             	movzbl %al,%eax
  800cc5:	29 c2                	sub    %eax,%edx
  800cc7:	89 d0                	mov    %edx,%eax
}
  800cc9:	5d                   	pop    %ebp
  800cca:	c3                   	ret    

00800ccb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ccb:	55                   	push   %ebp
  800ccc:	89 e5                	mov    %esp,%ebp
  800cce:	83 ec 04             	sub    $0x4,%esp
  800cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cd7:	eb 12                	jmp    800ceb <strchr+0x20>
		if (*s == c)
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ce1:	75 05                	jne    800ce8 <strchr+0x1d>
			return (char *) s;
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	eb 11                	jmp    800cf9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ce8:	ff 45 08             	incl   0x8(%ebp)
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8a 00                	mov    (%eax),%al
  800cf0:	84 c0                	test   %al,%al
  800cf2:	75 e5                	jne    800cd9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cf4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
  800cfe:	83 ec 04             	sub    $0x4,%esp
  800d01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d04:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d07:	eb 0d                	jmp    800d16 <strfind+0x1b>
		if (*s == c)
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8a 00                	mov    (%eax),%al
  800d0e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d11:	74 0e                	je     800d21 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d13:	ff 45 08             	incl   0x8(%ebp)
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	84 c0                	test   %al,%al
  800d1d:	75 ea                	jne    800d09 <strfind+0xe>
  800d1f:	eb 01                	jmp    800d22 <strfind+0x27>
		if (*s == c)
			break;
  800d21:	90                   	nop
	return (char *) s;
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d25:	c9                   	leave  
  800d26:	c3                   	ret    

00800d27 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d27:	55                   	push   %ebp
  800d28:	89 e5                	mov    %esp,%ebp
  800d2a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d33:	8b 45 10             	mov    0x10(%ebp),%eax
  800d36:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d39:	eb 0e                	jmp    800d49 <memset+0x22>
		*p++ = c;
  800d3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d3e:	8d 50 01             	lea    0x1(%eax),%edx
  800d41:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d44:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d47:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d49:	ff 4d f8             	decl   -0x8(%ebp)
  800d4c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d50:	79 e9                	jns    800d3b <memset+0x14>
		*p++ = c;

	return v;
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d55:	c9                   	leave  
  800d56:	c3                   	ret    

00800d57 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d57:	55                   	push   %ebp
  800d58:	89 e5                	mov    %esp,%ebp
  800d5a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d69:	eb 16                	jmp    800d81 <memcpy+0x2a>
		*d++ = *s++;
  800d6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6e:	8d 50 01             	lea    0x1(%eax),%edx
  800d71:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d74:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d77:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d7a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d7d:	8a 12                	mov    (%edx),%dl
  800d7f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d81:	8b 45 10             	mov    0x10(%ebp),%eax
  800d84:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d87:	89 55 10             	mov    %edx,0x10(%ebp)
  800d8a:	85 c0                	test   %eax,%eax
  800d8c:	75 dd                	jne    800d6b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d91:	c9                   	leave  
  800d92:	c3                   	ret    

00800d93 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d93:	55                   	push   %ebp
  800d94:	89 e5                	mov    %esp,%ebp
  800d96:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800d99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800da5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800da8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dab:	73 50                	jae    800dfd <memmove+0x6a>
  800dad:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800db0:	8b 45 10             	mov    0x10(%ebp),%eax
  800db3:	01 d0                	add    %edx,%eax
  800db5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800db8:	76 43                	jbe    800dfd <memmove+0x6a>
		s += n;
  800dba:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbd:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dc0:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dc6:	eb 10                	jmp    800dd8 <memmove+0x45>
			*--d = *--s;
  800dc8:	ff 4d f8             	decl   -0x8(%ebp)
  800dcb:	ff 4d fc             	decl   -0x4(%ebp)
  800dce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd1:	8a 10                	mov    (%eax),%dl
  800dd3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dde:	89 55 10             	mov    %edx,0x10(%ebp)
  800de1:	85 c0                	test   %eax,%eax
  800de3:	75 e3                	jne    800dc8 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800de5:	eb 23                	jmp    800e0a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800de7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dea:	8d 50 01             	lea    0x1(%eax),%edx
  800ded:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800df0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df9:	8a 12                	mov    (%edx),%dl
  800dfb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800dfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800e00:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e03:	89 55 10             	mov    %edx,0x10(%ebp)
  800e06:	85 c0                	test   %eax,%eax
  800e08:	75 dd                	jne    800de7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0d:	c9                   	leave  
  800e0e:	c3                   	ret    

00800e0f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e0f:	55                   	push   %ebp
  800e10:	89 e5                	mov    %esp,%ebp
  800e12:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e21:	eb 2a                	jmp    800e4d <memcmp+0x3e>
		if (*s1 != *s2)
  800e23:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e26:	8a 10                	mov    (%eax),%dl
  800e28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	38 c2                	cmp    %al,%dl
  800e2f:	74 16                	je     800e47 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e31:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	0f b6 d0             	movzbl %al,%edx
  800e39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3c:	8a 00                	mov    (%eax),%al
  800e3e:	0f b6 c0             	movzbl %al,%eax
  800e41:	29 c2                	sub    %eax,%edx
  800e43:	89 d0                	mov    %edx,%eax
  800e45:	eb 18                	jmp    800e5f <memcmp+0x50>
		s1++, s2++;
  800e47:	ff 45 fc             	incl   -0x4(%ebp)
  800e4a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e50:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e53:	89 55 10             	mov    %edx,0x10(%ebp)
  800e56:	85 c0                	test   %eax,%eax
  800e58:	75 c9                	jne    800e23 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e5f:	c9                   	leave  
  800e60:	c3                   	ret    

00800e61 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e61:	55                   	push   %ebp
  800e62:	89 e5                	mov    %esp,%ebp
  800e64:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e67:	8b 55 08             	mov    0x8(%ebp),%edx
  800e6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6d:	01 d0                	add    %edx,%eax
  800e6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e72:	eb 15                	jmp    800e89 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	0f b6 d0             	movzbl %al,%edx
  800e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7f:	0f b6 c0             	movzbl %al,%eax
  800e82:	39 c2                	cmp    %eax,%edx
  800e84:	74 0d                	je     800e93 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e86:	ff 45 08             	incl   0x8(%ebp)
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e8f:	72 e3                	jb     800e74 <memfind+0x13>
  800e91:	eb 01                	jmp    800e94 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e93:	90                   	nop
	return (void *) s;
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e97:	c9                   	leave  
  800e98:	c3                   	ret    

00800e99 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e99:	55                   	push   %ebp
  800e9a:	89 e5                	mov    %esp,%ebp
  800e9c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ea6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ead:	eb 03                	jmp    800eb2 <strtol+0x19>
		s++;
  800eaf:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	8a 00                	mov    (%eax),%al
  800eb7:	3c 20                	cmp    $0x20,%al
  800eb9:	74 f4                	je     800eaf <strtol+0x16>
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	8a 00                	mov    (%eax),%al
  800ec0:	3c 09                	cmp    $0x9,%al
  800ec2:	74 eb                	je     800eaf <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec7:	8a 00                	mov    (%eax),%al
  800ec9:	3c 2b                	cmp    $0x2b,%al
  800ecb:	75 05                	jne    800ed2 <strtol+0x39>
		s++;
  800ecd:	ff 45 08             	incl   0x8(%ebp)
  800ed0:	eb 13                	jmp    800ee5 <strtol+0x4c>
	else if (*s == '-')
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	3c 2d                	cmp    $0x2d,%al
  800ed9:	75 0a                	jne    800ee5 <strtol+0x4c>
		s++, neg = 1;
  800edb:	ff 45 08             	incl   0x8(%ebp)
  800ede:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ee5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee9:	74 06                	je     800ef1 <strtol+0x58>
  800eeb:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800eef:	75 20                	jne    800f11 <strtol+0x78>
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	3c 30                	cmp    $0x30,%al
  800ef8:	75 17                	jne    800f11 <strtol+0x78>
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	40                   	inc    %eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	3c 78                	cmp    $0x78,%al
  800f02:	75 0d                	jne    800f11 <strtol+0x78>
		s += 2, base = 16;
  800f04:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f08:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f0f:	eb 28                	jmp    800f39 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f11:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f15:	75 15                	jne    800f2c <strtol+0x93>
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	3c 30                	cmp    $0x30,%al
  800f1e:	75 0c                	jne    800f2c <strtol+0x93>
		s++, base = 8;
  800f20:	ff 45 08             	incl   0x8(%ebp)
  800f23:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f2a:	eb 0d                	jmp    800f39 <strtol+0xa0>
	else if (base == 0)
  800f2c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f30:	75 07                	jne    800f39 <strtol+0xa0>
		base = 10;
  800f32:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	3c 2f                	cmp    $0x2f,%al
  800f40:	7e 19                	jle    800f5b <strtol+0xc2>
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	8a 00                	mov    (%eax),%al
  800f47:	3c 39                	cmp    $0x39,%al
  800f49:	7f 10                	jg     800f5b <strtol+0xc2>
			dig = *s - '0';
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	8a 00                	mov    (%eax),%al
  800f50:	0f be c0             	movsbl %al,%eax
  800f53:	83 e8 30             	sub    $0x30,%eax
  800f56:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f59:	eb 42                	jmp    800f9d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	8a 00                	mov    (%eax),%al
  800f60:	3c 60                	cmp    $0x60,%al
  800f62:	7e 19                	jle    800f7d <strtol+0xe4>
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	8a 00                	mov    (%eax),%al
  800f69:	3c 7a                	cmp    $0x7a,%al
  800f6b:	7f 10                	jg     800f7d <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	0f be c0             	movsbl %al,%eax
  800f75:	83 e8 57             	sub    $0x57,%eax
  800f78:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f7b:	eb 20                	jmp    800f9d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	3c 40                	cmp    $0x40,%al
  800f84:	7e 39                	jle    800fbf <strtol+0x126>
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	3c 5a                	cmp    $0x5a,%al
  800f8d:	7f 30                	jg     800fbf <strtol+0x126>
			dig = *s - 'A' + 10;
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	0f be c0             	movsbl %al,%eax
  800f97:	83 e8 37             	sub    $0x37,%eax
  800f9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa0:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fa3:	7d 19                	jge    800fbe <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fa5:	ff 45 08             	incl   0x8(%ebp)
  800fa8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fab:	0f af 45 10          	imul   0x10(%ebp),%eax
  800faf:	89 c2                	mov    %eax,%edx
  800fb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb4:	01 d0                	add    %edx,%eax
  800fb6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fb9:	e9 7b ff ff ff       	jmp    800f39 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fbe:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fbf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fc3:	74 08                	je     800fcd <strtol+0x134>
		*endptr = (char *) s;
  800fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc8:	8b 55 08             	mov    0x8(%ebp),%edx
  800fcb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fcd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fd1:	74 07                	je     800fda <strtol+0x141>
  800fd3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd6:	f7 d8                	neg    %eax
  800fd8:	eb 03                	jmp    800fdd <strtol+0x144>
  800fda:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fdd:	c9                   	leave  
  800fde:	c3                   	ret    

00800fdf <ltostr>:

void
ltostr(long value, char *str)
{
  800fdf:	55                   	push   %ebp
  800fe0:	89 e5                	mov    %esp,%ebp
  800fe2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fe5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ff3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff7:	79 13                	jns    80100c <ltostr+0x2d>
	{
		neg = 1;
  800ff9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801000:	8b 45 0c             	mov    0xc(%ebp),%eax
  801003:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801006:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801009:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801014:	99                   	cltd   
  801015:	f7 f9                	idiv   %ecx
  801017:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80101a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101d:	8d 50 01             	lea    0x1(%eax),%edx
  801020:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801023:	89 c2                	mov    %eax,%edx
  801025:	8b 45 0c             	mov    0xc(%ebp),%eax
  801028:	01 d0                	add    %edx,%eax
  80102a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80102d:	83 c2 30             	add    $0x30,%edx
  801030:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801032:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801035:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80103a:	f7 e9                	imul   %ecx
  80103c:	c1 fa 02             	sar    $0x2,%edx
  80103f:	89 c8                	mov    %ecx,%eax
  801041:	c1 f8 1f             	sar    $0x1f,%eax
  801044:	29 c2                	sub    %eax,%edx
  801046:	89 d0                	mov    %edx,%eax
  801048:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80104b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80104e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801053:	f7 e9                	imul   %ecx
  801055:	c1 fa 02             	sar    $0x2,%edx
  801058:	89 c8                	mov    %ecx,%eax
  80105a:	c1 f8 1f             	sar    $0x1f,%eax
  80105d:	29 c2                	sub    %eax,%edx
  80105f:	89 d0                	mov    %edx,%eax
  801061:	c1 e0 02             	shl    $0x2,%eax
  801064:	01 d0                	add    %edx,%eax
  801066:	01 c0                	add    %eax,%eax
  801068:	29 c1                	sub    %eax,%ecx
  80106a:	89 ca                	mov    %ecx,%edx
  80106c:	85 d2                	test   %edx,%edx
  80106e:	75 9c                	jne    80100c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801070:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801077:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107a:	48                   	dec    %eax
  80107b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80107e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801082:	74 3d                	je     8010c1 <ltostr+0xe2>
		start = 1 ;
  801084:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80108b:	eb 34                	jmp    8010c1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80108d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801090:	8b 45 0c             	mov    0xc(%ebp),%eax
  801093:	01 d0                	add    %edx,%eax
  801095:	8a 00                	mov    (%eax),%al
  801097:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80109a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a0:	01 c2                	add    %eax,%edx
  8010a2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a8:	01 c8                	add    %ecx,%eax
  8010aa:	8a 00                	mov    (%eax),%al
  8010ac:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ae:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b4:	01 c2                	add    %eax,%edx
  8010b6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010b9:	88 02                	mov    %al,(%edx)
		start++ ;
  8010bb:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010be:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010c7:	7c c4                	jl     80108d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010c9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cf:	01 d0                	add    %edx,%eax
  8010d1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010d4:	90                   	nop
  8010d5:	c9                   	leave  
  8010d6:	c3                   	ret    

008010d7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010d7:	55                   	push   %ebp
  8010d8:	89 e5                	mov    %esp,%ebp
  8010da:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010dd:	ff 75 08             	pushl  0x8(%ebp)
  8010e0:	e8 54 fa ff ff       	call   800b39 <strlen>
  8010e5:	83 c4 04             	add    $0x4,%esp
  8010e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010eb:	ff 75 0c             	pushl  0xc(%ebp)
  8010ee:	e8 46 fa ff ff       	call   800b39 <strlen>
  8010f3:	83 c4 04             	add    $0x4,%esp
  8010f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801107:	eb 17                	jmp    801120 <strcconcat+0x49>
		final[s] = str1[s] ;
  801109:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80110c:	8b 45 10             	mov    0x10(%ebp),%eax
  80110f:	01 c2                	add    %eax,%edx
  801111:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	01 c8                	add    %ecx,%eax
  801119:	8a 00                	mov    (%eax),%al
  80111b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80111d:	ff 45 fc             	incl   -0x4(%ebp)
  801120:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801123:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801126:	7c e1                	jl     801109 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801128:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80112f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801136:	eb 1f                	jmp    801157 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801138:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113b:	8d 50 01             	lea    0x1(%eax),%edx
  80113e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801141:	89 c2                	mov    %eax,%edx
  801143:	8b 45 10             	mov    0x10(%ebp),%eax
  801146:	01 c2                	add    %eax,%edx
  801148:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80114b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114e:	01 c8                	add    %ecx,%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801154:	ff 45 f8             	incl   -0x8(%ebp)
  801157:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80115d:	7c d9                	jl     801138 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80115f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801162:	8b 45 10             	mov    0x10(%ebp),%eax
  801165:	01 d0                	add    %edx,%eax
  801167:	c6 00 00             	movb   $0x0,(%eax)
}
  80116a:	90                   	nop
  80116b:	c9                   	leave  
  80116c:	c3                   	ret    

0080116d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801170:	8b 45 14             	mov    0x14(%ebp),%eax
  801173:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801179:	8b 45 14             	mov    0x14(%ebp),%eax
  80117c:	8b 00                	mov    (%eax),%eax
  80117e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801185:	8b 45 10             	mov    0x10(%ebp),%eax
  801188:	01 d0                	add    %edx,%eax
  80118a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801190:	eb 0c                	jmp    80119e <strsplit+0x31>
			*string++ = 0;
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	8d 50 01             	lea    0x1(%eax),%edx
  801198:	89 55 08             	mov    %edx,0x8(%ebp)
  80119b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	84 c0                	test   %al,%al
  8011a5:	74 18                	je     8011bf <strsplit+0x52>
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	8a 00                	mov    (%eax),%al
  8011ac:	0f be c0             	movsbl %al,%eax
  8011af:	50                   	push   %eax
  8011b0:	ff 75 0c             	pushl  0xc(%ebp)
  8011b3:	e8 13 fb ff ff       	call   800ccb <strchr>
  8011b8:	83 c4 08             	add    $0x8,%esp
  8011bb:	85 c0                	test   %eax,%eax
  8011bd:	75 d3                	jne    801192 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	84 c0                	test   %al,%al
  8011c6:	74 5a                	je     801222 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cb:	8b 00                	mov    (%eax),%eax
  8011cd:	83 f8 0f             	cmp    $0xf,%eax
  8011d0:	75 07                	jne    8011d9 <strsplit+0x6c>
		{
			return 0;
  8011d2:	b8 00 00 00 00       	mov    $0x0,%eax
  8011d7:	eb 66                	jmp    80123f <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011dc:	8b 00                	mov    (%eax),%eax
  8011de:	8d 48 01             	lea    0x1(%eax),%ecx
  8011e1:	8b 55 14             	mov    0x14(%ebp),%edx
  8011e4:	89 0a                	mov    %ecx,(%edx)
  8011e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f0:	01 c2                	add    %eax,%edx
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011f7:	eb 03                	jmp    8011fc <strsplit+0x8f>
			string++;
  8011f9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	84 c0                	test   %al,%al
  801203:	74 8b                	je     801190 <strsplit+0x23>
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	8a 00                	mov    (%eax),%al
  80120a:	0f be c0             	movsbl %al,%eax
  80120d:	50                   	push   %eax
  80120e:	ff 75 0c             	pushl  0xc(%ebp)
  801211:	e8 b5 fa ff ff       	call   800ccb <strchr>
  801216:	83 c4 08             	add    $0x8,%esp
  801219:	85 c0                	test   %eax,%eax
  80121b:	74 dc                	je     8011f9 <strsplit+0x8c>
			string++;
	}
  80121d:	e9 6e ff ff ff       	jmp    801190 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801222:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801223:	8b 45 14             	mov    0x14(%ebp),%eax
  801226:	8b 00                	mov    (%eax),%eax
  801228:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80122f:	8b 45 10             	mov    0x10(%ebp),%eax
  801232:	01 d0                	add    %edx,%eax
  801234:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80123a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80123f:	c9                   	leave  
  801240:	c3                   	ret    

00801241 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801241:	55                   	push   %ebp
  801242:	89 e5                	mov    %esp,%ebp
  801244:	57                   	push   %edi
  801245:	56                   	push   %esi
  801246:	53                   	push   %ebx
  801247:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801250:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801253:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801256:	8b 7d 18             	mov    0x18(%ebp),%edi
  801259:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80125c:	cd 30                	int    $0x30
  80125e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801261:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801264:	83 c4 10             	add    $0x10,%esp
  801267:	5b                   	pop    %ebx
  801268:	5e                   	pop    %esi
  801269:	5f                   	pop    %edi
  80126a:	5d                   	pop    %ebp
  80126b:	c3                   	ret    

0080126c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
  80126f:	83 ec 04             	sub    $0x4,%esp
  801272:	8b 45 10             	mov    0x10(%ebp),%eax
  801275:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801278:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80127c:	8b 45 08             	mov    0x8(%ebp),%eax
  80127f:	6a 00                	push   $0x0
  801281:	6a 00                	push   $0x0
  801283:	52                   	push   %edx
  801284:	ff 75 0c             	pushl  0xc(%ebp)
  801287:	50                   	push   %eax
  801288:	6a 00                	push   $0x0
  80128a:	e8 b2 ff ff ff       	call   801241 <syscall>
  80128f:	83 c4 18             	add    $0x18,%esp
}
  801292:	90                   	nop
  801293:	c9                   	leave  
  801294:	c3                   	ret    

00801295 <sys_cgetc>:

int
sys_cgetc(void)
{
  801295:	55                   	push   %ebp
  801296:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 01                	push   $0x1
  8012a4:	e8 98 ff ff ff       	call   801241 <syscall>
  8012a9:	83 c4 18             	add    $0x18,%esp
}
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	50                   	push   %eax
  8012bd:	6a 05                	push   $0x5
  8012bf:	e8 7d ff ff ff       	call   801241 <syscall>
  8012c4:	83 c4 18             	add    $0x18,%esp
}
  8012c7:	c9                   	leave  
  8012c8:	c3                   	ret    

008012c9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012c9:	55                   	push   %ebp
  8012ca:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 02                	push   $0x2
  8012d8:	e8 64 ff ff ff       	call   801241 <syscall>
  8012dd:	83 c4 18             	add    $0x18,%esp
}
  8012e0:	c9                   	leave  
  8012e1:	c3                   	ret    

008012e2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012e2:	55                   	push   %ebp
  8012e3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 03                	push   $0x3
  8012f1:	e8 4b ff ff ff       	call   801241 <syscall>
  8012f6:	83 c4 18             	add    $0x18,%esp
}
  8012f9:	c9                   	leave  
  8012fa:	c3                   	ret    

008012fb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	6a 00                	push   $0x0
  801308:	6a 04                	push   $0x4
  80130a:	e8 32 ff ff ff       	call   801241 <syscall>
  80130f:	83 c4 18             	add    $0x18,%esp
}
  801312:	c9                   	leave  
  801313:	c3                   	ret    

00801314 <sys_env_exit>:


void sys_env_exit(void)
{
  801314:	55                   	push   %ebp
  801315:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 06                	push   $0x6
  801323:	e8 19 ff ff ff       	call   801241 <syscall>
  801328:	83 c4 18             	add    $0x18,%esp
}
  80132b:	90                   	nop
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801331:	8b 55 0c             	mov    0xc(%ebp),%edx
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	52                   	push   %edx
  80133e:	50                   	push   %eax
  80133f:	6a 07                	push   $0x7
  801341:	e8 fb fe ff ff       	call   801241 <syscall>
  801346:	83 c4 18             	add    $0x18,%esp
}
  801349:	c9                   	leave  
  80134a:	c3                   	ret    

0080134b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80134b:	55                   	push   %ebp
  80134c:	89 e5                	mov    %esp,%ebp
  80134e:	56                   	push   %esi
  80134f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801350:	8b 75 18             	mov    0x18(%ebp),%esi
  801353:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801356:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801359:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135c:	8b 45 08             	mov    0x8(%ebp),%eax
  80135f:	56                   	push   %esi
  801360:	53                   	push   %ebx
  801361:	51                   	push   %ecx
  801362:	52                   	push   %edx
  801363:	50                   	push   %eax
  801364:	6a 08                	push   $0x8
  801366:	e8 d6 fe ff ff       	call   801241 <syscall>
  80136b:	83 c4 18             	add    $0x18,%esp
}
  80136e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801371:	5b                   	pop    %ebx
  801372:	5e                   	pop    %esi
  801373:	5d                   	pop    %ebp
  801374:	c3                   	ret    

00801375 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801375:	55                   	push   %ebp
  801376:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801378:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	52                   	push   %edx
  801385:	50                   	push   %eax
  801386:	6a 09                	push   $0x9
  801388:	e8 b4 fe ff ff       	call   801241 <syscall>
  80138d:	83 c4 18             	add    $0x18,%esp
}
  801390:	c9                   	leave  
  801391:	c3                   	ret    

00801392 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	ff 75 0c             	pushl  0xc(%ebp)
  80139e:	ff 75 08             	pushl  0x8(%ebp)
  8013a1:	6a 0a                	push   $0xa
  8013a3:	e8 99 fe ff ff       	call   801241 <syscall>
  8013a8:	83 c4 18             	add    $0x18,%esp
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 0b                	push   $0xb
  8013bc:	e8 80 fe ff ff       	call   801241 <syscall>
  8013c1:	83 c4 18             	add    $0x18,%esp
}
  8013c4:	c9                   	leave  
  8013c5:	c3                   	ret    

008013c6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 0c                	push   $0xc
  8013d5:	e8 67 fe ff ff       	call   801241 <syscall>
  8013da:	83 c4 18             	add    $0x18,%esp
}
  8013dd:	c9                   	leave  
  8013de:	c3                   	ret    

008013df <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013df:	55                   	push   %ebp
  8013e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 0d                	push   $0xd
  8013ee:	e8 4e fe ff ff       	call   801241 <syscall>
  8013f3:	83 c4 18             	add    $0x18,%esp
}
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	ff 75 0c             	pushl  0xc(%ebp)
  801404:	ff 75 08             	pushl  0x8(%ebp)
  801407:	6a 11                	push   $0x11
  801409:	e8 33 fe ff ff       	call   801241 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
	return;
  801411:	90                   	nop
}
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	ff 75 0c             	pushl  0xc(%ebp)
  801420:	ff 75 08             	pushl  0x8(%ebp)
  801423:	6a 12                	push   $0x12
  801425:	e8 17 fe ff ff       	call   801241 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
	return ;
  80142d:	90                   	nop
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 0e                	push   $0xe
  80143f:	e8 fd fd ff ff       	call   801241 <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	6a 00                	push   $0x0
  801454:	ff 75 08             	pushl  0x8(%ebp)
  801457:	6a 0f                	push   $0xf
  801459:	e8 e3 fd ff ff       	call   801241 <syscall>
  80145e:	83 c4 18             	add    $0x18,%esp
}
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 10                	push   $0x10
  801472:	e8 ca fd ff ff       	call   801241 <syscall>
  801477:	83 c4 18             	add    $0x18,%esp
}
  80147a:	90                   	nop
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 14                	push   $0x14
  80148c:	e8 b0 fd ff ff       	call   801241 <syscall>
  801491:	83 c4 18             	add    $0x18,%esp
}
  801494:	90                   	nop
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 15                	push   $0x15
  8014a6:	e8 96 fd ff ff       	call   801241 <syscall>
  8014ab:	83 c4 18             	add    $0x18,%esp
}
  8014ae:	90                   	nop
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
  8014b4:	83 ec 04             	sub    $0x4,%esp
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014bd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	50                   	push   %eax
  8014ca:	6a 16                	push   $0x16
  8014cc:	e8 70 fd ff ff       	call   801241 <syscall>
  8014d1:	83 c4 18             	add    $0x18,%esp
}
  8014d4:	90                   	nop
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 17                	push   $0x17
  8014e6:	e8 56 fd ff ff       	call   801241 <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
}
  8014ee:	90                   	nop
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	ff 75 0c             	pushl  0xc(%ebp)
  801500:	50                   	push   %eax
  801501:	6a 18                	push   $0x18
  801503:	e8 39 fd ff ff       	call   801241 <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801510:	8b 55 0c             	mov    0xc(%ebp),%edx
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	52                   	push   %edx
  80151d:	50                   	push   %eax
  80151e:	6a 1b                	push   $0x1b
  801520:	e8 1c fd ff ff       	call   801241 <syscall>
  801525:	83 c4 18             	add    $0x18,%esp
}
  801528:	c9                   	leave  
  801529:	c3                   	ret    

0080152a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80152a:	55                   	push   %ebp
  80152b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80152d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801530:	8b 45 08             	mov    0x8(%ebp),%eax
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	52                   	push   %edx
  80153a:	50                   	push   %eax
  80153b:	6a 19                	push   $0x19
  80153d:	e8 ff fc ff ff       	call   801241 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	90                   	nop
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80154b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	52                   	push   %edx
  801558:	50                   	push   %eax
  801559:	6a 1a                	push   $0x1a
  80155b:	e8 e1 fc ff ff       	call   801241 <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	90                   	nop
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
  801569:	83 ec 04             	sub    $0x4,%esp
  80156c:	8b 45 10             	mov    0x10(%ebp),%eax
  80156f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801572:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801575:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
  80157c:	6a 00                	push   $0x0
  80157e:	51                   	push   %ecx
  80157f:	52                   	push   %edx
  801580:	ff 75 0c             	pushl  0xc(%ebp)
  801583:	50                   	push   %eax
  801584:	6a 1c                	push   $0x1c
  801586:	e8 b6 fc ff ff       	call   801241 <syscall>
  80158b:	83 c4 18             	add    $0x18,%esp
}
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801593:	8b 55 0c             	mov    0xc(%ebp),%edx
  801596:	8b 45 08             	mov    0x8(%ebp),%eax
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	52                   	push   %edx
  8015a0:	50                   	push   %eax
  8015a1:	6a 1d                	push   $0x1d
  8015a3:	e8 99 fc ff ff       	call   801241 <syscall>
  8015a8:	83 c4 18             	add    $0x18,%esp
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015b0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	51                   	push   %ecx
  8015be:	52                   	push   %edx
  8015bf:	50                   	push   %eax
  8015c0:	6a 1e                	push   $0x1e
  8015c2:	e8 7a fc ff ff       	call   801241 <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	52                   	push   %edx
  8015dc:	50                   	push   %eax
  8015dd:	6a 1f                	push   $0x1f
  8015df:	e8 5d fc ff ff       	call   801241 <syscall>
  8015e4:	83 c4 18             	add    $0x18,%esp
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 20                	push   $0x20
  8015f8:	e8 44 fc ff ff       	call   801241 <syscall>
  8015fd:	83 c4 18             	add    $0x18,%esp
}
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801605:	8b 45 08             	mov    0x8(%ebp),%eax
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	ff 75 10             	pushl  0x10(%ebp)
  80160f:	ff 75 0c             	pushl  0xc(%ebp)
  801612:	50                   	push   %eax
  801613:	6a 21                	push   $0x21
  801615:	e8 27 fc ff ff       	call   801241 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801622:	8b 45 08             	mov    0x8(%ebp),%eax
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	50                   	push   %eax
  80162e:	6a 22                	push   $0x22
  801630:	e8 0c fc ff ff       	call   801241 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	90                   	nop
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	50                   	push   %eax
  80164a:	6a 23                	push   $0x23
  80164c:	e8 f0 fb ff ff       	call   801241 <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	90                   	nop
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
  80165a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80165d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801660:	8d 50 04             	lea    0x4(%eax),%edx
  801663:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	52                   	push   %edx
  80166d:	50                   	push   %eax
  80166e:	6a 24                	push   $0x24
  801670:	e8 cc fb ff ff       	call   801241 <syscall>
  801675:	83 c4 18             	add    $0x18,%esp
	return result;
  801678:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80167b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80167e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801681:	89 01                	mov    %eax,(%ecx)
  801683:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	c9                   	leave  
  80168a:	c2 04 00             	ret    $0x4

0080168d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80168d:	55                   	push   %ebp
  80168e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	ff 75 10             	pushl  0x10(%ebp)
  801697:	ff 75 0c             	pushl  0xc(%ebp)
  80169a:	ff 75 08             	pushl  0x8(%ebp)
  80169d:	6a 13                	push   $0x13
  80169f:	e8 9d fb ff ff       	call   801241 <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a7:	90                   	nop
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <sys_rcr2>:
uint32 sys_rcr2()
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 25                	push   $0x25
  8016b9:	e8 83 fb ff ff       	call   801241 <syscall>
  8016be:	83 c4 18             	add    $0x18,%esp
}
  8016c1:	c9                   	leave  
  8016c2:	c3                   	ret    

008016c3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016c3:	55                   	push   %ebp
  8016c4:	89 e5                	mov    %esp,%ebp
  8016c6:	83 ec 04             	sub    $0x4,%esp
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016cf:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	50                   	push   %eax
  8016dc:	6a 26                	push   $0x26
  8016de:	e8 5e fb ff ff       	call   801241 <syscall>
  8016e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e6:	90                   	nop
}
  8016e7:	c9                   	leave  
  8016e8:	c3                   	ret    

008016e9 <rsttst>:
void rsttst()
{
  8016e9:	55                   	push   %ebp
  8016ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 28                	push   $0x28
  8016f8:	e8 44 fb ff ff       	call   801241 <syscall>
  8016fd:	83 c4 18             	add    $0x18,%esp
	return ;
  801700:	90                   	nop
}
  801701:	c9                   	leave  
  801702:	c3                   	ret    

00801703 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
  801706:	83 ec 04             	sub    $0x4,%esp
  801709:	8b 45 14             	mov    0x14(%ebp),%eax
  80170c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80170f:	8b 55 18             	mov    0x18(%ebp),%edx
  801712:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801716:	52                   	push   %edx
  801717:	50                   	push   %eax
  801718:	ff 75 10             	pushl  0x10(%ebp)
  80171b:	ff 75 0c             	pushl  0xc(%ebp)
  80171e:	ff 75 08             	pushl  0x8(%ebp)
  801721:	6a 27                	push   $0x27
  801723:	e8 19 fb ff ff       	call   801241 <syscall>
  801728:	83 c4 18             	add    $0x18,%esp
	return ;
  80172b:	90                   	nop
}
  80172c:	c9                   	leave  
  80172d:	c3                   	ret    

0080172e <chktst>:
void chktst(uint32 n)
{
  80172e:	55                   	push   %ebp
  80172f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	ff 75 08             	pushl  0x8(%ebp)
  80173c:	6a 29                	push   $0x29
  80173e:	e8 fe fa ff ff       	call   801241 <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
	return ;
  801746:	90                   	nop
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <inctst>:

void inctst()
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 2a                	push   $0x2a
  801758:	e8 e4 fa ff ff       	call   801241 <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
	return ;
  801760:	90                   	nop
}
  801761:	c9                   	leave  
  801762:	c3                   	ret    

00801763 <gettst>:
uint32 gettst()
{
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 2b                	push   $0x2b
  801772:	e8 ca fa ff ff       	call   801241 <syscall>
  801777:	83 c4 18             	add    $0x18,%esp
}
  80177a:	c9                   	leave  
  80177b:	c3                   	ret    

0080177c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80177c:	55                   	push   %ebp
  80177d:	89 e5                	mov    %esp,%ebp
  80177f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 2c                	push   $0x2c
  80178e:	e8 ae fa ff ff       	call   801241 <syscall>
  801793:	83 c4 18             	add    $0x18,%esp
  801796:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801799:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80179d:	75 07                	jne    8017a6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80179f:	b8 01 00 00 00       	mov    $0x1,%eax
  8017a4:	eb 05                	jmp    8017ab <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
  8017b0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 2c                	push   $0x2c
  8017bf:	e8 7d fa ff ff       	call   801241 <syscall>
  8017c4:	83 c4 18             	add    $0x18,%esp
  8017c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017ca:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017ce:	75 07                	jne    8017d7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017d0:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d5:	eb 05                	jmp    8017dc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017dc:	c9                   	leave  
  8017dd:	c3                   	ret    

008017de <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017de:	55                   	push   %ebp
  8017df:	89 e5                	mov    %esp,%ebp
  8017e1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 2c                	push   $0x2c
  8017f0:	e8 4c fa ff ff       	call   801241 <syscall>
  8017f5:	83 c4 18             	add    $0x18,%esp
  8017f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017fb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017ff:	75 07                	jne    801808 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801801:	b8 01 00 00 00       	mov    $0x1,%eax
  801806:	eb 05                	jmp    80180d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801808:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
  801812:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 2c                	push   $0x2c
  801821:	e8 1b fa ff ff       	call   801241 <syscall>
  801826:	83 c4 18             	add    $0x18,%esp
  801829:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80182c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801830:	75 07                	jne    801839 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801832:	b8 01 00 00 00       	mov    $0x1,%eax
  801837:	eb 05                	jmp    80183e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801839:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80183e:	c9                   	leave  
  80183f:	c3                   	ret    

00801840 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801840:	55                   	push   %ebp
  801841:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	ff 75 08             	pushl  0x8(%ebp)
  80184e:	6a 2d                	push   $0x2d
  801850:	e8 ec f9 ff ff       	call   801241 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
	return ;
  801858:	90                   	nop
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
  80185e:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801861:	8b 55 08             	mov    0x8(%ebp),%edx
  801864:	89 d0                	mov    %edx,%eax
  801866:	c1 e0 02             	shl    $0x2,%eax
  801869:	01 d0                	add    %edx,%eax
  80186b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801872:	01 d0                	add    %edx,%eax
  801874:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80187b:	01 d0                	add    %edx,%eax
  80187d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801884:	01 d0                	add    %edx,%eax
  801886:	c1 e0 04             	shl    $0x4,%eax
  801889:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80188c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801893:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801896:	83 ec 0c             	sub    $0xc,%esp
  801899:	50                   	push   %eax
  80189a:	e8 b8 fd ff ff       	call   801657 <sys_get_virtual_time>
  80189f:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018a2:	eb 41                	jmp    8018e5 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018a4:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018a7:	83 ec 0c             	sub    $0xc,%esp
  8018aa:	50                   	push   %eax
  8018ab:	e8 a7 fd ff ff       	call   801657 <sys_get_virtual_time>
  8018b0:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8018b3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018b9:	29 c2                	sub    %eax,%edx
  8018bb:	89 d0                	mov    %edx,%eax
  8018bd:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8018c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8018c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8018c6:	89 d1                	mov    %edx,%ecx
  8018c8:	29 c1                	sub    %eax,%ecx
  8018ca:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8018cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018d0:	39 c2                	cmp    %eax,%edx
  8018d2:	0f 97 c0             	seta   %al
  8018d5:	0f b6 c0             	movzbl %al,%eax
  8018d8:	29 c1                	sub    %eax,%ecx
  8018da:	89 c8                	mov    %ecx,%eax
  8018dc:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8018df:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8018e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8018e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018eb:	72 b7                	jb     8018a4 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8018ed:	90                   	nop
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
  8018f3:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8018f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8018fd:	eb 03                	jmp    801902 <busy_wait+0x12>
  8018ff:	ff 45 fc             	incl   -0x4(%ebp)
  801902:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801905:	3b 45 08             	cmp    0x8(%ebp),%eax
  801908:	72 f5                	jb     8018ff <busy_wait+0xf>
	return i;
  80190a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80190d:	c9                   	leave  
  80190e:	c3                   	ret    

0080190f <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80190f:	55                   	push   %ebp
  801910:	89 e5                	mov    %esp,%ebp
  801912:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801915:	8b 45 08             	mov    0x8(%ebp),%eax
  801918:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80191b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80191f:	83 ec 0c             	sub    $0xc,%esp
  801922:	50                   	push   %eax
  801923:	e8 89 fb ff ff       	call   8014b1 <sys_cputc>
  801928:	83 c4 10             	add    $0x10,%esp
}
  80192b:	90                   	nop
  80192c:	c9                   	leave  
  80192d:	c3                   	ret    

0080192e <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80192e:	55                   	push   %ebp
  80192f:	89 e5                	mov    %esp,%ebp
  801931:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801934:	e8 44 fb ff ff       	call   80147d <sys_disable_interrupt>
	char c = ch;
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80193f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801943:	83 ec 0c             	sub    $0xc,%esp
  801946:	50                   	push   %eax
  801947:	e8 65 fb ff ff       	call   8014b1 <sys_cputc>
  80194c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80194f:	e8 43 fb ff ff       	call   801497 <sys_enable_interrupt>
}
  801954:	90                   	nop
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <getchar>:

int
getchar(void)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
  80195a:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80195d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801964:	eb 08                	jmp    80196e <getchar+0x17>
	{
		c = sys_cgetc();
  801966:	e8 2a f9 ff ff       	call   801295 <sys_cgetc>
  80196b:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80196e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801972:	74 f2                	je     801966 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801974:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <atomic_getchar>:

int
atomic_getchar(void)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
  80197c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80197f:	e8 f9 fa ff ff       	call   80147d <sys_disable_interrupt>
	int c=0;
  801984:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80198b:	eb 08                	jmp    801995 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  80198d:	e8 03 f9 ff ff       	call   801295 <sys_cgetc>
  801992:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801995:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801999:	74 f2                	je     80198d <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  80199b:	e8 f7 fa ff ff       	call   801497 <sys_enable_interrupt>
	return c;
  8019a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <iscons>:

int iscons(int fdnum)
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8019a8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019ad:	5d                   	pop    %ebp
  8019ae:	c3                   	ret    
  8019af:	90                   	nop

008019b0 <__udivdi3>:
  8019b0:	55                   	push   %ebp
  8019b1:	57                   	push   %edi
  8019b2:	56                   	push   %esi
  8019b3:	53                   	push   %ebx
  8019b4:	83 ec 1c             	sub    $0x1c,%esp
  8019b7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019bb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019bf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019c3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019c7:	89 ca                	mov    %ecx,%edx
  8019c9:	89 f8                	mov    %edi,%eax
  8019cb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019cf:	85 f6                	test   %esi,%esi
  8019d1:	75 2d                	jne    801a00 <__udivdi3+0x50>
  8019d3:	39 cf                	cmp    %ecx,%edi
  8019d5:	77 65                	ja     801a3c <__udivdi3+0x8c>
  8019d7:	89 fd                	mov    %edi,%ebp
  8019d9:	85 ff                	test   %edi,%edi
  8019db:	75 0b                	jne    8019e8 <__udivdi3+0x38>
  8019dd:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e2:	31 d2                	xor    %edx,%edx
  8019e4:	f7 f7                	div    %edi
  8019e6:	89 c5                	mov    %eax,%ebp
  8019e8:	31 d2                	xor    %edx,%edx
  8019ea:	89 c8                	mov    %ecx,%eax
  8019ec:	f7 f5                	div    %ebp
  8019ee:	89 c1                	mov    %eax,%ecx
  8019f0:	89 d8                	mov    %ebx,%eax
  8019f2:	f7 f5                	div    %ebp
  8019f4:	89 cf                	mov    %ecx,%edi
  8019f6:	89 fa                	mov    %edi,%edx
  8019f8:	83 c4 1c             	add    $0x1c,%esp
  8019fb:	5b                   	pop    %ebx
  8019fc:	5e                   	pop    %esi
  8019fd:	5f                   	pop    %edi
  8019fe:	5d                   	pop    %ebp
  8019ff:	c3                   	ret    
  801a00:	39 ce                	cmp    %ecx,%esi
  801a02:	77 28                	ja     801a2c <__udivdi3+0x7c>
  801a04:	0f bd fe             	bsr    %esi,%edi
  801a07:	83 f7 1f             	xor    $0x1f,%edi
  801a0a:	75 40                	jne    801a4c <__udivdi3+0x9c>
  801a0c:	39 ce                	cmp    %ecx,%esi
  801a0e:	72 0a                	jb     801a1a <__udivdi3+0x6a>
  801a10:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a14:	0f 87 9e 00 00 00    	ja     801ab8 <__udivdi3+0x108>
  801a1a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a1f:	89 fa                	mov    %edi,%edx
  801a21:	83 c4 1c             	add    $0x1c,%esp
  801a24:	5b                   	pop    %ebx
  801a25:	5e                   	pop    %esi
  801a26:	5f                   	pop    %edi
  801a27:	5d                   	pop    %ebp
  801a28:	c3                   	ret    
  801a29:	8d 76 00             	lea    0x0(%esi),%esi
  801a2c:	31 ff                	xor    %edi,%edi
  801a2e:	31 c0                	xor    %eax,%eax
  801a30:	89 fa                	mov    %edi,%edx
  801a32:	83 c4 1c             	add    $0x1c,%esp
  801a35:	5b                   	pop    %ebx
  801a36:	5e                   	pop    %esi
  801a37:	5f                   	pop    %edi
  801a38:	5d                   	pop    %ebp
  801a39:	c3                   	ret    
  801a3a:	66 90                	xchg   %ax,%ax
  801a3c:	89 d8                	mov    %ebx,%eax
  801a3e:	f7 f7                	div    %edi
  801a40:	31 ff                	xor    %edi,%edi
  801a42:	89 fa                	mov    %edi,%edx
  801a44:	83 c4 1c             	add    $0x1c,%esp
  801a47:	5b                   	pop    %ebx
  801a48:	5e                   	pop    %esi
  801a49:	5f                   	pop    %edi
  801a4a:	5d                   	pop    %ebp
  801a4b:	c3                   	ret    
  801a4c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a51:	89 eb                	mov    %ebp,%ebx
  801a53:	29 fb                	sub    %edi,%ebx
  801a55:	89 f9                	mov    %edi,%ecx
  801a57:	d3 e6                	shl    %cl,%esi
  801a59:	89 c5                	mov    %eax,%ebp
  801a5b:	88 d9                	mov    %bl,%cl
  801a5d:	d3 ed                	shr    %cl,%ebp
  801a5f:	89 e9                	mov    %ebp,%ecx
  801a61:	09 f1                	or     %esi,%ecx
  801a63:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a67:	89 f9                	mov    %edi,%ecx
  801a69:	d3 e0                	shl    %cl,%eax
  801a6b:	89 c5                	mov    %eax,%ebp
  801a6d:	89 d6                	mov    %edx,%esi
  801a6f:	88 d9                	mov    %bl,%cl
  801a71:	d3 ee                	shr    %cl,%esi
  801a73:	89 f9                	mov    %edi,%ecx
  801a75:	d3 e2                	shl    %cl,%edx
  801a77:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a7b:	88 d9                	mov    %bl,%cl
  801a7d:	d3 e8                	shr    %cl,%eax
  801a7f:	09 c2                	or     %eax,%edx
  801a81:	89 d0                	mov    %edx,%eax
  801a83:	89 f2                	mov    %esi,%edx
  801a85:	f7 74 24 0c          	divl   0xc(%esp)
  801a89:	89 d6                	mov    %edx,%esi
  801a8b:	89 c3                	mov    %eax,%ebx
  801a8d:	f7 e5                	mul    %ebp
  801a8f:	39 d6                	cmp    %edx,%esi
  801a91:	72 19                	jb     801aac <__udivdi3+0xfc>
  801a93:	74 0b                	je     801aa0 <__udivdi3+0xf0>
  801a95:	89 d8                	mov    %ebx,%eax
  801a97:	31 ff                	xor    %edi,%edi
  801a99:	e9 58 ff ff ff       	jmp    8019f6 <__udivdi3+0x46>
  801a9e:	66 90                	xchg   %ax,%ax
  801aa0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801aa4:	89 f9                	mov    %edi,%ecx
  801aa6:	d3 e2                	shl    %cl,%edx
  801aa8:	39 c2                	cmp    %eax,%edx
  801aaa:	73 e9                	jae    801a95 <__udivdi3+0xe5>
  801aac:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801aaf:	31 ff                	xor    %edi,%edi
  801ab1:	e9 40 ff ff ff       	jmp    8019f6 <__udivdi3+0x46>
  801ab6:	66 90                	xchg   %ax,%ax
  801ab8:	31 c0                	xor    %eax,%eax
  801aba:	e9 37 ff ff ff       	jmp    8019f6 <__udivdi3+0x46>
  801abf:	90                   	nop

00801ac0 <__umoddi3>:
  801ac0:	55                   	push   %ebp
  801ac1:	57                   	push   %edi
  801ac2:	56                   	push   %esi
  801ac3:	53                   	push   %ebx
  801ac4:	83 ec 1c             	sub    $0x1c,%esp
  801ac7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801acb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801acf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ad3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ad7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801adb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801adf:	89 f3                	mov    %esi,%ebx
  801ae1:	89 fa                	mov    %edi,%edx
  801ae3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ae7:	89 34 24             	mov    %esi,(%esp)
  801aea:	85 c0                	test   %eax,%eax
  801aec:	75 1a                	jne    801b08 <__umoddi3+0x48>
  801aee:	39 f7                	cmp    %esi,%edi
  801af0:	0f 86 a2 00 00 00    	jbe    801b98 <__umoddi3+0xd8>
  801af6:	89 c8                	mov    %ecx,%eax
  801af8:	89 f2                	mov    %esi,%edx
  801afa:	f7 f7                	div    %edi
  801afc:	89 d0                	mov    %edx,%eax
  801afe:	31 d2                	xor    %edx,%edx
  801b00:	83 c4 1c             	add    $0x1c,%esp
  801b03:	5b                   	pop    %ebx
  801b04:	5e                   	pop    %esi
  801b05:	5f                   	pop    %edi
  801b06:	5d                   	pop    %ebp
  801b07:	c3                   	ret    
  801b08:	39 f0                	cmp    %esi,%eax
  801b0a:	0f 87 ac 00 00 00    	ja     801bbc <__umoddi3+0xfc>
  801b10:	0f bd e8             	bsr    %eax,%ebp
  801b13:	83 f5 1f             	xor    $0x1f,%ebp
  801b16:	0f 84 ac 00 00 00    	je     801bc8 <__umoddi3+0x108>
  801b1c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b21:	29 ef                	sub    %ebp,%edi
  801b23:	89 fe                	mov    %edi,%esi
  801b25:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b29:	89 e9                	mov    %ebp,%ecx
  801b2b:	d3 e0                	shl    %cl,%eax
  801b2d:	89 d7                	mov    %edx,%edi
  801b2f:	89 f1                	mov    %esi,%ecx
  801b31:	d3 ef                	shr    %cl,%edi
  801b33:	09 c7                	or     %eax,%edi
  801b35:	89 e9                	mov    %ebp,%ecx
  801b37:	d3 e2                	shl    %cl,%edx
  801b39:	89 14 24             	mov    %edx,(%esp)
  801b3c:	89 d8                	mov    %ebx,%eax
  801b3e:	d3 e0                	shl    %cl,%eax
  801b40:	89 c2                	mov    %eax,%edx
  801b42:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b46:	d3 e0                	shl    %cl,%eax
  801b48:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b4c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b50:	89 f1                	mov    %esi,%ecx
  801b52:	d3 e8                	shr    %cl,%eax
  801b54:	09 d0                	or     %edx,%eax
  801b56:	d3 eb                	shr    %cl,%ebx
  801b58:	89 da                	mov    %ebx,%edx
  801b5a:	f7 f7                	div    %edi
  801b5c:	89 d3                	mov    %edx,%ebx
  801b5e:	f7 24 24             	mull   (%esp)
  801b61:	89 c6                	mov    %eax,%esi
  801b63:	89 d1                	mov    %edx,%ecx
  801b65:	39 d3                	cmp    %edx,%ebx
  801b67:	0f 82 87 00 00 00    	jb     801bf4 <__umoddi3+0x134>
  801b6d:	0f 84 91 00 00 00    	je     801c04 <__umoddi3+0x144>
  801b73:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b77:	29 f2                	sub    %esi,%edx
  801b79:	19 cb                	sbb    %ecx,%ebx
  801b7b:	89 d8                	mov    %ebx,%eax
  801b7d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b81:	d3 e0                	shl    %cl,%eax
  801b83:	89 e9                	mov    %ebp,%ecx
  801b85:	d3 ea                	shr    %cl,%edx
  801b87:	09 d0                	or     %edx,%eax
  801b89:	89 e9                	mov    %ebp,%ecx
  801b8b:	d3 eb                	shr    %cl,%ebx
  801b8d:	89 da                	mov    %ebx,%edx
  801b8f:	83 c4 1c             	add    $0x1c,%esp
  801b92:	5b                   	pop    %ebx
  801b93:	5e                   	pop    %esi
  801b94:	5f                   	pop    %edi
  801b95:	5d                   	pop    %ebp
  801b96:	c3                   	ret    
  801b97:	90                   	nop
  801b98:	89 fd                	mov    %edi,%ebp
  801b9a:	85 ff                	test   %edi,%edi
  801b9c:	75 0b                	jne    801ba9 <__umoddi3+0xe9>
  801b9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801ba3:	31 d2                	xor    %edx,%edx
  801ba5:	f7 f7                	div    %edi
  801ba7:	89 c5                	mov    %eax,%ebp
  801ba9:	89 f0                	mov    %esi,%eax
  801bab:	31 d2                	xor    %edx,%edx
  801bad:	f7 f5                	div    %ebp
  801baf:	89 c8                	mov    %ecx,%eax
  801bb1:	f7 f5                	div    %ebp
  801bb3:	89 d0                	mov    %edx,%eax
  801bb5:	e9 44 ff ff ff       	jmp    801afe <__umoddi3+0x3e>
  801bba:	66 90                	xchg   %ax,%ax
  801bbc:	89 c8                	mov    %ecx,%eax
  801bbe:	89 f2                	mov    %esi,%edx
  801bc0:	83 c4 1c             	add    $0x1c,%esp
  801bc3:	5b                   	pop    %ebx
  801bc4:	5e                   	pop    %esi
  801bc5:	5f                   	pop    %edi
  801bc6:	5d                   	pop    %ebp
  801bc7:	c3                   	ret    
  801bc8:	3b 04 24             	cmp    (%esp),%eax
  801bcb:	72 06                	jb     801bd3 <__umoddi3+0x113>
  801bcd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bd1:	77 0f                	ja     801be2 <__umoddi3+0x122>
  801bd3:	89 f2                	mov    %esi,%edx
  801bd5:	29 f9                	sub    %edi,%ecx
  801bd7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bdb:	89 14 24             	mov    %edx,(%esp)
  801bde:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801be2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801be6:	8b 14 24             	mov    (%esp),%edx
  801be9:	83 c4 1c             	add    $0x1c,%esp
  801bec:	5b                   	pop    %ebx
  801bed:	5e                   	pop    %esi
  801bee:	5f                   	pop    %edi
  801bef:	5d                   	pop    %ebp
  801bf0:	c3                   	ret    
  801bf1:	8d 76 00             	lea    0x0(%esi),%esi
  801bf4:	2b 04 24             	sub    (%esp),%eax
  801bf7:	19 fa                	sbb    %edi,%edx
  801bf9:	89 d1                	mov    %edx,%ecx
  801bfb:	89 c6                	mov    %eax,%esi
  801bfd:	e9 71 ff ff ff       	jmp    801b73 <__umoddi3+0xb3>
  801c02:	66 90                	xchg   %ax,%ax
  801c04:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c08:	72 ea                	jb     801bf4 <__umoddi3+0x134>
  801c0a:	89 d9                	mov    %ebx,%ecx
  801c0c:	e9 62 ff ff ff       	jmp    801b73 <__umoddi3+0xb3>
