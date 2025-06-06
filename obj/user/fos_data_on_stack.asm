
obj/user/fos_data_on_stack:     file format elf32-i386


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
  800031:	e8 1e 00 00 00       	call   800054 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 48 27 00 00    	sub    $0x2748,%esp
	/// Adding array of 512 integer on user stack
	int arr[2512];

	atomic_cprintf("user stack contains 512 integer\n");
  800041:	83 ec 0c             	sub    $0xc,%esp
  800044:	68 40 18 80 00       	push   $0x801840
  800049:	e8 09 02 00 00       	call   800257 <atomic_cprintf>
  80004e:	83 c4 10             	add    $0x10,%esp

	return;	
  800051:	90                   	nop
}
  800052:	c9                   	leave  
  800053:	c3                   	ret    

00800054 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800054:	55                   	push   %ebp
  800055:	89 e5                	mov    %esp,%ebp
  800057:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80005a:	e8 f6 0f 00 00       	call   801055 <sys_getenvindex>
  80005f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800062:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800065:	89 d0                	mov    %edx,%eax
  800067:	01 c0                	add    %eax,%eax
  800069:	01 d0                	add    %edx,%eax
  80006b:	c1 e0 02             	shl    $0x2,%eax
  80006e:	01 d0                	add    %edx,%eax
  800070:	c1 e0 06             	shl    $0x6,%eax
  800073:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800078:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80007d:	a1 04 20 80 00       	mov    0x802004,%eax
  800082:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800088:	84 c0                	test   %al,%al
  80008a:	74 0f                	je     80009b <libmain+0x47>
		binaryname = myEnv->prog_name;
  80008c:	a1 04 20 80 00       	mov    0x802004,%eax
  800091:	05 f4 02 00 00       	add    $0x2f4,%eax
  800096:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80009b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80009f:	7e 0a                	jle    8000ab <libmain+0x57>
		binaryname = argv[0];
  8000a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000a4:	8b 00                	mov    (%eax),%eax
  8000a6:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000ab:	83 ec 08             	sub    $0x8,%esp
  8000ae:	ff 75 0c             	pushl  0xc(%ebp)
  8000b1:	ff 75 08             	pushl  0x8(%ebp)
  8000b4:	e8 7f ff ff ff       	call   800038 <_main>
  8000b9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000bc:	e8 2f 11 00 00       	call   8011f0 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000c1:	83 ec 0c             	sub    $0xc,%esp
  8000c4:	68 7c 18 80 00       	push   $0x80187c
  8000c9:	e8 5c 01 00 00       	call   80022a <cprintf>
  8000ce:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000d1:	a1 04 20 80 00       	mov    0x802004,%eax
  8000d6:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8000dc:	a1 04 20 80 00       	mov    0x802004,%eax
  8000e1:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8000e7:	83 ec 04             	sub    $0x4,%esp
  8000ea:	52                   	push   %edx
  8000eb:	50                   	push   %eax
  8000ec:	68 a4 18 80 00       	push   $0x8018a4
  8000f1:	e8 34 01 00 00       	call   80022a <cprintf>
  8000f6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8000f9:	a1 04 20 80 00       	mov    0x802004,%eax
  8000fe:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800104:	83 ec 08             	sub    $0x8,%esp
  800107:	50                   	push   %eax
  800108:	68 c9 18 80 00       	push   $0x8018c9
  80010d:	e8 18 01 00 00       	call   80022a <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 7c 18 80 00       	push   $0x80187c
  80011d:	e8 08 01 00 00       	call   80022a <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800125:	e8 e0 10 00 00       	call   80120a <sys_enable_interrupt>

	// exit gracefully
	exit();
  80012a:	e8 19 00 00 00       	call   800148 <exit>
}
  80012f:	90                   	nop
  800130:	c9                   	leave  
  800131:	c3                   	ret    

00800132 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800132:	55                   	push   %ebp
  800133:	89 e5                	mov    %esp,%ebp
  800135:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800138:	83 ec 0c             	sub    $0xc,%esp
  80013b:	6a 00                	push   $0x0
  80013d:	e8 df 0e 00 00       	call   801021 <sys_env_destroy>
  800142:	83 c4 10             	add    $0x10,%esp
}
  800145:	90                   	nop
  800146:	c9                   	leave  
  800147:	c3                   	ret    

00800148 <exit>:

void
exit(void)
{
  800148:	55                   	push   %ebp
  800149:	89 e5                	mov    %esp,%ebp
  80014b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80014e:	e8 34 0f 00 00       	call   801087 <sys_env_exit>
}
  800153:	90                   	nop
  800154:	c9                   	leave  
  800155:	c3                   	ret    

00800156 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800156:	55                   	push   %ebp
  800157:	89 e5                	mov    %esp,%ebp
  800159:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80015c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80015f:	8b 00                	mov    (%eax),%eax
  800161:	8d 48 01             	lea    0x1(%eax),%ecx
  800164:	8b 55 0c             	mov    0xc(%ebp),%edx
  800167:	89 0a                	mov    %ecx,(%edx)
  800169:	8b 55 08             	mov    0x8(%ebp),%edx
  80016c:	88 d1                	mov    %dl,%cl
  80016e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800171:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800175:	8b 45 0c             	mov    0xc(%ebp),%eax
  800178:	8b 00                	mov    (%eax),%eax
  80017a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80017f:	75 2c                	jne    8001ad <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800181:	a0 08 20 80 00       	mov    0x802008,%al
  800186:	0f b6 c0             	movzbl %al,%eax
  800189:	8b 55 0c             	mov    0xc(%ebp),%edx
  80018c:	8b 12                	mov    (%edx),%edx
  80018e:	89 d1                	mov    %edx,%ecx
  800190:	8b 55 0c             	mov    0xc(%ebp),%edx
  800193:	83 c2 08             	add    $0x8,%edx
  800196:	83 ec 04             	sub    $0x4,%esp
  800199:	50                   	push   %eax
  80019a:	51                   	push   %ecx
  80019b:	52                   	push   %edx
  80019c:	e8 3e 0e 00 00       	call   800fdf <sys_cputs>
  8001a1:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b0:	8b 40 04             	mov    0x4(%eax),%eax
  8001b3:	8d 50 01             	lea    0x1(%eax),%edx
  8001b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001bc:	90                   	nop
  8001bd:	c9                   	leave  
  8001be:	c3                   	ret    

008001bf <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001bf:	55                   	push   %ebp
  8001c0:	89 e5                	mov    %esp,%ebp
  8001c2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001c8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001cf:	00 00 00 
	b.cnt = 0;
  8001d2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001d9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001dc:	ff 75 0c             	pushl  0xc(%ebp)
  8001df:	ff 75 08             	pushl  0x8(%ebp)
  8001e2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8001e8:	50                   	push   %eax
  8001e9:	68 56 01 80 00       	push   $0x800156
  8001ee:	e8 11 02 00 00       	call   800404 <vprintfmt>
  8001f3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8001f6:	a0 08 20 80 00       	mov    0x802008,%al
  8001fb:	0f b6 c0             	movzbl %al,%eax
  8001fe:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800204:	83 ec 04             	sub    $0x4,%esp
  800207:	50                   	push   %eax
  800208:	52                   	push   %edx
  800209:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80020f:	83 c0 08             	add    $0x8,%eax
  800212:	50                   	push   %eax
  800213:	e8 c7 0d 00 00       	call   800fdf <sys_cputs>
  800218:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80021b:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800222:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800228:	c9                   	leave  
  800229:	c3                   	ret    

0080022a <cprintf>:

int cprintf(const char *fmt, ...) {
  80022a:	55                   	push   %ebp
  80022b:	89 e5                	mov    %esp,%ebp
  80022d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800230:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800237:	8d 45 0c             	lea    0xc(%ebp),%eax
  80023a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80023d:	8b 45 08             	mov    0x8(%ebp),%eax
  800240:	83 ec 08             	sub    $0x8,%esp
  800243:	ff 75 f4             	pushl  -0xc(%ebp)
  800246:	50                   	push   %eax
  800247:	e8 73 ff ff ff       	call   8001bf <vcprintf>
  80024c:	83 c4 10             	add    $0x10,%esp
  80024f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800252:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800255:	c9                   	leave  
  800256:	c3                   	ret    

00800257 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800257:	55                   	push   %ebp
  800258:	89 e5                	mov    %esp,%ebp
  80025a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80025d:	e8 8e 0f 00 00       	call   8011f0 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800262:	8d 45 0c             	lea    0xc(%ebp),%eax
  800265:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800268:	8b 45 08             	mov    0x8(%ebp),%eax
  80026b:	83 ec 08             	sub    $0x8,%esp
  80026e:	ff 75 f4             	pushl  -0xc(%ebp)
  800271:	50                   	push   %eax
  800272:	e8 48 ff ff ff       	call   8001bf <vcprintf>
  800277:	83 c4 10             	add    $0x10,%esp
  80027a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80027d:	e8 88 0f 00 00       	call   80120a <sys_enable_interrupt>
	return cnt;
  800282:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800285:	c9                   	leave  
  800286:	c3                   	ret    

00800287 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800287:	55                   	push   %ebp
  800288:	89 e5                	mov    %esp,%ebp
  80028a:	53                   	push   %ebx
  80028b:	83 ec 14             	sub    $0x14,%esp
  80028e:	8b 45 10             	mov    0x10(%ebp),%eax
  800291:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800294:	8b 45 14             	mov    0x14(%ebp),%eax
  800297:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80029a:	8b 45 18             	mov    0x18(%ebp),%eax
  80029d:	ba 00 00 00 00       	mov    $0x0,%edx
  8002a2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002a5:	77 55                	ja     8002fc <printnum+0x75>
  8002a7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002aa:	72 05                	jb     8002b1 <printnum+0x2a>
  8002ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002af:	77 4b                	ja     8002fc <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002b1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002b4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002b7:	8b 45 18             	mov    0x18(%ebp),%eax
  8002ba:	ba 00 00 00 00       	mov    $0x0,%edx
  8002bf:	52                   	push   %edx
  8002c0:	50                   	push   %eax
  8002c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c4:	ff 75 f0             	pushl  -0x10(%ebp)
  8002c7:	e8 04 13 00 00       	call   8015d0 <__udivdi3>
  8002cc:	83 c4 10             	add    $0x10,%esp
  8002cf:	83 ec 04             	sub    $0x4,%esp
  8002d2:	ff 75 20             	pushl  0x20(%ebp)
  8002d5:	53                   	push   %ebx
  8002d6:	ff 75 18             	pushl  0x18(%ebp)
  8002d9:	52                   	push   %edx
  8002da:	50                   	push   %eax
  8002db:	ff 75 0c             	pushl  0xc(%ebp)
  8002de:	ff 75 08             	pushl  0x8(%ebp)
  8002e1:	e8 a1 ff ff ff       	call   800287 <printnum>
  8002e6:	83 c4 20             	add    $0x20,%esp
  8002e9:	eb 1a                	jmp    800305 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8002eb:	83 ec 08             	sub    $0x8,%esp
  8002ee:	ff 75 0c             	pushl  0xc(%ebp)
  8002f1:	ff 75 20             	pushl  0x20(%ebp)
  8002f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f7:	ff d0                	call   *%eax
  8002f9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8002fc:	ff 4d 1c             	decl   0x1c(%ebp)
  8002ff:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800303:	7f e6                	jg     8002eb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800305:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800308:	bb 00 00 00 00       	mov    $0x0,%ebx
  80030d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800310:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800313:	53                   	push   %ebx
  800314:	51                   	push   %ecx
  800315:	52                   	push   %edx
  800316:	50                   	push   %eax
  800317:	e8 c4 13 00 00       	call   8016e0 <__umoddi3>
  80031c:	83 c4 10             	add    $0x10,%esp
  80031f:	05 f4 1a 80 00       	add    $0x801af4,%eax
  800324:	8a 00                	mov    (%eax),%al
  800326:	0f be c0             	movsbl %al,%eax
  800329:	83 ec 08             	sub    $0x8,%esp
  80032c:	ff 75 0c             	pushl  0xc(%ebp)
  80032f:	50                   	push   %eax
  800330:	8b 45 08             	mov    0x8(%ebp),%eax
  800333:	ff d0                	call   *%eax
  800335:	83 c4 10             	add    $0x10,%esp
}
  800338:	90                   	nop
  800339:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80033c:	c9                   	leave  
  80033d:	c3                   	ret    

