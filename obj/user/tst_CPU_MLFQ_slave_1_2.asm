
obj/user/tst_CPU_MLFQ_slave_1_2:     file format elf32-i386


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
  800031:	e8 73 00 00 00       	call   8000a9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 39                	jmp    800080 <_main+0x48>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 04 20 80 00       	mov    0x802004,%eax
  80004c:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800052:	a1 04 20 80 00       	mov    0x802004,%eax
  800057:	8b 40 74             	mov    0x74(%eax),%eax
  80005a:	83 ec 04             	sub    $0x4,%esp
  80005d:	52                   	push   %edx
  80005e:	50                   	push   %eax
  80005f:	68 40 19 80 00       	push   $0x801940
  800064:	e8 61 13 00 00       	call   8013ca <sys_create_env>
  800069:	83 c4 10             	add    $0x10,%esp
  80006c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		sys_run_env(ID);
  80006f:	83 ec 0c             	sub    $0xc,%esp
  800072:	ff 75 f0             	pushl  -0x10(%ebp)
  800075:	e8 6d 13 00 00       	call   8013e7 <sys_run_env>
  80007a:	83 c4 10             	add    $0x10,%esp

void _main(void)
{
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  80007d:	ff 45 f4             	incl   -0xc(%ebp)
  800080:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  800084:	7e c1                	jle    800047 <_main+0xf>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(ID);
	}

	env_sleep(100000);
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 a0 86 01 00       	push   $0x186a0
  80008e:	e8 90 15 00 00       	call   801623 <env_sleep>
  800093:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test CPU SCHEDULING using MLFQ is completed successfully.\n");
  800096:	83 ec 0c             	sub    $0xc,%esp
  800099:	68 50 19 80 00       	push   $0x801950
  80009e:	e8 dc 01 00 00       	call   80027f <cprintf>
  8000a3:	83 c4 10             	add    $0x10,%esp

	return;
  8000a6:	90                   	nop
}
  8000a7:	c9                   	leave  
  8000a8:	c3                   	ret    

008000a9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000a9:	55                   	push   %ebp
  8000aa:	89 e5                	mov    %esp,%ebp
  8000ac:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000af:	e8 f6 0f 00 00       	call   8010aa <sys_getenvindex>
  8000b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ba:	89 d0                	mov    %edx,%eax
  8000bc:	01 c0                	add    %eax,%eax
  8000be:	01 d0                	add    %edx,%eax
  8000c0:	c1 e0 02             	shl    $0x2,%eax
  8000c3:	01 d0                	add    %edx,%eax
  8000c5:	c1 e0 06             	shl    $0x6,%eax
  8000c8:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000cd:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000d2:	a1 04 20 80 00       	mov    0x802004,%eax
  8000d7:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000dd:	84 c0                	test   %al,%al
  8000df:	74 0f                	je     8000f0 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000e1:	a1 04 20 80 00       	mov    0x802004,%eax
  8000e6:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000eb:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000f4:	7e 0a                	jle    800100 <libmain+0x57>
		binaryname = argv[0];
  8000f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f9:	8b 00                	mov    (%eax),%eax
  8000fb:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	ff 75 0c             	pushl  0xc(%ebp)
  800106:	ff 75 08             	pushl  0x8(%ebp)
  800109:	e8 2a ff ff ff       	call   800038 <_main>
  80010e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800111:	e8 2f 11 00 00       	call   801245 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800116:	83 ec 0c             	sub    $0xc,%esp
  800119:	68 b8 19 80 00       	push   $0x8019b8
  80011e:	e8 5c 01 00 00       	call   80027f <cprintf>
  800123:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800126:	a1 04 20 80 00       	mov    0x802004,%eax
  80012b:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800131:	a1 04 20 80 00       	mov    0x802004,%eax
  800136:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80013c:	83 ec 04             	sub    $0x4,%esp
  80013f:	52                   	push   %edx
  800140:	50                   	push   %eax
  800141:	68 e0 19 80 00       	push   $0x8019e0
  800146:	e8 34 01 00 00       	call   80027f <cprintf>
  80014b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80014e:	a1 04 20 80 00       	mov    0x802004,%eax
  800153:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800159:	83 ec 08             	sub    $0x8,%esp
  80015c:	50                   	push   %eax
  80015d:	68 05 1a 80 00       	push   $0x801a05
  800162:	e8 18 01 00 00       	call   80027f <cprintf>
  800167:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	68 b8 19 80 00       	push   $0x8019b8
  800172:	e8 08 01 00 00       	call   80027f <cprintf>
  800177:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80017a:	e8 e0 10 00 00       	call   80125f <sys_enable_interrupt>

	// exit gracefully
	exit();
  80017f:	e8 19 00 00 00       	call   80019d <exit>
}
  800184:	90                   	nop
  800185:	c9                   	leave  
  800186:	c3                   	ret    

00800187 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800187:	55                   	push   %ebp
  800188:	89 e5                	mov    %esp,%ebp
  80018a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80018d:	83 ec 0c             	sub    $0xc,%esp
  800190:	6a 00                	push   $0x0
  800192:	e8 df 0e 00 00       	call   801076 <sys_env_destroy>
  800197:	83 c4 10             	add    $0x10,%esp
}
  80019a:	90                   	nop
  80019b:	c9                   	leave  
  80019c:	c3                   	ret    

0080019d <exit>:

void
exit(void)
{
  80019d:	55                   	push   %ebp
  80019e:	89 e5                	mov    %esp,%ebp
  8001a0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001a3:	e8 34 0f 00 00       	call   8010dc <sys_env_exit>
}
  8001a8:	90                   	nop
  8001a9:	c9                   	leave  
  8001aa:	c3                   	ret    

008001ab <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001ab:	55                   	push   %ebp
  8001ac:	89 e5                	mov    %esp,%ebp
  8001ae:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b4:	8b 00                	mov    (%eax),%eax
  8001b6:	8d 48 01             	lea    0x1(%eax),%ecx
  8001b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001bc:	89 0a                	mov    %ecx,(%edx)
  8001be:	8b 55 08             	mov    0x8(%ebp),%edx
  8001c1:	88 d1                	mov    %dl,%cl
  8001c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001cd:	8b 00                	mov    (%eax),%eax
  8001cf:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001d4:	75 2c                	jne    800202 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001d6:	a0 08 20 80 00       	mov    0x802008,%al
  8001db:	0f b6 c0             	movzbl %al,%eax
  8001de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e1:	8b 12                	mov    (%edx),%edx
  8001e3:	89 d1                	mov    %edx,%ecx
  8001e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e8:	83 c2 08             	add    $0x8,%edx
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	50                   	push   %eax
  8001ef:	51                   	push   %ecx
  8001f0:	52                   	push   %edx
  8001f1:	e8 3e 0e 00 00       	call   801034 <sys_cputs>
  8001f6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800202:	8b 45 0c             	mov    0xc(%ebp),%eax
  800205:	8b 40 04             	mov    0x4(%eax),%eax
  800208:	8d 50 01             	lea    0x1(%eax),%edx
  80020b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800211:	90                   	nop
  800212:	c9                   	leave  
  800213:	c3                   	ret    

00800214 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800214:	55                   	push   %ebp
  800215:	89 e5                	mov    %esp,%ebp
  800217:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80021d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800224:	00 00 00 
	b.cnt = 0;
  800227:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80022e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800231:	ff 75 0c             	pushl  0xc(%ebp)
  800234:	ff 75 08             	pushl  0x8(%ebp)
  800237:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80023d:	50                   	push   %eax
  80023e:	68 ab 01 80 00       	push   $0x8001ab
  800243:	e8 11 02 00 00       	call   800459 <vprintfmt>
  800248:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80024b:	a0 08 20 80 00       	mov    0x802008,%al
  800250:	0f b6 c0             	movzbl %al,%eax
  800253:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800259:	83 ec 04             	sub    $0x4,%esp
  80025c:	50                   	push   %eax
  80025d:	52                   	push   %edx
  80025e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800264:	83 c0 08             	add    $0x8,%eax
  800267:	50                   	push   %eax
  800268:	e8 c7 0d 00 00       	call   801034 <sys_cputs>
  80026d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800270:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800277:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80027d:	c9                   	leave  
  80027e:	c3                   	ret    

0080027f <cprintf>:

int cprintf(const char *fmt, ...) {
  80027f:	55                   	push   %ebp
  800280:	89 e5                	mov    %esp,%ebp
  800282:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800285:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  80028c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80028f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800292:	8b 45 08             	mov    0x8(%ebp),%eax
  800295:	83 ec 08             	sub    $0x8,%esp
  800298:	ff 75 f4             	pushl  -0xc(%ebp)
  80029b:	50                   	push   %eax
  80029c:	e8 73 ff ff ff       	call   800214 <vcprintf>
  8002a1:	83 c4 10             	add    $0x10,%esp
  8002a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002aa:	c9                   	leave  
  8002ab:	c3                   	ret    

008002ac <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002ac:	55                   	push   %ebp
  8002ad:	89 e5                	mov    %esp,%ebp
  8002af:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002b2:	e8 8e 0f 00 00       	call   801245 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002b7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c0:	83 ec 08             	sub    $0x8,%esp
  8002c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c6:	50                   	push   %eax
  8002c7:	e8 48 ff ff ff       	call   800214 <vcprintf>
  8002cc:	83 c4 10             	add    $0x10,%esp
  8002cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002d2:	e8 88 0f 00 00       	call   80125f <sys_enable_interrupt>
	return cnt;
  8002d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002da:	c9                   	leave  
  8002db:	c3                   	ret    

008002dc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002dc:	55                   	push   %ebp
  8002dd:	89 e5                	mov    %esp,%ebp
  8002df:	53                   	push   %ebx
  8002e0:	83 ec 14             	sub    $0x14,%esp
  8002e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8002ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002ef:	8b 45 18             	mov    0x18(%ebp),%eax
  8002f2:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002fa:	77 55                	ja     800351 <printnum+0x75>
  8002fc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002ff:	72 05                	jb     800306 <printnum+0x2a>
  800301:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800304:	77 4b                	ja     800351 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800306:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800309:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80030c:	8b 45 18             	mov    0x18(%ebp),%eax
  80030f:	ba 00 00 00 00       	mov    $0x0,%edx
  800314:	52                   	push   %edx
  800315:	50                   	push   %eax
  800316:	ff 75 f4             	pushl  -0xc(%ebp)
  800319:	ff 75 f0             	pushl  -0x10(%ebp)
  80031c:	e8 b7 13 00 00       	call   8016d8 <__udivdi3>
  800321:	83 c4 10             	add    $0x10,%esp
  800324:	83 ec 04             	sub    $0x4,%esp
  800327:	ff 75 20             	pushl  0x20(%ebp)
  80032a:	53                   	push   %ebx
  80032b:	ff 75 18             	pushl  0x18(%ebp)
  80032e:	52                   	push   %edx
  80032f:	50                   	push   %eax
  800330:	ff 75 0c             	pushl  0xc(%ebp)
  800333:	ff 75 08             	pushl  0x8(%ebp)
  800336:	e8 a1 ff ff ff       	call   8002dc <printnum>
  80033b:	83 c4 20             	add    $0x20,%esp
  80033e:	eb 1a                	jmp    80035a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800340:	83 ec 08             	sub    $0x8,%esp
  800343:	ff 75 0c             	pushl  0xc(%ebp)
  800346:	ff 75 20             	pushl  0x20(%ebp)
  800349:	8b 45 08             	mov    0x8(%ebp),%eax
  80034c:	ff d0                	call   *%eax
  80034e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800351:	ff 4d 1c             	decl   0x1c(%ebp)
  800354:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800358:	7f e6                	jg     800340 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80035a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80035d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800362:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800365:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800368:	53                   	push   %ebx
  800369:	51                   	push   %ecx
  80036a:	52                   	push   %edx
  80036b:	50                   	push   %eax
  80036c:	e8 77 14 00 00       	call   8017e8 <__umoddi3>
  800371:	83 c4 10             	add    $0x10,%esp
  800374:	05 34 1c 80 00       	add    $0x801c34,%eax
  800379:	8a 00                	mov    (%eax),%al
  80037b:	0f be c0             	movsbl %al,%eax
  80037e:	83 ec 08             	sub    $0x8,%esp
  800381:	ff 75 0c             	pushl  0xc(%ebp)
  800384:	50                   	push   %eax
  800385:	8b 45 08             	mov    0x8(%ebp),%eax
  800388:	ff d0                	call   *%eax
  80038a:	83 c4 10             	add    $0x10,%esp
}
  80038d:	90                   	nop
  80038e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800391:	c9                   	leave  
  800392:	c3                   	ret    

