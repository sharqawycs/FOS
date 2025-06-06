
obj/user/sc_CPU_MLFQ_Master_1:     file format elf32-i386


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
  800031:	e8 66 00 00 00       	call   80009c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 5; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 39                	jmp    800080 <_main+0x48>
			ID = sys_create_env("tmlfq_1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 04 20 80 00       	mov    0x802004,%eax
  80004c:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800052:	a1 04 20 80 00       	mov    0x802004,%eax
  800057:	8b 40 74             	mov    0x74(%eax),%eax
  80005a:	83 ec 04             	sub    $0x4,%esp
  80005d:	52                   	push   %edx
  80005e:	50                   	push   %eax
  80005f:	68 40 19 80 00       	push   $0x801940
  800064:	e8 54 13 00 00       	call   8013bd <sys_create_env>
  800069:	83 c4 10             	add    $0x10,%esp
  80006c:	89 45 f0             	mov    %eax,-0x10(%ebp)
			sys_run_env(ID);
  80006f:	83 ec 0c             	sub    $0xc,%esp
  800072:	ff 75 f0             	pushl  -0x10(%ebp)
  800075:	e8 60 13 00 00       	call   8013da <sys_run_env>
  80007a:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  80007d:	ff 45 f4             	incl   -0xc(%ebp)
  800080:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  800084:	7e c1                	jle    800047 <_main+0xf>
			ID = sys_create_env("tmlfq_1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}

		//env_sleep(80000);
		int x = busy_wait(50000000);
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 80 f0 fa 02       	push   $0x2faf080
  80008e:	e8 18 16 00 00       	call   8016ab <busy_wait>
  800093:	83 c4 10             	add    $0x10,%esp
  800096:	89 45 ec             	mov    %eax,-0x14(%ebp)

}
  800099:	90                   	nop
  80009a:	c9                   	leave  
  80009b:	c3                   	ret    

0080009c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80009c:	55                   	push   %ebp
  80009d:	89 e5                	mov    %esp,%ebp
  80009f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000a2:	e8 f6 0f 00 00       	call   80109d <sys_getenvindex>
  8000a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ad:	89 d0                	mov    %edx,%eax
  8000af:	01 c0                	add    %eax,%eax
  8000b1:	01 d0                	add    %edx,%eax
  8000b3:	c1 e0 02             	shl    $0x2,%eax
  8000b6:	01 d0                	add    %edx,%eax
  8000b8:	c1 e0 06             	shl    $0x6,%eax
  8000bb:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000c0:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000c5:	a1 04 20 80 00       	mov    0x802004,%eax
  8000ca:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000d0:	84 c0                	test   %al,%al
  8000d2:	74 0f                	je     8000e3 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000d4:	a1 04 20 80 00       	mov    0x802004,%eax
  8000d9:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000de:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000e7:	7e 0a                	jle    8000f3 <libmain+0x57>
		binaryname = argv[0];
  8000e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000f3:	83 ec 08             	sub    $0x8,%esp
  8000f6:	ff 75 0c             	pushl  0xc(%ebp)
  8000f9:	ff 75 08             	pushl  0x8(%ebp)
  8000fc:	e8 37 ff ff ff       	call   800038 <_main>
  800101:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800104:	e8 2f 11 00 00       	call   801238 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800109:	83 ec 0c             	sub    $0xc,%esp
  80010c:	68 60 19 80 00       	push   $0x801960
  800111:	e8 5c 01 00 00       	call   800272 <cprintf>
  800116:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800119:	a1 04 20 80 00       	mov    0x802004,%eax
  80011e:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800124:	a1 04 20 80 00       	mov    0x802004,%eax
  800129:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80012f:	83 ec 04             	sub    $0x4,%esp
  800132:	52                   	push   %edx
  800133:	50                   	push   %eax
  800134:	68 88 19 80 00       	push   $0x801988
  800139:	e8 34 01 00 00       	call   800272 <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800141:	a1 04 20 80 00       	mov    0x802004,%eax
  800146:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80014c:	83 ec 08             	sub    $0x8,%esp
  80014f:	50                   	push   %eax
  800150:	68 ad 19 80 00       	push   $0x8019ad
  800155:	e8 18 01 00 00       	call   800272 <cprintf>
  80015a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80015d:	83 ec 0c             	sub    $0xc,%esp
  800160:	68 60 19 80 00       	push   $0x801960
  800165:	e8 08 01 00 00       	call   800272 <cprintf>
  80016a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80016d:	e8 e0 10 00 00       	call   801252 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800172:	e8 19 00 00 00       	call   800190 <exit>
}
  800177:	90                   	nop
  800178:	c9                   	leave  
  800179:	c3                   	ret    

0080017a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80017a:	55                   	push   %ebp
  80017b:	89 e5                	mov    %esp,%ebp
  80017d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800180:	83 ec 0c             	sub    $0xc,%esp
  800183:	6a 00                	push   $0x0
  800185:	e8 df 0e 00 00       	call   801069 <sys_env_destroy>
  80018a:	83 c4 10             	add    $0x10,%esp
}
  80018d:	90                   	nop
  80018e:	c9                   	leave  
  80018f:	c3                   	ret    

00800190 <exit>:

void
exit(void)
{
  800190:	55                   	push   %ebp
  800191:	89 e5                	mov    %esp,%ebp
  800193:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800196:	e8 34 0f 00 00       	call   8010cf <sys_env_exit>
}
  80019b:	90                   	nop
  80019c:	c9                   	leave  
  80019d:	c3                   	ret    

0080019e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80019e:	55                   	push   %ebp
  80019f:	89 e5                	mov    %esp,%ebp
  8001a1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001a7:	8b 00                	mov    (%eax),%eax
  8001a9:	8d 48 01             	lea    0x1(%eax),%ecx
  8001ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001af:	89 0a                	mov    %ecx,(%edx)
  8001b1:	8b 55 08             	mov    0x8(%ebp),%edx
  8001b4:	88 d1                	mov    %dl,%cl
  8001b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c0:	8b 00                	mov    (%eax),%eax
  8001c2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001c7:	75 2c                	jne    8001f5 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001c9:	a0 08 20 80 00       	mov    0x802008,%al
  8001ce:	0f b6 c0             	movzbl %al,%eax
  8001d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d4:	8b 12                	mov    (%edx),%edx
  8001d6:	89 d1                	mov    %edx,%ecx
  8001d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001db:	83 c2 08             	add    $0x8,%edx
  8001de:	83 ec 04             	sub    $0x4,%esp
  8001e1:	50                   	push   %eax
  8001e2:	51                   	push   %ecx
  8001e3:	52                   	push   %edx
  8001e4:	e8 3e 0e 00 00       	call   801027 <sys_cputs>
  8001e9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f8:	8b 40 04             	mov    0x4(%eax),%eax
  8001fb:	8d 50 01             	lea    0x1(%eax),%edx
  8001fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800201:	89 50 04             	mov    %edx,0x4(%eax)
}
  800204:	90                   	nop
  800205:	c9                   	leave  
  800206:	c3                   	ret    

00800207 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800207:	55                   	push   %ebp
  800208:	89 e5                	mov    %esp,%ebp
  80020a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800210:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800217:	00 00 00 
	b.cnt = 0;
  80021a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800221:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800224:	ff 75 0c             	pushl  0xc(%ebp)
  800227:	ff 75 08             	pushl  0x8(%ebp)
  80022a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800230:	50                   	push   %eax
  800231:	68 9e 01 80 00       	push   $0x80019e
  800236:	e8 11 02 00 00       	call   80044c <vprintfmt>
  80023b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80023e:	a0 08 20 80 00       	mov    0x802008,%al
  800243:	0f b6 c0             	movzbl %al,%eax
  800246:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80024c:	83 ec 04             	sub    $0x4,%esp
  80024f:	50                   	push   %eax
  800250:	52                   	push   %edx
  800251:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800257:	83 c0 08             	add    $0x8,%eax
  80025a:	50                   	push   %eax
  80025b:	e8 c7 0d 00 00       	call   801027 <sys_cputs>
  800260:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800263:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  80026a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800270:	c9                   	leave  
  800271:	c3                   	ret    

00800272 <cprintf>:

int cprintf(const char *fmt, ...) {
  800272:	55                   	push   %ebp
  800273:	89 e5                	mov    %esp,%ebp
  800275:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800278:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  80027f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800282:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800285:	8b 45 08             	mov    0x8(%ebp),%eax
  800288:	83 ec 08             	sub    $0x8,%esp
  80028b:	ff 75 f4             	pushl  -0xc(%ebp)
  80028e:	50                   	push   %eax
  80028f:	e8 73 ff ff ff       	call   800207 <vcprintf>
  800294:	83 c4 10             	add    $0x10,%esp
  800297:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80029a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80029d:	c9                   	leave  
  80029e:	c3                   	ret    

0080029f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80029f:	55                   	push   %ebp
  8002a0:	89 e5                	mov    %esp,%ebp
  8002a2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002a5:	e8 8e 0f 00 00       	call   801238 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002aa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b3:	83 ec 08             	sub    $0x8,%esp
  8002b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8002b9:	50                   	push   %eax
  8002ba:	e8 48 ff ff ff       	call   800207 <vcprintf>
  8002bf:	83 c4 10             	add    $0x10,%esp
  8002c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002c5:	e8 88 0f 00 00       	call   801252 <sys_enable_interrupt>
	return cnt;
  8002ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002cd:	c9                   	leave  
  8002ce:	c3                   	ret    

008002cf <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002cf:	55                   	push   %ebp
  8002d0:	89 e5                	mov    %esp,%ebp
  8002d2:	53                   	push   %ebx
  8002d3:	83 ec 14             	sub    $0x14,%esp
  8002d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8002df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002e2:	8b 45 18             	mov    0x18(%ebp),%eax
  8002e5:	ba 00 00 00 00       	mov    $0x0,%edx
  8002ea:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002ed:	77 55                	ja     800344 <printnum+0x75>
  8002ef:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002f2:	72 05                	jb     8002f9 <printnum+0x2a>
  8002f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002f7:	77 4b                	ja     800344 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002f9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002fc:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002ff:	8b 45 18             	mov    0x18(%ebp),%eax
  800302:	ba 00 00 00 00       	mov    $0x0,%edx
  800307:	52                   	push   %edx
  800308:	50                   	push   %eax
  800309:	ff 75 f4             	pushl  -0xc(%ebp)
  80030c:	ff 75 f0             	pushl  -0x10(%ebp)
  80030f:	e8 b8 13 00 00       	call   8016cc <__udivdi3>
  800314:	83 c4 10             	add    $0x10,%esp
  800317:	83 ec 04             	sub    $0x4,%esp
  80031a:	ff 75 20             	pushl  0x20(%ebp)
  80031d:	53                   	push   %ebx
  80031e:	ff 75 18             	pushl  0x18(%ebp)
  800321:	52                   	push   %edx
  800322:	50                   	push   %eax
  800323:	ff 75 0c             	pushl  0xc(%ebp)
  800326:	ff 75 08             	pushl  0x8(%ebp)
  800329:	e8 a1 ff ff ff       	call   8002cf <printnum>
  80032e:	83 c4 20             	add    $0x20,%esp
  800331:	eb 1a                	jmp    80034d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800333:	83 ec 08             	sub    $0x8,%esp
  800336:	ff 75 0c             	pushl  0xc(%ebp)
  800339:	ff 75 20             	pushl  0x20(%ebp)
  80033c:	8b 45 08             	mov    0x8(%ebp),%eax
  80033f:	ff d0                	call   *%eax
  800341:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800344:	ff 4d 1c             	decl   0x1c(%ebp)
  800347:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80034b:	7f e6                	jg     800333 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80034d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800350:	bb 00 00 00 00       	mov    $0x0,%ebx
  800355:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800358:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80035b:	53                   	push   %ebx
  80035c:	51                   	push   %ecx
  80035d:	52                   	push   %edx
  80035e:	50                   	push   %eax
  80035f:	e8 78 14 00 00       	call   8017dc <__umoddi3>
  800364:	83 c4 10             	add    $0x10,%esp
  800367:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  80036c:	8a 00                	mov    (%eax),%al
  80036e:	0f be c0             	movsbl %al,%eax
  800371:	83 ec 08             	sub    $0x8,%esp
  800374:	ff 75 0c             	pushl  0xc(%ebp)
  800377:	50                   	push   %eax
  800378:	8b 45 08             	mov    0x8(%ebp),%eax
  80037b:	ff d0                	call   *%eax
  80037d:	83 c4 10             	add    $0x10,%esp
}
  800380:	90                   	nop
  800381:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800384:	c9                   	leave  
  800385:	c3                   	ret    