0080033e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80033e:	55                   	push   %ebp
  80033f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800341:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800345:	7e 1c                	jle    800363 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800347:	8b 45 08             	mov    0x8(%ebp),%eax
  80034a:	8b 00                	mov    (%eax),%eax
  80034c:	8d 50 08             	lea    0x8(%eax),%edx
  80034f:	8b 45 08             	mov    0x8(%ebp),%eax
  800352:	89 10                	mov    %edx,(%eax)
  800354:	8b 45 08             	mov    0x8(%ebp),%eax
  800357:	8b 00                	mov    (%eax),%eax
  800359:	83 e8 08             	sub    $0x8,%eax
  80035c:	8b 50 04             	mov    0x4(%eax),%edx
  80035f:	8b 00                	mov    (%eax),%eax
  800361:	eb 40                	jmp    8003a3 <getuint+0x65>
	else if (lflag)
  800363:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800367:	74 1e                	je     800387 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800369:	8b 45 08             	mov    0x8(%ebp),%eax
  80036c:	8b 00                	mov    (%eax),%eax
  80036e:	8d 50 04             	lea    0x4(%eax),%edx
  800371:	8b 45 08             	mov    0x8(%ebp),%eax
  800374:	89 10                	mov    %edx,(%eax)
  800376:	8b 45 08             	mov    0x8(%ebp),%eax
  800379:	8b 00                	mov    (%eax),%eax
  80037b:	83 e8 04             	sub    $0x4,%eax
  80037e:	8b 00                	mov    (%eax),%eax
  800380:	ba 00 00 00 00       	mov    $0x0,%edx
  800385:	eb 1c                	jmp    8003a3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	8b 00                	mov    (%eax),%eax
  80038c:	8d 50 04             	lea    0x4(%eax),%edx
  80038f:	8b 45 08             	mov    0x8(%ebp),%eax
  800392:	89 10                	mov    %edx,(%eax)
  800394:	8b 45 08             	mov    0x8(%ebp),%eax
  800397:	8b 00                	mov    (%eax),%eax
  800399:	83 e8 04             	sub    $0x4,%eax
  80039c:	8b 00                	mov    (%eax),%eax
  80039e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003a3:	5d                   	pop    %ebp
  8003a4:	c3                   	ret    

008003a5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003a5:	55                   	push   %ebp
  8003a6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003a8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ac:	7e 1c                	jle    8003ca <getint+0x25>
		return va_arg(*ap, long long);
  8003ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b1:	8b 00                	mov    (%eax),%eax
  8003b3:	8d 50 08             	lea    0x8(%eax),%edx
  8003b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b9:	89 10                	mov    %edx,(%eax)
  8003bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003be:	8b 00                	mov    (%eax),%eax
  8003c0:	83 e8 08             	sub    $0x8,%eax
  8003c3:	8b 50 04             	mov    0x4(%eax),%edx
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	eb 38                	jmp    800402 <getint+0x5d>
	else if (lflag)
  8003ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003ce:	74 1a                	je     8003ea <getint+0x45>
		return va_arg(*ap, long);
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	8b 00                	mov    (%eax),%eax
  8003d5:	8d 50 04             	lea    0x4(%eax),%edx
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	89 10                	mov    %edx,(%eax)
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	83 e8 04             	sub    $0x4,%eax
  8003e5:	8b 00                	mov    (%eax),%eax
  8003e7:	99                   	cltd   
  8003e8:	eb 18                	jmp    800402 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	8d 50 04             	lea    0x4(%eax),%edx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	89 10                	mov    %edx,(%eax)
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	83 e8 04             	sub    $0x4,%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	99                   	cltd   
}
  800402:	5d                   	pop    %ebp
  800403:	c3                   	ret    

00800404 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800404:	55                   	push   %ebp
  800405:	89 e5                	mov    %esp,%ebp
  800407:	56                   	push   %esi
  800408:	53                   	push   %ebx
  800409:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80040c:	eb 17                	jmp    800425 <vprintfmt+0x21>
			if (ch == '\0')
  80040e:	85 db                	test   %ebx,%ebx
  800410:	0f 84 af 03 00 00    	je     8007c5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800416:	83 ec 08             	sub    $0x8,%esp
  800419:	ff 75 0c             	pushl  0xc(%ebp)
  80041c:	53                   	push   %ebx
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	ff d0                	call   *%eax
  800422:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800425:	8b 45 10             	mov    0x10(%ebp),%eax
  800428:	8d 50 01             	lea    0x1(%eax),%edx
  80042b:	89 55 10             	mov    %edx,0x10(%ebp)
  80042e:	8a 00                	mov    (%eax),%al
  800430:	0f b6 d8             	movzbl %al,%ebx
  800433:	83 fb 25             	cmp    $0x25,%ebx
  800436:	75 d6                	jne    80040e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800438:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80043c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800443:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80044a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800451:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800458:	8b 45 10             	mov    0x10(%ebp),%eax
  80045b:	8d 50 01             	lea    0x1(%eax),%edx
  80045e:	89 55 10             	mov    %edx,0x10(%ebp)
  800461:	8a 00                	mov    (%eax),%al
  800463:	0f b6 d8             	movzbl %al,%ebx
  800466:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800469:	83 f8 55             	cmp    $0x55,%eax
  80046c:	0f 87 2b 03 00 00    	ja     80079d <vprintfmt+0x399>
  800472:	8b 04 85 18 1b 80 00 	mov    0x801b18(,%eax,4),%eax
  800479:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80047b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80047f:	eb d7                	jmp    800458 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800481:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800485:	eb d1                	jmp    800458 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800487:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80048e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800491:	89 d0                	mov    %edx,%eax
  800493:	c1 e0 02             	shl    $0x2,%eax
  800496:	01 d0                	add    %edx,%eax
  800498:	01 c0                	add    %eax,%eax
  80049a:	01 d8                	add    %ebx,%eax
  80049c:	83 e8 30             	sub    $0x30,%eax
  80049f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a5:	8a 00                	mov    (%eax),%al
  8004a7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004aa:	83 fb 2f             	cmp    $0x2f,%ebx
  8004ad:	7e 3e                	jle    8004ed <vprintfmt+0xe9>
  8004af:	83 fb 39             	cmp    $0x39,%ebx
  8004b2:	7f 39                	jg     8004ed <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004b4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004b7:	eb d5                	jmp    80048e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8004bc:	83 c0 04             	add    $0x4,%eax
  8004bf:	89 45 14             	mov    %eax,0x14(%ebp)
  8004c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c5:	83 e8 04             	sub    $0x4,%eax
  8004c8:	8b 00                	mov    (%eax),%eax
  8004ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004cd:	eb 1f                	jmp    8004ee <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004d3:	79 83                	jns    800458 <vprintfmt+0x54>
				width = 0;
  8004d5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004dc:	e9 77 ff ff ff       	jmp    800458 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8004e1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8004e8:	e9 6b ff ff ff       	jmp    800458 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8004ed:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8004ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004f2:	0f 89 60 ff ff ff    	jns    800458 <vprintfmt+0x54>
				width = precision, precision = -1;
  8004f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8004fe:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800505:	e9 4e ff ff ff       	jmp    800458 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80050a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80050d:	e9 46 ff ff ff       	jmp    800458 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800512:	8b 45 14             	mov    0x14(%ebp),%eax
  800515:	83 c0 04             	add    $0x4,%eax
  800518:	89 45 14             	mov    %eax,0x14(%ebp)
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	83 e8 04             	sub    $0x4,%eax
  800521:	8b 00                	mov    (%eax),%eax
  800523:	83 ec 08             	sub    $0x8,%esp
  800526:	ff 75 0c             	pushl  0xc(%ebp)
  800529:	50                   	push   %eax
  80052a:	8b 45 08             	mov    0x8(%ebp),%eax
  80052d:	ff d0                	call   *%eax
  80052f:	83 c4 10             	add    $0x10,%esp
			break;
  800532:	e9 89 02 00 00       	jmp    8007c0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800537:	8b 45 14             	mov    0x14(%ebp),%eax
  80053a:	83 c0 04             	add    $0x4,%eax
  80053d:	89 45 14             	mov    %eax,0x14(%ebp)
  800540:	8b 45 14             	mov    0x14(%ebp),%eax
  800543:	83 e8 04             	sub    $0x4,%eax
  800546:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800548:	85 db                	test   %ebx,%ebx
  80054a:	79 02                	jns    80054e <vprintfmt+0x14a>
				err = -err;
  80054c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80054e:	83 fb 64             	cmp    $0x64,%ebx
  800551:	7f 0b                	jg     80055e <vprintfmt+0x15a>
  800553:	8b 34 9d 60 19 80 00 	mov    0x801960(,%ebx,4),%esi
  80055a:	85 f6                	test   %esi,%esi
  80055c:	75 19                	jne    800577 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80055e:	53                   	push   %ebx
  80055f:	68 05 1b 80 00       	push   $0x801b05
  800564:	ff 75 0c             	pushl  0xc(%ebp)
  800567:	ff 75 08             	pushl  0x8(%ebp)
  80056a:	e8 5e 02 00 00       	call   8007cd <printfmt>
  80056f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800572:	e9 49 02 00 00       	jmp    8007c0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800577:	56                   	push   %esi
  800578:	68 0e 1b 80 00       	push   $0x801b0e
  80057d:	ff 75 0c             	pushl  0xc(%ebp)
  800580:	ff 75 08             	pushl  0x8(%ebp)
  800583:	e8 45 02 00 00       	call   8007cd <printfmt>
  800588:	83 c4 10             	add    $0x10,%esp
			break;
  80058b:	e9 30 02 00 00       	jmp    8007c0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800590:	8b 45 14             	mov    0x14(%ebp),%eax
  800593:	83 c0 04             	add    $0x4,%eax
  800596:	89 45 14             	mov    %eax,0x14(%ebp)
  800599:	8b 45 14             	mov    0x14(%ebp),%eax
  80059c:	83 e8 04             	sub    $0x4,%eax
  80059f:	8b 30                	mov    (%eax),%esi
  8005a1:	85 f6                	test   %esi,%esi
  8005a3:	75 05                	jne    8005aa <vprintfmt+0x1a6>
				p = "(null)";
  8005a5:	be 11 1b 80 00       	mov    $0x801b11,%esi
			if (width > 0 && padc != '-')
  8005aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005ae:	7e 6d                	jle    80061d <vprintfmt+0x219>
  8005b0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005b4:	74 67                	je     80061d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b9:	83 ec 08             	sub    $0x8,%esp
  8005bc:	50                   	push   %eax
  8005bd:	56                   	push   %esi
  8005be:	e8 0c 03 00 00       	call   8008cf <strnlen>
  8005c3:	83 c4 10             	add    $0x10,%esp
  8005c6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005c9:	eb 16                	jmp    8005e1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005cb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005cf:	83 ec 08             	sub    $0x8,%esp
  8005d2:	ff 75 0c             	pushl  0xc(%ebp)
  8005d5:	50                   	push   %eax
  8005d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d9:	ff d0                	call   *%eax
  8005db:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005de:	ff 4d e4             	decl   -0x1c(%ebp)
  8005e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e5:	7f e4                	jg     8005cb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8005e7:	eb 34                	jmp    80061d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8005e9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8005ed:	74 1c                	je     80060b <vprintfmt+0x207>
  8005ef:	83 fb 1f             	cmp    $0x1f,%ebx
  8005f2:	7e 05                	jle    8005f9 <vprintfmt+0x1f5>
  8005f4:	83 fb 7e             	cmp    $0x7e,%ebx
  8005f7:	7e 12                	jle    80060b <vprintfmt+0x207>
					putch('?', putdat);
  8005f9:	83 ec 08             	sub    $0x8,%esp
  8005fc:	ff 75 0c             	pushl  0xc(%ebp)
  8005ff:	6a 3f                	push   $0x3f
  800601:	8b 45 08             	mov    0x8(%ebp),%eax
  800604:	ff d0                	call   *%eax
  800606:	83 c4 10             	add    $0x10,%esp
  800609:	eb 0f                	jmp    80061a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80060b:	83 ec 08             	sub    $0x8,%esp
  80060e:	ff 75 0c             	pushl  0xc(%ebp)
  800611:	53                   	push   %ebx
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	ff d0                	call   *%eax
  800617:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80061a:	ff 4d e4             	decl   -0x1c(%ebp)
  80061d:	89 f0                	mov    %esi,%eax
  80061f:	8d 70 01             	lea    0x1(%eax),%esi
  800622:	8a 00                	mov    (%eax),%al
  800624:	0f be d8             	movsbl %al,%ebx
  800627:	85 db                	test   %ebx,%ebx
  800629:	74 24                	je     80064f <vprintfmt+0x24b>
  80062b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80062f:	78 b8                	js     8005e9 <vprintfmt+0x1e5>
  800631:	ff 4d e0             	decl   -0x20(%ebp)
  800634:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800638:	79 af                	jns    8005e9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80063a:	eb 13                	jmp    80064f <vprintfmt+0x24b>
				putch(' ', putdat);
  80063c:	83 ec 08             	sub    $0x8,%esp
  80063f:	ff 75 0c             	pushl  0xc(%ebp)
  800642:	6a 20                	push   $0x20
  800644:	8b 45 08             	mov    0x8(%ebp),%eax
  800647:	ff d0                	call   *%eax
  800649:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80064c:	ff 4d e4             	decl   -0x1c(%ebp)
  80064f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800653:	7f e7                	jg     80063c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800655:	e9 66 01 00 00       	jmp    8007c0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80065a:	83 ec 08             	sub    $0x8,%esp
  80065d:	ff 75 e8             	pushl  -0x18(%ebp)
  800660:	8d 45 14             	lea    0x14(%ebp),%eax
  800663:	50                   	push   %eax
  800664:	e8 3c fd ff ff       	call   8003a5 <getint>
  800669:	83 c4 10             	add    $0x10,%esp
  80066c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80066f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800672:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800675:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800678:	85 d2                	test   %edx,%edx
  80067a:	79 23                	jns    80069f <vprintfmt+0x29b>
				putch('-', putdat);
  80067c:	83 ec 08             	sub    $0x8,%esp
  80067f:	ff 75 0c             	pushl  0xc(%ebp)
  800682:	6a 2d                	push   $0x2d
  800684:	8b 45 08             	mov    0x8(%ebp),%eax
  800687:	ff d0                	call   *%eax
  800689:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80068c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80068f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800692:	f7 d8                	neg    %eax
  800694:	83 d2 00             	adc    $0x0,%edx
  800697:	f7 da                	neg    %edx
  800699:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80069c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80069f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006a6:	e9 bc 00 00 00       	jmp    800767 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006ab:	83 ec 08             	sub    $0x8,%esp
  8006ae:	ff 75 e8             	pushl  -0x18(%ebp)
  8006b1:	8d 45 14             	lea    0x14(%ebp),%eax
  8006b4:	50                   	push   %eax
  8006b5:	e8 84 fc ff ff       	call   80033e <getuint>
  8006ba:	83 c4 10             	add    $0x10,%esp
  8006bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006c3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006ca:	e9 98 00 00 00       	jmp    800767 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006cf:	83 ec 08             	sub    $0x8,%esp
  8006d2:	ff 75 0c             	pushl  0xc(%ebp)
  8006d5:	6a 58                	push   $0x58
  8006d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006da:	ff d0                	call   *%eax
  8006dc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006df:	83 ec 08             	sub    $0x8,%esp
  8006e2:	ff 75 0c             	pushl  0xc(%ebp)
  8006e5:	6a 58                	push   $0x58
  8006e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ea:	ff d0                	call   *%eax
  8006ec:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006ef:	83 ec 08             	sub    $0x8,%esp
  8006f2:	ff 75 0c             	pushl  0xc(%ebp)
  8006f5:	6a 58                	push   $0x58
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	ff d0                	call   *%eax
  8006fc:	83 c4 10             	add    $0x10,%esp
			break;
  8006ff:	e9 bc 00 00 00       	jmp    8007c0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800704:	83 ec 08             	sub    $0x8,%esp
  800707:	ff 75 0c             	pushl  0xc(%ebp)
  80070a:	6a 30                	push   $0x30
  80070c:	8b 45 08             	mov    0x8(%ebp),%eax
  80070f:	ff d0                	call   *%eax
  800711:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800714:	83 ec 08             	sub    $0x8,%esp
  800717:	ff 75 0c             	pushl  0xc(%ebp)
  80071a:	6a 78                	push   $0x78
  80071c:	8b 45 08             	mov    0x8(%ebp),%eax
  80071f:	ff d0                	call   *%eax
  800721:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800724:	8b 45 14             	mov    0x14(%ebp),%eax
  800727:	83 c0 04             	add    $0x4,%eax
  80072a:	89 45 14             	mov    %eax,0x14(%ebp)
  80072d:	8b 45 14             	mov    0x14(%ebp),%eax
  800730:	83 e8 04             	sub    $0x4,%eax
  800733:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800735:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800738:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80073f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800746:	eb 1f                	jmp    800767 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800748:	83 ec 08             	sub    $0x8,%esp
  80074b:	ff 75 e8             	pushl  -0x18(%ebp)
  80074e:	8d 45 14             	lea    0x14(%ebp),%eax
  800751:	50                   	push   %eax
  800752:	e8 e7 fb ff ff       	call   80033e <getuint>
  800757:	83 c4 10             	add    $0x10,%esp
  80075a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80075d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800760:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800767:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80076b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80076e:	83 ec 04             	sub    $0x4,%esp
  800771:	52                   	push   %edx
  800772:	ff 75 e4             	pushl  -0x1c(%ebp)
  800775:	50                   	push   %eax
  800776:	ff 75 f4             	pushl  -0xc(%ebp)
  800779:	ff 75 f0             	pushl  -0x10(%ebp)
  80077c:	ff 75 0c             	pushl  0xc(%ebp)
  80077f:	ff 75 08             	pushl  0x8(%ebp)
  800782:	e8 00 fb ff ff       	call   800287 <printnum>
  800787:	83 c4 20             	add    $0x20,%esp
			break;
  80078a:	eb 34                	jmp    8007c0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80078c:	83 ec 08             	sub    $0x8,%esp
  80078f:	ff 75 0c             	pushl  0xc(%ebp)
  800792:	53                   	push   %ebx
  800793:	8b 45 08             	mov    0x8(%ebp),%eax
  800796:	ff d0                	call   *%eax
  800798:	83 c4 10             	add    $0x10,%esp
			break;
  80079b:	eb 23                	jmp    8007c0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80079d:	83 ec 08             	sub    $0x8,%esp
  8007a0:	ff 75 0c             	pushl  0xc(%ebp)
  8007a3:	6a 25                	push   $0x25
  8007a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a8:	ff d0                	call   *%eax
  8007aa:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007ad:	ff 4d 10             	decl   0x10(%ebp)
  8007b0:	eb 03                	jmp    8007b5 <vprintfmt+0x3b1>
  8007b2:	ff 4d 10             	decl   0x10(%ebp)
  8007b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b8:	48                   	dec    %eax
  8007b9:	8a 00                	mov    (%eax),%al
  8007bb:	3c 25                	cmp    $0x25,%al
  8007bd:	75 f3                	jne    8007b2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007bf:	90                   	nop
		}
	}
  8007c0:	e9 47 fc ff ff       	jmp    80040c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007c5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007c9:	5b                   	pop    %ebx
  8007ca:	5e                   	pop    %esi
  8007cb:	5d                   	pop    %ebp
  8007cc:	c3                   	ret    

