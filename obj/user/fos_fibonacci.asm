
obj/user/fos_fibonacci:     file format elf32-i386


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
  800031:	e8 ab 00 00 00       	call   8000e1 <libmain>
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
	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 80 1b 80 00       	push   $0x801b80
  800057:	e8 db 09 00 00       	call   800a37 <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 2d 0e 00 00       	call   800e9f <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = fibonacci(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <fibonacci>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 9e 1b 80 00       	push   $0x801b9e
  800097:	e8 48 02 00 00       	call   8002e4 <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <fibonacci>:


int fibonacci(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	53                   	push   %ebx
  8000a6:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  8000a9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ad:	7f 07                	jg     8000b6 <fibonacci+0x14>
		return 1 ;
  8000af:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b4:	eb 26                	jmp    8000dc <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  8000b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b9:	48                   	dec    %eax
  8000ba:	83 ec 0c             	sub    $0xc,%esp
  8000bd:	50                   	push   %eax
  8000be:	e8 df ff ff ff       	call   8000a2 <fibonacci>
  8000c3:	83 c4 10             	add    $0x10,%esp
  8000c6:	89 c3                	mov    %eax,%ebx
  8000c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8000cb:	83 e8 02             	sub    $0x2,%eax
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	50                   	push   %eax
  8000d2:	e8 cb ff ff ff       	call   8000a2 <fibonacci>
  8000d7:	83 c4 10             	add    $0x10,%esp
  8000da:	01 d8                	add    %ebx,%eax
}
  8000dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000df:	c9                   	leave  
  8000e0:	c3                   	ret    

008000e1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000e1:	55                   	push   %ebp
  8000e2:	89 e5                	mov    %esp,%ebp
  8000e4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e7:	e8 fc 11 00 00       	call   8012e8 <sys_getenvindex>
  8000ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000f2:	89 d0                	mov    %edx,%eax
  8000f4:	01 c0                	add    %eax,%eax
  8000f6:	01 d0                	add    %edx,%eax
  8000f8:	c1 e0 02             	shl    $0x2,%eax
  8000fb:	01 d0                	add    %edx,%eax
  8000fd:	c1 e0 06             	shl    $0x6,%eax
  800100:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800105:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80010a:	a1 04 20 80 00       	mov    0x802004,%eax
  80010f:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800115:	84 c0                	test   %al,%al
  800117:	74 0f                	je     800128 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800119:	a1 04 20 80 00       	mov    0x802004,%eax
  80011e:	05 f4 02 00 00       	add    $0x2f4,%eax
  800123:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800128:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80012c:	7e 0a                	jle    800138 <libmain+0x57>
		binaryname = argv[0];
  80012e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800131:	8b 00                	mov    (%eax),%eax
  800133:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800138:	83 ec 08             	sub    $0x8,%esp
  80013b:	ff 75 0c             	pushl  0xc(%ebp)
  80013e:	ff 75 08             	pushl  0x8(%ebp)
  800141:	e8 f2 fe ff ff       	call   800038 <_main>
  800146:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800149:	e8 35 13 00 00       	call   801483 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80014e:	83 ec 0c             	sub    $0xc,%esp
  800151:	68 cc 1b 80 00       	push   $0x801bcc
  800156:	e8 5c 01 00 00       	call   8002b7 <cprintf>
  80015b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80015e:	a1 04 20 80 00       	mov    0x802004,%eax
  800163:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800169:	a1 04 20 80 00       	mov    0x802004,%eax
  80016e:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800174:	83 ec 04             	sub    $0x4,%esp
  800177:	52                   	push   %edx
  800178:	50                   	push   %eax
  800179:	68 f4 1b 80 00       	push   $0x801bf4
  80017e:	e8 34 01 00 00       	call   8002b7 <cprintf>
  800183:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800186:	a1 04 20 80 00       	mov    0x802004,%eax
  80018b:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800191:	83 ec 08             	sub    $0x8,%esp
  800194:	50                   	push   %eax
  800195:	68 19 1c 80 00       	push   $0x801c19
  80019a:	e8 18 01 00 00       	call   8002b7 <cprintf>
  80019f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001a2:	83 ec 0c             	sub    $0xc,%esp
  8001a5:	68 cc 1b 80 00       	push   $0x801bcc
  8001aa:	e8 08 01 00 00       	call   8002b7 <cprintf>
  8001af:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001b2:	e8 e6 12 00 00       	call   80149d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001b7:	e8 19 00 00 00       	call   8001d5 <exit>
}
  8001bc:	90                   	nop
  8001bd:	c9                   	leave  
  8001be:	c3                   	ret    

008001bf <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001bf:	55                   	push   %ebp
  8001c0:	89 e5                	mov    %esp,%ebp
  8001c2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	6a 00                	push   $0x0
  8001ca:	e8 e5 10 00 00       	call   8012b4 <sys_env_destroy>
  8001cf:	83 c4 10             	add    $0x10,%esp
}
  8001d2:	90                   	nop
  8001d3:	c9                   	leave  
  8001d4:	c3                   	ret    

008001d5 <exit>:

void
exit(void)
{
  8001d5:	55                   	push   %ebp
  8001d6:	89 e5                	mov    %esp,%ebp
  8001d8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001db:	e8 3a 11 00 00       	call   80131a <sys_env_exit>
}
  8001e0:	90                   	nop
  8001e1:	c9                   	leave  
  8001e2:	c3                   	ret    

008001e3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001e3:	55                   	push   %ebp
  8001e4:	89 e5                	mov    %esp,%ebp
  8001e6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ec:	8b 00                	mov    (%eax),%eax
  8001ee:	8d 48 01             	lea    0x1(%eax),%ecx
  8001f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f4:	89 0a                	mov    %ecx,(%edx)
  8001f6:	8b 55 08             	mov    0x8(%ebp),%edx
  8001f9:	88 d1                	mov    %dl,%cl
  8001fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fe:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800202:	8b 45 0c             	mov    0xc(%ebp),%eax
  800205:	8b 00                	mov    (%eax),%eax
  800207:	3d ff 00 00 00       	cmp    $0xff,%eax
  80020c:	75 2c                	jne    80023a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80020e:	a0 08 20 80 00       	mov    0x802008,%al
  800213:	0f b6 c0             	movzbl %al,%eax
  800216:	8b 55 0c             	mov    0xc(%ebp),%edx
  800219:	8b 12                	mov    (%edx),%edx
  80021b:	89 d1                	mov    %edx,%ecx
  80021d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800220:	83 c2 08             	add    $0x8,%edx
  800223:	83 ec 04             	sub    $0x4,%esp
  800226:	50                   	push   %eax
  800227:	51                   	push   %ecx
  800228:	52                   	push   %edx
  800229:	e8 44 10 00 00       	call   801272 <sys_cputs>
  80022e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800231:	8b 45 0c             	mov    0xc(%ebp),%eax
  800234:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80023a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023d:	8b 40 04             	mov    0x4(%eax),%eax
  800240:	8d 50 01             	lea    0x1(%eax),%edx
  800243:	8b 45 0c             	mov    0xc(%ebp),%eax
  800246:	89 50 04             	mov    %edx,0x4(%eax)
}
  800249:	90                   	nop
  80024a:	c9                   	leave  
  80024b:	c3                   	ret    

0080024c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80024c:	55                   	push   %ebp
  80024d:	89 e5                	mov    %esp,%ebp
  80024f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800255:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80025c:	00 00 00 
	b.cnt = 0;
  80025f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800266:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800269:	ff 75 0c             	pushl  0xc(%ebp)
  80026c:	ff 75 08             	pushl  0x8(%ebp)
  80026f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800275:	50                   	push   %eax
  800276:	68 e3 01 80 00       	push   $0x8001e3
  80027b:	e8 11 02 00 00       	call   800491 <vprintfmt>
  800280:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800283:	a0 08 20 80 00       	mov    0x802008,%al
  800288:	0f b6 c0             	movzbl %al,%eax
  80028b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800291:	83 ec 04             	sub    $0x4,%esp
  800294:	50                   	push   %eax
  800295:	52                   	push   %edx
  800296:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80029c:	83 c0 08             	add    $0x8,%eax
  80029f:	50                   	push   %eax
  8002a0:	e8 cd 0f 00 00       	call   801272 <sys_cputs>
  8002a5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002a8:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  8002af:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002b5:	c9                   	leave  
  8002b6:	c3                   	ret    

008002b7 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002b7:	55                   	push   %ebp
  8002b8:	89 e5                	mov    %esp,%ebp
  8002ba:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002bd:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002c4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8002cd:	83 ec 08             	sub    $0x8,%esp
  8002d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d3:	50                   	push   %eax
  8002d4:	e8 73 ff ff ff       	call   80024c <vcprintf>
  8002d9:	83 c4 10             	add    $0x10,%esp
  8002dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002df:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e2:	c9                   	leave  
  8002e3:	c3                   	ret    

008002e4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002e4:	55                   	push   %ebp
  8002e5:	89 e5                	mov    %esp,%ebp
  8002e7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002ea:	e8 94 11 00 00       	call   801483 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002ef:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f8:	83 ec 08             	sub    $0x8,%esp
  8002fb:	ff 75 f4             	pushl  -0xc(%ebp)
  8002fe:	50                   	push   %eax
  8002ff:	e8 48 ff ff ff       	call   80024c <vcprintf>
  800304:	83 c4 10             	add    $0x10,%esp
  800307:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80030a:	e8 8e 11 00 00       	call   80149d <sys_enable_interrupt>
	return cnt;
  80030f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800312:	c9                   	leave  
  800313:	c3                   	ret    

00800314 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800314:	55                   	push   %ebp
  800315:	89 e5                	mov    %esp,%ebp
  800317:	53                   	push   %ebx
  800318:	83 ec 14             	sub    $0x14,%esp
  80031b:	8b 45 10             	mov    0x10(%ebp),%eax
  80031e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800321:	8b 45 14             	mov    0x14(%ebp),%eax
  800324:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800327:	8b 45 18             	mov    0x18(%ebp),%eax
  80032a:	ba 00 00 00 00       	mov    $0x0,%edx
  80032f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800332:	77 55                	ja     800389 <printnum+0x75>
  800334:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800337:	72 05                	jb     80033e <printnum+0x2a>
  800339:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80033c:	77 4b                	ja     800389 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80033e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800341:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800344:	8b 45 18             	mov    0x18(%ebp),%eax
  800347:	ba 00 00 00 00       	mov    $0x0,%edx
  80034c:	52                   	push   %edx
  80034d:	50                   	push   %eax
  80034e:	ff 75 f4             	pushl  -0xc(%ebp)
  800351:	ff 75 f0             	pushl  -0x10(%ebp)
  800354:	e8 ab 15 00 00       	call   801904 <__udivdi3>
  800359:	83 c4 10             	add    $0x10,%esp
  80035c:	83 ec 04             	sub    $0x4,%esp
  80035f:	ff 75 20             	pushl  0x20(%ebp)
  800362:	53                   	push   %ebx
  800363:	ff 75 18             	pushl  0x18(%ebp)
  800366:	52                   	push   %edx
  800367:	50                   	push   %eax
  800368:	ff 75 0c             	pushl  0xc(%ebp)
  80036b:	ff 75 08             	pushl  0x8(%ebp)
  80036e:	e8 a1 ff ff ff       	call   800314 <printnum>
  800373:	83 c4 20             	add    $0x20,%esp
  800376:	eb 1a                	jmp    800392 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800378:	83 ec 08             	sub    $0x8,%esp
  80037b:	ff 75 0c             	pushl  0xc(%ebp)
  80037e:	ff 75 20             	pushl  0x20(%ebp)
  800381:	8b 45 08             	mov    0x8(%ebp),%eax
  800384:	ff d0                	call   *%eax
  800386:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800389:	ff 4d 1c             	decl   0x1c(%ebp)
  80038c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800390:	7f e6                	jg     800378 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800392:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800395:	bb 00 00 00 00       	mov    $0x0,%ebx
  80039a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80039d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003a0:	53                   	push   %ebx
  8003a1:	51                   	push   %ecx
  8003a2:	52                   	push   %edx
  8003a3:	50                   	push   %eax
  8003a4:	e8 6b 16 00 00       	call   801a14 <__umoddi3>
  8003a9:	83 c4 10             	add    $0x10,%esp
  8003ac:	05 54 1e 80 00       	add    $0x801e54,%eax
  8003b1:	8a 00                	mov    (%eax),%al
  8003b3:	0f be c0             	movsbl %al,%eax
  8003b6:	83 ec 08             	sub    $0x8,%esp
  8003b9:	ff 75 0c             	pushl  0xc(%ebp)
  8003bc:	50                   	push   %eax
  8003bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c0:	ff d0                	call   *%eax
  8003c2:	83 c4 10             	add    $0x10,%esp
}
  8003c5:	90                   	nop
  8003c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003c9:	c9                   	leave  
  8003ca:	c3                   	ret    