00800386 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800386:	55                   	push   %ebp
  800387:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800389:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80038d:	7e 1c                	jle    8003ab <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80038f:	8b 45 08             	mov    0x8(%ebp),%eax
  800392:	8b 00                	mov    (%eax),%eax
  800394:	8d 50 08             	lea    0x8(%eax),%edx
  800397:	8b 45 08             	mov    0x8(%ebp),%eax
  80039a:	89 10                	mov    %edx,(%eax)
  80039c:	8b 45 08             	mov    0x8(%ebp),%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	83 e8 08             	sub    $0x8,%eax
  8003a4:	8b 50 04             	mov    0x4(%eax),%edx
  8003a7:	8b 00                	mov    (%eax),%eax
  8003a9:	eb 40                	jmp    8003eb <getuint+0x65>
	else if (lflag)
  8003ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003af:	74 1e                	je     8003cf <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b4:	8b 00                	mov    (%eax),%eax
  8003b6:	8d 50 04             	lea    0x4(%eax),%edx
  8003b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bc:	89 10                	mov    %edx,(%eax)
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	8b 00                	mov    (%eax),%eax
  8003c3:	83 e8 04             	sub    $0x4,%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	ba 00 00 00 00       	mov    $0x0,%edx
  8003cd:	eb 1c                	jmp    8003eb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d2:	8b 00                	mov    (%eax),%eax
  8003d4:	8d 50 04             	lea    0x4(%eax),%edx
  8003d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003da:	89 10                	mov    %edx,(%eax)
  8003dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003df:	8b 00                	mov    (%eax),%eax
  8003e1:	83 e8 04             	sub    $0x4,%eax
  8003e4:	8b 00                	mov    (%eax),%eax
  8003e6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003eb:	5d                   	pop    %ebp
  8003ec:	c3                   	ret    

008003ed <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003ed:	55                   	push   %ebp
  8003ee:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003f0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003f4:	7e 1c                	jle    800412 <getint+0x25>
		return va_arg(*ap, long long);
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	8d 50 08             	lea    0x8(%eax),%edx
  8003fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800401:	89 10                	mov    %edx,(%eax)
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	83 e8 08             	sub    $0x8,%eax
  80040b:	8b 50 04             	mov    0x4(%eax),%edx
  80040e:	8b 00                	mov    (%eax),%eax
  800410:	eb 38                	jmp    80044a <getint+0x5d>
	else if (lflag)
  800412:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800416:	74 1a                	je     800432 <getint+0x45>
		return va_arg(*ap, long);
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	8d 50 04             	lea    0x4(%eax),%edx
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	89 10                	mov    %edx,(%eax)
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	83 e8 04             	sub    $0x4,%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	99                   	cltd   
  800430:	eb 18                	jmp    80044a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	8b 00                	mov    (%eax),%eax
  800437:	8d 50 04             	lea    0x4(%eax),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	89 10                	mov    %edx,(%eax)
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	8b 00                	mov    (%eax),%eax
  800444:	83 e8 04             	sub    $0x4,%eax
  800447:	8b 00                	mov    (%eax),%eax
  800449:	99                   	cltd   
}
  80044a:	5d                   	pop    %ebp
  80044b:	c3                   	ret    

0080044c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80044c:	55                   	push   %ebp
  80044d:	89 e5                	mov    %esp,%ebp
  80044f:	56                   	push   %esi
  800450:	53                   	push   %ebx
  800451:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800454:	eb 17                	jmp    80046d <vprintfmt+0x21>
			if (ch == '\0')
  800456:	85 db                	test   %ebx,%ebx
  800458:	0f 84 af 03 00 00    	je     80080d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80045e:	83 ec 08             	sub    $0x8,%esp
  800461:	ff 75 0c             	pushl  0xc(%ebp)
  800464:	53                   	push   %ebx
  800465:	8b 45 08             	mov    0x8(%ebp),%eax
  800468:	ff d0                	call   *%eax
  80046a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80046d:	8b 45 10             	mov    0x10(%ebp),%eax
  800470:	8d 50 01             	lea    0x1(%eax),%edx
  800473:	89 55 10             	mov    %edx,0x10(%ebp)
  800476:	8a 00                	mov    (%eax),%al
  800478:	0f b6 d8             	movzbl %al,%ebx
  80047b:	83 fb 25             	cmp    $0x25,%ebx
  80047e:	75 d6                	jne    800456 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800480:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800484:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80048b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800492:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800499:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a3:	8d 50 01             	lea    0x1(%eax),%edx
  8004a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8004a9:	8a 00                	mov    (%eax),%al
  8004ab:	0f b6 d8             	movzbl %al,%ebx
  8004ae:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004b1:	83 f8 55             	cmp    $0x55,%eax
  8004b4:	0f 87 2b 03 00 00    	ja     8007e5 <vprintfmt+0x399>
  8004ba:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004c1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004c3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004c7:	eb d7                	jmp    8004a0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004c9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004cd:	eb d1                	jmp    8004a0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004cf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004d6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004d9:	89 d0                	mov    %edx,%eax
  8004db:	c1 e0 02             	shl    $0x2,%eax
  8004de:	01 d0                	add    %edx,%eax
  8004e0:	01 c0                	add    %eax,%eax
  8004e2:	01 d8                	add    %ebx,%eax
  8004e4:	83 e8 30             	sub    $0x30,%eax
  8004e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ed:	8a 00                	mov    (%eax),%al
  8004ef:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004f2:	83 fb 2f             	cmp    $0x2f,%ebx
  8004f5:	7e 3e                	jle    800535 <vprintfmt+0xe9>
  8004f7:	83 fb 39             	cmp    $0x39,%ebx
  8004fa:	7f 39                	jg     800535 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004fc:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004ff:	eb d5                	jmp    8004d6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800501:	8b 45 14             	mov    0x14(%ebp),%eax
  800504:	83 c0 04             	add    $0x4,%eax
  800507:	89 45 14             	mov    %eax,0x14(%ebp)
  80050a:	8b 45 14             	mov    0x14(%ebp),%eax
  80050d:	83 e8 04             	sub    $0x4,%eax
  800510:	8b 00                	mov    (%eax),%eax
  800512:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800515:	eb 1f                	jmp    800536 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800517:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80051b:	79 83                	jns    8004a0 <vprintfmt+0x54>
				width = 0;
  80051d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800524:	e9 77 ff ff ff       	jmp    8004a0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800529:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800530:	e9 6b ff ff ff       	jmp    8004a0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800535:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800536:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80053a:	0f 89 60 ff ff ff    	jns    8004a0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800546:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80054d:	e9 4e ff ff ff       	jmp    8004a0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800552:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800555:	e9 46 ff ff ff       	jmp    8004a0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80055a:	8b 45 14             	mov    0x14(%ebp),%eax
  80055d:	83 c0 04             	add    $0x4,%eax
  800560:	89 45 14             	mov    %eax,0x14(%ebp)
  800563:	8b 45 14             	mov    0x14(%ebp),%eax
  800566:	83 e8 04             	sub    $0x4,%eax
  800569:	8b 00                	mov    (%eax),%eax
  80056b:	83 ec 08             	sub    $0x8,%esp
  80056e:	ff 75 0c             	pushl  0xc(%ebp)
  800571:	50                   	push   %eax
  800572:	8b 45 08             	mov    0x8(%ebp),%eax
  800575:	ff d0                	call   *%eax
  800577:	83 c4 10             	add    $0x10,%esp
			break;
  80057a:	e9 89 02 00 00       	jmp    800808 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80057f:	8b 45 14             	mov    0x14(%ebp),%eax
  800582:	83 c0 04             	add    $0x4,%eax
  800585:	89 45 14             	mov    %eax,0x14(%ebp)
  800588:	8b 45 14             	mov    0x14(%ebp),%eax
  80058b:	83 e8 04             	sub    $0x4,%eax
  80058e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800590:	85 db                	test   %ebx,%ebx
  800592:	79 02                	jns    800596 <vprintfmt+0x14a>
				err = -err;
  800594:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800596:	83 fb 64             	cmp    $0x64,%ebx
  800599:	7f 0b                	jg     8005a6 <vprintfmt+0x15a>
  80059b:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  8005a2:	85 f6                	test   %esi,%esi
  8005a4:	75 19                	jne    8005bf <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005a6:	53                   	push   %ebx
  8005a7:	68 05 1c 80 00       	push   $0x801c05
  8005ac:	ff 75 0c             	pushl  0xc(%ebp)
  8005af:	ff 75 08             	pushl  0x8(%ebp)
  8005b2:	e8 5e 02 00 00       	call   800815 <printfmt>
  8005b7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005ba:	e9 49 02 00 00       	jmp    800808 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005bf:	56                   	push   %esi
  8005c0:	68 0e 1c 80 00       	push   $0x801c0e
  8005c5:	ff 75 0c             	pushl  0xc(%ebp)
  8005c8:	ff 75 08             	pushl  0x8(%ebp)
  8005cb:	e8 45 02 00 00       	call   800815 <printfmt>
  8005d0:	83 c4 10             	add    $0x10,%esp
			break;
  8005d3:	e9 30 02 00 00       	jmp    800808 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005db:	83 c0 04             	add    $0x4,%eax
  8005de:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e4:	83 e8 04             	sub    $0x4,%eax
  8005e7:	8b 30                	mov    (%eax),%esi
  8005e9:	85 f6                	test   %esi,%esi
  8005eb:	75 05                	jne    8005f2 <vprintfmt+0x1a6>
				p = "(null)";
  8005ed:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  8005f2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005f6:	7e 6d                	jle    800665 <vprintfmt+0x219>
  8005f8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005fc:	74 67                	je     800665 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800601:	83 ec 08             	sub    $0x8,%esp
  800604:	50                   	push   %eax
  800605:	56                   	push   %esi
  800606:	e8 0c 03 00 00       	call   800917 <strnlen>
  80060b:	83 c4 10             	add    $0x10,%esp
  80060e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800611:	eb 16                	jmp    800629 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800613:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800617:	83 ec 08             	sub    $0x8,%esp
  80061a:	ff 75 0c             	pushl  0xc(%ebp)
  80061d:	50                   	push   %eax
  80061e:	8b 45 08             	mov    0x8(%ebp),%eax
  800621:	ff d0                	call   *%eax
  800623:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800626:	ff 4d e4             	decl   -0x1c(%ebp)
  800629:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80062d:	7f e4                	jg     800613 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80062f:	eb 34                	jmp    800665 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800631:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800635:	74 1c                	je     800653 <vprintfmt+0x207>
  800637:	83 fb 1f             	cmp    $0x1f,%ebx
  80063a:	7e 05                	jle    800641 <vprintfmt+0x1f5>
  80063c:	83 fb 7e             	cmp    $0x7e,%ebx
  80063f:	7e 12                	jle    800653 <vprintfmt+0x207>
					putch('?', putdat);
  800641:	83 ec 08             	sub    $0x8,%esp
  800644:	ff 75 0c             	pushl  0xc(%ebp)
  800647:	6a 3f                	push   $0x3f
  800649:	8b 45 08             	mov    0x8(%ebp),%eax
  80064c:	ff d0                	call   *%eax
  80064e:	83 c4 10             	add    $0x10,%esp
  800651:	eb 0f                	jmp    800662 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800653:	83 ec 08             	sub    $0x8,%esp
  800656:	ff 75 0c             	pushl  0xc(%ebp)
  800659:	53                   	push   %ebx
  80065a:	8b 45 08             	mov    0x8(%ebp),%eax
  80065d:	ff d0                	call   *%eax
  80065f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800662:	ff 4d e4             	decl   -0x1c(%ebp)
  800665:	89 f0                	mov    %esi,%eax
  800667:	8d 70 01             	lea    0x1(%eax),%esi
  80066a:	8a 00                	mov    (%eax),%al
  80066c:	0f be d8             	movsbl %al,%ebx
  80066f:	85 db                	test   %ebx,%ebx
  800671:	74 24                	je     800697 <vprintfmt+0x24b>
  800673:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800677:	78 b8                	js     800631 <vprintfmt+0x1e5>
  800679:	ff 4d e0             	decl   -0x20(%ebp)
  80067c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800680:	79 af                	jns    800631 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800682:	eb 13                	jmp    800697 <vprintfmt+0x24b>
				putch(' ', putdat);
  800684:	83 ec 08             	sub    $0x8,%esp
  800687:	ff 75 0c             	pushl  0xc(%ebp)
  80068a:	6a 20                	push   $0x20
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	ff d0                	call   *%eax
  800691:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800694:	ff 4d e4             	decl   -0x1c(%ebp)
  800697:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80069b:	7f e7                	jg     800684 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80069d:	e9 66 01 00 00       	jmp    800808 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006a2:	83 ec 08             	sub    $0x8,%esp
  8006a5:	ff 75 e8             	pushl  -0x18(%ebp)
  8006a8:	8d 45 14             	lea    0x14(%ebp),%eax
  8006ab:	50                   	push   %eax
  8006ac:	e8 3c fd ff ff       	call   8003ed <getint>
  8006b1:	83 c4 10             	add    $0x10,%esp
  8006b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006b7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006c0:	85 d2                	test   %edx,%edx
  8006c2:	79 23                	jns    8006e7 <vprintfmt+0x29b>
				putch('-', putdat);
  8006c4:	83 ec 08             	sub    $0x8,%esp
  8006c7:	ff 75 0c             	pushl  0xc(%ebp)
  8006ca:	6a 2d                	push   $0x2d
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	ff d0                	call   *%eax
  8006d1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006da:	f7 d8                	neg    %eax
  8006dc:	83 d2 00             	adc    $0x0,%edx
  8006df:	f7 da                	neg    %edx
  8006e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006e7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006ee:	e9 bc 00 00 00       	jmp    8007af <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006f3:	83 ec 08             	sub    $0x8,%esp
  8006f6:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f9:	8d 45 14             	lea    0x14(%ebp),%eax
  8006fc:	50                   	push   %eax
  8006fd:	e8 84 fc ff ff       	call   800386 <getuint>
  800702:	83 c4 10             	add    $0x10,%esp
  800705:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800708:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80070b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800712:	e9 98 00 00 00       	jmp    8007af <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	ff 75 0c             	pushl  0xc(%ebp)
  80071d:	6a 58                	push   $0x58
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	ff d0                	call   *%eax
  800724:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 0c             	pushl  0xc(%ebp)
  80072d:	6a 58                	push   $0x58
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	ff d0                	call   *%eax
  800734:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800737:	83 ec 08             	sub    $0x8,%esp
  80073a:	ff 75 0c             	pushl  0xc(%ebp)
  80073d:	6a 58                	push   $0x58
  80073f:	8b 45 08             	mov    0x8(%ebp),%eax
  800742:	ff d0                	call   *%eax
  800744:	83 c4 10             	add    $0x10,%esp
			break;
  800747:	e9 bc 00 00 00       	jmp    800808 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	ff 75 0c             	pushl  0xc(%ebp)
  800752:	6a 30                	push   $0x30
  800754:	8b 45 08             	mov    0x8(%ebp),%eax
  800757:	ff d0                	call   *%eax
  800759:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80075c:	83 ec 08             	sub    $0x8,%esp
  80075f:	ff 75 0c             	pushl  0xc(%ebp)
  800762:	6a 78                	push   $0x78
  800764:	8b 45 08             	mov    0x8(%ebp),%eax
  800767:	ff d0                	call   *%eax
  800769:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80076c:	8b 45 14             	mov    0x14(%ebp),%eax
  80076f:	83 c0 04             	add    $0x4,%eax
  800772:	89 45 14             	mov    %eax,0x14(%ebp)
  800775:	8b 45 14             	mov    0x14(%ebp),%eax
  800778:	83 e8 04             	sub    $0x4,%eax
  80077b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80077d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800780:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800787:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80078e:	eb 1f                	jmp    8007af <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800790:	83 ec 08             	sub    $0x8,%esp
  800793:	ff 75 e8             	pushl  -0x18(%ebp)
  800796:	8d 45 14             	lea    0x14(%ebp),%eax
  800799:	50                   	push   %eax
  80079a:	e8 e7 fb ff ff       	call   800386 <getuint>
  80079f:	83 c4 10             	add    $0x10,%esp
  8007a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007a8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007af:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007b6:	83 ec 04             	sub    $0x4,%esp
  8007b9:	52                   	push   %edx
  8007ba:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007bd:	50                   	push   %eax
  8007be:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c1:	ff 75 f0             	pushl  -0x10(%ebp)
  8007c4:	ff 75 0c             	pushl  0xc(%ebp)
  8007c7:	ff 75 08             	pushl  0x8(%ebp)
  8007ca:	e8 00 fb ff ff       	call   8002cf <printnum>
  8007cf:	83 c4 20             	add    $0x20,%esp
			break;
  8007d2:	eb 34                	jmp    800808 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007d4:	83 ec 08             	sub    $0x8,%esp
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	53                   	push   %ebx
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	ff d0                	call   *%eax
  8007e0:	83 c4 10             	add    $0x10,%esp
			break;
  8007e3:	eb 23                	jmp    800808 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	ff 75 0c             	pushl  0xc(%ebp)
  8007eb:	6a 25                	push   $0x25
  8007ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f0:	ff d0                	call   *%eax
  8007f2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007f5:	ff 4d 10             	decl   0x10(%ebp)
  8007f8:	eb 03                	jmp    8007fd <vprintfmt+0x3b1>
  8007fa:	ff 4d 10             	decl   0x10(%ebp)
  8007fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800800:	48                   	dec    %eax
  800801:	8a 00                	mov    (%eax),%al
  800803:	3c 25                	cmp    $0x25,%al
  800805:	75 f3                	jne    8007fa <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800807:	90                   	nop
		}
	}
  800808:	e9 47 fc ff ff       	jmp    800454 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80080d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80080e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800811:	5b                   	pop    %ebx
  800812:	5e                   	pop    %esi
  800813:	5d                   	pop    %ebp
  800814:	c3                   	ret    