00800393 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800393:	55                   	push   %ebp
  800394:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800396:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80039a:	7e 1c                	jle    8003b8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80039c:	8b 45 08             	mov    0x8(%ebp),%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	8d 50 08             	lea    0x8(%eax),%edx
  8003a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a7:	89 10                	mov    %edx,(%eax)
  8003a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ac:	8b 00                	mov    (%eax),%eax
  8003ae:	83 e8 08             	sub    $0x8,%eax
  8003b1:	8b 50 04             	mov    0x4(%eax),%edx
  8003b4:	8b 00                	mov    (%eax),%eax
  8003b6:	eb 40                	jmp    8003f8 <getuint+0x65>
	else if (lflag)
  8003b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003bc:	74 1e                	je     8003dc <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	8b 00                	mov    (%eax),%eax
  8003c3:	8d 50 04             	lea    0x4(%eax),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	89 10                	mov    %edx,(%eax)
  8003cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ce:	8b 00                	mov    (%eax),%eax
  8003d0:	83 e8 04             	sub    $0x4,%eax
  8003d3:	8b 00                	mov    (%eax),%eax
  8003d5:	ba 00 00 00 00       	mov    $0x0,%edx
  8003da:	eb 1c                	jmp    8003f8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003df:	8b 00                	mov    (%eax),%eax
  8003e1:	8d 50 04             	lea    0x4(%eax),%edx
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	89 10                	mov    %edx,(%eax)
  8003e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	83 e8 04             	sub    $0x4,%eax
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003f8:	5d                   	pop    %ebp
  8003f9:	c3                   	ret    

008003fa <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003fa:	55                   	push   %ebp
  8003fb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003fd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800401:	7e 1c                	jle    80041f <getint+0x25>
		return va_arg(*ap, long long);
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	8d 50 08             	lea    0x8(%eax),%edx
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	89 10                	mov    %edx,(%eax)
  800410:	8b 45 08             	mov    0x8(%ebp),%eax
  800413:	8b 00                	mov    (%eax),%eax
  800415:	83 e8 08             	sub    $0x8,%eax
  800418:	8b 50 04             	mov    0x4(%eax),%edx
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	eb 38                	jmp    800457 <getint+0x5d>
	else if (lflag)
  80041f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800423:	74 1a                	je     80043f <getint+0x45>
		return va_arg(*ap, long);
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	8d 50 04             	lea    0x4(%eax),%edx
  80042d:	8b 45 08             	mov    0x8(%ebp),%eax
  800430:	89 10                	mov    %edx,(%eax)
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	8b 00                	mov    (%eax),%eax
  800437:	83 e8 04             	sub    $0x4,%eax
  80043a:	8b 00                	mov    (%eax),%eax
  80043c:	99                   	cltd   
  80043d:	eb 18                	jmp    800457 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	8b 00                	mov    (%eax),%eax
  800444:	8d 50 04             	lea    0x4(%eax),%edx
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	89 10                	mov    %edx,(%eax)
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	83 e8 04             	sub    $0x4,%eax
  800454:	8b 00                	mov    (%eax),%eax
  800456:	99                   	cltd   
}
  800457:	5d                   	pop    %ebp
  800458:	c3                   	ret    

00800459 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800459:	55                   	push   %ebp
  80045a:	89 e5                	mov    %esp,%ebp
  80045c:	56                   	push   %esi
  80045d:	53                   	push   %ebx
  80045e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800461:	eb 17                	jmp    80047a <vprintfmt+0x21>
			if (ch == '\0')
  800463:	85 db                	test   %ebx,%ebx
  800465:	0f 84 af 03 00 00    	je     80081a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80046b:	83 ec 08             	sub    $0x8,%esp
  80046e:	ff 75 0c             	pushl  0xc(%ebp)
  800471:	53                   	push   %ebx
  800472:	8b 45 08             	mov    0x8(%ebp),%eax
  800475:	ff d0                	call   *%eax
  800477:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80047a:	8b 45 10             	mov    0x10(%ebp),%eax
  80047d:	8d 50 01             	lea    0x1(%eax),%edx
  800480:	89 55 10             	mov    %edx,0x10(%ebp)
  800483:	8a 00                	mov    (%eax),%al
  800485:	0f b6 d8             	movzbl %al,%ebx
  800488:	83 fb 25             	cmp    $0x25,%ebx
  80048b:	75 d6                	jne    800463 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80048d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800491:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800498:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80049f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004a6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b0:	8d 50 01             	lea    0x1(%eax),%edx
  8004b3:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b6:	8a 00                	mov    (%eax),%al
  8004b8:	0f b6 d8             	movzbl %al,%ebx
  8004bb:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004be:	83 f8 55             	cmp    $0x55,%eax
  8004c1:	0f 87 2b 03 00 00    	ja     8007f2 <vprintfmt+0x399>
  8004c7:	8b 04 85 58 1c 80 00 	mov    0x801c58(,%eax,4),%eax
  8004ce:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004d0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004d4:	eb d7                	jmp    8004ad <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004d6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004da:	eb d1                	jmp    8004ad <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004dc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004e3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004e6:	89 d0                	mov    %edx,%eax
  8004e8:	c1 e0 02             	shl    $0x2,%eax
  8004eb:	01 d0                	add    %edx,%eax
  8004ed:	01 c0                	add    %eax,%eax
  8004ef:	01 d8                	add    %ebx,%eax
  8004f1:	83 e8 30             	sub    $0x30,%eax
  8004f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fa:	8a 00                	mov    (%eax),%al
  8004fc:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004ff:	83 fb 2f             	cmp    $0x2f,%ebx
  800502:	7e 3e                	jle    800542 <vprintfmt+0xe9>
  800504:	83 fb 39             	cmp    $0x39,%ebx
  800507:	7f 39                	jg     800542 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800509:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80050c:	eb d5                	jmp    8004e3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80050e:	8b 45 14             	mov    0x14(%ebp),%eax
  800511:	83 c0 04             	add    $0x4,%eax
  800514:	89 45 14             	mov    %eax,0x14(%ebp)
  800517:	8b 45 14             	mov    0x14(%ebp),%eax
  80051a:	83 e8 04             	sub    $0x4,%eax
  80051d:	8b 00                	mov    (%eax),%eax
  80051f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800522:	eb 1f                	jmp    800543 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800524:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800528:	79 83                	jns    8004ad <vprintfmt+0x54>
				width = 0;
  80052a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800531:	e9 77 ff ff ff       	jmp    8004ad <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800536:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80053d:	e9 6b ff ff ff       	jmp    8004ad <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800542:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800543:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800547:	0f 89 60 ff ff ff    	jns    8004ad <vprintfmt+0x54>
				width = precision, precision = -1;
  80054d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800553:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80055a:	e9 4e ff ff ff       	jmp    8004ad <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80055f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800562:	e9 46 ff ff ff       	jmp    8004ad <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800567:	8b 45 14             	mov    0x14(%ebp),%eax
  80056a:	83 c0 04             	add    $0x4,%eax
  80056d:	89 45 14             	mov    %eax,0x14(%ebp)
  800570:	8b 45 14             	mov    0x14(%ebp),%eax
  800573:	83 e8 04             	sub    $0x4,%eax
  800576:	8b 00                	mov    (%eax),%eax
  800578:	83 ec 08             	sub    $0x8,%esp
  80057b:	ff 75 0c             	pushl  0xc(%ebp)
  80057e:	50                   	push   %eax
  80057f:	8b 45 08             	mov    0x8(%ebp),%eax
  800582:	ff d0                	call   *%eax
  800584:	83 c4 10             	add    $0x10,%esp
			break;
  800587:	e9 89 02 00 00       	jmp    800815 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80058c:	8b 45 14             	mov    0x14(%ebp),%eax
  80058f:	83 c0 04             	add    $0x4,%eax
  800592:	89 45 14             	mov    %eax,0x14(%ebp)
  800595:	8b 45 14             	mov    0x14(%ebp),%eax
  800598:	83 e8 04             	sub    $0x4,%eax
  80059b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80059d:	85 db                	test   %ebx,%ebx
  80059f:	79 02                	jns    8005a3 <vprintfmt+0x14a>
				err = -err;
  8005a1:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005a3:	83 fb 64             	cmp    $0x64,%ebx
  8005a6:	7f 0b                	jg     8005b3 <vprintfmt+0x15a>
  8005a8:	8b 34 9d a0 1a 80 00 	mov    0x801aa0(,%ebx,4),%esi
  8005af:	85 f6                	test   %esi,%esi
  8005b1:	75 19                	jne    8005cc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005b3:	53                   	push   %ebx
  8005b4:	68 45 1c 80 00       	push   $0x801c45
  8005b9:	ff 75 0c             	pushl  0xc(%ebp)
  8005bc:	ff 75 08             	pushl  0x8(%ebp)
  8005bf:	e8 5e 02 00 00       	call   800822 <printfmt>
  8005c4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005c7:	e9 49 02 00 00       	jmp    800815 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005cc:	56                   	push   %esi
  8005cd:	68 4e 1c 80 00       	push   $0x801c4e
  8005d2:	ff 75 0c             	pushl  0xc(%ebp)
  8005d5:	ff 75 08             	pushl  0x8(%ebp)
  8005d8:	e8 45 02 00 00       	call   800822 <printfmt>
  8005dd:	83 c4 10             	add    $0x10,%esp
			break;
  8005e0:	e9 30 02 00 00       	jmp    800815 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e8:	83 c0 04             	add    $0x4,%eax
  8005eb:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f1:	83 e8 04             	sub    $0x4,%eax
  8005f4:	8b 30                	mov    (%eax),%esi
  8005f6:	85 f6                	test   %esi,%esi
  8005f8:	75 05                	jne    8005ff <vprintfmt+0x1a6>
				p = "(null)";
  8005fa:	be 51 1c 80 00       	mov    $0x801c51,%esi
			if (width > 0 && padc != '-')
  8005ff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800603:	7e 6d                	jle    800672 <vprintfmt+0x219>
  800605:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800609:	74 67                	je     800672 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80060b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060e:	83 ec 08             	sub    $0x8,%esp
  800611:	50                   	push   %eax
  800612:	56                   	push   %esi
  800613:	e8 0c 03 00 00       	call   800924 <strnlen>
  800618:	83 c4 10             	add    $0x10,%esp
  80061b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80061e:	eb 16                	jmp    800636 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800620:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800624:	83 ec 08             	sub    $0x8,%esp
  800627:	ff 75 0c             	pushl  0xc(%ebp)
  80062a:	50                   	push   %eax
  80062b:	8b 45 08             	mov    0x8(%ebp),%eax
  80062e:	ff d0                	call   *%eax
  800630:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800633:	ff 4d e4             	decl   -0x1c(%ebp)
  800636:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80063a:	7f e4                	jg     800620 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80063c:	eb 34                	jmp    800672 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80063e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800642:	74 1c                	je     800660 <vprintfmt+0x207>
  800644:	83 fb 1f             	cmp    $0x1f,%ebx
  800647:	7e 05                	jle    80064e <vprintfmt+0x1f5>
  800649:	83 fb 7e             	cmp    $0x7e,%ebx
  80064c:	7e 12                	jle    800660 <vprintfmt+0x207>
					putch('?', putdat);
  80064e:	83 ec 08             	sub    $0x8,%esp
  800651:	ff 75 0c             	pushl  0xc(%ebp)
  800654:	6a 3f                	push   $0x3f
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	ff d0                	call   *%eax
  80065b:	83 c4 10             	add    $0x10,%esp
  80065e:	eb 0f                	jmp    80066f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	ff 75 0c             	pushl  0xc(%ebp)
  800666:	53                   	push   %ebx
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	ff d0                	call   *%eax
  80066c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80066f:	ff 4d e4             	decl   -0x1c(%ebp)
  800672:	89 f0                	mov    %esi,%eax
  800674:	8d 70 01             	lea    0x1(%eax),%esi
  800677:	8a 00                	mov    (%eax),%al
  800679:	0f be d8             	movsbl %al,%ebx
  80067c:	85 db                	test   %ebx,%ebx
  80067e:	74 24                	je     8006a4 <vprintfmt+0x24b>
  800680:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800684:	78 b8                	js     80063e <vprintfmt+0x1e5>
  800686:	ff 4d e0             	decl   -0x20(%ebp)
  800689:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80068d:	79 af                	jns    80063e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80068f:	eb 13                	jmp    8006a4 <vprintfmt+0x24b>
				putch(' ', putdat);
  800691:	83 ec 08             	sub    $0x8,%esp
  800694:	ff 75 0c             	pushl  0xc(%ebp)
  800697:	6a 20                	push   $0x20
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	ff d0                	call   *%eax
  80069e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a8:	7f e7                	jg     800691 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006aa:	e9 66 01 00 00       	jmp    800815 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006af:	83 ec 08             	sub    $0x8,%esp
  8006b2:	ff 75 e8             	pushl  -0x18(%ebp)
  8006b5:	8d 45 14             	lea    0x14(%ebp),%eax
  8006b8:	50                   	push   %eax
  8006b9:	e8 3c fd ff ff       	call   8003fa <getint>
  8006be:	83 c4 10             	add    $0x10,%esp
  8006c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006cd:	85 d2                	test   %edx,%edx
  8006cf:	79 23                	jns    8006f4 <vprintfmt+0x29b>
				putch('-', putdat);
  8006d1:	83 ec 08             	sub    $0x8,%esp
  8006d4:	ff 75 0c             	pushl  0xc(%ebp)
  8006d7:	6a 2d                	push   $0x2d
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	ff d0                	call   *%eax
  8006de:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e7:	f7 d8                	neg    %eax
  8006e9:	83 d2 00             	adc    $0x0,%edx
  8006ec:	f7 da                	neg    %edx
  8006ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006f4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006fb:	e9 bc 00 00 00       	jmp    8007bc <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800700:	83 ec 08             	sub    $0x8,%esp
  800703:	ff 75 e8             	pushl  -0x18(%ebp)
  800706:	8d 45 14             	lea    0x14(%ebp),%eax
  800709:	50                   	push   %eax
  80070a:	e8 84 fc ff ff       	call   800393 <getuint>
  80070f:	83 c4 10             	add    $0x10,%esp
  800712:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800715:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800718:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80071f:	e9 98 00 00 00       	jmp    8007bc <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800724:	83 ec 08             	sub    $0x8,%esp
  800727:	ff 75 0c             	pushl  0xc(%ebp)
  80072a:	6a 58                	push   $0x58
  80072c:	8b 45 08             	mov    0x8(%ebp),%eax
  80072f:	ff d0                	call   *%eax
  800731:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800734:	83 ec 08             	sub    $0x8,%esp
  800737:	ff 75 0c             	pushl  0xc(%ebp)
  80073a:	6a 58                	push   $0x58
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	ff d0                	call   *%eax
  800741:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	ff 75 0c             	pushl  0xc(%ebp)
  80074a:	6a 58                	push   $0x58
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	ff d0                	call   *%eax
  800751:	83 c4 10             	add    $0x10,%esp
			break;
  800754:	e9 bc 00 00 00       	jmp    800815 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800759:	83 ec 08             	sub    $0x8,%esp
  80075c:	ff 75 0c             	pushl  0xc(%ebp)
  80075f:	6a 30                	push   $0x30
  800761:	8b 45 08             	mov    0x8(%ebp),%eax
  800764:	ff d0                	call   *%eax
  800766:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800769:	83 ec 08             	sub    $0x8,%esp
  80076c:	ff 75 0c             	pushl  0xc(%ebp)
  80076f:	6a 78                	push   $0x78
  800771:	8b 45 08             	mov    0x8(%ebp),%eax
  800774:	ff d0                	call   *%eax
  800776:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800779:	8b 45 14             	mov    0x14(%ebp),%eax
  80077c:	83 c0 04             	add    $0x4,%eax
  80077f:	89 45 14             	mov    %eax,0x14(%ebp)
  800782:	8b 45 14             	mov    0x14(%ebp),%eax
  800785:	83 e8 04             	sub    $0x4,%eax
  800788:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80078a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800794:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80079b:	eb 1f                	jmp    8007bc <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80079d:	83 ec 08             	sub    $0x8,%esp
  8007a0:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a3:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a6:	50                   	push   %eax
  8007a7:	e8 e7 fb ff ff       	call   800393 <getuint>
  8007ac:	83 c4 10             	add    $0x10,%esp
  8007af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007b5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007bc:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007c3:	83 ec 04             	sub    $0x4,%esp
  8007c6:	52                   	push   %edx
  8007c7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007ca:	50                   	push   %eax
  8007cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ce:	ff 75 f0             	pushl  -0x10(%ebp)
  8007d1:	ff 75 0c             	pushl  0xc(%ebp)
  8007d4:	ff 75 08             	pushl  0x8(%ebp)
  8007d7:	e8 00 fb ff ff       	call   8002dc <printnum>
  8007dc:	83 c4 20             	add    $0x20,%esp
			break;
  8007df:	eb 34                	jmp    800815 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007e1:	83 ec 08             	sub    $0x8,%esp
  8007e4:	ff 75 0c             	pushl  0xc(%ebp)
  8007e7:	53                   	push   %ebx
  8007e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007eb:	ff d0                	call   *%eax
  8007ed:	83 c4 10             	add    $0x10,%esp
			break;
  8007f0:	eb 23                	jmp    800815 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007f2:	83 ec 08             	sub    $0x8,%esp
  8007f5:	ff 75 0c             	pushl  0xc(%ebp)
  8007f8:	6a 25                	push   $0x25
  8007fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fd:	ff d0                	call   *%eax
  8007ff:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800802:	ff 4d 10             	decl   0x10(%ebp)
  800805:	eb 03                	jmp    80080a <vprintfmt+0x3b1>
  800807:	ff 4d 10             	decl   0x10(%ebp)
  80080a:	8b 45 10             	mov    0x10(%ebp),%eax
  80080d:	48                   	dec    %eax
  80080e:	8a 00                	mov    (%eax),%al
  800810:	3c 25                	cmp    $0x25,%al
  800812:	75 f3                	jne    800807 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800814:	90                   	nop
		}
	}
  800815:	e9 47 fc ff ff       	jmp    800461 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80081a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80081b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80081e:	5b                   	pop    %ebx
  80081f:	5e                   	pop    %esi
  800820:	5d                   	pop    %ebp
  800821:	c3                   	ret    

