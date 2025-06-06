
obj/user/sc_scarceMemoryWithLargeArr:     file format elf32-i386


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
  800031:	e8 70 00 00 00       	call   8000a6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

//char Elements[102400*PAGE_SIZE];
char Elements[25600*PAGE_SIZE];
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	/*[1] CREATE LARGE ARRAY THAT SCARCE MEMORY*/
	env_sleep(500000);
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 20 a1 07 00       	push   $0x7a120
  800046:	e8 65 18 00 00       	call   8018b0 <env_sleep>
  80004b:	83 c4 10             	add    $0x10,%esp
	uint32 required_size = sizeof(int) * 3;
  80004e:	c7 45 f0 0c 00 00 00 	movl   $0xc,-0x10(%ebp)
	uint32 *Elements2 = malloc(required_size) ;
  800055:	83 ec 0c             	sub    $0xc,%esp
  800058:	ff 75 f0             	pushl  -0x10(%ebp)
  80005b:	e8 e0 0f 00 00       	call   801040 <malloc>
  800060:	83 c4 10             	add    $0x10,%esp
  800063:	89 45 ec             	mov    %eax,-0x14(%ebp)
//
//	for(uint32 i = 0; i < 13500*PAGE_SIZE; i+=PAGE_SIZE)
//	{
//		Elements[i] = 0;
//	}
	for(uint32 i = 0; i < required_size; i+=PAGE_SIZE)
  800066:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80006d:	eb 1c                	jmp    80008b <_main+0x53>
	{
		Elements2[i] = 0;
  80006f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800072:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800079:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80007c:	01 d0                	add    %edx,%eax
  80007e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//
//	for(uint32 i = 0; i < 13500*PAGE_SIZE; i+=PAGE_SIZE)
//	{
//		Elements[i] = 0;
//	}
	for(uint32 i = 0; i < required_size; i+=PAGE_SIZE)
  800084:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  80008b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80008e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800091:	72 dc                	jb     80006f <_main+0x37>
	{
		Elements2[i] = 0;
	}

	cprintf("Congratulations!! Scenario of Handling SCARCE MEM is completed successfully!!\n\n\n");
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	68 c0 1d 80 00       	push   $0x801dc0
  80009b:	e8 dc 01 00 00       	call   80027c <cprintf>
  8000a0:	83 c4 10             	add    $0x10,%esp

	return;
  8000a3:	90                   	nop
}
  8000a4:	c9                   	leave  
  8000a5:	c3                   	ret    

008000a6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000a6:	55                   	push   %ebp
  8000a7:	89 e5                	mov    %esp,%ebp
  8000a9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000ac:	e8 86 12 00 00       	call   801337 <sys_getenvindex>
  8000b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000b7:	89 d0                	mov    %edx,%eax
  8000b9:	01 c0                	add    %eax,%eax
  8000bb:	01 d0                	add    %edx,%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	01 d0                	add    %edx,%eax
  8000c2:	c1 e0 06             	shl    $0x6,%eax
  8000c5:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000ca:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d4:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000da:	84 c0                	test   %al,%al
  8000dc:	74 0f                	je     8000ed <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000e8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ed:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000f1:	7e 0a                	jle    8000fd <libmain+0x57>
		binaryname = argv[0];
  8000f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f6:	8b 00                	mov    (%eax),%eax
  8000f8:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8000fd:	83 ec 08             	sub    $0x8,%esp
  800100:	ff 75 0c             	pushl  0xc(%ebp)
  800103:	ff 75 08             	pushl  0x8(%ebp)
  800106:	e8 2d ff ff ff       	call   800038 <_main>
  80010b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80010e:	e8 bf 13 00 00       	call   8014d2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800113:	83 ec 0c             	sub    $0xc,%esp
  800116:	68 2c 1e 80 00       	push   $0x801e2c
  80011b:	e8 5c 01 00 00       	call   80027c <cprintf>
  800120:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800123:	a1 20 30 80 00       	mov    0x803020,%eax
  800128:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80012e:	a1 20 30 80 00       	mov    0x803020,%eax
  800133:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800139:	83 ec 04             	sub    $0x4,%esp
  80013c:	52                   	push   %edx
  80013d:	50                   	push   %eax
  80013e:	68 54 1e 80 00       	push   $0x801e54
  800143:	e8 34 01 00 00       	call   80027c <cprintf>
  800148:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80014b:	a1 20 30 80 00       	mov    0x803020,%eax
  800150:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800156:	83 ec 08             	sub    $0x8,%esp
  800159:	50                   	push   %eax
  80015a:	68 79 1e 80 00       	push   $0x801e79
  80015f:	e8 18 01 00 00       	call   80027c <cprintf>
  800164:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800167:	83 ec 0c             	sub    $0xc,%esp
  80016a:	68 2c 1e 80 00       	push   $0x801e2c
  80016f:	e8 08 01 00 00       	call   80027c <cprintf>
  800174:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800177:	e8 70 13 00 00       	call   8014ec <sys_enable_interrupt>

	// exit gracefully
	exit();
  80017c:	e8 19 00 00 00       	call   80019a <exit>
}
  800181:	90                   	nop
  800182:	c9                   	leave  
  800183:	c3                   	ret    

00800184 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800184:	55                   	push   %ebp
  800185:	89 e5                	mov    %esp,%ebp
  800187:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80018a:	83 ec 0c             	sub    $0xc,%esp
  80018d:	6a 00                	push   $0x0
  80018f:	e8 6f 11 00 00       	call   801303 <sys_env_destroy>
  800194:	83 c4 10             	add    $0x10,%esp
}
  800197:	90                   	nop
  800198:	c9                   	leave  
  800199:	c3                   	ret    

0080019a <exit>:

void
exit(void)
{
  80019a:	55                   	push   %ebp
  80019b:	89 e5                	mov    %esp,%ebp
  80019d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001a0:	e8 c4 11 00 00       	call   801369 <sys_env_exit>
}
  8001a5:	90                   	nop
  8001a6:	c9                   	leave  
  8001a7:	c3                   	ret    

008001a8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001a8:	55                   	push   %ebp
  8001a9:	89 e5                	mov    %esp,%ebp
  8001ab:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b1:	8b 00                	mov    (%eax),%eax
  8001b3:	8d 48 01             	lea    0x1(%eax),%ecx
  8001b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b9:	89 0a                	mov    %ecx,(%edx)
  8001bb:	8b 55 08             	mov    0x8(%ebp),%edx
  8001be:	88 d1                	mov    %dl,%cl
  8001c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ca:	8b 00                	mov    (%eax),%eax
  8001cc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001d1:	75 2c                	jne    8001ff <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001d3:	a0 24 30 80 00       	mov    0x803024,%al
  8001d8:	0f b6 c0             	movzbl %al,%eax
  8001db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001de:	8b 12                	mov    (%edx),%edx
  8001e0:	89 d1                	mov    %edx,%ecx
  8001e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e5:	83 c2 08             	add    $0x8,%edx
  8001e8:	83 ec 04             	sub    $0x4,%esp
  8001eb:	50                   	push   %eax
  8001ec:	51                   	push   %ecx
  8001ed:	52                   	push   %edx
  8001ee:	e8 ce 10 00 00       	call   8012c1 <sys_cputs>
  8001f3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800202:	8b 40 04             	mov    0x4(%eax),%eax
  800205:	8d 50 01             	lea    0x1(%eax),%edx
  800208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80020e:	90                   	nop
  80020f:	c9                   	leave  
  800210:	c3                   	ret    

00800211 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800211:	55                   	push   %ebp
  800212:	89 e5                	mov    %esp,%ebp
  800214:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80021a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800221:	00 00 00 
	b.cnt = 0;
  800224:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80022b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80022e:	ff 75 0c             	pushl  0xc(%ebp)
  800231:	ff 75 08             	pushl  0x8(%ebp)
  800234:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80023a:	50                   	push   %eax
  80023b:	68 a8 01 80 00       	push   $0x8001a8
  800240:	e8 11 02 00 00       	call   800456 <vprintfmt>
  800245:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800248:	a0 24 30 80 00       	mov    0x803024,%al
  80024d:	0f b6 c0             	movzbl %al,%eax
  800250:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800256:	83 ec 04             	sub    $0x4,%esp
  800259:	50                   	push   %eax
  80025a:	52                   	push   %edx
  80025b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800261:	83 c0 08             	add    $0x8,%eax
  800264:	50                   	push   %eax
  800265:	e8 57 10 00 00       	call   8012c1 <sys_cputs>
  80026a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80026d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800274:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80027a:	c9                   	leave  
  80027b:	c3                   	ret    

0080027c <cprintf>:

int cprintf(const char *fmt, ...) {
  80027c:	55                   	push   %ebp
  80027d:	89 e5                	mov    %esp,%ebp
  80027f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800282:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800289:	8d 45 0c             	lea    0xc(%ebp),%eax
  80028c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80028f:	8b 45 08             	mov    0x8(%ebp),%eax
  800292:	83 ec 08             	sub    $0x8,%esp
  800295:	ff 75 f4             	pushl  -0xc(%ebp)
  800298:	50                   	push   %eax
  800299:	e8 73 ff ff ff       	call   800211 <vcprintf>
  80029e:	83 c4 10             	add    $0x10,%esp
  8002a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002a7:	c9                   	leave  
  8002a8:	c3                   	ret    

008002a9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002a9:	55                   	push   %ebp
  8002aa:	89 e5                	mov    %esp,%ebp
  8002ac:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002af:	e8 1e 12 00 00       	call   8014d2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002b4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8002bd:	83 ec 08             	sub    $0x8,%esp
  8002c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c3:	50                   	push   %eax
  8002c4:	e8 48 ff ff ff       	call   800211 <vcprintf>
  8002c9:	83 c4 10             	add    $0x10,%esp
  8002cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002cf:	e8 18 12 00 00       	call   8014ec <sys_enable_interrupt>
	return cnt;
  8002d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002d7:	c9                   	leave  
  8002d8:	c3                   	ret    

008002d9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002d9:	55                   	push   %ebp
  8002da:	89 e5                	mov    %esp,%ebp
  8002dc:	53                   	push   %ebx
  8002dd:	83 ec 14             	sub    $0x14,%esp
  8002e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8002e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002ec:	8b 45 18             	mov    0x18(%ebp),%eax
  8002ef:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002f7:	77 55                	ja     80034e <printnum+0x75>
  8002f9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002fc:	72 05                	jb     800303 <printnum+0x2a>
  8002fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800301:	77 4b                	ja     80034e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800303:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800306:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800309:	8b 45 18             	mov    0x18(%ebp),%eax
  80030c:	ba 00 00 00 00       	mov    $0x0,%edx
  800311:	52                   	push   %edx
  800312:	50                   	push   %eax
  800313:	ff 75 f4             	pushl  -0xc(%ebp)
  800316:	ff 75 f0             	pushl  -0x10(%ebp)
  800319:	e8 26 18 00 00       	call   801b44 <__udivdi3>
  80031e:	83 c4 10             	add    $0x10,%esp
  800321:	83 ec 04             	sub    $0x4,%esp
  800324:	ff 75 20             	pushl  0x20(%ebp)
  800327:	53                   	push   %ebx
  800328:	ff 75 18             	pushl  0x18(%ebp)
  80032b:	52                   	push   %edx
  80032c:	50                   	push   %eax
  80032d:	ff 75 0c             	pushl  0xc(%ebp)
  800330:	ff 75 08             	pushl  0x8(%ebp)
  800333:	e8 a1 ff ff ff       	call   8002d9 <printnum>
  800338:	83 c4 20             	add    $0x20,%esp
  80033b:	eb 1a                	jmp    800357 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80033d:	83 ec 08             	sub    $0x8,%esp
  800340:	ff 75 0c             	pushl  0xc(%ebp)
  800343:	ff 75 20             	pushl  0x20(%ebp)
  800346:	8b 45 08             	mov    0x8(%ebp),%eax
  800349:	ff d0                	call   *%eax
  80034b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80034e:	ff 4d 1c             	decl   0x1c(%ebp)
  800351:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800355:	7f e6                	jg     80033d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800357:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80035a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80035f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800362:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800365:	53                   	push   %ebx
  800366:	51                   	push   %ecx
  800367:	52                   	push   %edx
  800368:	50                   	push   %eax
  800369:	e8 e6 18 00 00       	call   801c54 <__umoddi3>
  80036e:	83 c4 10             	add    $0x10,%esp
  800371:	05 b4 20 80 00       	add    $0x8020b4,%eax
  800376:	8a 00                	mov    (%eax),%al
  800378:	0f be c0             	movsbl %al,%eax
  80037b:	83 ec 08             	sub    $0x8,%esp
  80037e:	ff 75 0c             	pushl  0xc(%ebp)
  800381:	50                   	push   %eax
  800382:	8b 45 08             	mov    0x8(%ebp),%eax
  800385:	ff d0                	call   *%eax
  800387:	83 c4 10             	add    $0x10,%esp
}
  80038a:	90                   	nop
  80038b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80038e:	c9                   	leave  
  80038f:	c3                   	ret    