008007cd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007cd:	55                   	push   %ebp
  8007ce:	89 e5                	mov    %esp,%ebp
  8007d0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007d3:	8d 45 10             	lea    0x10(%ebp),%eax
  8007d6:	83 c0 04             	add    $0x4,%eax
  8007d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8007df:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e2:	50                   	push   %eax
  8007e3:	ff 75 0c             	pushl  0xc(%ebp)
  8007e6:	ff 75 08             	pushl  0x8(%ebp)
  8007e9:	e8 16 fc ff ff       	call   800404 <vprintfmt>
  8007ee:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8007f1:	90                   	nop
  8007f2:	c9                   	leave  
  8007f3:	c3                   	ret    

008007f4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8007f4:	55                   	push   %ebp
  8007f5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8007f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007fa:	8b 40 08             	mov    0x8(%eax),%eax
  8007fd:	8d 50 01             	lea    0x1(%eax),%edx
  800800:	8b 45 0c             	mov    0xc(%ebp),%eax
  800803:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800806:	8b 45 0c             	mov    0xc(%ebp),%eax
  800809:	8b 10                	mov    (%eax),%edx
  80080b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80080e:	8b 40 04             	mov    0x4(%eax),%eax
  800811:	39 c2                	cmp    %eax,%edx
  800813:	73 12                	jae    800827 <sprintputch+0x33>
		*b->buf++ = ch;
  800815:	8b 45 0c             	mov    0xc(%ebp),%eax
  800818:	8b 00                	mov    (%eax),%eax
  80081a:	8d 48 01             	lea    0x1(%eax),%ecx
  80081d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800820:	89 0a                	mov    %ecx,(%edx)
  800822:	8b 55 08             	mov    0x8(%ebp),%edx
  800825:	88 10                	mov    %dl,(%eax)
}
  800827:	90                   	nop
  800828:	5d                   	pop    %ebp
  800829:	c3                   	ret    

0080082a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80082a:	55                   	push   %ebp
  80082b:	89 e5                	mov    %esp,%ebp
  80082d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800836:	8b 45 0c             	mov    0xc(%ebp),%eax
  800839:	8d 50 ff             	lea    -0x1(%eax),%edx
  80083c:	8b 45 08             	mov    0x8(%ebp),%eax
  80083f:	01 d0                	add    %edx,%eax
  800841:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800844:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80084b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80084f:	74 06                	je     800857 <vsnprintf+0x2d>
  800851:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800855:	7f 07                	jg     80085e <vsnprintf+0x34>
		return -E_INVAL;
  800857:	b8 03 00 00 00       	mov    $0x3,%eax
  80085c:	eb 20                	jmp    80087e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80085e:	ff 75 14             	pushl  0x14(%ebp)
  800861:	ff 75 10             	pushl  0x10(%ebp)
  800864:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800867:	50                   	push   %eax
  800868:	68 f4 07 80 00       	push   $0x8007f4
  80086d:	e8 92 fb ff ff       	call   800404 <vprintfmt>
  800872:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800875:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800878:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80087b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80087e:	c9                   	leave  
  80087f:	c3                   	ret    

00800880 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800880:	55                   	push   %ebp
  800881:	89 e5                	mov    %esp,%ebp
  800883:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800886:	8d 45 10             	lea    0x10(%ebp),%eax
  800889:	83 c0 04             	add    $0x4,%eax
  80088c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80088f:	8b 45 10             	mov    0x10(%ebp),%eax
  800892:	ff 75 f4             	pushl  -0xc(%ebp)
  800895:	50                   	push   %eax
  800896:	ff 75 0c             	pushl  0xc(%ebp)
  800899:	ff 75 08             	pushl  0x8(%ebp)
  80089c:	e8 89 ff ff ff       	call   80082a <vsnprintf>
  8008a1:	83 c4 10             	add    $0x10,%esp
  8008a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008aa:	c9                   	leave  
  8008ab:	c3                   	ret    

008008ac <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008ac:	55                   	push   %ebp
  8008ad:	89 e5                	mov    %esp,%ebp
  8008af:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008b9:	eb 06                	jmp    8008c1 <strlen+0x15>
		n++;
  8008bb:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008be:	ff 45 08             	incl   0x8(%ebp)
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	8a 00                	mov    (%eax),%al
  8008c6:	84 c0                	test   %al,%al
  8008c8:	75 f1                	jne    8008bb <strlen+0xf>
		n++;
	return n;
  8008ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008cd:	c9                   	leave  
  8008ce:	c3                   	ret    

008008cf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008cf:	55                   	push   %ebp
  8008d0:	89 e5                	mov    %esp,%ebp
  8008d2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008dc:	eb 09                	jmp    8008e7 <strnlen+0x18>
		n++;
  8008de:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008e1:	ff 45 08             	incl   0x8(%ebp)
  8008e4:	ff 4d 0c             	decl   0xc(%ebp)
  8008e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008eb:	74 09                	je     8008f6 <strnlen+0x27>
  8008ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f0:	8a 00                	mov    (%eax),%al
  8008f2:	84 c0                	test   %al,%al
  8008f4:	75 e8                	jne    8008de <strnlen+0xf>
		n++;
	return n;
  8008f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008f9:	c9                   	leave  
  8008fa:	c3                   	ret    

