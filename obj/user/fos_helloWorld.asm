
obj/user/fos_helloWorld:     file format elf32-i386


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
  800031:	e8 31 00 00 00       	call   800067 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	extern unsigned char * etext;
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);		
	atomic_cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 60 18 80 00       	push   $0x801860
  800046:	e8 1f 02 00 00       	call   80026a <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	atomic_cprintf("end of code = %x\n",etext);
  80004e:	a1 45 18 80 00       	mov    0x801845,%eax
  800053:	83 ec 08             	sub    $0x8,%esp
  800056:	50                   	push   %eax
  800057:	68 88 18 80 00       	push   $0x801888
  80005c:	e8 09 02 00 00       	call   80026a <atomic_cprintf>
  800061:	83 c4 10             	add    $0x10,%esp
}
  800064:	90                   	nop
  800065:	c9                   	leave  
  800066:	c3                   	ret    

00800067 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800067:	55                   	push   %ebp
  800068:	89 e5                	mov    %esp,%ebp
  80006a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80006d:	e8 f6 0f 00 00       	call   801068 <sys_getenvindex>
  800072:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800075:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800078:	89 d0                	mov    %edx,%eax
  80007a:	01 c0                	add    %eax,%eax
  80007c:	01 d0                	add    %edx,%eax
  80007e:	c1 e0 02             	shl    $0x2,%eax
  800081:	01 d0                	add    %edx,%eax
  800083:	c1 e0 06             	shl    $0x6,%eax
  800086:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80008b:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800090:	a1 04 20 80 00       	mov    0x802004,%eax
  800095:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80009b:	84 c0                	test   %al,%al
  80009d:	74 0f                	je     8000ae <libmain+0x47>
		binaryname = myEnv->prog_name;
  80009f:	a1 04 20 80 00       	mov    0x802004,%eax
  8000a4:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000a9:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000b2:	7e 0a                	jle    8000be <libmain+0x57>
		binaryname = argv[0];
  8000b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000b7:	8b 00                	mov    (%eax),%eax
  8000b9:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000be:	83 ec 08             	sub    $0x8,%esp
  8000c1:	ff 75 0c             	pushl  0xc(%ebp)
  8000c4:	ff 75 08             	pushl  0x8(%ebp)
  8000c7:	e8 6c ff ff ff       	call   800038 <_main>
  8000cc:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000cf:	e8 2f 11 00 00       	call   801203 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000d4:	83 ec 0c             	sub    $0xc,%esp
  8000d7:	68 b4 18 80 00       	push   $0x8018b4
  8000dc:	e8 5c 01 00 00       	call   80023d <cprintf>
  8000e1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000e4:	a1 04 20 80 00       	mov    0x802004,%eax
  8000e9:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8000ef:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f4:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8000fa:	83 ec 04             	sub    $0x4,%esp
  8000fd:	52                   	push   %edx
  8000fe:	50                   	push   %eax
  8000ff:	68 dc 18 80 00       	push   $0x8018dc
  800104:	e8 34 01 00 00       	call   80023d <cprintf>
  800109:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80010c:	a1 04 20 80 00       	mov    0x802004,%eax
  800111:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800117:	83 ec 08             	sub    $0x8,%esp
  80011a:	50                   	push   %eax
  80011b:	68 01 19 80 00       	push   $0x801901
  800120:	e8 18 01 00 00       	call   80023d <cprintf>
  800125:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800128:	83 ec 0c             	sub    $0xc,%esp
  80012b:	68 b4 18 80 00       	push   $0x8018b4
  800130:	e8 08 01 00 00       	call   80023d <cprintf>
  800135:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800138:	e8 e0 10 00 00       	call   80121d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80013d:	e8 19 00 00 00       	call   80015b <exit>
}
  800142:	90                   	nop
  800143:	c9                   	leave  
  800144:	c3                   	ret    

00800145 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800145:	55                   	push   %ebp
  800146:	89 e5                	mov    %esp,%ebp
  800148:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80014b:	83 ec 0c             	sub    $0xc,%esp
  80014e:	6a 00                	push   $0x0
  800150:	e8 df 0e 00 00       	call   801034 <sys_env_destroy>
  800155:	83 c4 10             	add    $0x10,%esp
}
  800158:	90                   	nop
  800159:	c9                   	leave  
  80015a:	c3                   	ret    

0080015b <exit>:

void
exit(void)
{
  80015b:	55                   	push   %ebp
  80015c:	89 e5                	mov    %esp,%ebp
  80015e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800161:	e8 34 0f 00 00       	call   80109a <sys_env_exit>
}
  800166:	90                   	nop
  800167:	c9                   	leave  
  800168:	c3                   	ret    

00800169 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800169:	55                   	push   %ebp
  80016a:	89 e5                	mov    %esp,%ebp
  80016c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80016f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800172:	8b 00                	mov    (%eax),%eax
  800174:	8d 48 01             	lea    0x1(%eax),%ecx
  800177:	8b 55 0c             	mov    0xc(%ebp),%edx
  80017a:	89 0a                	mov    %ecx,(%edx)
  80017c:	8b 55 08             	mov    0x8(%ebp),%edx
  80017f:	88 d1                	mov    %dl,%cl
  800181:	8b 55 0c             	mov    0xc(%ebp),%edx
  800184:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800188:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018b:	8b 00                	mov    (%eax),%eax
  80018d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800192:	75 2c                	jne    8001c0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800194:	a0 08 20 80 00       	mov    0x802008,%al
  800199:	0f b6 c0             	movzbl %al,%eax
  80019c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80019f:	8b 12                	mov    (%edx),%edx
  8001a1:	89 d1                	mov    %edx,%ecx
  8001a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001a6:	83 c2 08             	add    $0x8,%edx
  8001a9:	83 ec 04             	sub    $0x4,%esp
  8001ac:	50                   	push   %eax
  8001ad:	51                   	push   %ecx
  8001ae:	52                   	push   %edx
  8001af:	e8 3e 0e 00 00       	call   800ff2 <sys_cputs>
  8001b4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c3:	8b 40 04             	mov    0x4(%eax),%eax
  8001c6:	8d 50 01             	lea    0x1(%eax),%edx
  8001c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001cc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001cf:	90                   	nop
  8001d0:	c9                   	leave  
  8001d1:	c3                   	ret    

008001d2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001d2:	55                   	push   %ebp
  8001d3:	89 e5                	mov    %esp,%ebp
  8001d5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001db:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001e2:	00 00 00 
	b.cnt = 0;
  8001e5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001ec:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001ef:	ff 75 0c             	pushl  0xc(%ebp)
  8001f2:	ff 75 08             	pushl  0x8(%ebp)
  8001f5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8001fb:	50                   	push   %eax
  8001fc:	68 69 01 80 00       	push   $0x800169
  800201:	e8 11 02 00 00       	call   800417 <vprintfmt>
  800206:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800209:	a0 08 20 80 00       	mov    0x802008,%al
  80020e:	0f b6 c0             	movzbl %al,%eax
  800211:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	50                   	push   %eax
  80021b:	52                   	push   %edx
  80021c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800222:	83 c0 08             	add    $0x8,%eax
  800225:	50                   	push   %eax
  800226:	e8 c7 0d 00 00       	call   800ff2 <sys_cputs>
  80022b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80022e:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800235:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80023b:	c9                   	leave  
  80023c:	c3                   	ret    

0080023d <cprintf>:

int cprintf(const char *fmt, ...) {
  80023d:	55                   	push   %ebp
  80023e:	89 e5                	mov    %esp,%ebp
  800240:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800243:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  80024a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80024d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800250:	8b 45 08             	mov    0x8(%ebp),%eax
  800253:	83 ec 08             	sub    $0x8,%esp
  800256:	ff 75 f4             	pushl  -0xc(%ebp)
  800259:	50                   	push   %eax
  80025a:	e8 73 ff ff ff       	call   8001d2 <vcprintf>
  80025f:	83 c4 10             	add    $0x10,%esp
  800262:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800265:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800268:	c9                   	leave  
  800269:	c3                   	ret    

0080026a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80026a:	55                   	push   %ebp
  80026b:	89 e5                	mov    %esp,%ebp
  80026d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800270:	e8 8e 0f 00 00       	call   801203 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800275:	8d 45 0c             	lea    0xc(%ebp),%eax
  800278:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80027b:	8b 45 08             	mov    0x8(%ebp),%eax
  80027e:	83 ec 08             	sub    $0x8,%esp
  800281:	ff 75 f4             	pushl  -0xc(%ebp)
  800284:	50                   	push   %eax
  800285:	e8 48 ff ff ff       	call   8001d2 <vcprintf>
  80028a:	83 c4 10             	add    $0x10,%esp
  80028d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800290:	e8 88 0f 00 00       	call   80121d <sys_enable_interrupt>
	return cnt;
  800295:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800298:	c9                   	leave  
  800299:	c3                   	ret    

0080029a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80029a:	55                   	push   %ebp
  80029b:	89 e5                	mov    %esp,%ebp
  80029d:	53                   	push   %ebx
  80029e:	83 ec 14             	sub    $0x14,%esp
  8002a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8002aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002ad:	8b 45 18             	mov    0x18(%ebp),%eax
  8002b0:	ba 00 00 00 00       	mov    $0x0,%edx
  8002b5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002b8:	77 55                	ja     80030f <printnum+0x75>
  8002ba:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002bd:	72 05                	jb     8002c4 <printnum+0x2a>
  8002bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002c2:	77 4b                	ja     80030f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002c4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002c7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002ca:	8b 45 18             	mov    0x18(%ebp),%eax
  8002cd:	ba 00 00 00 00       	mov    $0x0,%edx
  8002d2:	52                   	push   %edx
  8002d3:	50                   	push   %eax
  8002d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d7:	ff 75 f0             	pushl  -0x10(%ebp)
  8002da:	e8 05 13 00 00       	call   8015e4 <__udivdi3>
  8002df:	83 c4 10             	add    $0x10,%esp
  8002e2:	83 ec 04             	sub    $0x4,%esp
  8002e5:	ff 75 20             	pushl  0x20(%ebp)
  8002e8:	53                   	push   %ebx
  8002e9:	ff 75 18             	pushl  0x18(%ebp)
  8002ec:	52                   	push   %edx
  8002ed:	50                   	push   %eax
  8002ee:	ff 75 0c             	pushl  0xc(%ebp)
  8002f1:	ff 75 08             	pushl  0x8(%ebp)
  8002f4:	e8 a1 ff ff ff       	call   80029a <printnum>
  8002f9:	83 c4 20             	add    $0x20,%esp
  8002fc:	eb 1a                	jmp    800318 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8002fe:	83 ec 08             	sub    $0x8,%esp
  800301:	ff 75 0c             	pushl  0xc(%ebp)
  800304:	ff 75 20             	pushl  0x20(%ebp)
  800307:	8b 45 08             	mov    0x8(%ebp),%eax
  80030a:	ff d0                	call   *%eax
  80030c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80030f:	ff 4d 1c             	decl   0x1c(%ebp)
  800312:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800316:	7f e6                	jg     8002fe <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800318:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80031b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800320:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800323:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800326:	53                   	push   %ebx
  800327:	51                   	push   %ecx
  800328:	52                   	push   %edx
  800329:	50                   	push   %eax
  80032a:	e8 c5 13 00 00       	call   8016f4 <__umoddi3>
  80032f:	83 c4 10             	add    $0x10,%esp
  800332:	05 34 1b 80 00       	add    $0x801b34,%eax
  800337:	8a 00                	mov    (%eax),%al
  800339:	0f be c0             	movsbl %al,%eax
  80033c:	83 ec 08             	sub    $0x8,%esp
  80033f:	ff 75 0c             	pushl  0xc(%ebp)
  800342:	50                   	push   %eax
  800343:	8b 45 08             	mov    0x8(%ebp),%eax
  800346:	ff d0                	call   *%eax
  800348:	83 c4 10             	add    $0x10,%esp
}
  80034b:	90                   	nop
  80034c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80034f:	c9                   	leave  
  800350:	c3                   	ret    