00800822 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800822:	55                   	push   %ebp
  800823:	89 e5                	mov    %esp,%ebp
  800825:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800828:	8d 45 10             	lea    0x10(%ebp),%eax
  80082b:	83 c0 04             	add    $0x4,%eax
  80082e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800831:	8b 45 10             	mov    0x10(%ebp),%eax
  800834:	ff 75 f4             	pushl  -0xc(%ebp)
  800837:	50                   	push   %eax
  800838:	ff 75 0c             	pushl  0xc(%ebp)
  80083b:	ff 75 08             	pushl  0x8(%ebp)
  80083e:	e8 16 fc ff ff       	call   800459 <vprintfmt>
  800843:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800846:	90                   	nop
  800847:	c9                   	leave  
  800848:	c3                   	ret    

00800849 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800849:	55                   	push   %ebp
  80084a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80084c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80084f:	8b 40 08             	mov    0x8(%eax),%eax
  800852:	8d 50 01             	lea    0x1(%eax),%edx
  800855:	8b 45 0c             	mov    0xc(%ebp),%eax
  800858:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80085b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085e:	8b 10                	mov    (%eax),%edx
  800860:	8b 45 0c             	mov    0xc(%ebp),%eax
  800863:	8b 40 04             	mov    0x4(%eax),%eax
  800866:	39 c2                	cmp    %eax,%edx
  800868:	73 12                	jae    80087c <sprintputch+0x33>
		*b->buf++ = ch;
  80086a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086d:	8b 00                	mov    (%eax),%eax
  80086f:	8d 48 01             	lea    0x1(%eax),%ecx
  800872:	8b 55 0c             	mov    0xc(%ebp),%edx
  800875:	89 0a                	mov    %ecx,(%edx)
  800877:	8b 55 08             	mov    0x8(%ebp),%edx
  80087a:	88 10                	mov    %dl,(%eax)
}
  80087c:	90                   	nop
  80087d:	5d                   	pop    %ebp
  80087e:	c3                   	ret    

0080087f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80087f:	55                   	push   %ebp
  800880:	89 e5                	mov    %esp,%ebp
  800882:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80088b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800891:	8b 45 08             	mov    0x8(%ebp),%eax
  800894:	01 d0                	add    %edx,%eax
  800896:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800899:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008a4:	74 06                	je     8008ac <vsnprintf+0x2d>
  8008a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008aa:	7f 07                	jg     8008b3 <vsnprintf+0x34>
		return -E_INVAL;
  8008ac:	b8 03 00 00 00       	mov    $0x3,%eax
  8008b1:	eb 20                	jmp    8008d3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008b3:	ff 75 14             	pushl  0x14(%ebp)
  8008b6:	ff 75 10             	pushl  0x10(%ebp)
  8008b9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008bc:	50                   	push   %eax
  8008bd:	68 49 08 80 00       	push   $0x800849
  8008c2:	e8 92 fb ff ff       	call   800459 <vprintfmt>
  8008c7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008cd:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008d3:	c9                   	leave  
  8008d4:	c3                   	ret    

008008d5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008d5:	55                   	push   %ebp
  8008d6:	89 e5                	mov    %esp,%ebp
  8008d8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008db:	8d 45 10             	lea    0x10(%ebp),%eax
  8008de:	83 c0 04             	add    $0x4,%eax
  8008e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ea:	50                   	push   %eax
  8008eb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ee:	ff 75 08             	pushl  0x8(%ebp)
  8008f1:	e8 89 ff ff ff       	call   80087f <vsnprintf>
  8008f6:	83 c4 10             	add    $0x10,%esp
  8008f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008ff:	c9                   	leave  
  800900:	c3                   	ret    

00800901 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800901:	55                   	push   %ebp
  800902:	89 e5                	mov    %esp,%ebp
  800904:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800907:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80090e:	eb 06                	jmp    800916 <strlen+0x15>
		n++;
  800910:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800913:	ff 45 08             	incl   0x8(%ebp)
  800916:	8b 45 08             	mov    0x8(%ebp),%eax
  800919:	8a 00                	mov    (%eax),%al
  80091b:	84 c0                	test   %al,%al
  80091d:	75 f1                	jne    800910 <strlen+0xf>
		n++;
	return n;
  80091f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800922:	c9                   	leave  
  800923:	c3                   	ret    

00800924 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800924:	55                   	push   %ebp
  800925:	89 e5                	mov    %esp,%ebp
  800927:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80092a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800931:	eb 09                	jmp    80093c <strnlen+0x18>
		n++;
  800933:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800936:	ff 45 08             	incl   0x8(%ebp)
  800939:	ff 4d 0c             	decl   0xc(%ebp)
  80093c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800940:	74 09                	je     80094b <strnlen+0x27>
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	8a 00                	mov    (%eax),%al
  800947:	84 c0                	test   %al,%al
  800949:	75 e8                	jne    800933 <strnlen+0xf>
		n++;
	return n;
  80094b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80094e:	c9                   	leave  
  80094f:	c3                   	ret    

00800950 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800950:	55                   	push   %ebp
  800951:	89 e5                	mov    %esp,%ebp
  800953:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800956:	8b 45 08             	mov    0x8(%ebp),%eax
  800959:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80095c:	90                   	nop
  80095d:	8b 45 08             	mov    0x8(%ebp),%eax
  800960:	8d 50 01             	lea    0x1(%eax),%edx
  800963:	89 55 08             	mov    %edx,0x8(%ebp)
  800966:	8b 55 0c             	mov    0xc(%ebp),%edx
  800969:	8d 4a 01             	lea    0x1(%edx),%ecx
  80096c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80096f:	8a 12                	mov    (%edx),%dl
  800971:	88 10                	mov    %dl,(%eax)
  800973:	8a 00                	mov    (%eax),%al
  800975:	84 c0                	test   %al,%al
  800977:	75 e4                	jne    80095d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800979:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097c:	c9                   	leave  
  80097d:	c3                   	ret    