00800390 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800390:	55                   	push   %ebp
  800391:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800393:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800397:	7e 1c                	jle    8003b5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800399:	8b 45 08             	mov    0x8(%ebp),%eax
  80039c:	8b 00                	mov    (%eax),%eax
  80039e:	8d 50 08             	lea    0x8(%eax),%edx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	89 10                	mov    %edx,(%eax)
  8003a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a9:	8b 00                	mov    (%eax),%eax
  8003ab:	83 e8 08             	sub    $0x8,%eax
  8003ae:	8b 50 04             	mov    0x4(%eax),%edx
  8003b1:	8b 00                	mov    (%eax),%eax
  8003b3:	eb 40                	jmp    8003f5 <getuint+0x65>
	else if (lflag)
  8003b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003b9:	74 1e                	je     8003d9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003be:	8b 00                	mov    (%eax),%eax
  8003c0:	8d 50 04             	lea    0x4(%eax),%edx
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	89 10                	mov    %edx,(%eax)
  8003c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cb:	8b 00                	mov    (%eax),%eax
  8003cd:	83 e8 04             	sub    $0x4,%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	ba 00 00 00 00       	mov    $0x0,%edx
  8003d7:	eb 1c                	jmp    8003f5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dc:	8b 00                	mov    (%eax),%eax
  8003de:	8d 50 04             	lea    0x4(%eax),%edx
  8003e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e4:	89 10                	mov    %edx,(%eax)
  8003e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e9:	8b 00                	mov    (%eax),%eax
  8003eb:	83 e8 04             	sub    $0x4,%eax
  8003ee:	8b 00                	mov    (%eax),%eax
  8003f0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003f5:	5d                   	pop    %ebp
  8003f6:	c3                   	ret    

008003f7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003f7:	55                   	push   %ebp
  8003f8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003fa:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003fe:	7e 1c                	jle    80041c <getint+0x25>
		return va_arg(*ap, long long);
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	8b 00                	mov    (%eax),%eax
  800405:	8d 50 08             	lea    0x8(%eax),%edx
  800408:	8b 45 08             	mov    0x8(%ebp),%eax
  80040b:	89 10                	mov    %edx,(%eax)
  80040d:	8b 45 08             	mov    0x8(%ebp),%eax
  800410:	8b 00                	mov    (%eax),%eax
  800412:	83 e8 08             	sub    $0x8,%eax
  800415:	8b 50 04             	mov    0x4(%eax),%edx
  800418:	8b 00                	mov    (%eax),%eax
  80041a:	eb 38                	jmp    800454 <getint+0x5d>
	else if (lflag)
  80041c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800420:	74 1a                	je     80043c <getint+0x45>
		return va_arg(*ap, long);
  800422:	8b 45 08             	mov    0x8(%ebp),%eax
  800425:	8b 00                	mov    (%eax),%eax
  800427:	8d 50 04             	lea    0x4(%eax),%edx
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	89 10                	mov    %edx,(%eax)
  80042f:	8b 45 08             	mov    0x8(%ebp),%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	83 e8 04             	sub    $0x4,%eax
  800437:	8b 00                	mov    (%eax),%eax
  800439:	99                   	cltd   
  80043a:	eb 18                	jmp    800454 <getint+0x5d>
	else
		return va_arg(*ap, int);
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
}
  800454:	5d                   	pop    %ebp
  800455:	c3                   	ret    

00800456 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800456:	55                   	push   %ebp
  800457:	89 e5                	mov    %esp,%ebp
  800459:	56                   	push   %esi
  80045a:	53                   	push   %ebx
  80045b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80045e:	eb 17                	jmp    800477 <vprintfmt+0x21>
			if (ch == '\0')
  800460:	85 db                	test   %ebx,%ebx
  800462:	0f 84 af 03 00 00    	je     800817 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800468:	83 ec 08             	sub    $0x8,%esp
  80046b:	ff 75 0c             	pushl  0xc(%ebp)
  80046e:	53                   	push   %ebx
  80046f:	8b 45 08             	mov    0x8(%ebp),%eax
  800472:	ff d0                	call   *%eax
  800474:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800477:	8b 45 10             	mov    0x10(%ebp),%eax
  80047a:	8d 50 01             	lea    0x1(%eax),%edx
  80047d:	89 55 10             	mov    %edx,0x10(%ebp)
  800480:	8a 00                	mov    (%eax),%al
  800482:	0f b6 d8             	movzbl %al,%ebx
  800485:	83 fb 25             	cmp    $0x25,%ebx
  800488:	75 d6                	jne    800460 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80048a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80048e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800495:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80049c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004a3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ad:	8d 50 01             	lea    0x1(%eax),%edx
  8004b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b3:	8a 00                	mov    (%eax),%al
  8004b5:	0f b6 d8             	movzbl %al,%ebx
  8004b8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004bb:	83 f8 55             	cmp    $0x55,%eax
  8004be:	0f 87 2b 03 00 00    	ja     8007ef <vprintfmt+0x399>
  8004c4:	8b 04 85 d8 20 80 00 	mov    0x8020d8(,%eax,4),%eax
  8004cb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004cd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004d1:	eb d7                	jmp    8004aa <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004d3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004d7:	eb d1                	jmp    8004aa <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004d9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004e0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004e3:	89 d0                	mov    %edx,%eax
  8004e5:	c1 e0 02             	shl    $0x2,%eax
  8004e8:	01 d0                	add    %edx,%eax
  8004ea:	01 c0                	add    %eax,%eax
  8004ec:	01 d8                	add    %ebx,%eax
  8004ee:	83 e8 30             	sub    $0x30,%eax
  8004f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f7:	8a 00                	mov    (%eax),%al
  8004f9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004fc:	83 fb 2f             	cmp    $0x2f,%ebx
  8004ff:	7e 3e                	jle    80053f <vprintfmt+0xe9>
  800501:	83 fb 39             	cmp    $0x39,%ebx
  800504:	7f 39                	jg     80053f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800506:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800509:	eb d5                	jmp    8004e0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80050b:	8b 45 14             	mov    0x14(%ebp),%eax
  80050e:	83 c0 04             	add    $0x4,%eax
  800511:	89 45 14             	mov    %eax,0x14(%ebp)
  800514:	8b 45 14             	mov    0x14(%ebp),%eax
  800517:	83 e8 04             	sub    $0x4,%eax
  80051a:	8b 00                	mov    (%eax),%eax
  80051c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80051f:	eb 1f                	jmp    800540 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800521:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800525:	79 83                	jns    8004aa <vprintfmt+0x54>
				width = 0;
  800527:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80052e:	e9 77 ff ff ff       	jmp    8004aa <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800533:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80053a:	e9 6b ff ff ff       	jmp    8004aa <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80053f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800540:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800544:	0f 89 60 ff ff ff    	jns    8004aa <vprintfmt+0x54>
				width = precision, precision = -1;
  80054a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80054d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800550:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800557:	e9 4e ff ff ff       	jmp    8004aa <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80055c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80055f:	e9 46 ff ff ff       	jmp    8004aa <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800564:	8b 45 14             	mov    0x14(%ebp),%eax
  800567:	83 c0 04             	add    $0x4,%eax
  80056a:	89 45 14             	mov    %eax,0x14(%ebp)
  80056d:	8b 45 14             	mov    0x14(%ebp),%eax
  800570:	83 e8 04             	sub    $0x4,%eax
  800573:	8b 00                	mov    (%eax),%eax
  800575:	83 ec 08             	sub    $0x8,%esp
  800578:	ff 75 0c             	pushl  0xc(%ebp)
  80057b:	50                   	push   %eax
  80057c:	8b 45 08             	mov    0x8(%ebp),%eax
  80057f:	ff d0                	call   *%eax
  800581:	83 c4 10             	add    $0x10,%esp
			break;
  800584:	e9 89 02 00 00       	jmp    800812 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800589:	8b 45 14             	mov    0x14(%ebp),%eax
  80058c:	83 c0 04             	add    $0x4,%eax
  80058f:	89 45 14             	mov    %eax,0x14(%ebp)
  800592:	8b 45 14             	mov    0x14(%ebp),%eax
  800595:	83 e8 04             	sub    $0x4,%eax
  800598:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80059a:	85 db                	test   %ebx,%ebx
  80059c:	79 02                	jns    8005a0 <vprintfmt+0x14a>
				err = -err;
  80059e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005a0:	83 fb 64             	cmp    $0x64,%ebx
  8005a3:	7f 0b                	jg     8005b0 <vprintfmt+0x15a>
  8005a5:	8b 34 9d 20 1f 80 00 	mov    0x801f20(,%ebx,4),%esi
  8005ac:	85 f6                	test   %esi,%esi
  8005ae:	75 19                	jne    8005c9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005b0:	53                   	push   %ebx
  8005b1:	68 c5 20 80 00       	push   $0x8020c5
  8005b6:	ff 75 0c             	pushl  0xc(%ebp)
  8005b9:	ff 75 08             	pushl  0x8(%ebp)
  8005bc:	e8 5e 02 00 00       	call   80081f <printfmt>
  8005c1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005c4:	e9 49 02 00 00       	jmp    800812 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005c9:	56                   	push   %esi
  8005ca:	68 ce 20 80 00       	push   $0x8020ce
  8005cf:	ff 75 0c             	pushl  0xc(%ebp)
  8005d2:	ff 75 08             	pushl  0x8(%ebp)
  8005d5:	e8 45 02 00 00       	call   80081f <printfmt>
  8005da:	83 c4 10             	add    $0x10,%esp
			break;
  8005dd:	e9 30 02 00 00       	jmp    800812 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e5:	83 c0 04             	add    $0x4,%eax
  8005e8:	89 45 14             	mov    %eax,0x14(%ebp)
  8005eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ee:	83 e8 04             	sub    $0x4,%eax
  8005f1:	8b 30                	mov    (%eax),%esi
  8005f3:	85 f6                	test   %esi,%esi
  8005f5:	75 05                	jne    8005fc <vprintfmt+0x1a6>
				p = "(null)";
  8005f7:	be d1 20 80 00       	mov    $0x8020d1,%esi
			if (width > 0 && padc != '-')
  8005fc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800600:	7e 6d                	jle    80066f <vprintfmt+0x219>
  800602:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800606:	74 67                	je     80066f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800608:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060b:	83 ec 08             	sub    $0x8,%esp
  80060e:	50                   	push   %eax
  80060f:	56                   	push   %esi
  800610:	e8 0c 03 00 00       	call   800921 <strnlen>
  800615:	83 c4 10             	add    $0x10,%esp
  800618:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80061b:	eb 16                	jmp    800633 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80061d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800621:	83 ec 08             	sub    $0x8,%esp
  800624:	ff 75 0c             	pushl  0xc(%ebp)
  800627:	50                   	push   %eax
  800628:	8b 45 08             	mov    0x8(%ebp),%eax
  80062b:	ff d0                	call   *%eax
  80062d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800630:	ff 4d e4             	decl   -0x1c(%ebp)
  800633:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800637:	7f e4                	jg     80061d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800639:	eb 34                	jmp    80066f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80063b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80063f:	74 1c                	je     80065d <vprintfmt+0x207>
  800641:	83 fb 1f             	cmp    $0x1f,%ebx
  800644:	7e 05                	jle    80064b <vprintfmt+0x1f5>
  800646:	83 fb 7e             	cmp    $0x7e,%ebx
  800649:	7e 12                	jle    80065d <vprintfmt+0x207>
					putch('?', putdat);
  80064b:	83 ec 08             	sub    $0x8,%esp
  80064e:	ff 75 0c             	pushl  0xc(%ebp)
  800651:	6a 3f                	push   $0x3f
  800653:	8b 45 08             	mov    0x8(%ebp),%eax
  800656:	ff d0                	call   *%eax
  800658:	83 c4 10             	add    $0x10,%esp
  80065b:	eb 0f                	jmp    80066c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80065d:	83 ec 08             	sub    $0x8,%esp
  800660:	ff 75 0c             	pushl  0xc(%ebp)
  800663:	53                   	push   %ebx
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	ff d0                	call   *%eax
  800669:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80066c:	ff 4d e4             	decl   -0x1c(%ebp)
  80066f:	89 f0                	mov    %esi,%eax
  800671:	8d 70 01             	lea    0x1(%eax),%esi
  800674:	8a 00                	mov    (%eax),%al
  800676:	0f be d8             	movsbl %al,%ebx
  800679:	85 db                	test   %ebx,%ebx
  80067b:	74 24                	je     8006a1 <vprintfmt+0x24b>
  80067d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800681:	78 b8                	js     80063b <vprintfmt+0x1e5>
  800683:	ff 4d e0             	decl   -0x20(%ebp)
  800686:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80068a:	79 af                	jns    80063b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80068c:	eb 13                	jmp    8006a1 <vprintfmt+0x24b>
				putch(' ', putdat);
  80068e:	83 ec 08             	sub    $0x8,%esp
  800691:	ff 75 0c             	pushl  0xc(%ebp)
  800694:	6a 20                	push   $0x20
  800696:	8b 45 08             	mov    0x8(%ebp),%eax
  800699:	ff d0                	call   *%eax
  80069b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80069e:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a5:	7f e7                	jg     80068e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006a7:	e9 66 01 00 00       	jmp    800812 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006ac:	83 ec 08             	sub    $0x8,%esp
  8006af:	ff 75 e8             	pushl  -0x18(%ebp)
  8006b2:	8d 45 14             	lea    0x14(%ebp),%eax
  8006b5:	50                   	push   %eax
  8006b6:	e8 3c fd ff ff       	call   8003f7 <getint>
  8006bb:	83 c4 10             	add    $0x10,%esp
  8006be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ca:	85 d2                	test   %edx,%edx
  8006cc:	79 23                	jns    8006f1 <vprintfmt+0x29b>
				putch('-', putdat);
  8006ce:	83 ec 08             	sub    $0x8,%esp
  8006d1:	ff 75 0c             	pushl  0xc(%ebp)
  8006d4:	6a 2d                	push   $0x2d
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	ff d0                	call   *%eax
  8006db:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e4:	f7 d8                	neg    %eax
  8006e6:	83 d2 00             	adc    $0x0,%edx
  8006e9:	f7 da                	neg    %edx
  8006eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006f1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006f8:	e9 bc 00 00 00       	jmp    8007b9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006fd:	83 ec 08             	sub    $0x8,%esp
  800700:	ff 75 e8             	pushl  -0x18(%ebp)
  800703:	8d 45 14             	lea    0x14(%ebp),%eax
  800706:	50                   	push   %eax
  800707:	e8 84 fc ff ff       	call   800390 <getuint>
  80070c:	83 c4 10             	add    $0x10,%esp
  80070f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800712:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800715:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80071c:	e9 98 00 00 00       	jmp    8007b9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800721:	83 ec 08             	sub    $0x8,%esp
  800724:	ff 75 0c             	pushl  0xc(%ebp)
  800727:	6a 58                	push   $0x58
  800729:	8b 45 08             	mov    0x8(%ebp),%eax
  80072c:	ff d0                	call   *%eax
  80072e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 0c             	pushl  0xc(%ebp)
  800737:	6a 58                	push   $0x58
  800739:	8b 45 08             	mov    0x8(%ebp),%eax
  80073c:	ff d0                	call   *%eax
  80073e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800741:	83 ec 08             	sub    $0x8,%esp
  800744:	ff 75 0c             	pushl  0xc(%ebp)
  800747:	6a 58                	push   $0x58
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	ff d0                	call   *%eax
  80074e:	83 c4 10             	add    $0x10,%esp
			break;
  800751:	e9 bc 00 00 00       	jmp    800812 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800756:	83 ec 08             	sub    $0x8,%esp
  800759:	ff 75 0c             	pushl  0xc(%ebp)
  80075c:	6a 30                	push   $0x30
  80075e:	8b 45 08             	mov    0x8(%ebp),%eax
  800761:	ff d0                	call   *%eax
  800763:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800766:	83 ec 08             	sub    $0x8,%esp
  800769:	ff 75 0c             	pushl  0xc(%ebp)
  80076c:	6a 78                	push   $0x78
  80076e:	8b 45 08             	mov    0x8(%ebp),%eax
  800771:	ff d0                	call   *%eax
  800773:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800776:	8b 45 14             	mov    0x14(%ebp),%eax
  800779:	83 c0 04             	add    $0x4,%eax
  80077c:	89 45 14             	mov    %eax,0x14(%ebp)
  80077f:	8b 45 14             	mov    0x14(%ebp),%eax
  800782:	83 e8 04             	sub    $0x4,%eax
  800785:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800787:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800791:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800798:	eb 1f                	jmp    8007b9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80079a:	83 ec 08             	sub    $0x8,%esp
  80079d:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a0:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a3:	50                   	push   %eax
  8007a4:	e8 e7 fb ff ff       	call   800390 <getuint>
  8007a9:	83 c4 10             	add    $0x10,%esp
  8007ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007af:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007b2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007b9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007c0:	83 ec 04             	sub    $0x4,%esp
  8007c3:	52                   	push   %edx
  8007c4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007c7:	50                   	push   %eax
  8007c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cb:	ff 75 f0             	pushl  -0x10(%ebp)
  8007ce:	ff 75 0c             	pushl  0xc(%ebp)
  8007d1:	ff 75 08             	pushl  0x8(%ebp)
  8007d4:	e8 00 fb ff ff       	call   8002d9 <printnum>
  8007d9:	83 c4 20             	add    $0x20,%esp
			break;
  8007dc:	eb 34                	jmp    800812 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007de:	83 ec 08             	sub    $0x8,%esp
  8007e1:	ff 75 0c             	pushl  0xc(%ebp)
  8007e4:	53                   	push   %ebx
  8007e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e8:	ff d0                	call   *%eax
  8007ea:	83 c4 10             	add    $0x10,%esp
			break;
  8007ed:	eb 23                	jmp    800812 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007ef:	83 ec 08             	sub    $0x8,%esp
  8007f2:	ff 75 0c             	pushl  0xc(%ebp)
  8007f5:	6a 25                	push   $0x25
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	ff d0                	call   *%eax
  8007fc:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007ff:	ff 4d 10             	decl   0x10(%ebp)
  800802:	eb 03                	jmp    800807 <vprintfmt+0x3b1>
  800804:	ff 4d 10             	decl   0x10(%ebp)
  800807:	8b 45 10             	mov    0x10(%ebp),%eax
  80080a:	48                   	dec    %eax
  80080b:	8a 00                	mov    (%eax),%al
  80080d:	3c 25                	cmp    $0x25,%al
  80080f:	75 f3                	jne    800804 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800811:	90                   	nop
		}
	}
  800812:	e9 47 fc ff ff       	jmp    80045e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800817:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800818:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80081b:	5b                   	pop    %ebx
  80081c:	5e                   	pop    %esi
  80081d:	5d                   	pop    %ebp
  80081e:	c3                   	ret    