00800815 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800815:	55                   	push   %ebp
  800816:	89 e5                	mov    %esp,%ebp
  800818:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80081b:	8d 45 10             	lea    0x10(%ebp),%eax
  80081e:	83 c0 04             	add    $0x4,%eax
  800821:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800824:	8b 45 10             	mov    0x10(%ebp),%eax
  800827:	ff 75 f4             	pushl  -0xc(%ebp)
  80082a:	50                   	push   %eax
  80082b:	ff 75 0c             	pushl  0xc(%ebp)
  80082e:	ff 75 08             	pushl  0x8(%ebp)
  800831:	e8 16 fc ff ff       	call   80044c <vprintfmt>
  800836:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800839:	90                   	nop
  80083a:	c9                   	leave  
  80083b:	c3                   	ret    

0080083c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80083c:	55                   	push   %ebp
  80083d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80083f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800842:	8b 40 08             	mov    0x8(%eax),%eax
  800845:	8d 50 01             	lea    0x1(%eax),%edx
  800848:	8b 45 0c             	mov    0xc(%ebp),%eax
  80084b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80084e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800851:	8b 10                	mov    (%eax),%edx
  800853:	8b 45 0c             	mov    0xc(%ebp),%eax
  800856:	8b 40 04             	mov    0x4(%eax),%eax
  800859:	39 c2                	cmp    %eax,%edx
  80085b:	73 12                	jae    80086f <sprintputch+0x33>
		*b->buf++ = ch;
  80085d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800860:	8b 00                	mov    (%eax),%eax
  800862:	8d 48 01             	lea    0x1(%eax),%ecx
  800865:	8b 55 0c             	mov    0xc(%ebp),%edx
  800868:	89 0a                	mov    %ecx,(%edx)
  80086a:	8b 55 08             	mov    0x8(%ebp),%edx
  80086d:	88 10                	mov    %dl,(%eax)
}
  80086f:	90                   	nop
  800870:	5d                   	pop    %ebp
  800871:	c3                   	ret    

00800872 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800872:	55                   	push   %ebp
  800873:	89 e5                	mov    %esp,%ebp
  800875:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800878:	8b 45 08             	mov    0x8(%ebp),%eax
  80087b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80087e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800881:	8d 50 ff             	lea    -0x1(%eax),%edx
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	01 d0                	add    %edx,%eax
  800889:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80088c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800893:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800897:	74 06                	je     80089f <vsnprintf+0x2d>
  800899:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80089d:	7f 07                	jg     8008a6 <vsnprintf+0x34>
		return -E_INVAL;
  80089f:	b8 03 00 00 00       	mov    $0x3,%eax
  8008a4:	eb 20                	jmp    8008c6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008a6:	ff 75 14             	pushl  0x14(%ebp)
  8008a9:	ff 75 10             	pushl  0x10(%ebp)
  8008ac:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008af:	50                   	push   %eax
  8008b0:	68 3c 08 80 00       	push   $0x80083c
  8008b5:	e8 92 fb ff ff       	call   80044c <vprintfmt>
  8008ba:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008c0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008c6:	c9                   	leave  
  8008c7:	c3                   	ret    

008008c8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008c8:	55                   	push   %ebp
  8008c9:	89 e5                	mov    %esp,%ebp
  8008cb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008ce:	8d 45 10             	lea    0x10(%ebp),%eax
  8008d1:	83 c0 04             	add    $0x4,%eax
  8008d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008da:	ff 75 f4             	pushl  -0xc(%ebp)
  8008dd:	50                   	push   %eax
  8008de:	ff 75 0c             	pushl  0xc(%ebp)
  8008e1:	ff 75 08             	pushl  0x8(%ebp)
  8008e4:	e8 89 ff ff ff       	call   800872 <vsnprintf>
  8008e9:	83 c4 10             	add    $0x10,%esp
  8008ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008f2:	c9                   	leave  
  8008f3:	c3                   	ret    

008008f4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008f4:	55                   	push   %ebp
  8008f5:	89 e5                	mov    %esp,%ebp
  8008f7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800901:	eb 06                	jmp    800909 <strlen+0x15>
		n++;
  800903:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800906:	ff 45 08             	incl   0x8(%ebp)
  800909:	8b 45 08             	mov    0x8(%ebp),%eax
  80090c:	8a 00                	mov    (%eax),%al
  80090e:	84 c0                	test   %al,%al
  800910:	75 f1                	jne    800903 <strlen+0xf>
		n++;
	return n;
  800912:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800915:	c9                   	leave  
  800916:	c3                   	ret    

00800917 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800917:	55                   	push   %ebp
  800918:	89 e5                	mov    %esp,%ebp
  80091a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80091d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800924:	eb 09                	jmp    80092f <strnlen+0x18>
		n++;
  800926:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800929:	ff 45 08             	incl   0x8(%ebp)
  80092c:	ff 4d 0c             	decl   0xc(%ebp)
  80092f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800933:	74 09                	je     80093e <strnlen+0x27>
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	8a 00                	mov    (%eax),%al
  80093a:	84 c0                	test   %al,%al
  80093c:	75 e8                	jne    800926 <strnlen+0xf>
		n++;
	return n;
  80093e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800941:	c9                   	leave  
  800942:	c3                   	ret    

00800943 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800943:	55                   	push   %ebp
  800944:	89 e5                	mov    %esp,%ebp
  800946:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80094f:	90                   	nop
  800950:	8b 45 08             	mov    0x8(%ebp),%eax
  800953:	8d 50 01             	lea    0x1(%eax),%edx
  800956:	89 55 08             	mov    %edx,0x8(%ebp)
  800959:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80095f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800962:	8a 12                	mov    (%edx),%dl
  800964:	88 10                	mov    %dl,(%eax)
  800966:	8a 00                	mov    (%eax),%al
  800968:	84 c0                	test   %al,%al
  80096a:	75 e4                	jne    800950 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80096c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80096f:	c9                   	leave  
  800970:	c3                   	ret    

00800971 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800971:	55                   	push   %ebp
  800972:	89 e5                	mov    %esp,%ebp
  800974:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80097d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800984:	eb 1f                	jmp    8009a5 <strncpy+0x34>
		*dst++ = *src;
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	8d 50 01             	lea    0x1(%eax),%edx
  80098c:	89 55 08             	mov    %edx,0x8(%ebp)
  80098f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800992:	8a 12                	mov    (%edx),%dl
  800994:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800996:	8b 45 0c             	mov    0xc(%ebp),%eax
  800999:	8a 00                	mov    (%eax),%al
  80099b:	84 c0                	test   %al,%al
  80099d:	74 03                	je     8009a2 <strncpy+0x31>
			src++;
  80099f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009a2:	ff 45 fc             	incl   -0x4(%ebp)
  8009a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009a8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009ab:	72 d9                	jb     800986 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009b0:	c9                   	leave  
  8009b1:	c3                   	ret    

