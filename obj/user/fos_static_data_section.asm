
obj/user/fos_static_data_section:     file format elf32-i386


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
  800031:	e8 1b 00 00 00       	call   800051 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

/// Adding array of 20000 integer on user data section
int arr[20000];

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	atomic_cprintf("user data section contains 20,000 integer\n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 40 18 80 00       	push   $0x801840
  800046:	e8 09 02 00 00       	call   800254 <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	
	return;	
  80004e:	90                   	nop
}
  80004f:	c9                   	leave  
  800050:	c3                   	ret    

00800051 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800051:	55                   	push   %ebp
  800052:	89 e5                	mov    %esp,%ebp
  800054:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800057:	e8 f6 0f 00 00       	call   801052 <sys_getenvindex>
  80005c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80005f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800062:	89 d0                	mov    %edx,%eax
  800064:	01 c0                	add    %eax,%eax
  800066:	01 d0                	add    %edx,%eax
  800068:	c1 e0 02             	shl    $0x2,%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	c1 e0 06             	shl    $0x6,%eax
  800070:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800075:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80007a:	a1 20 20 80 00       	mov    0x802020,%eax
  80007f:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800085:	84 c0                	test   %al,%al
  800087:	74 0f                	je     800098 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800089:	a1 20 20 80 00       	mov    0x802020,%eax
  80008e:	05 f4 02 00 00       	add    $0x2f4,%eax
  800093:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800098:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80009c:	7e 0a                	jle    8000a8 <libmain+0x57>
		binaryname = argv[0];
  80009e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000a1:	8b 00                	mov    (%eax),%eax
  8000a3:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000a8:	83 ec 08             	sub    $0x8,%esp
  8000ab:	ff 75 0c             	pushl  0xc(%ebp)
  8000ae:	ff 75 08             	pushl  0x8(%ebp)
  8000b1:	e8 82 ff ff ff       	call   800038 <_main>
  8000b6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000b9:	e8 2f 11 00 00       	call   8011ed <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000be:	83 ec 0c             	sub    $0xc,%esp
  8000c1:	68 84 18 80 00       	push   $0x801884
  8000c6:	e8 5c 01 00 00       	call   800227 <cprintf>
  8000cb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000ce:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d3:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8000d9:	a1 20 20 80 00       	mov    0x802020,%eax
  8000de:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8000e4:	83 ec 04             	sub    $0x4,%esp
  8000e7:	52                   	push   %edx
  8000e8:	50                   	push   %eax
  8000e9:	68 ac 18 80 00       	push   $0x8018ac
  8000ee:	e8 34 01 00 00       	call   800227 <cprintf>
  8000f3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8000f6:	a1 20 20 80 00       	mov    0x802020,%eax
  8000fb:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800101:	83 ec 08             	sub    $0x8,%esp
  800104:	50                   	push   %eax
  800105:	68 d1 18 80 00       	push   $0x8018d1
  80010a:	e8 18 01 00 00       	call   800227 <cprintf>
  80010f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	68 84 18 80 00       	push   $0x801884
  80011a:	e8 08 01 00 00       	call   800227 <cprintf>
  80011f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800122:	e8 e0 10 00 00       	call   801207 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800127:	e8 19 00 00 00       	call   800145 <exit>
}
  80012c:	90                   	nop
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800135:	83 ec 0c             	sub    $0xc,%esp
  800138:	6a 00                	push   $0x0
  80013a:	e8 df 0e 00 00       	call   80101e <sys_env_destroy>
  80013f:	83 c4 10             	add    $0x10,%esp
}
  800142:	90                   	nop
  800143:	c9                   	leave  
  800144:	c3                   	ret    

00800145 <exit>:

void
exit(void)
{
  800145:	55                   	push   %ebp
  800146:	89 e5                	mov    %esp,%ebp
  800148:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80014b:	e8 34 0f 00 00       	call   801084 <sys_env_exit>
}
  800150:	90                   	nop
  800151:	c9                   	leave  
  800152:	c3                   	ret    

00800153 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800153:	55                   	push   %ebp
  800154:	89 e5                	mov    %esp,%ebp
  800156:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800159:	8b 45 0c             	mov    0xc(%ebp),%eax
  80015c:	8b 00                	mov    (%eax),%eax
  80015e:	8d 48 01             	lea    0x1(%eax),%ecx
  800161:	8b 55 0c             	mov    0xc(%ebp),%edx
  800164:	89 0a                	mov    %ecx,(%edx)
  800166:	8b 55 08             	mov    0x8(%ebp),%edx
  800169:	88 d1                	mov    %dl,%cl
  80016b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80016e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800172:	8b 45 0c             	mov    0xc(%ebp),%eax
  800175:	8b 00                	mov    (%eax),%eax
  800177:	3d ff 00 00 00       	cmp    $0xff,%eax
  80017c:	75 2c                	jne    8001aa <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80017e:	a0 24 20 80 00       	mov    0x802024,%al
  800183:	0f b6 c0             	movzbl %al,%eax
  800186:	8b 55 0c             	mov    0xc(%ebp),%edx
  800189:	8b 12                	mov    (%edx),%edx
  80018b:	89 d1                	mov    %edx,%ecx
  80018d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800190:	83 c2 08             	add    $0x8,%edx
  800193:	83 ec 04             	sub    $0x4,%esp
  800196:	50                   	push   %eax
  800197:	51                   	push   %ecx
  800198:	52                   	push   %edx
  800199:	e8 3e 0e 00 00       	call   800fdc <sys_cputs>
  80019e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ad:	8b 40 04             	mov    0x4(%eax),%eax
  8001b0:	8d 50 01             	lea    0x1(%eax),%edx
  8001b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b6:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001b9:	90                   	nop
  8001ba:	c9                   	leave  
  8001bb:	c3                   	ret    

008001bc <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001bc:	55                   	push   %ebp
  8001bd:	89 e5                	mov    %esp,%ebp
  8001bf:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001c5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001cc:	00 00 00 
	b.cnt = 0;
  8001cf:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001d6:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001d9:	ff 75 0c             	pushl  0xc(%ebp)
  8001dc:	ff 75 08             	pushl  0x8(%ebp)
  8001df:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8001e5:	50                   	push   %eax
  8001e6:	68 53 01 80 00       	push   $0x800153
  8001eb:	e8 11 02 00 00       	call   800401 <vprintfmt>
  8001f0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8001f3:	a0 24 20 80 00       	mov    0x802024,%al
  8001f8:	0f b6 c0             	movzbl %al,%eax
  8001fb:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800201:	83 ec 04             	sub    $0x4,%esp
  800204:	50                   	push   %eax
  800205:	52                   	push   %edx
  800206:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80020c:	83 c0 08             	add    $0x8,%eax
  80020f:	50                   	push   %eax
  800210:	e8 c7 0d 00 00       	call   800fdc <sys_cputs>
  800215:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800218:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80021f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800225:	c9                   	leave  
  800226:	c3                   	ret    

00800227 <cprintf>:

int cprintf(const char *fmt, ...) {
  800227:	55                   	push   %ebp
  800228:	89 e5                	mov    %esp,%ebp
  80022a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80022d:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800234:	8d 45 0c             	lea    0xc(%ebp),%eax
  800237:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80023a:	8b 45 08             	mov    0x8(%ebp),%eax
  80023d:	83 ec 08             	sub    $0x8,%esp
  800240:	ff 75 f4             	pushl  -0xc(%ebp)
  800243:	50                   	push   %eax
  800244:	e8 73 ff ff ff       	call   8001bc <vcprintf>
  800249:	83 c4 10             	add    $0x10,%esp
  80024c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80024f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800252:	c9                   	leave  
  800253:	c3                   	ret    

00800254 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800254:	55                   	push   %ebp
  800255:	89 e5                	mov    %esp,%ebp
  800257:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80025a:	e8 8e 0f 00 00       	call   8011ed <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80025f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800262:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800265:	8b 45 08             	mov    0x8(%ebp),%eax
  800268:	83 ec 08             	sub    $0x8,%esp
  80026b:	ff 75 f4             	pushl  -0xc(%ebp)
  80026e:	50                   	push   %eax
  80026f:	e8 48 ff ff ff       	call   8001bc <vcprintf>
  800274:	83 c4 10             	add    $0x10,%esp
  800277:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80027a:	e8 88 0f 00 00       	call   801207 <sys_enable_interrupt>
	return cnt;
  80027f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800282:	c9                   	leave  
  800283:	c3                   	ret    

00800284 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800284:	55                   	push   %ebp
  800285:	89 e5                	mov    %esp,%ebp
  800287:	53                   	push   %ebx
  800288:	83 ec 14             	sub    $0x14,%esp
  80028b:	8b 45 10             	mov    0x10(%ebp),%eax
  80028e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800291:	8b 45 14             	mov    0x14(%ebp),%eax
  800294:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800297:	8b 45 18             	mov    0x18(%ebp),%eax
  80029a:	ba 00 00 00 00       	mov    $0x0,%edx
  80029f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002a2:	77 55                	ja     8002f9 <printnum+0x75>
  8002a4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002a7:	72 05                	jb     8002ae <printnum+0x2a>
  8002a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002ac:	77 4b                	ja     8002f9 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002ae:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002b1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002b4:	8b 45 18             	mov    0x18(%ebp),%eax
  8002b7:	ba 00 00 00 00       	mov    $0x0,%edx
  8002bc:	52                   	push   %edx
  8002bd:	50                   	push   %eax
  8002be:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c1:	ff 75 f0             	pushl  -0x10(%ebp)
  8002c4:	e8 03 13 00 00       	call   8015cc <__udivdi3>
  8002c9:	83 c4 10             	add    $0x10,%esp
  8002cc:	83 ec 04             	sub    $0x4,%esp
  8002cf:	ff 75 20             	pushl  0x20(%ebp)
  8002d2:	53                   	push   %ebx
  8002d3:	ff 75 18             	pushl  0x18(%ebp)
  8002d6:	52                   	push   %edx
  8002d7:	50                   	push   %eax
  8002d8:	ff 75 0c             	pushl  0xc(%ebp)
  8002db:	ff 75 08             	pushl  0x8(%ebp)
  8002de:	e8 a1 ff ff ff       	call   800284 <printnum>
  8002e3:	83 c4 20             	add    $0x20,%esp
  8002e6:	eb 1a                	jmp    800302 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8002e8:	83 ec 08             	sub    $0x8,%esp
  8002eb:	ff 75 0c             	pushl  0xc(%ebp)
  8002ee:	ff 75 20             	pushl  0x20(%ebp)
  8002f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f4:	ff d0                	call   *%eax
  8002f6:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8002f9:	ff 4d 1c             	decl   0x1c(%ebp)
  8002fc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800300:	7f e6                	jg     8002e8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800302:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800305:	bb 00 00 00 00       	mov    $0x0,%ebx
  80030a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80030d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800310:	53                   	push   %ebx
  800311:	51                   	push   %ecx
  800312:	52                   	push   %edx
  800313:	50                   	push   %eax
  800314:	e8 c3 13 00 00       	call   8016dc <__umoddi3>
  800319:	83 c4 10             	add    $0x10,%esp
  80031c:	05 14 1b 80 00       	add    $0x801b14,%eax
  800321:	8a 00                	mov    (%eax),%al
  800323:	0f be c0             	movsbl %al,%eax
  800326:	83 ec 08             	sub    $0x8,%esp
  800329:	ff 75 0c             	pushl  0xc(%ebp)
  80032c:	50                   	push   %eax
  80032d:	8b 45 08             	mov    0x8(%ebp),%eax
  800330:	ff d0                	call   *%eax
  800332:	83 c4 10             	add    $0x10,%esp
}
  800335:	90                   	nop
  800336:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800339:	c9                   	leave  
  80033a:	c3                   	ret    