0080097e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80097e:	55                   	push   %ebp
  80097f:	89 e5                	mov    %esp,%ebp
  800981:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80098a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800991:	eb 1f                	jmp    8009b2 <strncpy+0x34>
		*dst++ = *src;
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	8d 50 01             	lea    0x1(%eax),%edx
  800999:	89 55 08             	mov    %edx,0x8(%ebp)
  80099c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099f:	8a 12                	mov    (%edx),%dl
  8009a1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a6:	8a 00                	mov    (%eax),%al
  8009a8:	84 c0                	test   %al,%al
  8009aa:	74 03                	je     8009af <strncpy+0x31>
			src++;
  8009ac:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009af:	ff 45 fc             	incl   -0x4(%ebp)
  8009b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009b5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009b8:	72 d9                	jb     800993 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009bd:	c9                   	leave  
  8009be:	c3                   	ret    

008009bf <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009bf:	55                   	push   %ebp
  8009c0:	89 e5                	mov    %esp,%ebp
  8009c2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009cf:	74 30                	je     800a01 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009d1:	eb 16                	jmp    8009e9 <strlcpy+0x2a>
			*dst++ = *src++;
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	8d 50 01             	lea    0x1(%eax),%edx
  8009d9:	89 55 08             	mov    %edx,0x8(%ebp)
  8009dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009df:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009e2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009e5:	8a 12                	mov    (%edx),%dl
  8009e7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009e9:	ff 4d 10             	decl   0x10(%ebp)
  8009ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009f0:	74 09                	je     8009fb <strlcpy+0x3c>
  8009f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f5:	8a 00                	mov    (%eax),%al
  8009f7:	84 c0                	test   %al,%al
  8009f9:	75 d8                	jne    8009d3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fe:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a01:	8b 55 08             	mov    0x8(%ebp),%edx
  800a04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a07:	29 c2                	sub    %eax,%edx
  800a09:	89 d0                	mov    %edx,%eax
}
  800a0b:	c9                   	leave  
  800a0c:	c3                   	ret    

00800a0d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a0d:	55                   	push   %ebp
  800a0e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a10:	eb 06                	jmp    800a18 <strcmp+0xb>
		p++, q++;
  800a12:	ff 45 08             	incl   0x8(%ebp)
  800a15:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a18:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1b:	8a 00                	mov    (%eax),%al
  800a1d:	84 c0                	test   %al,%al
  800a1f:	74 0e                	je     800a2f <strcmp+0x22>
  800a21:	8b 45 08             	mov    0x8(%ebp),%eax
  800a24:	8a 10                	mov    (%eax),%dl
  800a26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a29:	8a 00                	mov    (%eax),%al
  800a2b:	38 c2                	cmp    %al,%dl
  800a2d:	74 e3                	je     800a12 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a32:	8a 00                	mov    (%eax),%al
  800a34:	0f b6 d0             	movzbl %al,%edx
  800a37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3a:	8a 00                	mov    (%eax),%al
  800a3c:	0f b6 c0             	movzbl %al,%eax
  800a3f:	29 c2                	sub    %eax,%edx
  800a41:	89 d0                	mov    %edx,%eax
}
  800a43:	5d                   	pop    %ebp
  800a44:	c3                   	ret    

00800a45 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a45:	55                   	push   %ebp
  800a46:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a48:	eb 09                	jmp    800a53 <strncmp+0xe>
		n--, p++, q++;
  800a4a:	ff 4d 10             	decl   0x10(%ebp)
  800a4d:	ff 45 08             	incl   0x8(%ebp)
  800a50:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a53:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a57:	74 17                	je     800a70 <strncmp+0x2b>
  800a59:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5c:	8a 00                	mov    (%eax),%al
  800a5e:	84 c0                	test   %al,%al
  800a60:	74 0e                	je     800a70 <strncmp+0x2b>
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	8a 10                	mov    (%eax),%dl
  800a67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6a:	8a 00                	mov    (%eax),%al
  800a6c:	38 c2                	cmp    %al,%dl
  800a6e:	74 da                	je     800a4a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a74:	75 07                	jne    800a7d <strncmp+0x38>
		return 0;
  800a76:	b8 00 00 00 00       	mov    $0x0,%eax
  800a7b:	eb 14                	jmp    800a91 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	8a 00                	mov    (%eax),%al
  800a82:	0f b6 d0             	movzbl %al,%edx
  800a85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a88:	8a 00                	mov    (%eax),%al
  800a8a:	0f b6 c0             	movzbl %al,%eax
  800a8d:	29 c2                	sub    %eax,%edx
  800a8f:	89 d0                	mov    %edx,%eax
}
  800a91:	5d                   	pop    %ebp
  800a92:	c3                   	ret    

00800a93 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a93:	55                   	push   %ebp
  800a94:	89 e5                	mov    %esp,%ebp
  800a96:	83 ec 04             	sub    $0x4,%esp
  800a99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a9f:	eb 12                	jmp    800ab3 <strchr+0x20>
		if (*s == c)
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	8a 00                	mov    (%eax),%al
  800aa6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aa9:	75 05                	jne    800ab0 <strchr+0x1d>
			return (char *) s;
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	eb 11                	jmp    800ac1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ab0:	ff 45 08             	incl   0x8(%ebp)
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	8a 00                	mov    (%eax),%al
  800ab8:	84 c0                	test   %al,%al
  800aba:	75 e5                	jne    800aa1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800abc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ac1:	c9                   	leave  
  800ac2:	c3                   	ret    

00800ac3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ac3:	55                   	push   %ebp
  800ac4:	89 e5                	mov    %esp,%ebp
  800ac6:	83 ec 04             	sub    $0x4,%esp
  800ac9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800acf:	eb 0d                	jmp    800ade <strfind+0x1b>
		if (*s == c)
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	8a 00                	mov    (%eax),%al
  800ad6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad9:	74 0e                	je     800ae9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800adb:	ff 45 08             	incl   0x8(%ebp)
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	8a 00                	mov    (%eax),%al
  800ae3:	84 c0                	test   %al,%al
  800ae5:	75 ea                	jne    800ad1 <strfind+0xe>
  800ae7:	eb 01                	jmp    800aea <strfind+0x27>
		if (*s == c)
			break;
  800ae9:	90                   	nop
	return (char *) s;
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aed:	c9                   	leave  
  800aee:	c3                   	ret    

00800aef <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800aef:	55                   	push   %ebp
  800af0:	89 e5                	mov    %esp,%ebp
  800af2:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800afb:	8b 45 10             	mov    0x10(%ebp),%eax
  800afe:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b01:	eb 0e                	jmp    800b11 <memset+0x22>
		*p++ = c;
  800b03:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b06:	8d 50 01             	lea    0x1(%eax),%edx
  800b09:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b11:	ff 4d f8             	decl   -0x8(%ebp)
  800b14:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b18:	79 e9                	jns    800b03 <memset+0x14>
		*p++ = c;

	return v;
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b1d:	c9                   	leave  
  800b1e:	c3                   	ret    

00800b1f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
  800b22:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b31:	eb 16                	jmp    800b49 <memcpy+0x2a>
		*d++ = *s++;
  800b33:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b36:	8d 50 01             	lea    0x1(%eax),%edx
  800b39:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b3c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b3f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b42:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b45:	8a 12                	mov    (%edx),%dl
  800b47:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b49:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b4f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b52:	85 c0                	test   %eax,%eax
  800b54:	75 dd                	jne    800b33 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b56:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b59:	c9                   	leave  
  800b5a:	c3                   	ret    

00800b5b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b5b:	55                   	push   %ebp
  800b5c:	89 e5                	mov    %esp,%ebp
  800b5e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b64:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b70:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b73:	73 50                	jae    800bc5 <memmove+0x6a>
  800b75:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b78:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7b:	01 d0                	add    %edx,%eax
  800b7d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b80:	76 43                	jbe    800bc5 <memmove+0x6a>
		s += n;
  800b82:	8b 45 10             	mov    0x10(%ebp),%eax
  800b85:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b88:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b8e:	eb 10                	jmp    800ba0 <memmove+0x45>
			*--d = *--s;
  800b90:	ff 4d f8             	decl   -0x8(%ebp)
  800b93:	ff 4d fc             	decl   -0x4(%ebp)
  800b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b99:	8a 10                	mov    (%eax),%dl
  800b9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b9e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ba0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba9:	85 c0                	test   %eax,%eax
  800bab:	75 e3                	jne    800b90 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bad:	eb 23                	jmp    800bd2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800baf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb2:	8d 50 01             	lea    0x1(%eax),%edx
  800bb5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bb8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bbb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bbe:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bc1:	8a 12                	mov    (%edx),%dl
  800bc3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bcb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bce:	85 c0                	test   %eax,%eax
  800bd0:	75 dd                	jne    800baf <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd5:	c9                   	leave  
  800bd6:	c3                   	ret    

00800bd7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bd7:	55                   	push   %ebp
  800bd8:	89 e5                	mov    %esp,%ebp
  800bda:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800be3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800be9:	eb 2a                	jmp    800c15 <memcmp+0x3e>
		if (*s1 != *s2)
  800beb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bee:	8a 10                	mov    (%eax),%dl
  800bf0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf3:	8a 00                	mov    (%eax),%al
  800bf5:	38 c2                	cmp    %al,%dl
  800bf7:	74 16                	je     800c0f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfc:	8a 00                	mov    (%eax),%al
  800bfe:	0f b6 d0             	movzbl %al,%edx
  800c01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c04:	8a 00                	mov    (%eax),%al
  800c06:	0f b6 c0             	movzbl %al,%eax
  800c09:	29 c2                	sub    %eax,%edx
  800c0b:	89 d0                	mov    %edx,%eax
  800c0d:	eb 18                	jmp    800c27 <memcmp+0x50>
		s1++, s2++;
  800c0f:	ff 45 fc             	incl   -0x4(%ebp)
  800c12:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c15:	8b 45 10             	mov    0x10(%ebp),%eax
  800c18:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c1b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c1e:	85 c0                	test   %eax,%eax
  800c20:	75 c9                	jne    800beb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c27:	c9                   	leave  
  800c28:	c3                   	ret    

00800c29 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c2f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c32:	8b 45 10             	mov    0x10(%ebp),%eax
  800c35:	01 d0                	add    %edx,%eax
  800c37:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c3a:	eb 15                	jmp    800c51 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	8a 00                	mov    (%eax),%al
  800c41:	0f b6 d0             	movzbl %al,%edx
  800c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c47:	0f b6 c0             	movzbl %al,%eax
  800c4a:	39 c2                	cmp    %eax,%edx
  800c4c:	74 0d                	je     800c5b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c4e:	ff 45 08             	incl   0x8(%ebp)
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c57:	72 e3                	jb     800c3c <memfind+0x13>
  800c59:	eb 01                	jmp    800c5c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c5b:	90                   	nop
	return (void *) s;
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c5f:	c9                   	leave  
  800c60:	c3                   	ret    

