
obj/user/concurrent_start:     file format elf32-i386


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
  800031:	e8 b5 00 00 00       	call   8000eb <libmain>
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
  80003b:	83 ec 18             	sub    $0x18,%esp
	char *str ;
	sys_createSharedObject("cnc1", 512, 1, (void*) &str);
  80003e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800041:	50                   	push   %eax
  800042:	6a 01                	push   $0x1
  800044:	68 00 02 00 00       	push   $0x200
  800049:	68 e0 18 80 00       	push   $0x8018e0
  80004e:	e8 1d 13 00 00       	call   801370 <sys_createSharedObject>
  800053:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("cnc1", 1);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	6a 01                	push   $0x1
  80005b:	68 e0 18 80 00       	push   $0x8018e0
  800060:	e8 96 12 00 00       	call   8012fb <sys_createSemaphore>
  800065:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore("depend1", 0);
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	6a 00                	push   $0x0
  80006d:	68 e5 18 80 00       	push   $0x8018e5
  800072:	e8 84 12 00 00       	call   8012fb <sys_createSemaphore>
  800077:	83 c4 10             	add    $0x10,%esp

	uint32 id1, id2;
	id2 = sys_create_env("qs2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80007a:	a1 04 20 80 00       	mov    0x802004,%eax
  80007f:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800085:	a1 04 20 80 00       	mov    0x802004,%eax
  80008a:	8b 40 74             	mov    0x74(%eax),%eax
  80008d:	83 ec 04             	sub    $0x4,%esp
  800090:	52                   	push   %edx
  800091:	50                   	push   %eax
  800092:	68 ed 18 80 00       	push   $0x8018ed
  800097:	e8 70 13 00 00       	call   80140c <sys_create_env>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	id1 = sys_create_env("qs1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000a2:	a1 04 20 80 00       	mov    0x802004,%eax
  8000a7:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000ad:	a1 04 20 80 00       	mov    0x802004,%eax
  8000b2:	8b 40 74             	mov    0x74(%eax),%eax
  8000b5:	83 ec 04             	sub    $0x4,%esp
  8000b8:	52                   	push   %edx
  8000b9:	50                   	push   %eax
  8000ba:	68 f1 18 80 00       	push   $0x8018f1
  8000bf:	e8 48 13 00 00       	call   80140c <sys_create_env>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 45 f0             	mov    %eax,-0x10(%ebp)

	sys_run_env(id2);
  8000ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cd:	83 ec 0c             	sub    $0xc,%esp
  8000d0:	50                   	push   %eax
  8000d1:	e8 53 13 00 00       	call   801429 <sys_run_env>
  8000d6:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id1);
  8000d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000dc:	83 ec 0c             	sub    $0xc,%esp
  8000df:	50                   	push   %eax
  8000e0:	e8 44 13 00 00       	call   801429 <sys_run_env>
  8000e5:	83 c4 10             	add    $0x10,%esp

	return;
  8000e8:	90                   	nop
}
  8000e9:	c9                   	leave  
  8000ea:	c3                   	ret    

008000eb <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000eb:	55                   	push   %ebp
  8000ec:	89 e5                	mov    %esp,%ebp
  8000ee:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000f1:	e8 f6 0f 00 00       	call   8010ec <sys_getenvindex>
  8000f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000fc:	89 d0                	mov    %edx,%eax
  8000fe:	01 c0                	add    %eax,%eax
  800100:	01 d0                	add    %edx,%eax
  800102:	c1 e0 02             	shl    $0x2,%eax
  800105:	01 d0                	add    %edx,%eax
  800107:	c1 e0 06             	shl    $0x6,%eax
  80010a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80010f:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800114:	a1 04 20 80 00       	mov    0x802004,%eax
  800119:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80011f:	84 c0                	test   %al,%al
  800121:	74 0f                	je     800132 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800123:	a1 04 20 80 00       	mov    0x802004,%eax
  800128:	05 f4 02 00 00       	add    $0x2f4,%eax
  80012d:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800132:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800136:	7e 0a                	jle    800142 <libmain+0x57>
		binaryname = argv[0];
  800138:	8b 45 0c             	mov    0xc(%ebp),%eax
  80013b:	8b 00                	mov    (%eax),%eax
  80013d:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800142:	83 ec 08             	sub    $0x8,%esp
  800145:	ff 75 0c             	pushl  0xc(%ebp)
  800148:	ff 75 08             	pushl  0x8(%ebp)
  80014b:	e8 e8 fe ff ff       	call   800038 <_main>
  800150:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800153:	e8 2f 11 00 00       	call   801287 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800158:	83 ec 0c             	sub    $0xc,%esp
  80015b:	68 10 19 80 00       	push   $0x801910
  800160:	e8 5c 01 00 00       	call   8002c1 <cprintf>
  800165:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800168:	a1 04 20 80 00       	mov    0x802004,%eax
  80016d:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800173:	a1 04 20 80 00       	mov    0x802004,%eax
  800178:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80017e:	83 ec 04             	sub    $0x4,%esp
  800181:	52                   	push   %edx
  800182:	50                   	push   %eax
  800183:	68 38 19 80 00       	push   $0x801938
  800188:	e8 34 01 00 00       	call   8002c1 <cprintf>
  80018d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800190:	a1 04 20 80 00       	mov    0x802004,%eax
  800195:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80019b:	83 ec 08             	sub    $0x8,%esp
  80019e:	50                   	push   %eax
  80019f:	68 5d 19 80 00       	push   $0x80195d
  8001a4:	e8 18 01 00 00       	call   8002c1 <cprintf>
  8001a9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001ac:	83 ec 0c             	sub    $0xc,%esp
  8001af:	68 10 19 80 00       	push   $0x801910
  8001b4:	e8 08 01 00 00       	call   8002c1 <cprintf>
  8001b9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001bc:	e8 e0 10 00 00       	call   8012a1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001c1:	e8 19 00 00 00       	call   8001df <exit>
}
  8001c6:	90                   	nop
  8001c7:	c9                   	leave  
  8001c8:	c3                   	ret    

008001c9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001c9:	55                   	push   %ebp
  8001ca:	89 e5                	mov    %esp,%ebp
  8001cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001cf:	83 ec 0c             	sub    $0xc,%esp
  8001d2:	6a 00                	push   $0x0
  8001d4:	e8 df 0e 00 00       	call   8010b8 <sys_env_destroy>
  8001d9:	83 c4 10             	add    $0x10,%esp
}
  8001dc:	90                   	nop
  8001dd:	c9                   	leave  
  8001de:	c3                   	ret    

008001df <exit>:

void
exit(void)
{
  8001df:	55                   	push   %ebp
  8001e0:	89 e5                	mov    %esp,%ebp
  8001e2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001e5:	e8 34 0f 00 00       	call   80111e <sys_env_exit>
}
  8001ea:	90                   	nop
  8001eb:	c9                   	leave  
  8001ec:	c3                   	ret    

008001ed <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001ed:	55                   	push   %ebp
  8001ee:	89 e5                	mov    %esp,%ebp
  8001f0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f6:	8b 00                	mov    (%eax),%eax
  8001f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8001fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fe:	89 0a                	mov    %ecx,(%edx)
  800200:	8b 55 08             	mov    0x8(%ebp),%edx
  800203:	88 d1                	mov    %dl,%cl
  800205:	8b 55 0c             	mov    0xc(%ebp),%edx
  800208:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80020c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020f:	8b 00                	mov    (%eax),%eax
  800211:	3d ff 00 00 00       	cmp    $0xff,%eax
  800216:	75 2c                	jne    800244 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800218:	a0 08 20 80 00       	mov    0x802008,%al
  80021d:	0f b6 c0             	movzbl %al,%eax
  800220:	8b 55 0c             	mov    0xc(%ebp),%edx
  800223:	8b 12                	mov    (%edx),%edx
  800225:	89 d1                	mov    %edx,%ecx
  800227:	8b 55 0c             	mov    0xc(%ebp),%edx
  80022a:	83 c2 08             	add    $0x8,%edx
  80022d:	83 ec 04             	sub    $0x4,%esp
  800230:	50                   	push   %eax
  800231:	51                   	push   %ecx
  800232:	52                   	push   %edx
  800233:	e8 3e 0e 00 00       	call   801076 <sys_cputs>
  800238:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80023b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800244:	8b 45 0c             	mov    0xc(%ebp),%eax
  800247:	8b 40 04             	mov    0x4(%eax),%eax
  80024a:	8d 50 01             	lea    0x1(%eax),%edx
  80024d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800250:	89 50 04             	mov    %edx,0x4(%eax)
}
  800253:	90                   	nop
  800254:	c9                   	leave  
  800255:	c3                   	ret    

00800256 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800256:	55                   	push   %ebp
  800257:	89 e5                	mov    %esp,%ebp
  800259:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80025f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800266:	00 00 00 
	b.cnt = 0;
  800269:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800270:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800273:	ff 75 0c             	pushl  0xc(%ebp)
  800276:	ff 75 08             	pushl  0x8(%ebp)
  800279:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80027f:	50                   	push   %eax
  800280:	68 ed 01 80 00       	push   $0x8001ed
  800285:	e8 11 02 00 00       	call   80049b <vprintfmt>
  80028a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80028d:	a0 08 20 80 00       	mov    0x802008,%al
  800292:	0f b6 c0             	movzbl %al,%eax
  800295:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80029b:	83 ec 04             	sub    $0x4,%esp
  80029e:	50                   	push   %eax
  80029f:	52                   	push   %edx
  8002a0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002a6:	83 c0 08             	add    $0x8,%eax
  8002a9:	50                   	push   %eax
  8002aa:	e8 c7 0d 00 00       	call   801076 <sys_cputs>
  8002af:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002b2:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  8002b9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002bf:	c9                   	leave  
  8002c0:	c3                   	ret    

008002c1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002c1:	55                   	push   %ebp
  8002c2:	89 e5                	mov    %esp,%ebp
  8002c4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002c7:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002ce:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d7:	83 ec 08             	sub    $0x8,%esp
  8002da:	ff 75 f4             	pushl  -0xc(%ebp)
  8002dd:	50                   	push   %eax
  8002de:	e8 73 ff ff ff       	call   800256 <vcprintf>
  8002e3:	83 c4 10             	add    $0x10,%esp
  8002e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ec:	c9                   	leave  
  8002ed:	c3                   	ret    

008002ee <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002ee:	55                   	push   %ebp
  8002ef:	89 e5                	mov    %esp,%ebp
  8002f1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002f4:	e8 8e 0f 00 00       	call   801287 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002f9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800302:	83 ec 08             	sub    $0x8,%esp
  800305:	ff 75 f4             	pushl  -0xc(%ebp)
  800308:	50                   	push   %eax
  800309:	e8 48 ff ff ff       	call   800256 <vcprintf>
  80030e:	83 c4 10             	add    $0x10,%esp
  800311:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800314:	e8 88 0f 00 00       	call   8012a1 <sys_enable_interrupt>
	return cnt;
  800319:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80031c:	c9                   	leave  
  80031d:	c3                   	ret    