0080081f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80081f:	55                   	push   %ebp
  800820:	89 e5                	mov    %esp,%ebp
  800822:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800825:	8d 45 10             	lea    0x10(%ebp),%eax
  800828:	83 c0 04             	add    $0x4,%eax
  80082b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80082e:	8b 45 10             	mov    0x10(%ebp),%eax
  800831:	ff 75 f4             	pushl  -0xc(%ebp)
  800834:	50                   	push   %eax
  800835:	ff 75 0c             	pushl  0xc(%ebp)
  800838:	ff 75 08             	pushl  0x8(%ebp)
  80083b:	e8 16 fc ff ff       	call   800456 <vprintfmt>
  800840:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800843:	90                   	nop
  800844:	c9                   	leave  
  800845:	c3                   	ret    

00800846 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800846:	55                   	push   %ebp
  800847:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800849:	8b 45 0c             	mov    0xc(%ebp),%eax
  80084c:	8b 40 08             	mov    0x8(%eax),%eax
  80084f:	8d 50 01             	lea    0x1(%eax),%edx
  800852:	8b 45 0c             	mov    0xc(%ebp),%eax
  800855:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800858:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085b:	8b 10                	mov    (%eax),%edx
  80085d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800860:	8b 40 04             	mov    0x4(%eax),%eax
  800863:	39 c2                	cmp    %eax,%edx
  800865:	73 12                	jae    800879 <sprintputch+0x33>
		*b->buf++ = ch;
  800867:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086a:	8b 00                	mov    (%eax),%eax
  80086c:	8d 48 01             	lea    0x1(%eax),%ecx
  80086f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800872:	89 0a                	mov    %ecx,(%edx)
  800874:	8b 55 08             	mov    0x8(%ebp),%edx
  800877:	88 10                	mov    %dl,(%eax)
}
  800879:	90                   	nop
  80087a:	5d                   	pop    %ebp
  80087b:	c3                   	ret    

0080087c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80087c:	55                   	push   %ebp
  80087d:	89 e5                	mov    %esp,%ebp
  80087f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800882:	8b 45 08             	mov    0x8(%ebp),%eax
  800885:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800888:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80088e:	8b 45 08             	mov    0x8(%ebp),%eax
  800891:	01 d0                	add    %edx,%eax
  800893:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800896:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80089d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008a1:	74 06                	je     8008a9 <vsnprintf+0x2d>
  8008a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a7:	7f 07                	jg     8008b0 <vsnprintf+0x34>
		return -E_INVAL;
  8008a9:	b8 03 00 00 00       	mov    $0x3,%eax
  8008ae:	eb 20                	jmp    8008d0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008b0:	ff 75 14             	pushl  0x14(%ebp)
  8008b3:	ff 75 10             	pushl  0x10(%ebp)
  8008b6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008b9:	50                   	push   %eax
  8008ba:	68 46 08 80 00       	push   $0x800846
  8008bf:	e8 92 fb ff ff       	call   800456 <vprintfmt>
  8008c4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ca:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008d0:	c9                   	leave  
  8008d1:	c3                   	ret    

008008d2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008d2:	55                   	push   %ebp
  8008d3:	89 e5                	mov    %esp,%ebp
  8008d5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008d8:	8d 45 10             	lea    0x10(%ebp),%eax
  8008db:	83 c0 04             	add    $0x4,%eax
  8008de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e4:	ff 75 f4             	pushl  -0xc(%ebp)
  8008e7:	50                   	push   %eax
  8008e8:	ff 75 0c             	pushl  0xc(%ebp)
  8008eb:	ff 75 08             	pushl  0x8(%ebp)
  8008ee:	e8 89 ff ff ff       	call   80087c <vsnprintf>
  8008f3:	83 c4 10             	add    $0x10,%esp
  8008f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008fc:	c9                   	leave  
  8008fd:	c3                   	ret    

008008fe <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008fe:	55                   	push   %ebp
  8008ff:	89 e5                	mov    %esp,%ebp
  800901:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800904:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80090b:	eb 06                	jmp    800913 <strlen+0x15>
		n++;
  80090d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800910:	ff 45 08             	incl   0x8(%ebp)
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	8a 00                	mov    (%eax),%al
  800918:	84 c0                	test   %al,%al
  80091a:	75 f1                	jne    80090d <strlen+0xf>
		n++;
	return n;
  80091c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800927:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80092e:	eb 09                	jmp    800939 <strnlen+0x18>
		n++;
  800930:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800933:	ff 45 08             	incl   0x8(%ebp)
  800936:	ff 4d 0c             	decl   0xc(%ebp)
  800939:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80093d:	74 09                	je     800948 <strnlen+0x27>
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	8a 00                	mov    (%eax),%al
  800944:	84 c0                	test   %al,%al
  800946:	75 e8                	jne    800930 <strnlen+0xf>
		n++;
	return n;
  800948:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80094b:	c9                   	leave  
  80094c:	c3                   	ret    

0080094d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80094d:	55                   	push   %ebp
  80094e:	89 e5                	mov    %esp,%ebp
  800950:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800959:	90                   	nop
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	8d 50 01             	lea    0x1(%eax),%edx
  800960:	89 55 08             	mov    %edx,0x8(%ebp)
  800963:	8b 55 0c             	mov    0xc(%ebp),%edx
  800966:	8d 4a 01             	lea    0x1(%edx),%ecx
  800969:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80096c:	8a 12                	mov    (%edx),%dl
  80096e:	88 10                	mov    %dl,(%eax)
  800970:	8a 00                	mov    (%eax),%al
  800972:	84 c0                	test   %al,%al
  800974:	75 e4                	jne    80095a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800976:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800979:	c9                   	leave  
  80097a:	c3                   	ret    

0080097b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80097b:	55                   	push   %ebp
  80097c:	89 e5                	mov    %esp,%ebp
  80097e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800981:	8b 45 08             	mov    0x8(%ebp),%eax
  800984:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800987:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80098e:	eb 1f                	jmp    8009af <strncpy+0x34>
		*dst++ = *src;
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	8d 50 01             	lea    0x1(%eax),%edx
  800996:	89 55 08             	mov    %edx,0x8(%ebp)
  800999:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099c:	8a 12                	mov    (%edx),%dl
  80099e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a3:	8a 00                	mov    (%eax),%al
  8009a5:	84 c0                	test   %al,%al
  8009a7:	74 03                	je     8009ac <strncpy+0x31>
			src++;
  8009a9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009ac:	ff 45 fc             	incl   -0x4(%ebp)
  8009af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009b2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009b5:	72 d9                	jb     800990 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009ba:	c9                   	leave  
  8009bb:	c3                   	ret    

008009bc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009bc:	55                   	push   %ebp
  8009bd:	89 e5                	mov    %esp,%ebp
  8009bf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009cc:	74 30                	je     8009fe <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009ce:	eb 16                	jmp    8009e6 <strlcpy+0x2a>
			*dst++ = *src++;
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	8d 50 01             	lea    0x1(%eax),%edx
  8009d6:	89 55 08             	mov    %edx,0x8(%ebp)
  8009d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009dc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009df:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009e2:	8a 12                	mov    (%edx),%dl
  8009e4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009e6:	ff 4d 10             	decl   0x10(%ebp)
  8009e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ed:	74 09                	je     8009f8 <strlcpy+0x3c>
  8009ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f2:	8a 00                	mov    (%eax),%al
  8009f4:	84 c0                	test   %al,%al
  8009f6:	75 d8                	jne    8009d0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fb:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009fe:	8b 55 08             	mov    0x8(%ebp),%edx
  800a01:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a04:	29 c2                	sub    %eax,%edx
  800a06:	89 d0                	mov    %edx,%eax
}
  800a08:	c9                   	leave  
  800a09:	c3                   	ret    

00800a0a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a0a:	55                   	push   %ebp
  800a0b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a0d:	eb 06                	jmp    800a15 <strcmp+0xb>
		p++, q++;
  800a0f:	ff 45 08             	incl   0x8(%ebp)
  800a12:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	8a 00                	mov    (%eax),%al
  800a1a:	84 c0                	test   %al,%al
  800a1c:	74 0e                	je     800a2c <strcmp+0x22>
  800a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a21:	8a 10                	mov    (%eax),%dl
  800a23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a26:	8a 00                	mov    (%eax),%al
  800a28:	38 c2                	cmp    %al,%dl
  800a2a:	74 e3                	je     800a0f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2f:	8a 00                	mov    (%eax),%al
  800a31:	0f b6 d0             	movzbl %al,%edx
  800a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a37:	8a 00                	mov    (%eax),%al
  800a39:	0f b6 c0             	movzbl %al,%eax
  800a3c:	29 c2                	sub    %eax,%edx
  800a3e:	89 d0                	mov    %edx,%eax
}
  800a40:	5d                   	pop    %ebp
  800a41:	c3                   	ret    