0080033b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80033b:	55                   	push   %ebp
  80033c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80033e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800342:	7e 1c                	jle    800360 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800344:	8b 45 08             	mov    0x8(%ebp),%eax
  800347:	8b 00                	mov    (%eax),%eax
  800349:	8d 50 08             	lea    0x8(%eax),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	89 10                	mov    %edx,(%eax)
  800351:	8b 45 08             	mov    0x8(%ebp),%eax
  800354:	8b 00                	mov    (%eax),%eax
  800356:	83 e8 08             	sub    $0x8,%eax
  800359:	8b 50 04             	mov    0x4(%eax),%edx
  80035c:	8b 00                	mov    (%eax),%eax
  80035e:	eb 40                	jmp    8003a0 <getuint+0x65>
	else if (lflag)
  800360:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800364:	74 1e                	je     800384 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	8b 00                	mov    (%eax),%eax
  80036b:	8d 50 04             	lea    0x4(%eax),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	89 10                	mov    %edx,(%eax)
  800373:	8b 45 08             	mov    0x8(%ebp),%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	83 e8 04             	sub    $0x4,%eax
  80037b:	8b 00                	mov    (%eax),%eax
  80037d:	ba 00 00 00 00       	mov    $0x0,%edx
  800382:	eb 1c                	jmp    8003a0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800384:	8b 45 08             	mov    0x8(%ebp),%eax
  800387:	8b 00                	mov    (%eax),%eax
  800389:	8d 50 04             	lea    0x4(%eax),%edx
  80038c:	8b 45 08             	mov    0x8(%ebp),%eax
  80038f:	89 10                	mov    %edx,(%eax)
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	8b 00                	mov    (%eax),%eax
  800396:	83 e8 04             	sub    $0x4,%eax
  800399:	8b 00                	mov    (%eax),%eax
  80039b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003a0:	5d                   	pop    %ebp
  8003a1:	c3                   	ret    

008003a2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003a2:	55                   	push   %ebp
  8003a3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003a5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003a9:	7e 1c                	jle    8003c7 <getint+0x25>
		return va_arg(*ap, long long);
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
  8003c5:	eb 38                	jmp    8003ff <getint+0x5d>
	else if (lflag)
  8003c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003cb:	74 1a                	je     8003e7 <getint+0x45>
		return va_arg(*ap, long);
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	8d 50 04             	lea    0x4(%eax),%edx
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	89 10                	mov    %edx,(%eax)
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	83 e8 04             	sub    $0x4,%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	99                   	cltd   
  8003e5:	eb 18                	jmp    8003ff <getint+0x5d>
	else
		return va_arg(*ap, int);
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	8d 50 04             	lea    0x4(%eax),%edx
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	89 10                	mov    %edx,(%eax)
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	83 e8 04             	sub    $0x4,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	99                   	cltd   
}
  8003ff:	5d                   	pop    %ebp
  800400:	c3                   	ret    

00800401 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800401:	55                   	push   %ebp
  800402:	89 e5                	mov    %esp,%ebp
  800404:	56                   	push   %esi
  800405:	53                   	push   %ebx
  800406:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800409:	eb 17                	jmp    800422 <vprintfmt+0x21>
			if (ch == '\0')
  80040b:	85 db                	test   %ebx,%ebx
  80040d:	0f 84 af 03 00 00    	je     8007c2 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800413:	83 ec 08             	sub    $0x8,%esp
  800416:	ff 75 0c             	pushl  0xc(%ebp)
  800419:	53                   	push   %ebx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	ff d0                	call   *%eax
  80041f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800422:	8b 45 10             	mov    0x10(%ebp),%eax
  800425:	8d 50 01             	lea    0x1(%eax),%edx
  800428:	89 55 10             	mov    %edx,0x10(%ebp)
  80042b:	8a 00                	mov    (%eax),%al
  80042d:	0f b6 d8             	movzbl %al,%ebx
  800430:	83 fb 25             	cmp    $0x25,%ebx
  800433:	75 d6                	jne    80040b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800435:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800439:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800440:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800447:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80044e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800455:	8b 45 10             	mov    0x10(%ebp),%eax
  800458:	8d 50 01             	lea    0x1(%eax),%edx
  80045b:	89 55 10             	mov    %edx,0x10(%ebp)
  80045e:	8a 00                	mov    (%eax),%al
  800460:	0f b6 d8             	movzbl %al,%ebx
  800463:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800466:	83 f8 55             	cmp    $0x55,%eax
  800469:	0f 87 2b 03 00 00    	ja     80079a <vprintfmt+0x399>
  80046f:	8b 04 85 38 1b 80 00 	mov    0x801b38(,%eax,4),%eax
  800476:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800478:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80047c:	eb d7                	jmp    800455 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80047e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800482:	eb d1                	jmp    800455 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800484:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80048b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80048e:	89 d0                	mov    %edx,%eax
  800490:	c1 e0 02             	shl    $0x2,%eax
  800493:	01 d0                	add    %edx,%eax
  800495:	01 c0                	add    %eax,%eax
  800497:	01 d8                	add    %ebx,%eax
  800499:	83 e8 30             	sub    $0x30,%eax
  80049c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80049f:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a2:	8a 00                	mov    (%eax),%al
  8004a4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004a7:	83 fb 2f             	cmp    $0x2f,%ebx
  8004aa:	7e 3e                	jle    8004ea <vprintfmt+0xe9>
  8004ac:	83 fb 39             	cmp    $0x39,%ebx
  8004af:	7f 39                	jg     8004ea <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004b1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004b4:	eb d5                	jmp    80048b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8004b9:	83 c0 04             	add    $0x4,%eax
  8004bc:	89 45 14             	mov    %eax,0x14(%ebp)
  8004bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c2:	83 e8 04             	sub    $0x4,%eax
  8004c5:	8b 00                	mov    (%eax),%eax
  8004c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004ca:	eb 1f                	jmp    8004eb <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004d0:	79 83                	jns    800455 <vprintfmt+0x54>
				width = 0;
  8004d2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004d9:	e9 77 ff ff ff       	jmp    800455 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8004de:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8004e5:	e9 6b ff ff ff       	jmp    800455 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8004ea:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8004eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004ef:	0f 89 60 ff ff ff    	jns    800455 <vprintfmt+0x54>
				width = precision, precision = -1;
  8004f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8004fb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800502:	e9 4e ff ff ff       	jmp    800455 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800507:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80050a:	e9 46 ff ff ff       	jmp    800455 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80050f:	8b 45 14             	mov    0x14(%ebp),%eax
  800512:	83 c0 04             	add    $0x4,%eax
  800515:	89 45 14             	mov    %eax,0x14(%ebp)
  800518:	8b 45 14             	mov    0x14(%ebp),%eax
  80051b:	83 e8 04             	sub    $0x4,%eax
  80051e:	8b 00                	mov    (%eax),%eax
  800520:	83 ec 08             	sub    $0x8,%esp
  800523:	ff 75 0c             	pushl  0xc(%ebp)
  800526:	50                   	push   %eax
  800527:	8b 45 08             	mov    0x8(%ebp),%eax
  80052a:	ff d0                	call   *%eax
  80052c:	83 c4 10             	add    $0x10,%esp
			break;
  80052f:	e9 89 02 00 00       	jmp    8007bd <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800534:	8b 45 14             	mov    0x14(%ebp),%eax
  800537:	83 c0 04             	add    $0x4,%eax
  80053a:	89 45 14             	mov    %eax,0x14(%ebp)
  80053d:	8b 45 14             	mov    0x14(%ebp),%eax
  800540:	83 e8 04             	sub    $0x4,%eax
  800543:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800545:	85 db                	test   %ebx,%ebx
  800547:	79 02                	jns    80054b <vprintfmt+0x14a>
				err = -err;
  800549:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80054b:	83 fb 64             	cmp    $0x64,%ebx
  80054e:	7f 0b                	jg     80055b <vprintfmt+0x15a>
  800550:	8b 34 9d 80 19 80 00 	mov    0x801980(,%ebx,4),%esi
  800557:	85 f6                	test   %esi,%esi
  800559:	75 19                	jne    800574 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80055b:	53                   	push   %ebx
  80055c:	68 25 1b 80 00       	push   $0x801b25
  800561:	ff 75 0c             	pushl  0xc(%ebp)
  800564:	ff 75 08             	pushl  0x8(%ebp)
  800567:	e8 5e 02 00 00       	call   8007ca <printfmt>
  80056c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80056f:	e9 49 02 00 00       	jmp    8007bd <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800574:	56                   	push   %esi
  800575:	68 2e 1b 80 00       	push   $0x801b2e
  80057a:	ff 75 0c             	pushl  0xc(%ebp)
  80057d:	ff 75 08             	pushl  0x8(%ebp)
  800580:	e8 45 02 00 00       	call   8007ca <printfmt>
  800585:	83 c4 10             	add    $0x10,%esp
			break;
  800588:	e9 30 02 00 00       	jmp    8007bd <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80058d:	8b 45 14             	mov    0x14(%ebp),%eax
  800590:	83 c0 04             	add    $0x4,%eax
  800593:	89 45 14             	mov    %eax,0x14(%ebp)
  800596:	8b 45 14             	mov    0x14(%ebp),%eax
  800599:	83 e8 04             	sub    $0x4,%eax
  80059c:	8b 30                	mov    (%eax),%esi
  80059e:	85 f6                	test   %esi,%esi
  8005a0:	75 05                	jne    8005a7 <vprintfmt+0x1a6>
				p = "(null)";
  8005a2:	be 31 1b 80 00       	mov    $0x801b31,%esi
			if (width > 0 && padc != '-')
  8005a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005ab:	7e 6d                	jle    80061a <vprintfmt+0x219>
  8005ad:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005b1:	74 67                	je     80061a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b6:	83 ec 08             	sub    $0x8,%esp
  8005b9:	50                   	push   %eax
  8005ba:	56                   	push   %esi
  8005bb:	e8 0c 03 00 00       	call   8008cc <strnlen>
  8005c0:	83 c4 10             	add    $0x10,%esp
  8005c3:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005c6:	eb 16                	jmp    8005de <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005c8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005cc:	83 ec 08             	sub    $0x8,%esp
  8005cf:	ff 75 0c             	pushl  0xc(%ebp)
  8005d2:	50                   	push   %eax
  8005d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d6:	ff d0                	call   *%eax
  8005d8:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005db:	ff 4d e4             	decl   -0x1c(%ebp)
  8005de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e2:	7f e4                	jg     8005c8 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8005e4:	eb 34                	jmp    80061a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8005e6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8005ea:	74 1c                	je     800608 <vprintfmt+0x207>
  8005ec:	83 fb 1f             	cmp    $0x1f,%ebx
  8005ef:	7e 05                	jle    8005f6 <vprintfmt+0x1f5>
  8005f1:	83 fb 7e             	cmp    $0x7e,%ebx
  8005f4:	7e 12                	jle    800608 <vprintfmt+0x207>
					putch('?', putdat);
  8005f6:	83 ec 08             	sub    $0x8,%esp
  8005f9:	ff 75 0c             	pushl  0xc(%ebp)
  8005fc:	6a 3f                	push   $0x3f
  8005fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800601:	ff d0                	call   *%eax
  800603:	83 c4 10             	add    $0x10,%esp
  800606:	eb 0f                	jmp    800617 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800608:	83 ec 08             	sub    $0x8,%esp
  80060b:	ff 75 0c             	pushl  0xc(%ebp)
  80060e:	53                   	push   %ebx
  80060f:	8b 45 08             	mov    0x8(%ebp),%eax
  800612:	ff d0                	call   *%eax
  800614:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800617:	ff 4d e4             	decl   -0x1c(%ebp)
  80061a:	89 f0                	mov    %esi,%eax
  80061c:	8d 70 01             	lea    0x1(%eax),%esi
  80061f:	8a 00                	mov    (%eax),%al
  800621:	0f be d8             	movsbl %al,%ebx
  800624:	85 db                	test   %ebx,%ebx
  800626:	74 24                	je     80064c <vprintfmt+0x24b>
  800628:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80062c:	78 b8                	js     8005e6 <vprintfmt+0x1e5>
  80062e:	ff 4d e0             	decl   -0x20(%ebp)
  800631:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800635:	79 af                	jns    8005e6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800637:	eb 13                	jmp    80064c <vprintfmt+0x24b>
				putch(' ', putdat);
  800639:	83 ec 08             	sub    $0x8,%esp
  80063c:	ff 75 0c             	pushl  0xc(%ebp)
  80063f:	6a 20                	push   $0x20
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	ff d0                	call   *%eax
  800646:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800649:	ff 4d e4             	decl   -0x1c(%ebp)
  80064c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800650:	7f e7                	jg     800639 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800652:	e9 66 01 00 00       	jmp    8007bd <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800657:	83 ec 08             	sub    $0x8,%esp
  80065a:	ff 75 e8             	pushl  -0x18(%ebp)
  80065d:	8d 45 14             	lea    0x14(%ebp),%eax
  800660:	50                   	push   %eax
  800661:	e8 3c fd ff ff       	call   8003a2 <getint>
  800666:	83 c4 10             	add    $0x10,%esp
  800669:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80066c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80066f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800672:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800675:	85 d2                	test   %edx,%edx
  800677:	79 23                	jns    80069c <vprintfmt+0x29b>
				putch('-', putdat);
  800679:	83 ec 08             	sub    $0x8,%esp
  80067c:	ff 75 0c             	pushl  0xc(%ebp)
  80067f:	6a 2d                	push   $0x2d
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	ff d0                	call   *%eax
  800686:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800689:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80068c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80068f:	f7 d8                	neg    %eax
  800691:	83 d2 00             	adc    $0x0,%edx
  800694:	f7 da                	neg    %edx
  800696:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800699:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80069c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006a3:	e9 bc 00 00 00       	jmp    800764 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006a8:	83 ec 08             	sub    $0x8,%esp
  8006ab:	ff 75 e8             	pushl  -0x18(%ebp)
  8006ae:	8d 45 14             	lea    0x14(%ebp),%eax
  8006b1:	50                   	push   %eax
  8006b2:	e8 84 fc ff ff       	call   80033b <getuint>
  8006b7:	83 c4 10             	add    $0x10,%esp
  8006ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006c0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006c7:	e9 98 00 00 00       	jmp    800764 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006cc:	83 ec 08             	sub    $0x8,%esp
  8006cf:	ff 75 0c             	pushl  0xc(%ebp)
  8006d2:	6a 58                	push   $0x58
  8006d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d7:	ff d0                	call   *%eax
  8006d9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006dc:	83 ec 08             	sub    $0x8,%esp
  8006df:	ff 75 0c             	pushl  0xc(%ebp)
  8006e2:	6a 58                	push   $0x58
  8006e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e7:	ff d0                	call   *%eax
  8006e9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 0c             	pushl  0xc(%ebp)
  8006f2:	6a 58                	push   $0x58
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	ff d0                	call   *%eax
  8006f9:	83 c4 10             	add    $0x10,%esp
			break;
  8006fc:	e9 bc 00 00 00       	jmp    8007bd <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 0c             	pushl  0xc(%ebp)
  800707:	6a 30                	push   $0x30
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	ff d0                	call   *%eax
  80070e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800711:	83 ec 08             	sub    $0x8,%esp
  800714:	ff 75 0c             	pushl  0xc(%ebp)
  800717:	6a 78                	push   $0x78
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	ff d0                	call   *%eax
  80071e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800721:	8b 45 14             	mov    0x14(%ebp),%eax
  800724:	83 c0 04             	add    $0x4,%eax
  800727:	89 45 14             	mov    %eax,0x14(%ebp)
  80072a:	8b 45 14             	mov    0x14(%ebp),%eax
  80072d:	83 e8 04             	sub    $0x4,%eax
  800730:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800732:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800735:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80073c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800743:	eb 1f                	jmp    800764 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800745:	83 ec 08             	sub    $0x8,%esp
  800748:	ff 75 e8             	pushl  -0x18(%ebp)
  80074b:	8d 45 14             	lea    0x14(%ebp),%eax
  80074e:	50                   	push   %eax
  80074f:	e8 e7 fb ff ff       	call   80033b <getuint>
  800754:	83 c4 10             	add    $0x10,%esp
  800757:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80075a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80075d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800764:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800768:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80076b:	83 ec 04             	sub    $0x4,%esp
  80076e:	52                   	push   %edx
  80076f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800772:	50                   	push   %eax
  800773:	ff 75 f4             	pushl  -0xc(%ebp)
  800776:	ff 75 f0             	pushl  -0x10(%ebp)
  800779:	ff 75 0c             	pushl  0xc(%ebp)
  80077c:	ff 75 08             	pushl  0x8(%ebp)
  80077f:	e8 00 fb ff ff       	call   800284 <printnum>
  800784:	83 c4 20             	add    $0x20,%esp
			break;
  800787:	eb 34                	jmp    8007bd <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800789:	83 ec 08             	sub    $0x8,%esp
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	53                   	push   %ebx
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	ff d0                	call   *%eax
  800795:	83 c4 10             	add    $0x10,%esp
			break;
  800798:	eb 23                	jmp    8007bd <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80079a:	83 ec 08             	sub    $0x8,%esp
  80079d:	ff 75 0c             	pushl  0xc(%ebp)
  8007a0:	6a 25                	push   $0x25
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	ff d0                	call   *%eax
  8007a7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007aa:	ff 4d 10             	decl   0x10(%ebp)
  8007ad:	eb 03                	jmp    8007b2 <vprintfmt+0x3b1>
  8007af:	ff 4d 10             	decl   0x10(%ebp)
  8007b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b5:	48                   	dec    %eax
  8007b6:	8a 00                	mov    (%eax),%al
  8007b8:	3c 25                	cmp    $0x25,%al
  8007ba:	75 f3                	jne    8007af <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007bc:	90                   	nop
		}
	}
  8007bd:	e9 47 fc ff ff       	jmp    800409 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007c2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007c3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007c6:	5b                   	pop    %ebx
  8007c7:	5e                   	pop    %esi
  8007c8:	5d                   	pop    %ebp
  8007c9:	c3                   	ret    