00800351 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800351:	55                   	push   %ebp
  800352:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800354:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800358:	7e 1c                	jle    800376 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80035a:	8b 45 08             	mov    0x8(%ebp),%eax
  80035d:	8b 00                	mov    (%eax),%eax
  80035f:	8d 50 08             	lea    0x8(%eax),%edx
  800362:	8b 45 08             	mov    0x8(%ebp),%eax
  800365:	89 10                	mov    %edx,(%eax)
  800367:	8b 45 08             	mov    0x8(%ebp),%eax
  80036a:	8b 00                	mov    (%eax),%eax
  80036c:	83 e8 08             	sub    $0x8,%eax
  80036f:	8b 50 04             	mov    0x4(%eax),%edx
  800372:	8b 00                	mov    (%eax),%eax
  800374:	eb 40                	jmp    8003b6 <getuint+0x65>
	else if (lflag)
  800376:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80037a:	74 1e                	je     80039a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80037c:	8b 45 08             	mov    0x8(%ebp),%eax
  80037f:	8b 00                	mov    (%eax),%eax
  800381:	8d 50 04             	lea    0x4(%eax),%edx
  800384:	8b 45 08             	mov    0x8(%ebp),%eax
  800387:	89 10                	mov    %edx,(%eax)
  800389:	8b 45 08             	mov    0x8(%ebp),%eax
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	83 e8 04             	sub    $0x4,%eax
  800391:	8b 00                	mov    (%eax),%eax
  800393:	ba 00 00 00 00       	mov    $0x0,%edx
  800398:	eb 1c                	jmp    8003b6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80039a:	8b 45 08             	mov    0x8(%ebp),%eax
  80039d:	8b 00                	mov    (%eax),%eax
  80039f:	8d 50 04             	lea    0x4(%eax),%edx
  8003a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a5:	89 10                	mov    %edx,(%eax)
  8003a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003aa:	8b 00                	mov    (%eax),%eax
  8003ac:	83 e8 04             	sub    $0x4,%eax
  8003af:	8b 00                	mov    (%eax),%eax
  8003b1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003b6:	5d                   	pop    %ebp
  8003b7:	c3                   	ret    

008003b8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003b8:	55                   	push   %ebp
  8003b9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003bb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003bf:	7e 1c                	jle    8003dd <getint+0x25>
		return va_arg(*ap, long long);
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	8b 00                	mov    (%eax),%eax
  8003c6:	8d 50 08             	lea    0x8(%eax),%edx
  8003c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cc:	89 10                	mov    %edx,(%eax)
  8003ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d1:	8b 00                	mov    (%eax),%eax
  8003d3:	83 e8 08             	sub    $0x8,%eax
  8003d6:	8b 50 04             	mov    0x4(%eax),%edx
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	eb 38                	jmp    800415 <getint+0x5d>
	else if (lflag)
  8003dd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003e1:	74 1a                	je     8003fd <getint+0x45>
		return va_arg(*ap, long);
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	8b 00                	mov    (%eax),%eax
  8003e8:	8d 50 04             	lea    0x4(%eax),%edx
  8003eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ee:	89 10                	mov    %edx,(%eax)
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	83 e8 04             	sub    $0x4,%eax
  8003f8:	8b 00                	mov    (%eax),%eax
  8003fa:	99                   	cltd   
  8003fb:	eb 18                	jmp    800415 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	8d 50 04             	lea    0x4(%eax),%edx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	89 10                	mov    %edx,(%eax)
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	83 e8 04             	sub    $0x4,%eax
  800412:	8b 00                	mov    (%eax),%eax
  800414:	99                   	cltd   
}
  800415:	5d                   	pop    %ebp
  800416:	c3                   	ret    

00800417 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800417:	55                   	push   %ebp
  800418:	89 e5                	mov    %esp,%ebp
  80041a:	56                   	push   %esi
  80041b:	53                   	push   %ebx
  80041c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80041f:	eb 17                	jmp    800438 <vprintfmt+0x21>
			if (ch == '\0')
  800421:	85 db                	test   %ebx,%ebx
  800423:	0f 84 af 03 00 00    	je     8007d8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800429:	83 ec 08             	sub    $0x8,%esp
  80042c:	ff 75 0c             	pushl  0xc(%ebp)
  80042f:	53                   	push   %ebx
  800430:	8b 45 08             	mov    0x8(%ebp),%eax
  800433:	ff d0                	call   *%eax
  800435:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800438:	8b 45 10             	mov    0x10(%ebp),%eax
  80043b:	8d 50 01             	lea    0x1(%eax),%edx
  80043e:	89 55 10             	mov    %edx,0x10(%ebp)
  800441:	8a 00                	mov    (%eax),%al
  800443:	0f b6 d8             	movzbl %al,%ebx
  800446:	83 fb 25             	cmp    $0x25,%ebx
  800449:	75 d6                	jne    800421 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80044b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80044f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800456:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80045d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800464:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80046b:	8b 45 10             	mov    0x10(%ebp),%eax
  80046e:	8d 50 01             	lea    0x1(%eax),%edx
  800471:	89 55 10             	mov    %edx,0x10(%ebp)
  800474:	8a 00                	mov    (%eax),%al
  800476:	0f b6 d8             	movzbl %al,%ebx
  800479:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80047c:	83 f8 55             	cmp    $0x55,%eax
  80047f:	0f 87 2b 03 00 00    	ja     8007b0 <vprintfmt+0x399>
  800485:	8b 04 85 58 1b 80 00 	mov    0x801b58(,%eax,4),%eax
  80048c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80048e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800492:	eb d7                	jmp    80046b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800494:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800498:	eb d1                	jmp    80046b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80049a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004a1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004a4:	89 d0                	mov    %edx,%eax
  8004a6:	c1 e0 02             	shl    $0x2,%eax
  8004a9:	01 d0                	add    %edx,%eax
  8004ab:	01 c0                	add    %eax,%eax
  8004ad:	01 d8                	add    %ebx,%eax
  8004af:	83 e8 30             	sub    $0x30,%eax
  8004b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b8:	8a 00                	mov    (%eax),%al
  8004ba:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004bd:	83 fb 2f             	cmp    $0x2f,%ebx
  8004c0:	7e 3e                	jle    800500 <vprintfmt+0xe9>
  8004c2:	83 fb 39             	cmp    $0x39,%ebx
  8004c5:	7f 39                	jg     800500 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004c7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004ca:	eb d5                	jmp    8004a1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8004cf:	83 c0 04             	add    $0x4,%eax
  8004d2:	89 45 14             	mov    %eax,0x14(%ebp)
  8004d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d8:	83 e8 04             	sub    $0x4,%eax
  8004db:	8b 00                	mov    (%eax),%eax
  8004dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004e0:	eb 1f                	jmp    800501 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004e2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004e6:	79 83                	jns    80046b <vprintfmt+0x54>
				width = 0;
  8004e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004ef:	e9 77 ff ff ff       	jmp    80046b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8004f4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8004fb:	e9 6b ff ff ff       	jmp    80046b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800500:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800501:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800505:	0f 89 60 ff ff ff    	jns    80046b <vprintfmt+0x54>
				width = precision, precision = -1;
  80050b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80050e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800511:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800518:	e9 4e ff ff ff       	jmp    80046b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80051d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800520:	e9 46 ff ff ff       	jmp    80046b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800525:	8b 45 14             	mov    0x14(%ebp),%eax
  800528:	83 c0 04             	add    $0x4,%eax
  80052b:	89 45 14             	mov    %eax,0x14(%ebp)
  80052e:	8b 45 14             	mov    0x14(%ebp),%eax
  800531:	83 e8 04             	sub    $0x4,%eax
  800534:	8b 00                	mov    (%eax),%eax
  800536:	83 ec 08             	sub    $0x8,%esp
  800539:	ff 75 0c             	pushl  0xc(%ebp)
  80053c:	50                   	push   %eax
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	ff d0                	call   *%eax
  800542:	83 c4 10             	add    $0x10,%esp
			break;
  800545:	e9 89 02 00 00       	jmp    8007d3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80054a:	8b 45 14             	mov    0x14(%ebp),%eax
  80054d:	83 c0 04             	add    $0x4,%eax
  800550:	89 45 14             	mov    %eax,0x14(%ebp)
  800553:	8b 45 14             	mov    0x14(%ebp),%eax
  800556:	83 e8 04             	sub    $0x4,%eax
  800559:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80055b:	85 db                	test   %ebx,%ebx
  80055d:	79 02                	jns    800561 <vprintfmt+0x14a>
				err = -err;
  80055f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800561:	83 fb 64             	cmp    $0x64,%ebx
  800564:	7f 0b                	jg     800571 <vprintfmt+0x15a>
  800566:	8b 34 9d a0 19 80 00 	mov    0x8019a0(,%ebx,4),%esi
  80056d:	85 f6                	test   %esi,%esi
  80056f:	75 19                	jne    80058a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800571:	53                   	push   %ebx
  800572:	68 45 1b 80 00       	push   $0x801b45
  800577:	ff 75 0c             	pushl  0xc(%ebp)
  80057a:	ff 75 08             	pushl  0x8(%ebp)
  80057d:	e8 5e 02 00 00       	call   8007e0 <printfmt>
  800582:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800585:	e9 49 02 00 00       	jmp    8007d3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80058a:	56                   	push   %esi
  80058b:	68 4e 1b 80 00       	push   $0x801b4e
  800590:	ff 75 0c             	pushl  0xc(%ebp)
  800593:	ff 75 08             	pushl  0x8(%ebp)
  800596:	e8 45 02 00 00       	call   8007e0 <printfmt>
  80059b:	83 c4 10             	add    $0x10,%esp
			break;
  80059e:	e9 30 02 00 00       	jmp    8007d3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a6:	83 c0 04             	add    $0x4,%eax
  8005a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8005af:	83 e8 04             	sub    $0x4,%eax
  8005b2:	8b 30                	mov    (%eax),%esi
  8005b4:	85 f6                	test   %esi,%esi
  8005b6:	75 05                	jne    8005bd <vprintfmt+0x1a6>
				p = "(null)";
  8005b8:	be 51 1b 80 00       	mov    $0x801b51,%esi
			if (width > 0 && padc != '-')
  8005bd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c1:	7e 6d                	jle    800630 <vprintfmt+0x219>
  8005c3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005c7:	74 67                	je     800630 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005cc:	83 ec 08             	sub    $0x8,%esp
  8005cf:	50                   	push   %eax
  8005d0:	56                   	push   %esi
  8005d1:	e8 0c 03 00 00       	call   8008e2 <strnlen>
  8005d6:	83 c4 10             	add    $0x10,%esp
  8005d9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005dc:	eb 16                	jmp    8005f4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005de:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005e2:	83 ec 08             	sub    $0x8,%esp
  8005e5:	ff 75 0c             	pushl  0xc(%ebp)
  8005e8:	50                   	push   %eax
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	ff d0                	call   *%eax
  8005ee:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005f1:	ff 4d e4             	decl   -0x1c(%ebp)
  8005f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005f8:	7f e4                	jg     8005de <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8005fa:	eb 34                	jmp    800630 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8005fc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800600:	74 1c                	je     80061e <vprintfmt+0x207>
  800602:	83 fb 1f             	cmp    $0x1f,%ebx
  800605:	7e 05                	jle    80060c <vprintfmt+0x1f5>
  800607:	83 fb 7e             	cmp    $0x7e,%ebx
  80060a:	7e 12                	jle    80061e <vprintfmt+0x207>
					putch('?', putdat);
  80060c:	83 ec 08             	sub    $0x8,%esp
  80060f:	ff 75 0c             	pushl  0xc(%ebp)
  800612:	6a 3f                	push   $0x3f
  800614:	8b 45 08             	mov    0x8(%ebp),%eax
  800617:	ff d0                	call   *%eax
  800619:	83 c4 10             	add    $0x10,%esp
  80061c:	eb 0f                	jmp    80062d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80061e:	83 ec 08             	sub    $0x8,%esp
  800621:	ff 75 0c             	pushl  0xc(%ebp)
  800624:	53                   	push   %ebx
  800625:	8b 45 08             	mov    0x8(%ebp),%eax
  800628:	ff d0                	call   *%eax
  80062a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80062d:	ff 4d e4             	decl   -0x1c(%ebp)
  800630:	89 f0                	mov    %esi,%eax
  800632:	8d 70 01             	lea    0x1(%eax),%esi
  800635:	8a 00                	mov    (%eax),%al
  800637:	0f be d8             	movsbl %al,%ebx
  80063a:	85 db                	test   %ebx,%ebx
  80063c:	74 24                	je     800662 <vprintfmt+0x24b>
  80063e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800642:	78 b8                	js     8005fc <vprintfmt+0x1e5>
  800644:	ff 4d e0             	decl   -0x20(%ebp)
  800647:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80064b:	79 af                	jns    8005fc <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80064d:	eb 13                	jmp    800662 <vprintfmt+0x24b>
				putch(' ', putdat);
  80064f:	83 ec 08             	sub    $0x8,%esp
  800652:	ff 75 0c             	pushl  0xc(%ebp)
  800655:	6a 20                	push   $0x20
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	ff d0                	call   *%eax
  80065c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80065f:	ff 4d e4             	decl   -0x1c(%ebp)
  800662:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800666:	7f e7                	jg     80064f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800668:	e9 66 01 00 00       	jmp    8007d3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80066d:	83 ec 08             	sub    $0x8,%esp
  800670:	ff 75 e8             	pushl  -0x18(%ebp)
  800673:	8d 45 14             	lea    0x14(%ebp),%eax
  800676:	50                   	push   %eax
  800677:	e8 3c fd ff ff       	call   8003b8 <getint>
  80067c:	83 c4 10             	add    $0x10,%esp
  80067f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800682:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800685:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800688:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80068b:	85 d2                	test   %edx,%edx
  80068d:	79 23                	jns    8006b2 <vprintfmt+0x29b>
				putch('-', putdat);
  80068f:	83 ec 08             	sub    $0x8,%esp
  800692:	ff 75 0c             	pushl  0xc(%ebp)
  800695:	6a 2d                	push   $0x2d
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	ff d0                	call   *%eax
  80069c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80069f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006a5:	f7 d8                	neg    %eax
  8006a7:	83 d2 00             	adc    $0x0,%edx
  8006aa:	f7 da                	neg    %edx
  8006ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006af:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006b2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006b9:	e9 bc 00 00 00       	jmp    80077a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006be:	83 ec 08             	sub    $0x8,%esp
  8006c1:	ff 75 e8             	pushl  -0x18(%ebp)
  8006c4:	8d 45 14             	lea    0x14(%ebp),%eax
  8006c7:	50                   	push   %eax
  8006c8:	e8 84 fc ff ff       	call   800351 <getuint>
  8006cd:	83 c4 10             	add    $0x10,%esp
  8006d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006d6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006dd:	e9 98 00 00 00       	jmp    80077a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006e2:	83 ec 08             	sub    $0x8,%esp
  8006e5:	ff 75 0c             	pushl  0xc(%ebp)
  8006e8:	6a 58                	push   $0x58
  8006ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ed:	ff d0                	call   *%eax
  8006ef:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006f2:	83 ec 08             	sub    $0x8,%esp
  8006f5:	ff 75 0c             	pushl  0xc(%ebp)
  8006f8:	6a 58                	push   $0x58
  8006fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fd:	ff d0                	call   *%eax
  8006ff:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	ff 75 0c             	pushl  0xc(%ebp)
  800708:	6a 58                	push   $0x58
  80070a:	8b 45 08             	mov    0x8(%ebp),%eax
  80070d:	ff d0                	call   *%eax
  80070f:	83 c4 10             	add    $0x10,%esp
			break;
  800712:	e9 bc 00 00 00       	jmp    8007d3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	ff 75 0c             	pushl  0xc(%ebp)
  80071d:	6a 30                	push   $0x30
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	ff d0                	call   *%eax
  800724:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 0c             	pushl  0xc(%ebp)
  80072d:	6a 78                	push   $0x78
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	ff d0                	call   *%eax
  800734:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800737:	8b 45 14             	mov    0x14(%ebp),%eax
  80073a:	83 c0 04             	add    $0x4,%eax
  80073d:	89 45 14             	mov    %eax,0x14(%ebp)
  800740:	8b 45 14             	mov    0x14(%ebp),%eax
  800743:	83 e8 04             	sub    $0x4,%eax
  800746:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800748:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80074b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800752:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800759:	eb 1f                	jmp    80077a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 e8             	pushl  -0x18(%ebp)
  800761:	8d 45 14             	lea    0x14(%ebp),%eax
  800764:	50                   	push   %eax
  800765:	e8 e7 fb ff ff       	call   800351 <getuint>
  80076a:	83 c4 10             	add    $0x10,%esp
  80076d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800770:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800773:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80077a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80077e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800781:	83 ec 04             	sub    $0x4,%esp
  800784:	52                   	push   %edx
  800785:	ff 75 e4             	pushl  -0x1c(%ebp)
  800788:	50                   	push   %eax
  800789:	ff 75 f4             	pushl  -0xc(%ebp)
  80078c:	ff 75 f0             	pushl  -0x10(%ebp)
  80078f:	ff 75 0c             	pushl  0xc(%ebp)
  800792:	ff 75 08             	pushl  0x8(%ebp)
  800795:	e8 00 fb ff ff       	call   80029a <printnum>
  80079a:	83 c4 20             	add    $0x20,%esp
			break;
  80079d:	eb 34                	jmp    8007d3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80079f:	83 ec 08             	sub    $0x8,%esp
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	53                   	push   %ebx
  8007a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a9:	ff d0                	call   *%eax
  8007ab:	83 c4 10             	add    $0x10,%esp
			break;
  8007ae:	eb 23                	jmp    8007d3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007b0:	83 ec 08             	sub    $0x8,%esp
  8007b3:	ff 75 0c             	pushl  0xc(%ebp)
  8007b6:	6a 25                	push   $0x25
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	ff d0                	call   *%eax
  8007bd:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007c0:	ff 4d 10             	decl   0x10(%ebp)
  8007c3:	eb 03                	jmp    8007c8 <vprintfmt+0x3b1>
  8007c5:	ff 4d 10             	decl   0x10(%ebp)
  8007c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8007cb:	48                   	dec    %eax
  8007cc:	8a 00                	mov    (%eax),%al
  8007ce:	3c 25                	cmp    $0x25,%al
  8007d0:	75 f3                	jne    8007c5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007d2:	90                   	nop
		}
	}
  8007d3:	e9 47 fc ff ff       	jmp    80041f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007d8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007dc:	5b                   	pop    %ebx
  8007dd:	5e                   	pop    %esi
  8007de:	5d                   	pop    %ebp
  8007df:	c3                   	ret    