00800c61 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c61:	55                   	push   %ebp
  800c62:	89 e5                	mov    %esp,%ebp
  800c64:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c6e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c75:	eb 03                	jmp    800c7a <strtol+0x19>
		s++;
  800c77:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7d:	8a 00                	mov    (%eax),%al
  800c7f:	3c 20                	cmp    $0x20,%al
  800c81:	74 f4                	je     800c77 <strtol+0x16>
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8a 00                	mov    (%eax),%al
  800c88:	3c 09                	cmp    $0x9,%al
  800c8a:	74 eb                	je     800c77 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	3c 2b                	cmp    $0x2b,%al
  800c93:	75 05                	jne    800c9a <strtol+0x39>
		s++;
  800c95:	ff 45 08             	incl   0x8(%ebp)
  800c98:	eb 13                	jmp    800cad <strtol+0x4c>
	else if (*s == '-')
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8a 00                	mov    (%eax),%al
  800c9f:	3c 2d                	cmp    $0x2d,%al
  800ca1:	75 0a                	jne    800cad <strtol+0x4c>
		s++, neg = 1;
  800ca3:	ff 45 08             	incl   0x8(%ebp)
  800ca6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb1:	74 06                	je     800cb9 <strtol+0x58>
  800cb3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cb7:	75 20                	jne    800cd9 <strtol+0x78>
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	8a 00                	mov    (%eax),%al
  800cbe:	3c 30                	cmp    $0x30,%al
  800cc0:	75 17                	jne    800cd9 <strtol+0x78>
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	40                   	inc    %eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	3c 78                	cmp    $0x78,%al
  800cca:	75 0d                	jne    800cd9 <strtol+0x78>
		s += 2, base = 16;
  800ccc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cd0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cd7:	eb 28                	jmp    800d01 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cd9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cdd:	75 15                	jne    800cf4 <strtol+0x93>
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	8a 00                	mov    (%eax),%al
  800ce4:	3c 30                	cmp    $0x30,%al
  800ce6:	75 0c                	jne    800cf4 <strtol+0x93>
		s++, base = 8;
  800ce8:	ff 45 08             	incl   0x8(%ebp)
  800ceb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cf2:	eb 0d                	jmp    800d01 <strtol+0xa0>
	else if (base == 0)
  800cf4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf8:	75 07                	jne    800d01 <strtol+0xa0>
		base = 10;
  800cfa:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	8a 00                	mov    (%eax),%al
  800d06:	3c 2f                	cmp    $0x2f,%al
  800d08:	7e 19                	jle    800d23 <strtol+0xc2>
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	8a 00                	mov    (%eax),%al
  800d0f:	3c 39                	cmp    $0x39,%al
  800d11:	7f 10                	jg     800d23 <strtol+0xc2>
			dig = *s - '0';
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	0f be c0             	movsbl %al,%eax
  800d1b:	83 e8 30             	sub    $0x30,%eax
  800d1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d21:	eb 42                	jmp    800d65 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	3c 60                	cmp    $0x60,%al
  800d2a:	7e 19                	jle    800d45 <strtol+0xe4>
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	3c 7a                	cmp    $0x7a,%al
  800d33:	7f 10                	jg     800d45 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	0f be c0             	movsbl %al,%eax
  800d3d:	83 e8 57             	sub    $0x57,%eax
  800d40:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d43:	eb 20                	jmp    800d65 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8a 00                	mov    (%eax),%al
  800d4a:	3c 40                	cmp    $0x40,%al
  800d4c:	7e 39                	jle    800d87 <strtol+0x126>
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	8a 00                	mov    (%eax),%al
  800d53:	3c 5a                	cmp    $0x5a,%al
  800d55:	7f 30                	jg     800d87 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	8a 00                	mov    (%eax),%al
  800d5c:	0f be c0             	movsbl %al,%eax
  800d5f:	83 e8 37             	sub    $0x37,%eax
  800d62:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d68:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d6b:	7d 19                	jge    800d86 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d6d:	ff 45 08             	incl   0x8(%ebp)
  800d70:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d73:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d77:	89 c2                	mov    %eax,%edx
  800d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d7c:	01 d0                	add    %edx,%eax
  800d7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d81:	e9 7b ff ff ff       	jmp    800d01 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d86:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d87:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d8b:	74 08                	je     800d95 <strtol+0x134>
		*endptr = (char *) s;
  800d8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d90:	8b 55 08             	mov    0x8(%ebp),%edx
  800d93:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d95:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d99:	74 07                	je     800da2 <strtol+0x141>
  800d9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9e:	f7 d8                	neg    %eax
  800da0:	eb 03                	jmp    800da5 <strtol+0x144>
  800da2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800da5:	c9                   	leave  
  800da6:	c3                   	ret    

00800da7 <ltostr>:

void
ltostr(long value, char *str)
{
  800da7:	55                   	push   %ebp
  800da8:	89 e5                	mov    %esp,%ebp
  800daa:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800db4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dbb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dbf:	79 13                	jns    800dd4 <ltostr+0x2d>
	{
		neg = 1;
  800dc1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dcb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dce:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dd1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ddc:	99                   	cltd   
  800ddd:	f7 f9                	idiv   %ecx
  800ddf:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800de2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de5:	8d 50 01             	lea    0x1(%eax),%edx
  800de8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800deb:	89 c2                	mov    %eax,%edx
  800ded:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df0:	01 d0                	add    %edx,%eax
  800df2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800df5:	83 c2 30             	add    $0x30,%edx
  800df8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dfa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dfd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e02:	f7 e9                	imul   %ecx
  800e04:	c1 fa 02             	sar    $0x2,%edx
  800e07:	89 c8                	mov    %ecx,%eax
  800e09:	c1 f8 1f             	sar    $0x1f,%eax
  800e0c:	29 c2                	sub    %eax,%edx
  800e0e:	89 d0                	mov    %edx,%eax
  800e10:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e13:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e16:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e1b:	f7 e9                	imul   %ecx
  800e1d:	c1 fa 02             	sar    $0x2,%edx
  800e20:	89 c8                	mov    %ecx,%eax
  800e22:	c1 f8 1f             	sar    $0x1f,%eax
  800e25:	29 c2                	sub    %eax,%edx
  800e27:	89 d0                	mov    %edx,%eax
  800e29:	c1 e0 02             	shl    $0x2,%eax
  800e2c:	01 d0                	add    %edx,%eax
  800e2e:	01 c0                	add    %eax,%eax
  800e30:	29 c1                	sub    %eax,%ecx
  800e32:	89 ca                	mov    %ecx,%edx
  800e34:	85 d2                	test   %edx,%edx
  800e36:	75 9c                	jne    800dd4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e42:	48                   	dec    %eax
  800e43:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e46:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e4a:	74 3d                	je     800e89 <ltostr+0xe2>
		start = 1 ;
  800e4c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e53:	eb 34                	jmp    800e89 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e55:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5b:	01 d0                	add    %edx,%eax
  800e5d:	8a 00                	mov    (%eax),%al
  800e5f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e62:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e68:	01 c2                	add    %eax,%edx
  800e6a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e70:	01 c8                	add    %ecx,%eax
  800e72:	8a 00                	mov    (%eax),%al
  800e74:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e76:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7c:	01 c2                	add    %eax,%edx
  800e7e:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e81:	88 02                	mov    %al,(%edx)
		start++ ;
  800e83:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e86:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e8c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e8f:	7c c4                	jl     800e55 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e91:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e97:	01 d0                	add    %edx,%eax
  800e99:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e9c:	90                   	nop
  800e9d:	c9                   	leave  
  800e9e:	c3                   	ret    

00800e9f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e9f:	55                   	push   %ebp
  800ea0:	89 e5                	mov    %esp,%ebp
  800ea2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ea5:	ff 75 08             	pushl  0x8(%ebp)
  800ea8:	e8 54 fa ff ff       	call   800901 <strlen>
  800ead:	83 c4 04             	add    $0x4,%esp
  800eb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	e8 46 fa ff ff       	call   800901 <strlen>
  800ebb:	83 c4 04             	add    $0x4,%esp
  800ebe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ec1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ec8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ecf:	eb 17                	jmp    800ee8 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ed1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed7:	01 c2                	add    %eax,%edx
  800ed9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	01 c8                	add    %ecx,%eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ee5:	ff 45 fc             	incl   -0x4(%ebp)
  800ee8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eeb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eee:	7c e1                	jl     800ed1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ef0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ef7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800efe:	eb 1f                	jmp    800f1f <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f03:	8d 50 01             	lea    0x1(%eax),%edx
  800f06:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f09:	89 c2                	mov    %eax,%edx
  800f0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0e:	01 c2                	add    %eax,%edx
  800f10:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f16:	01 c8                	add    %ecx,%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f1c:	ff 45 f8             	incl   -0x8(%ebp)
  800f1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f25:	7c d9                	jl     800f00 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f27:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2d:	01 d0                	add    %edx,%eax
  800f2f:	c6 00 00             	movb   $0x0,(%eax)
}
  800f32:	90                   	nop
  800f33:	c9                   	leave  
  800f34:	c3                   	ret    

00800f35 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f35:	55                   	push   %ebp
  800f36:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f38:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f41:	8b 45 14             	mov    0x14(%ebp),%eax
  800f44:	8b 00                	mov    (%eax),%eax
  800f46:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f50:	01 d0                	add    %edx,%eax
  800f52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f58:	eb 0c                	jmp    800f66 <strsplit+0x31>
			*string++ = 0;
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5d:	8d 50 01             	lea    0x1(%eax),%edx
  800f60:	89 55 08             	mov    %edx,0x8(%ebp)
  800f63:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	84 c0                	test   %al,%al
  800f6d:	74 18                	je     800f87 <strsplit+0x52>
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	0f be c0             	movsbl %al,%eax
  800f77:	50                   	push   %eax
  800f78:	ff 75 0c             	pushl  0xc(%ebp)
  800f7b:	e8 13 fb ff ff       	call   800a93 <strchr>
  800f80:	83 c4 08             	add    $0x8,%esp
  800f83:	85 c0                	test   %eax,%eax
  800f85:	75 d3                	jne    800f5a <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	8a 00                	mov    (%eax),%al
  800f8c:	84 c0                	test   %al,%al
  800f8e:	74 5a                	je     800fea <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f90:	8b 45 14             	mov    0x14(%ebp),%eax
  800f93:	8b 00                	mov    (%eax),%eax
  800f95:	83 f8 0f             	cmp    $0xf,%eax
  800f98:	75 07                	jne    800fa1 <strsplit+0x6c>
		{
			return 0;
  800f9a:	b8 00 00 00 00       	mov    $0x0,%eax
  800f9f:	eb 66                	jmp    801007 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fa1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa4:	8b 00                	mov    (%eax),%eax
  800fa6:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa9:	8b 55 14             	mov    0x14(%ebp),%edx
  800fac:	89 0a                	mov    %ecx,(%edx)
  800fae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb8:	01 c2                	add    %eax,%edx
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fbf:	eb 03                	jmp    800fc4 <strsplit+0x8f>
			string++;
  800fc1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc7:	8a 00                	mov    (%eax),%al
  800fc9:	84 c0                	test   %al,%al
  800fcb:	74 8b                	je     800f58 <strsplit+0x23>
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	8a 00                	mov    (%eax),%al
  800fd2:	0f be c0             	movsbl %al,%eax
  800fd5:	50                   	push   %eax
  800fd6:	ff 75 0c             	pushl  0xc(%ebp)
  800fd9:	e8 b5 fa ff ff       	call   800a93 <strchr>
  800fde:	83 c4 08             	add    $0x8,%esp
  800fe1:	85 c0                	test   %eax,%eax
  800fe3:	74 dc                	je     800fc1 <strsplit+0x8c>
			string++;
	}
  800fe5:	e9 6e ff ff ff       	jmp    800f58 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fea:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800feb:	8b 45 14             	mov    0x14(%ebp),%eax
  800fee:	8b 00                	mov    (%eax),%eax
  800ff0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff7:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffa:	01 d0                	add    %edx,%eax
  800ffc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801002:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801007:	c9                   	leave  
  801008:	c3                   	ret    

00801009 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801009:	55                   	push   %ebp
  80100a:	89 e5                	mov    %esp,%ebp
  80100c:	57                   	push   %edi
  80100d:	56                   	push   %esi
  80100e:	53                   	push   %ebx
  80100f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	8b 55 0c             	mov    0xc(%ebp),%edx
  801018:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80101b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80101e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801021:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801024:	cd 30                	int    $0x30
  801026:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801029:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80102c:	83 c4 10             	add    $0x10,%esp
  80102f:	5b                   	pop    %ebx
  801030:	5e                   	pop    %esi
  801031:	5f                   	pop    %edi
  801032:	5d                   	pop    %ebp
  801033:	c3                   	ret    

00801034 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801034:	55                   	push   %ebp
  801035:	89 e5                	mov    %esp,%ebp
  801037:	83 ec 04             	sub    $0x4,%esp
  80103a:	8b 45 10             	mov    0x10(%ebp),%eax
  80103d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801040:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	6a 00                	push   $0x0
  801049:	6a 00                	push   $0x0
  80104b:	52                   	push   %edx
  80104c:	ff 75 0c             	pushl  0xc(%ebp)
  80104f:	50                   	push   %eax
  801050:	6a 00                	push   $0x0
  801052:	e8 b2 ff ff ff       	call   801009 <syscall>
  801057:	83 c4 18             	add    $0x18,%esp
}
  80105a:	90                   	nop
  80105b:	c9                   	leave  
  80105c:	c3                   	ret    