008008fb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8008fb:	55                   	push   %ebp
  8008fc:	89 e5                	mov    %esp,%ebp
  8008fe:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800901:	8b 45 08             	mov    0x8(%ebp),%eax
  800904:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800907:	90                   	nop
  800908:	8b 45 08             	mov    0x8(%ebp),%eax
  80090b:	8d 50 01             	lea    0x1(%eax),%edx
  80090e:	89 55 08             	mov    %edx,0x8(%ebp)
  800911:	8b 55 0c             	mov    0xc(%ebp),%edx
  800914:	8d 4a 01             	lea    0x1(%edx),%ecx
  800917:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80091a:	8a 12                	mov    (%edx),%dl
  80091c:	88 10                	mov    %dl,(%eax)
  80091e:	8a 00                	mov    (%eax),%al
  800920:	84 c0                	test   %al,%al
  800922:	75 e4                	jne    800908 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800924:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800927:	c9                   	leave  
  800928:	c3                   	ret    

00800929 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800929:	55                   	push   %ebp
  80092a:	89 e5                	mov    %esp,%ebp
  80092c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800935:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80093c:	eb 1f                	jmp    80095d <strncpy+0x34>
		*dst++ = *src;
  80093e:	8b 45 08             	mov    0x8(%ebp),%eax
  800941:	8d 50 01             	lea    0x1(%eax),%edx
  800944:	89 55 08             	mov    %edx,0x8(%ebp)
  800947:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094a:	8a 12                	mov    (%edx),%dl
  80094c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	8a 00                	mov    (%eax),%al
  800953:	84 c0                	test   %al,%al
  800955:	74 03                	je     80095a <strncpy+0x31>
			src++;
  800957:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80095a:	ff 45 fc             	incl   -0x4(%ebp)
  80095d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800960:	3b 45 10             	cmp    0x10(%ebp),%eax
  800963:	72 d9                	jb     80093e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800965:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800968:	c9                   	leave  
  800969:	c3                   	ret    

0080096a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80096a:	55                   	push   %ebp
  80096b:	89 e5                	mov    %esp,%ebp
  80096d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800976:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80097a:	74 30                	je     8009ac <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80097c:	eb 16                	jmp    800994 <strlcpy+0x2a>
			*dst++ = *src++;
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	8d 50 01             	lea    0x1(%eax),%edx
  800984:	89 55 08             	mov    %edx,0x8(%ebp)
  800987:	8b 55 0c             	mov    0xc(%ebp),%edx
  80098a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80098d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800990:	8a 12                	mov    (%edx),%dl
  800992:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800994:	ff 4d 10             	decl   0x10(%ebp)
  800997:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80099b:	74 09                	je     8009a6 <strlcpy+0x3c>
  80099d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a0:	8a 00                	mov    (%eax),%al
  8009a2:	84 c0                	test   %al,%al
  8009a4:	75 d8                	jne    80097e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8009af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009b2:	29 c2                	sub    %eax,%edx
  8009b4:	89 d0                	mov    %edx,%eax
}
  8009b6:	c9                   	leave  
  8009b7:	c3                   	ret    

008009b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009b8:	55                   	push   %ebp
  8009b9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009bb:	eb 06                	jmp    8009c3 <strcmp+0xb>
		p++, q++;
  8009bd:	ff 45 08             	incl   0x8(%ebp)
  8009c0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c6:	8a 00                	mov    (%eax),%al
  8009c8:	84 c0                	test   %al,%al
  8009ca:	74 0e                	je     8009da <strcmp+0x22>
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	8a 10                	mov    (%eax),%dl
  8009d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d4:	8a 00                	mov    (%eax),%al
  8009d6:	38 c2                	cmp    %al,%dl
  8009d8:	74 e3                	je     8009bd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	8a 00                	mov    (%eax),%al
  8009df:	0f b6 d0             	movzbl %al,%edx
  8009e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e5:	8a 00                	mov    (%eax),%al
  8009e7:	0f b6 c0             	movzbl %al,%eax
  8009ea:	29 c2                	sub    %eax,%edx
  8009ec:	89 d0                	mov    %edx,%eax
}
  8009ee:	5d                   	pop    %ebp
  8009ef:	c3                   	ret    

008009f0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8009f0:	55                   	push   %ebp
  8009f1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8009f3:	eb 09                	jmp    8009fe <strncmp+0xe>
		n--, p++, q++;
  8009f5:	ff 4d 10             	decl   0x10(%ebp)
  8009f8:	ff 45 08             	incl   0x8(%ebp)
  8009fb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8009fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a02:	74 17                	je     800a1b <strncmp+0x2b>
  800a04:	8b 45 08             	mov    0x8(%ebp),%eax
  800a07:	8a 00                	mov    (%eax),%al
  800a09:	84 c0                	test   %al,%al
  800a0b:	74 0e                	je     800a1b <strncmp+0x2b>
  800a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a10:	8a 10                	mov    (%eax),%dl
  800a12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a15:	8a 00                	mov    (%eax),%al
  800a17:	38 c2                	cmp    %al,%dl
  800a19:	74 da                	je     8009f5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a1b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a1f:	75 07                	jne    800a28 <strncmp+0x38>
		return 0;
  800a21:	b8 00 00 00 00       	mov    $0x0,%eax
  800a26:	eb 14                	jmp    800a3c <strncmp+0x4c>
	else
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

00800a3e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a3e:	55                   	push   %ebp
  800a3f:	89 e5                	mov    %esp,%ebp
  800a41:	83 ec 04             	sub    $0x4,%esp
  800a44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a47:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a4a:	eb 12                	jmp    800a5e <strchr+0x20>
		if (*s == c)
  800a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4f:	8a 00                	mov    (%eax),%al
  800a51:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a54:	75 05                	jne    800a5b <strchr+0x1d>
			return (char *) s;
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	eb 11                	jmp    800a6c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a5b:	ff 45 08             	incl   0x8(%ebp)
  800a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a61:	8a 00                	mov    (%eax),%al
  800a63:	84 c0                	test   %al,%al
  800a65:	75 e5                	jne    800a4c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a6c:	c9                   	leave  
  800a6d:	c3                   	ret    

00800a6e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a6e:	55                   	push   %ebp
  800a6f:	89 e5                	mov    %esp,%ebp
  800a71:	83 ec 04             	sub    $0x4,%esp
  800a74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a77:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a7a:	eb 0d                	jmp    800a89 <strfind+0x1b>
		if (*s == c)
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	8a 00                	mov    (%eax),%al
  800a81:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a84:	74 0e                	je     800a94 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800a86:	ff 45 08             	incl   0x8(%ebp)
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	8a 00                	mov    (%eax),%al
  800a8e:	84 c0                	test   %al,%al
  800a90:	75 ea                	jne    800a7c <strfind+0xe>
  800a92:	eb 01                	jmp    800a95 <strfind+0x27>
		if (*s == c)
			break;
  800a94:	90                   	nop
	return (char *) s;
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800a98:	c9                   	leave  
  800a99:	c3                   	ret    

00800a9a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800a9a:	55                   	push   %ebp
  800a9b:	89 e5                	mov    %esp,%ebp
  800a9d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800aa6:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800aac:	eb 0e                	jmp    800abc <memset+0x22>
		*p++ = c;
  800aae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ab1:	8d 50 01             	lea    0x1(%eax),%edx
  800ab4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ab7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aba:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800abc:	ff 4d f8             	decl   -0x8(%ebp)
  800abf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ac3:	79 e9                	jns    800aae <memset+0x14>
		*p++ = c;

	return v;
  800ac5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800adc:	eb 16                	jmp    800af4 <memcpy+0x2a>
		*d++ = *s++;
  800ade:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ae1:	8d 50 01             	lea    0x1(%eax),%edx
  800ae4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ae7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800aea:	8d 4a 01             	lea    0x1(%edx),%ecx
  800aed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800af0:	8a 12                	mov    (%edx),%dl
  800af2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800af4:	8b 45 10             	mov    0x10(%ebp),%eax
  800af7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800afa:	89 55 10             	mov    %edx,0x10(%ebp)
  800afd:	85 c0                	test   %eax,%eax
  800aff:	75 dd                	jne    800ade <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b04:	c9                   	leave  
  800b05:	c3                   	ret    

00800b06 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b06:	55                   	push   %ebp
  800b07:	89 e5                	mov    %esp,%ebp
  800b09:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b1b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b1e:	73 50                	jae    800b70 <memmove+0x6a>
  800b20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b23:	8b 45 10             	mov    0x10(%ebp),%eax
  800b26:	01 d0                	add    %edx,%eax
  800b28:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b2b:	76 43                	jbe    800b70 <memmove+0x6a>
		s += n;
  800b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b30:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b33:	8b 45 10             	mov    0x10(%ebp),%eax
  800b36:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b39:	eb 10                	jmp    800b4b <memmove+0x45>
			*--d = *--s;
  800b3b:	ff 4d f8             	decl   -0x8(%ebp)
  800b3e:	ff 4d fc             	decl   -0x4(%ebp)
  800b41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b44:	8a 10                	mov    (%eax),%dl
  800b46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b49:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b51:	89 55 10             	mov    %edx,0x10(%ebp)
  800b54:	85 c0                	test   %eax,%eax
  800b56:	75 e3                	jne    800b3b <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b58:	eb 23                	jmp    800b7d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b5d:	8d 50 01             	lea    0x1(%eax),%edx
  800b60:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b63:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b66:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b69:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b6c:	8a 12                	mov    (%edx),%dl
  800b6e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b70:	8b 45 10             	mov    0x10(%ebp),%eax
  800b73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b76:	89 55 10             	mov    %edx,0x10(%ebp)
  800b79:	85 c0                	test   %eax,%eax
  800b7b:	75 dd                	jne    800b5a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800b8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b91:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800b94:	eb 2a                	jmp    800bc0 <memcmp+0x3e>
		if (*s1 != *s2)
  800b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b99:	8a 10                	mov    (%eax),%dl
  800b9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b9e:	8a 00                	mov    (%eax),%al
  800ba0:	38 c2                	cmp    %al,%dl
  800ba2:	74 16                	je     800bba <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ba4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba7:	8a 00                	mov    (%eax),%al
  800ba9:	0f b6 d0             	movzbl %al,%edx
  800bac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800baf:	8a 00                	mov    (%eax),%al
  800bb1:	0f b6 c0             	movzbl %al,%eax
  800bb4:	29 c2                	sub    %eax,%edx
  800bb6:	89 d0                	mov    %edx,%eax
  800bb8:	eb 18                	jmp    800bd2 <memcmp+0x50>
		s1++, s2++;
  800bba:	ff 45 fc             	incl   -0x4(%ebp)
  800bbd:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bc0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc6:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc9:	85 c0                	test   %eax,%eax
  800bcb:	75 c9                	jne    800b96 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bcd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bd2:	c9                   	leave  
  800bd3:	c3                   	ret    

00800bd4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bd4:	55                   	push   %ebp
  800bd5:	89 e5                	mov    %esp,%ebp
  800bd7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bda:	8b 55 08             	mov    0x8(%ebp),%edx
  800bdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800be0:	01 d0                	add    %edx,%eax
  800be2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800be5:	eb 15                	jmp    800bfc <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800be7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bea:	8a 00                	mov    (%eax),%al
  800bec:	0f b6 d0             	movzbl %al,%edx
  800bef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf2:	0f b6 c0             	movzbl %al,%eax
  800bf5:	39 c2                	cmp    %eax,%edx
  800bf7:	74 0d                	je     800c06 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800bf9:	ff 45 08             	incl   0x8(%ebp)
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c02:	72 e3                	jb     800be7 <memfind+0x13>
  800c04:	eb 01                	jmp    800c07 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c06:	90                   	nop
	return (void *) s;
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c0a:	c9                   	leave  
  800c0b:	c3                   	ret    