008007e0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007e0:	55                   	push   %ebp
  8007e1:	89 e5                	mov    %esp,%ebp
  8007e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8007e9:	83 c0 04             	add    $0x4,%eax
  8007ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f5:	50                   	push   %eax
  8007f6:	ff 75 0c             	pushl  0xc(%ebp)
  8007f9:	ff 75 08             	pushl  0x8(%ebp)
  8007fc:	e8 16 fc ff ff       	call   800417 <vprintfmt>
  800801:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800804:	90                   	nop
  800805:	c9                   	leave  
  800806:	c3                   	ret    

00800807 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800807:	55                   	push   %ebp
  800808:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80080a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80080d:	8b 40 08             	mov    0x8(%eax),%eax
  800810:	8d 50 01             	lea    0x1(%eax),%edx
  800813:	8b 45 0c             	mov    0xc(%ebp),%eax
  800816:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800819:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081c:	8b 10                	mov    (%eax),%edx
  80081e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800821:	8b 40 04             	mov    0x4(%eax),%eax
  800824:	39 c2                	cmp    %eax,%edx
  800826:	73 12                	jae    80083a <sprintputch+0x33>
		*b->buf++ = ch;
  800828:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082b:	8b 00                	mov    (%eax),%eax
  80082d:	8d 48 01             	lea    0x1(%eax),%ecx
  800830:	8b 55 0c             	mov    0xc(%ebp),%edx
  800833:	89 0a                	mov    %ecx,(%edx)
  800835:	8b 55 08             	mov    0x8(%ebp),%edx
  800838:	88 10                	mov    %dl,(%eax)
}
  80083a:	90                   	nop
  80083b:	5d                   	pop    %ebp
  80083c:	c3                   	ret    

0080083d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80083d:	55                   	push   %ebp
  80083e:	89 e5                	mov    %esp,%ebp
  800840:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800849:	8b 45 0c             	mov    0xc(%ebp),%eax
  80084c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	01 d0                	add    %edx,%eax
  800854:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800857:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80085e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800862:	74 06                	je     80086a <vsnprintf+0x2d>
  800864:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800868:	7f 07                	jg     800871 <vsnprintf+0x34>
		return -E_INVAL;
  80086a:	b8 03 00 00 00       	mov    $0x3,%eax
  80086f:	eb 20                	jmp    800891 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800871:	ff 75 14             	pushl  0x14(%ebp)
  800874:	ff 75 10             	pushl  0x10(%ebp)
  800877:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80087a:	50                   	push   %eax
  80087b:	68 07 08 80 00       	push   $0x800807
  800880:	e8 92 fb ff ff       	call   800417 <vprintfmt>
  800885:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800888:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80088b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80088e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800891:	c9                   	leave  
  800892:	c3                   	ret    

00800893 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800893:	55                   	push   %ebp
  800894:	89 e5                	mov    %esp,%ebp
  800896:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800899:	8d 45 10             	lea    0x10(%ebp),%eax
  80089c:	83 c0 04             	add    $0x4,%eax
  80089f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8008a8:	50                   	push   %eax
  8008a9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ac:	ff 75 08             	pushl  0x8(%ebp)
  8008af:	e8 89 ff ff ff       	call   80083d <vsnprintf>
  8008b4:	83 c4 10             	add    $0x10,%esp
  8008b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008bd:	c9                   	leave  
  8008be:	c3                   	ret    

008008bf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008bf:	55                   	push   %ebp
  8008c0:	89 e5                	mov    %esp,%ebp
  8008c2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008cc:	eb 06                	jmp    8008d4 <strlen+0x15>
		n++;
  8008ce:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008d1:	ff 45 08             	incl   0x8(%ebp)
  8008d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d7:	8a 00                	mov    (%eax),%al
  8008d9:	84 c0                	test   %al,%al
  8008db:	75 f1                	jne    8008ce <strlen+0xf>
		n++;
	return n;
  8008dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008e0:	c9                   	leave  
  8008e1:	c3                   	ret    

008008e2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008e2:	55                   	push   %ebp
  8008e3:	89 e5                	mov    %esp,%ebp
  8008e5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008ef:	eb 09                	jmp    8008fa <strnlen+0x18>
		n++;
  8008f1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008f4:	ff 45 08             	incl   0x8(%ebp)
  8008f7:	ff 4d 0c             	decl   0xc(%ebp)
  8008fa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008fe:	74 09                	je     800909 <strnlen+0x27>
  800900:	8b 45 08             	mov    0x8(%ebp),%eax
  800903:	8a 00                	mov    (%eax),%al
  800905:	84 c0                	test   %al,%al
  800907:	75 e8                	jne    8008f1 <strnlen+0xf>
		n++;
	return n;
  800909:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80090c:	c9                   	leave  
  80090d:	c3                   	ret    

0080090e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80090e:	55                   	push   %ebp
  80090f:	89 e5                	mov    %esp,%ebp
  800911:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800914:	8b 45 08             	mov    0x8(%ebp),%eax
  800917:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80091a:	90                   	nop
  80091b:	8b 45 08             	mov    0x8(%ebp),%eax
  80091e:	8d 50 01             	lea    0x1(%eax),%edx
  800921:	89 55 08             	mov    %edx,0x8(%ebp)
  800924:	8b 55 0c             	mov    0xc(%ebp),%edx
  800927:	8d 4a 01             	lea    0x1(%edx),%ecx
  80092a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80092d:	8a 12                	mov    (%edx),%dl
  80092f:	88 10                	mov    %dl,(%eax)
  800931:	8a 00                	mov    (%eax),%al
  800933:	84 c0                	test   %al,%al
  800935:	75 e4                	jne    80091b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800937:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80093a:	c9                   	leave  
  80093b:	c3                   	ret    