0080105d <sys_cgetc>:

int
sys_cgetc(void)
{
  80105d:	55                   	push   %ebp
  80105e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801060:	6a 00                	push   $0x0
  801062:	6a 00                	push   $0x0
  801064:	6a 00                	push   $0x0
  801066:	6a 00                	push   $0x0
  801068:	6a 00                	push   $0x0
  80106a:	6a 01                	push   $0x1
  80106c:	e8 98 ff ff ff       	call   801009 <syscall>
  801071:	83 c4 18             	add    $0x18,%esp
}
  801074:	c9                   	leave  
  801075:	c3                   	ret    

00801076 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801076:	55                   	push   %ebp
  801077:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	6a 00                	push   $0x0
  80107e:	6a 00                	push   $0x0
  801080:	6a 00                	push   $0x0
  801082:	6a 00                	push   $0x0
  801084:	50                   	push   %eax
  801085:	6a 05                	push   $0x5
  801087:	e8 7d ff ff ff       	call   801009 <syscall>
  80108c:	83 c4 18             	add    $0x18,%esp
}
  80108f:	c9                   	leave  
  801090:	c3                   	ret    

00801091 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801091:	55                   	push   %ebp
  801092:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 00                	push   $0x0
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	6a 02                	push   $0x2
  8010a0:	e8 64 ff ff ff       	call   801009 <syscall>
  8010a5:	83 c4 18             	add    $0x18,%esp
}
  8010a8:	c9                   	leave  
  8010a9:	c3                   	ret    

008010aa <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010aa:	55                   	push   %ebp
  8010ab:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 00                	push   $0x0
  8010b3:	6a 00                	push   $0x0
  8010b5:	6a 00                	push   $0x0
  8010b7:	6a 03                	push   $0x3
  8010b9:	e8 4b ff ff ff       	call   801009 <syscall>
  8010be:	83 c4 18             	add    $0x18,%esp
}
  8010c1:	c9                   	leave  
  8010c2:	c3                   	ret    

008010c3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010c3:	55                   	push   %ebp
  8010c4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 00                	push   $0x0
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 00                	push   $0x0
  8010d0:	6a 04                	push   $0x4
  8010d2:	e8 32 ff ff ff       	call   801009 <syscall>
  8010d7:	83 c4 18             	add    $0x18,%esp
}
  8010da:	c9                   	leave  
  8010db:	c3                   	ret    

008010dc <sys_env_exit>:


void sys_env_exit(void)
{
  8010dc:	55                   	push   %ebp
  8010dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010df:	6a 00                	push   $0x0
  8010e1:	6a 00                	push   $0x0
  8010e3:	6a 00                	push   $0x0
  8010e5:	6a 00                	push   $0x0
  8010e7:	6a 00                	push   $0x0
  8010e9:	6a 06                	push   $0x6
  8010eb:	e8 19 ff ff ff       	call   801009 <syscall>
  8010f0:	83 c4 18             	add    $0x18,%esp
}
  8010f3:	90                   	nop
  8010f4:	c9                   	leave  
  8010f5:	c3                   	ret    

008010f6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010f6:	55                   	push   %ebp
  8010f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	6a 00                	push   $0x0
  801101:	6a 00                	push   $0x0
  801103:	6a 00                	push   $0x0
  801105:	52                   	push   %edx
  801106:	50                   	push   %eax
  801107:	6a 07                	push   $0x7
  801109:	e8 fb fe ff ff       	call   801009 <syscall>
  80110e:	83 c4 18             	add    $0x18,%esp
}
  801111:	c9                   	leave  
  801112:	c3                   	ret    

00801113 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	56                   	push   %esi
  801117:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801118:	8b 75 18             	mov    0x18(%ebp),%esi
  80111b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80111e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801121:	8b 55 0c             	mov    0xc(%ebp),%edx
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	56                   	push   %esi
  801128:	53                   	push   %ebx
  801129:	51                   	push   %ecx
  80112a:	52                   	push   %edx
  80112b:	50                   	push   %eax
  80112c:	6a 08                	push   $0x8
  80112e:	e8 d6 fe ff ff       	call   801009 <syscall>
  801133:	83 c4 18             	add    $0x18,%esp
}
  801136:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801139:	5b                   	pop    %ebx
  80113a:	5e                   	pop    %esi
  80113b:	5d                   	pop    %ebp
  80113c:	c3                   	ret    

0080113d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80113d:	55                   	push   %ebp
  80113e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801140:	8b 55 0c             	mov    0xc(%ebp),%edx
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
  801146:	6a 00                	push   $0x0
  801148:	6a 00                	push   $0x0
  80114a:	6a 00                	push   $0x0
  80114c:	52                   	push   %edx
  80114d:	50                   	push   %eax
  80114e:	6a 09                	push   $0x9
  801150:	e8 b4 fe ff ff       	call   801009 <syscall>
  801155:	83 c4 18             	add    $0x18,%esp
}
  801158:	c9                   	leave  
  801159:	c3                   	ret    

0080115a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80115a:	55                   	push   %ebp
  80115b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80115d:	6a 00                	push   $0x0
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	ff 75 0c             	pushl  0xc(%ebp)
  801166:	ff 75 08             	pushl  0x8(%ebp)
  801169:	6a 0a                	push   $0xa
  80116b:	e8 99 fe ff ff       	call   801009 <syscall>
  801170:	83 c4 18             	add    $0x18,%esp
}
  801173:	c9                   	leave  
  801174:	c3                   	ret    

00801175 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801175:	55                   	push   %ebp
  801176:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 00                	push   $0x0
  80117e:	6a 00                	push   $0x0
  801180:	6a 00                	push   $0x0
  801182:	6a 0b                	push   $0xb
  801184:	e8 80 fe ff ff       	call   801009 <syscall>
  801189:	83 c4 18             	add    $0x18,%esp
}
  80118c:	c9                   	leave  
  80118d:	c3                   	ret    

0080118e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80118e:	55                   	push   %ebp
  80118f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 00                	push   $0x0
  801197:	6a 00                	push   $0x0
  801199:	6a 00                	push   $0x0
  80119b:	6a 0c                	push   $0xc
  80119d:	e8 67 fe ff ff       	call   801009 <syscall>
  8011a2:	83 c4 18             	add    $0x18,%esp
}
  8011a5:	c9                   	leave  
  8011a6:	c3                   	ret    

008011a7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011a7:	55                   	push   %ebp
  8011a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 00                	push   $0x0
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 00                	push   $0x0
  8011b4:	6a 0d                	push   $0xd
  8011b6:	e8 4e fe ff ff       	call   801009 <syscall>
  8011bb:	83 c4 18             	add    $0x18,%esp
}
  8011be:	c9                   	leave  
  8011bf:	c3                   	ret    

008011c0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011c0:	55                   	push   %ebp
  8011c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 00                	push   $0x0
  8011c9:	ff 75 0c             	pushl  0xc(%ebp)
  8011cc:	ff 75 08             	pushl  0x8(%ebp)
  8011cf:	6a 11                	push   $0x11
  8011d1:	e8 33 fe ff ff       	call   801009 <syscall>
  8011d6:	83 c4 18             	add    $0x18,%esp
	return;
  8011d9:	90                   	nop
}
  8011da:	c9                   	leave  
  8011db:	c3                   	ret    

008011dc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011dc:	55                   	push   %ebp
  8011dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	ff 75 0c             	pushl  0xc(%ebp)
  8011e8:	ff 75 08             	pushl  0x8(%ebp)
  8011eb:	6a 12                	push   $0x12
  8011ed:	e8 17 fe ff ff       	call   801009 <syscall>
  8011f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8011f5:	90                   	nop
}
  8011f6:	c9                   	leave  
  8011f7:	c3                   	ret    

008011f8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011f8:	55                   	push   %ebp
  8011f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	6a 0e                	push   $0xe
  801207:	e8 fd fd ff ff       	call   801009 <syscall>
  80120c:	83 c4 18             	add    $0x18,%esp
}
  80120f:	c9                   	leave  
  801210:	c3                   	ret    

00801211 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801211:	55                   	push   %ebp
  801212:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801214:	6a 00                	push   $0x0
  801216:	6a 00                	push   $0x0
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	ff 75 08             	pushl  0x8(%ebp)
  80121f:	6a 0f                	push   $0xf
  801221:	e8 e3 fd ff ff       	call   801009 <syscall>
  801226:	83 c4 18             	add    $0x18,%esp
}
  801229:	c9                   	leave  
  80122a:	c3                   	ret    

0080122b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80122b:	55                   	push   %ebp
  80122c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80122e:	6a 00                	push   $0x0
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	6a 00                	push   $0x0
  801238:	6a 10                	push   $0x10
  80123a:	e8 ca fd ff ff       	call   801009 <syscall>
  80123f:	83 c4 18             	add    $0x18,%esp
}
  801242:	90                   	nop
  801243:	c9                   	leave  
  801244:	c3                   	ret    

00801245 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801245:	55                   	push   %ebp
  801246:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 14                	push   $0x14
  801254:	e8 b0 fd ff ff       	call   801009 <syscall>
  801259:	83 c4 18             	add    $0x18,%esp
}
  80125c:	90                   	nop
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801262:	6a 00                	push   $0x0
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 15                	push   $0x15
  80126e:	e8 96 fd ff ff       	call   801009 <syscall>
  801273:	83 c4 18             	add    $0x18,%esp
}
  801276:	90                   	nop
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <sys_cputc>:


void
sys_cputc(const char c)
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
  80127c:	83 ec 04             	sub    $0x4,%esp
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801285:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	50                   	push   %eax
  801292:	6a 16                	push   $0x16
  801294:	e8 70 fd ff ff       	call   801009 <syscall>
  801299:	83 c4 18             	add    $0x18,%esp
}
  80129c:	90                   	nop
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 17                	push   $0x17
  8012ae:	e8 56 fd ff ff       	call   801009 <syscall>
  8012b3:	83 c4 18             	add    $0x18,%esp
}
  8012b6:	90                   	nop
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	ff 75 0c             	pushl  0xc(%ebp)
  8012c8:	50                   	push   %eax
  8012c9:	6a 18                	push   $0x18
  8012cb:	e8 39 fd ff ff       	call   801009 <syscall>
  8012d0:	83 c4 18             	add    $0x18,%esp
}
  8012d3:	c9                   	leave  
  8012d4:	c3                   	ret    

008012d5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012d5:	55                   	push   %ebp
  8012d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 00                	push   $0x0
  8012e4:	52                   	push   %edx
  8012e5:	50                   	push   %eax
  8012e6:	6a 1b                	push   $0x1b
  8012e8:	e8 1c fd ff ff       	call   801009 <syscall>
  8012ed:	83 c4 18             	add    $0x18,%esp
}
  8012f0:	c9                   	leave  
  8012f1:	c3                   	ret    

008012f2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012f2:	55                   	push   %ebp
  8012f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	6a 00                	push   $0x0
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	52                   	push   %edx
  801302:	50                   	push   %eax
  801303:	6a 19                	push   $0x19
  801305:	e8 ff fc ff ff       	call   801009 <syscall>
  80130a:	83 c4 18             	add    $0x18,%esp
}
  80130d:	90                   	nop
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801313:	8b 55 0c             	mov    0xc(%ebp),%edx
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	52                   	push   %edx
  801320:	50                   	push   %eax
  801321:	6a 1a                	push   $0x1a
  801323:	e8 e1 fc ff ff       	call   801009 <syscall>
  801328:	83 c4 18             	add    $0x18,%esp
}
  80132b:	90                   	nop
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
  801331:	83 ec 04             	sub    $0x4,%esp
  801334:	8b 45 10             	mov    0x10(%ebp),%eax
  801337:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80133a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80133d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	6a 00                	push   $0x0
  801346:	51                   	push   %ecx
  801347:	52                   	push   %edx
  801348:	ff 75 0c             	pushl  0xc(%ebp)
  80134b:	50                   	push   %eax
  80134c:	6a 1c                	push   $0x1c
  80134e:	e8 b6 fc ff ff       	call   801009 <syscall>
  801353:	83 c4 18             	add    $0x18,%esp
}
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80135b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	52                   	push   %edx
  801368:	50                   	push   %eax
  801369:	6a 1d                	push   $0x1d
  80136b:	e8 99 fc ff ff       	call   801009 <syscall>
  801370:	83 c4 18             	add    $0x18,%esp
}
  801373:	c9                   	leave  
  801374:	c3                   	ret    