008007ca <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007ca:	55                   	push   %ebp
  8007cb:	89 e5                	mov    %esp,%ebp
  8007cd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007d0:	8d 45 10             	lea    0x10(%ebp),%eax
  8007d3:	83 c0 04             	add    $0x4,%eax
  8007d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8007dc:	ff 75 f4             	pushl  -0xc(%ebp)
  8007df:	50                   	push   %eax
  8007e0:	ff 75 0c             	pushl  0xc(%ebp)
  8007e3:	ff 75 08             	pushl  0x8(%ebp)
  8007e6:	e8 16 fc ff ff       	call   800401 <vprintfmt>
  8007eb:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8007ee:	90                   	nop
  8007ef:	c9                   	leave  
  8007f0:	c3                   	ret    

008007f1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8007f1:	55                   	push   %ebp
  8007f2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8007f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007f7:	8b 40 08             	mov    0x8(%eax),%eax
  8007fa:	8d 50 01             	lea    0x1(%eax),%edx
  8007fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800800:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800803:	8b 45 0c             	mov    0xc(%ebp),%eax
  800806:	8b 10                	mov    (%eax),%edx
  800808:	8b 45 0c             	mov    0xc(%ebp),%eax
  80080b:	8b 40 04             	mov    0x4(%eax),%eax
  80080e:	39 c2                	cmp    %eax,%edx
  800810:	73 12                	jae    800824 <sprintputch+0x33>
		*b->buf++ = ch;
  800812:	8b 45 0c             	mov    0xc(%ebp),%eax
  800815:	8b 00                	mov    (%eax),%eax
  800817:	8d 48 01             	lea    0x1(%eax),%ecx
  80081a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80081d:	89 0a                	mov    %ecx,(%edx)
  80081f:	8b 55 08             	mov    0x8(%ebp),%edx
  800822:	88 10                	mov    %dl,(%eax)
}
  800824:	90                   	nop
  800825:	5d                   	pop    %ebp
  800826:	c3                   	ret    

00800827 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800827:	55                   	push   %ebp
  800828:	89 e5                	mov    %esp,%ebp
  80082a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800833:	8b 45 0c             	mov    0xc(%ebp),%eax
  800836:	8d 50 ff             	lea    -0x1(%eax),%edx
  800839:	8b 45 08             	mov    0x8(%ebp),%eax
  80083c:	01 d0                	add    %edx,%eax
  80083e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800841:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800848:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80084c:	74 06                	je     800854 <vsnprintf+0x2d>
  80084e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800852:	7f 07                	jg     80085b <vsnprintf+0x34>
		return -E_INVAL;
  800854:	b8 03 00 00 00       	mov    $0x3,%eax
  800859:	eb 20                	jmp    80087b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80085b:	ff 75 14             	pushl  0x14(%ebp)
  80085e:	ff 75 10             	pushl  0x10(%ebp)
  800861:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800864:	50                   	push   %eax
  800865:	68 f1 07 80 00       	push   $0x8007f1
  80086a:	e8 92 fb ff ff       	call   800401 <vprintfmt>
  80086f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800872:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800875:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800878:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80087b:	c9                   	leave  
  80087c:	c3                   	ret    

0080087d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80087d:	55                   	push   %ebp
  80087e:	89 e5                	mov    %esp,%ebp
  800880:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800883:	8d 45 10             	lea    0x10(%ebp),%eax
  800886:	83 c0 04             	add    $0x4,%eax
  800889:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80088c:	8b 45 10             	mov    0x10(%ebp),%eax
  80088f:	ff 75 f4             	pushl  -0xc(%ebp)
  800892:	50                   	push   %eax
  800893:	ff 75 0c             	pushl  0xc(%ebp)
  800896:	ff 75 08             	pushl  0x8(%ebp)
  800899:	e8 89 ff ff ff       	call   800827 <vsnprintf>
  80089e:	83 c4 10             	add    $0x10,%esp
  8008a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008a7:	c9                   	leave  
  8008a8:	c3                   	ret    

008008a9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008a9:	55                   	push   %ebp
  8008aa:	89 e5                	mov    %esp,%ebp
  8008ac:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008b6:	eb 06                	jmp    8008be <strlen+0x15>
		n++;
  8008b8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008bb:	ff 45 08             	incl   0x8(%ebp)
  8008be:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c1:	8a 00                	mov    (%eax),%al
  8008c3:	84 c0                	test   %al,%al
  8008c5:	75 f1                	jne    8008b8 <strlen+0xf>
		n++;
	return n;
  8008c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008ca:	c9                   	leave  
  8008cb:	c3                   	ret    

008008cc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008cc:	55                   	push   %ebp
  8008cd:	89 e5                	mov    %esp,%ebp
  8008cf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008d9:	eb 09                	jmp    8008e4 <strnlen+0x18>
		n++;
  8008db:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008de:	ff 45 08             	incl   0x8(%ebp)
  8008e1:	ff 4d 0c             	decl   0xc(%ebp)
  8008e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e8:	74 09                	je     8008f3 <strnlen+0x27>
  8008ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ed:	8a 00                	mov    (%eax),%al
  8008ef:	84 c0                	test   %al,%al
  8008f1:	75 e8                	jne    8008db <strnlen+0xf>
		n++;
	return n;
  8008f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008f6:	c9                   	leave  
  8008f7:	c3                   	ret    

008008f8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8008f8:	55                   	push   %ebp
  8008f9:	89 e5                	mov    %esp,%ebp
  8008fb:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8008fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800901:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800904:	90                   	nop
  800905:	8b 45 08             	mov    0x8(%ebp),%eax
  800908:	8d 50 01             	lea    0x1(%eax),%edx
  80090b:	89 55 08             	mov    %edx,0x8(%ebp)
  80090e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800911:	8d 4a 01             	lea    0x1(%edx),%ecx
  800914:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800917:	8a 12                	mov    (%edx),%dl
  800919:	88 10                	mov    %dl,(%eax)
  80091b:	8a 00                	mov    (%eax),%al
  80091d:	84 c0                	test   %al,%al
  80091f:	75 e4                	jne    800905 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800921:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800924:	c9                   	leave  
  800925:	c3                   	ret    