0080093c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80093c:	55                   	push   %ebp
  80093d:	89 e5                	mov    %esp,%ebp
  80093f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800948:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80094f:	eb 1f                	jmp    800970 <strncpy+0x34>
		*dst++ = *src;
  800951:	8b 45 08             	mov    0x8(%ebp),%eax
  800954:	8d 50 01             	lea    0x1(%eax),%edx
  800957:	89 55 08             	mov    %edx,0x8(%ebp)
  80095a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095d:	8a 12                	mov    (%edx),%dl
  80095f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800961:	8b 45 0c             	mov    0xc(%ebp),%eax
  800964:	8a 00                	mov    (%eax),%al
  800966:	84 c0                	test   %al,%al
  800968:	74 03                	je     80096d <strncpy+0x31>
			src++;
  80096a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80096d:	ff 45 fc             	incl   -0x4(%ebp)
  800970:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800973:	3b 45 10             	cmp    0x10(%ebp),%eax
  800976:	72 d9                	jb     800951 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800978:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80097b:	c9                   	leave  
  80097c:	c3                   	ret    

0080097d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80097d:	55                   	push   %ebp
  80097e:	89 e5                	mov    %esp,%ebp
  800980:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800983:	8b 45 08             	mov    0x8(%ebp),%eax
  800986:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800989:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80098d:	74 30                	je     8009bf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80098f:	eb 16                	jmp    8009a7 <strlcpy+0x2a>
			*dst++ = *src++;
  800991:	8b 45 08             	mov    0x8(%ebp),%eax
  800994:	8d 50 01             	lea    0x1(%eax),%edx
  800997:	89 55 08             	mov    %edx,0x8(%ebp)
  80099a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099d:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009a0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009a3:	8a 12                	mov    (%edx),%dl
  8009a5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009a7:	ff 4d 10             	decl   0x10(%ebp)
  8009aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ae:	74 09                	je     8009b9 <strlcpy+0x3c>
  8009b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b3:	8a 00                	mov    (%eax),%al
  8009b5:	84 c0                	test   %al,%al
  8009b7:	75 d8                	jne    800991 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8009c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009c5:	29 c2                	sub    %eax,%edx
  8009c7:	89 d0                	mov    %edx,%eax
}
  8009c9:	c9                   	leave  
  8009ca:	c3                   	ret    

008009cb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009cb:	55                   	push   %ebp
  8009cc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009ce:	eb 06                	jmp    8009d6 <strcmp+0xb>
		p++, q++;
  8009d0:	ff 45 08             	incl   0x8(%ebp)
  8009d3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d9:	8a 00                	mov    (%eax),%al
  8009db:	84 c0                	test   %al,%al
  8009dd:	74 0e                	je     8009ed <strcmp+0x22>
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	8a 10                	mov    (%eax),%dl
  8009e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e7:	8a 00                	mov    (%eax),%al
  8009e9:	38 c2                	cmp    %al,%dl
  8009eb:	74 e3                	je     8009d0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	8a 00                	mov    (%eax),%al
  8009f2:	0f b6 d0             	movzbl %al,%edx
  8009f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f8:	8a 00                	mov    (%eax),%al
  8009fa:	0f b6 c0             	movzbl %al,%eax
  8009fd:	29 c2                	sub    %eax,%edx
  8009ff:	89 d0                	mov    %edx,%eax
}
  800a01:	5d                   	pop    %ebp
  800a02:	c3                   	ret    

00800a03 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a03:	55                   	push   %ebp
  800a04:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a06:	eb 09                	jmp    800a11 <strncmp+0xe>
		n--, p++, q++;
  800a08:	ff 4d 10             	decl   0x10(%ebp)
  800a0b:	ff 45 08             	incl   0x8(%ebp)
  800a0e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a11:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a15:	74 17                	je     800a2e <strncmp+0x2b>
  800a17:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1a:	8a 00                	mov    (%eax),%al
  800a1c:	84 c0                	test   %al,%al
  800a1e:	74 0e                	je     800a2e <strncmp+0x2b>
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	8a 10                	mov    (%eax),%dl
  800a25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a28:	8a 00                	mov    (%eax),%al
  800a2a:	38 c2                	cmp    %al,%dl
  800a2c:	74 da                	je     800a08 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a2e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a32:	75 07                	jne    800a3b <strncmp+0x38>
		return 0;
  800a34:	b8 00 00 00 00       	mov    $0x0,%eax
  800a39:	eb 14                	jmp    800a4f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3e:	8a 00                	mov    (%eax),%al
  800a40:	0f b6 d0             	movzbl %al,%edx
  800a43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a46:	8a 00                	mov    (%eax),%al
  800a48:	0f b6 c0             	movzbl %al,%eax
  800a4b:	29 c2                	sub    %eax,%edx
  800a4d:	89 d0                	mov    %edx,%eax
}
  800a4f:	5d                   	pop    %ebp
  800a50:	c3                   	ret    

00800a51 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a51:	55                   	push   %ebp
  800a52:	89 e5                	mov    %esp,%ebp
  800a54:	83 ec 04             	sub    $0x4,%esp
  800a57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a5d:	eb 12                	jmp    800a71 <strchr+0x20>
		if (*s == c)
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	8a 00                	mov    (%eax),%al
  800a64:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a67:	75 05                	jne    800a6e <strchr+0x1d>
			return (char *) s;
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	eb 11                	jmp    800a7f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a6e:	ff 45 08             	incl   0x8(%ebp)
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	8a 00                	mov    (%eax),%al
  800a76:	84 c0                	test   %al,%al
  800a78:	75 e5                	jne    800a5f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a7f:	c9                   	leave  
  800a80:	c3                   	ret    

00800a81 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a81:	55                   	push   %ebp
  800a82:	89 e5                	mov    %esp,%ebp
  800a84:	83 ec 04             	sub    $0x4,%esp
  800a87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a8d:	eb 0d                	jmp    800a9c <strfind+0x1b>
		if (*s == c)
  800a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a92:	8a 00                	mov    (%eax),%al
  800a94:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a97:	74 0e                	je     800aa7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800a99:	ff 45 08             	incl   0x8(%ebp)
  800a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9f:	8a 00                	mov    (%eax),%al
  800aa1:	84 c0                	test   %al,%al
  800aa3:	75 ea                	jne    800a8f <strfind+0xe>
  800aa5:	eb 01                	jmp    800aa8 <strfind+0x27>
		if (*s == c)
			break;
  800aa7:	90                   	nop
	return (char *) s;
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aab:	c9                   	leave  
  800aac:	c3                   	ret    

00800aad <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800aad:	55                   	push   %ebp
  800aae:	89 e5                	mov    %esp,%ebp
  800ab0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ab9:	8b 45 10             	mov    0x10(%ebp),%eax
  800abc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800abf:	eb 0e                	jmp    800acf <memset+0x22>
		*p++ = c;
  800ac1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ac4:	8d 50 01             	lea    0x1(%eax),%edx
  800ac7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800aca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800acd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800acf:	ff 4d f8             	decl   -0x8(%ebp)
  800ad2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ad6:	79 e9                	jns    800ac1 <memset+0x14>
		*p++ = c;

	return v;
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800adb:	c9                   	leave  
  800adc:	c3                   	ret    

00800add <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800add:	55                   	push   %ebp
  800ade:	89 e5                	mov    %esp,%ebp
  800ae0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ae3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800aef:	eb 16                	jmp    800b07 <memcpy+0x2a>
		*d++ = *s++;
  800af1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800af4:	8d 50 01             	lea    0x1(%eax),%edx
  800af7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800afa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800afd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b00:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b03:	8a 12                	mov    (%edx),%dl
  800b05:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b07:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b0d:	89 55 10             	mov    %edx,0x10(%ebp)
  800b10:	85 c0                	test   %eax,%eax
  800b12:	75 dd                	jne    800af1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b17:	c9                   	leave  
  800b18:	c3                   	ret    

00800b19 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b19:	55                   	push   %ebp
  800b1a:	89 e5                	mov    %esp,%ebp
  800b1c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b2e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b31:	73 50                	jae    800b83 <memmove+0x6a>
  800b33:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b36:	8b 45 10             	mov    0x10(%ebp),%eax
  800b39:	01 d0                	add    %edx,%eax
  800b3b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b3e:	76 43                	jbe    800b83 <memmove+0x6a>
		s += n;
  800b40:	8b 45 10             	mov    0x10(%ebp),%eax
  800b43:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b46:	8b 45 10             	mov    0x10(%ebp),%eax
  800b49:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b4c:	eb 10                	jmp    800b5e <memmove+0x45>
			*--d = *--s;
  800b4e:	ff 4d f8             	decl   -0x8(%ebp)
  800b51:	ff 4d fc             	decl   -0x4(%ebp)
  800b54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b57:	8a 10                	mov    (%eax),%dl
  800b59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b5c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b61:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b64:	89 55 10             	mov    %edx,0x10(%ebp)
  800b67:	85 c0                	test   %eax,%eax
  800b69:	75 e3                	jne    800b4e <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b6b:	eb 23                	jmp    800b90 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b70:	8d 50 01             	lea    0x1(%eax),%edx
  800b73:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b76:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b79:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b7c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b7f:	8a 12                	mov    (%edx),%dl
  800b81:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b83:	8b 45 10             	mov    0x10(%ebp),%eax
  800b86:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b89:	89 55 10             	mov    %edx,0x10(%ebp)
  800b8c:	85 c0                	test   %eax,%eax
  800b8e:	75 dd                	jne    800b6d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b93:	c9                   	leave  
  800b94:	c3                   	ret    

00800b95 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800b95:	55                   	push   %ebp
  800b96:	89 e5                	mov    %esp,%ebp
  800b98:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ba1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ba7:	eb 2a                	jmp    800bd3 <memcmp+0x3e>
		if (*s1 != *s2)
  800ba9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bac:	8a 10                	mov    (%eax),%dl
  800bae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb1:	8a 00                	mov    (%eax),%al
  800bb3:	38 c2                	cmp    %al,%dl
  800bb5:	74 16                	je     800bcd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bba:	8a 00                	mov    (%eax),%al
  800bbc:	0f b6 d0             	movzbl %al,%edx
  800bbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc2:	8a 00                	mov    (%eax),%al
  800bc4:	0f b6 c0             	movzbl %al,%eax
  800bc7:	29 c2                	sub    %eax,%edx
  800bc9:	89 d0                	mov    %edx,%eax
  800bcb:	eb 18                	jmp    800be5 <memcmp+0x50>
		s1++, s2++;
  800bcd:	ff 45 fc             	incl   -0x4(%ebp)
  800bd0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bd3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bdc:	85 c0                	test   %eax,%eax
  800bde:	75 c9                	jne    800ba9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800be0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800be5:	c9                   	leave  
  800be6:	c3                   	ret    

00800be7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
  800bea:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bed:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf3:	01 d0                	add    %edx,%eax
  800bf5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800bf8:	eb 15                	jmp    800c0f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	8a 00                	mov    (%eax),%al
  800bff:	0f b6 d0             	movzbl %al,%edx
  800c02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c05:	0f b6 c0             	movzbl %al,%eax
  800c08:	39 c2                	cmp    %eax,%edx
  800c0a:	74 0d                	je     800c19 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c0c:	ff 45 08             	incl   0x8(%ebp)
  800c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c12:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c15:	72 e3                	jb     800bfa <memfind+0x13>
  800c17:	eb 01                	jmp    800c1a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c19:	90                   	nop
	return (void *) s;
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c1d:	c9                   	leave  
  800c1e:	c3                   	ret    