00801375 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801375:	55                   	push   %ebp
  801376:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801378:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80137b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	51                   	push   %ecx
  801386:	52                   	push   %edx
  801387:	50                   	push   %eax
  801388:	6a 1e                	push   $0x1e
  80138a:	e8 7a fc ff ff       	call   801009 <syscall>
  80138f:	83 c4 18             	add    $0x18,%esp
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801397:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	52                   	push   %edx
  8013a4:	50                   	push   %eax
  8013a5:	6a 1f                	push   $0x1f
  8013a7:	e8 5d fc ff ff       	call   801009 <syscall>
  8013ac:	83 c4 18             	add    $0x18,%esp
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 20                	push   $0x20
  8013c0:	e8 44 fc ff ff       	call   801009 <syscall>
  8013c5:	83 c4 18             	add    $0x18,%esp
}
  8013c8:	c9                   	leave  
  8013c9:	c3                   	ret    

008013ca <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	ff 75 10             	pushl  0x10(%ebp)
  8013d7:	ff 75 0c             	pushl  0xc(%ebp)
  8013da:	50                   	push   %eax
  8013db:	6a 21                	push   $0x21
  8013dd:	e8 27 fc ff ff       	call   801009 <syscall>
  8013e2:	83 c4 18             	add    $0x18,%esp
}
  8013e5:	c9                   	leave  
  8013e6:	c3                   	ret    

008013e7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013e7:	55                   	push   %ebp
  8013e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	50                   	push   %eax
  8013f6:	6a 22                	push   $0x22
  8013f8:	e8 0c fc ff ff       	call   801009 <syscall>
  8013fd:	83 c4 18             	add    $0x18,%esp
}
  801400:	90                   	nop
  801401:	c9                   	leave  
  801402:	c3                   	ret    

00801403 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801403:	55                   	push   %ebp
  801404:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	50                   	push   %eax
  801412:	6a 23                	push   $0x23
  801414:	e8 f0 fb ff ff       	call   801009 <syscall>
  801419:	83 c4 18             	add    $0x18,%esp
}
  80141c:	90                   	nop
  80141d:	c9                   	leave  
  80141e:	c3                   	ret    

0080141f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80141f:	55                   	push   %ebp
  801420:	89 e5                	mov    %esp,%ebp
  801422:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801425:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801428:	8d 50 04             	lea    0x4(%eax),%edx
  80142b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	52                   	push   %edx
  801435:	50                   	push   %eax
  801436:	6a 24                	push   $0x24
  801438:	e8 cc fb ff ff       	call   801009 <syscall>
  80143d:	83 c4 18             	add    $0x18,%esp
	return result;
  801440:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801443:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801446:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801449:	89 01                	mov    %eax,(%ecx)
  80144b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	c9                   	leave  
  801452:	c2 04 00             	ret    $0x4

00801455 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801455:	55                   	push   %ebp
  801456:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	ff 75 10             	pushl  0x10(%ebp)
  80145f:	ff 75 0c             	pushl  0xc(%ebp)
  801462:	ff 75 08             	pushl  0x8(%ebp)
  801465:	6a 13                	push   $0x13
  801467:	e8 9d fb ff ff       	call   801009 <syscall>
  80146c:	83 c4 18             	add    $0x18,%esp
	return ;
  80146f:	90                   	nop
}
  801470:	c9                   	leave  
  801471:	c3                   	ret    

00801472 <sys_rcr2>:
uint32 sys_rcr2()
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 25                	push   $0x25
  801481:	e8 83 fb ff ff       	call   801009 <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
}
  801489:	c9                   	leave  
  80148a:	c3                   	ret    

0080148b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80148b:	55                   	push   %ebp
  80148c:	89 e5                	mov    %esp,%ebp
  80148e:	83 ec 04             	sub    $0x4,%esp
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801497:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	50                   	push   %eax
  8014a4:	6a 26                	push   $0x26
  8014a6:	e8 5e fb ff ff       	call   801009 <syscall>
  8014ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ae:	90                   	nop
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <rsttst>:
void rsttst()
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 28                	push   $0x28
  8014c0:	e8 44 fb ff ff       	call   801009 <syscall>
  8014c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c8:	90                   	nop
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
  8014ce:	83 ec 04             	sub    $0x4,%esp
  8014d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014d7:	8b 55 18             	mov    0x18(%ebp),%edx
  8014da:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014de:	52                   	push   %edx
  8014df:	50                   	push   %eax
  8014e0:	ff 75 10             	pushl  0x10(%ebp)
  8014e3:	ff 75 0c             	pushl  0xc(%ebp)
  8014e6:	ff 75 08             	pushl  0x8(%ebp)
  8014e9:	6a 27                	push   $0x27
  8014eb:	e8 19 fb ff ff       	call   801009 <syscall>
  8014f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f3:	90                   	nop
}
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <chktst>:
void chktst(uint32 n)
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	ff 75 08             	pushl  0x8(%ebp)
  801504:	6a 29                	push   $0x29
  801506:	e8 fe fa ff ff       	call   801009 <syscall>
  80150b:	83 c4 18             	add    $0x18,%esp
	return ;
  80150e:	90                   	nop
}
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <inctst>:

void inctst()
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 2a                	push   $0x2a
  801520:	e8 e4 fa ff ff       	call   801009 <syscall>
  801525:	83 c4 18             	add    $0x18,%esp
	return ;
  801528:	90                   	nop
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <gettst>:
uint32 gettst()
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 2b                	push   $0x2b
  80153a:	e8 ca fa ff ff       	call   801009 <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
}
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
  801547:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 2c                	push   $0x2c
  801556:	e8 ae fa ff ff       	call   801009 <syscall>
  80155b:	83 c4 18             	add    $0x18,%esp
  80155e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801561:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801565:	75 07                	jne    80156e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801567:	b8 01 00 00 00       	mov    $0x1,%eax
  80156c:	eb 05                	jmp    801573 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80156e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
  801578:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 2c                	push   $0x2c
  801587:	e8 7d fa ff ff       	call   801009 <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
  80158f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801592:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801596:	75 07                	jne    80159f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801598:	b8 01 00 00 00       	mov    $0x1,%eax
  80159d:	eb 05                	jmp    8015a4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80159f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
  8015a9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 2c                	push   $0x2c
  8015b8:	e8 4c fa ff ff       	call   801009 <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
  8015c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015c3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015c7:	75 07                	jne    8015d0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ce:	eb 05                	jmp    8015d5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
  8015da:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 2c                	push   $0x2c
  8015e9:	e8 1b fa ff ff       	call   801009 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
  8015f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015f4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015f8:	75 07                	jne    801601 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ff:	eb 05                	jmp    801606 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801601:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	ff 75 08             	pushl  0x8(%ebp)
  801616:	6a 2d                	push   $0x2d
  801618:	e8 ec f9 ff ff       	call   801009 <syscall>
  80161d:	83 c4 18             	add    $0x18,%esp
	return ;
  801620:	90                   	nop
}
  801621:	c9                   	leave  
  801622:	c3                   	ret    

00801623 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801623:	55                   	push   %ebp
  801624:	89 e5                	mov    %esp,%ebp
  801626:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801629:	8b 55 08             	mov    0x8(%ebp),%edx
  80162c:	89 d0                	mov    %edx,%eax
  80162e:	c1 e0 02             	shl    $0x2,%eax
  801631:	01 d0                	add    %edx,%eax
  801633:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80163a:	01 d0                	add    %edx,%eax
  80163c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801643:	01 d0                	add    %edx,%eax
  801645:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80164c:	01 d0                	add    %edx,%eax
  80164e:	c1 e0 04             	shl    $0x4,%eax
  801651:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801654:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80165b:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80165e:	83 ec 0c             	sub    $0xc,%esp
  801661:	50                   	push   %eax
  801662:	e8 b8 fd ff ff       	call   80141f <sys_get_virtual_time>
  801667:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80166a:	eb 41                	jmp    8016ad <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80166c:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80166f:	83 ec 0c             	sub    $0xc,%esp
  801672:	50                   	push   %eax
  801673:	e8 a7 fd ff ff       	call   80141f <sys_get_virtual_time>
  801678:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80167b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80167e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801681:	29 c2                	sub    %eax,%edx
  801683:	89 d0                	mov    %edx,%eax
  801685:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801688:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80168b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80168e:	89 d1                	mov    %edx,%ecx
  801690:	29 c1                	sub    %eax,%ecx
  801692:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801695:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801698:	39 c2                	cmp    %eax,%edx
  80169a:	0f 97 c0             	seta   %al
  80169d:	0f b6 c0             	movzbl %al,%eax
  8016a0:	29 c1                	sub    %eax,%ecx
  8016a2:	89 c8                	mov    %ecx,%eax
  8016a4:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8016a7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8016aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8016ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016b3:	72 b7                	jb     80166c <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8016b5:	90                   	nop
  8016b6:	c9                   	leave  
  8016b7:	c3                   	ret    

008016b8 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8016b8:	55                   	push   %ebp
  8016b9:	89 e5                	mov    %esp,%ebp
  8016bb:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8016be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8016c5:	eb 03                	jmp    8016ca <busy_wait+0x12>
  8016c7:	ff 45 fc             	incl   -0x4(%ebp)
  8016ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016cd:	3b 45 08             	cmp    0x8(%ebp),%eax
  8016d0:	72 f5                	jb     8016c7 <busy_wait+0xf>
	return i;
  8016d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016d5:	c9                   	leave  
  8016d6:	c3                   	ret    
  8016d7:	90                   	nop