0080031e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80031e:	55                   	push   %ebp
  80031f:	89 e5                	mov    %esp,%ebp
  800321:	53                   	push   %ebx
  800322:	83 ec 14             	sub    $0x14,%esp
  800325:	8b 45 10             	mov    0x10(%ebp),%eax
  800328:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80032b:	8b 45 14             	mov    0x14(%ebp),%eax
  80032e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800331:	8b 45 18             	mov    0x18(%ebp),%eax
  800334:	ba 00 00 00 00       	mov    $0x0,%edx
  800339:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80033c:	77 55                	ja     800393 <printnum+0x75>
  80033e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800341:	72 05                	jb     800348 <printnum+0x2a>
  800343:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800346:	77 4b                	ja     800393 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800348:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80034b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80034e:	8b 45 18             	mov    0x18(%ebp),%eax
  800351:	ba 00 00 00 00       	mov    $0x0,%edx
  800356:	52                   	push   %edx
  800357:	50                   	push   %eax
  800358:	ff 75 f4             	pushl  -0xc(%ebp)
  80035b:	ff 75 f0             	pushl  -0x10(%ebp)
  80035e:	e8 05 13 00 00       	call   801668 <__udivdi3>
  800363:	83 c4 10             	add    $0x10,%esp
  800366:	83 ec 04             	sub    $0x4,%esp
  800369:	ff 75 20             	pushl  0x20(%ebp)
  80036c:	53                   	push   %ebx
  80036d:	ff 75 18             	pushl  0x18(%ebp)
  800370:	52                   	push   %edx
  800371:	50                   	push   %eax
  800372:	ff 75 0c             	pushl  0xc(%ebp)
  800375:	ff 75 08             	pushl  0x8(%ebp)
  800378:	e8 a1 ff ff ff       	call   80031e <printnum>
  80037d:	83 c4 20             	add    $0x20,%esp
  800380:	eb 1a                	jmp    80039c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800382:	83 ec 08             	sub    $0x8,%esp
  800385:	ff 75 0c             	pushl  0xc(%ebp)
  800388:	ff 75 20             	pushl  0x20(%ebp)
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	ff d0                	call   *%eax
  800390:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800393:	ff 4d 1c             	decl   0x1c(%ebp)
  800396:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80039a:	7f e6                	jg     800382 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80039c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80039f:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003aa:	53                   	push   %ebx
  8003ab:	51                   	push   %ecx
  8003ac:	52                   	push   %edx
  8003ad:	50                   	push   %eax
  8003ae:	e8 c5 13 00 00       	call   801778 <__umoddi3>
  8003b3:	83 c4 10             	add    $0x10,%esp
  8003b6:	05 94 1b 80 00       	add    $0x801b94,%eax
  8003bb:	8a 00                	mov    (%eax),%al
  8003bd:	0f be c0             	movsbl %al,%eax
  8003c0:	83 ec 08             	sub    $0x8,%esp
  8003c3:	ff 75 0c             	pushl  0xc(%ebp)
  8003c6:	50                   	push   %eax
  8003c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ca:	ff d0                	call   *%eax
  8003cc:	83 c4 10             	add    $0x10,%esp
}
  8003cf:	90                   	nop
  8003d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003d3:	c9                   	leave  
  8003d4:	c3                   	ret    

008003d5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003d5:	55                   	push   %ebp
  8003d6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003d8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003dc:	7e 1c                	jle    8003fa <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003de:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e1:	8b 00                	mov    (%eax),%eax
  8003e3:	8d 50 08             	lea    0x8(%eax),%edx
  8003e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e9:	89 10                	mov    %edx,(%eax)
  8003eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ee:	8b 00                	mov    (%eax),%eax
  8003f0:	83 e8 08             	sub    $0x8,%eax
  8003f3:	8b 50 04             	mov    0x4(%eax),%edx
  8003f6:	8b 00                	mov    (%eax),%eax
  8003f8:	eb 40                	jmp    80043a <getuint+0x65>
	else if (lflag)
  8003fa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003fe:	74 1e                	je     80041e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	8b 00                	mov    (%eax),%eax
  800405:	8d 50 04             	lea    0x4(%eax),%edx
  800408:	8b 45 08             	mov    0x8(%ebp),%eax
  80040b:	89 10                	mov    %edx,(%eax)
  80040d:	8b 45 08             	mov    0x8(%ebp),%eax
  800410:	8b 00                	mov    (%eax),%eax
  800412:	83 e8 04             	sub    $0x4,%eax
  800415:	8b 00                	mov    (%eax),%eax
  800417:	ba 00 00 00 00       	mov    $0x0,%edx
  80041c:	eb 1c                	jmp    80043a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80041e:	8b 45 08             	mov    0x8(%ebp),%eax
  800421:	8b 00                	mov    (%eax),%eax
  800423:	8d 50 04             	lea    0x4(%eax),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	89 10                	mov    %edx,(%eax)
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	83 e8 04             	sub    $0x4,%eax
  800433:	8b 00                	mov    (%eax),%eax
  800435:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80043a:	5d                   	pop    %ebp
  80043b:	c3                   	ret    

0080043c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80043c:	55                   	push   %ebp
  80043d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80043f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800443:	7e 1c                	jle    800461 <getint+0x25>
		return va_arg(*ap, long long);
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	8d 50 08             	lea    0x8(%eax),%edx
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	89 10                	mov    %edx,(%eax)
  800452:	8b 45 08             	mov    0x8(%ebp),%eax
  800455:	8b 00                	mov    (%eax),%eax
  800457:	83 e8 08             	sub    $0x8,%eax
  80045a:	8b 50 04             	mov    0x4(%eax),%edx
  80045d:	8b 00                	mov    (%eax),%eax
  80045f:	eb 38                	jmp    800499 <getint+0x5d>
	else if (lflag)
  800461:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800465:	74 1a                	je     800481 <getint+0x45>
		return va_arg(*ap, long);
  800467:	8b 45 08             	mov    0x8(%ebp),%eax
  80046a:	8b 00                	mov    (%eax),%eax
  80046c:	8d 50 04             	lea    0x4(%eax),%edx
  80046f:	8b 45 08             	mov    0x8(%ebp),%eax
  800472:	89 10                	mov    %edx,(%eax)
  800474:	8b 45 08             	mov    0x8(%ebp),%eax
  800477:	8b 00                	mov    (%eax),%eax
  800479:	83 e8 04             	sub    $0x4,%eax
  80047c:	8b 00                	mov    (%eax),%eax
  80047e:	99                   	cltd   
  80047f:	eb 18                	jmp    800499 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	8b 00                	mov    (%eax),%eax
  800486:	8d 50 04             	lea    0x4(%eax),%edx
  800489:	8b 45 08             	mov    0x8(%ebp),%eax
  80048c:	89 10                	mov    %edx,(%eax)
  80048e:	8b 45 08             	mov    0x8(%ebp),%eax
  800491:	8b 00                	mov    (%eax),%eax
  800493:	83 e8 04             	sub    $0x4,%eax
  800496:	8b 00                	mov    (%eax),%eax
  800498:	99                   	cltd   
}
  800499:	5d                   	pop    %ebp
  80049a:	c3                   	ret    