00800c0c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c0c:	55                   	push   %ebp
  800c0d:	89 e5                	mov    %esp,%ebp
  800c0f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c19:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c20:	eb 03                	jmp    800c25 <strtol+0x19>
		s++;
  800c22:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c25:	8b 45 08             	mov    0x8(%ebp),%eax
  800c28:	8a 00                	mov    (%eax),%al
  800c2a:	3c 20                	cmp    $0x20,%al
  800c2c:	74 f4                	je     800c22 <strtol+0x16>
  800c2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c31:	8a 00                	mov    (%eax),%al
  800c33:	3c 09                	cmp    $0x9,%al
  800c35:	74 eb                	je     800c22 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	8a 00                	mov    (%eax),%al
  800c3c:	3c 2b                	cmp    $0x2b,%al
  800c3e:	75 05                	jne    800c45 <strtol+0x39>
		s++;
  800c40:	ff 45 08             	incl   0x8(%ebp)
  800c43:	eb 13                	jmp    800c58 <strtol+0x4c>
	else if (*s == '-')
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	8a 00                	mov    (%eax),%al
  800c4a:	3c 2d                	cmp    $0x2d,%al
  800c4c:	75 0a                	jne    800c58 <strtol+0x4c>
		s++, neg = 1;
  800c4e:	ff 45 08             	incl   0x8(%ebp)
  800c51:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c58:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c5c:	74 06                	je     800c64 <strtol+0x58>
  800c5e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c62:	75 20                	jne    800c84 <strtol+0x78>
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	3c 30                	cmp    $0x30,%al
  800c6b:	75 17                	jne    800c84 <strtol+0x78>
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	40                   	inc    %eax
  800c71:	8a 00                	mov    (%eax),%al
  800c73:	3c 78                	cmp    $0x78,%al
  800c75:	75 0d                	jne    800c84 <strtol+0x78>
		s += 2, base = 16;
  800c77:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c7b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800c82:	eb 28                	jmp    800cac <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800c84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c88:	75 15                	jne    800c9f <strtol+0x93>
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	3c 30                	cmp    $0x30,%al
  800c91:	75 0c                	jne    800c9f <strtol+0x93>
		s++, base = 8;
  800c93:	ff 45 08             	incl   0x8(%ebp)
  800c96:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800c9d:	eb 0d                	jmp    800cac <strtol+0xa0>
	else if (base == 0)
  800c9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca3:	75 07                	jne    800cac <strtol+0xa0>
		base = 10;
  800ca5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	3c 2f                	cmp    $0x2f,%al
  800cb3:	7e 19                	jle    800cce <strtol+0xc2>
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	8a 00                	mov    (%eax),%al
  800cba:	3c 39                	cmp    $0x39,%al
  800cbc:	7f 10                	jg     800cce <strtol+0xc2>
			dig = *s - '0';
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	8a 00                	mov    (%eax),%al
  800cc3:	0f be c0             	movsbl %al,%eax
  800cc6:	83 e8 30             	sub    $0x30,%eax
  800cc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ccc:	eb 42                	jmp    800d10 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8a 00                	mov    (%eax),%al
  800cd3:	3c 60                	cmp    $0x60,%al
  800cd5:	7e 19                	jle    800cf0 <strtol+0xe4>
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	3c 7a                	cmp    $0x7a,%al
  800cde:	7f 10                	jg     800cf0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	0f be c0             	movsbl %al,%eax
  800ce8:	83 e8 57             	sub    $0x57,%eax
  800ceb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cee:	eb 20                	jmp    800d10 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8a 00                	mov    (%eax),%al
  800cf5:	3c 40                	cmp    $0x40,%al
  800cf7:	7e 39                	jle    800d32 <strtol+0x126>
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	8a 00                	mov    (%eax),%al
  800cfe:	3c 5a                	cmp    $0x5a,%al
  800d00:	7f 30                	jg     800d32 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d02:	8b 45 08             	mov    0x8(%ebp),%eax
  800d05:	8a 00                	mov    (%eax),%al
  800d07:	0f be c0             	movsbl %al,%eax
  800d0a:	83 e8 37             	sub    $0x37,%eax
  800d0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d13:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d16:	7d 19                	jge    800d31 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d18:	ff 45 08             	incl   0x8(%ebp)
  800d1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d1e:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d22:	89 c2                	mov    %eax,%edx
  800d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d27:	01 d0                	add    %edx,%eax
  800d29:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d2c:	e9 7b ff ff ff       	jmp    800cac <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d31:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d32:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d36:	74 08                	je     800d40 <strtol+0x134>
		*endptr = (char *) s;
  800d38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3b:	8b 55 08             	mov    0x8(%ebp),%edx
  800d3e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d40:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d44:	74 07                	je     800d4d <strtol+0x141>
  800d46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d49:	f7 d8                	neg    %eax
  800d4b:	eb 03                	jmp    800d50 <strtol+0x144>
  800d4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d50:	c9                   	leave  
  800d51:	c3                   	ret    

00800d52 <ltostr>:

void
ltostr(long value, char *str)
{
  800d52:	55                   	push   %ebp
  800d53:	89 e5                	mov    %esp,%ebp
  800d55:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d58:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d5f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d66:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d6a:	79 13                	jns    800d7f <ltostr+0x2d>
	{
		neg = 1;
  800d6c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d76:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d79:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d7c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800d87:	99                   	cltd   
  800d88:	f7 f9                	idiv   %ecx
  800d8a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800d8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d90:	8d 50 01             	lea    0x1(%eax),%edx
  800d93:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d96:	89 c2                	mov    %eax,%edx
  800d98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9b:	01 d0                	add    %edx,%eax
  800d9d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800da0:	83 c2 30             	add    $0x30,%edx
  800da3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800da5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800da8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dad:	f7 e9                	imul   %ecx
  800daf:	c1 fa 02             	sar    $0x2,%edx
  800db2:	89 c8                	mov    %ecx,%eax
  800db4:	c1 f8 1f             	sar    $0x1f,%eax
  800db7:	29 c2                	sub    %eax,%edx
  800db9:	89 d0                	mov    %edx,%eax
  800dbb:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dbe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dc1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dc6:	f7 e9                	imul   %ecx
  800dc8:	c1 fa 02             	sar    $0x2,%edx
  800dcb:	89 c8                	mov    %ecx,%eax
  800dcd:	c1 f8 1f             	sar    $0x1f,%eax
  800dd0:	29 c2                	sub    %eax,%edx
  800dd2:	89 d0                	mov    %edx,%eax
  800dd4:	c1 e0 02             	shl    $0x2,%eax
  800dd7:	01 d0                	add    %edx,%eax
  800dd9:	01 c0                	add    %eax,%eax
  800ddb:	29 c1                	sub    %eax,%ecx
  800ddd:	89 ca                	mov    %ecx,%edx
  800ddf:	85 d2                	test   %edx,%edx
  800de1:	75 9c                	jne    800d7f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800de3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800dea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ded:	48                   	dec    %eax
  800dee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800df1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800df5:	74 3d                	je     800e34 <ltostr+0xe2>
		start = 1 ;
  800df7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800dfe:	eb 34                	jmp    800e34 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e00:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e06:	01 d0                	add    %edx,%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e13:	01 c2                	add    %eax,%edx
  800e15:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1b:	01 c8                	add    %ecx,%eax
  800e1d:	8a 00                	mov    (%eax),%al
  800e1f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e21:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e27:	01 c2                	add    %eax,%edx
  800e29:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e2c:	88 02                	mov    %al,(%edx)
		start++ ;
  800e2e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e31:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e37:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e3a:	7c c4                	jl     800e00 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e3c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e42:	01 d0                	add    %edx,%eax
  800e44:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e47:	90                   	nop
  800e48:	c9                   	leave  
  800e49:	c3                   	ret    

00800e4a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e4a:	55                   	push   %ebp
  800e4b:	89 e5                	mov    %esp,%ebp
  800e4d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e50:	ff 75 08             	pushl  0x8(%ebp)
  800e53:	e8 54 fa ff ff       	call   8008ac <strlen>
  800e58:	83 c4 04             	add    $0x4,%esp
  800e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e5e:	ff 75 0c             	pushl  0xc(%ebp)
  800e61:	e8 46 fa ff ff       	call   8008ac <strlen>
  800e66:	83 c4 04             	add    $0x4,%esp
  800e69:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e7a:	eb 17                	jmp    800e93 <strcconcat+0x49>
		final[s] = str1[s] ;
  800e7c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e82:	01 c2                	add    %eax,%edx
  800e84:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	01 c8                	add    %ecx,%eax
  800e8c:	8a 00                	mov    (%eax),%al
  800e8e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800e90:	ff 45 fc             	incl   -0x4(%ebp)
  800e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e96:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e99:	7c e1                	jl     800e7c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800e9b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ea2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ea9:	eb 1f                	jmp    800eca <strcconcat+0x80>
		final[s++] = str2[i] ;
  800eab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eae:	8d 50 01             	lea    0x1(%eax),%edx
  800eb1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eb4:	89 c2                	mov    %eax,%edx
  800eb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb9:	01 c2                	add    %eax,%edx
  800ebb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec1:	01 c8                	add    %ecx,%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ec7:	ff 45 f8             	incl   -0x8(%ebp)
  800eca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ecd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ed0:	7c d9                	jl     800eab <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ed2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed8:	01 d0                	add    %edx,%eax
  800eda:	c6 00 00             	movb   $0x0,(%eax)
}
  800edd:	90                   	nop
  800ede:	c9                   	leave  
  800edf:	c3                   	ret    

00800ee0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800ee0:	55                   	push   %ebp
  800ee1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800ee3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800eec:	8b 45 14             	mov    0x14(%ebp),%eax
  800eef:	8b 00                	mov    (%eax),%eax
  800ef1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ef8:	8b 45 10             	mov    0x10(%ebp),%eax
  800efb:	01 d0                	add    %edx,%eax
  800efd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f03:	eb 0c                	jmp    800f11 <strsplit+0x31>
			*string++ = 0;
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	8d 50 01             	lea    0x1(%eax),%edx
  800f0b:	89 55 08             	mov    %edx,0x8(%ebp)
  800f0e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	84 c0                	test   %al,%al
  800f18:	74 18                	je     800f32 <strsplit+0x52>
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	0f be c0             	movsbl %al,%eax
  800f22:	50                   	push   %eax
  800f23:	ff 75 0c             	pushl  0xc(%ebp)
  800f26:	e8 13 fb ff ff       	call   800a3e <strchr>
  800f2b:	83 c4 08             	add    $0x8,%esp
  800f2e:	85 c0                	test   %eax,%eax
  800f30:	75 d3                	jne    800f05 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	84 c0                	test   %al,%al
  800f39:	74 5a                	je     800f95 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3e:	8b 00                	mov    (%eax),%eax
  800f40:	83 f8 0f             	cmp    $0xf,%eax
  800f43:	75 07                	jne    800f4c <strsplit+0x6c>
		{
			return 0;
  800f45:	b8 00 00 00 00       	mov    $0x0,%eax
  800f4a:	eb 66                	jmp    800fb2 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4f:	8b 00                	mov    (%eax),%eax
  800f51:	8d 48 01             	lea    0x1(%eax),%ecx
  800f54:	8b 55 14             	mov    0x14(%ebp),%edx
  800f57:	89 0a                	mov    %ecx,(%edx)
  800f59:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f60:	8b 45 10             	mov    0x10(%ebp),%eax
  800f63:	01 c2                	add    %eax,%edx
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f6a:	eb 03                	jmp    800f6f <strsplit+0x8f>
			string++;
  800f6c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	84 c0                	test   %al,%al
  800f76:	74 8b                	je     800f03 <strsplit+0x23>
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	8a 00                	mov    (%eax),%al
  800f7d:	0f be c0             	movsbl %al,%eax
  800f80:	50                   	push   %eax
  800f81:	ff 75 0c             	pushl  0xc(%ebp)
  800f84:	e8 b5 fa ff ff       	call   800a3e <strchr>
  800f89:	83 c4 08             	add    $0x8,%esp
  800f8c:	85 c0                	test   %eax,%eax
  800f8e:	74 dc                	je     800f6c <strsplit+0x8c>
			string++;
	}
  800f90:	e9 6e ff ff ff       	jmp    800f03 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800f95:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800f96:	8b 45 14             	mov    0x14(%ebp),%eax
  800f99:	8b 00                	mov    (%eax),%eax
  800f9b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fa2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa5:	01 d0                	add    %edx,%eax
  800fa7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fad:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fb2:	c9                   	leave  
  800fb3:	c3                   	ret    

00800fb4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fb4:	55                   	push   %ebp
  800fb5:	89 e5                	mov    %esp,%ebp
  800fb7:	57                   	push   %edi
  800fb8:	56                   	push   %esi
  800fb9:	53                   	push   %ebx
  800fba:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fc3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fc6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fc9:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fcc:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fcf:	cd 30                	int    $0x30
  800fd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800fd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fd7:	83 c4 10             	add    $0x10,%esp
  800fda:	5b                   	pop    %ebx
  800fdb:	5e                   	pop    %esi
  800fdc:	5f                   	pop    %edi
  800fdd:	5d                   	pop    %ebp
  800fde:	c3                   	ret    

00800fdf <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800fdf:	55                   	push   %ebp
  800fe0:	89 e5                	mov    %esp,%ebp
  800fe2:	83 ec 04             	sub    $0x4,%esp
  800fe5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  800feb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  800fef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff2:	6a 00                	push   $0x0
  800ff4:	6a 00                	push   $0x0
  800ff6:	52                   	push   %edx
  800ff7:	ff 75 0c             	pushl  0xc(%ebp)
  800ffa:	50                   	push   %eax
  800ffb:	6a 00                	push   $0x0
  800ffd:	e8 b2 ff ff ff       	call   800fb4 <syscall>
  801002:	83 c4 18             	add    $0x18,%esp
}
  801005:	90                   	nop
  801006:	c9                   	leave  
  801007:	c3                   	ret    