008009b2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009b2:	55                   	push   %ebp
  8009b3:	89 e5                	mov    %esp,%ebp
  8009b5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009c2:	74 30                	je     8009f4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009c4:	eb 16                	jmp    8009dc <strlcpy+0x2a>
			*dst++ = *src++;
  8009c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c9:	8d 50 01             	lea    0x1(%eax),%edx
  8009cc:	89 55 08             	mov    %edx,0x8(%ebp)
  8009cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009d5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009d8:	8a 12                	mov    (%edx),%dl
  8009da:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009dc:	ff 4d 10             	decl   0x10(%ebp)
  8009df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009e3:	74 09                	je     8009ee <strlcpy+0x3c>
  8009e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e8:	8a 00                	mov    (%eax),%al
  8009ea:	84 c0                	test   %al,%al
  8009ec:	75 d8                	jne    8009c6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009f4:	8b 55 08             	mov    0x8(%ebp),%edx
  8009f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009fa:	29 c2                	sub    %eax,%edx
  8009fc:	89 d0                	mov    %edx,%eax
}
  8009fe:	c9                   	leave  
  8009ff:	c3                   	ret    

00800a00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a00:	55                   	push   %ebp
  800a01:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a03:	eb 06                	jmp    800a0b <strcmp+0xb>
		p++, q++;
  800a05:	ff 45 08             	incl   0x8(%ebp)
  800a08:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0e:	8a 00                	mov    (%eax),%al
  800a10:	84 c0                	test   %al,%al
  800a12:	74 0e                	je     800a22 <strcmp+0x22>
  800a14:	8b 45 08             	mov    0x8(%ebp),%eax
  800a17:	8a 10                	mov    (%eax),%dl
  800a19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1c:	8a 00                	mov    (%eax),%al
  800a1e:	38 c2                	cmp    %al,%dl
  800a20:	74 e3                	je     800a05 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	8a 00                	mov    (%eax),%al
  800a27:	0f b6 d0             	movzbl %al,%edx
  800a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2d:	8a 00                	mov    (%eax),%al
  800a2f:	0f b6 c0             	movzbl %al,%eax
  800a32:	29 c2                	sub    %eax,%edx
  800a34:	89 d0                	mov    %edx,%eax
}
  800a36:	5d                   	pop    %ebp
  800a37:	c3                   	ret    

00800a38 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a38:	55                   	push   %ebp
  800a39:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a3b:	eb 09                	jmp    800a46 <strncmp+0xe>
		n--, p++, q++;
  800a3d:	ff 4d 10             	decl   0x10(%ebp)
  800a40:	ff 45 08             	incl   0x8(%ebp)
  800a43:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a4a:	74 17                	je     800a63 <strncmp+0x2b>
  800a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4f:	8a 00                	mov    (%eax),%al
  800a51:	84 c0                	test   %al,%al
  800a53:	74 0e                	je     800a63 <strncmp+0x2b>
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	8a 10                	mov    (%eax),%dl
  800a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5d:	8a 00                	mov    (%eax),%al
  800a5f:	38 c2                	cmp    %al,%dl
  800a61:	74 da                	je     800a3d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a67:	75 07                	jne    800a70 <strncmp+0x38>
		return 0;
  800a69:	b8 00 00 00 00       	mov    $0x0,%eax
  800a6e:	eb 14                	jmp    800a84 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	8a 00                	mov    (%eax),%al
  800a75:	0f b6 d0             	movzbl %al,%edx
  800a78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7b:	8a 00                	mov    (%eax),%al
  800a7d:	0f b6 c0             	movzbl %al,%eax
  800a80:	29 c2                	sub    %eax,%edx
  800a82:	89 d0                	mov    %edx,%eax
}
  800a84:	5d                   	pop    %ebp
  800a85:	c3                   	ret    

00800a86 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a86:	55                   	push   %ebp
  800a87:	89 e5                	mov    %esp,%ebp
  800a89:	83 ec 04             	sub    $0x4,%esp
  800a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a92:	eb 12                	jmp    800aa6 <strchr+0x20>
		if (*s == c)
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a9c:	75 05                	jne    800aa3 <strchr+0x1d>
			return (char *) s;
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	eb 11                	jmp    800ab4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800aa3:	ff 45 08             	incl   0x8(%ebp)
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	8a 00                	mov    (%eax),%al
  800aab:	84 c0                	test   %al,%al
  800aad:	75 e5                	jne    800a94 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800aaf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ab4:	c9                   	leave  
  800ab5:	c3                   	ret    

00800ab6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ab6:	55                   	push   %ebp
  800ab7:	89 e5                	mov    %esp,%ebp
  800ab9:	83 ec 04             	sub    $0x4,%esp
  800abc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ac2:	eb 0d                	jmp    800ad1 <strfind+0x1b>
		if (*s == c)
  800ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac7:	8a 00                	mov    (%eax),%al
  800ac9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800acc:	74 0e                	je     800adc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ace:	ff 45 08             	incl   0x8(%ebp)
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	8a 00                	mov    (%eax),%al
  800ad6:	84 c0                	test   %al,%al
  800ad8:	75 ea                	jne    800ac4 <strfind+0xe>
  800ada:	eb 01                	jmp    800add <strfind+0x27>
		if (*s == c)
			break;
  800adc:	90                   	nop
	return (char *) s;
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ae0:	c9                   	leave  
  800ae1:	c3                   	ret    

00800ae2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ae2:	55                   	push   %ebp
  800ae3:	89 e5                	mov    %esp,%ebp
  800ae5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800aee:	8b 45 10             	mov    0x10(%ebp),%eax
  800af1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800af4:	eb 0e                	jmp    800b04 <memset+0x22>
		*p++ = c;
  800af6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800af9:	8d 50 01             	lea    0x1(%eax),%edx
  800afc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800aff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b02:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b04:	ff 4d f8             	decl   -0x8(%ebp)
  800b07:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b0b:	79 e9                	jns    800af6 <memset+0x14>
		*p++ = c;

	return v;
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b10:	c9                   	leave  
  800b11:	c3                   	ret    

00800b12 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b12:	55                   	push   %ebp
  800b13:	89 e5                	mov    %esp,%ebp
  800b15:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b24:	eb 16                	jmp    800b3c <memcpy+0x2a>
		*d++ = *s++;
  800b26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b29:	8d 50 01             	lea    0x1(%eax),%edx
  800b2c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b2f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b32:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b35:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b38:	8a 12                	mov    (%edx),%dl
  800b3a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b42:	89 55 10             	mov    %edx,0x10(%ebp)
  800b45:	85 c0                	test   %eax,%eax
  800b47:	75 dd                	jne    800b26 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b4c:	c9                   	leave  
  800b4d:	c3                   	ret    

00800b4e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b4e:	55                   	push   %ebp
  800b4f:	89 e5                	mov    %esp,%ebp
  800b51:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b63:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b66:	73 50                	jae    800bb8 <memmove+0x6a>
  800b68:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6e:	01 d0                	add    %edx,%eax
  800b70:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b73:	76 43                	jbe    800bb8 <memmove+0x6a>
		s += n;
  800b75:	8b 45 10             	mov    0x10(%ebp),%eax
  800b78:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b81:	eb 10                	jmp    800b93 <memmove+0x45>
			*--d = *--s;
  800b83:	ff 4d f8             	decl   -0x8(%ebp)
  800b86:	ff 4d fc             	decl   -0x4(%ebp)
  800b89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b8c:	8a 10                	mov    (%eax),%dl
  800b8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b91:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b93:	8b 45 10             	mov    0x10(%ebp),%eax
  800b96:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b99:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9c:	85 c0                	test   %eax,%eax
  800b9e:	75 e3                	jne    800b83 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ba0:	eb 23                	jmp    800bc5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ba2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ba5:	8d 50 01             	lea    0x1(%eax),%edx
  800ba8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bae:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bb4:	8a 12                	mov    (%edx),%dl
  800bb6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bbe:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc1:	85 c0                	test   %eax,%eax
  800bc3:	75 dd                	jne    800ba2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bc8:	c9                   	leave  
  800bc9:	c3                   	ret    

00800bca <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bca:	55                   	push   %ebp
  800bcb:	89 e5                	mov    %esp,%ebp
  800bcd:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bdc:	eb 2a                	jmp    800c08 <memcmp+0x3e>
		if (*s1 != *s2)
  800bde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be1:	8a 10                	mov    (%eax),%dl
  800be3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be6:	8a 00                	mov    (%eax),%al
  800be8:	38 c2                	cmp    %al,%dl
  800bea:	74 16                	je     800c02 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bef:	8a 00                	mov    (%eax),%al
  800bf1:	0f b6 d0             	movzbl %al,%edx
  800bf4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf7:	8a 00                	mov    (%eax),%al
  800bf9:	0f b6 c0             	movzbl %al,%eax
  800bfc:	29 c2                	sub    %eax,%edx
  800bfe:	89 d0                	mov    %edx,%eax
  800c00:	eb 18                	jmp    800c1a <memcmp+0x50>
		s1++, s2++;
  800c02:	ff 45 fc             	incl   -0x4(%ebp)
  800c05:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c08:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c0e:	89 55 10             	mov    %edx,0x10(%ebp)
  800c11:	85 c0                	test   %eax,%eax
  800c13:	75 c9                	jne    800bde <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c15:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c1a:	c9                   	leave  
  800c1b:	c3                   	ret    

00800c1c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c1c:	55                   	push   %ebp
  800c1d:	89 e5                	mov    %esp,%ebp
  800c1f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c22:	8b 55 08             	mov    0x8(%ebp),%edx
  800c25:	8b 45 10             	mov    0x10(%ebp),%eax
  800c28:	01 d0                	add    %edx,%eax
  800c2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c2d:	eb 15                	jmp    800c44 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	8a 00                	mov    (%eax),%al
  800c34:	0f b6 d0             	movzbl %al,%edx
  800c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3a:	0f b6 c0             	movzbl %al,%eax
  800c3d:	39 c2                	cmp    %eax,%edx
  800c3f:	74 0d                	je     800c4e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c41:	ff 45 08             	incl   0x8(%ebp)
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c4a:	72 e3                	jb     800c2f <memfind+0x13>
  800c4c:	eb 01                	jmp    800c4f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c4e:	90                   	nop
	return (void *) s;
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c52:	c9                   	leave  
  800c53:	c3                   	ret    