008003cb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003cb:	55                   	push   %ebp
  8003cc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003ce:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003d2:	7e 1c                	jle    8003f0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	8b 00                	mov    (%eax),%eax
  8003d9:	8d 50 08             	lea    0x8(%eax),%edx
  8003dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003df:	89 10                	mov    %edx,(%eax)
  8003e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e4:	8b 00                	mov    (%eax),%eax
  8003e6:	83 e8 08             	sub    $0x8,%eax
  8003e9:	8b 50 04             	mov    0x4(%eax),%edx
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	eb 40                	jmp    800430 <getuint+0x65>
	else if (lflag)
  8003f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003f4:	74 1e                	je     800414 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	8d 50 04             	lea    0x4(%eax),%edx
  8003fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800401:	89 10                	mov    %edx,(%eax)
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	83 e8 04             	sub    $0x4,%eax
  80040b:	8b 00                	mov    (%eax),%eax
  80040d:	ba 00 00 00 00       	mov    $0x0,%edx
  800412:	eb 1c                	jmp    800430 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	8b 00                	mov    (%eax),%eax
  800419:	8d 50 04             	lea    0x4(%eax),%edx
  80041c:	8b 45 08             	mov    0x8(%ebp),%eax
  80041f:	89 10                	mov    %edx,(%eax)
  800421:	8b 45 08             	mov    0x8(%ebp),%eax
  800424:	8b 00                	mov    (%eax),%eax
  800426:	83 e8 04             	sub    $0x4,%eax
  800429:	8b 00                	mov    (%eax),%eax
  80042b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800430:	5d                   	pop    %ebp
  800431:	c3                   	ret    

00800432 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800432:	55                   	push   %ebp
  800433:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800435:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800439:	7e 1c                	jle    800457 <getint+0x25>
		return va_arg(*ap, long long);
  80043b:	8b 45 08             	mov    0x8(%ebp),%eax
  80043e:	8b 00                	mov    (%eax),%eax
  800440:	8d 50 08             	lea    0x8(%eax),%edx
  800443:	8b 45 08             	mov    0x8(%ebp),%eax
  800446:	89 10                	mov    %edx,(%eax)
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	83 e8 08             	sub    $0x8,%eax
  800450:	8b 50 04             	mov    0x4(%eax),%edx
  800453:	8b 00                	mov    (%eax),%eax
  800455:	eb 38                	jmp    80048f <getint+0x5d>
	else if (lflag)
  800457:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80045b:	74 1a                	je     800477 <getint+0x45>
		return va_arg(*ap, long);
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	8b 00                	mov    (%eax),%eax
  800462:	8d 50 04             	lea    0x4(%eax),%edx
  800465:	8b 45 08             	mov    0x8(%ebp),%eax
  800468:	89 10                	mov    %edx,(%eax)
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	8b 00                	mov    (%eax),%eax
  80046f:	83 e8 04             	sub    $0x4,%eax
  800472:	8b 00                	mov    (%eax),%eax
  800474:	99                   	cltd   
  800475:	eb 18                	jmp    80048f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800477:	8b 45 08             	mov    0x8(%ebp),%eax
  80047a:	8b 00                	mov    (%eax),%eax
  80047c:	8d 50 04             	lea    0x4(%eax),%edx
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	89 10                	mov    %edx,(%eax)
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	83 e8 04             	sub    $0x4,%eax
  80048c:	8b 00                	mov    (%eax),%eax
  80048e:	99                   	cltd   
}
  80048f:	5d                   	pop    %ebp
  800490:	c3                   	ret    

00800491 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800491:	55                   	push   %ebp
  800492:	89 e5                	mov    %esp,%ebp
  800494:	56                   	push   %esi
  800495:	53                   	push   %ebx
  800496:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800499:	eb 17                	jmp    8004b2 <vprintfmt+0x21>
			if (ch == '\0')
  80049b:	85 db                	test   %ebx,%ebx
  80049d:	0f 84 af 03 00 00    	je     800852 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004a3:	83 ec 08             	sub    $0x8,%esp
  8004a6:	ff 75 0c             	pushl  0xc(%ebp)
  8004a9:	53                   	push   %ebx
  8004aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ad:	ff d0                	call   *%eax
  8004af:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b5:	8d 50 01             	lea    0x1(%eax),%edx
  8004b8:	89 55 10             	mov    %edx,0x10(%ebp)
  8004bb:	8a 00                	mov    (%eax),%al
  8004bd:	0f b6 d8             	movzbl %al,%ebx
  8004c0:	83 fb 25             	cmp    $0x25,%ebx
  8004c3:	75 d6                	jne    80049b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004c5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004c9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004d0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004d7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004de:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e8:	8d 50 01             	lea    0x1(%eax),%edx
  8004eb:	89 55 10             	mov    %edx,0x10(%ebp)
  8004ee:	8a 00                	mov    (%eax),%al
  8004f0:	0f b6 d8             	movzbl %al,%ebx
  8004f3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004f6:	83 f8 55             	cmp    $0x55,%eax
  8004f9:	0f 87 2b 03 00 00    	ja     80082a <vprintfmt+0x399>
  8004ff:	8b 04 85 78 1e 80 00 	mov    0x801e78(,%eax,4),%eax
  800506:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800508:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80050c:	eb d7                	jmp    8004e5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80050e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800512:	eb d1                	jmp    8004e5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800514:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80051b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	c1 e0 02             	shl    $0x2,%eax
  800523:	01 d0                	add    %edx,%eax
  800525:	01 c0                	add    %eax,%eax
  800527:	01 d8                	add    %ebx,%eax
  800529:	83 e8 30             	sub    $0x30,%eax
  80052c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80052f:	8b 45 10             	mov    0x10(%ebp),%eax
  800532:	8a 00                	mov    (%eax),%al
  800534:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800537:	83 fb 2f             	cmp    $0x2f,%ebx
  80053a:	7e 3e                	jle    80057a <vprintfmt+0xe9>
  80053c:	83 fb 39             	cmp    $0x39,%ebx
  80053f:	7f 39                	jg     80057a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800541:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800544:	eb d5                	jmp    80051b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800546:	8b 45 14             	mov    0x14(%ebp),%eax
  800549:	83 c0 04             	add    $0x4,%eax
  80054c:	89 45 14             	mov    %eax,0x14(%ebp)
  80054f:	8b 45 14             	mov    0x14(%ebp),%eax
  800552:	83 e8 04             	sub    $0x4,%eax
  800555:	8b 00                	mov    (%eax),%eax
  800557:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80055a:	eb 1f                	jmp    80057b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80055c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800560:	79 83                	jns    8004e5 <vprintfmt+0x54>
				width = 0;
  800562:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800569:	e9 77 ff ff ff       	jmp    8004e5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80056e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800575:	e9 6b ff ff ff       	jmp    8004e5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80057a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80057b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80057f:	0f 89 60 ff ff ff    	jns    8004e5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800585:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800588:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80058b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800592:	e9 4e ff ff ff       	jmp    8004e5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800597:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80059a:	e9 46 ff ff ff       	jmp    8004e5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80059f:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a2:	83 c0 04             	add    $0x4,%eax
  8005a5:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ab:	83 e8 04             	sub    $0x4,%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	83 ec 08             	sub    $0x8,%esp
  8005b3:	ff 75 0c             	pushl  0xc(%ebp)
  8005b6:	50                   	push   %eax
  8005b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ba:	ff d0                	call   *%eax
  8005bc:	83 c4 10             	add    $0x10,%esp
			break;
  8005bf:	e9 89 02 00 00       	jmp    80084d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c7:	83 c0 04             	add    $0x4,%eax
  8005ca:	89 45 14             	mov    %eax,0x14(%ebp)
  8005cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d0:	83 e8 04             	sub    $0x4,%eax
  8005d3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005d5:	85 db                	test   %ebx,%ebx
  8005d7:	79 02                	jns    8005db <vprintfmt+0x14a>
				err = -err;
  8005d9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005db:	83 fb 64             	cmp    $0x64,%ebx
  8005de:	7f 0b                	jg     8005eb <vprintfmt+0x15a>
  8005e0:	8b 34 9d c0 1c 80 00 	mov    0x801cc0(,%ebx,4),%esi
  8005e7:	85 f6                	test   %esi,%esi
  8005e9:	75 19                	jne    800604 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005eb:	53                   	push   %ebx
  8005ec:	68 65 1e 80 00       	push   $0x801e65
  8005f1:	ff 75 0c             	pushl  0xc(%ebp)
  8005f4:	ff 75 08             	pushl  0x8(%ebp)
  8005f7:	e8 5e 02 00 00       	call   80085a <printfmt>
  8005fc:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005ff:	e9 49 02 00 00       	jmp    80084d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800604:	56                   	push   %esi
  800605:	68 6e 1e 80 00       	push   $0x801e6e
  80060a:	ff 75 0c             	pushl  0xc(%ebp)
  80060d:	ff 75 08             	pushl  0x8(%ebp)
  800610:	e8 45 02 00 00       	call   80085a <printfmt>
  800615:	83 c4 10             	add    $0x10,%esp
			break;
  800618:	e9 30 02 00 00       	jmp    80084d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80061d:	8b 45 14             	mov    0x14(%ebp),%eax
  800620:	83 c0 04             	add    $0x4,%eax
  800623:	89 45 14             	mov    %eax,0x14(%ebp)
  800626:	8b 45 14             	mov    0x14(%ebp),%eax
  800629:	83 e8 04             	sub    $0x4,%eax
  80062c:	8b 30                	mov    (%eax),%esi
  80062e:	85 f6                	test   %esi,%esi
  800630:	75 05                	jne    800637 <vprintfmt+0x1a6>
				p = "(null)";
  800632:	be 71 1e 80 00       	mov    $0x801e71,%esi
			if (width > 0 && padc != '-')
  800637:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80063b:	7e 6d                	jle    8006aa <vprintfmt+0x219>
  80063d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800641:	74 67                	je     8006aa <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800643:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800646:	83 ec 08             	sub    $0x8,%esp
  800649:	50                   	push   %eax
  80064a:	56                   	push   %esi
  80064b:	e8 12 05 00 00       	call   800b62 <strnlen>
  800650:	83 c4 10             	add    $0x10,%esp
  800653:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800656:	eb 16                	jmp    80066e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800658:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80065c:	83 ec 08             	sub    $0x8,%esp
  80065f:	ff 75 0c             	pushl  0xc(%ebp)
  800662:	50                   	push   %eax
  800663:	8b 45 08             	mov    0x8(%ebp),%eax
  800666:	ff d0                	call   *%eax
  800668:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80066b:	ff 4d e4             	decl   -0x1c(%ebp)
  80066e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800672:	7f e4                	jg     800658 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800674:	eb 34                	jmp    8006aa <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800676:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80067a:	74 1c                	je     800698 <vprintfmt+0x207>
  80067c:	83 fb 1f             	cmp    $0x1f,%ebx
  80067f:	7e 05                	jle    800686 <vprintfmt+0x1f5>
  800681:	83 fb 7e             	cmp    $0x7e,%ebx
  800684:	7e 12                	jle    800698 <vprintfmt+0x207>
					putch('?', putdat);
  800686:	83 ec 08             	sub    $0x8,%esp
  800689:	ff 75 0c             	pushl  0xc(%ebp)
  80068c:	6a 3f                	push   $0x3f
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	ff d0                	call   *%eax
  800693:	83 c4 10             	add    $0x10,%esp
  800696:	eb 0f                	jmp    8006a7 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800698:	83 ec 08             	sub    $0x8,%esp
  80069b:	ff 75 0c             	pushl  0xc(%ebp)
  80069e:	53                   	push   %ebx
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	ff d0                	call   *%eax
  8006a4:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006a7:	ff 4d e4             	decl   -0x1c(%ebp)
  8006aa:	89 f0                	mov    %esi,%eax
  8006ac:	8d 70 01             	lea    0x1(%eax),%esi
  8006af:	8a 00                	mov    (%eax),%al
  8006b1:	0f be d8             	movsbl %al,%ebx
  8006b4:	85 db                	test   %ebx,%ebx
  8006b6:	74 24                	je     8006dc <vprintfmt+0x24b>
  8006b8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006bc:	78 b8                	js     800676 <vprintfmt+0x1e5>
  8006be:	ff 4d e0             	decl   -0x20(%ebp)
  8006c1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c5:	79 af                	jns    800676 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006c7:	eb 13                	jmp    8006dc <vprintfmt+0x24b>
				putch(' ', putdat);
  8006c9:	83 ec 08             	sub    $0x8,%esp
  8006cc:	ff 75 0c             	pushl  0xc(%ebp)
  8006cf:	6a 20                	push   $0x20
  8006d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d4:	ff d0                	call   *%eax
  8006d6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d9:	ff 4d e4             	decl   -0x1c(%ebp)
  8006dc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e0:	7f e7                	jg     8006c9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006e2:	e9 66 01 00 00       	jmp    80084d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006e7:	83 ec 08             	sub    $0x8,%esp
  8006ea:	ff 75 e8             	pushl  -0x18(%ebp)
  8006ed:	8d 45 14             	lea    0x14(%ebp),%eax
  8006f0:	50                   	push   %eax
  8006f1:	e8 3c fd ff ff       	call   800432 <getint>
  8006f6:	83 c4 10             	add    $0x10,%esp
  8006f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006fc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800702:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800705:	85 d2                	test   %edx,%edx
  800707:	79 23                	jns    80072c <vprintfmt+0x29b>
				putch('-', putdat);
  800709:	83 ec 08             	sub    $0x8,%esp
  80070c:	ff 75 0c             	pushl  0xc(%ebp)
  80070f:	6a 2d                	push   $0x2d
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	ff d0                	call   *%eax
  800716:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800719:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80071c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80071f:	f7 d8                	neg    %eax
  800721:	83 d2 00             	adc    $0x0,%edx
  800724:	f7 da                	neg    %edx
  800726:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800729:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80072c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800733:	e9 bc 00 00 00       	jmp    8007f4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800738:	83 ec 08             	sub    $0x8,%esp
  80073b:	ff 75 e8             	pushl  -0x18(%ebp)
  80073e:	8d 45 14             	lea    0x14(%ebp),%eax
  800741:	50                   	push   %eax
  800742:	e8 84 fc ff ff       	call   8003cb <getuint>
  800747:	83 c4 10             	add    $0x10,%esp
  80074a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80074d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800750:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800757:	e9 98 00 00 00       	jmp    8007f4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80075c:	83 ec 08             	sub    $0x8,%esp
  80075f:	ff 75 0c             	pushl  0xc(%ebp)
  800762:	6a 58                	push   $0x58
  800764:	8b 45 08             	mov    0x8(%ebp),%eax
  800767:	ff d0                	call   *%eax
  800769:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80076c:	83 ec 08             	sub    $0x8,%esp
  80076f:	ff 75 0c             	pushl  0xc(%ebp)
  800772:	6a 58                	push   $0x58
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	ff d0                	call   *%eax
  800779:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80077c:	83 ec 08             	sub    $0x8,%esp
  80077f:	ff 75 0c             	pushl  0xc(%ebp)
  800782:	6a 58                	push   $0x58
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	ff d0                	call   *%eax
  800789:	83 c4 10             	add    $0x10,%esp
			break;
  80078c:	e9 bc 00 00 00       	jmp    80084d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800791:	83 ec 08             	sub    $0x8,%esp
  800794:	ff 75 0c             	pushl  0xc(%ebp)
  800797:	6a 30                	push   $0x30
  800799:	8b 45 08             	mov    0x8(%ebp),%eax
  80079c:	ff d0                	call   *%eax
  80079e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 0c             	pushl  0xc(%ebp)
  8007a7:	6a 78                	push   $0x78
  8007a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ac:	ff d0                	call   *%eax
  8007ae:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b4:	83 c0 04             	add    $0x4,%eax
  8007b7:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bd:	83 e8 04             	sub    $0x4,%eax
  8007c0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007cc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007d3:	eb 1f                	jmp    8007f4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007d5:	83 ec 08             	sub    $0x8,%esp
  8007d8:	ff 75 e8             	pushl  -0x18(%ebp)
  8007db:	8d 45 14             	lea    0x14(%ebp),%eax
  8007de:	50                   	push   %eax
  8007df:	e8 e7 fb ff ff       	call   8003cb <getuint>
  8007e4:	83 c4 10             	add    $0x10,%esp
  8007e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007ed:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007f4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007fb:	83 ec 04             	sub    $0x4,%esp
  8007fe:	52                   	push   %edx
  8007ff:	ff 75 e4             	pushl  -0x1c(%ebp)
  800802:	50                   	push   %eax
  800803:	ff 75 f4             	pushl  -0xc(%ebp)
  800806:	ff 75 f0             	pushl  -0x10(%ebp)
  800809:	ff 75 0c             	pushl  0xc(%ebp)
  80080c:	ff 75 08             	pushl  0x8(%ebp)
  80080f:	e8 00 fb ff ff       	call   800314 <printnum>
  800814:	83 c4 20             	add    $0x20,%esp
			break;
  800817:	eb 34                	jmp    80084d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800819:	83 ec 08             	sub    $0x8,%esp
  80081c:	ff 75 0c             	pushl  0xc(%ebp)
  80081f:	53                   	push   %ebx
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	ff d0                	call   *%eax
  800825:	83 c4 10             	add    $0x10,%esp
			break;
  800828:	eb 23                	jmp    80084d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80082a:	83 ec 08             	sub    $0x8,%esp
  80082d:	ff 75 0c             	pushl  0xc(%ebp)
  800830:	6a 25                	push   $0x25
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	ff d0                	call   *%eax
  800837:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80083a:	ff 4d 10             	decl   0x10(%ebp)
  80083d:	eb 03                	jmp    800842 <vprintfmt+0x3b1>
  80083f:	ff 4d 10             	decl   0x10(%ebp)
  800842:	8b 45 10             	mov    0x10(%ebp),%eax
  800845:	48                   	dec    %eax
  800846:	8a 00                	mov    (%eax),%al
  800848:	3c 25                	cmp    $0x25,%al
  80084a:	75 f3                	jne    80083f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80084c:	90                   	nop
		}
	}
  80084d:	e9 47 fc ff ff       	jmp    800499 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800852:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800853:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800856:	5b                   	pop    %ebx
  800857:	5e                   	pop    %esi
  800858:	5d                   	pop    %ebp
  800859:	c3                   	ret    