00801008 <sys_cgetc>:

int
sys_cgetc(void)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80100b:	6a 00                	push   $0x0
  80100d:	6a 00                	push   $0x0
  80100f:	6a 00                	push   $0x0
  801011:	6a 00                	push   $0x0
  801013:	6a 00                	push   $0x0
  801015:	6a 01                	push   $0x1
  801017:	e8 98 ff ff ff       	call   800fb4 <syscall>
  80101c:	83 c4 18             	add    $0x18,%esp
}
  80101f:	c9                   	leave  
  801020:	c3                   	ret    

00801021 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801021:	55                   	push   %ebp
  801022:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	6a 00                	push   $0x0
  801029:	6a 00                	push   $0x0
  80102b:	6a 00                	push   $0x0
  80102d:	6a 00                	push   $0x0
  80102f:	50                   	push   %eax
  801030:	6a 05                	push   $0x5
  801032:	e8 7d ff ff ff       	call   800fb4 <syscall>
  801037:	83 c4 18             	add    $0x18,%esp
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80103f:	6a 00                	push   $0x0
  801041:	6a 00                	push   $0x0
  801043:	6a 00                	push   $0x0
  801045:	6a 00                	push   $0x0
  801047:	6a 00                	push   $0x0
  801049:	6a 02                	push   $0x2
  80104b:	e8 64 ff ff ff       	call   800fb4 <syscall>
  801050:	83 c4 18             	add    $0x18,%esp
}
  801053:	c9                   	leave  
  801054:	c3                   	ret    

00801055 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801055:	55                   	push   %ebp
  801056:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801058:	6a 00                	push   $0x0
  80105a:	6a 00                	push   $0x0
  80105c:	6a 00                	push   $0x0
  80105e:	6a 00                	push   $0x0
  801060:	6a 00                	push   $0x0
  801062:	6a 03                	push   $0x3
  801064:	e8 4b ff ff ff       	call   800fb4 <syscall>
  801069:	83 c4 18             	add    $0x18,%esp
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801071:	6a 00                	push   $0x0
  801073:	6a 00                	push   $0x0
  801075:	6a 00                	push   $0x0
  801077:	6a 00                	push   $0x0
  801079:	6a 00                	push   $0x0
  80107b:	6a 04                	push   $0x4
  80107d:	e8 32 ff ff ff       	call   800fb4 <syscall>
  801082:	83 c4 18             	add    $0x18,%esp
}
  801085:	c9                   	leave  
  801086:	c3                   	ret    

00801087 <sys_env_exit>:


void sys_env_exit(void)
{
  801087:	55                   	push   %ebp
  801088:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80108a:	6a 00                	push   $0x0
  80108c:	6a 00                	push   $0x0
  80108e:	6a 00                	push   $0x0
  801090:	6a 00                	push   $0x0
  801092:	6a 00                	push   $0x0
  801094:	6a 06                	push   $0x6
  801096:	e8 19 ff ff ff       	call   800fb4 <syscall>
  80109b:	83 c4 18             	add    $0x18,%esp
}
  80109e:	90                   	nop
  80109f:	c9                   	leave  
  8010a0:	c3                   	ret    

008010a1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010a1:	55                   	push   %ebp
  8010a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 00                	push   $0x0
  8010b0:	52                   	push   %edx
  8010b1:	50                   	push   %eax
  8010b2:	6a 07                	push   $0x7
  8010b4:	e8 fb fe ff ff       	call   800fb4 <syscall>
  8010b9:	83 c4 18             	add    $0x18,%esp
}
  8010bc:	c9                   	leave  
  8010bd:	c3                   	ret    

008010be <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010be:	55                   	push   %ebp
  8010bf:	89 e5                	mov    %esp,%ebp
  8010c1:	56                   	push   %esi
  8010c2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010c3:	8b 75 18             	mov    0x18(%ebp),%esi
  8010c6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	56                   	push   %esi
  8010d3:	53                   	push   %ebx
  8010d4:	51                   	push   %ecx
  8010d5:	52                   	push   %edx
  8010d6:	50                   	push   %eax
  8010d7:	6a 08                	push   $0x8
  8010d9:	e8 d6 fe ff ff       	call   800fb4 <syscall>
  8010de:	83 c4 18             	add    $0x18,%esp
}
  8010e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010e4:	5b                   	pop    %ebx
  8010e5:	5e                   	pop    %esi
  8010e6:	5d                   	pop    %ebp
  8010e7:	c3                   	ret    

008010e8 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8010e8:	55                   	push   %ebp
  8010e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8010eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	6a 00                	push   $0x0
  8010f3:	6a 00                	push   $0x0
  8010f5:	6a 00                	push   $0x0
  8010f7:	52                   	push   %edx
  8010f8:	50                   	push   %eax
  8010f9:	6a 09                	push   $0x9
  8010fb:	e8 b4 fe ff ff       	call   800fb4 <syscall>
  801100:	83 c4 18             	add    $0x18,%esp
}
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	6a 00                	push   $0x0
  80110e:	ff 75 0c             	pushl  0xc(%ebp)
  801111:	ff 75 08             	pushl  0x8(%ebp)
  801114:	6a 0a                	push   $0xa
  801116:	e8 99 fe ff ff       	call   800fb4 <syscall>
  80111b:	83 c4 18             	add    $0x18,%esp
}
  80111e:	c9                   	leave  
  80111f:	c3                   	ret    

00801120 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801123:	6a 00                	push   $0x0
  801125:	6a 00                	push   $0x0
  801127:	6a 00                	push   $0x0
  801129:	6a 00                	push   $0x0
  80112b:	6a 00                	push   $0x0
  80112d:	6a 0b                	push   $0xb
  80112f:	e8 80 fe ff ff       	call   800fb4 <syscall>
  801134:	83 c4 18             	add    $0x18,%esp
}
  801137:	c9                   	leave  
  801138:	c3                   	ret    

00801139 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801139:	55                   	push   %ebp
  80113a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80113c:	6a 00                	push   $0x0
  80113e:	6a 00                	push   $0x0
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	6a 00                	push   $0x0
  801146:	6a 0c                	push   $0xc
  801148:	e8 67 fe ff ff       	call   800fb4 <syscall>
  80114d:	83 c4 18             	add    $0x18,%esp
}
  801150:	c9                   	leave  
  801151:	c3                   	ret    

00801152 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801152:	55                   	push   %ebp
  801153:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801155:	6a 00                	push   $0x0
  801157:	6a 00                	push   $0x0
  801159:	6a 00                	push   $0x0
  80115b:	6a 00                	push   $0x0
  80115d:	6a 00                	push   $0x0
  80115f:	6a 0d                	push   $0xd
  801161:	e8 4e fe ff ff       	call   800fb4 <syscall>
  801166:	83 c4 18             	add    $0x18,%esp
}
  801169:	c9                   	leave  
  80116a:	c3                   	ret    

0080116b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80116b:	55                   	push   %ebp
  80116c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80116e:	6a 00                	push   $0x0
  801170:	6a 00                	push   $0x0
  801172:	6a 00                	push   $0x0
  801174:	ff 75 0c             	pushl  0xc(%ebp)
  801177:	ff 75 08             	pushl  0x8(%ebp)
  80117a:	6a 11                	push   $0x11
  80117c:	e8 33 fe ff ff       	call   800fb4 <syscall>
  801181:	83 c4 18             	add    $0x18,%esp
	return;
  801184:	90                   	nop
}
  801185:	c9                   	leave  
  801186:	c3                   	ret    

00801187 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80118a:	6a 00                	push   $0x0
  80118c:	6a 00                	push   $0x0
  80118e:	6a 00                	push   $0x0
  801190:	ff 75 0c             	pushl  0xc(%ebp)
  801193:	ff 75 08             	pushl  0x8(%ebp)
  801196:	6a 12                	push   $0x12
  801198:	e8 17 fe ff ff       	call   800fb4 <syscall>
  80119d:	83 c4 18             	add    $0x18,%esp
	return ;
  8011a0:	90                   	nop
}
  8011a1:	c9                   	leave  
  8011a2:	c3                   	ret    

008011a3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011a3:	55                   	push   %ebp
  8011a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 00                	push   $0x0
  8011b0:	6a 0e                	push   $0xe
  8011b2:	e8 fd fd ff ff       	call   800fb4 <syscall>
  8011b7:	83 c4 18             	add    $0x18,%esp
}
  8011ba:	c9                   	leave  
  8011bb:	c3                   	ret    

008011bc <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011bc:	55                   	push   %ebp
  8011bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	ff 75 08             	pushl  0x8(%ebp)
  8011ca:	6a 0f                	push   $0xf
  8011cc:	e8 e3 fd ff ff       	call   800fb4 <syscall>
  8011d1:	83 c4 18             	add    $0x18,%esp
}
  8011d4:	c9                   	leave  
  8011d5:	c3                   	ret    

008011d6 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 00                	push   $0x0
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 10                	push   $0x10
  8011e5:	e8 ca fd ff ff       	call   800fb4 <syscall>
  8011ea:	83 c4 18             	add    $0x18,%esp
}
  8011ed:	90                   	nop
  8011ee:	c9                   	leave  
  8011ef:	c3                   	ret    

008011f0 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8011f0:	55                   	push   %ebp
  8011f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8011f3:	6a 00                	push   $0x0
  8011f5:	6a 00                	push   $0x0
  8011f7:	6a 00                	push   $0x0
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 14                	push   $0x14
  8011ff:	e8 b0 fd ff ff       	call   800fb4 <syscall>
  801204:	83 c4 18             	add    $0x18,%esp
}
  801207:	90                   	nop
  801208:	c9                   	leave  
  801209:	c3                   	ret    

0080120a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80120a:	55                   	push   %ebp
  80120b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80120d:	6a 00                	push   $0x0
  80120f:	6a 00                	push   $0x0
  801211:	6a 00                	push   $0x0
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	6a 15                	push   $0x15
  801219:	e8 96 fd ff ff       	call   800fb4 <syscall>
  80121e:	83 c4 18             	add    $0x18,%esp
}
  801221:	90                   	nop
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <sys_cputc>:


void
sys_cputc(const char c)
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
  801227:	83 ec 04             	sub    $0x4,%esp
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801230:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801234:	6a 00                	push   $0x0
  801236:	6a 00                	push   $0x0
  801238:	6a 00                	push   $0x0
  80123a:	6a 00                	push   $0x0
  80123c:	50                   	push   %eax
  80123d:	6a 16                	push   $0x16
  80123f:	e8 70 fd ff ff       	call   800fb4 <syscall>
  801244:	83 c4 18             	add    $0x18,%esp
}
  801247:	90                   	nop
  801248:	c9                   	leave  
  801249:	c3                   	ret    

0080124a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80124a:	55                   	push   %ebp
  80124b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 17                	push   $0x17
  801259:	e8 56 fd ff ff       	call   800fb4 <syscall>
  80125e:	83 c4 18             	add    $0x18,%esp
}
  801261:	90                   	nop
  801262:	c9                   	leave  
  801263:	c3                   	ret    