00800926 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800926:	55                   	push   %ebp
  800927:	89 e5                	mov    %esp,%ebp
  800929:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800932:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800939:	eb 1f                	jmp    80095a <strncpy+0x34>
		*dst++ = *src;
  80093b:	8b 45 08             	mov    0x8(%ebp),%eax
  80093e:	8d 50 01             	lea    0x1(%eax),%edx
  800941:	89 55 08             	mov    %edx,0x8(%ebp)
  800944:	8b 55 0c             	mov    0xc(%ebp),%edx
  800947:	8a 12                	mov    (%edx),%dl
  800949:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80094b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094e:	8a 00                	mov    (%eax),%al
  800950:	84 c0                	test   %al,%al
  800952:	74 03                	je     800957 <strncpy+0x31>
			src++;
  800954:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800957:	ff 45 fc             	incl   -0x4(%ebp)
  80095a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80095d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800960:	72 d9                	jb     80093b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800962:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800965:	c9                   	leave  
  800966:	c3                   	ret    

00800967 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800967:	55                   	push   %ebp
  800968:	89 e5                	mov    %esp,%ebp
  80096a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80096d:	8b 45 08             	mov    0x8(%ebp),%eax
  800970:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800973:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800977:	74 30                	je     8009a9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800979:	eb 16                	jmp    800991 <strlcpy+0x2a>
			*dst++ = *src++;
  80097b:	8b 45 08             	mov    0x8(%ebp),%eax
  80097e:	8d 50 01             	lea    0x1(%eax),%edx
  800981:	89 55 08             	mov    %edx,0x8(%ebp)
  800984:	8b 55 0c             	mov    0xc(%ebp),%edx
  800987:	8d 4a 01             	lea    0x1(%edx),%ecx
  80098a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80098d:	8a 12                	mov    (%edx),%dl
  80098f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800991:	ff 4d 10             	decl   0x10(%ebp)
  800994:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800998:	74 09                	je     8009a3 <strlcpy+0x3c>
  80099a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099d:	8a 00                	mov    (%eax),%al
  80099f:	84 c0                	test   %al,%al
  8009a1:	75 d8                	jne    80097b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009a9:	8b 55 08             	mov    0x8(%ebp),%edx
  8009ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009af:	29 c2                	sub    %eax,%edx
  8009b1:	89 d0                	mov    %edx,%eax
}
  8009b3:	c9                   	leave  
  8009b4:	c3                   	ret    

008009b5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009b5:	55                   	push   %ebp
  8009b6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009b8:	eb 06                	jmp    8009c0 <strcmp+0xb>
		p++, q++;
  8009ba:	ff 45 08             	incl   0x8(%ebp)
  8009bd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	8a 00                	mov    (%eax),%al
  8009c5:	84 c0                	test   %al,%al
  8009c7:	74 0e                	je     8009d7 <strcmp+0x22>
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	8a 10                	mov    (%eax),%dl
  8009ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d1:	8a 00                	mov    (%eax),%al
  8009d3:	38 c2                	cmp    %al,%dl
  8009d5:	74 e3                	je     8009ba <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	8a 00                	mov    (%eax),%al
  8009dc:	0f b6 d0             	movzbl %al,%edx
  8009df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e2:	8a 00                	mov    (%eax),%al
  8009e4:	0f b6 c0             	movzbl %al,%eax
  8009e7:	29 c2                	sub    %eax,%edx
  8009e9:	89 d0                	mov    %edx,%eax
}
  8009eb:	5d                   	pop    %ebp
  8009ec:	c3                   	ret    

008009ed <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8009ed:	55                   	push   %ebp
  8009ee:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8009f0:	eb 09                	jmp    8009fb <strncmp+0xe>
		n--, p++, q++;
  8009f2:	ff 4d 10             	decl   0x10(%ebp)
  8009f5:	ff 45 08             	incl   0x8(%ebp)
  8009f8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8009fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ff:	74 17                	je     800a18 <strncmp+0x2b>
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	8a 00                	mov    (%eax),%al
  800a06:	84 c0                	test   %al,%al
  800a08:	74 0e                	je     800a18 <strncmp+0x2b>
  800a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0d:	8a 10                	mov    (%eax),%dl
  800a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a12:	8a 00                	mov    (%eax),%al
  800a14:	38 c2                	cmp    %al,%dl
  800a16:	74 da                	je     8009f2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a1c:	75 07                	jne    800a25 <strncmp+0x38>
		return 0;
  800a1e:	b8 00 00 00 00       	mov    $0x0,%eax
  800a23:	eb 14                	jmp    800a39 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a25:	8b 45 08             	mov    0x8(%ebp),%eax
  800a28:	8a 00                	mov    (%eax),%al
  800a2a:	0f b6 d0             	movzbl %al,%edx
  800a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a30:	8a 00                	mov    (%eax),%al
  800a32:	0f b6 c0             	movzbl %al,%eax
  800a35:	29 c2                	sub    %eax,%edx
  800a37:	89 d0                	mov    %edx,%eax
}
  800a39:	5d                   	pop    %ebp
  800a3a:	c3                   	ret    

00800a3b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a3b:	55                   	push   %ebp
  800a3c:	89 e5                	mov    %esp,%ebp
  800a3e:	83 ec 04             	sub    $0x4,%esp
  800a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a44:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a47:	eb 12                	jmp    800a5b <strchr+0x20>
		if (*s == c)
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	8a 00                	mov    (%eax),%al
  800a4e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a51:	75 05                	jne    800a58 <strchr+0x1d>
			return (char *) s;
  800a53:	8b 45 08             	mov    0x8(%ebp),%eax
  800a56:	eb 11                	jmp    800a69 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a58:	ff 45 08             	incl   0x8(%ebp)
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	8a 00                	mov    (%eax),%al
  800a60:	84 c0                	test   %al,%al
  800a62:	75 e5                	jne    800a49 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a64:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a69:	c9                   	leave  
  800a6a:	c3                   	ret    

00800a6b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a6b:	55                   	push   %ebp
  800a6c:	89 e5                	mov    %esp,%ebp
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a74:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a77:	eb 0d                	jmp    800a86 <strfind+0x1b>
		if (*s == c)
  800a79:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7c:	8a 00                	mov    (%eax),%al
  800a7e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a81:	74 0e                	je     800a91 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800a83:	ff 45 08             	incl   0x8(%ebp)
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	8a 00                	mov    (%eax),%al
  800a8b:	84 c0                	test   %al,%al
  800a8d:	75 ea                	jne    800a79 <strfind+0xe>
  800a8f:	eb 01                	jmp    800a92 <strfind+0x27>
		if (*s == c)
			break;
  800a91:	90                   	nop
	return (char *) s;
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800a95:	c9                   	leave  
  800a96:	c3                   	ret    

00800a97 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800a97:	55                   	push   %ebp
  800a98:	89 e5                	mov    %esp,%ebp
  800a9a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800aa3:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800aa9:	eb 0e                	jmp    800ab9 <memset+0x22>
		*p++ = c;
  800aab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aae:	8d 50 01             	lea    0x1(%eax),%edx
  800ab1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ab4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ab7:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ab9:	ff 4d f8             	decl   -0x8(%ebp)
  800abc:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ac0:	79 e9                	jns    800aab <memset+0x14>
		*p++ = c;

	return v;
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ac5:	c9                   	leave  
  800ac6:	c3                   	ret    

00800ac7 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ac7:	55                   	push   %ebp
  800ac8:	89 e5                	mov    %esp,%ebp
  800aca:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800acd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ad9:	eb 16                	jmp    800af1 <memcpy+0x2a>
		*d++ = *s++;
  800adb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ade:	8d 50 01             	lea    0x1(%eax),%edx
  800ae1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ae4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ae7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800aea:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800aed:	8a 12                	mov    (%edx),%dl
  800aef:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800af1:	8b 45 10             	mov    0x10(%ebp),%eax
  800af4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800af7:	89 55 10             	mov    %edx,0x10(%ebp)
  800afa:	85 c0                	test   %eax,%eax
  800afc:	75 dd                	jne    800adb <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b01:	c9                   	leave  
  800b02:	c3                   	ret    

00800b03 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b03:	55                   	push   %ebp
  800b04:	89 e5                	mov    %esp,%ebp
  800b06:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b15:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b18:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b1b:	73 50                	jae    800b6d <memmove+0x6a>
  800b1d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b20:	8b 45 10             	mov    0x10(%ebp),%eax
  800b23:	01 d0                	add    %edx,%eax
  800b25:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b28:	76 43                	jbe    800b6d <memmove+0x6a>
		s += n;
  800b2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b30:	8b 45 10             	mov    0x10(%ebp),%eax
  800b33:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b36:	eb 10                	jmp    800b48 <memmove+0x45>
			*--d = *--s;
  800b38:	ff 4d f8             	decl   -0x8(%ebp)
  800b3b:	ff 4d fc             	decl   -0x4(%ebp)
  800b3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b41:	8a 10                	mov    (%eax),%dl
  800b43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b46:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b48:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b4e:	89 55 10             	mov    %edx,0x10(%ebp)
  800b51:	85 c0                	test   %eax,%eax
  800b53:	75 e3                	jne    800b38 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b55:	eb 23                	jmp    800b7a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b57:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b5a:	8d 50 01             	lea    0x1(%eax),%edx
  800b5d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b60:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b63:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b66:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b69:	8a 12                	mov    (%edx),%dl
  800b6b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b70:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b73:	89 55 10             	mov    %edx,0x10(%ebp)
  800b76:	85 c0                	test   %eax,%eax
  800b78:	75 dd                	jne    800b57 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b7d:	c9                   	leave  
  800b7e:	c3                   	ret    

00800b7f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800b7f:	55                   	push   %ebp
  800b80:	89 e5                	mov    %esp,%ebp
  800b82:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800b91:	eb 2a                	jmp    800bbd <memcmp+0x3e>
		if (*s1 != *s2)
  800b93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b96:	8a 10                	mov    (%eax),%dl
  800b98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b9b:	8a 00                	mov    (%eax),%al
  800b9d:	38 c2                	cmp    %al,%dl
  800b9f:	74 16                	je     800bb7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ba1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba4:	8a 00                	mov    (%eax),%al
  800ba6:	0f b6 d0             	movzbl %al,%edx
  800ba9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bac:	8a 00                	mov    (%eax),%al
  800bae:	0f b6 c0             	movzbl %al,%eax
  800bb1:	29 c2                	sub    %eax,%edx
  800bb3:	89 d0                	mov    %edx,%eax
  800bb5:	eb 18                	jmp    800bcf <memcmp+0x50>
		s1++, s2++;
  800bb7:	ff 45 fc             	incl   -0x4(%ebp)
  800bba:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc3:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc6:	85 c0                	test   %eax,%eax
  800bc8:	75 c9                	jne    800b93 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bd7:	8b 55 08             	mov    0x8(%ebp),%edx
  800bda:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdd:	01 d0                	add    %edx,%eax
  800bdf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800be2:	eb 15                	jmp    800bf9 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	8a 00                	mov    (%eax),%al
  800be9:	0f b6 d0             	movzbl %al,%edx
  800bec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bef:	0f b6 c0             	movzbl %al,%eax
  800bf2:	39 c2                	cmp    %eax,%edx
  800bf4:	74 0d                	je     800c03 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800bf6:	ff 45 08             	incl   0x8(%ebp)
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800bff:	72 e3                	jb     800be4 <memfind+0x13>
  800c01:	eb 01                	jmp    800c04 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c03:	90                   	nop
	return (void *) s;
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c07:	c9                   	leave  
  800c08:	c3                   	ret    