00800a42 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a42:	55                   	push   %ebp
  800a43:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a45:	eb 09                	jmp    800a50 <strncmp+0xe>
		n--, p++, q++;
  800a47:	ff 4d 10             	decl   0x10(%ebp)
  800a4a:	ff 45 08             	incl   0x8(%ebp)
  800a4d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a50:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a54:	74 17                	je     800a6d <strncmp+0x2b>
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	8a 00                	mov    (%eax),%al
  800a5b:	84 c0                	test   %al,%al
  800a5d:	74 0e                	je     800a6d <strncmp+0x2b>
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	8a 10                	mov    (%eax),%dl
  800a64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a67:	8a 00                	mov    (%eax),%al
  800a69:	38 c2                	cmp    %al,%dl
  800a6b:	74 da                	je     800a47 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a71:	75 07                	jne    800a7a <strncmp+0x38>
		return 0;
  800a73:	b8 00 00 00 00       	mov    $0x0,%eax
  800a78:	eb 14                	jmp    800a8e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	8a 00                	mov    (%eax),%al
  800a7f:	0f b6 d0             	movzbl %al,%edx
  800a82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a85:	8a 00                	mov    (%eax),%al
  800a87:	0f b6 c0             	movzbl %al,%eax
  800a8a:	29 c2                	sub    %eax,%edx
  800a8c:	89 d0                	mov    %edx,%eax
}
  800a8e:	5d                   	pop    %ebp
  800a8f:	c3                   	ret    

00800a90 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a90:	55                   	push   %ebp
  800a91:	89 e5                	mov    %esp,%ebp
  800a93:	83 ec 04             	sub    $0x4,%esp
  800a96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a99:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a9c:	eb 12                	jmp    800ab0 <strchr+0x20>
		if (*s == c)
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	8a 00                	mov    (%eax),%al
  800aa3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aa6:	75 05                	jne    800aad <strchr+0x1d>
			return (char *) s;
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	eb 11                	jmp    800abe <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800aad:	ff 45 08             	incl   0x8(%ebp)
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	8a 00                	mov    (%eax),%al
  800ab5:	84 c0                	test   %al,%al
  800ab7:	75 e5                	jne    800a9e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ab9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800abe:	c9                   	leave  
  800abf:	c3                   	ret    

00800ac0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ac0:	55                   	push   %ebp
  800ac1:	89 e5                	mov    %esp,%ebp
  800ac3:	83 ec 04             	sub    $0x4,%esp
  800ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800acc:	eb 0d                	jmp    800adb <strfind+0x1b>
		if (*s == c)
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	8a 00                	mov    (%eax),%al
  800ad3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad6:	74 0e                	je     800ae6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ad8:	ff 45 08             	incl   0x8(%ebp)
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	8a 00                	mov    (%eax),%al
  800ae0:	84 c0                	test   %al,%al
  800ae2:	75 ea                	jne    800ace <strfind+0xe>
  800ae4:	eb 01                	jmp    800ae7 <strfind+0x27>
		if (*s == c)
			break;
  800ae6:	90                   	nop
	return (char *) s;
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aea:	c9                   	leave  
  800aeb:	c3                   	ret    

00800aec <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800aec:	55                   	push   %ebp
  800aed:	89 e5                	mov    %esp,%ebp
  800aef:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800af2:	8b 45 08             	mov    0x8(%ebp),%eax
  800af5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800af8:	8b 45 10             	mov    0x10(%ebp),%eax
  800afb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800afe:	eb 0e                	jmp    800b0e <memset+0x22>
		*p++ = c;
  800b00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b03:	8d 50 01             	lea    0x1(%eax),%edx
  800b06:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b09:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b0e:	ff 4d f8             	decl   -0x8(%ebp)
  800b11:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b15:	79 e9                	jns    800b00 <memset+0x14>
		*p++ = c;

	return v;
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b1a:	c9                   	leave  
  800b1b:	c3                   	ret    

00800b1c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b1c:	55                   	push   %ebp
  800b1d:	89 e5                	mov    %esp,%ebp
  800b1f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b2e:	eb 16                	jmp    800b46 <memcpy+0x2a>
		*d++ = *s++;
  800b30:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b33:	8d 50 01             	lea    0x1(%eax),%edx
  800b36:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b3c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b3f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b42:	8a 12                	mov    (%edx),%dl
  800b44:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b46:	8b 45 10             	mov    0x10(%ebp),%eax
  800b49:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b4f:	85 c0                	test   %eax,%eax
  800b51:	75 dd                	jne    800b30 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b56:	c9                   	leave  
  800b57:	c3                   	ret    

00800b58 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b58:	55                   	push   %ebp
  800b59:	89 e5                	mov    %esp,%ebp
  800b5b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b6d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b70:	73 50                	jae    800bc2 <memmove+0x6a>
  800b72:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b75:	8b 45 10             	mov    0x10(%ebp),%eax
  800b78:	01 d0                	add    %edx,%eax
  800b7a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b7d:	76 43                	jbe    800bc2 <memmove+0x6a>
		s += n;
  800b7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b82:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b85:	8b 45 10             	mov    0x10(%ebp),%eax
  800b88:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b8b:	eb 10                	jmp    800b9d <memmove+0x45>
			*--d = *--s;
  800b8d:	ff 4d f8             	decl   -0x8(%ebp)
  800b90:	ff 4d fc             	decl   -0x4(%ebp)
  800b93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b96:	8a 10                	mov    (%eax),%dl
  800b98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b9b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba3:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba6:	85 c0                	test   %eax,%eax
  800ba8:	75 e3                	jne    800b8d <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800baa:	eb 23                	jmp    800bcf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800baf:	8d 50 01             	lea    0x1(%eax),%edx
  800bb2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bb5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bb8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bbb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bbe:	8a 12                	mov    (%edx),%dl
  800bc0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bcb:	85 c0                	test   %eax,%eax
  800bcd:	75 dd                	jne    800bac <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd2:	c9                   	leave  
  800bd3:	c3                   	ret    

00800bd4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bd4:	55                   	push   %ebp
  800bd5:	89 e5                	mov    %esp,%ebp
  800bd7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800be6:	eb 2a                	jmp    800c12 <memcmp+0x3e>
		if (*s1 != *s2)
  800be8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800beb:	8a 10                	mov    (%eax),%dl
  800bed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf0:	8a 00                	mov    (%eax),%al
  800bf2:	38 c2                	cmp    %al,%dl
  800bf4:	74 16                	je     800c0c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bf6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	0f b6 d0             	movzbl %al,%edx
  800bfe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c01:	8a 00                	mov    (%eax),%al
  800c03:	0f b6 c0             	movzbl %al,%eax
  800c06:	29 c2                	sub    %eax,%edx
  800c08:	89 d0                	mov    %edx,%eax
  800c0a:	eb 18                	jmp    800c24 <memcmp+0x50>
		s1++, s2++;
  800c0c:	ff 45 fc             	incl   -0x4(%ebp)
  800c0f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c12:	8b 45 10             	mov    0x10(%ebp),%eax
  800c15:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c18:	89 55 10             	mov    %edx,0x10(%ebp)
  800c1b:	85 c0                	test   %eax,%eax
  800c1d:	75 c9                	jne    800be8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c24:	c9                   	leave  
  800c25:	c3                   	ret    

00800c26 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c2c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c32:	01 d0                	add    %edx,%eax
  800c34:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c37:	eb 15                	jmp    800c4e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	8a 00                	mov    (%eax),%al
  800c3e:	0f b6 d0             	movzbl %al,%edx
  800c41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c44:	0f b6 c0             	movzbl %al,%eax
  800c47:	39 c2                	cmp    %eax,%edx
  800c49:	74 0d                	je     800c58 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c4b:	ff 45 08             	incl   0x8(%ebp)
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c54:	72 e3                	jb     800c39 <memfind+0x13>
  800c56:	eb 01                	jmp    800c59 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c58:	90                   	nop
	return (void *) s;
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c5c:	c9                   	leave  
  800c5d:	c3                   	ret    

00800c5e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c5e:	55                   	push   %ebp
  800c5f:	89 e5                	mov    %esp,%ebp
  800c61:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c6b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c72:	eb 03                	jmp    800c77 <strtol+0x19>
		s++;
  800c74:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	8a 00                	mov    (%eax),%al
  800c7c:	3c 20                	cmp    $0x20,%al
  800c7e:	74 f4                	je     800c74 <strtol+0x16>
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8a 00                	mov    (%eax),%al
  800c85:	3c 09                	cmp    $0x9,%al
  800c87:	74 eb                	je     800c74 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	8a 00                	mov    (%eax),%al
  800c8e:	3c 2b                	cmp    $0x2b,%al
  800c90:	75 05                	jne    800c97 <strtol+0x39>
		s++;
  800c92:	ff 45 08             	incl   0x8(%ebp)
  800c95:	eb 13                	jmp    800caa <strtol+0x4c>
	else if (*s == '-')
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8a 00                	mov    (%eax),%al
  800c9c:	3c 2d                	cmp    $0x2d,%al
  800c9e:	75 0a                	jne    800caa <strtol+0x4c>
		s++, neg = 1;
  800ca0:	ff 45 08             	incl   0x8(%ebp)
  800ca3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800caa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cae:	74 06                	je     800cb6 <strtol+0x58>
  800cb0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cb4:	75 20                	jne    800cd6 <strtol+0x78>
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	3c 30                	cmp    $0x30,%al
  800cbd:	75 17                	jne    800cd6 <strtol+0x78>
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	40                   	inc    %eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	3c 78                	cmp    $0x78,%al
  800cc7:	75 0d                	jne    800cd6 <strtol+0x78>
		s += 2, base = 16;
  800cc9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ccd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cd4:	eb 28                	jmp    800cfe <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cda:	75 15                	jne    800cf1 <strtol+0x93>
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	3c 30                	cmp    $0x30,%al
  800ce3:	75 0c                	jne    800cf1 <strtol+0x93>
		s++, base = 8;
  800ce5:	ff 45 08             	incl   0x8(%ebp)
  800ce8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cef:	eb 0d                	jmp    800cfe <strtol+0xa0>
	else if (base == 0)
  800cf1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf5:	75 07                	jne    800cfe <strtol+0xa0>
		base = 10;
  800cf7:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	3c 2f                	cmp    $0x2f,%al
  800d05:	7e 19                	jle    800d20 <strtol+0xc2>
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3c 39                	cmp    $0x39,%al
  800d0e:	7f 10                	jg     800d20 <strtol+0xc2>
			dig = *s - '0';
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	0f be c0             	movsbl %al,%eax
  800d18:	83 e8 30             	sub    $0x30,%eax
  800d1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d1e:	eb 42                	jmp    800d62 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	3c 60                	cmp    $0x60,%al
  800d27:	7e 19                	jle    800d42 <strtol+0xe4>
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	3c 7a                	cmp    $0x7a,%al
  800d30:	7f 10                	jg     800d42 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	0f be c0             	movsbl %al,%eax
  800d3a:	83 e8 57             	sub    $0x57,%eax
  800d3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d40:	eb 20                	jmp    800d62 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8a 00                	mov    (%eax),%al
  800d47:	3c 40                	cmp    $0x40,%al
  800d49:	7e 39                	jle    800d84 <strtol+0x126>
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	8a 00                	mov    (%eax),%al
  800d50:	3c 5a                	cmp    $0x5a,%al
  800d52:	7f 30                	jg     800d84 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	0f be c0             	movsbl %al,%eax
  800d5c:	83 e8 37             	sub    $0x37,%eax
  800d5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d65:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d68:	7d 19                	jge    800d83 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d6a:	ff 45 08             	incl   0x8(%ebp)
  800d6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d70:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d74:	89 c2                	mov    %eax,%edx
  800d76:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d79:	01 d0                	add    %edx,%eax
  800d7b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d7e:	e9 7b ff ff ff       	jmp    800cfe <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d83:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d84:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d88:	74 08                	je     800d92 <strtol+0x134>
		*endptr = (char *) s;
  800d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8d:	8b 55 08             	mov    0x8(%ebp),%edx
  800d90:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d92:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d96:	74 07                	je     800d9f <strtol+0x141>
  800d98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9b:	f7 d8                	neg    %eax
  800d9d:	eb 03                	jmp    800da2 <strtol+0x144>
  800d9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800da2:	c9                   	leave  
  800da3:	c3                   	ret    

00800da4 <ltostr>:

void
ltostr(long value, char *str)
{
  800da4:	55                   	push   %ebp
  800da5:	89 e5                	mov    %esp,%ebp
  800da7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800daa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800db1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800db8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dbc:	79 13                	jns    800dd1 <ltostr+0x2d>
	{
		neg = 1;
  800dbe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dcb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dce:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dd9:	99                   	cltd   
  800dda:	f7 f9                	idiv   %ecx
  800ddc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ddf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de2:	8d 50 01             	lea    0x1(%eax),%edx
  800de5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de8:	89 c2                	mov    %eax,%edx
  800dea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ded:	01 d0                	add    %edx,%eax
  800def:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800df2:	83 c2 30             	add    $0x30,%edx
  800df5:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800df7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dfa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dff:	f7 e9                	imul   %ecx
  800e01:	c1 fa 02             	sar    $0x2,%edx
  800e04:	89 c8                	mov    %ecx,%eax
  800e06:	c1 f8 1f             	sar    $0x1f,%eax
  800e09:	29 c2                	sub    %eax,%edx
  800e0b:	89 d0                	mov    %edx,%eax
  800e0d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e10:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e13:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e18:	f7 e9                	imul   %ecx
  800e1a:	c1 fa 02             	sar    $0x2,%edx
  800e1d:	89 c8                	mov    %ecx,%eax
  800e1f:	c1 f8 1f             	sar    $0x1f,%eax
  800e22:	29 c2                	sub    %eax,%edx
  800e24:	89 d0                	mov    %edx,%eax
  800e26:	c1 e0 02             	shl    $0x2,%eax
  800e29:	01 d0                	add    %edx,%eax
  800e2b:	01 c0                	add    %eax,%eax
  800e2d:	29 c1                	sub    %eax,%ecx
  800e2f:	89 ca                	mov    %ecx,%edx
  800e31:	85 d2                	test   %edx,%edx
  800e33:	75 9c                	jne    800dd1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e35:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3f:	48                   	dec    %eax
  800e40:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e43:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e47:	74 3d                	je     800e86 <ltostr+0xe2>
		start = 1 ;
  800e49:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e50:	eb 34                	jmp    800e86 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e52:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e58:	01 d0                	add    %edx,%eax
  800e5a:	8a 00                	mov    (%eax),%al
  800e5c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e65:	01 c2                	add    %eax,%edx
  800e67:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6d:	01 c8                	add    %ecx,%eax
  800e6f:	8a 00                	mov    (%eax),%al
  800e71:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e73:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e79:	01 c2                	add    %eax,%edx
  800e7b:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e7e:	88 02                	mov    %al,(%edx)
		start++ ;
  800e80:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e83:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e89:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e8c:	7c c4                	jl     800e52 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e8e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e94:	01 d0                	add    %edx,%eax
  800e96:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e99:	90                   	nop
  800e9a:	c9                   	leave  
  800e9b:	c3                   	ret    

00800e9c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e9c:	55                   	push   %ebp
  800e9d:	89 e5                	mov    %esp,%ebp
  800e9f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ea2:	ff 75 08             	pushl  0x8(%ebp)
  800ea5:	e8 54 fa ff ff       	call   8008fe <strlen>
  800eaa:	83 c4 04             	add    $0x4,%esp
  800ead:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	e8 46 fa ff ff       	call   8008fe <strlen>
  800eb8:	83 c4 04             	add    $0x4,%esp
  800ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ebe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ec5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ecc:	eb 17                	jmp    800ee5 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ece:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed4:	01 c2                	add    %eax,%edx
  800ed6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	01 c8                	add    %ecx,%eax
  800ede:	8a 00                	mov    (%eax),%al
  800ee0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ee2:	ff 45 fc             	incl   -0x4(%ebp)
  800ee5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eeb:	7c e1                	jl     800ece <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800eed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ef4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800efb:	eb 1f                	jmp    800f1c <strcconcat+0x80>
		final[s++] = str2[i] ;
  800efd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f00:	8d 50 01             	lea    0x1(%eax),%edx
  800f03:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f06:	89 c2                	mov    %eax,%edx
  800f08:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0b:	01 c2                	add    %eax,%edx
  800f0d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f13:	01 c8                	add    %ecx,%eax
  800f15:	8a 00                	mov    (%eax),%al
  800f17:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f19:	ff 45 f8             	incl   -0x8(%ebp)
  800f1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f1f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f22:	7c d9                	jl     800efd <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f24:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f27:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2a:	01 d0                	add    %edx,%eax
  800f2c:	c6 00 00             	movb   $0x0,(%eax)
}
  800f2f:	90                   	nop
  800f30:	c9                   	leave  
  800f31:	c3                   	ret    

00800f32 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f32:	55                   	push   %ebp
  800f33:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f35:	8b 45 14             	mov    0x14(%ebp),%eax
  800f38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f3e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f41:	8b 00                	mov    (%eax),%eax
  800f43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4d:	01 d0                	add    %edx,%eax
  800f4f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f55:	eb 0c                	jmp    800f63 <strsplit+0x31>
			*string++ = 0;
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	8d 50 01             	lea    0x1(%eax),%edx
  800f5d:	89 55 08             	mov    %edx,0x8(%ebp)
  800f60:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	84 c0                	test   %al,%al
  800f6a:	74 18                	je     800f84 <strsplit+0x52>
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	0f be c0             	movsbl %al,%eax
  800f74:	50                   	push   %eax
  800f75:	ff 75 0c             	pushl  0xc(%ebp)
  800f78:	e8 13 fb ff ff       	call   800a90 <strchr>
  800f7d:	83 c4 08             	add    $0x8,%esp
  800f80:	85 c0                	test   %eax,%eax
  800f82:	75 d3                	jne    800f57 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	84 c0                	test   %al,%al
  800f8b:	74 5a                	je     800fe7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f90:	8b 00                	mov    (%eax),%eax
  800f92:	83 f8 0f             	cmp    $0xf,%eax
  800f95:	75 07                	jne    800f9e <strsplit+0x6c>
		{
			return 0;
  800f97:	b8 00 00 00 00       	mov    $0x0,%eax
  800f9c:	eb 66                	jmp    801004 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa1:	8b 00                	mov    (%eax),%eax
  800fa3:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa6:	8b 55 14             	mov    0x14(%ebp),%edx
  800fa9:	89 0a                	mov    %ecx,(%edx)
  800fab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb5:	01 c2                	add    %eax,%edx
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fbc:	eb 03                	jmp    800fc1 <strsplit+0x8f>
			string++;
  800fbe:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	84 c0                	test   %al,%al
  800fc8:	74 8b                	je     800f55 <strsplit+0x23>
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	8a 00                	mov    (%eax),%al
  800fcf:	0f be c0             	movsbl %al,%eax
  800fd2:	50                   	push   %eax
  800fd3:	ff 75 0c             	pushl  0xc(%ebp)
  800fd6:	e8 b5 fa ff ff       	call   800a90 <strchr>
  800fdb:	83 c4 08             	add    $0x8,%esp
  800fde:	85 c0                	test   %eax,%eax
  800fe0:	74 dc                	je     800fbe <strsplit+0x8c>
			string++;
	}
  800fe2:	e9 6e ff ff ff       	jmp    800f55 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fe7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fe8:	8b 45 14             	mov    0x14(%ebp),%eax
  800feb:	8b 00                	mov    (%eax),%eax
  800fed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff7:	01 d0                	add    %edx,%eax
  800ff9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fff:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801004:	c9                   	leave  
  801005:	c3                   	ret    

00801006 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801006:	55                   	push   %ebp
  801007:	89 e5                	mov    %esp,%ebp
  801009:	83 ec 18             	sub    $0x18,%esp
  80100c:	8b 45 10             	mov    0x10(%ebp),%eax
  80100f:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801012:	83 ec 04             	sub    $0x4,%esp
  801015:	68 30 22 80 00       	push   $0x802230
  80101a:	6a 17                	push   $0x17
  80101c:	68 4f 22 80 00       	push   $0x80224f
  801021:	e8 3e 09 00 00       	call   801964 <_panic>

00801026 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801026:	55                   	push   %ebp
  801027:	89 e5                	mov    %esp,%ebp
  801029:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80102c:	83 ec 04             	sub    $0x4,%esp
  80102f:	68 5b 22 80 00       	push   $0x80225b
  801034:	6a 2f                	push   $0x2f
  801036:	68 4f 22 80 00       	push   $0x80224f
  80103b:	e8 24 09 00 00       	call   801964 <_panic>

00801040 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801040:	55                   	push   %ebp
  801041:	89 e5                	mov    %esp,%ebp
  801043:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801046:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  80104d:	8b 55 08             	mov    0x8(%ebp),%edx
  801050:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801053:	01 d0                	add    %edx,%eax
  801055:	48                   	dec    %eax
  801056:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801059:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80105c:	ba 00 00 00 00       	mov    $0x0,%edx
  801061:	f7 75 ec             	divl   -0x14(%ebp)
  801064:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801067:	29 d0                	sub    %edx,%eax
  801069:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	c1 e8 0c             	shr    $0xc,%eax
  801072:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801075:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80107c:	e9 c8 00 00 00       	jmp    801149 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801081:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801088:	eb 27                	jmp    8010b1 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80108a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80108d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801090:	01 c2                	add    %eax,%edx
  801092:	89 d0                	mov    %edx,%eax
  801094:	01 c0                	add    %eax,%eax
  801096:	01 d0                	add    %edx,%eax
  801098:	c1 e0 02             	shl    $0x2,%eax
  80109b:	05 88 30 c0 06       	add    $0x6c03088,%eax
  8010a0:	8b 00                	mov    (%eax),%eax
  8010a2:	85 c0                	test   %eax,%eax
  8010a4:	74 08                	je     8010ae <malloc+0x6e>
            	i += j;
  8010a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010a9:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8010ac:	eb 0b                	jmp    8010b9 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8010ae:	ff 45 f0             	incl   -0x10(%ebp)
  8010b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010b4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8010b7:	72 d1                	jb     80108a <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8010b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010bc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8010bf:	0f 85 81 00 00 00    	jne    801146 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8010c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c8:	05 00 00 08 00       	add    $0x80000,%eax
  8010cd:	c1 e0 0c             	shl    $0xc,%eax
  8010d0:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8010d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8010da:	eb 1f                	jmp    8010fb <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8010dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e2:	01 c2                	add    %eax,%edx
  8010e4:	89 d0                	mov    %edx,%eax
  8010e6:	01 c0                	add    %eax,%eax
  8010e8:	01 d0                	add    %edx,%eax
  8010ea:	c1 e0 02             	shl    $0x2,%eax
  8010ed:	05 88 30 c0 06       	add    $0x6c03088,%eax
  8010f2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8010f8:	ff 45 f0             	incl   -0x10(%ebp)
  8010fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010fe:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801101:	72 d9                	jb     8010dc <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801103:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801106:	89 d0                	mov    %edx,%eax
  801108:	01 c0                	add    %eax,%eax
  80110a:	01 d0                	add    %edx,%eax
  80110c:	c1 e0 02             	shl    $0x2,%eax
  80110f:	8d 90 80 30 c0 06    	lea    0x6c03080(%eax),%edx
  801115:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801118:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80111a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80111d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801120:	89 c8                	mov    %ecx,%eax
  801122:	01 c0                	add    %eax,%eax
  801124:	01 c8                	add    %ecx,%eax
  801126:	c1 e0 02             	shl    $0x2,%eax
  801129:	05 84 30 c0 06       	add    $0x6c03084,%eax
  80112e:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801130:	83 ec 08             	sub    $0x8,%esp
  801133:	ff 75 08             	pushl  0x8(%ebp)
  801136:	ff 75 e0             	pushl  -0x20(%ebp)
  801139:	e8 2b 03 00 00       	call   801469 <sys_allocateMem>
  80113e:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801141:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801144:	eb 19                	jmp    80115f <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801146:	ff 45 f4             	incl   -0xc(%ebp)
  801149:	a1 04 30 80 00       	mov    0x803004,%eax
  80114e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801151:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801154:	0f 83 27 ff ff ff    	jae    801081 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  80115a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
  801164:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801167:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80116b:	0f 84 e5 00 00 00    	je     801256 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801177:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80117a:	05 00 00 00 80       	add    $0x80000000,%eax
  80117f:	c1 e8 0c             	shr    $0xc,%eax
  801182:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801185:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801188:	89 d0                	mov    %edx,%eax
  80118a:	01 c0                	add    %eax,%eax
  80118c:	01 d0                	add    %edx,%eax
  80118e:	c1 e0 02             	shl    $0x2,%eax
  801191:	05 80 30 c0 06       	add    $0x6c03080,%eax
  801196:	8b 00                	mov    (%eax),%eax
  801198:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80119b:	0f 85 b8 00 00 00    	jne    801259 <free+0xf8>
  8011a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011a4:	89 d0                	mov    %edx,%eax
  8011a6:	01 c0                	add    %eax,%eax
  8011a8:	01 d0                	add    %edx,%eax
  8011aa:	c1 e0 02             	shl    $0x2,%eax
  8011ad:	05 88 30 c0 06       	add    $0x6c03088,%eax
  8011b2:	8b 00                	mov    (%eax),%eax
  8011b4:	85 c0                	test   %eax,%eax
  8011b6:	0f 84 9d 00 00 00    	je     801259 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8011bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011bf:	89 d0                	mov    %edx,%eax
  8011c1:	01 c0                	add    %eax,%eax
  8011c3:	01 d0                	add    %edx,%eax
  8011c5:	c1 e0 02             	shl    $0x2,%eax
  8011c8:	05 84 30 c0 06       	add    $0x6c03084,%eax
  8011cd:	8b 00                	mov    (%eax),%eax
  8011cf:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8011d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8011d5:	c1 e0 0c             	shl    $0xc,%eax
  8011d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8011db:	83 ec 08             	sub    $0x8,%esp
  8011de:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011e1:	ff 75 f0             	pushl  -0x10(%ebp)
  8011e4:	e8 64 02 00 00       	call   80144d <sys_freeMem>
  8011e9:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8011ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8011f3:	eb 57                	jmp    80124c <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8011f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011fb:	01 c2                	add    %eax,%edx
  8011fd:	89 d0                	mov    %edx,%eax
  8011ff:	01 c0                	add    %eax,%eax
  801201:	01 d0                	add    %edx,%eax
  801203:	c1 e0 02             	shl    $0x2,%eax
  801206:	05 88 30 c0 06       	add    $0x6c03088,%eax
  80120b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801211:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801214:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801217:	01 c2                	add    %eax,%edx
  801219:	89 d0                	mov    %edx,%eax
  80121b:	01 c0                	add    %eax,%eax
  80121d:	01 d0                	add    %edx,%eax
  80121f:	c1 e0 02             	shl    $0x2,%eax
  801222:	05 80 30 c0 06       	add    $0x6c03080,%eax
  801227:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  80122d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801230:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801233:	01 c2                	add    %eax,%edx
  801235:	89 d0                	mov    %edx,%eax
  801237:	01 c0                	add    %eax,%eax
  801239:	01 d0                	add    %edx,%eax
  80123b:	c1 e0 02             	shl    $0x2,%eax
  80123e:	05 84 30 c0 06       	add    $0x6c03084,%eax
  801243:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801249:	ff 45 f4             	incl   -0xc(%ebp)
  80124c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80124f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801252:	7c a1                	jl     8011f5 <free+0x94>
  801254:	eb 04                	jmp    80125a <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801256:	90                   	nop
  801257:	eb 01                	jmp    80125a <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801259:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
  80125f:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801262:	83 ec 04             	sub    $0x4,%esp
  801265:	68 78 22 80 00       	push   $0x802278
  80126a:	68 ae 00 00 00       	push   $0xae
  80126f:	68 4f 22 80 00       	push   $0x80224f
  801274:	e8 eb 06 00 00       	call   801964 <_panic>

00801279 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
  80127c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80127f:	83 ec 04             	sub    $0x4,%esp
  801282:	68 98 22 80 00       	push   $0x802298
  801287:	68 ca 00 00 00       	push   $0xca
  80128c:	68 4f 22 80 00       	push   $0x80224f
  801291:	e8 ce 06 00 00       	call   801964 <_panic>

00801296 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801296:	55                   	push   %ebp
  801297:	89 e5                	mov    %esp,%ebp
  801299:	57                   	push   %edi
  80129a:	56                   	push   %esi
  80129b:	53                   	push   %ebx
  80129c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80129f:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012a8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012ab:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012ae:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012b1:	cd 30                	int    $0x30
  8012b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b9:	83 c4 10             	add    $0x10,%esp
  8012bc:	5b                   	pop    %ebx
  8012bd:	5e                   	pop    %esi
  8012be:	5f                   	pop    %edi
  8012bf:	5d                   	pop    %ebp
  8012c0:	c3                   	ret    

008012c1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012c1:	55                   	push   %ebp
  8012c2:	89 e5                	mov    %esp,%ebp
  8012c4:	83 ec 04             	sub    $0x4,%esp
  8012c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012cd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	52                   	push   %edx
  8012d9:	ff 75 0c             	pushl  0xc(%ebp)
  8012dc:	50                   	push   %eax
  8012dd:	6a 00                	push   $0x0
  8012df:	e8 b2 ff ff ff       	call   801296 <syscall>
  8012e4:	83 c4 18             	add    $0x18,%esp
}
  8012e7:	90                   	nop
  8012e8:	c9                   	leave  
  8012e9:	c3                   	ret    