0080085a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80085a:	55                   	push   %ebp
  80085b:	89 e5                	mov    %esp,%ebp
  80085d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800860:	8d 45 10             	lea    0x10(%ebp),%eax
  800863:	83 c0 04             	add    $0x4,%eax
  800866:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800869:	8b 45 10             	mov    0x10(%ebp),%eax
  80086c:	ff 75 f4             	pushl  -0xc(%ebp)
  80086f:	50                   	push   %eax
  800870:	ff 75 0c             	pushl  0xc(%ebp)
  800873:	ff 75 08             	pushl  0x8(%ebp)
  800876:	e8 16 fc ff ff       	call   800491 <vprintfmt>
  80087b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80087e:	90                   	nop
  80087f:	c9                   	leave  
  800880:	c3                   	ret    

00800881 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800881:	55                   	push   %ebp
  800882:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800884:	8b 45 0c             	mov    0xc(%ebp),%eax
  800887:	8b 40 08             	mov    0x8(%eax),%eax
  80088a:	8d 50 01             	lea    0x1(%eax),%edx
  80088d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800890:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800893:	8b 45 0c             	mov    0xc(%ebp),%eax
  800896:	8b 10                	mov    (%eax),%edx
  800898:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089b:	8b 40 04             	mov    0x4(%eax),%eax
  80089e:	39 c2                	cmp    %eax,%edx
  8008a0:	73 12                	jae    8008b4 <sprintputch+0x33>
		*b->buf++ = ch;
  8008a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a5:	8b 00                	mov    (%eax),%eax
  8008a7:	8d 48 01             	lea    0x1(%eax),%ecx
  8008aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ad:	89 0a                	mov    %ecx,(%edx)
  8008af:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b2:	88 10                	mov    %dl,(%eax)
}
  8008b4:	90                   	nop
  8008b5:	5d                   	pop    %ebp
  8008b6:	c3                   	ret    

008008b7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008b7:	55                   	push   %ebp
  8008b8:	89 e5                	mov    %esp,%ebp
  8008ba:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cc:	01 d0                	add    %edx,%eax
  8008ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008dc:	74 06                	je     8008e4 <vsnprintf+0x2d>
  8008de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e2:	7f 07                	jg     8008eb <vsnprintf+0x34>
		return -E_INVAL;
  8008e4:	b8 03 00 00 00       	mov    $0x3,%eax
  8008e9:	eb 20                	jmp    80090b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008eb:	ff 75 14             	pushl  0x14(%ebp)
  8008ee:	ff 75 10             	pushl  0x10(%ebp)
  8008f1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008f4:	50                   	push   %eax
  8008f5:	68 81 08 80 00       	push   $0x800881
  8008fa:	e8 92 fb ff ff       	call   800491 <vprintfmt>
  8008ff:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800902:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800905:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800908:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80090b:	c9                   	leave  
  80090c:	c3                   	ret    

0080090d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80090d:	55                   	push   %ebp
  80090e:	89 e5                	mov    %esp,%ebp
  800910:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800913:	8d 45 10             	lea    0x10(%ebp),%eax
  800916:	83 c0 04             	add    $0x4,%eax
  800919:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80091c:	8b 45 10             	mov    0x10(%ebp),%eax
  80091f:	ff 75 f4             	pushl  -0xc(%ebp)
  800922:	50                   	push   %eax
  800923:	ff 75 0c             	pushl  0xc(%ebp)
  800926:	ff 75 08             	pushl  0x8(%ebp)
  800929:	e8 89 ff ff ff       	call   8008b7 <vsnprintf>
  80092e:	83 c4 10             	add    $0x10,%esp
  800931:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800934:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800937:	c9                   	leave  
  800938:	c3                   	ret    

00800939 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800939:	55                   	push   %ebp
  80093a:	89 e5                	mov    %esp,%ebp
  80093c:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80093f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800943:	74 13                	je     800958 <readline+0x1f>
		cprintf("%s", prompt);
  800945:	83 ec 08             	sub    $0x8,%esp
  800948:	ff 75 08             	pushl  0x8(%ebp)
  80094b:	68 d0 1f 80 00       	push   $0x801fd0
  800950:	e8 62 f9 ff ff       	call   8002b7 <cprintf>
  800955:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800958:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80095f:	83 ec 0c             	sub    $0xc,%esp
  800962:	6a 00                	push   $0x0
  800964:	e8 8e 0f 00 00       	call   8018f7 <iscons>
  800969:	83 c4 10             	add    $0x10,%esp
  80096c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80096f:	e8 35 0f 00 00       	call   8018a9 <getchar>
  800974:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800977:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80097b:	79 22                	jns    80099f <readline+0x66>
			if (c != -E_EOF)
  80097d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800981:	0f 84 ad 00 00 00    	je     800a34 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800987:	83 ec 08             	sub    $0x8,%esp
  80098a:	ff 75 ec             	pushl  -0x14(%ebp)
  80098d:	68 d3 1f 80 00       	push   $0x801fd3
  800992:	e8 20 f9 ff ff       	call   8002b7 <cprintf>
  800997:	83 c4 10             	add    $0x10,%esp
			return;
  80099a:	e9 95 00 00 00       	jmp    800a34 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80099f:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009a3:	7e 34                	jle    8009d9 <readline+0xa0>
  8009a5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009ac:	7f 2b                	jg     8009d9 <readline+0xa0>
			if (echoing)
  8009ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009b2:	74 0e                	je     8009c2 <readline+0x89>
				cputchar(c);
  8009b4:	83 ec 0c             	sub    $0xc,%esp
  8009b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8009ba:	e8 a2 0e 00 00       	call   801861 <cputchar>
  8009bf:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009c5:	8d 50 01             	lea    0x1(%eax),%edx
  8009c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009cb:	89 c2                	mov    %eax,%edx
  8009cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d0:	01 d0                	add    %edx,%eax
  8009d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009d5:	88 10                	mov    %dl,(%eax)
  8009d7:	eb 56                	jmp    800a2f <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009d9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009dd:	75 1f                	jne    8009fe <readline+0xc5>
  8009df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009e3:	7e 19                	jle    8009fe <readline+0xc5>
			if (echoing)
  8009e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009e9:	74 0e                	je     8009f9 <readline+0xc0>
				cputchar(c);
  8009eb:	83 ec 0c             	sub    $0xc,%esp
  8009ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8009f1:	e8 6b 0e 00 00       	call   801861 <cputchar>
  8009f6:	83 c4 10             	add    $0x10,%esp

			i--;
  8009f9:	ff 4d f4             	decl   -0xc(%ebp)
  8009fc:	eb 31                	jmp    800a2f <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8009fe:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a02:	74 0a                	je     800a0e <readline+0xd5>
  800a04:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a08:	0f 85 61 ff ff ff    	jne    80096f <readline+0x36>
			if (echoing)
  800a0e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a12:	74 0e                	je     800a22 <readline+0xe9>
				cputchar(c);
  800a14:	83 ec 0c             	sub    $0xc,%esp
  800a17:	ff 75 ec             	pushl  -0x14(%ebp)
  800a1a:	e8 42 0e 00 00       	call   801861 <cputchar>
  800a1f:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a22:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a28:	01 d0                	add    %edx,%eax
  800a2a:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a2d:	eb 06                	jmp    800a35 <readline+0xfc>
		}
	}
  800a2f:	e9 3b ff ff ff       	jmp    80096f <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a34:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a35:	c9                   	leave  
  800a36:	c3                   	ret    