00800c1f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c1f:	55                   	push   %ebp
  800c20:	89 e5                	mov    %esp,%ebp
  800c22:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c2c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c33:	eb 03                	jmp    800c38 <strtol+0x19>
		s++;
  800c35:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	8a 00                	mov    (%eax),%al
  800c3d:	3c 20                	cmp    $0x20,%al
  800c3f:	74 f4                	je     800c35 <strtol+0x16>
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8a 00                	mov    (%eax),%al
  800c46:	3c 09                	cmp    $0x9,%al
  800c48:	74 eb                	je     800c35 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	8a 00                	mov    (%eax),%al
  800c4f:	3c 2b                	cmp    $0x2b,%al
  800c51:	75 05                	jne    800c58 <strtol+0x39>
		s++;
  800c53:	ff 45 08             	incl   0x8(%ebp)
  800c56:	eb 13                	jmp    800c6b <strtol+0x4c>
	else if (*s == '-')
  800c58:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5b:	8a 00                	mov    (%eax),%al
  800c5d:	3c 2d                	cmp    $0x2d,%al
  800c5f:	75 0a                	jne    800c6b <strtol+0x4c>
		s++, neg = 1;
  800c61:	ff 45 08             	incl   0x8(%ebp)
  800c64:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c6b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c6f:	74 06                	je     800c77 <strtol+0x58>
  800c71:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c75:	75 20                	jne    800c97 <strtol+0x78>
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	8a 00                	mov    (%eax),%al
  800c7c:	3c 30                	cmp    $0x30,%al
  800c7e:	75 17                	jne    800c97 <strtol+0x78>
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	40                   	inc    %eax
  800c84:	8a 00                	mov    (%eax),%al
  800c86:	3c 78                	cmp    $0x78,%al
  800c88:	75 0d                	jne    800c97 <strtol+0x78>
		s += 2, base = 16;
  800c8a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c8e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800c95:	eb 28                	jmp    800cbf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800c97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9b:	75 15                	jne    800cb2 <strtol+0x93>
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	3c 30                	cmp    $0x30,%al
  800ca4:	75 0c                	jne    800cb2 <strtol+0x93>
		s++, base = 8;
  800ca6:	ff 45 08             	incl   0x8(%ebp)
  800ca9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cb0:	eb 0d                	jmp    800cbf <strtol+0xa0>
	else if (base == 0)
  800cb2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb6:	75 07                	jne    800cbf <strtol+0xa0>
		base = 10;
  800cb8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	3c 2f                	cmp    $0x2f,%al
  800cc6:	7e 19                	jle    800ce1 <strtol+0xc2>
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	3c 39                	cmp    $0x39,%al
  800ccf:	7f 10                	jg     800ce1 <strtol+0xc2>
			dig = *s - '0';
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	0f be c0             	movsbl %al,%eax
  800cd9:	83 e8 30             	sub    $0x30,%eax
  800cdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cdf:	eb 42                	jmp    800d23 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8a 00                	mov    (%eax),%al
  800ce6:	3c 60                	cmp    $0x60,%al
  800ce8:	7e 19                	jle    800d03 <strtol+0xe4>
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	3c 7a                	cmp    $0x7a,%al
  800cf1:	7f 10                	jg     800d03 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	8a 00                	mov    (%eax),%al
  800cf8:	0f be c0             	movsbl %al,%eax
  800cfb:	83 e8 57             	sub    $0x57,%eax
  800cfe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d01:	eb 20                	jmp    800d23 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	3c 40                	cmp    $0x40,%al
  800d0a:	7e 39                	jle    800d45 <strtol+0x126>
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8a 00                	mov    (%eax),%al
  800d11:	3c 5a                	cmp    $0x5a,%al
  800d13:	7f 30                	jg     800d45 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	8a 00                	mov    (%eax),%al
  800d1a:	0f be c0             	movsbl %al,%eax
  800d1d:	83 e8 37             	sub    $0x37,%eax
  800d20:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d23:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d26:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d29:	7d 19                	jge    800d44 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d2b:	ff 45 08             	incl   0x8(%ebp)
  800d2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d31:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d35:	89 c2                	mov    %eax,%edx
  800d37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d3a:	01 d0                	add    %edx,%eax
  800d3c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d3f:	e9 7b ff ff ff       	jmp    800cbf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d44:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d45:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d49:	74 08                	je     800d53 <strtol+0x134>
		*endptr = (char *) s;
  800d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d51:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d53:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d57:	74 07                	je     800d60 <strtol+0x141>
  800d59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d5c:	f7 d8                	neg    %eax
  800d5e:	eb 03                	jmp    800d63 <strtol+0x144>
  800d60:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d63:	c9                   	leave  
  800d64:	c3                   	ret    

00800d65 <ltostr>:

void
ltostr(long value, char *str)
{
  800d65:	55                   	push   %ebp
  800d66:	89 e5                	mov    %esp,%ebp
  800d68:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d72:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d79:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d7d:	79 13                	jns    800d92 <ltostr+0x2d>
	{
		neg = 1;
  800d7f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d89:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d8c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d8f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800d9a:	99                   	cltd   
  800d9b:	f7 f9                	idiv   %ecx
  800d9d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800da0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da3:	8d 50 01             	lea    0x1(%eax),%edx
  800da6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800da9:	89 c2                	mov    %eax,%edx
  800dab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dae:	01 d0                	add    %edx,%eax
  800db0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800db3:	83 c2 30             	add    $0x30,%edx
  800db6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800db8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dbb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dc0:	f7 e9                	imul   %ecx
  800dc2:	c1 fa 02             	sar    $0x2,%edx
  800dc5:	89 c8                	mov    %ecx,%eax
  800dc7:	c1 f8 1f             	sar    $0x1f,%eax
  800dca:	29 c2                	sub    %eax,%edx
  800dcc:	89 d0                	mov    %edx,%eax
  800dce:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dd1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dd4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dd9:	f7 e9                	imul   %ecx
  800ddb:	c1 fa 02             	sar    $0x2,%edx
  800dde:	89 c8                	mov    %ecx,%eax
  800de0:	c1 f8 1f             	sar    $0x1f,%eax
  800de3:	29 c2                	sub    %eax,%edx
  800de5:	89 d0                	mov    %edx,%eax
  800de7:	c1 e0 02             	shl    $0x2,%eax
  800dea:	01 d0                	add    %edx,%eax
  800dec:	01 c0                	add    %eax,%eax
  800dee:	29 c1                	sub    %eax,%ecx
  800df0:	89 ca                	mov    %ecx,%edx
  800df2:	85 d2                	test   %edx,%edx
  800df4:	75 9c                	jne    800d92 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800df6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800dfd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e00:	48                   	dec    %eax
  800e01:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e04:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e08:	74 3d                	je     800e47 <ltostr+0xe2>
		start = 1 ;
  800e0a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e11:	eb 34                	jmp    800e47 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e13:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e19:	01 d0                	add    %edx,%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e20:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e26:	01 c2                	add    %eax,%edx
  800e28:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2e:	01 c8                	add    %ecx,%eax
  800e30:	8a 00                	mov    (%eax),%al
  800e32:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e34:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3a:	01 c2                	add    %eax,%edx
  800e3c:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e3f:	88 02                	mov    %al,(%edx)
		start++ ;
  800e41:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e44:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e4a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e4d:	7c c4                	jl     800e13 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e4f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e55:	01 d0                	add    %edx,%eax
  800e57:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e5a:	90                   	nop
  800e5b:	c9                   	leave  
  800e5c:	c3                   	ret    

00800e5d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e5d:	55                   	push   %ebp
  800e5e:	89 e5                	mov    %esp,%ebp
  800e60:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e63:	ff 75 08             	pushl  0x8(%ebp)
  800e66:	e8 54 fa ff ff       	call   8008bf <strlen>
  800e6b:	83 c4 04             	add    $0x4,%esp
  800e6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e71:	ff 75 0c             	pushl  0xc(%ebp)
  800e74:	e8 46 fa ff ff       	call   8008bf <strlen>
  800e79:	83 c4 04             	add    $0x4,%esp
  800e7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e8d:	eb 17                	jmp    800ea6 <strcconcat+0x49>
		final[s] = str1[s] ;
  800e8f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e92:	8b 45 10             	mov    0x10(%ebp),%eax
  800e95:	01 c2                	add    %eax,%edx
  800e97:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	01 c8                	add    %ecx,%eax
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ea3:	ff 45 fc             	incl   -0x4(%ebp)
  800ea6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eac:	7c e1                	jl     800e8f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800eae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800eb5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ebc:	eb 1f                	jmp    800edd <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ebe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec1:	8d 50 01             	lea    0x1(%eax),%edx
  800ec4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ec7:	89 c2                	mov    %eax,%edx
  800ec9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecc:	01 c2                	add    %eax,%edx
  800ece:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed4:	01 c8                	add    %ecx,%eax
  800ed6:	8a 00                	mov    (%eax),%al
  800ed8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800eda:	ff 45 f8             	incl   -0x8(%ebp)
  800edd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ee3:	7c d9                	jl     800ebe <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ee5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee8:	8b 45 10             	mov    0x10(%ebp),%eax
  800eeb:	01 d0                	add    %edx,%eax
  800eed:	c6 00 00             	movb   $0x0,(%eax)
}
  800ef0:	90                   	nop
  800ef1:	c9                   	leave  
  800ef2:	c3                   	ret    

00800ef3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800ef3:	55                   	push   %ebp
  800ef4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800ef6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800eff:	8b 45 14             	mov    0x14(%ebp),%eax
  800f02:	8b 00                	mov    (%eax),%eax
  800f04:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0e:	01 d0                	add    %edx,%eax
  800f10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f16:	eb 0c                	jmp    800f24 <strsplit+0x31>
			*string++ = 0;
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8d 50 01             	lea    0x1(%eax),%edx
  800f1e:	89 55 08             	mov    %edx,0x8(%ebp)
  800f21:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	84 c0                	test   %al,%al
  800f2b:	74 18                	je     800f45 <strsplit+0x52>
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	8a 00                	mov    (%eax),%al
  800f32:	0f be c0             	movsbl %al,%eax
  800f35:	50                   	push   %eax
  800f36:	ff 75 0c             	pushl  0xc(%ebp)
  800f39:	e8 13 fb ff ff       	call   800a51 <strchr>
  800f3e:	83 c4 08             	add    $0x8,%esp
  800f41:	85 c0                	test   %eax,%eax
  800f43:	75 d3                	jne    800f18 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	84 c0                	test   %al,%al
  800f4c:	74 5a                	je     800fa8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f51:	8b 00                	mov    (%eax),%eax
  800f53:	83 f8 0f             	cmp    $0xf,%eax
  800f56:	75 07                	jne    800f5f <strsplit+0x6c>
		{
			return 0;
  800f58:	b8 00 00 00 00       	mov    $0x0,%eax
  800f5d:	eb 66                	jmp    800fc5 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f62:	8b 00                	mov    (%eax),%eax
  800f64:	8d 48 01             	lea    0x1(%eax),%ecx
  800f67:	8b 55 14             	mov    0x14(%ebp),%edx
  800f6a:	89 0a                	mov    %ecx,(%edx)
  800f6c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f73:	8b 45 10             	mov    0x10(%ebp),%eax
  800f76:	01 c2                	add    %eax,%edx
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f7d:	eb 03                	jmp    800f82 <strsplit+0x8f>
			string++;
  800f7f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	84 c0                	test   %al,%al
  800f89:	74 8b                	je     800f16 <strsplit+0x23>
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	0f be c0             	movsbl %al,%eax
  800f93:	50                   	push   %eax
  800f94:	ff 75 0c             	pushl  0xc(%ebp)
  800f97:	e8 b5 fa ff ff       	call   800a51 <strchr>
  800f9c:	83 c4 08             	add    $0x8,%esp
  800f9f:	85 c0                	test   %eax,%eax
  800fa1:	74 dc                	je     800f7f <strsplit+0x8c>
			string++;
	}
  800fa3:	e9 6e ff ff ff       	jmp    800f16 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fa8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fa9:	8b 45 14             	mov    0x14(%ebp),%eax
  800fac:	8b 00                	mov    (%eax),%eax
  800fae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb8:	01 d0                	add    %edx,%eax
  800fba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fc0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fc5:	c9                   	leave  
  800fc6:	c3                   	ret    

00800fc7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fc7:	55                   	push   %ebp
  800fc8:	89 e5                	mov    %esp,%ebp
  800fca:	57                   	push   %edi
  800fcb:	56                   	push   %esi
  800fcc:	53                   	push   %ebx
  800fcd:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fd6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fd9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fdc:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fdf:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fe2:	cd 30                	int    $0x30
  800fe4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800fe7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fea:	83 c4 10             	add    $0x10,%esp
  800fed:	5b                   	pop    %ebx
  800fee:	5e                   	pop    %esi
  800fef:	5f                   	pop    %edi
  800ff0:	5d                   	pop    %ebp
  800ff1:	c3                   	ret    

00800ff2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800ff2:	55                   	push   %ebp
  800ff3:	89 e5                	mov    %esp,%ebp
  800ff5:	83 ec 04             	sub    $0x4,%esp
  800ff8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  800ffe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	6a 00                	push   $0x0
  801007:	6a 00                	push   $0x0
  801009:	52                   	push   %edx
  80100a:	ff 75 0c             	pushl  0xc(%ebp)
  80100d:	50                   	push   %eax
  80100e:	6a 00                	push   $0x0
  801010:	e8 b2 ff ff ff       	call   800fc7 <syscall>
  801015:	83 c4 18             	add    $0x18,%esp
}
  801018:	90                   	nop
  801019:	c9                   	leave  
  80101a:	c3                   	ret    