008012ea <sys_cgetc>:

int
sys_cgetc(void)
{
  8012ea:	55                   	push   %ebp
  8012eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 01                	push   $0x1
  8012f9:	e8 98 ff ff ff       	call   801296 <syscall>
  8012fe:	83 c4 18             	add    $0x18,%esp
}
  801301:	c9                   	leave  
  801302:	c3                   	ret    

00801303 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801303:	55                   	push   %ebp
  801304:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	50                   	push   %eax
  801312:	6a 05                	push   $0x5
  801314:	e8 7d ff ff ff       	call   801296 <syscall>
  801319:	83 c4 18             	add    $0x18,%esp
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 02                	push   $0x2
  80132d:	e8 64 ff ff ff       	call   801296 <syscall>
  801332:	83 c4 18             	add    $0x18,%esp
}
  801335:	c9                   	leave  
  801336:	c3                   	ret    

00801337 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801337:	55                   	push   %ebp
  801338:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 03                	push   $0x3
  801346:	e8 4b ff ff ff       	call   801296 <syscall>
  80134b:	83 c4 18             	add    $0x18,%esp
}
  80134e:	c9                   	leave  
  80134f:	c3                   	ret    

00801350 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801350:	55                   	push   %ebp
  801351:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801353:	6a 00                	push   $0x0
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 00                	push   $0x0
  80135b:	6a 00                	push   $0x0
  80135d:	6a 04                	push   $0x4
  80135f:	e8 32 ff ff ff       	call   801296 <syscall>
  801364:	83 c4 18             	add    $0x18,%esp
}
  801367:	c9                   	leave  
  801368:	c3                   	ret    

00801369 <sys_env_exit>:


void sys_env_exit(void)
{
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80136c:	6a 00                	push   $0x0
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 06                	push   $0x6
  801378:	e8 19 ff ff ff       	call   801296 <syscall>
  80137d:	83 c4 18             	add    $0x18,%esp
}
  801380:	90                   	nop
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801386:	8b 55 0c             	mov    0xc(%ebp),%edx
  801389:	8b 45 08             	mov    0x8(%ebp),%eax
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	52                   	push   %edx
  801393:	50                   	push   %eax
  801394:	6a 07                	push   $0x7
  801396:	e8 fb fe ff ff       	call   801296 <syscall>
  80139b:	83 c4 18             	add    $0x18,%esp
}
  80139e:	c9                   	leave  
  80139f:	c3                   	ret    

008013a0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013a0:	55                   	push   %ebp
  8013a1:	89 e5                	mov    %esp,%ebp
  8013a3:	56                   	push   %esi
  8013a4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013a5:	8b 75 18             	mov    0x18(%ebp),%esi
  8013a8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	56                   	push   %esi
  8013b5:	53                   	push   %ebx
  8013b6:	51                   	push   %ecx
  8013b7:	52                   	push   %edx
  8013b8:	50                   	push   %eax
  8013b9:	6a 08                	push   $0x8
  8013bb:	e8 d6 fe ff ff       	call   801296 <syscall>
  8013c0:	83 c4 18             	add    $0x18,%esp
}
  8013c3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013c6:	5b                   	pop    %ebx
  8013c7:	5e                   	pop    %esi
  8013c8:	5d                   	pop    %ebp
  8013c9:	c3                   	ret    

008013ca <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	52                   	push   %edx
  8013da:	50                   	push   %eax
  8013db:	6a 09                	push   $0x9
  8013dd:	e8 b4 fe ff ff       	call   801296 <syscall>
  8013e2:	83 c4 18             	add    $0x18,%esp
}
  8013e5:	c9                   	leave  
  8013e6:	c3                   	ret    

008013e7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013e7:	55                   	push   %ebp
  8013e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	ff 75 0c             	pushl  0xc(%ebp)
  8013f3:	ff 75 08             	pushl  0x8(%ebp)
  8013f6:	6a 0a                	push   $0xa
  8013f8:	e8 99 fe ff ff       	call   801296 <syscall>
  8013fd:	83 c4 18             	add    $0x18,%esp
}
  801400:	c9                   	leave  
  801401:	c3                   	ret    

00801402 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801402:	55                   	push   %ebp
  801403:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 0b                	push   $0xb
  801411:	e8 80 fe ff ff       	call   801296 <syscall>
  801416:	83 c4 18             	add    $0x18,%esp
}
  801419:	c9                   	leave  
  80141a:	c3                   	ret    

0080141b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80141b:	55                   	push   %ebp
  80141c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 0c                	push   $0xc
  80142a:	e8 67 fe ff ff       	call   801296 <syscall>
  80142f:	83 c4 18             	add    $0x18,%esp
}
  801432:	c9                   	leave  
  801433:	c3                   	ret    

00801434 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801434:	55                   	push   %ebp
  801435:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 0d                	push   $0xd
  801443:	e8 4e fe ff ff       	call   801296 <syscall>
  801448:	83 c4 18             	add    $0x18,%esp
}
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801450:	6a 00                	push   $0x0
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	ff 75 0c             	pushl  0xc(%ebp)
  801459:	ff 75 08             	pushl  0x8(%ebp)
  80145c:	6a 11                	push   $0x11
  80145e:	e8 33 fe ff ff       	call   801296 <syscall>
  801463:	83 c4 18             	add    $0x18,%esp
	return;
  801466:	90                   	nop
}
  801467:	c9                   	leave  
  801468:	c3                   	ret    

00801469 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801469:	55                   	push   %ebp
  80146a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	ff 75 0c             	pushl  0xc(%ebp)
  801475:	ff 75 08             	pushl  0x8(%ebp)
  801478:	6a 12                	push   $0x12
  80147a:	e8 17 fe ff ff       	call   801296 <syscall>
  80147f:	83 c4 18             	add    $0x18,%esp
	return ;
  801482:	90                   	nop
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 0e                	push   $0xe
  801494:	e8 fd fd ff ff       	call   801296 <syscall>
  801499:	83 c4 18             	add    $0x18,%esp
}
  80149c:	c9                   	leave  
  80149d:	c3                   	ret    

0080149e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	ff 75 08             	pushl  0x8(%ebp)
  8014ac:	6a 0f                	push   $0xf
  8014ae:	e8 e3 fd ff ff       	call   801296 <syscall>
  8014b3:	83 c4 18             	add    $0x18,%esp
}
  8014b6:	c9                   	leave  
  8014b7:	c3                   	ret    

008014b8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 10                	push   $0x10
  8014c7:	e8 ca fd ff ff       	call   801296 <syscall>
  8014cc:	83 c4 18             	add    $0x18,%esp
}
  8014cf:	90                   	nop
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 14                	push   $0x14
  8014e1:	e8 b0 fd ff ff       	call   801296 <syscall>
  8014e6:	83 c4 18             	add    $0x18,%esp
}
  8014e9:	90                   	nop
  8014ea:	c9                   	leave  
  8014eb:	c3                   	ret    

008014ec <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014ec:	55                   	push   %ebp
  8014ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 15                	push   $0x15
  8014fb:	e8 96 fd ff ff       	call   801296 <syscall>
  801500:	83 c4 18             	add    $0x18,%esp
}
  801503:	90                   	nop
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <sys_cputc>:


void
sys_cputc(const char c)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
  801509:	83 ec 04             	sub    $0x4,%esp
  80150c:	8b 45 08             	mov    0x8(%ebp),%eax
  80150f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801512:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	50                   	push   %eax
  80151f:	6a 16                	push   $0x16
  801521:	e8 70 fd ff ff       	call   801296 <syscall>
  801526:	83 c4 18             	add    $0x18,%esp
}
  801529:	90                   	nop
  80152a:	c9                   	leave  
  80152b:	c3                   	ret    

0080152c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80152c:	55                   	push   %ebp
  80152d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 17                	push   $0x17
  80153b:	e8 56 fd ff ff       	call   801296 <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	90                   	nop
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801549:	8b 45 08             	mov    0x8(%ebp),%eax
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	ff 75 0c             	pushl  0xc(%ebp)
  801555:	50                   	push   %eax
  801556:	6a 18                	push   $0x18
  801558:	e8 39 fd ff ff       	call   801296 <syscall>
  80155d:	83 c4 18             	add    $0x18,%esp
}
  801560:	c9                   	leave  
  801561:	c3                   	ret    

00801562 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801565:	8b 55 0c             	mov    0xc(%ebp),%edx
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	52                   	push   %edx
  801572:	50                   	push   %eax
  801573:	6a 1b                	push   $0x1b
  801575:	e8 1c fd ff ff       	call   801296 <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801582:	8b 55 0c             	mov    0xc(%ebp),%edx
  801585:	8b 45 08             	mov    0x8(%ebp),%eax
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	52                   	push   %edx
  80158f:	50                   	push   %eax
  801590:	6a 19                	push   $0x19
  801592:	e8 ff fc ff ff       	call   801296 <syscall>
  801597:	83 c4 18             	add    $0x18,%esp
}
  80159a:	90                   	nop
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	52                   	push   %edx
  8015ad:	50                   	push   %eax
  8015ae:	6a 1a                	push   $0x1a
  8015b0:	e8 e1 fc ff ff       	call   801296 <syscall>
  8015b5:	83 c4 18             	add    $0x18,%esp
}
  8015b8:	90                   	nop
  8015b9:	c9                   	leave  
  8015ba:	c3                   	ret    

008015bb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
  8015be:	83 ec 04             	sub    $0x4,%esp
  8015c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015c7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015ca:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d1:	6a 00                	push   $0x0
  8015d3:	51                   	push   %ecx
  8015d4:	52                   	push   %edx
  8015d5:	ff 75 0c             	pushl  0xc(%ebp)
  8015d8:	50                   	push   %eax
  8015d9:	6a 1c                	push   $0x1c
  8015db:	e8 b6 fc ff ff       	call   801296 <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
}
  8015e3:	c9                   	leave  
  8015e4:	c3                   	ret    

008015e5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	52                   	push   %edx
  8015f5:	50                   	push   %eax
  8015f6:	6a 1d                	push   $0x1d
  8015f8:	e8 99 fc ff ff       	call   801296 <syscall>
  8015fd:	83 c4 18             	add    $0x18,%esp
}
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801605:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801608:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	51                   	push   %ecx
  801613:	52                   	push   %edx
  801614:	50                   	push   %eax
  801615:	6a 1e                	push   $0x1e
  801617:	e8 7a fc ff ff       	call   801296 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801624:	8b 55 0c             	mov    0xc(%ebp),%edx
  801627:	8b 45 08             	mov    0x8(%ebp),%eax
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	52                   	push   %edx
  801631:	50                   	push   %eax
  801632:	6a 1f                	push   $0x1f
  801634:	e8 5d fc ff ff       	call   801296 <syscall>
  801639:	83 c4 18             	add    $0x18,%esp
}
  80163c:	c9                   	leave  
  80163d:	c3                   	ret    

0080163e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80163e:	55                   	push   %ebp
  80163f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 20                	push   $0x20
  80164d:	e8 44 fc ff ff       	call   801296 <syscall>
  801652:	83 c4 18             	add    $0x18,%esp
}
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	ff 75 10             	pushl  0x10(%ebp)
  801664:	ff 75 0c             	pushl  0xc(%ebp)
  801667:	50                   	push   %eax
  801668:	6a 21                	push   $0x21
  80166a:	e8 27 fc ff ff       	call   801296 <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	c9                   	leave  
  801673:	c3                   	ret    