0080049b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80049b:	55                   	push   %ebp
  80049c:	89 e5                	mov    %esp,%ebp
  80049e:	56                   	push   %esi
  80049f:	53                   	push   %ebx
  8004a0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a3:	eb 17                	jmp    8004bc <vprintfmt+0x21>
			if (ch == '\0')
  8004a5:	85 db                	test   %ebx,%ebx
  8004a7:	0f 84 af 03 00 00    	je     80085c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004ad:	83 ec 08             	sub    $0x8,%esp
  8004b0:	ff 75 0c             	pushl  0xc(%ebp)
  8004b3:	53                   	push   %ebx
  8004b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b7:	ff d0                	call   *%eax
  8004b9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bf:	8d 50 01             	lea    0x1(%eax),%edx
  8004c2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c5:	8a 00                	mov    (%eax),%al
  8004c7:	0f b6 d8             	movzbl %al,%ebx
  8004ca:	83 fb 25             	cmp    $0x25,%ebx
  8004cd:	75 d6                	jne    8004a5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004cf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004d3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004da:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004e1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004e8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f2:	8d 50 01             	lea    0x1(%eax),%edx
  8004f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f8:	8a 00                	mov    (%eax),%al
  8004fa:	0f b6 d8             	movzbl %al,%ebx
  8004fd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800500:	83 f8 55             	cmp    $0x55,%eax
  800503:	0f 87 2b 03 00 00    	ja     800834 <vprintfmt+0x399>
  800509:	8b 04 85 b8 1b 80 00 	mov    0x801bb8(,%eax,4),%eax
  800510:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800512:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800516:	eb d7                	jmp    8004ef <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800518:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80051c:	eb d1                	jmp    8004ef <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80051e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800525:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800528:	89 d0                	mov    %edx,%eax
  80052a:	c1 e0 02             	shl    $0x2,%eax
  80052d:	01 d0                	add    %edx,%eax
  80052f:	01 c0                	add    %eax,%eax
  800531:	01 d8                	add    %ebx,%eax
  800533:	83 e8 30             	sub    $0x30,%eax
  800536:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800539:	8b 45 10             	mov    0x10(%ebp),%eax
  80053c:	8a 00                	mov    (%eax),%al
  80053e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800541:	83 fb 2f             	cmp    $0x2f,%ebx
  800544:	7e 3e                	jle    800584 <vprintfmt+0xe9>
  800546:	83 fb 39             	cmp    $0x39,%ebx
  800549:	7f 39                	jg     800584 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80054b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80054e:	eb d5                	jmp    800525 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800550:	8b 45 14             	mov    0x14(%ebp),%eax
  800553:	83 c0 04             	add    $0x4,%eax
  800556:	89 45 14             	mov    %eax,0x14(%ebp)
  800559:	8b 45 14             	mov    0x14(%ebp),%eax
  80055c:	83 e8 04             	sub    $0x4,%eax
  80055f:	8b 00                	mov    (%eax),%eax
  800561:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800564:	eb 1f                	jmp    800585 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800566:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80056a:	79 83                	jns    8004ef <vprintfmt+0x54>
				width = 0;
  80056c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800573:	e9 77 ff ff ff       	jmp    8004ef <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800578:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80057f:	e9 6b ff ff ff       	jmp    8004ef <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800584:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800585:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800589:	0f 89 60 ff ff ff    	jns    8004ef <vprintfmt+0x54>
				width = precision, precision = -1;
  80058f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800592:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800595:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80059c:	e9 4e ff ff ff       	jmp    8004ef <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005a1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005a4:	e9 46 ff ff ff       	jmp    8004ef <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ac:	83 c0 04             	add    $0x4,%eax
  8005af:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b5:	83 e8 04             	sub    $0x4,%eax
  8005b8:	8b 00                	mov    (%eax),%eax
  8005ba:	83 ec 08             	sub    $0x8,%esp
  8005bd:	ff 75 0c             	pushl  0xc(%ebp)
  8005c0:	50                   	push   %eax
  8005c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c4:	ff d0                	call   *%eax
  8005c6:	83 c4 10             	add    $0x10,%esp
			break;
  8005c9:	e9 89 02 00 00       	jmp    800857 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d1:	83 c0 04             	add    $0x4,%eax
  8005d4:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005da:	83 e8 04             	sub    $0x4,%eax
  8005dd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005df:	85 db                	test   %ebx,%ebx
  8005e1:	79 02                	jns    8005e5 <vprintfmt+0x14a>
				err = -err;
  8005e3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005e5:	83 fb 64             	cmp    $0x64,%ebx
  8005e8:	7f 0b                	jg     8005f5 <vprintfmt+0x15a>
  8005ea:	8b 34 9d 00 1a 80 00 	mov    0x801a00(,%ebx,4),%esi
  8005f1:	85 f6                	test   %esi,%esi
  8005f3:	75 19                	jne    80060e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005f5:	53                   	push   %ebx
  8005f6:	68 a5 1b 80 00       	push   $0x801ba5
  8005fb:	ff 75 0c             	pushl  0xc(%ebp)
  8005fe:	ff 75 08             	pushl  0x8(%ebp)
  800601:	e8 5e 02 00 00       	call   800864 <printfmt>
  800606:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800609:	e9 49 02 00 00       	jmp    800857 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80060e:	56                   	push   %esi
  80060f:	68 ae 1b 80 00       	push   $0x801bae
  800614:	ff 75 0c             	pushl  0xc(%ebp)
  800617:	ff 75 08             	pushl  0x8(%ebp)
  80061a:	e8 45 02 00 00       	call   800864 <printfmt>
  80061f:	83 c4 10             	add    $0x10,%esp
			break;
  800622:	e9 30 02 00 00       	jmp    800857 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800627:	8b 45 14             	mov    0x14(%ebp),%eax
  80062a:	83 c0 04             	add    $0x4,%eax
  80062d:	89 45 14             	mov    %eax,0x14(%ebp)
  800630:	8b 45 14             	mov    0x14(%ebp),%eax
  800633:	83 e8 04             	sub    $0x4,%eax
  800636:	8b 30                	mov    (%eax),%esi
  800638:	85 f6                	test   %esi,%esi
  80063a:	75 05                	jne    800641 <vprintfmt+0x1a6>
				p = "(null)";
  80063c:	be b1 1b 80 00       	mov    $0x801bb1,%esi
			if (width > 0 && padc != '-')
  800641:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800645:	7e 6d                	jle    8006b4 <vprintfmt+0x219>
  800647:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80064b:	74 67                	je     8006b4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80064d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800650:	83 ec 08             	sub    $0x8,%esp
  800653:	50                   	push   %eax
  800654:	56                   	push   %esi
  800655:	e8 0c 03 00 00       	call   800966 <strnlen>
  80065a:	83 c4 10             	add    $0x10,%esp
  80065d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800660:	eb 16                	jmp    800678 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800662:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800666:	83 ec 08             	sub    $0x8,%esp
  800669:	ff 75 0c             	pushl  0xc(%ebp)
  80066c:	50                   	push   %eax
  80066d:	8b 45 08             	mov    0x8(%ebp),%eax
  800670:	ff d0                	call   *%eax
  800672:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800675:	ff 4d e4             	decl   -0x1c(%ebp)
  800678:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80067c:	7f e4                	jg     800662 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80067e:	eb 34                	jmp    8006b4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800680:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800684:	74 1c                	je     8006a2 <vprintfmt+0x207>
  800686:	83 fb 1f             	cmp    $0x1f,%ebx
  800689:	7e 05                	jle    800690 <vprintfmt+0x1f5>
  80068b:	83 fb 7e             	cmp    $0x7e,%ebx
  80068e:	7e 12                	jle    8006a2 <vprintfmt+0x207>
					putch('?', putdat);
  800690:	83 ec 08             	sub    $0x8,%esp
  800693:	ff 75 0c             	pushl  0xc(%ebp)
  800696:	6a 3f                	push   $0x3f
  800698:	8b 45 08             	mov    0x8(%ebp),%eax
  80069b:	ff d0                	call   *%eax
  80069d:	83 c4 10             	add    $0x10,%esp
  8006a0:	eb 0f                	jmp    8006b1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006a2:	83 ec 08             	sub    $0x8,%esp
  8006a5:	ff 75 0c             	pushl  0xc(%ebp)
  8006a8:	53                   	push   %ebx
  8006a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ac:	ff d0                	call   *%eax
  8006ae:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006b1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b4:	89 f0                	mov    %esi,%eax
  8006b6:	8d 70 01             	lea    0x1(%eax),%esi
  8006b9:	8a 00                	mov    (%eax),%al
  8006bb:	0f be d8             	movsbl %al,%ebx
  8006be:	85 db                	test   %ebx,%ebx
  8006c0:	74 24                	je     8006e6 <vprintfmt+0x24b>
  8006c2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c6:	78 b8                	js     800680 <vprintfmt+0x1e5>
  8006c8:	ff 4d e0             	decl   -0x20(%ebp)
  8006cb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006cf:	79 af                	jns    800680 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d1:	eb 13                	jmp    8006e6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006d3:	83 ec 08             	sub    $0x8,%esp
  8006d6:	ff 75 0c             	pushl  0xc(%ebp)
  8006d9:	6a 20                	push   $0x20
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	ff d0                	call   *%eax
  8006e0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e3:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ea:	7f e7                	jg     8006d3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006ec:	e9 66 01 00 00       	jmp    800857 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006f1:	83 ec 08             	sub    $0x8,%esp
  8006f4:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f7:	8d 45 14             	lea    0x14(%ebp),%eax
  8006fa:	50                   	push   %eax
  8006fb:	e8 3c fd ff ff       	call   80043c <getint>
  800700:	83 c4 10             	add    $0x10,%esp
  800703:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800706:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800709:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80070f:	85 d2                	test   %edx,%edx
  800711:	79 23                	jns    800736 <vprintfmt+0x29b>
				putch('-', putdat);
  800713:	83 ec 08             	sub    $0x8,%esp
  800716:	ff 75 0c             	pushl  0xc(%ebp)
  800719:	6a 2d                	push   $0x2d
  80071b:	8b 45 08             	mov    0x8(%ebp),%eax
  80071e:	ff d0                	call   *%eax
  800720:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800723:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800726:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800729:	f7 d8                	neg    %eax
  80072b:	83 d2 00             	adc    $0x0,%edx
  80072e:	f7 da                	neg    %edx
  800730:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800733:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800736:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80073d:	e9 bc 00 00 00       	jmp    8007fe <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800742:	83 ec 08             	sub    $0x8,%esp
  800745:	ff 75 e8             	pushl  -0x18(%ebp)
  800748:	8d 45 14             	lea    0x14(%ebp),%eax
  80074b:	50                   	push   %eax
  80074c:	e8 84 fc ff ff       	call   8003d5 <getuint>
  800751:	83 c4 10             	add    $0x10,%esp
  800754:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800757:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80075a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800761:	e9 98 00 00 00       	jmp    8007fe <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  800786:	83 ec 08             	sub    $0x8,%esp
  800789:	ff 75 0c             	pushl  0xc(%ebp)
  80078c:	6a 58                	push   $0x58
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	ff d0                	call   *%eax
  800793:	83 c4 10             	add    $0x10,%esp
			break;
  800796:	e9 bc 00 00 00       	jmp    800857 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80079b:	83 ec 08             	sub    $0x8,%esp
  80079e:	ff 75 0c             	pushl  0xc(%ebp)
  8007a1:	6a 30                	push   $0x30
  8007a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a6:	ff d0                	call   *%eax
  8007a8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007ab:	83 ec 08             	sub    $0x8,%esp
  8007ae:	ff 75 0c             	pushl  0xc(%ebp)
  8007b1:	6a 78                	push   $0x78
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	ff d0                	call   *%eax
  8007b8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007be:	83 c0 04             	add    $0x4,%eax
  8007c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c7:	83 e8 04             	sub    $0x4,%eax
  8007ca:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007d6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007dd:	eb 1f                	jmp    8007fe <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007df:	83 ec 08             	sub    $0x8,%esp
  8007e2:	ff 75 e8             	pushl  -0x18(%ebp)
  8007e5:	8d 45 14             	lea    0x14(%ebp),%eax
  8007e8:	50                   	push   %eax
  8007e9:	e8 e7 fb ff ff       	call   8003d5 <getuint>
  8007ee:	83 c4 10             	add    $0x10,%esp
  8007f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007f7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007fe:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800802:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800805:	83 ec 04             	sub    $0x4,%esp
  800808:	52                   	push   %edx
  800809:	ff 75 e4             	pushl  -0x1c(%ebp)
  80080c:	50                   	push   %eax
  80080d:	ff 75 f4             	pushl  -0xc(%ebp)
  800810:	ff 75 f0             	pushl  -0x10(%ebp)
  800813:	ff 75 0c             	pushl  0xc(%ebp)
  800816:	ff 75 08             	pushl  0x8(%ebp)
  800819:	e8 00 fb ff ff       	call   80031e <printnum>
  80081e:	83 c4 20             	add    $0x20,%esp
			break;
  800821:	eb 34                	jmp    800857 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800823:	83 ec 08             	sub    $0x8,%esp
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	53                   	push   %ebx
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
			break;
  800832:	eb 23                	jmp    800857 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800834:	83 ec 08             	sub    $0x8,%esp
  800837:	ff 75 0c             	pushl  0xc(%ebp)
  80083a:	6a 25                	push   $0x25
  80083c:	8b 45 08             	mov    0x8(%ebp),%eax
  80083f:	ff d0                	call   *%eax
  800841:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800844:	ff 4d 10             	decl   0x10(%ebp)
  800847:	eb 03                	jmp    80084c <vprintfmt+0x3b1>
  800849:	ff 4d 10             	decl   0x10(%ebp)
  80084c:	8b 45 10             	mov    0x10(%ebp),%eax
  80084f:	48                   	dec    %eax
  800850:	8a 00                	mov    (%eax),%al
  800852:	3c 25                	cmp    $0x25,%al
  800854:	75 f3                	jne    800849 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800856:	90                   	nop
		}
	}
  800857:	e9 47 fc ff ff       	jmp    8004a3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80085c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80085d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800860:	5b                   	pop    %ebx
  800861:	5e                   	pop    %esi
  800862:	5d                   	pop    %ebp
  800863:	c3                   	ret    

00800864 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800864:	55                   	push   %ebp
  800865:	89 e5                	mov    %esp,%ebp
  800867:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80086a:	8d 45 10             	lea    0x10(%ebp),%eax
  80086d:	83 c0 04             	add    $0x4,%eax
  800870:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800873:	8b 45 10             	mov    0x10(%ebp),%eax
  800876:	ff 75 f4             	pushl  -0xc(%ebp)
  800879:	50                   	push   %eax
  80087a:	ff 75 0c             	pushl  0xc(%ebp)
  80087d:	ff 75 08             	pushl  0x8(%ebp)
  800880:	e8 16 fc ff ff       	call   80049b <vprintfmt>
  800885:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800888:	90                   	nop
  800889:	c9                   	leave  
  80088a:	c3                   	ret    

0080088b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80088b:	55                   	push   %ebp
  80088c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80088e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800891:	8b 40 08             	mov    0x8(%eax),%eax
  800894:	8d 50 01             	lea    0x1(%eax),%edx
  800897:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80089d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a0:	8b 10                	mov    (%eax),%edx
  8008a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a5:	8b 40 04             	mov    0x4(%eax),%eax
  8008a8:	39 c2                	cmp    %eax,%edx
  8008aa:	73 12                	jae    8008be <sprintputch+0x33>
		*b->buf++ = ch;
  8008ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008af:	8b 00                	mov    (%eax),%eax
  8008b1:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b7:	89 0a                	mov    %ecx,(%edx)
  8008b9:	8b 55 08             	mov    0x8(%ebp),%edx
  8008bc:	88 10                	mov    %dl,(%eax)
}
  8008be:	90                   	nop
  8008bf:	5d                   	pop    %ebp
  8008c0:	c3                   	ret    

008008c1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008c1:	55                   	push   %ebp
  8008c2:	89 e5                	mov    %esp,%ebp
  8008c4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d6:	01 d0                	add    %edx,%eax
  8008d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008e2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e6:	74 06                	je     8008ee <vsnprintf+0x2d>
  8008e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ec:	7f 07                	jg     8008f5 <vsnprintf+0x34>
		return -E_INVAL;
  8008ee:	b8 03 00 00 00       	mov    $0x3,%eax
  8008f3:	eb 20                	jmp    800915 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008f5:	ff 75 14             	pushl  0x14(%ebp)
  8008f8:	ff 75 10             	pushl  0x10(%ebp)
  8008fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008fe:	50                   	push   %eax
  8008ff:	68 8b 08 80 00       	push   $0x80088b
  800904:	e8 92 fb ff ff       	call   80049b <vprintfmt>
  800909:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80090c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80090f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800912:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800915:	c9                   	leave  
  800916:	c3                   	ret    

00800917 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800917:	55                   	push   %ebp
  800918:	89 e5                	mov    %esp,%ebp
  80091a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80091d:	8d 45 10             	lea    0x10(%ebp),%eax
  800920:	83 c0 04             	add    $0x4,%eax
  800923:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800926:	8b 45 10             	mov    0x10(%ebp),%eax
  800929:	ff 75 f4             	pushl  -0xc(%ebp)
  80092c:	50                   	push   %eax
  80092d:	ff 75 0c             	pushl  0xc(%ebp)
  800930:	ff 75 08             	pushl  0x8(%ebp)
  800933:	e8 89 ff ff ff       	call   8008c1 <vsnprintf>
  800938:	83 c4 10             	add    $0x10,%esp
  80093b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80093e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800941:	c9                   	leave  
  800942:	c3                   	ret    