00800c54 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c54:	55                   	push   %ebp
  800c55:	89 e5                	mov    %esp,%ebp
  800c57:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c5a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c61:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c68:	eb 03                	jmp    800c6d <strtol+0x19>
		s++;
  800c6a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	3c 20                	cmp    $0x20,%al
  800c74:	74 f4                	je     800c6a <strtol+0x16>
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	8a 00                	mov    (%eax),%al
  800c7b:	3c 09                	cmp    $0x9,%al
  800c7d:	74 eb                	je     800c6a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	3c 2b                	cmp    $0x2b,%al
  800c86:	75 05                	jne    800c8d <strtol+0x39>
		s++;
  800c88:	ff 45 08             	incl   0x8(%ebp)
  800c8b:	eb 13                	jmp    800ca0 <strtol+0x4c>
	else if (*s == '-')
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	3c 2d                	cmp    $0x2d,%al
  800c94:	75 0a                	jne    800ca0 <strtol+0x4c>
		s++, neg = 1;
  800c96:	ff 45 08             	incl   0x8(%ebp)
  800c99:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ca0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca4:	74 06                	je     800cac <strtol+0x58>
  800ca6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800caa:	75 20                	jne    800ccc <strtol+0x78>
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	3c 30                	cmp    $0x30,%al
  800cb3:	75 17                	jne    800ccc <strtol+0x78>
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	40                   	inc    %eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	3c 78                	cmp    $0x78,%al
  800cbd:	75 0d                	jne    800ccc <strtol+0x78>
		s += 2, base = 16;
  800cbf:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cc3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cca:	eb 28                	jmp    800cf4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ccc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd0:	75 15                	jne    800ce7 <strtol+0x93>
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	3c 30                	cmp    $0x30,%al
  800cd9:	75 0c                	jne    800ce7 <strtol+0x93>
		s++, base = 8;
  800cdb:	ff 45 08             	incl   0x8(%ebp)
  800cde:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ce5:	eb 0d                	jmp    800cf4 <strtol+0xa0>
	else if (base == 0)
  800ce7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ceb:	75 07                	jne    800cf4 <strtol+0xa0>
		base = 10;
  800ced:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf7:	8a 00                	mov    (%eax),%al
  800cf9:	3c 2f                	cmp    $0x2f,%al
  800cfb:	7e 19                	jle    800d16 <strtol+0xc2>
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	8a 00                	mov    (%eax),%al
  800d02:	3c 39                	cmp    $0x39,%al
  800d04:	7f 10                	jg     800d16 <strtol+0xc2>
			dig = *s - '0';
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f be c0             	movsbl %al,%eax
  800d0e:	83 e8 30             	sub    $0x30,%eax
  800d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d14:	eb 42                	jmp    800d58 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	3c 60                	cmp    $0x60,%al
  800d1d:	7e 19                	jle    800d38 <strtol+0xe4>
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	3c 7a                	cmp    $0x7a,%al
  800d26:	7f 10                	jg     800d38 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8a 00                	mov    (%eax),%al
  800d2d:	0f be c0             	movsbl %al,%eax
  800d30:	83 e8 57             	sub    $0x57,%eax
  800d33:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d36:	eb 20                	jmp    800d58 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8a 00                	mov    (%eax),%al
  800d3d:	3c 40                	cmp    $0x40,%al
  800d3f:	7e 39                	jle    800d7a <strtol+0x126>
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	8a 00                	mov    (%eax),%al
  800d46:	3c 5a                	cmp    $0x5a,%al
  800d48:	7f 30                	jg     800d7a <strtol+0x126>
			dig = *s - 'A' + 10;
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	8a 00                	mov    (%eax),%al
  800d4f:	0f be c0             	movsbl %al,%eax
  800d52:	83 e8 37             	sub    $0x37,%eax
  800d55:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d5b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d5e:	7d 19                	jge    800d79 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d60:	ff 45 08             	incl   0x8(%ebp)
  800d63:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d66:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d6a:	89 c2                	mov    %eax,%edx
  800d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d6f:	01 d0                	add    %edx,%eax
  800d71:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d74:	e9 7b ff ff ff       	jmp    800cf4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d79:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d7a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d7e:	74 08                	je     800d88 <strtol+0x134>
		*endptr = (char *) s;
  800d80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d83:	8b 55 08             	mov    0x8(%ebp),%edx
  800d86:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d88:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d8c:	74 07                	je     800d95 <strtol+0x141>
  800d8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d91:	f7 d8                	neg    %eax
  800d93:	eb 03                	jmp    800d98 <strtol+0x144>
  800d95:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d98:	c9                   	leave  
  800d99:	c3                   	ret    

00800d9a <ltostr>:

void
ltostr(long value, char *str)
{
  800d9a:	55                   	push   %ebp
  800d9b:	89 e5                	mov    %esp,%ebp
  800d9d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800da0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800da7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800db2:	79 13                	jns    800dc7 <ltostr+0x2d>
	{
		neg = 1;
  800db4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbe:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dc1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dc4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dcf:	99                   	cltd   
  800dd0:	f7 f9                	idiv   %ecx
  800dd2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd8:	8d 50 01             	lea    0x1(%eax),%edx
  800ddb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dde:	89 c2                	mov    %eax,%edx
  800de0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de3:	01 d0                	add    %edx,%eax
  800de5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800de8:	83 c2 30             	add    $0x30,%edx
  800deb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ded:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800df0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800df5:	f7 e9                	imul   %ecx
  800df7:	c1 fa 02             	sar    $0x2,%edx
  800dfa:	89 c8                	mov    %ecx,%eax
  800dfc:	c1 f8 1f             	sar    $0x1f,%eax
  800dff:	29 c2                	sub    %eax,%edx
  800e01:	89 d0                	mov    %edx,%eax
  800e03:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e06:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e09:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e0e:	f7 e9                	imul   %ecx
  800e10:	c1 fa 02             	sar    $0x2,%edx
  800e13:	89 c8                	mov    %ecx,%eax
  800e15:	c1 f8 1f             	sar    $0x1f,%eax
  800e18:	29 c2                	sub    %eax,%edx
  800e1a:	89 d0                	mov    %edx,%eax
  800e1c:	c1 e0 02             	shl    $0x2,%eax
  800e1f:	01 d0                	add    %edx,%eax
  800e21:	01 c0                	add    %eax,%eax
  800e23:	29 c1                	sub    %eax,%ecx
  800e25:	89 ca                	mov    %ecx,%edx
  800e27:	85 d2                	test   %edx,%edx
  800e29:	75 9c                	jne    800dc7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e2b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e35:	48                   	dec    %eax
  800e36:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e39:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e3d:	74 3d                	je     800e7c <ltostr+0xe2>
		start = 1 ;
  800e3f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e46:	eb 34                	jmp    800e7c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e48:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4e:	01 d0                	add    %edx,%eax
  800e50:	8a 00                	mov    (%eax),%al
  800e52:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e55:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5b:	01 c2                	add    %eax,%edx
  800e5d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e63:	01 c8                	add    %ecx,%eax
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e69:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6f:	01 c2                	add    %eax,%edx
  800e71:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e74:	88 02                	mov    %al,(%edx)
		start++ ;
  800e76:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e79:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e7f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e82:	7c c4                	jl     800e48 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e84:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8a:	01 d0                	add    %edx,%eax
  800e8c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e8f:	90                   	nop
  800e90:	c9                   	leave  
  800e91:	c3                   	ret    

00800e92 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e92:	55                   	push   %ebp
  800e93:	89 e5                	mov    %esp,%ebp
  800e95:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e98:	ff 75 08             	pushl  0x8(%ebp)
  800e9b:	e8 54 fa ff ff       	call   8008f4 <strlen>
  800ea0:	83 c4 04             	add    $0x4,%esp
  800ea3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ea6:	ff 75 0c             	pushl  0xc(%ebp)
  800ea9:	e8 46 fa ff ff       	call   8008f4 <strlen>
  800eae:	83 c4 04             	add    $0x4,%esp
  800eb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800eb4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ebb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ec2:	eb 17                	jmp    800edb <strcconcat+0x49>
		final[s] = str1[s] ;
  800ec4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ec7:	8b 45 10             	mov    0x10(%ebp),%eax
  800eca:	01 c2                	add    %eax,%edx
  800ecc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	01 c8                	add    %ecx,%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ed8:	ff 45 fc             	incl   -0x4(%ebp)
  800edb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ede:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ee1:	7c e1                	jl     800ec4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ee3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800eea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ef1:	eb 1f                	jmp    800f12 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ef3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef6:	8d 50 01             	lea    0x1(%eax),%edx
  800ef9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800efc:	89 c2                	mov    %eax,%edx
  800efe:	8b 45 10             	mov    0x10(%ebp),%eax
  800f01:	01 c2                	add    %eax,%edx
  800f03:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f09:	01 c8                	add    %ecx,%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f0f:	ff 45 f8             	incl   -0x8(%ebp)
  800f12:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f15:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f18:	7c d9                	jl     800ef3 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f1a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f20:	01 d0                	add    %edx,%eax
  800f22:	c6 00 00             	movb   $0x0,(%eax)
}
  800f25:	90                   	nop
  800f26:	c9                   	leave  
  800f27:	c3                   	ret    

00800f28 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f28:	55                   	push   %ebp
  800f29:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f34:	8b 45 14             	mov    0x14(%ebp),%eax
  800f37:	8b 00                	mov    (%eax),%eax
  800f39:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f40:	8b 45 10             	mov    0x10(%ebp),%eax
  800f43:	01 d0                	add    %edx,%eax
  800f45:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f4b:	eb 0c                	jmp    800f59 <strsplit+0x31>
			*string++ = 0;
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	8d 50 01             	lea    0x1(%eax),%edx
  800f53:	89 55 08             	mov    %edx,0x8(%ebp)
  800f56:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	84 c0                	test   %al,%al
  800f60:	74 18                	je     800f7a <strsplit+0x52>
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	0f be c0             	movsbl %al,%eax
  800f6a:	50                   	push   %eax
  800f6b:	ff 75 0c             	pushl  0xc(%ebp)
  800f6e:	e8 13 fb ff ff       	call   800a86 <strchr>
  800f73:	83 c4 08             	add    $0x8,%esp
  800f76:	85 c0                	test   %eax,%eax
  800f78:	75 d3                	jne    800f4d <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	84 c0                	test   %al,%al
  800f81:	74 5a                	je     800fdd <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f83:	8b 45 14             	mov    0x14(%ebp),%eax
  800f86:	8b 00                	mov    (%eax),%eax
  800f88:	83 f8 0f             	cmp    $0xf,%eax
  800f8b:	75 07                	jne    800f94 <strsplit+0x6c>
		{
			return 0;
  800f8d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f92:	eb 66                	jmp    800ffa <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f94:	8b 45 14             	mov    0x14(%ebp),%eax
  800f97:	8b 00                	mov    (%eax),%eax
  800f99:	8d 48 01             	lea    0x1(%eax),%ecx
  800f9c:	8b 55 14             	mov    0x14(%ebp),%edx
  800f9f:	89 0a                	mov    %ecx,(%edx)
  800fa1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fa8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fab:	01 c2                	add    %eax,%edx
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fb2:	eb 03                	jmp    800fb7 <strsplit+0x8f>
			string++;
  800fb4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	84 c0                	test   %al,%al
  800fbe:	74 8b                	je     800f4b <strsplit+0x23>
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	0f be c0             	movsbl %al,%eax
  800fc8:	50                   	push   %eax
  800fc9:	ff 75 0c             	pushl  0xc(%ebp)
  800fcc:	e8 b5 fa ff ff       	call   800a86 <strchr>
  800fd1:	83 c4 08             	add    $0x8,%esp
  800fd4:	85 c0                	test   %eax,%eax
  800fd6:	74 dc                	je     800fb4 <strsplit+0x8c>
			string++;
	}
  800fd8:	e9 6e ff ff ff       	jmp    800f4b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fdd:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fde:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe1:	8b 00                	mov    (%eax),%eax
  800fe3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fea:	8b 45 10             	mov    0x10(%ebp),%eax
  800fed:	01 d0                	add    %edx,%eax
  800fef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800ff5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800ffa:	c9                   	leave  
  800ffb:	c3                   	ret    

00800ffc <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800ffc:	55                   	push   %ebp
  800ffd:	89 e5                	mov    %esp,%ebp
  800fff:	57                   	push   %edi
  801000:	56                   	push   %esi
  801001:	53                   	push   %ebx
  801002:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
  801008:	8b 55 0c             	mov    0xc(%ebp),%edx
  80100b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80100e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801011:	8b 7d 18             	mov    0x18(%ebp),%edi
  801014:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801017:	cd 30                	int    $0x30
  801019:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80101c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80101f:	83 c4 10             	add    $0x10,%esp
  801022:	5b                   	pop    %ebx
  801023:	5e                   	pop    %esi
  801024:	5f                   	pop    %edi
  801025:	5d                   	pop    %ebp
  801026:	c3                   	ret    

00801027 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801027:	55                   	push   %ebp
  801028:	89 e5                	mov    %esp,%ebp
  80102a:	83 ec 04             	sub    $0x4,%esp
  80102d:	8b 45 10             	mov    0x10(%ebp),%eax
  801030:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801033:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	6a 00                	push   $0x0
  80103c:	6a 00                	push   $0x0
  80103e:	52                   	push   %edx
  80103f:	ff 75 0c             	pushl  0xc(%ebp)
  801042:	50                   	push   %eax
  801043:	6a 00                	push   $0x0
  801045:	e8 b2 ff ff ff       	call   800ffc <syscall>
  80104a:	83 c4 18             	add    $0x18,%esp
}
  80104d:	90                   	nop
  80104e:	c9                   	leave  
  80104f:	c3                   	ret    

00801050 <sys_cgetc>:

int
sys_cgetc(void)
{
  801050:	55                   	push   %ebp
  801051:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801053:	6a 00                	push   $0x0
  801055:	6a 00                	push   $0x0
  801057:	6a 00                	push   $0x0
  801059:	6a 00                	push   $0x0
  80105b:	6a 00                	push   $0x0
  80105d:	6a 01                	push   $0x1
  80105f:	e8 98 ff ff ff       	call   800ffc <syscall>
  801064:	83 c4 18             	add    $0x18,%esp
}
  801067:	c9                   	leave  
  801068:	c3                   	ret    