00800c09 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
  800c0c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c16:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c1d:	eb 03                	jmp    800c22 <strtol+0x19>
		s++;
  800c1f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c22:	8b 45 08             	mov    0x8(%ebp),%eax
  800c25:	8a 00                	mov    (%eax),%al
  800c27:	3c 20                	cmp    $0x20,%al
  800c29:	74 f4                	je     800c1f <strtol+0x16>
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	8a 00                	mov    (%eax),%al
  800c30:	3c 09                	cmp    $0x9,%al
  800c32:	74 eb                	je     800c1f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	8a 00                	mov    (%eax),%al
  800c39:	3c 2b                	cmp    $0x2b,%al
  800c3b:	75 05                	jne    800c42 <strtol+0x39>
		s++;
  800c3d:	ff 45 08             	incl   0x8(%ebp)
  800c40:	eb 13                	jmp    800c55 <strtol+0x4c>
	else if (*s == '-')
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	8a 00                	mov    (%eax),%al
  800c47:	3c 2d                	cmp    $0x2d,%al
  800c49:	75 0a                	jne    800c55 <strtol+0x4c>
		s++, neg = 1;
  800c4b:	ff 45 08             	incl   0x8(%ebp)
  800c4e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c59:	74 06                	je     800c61 <strtol+0x58>
  800c5b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c5f:	75 20                	jne    800c81 <strtol+0x78>
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	8a 00                	mov    (%eax),%al
  800c66:	3c 30                	cmp    $0x30,%al
  800c68:	75 17                	jne    800c81 <strtol+0x78>
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	40                   	inc    %eax
  800c6e:	8a 00                	mov    (%eax),%al
  800c70:	3c 78                	cmp    $0x78,%al
  800c72:	75 0d                	jne    800c81 <strtol+0x78>
		s += 2, base = 16;
  800c74:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c78:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800c7f:	eb 28                	jmp    800ca9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800c81:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c85:	75 15                	jne    800c9c <strtol+0x93>
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	3c 30                	cmp    $0x30,%al
  800c8e:	75 0c                	jne    800c9c <strtol+0x93>
		s++, base = 8;
  800c90:	ff 45 08             	incl   0x8(%ebp)
  800c93:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800c9a:	eb 0d                	jmp    800ca9 <strtol+0xa0>
	else if (base == 0)
  800c9c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca0:	75 07                	jne    800ca9 <strtol+0xa0>
		base = 10;
  800ca2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	3c 2f                	cmp    $0x2f,%al
  800cb0:	7e 19                	jle    800ccb <strtol+0xc2>
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	3c 39                	cmp    $0x39,%al
  800cb9:	7f 10                	jg     800ccb <strtol+0xc2>
			dig = *s - '0';
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	0f be c0             	movsbl %al,%eax
  800cc3:	83 e8 30             	sub    $0x30,%eax
  800cc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cc9:	eb 42                	jmp    800d0d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	3c 60                	cmp    $0x60,%al
  800cd2:	7e 19                	jle    800ced <strtol+0xe4>
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8a 00                	mov    (%eax),%al
  800cd9:	3c 7a                	cmp    $0x7a,%al
  800cdb:	7f 10                	jg     800ced <strtol+0xe4>
			dig = *s - 'a' + 10;
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	0f be c0             	movsbl %al,%eax
  800ce5:	83 e8 57             	sub    $0x57,%eax
  800ce8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ceb:	eb 20                	jmp    800d0d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	3c 40                	cmp    $0x40,%al
  800cf4:	7e 39                	jle    800d2f <strtol+0x126>
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	8a 00                	mov    (%eax),%al
  800cfb:	3c 5a                	cmp    $0x5a,%al
  800cfd:	7f 30                	jg     800d2f <strtol+0x126>
			dig = *s - 'A' + 10;
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	0f be c0             	movsbl %al,%eax
  800d07:	83 e8 37             	sub    $0x37,%eax
  800d0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d10:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d13:	7d 19                	jge    800d2e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d15:	ff 45 08             	incl   0x8(%ebp)
  800d18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d1b:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d1f:	89 c2                	mov    %eax,%edx
  800d21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d24:	01 d0                	add    %edx,%eax
  800d26:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d29:	e9 7b ff ff ff       	jmp    800ca9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d2e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d2f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d33:	74 08                	je     800d3d <strtol+0x134>
		*endptr = (char *) s;
  800d35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d38:	8b 55 08             	mov    0x8(%ebp),%edx
  800d3b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d3d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d41:	74 07                	je     800d4a <strtol+0x141>
  800d43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d46:	f7 d8                	neg    %eax
  800d48:	eb 03                	jmp    800d4d <strtol+0x144>
  800d4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d4d:	c9                   	leave  
  800d4e:	c3                   	ret    

00800d4f <ltostr>:

void
ltostr(long value, char *str)
{
  800d4f:	55                   	push   %ebp
  800d50:	89 e5                	mov    %esp,%ebp
  800d52:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d55:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d5c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d63:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d67:	79 13                	jns    800d7c <ltostr+0x2d>
	{
		neg = 1;
  800d69:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d73:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d76:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d79:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800d84:	99                   	cltd   
  800d85:	f7 f9                	idiv   %ecx
  800d87:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800d8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8d:	8d 50 01             	lea    0x1(%eax),%edx
  800d90:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d93:	89 c2                	mov    %eax,%edx
  800d95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d98:	01 d0                	add    %edx,%eax
  800d9a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d9d:	83 c2 30             	add    $0x30,%edx
  800da0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800da2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800da5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800daa:	f7 e9                	imul   %ecx
  800dac:	c1 fa 02             	sar    $0x2,%edx
  800daf:	89 c8                	mov    %ecx,%eax
  800db1:	c1 f8 1f             	sar    $0x1f,%eax
  800db4:	29 c2                	sub    %eax,%edx
  800db6:	89 d0                	mov    %edx,%eax
  800db8:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dbb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dbe:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dc3:	f7 e9                	imul   %ecx
  800dc5:	c1 fa 02             	sar    $0x2,%edx
  800dc8:	89 c8                	mov    %ecx,%eax
  800dca:	c1 f8 1f             	sar    $0x1f,%eax
  800dcd:	29 c2                	sub    %eax,%edx
  800dcf:	89 d0                	mov    %edx,%eax
  800dd1:	c1 e0 02             	shl    $0x2,%eax
  800dd4:	01 d0                	add    %edx,%eax
  800dd6:	01 c0                	add    %eax,%eax
  800dd8:	29 c1                	sub    %eax,%ecx
  800dda:	89 ca                	mov    %ecx,%edx
  800ddc:	85 d2                	test   %edx,%edx
  800dde:	75 9c                	jne    800d7c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800de0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800de7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dea:	48                   	dec    %eax
  800deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800dee:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800df2:	74 3d                	je     800e31 <ltostr+0xe2>
		start = 1 ;
  800df4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800dfb:	eb 34                	jmp    800e31 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800dfd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e03:	01 d0                	add    %edx,%eax
  800e05:	8a 00                	mov    (%eax),%al
  800e07:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e10:	01 c2                	add    %eax,%edx
  800e12:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e18:	01 c8                	add    %ecx,%eax
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e1e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	01 c2                	add    %eax,%edx
  800e26:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e29:	88 02                	mov    %al,(%edx)
		start++ ;
  800e2b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e2e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e34:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e37:	7c c4                	jl     800dfd <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e39:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3f:	01 d0                	add    %edx,%eax
  800e41:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e44:	90                   	nop
  800e45:	c9                   	leave  
  800e46:	c3                   	ret    

00800e47 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e47:	55                   	push   %ebp
  800e48:	89 e5                	mov    %esp,%ebp
  800e4a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e4d:	ff 75 08             	pushl  0x8(%ebp)
  800e50:	e8 54 fa ff ff       	call   8008a9 <strlen>
  800e55:	83 c4 04             	add    $0x4,%esp
  800e58:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e5b:	ff 75 0c             	pushl  0xc(%ebp)
  800e5e:	e8 46 fa ff ff       	call   8008a9 <strlen>
  800e63:	83 c4 04             	add    $0x4,%esp
  800e66:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e69:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e77:	eb 17                	jmp    800e90 <strcconcat+0x49>
		final[s] = str1[s] ;
  800e79:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7f:	01 c2                	add    %eax,%edx
  800e81:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	01 c8                	add    %ecx,%eax
  800e89:	8a 00                	mov    (%eax),%al
  800e8b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800e8d:	ff 45 fc             	incl   -0x4(%ebp)
  800e90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e93:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e96:	7c e1                	jl     800e79 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800e98:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800e9f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ea6:	eb 1f                	jmp    800ec7 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ea8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eab:	8d 50 01             	lea    0x1(%eax),%edx
  800eae:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eb1:	89 c2                	mov    %eax,%edx
  800eb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb6:	01 c2                	add    %eax,%edx
  800eb8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebe:	01 c8                	add    %ecx,%eax
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ec4:	ff 45 f8             	incl   -0x8(%ebp)
  800ec7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eca:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ecd:	7c d9                	jl     800ea8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ecf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed5:	01 d0                	add    %edx,%eax
  800ed7:	c6 00 00             	movb   $0x0,(%eax)
}
  800eda:	90                   	nop
  800edb:	c9                   	leave  
  800edc:	c3                   	ret    

00800edd <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800edd:	55                   	push   %ebp
  800ede:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800ee0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ee9:	8b 45 14             	mov    0x14(%ebp),%eax
  800eec:	8b 00                	mov    (%eax),%eax
  800eee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ef5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef8:	01 d0                	add    %edx,%eax
  800efa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f00:	eb 0c                	jmp    800f0e <strsplit+0x31>
			*string++ = 0;
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	8d 50 01             	lea    0x1(%eax),%edx
  800f08:	89 55 08             	mov    %edx,0x8(%ebp)
  800f0b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	84 c0                	test   %al,%al
  800f15:	74 18                	je     800f2f <strsplit+0x52>
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	0f be c0             	movsbl %al,%eax
  800f1f:	50                   	push   %eax
  800f20:	ff 75 0c             	pushl  0xc(%ebp)
  800f23:	e8 13 fb ff ff       	call   800a3b <strchr>
  800f28:	83 c4 08             	add    $0x8,%esp
  800f2b:	85 c0                	test   %eax,%eax
  800f2d:	75 d3                	jne    800f02 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	84 c0                	test   %al,%al
  800f36:	74 5a                	je     800f92 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f38:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3b:	8b 00                	mov    (%eax),%eax
  800f3d:	83 f8 0f             	cmp    $0xf,%eax
  800f40:	75 07                	jne    800f49 <strsplit+0x6c>
		{
			return 0;
  800f42:	b8 00 00 00 00       	mov    $0x0,%eax
  800f47:	eb 66                	jmp    800faf <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f49:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4c:	8b 00                	mov    (%eax),%eax
  800f4e:	8d 48 01             	lea    0x1(%eax),%ecx
  800f51:	8b 55 14             	mov    0x14(%ebp),%edx
  800f54:	89 0a                	mov    %ecx,(%edx)
  800f56:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f60:	01 c2                	add    %eax,%edx
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f67:	eb 03                	jmp    800f6c <strsplit+0x8f>
			string++;
  800f69:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	84 c0                	test   %al,%al
  800f73:	74 8b                	je     800f00 <strsplit+0x23>
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	0f be c0             	movsbl %al,%eax
  800f7d:	50                   	push   %eax
  800f7e:	ff 75 0c             	pushl  0xc(%ebp)
  800f81:	e8 b5 fa ff ff       	call   800a3b <strchr>
  800f86:	83 c4 08             	add    $0x8,%esp
  800f89:	85 c0                	test   %eax,%eax
  800f8b:	74 dc                	je     800f69 <strsplit+0x8c>
			string++;
	}
  800f8d:	e9 6e ff ff ff       	jmp    800f00 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800f92:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800f93:	8b 45 14             	mov    0x14(%ebp),%eax
  800f96:	8b 00                	mov    (%eax),%eax
  800f98:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa2:	01 d0                	add    %edx,%eax
  800fa4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800faa:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800faf:	c9                   	leave  
  800fb0:	c3                   	ret    

00800fb1 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fb1:	55                   	push   %ebp
  800fb2:	89 e5                	mov    %esp,%ebp
  800fb4:	57                   	push   %edi
  800fb5:	56                   	push   %esi
  800fb6:	53                   	push   %ebx
  800fb7:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fc0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fc3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fc6:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fc9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fcc:	cd 30                	int    $0x30
  800fce:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800fd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fd4:	83 c4 10             	add    $0x10,%esp
  800fd7:	5b                   	pop    %ebx
  800fd8:	5e                   	pop    %esi
  800fd9:	5f                   	pop    %edi
  800fda:	5d                   	pop    %ebp
  800fdb:	c3                   	ret    

00800fdc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800fdc:	55                   	push   %ebp
  800fdd:	89 e5                	mov    %esp,%ebp
  800fdf:	83 ec 04             	sub    $0x4,%esp
  800fe2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  800fe8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	6a 00                	push   $0x0
  800ff1:	6a 00                	push   $0x0
  800ff3:	52                   	push   %edx
  800ff4:	ff 75 0c             	pushl  0xc(%ebp)
  800ff7:	50                   	push   %eax
  800ff8:	6a 00                	push   $0x0
  800ffa:	e8 b2 ff ff ff       	call   800fb1 <syscall>
  800fff:	83 c4 18             	add    $0x18,%esp
}
  801002:	90                   	nop
  801003:	c9                   	leave  
  801004:	c3                   	ret    