00800943 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800943:	55                   	push   %ebp
  800944:	89 e5                	mov    %esp,%ebp
  800946:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800949:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800950:	eb 06                	jmp    800958 <strlen+0x15>
		n++;
  800952:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800955:	ff 45 08             	incl   0x8(%ebp)
  800958:	8b 45 08             	mov    0x8(%ebp),%eax
  80095b:	8a 00                	mov    (%eax),%al
  80095d:	84 c0                	test   %al,%al
  80095f:	75 f1                	jne    800952 <strlen+0xf>
		n++;
	return n;
  800961:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800964:	c9                   	leave  
  800965:	c3                   	ret    

00800966 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800966:	55                   	push   %ebp
  800967:	89 e5                	mov    %esp,%ebp
  800969:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80096c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800973:	eb 09                	jmp    80097e <strnlen+0x18>
		n++;
  800975:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800978:	ff 45 08             	incl   0x8(%ebp)
  80097b:	ff 4d 0c             	decl   0xc(%ebp)
  80097e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800982:	74 09                	je     80098d <strnlen+0x27>
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	8a 00                	mov    (%eax),%al
  800989:	84 c0                	test   %al,%al
  80098b:	75 e8                	jne    800975 <strnlen+0xf>
		n++;
	return n;
  80098d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800990:	c9                   	leave  
  800991:	c3                   	ret    

00800992 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800992:	55                   	push   %ebp
  800993:	89 e5                	mov    %esp,%ebp
  800995:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80099e:	90                   	nop
  80099f:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a2:	8d 50 01             	lea    0x1(%eax),%edx
  8009a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009ae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009b1:	8a 12                	mov    (%edx),%dl
  8009b3:	88 10                	mov    %dl,(%eax)
  8009b5:	8a 00                	mov    (%eax),%al
  8009b7:	84 c0                	test   %al,%al
  8009b9:	75 e4                	jne    80099f <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009be:	c9                   	leave  
  8009bf:	c3                   	ret    

008009c0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009c0:	55                   	push   %ebp
  8009c1:	89 e5                	mov    %esp,%ebp
  8009c3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009d3:	eb 1f                	jmp    8009f4 <strncpy+0x34>
		*dst++ = *src;
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	8d 50 01             	lea    0x1(%eax),%edx
  8009db:	89 55 08             	mov    %edx,0x8(%ebp)
  8009de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e1:	8a 12                	mov    (%edx),%dl
  8009e3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e8:	8a 00                	mov    (%eax),%al
  8009ea:	84 c0                	test   %al,%al
  8009ec:	74 03                	je     8009f1 <strncpy+0x31>
			src++;
  8009ee:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009f1:	ff 45 fc             	incl   -0x4(%ebp)
  8009f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009f7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009fa:	72 d9                	jb     8009d5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009ff:	c9                   	leave  
  800a00:	c3                   	ret    

00800a01 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a01:	55                   	push   %ebp
  800a02:	89 e5                	mov    %esp,%ebp
  800a04:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a11:	74 30                	je     800a43 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a13:	eb 16                	jmp    800a2b <strlcpy+0x2a>
			*dst++ = *src++;
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	8d 50 01             	lea    0x1(%eax),%edx
  800a1b:	89 55 08             	mov    %edx,0x8(%ebp)
  800a1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a21:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a24:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a27:	8a 12                	mov    (%edx),%dl
  800a29:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a2b:	ff 4d 10             	decl   0x10(%ebp)
  800a2e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a32:	74 09                	je     800a3d <strlcpy+0x3c>
  800a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a37:	8a 00                	mov    (%eax),%al
  800a39:	84 c0                	test   %al,%al
  800a3b:	75 d8                	jne    800a15 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a40:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a43:	8b 55 08             	mov    0x8(%ebp),%edx
  800a46:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a49:	29 c2                	sub    %eax,%edx
  800a4b:	89 d0                	mov    %edx,%eax
}
  800a4d:	c9                   	leave  
  800a4e:	c3                   	ret    

00800a4f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a4f:	55                   	push   %ebp
  800a50:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a52:	eb 06                	jmp    800a5a <strcmp+0xb>
		p++, q++;
  800a54:	ff 45 08             	incl   0x8(%ebp)
  800a57:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	8a 00                	mov    (%eax),%al
  800a5f:	84 c0                	test   %al,%al
  800a61:	74 0e                	je     800a71 <strcmp+0x22>
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	8a 10                	mov    (%eax),%dl
  800a68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6b:	8a 00                	mov    (%eax),%al
  800a6d:	38 c2                	cmp    %al,%dl
  800a6f:	74 e3                	je     800a54 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	8a 00                	mov    (%eax),%al
  800a76:	0f b6 d0             	movzbl %al,%edx
  800a79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7c:	8a 00                	mov    (%eax),%al
  800a7e:	0f b6 c0             	movzbl %al,%eax
  800a81:	29 c2                	sub    %eax,%edx
  800a83:	89 d0                	mov    %edx,%eax
}
  800a85:	5d                   	pop    %ebp
  800a86:	c3                   	ret    

00800a87 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a87:	55                   	push   %ebp
  800a88:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a8a:	eb 09                	jmp    800a95 <strncmp+0xe>
		n--, p++, q++;
  800a8c:	ff 4d 10             	decl   0x10(%ebp)
  800a8f:	ff 45 08             	incl   0x8(%ebp)
  800a92:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a95:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a99:	74 17                	je     800ab2 <strncmp+0x2b>
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	8a 00                	mov    (%eax),%al
  800aa0:	84 c0                	test   %al,%al
  800aa2:	74 0e                	je     800ab2 <strncmp+0x2b>
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	8a 10                	mov    (%eax),%dl
  800aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aac:	8a 00                	mov    (%eax),%al
  800aae:	38 c2                	cmp    %al,%dl
  800ab0:	74 da                	je     800a8c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ab2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab6:	75 07                	jne    800abf <strncmp+0x38>
		return 0;
  800ab8:	b8 00 00 00 00       	mov    $0x0,%eax
  800abd:	eb 14                	jmp    800ad3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	8a 00                	mov    (%eax),%al
  800ac4:	0f b6 d0             	movzbl %al,%edx
  800ac7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aca:	8a 00                	mov    (%eax),%al
  800acc:	0f b6 c0             	movzbl %al,%eax
  800acf:	29 c2                	sub    %eax,%edx
  800ad1:	89 d0                	mov    %edx,%eax
}
  800ad3:	5d                   	pop    %ebp
  800ad4:	c3                   	ret    

00800ad5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ad5:	55                   	push   %ebp
  800ad6:	89 e5                	mov    %esp,%ebp
  800ad8:	83 ec 04             	sub    $0x4,%esp
  800adb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ade:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ae1:	eb 12                	jmp    800af5 <strchr+0x20>
		if (*s == c)
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	8a 00                	mov    (%eax),%al
  800ae8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aeb:	75 05                	jne    800af2 <strchr+0x1d>
			return (char *) s;
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	eb 11                	jmp    800b03 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800af2:	ff 45 08             	incl   0x8(%ebp)
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8a 00                	mov    (%eax),%al
  800afa:	84 c0                	test   %al,%al
  800afc:	75 e5                	jne    800ae3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800afe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b03:	c9                   	leave  
  800b04:	c3                   	ret    

00800b05 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b05:	55                   	push   %ebp
  800b06:	89 e5                	mov    %esp,%ebp
  800b08:	83 ec 04             	sub    $0x4,%esp
  800b0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b11:	eb 0d                	jmp    800b20 <strfind+0x1b>
		if (*s == c)
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	8a 00                	mov    (%eax),%al
  800b18:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b1b:	74 0e                	je     800b2b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b1d:	ff 45 08             	incl   0x8(%ebp)
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
  800b23:	8a 00                	mov    (%eax),%al
  800b25:	84 c0                	test   %al,%al
  800b27:	75 ea                	jne    800b13 <strfind+0xe>
  800b29:	eb 01                	jmp    800b2c <strfind+0x27>
		if (*s == c)
			break;
  800b2b:	90                   	nop
	return (char *) s;
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b2f:	c9                   	leave  
  800b30:	c3                   	ret    

00800b31 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b31:	55                   	push   %ebp
  800b32:	89 e5                	mov    %esp,%ebp
  800b34:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b40:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b43:	eb 0e                	jmp    800b53 <memset+0x22>
		*p++ = c;
  800b45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b48:	8d 50 01             	lea    0x1(%eax),%edx
  800b4b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b51:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b53:	ff 4d f8             	decl   -0x8(%ebp)
  800b56:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b5a:	79 e9                	jns    800b45 <memset+0x14>
		*p++ = c;

	return v;
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b5f:	c9                   	leave  
  800b60:	c3                   	ret    

00800b61 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b61:	55                   	push   %ebp
  800b62:	89 e5                	mov    %esp,%ebp
  800b64:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b73:	eb 16                	jmp    800b8b <memcpy+0x2a>
		*d++ = *s++;
  800b75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b78:	8d 50 01             	lea    0x1(%eax),%edx
  800b7b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b7e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b81:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b84:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b87:	8a 12                	mov    (%edx),%dl
  800b89:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b91:	89 55 10             	mov    %edx,0x10(%ebp)
  800b94:	85 c0                	test   %eax,%eax
  800b96:	75 dd                	jne    800b75 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b9b:	c9                   	leave  
  800b9c:	c3                   	ret    

00800b9d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b9d:	55                   	push   %ebp
  800b9e:	89 e5                	mov    %esp,%ebp
  800ba0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800baf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bb5:	73 50                	jae    800c07 <memmove+0x6a>
  800bb7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bba:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbd:	01 d0                	add    %edx,%eax
  800bbf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bc2:	76 43                	jbe    800c07 <memmove+0x6a>
		s += n;
  800bc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bca:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bd0:	eb 10                	jmp    800be2 <memmove+0x45>
			*--d = *--s;
  800bd2:	ff 4d f8             	decl   -0x8(%ebp)
  800bd5:	ff 4d fc             	decl   -0x4(%ebp)
  800bd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bdb:	8a 10                	mov    (%eax),%dl
  800bdd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800be2:	8b 45 10             	mov    0x10(%ebp),%eax
  800be5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be8:	89 55 10             	mov    %edx,0x10(%ebp)
  800beb:	85 c0                	test   %eax,%eax
  800bed:	75 e3                	jne    800bd2 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bef:	eb 23                	jmp    800c14 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bf1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf4:	8d 50 01             	lea    0x1(%eax),%edx
  800bf7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bfa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bfd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c00:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c03:	8a 12                	mov    (%edx),%dl
  800c05:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c07:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c0d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c10:	85 c0                	test   %eax,%eax
  800c12:	75 dd                	jne    800bf1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c17:	c9                   	leave  
  800c18:	c3                   	ret    

00800c19 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c19:	55                   	push   %ebp
  800c1a:	89 e5                	mov    %esp,%ebp
  800c1c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c28:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c2b:	eb 2a                	jmp    800c57 <memcmp+0x3e>
		if (*s1 != *s2)
  800c2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c30:	8a 10                	mov    (%eax),%dl
  800c32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	38 c2                	cmp    %al,%dl
  800c39:	74 16                	je     800c51 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3e:	8a 00                	mov    (%eax),%al
  800c40:	0f b6 d0             	movzbl %al,%edx
  800c43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c46:	8a 00                	mov    (%eax),%al
  800c48:	0f b6 c0             	movzbl %al,%eax
  800c4b:	29 c2                	sub    %eax,%edx
  800c4d:	89 d0                	mov    %edx,%eax
  800c4f:	eb 18                	jmp    800c69 <memcmp+0x50>
		s1++, s2++;
  800c51:	ff 45 fc             	incl   -0x4(%ebp)
  800c54:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c57:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c5d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c60:	85 c0                	test   %eax,%eax
  800c62:	75 c9                	jne    800c2d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c64:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c69:	c9                   	leave  
  800c6a:	c3                   	ret    