00801069 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801069:	55                   	push   %ebp
  80106a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	6a 00                	push   $0x0
  801071:	6a 00                	push   $0x0
  801073:	6a 00                	push   $0x0
  801075:	6a 00                	push   $0x0
  801077:	50                   	push   %eax
  801078:	6a 05                	push   $0x5
  80107a:	e8 7d ff ff ff       	call   800ffc <syscall>
  80107f:	83 c4 18             	add    $0x18,%esp
}
  801082:	c9                   	leave  
  801083:	c3                   	ret    

00801084 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801084:	55                   	push   %ebp
  801085:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801087:	6a 00                	push   $0x0
  801089:	6a 00                	push   $0x0
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	6a 02                	push   $0x2
  801093:	e8 64 ff ff ff       	call   800ffc <syscall>
  801098:	83 c4 18             	add    $0x18,%esp
}
  80109b:	c9                   	leave  
  80109c:	c3                   	ret    

0080109d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80109d:	55                   	push   %ebp
  80109e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010a0:	6a 00                	push   $0x0
  8010a2:	6a 00                	push   $0x0
  8010a4:	6a 00                	push   $0x0
  8010a6:	6a 00                	push   $0x0
  8010a8:	6a 00                	push   $0x0
  8010aa:	6a 03                	push   $0x3
  8010ac:	e8 4b ff ff ff       	call   800ffc <syscall>
  8010b1:	83 c4 18             	add    $0x18,%esp
}
  8010b4:	c9                   	leave  
  8010b5:	c3                   	ret    

008010b6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010b6:	55                   	push   %ebp
  8010b7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010b9:	6a 00                	push   $0x0
  8010bb:	6a 00                	push   $0x0
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 04                	push   $0x4
  8010c5:	e8 32 ff ff ff       	call   800ffc <syscall>
  8010ca:	83 c4 18             	add    $0x18,%esp
}
  8010cd:	c9                   	leave  
  8010ce:	c3                   	ret    

008010cf <sys_env_exit>:


void sys_env_exit(void)
{
  8010cf:	55                   	push   %ebp
  8010d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010d2:	6a 00                	push   $0x0
  8010d4:	6a 00                	push   $0x0
  8010d6:	6a 00                	push   $0x0
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 00                	push   $0x0
  8010dc:	6a 06                	push   $0x6
  8010de:	e8 19 ff ff ff       	call   800ffc <syscall>
  8010e3:	83 c4 18             	add    $0x18,%esp
}
  8010e6:	90                   	nop
  8010e7:	c9                   	leave  
  8010e8:	c3                   	ret    

008010e9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010e9:	55                   	push   %ebp
  8010ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 00                	push   $0x0
  8010f8:	52                   	push   %edx
  8010f9:	50                   	push   %eax
  8010fa:	6a 07                	push   $0x7
  8010fc:	e8 fb fe ff ff       	call   800ffc <syscall>
  801101:	83 c4 18             	add    $0x18,%esp
}
  801104:	c9                   	leave  
  801105:	c3                   	ret    

00801106 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801106:	55                   	push   %ebp
  801107:	89 e5                	mov    %esp,%ebp
  801109:	56                   	push   %esi
  80110a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80110b:	8b 75 18             	mov    0x18(%ebp),%esi
  80110e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801111:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801114:	8b 55 0c             	mov    0xc(%ebp),%edx
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	56                   	push   %esi
  80111b:	53                   	push   %ebx
  80111c:	51                   	push   %ecx
  80111d:	52                   	push   %edx
  80111e:	50                   	push   %eax
  80111f:	6a 08                	push   $0x8
  801121:	e8 d6 fe ff ff       	call   800ffc <syscall>
  801126:	83 c4 18             	add    $0x18,%esp
}
  801129:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80112c:	5b                   	pop    %ebx
  80112d:	5e                   	pop    %esi
  80112e:	5d                   	pop    %ebp
  80112f:	c3                   	ret    

00801130 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801130:	55                   	push   %ebp
  801131:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801133:	8b 55 0c             	mov    0xc(%ebp),%edx
  801136:	8b 45 08             	mov    0x8(%ebp),%eax
  801139:	6a 00                	push   $0x0
  80113b:	6a 00                	push   $0x0
  80113d:	6a 00                	push   $0x0
  80113f:	52                   	push   %edx
  801140:	50                   	push   %eax
  801141:	6a 09                	push   $0x9
  801143:	e8 b4 fe ff ff       	call   800ffc <syscall>
  801148:	83 c4 18             	add    $0x18,%esp
}
  80114b:	c9                   	leave  
  80114c:	c3                   	ret    

0080114d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80114d:	55                   	push   %ebp
  80114e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801150:	6a 00                	push   $0x0
  801152:	6a 00                	push   $0x0
  801154:	6a 00                	push   $0x0
  801156:	ff 75 0c             	pushl  0xc(%ebp)
  801159:	ff 75 08             	pushl  0x8(%ebp)
  80115c:	6a 0a                	push   $0xa
  80115e:	e8 99 fe ff ff       	call   800ffc <syscall>
  801163:	83 c4 18             	add    $0x18,%esp
}
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80116b:	6a 00                	push   $0x0
  80116d:	6a 00                	push   $0x0
  80116f:	6a 00                	push   $0x0
  801171:	6a 00                	push   $0x0
  801173:	6a 00                	push   $0x0
  801175:	6a 0b                	push   $0xb
  801177:	e8 80 fe ff ff       	call   800ffc <syscall>
  80117c:	83 c4 18             	add    $0x18,%esp
}
  80117f:	c9                   	leave  
  801180:	c3                   	ret    

00801181 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801181:	55                   	push   %ebp
  801182:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801184:	6a 00                	push   $0x0
  801186:	6a 00                	push   $0x0
  801188:	6a 00                	push   $0x0
  80118a:	6a 00                	push   $0x0
  80118c:	6a 00                	push   $0x0
  80118e:	6a 0c                	push   $0xc
  801190:	e8 67 fe ff ff       	call   800ffc <syscall>
  801195:	83 c4 18             	add    $0x18,%esp
}
  801198:	c9                   	leave  
  801199:	c3                   	ret    

0080119a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80119a:	55                   	push   %ebp
  80119b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80119d:	6a 00                	push   $0x0
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 00                	push   $0x0
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	6a 0d                	push   $0xd
  8011a9:	e8 4e fe ff ff       	call   800ffc <syscall>
  8011ae:	83 c4 18             	add    $0x18,%esp
}
  8011b1:	c9                   	leave  
  8011b2:	c3                   	ret    

008011b3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011b3:	55                   	push   %ebp
  8011b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011b6:	6a 00                	push   $0x0
  8011b8:	6a 00                	push   $0x0
  8011ba:	6a 00                	push   $0x0
  8011bc:	ff 75 0c             	pushl  0xc(%ebp)
  8011bf:	ff 75 08             	pushl  0x8(%ebp)
  8011c2:	6a 11                	push   $0x11
  8011c4:	e8 33 fe ff ff       	call   800ffc <syscall>
  8011c9:	83 c4 18             	add    $0x18,%esp
	return;
  8011cc:	90                   	nop
}
  8011cd:	c9                   	leave  
  8011ce:	c3                   	ret    

008011cf <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011cf:	55                   	push   %ebp
  8011d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	ff 75 0c             	pushl  0xc(%ebp)
  8011db:	ff 75 08             	pushl  0x8(%ebp)
  8011de:	6a 12                	push   $0x12
  8011e0:	e8 17 fe ff ff       	call   800ffc <syscall>
  8011e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8011e8:	90                   	nop
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 0e                	push   $0xe
  8011fa:	e8 fd fd ff ff       	call   800ffc <syscall>
  8011ff:	83 c4 18             	add    $0x18,%esp
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801207:	6a 00                	push   $0x0
  801209:	6a 00                	push   $0x0
  80120b:	6a 00                	push   $0x0
  80120d:	6a 00                	push   $0x0
  80120f:	ff 75 08             	pushl  0x8(%ebp)
  801212:	6a 0f                	push   $0xf
  801214:	e8 e3 fd ff ff       	call   800ffc <syscall>
  801219:	83 c4 18             	add    $0x18,%esp
}
  80121c:	c9                   	leave  
  80121d:	c3                   	ret    

0080121e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80121e:	55                   	push   %ebp
  80121f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801221:	6a 00                	push   $0x0
  801223:	6a 00                	push   $0x0
  801225:	6a 00                	push   $0x0
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	6a 10                	push   $0x10
  80122d:	e8 ca fd ff ff       	call   800ffc <syscall>
  801232:	83 c4 18             	add    $0x18,%esp
}
  801235:	90                   	nop
  801236:	c9                   	leave  
  801237:	c3                   	ret    

00801238 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801238:	55                   	push   %ebp
  801239:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 14                	push   $0x14
  801247:	e8 b0 fd ff ff       	call   800ffc <syscall>
  80124c:	83 c4 18             	add    $0x18,%esp
}
  80124f:	90                   	nop
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 15                	push   $0x15
  801261:	e8 96 fd ff ff       	call   800ffc <syscall>
  801266:	83 c4 18             	add    $0x18,%esp
}
  801269:	90                   	nop
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <sys_cputc>:


void
sys_cputc(const char c)
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
  80126f:	83 ec 04             	sub    $0x4,%esp
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801278:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	50                   	push   %eax
  801285:	6a 16                	push   $0x16
  801287:	e8 70 fd ff ff       	call   800ffc <syscall>
  80128c:	83 c4 18             	add    $0x18,%esp
}
  80128f:	90                   	nop
  801290:	c9                   	leave  
  801291:	c3                   	ret    

00801292 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801295:	6a 00                	push   $0x0
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 17                	push   $0x17
  8012a1:	e8 56 fd ff ff       	call   800ffc <syscall>
  8012a6:	83 c4 18             	add    $0x18,%esp
}
  8012a9:	90                   	nop
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	ff 75 0c             	pushl  0xc(%ebp)
  8012bb:	50                   	push   %eax
  8012bc:	6a 18                	push   $0x18
  8012be:	e8 39 fd ff ff       	call   800ffc <syscall>
  8012c3:	83 c4 18             	add    $0x18,%esp
}
  8012c6:	c9                   	leave  
  8012c7:	c3                   	ret    

008012c8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	52                   	push   %edx
  8012d8:	50                   	push   %eax
  8012d9:	6a 1b                	push   $0x1b
  8012db:	e8 1c fd ff ff       	call   800ffc <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	c9                   	leave  
  8012e4:	c3                   	ret    

008012e5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012e5:	55                   	push   %ebp
  8012e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	52                   	push   %edx
  8012f5:	50                   	push   %eax
  8012f6:	6a 19                	push   $0x19
  8012f8:	e8 ff fc ff ff       	call   800ffc <syscall>
  8012fd:	83 c4 18             	add    $0x18,%esp
}
  801300:	90                   	nop
  801301:	c9                   	leave  
  801302:	c3                   	ret    

00801303 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801303:	55                   	push   %ebp
  801304:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801306:	8b 55 0c             	mov    0xc(%ebp),%edx
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	52                   	push   %edx
  801313:	50                   	push   %eax
  801314:	6a 1a                	push   $0x1a
  801316:	e8 e1 fc ff ff       	call   800ffc <syscall>
  80131b:	83 c4 18             	add    $0x18,%esp
}
  80131e:	90                   	nop
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
  801324:	83 ec 04             	sub    $0x4,%esp
  801327:	8b 45 10             	mov    0x10(%ebp),%eax
  80132a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80132d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801330:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	6a 00                	push   $0x0
  801339:	51                   	push   %ecx
  80133a:	52                   	push   %edx
  80133b:	ff 75 0c             	pushl  0xc(%ebp)
  80133e:	50                   	push   %eax
  80133f:	6a 1c                	push   $0x1c
  801341:	e8 b6 fc ff ff       	call   800ffc <syscall>
  801346:	83 c4 18             	add    $0x18,%esp
}
  801349:	c9                   	leave  
  80134a:	c3                   	ret    