008016d8 <__udivdi3>:
  8016d8:	55                   	push   %ebp
  8016d9:	57                   	push   %edi
  8016da:	56                   	push   %esi
  8016db:	53                   	push   %ebx
  8016dc:	83 ec 1c             	sub    $0x1c,%esp
  8016df:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016e3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016ef:	89 ca                	mov    %ecx,%edx
  8016f1:	89 f8                	mov    %edi,%eax
  8016f3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016f7:	85 f6                	test   %esi,%esi
  8016f9:	75 2d                	jne    801728 <__udivdi3+0x50>
  8016fb:	39 cf                	cmp    %ecx,%edi
  8016fd:	77 65                	ja     801764 <__udivdi3+0x8c>
  8016ff:	89 fd                	mov    %edi,%ebp
  801701:	85 ff                	test   %edi,%edi
  801703:	75 0b                	jne    801710 <__udivdi3+0x38>
  801705:	b8 01 00 00 00       	mov    $0x1,%eax
  80170a:	31 d2                	xor    %edx,%edx
  80170c:	f7 f7                	div    %edi
  80170e:	89 c5                	mov    %eax,%ebp
  801710:	31 d2                	xor    %edx,%edx
  801712:	89 c8                	mov    %ecx,%eax
  801714:	f7 f5                	div    %ebp
  801716:	89 c1                	mov    %eax,%ecx
  801718:	89 d8                	mov    %ebx,%eax
  80171a:	f7 f5                	div    %ebp
  80171c:	89 cf                	mov    %ecx,%edi
  80171e:	89 fa                	mov    %edi,%edx
  801720:	83 c4 1c             	add    $0x1c,%esp
  801723:	5b                   	pop    %ebx
  801724:	5e                   	pop    %esi
  801725:	5f                   	pop    %edi
  801726:	5d                   	pop    %ebp
  801727:	c3                   	ret    
  801728:	39 ce                	cmp    %ecx,%esi
  80172a:	77 28                	ja     801754 <__udivdi3+0x7c>
  80172c:	0f bd fe             	bsr    %esi,%edi
  80172f:	83 f7 1f             	xor    $0x1f,%edi
  801732:	75 40                	jne    801774 <__udivdi3+0x9c>
  801734:	39 ce                	cmp    %ecx,%esi
  801736:	72 0a                	jb     801742 <__udivdi3+0x6a>
  801738:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80173c:	0f 87 9e 00 00 00    	ja     8017e0 <__udivdi3+0x108>
  801742:	b8 01 00 00 00       	mov    $0x1,%eax
  801747:	89 fa                	mov    %edi,%edx
  801749:	83 c4 1c             	add    $0x1c,%esp
  80174c:	5b                   	pop    %ebx
  80174d:	5e                   	pop    %esi
  80174e:	5f                   	pop    %edi
  80174f:	5d                   	pop    %ebp
  801750:	c3                   	ret    
  801751:	8d 76 00             	lea    0x0(%esi),%esi
  801754:	31 ff                	xor    %edi,%edi
  801756:	31 c0                	xor    %eax,%eax
  801758:	89 fa                	mov    %edi,%edx
  80175a:	83 c4 1c             	add    $0x1c,%esp
  80175d:	5b                   	pop    %ebx
  80175e:	5e                   	pop    %esi
  80175f:	5f                   	pop    %edi
  801760:	5d                   	pop    %ebp
  801761:	c3                   	ret    
  801762:	66 90                	xchg   %ax,%ax
  801764:	89 d8                	mov    %ebx,%eax
  801766:	f7 f7                	div    %edi
  801768:	31 ff                	xor    %edi,%edi
  80176a:	89 fa                	mov    %edi,%edx
  80176c:	83 c4 1c             	add    $0x1c,%esp
  80176f:	5b                   	pop    %ebx
  801770:	5e                   	pop    %esi
  801771:	5f                   	pop    %edi
  801772:	5d                   	pop    %ebp
  801773:	c3                   	ret    
  801774:	bd 20 00 00 00       	mov    $0x20,%ebp
  801779:	89 eb                	mov    %ebp,%ebx
  80177b:	29 fb                	sub    %edi,%ebx
  80177d:	89 f9                	mov    %edi,%ecx
  80177f:	d3 e6                	shl    %cl,%esi
  801781:	89 c5                	mov    %eax,%ebp
  801783:	88 d9                	mov    %bl,%cl
  801785:	d3 ed                	shr    %cl,%ebp
  801787:	89 e9                	mov    %ebp,%ecx
  801789:	09 f1                	or     %esi,%ecx
  80178b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80178f:	89 f9                	mov    %edi,%ecx
  801791:	d3 e0                	shl    %cl,%eax
  801793:	89 c5                	mov    %eax,%ebp
  801795:	89 d6                	mov    %edx,%esi
  801797:	88 d9                	mov    %bl,%cl
  801799:	d3 ee                	shr    %cl,%esi
  80179b:	89 f9                	mov    %edi,%ecx
  80179d:	d3 e2                	shl    %cl,%edx
  80179f:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017a3:	88 d9                	mov    %bl,%cl
  8017a5:	d3 e8                	shr    %cl,%eax
  8017a7:	09 c2                	or     %eax,%edx
  8017a9:	89 d0                	mov    %edx,%eax
  8017ab:	89 f2                	mov    %esi,%edx
  8017ad:	f7 74 24 0c          	divl   0xc(%esp)
  8017b1:	89 d6                	mov    %edx,%esi
  8017b3:	89 c3                	mov    %eax,%ebx
  8017b5:	f7 e5                	mul    %ebp
  8017b7:	39 d6                	cmp    %edx,%esi
  8017b9:	72 19                	jb     8017d4 <__udivdi3+0xfc>
  8017bb:	74 0b                	je     8017c8 <__udivdi3+0xf0>
  8017bd:	89 d8                	mov    %ebx,%eax
  8017bf:	31 ff                	xor    %edi,%edi
  8017c1:	e9 58 ff ff ff       	jmp    80171e <__udivdi3+0x46>
  8017c6:	66 90                	xchg   %ax,%ax
  8017c8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017cc:	89 f9                	mov    %edi,%ecx
  8017ce:	d3 e2                	shl    %cl,%edx
  8017d0:	39 c2                	cmp    %eax,%edx
  8017d2:	73 e9                	jae    8017bd <__udivdi3+0xe5>
  8017d4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017d7:	31 ff                	xor    %edi,%edi
  8017d9:	e9 40 ff ff ff       	jmp    80171e <__udivdi3+0x46>
  8017de:	66 90                	xchg   %ax,%ax
  8017e0:	31 c0                	xor    %eax,%eax
  8017e2:	e9 37 ff ff ff       	jmp    80171e <__udivdi3+0x46>
  8017e7:	90                   	nop

008017e8 <__umoddi3>:
  8017e8:	55                   	push   %ebp
  8017e9:	57                   	push   %edi
  8017ea:	56                   	push   %esi
  8017eb:	53                   	push   %ebx
  8017ec:	83 ec 1c             	sub    $0x1c,%esp
  8017ef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017f3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017fb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801803:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801807:	89 f3                	mov    %esi,%ebx
  801809:	89 fa                	mov    %edi,%edx
  80180b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80180f:	89 34 24             	mov    %esi,(%esp)
  801812:	85 c0                	test   %eax,%eax
  801814:	75 1a                	jne    801830 <__umoddi3+0x48>
  801816:	39 f7                	cmp    %esi,%edi
  801818:	0f 86 a2 00 00 00    	jbe    8018c0 <__umoddi3+0xd8>
  80181e:	89 c8                	mov    %ecx,%eax
  801820:	89 f2                	mov    %esi,%edx
  801822:	f7 f7                	div    %edi
  801824:	89 d0                	mov    %edx,%eax
  801826:	31 d2                	xor    %edx,%edx
  801828:	83 c4 1c             	add    $0x1c,%esp
  80182b:	5b                   	pop    %ebx
  80182c:	5e                   	pop    %esi
  80182d:	5f                   	pop    %edi
  80182e:	5d                   	pop    %ebp
  80182f:	c3                   	ret    
  801830:	39 f0                	cmp    %esi,%eax
  801832:	0f 87 ac 00 00 00    	ja     8018e4 <__umoddi3+0xfc>
  801838:	0f bd e8             	bsr    %eax,%ebp
  80183b:	83 f5 1f             	xor    $0x1f,%ebp
  80183e:	0f 84 ac 00 00 00    	je     8018f0 <__umoddi3+0x108>
  801844:	bf 20 00 00 00       	mov    $0x20,%edi
  801849:	29 ef                	sub    %ebp,%edi
  80184b:	89 fe                	mov    %edi,%esi
  80184d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801851:	89 e9                	mov    %ebp,%ecx
  801853:	d3 e0                	shl    %cl,%eax
  801855:	89 d7                	mov    %edx,%edi
  801857:	89 f1                	mov    %esi,%ecx
  801859:	d3 ef                	shr    %cl,%edi
  80185b:	09 c7                	or     %eax,%edi
  80185d:	89 e9                	mov    %ebp,%ecx
  80185f:	d3 e2                	shl    %cl,%edx
  801861:	89 14 24             	mov    %edx,(%esp)
  801864:	89 d8                	mov    %ebx,%eax
  801866:	d3 e0                	shl    %cl,%eax
  801868:	89 c2                	mov    %eax,%edx
  80186a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80186e:	d3 e0                	shl    %cl,%eax
  801870:	89 44 24 04          	mov    %eax,0x4(%esp)
  801874:	8b 44 24 08          	mov    0x8(%esp),%eax
  801878:	89 f1                	mov    %esi,%ecx
  80187a:	d3 e8                	shr    %cl,%eax
  80187c:	09 d0                	or     %edx,%eax
  80187e:	d3 eb                	shr    %cl,%ebx
  801880:	89 da                	mov    %ebx,%edx
  801882:	f7 f7                	div    %edi
  801884:	89 d3                	mov    %edx,%ebx
  801886:	f7 24 24             	mull   (%esp)
  801889:	89 c6                	mov    %eax,%esi
  80188b:	89 d1                	mov    %edx,%ecx
  80188d:	39 d3                	cmp    %edx,%ebx
  80188f:	0f 82 87 00 00 00    	jb     80191c <__umoddi3+0x134>
  801895:	0f 84 91 00 00 00    	je     80192c <__umoddi3+0x144>
  80189b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80189f:	29 f2                	sub    %esi,%edx
  8018a1:	19 cb                	sbb    %ecx,%ebx
  8018a3:	89 d8                	mov    %ebx,%eax
  8018a5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018a9:	d3 e0                	shl    %cl,%eax
  8018ab:	89 e9                	mov    %ebp,%ecx
  8018ad:	d3 ea                	shr    %cl,%edx
  8018af:	09 d0                	or     %edx,%eax
  8018b1:	89 e9                	mov    %ebp,%ecx
  8018b3:	d3 eb                	shr    %cl,%ebx
  8018b5:	89 da                	mov    %ebx,%edx
  8018b7:	83 c4 1c             	add    $0x1c,%esp
  8018ba:	5b                   	pop    %ebx
  8018bb:	5e                   	pop    %esi
  8018bc:	5f                   	pop    %edi
  8018bd:	5d                   	pop    %ebp
  8018be:	c3                   	ret    
  8018bf:	90                   	nop
  8018c0:	89 fd                	mov    %edi,%ebp
  8018c2:	85 ff                	test   %edi,%edi
  8018c4:	75 0b                	jne    8018d1 <__umoddi3+0xe9>
  8018c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018cb:	31 d2                	xor    %edx,%edx
  8018cd:	f7 f7                	div    %edi
  8018cf:	89 c5                	mov    %eax,%ebp
  8018d1:	89 f0                	mov    %esi,%eax
  8018d3:	31 d2                	xor    %edx,%edx
  8018d5:	f7 f5                	div    %ebp
  8018d7:	89 c8                	mov    %ecx,%eax
  8018d9:	f7 f5                	div    %ebp
  8018db:	89 d0                	mov    %edx,%eax
  8018dd:	e9 44 ff ff ff       	jmp    801826 <__umoddi3+0x3e>
  8018e2:	66 90                	xchg   %ax,%ax
  8018e4:	89 c8                	mov    %ecx,%eax
  8018e6:	89 f2                	mov    %esi,%edx
  8018e8:	83 c4 1c             	add    $0x1c,%esp
  8018eb:	5b                   	pop    %ebx
  8018ec:	5e                   	pop    %esi
  8018ed:	5f                   	pop    %edi
  8018ee:	5d                   	pop    %ebp
  8018ef:	c3                   	ret    
  8018f0:	3b 04 24             	cmp    (%esp),%eax
  8018f3:	72 06                	jb     8018fb <__umoddi3+0x113>
  8018f5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018f9:	77 0f                	ja     80190a <__umoddi3+0x122>
  8018fb:	89 f2                	mov    %esi,%edx
  8018fd:	29 f9                	sub    %edi,%ecx
  8018ff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801903:	89 14 24             	mov    %edx,(%esp)
  801906:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80190a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80190e:	8b 14 24             	mov    (%esp),%edx
  801911:	83 c4 1c             	add    $0x1c,%esp
  801914:	5b                   	pop    %ebx
  801915:	5e                   	pop    %esi
  801916:	5f                   	pop    %edi
  801917:	5d                   	pop    %ebp
  801918:	c3                   	ret    
  801919:	8d 76 00             	lea    0x0(%esi),%esi
  80191c:	2b 04 24             	sub    (%esp),%eax
  80191f:	19 fa                	sbb    %edi,%edx
  801921:	89 d1                	mov    %edx,%ecx
  801923:	89 c6                	mov    %eax,%esi
  801925:	e9 71 ff ff ff       	jmp    80189b <__umoddi3+0xb3>
  80192a:	66 90                	xchg   %ax,%ax
  80192c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801930:	72 ea                	jb     80191c <__umoddi3+0x134>
  801932:	89 d9                	mov    %ebx,%ecx
  801934:	e9 62 ff ff ff       	jmp    80189b <__umoddi3+0xb3>