00800c6b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c6b:	55                   	push   %ebp
  800c6c:	89 e5                	mov    %esp,%ebp
  800c6e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c71:	8b 55 08             	mov    0x8(%ebp),%edx
  800c74:	8b 45 10             	mov    0x10(%ebp),%eax
  800c77:	01 d0                	add    %edx,%eax
  800c79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c7c:	eb 15                	jmp    800c93 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	0f b6 d0             	movzbl %al,%edx
  800c86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c89:	0f b6 c0             	movzbl %al,%eax
  800c8c:	39 c2                	cmp    %eax,%edx
  800c8e:	74 0d                	je     800c9d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c90:	ff 45 08             	incl   0x8(%ebp)
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c99:	72 e3                	jb     800c7e <memfind+0x13>
  800c9b:	eb 01                	jmp    800c9e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c9d:	90                   	nop
	return (void *) s;
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ca1:	c9                   	leave  
  800ca2:	c3                   	ret    

00800ca3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ca3:	55                   	push   %ebp
  800ca4:	89 e5                	mov    %esp,%ebp
  800ca6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ca9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cb0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cb7:	eb 03                	jmp    800cbc <strtol+0x19>
		s++;
  800cb9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	3c 20                	cmp    $0x20,%al
  800cc3:	74 f4                	je     800cb9 <strtol+0x16>
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	8a 00                	mov    (%eax),%al
  800cca:	3c 09                	cmp    $0x9,%al
  800ccc:	74 eb                	je     800cb9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8a 00                	mov    (%eax),%al
  800cd3:	3c 2b                	cmp    $0x2b,%al
  800cd5:	75 05                	jne    800cdc <strtol+0x39>
		s++;
  800cd7:	ff 45 08             	incl   0x8(%ebp)
  800cda:	eb 13                	jmp    800cef <strtol+0x4c>
	else if (*s == '-')
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	3c 2d                	cmp    $0x2d,%al
  800ce3:	75 0a                	jne    800cef <strtol+0x4c>
		s++, neg = 1;
  800ce5:	ff 45 08             	incl   0x8(%ebp)
  800ce8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf3:	74 06                	je     800cfb <strtol+0x58>
  800cf5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cf9:	75 20                	jne    800d1b <strtol+0x78>
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	3c 30                	cmp    $0x30,%al
  800d02:	75 17                	jne    800d1b <strtol+0x78>
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	40                   	inc    %eax
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	3c 78                	cmp    $0x78,%al
  800d0c:	75 0d                	jne    800d1b <strtol+0x78>
		s += 2, base = 16;
  800d0e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d12:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d19:	eb 28                	jmp    800d43 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d1b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1f:	75 15                	jne    800d36 <strtol+0x93>
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	3c 30                	cmp    $0x30,%al
  800d28:	75 0c                	jne    800d36 <strtol+0x93>
		s++, base = 8;
  800d2a:	ff 45 08             	incl   0x8(%ebp)
  800d2d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d34:	eb 0d                	jmp    800d43 <strtol+0xa0>
	else if (base == 0)
  800d36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3a:	75 07                	jne    800d43 <strtol+0xa0>
		base = 10;
  800d3c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	3c 2f                	cmp    $0x2f,%al
  800d4a:	7e 19                	jle    800d65 <strtol+0xc2>
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3c 39                	cmp    $0x39,%al
  800d53:	7f 10                	jg     800d65 <strtol+0xc2>
			dig = *s - '0';
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	0f be c0             	movsbl %al,%eax
  800d5d:	83 e8 30             	sub    $0x30,%eax
  800d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d63:	eb 42                	jmp    800da7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	8a 00                	mov    (%eax),%al
  800d6a:	3c 60                	cmp    $0x60,%al
  800d6c:	7e 19                	jle    800d87 <strtol+0xe4>
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	3c 7a                	cmp    $0x7a,%al
  800d75:	7f 10                	jg     800d87 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8a 00                	mov    (%eax),%al
  800d7c:	0f be c0             	movsbl %al,%eax
  800d7f:	83 e8 57             	sub    $0x57,%eax
  800d82:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d85:	eb 20                	jmp    800da7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	3c 40                	cmp    $0x40,%al
  800d8e:	7e 39                	jle    800dc9 <strtol+0x126>
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	8a 00                	mov    (%eax),%al
  800d95:	3c 5a                	cmp    $0x5a,%al
  800d97:	7f 30                	jg     800dc9 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	8a 00                	mov    (%eax),%al
  800d9e:	0f be c0             	movsbl %al,%eax
  800da1:	83 e8 37             	sub    $0x37,%eax
  800da4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800da7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800daa:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dad:	7d 19                	jge    800dc8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800daf:	ff 45 08             	incl   0x8(%ebp)
  800db2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db5:	0f af 45 10          	imul   0x10(%ebp),%eax
  800db9:	89 c2                	mov    %eax,%edx
  800dbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dbe:	01 d0                	add    %edx,%eax
  800dc0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dc3:	e9 7b ff ff ff       	jmp    800d43 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dc8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dc9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dcd:	74 08                	je     800dd7 <strtol+0x134>
		*endptr = (char *) s;
  800dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd2:	8b 55 08             	mov    0x8(%ebp),%edx
  800dd5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dd7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ddb:	74 07                	je     800de4 <strtol+0x141>
  800ddd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de0:	f7 d8                	neg    %eax
  800de2:	eb 03                	jmp    800de7 <strtol+0x144>
  800de4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800de7:	c9                   	leave  
  800de8:	c3                   	ret    

00800de9 <ltostr>:

void
ltostr(long value, char *str)
{
  800de9:	55                   	push   %ebp
  800dea:	89 e5                	mov    %esp,%ebp
  800dec:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800def:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800df6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dfd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e01:	79 13                	jns    800e16 <ltostr+0x2d>
	{
		neg = 1;
  800e03:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e10:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e13:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e16:	8b 45 08             	mov    0x8(%ebp),%eax
  800e19:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e1e:	99                   	cltd   
  800e1f:	f7 f9                	idiv   %ecx
  800e21:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e27:	8d 50 01             	lea    0x1(%eax),%edx
  800e2a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e2d:	89 c2                	mov    %eax,%edx
  800e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e32:	01 d0                	add    %edx,%eax
  800e34:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e37:	83 c2 30             	add    $0x30,%edx
  800e3a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e3c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e3f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e44:	f7 e9                	imul   %ecx
  800e46:	c1 fa 02             	sar    $0x2,%edx
  800e49:	89 c8                	mov    %ecx,%eax
  800e4b:	c1 f8 1f             	sar    $0x1f,%eax
  800e4e:	29 c2                	sub    %eax,%edx
  800e50:	89 d0                	mov    %edx,%eax
  800e52:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e55:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e58:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e5d:	f7 e9                	imul   %ecx
  800e5f:	c1 fa 02             	sar    $0x2,%edx
  800e62:	89 c8                	mov    %ecx,%eax
  800e64:	c1 f8 1f             	sar    $0x1f,%eax
  800e67:	29 c2                	sub    %eax,%edx
  800e69:	89 d0                	mov    %edx,%eax
  800e6b:	c1 e0 02             	shl    $0x2,%eax
  800e6e:	01 d0                	add    %edx,%eax
  800e70:	01 c0                	add    %eax,%eax
  800e72:	29 c1                	sub    %eax,%ecx
  800e74:	89 ca                	mov    %ecx,%edx
  800e76:	85 d2                	test   %edx,%edx
  800e78:	75 9c                	jne    800e16 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e84:	48                   	dec    %eax
  800e85:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e88:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e8c:	74 3d                	je     800ecb <ltostr+0xe2>
		start = 1 ;
  800e8e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e95:	eb 34                	jmp    800ecb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e97:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9d:	01 d0                	add    %edx,%eax
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800ea4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eaa:	01 c2                	add    %eax,%edx
  800eac:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb2:	01 c8                	add    %ecx,%eax
  800eb4:	8a 00                	mov    (%eax),%al
  800eb6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800eb8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebe:	01 c2                	add    %eax,%edx
  800ec0:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ec3:	88 02                	mov    %al,(%edx)
		start++ ;
  800ec5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ec8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ecb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ece:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ed1:	7c c4                	jl     800e97 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ed3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed9:	01 d0                	add    %edx,%eax
  800edb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ede:	90                   	nop
  800edf:	c9                   	leave  
  800ee0:	c3                   	ret    

00800ee1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ee1:	55                   	push   %ebp
  800ee2:	89 e5                	mov    %esp,%ebp
  800ee4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ee7:	ff 75 08             	pushl  0x8(%ebp)
  800eea:	e8 54 fa ff ff       	call   800943 <strlen>
  800eef:	83 c4 04             	add    $0x4,%esp
  800ef2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ef5:	ff 75 0c             	pushl  0xc(%ebp)
  800ef8:	e8 46 fa ff ff       	call   800943 <strlen>
  800efd:	83 c4 04             	add    $0x4,%esp
  800f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f11:	eb 17                	jmp    800f2a <strcconcat+0x49>
		final[s] = str1[s] ;
  800f13:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f16:	8b 45 10             	mov    0x10(%ebp),%eax
  800f19:	01 c2                	add    %eax,%edx
  800f1b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f21:	01 c8                	add    %ecx,%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f27:	ff 45 fc             	incl   -0x4(%ebp)
  800f2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f30:	7c e1                	jl     800f13 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f32:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f39:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f40:	eb 1f                	jmp    800f61 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f45:	8d 50 01             	lea    0x1(%eax),%edx
  800f48:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f4b:	89 c2                	mov    %eax,%edx
  800f4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f50:	01 c2                	add    %eax,%edx
  800f52:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f58:	01 c8                	add    %ecx,%eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f5e:	ff 45 f8             	incl   -0x8(%ebp)
  800f61:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f64:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f67:	7c d9                	jl     800f42 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f69:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6f:	01 d0                	add    %edx,%eax
  800f71:	c6 00 00             	movb   $0x0,(%eax)
}
  800f74:	90                   	nop
  800f75:	c9                   	leave  
  800f76:	c3                   	ret    

00800f77 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f77:	55                   	push   %ebp
  800f78:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f83:	8b 45 14             	mov    0x14(%ebp),%eax
  800f86:	8b 00                	mov    (%eax),%eax
  800f88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	01 d0                	add    %edx,%eax
  800f94:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f9a:	eb 0c                	jmp    800fa8 <strsplit+0x31>
			*string++ = 0;
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8d 50 01             	lea    0x1(%eax),%edx
  800fa2:	89 55 08             	mov    %edx,0x8(%ebp)
  800fa5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	84 c0                	test   %al,%al
  800faf:	74 18                	je     800fc9 <strsplit+0x52>
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	0f be c0             	movsbl %al,%eax
  800fb9:	50                   	push   %eax
  800fba:	ff 75 0c             	pushl  0xc(%ebp)
  800fbd:	e8 13 fb ff ff       	call   800ad5 <strchr>
  800fc2:	83 c4 08             	add    $0x8,%esp
  800fc5:	85 c0                	test   %eax,%eax
  800fc7:	75 d3                	jne    800f9c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	84 c0                	test   %al,%al
  800fd0:	74 5a                	je     80102c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800fd2:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd5:	8b 00                	mov    (%eax),%eax
  800fd7:	83 f8 0f             	cmp    $0xf,%eax
  800fda:	75 07                	jne    800fe3 <strsplit+0x6c>
		{
			return 0;
  800fdc:	b8 00 00 00 00       	mov    $0x0,%eax
  800fe1:	eb 66                	jmp    801049 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fe3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe6:	8b 00                	mov    (%eax),%eax
  800fe8:	8d 48 01             	lea    0x1(%eax),%ecx
  800feb:	8b 55 14             	mov    0x14(%ebp),%edx
  800fee:	89 0a                	mov    %ecx,(%edx)
  800ff0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff7:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffa:	01 c2                	add    %eax,%edx
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801001:	eb 03                	jmp    801006 <strsplit+0x8f>
			string++;
  801003:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	84 c0                	test   %al,%al
  80100d:	74 8b                	je     800f9a <strsplit+0x23>
  80100f:	8b 45 08             	mov    0x8(%ebp),%eax
  801012:	8a 00                	mov    (%eax),%al
  801014:	0f be c0             	movsbl %al,%eax
  801017:	50                   	push   %eax
  801018:	ff 75 0c             	pushl  0xc(%ebp)
  80101b:	e8 b5 fa ff ff       	call   800ad5 <strchr>
  801020:	83 c4 08             	add    $0x8,%esp
  801023:	85 c0                	test   %eax,%eax
  801025:	74 dc                	je     801003 <strsplit+0x8c>
			string++;
	}
  801027:	e9 6e ff ff ff       	jmp    800f9a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80102c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80102d:	8b 45 14             	mov    0x14(%ebp),%eax
  801030:	8b 00                	mov    (%eax),%eax
  801032:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801039:	8b 45 10             	mov    0x10(%ebp),%eax
  80103c:	01 d0                	add    %edx,%eax
  80103e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801044:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801049:	c9                   	leave  
  80104a:	c3                   	ret    

0080104b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80104b:	55                   	push   %ebp
  80104c:	89 e5                	mov    %esp,%ebp
  80104e:	57                   	push   %edi
  80104f:	56                   	push   %esi
  801050:	53                   	push   %ebx
  801051:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	8b 55 0c             	mov    0xc(%ebp),%edx
  80105a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80105d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801060:	8b 7d 18             	mov    0x18(%ebp),%edi
  801063:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801066:	cd 30                	int    $0x30
  801068:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80106b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80106e:	83 c4 10             	add    $0x10,%esp
  801071:	5b                   	pop    %ebx
  801072:	5e                   	pop    %esi
  801073:	5f                   	pop    %edi
  801074:	5d                   	pop    %ebp
  801075:	c3                   	ret    

00801076 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801076:	55                   	push   %ebp
  801077:	89 e5                	mov    %esp,%ebp
  801079:	83 ec 04             	sub    $0x4,%esp
  80107c:	8b 45 10             	mov    0x10(%ebp),%eax
  80107f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801082:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	6a 00                	push   $0x0
  80108b:	6a 00                	push   $0x0
  80108d:	52                   	push   %edx
  80108e:	ff 75 0c             	pushl  0xc(%ebp)
  801091:	50                   	push   %eax
  801092:	6a 00                	push   $0x0
  801094:	e8 b2 ff ff ff       	call   80104b <syscall>
  801099:	83 c4 18             	add    $0x18,%esp
}
  80109c:	90                   	nop
  80109d:	c9                   	leave  
  80109e:	c3                   	ret    