00801005 <sys_cgetc>:

int
sys_cgetc(void)
{
  801005:	55                   	push   %ebp
  801006:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801008:	6a 00                	push   $0x0
  80100a:	6a 00                	push   $0x0
  80100c:	6a 00                	push   $0x0
  80100e:	6a 00                	push   $0x0
  801010:	6a 00                	push   $0x0
  801012:	6a 01                	push   $0x1
  801014:	e8 98 ff ff ff       	call   800fb1 <syscall>
  801019:	83 c4 18             	add    $0x18,%esp
}
  80101c:	c9                   	leave  
  80101d:	c3                   	ret    

0080101e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80101e:	55                   	push   %ebp
  80101f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	6a 00                	push   $0x0
  801026:	6a 00                	push   $0x0
  801028:	6a 00                	push   $0x0
  80102a:	6a 00                	push   $0x0
  80102c:	50                   	push   %eax
  80102d:	6a 05                	push   $0x5
  80102f:	e8 7d ff ff ff       	call   800fb1 <syscall>
  801034:	83 c4 18             	add    $0x18,%esp
}
  801037:	c9                   	leave  
  801038:	c3                   	ret    

00801039 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801039:	55                   	push   %ebp
  80103a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80103c:	6a 00                	push   $0x0
  80103e:	6a 00                	push   $0x0
  801040:	6a 00                	push   $0x0
  801042:	6a 00                	push   $0x0
  801044:	6a 00                	push   $0x0
  801046:	6a 02                	push   $0x2
  801048:	e8 64 ff ff ff       	call   800fb1 <syscall>
  80104d:	83 c4 18             	add    $0x18,%esp
}
  801050:	c9                   	leave  
  801051:	c3                   	ret    

00801052 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801052:	55                   	push   %ebp
  801053:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801055:	6a 00                	push   $0x0
  801057:	6a 00                	push   $0x0
  801059:	6a 00                	push   $0x0
  80105b:	6a 00                	push   $0x0
  80105d:	6a 00                	push   $0x0
  80105f:	6a 03                	push   $0x3
  801061:	e8 4b ff ff ff       	call   800fb1 <syscall>
  801066:	83 c4 18             	add    $0x18,%esp
}
  801069:	c9                   	leave  
  80106a:	c3                   	ret    

0080106b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80106b:	55                   	push   %ebp
  80106c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80106e:	6a 00                	push   $0x0
  801070:	6a 00                	push   $0x0
  801072:	6a 00                	push   $0x0
  801074:	6a 00                	push   $0x0
  801076:	6a 00                	push   $0x0
  801078:	6a 04                	push   $0x4
  80107a:	e8 32 ff ff ff       	call   800fb1 <syscall>
  80107f:	83 c4 18             	add    $0x18,%esp
}
  801082:	c9                   	leave  
  801083:	c3                   	ret    

00801084 <sys_env_exit>:


void sys_env_exit(void)
{
  801084:	55                   	push   %ebp
  801085:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801087:	6a 00                	push   $0x0
  801089:	6a 00                	push   $0x0
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	6a 06                	push   $0x6
  801093:	e8 19 ff ff ff       	call   800fb1 <syscall>
  801098:	83 c4 18             	add    $0x18,%esp
}
  80109b:	90                   	nop
  80109c:	c9                   	leave  
  80109d:	c3                   	ret    

0080109e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80109e:	55                   	push   %ebp
  80109f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 00                	push   $0x0
  8010ad:	52                   	push   %edx
  8010ae:	50                   	push   %eax
  8010af:	6a 07                	push   $0x7
  8010b1:	e8 fb fe ff ff       	call   800fb1 <syscall>
  8010b6:	83 c4 18             	add    $0x18,%esp
}
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
  8010be:	56                   	push   %esi
  8010bf:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010c0:	8b 75 18             	mov    0x18(%ebp),%esi
  8010c3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cf:	56                   	push   %esi
  8010d0:	53                   	push   %ebx
  8010d1:	51                   	push   %ecx
  8010d2:	52                   	push   %edx
  8010d3:	50                   	push   %eax
  8010d4:	6a 08                	push   $0x8
  8010d6:	e8 d6 fe ff ff       	call   800fb1 <syscall>
  8010db:	83 c4 18             	add    $0x18,%esp
}
  8010de:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010e1:	5b                   	pop    %ebx
  8010e2:	5e                   	pop    %esi
  8010e3:	5d                   	pop    %ebp
  8010e4:	c3                   	ret    

008010e5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8010e5:	55                   	push   %ebp
  8010e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8010e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	6a 00                	push   $0x0
  8010f4:	52                   	push   %edx
  8010f5:	50                   	push   %eax
  8010f6:	6a 09                	push   $0x9
  8010f8:	e8 b4 fe ff ff       	call   800fb1 <syscall>
  8010fd:	83 c4 18             	add    $0x18,%esp
}
  801100:	c9                   	leave  
  801101:	c3                   	ret    

00801102 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801102:	55                   	push   %ebp
  801103:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801105:	6a 00                	push   $0x0
  801107:	6a 00                	push   $0x0
  801109:	6a 00                	push   $0x0
  80110b:	ff 75 0c             	pushl  0xc(%ebp)
  80110e:	ff 75 08             	pushl  0x8(%ebp)
  801111:	6a 0a                	push   $0xa
  801113:	e8 99 fe ff ff       	call   800fb1 <syscall>
  801118:	83 c4 18             	add    $0x18,%esp
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801120:	6a 00                	push   $0x0
  801122:	6a 00                	push   $0x0
  801124:	6a 00                	push   $0x0
  801126:	6a 00                	push   $0x0
  801128:	6a 00                	push   $0x0
  80112a:	6a 0b                	push   $0xb
  80112c:	e8 80 fe ff ff       	call   800fb1 <syscall>
  801131:	83 c4 18             	add    $0x18,%esp
}
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801139:	6a 00                	push   $0x0
  80113b:	6a 00                	push   $0x0
  80113d:	6a 00                	push   $0x0
  80113f:	6a 00                	push   $0x0
  801141:	6a 00                	push   $0x0
  801143:	6a 0c                	push   $0xc
  801145:	e8 67 fe ff ff       	call   800fb1 <syscall>
  80114a:	83 c4 18             	add    $0x18,%esp
}
  80114d:	c9                   	leave  
  80114e:	c3                   	ret    

0080114f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80114f:	55                   	push   %ebp
  801150:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801152:	6a 00                	push   $0x0
  801154:	6a 00                	push   $0x0
  801156:	6a 00                	push   $0x0
  801158:	6a 00                	push   $0x0
  80115a:	6a 00                	push   $0x0
  80115c:	6a 0d                	push   $0xd
  80115e:	e8 4e fe ff ff       	call   800fb1 <syscall>
  801163:	83 c4 18             	add    $0x18,%esp
}
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80116b:	6a 00                	push   $0x0
  80116d:	6a 00                	push   $0x0
  80116f:	6a 00                	push   $0x0
  801171:	ff 75 0c             	pushl  0xc(%ebp)
  801174:	ff 75 08             	pushl  0x8(%ebp)
  801177:	6a 11                	push   $0x11
  801179:	e8 33 fe ff ff       	call   800fb1 <syscall>
  80117e:	83 c4 18             	add    $0x18,%esp
	return;
  801181:	90                   	nop
}
  801182:	c9                   	leave  
  801183:	c3                   	ret    

00801184 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801184:	55                   	push   %ebp
  801185:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801187:	6a 00                	push   $0x0
  801189:	6a 00                	push   $0x0
  80118b:	6a 00                	push   $0x0
  80118d:	ff 75 0c             	pushl  0xc(%ebp)
  801190:	ff 75 08             	pushl  0x8(%ebp)
  801193:	6a 12                	push   $0x12
  801195:	e8 17 fe ff ff       	call   800fb1 <syscall>
  80119a:	83 c4 18             	add    $0x18,%esp
	return ;
  80119d:	90                   	nop
}
  80119e:	c9                   	leave  
  80119f:	c3                   	ret    

008011a0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011a0:	55                   	push   %ebp
  8011a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	6a 00                	push   $0x0
  8011a9:	6a 00                	push   $0x0
  8011ab:	6a 00                	push   $0x0
  8011ad:	6a 0e                	push   $0xe
  8011af:	e8 fd fd ff ff       	call   800fb1 <syscall>
  8011b4:	83 c4 18             	add    $0x18,%esp
}
  8011b7:	c9                   	leave  
  8011b8:	c3                   	ret    

008011b9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011b9:	55                   	push   %ebp
  8011ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 00                	push   $0x0
  8011c4:	ff 75 08             	pushl  0x8(%ebp)
  8011c7:	6a 0f                	push   $0xf
  8011c9:	e8 e3 fd ff ff       	call   800fb1 <syscall>
  8011ce:	83 c4 18             	add    $0x18,%esp
}
  8011d1:	c9                   	leave  
  8011d2:	c3                   	ret    

008011d3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011d3:	55                   	push   %ebp
  8011d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 00                	push   $0x0
  8011de:	6a 00                	push   $0x0
  8011e0:	6a 10                	push   $0x10
  8011e2:	e8 ca fd ff ff       	call   800fb1 <syscall>
  8011e7:	83 c4 18             	add    $0x18,%esp
}
  8011ea:	90                   	nop
  8011eb:	c9                   	leave  
  8011ec:	c3                   	ret    

008011ed <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8011ed:	55                   	push   %ebp
  8011ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 14                	push   $0x14
  8011fc:	e8 b0 fd ff ff       	call   800fb1 <syscall>
  801201:	83 c4 18             	add    $0x18,%esp
}
  801204:	90                   	nop
  801205:	c9                   	leave  
  801206:	c3                   	ret    

00801207 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 00                	push   $0x0
  801210:	6a 00                	push   $0x0
  801212:	6a 00                	push   $0x0
  801214:	6a 15                	push   $0x15
  801216:	e8 96 fd ff ff       	call   800fb1 <syscall>
  80121b:	83 c4 18             	add    $0x18,%esp
}
  80121e:	90                   	nop
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <sys_cputc>:


void
sys_cputc(const char c)
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
  801224:	83 ec 04             	sub    $0x4,%esp
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
  80122a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80122d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	50                   	push   %eax
  80123a:	6a 16                	push   $0x16
  80123c:	e8 70 fd ff ff       	call   800fb1 <syscall>
  801241:	83 c4 18             	add    $0x18,%esp
}
  801244:	90                   	nop
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 17                	push   $0x17
  801256:	e8 56 fd ff ff       	call   800fb1 <syscall>
  80125b:	83 c4 18             	add    $0x18,%esp
}
  80125e:	90                   	nop
  80125f:	c9                   	leave  
  801260:	c3                   	ret    

00801261 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801261:	55                   	push   %ebp
  801262:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	ff 75 0c             	pushl  0xc(%ebp)
  801270:	50                   	push   %eax
  801271:	6a 18                	push   $0x18
  801273:	e8 39 fd ff ff       	call   800fb1 <syscall>
  801278:	83 c4 18             	add    $0x18,%esp
}
  80127b:	c9                   	leave  
  80127c:	c3                   	ret    