00800a37 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a37:	55                   	push   %ebp
  800a38:	89 e5                	mov    %esp,%ebp
  800a3a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a3d:	e8 41 0a 00 00       	call   801483 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a42:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a46:	74 13                	je     800a5b <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a48:	83 ec 08             	sub    $0x8,%esp
  800a4b:	ff 75 08             	pushl  0x8(%ebp)
  800a4e:	68 d0 1f 80 00       	push   $0x801fd0
  800a53:	e8 5f f8 ff ff       	call   8002b7 <cprintf>
  800a58:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a62:	83 ec 0c             	sub    $0xc,%esp
  800a65:	6a 00                	push   $0x0
  800a67:	e8 8b 0e 00 00       	call   8018f7 <iscons>
  800a6c:	83 c4 10             	add    $0x10,%esp
  800a6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a72:	e8 32 0e 00 00       	call   8018a9 <getchar>
  800a77:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a7a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a7e:	79 23                	jns    800aa3 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a80:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a84:	74 13                	je     800a99 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a86:	83 ec 08             	sub    $0x8,%esp
  800a89:	ff 75 ec             	pushl  -0x14(%ebp)
  800a8c:	68 d3 1f 80 00       	push   $0x801fd3
  800a91:	e8 21 f8 ff ff       	call   8002b7 <cprintf>
  800a96:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800a99:	e8 ff 09 00 00       	call   80149d <sys_enable_interrupt>
			return;
  800a9e:	e9 9a 00 00 00       	jmp    800b3d <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800aa3:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800aa7:	7e 34                	jle    800add <atomic_readline+0xa6>
  800aa9:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ab0:	7f 2b                	jg     800add <atomic_readline+0xa6>
			if (echoing)
  800ab2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ab6:	74 0e                	je     800ac6 <atomic_readline+0x8f>
				cputchar(c);
  800ab8:	83 ec 0c             	sub    $0xc,%esp
  800abb:	ff 75 ec             	pushl  -0x14(%ebp)
  800abe:	e8 9e 0d 00 00       	call   801861 <cputchar>
  800ac3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ac9:	8d 50 01             	lea    0x1(%eax),%edx
  800acc:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800acf:	89 c2                	mov    %eax,%edx
  800ad1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad4:	01 d0                	add    %edx,%eax
  800ad6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ad9:	88 10                	mov    %dl,(%eax)
  800adb:	eb 5b                	jmp    800b38 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800add:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800ae1:	75 1f                	jne    800b02 <atomic_readline+0xcb>
  800ae3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800ae7:	7e 19                	jle    800b02 <atomic_readline+0xcb>
			if (echoing)
  800ae9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800aed:	74 0e                	je     800afd <atomic_readline+0xc6>
				cputchar(c);
  800aef:	83 ec 0c             	sub    $0xc,%esp
  800af2:	ff 75 ec             	pushl  -0x14(%ebp)
  800af5:	e8 67 0d 00 00       	call   801861 <cputchar>
  800afa:	83 c4 10             	add    $0x10,%esp
			i--;
  800afd:	ff 4d f4             	decl   -0xc(%ebp)
  800b00:	eb 36                	jmp    800b38 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b02:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b06:	74 0a                	je     800b12 <atomic_readline+0xdb>
  800b08:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b0c:	0f 85 60 ff ff ff    	jne    800a72 <atomic_readline+0x3b>
			if (echoing)
  800b12:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b16:	74 0e                	je     800b26 <atomic_readline+0xef>
				cputchar(c);
  800b18:	83 ec 0c             	sub    $0xc,%esp
  800b1b:	ff 75 ec             	pushl  -0x14(%ebp)
  800b1e:	e8 3e 0d 00 00       	call   801861 <cputchar>
  800b23:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b26:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2c:	01 d0                	add    %edx,%eax
  800b2e:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b31:	e8 67 09 00 00       	call   80149d <sys_enable_interrupt>
			return;
  800b36:	eb 05                	jmp    800b3d <atomic_readline+0x106>
		}
	}
  800b38:	e9 35 ff ff ff       	jmp    800a72 <atomic_readline+0x3b>
}
  800b3d:	c9                   	leave  
  800b3e:	c3                   	ret    

00800b3f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b3f:	55                   	push   %ebp
  800b40:	89 e5                	mov    %esp,%ebp
  800b42:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b4c:	eb 06                	jmp    800b54 <strlen+0x15>
		n++;
  800b4e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b51:	ff 45 08             	incl   0x8(%ebp)
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	8a 00                	mov    (%eax),%al
  800b59:	84 c0                	test   %al,%al
  800b5b:	75 f1                	jne    800b4e <strlen+0xf>
		n++;
	return n;
  800b5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b60:	c9                   	leave  
  800b61:	c3                   	ret    

00800b62 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b62:	55                   	push   %ebp
  800b63:	89 e5                	mov    %esp,%ebp
  800b65:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b6f:	eb 09                	jmp    800b7a <strnlen+0x18>
		n++;
  800b71:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b74:	ff 45 08             	incl   0x8(%ebp)
  800b77:	ff 4d 0c             	decl   0xc(%ebp)
  800b7a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b7e:	74 09                	je     800b89 <strnlen+0x27>
  800b80:	8b 45 08             	mov    0x8(%ebp),%eax
  800b83:	8a 00                	mov    (%eax),%al
  800b85:	84 c0                	test   %al,%al
  800b87:	75 e8                	jne    800b71 <strnlen+0xf>
		n++;
	return n;
  800b89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b8c:	c9                   	leave  
  800b8d:	c3                   	ret    

00800b8e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b8e:	55                   	push   %ebp
  800b8f:	89 e5                	mov    %esp,%ebp
  800b91:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b9a:	90                   	nop
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	8d 50 01             	lea    0x1(%eax),%edx
  800ba1:	89 55 08             	mov    %edx,0x8(%ebp)
  800ba4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800baa:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bad:	8a 12                	mov    (%edx),%dl
  800baf:	88 10                	mov    %dl,(%eax)
  800bb1:	8a 00                	mov    (%eax),%al
  800bb3:	84 c0                	test   %al,%al
  800bb5:	75 e4                	jne    800b9b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bba:	c9                   	leave  
  800bbb:	c3                   	ret    

00800bbc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bbc:	55                   	push   %ebp
  800bbd:	89 e5                	mov    %esp,%ebp
  800bbf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bc8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bcf:	eb 1f                	jmp    800bf0 <strncpy+0x34>
		*dst++ = *src;
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	8d 50 01             	lea    0x1(%eax),%edx
  800bd7:	89 55 08             	mov    %edx,0x8(%ebp)
  800bda:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bdd:	8a 12                	mov    (%edx),%dl
  800bdf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800be1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be4:	8a 00                	mov    (%eax),%al
  800be6:	84 c0                	test   %al,%al
  800be8:	74 03                	je     800bed <strncpy+0x31>
			src++;
  800bea:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bed:	ff 45 fc             	incl   -0x4(%ebp)
  800bf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bf6:	72 d9                	jb     800bd1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bf8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bfb:	c9                   	leave  
  800bfc:	c3                   	ret    

00800bfd <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bfd:	55                   	push   %ebp
  800bfe:	89 e5                	mov    %esp,%ebp
  800c00:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
  800c06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c0d:	74 30                	je     800c3f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c0f:	eb 16                	jmp    800c27 <strlcpy+0x2a>
			*dst++ = *src++;
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	8d 50 01             	lea    0x1(%eax),%edx
  800c17:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c20:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c23:	8a 12                	mov    (%edx),%dl
  800c25:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c27:	ff 4d 10             	decl   0x10(%ebp)
  800c2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c2e:	74 09                	je     800c39 <strlcpy+0x3c>
  800c30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c33:	8a 00                	mov    (%eax),%al
  800c35:	84 c0                	test   %al,%al
  800c37:	75 d8                	jne    800c11 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c3f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c45:	29 c2                	sub    %eax,%edx
  800c47:	89 d0                	mov    %edx,%eax
}
  800c49:	c9                   	leave  
  800c4a:	c3                   	ret    

00800c4b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c4b:	55                   	push   %ebp
  800c4c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c4e:	eb 06                	jmp    800c56 <strcmp+0xb>
		p++, q++;
  800c50:	ff 45 08             	incl   0x8(%ebp)
  800c53:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	84 c0                	test   %al,%al
  800c5d:	74 0e                	je     800c6d <strcmp+0x22>
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	8a 10                	mov    (%eax),%dl
  800c64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	38 c2                	cmp    %al,%dl
  800c6b:	74 e3                	je     800c50 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	0f b6 d0             	movzbl %al,%edx
  800c75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c78:	8a 00                	mov    (%eax),%al
  800c7a:	0f b6 c0             	movzbl %al,%eax
  800c7d:	29 c2                	sub    %eax,%edx
  800c7f:	89 d0                	mov    %edx,%eax
}
  800c81:	5d                   	pop    %ebp
  800c82:	c3                   	ret    

00800c83 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c83:	55                   	push   %ebp
  800c84:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c86:	eb 09                	jmp    800c91 <strncmp+0xe>
		n--, p++, q++;
  800c88:	ff 4d 10             	decl   0x10(%ebp)
  800c8b:	ff 45 08             	incl   0x8(%ebp)
  800c8e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c95:	74 17                	je     800cae <strncmp+0x2b>
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8a 00                	mov    (%eax),%al
  800c9c:	84 c0                	test   %al,%al
  800c9e:	74 0e                	je     800cae <strncmp+0x2b>
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	8a 10                	mov    (%eax),%dl
  800ca5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca8:	8a 00                	mov    (%eax),%al
  800caa:	38 c2                	cmp    %al,%dl
  800cac:	74 da                	je     800c88 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb2:	75 07                	jne    800cbb <strncmp+0x38>
		return 0;
  800cb4:	b8 00 00 00 00       	mov    $0x0,%eax
  800cb9:	eb 14                	jmp    800ccf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	0f b6 d0             	movzbl %al,%edx
  800cc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	0f b6 c0             	movzbl %al,%eax
  800ccb:	29 c2                	sub    %eax,%edx
  800ccd:	89 d0                	mov    %edx,%eax
}
  800ccf:	5d                   	pop    %ebp
  800cd0:	c3                   	ret    

00800cd1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cd1:	55                   	push   %ebp
  800cd2:	89 e5                	mov    %esp,%ebp
  800cd4:	83 ec 04             	sub    $0x4,%esp
  800cd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cda:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cdd:	eb 12                	jmp    800cf1 <strchr+0x20>
		if (*s == c)
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	8a 00                	mov    (%eax),%al
  800ce4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ce7:	75 05                	jne    800cee <strchr+0x1d>
			return (char *) s;
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	eb 11                	jmp    800cff <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cee:	ff 45 08             	incl   0x8(%ebp)
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8a 00                	mov    (%eax),%al
  800cf6:	84 c0                	test   %al,%al
  800cf8:	75 e5                	jne    800cdf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cfa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cff:	c9                   	leave  
  800d00:	c3                   	ret    

00800d01 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d01:	55                   	push   %ebp
  800d02:	89 e5                	mov    %esp,%ebp
  800d04:	83 ec 04             	sub    $0x4,%esp
  800d07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d0d:	eb 0d                	jmp    800d1c <strfind+0x1b>
		if (*s == c)
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d17:	74 0e                	je     800d27 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d19:	ff 45 08             	incl   0x8(%ebp)
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	84 c0                	test   %al,%al
  800d23:	75 ea                	jne    800d0f <strfind+0xe>
  800d25:	eb 01                	jmp    800d28 <strfind+0x27>
		if (*s == c)
			break;
  800d27:	90                   	nop
	return (char *) s;
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d2b:	c9                   	leave  
  800d2c:	c3                   	ret    

00800d2d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d2d:	55                   	push   %ebp
  800d2e:	89 e5                	mov    %esp,%ebp
  800d30:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d39:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d3f:	eb 0e                	jmp    800d4f <memset+0x22>
		*p++ = c;
  800d41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d44:	8d 50 01             	lea    0x1(%eax),%edx
  800d47:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d4d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d4f:	ff 4d f8             	decl   -0x8(%ebp)
  800d52:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d56:	79 e9                	jns    800d41 <memset+0x14>
		*p++ = c;

	return v;
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d5b:	c9                   	leave  
  800d5c:	c3                   	ret    