0080101b <sys_cgetc>:

int
sys_cgetc(void)
{
  80101b:	55                   	push   %ebp
  80101c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80101e:	6a 00                	push   $0x0
  801020:	6a 00                	push   $0x0
  801022:	6a 00                	push   $0x0
  801024:	6a 00                	push   $0x0
  801026:	6a 00                	push   $0x0
  801028:	6a 01                	push   $0x1
  80102a:	e8 98 ff ff ff       	call   800fc7 <syscall>
  80102f:	83 c4 18             	add    $0x18,%esp
}
  801032:	c9                   	leave  
  801033:	c3                   	ret    

00801034 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801034:	55                   	push   %ebp
  801035:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	6a 00                	push   $0x0
  80103c:	6a 00                	push   $0x0
  80103e:	6a 00                	push   $0x0
  801040:	6a 00                	push   $0x0
  801042:	50                   	push   %eax
  801043:	6a 05                	push   $0x5
  801045:	e8 7d ff ff ff       	call   800fc7 <syscall>
  80104a:	83 c4 18             	add    $0x18,%esp
}
  80104d:	c9                   	leave  
  80104e:	c3                   	ret    

0080104f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80104f:	55                   	push   %ebp
  801050:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801052:	6a 00                	push   $0x0
  801054:	6a 00                	push   $0x0
  801056:	6a 00                	push   $0x0
  801058:	6a 00                	push   $0x0
  80105a:	6a 00                	push   $0x0
  80105c:	6a 02                	push   $0x2
  80105e:	e8 64 ff ff ff       	call   800fc7 <syscall>
  801063:	83 c4 18             	add    $0x18,%esp
}
  801066:	c9                   	leave  
  801067:	c3                   	ret    

00801068 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801068:	55                   	push   %ebp
  801069:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80106b:	6a 00                	push   $0x0
  80106d:	6a 00                	push   $0x0
  80106f:	6a 00                	push   $0x0
  801071:	6a 00                	push   $0x0
  801073:	6a 00                	push   $0x0
  801075:	6a 03                	push   $0x3
  801077:	e8 4b ff ff ff       	call   800fc7 <syscall>
  80107c:	83 c4 18             	add    $0x18,%esp
}
  80107f:	c9                   	leave  
  801080:	c3                   	ret    

00801081 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801081:	55                   	push   %ebp
  801082:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801084:	6a 00                	push   $0x0
  801086:	6a 00                	push   $0x0
  801088:	6a 00                	push   $0x0
  80108a:	6a 00                	push   $0x0
  80108c:	6a 00                	push   $0x0
  80108e:	6a 04                	push   $0x4
  801090:	e8 32 ff ff ff       	call   800fc7 <syscall>
  801095:	83 c4 18             	add    $0x18,%esp
}
  801098:	c9                   	leave  
  801099:	c3                   	ret    

0080109a <sys_env_exit>:


void sys_env_exit(void)
{
  80109a:	55                   	push   %ebp
  80109b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80109d:	6a 00                	push   $0x0
  80109f:	6a 00                	push   $0x0
  8010a1:	6a 00                	push   $0x0
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 06                	push   $0x6
  8010a9:	e8 19 ff ff ff       	call   800fc7 <syscall>
  8010ae:	83 c4 18             	add    $0x18,%esp
}
  8010b1:	90                   	nop
  8010b2:	c9                   	leave  
  8010b3:	c3                   	ret    

008010b4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010b4:	55                   	push   %ebp
  8010b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	52                   	push   %edx
  8010c4:	50                   	push   %eax
  8010c5:	6a 07                	push   $0x7
  8010c7:	e8 fb fe ff ff       	call   800fc7 <syscall>
  8010cc:	83 c4 18             	add    $0x18,%esp
}
  8010cf:	c9                   	leave  
  8010d0:	c3                   	ret    

008010d1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010d1:	55                   	push   %ebp
  8010d2:	89 e5                	mov    %esp,%ebp
  8010d4:	56                   	push   %esi
  8010d5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010d6:	8b 75 18             	mov    0x18(%ebp),%esi
  8010d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010dc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	56                   	push   %esi
  8010e6:	53                   	push   %ebx
  8010e7:	51                   	push   %ecx
  8010e8:	52                   	push   %edx
  8010e9:	50                   	push   %eax
  8010ea:	6a 08                	push   $0x8
  8010ec:	e8 d6 fe ff ff       	call   800fc7 <syscall>
  8010f1:	83 c4 18             	add    $0x18,%esp
}
  8010f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010f7:	5b                   	pop    %ebx
  8010f8:	5e                   	pop    %esi
  8010f9:	5d                   	pop    %ebp
  8010fa:	c3                   	ret    

008010fb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8010fb:	55                   	push   %ebp
  8010fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8010fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801101:	8b 45 08             	mov    0x8(%ebp),%eax
  801104:	6a 00                	push   $0x0
  801106:	6a 00                	push   $0x0
  801108:	6a 00                	push   $0x0
  80110a:	52                   	push   %edx
  80110b:	50                   	push   %eax
  80110c:	6a 09                	push   $0x9
  80110e:	e8 b4 fe ff ff       	call   800fc7 <syscall>
  801113:	83 c4 18             	add    $0x18,%esp
}
  801116:	c9                   	leave  
  801117:	c3                   	ret    

00801118 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801118:	55                   	push   %ebp
  801119:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80111b:	6a 00                	push   $0x0
  80111d:	6a 00                	push   $0x0
  80111f:	6a 00                	push   $0x0
  801121:	ff 75 0c             	pushl  0xc(%ebp)
  801124:	ff 75 08             	pushl  0x8(%ebp)
  801127:	6a 0a                	push   $0xa
  801129:	e8 99 fe ff ff       	call   800fc7 <syscall>
  80112e:	83 c4 18             	add    $0x18,%esp
}
  801131:	c9                   	leave  
  801132:	c3                   	ret    

00801133 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801133:	55                   	push   %ebp
  801134:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801136:	6a 00                	push   $0x0
  801138:	6a 00                	push   $0x0
  80113a:	6a 00                	push   $0x0
  80113c:	6a 00                	push   $0x0
  80113e:	6a 00                	push   $0x0
  801140:	6a 0b                	push   $0xb
  801142:	e8 80 fe ff ff       	call   800fc7 <syscall>
  801147:	83 c4 18             	add    $0x18,%esp
}
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	6a 00                	push   $0x0
  801155:	6a 00                	push   $0x0
  801157:	6a 00                	push   $0x0
  801159:	6a 0c                	push   $0xc
  80115b:	e8 67 fe ff ff       	call   800fc7 <syscall>
  801160:	83 c4 18             	add    $0x18,%esp
}
  801163:	c9                   	leave  
  801164:	c3                   	ret    

00801165 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801165:	55                   	push   %ebp
  801166:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	6a 00                	push   $0x0
  80116e:	6a 00                	push   $0x0
  801170:	6a 00                	push   $0x0
  801172:	6a 0d                	push   $0xd
  801174:	e8 4e fe ff ff       	call   800fc7 <syscall>
  801179:	83 c4 18             	add    $0x18,%esp
}
  80117c:	c9                   	leave  
  80117d:	c3                   	ret    

0080117e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80117e:	55                   	push   %ebp
  80117f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 00                	push   $0x0
  801187:	ff 75 0c             	pushl  0xc(%ebp)
  80118a:	ff 75 08             	pushl  0x8(%ebp)
  80118d:	6a 11                	push   $0x11
  80118f:	e8 33 fe ff ff       	call   800fc7 <syscall>
  801194:	83 c4 18             	add    $0x18,%esp
	return;
  801197:	90                   	nop
}
  801198:	c9                   	leave  
  801199:	c3                   	ret    

0080119a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80119a:	55                   	push   %ebp
  80119b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80119d:	6a 00                	push   $0x0
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 00                	push   $0x0
  8011a3:	ff 75 0c             	pushl  0xc(%ebp)
  8011a6:	ff 75 08             	pushl  0x8(%ebp)
  8011a9:	6a 12                	push   $0x12
  8011ab:	e8 17 fe ff ff       	call   800fc7 <syscall>
  8011b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8011b3:	90                   	nop
}
  8011b4:	c9                   	leave  
  8011b5:	c3                   	ret    

008011b6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011b6:	55                   	push   %ebp
  8011b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 0e                	push   $0xe
  8011c5:	e8 fd fd ff ff       	call   800fc7 <syscall>
  8011ca:	83 c4 18             	add    $0x18,%esp
}
  8011cd:	c9                   	leave  
  8011ce:	c3                   	ret    

008011cf <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011cf:	55                   	push   %ebp
  8011d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	ff 75 08             	pushl  0x8(%ebp)
  8011dd:	6a 0f                	push   $0xf
  8011df:	e8 e3 fd ff ff       	call   800fc7 <syscall>
  8011e4:	83 c4 18             	add    $0x18,%esp
}
  8011e7:	c9                   	leave  
  8011e8:	c3                   	ret    

008011e9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011e9:	55                   	push   %ebp
  8011ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 10                	push   $0x10
  8011f8:	e8 ca fd ff ff       	call   800fc7 <syscall>
  8011fd:	83 c4 18             	add    $0x18,%esp
}
  801200:	90                   	nop
  801201:	c9                   	leave  
  801202:	c3                   	ret    

00801203 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801203:	55                   	push   %ebp
  801204:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 00                	push   $0x0
  801210:	6a 14                	push   $0x14
  801212:	e8 b0 fd ff ff       	call   800fc7 <syscall>
  801217:	83 c4 18             	add    $0x18,%esp
}
  80121a:	90                   	nop
  80121b:	c9                   	leave  
  80121c:	c3                   	ret    

0080121d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80121d:	55                   	push   %ebp
  80121e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801220:	6a 00                	push   $0x0
  801222:	6a 00                	push   $0x0
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 15                	push   $0x15
  80122c:	e8 96 fd ff ff       	call   800fc7 <syscall>
  801231:	83 c4 18             	add    $0x18,%esp
}
  801234:	90                   	nop
  801235:	c9                   	leave  
  801236:	c3                   	ret    

00801237 <sys_cputc>:


void
sys_cputc(const char c)
{
  801237:	55                   	push   %ebp
  801238:	89 e5                	mov    %esp,%ebp
  80123a:	83 ec 04             	sub    $0x4,%esp
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801243:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801247:	6a 00                	push   $0x0
  801249:	6a 00                	push   $0x0
  80124b:	6a 00                	push   $0x0
  80124d:	6a 00                	push   $0x0
  80124f:	50                   	push   %eax
  801250:	6a 16                	push   $0x16
  801252:	e8 70 fd ff ff       	call   800fc7 <syscall>
  801257:	83 c4 18             	add    $0x18,%esp
}
  80125a:	90                   	nop
  80125b:	c9                   	leave  
  80125c:	c3                   	ret    

0080125d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801260:	6a 00                	push   $0x0
  801262:	6a 00                	push   $0x0
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 17                	push   $0x17
  80126c:	e8 56 fd ff ff       	call   800fc7 <syscall>
  801271:	83 c4 18             	add    $0x18,%esp
}
  801274:	90                   	nop
  801275:	c9                   	leave  
  801276:	c3                   	ret    