0080127d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80127d:	55                   	push   %ebp
  80127e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801280:	8b 55 0c             	mov    0xc(%ebp),%edx
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	6a 00                	push   $0x0
  80128c:	52                   	push   %edx
  80128d:	50                   	push   %eax
  80128e:	6a 1b                	push   $0x1b
  801290:	e8 1c fd ff ff       	call   800fb1 <syscall>
  801295:	83 c4 18             	add    $0x18,%esp
}
  801298:	c9                   	leave  
  801299:	c3                   	ret    

0080129a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80129a:	55                   	push   %ebp
  80129b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80129d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	52                   	push   %edx
  8012aa:	50                   	push   %eax
  8012ab:	6a 19                	push   $0x19
  8012ad:	e8 ff fc ff ff       	call   800fb1 <syscall>
  8012b2:	83 c4 18             	add    $0x18,%esp
}
  8012b5:	90                   	nop
  8012b6:	c9                   	leave  
  8012b7:	c3                   	ret    

008012b8 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012b8:	55                   	push   %ebp
  8012b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	52                   	push   %edx
  8012c8:	50                   	push   %eax
  8012c9:	6a 1a                	push   $0x1a
  8012cb:	e8 e1 fc ff ff       	call   800fb1 <syscall>
  8012d0:	83 c4 18             	add    $0x18,%esp
}
  8012d3:	90                   	nop
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
  8012d9:	83 ec 04             	sub    $0x4,%esp
  8012dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012df:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8012e2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012e5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	6a 00                	push   $0x0
  8012ee:	51                   	push   %ecx
  8012ef:	52                   	push   %edx
  8012f0:	ff 75 0c             	pushl  0xc(%ebp)
  8012f3:	50                   	push   %eax
  8012f4:	6a 1c                	push   $0x1c
  8012f6:	e8 b6 fc ff ff       	call   800fb1 <syscall>
  8012fb:	83 c4 18             	add    $0x18,%esp
}
  8012fe:	c9                   	leave  
  8012ff:	c3                   	ret    

00801300 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801300:	55                   	push   %ebp
  801301:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801303:	8b 55 0c             	mov    0xc(%ebp),%edx
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	52                   	push   %edx
  801310:	50                   	push   %eax
  801311:	6a 1d                	push   $0x1d
  801313:	e8 99 fc ff ff       	call   800fb1 <syscall>
  801318:	83 c4 18             	add    $0x18,%esp
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801320:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801323:	8b 55 0c             	mov    0xc(%ebp),%edx
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	51                   	push   %ecx
  80132e:	52                   	push   %edx
  80132f:	50                   	push   %eax
  801330:	6a 1e                	push   $0x1e
  801332:	e8 7a fc ff ff       	call   800fb1 <syscall>
  801337:	83 c4 18             	add    $0x18,%esp
}
  80133a:	c9                   	leave  
  80133b:	c3                   	ret    

0080133c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80133c:	55                   	push   %ebp
  80133d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80133f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	52                   	push   %edx
  80134c:	50                   	push   %eax
  80134d:	6a 1f                	push   $0x1f
  80134f:	e8 5d fc ff ff       	call   800fb1 <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 20                	push   $0x20
  801368:	e8 44 fc ff ff       	call   800fb1 <syscall>
  80136d:	83 c4 18             	add    $0x18,%esp
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	ff 75 10             	pushl  0x10(%ebp)
  80137f:	ff 75 0c             	pushl  0xc(%ebp)
  801382:	50                   	push   %eax
  801383:	6a 21                	push   $0x21
  801385:	e8 27 fc ff ff       	call   800fb1 <syscall>
  80138a:	83 c4 18             	add    $0x18,%esp
}
  80138d:	c9                   	leave  
  80138e:	c3                   	ret    

0080138f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80138f:	55                   	push   %ebp
  801390:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	50                   	push   %eax
  80139e:	6a 22                	push   $0x22
  8013a0:	e8 0c fc ff ff       	call   800fb1 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	90                   	nop
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	50                   	push   %eax
  8013ba:	6a 23                	push   $0x23
  8013bc:	e8 f0 fb ff ff       	call   800fb1 <syscall>
  8013c1:	83 c4 18             	add    $0x18,%esp
}
  8013c4:	90                   	nop
  8013c5:	c9                   	leave  
  8013c6:	c3                   	ret    

008013c7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013c7:	55                   	push   %ebp
  8013c8:	89 e5                	mov    %esp,%ebp
  8013ca:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013cd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013d0:	8d 50 04             	lea    0x4(%eax),%edx
  8013d3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	52                   	push   %edx
  8013dd:	50                   	push   %eax
  8013de:	6a 24                	push   $0x24
  8013e0:	e8 cc fb ff ff       	call   800fb1 <syscall>
  8013e5:	83 c4 18             	add    $0x18,%esp
	return result;
  8013e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013f1:	89 01                	mov    %eax,(%ecx)
  8013f3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	c9                   	leave  
  8013fa:	c2 04 00             	ret    $0x4

008013fd <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8013fd:	55                   	push   %ebp
  8013fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	ff 75 10             	pushl  0x10(%ebp)
  801407:	ff 75 0c             	pushl  0xc(%ebp)
  80140a:	ff 75 08             	pushl  0x8(%ebp)
  80140d:	6a 13                	push   $0x13
  80140f:	e8 9d fb ff ff       	call   800fb1 <syscall>
  801414:	83 c4 18             	add    $0x18,%esp
	return ;
  801417:	90                   	nop
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <sys_rcr2>:
uint32 sys_rcr2()
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 25                	push   $0x25
  801429:	e8 83 fb ff ff       	call   800fb1 <syscall>
  80142e:	83 c4 18             	add    $0x18,%esp
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
  801436:	83 ec 04             	sub    $0x4,%esp
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80143f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	50                   	push   %eax
  80144c:	6a 26                	push   $0x26
  80144e:	e8 5e fb ff ff       	call   800fb1 <syscall>
  801453:	83 c4 18             	add    $0x18,%esp
	return ;
  801456:	90                   	nop
}
  801457:	c9                   	leave  
  801458:	c3                   	ret    

00801459 <rsttst>:
void rsttst()
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 28                	push   $0x28
  801468:	e8 44 fb ff ff       	call   800fb1 <syscall>
  80146d:	83 c4 18             	add    $0x18,%esp
	return ;
  801470:	90                   	nop
}
  801471:	c9                   	leave  
  801472:	c3                   	ret    

00801473 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801473:	55                   	push   %ebp
  801474:	89 e5                	mov    %esp,%ebp
  801476:	83 ec 04             	sub    $0x4,%esp
  801479:	8b 45 14             	mov    0x14(%ebp),%eax
  80147c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80147f:	8b 55 18             	mov    0x18(%ebp),%edx
  801482:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801486:	52                   	push   %edx
  801487:	50                   	push   %eax
  801488:	ff 75 10             	pushl  0x10(%ebp)
  80148b:	ff 75 0c             	pushl  0xc(%ebp)
  80148e:	ff 75 08             	pushl  0x8(%ebp)
  801491:	6a 27                	push   $0x27
  801493:	e8 19 fb ff ff       	call   800fb1 <syscall>
  801498:	83 c4 18             	add    $0x18,%esp
	return ;
  80149b:	90                   	nop
}
  80149c:	c9                   	leave  
  80149d:	c3                   	ret    

0080149e <chktst>:
void chktst(uint32 n)
{
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	ff 75 08             	pushl  0x8(%ebp)
  8014ac:	6a 29                	push   $0x29
  8014ae:	e8 fe fa ff ff       	call   800fb1 <syscall>
  8014b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b6:	90                   	nop
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <inctst>:

void inctst()
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 2a                	push   $0x2a
  8014c8:	e8 e4 fa ff ff       	call   800fb1 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d0:	90                   	nop
}
  8014d1:	c9                   	leave  
  8014d2:	c3                   	ret    

008014d3 <gettst>:
uint32 gettst()
{
  8014d3:	55                   	push   %ebp
  8014d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 2b                	push   $0x2b
  8014e2:	e8 ca fa ff ff       	call   800fb1 <syscall>
  8014e7:	83 c4 18             	add    $0x18,%esp
}
  8014ea:	c9                   	leave  
  8014eb:	c3                   	ret    

008014ec <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8014ec:	55                   	push   %ebp
  8014ed:	89 e5                	mov    %esp,%ebp
  8014ef:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 2c                	push   $0x2c
  8014fe:	e8 ae fa ff ff       	call   800fb1 <syscall>
  801503:	83 c4 18             	add    $0x18,%esp
  801506:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801509:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80150d:	75 07                	jne    801516 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80150f:	b8 01 00 00 00       	mov    $0x1,%eax
  801514:	eb 05                	jmp    80151b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801516:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80151b:	c9                   	leave  
  80151c:	c3                   	ret    

0080151d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
  801520:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 2c                	push   $0x2c
  80152f:	e8 7d fa ff ff       	call   800fb1 <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
  801537:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80153a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80153e:	75 07                	jne    801547 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801540:	b8 01 00 00 00       	mov    $0x1,%eax
  801545:	eb 05                	jmp    80154c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801547:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80154c:	c9                   	leave  
  80154d:	c3                   	ret    

0080154e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
  801551:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 2c                	push   $0x2c
  801560:	e8 4c fa ff ff       	call   800fb1 <syscall>
  801565:	83 c4 18             	add    $0x18,%esp
  801568:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80156b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80156f:	75 07                	jne    801578 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801571:	b8 01 00 00 00       	mov    $0x1,%eax
  801576:	eb 05                	jmp    80157d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801578:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
  801582:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 2c                	push   $0x2c
  801591:	e8 1b fa ff ff       	call   800fb1 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
  801599:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80159c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015a0:	75 07                	jne    8015a9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a7:	eb 05                	jmp    8015ae <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ae:	c9                   	leave  
  8015af:	c3                   	ret    

008015b0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	ff 75 08             	pushl  0x8(%ebp)
  8015be:	6a 2d                	push   $0x2d
  8015c0:	e8 ec f9 ff ff       	call   800fb1 <syscall>
  8015c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c8:	90                   	nop
}
  8015c9:	c9                   	leave  
  8015ca:	c3                   	ret    
  8015cb:	90                   	nop