0080109f <sys_cgetc>:

int
sys_cgetc(void)
{
  80109f:	55                   	push   %ebp
  8010a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010a2:	6a 00                	push   $0x0
  8010a4:	6a 00                	push   $0x0
  8010a6:	6a 00                	push   $0x0
  8010a8:	6a 00                	push   $0x0
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 01                	push   $0x1
  8010ae:	e8 98 ff ff ff       	call   80104b <syscall>
  8010b3:	83 c4 18             	add    $0x18,%esp
}
  8010b6:	c9                   	leave  
  8010b7:	c3                   	ret    

008010b8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010b8:	55                   	push   %ebp
  8010b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	6a 00                	push   $0x0
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 00                	push   $0x0
  8010c6:	50                   	push   %eax
  8010c7:	6a 05                	push   $0x5
  8010c9:	e8 7d ff ff ff       	call   80104b <syscall>
  8010ce:	83 c4 18             	add    $0x18,%esp
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010d6:	6a 00                	push   $0x0
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 00                	push   $0x0
  8010dc:	6a 00                	push   $0x0
  8010de:	6a 00                	push   $0x0
  8010e0:	6a 02                	push   $0x2
  8010e2:	e8 64 ff ff ff       	call   80104b <syscall>
  8010e7:	83 c4 18             	add    $0x18,%esp
}
  8010ea:	c9                   	leave  
  8010eb:	c3                   	ret    

008010ec <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010ec:	55                   	push   %ebp
  8010ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010ef:	6a 00                	push   $0x0
  8010f1:	6a 00                	push   $0x0
  8010f3:	6a 00                	push   $0x0
  8010f5:	6a 00                	push   $0x0
  8010f7:	6a 00                	push   $0x0
  8010f9:	6a 03                	push   $0x3
  8010fb:	e8 4b ff ff ff       	call   80104b <syscall>
  801100:	83 c4 18             	add    $0x18,%esp
}
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	6a 00                	push   $0x0
  80110e:	6a 00                	push   $0x0
  801110:	6a 00                	push   $0x0
  801112:	6a 04                	push   $0x4
  801114:	e8 32 ff ff ff       	call   80104b <syscall>
  801119:	83 c4 18             	add    $0x18,%esp
}
  80111c:	c9                   	leave  
  80111d:	c3                   	ret    

0080111e <sys_env_exit>:


void sys_env_exit(void)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801121:	6a 00                	push   $0x0
  801123:	6a 00                	push   $0x0
  801125:	6a 00                	push   $0x0
  801127:	6a 00                	push   $0x0
  801129:	6a 00                	push   $0x0
  80112b:	6a 06                	push   $0x6
  80112d:	e8 19 ff ff ff       	call   80104b <syscall>
  801132:	83 c4 18             	add    $0x18,%esp
}
  801135:	90                   	nop
  801136:	c9                   	leave  
  801137:	c3                   	ret    

00801138 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801138:	55                   	push   %ebp
  801139:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80113b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	6a 00                	push   $0x0
  801143:	6a 00                	push   $0x0
  801145:	6a 00                	push   $0x0
  801147:	52                   	push   %edx
  801148:	50                   	push   %eax
  801149:	6a 07                	push   $0x7
  80114b:	e8 fb fe ff ff       	call   80104b <syscall>
  801150:	83 c4 18             	add    $0x18,%esp
}
  801153:	c9                   	leave  
  801154:	c3                   	ret    

00801155 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801155:	55                   	push   %ebp
  801156:	89 e5                	mov    %esp,%ebp
  801158:	56                   	push   %esi
  801159:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80115a:	8b 75 18             	mov    0x18(%ebp),%esi
  80115d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801160:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801163:	8b 55 0c             	mov    0xc(%ebp),%edx
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	56                   	push   %esi
  80116a:	53                   	push   %ebx
  80116b:	51                   	push   %ecx
  80116c:	52                   	push   %edx
  80116d:	50                   	push   %eax
  80116e:	6a 08                	push   $0x8
  801170:	e8 d6 fe ff ff       	call   80104b <syscall>
  801175:	83 c4 18             	add    $0x18,%esp
}
  801178:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80117b:	5b                   	pop    %ebx
  80117c:	5e                   	pop    %esi
  80117d:	5d                   	pop    %ebp
  80117e:	c3                   	ret    

0080117f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80117f:	55                   	push   %ebp
  801180:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801182:	8b 55 0c             	mov    0xc(%ebp),%edx
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	6a 00                	push   $0x0
  80118a:	6a 00                	push   $0x0
  80118c:	6a 00                	push   $0x0
  80118e:	52                   	push   %edx
  80118f:	50                   	push   %eax
  801190:	6a 09                	push   $0x9
  801192:	e8 b4 fe ff ff       	call   80104b <syscall>
  801197:	83 c4 18             	add    $0x18,%esp
}
  80119a:	c9                   	leave  
  80119b:	c3                   	ret    

0080119c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80119c:	55                   	push   %ebp
  80119d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 00                	push   $0x0
  8011a3:	6a 00                	push   $0x0
  8011a5:	ff 75 0c             	pushl  0xc(%ebp)
  8011a8:	ff 75 08             	pushl  0x8(%ebp)
  8011ab:	6a 0a                	push   $0xa
  8011ad:	e8 99 fe ff ff       	call   80104b <syscall>
  8011b2:	83 c4 18             	add    $0x18,%esp
}
  8011b5:	c9                   	leave  
  8011b6:	c3                   	ret    

008011b7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 00                	push   $0x0
  8011c4:	6a 0b                	push   $0xb
  8011c6:	e8 80 fe ff ff       	call   80104b <syscall>
  8011cb:	83 c4 18             	add    $0x18,%esp
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011d3:	6a 00                	push   $0x0
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 00                	push   $0x0
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 0c                	push   $0xc
  8011df:	e8 67 fe ff ff       	call   80104b <syscall>
  8011e4:	83 c4 18             	add    $0x18,%esp
}
  8011e7:	c9                   	leave  
  8011e8:	c3                   	ret    

008011e9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011e9:	55                   	push   %ebp
  8011ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 0d                	push   $0xd
  8011f8:	e8 4e fe ff ff       	call   80104b <syscall>
  8011fd:	83 c4 18             	add    $0x18,%esp
}
  801200:	c9                   	leave  
  801201:	c3                   	ret    

00801202 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801202:	55                   	push   %ebp
  801203:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801205:	6a 00                	push   $0x0
  801207:	6a 00                	push   $0x0
  801209:	6a 00                	push   $0x0
  80120b:	ff 75 0c             	pushl  0xc(%ebp)
  80120e:	ff 75 08             	pushl  0x8(%ebp)
  801211:	6a 11                	push   $0x11
  801213:	e8 33 fe ff ff       	call   80104b <syscall>
  801218:	83 c4 18             	add    $0x18,%esp
	return;
  80121b:	90                   	nop
}
  80121c:	c9                   	leave  
  80121d:	c3                   	ret    

0080121e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80121e:	55                   	push   %ebp
  80121f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801221:	6a 00                	push   $0x0
  801223:	6a 00                	push   $0x0
  801225:	6a 00                	push   $0x0
  801227:	ff 75 0c             	pushl  0xc(%ebp)
  80122a:	ff 75 08             	pushl  0x8(%ebp)
  80122d:	6a 12                	push   $0x12
  80122f:	e8 17 fe ff ff       	call   80104b <syscall>
  801234:	83 c4 18             	add    $0x18,%esp
	return ;
  801237:	90                   	nop
}
  801238:	c9                   	leave  
  801239:	c3                   	ret    

0080123a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80123a:	55                   	push   %ebp
  80123b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 00                	push   $0x0
  801247:	6a 0e                	push   $0xe
  801249:	e8 fd fd ff ff       	call   80104b <syscall>
  80124e:	83 c4 18             	add    $0x18,%esp
}
  801251:	c9                   	leave  
  801252:	c3                   	ret    

00801253 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801253:	55                   	push   %ebp
  801254:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801256:	6a 00                	push   $0x0
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	ff 75 08             	pushl  0x8(%ebp)
  801261:	6a 0f                	push   $0xf
  801263:	e8 e3 fd ff ff       	call   80104b <syscall>
  801268:	83 c4 18             	add    $0x18,%esp
}
  80126b:	c9                   	leave  
  80126c:	c3                   	ret    

0080126d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80126d:	55                   	push   %ebp
  80126e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801270:	6a 00                	push   $0x0
  801272:	6a 00                	push   $0x0
  801274:	6a 00                	push   $0x0
  801276:	6a 00                	push   $0x0
  801278:	6a 00                	push   $0x0
  80127a:	6a 10                	push   $0x10
  80127c:	e8 ca fd ff ff       	call   80104b <syscall>
  801281:	83 c4 18             	add    $0x18,%esp
}
  801284:	90                   	nop
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 00                	push   $0x0
  801294:	6a 14                	push   $0x14
  801296:	e8 b0 fd ff ff       	call   80104b <syscall>
  80129b:	83 c4 18             	add    $0x18,%esp
}
  80129e:	90                   	nop
  80129f:	c9                   	leave  
  8012a0:	c3                   	ret    

008012a1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012a1:	55                   	push   %ebp
  8012a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 00                	push   $0x0
  8012ae:	6a 15                	push   $0x15
  8012b0:	e8 96 fd ff ff       	call   80104b <syscall>
  8012b5:	83 c4 18             	add    $0x18,%esp
}
  8012b8:	90                   	nop
  8012b9:	c9                   	leave  
  8012ba:	c3                   	ret    

008012bb <sys_cputc>:


void
sys_cputc(const char c)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
  8012be:	83 ec 04             	sub    $0x4,%esp
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012c7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	50                   	push   %eax
  8012d4:	6a 16                	push   $0x16
  8012d6:	e8 70 fd ff ff       	call   80104b <syscall>
  8012db:	83 c4 18             	add    $0x18,%esp
}
  8012de:	90                   	nop
  8012df:	c9                   	leave  
  8012e0:	c3                   	ret    