00801277 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801277:	55                   	push   %ebp
  801278:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	6a 00                	push   $0x0
  80127f:	6a 00                	push   $0x0
  801281:	6a 00                	push   $0x0
  801283:	ff 75 0c             	pushl  0xc(%ebp)
  801286:	50                   	push   %eax
  801287:	6a 18                	push   $0x18
  801289:	e8 39 fd ff ff       	call   800fc7 <syscall>
  80128e:	83 c4 18             	add    $0x18,%esp
}
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801296:	8b 55 0c             	mov    0xc(%ebp),%edx
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	52                   	push   %edx
  8012a3:	50                   	push   %eax
  8012a4:	6a 1b                	push   $0x1b
  8012a6:	e8 1c fd ff ff       	call   800fc7 <syscall>
  8012ab:	83 c4 18             	add    $0x18,%esp
}
  8012ae:	c9                   	leave  
  8012af:	c3                   	ret    

008012b0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012b0:	55                   	push   %ebp
  8012b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	52                   	push   %edx
  8012c0:	50                   	push   %eax
  8012c1:	6a 19                	push   $0x19
  8012c3:	e8 ff fc ff ff       	call   800fc7 <syscall>
  8012c8:	83 c4 18             	add    $0x18,%esp
}
  8012cb:	90                   	nop
  8012cc:	c9                   	leave  
  8012cd:	c3                   	ret    

008012ce <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012ce:	55                   	push   %ebp
  8012cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	52                   	push   %edx
  8012de:	50                   	push   %eax
  8012df:	6a 1a                	push   $0x1a
  8012e1:	e8 e1 fc ff ff       	call   800fc7 <syscall>
  8012e6:	83 c4 18             	add    $0x18,%esp
}
  8012e9:	90                   	nop
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
  8012ef:	83 ec 04             	sub    $0x4,%esp
  8012f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8012f8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012fb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	6a 00                	push   $0x0
  801304:	51                   	push   %ecx
  801305:	52                   	push   %edx
  801306:	ff 75 0c             	pushl  0xc(%ebp)
  801309:	50                   	push   %eax
  80130a:	6a 1c                	push   $0x1c
  80130c:	e8 b6 fc ff ff       	call   800fc7 <syscall>
  801311:	83 c4 18             	add    $0x18,%esp
}
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801319:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	52                   	push   %edx
  801326:	50                   	push   %eax
  801327:	6a 1d                	push   $0x1d
  801329:	e8 99 fc ff ff       	call   800fc7 <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	c9                   	leave  
  801332:	c3                   	ret    

00801333 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801336:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801339:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	51                   	push   %ecx
  801344:	52                   	push   %edx
  801345:	50                   	push   %eax
  801346:	6a 1e                	push   $0x1e
  801348:	e8 7a fc ff ff       	call   800fc7 <syscall>
  80134d:	83 c4 18             	add    $0x18,%esp
}
  801350:	c9                   	leave  
  801351:	c3                   	ret    

00801352 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801352:	55                   	push   %ebp
  801353:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801355:	8b 55 0c             	mov    0xc(%ebp),%edx
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	52                   	push   %edx
  801362:	50                   	push   %eax
  801363:	6a 1f                	push   $0x1f
  801365:	e8 5d fc ff ff       	call   800fc7 <syscall>
  80136a:	83 c4 18             	add    $0x18,%esp
}
  80136d:	c9                   	leave  
  80136e:	c3                   	ret    

0080136f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80136f:	55                   	push   %ebp
  801370:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 20                	push   $0x20
  80137e:	e8 44 fc ff ff       	call   800fc7 <syscall>
  801383:	83 c4 18             	add    $0x18,%esp
}
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	ff 75 10             	pushl  0x10(%ebp)
  801395:	ff 75 0c             	pushl  0xc(%ebp)
  801398:	50                   	push   %eax
  801399:	6a 21                	push   $0x21
  80139b:	e8 27 fc ff ff       	call   800fc7 <syscall>
  8013a0:	83 c4 18             	add    $0x18,%esp
}
  8013a3:	c9                   	leave  
  8013a4:	c3                   	ret    

008013a5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	50                   	push   %eax
  8013b4:	6a 22                	push   $0x22
  8013b6:	e8 0c fc ff ff       	call   800fc7 <syscall>
  8013bb:	83 c4 18             	add    $0x18,%esp
}
  8013be:	90                   	nop
  8013bf:	c9                   	leave  
  8013c0:	c3                   	ret    

008013c1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013c1:	55                   	push   %ebp
  8013c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	50                   	push   %eax
  8013d0:	6a 23                	push   $0x23
  8013d2:	e8 f0 fb ff ff       	call   800fc7 <syscall>
  8013d7:	83 c4 18             	add    $0x18,%esp
}
  8013da:	90                   	nop
  8013db:	c9                   	leave  
  8013dc:	c3                   	ret    

008013dd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
  8013e0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013e3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013e6:	8d 50 04             	lea    0x4(%eax),%edx
  8013e9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	52                   	push   %edx
  8013f3:	50                   	push   %eax
  8013f4:	6a 24                	push   $0x24
  8013f6:	e8 cc fb ff ff       	call   800fc7 <syscall>
  8013fb:	83 c4 18             	add    $0x18,%esp
	return result;
  8013fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801401:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801404:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801407:	89 01                	mov    %eax,(%ecx)
  801409:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	c9                   	leave  
  801410:	c2 04 00             	ret    $0x4

00801413 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	ff 75 10             	pushl  0x10(%ebp)
  80141d:	ff 75 0c             	pushl  0xc(%ebp)
  801420:	ff 75 08             	pushl  0x8(%ebp)
  801423:	6a 13                	push   $0x13
  801425:	e8 9d fb ff ff       	call   800fc7 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
	return ;
  80142d:	90                   	nop
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_rcr2>:
uint32 sys_rcr2()
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 25                	push   $0x25
  80143f:	e8 83 fb ff ff       	call   800fc7 <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
  80144c:	83 ec 04             	sub    $0x4,%esp
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801455:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	50                   	push   %eax
  801462:	6a 26                	push   $0x26
  801464:	e8 5e fb ff ff       	call   800fc7 <syscall>
  801469:	83 c4 18             	add    $0x18,%esp
	return ;
  80146c:	90                   	nop
}
  80146d:	c9                   	leave  
  80146e:	c3                   	ret    

0080146f <rsttst>:
void rsttst()
{
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 28                	push   $0x28
  80147e:	e8 44 fb ff ff       	call   800fc7 <syscall>
  801483:	83 c4 18             	add    $0x18,%esp
	return ;
  801486:	90                   	nop
}
  801487:	c9                   	leave  
  801488:	c3                   	ret    

00801489 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801489:	55                   	push   %ebp
  80148a:	89 e5                	mov    %esp,%ebp
  80148c:	83 ec 04             	sub    $0x4,%esp
  80148f:	8b 45 14             	mov    0x14(%ebp),%eax
  801492:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801495:	8b 55 18             	mov    0x18(%ebp),%edx
  801498:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80149c:	52                   	push   %edx
  80149d:	50                   	push   %eax
  80149e:	ff 75 10             	pushl  0x10(%ebp)
  8014a1:	ff 75 0c             	pushl  0xc(%ebp)
  8014a4:	ff 75 08             	pushl  0x8(%ebp)
  8014a7:	6a 27                	push   $0x27
  8014a9:	e8 19 fb ff ff       	call   800fc7 <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b1:	90                   	nop
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <chktst>:
void chktst(uint32 n)
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	ff 75 08             	pushl  0x8(%ebp)
  8014c2:	6a 29                	push   $0x29
  8014c4:	e8 fe fa ff ff       	call   800fc7 <syscall>
  8014c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014cc:	90                   	nop
}
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <inctst>:

void inctst()
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 2a                	push   $0x2a
  8014de:	e8 e4 fa ff ff       	call   800fc7 <syscall>
  8014e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e6:	90                   	nop
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <gettst>:
uint32 gettst()
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 2b                	push   $0x2b
  8014f8:	e8 ca fa ff ff       	call   800fc7 <syscall>
  8014fd:	83 c4 18             	add    $0x18,%esp
}
  801500:	c9                   	leave  
  801501:	c3                   	ret    

00801502 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801502:	55                   	push   %ebp
  801503:	89 e5                	mov    %esp,%ebp
  801505:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 2c                	push   $0x2c
  801514:	e8 ae fa ff ff       	call   800fc7 <syscall>
  801519:	83 c4 18             	add    $0x18,%esp
  80151c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80151f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801523:	75 07                	jne    80152c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801525:	b8 01 00 00 00       	mov    $0x1,%eax
  80152a:	eb 05                	jmp    801531 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80152c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
  801536:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 2c                	push   $0x2c
  801545:	e8 7d fa ff ff       	call   800fc7 <syscall>
  80154a:	83 c4 18             	add    $0x18,%esp
  80154d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801550:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801554:	75 07                	jne    80155d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801556:	b8 01 00 00 00       	mov    $0x1,%eax
  80155b:	eb 05                	jmp    801562 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80155d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
  801567:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 2c                	push   $0x2c
  801576:	e8 4c fa ff ff       	call   800fc7 <syscall>
  80157b:	83 c4 18             	add    $0x18,%esp
  80157e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801581:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801585:	75 07                	jne    80158e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801587:	b8 01 00 00 00       	mov    $0x1,%eax
  80158c:	eb 05                	jmp    801593 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80158e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801593:	c9                   	leave  
  801594:	c3                   	ret    

00801595 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801595:	55                   	push   %ebp
  801596:	89 e5                	mov    %esp,%ebp
  801598:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 2c                	push   $0x2c
  8015a7:	e8 1b fa ff ff       	call   800fc7 <syscall>
  8015ac:	83 c4 18             	add    $0x18,%esp
  8015af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015b2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015b6:	75 07                	jne    8015bf <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015b8:	b8 01 00 00 00       	mov    $0x1,%eax
  8015bd:	eb 05                	jmp    8015c4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c4:	c9                   	leave  
  8015c5:	c3                   	ret    

008015c6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	ff 75 08             	pushl  0x8(%ebp)
  8015d4:	6a 2d                	push   $0x2d
  8015d6:	e8 ec f9 ff ff       	call   800fc7 <syscall>
  8015db:	83 c4 18             	add    $0x18,%esp
	return ;
  8015de:	90                   	nop
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    
  8015e1:	66 90                	xchg   %ax,%ax
  8015e3:	90                   	nop