00801674 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	50                   	push   %eax
  801683:	6a 22                	push   $0x22
  801685:	e8 0c fc ff ff       	call   801296 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
}
  80168d:	90                   	nop
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	50                   	push   %eax
  80169f:	6a 23                	push   $0x23
  8016a1:	e8 f0 fb ff ff       	call   801296 <syscall>
  8016a6:	83 c4 18             	add    $0x18,%esp
}
  8016a9:	90                   	nop
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
  8016af:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016b2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b5:	8d 50 04             	lea    0x4(%eax),%edx
  8016b8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	52                   	push   %edx
  8016c2:	50                   	push   %eax
  8016c3:	6a 24                	push   $0x24
  8016c5:	e8 cc fb ff ff       	call   801296 <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
	return result;
  8016cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d6:	89 01                	mov    %eax,(%ecx)
  8016d8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	c9                   	leave  
  8016df:	c2 04 00             	ret    $0x4

008016e2 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	ff 75 10             	pushl  0x10(%ebp)
  8016ec:	ff 75 0c             	pushl  0xc(%ebp)
  8016ef:	ff 75 08             	pushl  0x8(%ebp)
  8016f2:	6a 13                	push   $0x13
  8016f4:	e8 9d fb ff ff       	call   801296 <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016fc:	90                   	nop
}
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <sys_rcr2>:
uint32 sys_rcr2()
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 25                	push   $0x25
  80170e:	e8 83 fb ff ff       	call   801296 <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
}
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	83 ec 04             	sub    $0x4,%esp
  80171e:	8b 45 08             	mov    0x8(%ebp),%eax
  801721:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801724:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	50                   	push   %eax
  801731:	6a 26                	push   $0x26
  801733:	e8 5e fb ff ff       	call   801296 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
	return ;
  80173b:	90                   	nop
}
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <rsttst>:
void rsttst()
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 28                	push   $0x28
  80174d:	e8 44 fb ff ff       	call   801296 <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
	return ;
  801755:	90                   	nop
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
  80175b:	83 ec 04             	sub    $0x4,%esp
  80175e:	8b 45 14             	mov    0x14(%ebp),%eax
  801761:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801764:	8b 55 18             	mov    0x18(%ebp),%edx
  801767:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80176b:	52                   	push   %edx
  80176c:	50                   	push   %eax
  80176d:	ff 75 10             	pushl  0x10(%ebp)
  801770:	ff 75 0c             	pushl  0xc(%ebp)
  801773:	ff 75 08             	pushl  0x8(%ebp)
  801776:	6a 27                	push   $0x27
  801778:	e8 19 fb ff ff       	call   801296 <syscall>
  80177d:	83 c4 18             	add    $0x18,%esp
	return ;
  801780:	90                   	nop
}
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <chktst>:
void chktst(uint32 n)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	ff 75 08             	pushl  0x8(%ebp)
  801791:	6a 29                	push   $0x29
  801793:	e8 fe fa ff ff       	call   801296 <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
	return ;
  80179b:	90                   	nop
}
  80179c:	c9                   	leave  
  80179d:	c3                   	ret    

0080179e <inctst>:

void inctst()
{
  80179e:	55                   	push   %ebp
  80179f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 2a                	push   $0x2a
  8017ad:	e8 e4 fa ff ff       	call   801296 <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b5:	90                   	nop
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <gettst>:
uint32 gettst()
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 2b                	push   $0x2b
  8017c7:	e8 ca fa ff ff       	call   801296 <syscall>
  8017cc:	83 c4 18             	add    $0x18,%esp
}
  8017cf:	c9                   	leave  
  8017d0:	c3                   	ret    

008017d1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
  8017d4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 2c                	push   $0x2c
  8017e3:	e8 ae fa ff ff       	call   801296 <syscall>
  8017e8:	83 c4 18             	add    $0x18,%esp
  8017eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017ee:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017f2:	75 07                	jne    8017fb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017f4:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f9:	eb 05                	jmp    801800 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
  801805:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 2c                	push   $0x2c
  801814:	e8 7d fa ff ff       	call   801296 <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
  80181c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80181f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801823:	75 07                	jne    80182c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801825:	b8 01 00 00 00       	mov    $0x1,%eax
  80182a:	eb 05                	jmp    801831 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80182c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
  801836:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 2c                	push   $0x2c
  801845:	e8 4c fa ff ff       	call   801296 <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
  80184d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801850:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801854:	75 07                	jne    80185d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801856:	b8 01 00 00 00       	mov    $0x1,%eax
  80185b:	eb 05                	jmp    801862 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80185d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 2c                	push   $0x2c
  801876:	e8 1b fa ff ff       	call   801296 <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
  80187e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801881:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801885:	75 07                	jne    80188e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801887:	b8 01 00 00 00       	mov    $0x1,%eax
  80188c:	eb 05                	jmp    801893 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80188e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	ff 75 08             	pushl  0x8(%ebp)
  8018a3:	6a 2d                	push   $0x2d
  8018a5:	e8 ec f9 ff ff       	call   801296 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ad:	90                   	nop
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018b6:	8b 55 08             	mov    0x8(%ebp),%edx
  8018b9:	89 d0                	mov    %edx,%eax
  8018bb:	c1 e0 02             	shl    $0x2,%eax
  8018be:	01 d0                	add    %edx,%eax
  8018c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c7:	01 d0                	add    %edx,%eax
  8018c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d0:	01 d0                	add    %edx,%eax
  8018d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d9:	01 d0                	add    %edx,%eax
  8018db:	c1 e0 04             	shl    $0x4,%eax
  8018de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018e8:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018eb:	83 ec 0c             	sub    $0xc,%esp
  8018ee:	50                   	push   %eax
  8018ef:	e8 b8 fd ff ff       	call   8016ac <sys_get_virtual_time>
  8018f4:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018f7:	eb 41                	jmp    80193a <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018f9:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018fc:	83 ec 0c             	sub    $0xc,%esp
  8018ff:	50                   	push   %eax
  801900:	e8 a7 fd ff ff       	call   8016ac <sys_get_virtual_time>
  801905:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801908:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80190b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80190e:	29 c2                	sub    %eax,%edx
  801910:	89 d0                	mov    %edx,%eax
  801912:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801915:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801918:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80191b:	89 d1                	mov    %edx,%ecx
  80191d:	29 c1                	sub    %eax,%ecx
  80191f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801922:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801925:	39 c2                	cmp    %eax,%edx
  801927:	0f 97 c0             	seta   %al
  80192a:	0f b6 c0             	movzbl %al,%eax
  80192d:	29 c1                	sub    %eax,%ecx
  80192f:	89 c8                	mov    %ecx,%eax
  801931:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801934:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801937:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80193a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80193d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801940:	72 b7                	jb     8018f9 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801942:	90                   	nop
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
  801948:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80194b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801952:	eb 03                	jmp    801957 <busy_wait+0x12>
  801954:	ff 45 fc             	incl   -0x4(%ebp)
  801957:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80195a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80195d:	72 f5                	jb     801954 <busy_wait+0xf>
	return i;
  80195f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
  801967:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80196a:	8d 45 10             	lea    0x10(%ebp),%eax
  80196d:	83 c0 04             	add    $0x4,%eax
  801970:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801973:	a1 80 30 d8 06       	mov    0x6d83080,%eax
  801978:	85 c0                	test   %eax,%eax
  80197a:	74 16                	je     801992 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80197c:	a1 80 30 d8 06       	mov    0x6d83080,%eax
  801981:	83 ec 08             	sub    $0x8,%esp
  801984:	50                   	push   %eax
  801985:	68 bc 22 80 00       	push   $0x8022bc
  80198a:	e8 ed e8 ff ff       	call   80027c <cprintf>
  80198f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801992:	a1 00 30 80 00       	mov    0x803000,%eax
  801997:	ff 75 0c             	pushl  0xc(%ebp)
  80199a:	ff 75 08             	pushl  0x8(%ebp)
  80199d:	50                   	push   %eax
  80199e:	68 c1 22 80 00       	push   $0x8022c1
  8019a3:	e8 d4 e8 ff ff       	call   80027c <cprintf>
  8019a8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8019ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ae:	83 ec 08             	sub    $0x8,%esp
  8019b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8019b4:	50                   	push   %eax
  8019b5:	e8 57 e8 ff ff       	call   800211 <vcprintf>
  8019ba:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8019bd:	83 ec 08             	sub    $0x8,%esp
  8019c0:	6a 00                	push   $0x0
  8019c2:	68 dd 22 80 00       	push   $0x8022dd
  8019c7:	e8 45 e8 ff ff       	call   800211 <vcprintf>
  8019cc:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8019cf:	e8 c6 e7 ff ff       	call   80019a <exit>

	// should not return here
	while (1) ;
  8019d4:	eb fe                	jmp    8019d4 <_panic+0x70>

008019d6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
  8019d9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8019dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8019e1:	8b 50 74             	mov    0x74(%eax),%edx
  8019e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e7:	39 c2                	cmp    %eax,%edx
  8019e9:	74 14                	je     8019ff <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8019eb:	83 ec 04             	sub    $0x4,%esp
  8019ee:	68 e0 22 80 00       	push   $0x8022e0
  8019f3:	6a 26                	push   $0x26
  8019f5:	68 2c 23 80 00       	push   $0x80232c
  8019fa:	e8 65 ff ff ff       	call   801964 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8019ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801a06:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a0d:	e9 c2 00 00 00       	jmp    801ad4 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801a12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a15:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1f:	01 d0                	add    %edx,%eax
  801a21:	8b 00                	mov    (%eax),%eax
  801a23:	85 c0                	test   %eax,%eax
  801a25:	75 08                	jne    801a2f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a27:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a2a:	e9 a2 00 00 00       	jmp    801ad1 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801a2f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a36:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801a3d:	eb 69                	jmp    801aa8 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801a3f:	a1 20 30 80 00       	mov    0x803020,%eax
  801a44:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a4a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a4d:	89 d0                	mov    %edx,%eax
  801a4f:	01 c0                	add    %eax,%eax
  801a51:	01 d0                	add    %edx,%eax
  801a53:	c1 e0 02             	shl    $0x2,%eax
  801a56:	01 c8                	add    %ecx,%eax
  801a58:	8a 40 04             	mov    0x4(%eax),%al
  801a5b:	84 c0                	test   %al,%al
  801a5d:	75 46                	jne    801aa5 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a5f:	a1 20 30 80 00       	mov    0x803020,%eax
  801a64:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a6a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a6d:	89 d0                	mov    %edx,%eax
  801a6f:	01 c0                	add    %eax,%eax
  801a71:	01 d0                	add    %edx,%eax
  801a73:	c1 e0 02             	shl    $0x2,%eax
  801a76:	01 c8                	add    %ecx,%eax
  801a78:	8b 00                	mov    (%eax),%eax
  801a7a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a7d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a80:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801a85:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a8a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801a91:	8b 45 08             	mov    0x8(%ebp),%eax
  801a94:	01 c8                	add    %ecx,%eax
  801a96:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a98:	39 c2                	cmp    %eax,%edx
  801a9a:	75 09                	jne    801aa5 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801a9c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801aa3:	eb 12                	jmp    801ab7 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801aa5:	ff 45 e8             	incl   -0x18(%ebp)
  801aa8:	a1 20 30 80 00       	mov    0x803020,%eax
  801aad:	8b 50 74             	mov    0x74(%eax),%edx
  801ab0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ab3:	39 c2                	cmp    %eax,%edx
  801ab5:	77 88                	ja     801a3f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801ab7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801abb:	75 14                	jne    801ad1 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801abd:	83 ec 04             	sub    $0x4,%esp
  801ac0:	68 38 23 80 00       	push   $0x802338
  801ac5:	6a 3a                	push   $0x3a
  801ac7:	68 2c 23 80 00       	push   $0x80232c
  801acc:	e8 93 fe ff ff       	call   801964 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801ad1:	ff 45 f0             	incl   -0x10(%ebp)
  801ad4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ad7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ada:	0f 8c 32 ff ff ff    	jl     801a12 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801ae0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ae7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801aee:	eb 26                	jmp    801b16 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801af0:	a1 20 30 80 00       	mov    0x803020,%eax
  801af5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801afb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801afe:	89 d0                	mov    %edx,%eax
  801b00:	01 c0                	add    %eax,%eax
  801b02:	01 d0                	add    %edx,%eax
  801b04:	c1 e0 02             	shl    $0x2,%eax
  801b07:	01 c8                	add    %ecx,%eax
  801b09:	8a 40 04             	mov    0x4(%eax),%al
  801b0c:	3c 01                	cmp    $0x1,%al
  801b0e:	75 03                	jne    801b13 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801b10:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b13:	ff 45 e0             	incl   -0x20(%ebp)
  801b16:	a1 20 30 80 00       	mov    0x803020,%eax
  801b1b:	8b 50 74             	mov    0x74(%eax),%edx
  801b1e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b21:	39 c2                	cmp    %eax,%edx
  801b23:	77 cb                	ja     801af0 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b28:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b2b:	74 14                	je     801b41 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801b2d:	83 ec 04             	sub    $0x4,%esp
  801b30:	68 8c 23 80 00       	push   $0x80238c
  801b35:	6a 44                	push   $0x44
  801b37:	68 2c 23 80 00       	push   $0x80232c
  801b3c:	e8 23 fe ff ff       	call   801964 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b41:	90                   	nop
  801b42:	c9                   	leave  
  801b43:	c3                   	ret    