008012e1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012e1:	55                   	push   %ebp
  8012e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 17                	push   $0x17
  8012f0:	e8 56 fd ff ff       	call   80104b <syscall>
  8012f5:	83 c4 18             	add    $0x18,%esp
}
  8012f8:	90                   	nop
  8012f9:	c9                   	leave  
  8012fa:	c3                   	ret    

008012fb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	ff 75 0c             	pushl  0xc(%ebp)
  80130a:	50                   	push   %eax
  80130b:	6a 18                	push   $0x18
  80130d:	e8 39 fd ff ff       	call   80104b <syscall>
  801312:	83 c4 18             	add    $0x18,%esp
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80131a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	52                   	push   %edx
  801327:	50                   	push   %eax
  801328:	6a 1b                	push   $0x1b
  80132a:	e8 1c fd ff ff       	call   80104b <syscall>
  80132f:	83 c4 18             	add    $0x18,%esp
}
  801332:	c9                   	leave  
  801333:	c3                   	ret    

00801334 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801337:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	52                   	push   %edx
  801344:	50                   	push   %eax
  801345:	6a 19                	push   $0x19
  801347:	e8 ff fc ff ff       	call   80104b <syscall>
  80134c:	83 c4 18             	add    $0x18,%esp
}
  80134f:	90                   	nop
  801350:	c9                   	leave  
  801351:	c3                   	ret    

00801352 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801352:	55                   	push   %ebp
  801353:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801355:	8b 55 0c             	mov    0xc(%ebp),%edx
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	52                   	push   %edx
  801362:	50                   	push   %eax
  801363:	6a 1a                	push   $0x1a
  801365:	e8 e1 fc ff ff       	call   80104b <syscall>
  80136a:	83 c4 18             	add    $0x18,%esp
}
  80136d:	90                   	nop
  80136e:	c9                   	leave  
  80136f:	c3                   	ret    

00801370 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801370:	55                   	push   %ebp
  801371:	89 e5                	mov    %esp,%ebp
  801373:	83 ec 04             	sub    $0x4,%esp
  801376:	8b 45 10             	mov    0x10(%ebp),%eax
  801379:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80137c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80137f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801383:	8b 45 08             	mov    0x8(%ebp),%eax
  801386:	6a 00                	push   $0x0
  801388:	51                   	push   %ecx
  801389:	52                   	push   %edx
  80138a:	ff 75 0c             	pushl  0xc(%ebp)
  80138d:	50                   	push   %eax
  80138e:	6a 1c                	push   $0x1c
  801390:	e8 b6 fc ff ff       	call   80104b <syscall>
  801395:	83 c4 18             	add    $0x18,%esp
}
  801398:	c9                   	leave  
  801399:	c3                   	ret    

0080139a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80139a:	55                   	push   %ebp
  80139b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80139d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	52                   	push   %edx
  8013aa:	50                   	push   %eax
  8013ab:	6a 1d                	push   $0x1d
  8013ad:	e8 99 fc ff ff       	call   80104b <syscall>
  8013b2:	83 c4 18             	add    $0x18,%esp
}
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	51                   	push   %ecx
  8013c8:	52                   	push   %edx
  8013c9:	50                   	push   %eax
  8013ca:	6a 1e                	push   $0x1e
  8013cc:	e8 7a fc ff ff       	call   80104b <syscall>
  8013d1:	83 c4 18             	add    $0x18,%esp
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	52                   	push   %edx
  8013e6:	50                   	push   %eax
  8013e7:	6a 1f                	push   $0x1f
  8013e9:	e8 5d fc ff ff       	call   80104b <syscall>
  8013ee:	83 c4 18             	add    $0x18,%esp
}
  8013f1:	c9                   	leave  
  8013f2:	c3                   	ret    

008013f3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013f3:	55                   	push   %ebp
  8013f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 20                	push   $0x20
  801402:	e8 44 fc ff ff       	call   80104b <syscall>
  801407:	83 c4 18             	add    $0x18,%esp
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	ff 75 10             	pushl  0x10(%ebp)
  801419:	ff 75 0c             	pushl  0xc(%ebp)
  80141c:	50                   	push   %eax
  80141d:	6a 21                	push   $0x21
  80141f:	e8 27 fc ff ff       	call   80104b <syscall>
  801424:	83 c4 18             	add    $0x18,%esp
}
  801427:	c9                   	leave  
  801428:	c3                   	ret    

00801429 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801429:	55                   	push   %ebp
  80142a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	50                   	push   %eax
  801438:	6a 22                	push   $0x22
  80143a:	e8 0c fc ff ff       	call   80104b <syscall>
  80143f:	83 c4 18             	add    $0x18,%esp
}
  801442:	90                   	nop
  801443:	c9                   	leave  
  801444:	c3                   	ret    

00801445 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801445:	55                   	push   %ebp
  801446:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	50                   	push   %eax
  801454:	6a 23                	push   $0x23
  801456:	e8 f0 fb ff ff       	call   80104b <syscall>
  80145b:	83 c4 18             	add    $0x18,%esp
}
  80145e:	90                   	nop
  80145f:	c9                   	leave  
  801460:	c3                   	ret    

00801461 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801461:	55                   	push   %ebp
  801462:	89 e5                	mov    %esp,%ebp
  801464:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801467:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80146a:	8d 50 04             	lea    0x4(%eax),%edx
  80146d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	52                   	push   %edx
  801477:	50                   	push   %eax
  801478:	6a 24                	push   $0x24
  80147a:	e8 cc fb ff ff       	call   80104b <syscall>
  80147f:	83 c4 18             	add    $0x18,%esp
	return result;
  801482:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801485:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801488:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148b:	89 01                	mov    %eax,(%ecx)
  80148d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	c9                   	leave  
  801494:	c2 04 00             	ret    $0x4

00801497 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	ff 75 10             	pushl  0x10(%ebp)
  8014a1:	ff 75 0c             	pushl  0xc(%ebp)
  8014a4:	ff 75 08             	pushl  0x8(%ebp)
  8014a7:	6a 13                	push   $0x13
  8014a9:	e8 9d fb ff ff       	call   80104b <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b1:	90                   	nop
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 25                	push   $0x25
  8014c3:	e8 83 fb ff ff       	call   80104b <syscall>
  8014c8:	83 c4 18             	add    $0x18,%esp
}
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 04             	sub    $0x4,%esp
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014d9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	50                   	push   %eax
  8014e6:	6a 26                	push   $0x26
  8014e8:	e8 5e fb ff ff       	call   80104b <syscall>
  8014ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f0:	90                   	nop
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <rsttst>:
void rsttst()
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 28                	push   $0x28
  801502:	e8 44 fb ff ff       	call   80104b <syscall>
  801507:	83 c4 18             	add    $0x18,%esp
	return ;
  80150a:	90                   	nop
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
  801510:	83 ec 04             	sub    $0x4,%esp
  801513:	8b 45 14             	mov    0x14(%ebp),%eax
  801516:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801519:	8b 55 18             	mov    0x18(%ebp),%edx
  80151c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801520:	52                   	push   %edx
  801521:	50                   	push   %eax
  801522:	ff 75 10             	pushl  0x10(%ebp)
  801525:	ff 75 0c             	pushl  0xc(%ebp)
  801528:	ff 75 08             	pushl  0x8(%ebp)
  80152b:	6a 27                	push   $0x27
  80152d:	e8 19 fb ff ff       	call   80104b <syscall>
  801532:	83 c4 18             	add    $0x18,%esp
	return ;
  801535:	90                   	nop
}
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <chktst>:
void chktst(uint32 n)
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	ff 75 08             	pushl  0x8(%ebp)
  801546:	6a 29                	push   $0x29
  801548:	e8 fe fa ff ff       	call   80104b <syscall>
  80154d:	83 c4 18             	add    $0x18,%esp
	return ;
  801550:	90                   	nop
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <inctst>:

void inctst()
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 2a                	push   $0x2a
  801562:	e8 e4 fa ff ff       	call   80104b <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
	return ;
  80156a:	90                   	nop
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <gettst>:
uint32 gettst()
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 2b                	push   $0x2b
  80157c:	e8 ca fa ff ff       	call   80104b <syscall>
  801581:	83 c4 18             	add    $0x18,%esp
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 2c                	push   $0x2c
  801598:	e8 ae fa ff ff       	call   80104b <syscall>
  80159d:	83 c4 18             	add    $0x18,%esp
  8015a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015a3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015a7:	75 07                	jne    8015b0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ae:	eb 05                	jmp    8015b5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
  8015ba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 2c                	push   $0x2c
  8015c9:	e8 7d fa ff ff       	call   80104b <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
  8015d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015d4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015d8:	75 07                	jne    8015e1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015da:	b8 01 00 00 00       	mov    $0x1,%eax
  8015df:	eb 05                	jmp    8015e6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
  8015eb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 2c                	push   $0x2c
  8015fa:	e8 4c fa ff ff       	call   80104b <syscall>
  8015ff:	83 c4 18             	add    $0x18,%esp
  801602:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801605:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801609:	75 07                	jne    801612 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80160b:	b8 01 00 00 00       	mov    $0x1,%eax
  801610:	eb 05                	jmp    801617 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801612:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
  80161c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 2c                	push   $0x2c
  80162b:	e8 1b fa ff ff       	call   80104b <syscall>
  801630:	83 c4 18             	add    $0x18,%esp
  801633:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801636:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80163a:	75 07                	jne    801643 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80163c:	b8 01 00 00 00       	mov    $0x1,%eax
  801641:	eb 05                	jmp    801648 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801643:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	ff 75 08             	pushl  0x8(%ebp)
  801658:	6a 2d                	push   $0x2d
  80165a:	e8 ec f9 ff ff       	call   80104b <syscall>
  80165f:	83 c4 18             	add    $0x18,%esp
	return ;
  801662:	90                   	nop
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    
  801665:	66 90                	xchg   %ax,%ax
  801667:	90                   	nop