00800d5d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d5d:	55                   	push   %ebp
  800d5e:	89 e5                	mov    %esp,%ebp
  800d60:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d6f:	eb 16                	jmp    800d87 <memcpy+0x2a>
		*d++ = *s++;
  800d71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d74:	8d 50 01             	lea    0x1(%eax),%edx
  800d77:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d80:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d83:	8a 12                	mov    (%edx),%dl
  800d85:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d87:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d8d:	89 55 10             	mov    %edx,0x10(%ebp)
  800d90:	85 c0                	test   %eax,%eax
  800d92:	75 dd                	jne    800d71 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d97:	c9                   	leave  
  800d98:	c3                   	ret    

00800d99 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d99:	55                   	push   %ebp
  800d9a:	89 e5                	mov    %esp,%ebp
  800d9c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800db1:	73 50                	jae    800e03 <memmove+0x6a>
  800db3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800db6:	8b 45 10             	mov    0x10(%ebp),%eax
  800db9:	01 d0                	add    %edx,%eax
  800dbb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dbe:	76 43                	jbe    800e03 <memmove+0x6a>
		s += n;
  800dc0:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dcc:	eb 10                	jmp    800dde <memmove+0x45>
			*--d = *--s;
  800dce:	ff 4d f8             	decl   -0x8(%ebp)
  800dd1:	ff 4d fc             	decl   -0x4(%ebp)
  800dd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd7:	8a 10                	mov    (%eax),%dl
  800dd9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dde:	8b 45 10             	mov    0x10(%ebp),%eax
  800de1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de4:	89 55 10             	mov    %edx,0x10(%ebp)
  800de7:	85 c0                	test   %eax,%eax
  800de9:	75 e3                	jne    800dce <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800deb:	eb 23                	jmp    800e10 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ded:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df0:	8d 50 01             	lea    0x1(%eax),%edx
  800df3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800df6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dfc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dff:	8a 12                	mov    (%edx),%dl
  800e01:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e03:	8b 45 10             	mov    0x10(%ebp),%eax
  800e06:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e09:	89 55 10             	mov    %edx,0x10(%ebp)
  800e0c:	85 c0                	test   %eax,%eax
  800e0e:	75 dd                	jne    800ded <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e13:	c9                   	leave  
  800e14:	c3                   	ret    

00800e15 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e15:	55                   	push   %ebp
  800e16:	89 e5                	mov    %esp,%ebp
  800e18:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e27:	eb 2a                	jmp    800e53 <memcmp+0x3e>
		if (*s1 != *s2)
  800e29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2c:	8a 10                	mov    (%eax),%dl
  800e2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e31:	8a 00                	mov    (%eax),%al
  800e33:	38 c2                	cmp    %al,%dl
  800e35:	74 16                	je     800e4d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e37:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e3a:	8a 00                	mov    (%eax),%al
  800e3c:	0f b6 d0             	movzbl %al,%edx
  800e3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e42:	8a 00                	mov    (%eax),%al
  800e44:	0f b6 c0             	movzbl %al,%eax
  800e47:	29 c2                	sub    %eax,%edx
  800e49:	89 d0                	mov    %edx,%eax
  800e4b:	eb 18                	jmp    800e65 <memcmp+0x50>
		s1++, s2++;
  800e4d:	ff 45 fc             	incl   -0x4(%ebp)
  800e50:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e53:	8b 45 10             	mov    0x10(%ebp),%eax
  800e56:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e59:	89 55 10             	mov    %edx,0x10(%ebp)
  800e5c:	85 c0                	test   %eax,%eax
  800e5e:	75 c9                	jne    800e29 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e60:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e65:	c9                   	leave  
  800e66:	c3                   	ret    

00800e67 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e67:	55                   	push   %ebp
  800e68:	89 e5                	mov    %esp,%ebp
  800e6a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e6d:	8b 55 08             	mov    0x8(%ebp),%edx
  800e70:	8b 45 10             	mov    0x10(%ebp),%eax
  800e73:	01 d0                	add    %edx,%eax
  800e75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e78:	eb 15                	jmp    800e8f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	8a 00                	mov    (%eax),%al
  800e7f:	0f b6 d0             	movzbl %al,%edx
  800e82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e85:	0f b6 c0             	movzbl %al,%eax
  800e88:	39 c2                	cmp    %eax,%edx
  800e8a:	74 0d                	je     800e99 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e8c:	ff 45 08             	incl   0x8(%ebp)
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e95:	72 e3                	jb     800e7a <memfind+0x13>
  800e97:	eb 01                	jmp    800e9a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e99:	90                   	nop
	return (void *) s;
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e9d:	c9                   	leave  
  800e9e:	c3                   	ret    

00800e9f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e9f:	55                   	push   %ebp
  800ea0:	89 e5                	mov    %esp,%ebp
  800ea2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ea5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eb3:	eb 03                	jmp    800eb8 <strtol+0x19>
		s++;
  800eb5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	8a 00                	mov    (%eax),%al
  800ebd:	3c 20                	cmp    $0x20,%al
  800ebf:	74 f4                	je     800eb5 <strtol+0x16>
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	8a 00                	mov    (%eax),%al
  800ec6:	3c 09                	cmp    $0x9,%al
  800ec8:	74 eb                	je     800eb5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	3c 2b                	cmp    $0x2b,%al
  800ed1:	75 05                	jne    800ed8 <strtol+0x39>
		s++;
  800ed3:	ff 45 08             	incl   0x8(%ebp)
  800ed6:	eb 13                	jmp    800eeb <strtol+0x4c>
	else if (*s == '-')
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	3c 2d                	cmp    $0x2d,%al
  800edf:	75 0a                	jne    800eeb <strtol+0x4c>
		s++, neg = 1;
  800ee1:	ff 45 08             	incl   0x8(%ebp)
  800ee4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800eeb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eef:	74 06                	je     800ef7 <strtol+0x58>
  800ef1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ef5:	75 20                	jne    800f17 <strtol+0x78>
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	8a 00                	mov    (%eax),%al
  800efc:	3c 30                	cmp    $0x30,%al
  800efe:	75 17                	jne    800f17 <strtol+0x78>
  800f00:	8b 45 08             	mov    0x8(%ebp),%eax
  800f03:	40                   	inc    %eax
  800f04:	8a 00                	mov    (%eax),%al
  800f06:	3c 78                	cmp    $0x78,%al
  800f08:	75 0d                	jne    800f17 <strtol+0x78>
		s += 2, base = 16;
  800f0a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f0e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f15:	eb 28                	jmp    800f3f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f17:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f1b:	75 15                	jne    800f32 <strtol+0x93>
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	8a 00                	mov    (%eax),%al
  800f22:	3c 30                	cmp    $0x30,%al
  800f24:	75 0c                	jne    800f32 <strtol+0x93>
		s++, base = 8;
  800f26:	ff 45 08             	incl   0x8(%ebp)
  800f29:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f30:	eb 0d                	jmp    800f3f <strtol+0xa0>
	else if (base == 0)
  800f32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f36:	75 07                	jne    800f3f <strtol+0xa0>
		base = 10;
  800f38:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f42:	8a 00                	mov    (%eax),%al
  800f44:	3c 2f                	cmp    $0x2f,%al
  800f46:	7e 19                	jle    800f61 <strtol+0xc2>
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4b:	8a 00                	mov    (%eax),%al
  800f4d:	3c 39                	cmp    $0x39,%al
  800f4f:	7f 10                	jg     800f61 <strtol+0xc2>
			dig = *s - '0';
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	8a 00                	mov    (%eax),%al
  800f56:	0f be c0             	movsbl %al,%eax
  800f59:	83 e8 30             	sub    $0x30,%eax
  800f5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f5f:	eb 42                	jmp    800fa3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	3c 60                	cmp    $0x60,%al
  800f68:	7e 19                	jle    800f83 <strtol+0xe4>
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	3c 7a                	cmp    $0x7a,%al
  800f71:	7f 10                	jg     800f83 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	0f be c0             	movsbl %al,%eax
  800f7b:	83 e8 57             	sub    $0x57,%eax
  800f7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f81:	eb 20                	jmp    800fa3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	3c 40                	cmp    $0x40,%al
  800f8a:	7e 39                	jle    800fc5 <strtol+0x126>
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	8a 00                	mov    (%eax),%al
  800f91:	3c 5a                	cmp    $0x5a,%al
  800f93:	7f 30                	jg     800fc5 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	0f be c0             	movsbl %al,%eax
  800f9d:	83 e8 37             	sub    $0x37,%eax
  800fa0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fa9:	7d 19                	jge    800fc4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fab:	ff 45 08             	incl   0x8(%ebp)
  800fae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb1:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fb5:	89 c2                	mov    %eax,%edx
  800fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fba:	01 d0                	add    %edx,%eax
  800fbc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fbf:	e9 7b ff ff ff       	jmp    800f3f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fc4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fc9:	74 08                	je     800fd3 <strtol+0x134>
		*endptr = (char *) s;
  800fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fce:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fd3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fd7:	74 07                	je     800fe0 <strtol+0x141>
  800fd9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fdc:	f7 d8                	neg    %eax
  800fde:	eb 03                	jmp    800fe3 <strtol+0x144>
  800fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fe3:	c9                   	leave  
  800fe4:	c3                   	ret    

00800fe5 <ltostr>:

void
ltostr(long value, char *str)
{
  800fe5:	55                   	push   %ebp
  800fe6:	89 e5                	mov    %esp,%ebp
  800fe8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800feb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800ff2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ff9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ffd:	79 13                	jns    801012 <ltostr+0x2d>
	{
		neg = 1;
  800fff:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801006:	8b 45 0c             	mov    0xc(%ebp),%eax
  801009:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80100c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80100f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80101a:	99                   	cltd   
  80101b:	f7 f9                	idiv   %ecx
  80101d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801020:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801023:	8d 50 01             	lea    0x1(%eax),%edx
  801026:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801029:	89 c2                	mov    %eax,%edx
  80102b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102e:	01 d0                	add    %edx,%eax
  801030:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801033:	83 c2 30             	add    $0x30,%edx
  801036:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801038:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80103b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801040:	f7 e9                	imul   %ecx
  801042:	c1 fa 02             	sar    $0x2,%edx
  801045:	89 c8                	mov    %ecx,%eax
  801047:	c1 f8 1f             	sar    $0x1f,%eax
  80104a:	29 c2                	sub    %eax,%edx
  80104c:	89 d0                	mov    %edx,%eax
  80104e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801051:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801054:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801059:	f7 e9                	imul   %ecx
  80105b:	c1 fa 02             	sar    $0x2,%edx
  80105e:	89 c8                	mov    %ecx,%eax
  801060:	c1 f8 1f             	sar    $0x1f,%eax
  801063:	29 c2                	sub    %eax,%edx
  801065:	89 d0                	mov    %edx,%eax
  801067:	c1 e0 02             	shl    $0x2,%eax
  80106a:	01 d0                	add    %edx,%eax
  80106c:	01 c0                	add    %eax,%eax
  80106e:	29 c1                	sub    %eax,%ecx
  801070:	89 ca                	mov    %ecx,%edx
  801072:	85 d2                	test   %edx,%edx
  801074:	75 9c                	jne    801012 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801076:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80107d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801080:	48                   	dec    %eax
  801081:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801084:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801088:	74 3d                	je     8010c7 <ltostr+0xe2>
		start = 1 ;
  80108a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801091:	eb 34                	jmp    8010c7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801093:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801096:	8b 45 0c             	mov    0xc(%ebp),%eax
  801099:	01 d0                	add    %edx,%eax
  80109b:	8a 00                	mov    (%eax),%al
  80109d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a6:	01 c2                	add    %eax,%edx
  8010a8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ae:	01 c8                	add    %ecx,%eax
  8010b0:	8a 00                	mov    (%eax),%al
  8010b2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ba:	01 c2                	add    %eax,%edx
  8010bc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010bf:	88 02                	mov    %al,(%edx)
		start++ ;
  8010c1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010c4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ca:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010cd:	7c c4                	jl     801093 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010cf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d5:	01 d0                	add    %edx,%eax
  8010d7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010da:	90                   	nop
  8010db:	c9                   	leave  
  8010dc:	c3                   	ret    

008010dd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010dd:	55                   	push   %ebp
  8010de:	89 e5                	mov    %esp,%ebp
  8010e0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010e3:	ff 75 08             	pushl  0x8(%ebp)
  8010e6:	e8 54 fa ff ff       	call   800b3f <strlen>
  8010eb:	83 c4 04             	add    $0x4,%esp
  8010ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010f1:	ff 75 0c             	pushl  0xc(%ebp)
  8010f4:	e8 46 fa ff ff       	call   800b3f <strlen>
  8010f9:	83 c4 04             	add    $0x4,%esp
  8010fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801106:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80110d:	eb 17                	jmp    801126 <strcconcat+0x49>
		final[s] = str1[s] ;
  80110f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801112:	8b 45 10             	mov    0x10(%ebp),%eax
  801115:	01 c2                	add    %eax,%edx
  801117:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80111a:	8b 45 08             	mov    0x8(%ebp),%eax
  80111d:	01 c8                	add    %ecx,%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801123:	ff 45 fc             	incl   -0x4(%ebp)
  801126:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801129:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80112c:	7c e1                	jl     80110f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80112e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801135:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80113c:	eb 1f                	jmp    80115d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80113e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801141:	8d 50 01             	lea    0x1(%eax),%edx
  801144:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801147:	89 c2                	mov    %eax,%edx
  801149:	8b 45 10             	mov    0x10(%ebp),%eax
  80114c:	01 c2                	add    %eax,%edx
  80114e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801151:	8b 45 0c             	mov    0xc(%ebp),%eax
  801154:	01 c8                	add    %ecx,%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80115a:	ff 45 f8             	incl   -0x8(%ebp)
  80115d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801160:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801163:	7c d9                	jl     80113e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801165:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801168:	8b 45 10             	mov    0x10(%ebp),%eax
  80116b:	01 d0                	add    %edx,%eax
  80116d:	c6 00 00             	movb   $0x0,(%eax)
}
  801170:	90                   	nop
  801171:	c9                   	leave  
  801172:	c3                   	ret    

00801173 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801173:	55                   	push   %ebp
  801174:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801176:	8b 45 14             	mov    0x14(%ebp),%eax
  801179:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80117f:	8b 45 14             	mov    0x14(%ebp),%eax
  801182:	8b 00                	mov    (%eax),%eax
  801184:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80118b:	8b 45 10             	mov    0x10(%ebp),%eax
  80118e:	01 d0                	add    %edx,%eax
  801190:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801196:	eb 0c                	jmp    8011a4 <strsplit+0x31>
			*string++ = 0;
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	8d 50 01             	lea    0x1(%eax),%edx
  80119e:	89 55 08             	mov    %edx,0x8(%ebp)
  8011a1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	84 c0                	test   %al,%al
  8011ab:	74 18                	je     8011c5 <strsplit+0x52>
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b0:	8a 00                	mov    (%eax),%al
  8011b2:	0f be c0             	movsbl %al,%eax
  8011b5:	50                   	push   %eax
  8011b6:	ff 75 0c             	pushl  0xc(%ebp)
  8011b9:	e8 13 fb ff ff       	call   800cd1 <strchr>
  8011be:	83 c4 08             	add    $0x8,%esp
  8011c1:	85 c0                	test   %eax,%eax
  8011c3:	75 d3                	jne    801198 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	84 c0                	test   %al,%al
  8011cc:	74 5a                	je     801228 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d1:	8b 00                	mov    (%eax),%eax
  8011d3:	83 f8 0f             	cmp    $0xf,%eax
  8011d6:	75 07                	jne    8011df <strsplit+0x6c>
		{
			return 0;
  8011d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8011dd:	eb 66                	jmp    801245 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011df:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e2:	8b 00                	mov    (%eax),%eax
  8011e4:	8d 48 01             	lea    0x1(%eax),%ecx
  8011e7:	8b 55 14             	mov    0x14(%ebp),%edx
  8011ea:	89 0a                	mov    %ecx,(%edx)
  8011ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f6:	01 c2                	add    %eax,%edx
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011fd:	eb 03                	jmp    801202 <strsplit+0x8f>
			string++;
  8011ff:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	84 c0                	test   %al,%al
  801209:	74 8b                	je     801196 <strsplit+0x23>
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	8a 00                	mov    (%eax),%al
  801210:	0f be c0             	movsbl %al,%eax
  801213:	50                   	push   %eax
  801214:	ff 75 0c             	pushl  0xc(%ebp)
  801217:	e8 b5 fa ff ff       	call   800cd1 <strchr>
  80121c:	83 c4 08             	add    $0x8,%esp
  80121f:	85 c0                	test   %eax,%eax
  801221:	74 dc                	je     8011ff <strsplit+0x8c>
			string++;
	}
  801223:	e9 6e ff ff ff       	jmp    801196 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801228:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801229:	8b 45 14             	mov    0x14(%ebp),%eax
  80122c:	8b 00                	mov    (%eax),%eax
  80122e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801235:	8b 45 10             	mov    0x10(%ebp),%eax
  801238:	01 d0                	add    %edx,%eax
  80123a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801240:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
  80124a:	57                   	push   %edi
  80124b:	56                   	push   %esi
  80124c:	53                   	push   %ebx
  80124d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8b 55 0c             	mov    0xc(%ebp),%edx
  801256:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801259:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80125c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80125f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801262:	cd 30                	int    $0x30
  801264:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801267:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80126a:	83 c4 10             	add    $0x10,%esp
  80126d:	5b                   	pop    %ebx
  80126e:	5e                   	pop    %esi
  80126f:	5f                   	pop    %edi
  801270:	5d                   	pop    %ebp
  801271:	c3                   	ret    

00801272 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801272:	55                   	push   %ebp
  801273:	89 e5                	mov    %esp,%ebp
  801275:	83 ec 04             	sub    $0x4,%esp
  801278:	8b 45 10             	mov    0x10(%ebp),%eax
  80127b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80127e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801282:	8b 45 08             	mov    0x8(%ebp),%eax
  801285:	6a 00                	push   $0x0
  801287:	6a 00                	push   $0x0
  801289:	52                   	push   %edx
  80128a:	ff 75 0c             	pushl  0xc(%ebp)
  80128d:	50                   	push   %eax
  80128e:	6a 00                	push   $0x0
  801290:	e8 b2 ff ff ff       	call   801247 <syscall>
  801295:	83 c4 18             	add    $0x18,%esp
}
  801298:	90                   	nop
  801299:	c9                   	leave  
  80129a:	c3                   	ret    

0080129b <sys_cgetc>:

int
sys_cgetc(void)
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 01                	push   $0x1
  8012aa:	e8 98 ff ff ff       	call   801247 <syscall>
  8012af:	83 c4 18             	add    $0x18,%esp
}
  8012b2:	c9                   	leave  
  8012b3:	c3                   	ret    

008012b4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012b4:	55                   	push   %ebp
  8012b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	50                   	push   %eax
  8012c3:	6a 05                	push   $0x5
  8012c5:	e8 7d ff ff ff       	call   801247 <syscall>
  8012ca:	83 c4 18             	add    $0x18,%esp
}
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 02                	push   $0x2
  8012de:	e8 64 ff ff ff       	call   801247 <syscall>
  8012e3:	83 c4 18             	add    $0x18,%esp
}
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 03                	push   $0x3
  8012f7:	e8 4b ff ff ff       	call   801247 <syscall>
  8012fc:	83 c4 18             	add    $0x18,%esp
}
  8012ff:	c9                   	leave  
  801300:	c3                   	ret    

00801301 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801301:	55                   	push   %ebp
  801302:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801304:	6a 00                	push   $0x0
  801306:	6a 00                	push   $0x0
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 04                	push   $0x4
  801310:	e8 32 ff ff ff       	call   801247 <syscall>
  801315:	83 c4 18             	add    $0x18,%esp
}
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_env_exit>:


void sys_env_exit(void)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 06                	push   $0x6
  801329:	e8 19 ff ff ff       	call   801247 <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	90                   	nop
  801332:	c9                   	leave  
  801333:	c3                   	ret    

00801334 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801337:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	52                   	push   %edx
  801344:	50                   	push   %eax
  801345:	6a 07                	push   $0x7
  801347:	e8 fb fe ff ff       	call   801247 <syscall>
  80134c:	83 c4 18             	add    $0x18,%esp
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
  801354:	56                   	push   %esi
  801355:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801356:	8b 75 18             	mov    0x18(%ebp),%esi
  801359:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80135c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80135f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	56                   	push   %esi
  801366:	53                   	push   %ebx
  801367:	51                   	push   %ecx
  801368:	52                   	push   %edx
  801369:	50                   	push   %eax
  80136a:	6a 08                	push   $0x8
  80136c:	e8 d6 fe ff ff       	call   801247 <syscall>
  801371:	83 c4 18             	add    $0x18,%esp
}
  801374:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801377:	5b                   	pop    %ebx
  801378:	5e                   	pop    %esi
  801379:	5d                   	pop    %ebp
  80137a:	c3                   	ret    

0080137b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80137e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	52                   	push   %edx
  80138b:	50                   	push   %eax
  80138c:	6a 09                	push   $0x9
  80138e:	e8 b4 fe ff ff       	call   801247 <syscall>
  801393:	83 c4 18             	add    $0x18,%esp
}
  801396:	c9                   	leave  
  801397:	c3                   	ret    

00801398 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	ff 75 0c             	pushl  0xc(%ebp)
  8013a4:	ff 75 08             	pushl  0x8(%ebp)
  8013a7:	6a 0a                	push   $0xa
  8013a9:	e8 99 fe ff ff       	call   801247 <syscall>
  8013ae:	83 c4 18             	add    $0x18,%esp
}
  8013b1:	c9                   	leave  
  8013b2:	c3                   	ret    

008013b3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 0b                	push   $0xb
  8013c2:	e8 80 fe ff ff       	call   801247 <syscall>
  8013c7:	83 c4 18             	add    $0x18,%esp
}
  8013ca:	c9                   	leave  
  8013cb:	c3                   	ret    

008013cc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013cc:	55                   	push   %ebp
  8013cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 0c                	push   $0xc
  8013db:	e8 67 fe ff ff       	call   801247 <syscall>
  8013e0:	83 c4 18             	add    $0x18,%esp
}
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 0d                	push   $0xd
  8013f4:	e8 4e fe ff ff       	call   801247 <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	ff 75 0c             	pushl  0xc(%ebp)
  80140a:	ff 75 08             	pushl  0x8(%ebp)
  80140d:	6a 11                	push   $0x11
  80140f:	e8 33 fe ff ff       	call   801247 <syscall>
  801414:	83 c4 18             	add    $0x18,%esp
	return;
  801417:	90                   	nop
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	ff 75 0c             	pushl  0xc(%ebp)
  801426:	ff 75 08             	pushl  0x8(%ebp)
  801429:	6a 12                	push   $0x12
  80142b:	e8 17 fe ff ff       	call   801247 <syscall>
  801430:	83 c4 18             	add    $0x18,%esp
	return ;
  801433:	90                   	nop
}
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 0e                	push   $0xe
  801445:	e8 fd fd ff ff       	call   801247 <syscall>
  80144a:	83 c4 18             	add    $0x18,%esp
}
  80144d:	c9                   	leave  
  80144e:	c3                   	ret    

0080144f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	ff 75 08             	pushl  0x8(%ebp)
  80145d:	6a 0f                	push   $0xf
  80145f:	e8 e3 fd ff ff       	call   801247 <syscall>
  801464:	83 c4 18             	add    $0x18,%esp
}
  801467:	c9                   	leave  
  801468:	c3                   	ret    

00801469 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801469:	55                   	push   %ebp
  80146a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 10                	push   $0x10
  801478:	e8 ca fd ff ff       	call   801247 <syscall>
  80147d:	83 c4 18             	add    $0x18,%esp
}
  801480:	90                   	nop
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 14                	push   $0x14
  801492:	e8 b0 fd ff ff       	call   801247 <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
}
  80149a:	90                   	nop
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 15                	push   $0x15
  8014ac:	e8 96 fd ff ff       	call   801247 <syscall>
  8014b1:	83 c4 18             	add    $0x18,%esp
}
  8014b4:	90                   	nop
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
  8014ba:	83 ec 04             	sub    $0x4,%esp
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014c3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	50                   	push   %eax
  8014d0:	6a 16                	push   $0x16
  8014d2:	e8 70 fd ff ff       	call   801247 <syscall>
  8014d7:	83 c4 18             	add    $0x18,%esp
}
  8014da:	90                   	nop
  8014db:	c9                   	leave  
  8014dc:	c3                   	ret    