008015cc <__udivdi3>:
  8015cc:	55                   	push   %ebp
  8015cd:	57                   	push   %edi
  8015ce:	56                   	push   %esi
  8015cf:	53                   	push   %ebx
  8015d0:	83 ec 1c             	sub    $0x1c,%esp
  8015d3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8015d7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8015db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8015df:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8015e3:	89 ca                	mov    %ecx,%edx
  8015e5:	89 f8                	mov    %edi,%eax
  8015e7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8015eb:	85 f6                	test   %esi,%esi
  8015ed:	75 2d                	jne    80161c <__udivdi3+0x50>
  8015ef:	39 cf                	cmp    %ecx,%edi
  8015f1:	77 65                	ja     801658 <__udivdi3+0x8c>
  8015f3:	89 fd                	mov    %edi,%ebp
  8015f5:	85 ff                	test   %edi,%edi
  8015f7:	75 0b                	jne    801604 <__udivdi3+0x38>
  8015f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015fe:	31 d2                	xor    %edx,%edx
  801600:	f7 f7                	div    %edi
  801602:	89 c5                	mov    %eax,%ebp
  801604:	31 d2                	xor    %edx,%edx
  801606:	89 c8                	mov    %ecx,%eax
  801608:	f7 f5                	div    %ebp
  80160a:	89 c1                	mov    %eax,%ecx
  80160c:	89 d8                	mov    %ebx,%eax
  80160e:	f7 f5                	div    %ebp
  801610:	89 cf                	mov    %ecx,%edi
  801612:	89 fa                	mov    %edi,%edx
  801614:	83 c4 1c             	add    $0x1c,%esp
  801617:	5b                   	pop    %ebx
  801618:	5e                   	pop    %esi
  801619:	5f                   	pop    %edi
  80161a:	5d                   	pop    %ebp
  80161b:	c3                   	ret    
  80161c:	39 ce                	cmp    %ecx,%esi
  80161e:	77 28                	ja     801648 <__udivdi3+0x7c>
  801620:	0f bd fe             	bsr    %esi,%edi
  801623:	83 f7 1f             	xor    $0x1f,%edi
  801626:	75 40                	jne    801668 <__udivdi3+0x9c>
  801628:	39 ce                	cmp    %ecx,%esi
  80162a:	72 0a                	jb     801636 <__udivdi3+0x6a>
  80162c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801630:	0f 87 9e 00 00 00    	ja     8016d4 <__udivdi3+0x108>
  801636:	b8 01 00 00 00       	mov    $0x1,%eax
  80163b:	89 fa                	mov    %edi,%edx
  80163d:	83 c4 1c             	add    $0x1c,%esp
  801640:	5b                   	pop    %ebx
  801641:	5e                   	pop    %esi
  801642:	5f                   	pop    %edi
  801643:	5d                   	pop    %ebp
  801644:	c3                   	ret    
  801645:	8d 76 00             	lea    0x0(%esi),%esi
  801648:	31 ff                	xor    %edi,%edi
  80164a:	31 c0                	xor    %eax,%eax
  80164c:	89 fa                	mov    %edi,%edx
  80164e:	83 c4 1c             	add    $0x1c,%esp
  801651:	5b                   	pop    %ebx
  801652:	5e                   	pop    %esi
  801653:	5f                   	pop    %edi
  801654:	5d                   	pop    %ebp
  801655:	c3                   	ret    
  801656:	66 90                	xchg   %ax,%ax
  801658:	89 d8                	mov    %ebx,%eax
  80165a:	f7 f7                	div    %edi
  80165c:	31 ff                	xor    %edi,%edi
  80165e:	89 fa                	mov    %edi,%edx
  801660:	83 c4 1c             	add    $0x1c,%esp
  801663:	5b                   	pop    %ebx
  801664:	5e                   	pop    %esi
  801665:	5f                   	pop    %edi
  801666:	5d                   	pop    %ebp
  801667:	c3                   	ret    
  801668:	bd 20 00 00 00       	mov    $0x20,%ebp
  80166d:	89 eb                	mov    %ebp,%ebx
  80166f:	29 fb                	sub    %edi,%ebx
  801671:	89 f9                	mov    %edi,%ecx
  801673:	d3 e6                	shl    %cl,%esi
  801675:	89 c5                	mov    %eax,%ebp
  801677:	88 d9                	mov    %bl,%cl
  801679:	d3 ed                	shr    %cl,%ebp
  80167b:	89 e9                	mov    %ebp,%ecx
  80167d:	09 f1                	or     %esi,%ecx
  80167f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801683:	89 f9                	mov    %edi,%ecx
  801685:	d3 e0                	shl    %cl,%eax
  801687:	89 c5                	mov    %eax,%ebp
  801689:	89 d6                	mov    %edx,%esi
  80168b:	88 d9                	mov    %bl,%cl
  80168d:	d3 ee                	shr    %cl,%esi
  80168f:	89 f9                	mov    %edi,%ecx
  801691:	d3 e2                	shl    %cl,%edx
  801693:	8b 44 24 08          	mov    0x8(%esp),%eax
  801697:	88 d9                	mov    %bl,%cl
  801699:	d3 e8                	shr    %cl,%eax
  80169b:	09 c2                	or     %eax,%edx
  80169d:	89 d0                	mov    %edx,%eax
  80169f:	89 f2                	mov    %esi,%edx
  8016a1:	f7 74 24 0c          	divl   0xc(%esp)
  8016a5:	89 d6                	mov    %edx,%esi
  8016a7:	89 c3                	mov    %eax,%ebx
  8016a9:	f7 e5                	mul    %ebp
  8016ab:	39 d6                	cmp    %edx,%esi
  8016ad:	72 19                	jb     8016c8 <__udivdi3+0xfc>
  8016af:	74 0b                	je     8016bc <__udivdi3+0xf0>
  8016b1:	89 d8                	mov    %ebx,%eax
  8016b3:	31 ff                	xor    %edi,%edi
  8016b5:	e9 58 ff ff ff       	jmp    801612 <__udivdi3+0x46>
  8016ba:	66 90                	xchg   %ax,%ax
  8016bc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8016c0:	89 f9                	mov    %edi,%ecx
  8016c2:	d3 e2                	shl    %cl,%edx
  8016c4:	39 c2                	cmp    %eax,%edx
  8016c6:	73 e9                	jae    8016b1 <__udivdi3+0xe5>
  8016c8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8016cb:	31 ff                	xor    %edi,%edi
  8016cd:	e9 40 ff ff ff       	jmp    801612 <__udivdi3+0x46>
  8016d2:	66 90                	xchg   %ax,%ax
  8016d4:	31 c0                	xor    %eax,%eax
  8016d6:	e9 37 ff ff ff       	jmp    801612 <__udivdi3+0x46>
  8016db:	90                   	nop

008016dc <__umoddi3>:
  8016dc:	55                   	push   %ebp
  8016dd:	57                   	push   %edi
  8016de:	56                   	push   %esi
  8016df:	53                   	push   %ebx
  8016e0:	83 ec 1c             	sub    $0x1c,%esp
  8016e3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8016e7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8016eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016ef:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8016f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8016f7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8016fb:	89 f3                	mov    %esi,%ebx
  8016fd:	89 fa                	mov    %edi,%edx
  8016ff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801703:	89 34 24             	mov    %esi,(%esp)
  801706:	85 c0                	test   %eax,%eax
  801708:	75 1a                	jne    801724 <__umoddi3+0x48>
  80170a:	39 f7                	cmp    %esi,%edi
  80170c:	0f 86 a2 00 00 00    	jbe    8017b4 <__umoddi3+0xd8>
  801712:	89 c8                	mov    %ecx,%eax
  801714:	89 f2                	mov    %esi,%edx
  801716:	f7 f7                	div    %edi
  801718:	89 d0                	mov    %edx,%eax
  80171a:	31 d2                	xor    %edx,%edx
  80171c:	83 c4 1c             	add    $0x1c,%esp
  80171f:	5b                   	pop    %ebx
  801720:	5e                   	pop    %esi
  801721:	5f                   	pop    %edi
  801722:	5d                   	pop    %ebp
  801723:	c3                   	ret    
  801724:	39 f0                	cmp    %esi,%eax
  801726:	0f 87 ac 00 00 00    	ja     8017d8 <__umoddi3+0xfc>
  80172c:	0f bd e8             	bsr    %eax,%ebp
  80172f:	83 f5 1f             	xor    $0x1f,%ebp
  801732:	0f 84 ac 00 00 00    	je     8017e4 <__umoddi3+0x108>
  801738:	bf 20 00 00 00       	mov    $0x20,%edi
  80173d:	29 ef                	sub    %ebp,%edi
  80173f:	89 fe                	mov    %edi,%esi
  801741:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801745:	89 e9                	mov    %ebp,%ecx
  801747:	d3 e0                	shl    %cl,%eax
  801749:	89 d7                	mov    %edx,%edi
  80174b:	89 f1                	mov    %esi,%ecx
  80174d:	d3 ef                	shr    %cl,%edi
  80174f:	09 c7                	or     %eax,%edi
  801751:	89 e9                	mov    %ebp,%ecx
  801753:	d3 e2                	shl    %cl,%edx
  801755:	89 14 24             	mov    %edx,(%esp)
  801758:	89 d8                	mov    %ebx,%eax
  80175a:	d3 e0                	shl    %cl,%eax
  80175c:	89 c2                	mov    %eax,%edx
  80175e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801762:	d3 e0                	shl    %cl,%eax
  801764:	89 44 24 04          	mov    %eax,0x4(%esp)
  801768:	8b 44 24 08          	mov    0x8(%esp),%eax
  80176c:	89 f1                	mov    %esi,%ecx
  80176e:	d3 e8                	shr    %cl,%eax
  801770:	09 d0                	or     %edx,%eax
  801772:	d3 eb                	shr    %cl,%ebx
  801774:	89 da                	mov    %ebx,%edx
  801776:	f7 f7                	div    %edi
  801778:	89 d3                	mov    %edx,%ebx
  80177a:	f7 24 24             	mull   (%esp)
  80177d:	89 c6                	mov    %eax,%esi
  80177f:	89 d1                	mov    %edx,%ecx
  801781:	39 d3                	cmp    %edx,%ebx
  801783:	0f 82 87 00 00 00    	jb     801810 <__umoddi3+0x134>
  801789:	0f 84 91 00 00 00    	je     801820 <__umoddi3+0x144>
  80178f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801793:	29 f2                	sub    %esi,%edx
  801795:	19 cb                	sbb    %ecx,%ebx
  801797:	89 d8                	mov    %ebx,%eax
  801799:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80179d:	d3 e0                	shl    %cl,%eax
  80179f:	89 e9                	mov    %ebp,%ecx
  8017a1:	d3 ea                	shr    %cl,%edx
  8017a3:	09 d0                	or     %edx,%eax
  8017a5:	89 e9                	mov    %ebp,%ecx
  8017a7:	d3 eb                	shr    %cl,%ebx
  8017a9:	89 da                	mov    %ebx,%edx
  8017ab:	83 c4 1c             	add    $0x1c,%esp
  8017ae:	5b                   	pop    %ebx
  8017af:	5e                   	pop    %esi
  8017b0:	5f                   	pop    %edi
  8017b1:	5d                   	pop    %ebp
  8017b2:	c3                   	ret    
  8017b3:	90                   	nop
  8017b4:	89 fd                	mov    %edi,%ebp
  8017b6:	85 ff                	test   %edi,%edi
  8017b8:	75 0b                	jne    8017c5 <__umoddi3+0xe9>
  8017ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8017bf:	31 d2                	xor    %edx,%edx
  8017c1:	f7 f7                	div    %edi
  8017c3:	89 c5                	mov    %eax,%ebp
  8017c5:	89 f0                	mov    %esi,%eax
  8017c7:	31 d2                	xor    %edx,%edx
  8017c9:	f7 f5                	div    %ebp
  8017cb:	89 c8                	mov    %ecx,%eax
  8017cd:	f7 f5                	div    %ebp
  8017cf:	89 d0                	mov    %edx,%eax
  8017d1:	e9 44 ff ff ff       	jmp    80171a <__umoddi3+0x3e>
  8017d6:	66 90                	xchg   %ax,%ax
  8017d8:	89 c8                	mov    %ecx,%eax
  8017da:	89 f2                	mov    %esi,%edx
  8017dc:	83 c4 1c             	add    $0x1c,%esp
  8017df:	5b                   	pop    %ebx
  8017e0:	5e                   	pop    %esi
  8017e1:	5f                   	pop    %edi
  8017e2:	5d                   	pop    %ebp
  8017e3:	c3                   	ret    
  8017e4:	3b 04 24             	cmp    (%esp),%eax
  8017e7:	72 06                	jb     8017ef <__umoddi3+0x113>
  8017e9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8017ed:	77 0f                	ja     8017fe <__umoddi3+0x122>
  8017ef:	89 f2                	mov    %esi,%edx
  8017f1:	29 f9                	sub    %edi,%ecx
  8017f3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8017f7:	89 14 24             	mov    %edx,(%esp)
  8017fa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017fe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801802:	8b 14 24             	mov    (%esp),%edx
  801805:	83 c4 1c             	add    $0x1c,%esp
  801808:	5b                   	pop    %ebx
  801809:	5e                   	pop    %esi
  80180a:	5f                   	pop    %edi
  80180b:	5d                   	pop    %ebp
  80180c:	c3                   	ret    
  80180d:	8d 76 00             	lea    0x0(%esi),%esi
  801810:	2b 04 24             	sub    (%esp),%eax
  801813:	19 fa                	sbb    %edi,%edx
  801815:	89 d1                	mov    %edx,%ecx
  801817:	89 c6                	mov    %eax,%esi
  801819:	e9 71 ff ff ff       	jmp    80178f <__umoddi3+0xb3>
  80181e:	66 90                	xchg   %ax,%ax
  801820:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801824:	72 ea                	jb     801810 <__umoddi3+0x134>
  801826:	89 d9                	mov    %ebx,%ecx
  801828:	e9 62 ff ff ff       	jmp    80178f <__umoddi3+0xb3>