00801668 <__udivdi3>:
  801668:	55                   	push   %ebp
  801669:	57                   	push   %edi
  80166a:	56                   	push   %esi
  80166b:	53                   	push   %ebx
  80166c:	83 ec 1c             	sub    $0x1c,%esp
  80166f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801673:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801677:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80167b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80167f:	89 ca                	mov    %ecx,%edx
  801681:	89 f8                	mov    %edi,%eax
  801683:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801687:	85 f6                	test   %esi,%esi
  801689:	75 2d                	jne    8016b8 <__udivdi3+0x50>
  80168b:	39 cf                	cmp    %ecx,%edi
  80168d:	77 65                	ja     8016f4 <__udivdi3+0x8c>
  80168f:	89 fd                	mov    %edi,%ebp
  801691:	85 ff                	test   %edi,%edi
  801693:	75 0b                	jne    8016a0 <__udivdi3+0x38>
  801695:	b8 01 00 00 00       	mov    $0x1,%eax
  80169a:	31 d2                	xor    %edx,%edx
  80169c:	f7 f7                	div    %edi
  80169e:	89 c5                	mov    %eax,%ebp
  8016a0:	31 d2                	xor    %edx,%edx
  8016a2:	89 c8                	mov    %ecx,%eax
  8016a4:	f7 f5                	div    %ebp
  8016a6:	89 c1                	mov    %eax,%ecx
  8016a8:	89 d8                	mov    %ebx,%eax
  8016aa:	f7 f5                	div    %ebp
  8016ac:	89 cf                	mov    %ecx,%edi
  8016ae:	89 fa                	mov    %edi,%edx
  8016b0:	83 c4 1c             	add    $0x1c,%esp
  8016b3:	5b                   	pop    %ebx
  8016b4:	5e                   	pop    %esi
  8016b5:	5f                   	pop    %edi
  8016b6:	5d                   	pop    %ebp
  8016b7:	c3                   	ret    
  8016b8:	39 ce                	cmp    %ecx,%esi
  8016ba:	77 28                	ja     8016e4 <__udivdi3+0x7c>
  8016bc:	0f bd fe             	bsr    %esi,%edi
  8016bf:	83 f7 1f             	xor    $0x1f,%edi
  8016c2:	75 40                	jne    801704 <__udivdi3+0x9c>
  8016c4:	39 ce                	cmp    %ecx,%esi
  8016c6:	72 0a                	jb     8016d2 <__udivdi3+0x6a>
  8016c8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016cc:	0f 87 9e 00 00 00    	ja     801770 <__udivdi3+0x108>
  8016d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d7:	89 fa                	mov    %edi,%edx
  8016d9:	83 c4 1c             	add    $0x1c,%esp
  8016dc:	5b                   	pop    %ebx
  8016dd:	5e                   	pop    %esi
  8016de:	5f                   	pop    %edi
  8016df:	5d                   	pop    %ebp
  8016e0:	c3                   	ret    
  8016e1:	8d 76 00             	lea    0x0(%esi),%esi
  8016e4:	31 ff                	xor    %edi,%edi
  8016e6:	31 c0                	xor    %eax,%eax
  8016e8:	89 fa                	mov    %edi,%edx
  8016ea:	83 c4 1c             	add    $0x1c,%esp
  8016ed:	5b                   	pop    %ebx
  8016ee:	5e                   	pop    %esi
  8016ef:	5f                   	pop    %edi
  8016f0:	5d                   	pop    %ebp
  8016f1:	c3                   	ret    
  8016f2:	66 90                	xchg   %ax,%ax
  8016f4:	89 d8                	mov    %ebx,%eax
  8016f6:	f7 f7                	div    %edi
  8016f8:	31 ff                	xor    %edi,%edi
  8016fa:	89 fa                	mov    %edi,%edx
  8016fc:	83 c4 1c             	add    $0x1c,%esp
  8016ff:	5b                   	pop    %ebx
  801700:	5e                   	pop    %esi
  801701:	5f                   	pop    %edi
  801702:	5d                   	pop    %ebp
  801703:	c3                   	ret    
  801704:	bd 20 00 00 00       	mov    $0x20,%ebp
  801709:	89 eb                	mov    %ebp,%ebx
  80170b:	29 fb                	sub    %edi,%ebx
  80170d:	89 f9                	mov    %edi,%ecx
  80170f:	d3 e6                	shl    %cl,%esi
  801711:	89 c5                	mov    %eax,%ebp
  801713:	88 d9                	mov    %bl,%cl
  801715:	d3 ed                	shr    %cl,%ebp
  801717:	89 e9                	mov    %ebp,%ecx
  801719:	09 f1                	or     %esi,%ecx
  80171b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80171f:	89 f9                	mov    %edi,%ecx
  801721:	d3 e0                	shl    %cl,%eax
  801723:	89 c5                	mov    %eax,%ebp
  801725:	89 d6                	mov    %edx,%esi
  801727:	88 d9                	mov    %bl,%cl
  801729:	d3 ee                	shr    %cl,%esi
  80172b:	89 f9                	mov    %edi,%ecx
  80172d:	d3 e2                	shl    %cl,%edx
  80172f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801733:	88 d9                	mov    %bl,%cl
  801735:	d3 e8                	shr    %cl,%eax
  801737:	09 c2                	or     %eax,%edx
  801739:	89 d0                	mov    %edx,%eax
  80173b:	89 f2                	mov    %esi,%edx
  80173d:	f7 74 24 0c          	divl   0xc(%esp)
  801741:	89 d6                	mov    %edx,%esi
  801743:	89 c3                	mov    %eax,%ebx
  801745:	f7 e5                	mul    %ebp
  801747:	39 d6                	cmp    %edx,%esi
  801749:	72 19                	jb     801764 <__udivdi3+0xfc>
  80174b:	74 0b                	je     801758 <__udivdi3+0xf0>
  80174d:	89 d8                	mov    %ebx,%eax
  80174f:	31 ff                	xor    %edi,%edi
  801751:	e9 58 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  801756:	66 90                	xchg   %ax,%ax
  801758:	8b 54 24 08          	mov    0x8(%esp),%edx
  80175c:	89 f9                	mov    %edi,%ecx
  80175e:	d3 e2                	shl    %cl,%edx
  801760:	39 c2                	cmp    %eax,%edx
  801762:	73 e9                	jae    80174d <__udivdi3+0xe5>
  801764:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801767:	31 ff                	xor    %edi,%edi
  801769:	e9 40 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  80176e:	66 90                	xchg   %ax,%ax
  801770:	31 c0                	xor    %eax,%eax
  801772:	e9 37 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  801777:	90                   	nop

00801778 <__umoddi3>:
  801778:	55                   	push   %ebp
  801779:	57                   	push   %edi
  80177a:	56                   	push   %esi
  80177b:	53                   	push   %ebx
  80177c:	83 ec 1c             	sub    $0x1c,%esp
  80177f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801783:	8b 74 24 34          	mov    0x34(%esp),%esi
  801787:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80178b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80178f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801793:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801797:	89 f3                	mov    %esi,%ebx
  801799:	89 fa                	mov    %edi,%edx
  80179b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80179f:	89 34 24             	mov    %esi,(%esp)
  8017a2:	85 c0                	test   %eax,%eax
  8017a4:	75 1a                	jne    8017c0 <__umoddi3+0x48>
  8017a6:	39 f7                	cmp    %esi,%edi
  8017a8:	0f 86 a2 00 00 00    	jbe    801850 <__umoddi3+0xd8>
  8017ae:	89 c8                	mov    %ecx,%eax
  8017b0:	89 f2                	mov    %esi,%edx
  8017b2:	f7 f7                	div    %edi
  8017b4:	89 d0                	mov    %edx,%eax
  8017b6:	31 d2                	xor    %edx,%edx
  8017b8:	83 c4 1c             	add    $0x1c,%esp
  8017bb:	5b                   	pop    %ebx
  8017bc:	5e                   	pop    %esi
  8017bd:	5f                   	pop    %edi
  8017be:	5d                   	pop    %ebp
  8017bf:	c3                   	ret    
  8017c0:	39 f0                	cmp    %esi,%eax
  8017c2:	0f 87 ac 00 00 00    	ja     801874 <__umoddi3+0xfc>
  8017c8:	0f bd e8             	bsr    %eax,%ebp
  8017cb:	83 f5 1f             	xor    $0x1f,%ebp
  8017ce:	0f 84 ac 00 00 00    	je     801880 <__umoddi3+0x108>
  8017d4:	bf 20 00 00 00       	mov    $0x20,%edi
  8017d9:	29 ef                	sub    %ebp,%edi
  8017db:	89 fe                	mov    %edi,%esi
  8017dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017e1:	89 e9                	mov    %ebp,%ecx
  8017e3:	d3 e0                	shl    %cl,%eax
  8017e5:	89 d7                	mov    %edx,%edi
  8017e7:	89 f1                	mov    %esi,%ecx
  8017e9:	d3 ef                	shr    %cl,%edi
  8017eb:	09 c7                	or     %eax,%edi
  8017ed:	89 e9                	mov    %ebp,%ecx
  8017ef:	d3 e2                	shl    %cl,%edx
  8017f1:	89 14 24             	mov    %edx,(%esp)
  8017f4:	89 d8                	mov    %ebx,%eax
  8017f6:	d3 e0                	shl    %cl,%eax
  8017f8:	89 c2                	mov    %eax,%edx
  8017fa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017fe:	d3 e0                	shl    %cl,%eax
  801800:	89 44 24 04          	mov    %eax,0x4(%esp)
  801804:	8b 44 24 08          	mov    0x8(%esp),%eax
  801808:	89 f1                	mov    %esi,%ecx
  80180a:	d3 e8                	shr    %cl,%eax
  80180c:	09 d0                	or     %edx,%eax
  80180e:	d3 eb                	shr    %cl,%ebx
  801810:	89 da                	mov    %ebx,%edx
  801812:	f7 f7                	div    %edi
  801814:	89 d3                	mov    %edx,%ebx
  801816:	f7 24 24             	mull   (%esp)
  801819:	89 c6                	mov    %eax,%esi
  80181b:	89 d1                	mov    %edx,%ecx
  80181d:	39 d3                	cmp    %edx,%ebx
  80181f:	0f 82 87 00 00 00    	jb     8018ac <__umoddi3+0x134>
  801825:	0f 84 91 00 00 00    	je     8018bc <__umoddi3+0x144>
  80182b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80182f:	29 f2                	sub    %esi,%edx
  801831:	19 cb                	sbb    %ecx,%ebx
  801833:	89 d8                	mov    %ebx,%eax
  801835:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801839:	d3 e0                	shl    %cl,%eax
  80183b:	89 e9                	mov    %ebp,%ecx
  80183d:	d3 ea                	shr    %cl,%edx
  80183f:	09 d0                	or     %edx,%eax
  801841:	89 e9                	mov    %ebp,%ecx
  801843:	d3 eb                	shr    %cl,%ebx
  801845:	89 da                	mov    %ebx,%edx
  801847:	83 c4 1c             	add    $0x1c,%esp
  80184a:	5b                   	pop    %ebx
  80184b:	5e                   	pop    %esi
  80184c:	5f                   	pop    %edi
  80184d:	5d                   	pop    %ebp
  80184e:	c3                   	ret    
  80184f:	90                   	nop
  801850:	89 fd                	mov    %edi,%ebp
  801852:	85 ff                	test   %edi,%edi
  801854:	75 0b                	jne    801861 <__umoddi3+0xe9>
  801856:	b8 01 00 00 00       	mov    $0x1,%eax
  80185b:	31 d2                	xor    %edx,%edx
  80185d:	f7 f7                	div    %edi
  80185f:	89 c5                	mov    %eax,%ebp
  801861:	89 f0                	mov    %esi,%eax
  801863:	31 d2                	xor    %edx,%edx
  801865:	f7 f5                	div    %ebp
  801867:	89 c8                	mov    %ecx,%eax
  801869:	f7 f5                	div    %ebp
  80186b:	89 d0                	mov    %edx,%eax
  80186d:	e9 44 ff ff ff       	jmp    8017b6 <__umoddi3+0x3e>
  801872:	66 90                	xchg   %ax,%ax
  801874:	89 c8                	mov    %ecx,%eax
  801876:	89 f2                	mov    %esi,%edx
  801878:	83 c4 1c             	add    $0x1c,%esp
  80187b:	5b                   	pop    %ebx
  80187c:	5e                   	pop    %esi
  80187d:	5f                   	pop    %edi
  80187e:	5d                   	pop    %ebp
  80187f:	c3                   	ret    
  801880:	3b 04 24             	cmp    (%esp),%eax
  801883:	72 06                	jb     80188b <__umoddi3+0x113>
  801885:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801889:	77 0f                	ja     80189a <__umoddi3+0x122>
  80188b:	89 f2                	mov    %esi,%edx
  80188d:	29 f9                	sub    %edi,%ecx
  80188f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801893:	89 14 24             	mov    %edx,(%esp)
  801896:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80189a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80189e:	8b 14 24             	mov    (%esp),%edx
  8018a1:	83 c4 1c             	add    $0x1c,%esp
  8018a4:	5b                   	pop    %ebx
  8018a5:	5e                   	pop    %esi
  8018a6:	5f                   	pop    %edi
  8018a7:	5d                   	pop    %ebp
  8018a8:	c3                   	ret    
  8018a9:	8d 76 00             	lea    0x0(%esi),%esi
  8018ac:	2b 04 24             	sub    (%esp),%eax
  8018af:	19 fa                	sbb    %edi,%edx
  8018b1:	89 d1                	mov    %edx,%ecx
  8018b3:	89 c6                	mov    %eax,%esi
  8018b5:	e9 71 ff ff ff       	jmp    80182b <__umoddi3+0xb3>
  8018ba:	66 90                	xchg   %ax,%ax
  8018bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018c0:	72 ea                	jb     8018ac <__umoddi3+0x134>
  8018c2:	89 d9                	mov    %ebx,%ecx
  8018c4:	e9 62 ff ff ff       	jmp    80182b <__umoddi3+0xb3>