008014dd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014dd:	55                   	push   %ebp
  8014de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 17                	push   $0x17
  8014ec:	e8 56 fd ff ff       	call   801247 <syscall>
  8014f1:	83 c4 18             	add    $0x18,%esp
}
  8014f4:	90                   	nop
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	ff 75 0c             	pushl  0xc(%ebp)
  801506:	50                   	push   %eax
  801507:	6a 18                	push   $0x18
  801509:	e8 39 fd ff ff       	call   801247 <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801516:	8b 55 0c             	mov    0xc(%ebp),%edx
  801519:	8b 45 08             	mov    0x8(%ebp),%eax
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	52                   	push   %edx
  801523:	50                   	push   %eax
  801524:	6a 1b                	push   $0x1b
  801526:	e8 1c fd ff ff       	call   801247 <syscall>
  80152b:	83 c4 18             	add    $0x18,%esp
}
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801533:	8b 55 0c             	mov    0xc(%ebp),%edx
  801536:	8b 45 08             	mov    0x8(%ebp),%eax
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	52                   	push   %edx
  801540:	50                   	push   %eax
  801541:	6a 19                	push   $0x19
  801543:	e8 ff fc ff ff       	call   801247 <syscall>
  801548:	83 c4 18             	add    $0x18,%esp
}
  80154b:	90                   	nop
  80154c:	c9                   	leave  
  80154d:	c3                   	ret    

0080154e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801551:	8b 55 0c             	mov    0xc(%ebp),%edx
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	52                   	push   %edx
  80155e:	50                   	push   %eax
  80155f:	6a 1a                	push   $0x1a
  801561:	e8 e1 fc ff ff       	call   801247 <syscall>
  801566:	83 c4 18             	add    $0x18,%esp
}
  801569:	90                   	nop
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
  80156f:	83 ec 04             	sub    $0x4,%esp
  801572:	8b 45 10             	mov    0x10(%ebp),%eax
  801575:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801578:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80157b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	6a 00                	push   $0x0
  801584:	51                   	push   %ecx
  801585:	52                   	push   %edx
  801586:	ff 75 0c             	pushl  0xc(%ebp)
  801589:	50                   	push   %eax
  80158a:	6a 1c                	push   $0x1c
  80158c:	e8 b6 fc ff ff       	call   801247 <syscall>
  801591:	83 c4 18             	add    $0x18,%esp
}
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801599:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	52                   	push   %edx
  8015a6:	50                   	push   %eax
  8015a7:	6a 1d                	push   $0x1d
  8015a9:	e8 99 fc ff ff       	call   801247 <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	51                   	push   %ecx
  8015c4:	52                   	push   %edx
  8015c5:	50                   	push   %eax
  8015c6:	6a 1e                	push   $0x1e
  8015c8:	e8 7a fc ff ff       	call   801247 <syscall>
  8015cd:	83 c4 18             	add    $0x18,%esp
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	52                   	push   %edx
  8015e2:	50                   	push   %eax
  8015e3:	6a 1f                	push   $0x1f
  8015e5:	e8 5d fc ff ff       	call   801247 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 20                	push   $0x20
  8015fe:	e8 44 fc ff ff       	call   801247 <syscall>
  801603:	83 c4 18             	add    $0x18,%esp
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	ff 75 10             	pushl  0x10(%ebp)
  801615:	ff 75 0c             	pushl  0xc(%ebp)
  801618:	50                   	push   %eax
  801619:	6a 21                	push   $0x21
  80161b:	e8 27 fc ff ff       	call   801247 <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
}
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	50                   	push   %eax
  801634:	6a 22                	push   $0x22
  801636:	e8 0c fc ff ff       	call   801247 <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	90                   	nop
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	50                   	push   %eax
  801650:	6a 23                	push   $0x23
  801652:	e8 f0 fb ff ff       	call   801247 <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	90                   	nop
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
  801660:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801663:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801666:	8d 50 04             	lea    0x4(%eax),%edx
  801669:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	52                   	push   %edx
  801673:	50                   	push   %eax
  801674:	6a 24                	push   $0x24
  801676:	e8 cc fb ff ff       	call   801247 <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
	return result;
  80167e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801681:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801684:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801687:	89 01                	mov    %eax,(%ecx)
  801689:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	c9                   	leave  
  801690:	c2 04 00             	ret    $0x4

00801693 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801693:	55                   	push   %ebp
  801694:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	ff 75 10             	pushl  0x10(%ebp)
  80169d:	ff 75 0c             	pushl  0xc(%ebp)
  8016a0:	ff 75 08             	pushl  0x8(%ebp)
  8016a3:	6a 13                	push   $0x13
  8016a5:	e8 9d fb ff ff       	call   801247 <syscall>
  8016aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ad:	90                   	nop
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 25                	push   $0x25
  8016bf:	e8 83 fb ff ff       	call   801247 <syscall>
  8016c4:	83 c4 18             	add    $0x18,%esp
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
  8016cc:	83 ec 04             	sub    $0x4,%esp
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016d5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	50                   	push   %eax
  8016e2:	6a 26                	push   $0x26
  8016e4:	e8 5e fb ff ff       	call   801247 <syscall>
  8016e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ec:	90                   	nop
}
  8016ed:	c9                   	leave  
  8016ee:	c3                   	ret    

008016ef <rsttst>:
void rsttst()
{
  8016ef:	55                   	push   %ebp
  8016f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 28                	push   $0x28
  8016fe:	e8 44 fb ff ff       	call   801247 <syscall>
  801703:	83 c4 18             	add    $0x18,%esp
	return ;
  801706:	90                   	nop
}
  801707:	c9                   	leave  
  801708:	c3                   	ret    

00801709 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801709:	55                   	push   %ebp
  80170a:	89 e5                	mov    %esp,%ebp
  80170c:	83 ec 04             	sub    $0x4,%esp
  80170f:	8b 45 14             	mov    0x14(%ebp),%eax
  801712:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801715:	8b 55 18             	mov    0x18(%ebp),%edx
  801718:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80171c:	52                   	push   %edx
  80171d:	50                   	push   %eax
  80171e:	ff 75 10             	pushl  0x10(%ebp)
  801721:	ff 75 0c             	pushl  0xc(%ebp)
  801724:	ff 75 08             	pushl  0x8(%ebp)
  801727:	6a 27                	push   $0x27
  801729:	e8 19 fb ff ff       	call   801247 <syscall>
  80172e:	83 c4 18             	add    $0x18,%esp
	return ;
  801731:	90                   	nop
}
  801732:	c9                   	leave  
  801733:	c3                   	ret    

00801734 <chktst>:
void chktst(uint32 n)
{
  801734:	55                   	push   %ebp
  801735:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	ff 75 08             	pushl  0x8(%ebp)
  801742:	6a 29                	push   $0x29
  801744:	e8 fe fa ff ff       	call   801247 <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
	return ;
  80174c:	90                   	nop
}
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <inctst>:

void inctst()
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 2a                	push   $0x2a
  80175e:	e8 e4 fa ff ff       	call   801247 <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
	return ;
  801766:	90                   	nop
}
  801767:	c9                   	leave  
  801768:	c3                   	ret    

00801769 <gettst>:
uint32 gettst()
{
  801769:	55                   	push   %ebp
  80176a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 2b                	push   $0x2b
  801778:	e8 ca fa ff ff       	call   801247 <syscall>
  80177d:	83 c4 18             	add    $0x18,%esp
}
  801780:	c9                   	leave  
  801781:	c3                   	ret    

00801782 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801782:	55                   	push   %ebp
  801783:	89 e5                	mov    %esp,%ebp
  801785:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 2c                	push   $0x2c
  801794:	e8 ae fa ff ff       	call   801247 <syscall>
  801799:	83 c4 18             	add    $0x18,%esp
  80179c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80179f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017a3:	75 07                	jne    8017ac <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8017aa:	eb 05                	jmp    8017b1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017b1:	c9                   	leave  
  8017b2:	c3                   	ret    

008017b3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017b3:	55                   	push   %ebp
  8017b4:	89 e5                	mov    %esp,%ebp
  8017b6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 2c                	push   $0x2c
  8017c5:	e8 7d fa ff ff       	call   801247 <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
  8017cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017d0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017d4:	75 07                	jne    8017dd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8017db:	eb 05                	jmp    8017e2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
  8017e7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 2c                	push   $0x2c
  8017f6:	e8 4c fa ff ff       	call   801247 <syscall>
  8017fb:	83 c4 18             	add    $0x18,%esp
  8017fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801801:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801805:	75 07                	jne    80180e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801807:	b8 01 00 00 00       	mov    $0x1,%eax
  80180c:	eb 05                	jmp    801813 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80180e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
  801818:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 2c                	push   $0x2c
  801827:	e8 1b fa ff ff       	call   801247 <syscall>
  80182c:	83 c4 18             	add    $0x18,%esp
  80182f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801832:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801836:	75 07                	jne    80183f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801838:	b8 01 00 00 00       	mov    $0x1,%eax
  80183d:	eb 05                	jmp    801844 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80183f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	ff 75 08             	pushl  0x8(%ebp)
  801854:	6a 2d                	push   $0x2d
  801856:	e8 ec f9 ff ff       	call   801247 <syscall>
  80185b:	83 c4 18             	add    $0x18,%esp
	return ;
  80185e:	90                   	nop
}
  80185f:	c9                   	leave  
  801860:	c3                   	ret    

00801861 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801861:	55                   	push   %ebp
  801862:	89 e5                	mov    %esp,%ebp
  801864:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801867:	8b 45 08             	mov    0x8(%ebp),%eax
  80186a:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80186d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801871:	83 ec 0c             	sub    $0xc,%esp
  801874:	50                   	push   %eax
  801875:	e8 3d fc ff ff       	call   8014b7 <sys_cputc>
  80187a:	83 c4 10             	add    $0x10,%esp
}
  80187d:	90                   	nop
  80187e:	c9                   	leave  
  80187f:	c3                   	ret    

00801880 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  801880:	55                   	push   %ebp
  801881:	89 e5                	mov    %esp,%ebp
  801883:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801886:	e8 f8 fb ff ff       	call   801483 <sys_disable_interrupt>
	char c = ch;
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
  80188e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801891:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801895:	83 ec 0c             	sub    $0xc,%esp
  801898:	50                   	push   %eax
  801899:	e8 19 fc ff ff       	call   8014b7 <sys_cputc>
  80189e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8018a1:	e8 f7 fb ff ff       	call   80149d <sys_enable_interrupt>
}
  8018a6:	90                   	nop
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <getchar>:

int
getchar(void)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
  8018ac:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8018af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018b6:	eb 08                	jmp    8018c0 <getchar+0x17>
	{
		c = sys_cgetc();
  8018b8:	e8 de f9 ff ff       	call   80129b <sys_cgetc>
  8018bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8018c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018c4:	74 f2                	je     8018b8 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8018c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018c9:	c9                   	leave  
  8018ca:	c3                   	ret    

008018cb <atomic_getchar>:

int
atomic_getchar(void)
{
  8018cb:	55                   	push   %ebp
  8018cc:	89 e5                	mov    %esp,%ebp
  8018ce:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8018d1:	e8 ad fb ff ff       	call   801483 <sys_disable_interrupt>
	int c=0;
  8018d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018dd:	eb 08                	jmp    8018e7 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8018df:	e8 b7 f9 ff ff       	call   80129b <sys_cgetc>
  8018e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8018e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018eb:	74 f2                	je     8018df <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8018ed:	e8 ab fb ff ff       	call   80149d <sys_enable_interrupt>
	return c;
  8018f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018f5:	c9                   	leave  
  8018f6:	c3                   	ret    

008018f7 <iscons>:

int iscons(int fdnum)
{
  8018f7:	55                   	push   %ebp
  8018f8:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8018fa:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8018ff:	5d                   	pop    %ebp
  801900:	c3                   	ret    
  801901:	66 90                	xchg   %ax,%ax
  801903:	90                   	nop

00801904 <__udivdi3>:
  801904:	55                   	push   %ebp
  801905:	57                   	push   %edi
  801906:	56                   	push   %esi
  801907:	53                   	push   %ebx
  801908:	83 ec 1c             	sub    $0x1c,%esp
  80190b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80190f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801913:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801917:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80191b:	89 ca                	mov    %ecx,%edx
  80191d:	89 f8                	mov    %edi,%eax
  80191f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801923:	85 f6                	test   %esi,%esi
  801925:	75 2d                	jne    801954 <__udivdi3+0x50>
  801927:	39 cf                	cmp    %ecx,%edi
  801929:	77 65                	ja     801990 <__udivdi3+0x8c>
  80192b:	89 fd                	mov    %edi,%ebp
  80192d:	85 ff                	test   %edi,%edi
  80192f:	75 0b                	jne    80193c <__udivdi3+0x38>
  801931:	b8 01 00 00 00       	mov    $0x1,%eax
  801936:	31 d2                	xor    %edx,%edx
  801938:	f7 f7                	div    %edi
  80193a:	89 c5                	mov    %eax,%ebp
  80193c:	31 d2                	xor    %edx,%edx
  80193e:	89 c8                	mov    %ecx,%eax
  801940:	f7 f5                	div    %ebp
  801942:	89 c1                	mov    %eax,%ecx
  801944:	89 d8                	mov    %ebx,%eax
  801946:	f7 f5                	div    %ebp
  801948:	89 cf                	mov    %ecx,%edi
  80194a:	89 fa                	mov    %edi,%edx
  80194c:	83 c4 1c             	add    $0x1c,%esp
  80194f:	5b                   	pop    %ebx
  801950:	5e                   	pop    %esi
  801951:	5f                   	pop    %edi
  801952:	5d                   	pop    %ebp
  801953:	c3                   	ret    
  801954:	39 ce                	cmp    %ecx,%esi
  801956:	77 28                	ja     801980 <__udivdi3+0x7c>
  801958:	0f bd fe             	bsr    %esi,%edi
  80195b:	83 f7 1f             	xor    $0x1f,%edi
  80195e:	75 40                	jne    8019a0 <__udivdi3+0x9c>
  801960:	39 ce                	cmp    %ecx,%esi
  801962:	72 0a                	jb     80196e <__udivdi3+0x6a>
  801964:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801968:	0f 87 9e 00 00 00    	ja     801a0c <__udivdi3+0x108>
  80196e:	b8 01 00 00 00       	mov    $0x1,%eax
  801973:	89 fa                	mov    %edi,%edx
  801975:	83 c4 1c             	add    $0x1c,%esp
  801978:	5b                   	pop    %ebx
  801979:	5e                   	pop    %esi
  80197a:	5f                   	pop    %edi
  80197b:	5d                   	pop    %ebp
  80197c:	c3                   	ret    
  80197d:	8d 76 00             	lea    0x0(%esi),%esi
  801980:	31 ff                	xor    %edi,%edi
  801982:	31 c0                	xor    %eax,%eax
  801984:	89 fa                	mov    %edi,%edx
  801986:	83 c4 1c             	add    $0x1c,%esp
  801989:	5b                   	pop    %ebx
  80198a:	5e                   	pop    %esi
  80198b:	5f                   	pop    %edi
  80198c:	5d                   	pop    %ebp
  80198d:	c3                   	ret    
  80198e:	66 90                	xchg   %ax,%ax
  801990:	89 d8                	mov    %ebx,%eax
  801992:	f7 f7                	div    %edi
  801994:	31 ff                	xor    %edi,%edi
  801996:	89 fa                	mov    %edi,%edx
  801998:	83 c4 1c             	add    $0x1c,%esp
  80199b:	5b                   	pop    %ebx
  80199c:	5e                   	pop    %esi
  80199d:	5f                   	pop    %edi
  80199e:	5d                   	pop    %ebp
  80199f:	c3                   	ret    
  8019a0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019a5:	89 eb                	mov    %ebp,%ebx
  8019a7:	29 fb                	sub    %edi,%ebx
  8019a9:	89 f9                	mov    %edi,%ecx
  8019ab:	d3 e6                	shl    %cl,%esi
  8019ad:	89 c5                	mov    %eax,%ebp
  8019af:	88 d9                	mov    %bl,%cl
  8019b1:	d3 ed                	shr    %cl,%ebp
  8019b3:	89 e9                	mov    %ebp,%ecx
  8019b5:	09 f1                	or     %esi,%ecx
  8019b7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019bb:	89 f9                	mov    %edi,%ecx
  8019bd:	d3 e0                	shl    %cl,%eax
  8019bf:	89 c5                	mov    %eax,%ebp
  8019c1:	89 d6                	mov    %edx,%esi
  8019c3:	88 d9                	mov    %bl,%cl
  8019c5:	d3 ee                	shr    %cl,%esi
  8019c7:	89 f9                	mov    %edi,%ecx
  8019c9:	d3 e2                	shl    %cl,%edx
  8019cb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019cf:	88 d9                	mov    %bl,%cl
  8019d1:	d3 e8                	shr    %cl,%eax
  8019d3:	09 c2                	or     %eax,%edx
  8019d5:	89 d0                	mov    %edx,%eax
  8019d7:	89 f2                	mov    %esi,%edx
  8019d9:	f7 74 24 0c          	divl   0xc(%esp)
  8019dd:	89 d6                	mov    %edx,%esi
  8019df:	89 c3                	mov    %eax,%ebx
  8019e1:	f7 e5                	mul    %ebp
  8019e3:	39 d6                	cmp    %edx,%esi
  8019e5:	72 19                	jb     801a00 <__udivdi3+0xfc>
  8019e7:	74 0b                	je     8019f4 <__udivdi3+0xf0>
  8019e9:	89 d8                	mov    %ebx,%eax
  8019eb:	31 ff                	xor    %edi,%edi
  8019ed:	e9 58 ff ff ff       	jmp    80194a <__udivdi3+0x46>
  8019f2:	66 90                	xchg   %ax,%ax
  8019f4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8019f8:	89 f9                	mov    %edi,%ecx
  8019fa:	d3 e2                	shl    %cl,%edx
  8019fc:	39 c2                	cmp    %eax,%edx
  8019fe:	73 e9                	jae    8019e9 <__udivdi3+0xe5>
  801a00:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a03:	31 ff                	xor    %edi,%edi
  801a05:	e9 40 ff ff ff       	jmp    80194a <__udivdi3+0x46>
  801a0a:	66 90                	xchg   %ax,%ax
  801a0c:	31 c0                	xor    %eax,%eax
  801a0e:	e9 37 ff ff ff       	jmp    80194a <__udivdi3+0x46>
  801a13:	90                   	nop

00801a14 <__umoddi3>:
  801a14:	55                   	push   %ebp
  801a15:	57                   	push   %edi
  801a16:	56                   	push   %esi
  801a17:	53                   	push   %ebx
  801a18:	83 ec 1c             	sub    $0x1c,%esp
  801a1b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a1f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a27:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a2f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a33:	89 f3                	mov    %esi,%ebx
  801a35:	89 fa                	mov    %edi,%edx
  801a37:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a3b:	89 34 24             	mov    %esi,(%esp)
  801a3e:	85 c0                	test   %eax,%eax
  801a40:	75 1a                	jne    801a5c <__umoddi3+0x48>
  801a42:	39 f7                	cmp    %esi,%edi
  801a44:	0f 86 a2 00 00 00    	jbe    801aec <__umoddi3+0xd8>
  801a4a:	89 c8                	mov    %ecx,%eax
  801a4c:	89 f2                	mov    %esi,%edx
  801a4e:	f7 f7                	div    %edi
  801a50:	89 d0                	mov    %edx,%eax
  801a52:	31 d2                	xor    %edx,%edx
  801a54:	83 c4 1c             	add    $0x1c,%esp
  801a57:	5b                   	pop    %ebx
  801a58:	5e                   	pop    %esi
  801a59:	5f                   	pop    %edi
  801a5a:	5d                   	pop    %ebp
  801a5b:	c3                   	ret    
  801a5c:	39 f0                	cmp    %esi,%eax
  801a5e:	0f 87 ac 00 00 00    	ja     801b10 <__umoddi3+0xfc>
  801a64:	0f bd e8             	bsr    %eax,%ebp
  801a67:	83 f5 1f             	xor    $0x1f,%ebp
  801a6a:	0f 84 ac 00 00 00    	je     801b1c <__umoddi3+0x108>
  801a70:	bf 20 00 00 00       	mov    $0x20,%edi
  801a75:	29 ef                	sub    %ebp,%edi
  801a77:	89 fe                	mov    %edi,%esi
  801a79:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a7d:	89 e9                	mov    %ebp,%ecx
  801a7f:	d3 e0                	shl    %cl,%eax
  801a81:	89 d7                	mov    %edx,%edi
  801a83:	89 f1                	mov    %esi,%ecx
  801a85:	d3 ef                	shr    %cl,%edi
  801a87:	09 c7                	or     %eax,%edi
  801a89:	89 e9                	mov    %ebp,%ecx
  801a8b:	d3 e2                	shl    %cl,%edx
  801a8d:	89 14 24             	mov    %edx,(%esp)
  801a90:	89 d8                	mov    %ebx,%eax
  801a92:	d3 e0                	shl    %cl,%eax
  801a94:	89 c2                	mov    %eax,%edx
  801a96:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a9a:	d3 e0                	shl    %cl,%eax
  801a9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801aa0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aa4:	89 f1                	mov    %esi,%ecx
  801aa6:	d3 e8                	shr    %cl,%eax
  801aa8:	09 d0                	or     %edx,%eax
  801aaa:	d3 eb                	shr    %cl,%ebx
  801aac:	89 da                	mov    %ebx,%edx
  801aae:	f7 f7                	div    %edi
  801ab0:	89 d3                	mov    %edx,%ebx
  801ab2:	f7 24 24             	mull   (%esp)
  801ab5:	89 c6                	mov    %eax,%esi
  801ab7:	89 d1                	mov    %edx,%ecx
  801ab9:	39 d3                	cmp    %edx,%ebx
  801abb:	0f 82 87 00 00 00    	jb     801b48 <__umoddi3+0x134>
  801ac1:	0f 84 91 00 00 00    	je     801b58 <__umoddi3+0x144>
  801ac7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801acb:	29 f2                	sub    %esi,%edx
  801acd:	19 cb                	sbb    %ecx,%ebx
  801acf:	89 d8                	mov    %ebx,%eax
  801ad1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ad5:	d3 e0                	shl    %cl,%eax
  801ad7:	89 e9                	mov    %ebp,%ecx
  801ad9:	d3 ea                	shr    %cl,%edx
  801adb:	09 d0                	or     %edx,%eax
  801add:	89 e9                	mov    %ebp,%ecx
  801adf:	d3 eb                	shr    %cl,%ebx
  801ae1:	89 da                	mov    %ebx,%edx
  801ae3:	83 c4 1c             	add    $0x1c,%esp
  801ae6:	5b                   	pop    %ebx
  801ae7:	5e                   	pop    %esi
  801ae8:	5f                   	pop    %edi
  801ae9:	5d                   	pop    %ebp
  801aea:	c3                   	ret    
  801aeb:	90                   	nop
  801aec:	89 fd                	mov    %edi,%ebp
  801aee:	85 ff                	test   %edi,%edi
  801af0:	75 0b                	jne    801afd <__umoddi3+0xe9>
  801af2:	b8 01 00 00 00       	mov    $0x1,%eax
  801af7:	31 d2                	xor    %edx,%edx
  801af9:	f7 f7                	div    %edi
  801afb:	89 c5                	mov    %eax,%ebp
  801afd:	89 f0                	mov    %esi,%eax
  801aff:	31 d2                	xor    %edx,%edx
  801b01:	f7 f5                	div    %ebp
  801b03:	89 c8                	mov    %ecx,%eax
  801b05:	f7 f5                	div    %ebp
  801b07:	89 d0                	mov    %edx,%eax
  801b09:	e9 44 ff ff ff       	jmp    801a52 <__umoddi3+0x3e>
  801b0e:	66 90                	xchg   %ax,%ax
  801b10:	89 c8                	mov    %ecx,%eax
  801b12:	89 f2                	mov    %esi,%edx
  801b14:	83 c4 1c             	add    $0x1c,%esp
  801b17:	5b                   	pop    %ebx
  801b18:	5e                   	pop    %esi
  801b19:	5f                   	pop    %edi
  801b1a:	5d                   	pop    %ebp
  801b1b:	c3                   	ret    
  801b1c:	3b 04 24             	cmp    (%esp),%eax
  801b1f:	72 06                	jb     801b27 <__umoddi3+0x113>
  801b21:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b25:	77 0f                	ja     801b36 <__umoddi3+0x122>
  801b27:	89 f2                	mov    %esi,%edx
  801b29:	29 f9                	sub    %edi,%ecx
  801b2b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b2f:	89 14 24             	mov    %edx,(%esp)
  801b32:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b36:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b3a:	8b 14 24             	mov    (%esp),%edx
  801b3d:	83 c4 1c             	add    $0x1c,%esp
  801b40:	5b                   	pop    %ebx
  801b41:	5e                   	pop    %esi
  801b42:	5f                   	pop    %edi
  801b43:	5d                   	pop    %ebp
  801b44:	c3                   	ret    
  801b45:	8d 76 00             	lea    0x0(%esi),%esi
  801b48:	2b 04 24             	sub    (%esp),%eax
  801b4b:	19 fa                	sbb    %edi,%edx
  801b4d:	89 d1                	mov    %edx,%ecx
  801b4f:	89 c6                	mov    %eax,%esi
  801b51:	e9 71 ff ff ff       	jmp    801ac7 <__umoddi3+0xb3>
  801b56:	66 90                	xchg   %ax,%ax
  801b58:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b5c:	72 ea                	jb     801b48 <__umoddi3+0x134>
  801b5e:	89 d9                	mov    %ebx,%ecx
  801b60:	e9 62 ff ff ff       	jmp    801ac7 <__umoddi3+0xb3>