0080134b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80134b:	55                   	push   %ebp
  80134c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80134e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801351:	8b 45 08             	mov    0x8(%ebp),%eax
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	52                   	push   %edx
  80135b:	50                   	push   %eax
  80135c:	6a 1d                	push   $0x1d
  80135e:	e8 99 fc ff ff       	call   800ffc <syscall>
  801363:	83 c4 18             	add    $0x18,%esp
}
  801366:	c9                   	leave  
  801367:	c3                   	ret    

00801368 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80136b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80136e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	51                   	push   %ecx
  801379:	52                   	push   %edx
  80137a:	50                   	push   %eax
  80137b:	6a 1e                	push   $0x1e
  80137d:	e8 7a fc ff ff       	call   800ffc <syscall>
  801382:	83 c4 18             	add    $0x18,%esp
}
  801385:	c9                   	leave  
  801386:	c3                   	ret    

00801387 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801387:	55                   	push   %ebp
  801388:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80138a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	6a 00                	push   $0x0
  801392:	6a 00                	push   $0x0
  801394:	6a 00                	push   $0x0
  801396:	52                   	push   %edx
  801397:	50                   	push   %eax
  801398:	6a 1f                	push   $0x1f
  80139a:	e8 5d fc ff ff       	call   800ffc <syscall>
  80139f:	83 c4 18             	add    $0x18,%esp
}
  8013a2:	c9                   	leave  
  8013a3:	c3                   	ret    

008013a4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 20                	push   $0x20
  8013b3:	e8 44 fc ff ff       	call   800ffc <syscall>
  8013b8:	83 c4 18             	add    $0x18,%esp
}
  8013bb:	c9                   	leave  
  8013bc:	c3                   	ret    

008013bd <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	ff 75 10             	pushl  0x10(%ebp)
  8013ca:	ff 75 0c             	pushl  0xc(%ebp)
  8013cd:	50                   	push   %eax
  8013ce:	6a 21                	push   $0x21
  8013d0:	e8 27 fc ff ff       	call   800ffc <syscall>
  8013d5:	83 c4 18             	add    $0x18,%esp
}
  8013d8:	c9                   	leave  
  8013d9:	c3                   	ret    

008013da <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	50                   	push   %eax
  8013e9:	6a 22                	push   $0x22
  8013eb:	e8 0c fc ff ff       	call   800ffc <syscall>
  8013f0:	83 c4 18             	add    $0x18,%esp
}
  8013f3:	90                   	nop
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	50                   	push   %eax
  801405:	6a 23                	push   $0x23
  801407:	e8 f0 fb ff ff       	call   800ffc <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	90                   	nop
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
  801415:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801418:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80141b:	8d 50 04             	lea    0x4(%eax),%edx
  80141e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	52                   	push   %edx
  801428:	50                   	push   %eax
  801429:	6a 24                	push   $0x24
  80142b:	e8 cc fb ff ff       	call   800ffc <syscall>
  801430:	83 c4 18             	add    $0x18,%esp
	return result;
  801433:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801436:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801439:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80143c:	89 01                	mov    %eax,(%ecx)
  80143e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	c9                   	leave  
  801445:	c2 04 00             	ret    $0x4

00801448 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801448:	55                   	push   %ebp
  801449:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	ff 75 10             	pushl  0x10(%ebp)
  801452:	ff 75 0c             	pushl  0xc(%ebp)
  801455:	ff 75 08             	pushl  0x8(%ebp)
  801458:	6a 13                	push   $0x13
  80145a:	e8 9d fb ff ff       	call   800ffc <syscall>
  80145f:	83 c4 18             	add    $0x18,%esp
	return ;
  801462:	90                   	nop
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <sys_rcr2>:
uint32 sys_rcr2()
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	6a 25                	push   $0x25
  801474:	e8 83 fb ff ff       	call   800ffc <syscall>
  801479:	83 c4 18             	add    $0x18,%esp
}
  80147c:	c9                   	leave  
  80147d:	c3                   	ret    

0080147e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
  801481:	83 ec 04             	sub    $0x4,%esp
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
  801487:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80148a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	50                   	push   %eax
  801497:	6a 26                	push   $0x26
  801499:	e8 5e fb ff ff       	call   800ffc <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a1:	90                   	nop
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <rsttst>:
void rsttst()
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 28                	push   $0x28
  8014b3:	e8 44 fb ff ff       	call   800ffc <syscall>
  8014b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8014bb:	90                   	nop
}
  8014bc:	c9                   	leave  
  8014bd:	c3                   	ret    

008014be <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014be:	55                   	push   %ebp
  8014bf:	89 e5                	mov    %esp,%ebp
  8014c1:	83 ec 04             	sub    $0x4,%esp
  8014c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014ca:	8b 55 18             	mov    0x18(%ebp),%edx
  8014cd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014d1:	52                   	push   %edx
  8014d2:	50                   	push   %eax
  8014d3:	ff 75 10             	pushl  0x10(%ebp)
  8014d6:	ff 75 0c             	pushl  0xc(%ebp)
  8014d9:	ff 75 08             	pushl  0x8(%ebp)
  8014dc:	6a 27                	push   $0x27
  8014de:	e8 19 fb ff ff       	call   800ffc <syscall>
  8014e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e6:	90                   	nop
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <chktst>:
void chktst(uint32 n)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	ff 75 08             	pushl  0x8(%ebp)
  8014f7:	6a 29                	push   $0x29
  8014f9:	e8 fe fa ff ff       	call   800ffc <syscall>
  8014fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801501:	90                   	nop
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <inctst>:

void inctst()
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 2a                	push   $0x2a
  801513:	e8 e4 fa ff ff       	call   800ffc <syscall>
  801518:	83 c4 18             	add    $0x18,%esp
	return ;
  80151b:	90                   	nop
}
  80151c:	c9                   	leave  
  80151d:	c3                   	ret    

0080151e <gettst>:
uint32 gettst()
{
  80151e:	55                   	push   %ebp
  80151f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801521:	6a 00                	push   $0x0
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 2b                	push   $0x2b
  80152d:	e8 ca fa ff ff       	call   800ffc <syscall>
  801532:	83 c4 18             	add    $0x18,%esp
}
  801535:	c9                   	leave  
  801536:	c3                   	ret    

00801537 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
  80153a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 2c                	push   $0x2c
  801549:	e8 ae fa ff ff       	call   800ffc <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
  801551:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801554:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801558:	75 07                	jne    801561 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80155a:	b8 01 00 00 00       	mov    $0x1,%eax
  80155f:	eb 05                	jmp    801566 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801561:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801566:	c9                   	leave  
  801567:	c3                   	ret    

00801568 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801568:	55                   	push   %ebp
  801569:	89 e5                	mov    %esp,%ebp
  80156b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 2c                	push   $0x2c
  80157a:	e8 7d fa ff ff       	call   800ffc <syscall>
  80157f:	83 c4 18             	add    $0x18,%esp
  801582:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801585:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801589:	75 07                	jne    801592 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80158b:	b8 01 00 00 00       	mov    $0x1,%eax
  801590:	eb 05                	jmp    801597 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801592:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
  80159c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 2c                	push   $0x2c
  8015ab:	e8 4c fa ff ff       	call   800ffc <syscall>
  8015b0:	83 c4 18             	add    $0x18,%esp
  8015b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015b6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015ba:	75 07                	jne    8015c3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015bc:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c1:	eb 05                	jmp    8015c8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c8:	c9                   	leave  
  8015c9:	c3                   	ret    

008015ca <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015ca:	55                   	push   %ebp
  8015cb:	89 e5                	mov    %esp,%ebp
  8015cd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 2c                	push   $0x2c
  8015dc:	e8 1b fa ff ff       	call   800ffc <syscall>
  8015e1:	83 c4 18             	add    $0x18,%esp
  8015e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015e7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015eb:	75 07                	jne    8015f4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f2:	eb 05                	jmp    8015f9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f9:	c9                   	leave  
  8015fa:	c3                   	ret    

008015fb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015fb:	55                   	push   %ebp
  8015fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	ff 75 08             	pushl  0x8(%ebp)
  801609:	6a 2d                	push   $0x2d
  80160b:	e8 ec f9 ff ff       	call   800ffc <syscall>
  801610:	83 c4 18             	add    $0x18,%esp
	return ;
  801613:	90                   	nop
}
  801614:	c9                   	leave  
  801615:	c3                   	ret    

00801616 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801616:	55                   	push   %ebp
  801617:	89 e5                	mov    %esp,%ebp
  801619:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80161c:	8b 55 08             	mov    0x8(%ebp),%edx
  80161f:	89 d0                	mov    %edx,%eax
  801621:	c1 e0 02             	shl    $0x2,%eax
  801624:	01 d0                	add    %edx,%eax
  801626:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80162d:	01 d0                	add    %edx,%eax
  80162f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801636:	01 d0                	add    %edx,%eax
  801638:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80163f:	01 d0                	add    %edx,%eax
  801641:	c1 e0 04             	shl    $0x4,%eax
  801644:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801647:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80164e:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801651:	83 ec 0c             	sub    $0xc,%esp
  801654:	50                   	push   %eax
  801655:	e8 b8 fd ff ff       	call   801412 <sys_get_virtual_time>
  80165a:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80165d:	eb 41                	jmp    8016a0 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80165f:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801662:	83 ec 0c             	sub    $0xc,%esp
  801665:	50                   	push   %eax
  801666:	e8 a7 fd ff ff       	call   801412 <sys_get_virtual_time>
  80166b:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80166e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801671:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801674:	29 c2                	sub    %eax,%edx
  801676:	89 d0                	mov    %edx,%eax
  801678:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80167b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80167e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801681:	89 d1                	mov    %edx,%ecx
  801683:	29 c1                	sub    %eax,%ecx
  801685:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801688:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80168b:	39 c2                	cmp    %eax,%edx
  80168d:	0f 97 c0             	seta   %al
  801690:	0f b6 c0             	movzbl %al,%eax
  801693:	29 c1                	sub    %eax,%ecx
  801695:	89 c8                	mov    %ecx,%eax
  801697:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80169a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80169d:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8016a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016a3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016a6:	72 b7                	jb     80165f <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8016a8:	90                   	nop
  8016a9:	c9                   	leave  
  8016aa:	c3                   	ret    

008016ab <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8016ab:	55                   	push   %ebp
  8016ac:	89 e5                	mov    %esp,%ebp
  8016ae:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8016b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8016b8:	eb 03                	jmp    8016bd <busy_wait+0x12>
  8016ba:	ff 45 fc             	incl   -0x4(%ebp)
  8016bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c0:	3b 45 08             	cmp    0x8(%ebp),%eax
  8016c3:	72 f5                	jb     8016ba <busy_wait+0xf>
	return i;
  8016c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016c8:	c9                   	leave  
  8016c9:	c3                   	ret    
  8016ca:	66 90                	xchg   %ax,%ax