00801b44 <__udivdi3>:
  801b44:	55                   	push   %ebp
  801b45:	57                   	push   %edi
  801b46:	56                   	push   %esi
  801b47:	53                   	push   %ebx
  801b48:	83 ec 1c             	sub    $0x1c,%esp
  801b4b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b4f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b57:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b5b:	89 ca                	mov    %ecx,%edx
  801b5d:	89 f8                	mov    %edi,%eax
  801b5f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b63:	85 f6                	test   %esi,%esi
  801b65:	75 2d                	jne    801b94 <__udivdi3+0x50>
  801b67:	39 cf                	cmp    %ecx,%edi
  801b69:	77 65                	ja     801bd0 <__udivdi3+0x8c>
  801b6b:	89 fd                	mov    %edi,%ebp
  801b6d:	85 ff                	test   %edi,%edi
  801b6f:	75 0b                	jne    801b7c <__udivdi3+0x38>
  801b71:	b8 01 00 00 00       	mov    $0x1,%eax
  801b76:	31 d2                	xor    %edx,%edx
  801b78:	f7 f7                	div    %edi
  801b7a:	89 c5                	mov    %eax,%ebp
  801b7c:	31 d2                	xor    %edx,%edx
  801b7e:	89 c8                	mov    %ecx,%eax
  801b80:	f7 f5                	div    %ebp
  801b82:	89 c1                	mov    %eax,%ecx
  801b84:	89 d8                	mov    %ebx,%eax
  801b86:	f7 f5                	div    %ebp
  801b88:	89 cf                	mov    %ecx,%edi
  801b8a:	89 fa                	mov    %edi,%edx
  801b8c:	83 c4 1c             	add    $0x1c,%esp
  801b8f:	5b                   	pop    %ebx
  801b90:	5e                   	pop    %esi
  801b91:	5f                   	pop    %edi
  801b92:	5d                   	pop    %ebp
  801b93:	c3                   	ret    
  801b94:	39 ce                	cmp    %ecx,%esi
  801b96:	77 28                	ja     801bc0 <__udivdi3+0x7c>
  801b98:	0f bd fe             	bsr    %esi,%edi
  801b9b:	83 f7 1f             	xor    $0x1f,%edi
  801b9e:	75 40                	jne    801be0 <__udivdi3+0x9c>
  801ba0:	39 ce                	cmp    %ecx,%esi
  801ba2:	72 0a                	jb     801bae <__udivdi3+0x6a>
  801ba4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ba8:	0f 87 9e 00 00 00    	ja     801c4c <__udivdi3+0x108>
  801bae:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb3:	89 fa                	mov    %edi,%edx
  801bb5:	83 c4 1c             	add    $0x1c,%esp
  801bb8:	5b                   	pop    %ebx
  801bb9:	5e                   	pop    %esi
  801bba:	5f                   	pop    %edi
  801bbb:	5d                   	pop    %ebp
  801bbc:	c3                   	ret    
  801bbd:	8d 76 00             	lea    0x0(%esi),%esi
  801bc0:	31 ff                	xor    %edi,%edi
  801bc2:	31 c0                	xor    %eax,%eax
  801bc4:	89 fa                	mov    %edi,%edx
  801bc6:	83 c4 1c             	add    $0x1c,%esp
  801bc9:	5b                   	pop    %ebx
  801bca:	5e                   	pop    %esi
  801bcb:	5f                   	pop    %edi
  801bcc:	5d                   	pop    %ebp
  801bcd:	c3                   	ret    
  801bce:	66 90                	xchg   %ax,%ax
  801bd0:	89 d8                	mov    %ebx,%eax
  801bd2:	f7 f7                	div    %edi
  801bd4:	31 ff                	xor    %edi,%edi
  801bd6:	89 fa                	mov    %edi,%edx
  801bd8:	83 c4 1c             	add    $0x1c,%esp
  801bdb:	5b                   	pop    %ebx
  801bdc:	5e                   	pop    %esi
  801bdd:	5f                   	pop    %edi
  801bde:	5d                   	pop    %ebp
  801bdf:	c3                   	ret    
  801be0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801be5:	89 eb                	mov    %ebp,%ebx
  801be7:	29 fb                	sub    %edi,%ebx
  801be9:	89 f9                	mov    %edi,%ecx
  801beb:	d3 e6                	shl    %cl,%esi
  801bed:	89 c5                	mov    %eax,%ebp
  801bef:	88 d9                	mov    %bl,%cl
  801bf1:	d3 ed                	shr    %cl,%ebp
  801bf3:	89 e9                	mov    %ebp,%ecx
  801bf5:	09 f1                	or     %esi,%ecx
  801bf7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bfb:	89 f9                	mov    %edi,%ecx
  801bfd:	d3 e0                	shl    %cl,%eax
  801bff:	89 c5                	mov    %eax,%ebp
  801c01:	89 d6                	mov    %edx,%esi
  801c03:	88 d9                	mov    %bl,%cl
  801c05:	d3 ee                	shr    %cl,%esi
  801c07:	89 f9                	mov    %edi,%ecx
  801c09:	d3 e2                	shl    %cl,%edx
  801c0b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c0f:	88 d9                	mov    %bl,%cl
  801c11:	d3 e8                	shr    %cl,%eax
  801c13:	09 c2                	or     %eax,%edx
  801c15:	89 d0                	mov    %edx,%eax
  801c17:	89 f2                	mov    %esi,%edx
  801c19:	f7 74 24 0c          	divl   0xc(%esp)
  801c1d:	89 d6                	mov    %edx,%esi
  801c1f:	89 c3                	mov    %eax,%ebx
  801c21:	f7 e5                	mul    %ebp
  801c23:	39 d6                	cmp    %edx,%esi
  801c25:	72 19                	jb     801c40 <__udivdi3+0xfc>
  801c27:	74 0b                	je     801c34 <__udivdi3+0xf0>
  801c29:	89 d8                	mov    %ebx,%eax
  801c2b:	31 ff                	xor    %edi,%edi
  801c2d:	e9 58 ff ff ff       	jmp    801b8a <__udivdi3+0x46>
  801c32:	66 90                	xchg   %ax,%ax
  801c34:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c38:	89 f9                	mov    %edi,%ecx
  801c3a:	d3 e2                	shl    %cl,%edx
  801c3c:	39 c2                	cmp    %eax,%edx
  801c3e:	73 e9                	jae    801c29 <__udivdi3+0xe5>
  801c40:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c43:	31 ff                	xor    %edi,%edi
  801c45:	e9 40 ff ff ff       	jmp    801b8a <__udivdi3+0x46>
  801c4a:	66 90                	xchg   %ax,%ax
  801c4c:	31 c0                	xor    %eax,%eax
  801c4e:	e9 37 ff ff ff       	jmp    801b8a <__udivdi3+0x46>
  801c53:	90                   	nop

00801c54 <__umoddi3>:
  801c54:	55                   	push   %ebp
  801c55:	57                   	push   %edi
  801c56:	56                   	push   %esi
  801c57:	53                   	push   %ebx
  801c58:	83 ec 1c             	sub    $0x1c,%esp
  801c5b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c5f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c67:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c6b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c6f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c73:	89 f3                	mov    %esi,%ebx
  801c75:	89 fa                	mov    %edi,%edx
  801c77:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c7b:	89 34 24             	mov    %esi,(%esp)
  801c7e:	85 c0                	test   %eax,%eax
  801c80:	75 1a                	jne    801c9c <__umoddi3+0x48>
  801c82:	39 f7                	cmp    %esi,%edi
  801c84:	0f 86 a2 00 00 00    	jbe    801d2c <__umoddi3+0xd8>
  801c8a:	89 c8                	mov    %ecx,%eax
  801c8c:	89 f2                	mov    %esi,%edx
  801c8e:	f7 f7                	div    %edi
  801c90:	89 d0                	mov    %edx,%eax
  801c92:	31 d2                	xor    %edx,%edx
  801c94:	83 c4 1c             	add    $0x1c,%esp
  801c97:	5b                   	pop    %ebx
  801c98:	5e                   	pop    %esi
  801c99:	5f                   	pop    %edi
  801c9a:	5d                   	pop    %ebp
  801c9b:	c3                   	ret    
  801c9c:	39 f0                	cmp    %esi,%eax
  801c9e:	0f 87 ac 00 00 00    	ja     801d50 <__umoddi3+0xfc>
  801ca4:	0f bd e8             	bsr    %eax,%ebp
  801ca7:	83 f5 1f             	xor    $0x1f,%ebp
  801caa:	0f 84 ac 00 00 00    	je     801d5c <__umoddi3+0x108>
  801cb0:	bf 20 00 00 00       	mov    $0x20,%edi
  801cb5:	29 ef                	sub    %ebp,%edi
  801cb7:	89 fe                	mov    %edi,%esi
  801cb9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cbd:	89 e9                	mov    %ebp,%ecx
  801cbf:	d3 e0                	shl    %cl,%eax
  801cc1:	89 d7                	mov    %edx,%edi
  801cc3:	89 f1                	mov    %esi,%ecx
  801cc5:	d3 ef                	shr    %cl,%edi
  801cc7:	09 c7                	or     %eax,%edi
  801cc9:	89 e9                	mov    %ebp,%ecx
  801ccb:	d3 e2                	shl    %cl,%edx
  801ccd:	89 14 24             	mov    %edx,(%esp)
  801cd0:	89 d8                	mov    %ebx,%eax
  801cd2:	d3 e0                	shl    %cl,%eax
  801cd4:	89 c2                	mov    %eax,%edx
  801cd6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cda:	d3 e0                	shl    %cl,%eax
  801cdc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ce0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ce4:	89 f1                	mov    %esi,%ecx
  801ce6:	d3 e8                	shr    %cl,%eax
  801ce8:	09 d0                	or     %edx,%eax
  801cea:	d3 eb                	shr    %cl,%ebx
  801cec:	89 da                	mov    %ebx,%edx
  801cee:	f7 f7                	div    %edi
  801cf0:	89 d3                	mov    %edx,%ebx
  801cf2:	f7 24 24             	mull   (%esp)
  801cf5:	89 c6                	mov    %eax,%esi
  801cf7:	89 d1                	mov    %edx,%ecx
  801cf9:	39 d3                	cmp    %edx,%ebx
  801cfb:	0f 82 87 00 00 00    	jb     801d88 <__umoddi3+0x134>
  801d01:	0f 84 91 00 00 00    	je     801d98 <__umoddi3+0x144>
  801d07:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d0b:	29 f2                	sub    %esi,%edx
  801d0d:	19 cb                	sbb    %ecx,%ebx
  801d0f:	89 d8                	mov    %ebx,%eax
  801d11:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d15:	d3 e0                	shl    %cl,%eax
  801d17:	89 e9                	mov    %ebp,%ecx
  801d19:	d3 ea                	shr    %cl,%edx
  801d1b:	09 d0                	or     %edx,%eax
  801d1d:	89 e9                	mov    %ebp,%ecx
  801d1f:	d3 eb                	shr    %cl,%ebx
  801d21:	89 da                	mov    %ebx,%edx
  801d23:	83 c4 1c             	add    $0x1c,%esp
  801d26:	5b                   	pop    %ebx
  801d27:	5e                   	pop    %esi
  801d28:	5f                   	pop    %edi
  801d29:	5d                   	pop    %ebp
  801d2a:	c3                   	ret    
  801d2b:	90                   	nop
  801d2c:	89 fd                	mov    %edi,%ebp
  801d2e:	85 ff                	test   %edi,%edi
  801d30:	75 0b                	jne    801d3d <__umoddi3+0xe9>
  801d32:	b8 01 00 00 00       	mov    $0x1,%eax
  801d37:	31 d2                	xor    %edx,%edx
  801d39:	f7 f7                	div    %edi
  801d3b:	89 c5                	mov    %eax,%ebp
  801d3d:	89 f0                	mov    %esi,%eax
  801d3f:	31 d2                	xor    %edx,%edx
  801d41:	f7 f5                	div    %ebp
  801d43:	89 c8                	mov    %ecx,%eax
  801d45:	f7 f5                	div    %ebp
  801d47:	89 d0                	mov    %edx,%eax
  801d49:	e9 44 ff ff ff       	jmp    801c92 <__umoddi3+0x3e>
  801d4e:	66 90                	xchg   %ax,%ax
  801d50:	89 c8                	mov    %ecx,%eax
  801d52:	89 f2                	mov    %esi,%edx
  801d54:	83 c4 1c             	add    $0x1c,%esp
  801d57:	5b                   	pop    %ebx
  801d58:	5e                   	pop    %esi
  801d59:	5f                   	pop    %edi
  801d5a:	5d                   	pop    %ebp
  801d5b:	c3                   	ret    
  801d5c:	3b 04 24             	cmp    (%esp),%eax
  801d5f:	72 06                	jb     801d67 <__umoddi3+0x113>
  801d61:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d65:	77 0f                	ja     801d76 <__umoddi3+0x122>
  801d67:	89 f2                	mov    %esi,%edx
  801d69:	29 f9                	sub    %edi,%ecx
  801d6b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d6f:	89 14 24             	mov    %edx,(%esp)
  801d72:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d76:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d7a:	8b 14 24             	mov    (%esp),%edx
  801d7d:	83 c4 1c             	add    $0x1c,%esp
  801d80:	5b                   	pop    %ebx
  801d81:	5e                   	pop    %esi
  801d82:	5f                   	pop    %edi
  801d83:	5d                   	pop    %ebp
  801d84:	c3                   	ret    
  801d85:	8d 76 00             	lea    0x0(%esi),%esi
  801d88:	2b 04 24             	sub    (%esp),%eax
  801d8b:	19 fa                	sbb    %edi,%edx
  801d8d:	89 d1                	mov    %edx,%ecx
  801d8f:	89 c6                	mov    %eax,%esi
  801d91:	e9 71 ff ff ff       	jmp    801d07 <__umoddi3+0xb3>
  801d96:	66 90                	xchg   %ax,%ax
  801d98:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d9c:	72 ea                	jb     801d88 <__umoddi3+0x134>
  801d9e:	89 d9                	mov    %ebx,%ecx
  801da0:	e9 62 ff ff ff       	jmp    801d07 <__umoddi3+0xb3>