00801264 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801264:	55                   	push   %ebp
  801265:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	ff 75 0c             	pushl  0xc(%ebp)
  801273:	50                   	push   %eax
  801274:	6a 18                	push   $0x18
  801276:	e8 39 fd ff ff       	call   800fb4 <syscall>
  80127b:	83 c4 18             	add    $0x18,%esp
}
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801283:	8b 55 0c             	mov    0xc(%ebp),%edx
  801286:	8b 45 08             	mov    0x8(%ebp),%eax
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	52                   	push   %edx
  801290:	50                   	push   %eax
  801291:	6a 1b                	push   $0x1b
  801293:	e8 1c fd ff ff       	call   800fb4 <syscall>
  801298:	83 c4 18             	add    $0x18,%esp
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	52                   	push   %edx
  8012ad:	50                   	push   %eax
  8012ae:	6a 19                	push   $0x19
  8012b0:	e8 ff fc ff ff       	call   800fb4 <syscall>
  8012b5:	83 c4 18             	add    $0x18,%esp
}
  8012b8:	90                   	nop
  8012b9:	c9                   	leave  
  8012ba:	c3                   	ret    

008012bb <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 00                	push   $0x0
  8012ca:	52                   	push   %edx
  8012cb:	50                   	push   %eax
  8012cc:	6a 1a                	push   $0x1a
  8012ce:	e8 e1 fc ff ff       	call   800fb4 <syscall>
  8012d3:	83 c4 18             	add    $0x18,%esp
}
  8012d6:	90                   	nop
  8012d7:	c9                   	leave  
  8012d8:	c3                   	ret    

008012d9 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
  8012dc:	83 ec 04             	sub    $0x4,%esp
  8012df:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e2:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8012e5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012e8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	6a 00                	push   $0x0
  8012f1:	51                   	push   %ecx
  8012f2:	52                   	push   %edx
  8012f3:	ff 75 0c             	pushl  0xc(%ebp)
  8012f6:	50                   	push   %eax
  8012f7:	6a 1c                	push   $0x1c
  8012f9:	e8 b6 fc ff ff       	call   800fb4 <syscall>
  8012fe:	83 c4 18             	add    $0x18,%esp
}
  801301:	c9                   	leave  
  801302:	c3                   	ret    

00801303 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801303:	55                   	push   %ebp
  801304:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801306:	8b 55 0c             	mov    0xc(%ebp),%edx
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	52                   	push   %edx
  801313:	50                   	push   %eax
  801314:	6a 1d                	push   $0x1d
  801316:	e8 99 fc ff ff       	call   800fb4 <syscall>
  80131b:	83 c4 18             	add    $0x18,%esp
}
  80131e:	c9                   	leave  
  80131f:	c3                   	ret    

00801320 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801320:	55                   	push   %ebp
  801321:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801323:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801326:	8b 55 0c             	mov    0xc(%ebp),%edx
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	51                   	push   %ecx
  801331:	52                   	push   %edx
  801332:	50                   	push   %eax
  801333:	6a 1e                	push   $0x1e
  801335:	e8 7a fc ff ff       	call   800fb4 <syscall>
  80133a:	83 c4 18             	add    $0x18,%esp
}
  80133d:	c9                   	leave  
  80133e:	c3                   	ret    

0080133f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80133f:	55                   	push   %ebp
  801340:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801342:	8b 55 0c             	mov    0xc(%ebp),%edx
  801345:	8b 45 08             	mov    0x8(%ebp),%eax
  801348:	6a 00                	push   $0x0
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	52                   	push   %edx
  80134f:	50                   	push   %eax
  801350:	6a 1f                	push   $0x1f
  801352:	e8 5d fc ff ff       	call   800fb4 <syscall>
  801357:	83 c4 18             	add    $0x18,%esp
}
  80135a:	c9                   	leave  
  80135b:	c3                   	ret    

0080135c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 20                	push   $0x20
  80136b:	e8 44 fc ff ff       	call   800fb4 <syscall>
  801370:	83 c4 18             	add    $0x18,%esp
}
  801373:	c9                   	leave  
  801374:	c3                   	ret    

00801375 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801375:	55                   	push   %ebp
  801376:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	ff 75 10             	pushl  0x10(%ebp)
  801382:	ff 75 0c             	pushl  0xc(%ebp)
  801385:	50                   	push   %eax
  801386:	6a 21                	push   $0x21
  801388:	e8 27 fc ff ff       	call   800fb4 <syscall>
  80138d:	83 c4 18             	add    $0x18,%esp
}
  801390:	c9                   	leave  
  801391:	c3                   	ret    

00801392 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	50                   	push   %eax
  8013a1:	6a 22                	push   $0x22
  8013a3:	e8 0c fc ff ff       	call   800fb4 <syscall>
  8013a8:	83 c4 18             	add    $0x18,%esp
}
  8013ab:	90                   	nop
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	50                   	push   %eax
  8013bd:	6a 23                	push   $0x23
  8013bf:	e8 f0 fb ff ff       	call   800fb4 <syscall>
  8013c4:	83 c4 18             	add    $0x18,%esp
}
  8013c7:	90                   	nop
  8013c8:	c9                   	leave  
  8013c9:	c3                   	ret    

008013ca <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
  8013cd:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013d0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013d3:	8d 50 04             	lea    0x4(%eax),%edx
  8013d6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	52                   	push   %edx
  8013e0:	50                   	push   %eax
  8013e1:	6a 24                	push   $0x24
  8013e3:	e8 cc fb ff ff       	call   800fb4 <syscall>
  8013e8:	83 c4 18             	add    $0x18,%esp
	return result;
  8013eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013f4:	89 01                	mov    %eax,(%ecx)
  8013f6:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	c9                   	leave  
  8013fd:	c2 04 00             	ret    $0x4

00801400 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801400:	55                   	push   %ebp
  801401:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	ff 75 10             	pushl  0x10(%ebp)
  80140a:	ff 75 0c             	pushl  0xc(%ebp)
  80140d:	ff 75 08             	pushl  0x8(%ebp)
  801410:	6a 13                	push   $0x13
  801412:	e8 9d fb ff ff       	call   800fb4 <syscall>
  801417:	83 c4 18             	add    $0x18,%esp
	return ;
  80141a:	90                   	nop
}
  80141b:	c9                   	leave  
  80141c:	c3                   	ret    

0080141d <sys_rcr2>:
uint32 sys_rcr2()
{
  80141d:	55                   	push   %ebp
  80141e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	6a 25                	push   $0x25
  80142c:	e8 83 fb ff ff       	call   800fb4 <syscall>
  801431:	83 c4 18             	add    $0x18,%esp
}
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
  801439:	83 ec 04             	sub    $0x4,%esp
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801442:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	50                   	push   %eax
  80144f:	6a 26                	push   $0x26
  801451:	e8 5e fb ff ff       	call   800fb4 <syscall>
  801456:	83 c4 18             	add    $0x18,%esp
	return ;
  801459:	90                   	nop
}
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <rsttst>:
void rsttst()
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 28                	push   $0x28
  80146b:	e8 44 fb ff ff       	call   800fb4 <syscall>
  801470:	83 c4 18             	add    $0x18,%esp
	return ;
  801473:	90                   	nop
}
  801474:	c9                   	leave  
  801475:	c3                   	ret    

00801476 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801476:	55                   	push   %ebp
  801477:	89 e5                	mov    %esp,%ebp
  801479:	83 ec 04             	sub    $0x4,%esp
  80147c:	8b 45 14             	mov    0x14(%ebp),%eax
  80147f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801482:	8b 55 18             	mov    0x18(%ebp),%edx
  801485:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801489:	52                   	push   %edx
  80148a:	50                   	push   %eax
  80148b:	ff 75 10             	pushl  0x10(%ebp)
  80148e:	ff 75 0c             	pushl  0xc(%ebp)
  801491:	ff 75 08             	pushl  0x8(%ebp)
  801494:	6a 27                	push   $0x27
  801496:	e8 19 fb ff ff       	call   800fb4 <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
	return ;
  80149e:	90                   	nop
}
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <chktst>:
void chktst(uint32 n)
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	ff 75 08             	pushl  0x8(%ebp)
  8014af:	6a 29                	push   $0x29
  8014b1:	e8 fe fa ff ff       	call   800fb4 <syscall>
  8014b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b9:	90                   	nop
}
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <inctst>:

void inctst()
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 2a                	push   $0x2a
  8014cb:	e8 e4 fa ff ff       	call   800fb4 <syscall>
  8014d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d3:	90                   	nop
}
  8014d4:	c9                   	leave  
  8014d5:	c3                   	ret    

008014d6 <gettst>:
uint32 gettst()
{
  8014d6:	55                   	push   %ebp
  8014d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 2b                	push   $0x2b
  8014e5:	e8 ca fa ff ff       	call   800fb4 <syscall>
  8014ea:	83 c4 18             	add    $0x18,%esp
}
  8014ed:	c9                   	leave  
  8014ee:	c3                   	ret    

008014ef <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
  8014f2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 2c                	push   $0x2c
  801501:	e8 ae fa ff ff       	call   800fb4 <syscall>
  801506:	83 c4 18             	add    $0x18,%esp
  801509:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80150c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801510:	75 07                	jne    801519 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801512:	b8 01 00 00 00       	mov    $0x1,%eax
  801517:	eb 05                	jmp    80151e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801519:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
  801523:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 2c                	push   $0x2c
  801532:	e8 7d fa ff ff       	call   800fb4 <syscall>
  801537:	83 c4 18             	add    $0x18,%esp
  80153a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80153d:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801541:	75 07                	jne    80154a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801543:	b8 01 00 00 00       	mov    $0x1,%eax
  801548:	eb 05                	jmp    80154f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80154a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80154f:	c9                   	leave  
  801550:	c3                   	ret    

00801551 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
  801554:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 2c                	push   $0x2c
  801563:	e8 4c fa ff ff       	call   800fb4 <syscall>
  801568:	83 c4 18             	add    $0x18,%esp
  80156b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80156e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801572:	75 07                	jne    80157b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801574:	b8 01 00 00 00       	mov    $0x1,%eax
  801579:	eb 05                	jmp    801580 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80157b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 2c                	push   $0x2c
  801594:	e8 1b fa ff ff       	call   800fb4 <syscall>
  801599:	83 c4 18             	add    $0x18,%esp
  80159c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80159f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015a3:	75 07                	jne    8015ac <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8015aa:	eb 05                	jmp    8015b1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	ff 75 08             	pushl  0x8(%ebp)
  8015c1:	6a 2d                	push   $0x2d
  8015c3:	e8 ec f9 ff ff       	call   800fb4 <syscall>
  8015c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8015cb:	90                   	nop
}
  8015cc:	c9                   	leave  
  8015cd:	c3                   	ret    
  8015ce:	66 90                	xchg   %ax,%ax