008016cc <__udivdi3>:
  8016cc:	55                   	push   %ebp
  8016cd:	57                   	push   %edi
  8016ce:	56                   	push   %esi
  8016cf:	53                   	push   %ebx
  8016d0:	83 ec 1c             	sub    $0x1c,%esp
  8016d3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016d7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016df:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016e3:	89 ca                	mov    %ecx,%edx
  8016e5:	89 f8                	mov    %edi,%eax
  8016e7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016eb:	85 f6                	test   %esi,%esi
  8016ed:	75 2d                	jne    80171c <__udivdi3+0x50>
  8016ef:	39 cf                	cmp    %ecx,%edi
  8016f1:	77 65                	ja     801758 <__udivdi3+0x8c>
  8016f3:	89 fd                	mov    %edi,%ebp
  8016f5:	85 ff                	test   %edi,%edi
  8016f7:	75 0b                	jne    801704 <__udivdi3+0x38>
  8016f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8016fe:	31 d2                	xor    %edx,%edx
  801700:	f7 f7                	div    %edi
  801702:	89 c5                	mov    %eax,%ebp
  801704:	31 d2                	xor    %edx,%edx
  801706:	89 c8                	mov    %ecx,%eax
  801708:	f7 f5                	div    %ebp
  80170a:	89 c1                	mov    %eax,%ecx
  80170c:	89 d8                	mov    %ebx,%eax
  80170e:	f7 f5                	div    %ebp
  801710:	89 cf                	mov    %ecx,%edi
  801712:	89 fa                	mov    %edi,%edx
  801714:	83 c4 1c             	add    $0x1c,%esp
  801717:	5b                   	pop    %ebx
  801718:	5e                   	pop    %esi
  801719:	5f                   	pop    %edi
  80171a:	5d                   	pop    %ebp
  80171b:	c3                   	ret    
  80171c:	39 ce                	cmp    %ecx,%esi
  80171e:	77 28                	ja     801748 <__udivdi3+0x7c>
  801720:	0f bd fe             	bsr    %esi,%edi
  801723:	83 f7 1f             	xor    $0x1f,%edi
  801726:	75 40                	jne    801768 <__udivdi3+0x9c>
  801728:	39 ce                	cmp    %ecx,%esi
  80172a:	72 0a                	jb     801736 <__udivdi3+0x6a>
  80172c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801730:	0f 87 9e 00 00 00    	ja     8017d4 <__udivdi3+0x108>
  801736:	b8 01 00 00 00       	mov    $0x1,%eax
  80173b:	89 fa                	mov    %edi,%edx
  80173d:	83 c4 1c             	add    $0x1c,%esp
  801740:	5b                   	pop    %ebx
  801741:	5e                   	pop    %esi
  801742:	5f                   	pop    %edi
  801743:	5d                   	pop    %ebp
  801744:	c3                   	ret    
  801745:	8d 76 00             	lea    0x0(%esi),%esi
  801748:	31 ff                	xor    %edi,%edi
  80174a:	31 c0                	xor    %eax,%eax
  80174c:	89 fa                	mov    %edi,%edx
  80174e:	83 c4 1c             	add    $0x1c,%esp
  801751:	5b                   	pop    %ebx
  801752:	5e                   	pop    %esi
  801753:	5f                   	pop    %edi
  801754:	5d                   	pop    %ebp
  801755:	c3                   	ret    
  801756:	66 90                	xchg   %ax,%ax
  801758:	89 d8                	mov    %ebx,%eax
  80175a:	f7 f7                	div    %edi
  80175c:	31 ff                	xor    %edi,%edi
  80175e:	89 fa                	mov    %edi,%edx
  801760:	83 c4 1c             	add    $0x1c,%esp
  801763:	5b                   	pop    %ebx
  801764:	5e                   	pop    %esi
  801765:	5f                   	pop    %edi
  801766:	5d                   	pop    %ebp
  801767:	c3                   	ret    
  801768:	bd 20 00 00 00       	mov    $0x20,%ebp
  80176d:	89 eb                	mov    %ebp,%ebx
  80176f:	29 fb                	sub    %edi,%ebx
  801771:	89 f9                	mov    %edi,%ecx
  801773:	d3 e6                	shl    %cl,%esi
  801775:	89 c5                	mov    %eax,%ebp
  801777:	88 d9                	mov    %bl,%cl
  801779:	d3 ed                	shr    %cl,%ebp
  80177b:	89 e9                	mov    %ebp,%ecx
  80177d:	09 f1                	or     %esi,%ecx
  80177f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801783:	89 f9                	mov    %edi,%ecx
  801785:	d3 e0                	shl    %cl,%eax
  801787:	89 c5                	mov    %eax,%ebp
  801789:	89 d6                	mov    %edx,%esi
  80178b:	88 d9                	mov    %bl,%cl
  80178d:	d3 ee                	shr    %cl,%esi
  80178f:	89 f9                	mov    %edi,%ecx
  801791:	d3 e2                	shl    %cl,%edx
  801793:	8b 44 24 08          	mov    0x8(%esp),%eax
  801797:	88 d9                	mov    %bl,%cl
  801799:	d3 e8                	shr    %cl,%eax
  80179b:	09 c2                	or     %eax,%edx
  80179d:	89 d0                	mov    %edx,%eax
  80179f:	89 f2                	mov    %esi,%edx
  8017a1:	f7 74 24 0c          	divl   0xc(%esp)
  8017a5:	89 d6                	mov    %edx,%esi
  8017a7:	89 c3                	mov    %eax,%ebx
  8017a9:	f7 e5                	mul    %ebp
  8017ab:	39 d6                	cmp    %edx,%esi
  8017ad:	72 19                	jb     8017c8 <__udivdi3+0xfc>
  8017af:	74 0b                	je     8017bc <__udivdi3+0xf0>
  8017b1:	89 d8                	mov    %ebx,%eax
  8017b3:	31 ff                	xor    %edi,%edi
  8017b5:	e9 58 ff ff ff       	jmp    801712 <__udivdi3+0x46>
  8017ba:	66 90                	xchg   %ax,%ax
  8017bc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017c0:	89 f9                	mov    %edi,%ecx
  8017c2:	d3 e2                	shl    %cl,%edx
  8017c4:	39 c2                	cmp    %eax,%edx
  8017c6:	73 e9                	jae    8017b1 <__udivdi3+0xe5>
  8017c8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017cb:	31 ff                	xor    %edi,%edi
  8017cd:	e9 40 ff ff ff       	jmp    801712 <__udivdi3+0x46>
  8017d2:	66 90                	xchg   %ax,%ax
  8017d4:	31 c0                	xor    %eax,%eax
  8017d6:	e9 37 ff ff ff       	jmp    801712 <__udivdi3+0x46>
  8017db:	90                   	nop

008017dc <__umoddi3>:
  8017dc:	55                   	push   %ebp
  8017dd:	57                   	push   %edi
  8017de:	56                   	push   %esi
  8017df:	53                   	push   %ebx
  8017e0:	83 ec 1c             	sub    $0x1c,%esp
  8017e3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017e7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017ef:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017f7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017fb:	89 f3                	mov    %esi,%ebx
  8017fd:	89 fa                	mov    %edi,%edx
  8017ff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801803:	89 34 24             	mov    %esi,(%esp)
  801806:	85 c0                	test   %eax,%eax
  801808:	75 1a                	jne    801824 <__umoddi3+0x48>
  80180a:	39 f7                	cmp    %esi,%edi
  80180c:	0f 86 a2 00 00 00    	jbe    8018b4 <__umoddi3+0xd8>
  801812:	89 c8                	mov    %ecx,%eax
  801814:	89 f2                	mov    %esi,%edx
  801816:	f7 f7                	div    %edi
  801818:	89 d0                	mov    %edx,%eax
  80181a:	31 d2                	xor    %edx,%edx
  80181c:	83 c4 1c             	add    $0x1c,%esp
  80181f:	5b                   	pop    %ebx
  801820:	5e                   	pop    %esi
  801821:	5f                   	pop    %edi
  801822:	5d                   	pop    %ebp
  801823:	c3                   	ret    
  801824:	39 f0                	cmp    %esi,%eax
  801826:	0f 87 ac 00 00 00    	ja     8018d8 <__umoddi3+0xfc>
  80182c:	0f bd e8             	bsr    %eax,%ebp
  80182f:	83 f5 1f             	xor    $0x1f,%ebp
  801832:	0f 84 ac 00 00 00    	je     8018e4 <__umoddi3+0x108>
  801838:	bf 20 00 00 00       	mov    $0x20,%edi
  80183d:	29 ef                	sub    %ebp,%edi
  80183f:	89 fe                	mov    %edi,%esi
  801841:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801845:	89 e9                	mov    %ebp,%ecx
  801847:	d3 e0                	shl    %cl,%eax
  801849:	89 d7                	mov    %edx,%edi
  80184b:	89 f1                	mov    %esi,%ecx
  80184d:	d3 ef                	shr    %cl,%edi
  80184f:	09 c7                	or     %eax,%edi
  801851:	89 e9                	mov    %ebp,%ecx
  801853:	d3 e2                	shl    %cl,%edx
  801855:	89 14 24             	mov    %edx,(%esp)
  801858:	89 d8                	mov    %ebx,%eax
  80185a:	d3 e0                	shl    %cl,%eax
  80185c:	89 c2                	mov    %eax,%edx
  80185e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801862:	d3 e0                	shl    %cl,%eax
  801864:	89 44 24 04          	mov    %eax,0x4(%esp)
  801868:	8b 44 24 08          	mov    0x8(%esp),%eax
  80186c:	89 f1                	mov    %esi,%ecx
  80186e:	d3 e8                	shr    %cl,%eax
  801870:	09 d0                	or     %edx,%eax
  801872:	d3 eb                	shr    %cl,%ebx
  801874:	89 da                	mov    %ebx,%edx
  801876:	f7 f7                	div    %edi
  801878:	89 d3                	mov    %edx,%ebx
  80187a:	f7 24 24             	mull   (%esp)
  80187d:	89 c6                	mov    %eax,%esi
  80187f:	89 d1                	mov    %edx,%ecx
  801881:	39 d3                	cmp    %edx,%ebx
  801883:	0f 82 87 00 00 00    	jb     801910 <__umoddi3+0x134>
  801889:	0f 84 91 00 00 00    	je     801920 <__umoddi3+0x144>
  80188f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801893:	29 f2                	sub    %esi,%edx
  801895:	19 cb                	sbb    %ecx,%ebx
  801897:	89 d8                	mov    %ebx,%eax
  801899:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80189d:	d3 e0                	shl    %cl,%eax
  80189f:	89 e9                	mov    %ebp,%ecx
  8018a1:	d3 ea                	shr    %cl,%edx
  8018a3:	09 d0                	or     %edx,%eax
  8018a5:	89 e9                	mov    %ebp,%ecx
  8018a7:	d3 eb                	shr    %cl,%ebx
  8018a9:	89 da                	mov    %ebx,%edx
  8018ab:	83 c4 1c             	add    $0x1c,%esp
  8018ae:	5b                   	pop    %ebx
  8018af:	5e                   	pop    %esi
  8018b0:	5f                   	pop    %edi
  8018b1:	5d                   	pop    %ebp
  8018b2:	c3                   	ret    
  8018b3:	90                   	nop
  8018b4:	89 fd                	mov    %edi,%ebp
  8018b6:	85 ff                	test   %edi,%edi
  8018b8:	75 0b                	jne    8018c5 <__umoddi3+0xe9>
  8018ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8018bf:	31 d2                	xor    %edx,%edx
  8018c1:	f7 f7                	div    %edi
  8018c3:	89 c5                	mov    %eax,%ebp
  8018c5:	89 f0                	mov    %esi,%eax
  8018c7:	31 d2                	xor    %edx,%edx
  8018c9:	f7 f5                	div    %ebp
  8018cb:	89 c8                	mov    %ecx,%eax
  8018cd:	f7 f5                	div    %ebp
  8018cf:	89 d0                	mov    %edx,%eax
  8018d1:	e9 44 ff ff ff       	jmp    80181a <__umoddi3+0x3e>
  8018d6:	66 90                	xchg   %ax,%ax
  8018d8:	89 c8                	mov    %ecx,%eax
  8018da:	89 f2                	mov    %esi,%edx
  8018dc:	83 c4 1c             	add    $0x1c,%esp
  8018df:	5b                   	pop    %ebx
  8018e0:	5e                   	pop    %esi
  8018e1:	5f                   	pop    %edi
  8018e2:	5d                   	pop    %ebp
  8018e3:	c3                   	ret    
  8018e4:	3b 04 24             	cmp    (%esp),%eax
  8018e7:	72 06                	jb     8018ef <__umoddi3+0x113>
  8018e9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018ed:	77 0f                	ja     8018fe <__umoddi3+0x122>
  8018ef:	89 f2                	mov    %esi,%edx
  8018f1:	29 f9                	sub    %edi,%ecx
  8018f3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018f7:	89 14 24             	mov    %edx,(%esp)
  8018fa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018fe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801902:	8b 14 24             	mov    (%esp),%edx
  801905:	83 c4 1c             	add    $0x1c,%esp
  801908:	5b                   	pop    %ebx
  801909:	5e                   	pop    %esi
  80190a:	5f                   	pop    %edi
  80190b:	5d                   	pop    %ebp
  80190c:	c3                   	ret    
  80190d:	8d 76 00             	lea    0x0(%esi),%esi
  801910:	2b 04 24             	sub    (%esp),%eax
  801913:	19 fa                	sbb    %edi,%edx
  801915:	89 d1                	mov    %edx,%ecx
  801917:	89 c6                	mov    %eax,%esi
  801919:	e9 71 ff ff ff       	jmp    80188f <__umoddi3+0xb3>
  80191e:	66 90                	xchg   %ax,%ax
  801920:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801924:	72 ea                	jb     801910 <__umoddi3+0x134>
  801926:	89 d9                	mov    %ebx,%ecx
  801928:	e9 62 ff ff ff       	jmp    80188f <__umoddi3+0xb3>