008015e4 <__udivdi3>:
  8015e4:	55                   	push   %ebp
  8015e5:	57                   	push   %edi
  8015e6:	56                   	push   %esi
  8015e7:	53                   	push   %ebx
  8015e8:	83 ec 1c             	sub    $0x1c,%esp
  8015eb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8015ef:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8015f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8015f7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8015fb:	89 ca                	mov    %ecx,%edx
  8015fd:	89 f8                	mov    %edi,%eax
  8015ff:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801603:	85 f6                	test   %esi,%esi
  801605:	75 2d                	jne    801634 <__udivdi3+0x50>
  801607:	39 cf                	cmp    %ecx,%edi
  801609:	77 65                	ja     801670 <__udivdi3+0x8c>
  80160b:	89 fd                	mov    %edi,%ebp
  80160d:	85 ff                	test   %edi,%edi
  80160f:	75 0b                	jne    80161c <__udivdi3+0x38>
  801611:	b8 01 00 00 00       	mov    $0x1,%eax
  801616:	31 d2                	xor    %edx,%edx
  801618:	f7 f7                	div    %edi
  80161a:	89 c5                	mov    %eax,%ebp
  80161c:	31 d2                	xor    %edx,%edx
  80161e:	89 c8                	mov    %ecx,%eax
  801620:	f7 f5                	div    %ebp
  801622:	89 c1                	mov    %eax,%ecx
  801624:	89 d8                	mov    %ebx,%eax
  801626:	f7 f5                	div    %ebp
  801628:	89 cf                	mov    %ecx,%edi
  80162a:	89 fa                	mov    %edi,%edx
  80162c:	83 c4 1c             	add    $0x1c,%esp
  80162f:	5b                   	pop    %ebx
  801630:	5e                   	pop    %esi
  801631:	5f                   	pop    %edi
  801632:	5d                   	pop    %ebp
  801633:	c3                   	ret    
  801634:	39 ce                	cmp    %ecx,%esi
  801636:	77 28                	ja     801660 <__udivdi3+0x7c>
  801638:	0f bd fe             	bsr    %esi,%edi
  80163b:	83 f7 1f             	xor    $0x1f,%edi
  80163e:	75 40                	jne    801680 <__udivdi3+0x9c>
  801640:	39 ce                	cmp    %ecx,%esi
  801642:	72 0a                	jb     80164e <__udivdi3+0x6a>
  801644:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801648:	0f 87 9e 00 00 00    	ja     8016ec <__udivdi3+0x108>
  80164e:	b8 01 00 00 00       	mov    $0x1,%eax
  801653:	89 fa                	mov    %edi,%edx
  801655:	83 c4 1c             	add    $0x1c,%esp
  801658:	5b                   	pop    %ebx
  801659:	5e                   	pop    %esi
  80165a:	5f                   	pop    %edi
  80165b:	5d                   	pop    %ebp
  80165c:	c3                   	ret    
  80165d:	8d 76 00             	lea    0x0(%esi),%esi
  801660:	31 ff                	xor    %edi,%edi
  801662:	31 c0                	xor    %eax,%eax
  801664:	89 fa                	mov    %edi,%edx
  801666:	83 c4 1c             	add    $0x1c,%esp
  801669:	5b                   	pop    %ebx
  80166a:	5e                   	pop    %esi
  80166b:	5f                   	pop    %edi
  80166c:	5d                   	pop    %ebp
  80166d:	c3                   	ret    
  80166e:	66 90                	xchg   %ax,%ax
  801670:	89 d8                	mov    %ebx,%eax
  801672:	f7 f7                	div    %edi
  801674:	31 ff                	xor    %edi,%edi
  801676:	89 fa                	mov    %edi,%edx
  801678:	83 c4 1c             	add    $0x1c,%esp
  80167b:	5b                   	pop    %ebx
  80167c:	5e                   	pop    %esi
  80167d:	5f                   	pop    %edi
  80167e:	5d                   	pop    %ebp
  80167f:	c3                   	ret    
  801680:	bd 20 00 00 00       	mov    $0x20,%ebp
  801685:	89 eb                	mov    %ebp,%ebx
  801687:	29 fb                	sub    %edi,%ebx
  801689:	89 f9                	mov    %edi,%ecx
  80168b:	d3 e6                	shl    %cl,%esi
  80168d:	89 c5                	mov    %eax,%ebp
  80168f:	88 d9                	mov    %bl,%cl
  801691:	d3 ed                	shr    %cl,%ebp
  801693:	89 e9                	mov    %ebp,%ecx
  801695:	09 f1                	or     %esi,%ecx
  801697:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80169b:	89 f9                	mov    %edi,%ecx
  80169d:	d3 e0                	shl    %cl,%eax
  80169f:	89 c5                	mov    %eax,%ebp
  8016a1:	89 d6                	mov    %edx,%esi
  8016a3:	88 d9                	mov    %bl,%cl
  8016a5:	d3 ee                	shr    %cl,%esi
  8016a7:	89 f9                	mov    %edi,%ecx
  8016a9:	d3 e2                	shl    %cl,%edx
  8016ab:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016af:	88 d9                	mov    %bl,%cl
  8016b1:	d3 e8                	shr    %cl,%eax
  8016b3:	09 c2                	or     %eax,%edx
  8016b5:	89 d0                	mov    %edx,%eax
  8016b7:	89 f2                	mov    %esi,%edx
  8016b9:	f7 74 24 0c          	divl   0xc(%esp)
  8016bd:	89 d6                	mov    %edx,%esi
  8016bf:	89 c3                	mov    %eax,%ebx
  8016c1:	f7 e5                	mul    %ebp
  8016c3:	39 d6                	cmp    %edx,%esi
  8016c5:	72 19                	jb     8016e0 <__udivdi3+0xfc>
  8016c7:	74 0b                	je     8016d4 <__udivdi3+0xf0>
  8016c9:	89 d8                	mov    %ebx,%eax
  8016cb:	31 ff                	xor    %edi,%edi
  8016cd:	e9 58 ff ff ff       	jmp    80162a <__udivdi3+0x46>
  8016d2:	66 90                	xchg   %ax,%ax
  8016d4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8016d8:	89 f9                	mov    %edi,%ecx
  8016da:	d3 e2                	shl    %cl,%edx
  8016dc:	39 c2                	cmp    %eax,%edx
  8016de:	73 e9                	jae    8016c9 <__udivdi3+0xe5>
  8016e0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8016e3:	31 ff                	xor    %edi,%edi
  8016e5:	e9 40 ff ff ff       	jmp    80162a <__udivdi3+0x46>
  8016ea:	66 90                	xchg   %ax,%ax
  8016ec:	31 c0                	xor    %eax,%eax
  8016ee:	e9 37 ff ff ff       	jmp    80162a <__udivdi3+0x46>
  8016f3:	90                   	nop

008016f4 <__umoddi3>:
  8016f4:	55                   	push   %ebp
  8016f5:	57                   	push   %edi
  8016f6:	56                   	push   %esi
  8016f7:	53                   	push   %ebx
  8016f8:	83 ec 1c             	sub    $0x1c,%esp
  8016fb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8016ff:	8b 74 24 34          	mov    0x34(%esp),%esi
  801703:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801707:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80170b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80170f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801713:	89 f3                	mov    %esi,%ebx
  801715:	89 fa                	mov    %edi,%edx
  801717:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80171b:	89 34 24             	mov    %esi,(%esp)
  80171e:	85 c0                	test   %eax,%eax
  801720:	75 1a                	jne    80173c <__umoddi3+0x48>
  801722:	39 f7                	cmp    %esi,%edi
  801724:	0f 86 a2 00 00 00    	jbe    8017cc <__umoddi3+0xd8>
  80172a:	89 c8                	mov    %ecx,%eax
  80172c:	89 f2                	mov    %esi,%edx
  80172e:	f7 f7                	div    %edi
  801730:	89 d0                	mov    %edx,%eax
  801732:	31 d2                	xor    %edx,%edx
  801734:	83 c4 1c             	add    $0x1c,%esp
  801737:	5b                   	pop    %ebx
  801738:	5e                   	pop    %esi
  801739:	5f                   	pop    %edi
  80173a:	5d                   	pop    %ebp
  80173b:	c3                   	ret    
  80173c:	39 f0                	cmp    %esi,%eax
  80173e:	0f 87 ac 00 00 00    	ja     8017f0 <__umoddi3+0xfc>
  801744:	0f bd e8             	bsr    %eax,%ebp
  801747:	83 f5 1f             	xor    $0x1f,%ebp
  80174a:	0f 84 ac 00 00 00    	je     8017fc <__umoddi3+0x108>
  801750:	bf 20 00 00 00       	mov    $0x20,%edi
  801755:	29 ef                	sub    %ebp,%edi
  801757:	89 fe                	mov    %edi,%esi
  801759:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80175d:	89 e9                	mov    %ebp,%ecx
  80175f:	d3 e0                	shl    %cl,%eax
  801761:	89 d7                	mov    %edx,%edi
  801763:	89 f1                	mov    %esi,%ecx
  801765:	d3 ef                	shr    %cl,%edi
  801767:	09 c7                	or     %eax,%edi
  801769:	89 e9                	mov    %ebp,%ecx
  80176b:	d3 e2                	shl    %cl,%edx
  80176d:	89 14 24             	mov    %edx,(%esp)
  801770:	89 d8                	mov    %ebx,%eax
  801772:	d3 e0                	shl    %cl,%eax
  801774:	89 c2                	mov    %eax,%edx
  801776:	8b 44 24 08          	mov    0x8(%esp),%eax
  80177a:	d3 e0                	shl    %cl,%eax
  80177c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801780:	8b 44 24 08          	mov    0x8(%esp),%eax
  801784:	89 f1                	mov    %esi,%ecx
  801786:	d3 e8                	shr    %cl,%eax
  801788:	09 d0                	or     %edx,%eax
  80178a:	d3 eb                	shr    %cl,%ebx
  80178c:	89 da                	mov    %ebx,%edx
  80178e:	f7 f7                	div    %edi
  801790:	89 d3                	mov    %edx,%ebx
  801792:	f7 24 24             	mull   (%esp)
  801795:	89 c6                	mov    %eax,%esi
  801797:	89 d1                	mov    %edx,%ecx
  801799:	39 d3                	cmp    %edx,%ebx
  80179b:	0f 82 87 00 00 00    	jb     801828 <__umoddi3+0x134>
  8017a1:	0f 84 91 00 00 00    	je     801838 <__umoddi3+0x144>
  8017a7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8017ab:	29 f2                	sub    %esi,%edx
  8017ad:	19 cb                	sbb    %ecx,%ebx
  8017af:	89 d8                	mov    %ebx,%eax
  8017b1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017b5:	d3 e0                	shl    %cl,%eax
  8017b7:	89 e9                	mov    %ebp,%ecx
  8017b9:	d3 ea                	shr    %cl,%edx
  8017bb:	09 d0                	or     %edx,%eax
  8017bd:	89 e9                	mov    %ebp,%ecx
  8017bf:	d3 eb                	shr    %cl,%ebx
  8017c1:	89 da                	mov    %ebx,%edx
  8017c3:	83 c4 1c             	add    $0x1c,%esp
  8017c6:	5b                   	pop    %ebx
  8017c7:	5e                   	pop    %esi
  8017c8:	5f                   	pop    %edi
  8017c9:	5d                   	pop    %ebp
  8017ca:	c3                   	ret    
  8017cb:	90                   	nop
  8017cc:	89 fd                	mov    %edi,%ebp
  8017ce:	85 ff                	test   %edi,%edi
  8017d0:	75 0b                	jne    8017dd <__umoddi3+0xe9>
  8017d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d7:	31 d2                	xor    %edx,%edx
  8017d9:	f7 f7                	div    %edi
  8017db:	89 c5                	mov    %eax,%ebp
  8017dd:	89 f0                	mov    %esi,%eax
  8017df:	31 d2                	xor    %edx,%edx
  8017e1:	f7 f5                	div    %ebp
  8017e3:	89 c8                	mov    %ecx,%eax
  8017e5:	f7 f5                	div    %ebp
  8017e7:	89 d0                	mov    %edx,%eax
  8017e9:	e9 44 ff ff ff       	jmp    801732 <__umoddi3+0x3e>
  8017ee:	66 90                	xchg   %ax,%ax
  8017f0:	89 c8                	mov    %ecx,%eax
  8017f2:	89 f2                	mov    %esi,%edx
  8017f4:	83 c4 1c             	add    $0x1c,%esp
  8017f7:	5b                   	pop    %ebx
  8017f8:	5e                   	pop    %esi
  8017f9:	5f                   	pop    %edi
  8017fa:	5d                   	pop    %ebp
  8017fb:	c3                   	ret    
  8017fc:	3b 04 24             	cmp    (%esp),%eax
  8017ff:	72 06                	jb     801807 <__umoddi3+0x113>
  801801:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801805:	77 0f                	ja     801816 <__umoddi3+0x122>
  801807:	89 f2                	mov    %esi,%edx
  801809:	29 f9                	sub    %edi,%ecx
  80180b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80180f:	89 14 24             	mov    %edx,(%esp)
  801812:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801816:	8b 44 24 04          	mov    0x4(%esp),%eax
  80181a:	8b 14 24             	mov    (%esp),%edx
  80181d:	83 c4 1c             	add    $0x1c,%esp
  801820:	5b                   	pop    %ebx
  801821:	5e                   	pop    %esi
  801822:	5f                   	pop    %edi
  801823:	5d                   	pop    %ebp
  801824:	c3                   	ret    
  801825:	8d 76 00             	lea    0x0(%esi),%esi
  801828:	2b 04 24             	sub    (%esp),%eax
  80182b:	19 fa                	sbb    %edi,%edx
  80182d:	89 d1                	mov    %edx,%ecx
  80182f:	89 c6                	mov    %eax,%esi
  801831:	e9 71 ff ff ff       	jmp    8017a7 <__umoddi3+0xb3>
  801836:	66 90                	xchg   %ax,%ax
  801838:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80183c:	72 ea                	jb     801828 <__umoddi3+0x134>
  80183e:	89 d9                	mov    %ebx,%ecx
  801840:	e9 62 ff ff ff       	jmp    8017a7 <__umoddi3+0xb3>