008015d0 <__udivdi3>:
  8015d0:	55                   	push   %ebp
  8015d1:	57                   	push   %edi
  8015d2:	56                   	push   %esi
  8015d3:	53                   	push   %ebx
  8015d4:	83 ec 1c             	sub    $0x1c,%esp
  8015d7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8015db:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8015df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8015e3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8015e7:	89 ca                	mov    %ecx,%edx
  8015e9:	89 f8                	mov    %edi,%eax
  8015eb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8015ef:	85 f6                	test   %esi,%esi
  8015f1:	75 2d                	jne    801620 <__udivdi3+0x50>
  8015f3:	39 cf                	cmp    %ecx,%edi
  8015f5:	77 65                	ja     80165c <__udivdi3+0x8c>
  8015f7:	89 fd                	mov    %edi,%ebp
  8015f9:	85 ff                	test   %edi,%edi
  8015fb:	75 0b                	jne    801608 <__udivdi3+0x38>
  8015fd:	b8 01 00 00 00       	mov    $0x1,%eax
  801602:	31 d2                	xor    %edx,%edx
  801604:	f7 f7                	div    %edi
  801606:	89 c5                	mov    %eax,%ebp
  801608:	31 d2                	xor    %edx,%edx
  80160a:	89 c8                	mov    %ecx,%eax
  80160c:	f7 f5                	div    %ebp
  80160e:	89 c1                	mov    %eax,%ecx
  801610:	89 d8                	mov    %ebx,%eax
  801612:	f7 f5                	div    %ebp
  801614:	89 cf                	mov    %ecx,%edi
  801616:	89 fa                	mov    %edi,%edx
  801618:	83 c4 1c             	add    $0x1c,%esp
  80161b:	5b                   	pop    %ebx
  80161c:	5e                   	pop    %esi
  80161d:	5f                   	pop    %edi
  80161e:	5d                   	pop    %ebp
  80161f:	c3                   	ret    
  801620:	39 ce                	cmp    %ecx,%esi
  801622:	77 28                	ja     80164c <__udivdi3+0x7c>
  801624:	0f bd fe             	bsr    %esi,%edi
  801627:	83 f7 1f             	xor    $0x1f,%edi
  80162a:	75 40                	jne    80166c <__udivdi3+0x9c>
  80162c:	39 ce                	cmp    %ecx,%esi
  80162e:	72 0a                	jb     80163a <__udivdi3+0x6a>
  801630:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801634:	0f 87 9e 00 00 00    	ja     8016d8 <__udivdi3+0x108>
  80163a:	b8 01 00 00 00       	mov    $0x1,%eax
  80163f:	89 fa                	mov    %edi,%edx
  801641:	83 c4 1c             	add    $0x1c,%esp
  801644:	5b                   	pop    %ebx
  801645:	5e                   	pop    %esi
  801646:	5f                   	pop    %edi
  801647:	5d                   	pop    %ebp
  801648:	c3                   	ret    
  801649:	8d 76 00             	lea    0x0(%esi),%esi
  80164c:	31 ff                	xor    %edi,%edi
  80164e:	31 c0                	xor    %eax,%eax
  801650:	89 fa                	mov    %edi,%edx
  801652:	83 c4 1c             	add    $0x1c,%esp
  801655:	5b                   	pop    %ebx
  801656:	5e                   	pop    %esi
  801657:	5f                   	pop    %edi
  801658:	5d                   	pop    %ebp
  801659:	c3                   	ret    
  80165a:	66 90                	xchg   %ax,%ax
  80165c:	89 d8                	mov    %ebx,%eax
  80165e:	f7 f7                	div    %edi
  801660:	31 ff                	xor    %edi,%edi
  801662:	89 fa                	mov    %edi,%edx
  801664:	83 c4 1c             	add    $0x1c,%esp
  801667:	5b                   	pop    %ebx
  801668:	5e                   	pop    %esi
  801669:	5f                   	pop    %edi
  80166a:	5d                   	pop    %ebp
  80166b:	c3                   	ret    
  80166c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801671:	89 eb                	mov    %ebp,%ebx
  801673:	29 fb                	sub    %edi,%ebx
  801675:	89 f9                	mov    %edi,%ecx
  801677:	d3 e6                	shl    %cl,%esi
  801679:	89 c5                	mov    %eax,%ebp
  80167b:	88 d9                	mov    %bl,%cl
  80167d:	d3 ed                	shr    %cl,%ebp
  80167f:	89 e9                	mov    %ebp,%ecx
  801681:	09 f1                	or     %esi,%ecx
  801683:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801687:	89 f9                	mov    %edi,%ecx
  801689:	d3 e0                	shl    %cl,%eax
  80168b:	89 c5                	mov    %eax,%ebp
  80168d:	89 d6                	mov    %edx,%esi
  80168f:	88 d9                	mov    %bl,%cl
  801691:	d3 ee                	shr    %cl,%esi
  801693:	89 f9                	mov    %edi,%ecx
  801695:	d3 e2                	shl    %cl,%edx
  801697:	8b 44 24 08          	mov    0x8(%esp),%eax
  80169b:	88 d9                	mov    %bl,%cl
  80169d:	d3 e8                	shr    %cl,%eax
  80169f:	09 c2                	or     %eax,%edx
  8016a1:	89 d0                	mov    %edx,%eax
  8016a3:	89 f2                	mov    %esi,%edx
  8016a5:	f7 74 24 0c          	divl   0xc(%esp)
  8016a9:	89 d6                	mov    %edx,%esi
  8016ab:	89 c3                	mov    %eax,%ebx
  8016ad:	f7 e5                	mul    %ebp
  8016af:	39 d6                	cmp    %edx,%esi
  8016b1:	72 19                	jb     8016cc <__udivdi3+0xfc>
  8016b3:	74 0b                	je     8016c0 <__udivdi3+0xf0>
  8016b5:	89 d8                	mov    %ebx,%eax
  8016b7:	31 ff                	xor    %edi,%edi
  8016b9:	e9 58 ff ff ff       	jmp    801616 <__udivdi3+0x46>
  8016be:	66 90                	xchg   %ax,%ax
  8016c0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8016c4:	89 f9                	mov    %edi,%ecx
  8016c6:	d3 e2                	shl    %cl,%edx
  8016c8:	39 c2                	cmp    %eax,%edx
  8016ca:	73 e9                	jae    8016b5 <__udivdi3+0xe5>
  8016cc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8016cf:	31 ff                	xor    %edi,%edi
  8016d1:	e9 40 ff ff ff       	jmp    801616 <__udivdi3+0x46>
  8016d6:	66 90                	xchg   %ax,%ax
  8016d8:	31 c0                	xor    %eax,%eax
  8016da:	e9 37 ff ff ff       	jmp    801616 <__udivdi3+0x46>
  8016df:	90                   	nop

008016e0 <__umoddi3>:
  8016e0:	55                   	push   %ebp
  8016e1:	57                   	push   %edi
  8016e2:	56                   	push   %esi
  8016e3:	53                   	push   %ebx
  8016e4:	83 ec 1c             	sub    $0x1c,%esp
  8016e7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8016eb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8016ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016f3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8016f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8016fb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8016ff:	89 f3                	mov    %esi,%ebx
  801701:	89 fa                	mov    %edi,%edx
  801703:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801707:	89 34 24             	mov    %esi,(%esp)
  80170a:	85 c0                	test   %eax,%eax
  80170c:	75 1a                	jne    801728 <__umoddi3+0x48>
  80170e:	39 f7                	cmp    %esi,%edi
  801710:	0f 86 a2 00 00 00    	jbe    8017b8 <__umoddi3+0xd8>
  801716:	89 c8                	mov    %ecx,%eax
  801718:	89 f2                	mov    %esi,%edx
  80171a:	f7 f7                	div    %edi
  80171c:	89 d0                	mov    %edx,%eax
  80171e:	31 d2                	xor    %edx,%edx
  801720:	83 c4 1c             	add    $0x1c,%esp
  801723:	5b                   	pop    %ebx
  801724:	5e                   	pop    %esi
  801725:	5f                   	pop    %edi
  801726:	5d                   	pop    %ebp
  801727:	c3                   	ret    
  801728:	39 f0                	cmp    %esi,%eax
  80172a:	0f 87 ac 00 00 00    	ja     8017dc <__umoddi3+0xfc>
  801730:	0f bd e8             	bsr    %eax,%ebp
  801733:	83 f5 1f             	xor    $0x1f,%ebp
  801736:	0f 84 ac 00 00 00    	je     8017e8 <__umoddi3+0x108>
  80173c:	bf 20 00 00 00       	mov    $0x20,%edi
  801741:	29 ef                	sub    %ebp,%edi
  801743:	89 fe                	mov    %edi,%esi
  801745:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801749:	89 e9                	mov    %ebp,%ecx
  80174b:	d3 e0                	shl    %cl,%eax
  80174d:	89 d7                	mov    %edx,%edi
  80174f:	89 f1                	mov    %esi,%ecx
  801751:	d3 ef                	shr    %cl,%edi
  801753:	09 c7                	or     %eax,%edi
  801755:	89 e9                	mov    %ebp,%ecx
  801757:	d3 e2                	shl    %cl,%edx
  801759:	89 14 24             	mov    %edx,(%esp)
  80175c:	89 d8                	mov    %ebx,%eax
  80175e:	d3 e0                	shl    %cl,%eax
  801760:	89 c2                	mov    %eax,%edx
  801762:	8b 44 24 08          	mov    0x8(%esp),%eax
  801766:	d3 e0                	shl    %cl,%eax
  801768:	89 44 24 04          	mov    %eax,0x4(%esp)
  80176c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801770:	89 f1                	mov    %esi,%ecx
  801772:	d3 e8                	shr    %cl,%eax
  801774:	09 d0                	or     %edx,%eax
  801776:	d3 eb                	shr    %cl,%ebx
  801778:	89 da                	mov    %ebx,%edx
  80177a:	f7 f7                	div    %edi
  80177c:	89 d3                	mov    %edx,%ebx
  80177e:	f7 24 24             	mull   (%esp)
  801781:	89 c6                	mov    %eax,%esi
  801783:	89 d1                	mov    %edx,%ecx
  801785:	39 d3                	cmp    %edx,%ebx
  801787:	0f 82 87 00 00 00    	jb     801814 <__umoddi3+0x134>
  80178d:	0f 84 91 00 00 00    	je     801824 <__umoddi3+0x144>
  801793:	8b 54 24 04          	mov    0x4(%esp),%edx
  801797:	29 f2                	sub    %esi,%edx
  801799:	19 cb                	sbb    %ecx,%ebx
  80179b:	89 d8                	mov    %ebx,%eax
  80179d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017a1:	d3 e0                	shl    %cl,%eax
  8017a3:	89 e9                	mov    %ebp,%ecx
  8017a5:	d3 ea                	shr    %cl,%edx
  8017a7:	09 d0                	or     %edx,%eax
  8017a9:	89 e9                	mov    %ebp,%ecx
  8017ab:	d3 eb                	shr    %cl,%ebx
  8017ad:	89 da                	mov    %ebx,%edx
  8017af:	83 c4 1c             	add    $0x1c,%esp
  8017b2:	5b                   	pop    %ebx
  8017b3:	5e                   	pop    %esi
  8017b4:	5f                   	pop    %edi
  8017b5:	5d                   	pop    %ebp
  8017b6:	c3                   	ret    
  8017b7:	90                   	nop
  8017b8:	89 fd                	mov    %edi,%ebp
  8017ba:	85 ff                	test   %edi,%edi
  8017bc:	75 0b                	jne    8017c9 <__umoddi3+0xe9>
  8017be:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c3:	31 d2                	xor    %edx,%edx
  8017c5:	f7 f7                	div    %edi
  8017c7:	89 c5                	mov    %eax,%ebp
  8017c9:	89 f0                	mov    %esi,%eax
  8017cb:	31 d2                	xor    %edx,%edx
  8017cd:	f7 f5                	div    %ebp
  8017cf:	89 c8                	mov    %ecx,%eax
  8017d1:	f7 f5                	div    %ebp
  8017d3:	89 d0                	mov    %edx,%eax
  8017d5:	e9 44 ff ff ff       	jmp    80171e <__umoddi3+0x3e>
  8017da:	66 90                	xchg   %ax,%ax
  8017dc:	89 c8                	mov    %ecx,%eax
  8017de:	89 f2                	mov    %esi,%edx
  8017e0:	83 c4 1c             	add    $0x1c,%esp
  8017e3:	5b                   	pop    %ebx
  8017e4:	5e                   	pop    %esi
  8017e5:	5f                   	pop    %edi
  8017e6:	5d                   	pop    %ebp
  8017e7:	c3                   	ret    
  8017e8:	3b 04 24             	cmp    (%esp),%eax
  8017eb:	72 06                	jb     8017f3 <__umoddi3+0x113>
  8017ed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8017f1:	77 0f                	ja     801802 <__umoddi3+0x122>
  8017f3:	89 f2                	mov    %esi,%edx
  8017f5:	29 f9                	sub    %edi,%ecx
  8017f7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8017fb:	89 14 24             	mov    %edx,(%esp)
  8017fe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801802:	8b 44 24 04          	mov    0x4(%esp),%eax
  801806:	8b 14 24             	mov    (%esp),%edx
  801809:	83 c4 1c             	add    $0x1c,%esp
  80180c:	5b                   	pop    %ebx
  80180d:	5e                   	pop    %esi
  80180e:	5f                   	pop    %edi
  80180f:	5d                   	pop    %ebp
  801810:	c3                   	ret    
  801811:	8d 76 00             	lea    0x0(%esi),%esi
  801814:	2b 04 24             	sub    (%esp),%eax
  801817:	19 fa                	sbb    %edi,%edx
  801819:	89 d1                	mov    %edx,%ecx
  80181b:	89 c6                	mov    %eax,%esi
  80181d:	e9 71 ff ff ff       	jmp    801793 <__umoddi3+0xb3>
  801822:	66 90                	xchg   %ax,%ax
  801824:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801828:	72 ea                	jb     801814 <__umoddi3+0x134>
  80182a:	89 d9                	mov    %ebx,%ecx
  80182c:	e9 62 ff ff ff       	jmp    801793 <__umoddi3+0xb3>
