
obj/user/dummy_process:     file format elf32-i386


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
  800031:	e8 8d 00 00 00       	call   8000c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void high_complexity_function();

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	high_complexity_function() ;
  80003e:	e8 03 00 00 00       	call   800046 <high_complexity_function>
	return;
  800043:	90                   	nop
}
  800044:	c9                   	leave  
  800045:	c3                   	ret    

00800046 <high_complexity_function>:

void high_complexity_function()
{
  800046:	55                   	push   %ebp
  800047:	89 e5                	mov    %esp,%ebp
  800049:	83 ec 38             	sub    $0x38,%esp
	uint32 end1 = RAND(0, 5000);
  80004c:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	50                   	push   %eax
  800053:	e8 e1 13 00 00       	call   801439 <sys_get_virtual_time>
  800058:	83 c4 0c             	add    $0xc,%esp
  80005b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80005e:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800063:	ba 00 00 00 00       	mov    $0x0,%edx
  800068:	f7 f1                	div    %ecx
  80006a:	89 55 e8             	mov    %edx,-0x18(%ebp)
	uint32 end2 = RAND(0, 5000);
  80006d:	8d 45 dc             	lea    -0x24(%ebp),%eax
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	50                   	push   %eax
  800074:	e8 c0 13 00 00       	call   801439 <sys_get_virtual_time>
  800079:	83 c4 0c             	add    $0xc,%esp
  80007c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80007f:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800084:	ba 00 00 00 00       	mov    $0x0,%edx
  800089:	f7 f1                	div    %ecx
  80008b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	int x = 10;
  80008e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
	for(int i = 0; i <= end1; i++)
  800095:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009c:	eb 1a                	jmp    8000b8 <high_complexity_function+0x72>
	{
		for(int i = 0; i <= end2; i++)
  80009e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8000a5:	eb 06                	jmp    8000ad <high_complexity_function+0x67>
		{
			{
				 x++;
  8000a7:	ff 45 f4             	incl   -0xc(%ebp)
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
	{
		for(int i = 0; i <= end2; i++)
  8000aa:	ff 45 ec             	incl   -0x14(%ebp)
  8000ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8000b3:	76 f2                	jbe    8000a7 <high_complexity_function+0x61>
void high_complexity_function()
{
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
  8000b5:	ff 45 f0             	incl   -0x10(%ebp)
  8000b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000bb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8000be:	76 de                	jbe    80009e <high_complexity_function+0x58>
			{
				 x++;
			}
		}
	}
}
  8000c0:	90                   	nop
  8000c1:	c9                   	leave  
  8000c2:	c3                   	ret    

008000c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c3:	55                   	push   %ebp
  8000c4:	89 e5                	mov    %esp,%ebp
  8000c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c9:	e8 f6 0f 00 00       	call   8010c4 <sys_getenvindex>
  8000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d4:	89 d0                	mov    %edx,%eax
  8000d6:	01 c0                	add    %eax,%eax
  8000d8:	01 d0                	add    %edx,%eax
  8000da:	c1 e0 02             	shl    $0x2,%eax
  8000dd:	01 d0                	add    %edx,%eax
  8000df:	c1 e0 06             	shl    $0x6,%eax
  8000e2:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000e7:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000ec:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f1:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000f7:	84 c0                	test   %al,%al
  8000f9:	74 0f                	je     80010a <libmain+0x47>
		binaryname = myEnv->prog_name;
  8000fb:	a1 04 20 80 00       	mov    0x802004,%eax
  800100:	05 f4 02 00 00       	add    $0x2f4,%eax
  800105:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80010a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80010e:	7e 0a                	jle    80011a <libmain+0x57>
		binaryname = argv[0];
  800110:	8b 45 0c             	mov    0xc(%ebp),%eax
  800113:	8b 00                	mov    (%eax),%eax
  800115:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80011a:	83 ec 08             	sub    $0x8,%esp
  80011d:	ff 75 0c             	pushl  0xc(%ebp)
  800120:	ff 75 08             	pushl  0x8(%ebp)
  800123:	e8 10 ff ff ff       	call   800038 <_main>
  800128:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80012b:	e8 2f 11 00 00       	call   80125f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800130:	83 ec 0c             	sub    $0xc,%esp
  800133:	68 d8 18 80 00       	push   $0x8018d8
  800138:	e8 5c 01 00 00       	call   800299 <cprintf>
  80013d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800140:	a1 04 20 80 00       	mov    0x802004,%eax
  800145:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80014b:	a1 04 20 80 00       	mov    0x802004,%eax
  800150:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800156:	83 ec 04             	sub    $0x4,%esp
  800159:	52                   	push   %edx
  80015a:	50                   	push   %eax
  80015b:	68 00 19 80 00       	push   $0x801900
  800160:	e8 34 01 00 00       	call   800299 <cprintf>
  800165:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800168:	a1 04 20 80 00       	mov    0x802004,%eax
  80016d:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800173:	83 ec 08             	sub    $0x8,%esp
  800176:	50                   	push   %eax
  800177:	68 25 19 80 00       	push   $0x801925
  80017c:	e8 18 01 00 00       	call   800299 <cprintf>
  800181:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800184:	83 ec 0c             	sub    $0xc,%esp
  800187:	68 d8 18 80 00       	push   $0x8018d8
  80018c:	e8 08 01 00 00       	call   800299 <cprintf>
  800191:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800194:	e8 e0 10 00 00       	call   801279 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800199:	e8 19 00 00 00       	call   8001b7 <exit>
}
  80019e:	90                   	nop
  80019f:	c9                   	leave  
  8001a0:	c3                   	ret    

008001a1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001a1:	55                   	push   %ebp
  8001a2:	89 e5                	mov    %esp,%ebp
  8001a4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	6a 00                	push   $0x0
  8001ac:	e8 df 0e 00 00       	call   801090 <sys_env_destroy>
  8001b1:	83 c4 10             	add    $0x10,%esp
}
  8001b4:	90                   	nop
  8001b5:	c9                   	leave  
  8001b6:	c3                   	ret    

008001b7 <exit>:

void
exit(void)
{
  8001b7:	55                   	push   %ebp
  8001b8:	89 e5                	mov    %esp,%ebp
  8001ba:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001bd:	e8 34 0f 00 00       	call   8010f6 <sys_env_exit>
}
  8001c2:	90                   	nop
  8001c3:	c9                   	leave  
  8001c4:	c3                   	ret    

008001c5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001c5:	55                   	push   %ebp
  8001c6:	89 e5                	mov    %esp,%ebp
  8001c8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ce:	8b 00                	mov    (%eax),%eax
  8001d0:	8d 48 01             	lea    0x1(%eax),%ecx
  8001d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d6:	89 0a                	mov    %ecx,(%edx)
  8001d8:	8b 55 08             	mov    0x8(%ebp),%edx
  8001db:	88 d1                	mov    %dl,%cl
  8001dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e7:	8b 00                	mov    (%eax),%eax
  8001e9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001ee:	75 2c                	jne    80021c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001f0:	a0 08 20 80 00       	mov    0x802008,%al
  8001f5:	0f b6 c0             	movzbl %al,%eax
  8001f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fb:	8b 12                	mov    (%edx),%edx
  8001fd:	89 d1                	mov    %edx,%ecx
  8001ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800202:	83 c2 08             	add    $0x8,%edx
  800205:	83 ec 04             	sub    $0x4,%esp
  800208:	50                   	push   %eax
  800209:	51                   	push   %ecx
  80020a:	52                   	push   %edx
  80020b:	e8 3e 0e 00 00       	call   80104e <sys_cputs>
  800210:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800213:	8b 45 0c             	mov    0xc(%ebp),%eax
  800216:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80021c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021f:	8b 40 04             	mov    0x4(%eax),%eax
  800222:	8d 50 01             	lea    0x1(%eax),%edx
  800225:	8b 45 0c             	mov    0xc(%ebp),%eax
  800228:	89 50 04             	mov    %edx,0x4(%eax)
}
  80022b:	90                   	nop
  80022c:	c9                   	leave  
  80022d:	c3                   	ret    

0080022e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80022e:	55                   	push   %ebp
  80022f:	89 e5                	mov    %esp,%ebp
  800231:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800237:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80023e:	00 00 00 
	b.cnt = 0;
  800241:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800248:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80024b:	ff 75 0c             	pushl  0xc(%ebp)
  80024e:	ff 75 08             	pushl  0x8(%ebp)
  800251:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800257:	50                   	push   %eax
  800258:	68 c5 01 80 00       	push   $0x8001c5
  80025d:	e8 11 02 00 00       	call   800473 <vprintfmt>
  800262:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800265:	a0 08 20 80 00       	mov    0x802008,%al
  80026a:	0f b6 c0             	movzbl %al,%eax
  80026d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800273:	83 ec 04             	sub    $0x4,%esp
  800276:	50                   	push   %eax
  800277:	52                   	push   %edx
  800278:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80027e:	83 c0 08             	add    $0x8,%eax
  800281:	50                   	push   %eax
  800282:	e8 c7 0d 00 00       	call   80104e <sys_cputs>
  800287:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80028a:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800291:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800297:	c9                   	leave  
  800298:	c3                   	ret    

00800299 <cprintf>:

int cprintf(const char *fmt, ...) {
  800299:	55                   	push   %ebp
  80029a:	89 e5                	mov    %esp,%ebp
  80029c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80029f:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002a6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8002af:	83 ec 08             	sub    $0x8,%esp
  8002b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8002b5:	50                   	push   %eax
  8002b6:	e8 73 ff ff ff       	call   80022e <vcprintf>
  8002bb:	83 c4 10             	add    $0x10,%esp
  8002be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002c4:	c9                   	leave  
  8002c5:	c3                   	ret    

008002c6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002c6:	55                   	push   %ebp
  8002c7:	89 e5                	mov    %esp,%ebp
  8002c9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002cc:	e8 8e 0f 00 00       	call   80125f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002d1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002da:	83 ec 08             	sub    $0x8,%esp
  8002dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e0:	50                   	push   %eax
  8002e1:	e8 48 ff ff ff       	call   80022e <vcprintf>
  8002e6:	83 c4 10             	add    $0x10,%esp
  8002e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002ec:	e8 88 0f 00 00       	call   801279 <sys_enable_interrupt>
	return cnt;
  8002f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002f4:	c9                   	leave  
  8002f5:	c3                   	ret    

008002f6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002f6:	55                   	push   %ebp
  8002f7:	89 e5                	mov    %esp,%ebp
  8002f9:	53                   	push   %ebx
  8002fa:	83 ec 14             	sub    $0x14,%esp
  8002fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800300:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800303:	8b 45 14             	mov    0x14(%ebp),%eax
  800306:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800309:	8b 45 18             	mov    0x18(%ebp),%eax
  80030c:	ba 00 00 00 00       	mov    $0x0,%edx
  800311:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800314:	77 55                	ja     80036b <printnum+0x75>
  800316:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800319:	72 05                	jb     800320 <printnum+0x2a>
  80031b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031e:	77 4b                	ja     80036b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800320:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800323:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800326:	8b 45 18             	mov    0x18(%ebp),%eax
  800329:	ba 00 00 00 00       	mov    $0x0,%edx
  80032e:	52                   	push   %edx
  80032f:	50                   	push   %eax
  800330:	ff 75 f4             	pushl  -0xc(%ebp)
  800333:	ff 75 f0             	pushl  -0x10(%ebp)
  800336:	e8 05 13 00 00       	call   801640 <__udivdi3>
  80033b:	83 c4 10             	add    $0x10,%esp
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	ff 75 20             	pushl  0x20(%ebp)
  800344:	53                   	push   %ebx
  800345:	ff 75 18             	pushl  0x18(%ebp)
  800348:	52                   	push   %edx
  800349:	50                   	push   %eax
  80034a:	ff 75 0c             	pushl  0xc(%ebp)
  80034d:	ff 75 08             	pushl  0x8(%ebp)
  800350:	e8 a1 ff ff ff       	call   8002f6 <printnum>
  800355:	83 c4 20             	add    $0x20,%esp
  800358:	eb 1a                	jmp    800374 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80035a:	83 ec 08             	sub    $0x8,%esp
  80035d:	ff 75 0c             	pushl  0xc(%ebp)
  800360:	ff 75 20             	pushl  0x20(%ebp)
  800363:	8b 45 08             	mov    0x8(%ebp),%eax
  800366:	ff d0                	call   *%eax
  800368:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80036b:	ff 4d 1c             	decl   0x1c(%ebp)
  80036e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800372:	7f e6                	jg     80035a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800374:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800377:	bb 00 00 00 00       	mov    $0x0,%ebx
  80037c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800382:	53                   	push   %ebx
  800383:	51                   	push   %ecx
  800384:	52                   	push   %edx
  800385:	50                   	push   %eax
  800386:	e8 c5 13 00 00       	call   801750 <__umoddi3>
  80038b:	83 c4 10             	add    $0x10,%esp
  80038e:	05 54 1b 80 00       	add    $0x801b54,%eax
  800393:	8a 00                	mov    (%eax),%al
  800395:	0f be c0             	movsbl %al,%eax
  800398:	83 ec 08             	sub    $0x8,%esp
  80039b:	ff 75 0c             	pushl  0xc(%ebp)
  80039e:	50                   	push   %eax
  80039f:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a2:	ff d0                	call   *%eax
  8003a4:	83 c4 10             	add    $0x10,%esp
}
  8003a7:	90                   	nop
  8003a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003ab:	c9                   	leave  
  8003ac:	c3                   	ret    

008003ad <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003ad:	55                   	push   %ebp
  8003ae:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003b0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003b4:	7e 1c                	jle    8003d2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b9:	8b 00                	mov    (%eax),%eax
  8003bb:	8d 50 08             	lea    0x8(%eax),%edx
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	89 10                	mov    %edx,(%eax)
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	83 e8 08             	sub    $0x8,%eax
  8003cb:	8b 50 04             	mov    0x4(%eax),%edx
  8003ce:	8b 00                	mov    (%eax),%eax
  8003d0:	eb 40                	jmp    800412 <getuint+0x65>
	else if (lflag)
  8003d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003d6:	74 1e                	je     8003f6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	8b 00                	mov    (%eax),%eax
  8003dd:	8d 50 04             	lea    0x4(%eax),%edx
  8003e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e3:	89 10                	mov    %edx,(%eax)
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	8b 00                	mov    (%eax),%eax
  8003ea:	83 e8 04             	sub    $0x4,%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	ba 00 00 00 00       	mov    $0x0,%edx
  8003f4:	eb 1c                	jmp    800412 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  800412:	5d                   	pop    %ebp
  800413:	c3                   	ret    

00800414 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800414:	55                   	push   %ebp
  800415:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800417:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80041b:	7e 1c                	jle    800439 <getint+0x25>
		return va_arg(*ap, long long);
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	8d 50 08             	lea    0x8(%eax),%edx
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	89 10                	mov    %edx,(%eax)
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	83 e8 08             	sub    $0x8,%eax
  800432:	8b 50 04             	mov    0x4(%eax),%edx
  800435:	8b 00                	mov    (%eax),%eax
  800437:	eb 38                	jmp    800471 <getint+0x5d>
	else if (lflag)
  800439:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80043d:	74 1a                	je     800459 <getint+0x45>
		return va_arg(*ap, long);
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
  800457:	eb 18                	jmp    800471 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	8d 50 04             	lea    0x4(%eax),%edx
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	89 10                	mov    %edx,(%eax)
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	83 e8 04             	sub    $0x4,%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	99                   	cltd   
}
  800471:	5d                   	pop    %ebp
  800472:	c3                   	ret    

00800473 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800473:	55                   	push   %ebp
  800474:	89 e5                	mov    %esp,%ebp
  800476:	56                   	push   %esi
  800477:	53                   	push   %ebx
  800478:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80047b:	eb 17                	jmp    800494 <vprintfmt+0x21>
			if (ch == '\0')
  80047d:	85 db                	test   %ebx,%ebx
  80047f:	0f 84 af 03 00 00    	je     800834 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800485:	83 ec 08             	sub    $0x8,%esp
  800488:	ff 75 0c             	pushl  0xc(%ebp)
  80048b:	53                   	push   %ebx
  80048c:	8b 45 08             	mov    0x8(%ebp),%eax
  80048f:	ff d0                	call   *%eax
  800491:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800494:	8b 45 10             	mov    0x10(%ebp),%eax
  800497:	8d 50 01             	lea    0x1(%eax),%edx
  80049a:	89 55 10             	mov    %edx,0x10(%ebp)
  80049d:	8a 00                	mov    (%eax),%al
  80049f:	0f b6 d8             	movzbl %al,%ebx
  8004a2:	83 fb 25             	cmp    $0x25,%ebx
  8004a5:	75 d6                	jne    80047d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004a7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004ab:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004b2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004b9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004c0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ca:	8d 50 01             	lea    0x1(%eax),%edx
  8004cd:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d0:	8a 00                	mov    (%eax),%al
  8004d2:	0f b6 d8             	movzbl %al,%ebx
  8004d5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004d8:	83 f8 55             	cmp    $0x55,%eax
  8004db:	0f 87 2b 03 00 00    	ja     80080c <vprintfmt+0x399>
  8004e1:	8b 04 85 78 1b 80 00 	mov    0x801b78(,%eax,4),%eax
  8004e8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004ea:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004ee:	eb d7                	jmp    8004c7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004f0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004f4:	eb d1                	jmp    8004c7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004f6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004fd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800500:	89 d0                	mov    %edx,%eax
  800502:	c1 e0 02             	shl    $0x2,%eax
  800505:	01 d0                	add    %edx,%eax
  800507:	01 c0                	add    %eax,%eax
  800509:	01 d8                	add    %ebx,%eax
  80050b:	83 e8 30             	sub    $0x30,%eax
  80050e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	8a 00                	mov    (%eax),%al
  800516:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800519:	83 fb 2f             	cmp    $0x2f,%ebx
  80051c:	7e 3e                	jle    80055c <vprintfmt+0xe9>
  80051e:	83 fb 39             	cmp    $0x39,%ebx
  800521:	7f 39                	jg     80055c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800523:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800526:	eb d5                	jmp    8004fd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800528:	8b 45 14             	mov    0x14(%ebp),%eax
  80052b:	83 c0 04             	add    $0x4,%eax
  80052e:	89 45 14             	mov    %eax,0x14(%ebp)
  800531:	8b 45 14             	mov    0x14(%ebp),%eax
  800534:	83 e8 04             	sub    $0x4,%eax
  800537:	8b 00                	mov    (%eax),%eax
  800539:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80053c:	eb 1f                	jmp    80055d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80053e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800542:	79 83                	jns    8004c7 <vprintfmt+0x54>
				width = 0;
  800544:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80054b:	e9 77 ff ff ff       	jmp    8004c7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800550:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800557:	e9 6b ff ff ff       	jmp    8004c7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80055c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80055d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800561:	0f 89 60 ff ff ff    	jns    8004c7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800567:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80056a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80056d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800574:	e9 4e ff ff ff       	jmp    8004c7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800579:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80057c:	e9 46 ff ff ff       	jmp    8004c7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800581:	8b 45 14             	mov    0x14(%ebp),%eax
  800584:	83 c0 04             	add    $0x4,%eax
  800587:	89 45 14             	mov    %eax,0x14(%ebp)
  80058a:	8b 45 14             	mov    0x14(%ebp),%eax
  80058d:	83 e8 04             	sub    $0x4,%eax
  800590:	8b 00                	mov    (%eax),%eax
  800592:	83 ec 08             	sub    $0x8,%esp
  800595:	ff 75 0c             	pushl  0xc(%ebp)
  800598:	50                   	push   %eax
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	ff d0                	call   *%eax
  80059e:	83 c4 10             	add    $0x10,%esp
			break;
  8005a1:	e9 89 02 00 00       	jmp    80082f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a9:	83 c0 04             	add    $0x4,%eax
  8005ac:	89 45 14             	mov    %eax,0x14(%ebp)
  8005af:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b2:	83 e8 04             	sub    $0x4,%eax
  8005b5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005b7:	85 db                	test   %ebx,%ebx
  8005b9:	79 02                	jns    8005bd <vprintfmt+0x14a>
				err = -err;
  8005bb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005bd:	83 fb 64             	cmp    $0x64,%ebx
  8005c0:	7f 0b                	jg     8005cd <vprintfmt+0x15a>
  8005c2:	8b 34 9d c0 19 80 00 	mov    0x8019c0(,%ebx,4),%esi
  8005c9:	85 f6                	test   %esi,%esi
  8005cb:	75 19                	jne    8005e6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005cd:	53                   	push   %ebx
  8005ce:	68 65 1b 80 00       	push   $0x801b65
  8005d3:	ff 75 0c             	pushl  0xc(%ebp)
  8005d6:	ff 75 08             	pushl  0x8(%ebp)
  8005d9:	e8 5e 02 00 00       	call   80083c <printfmt>
  8005de:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005e1:	e9 49 02 00 00       	jmp    80082f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005e6:	56                   	push   %esi
  8005e7:	68 6e 1b 80 00       	push   $0x801b6e
  8005ec:	ff 75 0c             	pushl  0xc(%ebp)
  8005ef:	ff 75 08             	pushl  0x8(%ebp)
  8005f2:	e8 45 02 00 00       	call   80083c <printfmt>
  8005f7:	83 c4 10             	add    $0x10,%esp
			break;
  8005fa:	e9 30 02 00 00       	jmp    80082f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005ff:	8b 45 14             	mov    0x14(%ebp),%eax
  800602:	83 c0 04             	add    $0x4,%eax
  800605:	89 45 14             	mov    %eax,0x14(%ebp)
  800608:	8b 45 14             	mov    0x14(%ebp),%eax
  80060b:	83 e8 04             	sub    $0x4,%eax
  80060e:	8b 30                	mov    (%eax),%esi
  800610:	85 f6                	test   %esi,%esi
  800612:	75 05                	jne    800619 <vprintfmt+0x1a6>
				p = "(null)";
  800614:	be 71 1b 80 00       	mov    $0x801b71,%esi
			if (width > 0 && padc != '-')
  800619:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80061d:	7e 6d                	jle    80068c <vprintfmt+0x219>
  80061f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800623:	74 67                	je     80068c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800625:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800628:	83 ec 08             	sub    $0x8,%esp
  80062b:	50                   	push   %eax
  80062c:	56                   	push   %esi
  80062d:	e8 0c 03 00 00       	call   80093e <strnlen>
  800632:	83 c4 10             	add    $0x10,%esp
  800635:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800638:	eb 16                	jmp    800650 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80063a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80063e:	83 ec 08             	sub    $0x8,%esp
  800641:	ff 75 0c             	pushl  0xc(%ebp)
  800644:	50                   	push   %eax
  800645:	8b 45 08             	mov    0x8(%ebp),%eax
  800648:	ff d0                	call   *%eax
  80064a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80064d:	ff 4d e4             	decl   -0x1c(%ebp)
  800650:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800654:	7f e4                	jg     80063a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800656:	eb 34                	jmp    80068c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800658:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80065c:	74 1c                	je     80067a <vprintfmt+0x207>
  80065e:	83 fb 1f             	cmp    $0x1f,%ebx
  800661:	7e 05                	jle    800668 <vprintfmt+0x1f5>
  800663:	83 fb 7e             	cmp    $0x7e,%ebx
  800666:	7e 12                	jle    80067a <vprintfmt+0x207>
					putch('?', putdat);
  800668:	83 ec 08             	sub    $0x8,%esp
  80066b:	ff 75 0c             	pushl  0xc(%ebp)
  80066e:	6a 3f                	push   $0x3f
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	ff d0                	call   *%eax
  800675:	83 c4 10             	add    $0x10,%esp
  800678:	eb 0f                	jmp    800689 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80067a:	83 ec 08             	sub    $0x8,%esp
  80067d:	ff 75 0c             	pushl  0xc(%ebp)
  800680:	53                   	push   %ebx
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	ff d0                	call   *%eax
  800686:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800689:	ff 4d e4             	decl   -0x1c(%ebp)
  80068c:	89 f0                	mov    %esi,%eax
  80068e:	8d 70 01             	lea    0x1(%eax),%esi
  800691:	8a 00                	mov    (%eax),%al
  800693:	0f be d8             	movsbl %al,%ebx
  800696:	85 db                	test   %ebx,%ebx
  800698:	74 24                	je     8006be <vprintfmt+0x24b>
  80069a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80069e:	78 b8                	js     800658 <vprintfmt+0x1e5>
  8006a0:	ff 4d e0             	decl   -0x20(%ebp)
  8006a3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006a7:	79 af                	jns    800658 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a9:	eb 13                	jmp    8006be <vprintfmt+0x24b>
				putch(' ', putdat);
  8006ab:	83 ec 08             	sub    $0x8,%esp
  8006ae:	ff 75 0c             	pushl  0xc(%ebp)
  8006b1:	6a 20                	push   $0x20
  8006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b6:	ff d0                	call   *%eax
  8006b8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006bb:	ff 4d e4             	decl   -0x1c(%ebp)
  8006be:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c2:	7f e7                	jg     8006ab <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006c4:	e9 66 01 00 00       	jmp    80082f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006c9:	83 ec 08             	sub    $0x8,%esp
  8006cc:	ff 75 e8             	pushl  -0x18(%ebp)
  8006cf:	8d 45 14             	lea    0x14(%ebp),%eax
  8006d2:	50                   	push   %eax
  8006d3:	e8 3c fd ff ff       	call   800414 <getint>
  8006d8:	83 c4 10             	add    $0x10,%esp
  8006db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006de:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e7:	85 d2                	test   %edx,%edx
  8006e9:	79 23                	jns    80070e <vprintfmt+0x29b>
				putch('-', putdat);
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	ff 75 0c             	pushl  0xc(%ebp)
  8006f1:	6a 2d                	push   $0x2d
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	ff d0                	call   *%eax
  8006f8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800701:	f7 d8                	neg    %eax
  800703:	83 d2 00             	adc    $0x0,%edx
  800706:	f7 da                	neg    %edx
  800708:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80070b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80070e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800715:	e9 bc 00 00 00       	jmp    8007d6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80071a:	83 ec 08             	sub    $0x8,%esp
  80071d:	ff 75 e8             	pushl  -0x18(%ebp)
  800720:	8d 45 14             	lea    0x14(%ebp),%eax
  800723:	50                   	push   %eax
  800724:	e8 84 fc ff ff       	call   8003ad <getuint>
  800729:	83 c4 10             	add    $0x10,%esp
  80072c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80072f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800732:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800739:	e9 98 00 00 00       	jmp    8007d6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80073e:	83 ec 08             	sub    $0x8,%esp
  800741:	ff 75 0c             	pushl  0xc(%ebp)
  800744:	6a 58                	push   $0x58
  800746:	8b 45 08             	mov    0x8(%ebp),%eax
  800749:	ff d0                	call   *%eax
  80074b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80074e:	83 ec 08             	sub    $0x8,%esp
  800751:	ff 75 0c             	pushl  0xc(%ebp)
  800754:	6a 58                	push   $0x58
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	ff d0                	call   *%eax
  80075b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80075e:	83 ec 08             	sub    $0x8,%esp
  800761:	ff 75 0c             	pushl  0xc(%ebp)
  800764:	6a 58                	push   $0x58
  800766:	8b 45 08             	mov    0x8(%ebp),%eax
  800769:	ff d0                	call   *%eax
  80076b:	83 c4 10             	add    $0x10,%esp
			break;
  80076e:	e9 bc 00 00 00       	jmp    80082f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800773:	83 ec 08             	sub    $0x8,%esp
  800776:	ff 75 0c             	pushl  0xc(%ebp)
  800779:	6a 30                	push   $0x30
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	ff d0                	call   *%eax
  800780:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800783:	83 ec 08             	sub    $0x8,%esp
  800786:	ff 75 0c             	pushl  0xc(%ebp)
  800789:	6a 78                	push   $0x78
  80078b:	8b 45 08             	mov    0x8(%ebp),%eax
  80078e:	ff d0                	call   *%eax
  800790:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800793:	8b 45 14             	mov    0x14(%ebp),%eax
  800796:	83 c0 04             	add    $0x4,%eax
  800799:	89 45 14             	mov    %eax,0x14(%ebp)
  80079c:	8b 45 14             	mov    0x14(%ebp),%eax
  80079f:	83 e8 04             	sub    $0x4,%eax
  8007a2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007ae:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007b5:	eb 1f                	jmp    8007d6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007b7:	83 ec 08             	sub    $0x8,%esp
  8007ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8007bd:	8d 45 14             	lea    0x14(%ebp),%eax
  8007c0:	50                   	push   %eax
  8007c1:	e8 e7 fb ff ff       	call   8003ad <getuint>
  8007c6:	83 c4 10             	add    $0x10,%esp
  8007c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007cc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007cf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007d6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007da:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007dd:	83 ec 04             	sub    $0x4,%esp
  8007e0:	52                   	push   %edx
  8007e1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007e4:	50                   	push   %eax
  8007e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e8:	ff 75 f0             	pushl  -0x10(%ebp)
  8007eb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ee:	ff 75 08             	pushl  0x8(%ebp)
  8007f1:	e8 00 fb ff ff       	call   8002f6 <printnum>
  8007f6:	83 c4 20             	add    $0x20,%esp
			break;
  8007f9:	eb 34                	jmp    80082f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007fb:	83 ec 08             	sub    $0x8,%esp
  8007fe:	ff 75 0c             	pushl  0xc(%ebp)
  800801:	53                   	push   %ebx
  800802:	8b 45 08             	mov    0x8(%ebp),%eax
  800805:	ff d0                	call   *%eax
  800807:	83 c4 10             	add    $0x10,%esp
			break;
  80080a:	eb 23                	jmp    80082f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80080c:	83 ec 08             	sub    $0x8,%esp
  80080f:	ff 75 0c             	pushl  0xc(%ebp)
  800812:	6a 25                	push   $0x25
  800814:	8b 45 08             	mov    0x8(%ebp),%eax
  800817:	ff d0                	call   *%eax
  800819:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80081c:	ff 4d 10             	decl   0x10(%ebp)
  80081f:	eb 03                	jmp    800824 <vprintfmt+0x3b1>
  800821:	ff 4d 10             	decl   0x10(%ebp)
  800824:	8b 45 10             	mov    0x10(%ebp),%eax
  800827:	48                   	dec    %eax
  800828:	8a 00                	mov    (%eax),%al
  80082a:	3c 25                	cmp    $0x25,%al
  80082c:	75 f3                	jne    800821 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80082e:	90                   	nop
		}
	}
  80082f:	e9 47 fc ff ff       	jmp    80047b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800834:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800835:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800838:	5b                   	pop    %ebx
  800839:	5e                   	pop    %esi
  80083a:	5d                   	pop    %ebp
  80083b:	c3                   	ret    

0080083c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80083c:	55                   	push   %ebp
  80083d:	89 e5                	mov    %esp,%ebp
  80083f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800842:	8d 45 10             	lea    0x10(%ebp),%eax
  800845:	83 c0 04             	add    $0x4,%eax
  800848:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80084b:	8b 45 10             	mov    0x10(%ebp),%eax
  80084e:	ff 75 f4             	pushl  -0xc(%ebp)
  800851:	50                   	push   %eax
  800852:	ff 75 0c             	pushl  0xc(%ebp)
  800855:	ff 75 08             	pushl  0x8(%ebp)
  800858:	e8 16 fc ff ff       	call   800473 <vprintfmt>
  80085d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800860:	90                   	nop
  800861:	c9                   	leave  
  800862:	c3                   	ret    

00800863 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800863:	55                   	push   %ebp
  800864:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800866:	8b 45 0c             	mov    0xc(%ebp),%eax
  800869:	8b 40 08             	mov    0x8(%eax),%eax
  80086c:	8d 50 01             	lea    0x1(%eax),%edx
  80086f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800872:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800875:	8b 45 0c             	mov    0xc(%ebp),%eax
  800878:	8b 10                	mov    (%eax),%edx
  80087a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087d:	8b 40 04             	mov    0x4(%eax),%eax
  800880:	39 c2                	cmp    %eax,%edx
  800882:	73 12                	jae    800896 <sprintputch+0x33>
		*b->buf++ = ch;
  800884:	8b 45 0c             	mov    0xc(%ebp),%eax
  800887:	8b 00                	mov    (%eax),%eax
  800889:	8d 48 01             	lea    0x1(%eax),%ecx
  80088c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80088f:	89 0a                	mov    %ecx,(%edx)
  800891:	8b 55 08             	mov    0x8(%ebp),%edx
  800894:	88 10                	mov    %dl,(%eax)
}
  800896:	90                   	nop
  800897:	5d                   	pop    %ebp
  800898:	c3                   	ret    

00800899 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800899:	55                   	push   %ebp
  80089a:	89 e5                	mov    %esp,%ebp
  80089c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80089f:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	01 d0                	add    %edx,%eax
  8008b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008be:	74 06                	je     8008c6 <vsnprintf+0x2d>
  8008c0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008c4:	7f 07                	jg     8008cd <vsnprintf+0x34>
		return -E_INVAL;
  8008c6:	b8 03 00 00 00       	mov    $0x3,%eax
  8008cb:	eb 20                	jmp    8008ed <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008cd:	ff 75 14             	pushl  0x14(%ebp)
  8008d0:	ff 75 10             	pushl  0x10(%ebp)
  8008d3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008d6:	50                   	push   %eax
  8008d7:	68 63 08 80 00       	push   $0x800863
  8008dc:	e8 92 fb ff ff       	call   800473 <vprintfmt>
  8008e1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008e7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008ed:	c9                   	leave  
  8008ee:	c3                   	ret    

008008ef <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008ef:	55                   	push   %ebp
  8008f0:	89 e5                	mov    %esp,%ebp
  8008f2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008f5:	8d 45 10             	lea    0x10(%ebp),%eax
  8008f8:	83 c0 04             	add    $0x4,%eax
  8008fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800901:	ff 75 f4             	pushl  -0xc(%ebp)
  800904:	50                   	push   %eax
  800905:	ff 75 0c             	pushl  0xc(%ebp)
  800908:	ff 75 08             	pushl  0x8(%ebp)
  80090b:	e8 89 ff ff ff       	call   800899 <vsnprintf>
  800910:	83 c4 10             	add    $0x10,%esp
  800913:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800916:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800919:	c9                   	leave  
  80091a:	c3                   	ret    

0080091b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80091b:	55                   	push   %ebp
  80091c:	89 e5                	mov    %esp,%ebp
  80091e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800921:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800928:	eb 06                	jmp    800930 <strlen+0x15>
		n++;
  80092a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80092d:	ff 45 08             	incl   0x8(%ebp)
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	8a 00                	mov    (%eax),%al
  800935:	84 c0                	test   %al,%al
  800937:	75 f1                	jne    80092a <strlen+0xf>
		n++;
	return n;
  800939:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80093c:	c9                   	leave  
  80093d:	c3                   	ret    

0080093e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80093e:	55                   	push   %ebp
  80093f:	89 e5                	mov    %esp,%ebp
  800941:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800944:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80094b:	eb 09                	jmp    800956 <strnlen+0x18>
		n++;
  80094d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800950:	ff 45 08             	incl   0x8(%ebp)
  800953:	ff 4d 0c             	decl   0xc(%ebp)
  800956:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80095a:	74 09                	je     800965 <strnlen+0x27>
  80095c:	8b 45 08             	mov    0x8(%ebp),%eax
  80095f:	8a 00                	mov    (%eax),%al
  800961:	84 c0                	test   %al,%al
  800963:	75 e8                	jne    80094d <strnlen+0xf>
		n++;
	return n;
  800965:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800968:	c9                   	leave  
  800969:	c3                   	ret    

0080096a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80096a:	55                   	push   %ebp
  80096b:	89 e5                	mov    %esp,%ebp
  80096d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800976:	90                   	nop
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	8d 50 01             	lea    0x1(%eax),%edx
  80097d:	89 55 08             	mov    %edx,0x8(%ebp)
  800980:	8b 55 0c             	mov    0xc(%ebp),%edx
  800983:	8d 4a 01             	lea    0x1(%edx),%ecx
  800986:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800989:	8a 12                	mov    (%edx),%dl
  80098b:	88 10                	mov    %dl,(%eax)
  80098d:	8a 00                	mov    (%eax),%al
  80098f:	84 c0                	test   %al,%al
  800991:	75 e4                	jne    800977 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800993:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800996:	c9                   	leave  
  800997:	c3                   	ret    

00800998 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800998:	55                   	push   %ebp
  800999:	89 e5                	mov    %esp,%ebp
  80099b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ab:	eb 1f                	jmp    8009cc <strncpy+0x34>
		*dst++ = *src;
  8009ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b0:	8d 50 01             	lea    0x1(%eax),%edx
  8009b3:	89 55 08             	mov    %edx,0x8(%ebp)
  8009b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b9:	8a 12                	mov    (%edx),%dl
  8009bb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c0:	8a 00                	mov    (%eax),%al
  8009c2:	84 c0                	test   %al,%al
  8009c4:	74 03                	je     8009c9 <strncpy+0x31>
			src++;
  8009c6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009c9:	ff 45 fc             	incl   -0x4(%ebp)
  8009cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009cf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009d2:	72 d9                	jb     8009ad <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009d7:	c9                   	leave  
  8009d8:	c3                   	ret    

008009d9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009d9:	55                   	push   %ebp
  8009da:	89 e5                	mov    %esp,%ebp
  8009dc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009e9:	74 30                	je     800a1b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009eb:	eb 16                	jmp    800a03 <strlcpy+0x2a>
			*dst++ = *src++;
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	8d 50 01             	lea    0x1(%eax),%edx
  8009f3:	89 55 08             	mov    %edx,0x8(%ebp)
  8009f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009fc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009ff:	8a 12                	mov    (%edx),%dl
  800a01:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a03:	ff 4d 10             	decl   0x10(%ebp)
  800a06:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a0a:	74 09                	je     800a15 <strlcpy+0x3c>
  800a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0f:	8a 00                	mov    (%eax),%al
  800a11:	84 c0                	test   %al,%al
  800a13:	75 d8                	jne    8009ed <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a1b:	8b 55 08             	mov    0x8(%ebp),%edx
  800a1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a21:	29 c2                	sub    %eax,%edx
  800a23:	89 d0                	mov    %edx,%eax
}
  800a25:	c9                   	leave  
  800a26:	c3                   	ret    

00800a27 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a27:	55                   	push   %ebp
  800a28:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a2a:	eb 06                	jmp    800a32 <strcmp+0xb>
		p++, q++;
  800a2c:	ff 45 08             	incl   0x8(%ebp)
  800a2f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a32:	8b 45 08             	mov    0x8(%ebp),%eax
  800a35:	8a 00                	mov    (%eax),%al
  800a37:	84 c0                	test   %al,%al
  800a39:	74 0e                	je     800a49 <strcmp+0x22>
  800a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3e:	8a 10                	mov    (%eax),%dl
  800a40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a43:	8a 00                	mov    (%eax),%al
  800a45:	38 c2                	cmp    %al,%dl
  800a47:	74 e3                	je     800a2c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	8a 00                	mov    (%eax),%al
  800a4e:	0f b6 d0             	movzbl %al,%edx
  800a51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a54:	8a 00                	mov    (%eax),%al
  800a56:	0f b6 c0             	movzbl %al,%eax
  800a59:	29 c2                	sub    %eax,%edx
  800a5b:	89 d0                	mov    %edx,%eax
}
  800a5d:	5d                   	pop    %ebp
  800a5e:	c3                   	ret    

00800a5f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a5f:	55                   	push   %ebp
  800a60:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a62:	eb 09                	jmp    800a6d <strncmp+0xe>
		n--, p++, q++;
  800a64:	ff 4d 10             	decl   0x10(%ebp)
  800a67:	ff 45 08             	incl   0x8(%ebp)
  800a6a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a71:	74 17                	je     800a8a <strncmp+0x2b>
  800a73:	8b 45 08             	mov    0x8(%ebp),%eax
  800a76:	8a 00                	mov    (%eax),%al
  800a78:	84 c0                	test   %al,%al
  800a7a:	74 0e                	je     800a8a <strncmp+0x2b>
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	8a 10                	mov    (%eax),%dl
  800a81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a84:	8a 00                	mov    (%eax),%al
  800a86:	38 c2                	cmp    %al,%dl
  800a88:	74 da                	je     800a64 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a8a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a8e:	75 07                	jne    800a97 <strncmp+0x38>
		return 0;
  800a90:	b8 00 00 00 00       	mov    $0x0,%eax
  800a95:	eb 14                	jmp    800aab <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a97:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9a:	8a 00                	mov    (%eax),%al
  800a9c:	0f b6 d0             	movzbl %al,%edx
  800a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa2:	8a 00                	mov    (%eax),%al
  800aa4:	0f b6 c0             	movzbl %al,%eax
  800aa7:	29 c2                	sub    %eax,%edx
  800aa9:	89 d0                	mov    %edx,%eax
}
  800aab:	5d                   	pop    %ebp
  800aac:	c3                   	ret    

00800aad <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aad:	55                   	push   %ebp
  800aae:	89 e5                	mov    %esp,%ebp
  800ab0:	83 ec 04             	sub    $0x4,%esp
  800ab3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ab9:	eb 12                	jmp    800acd <strchr+0x20>
		if (*s == c)
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	8a 00                	mov    (%eax),%al
  800ac0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ac3:	75 05                	jne    800aca <strchr+0x1d>
			return (char *) s;
  800ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac8:	eb 11                	jmp    800adb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800aca:	ff 45 08             	incl   0x8(%ebp)
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	8a 00                	mov    (%eax),%al
  800ad2:	84 c0                	test   %al,%al
  800ad4:	75 e5                	jne    800abb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ad6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800adb:	c9                   	leave  
  800adc:	c3                   	ret    

00800add <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800add:	55                   	push   %ebp
  800ade:	89 e5                	mov    %esp,%ebp
  800ae0:	83 ec 04             	sub    $0x4,%esp
  800ae3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ae9:	eb 0d                	jmp    800af8 <strfind+0x1b>
		if (*s == c)
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	8a 00                	mov    (%eax),%al
  800af0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800af3:	74 0e                	je     800b03 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800af5:	ff 45 08             	incl   0x8(%ebp)
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	8a 00                	mov    (%eax),%al
  800afd:	84 c0                	test   %al,%al
  800aff:	75 ea                	jne    800aeb <strfind+0xe>
  800b01:	eb 01                	jmp    800b04 <strfind+0x27>
		if (*s == c)
			break;
  800b03:	90                   	nop
	return (char *) s;
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b07:	c9                   	leave  
  800b08:	c3                   	ret    

00800b09 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b09:	55                   	push   %ebp
  800b0a:	89 e5                	mov    %esp,%ebp
  800b0c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b15:	8b 45 10             	mov    0x10(%ebp),%eax
  800b18:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b1b:	eb 0e                	jmp    800b2b <memset+0x22>
		*p++ = c;
  800b1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b20:	8d 50 01             	lea    0x1(%eax),%edx
  800b23:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b26:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b29:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b2b:	ff 4d f8             	decl   -0x8(%ebp)
  800b2e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b32:	79 e9                	jns    800b1d <memset+0x14>
		*p++ = c;

	return v;
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b37:	c9                   	leave  
  800b38:	c3                   	ret    

00800b39 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
  800b3c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b4b:	eb 16                	jmp    800b63 <memcpy+0x2a>
		*d++ = *s++;
  800b4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b50:	8d 50 01             	lea    0x1(%eax),%edx
  800b53:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b56:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b59:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b5c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b5f:	8a 12                	mov    (%edx),%dl
  800b61:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b63:	8b 45 10             	mov    0x10(%ebp),%eax
  800b66:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b69:	89 55 10             	mov    %edx,0x10(%ebp)
  800b6c:	85 c0                	test   %eax,%eax
  800b6e:	75 dd                	jne    800b4d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b73:	c9                   	leave  
  800b74:	c3                   	ret    

00800b75 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b75:	55                   	push   %ebp
  800b76:	89 e5                	mov    %esp,%ebp
  800b78:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b8a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b8d:	73 50                	jae    800bdf <memmove+0x6a>
  800b8f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b92:	8b 45 10             	mov    0x10(%ebp),%eax
  800b95:	01 d0                	add    %edx,%eax
  800b97:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b9a:	76 43                	jbe    800bdf <memmove+0x6a>
		s += n;
  800b9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ba8:	eb 10                	jmp    800bba <memmove+0x45>
			*--d = *--s;
  800baa:	ff 4d f8             	decl   -0x8(%ebp)
  800bad:	ff 4d fc             	decl   -0x4(%ebp)
  800bb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb3:	8a 10                	mov    (%eax),%dl
  800bb5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bba:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc0:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc3:	85 c0                	test   %eax,%eax
  800bc5:	75 e3                	jne    800baa <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bc7:	eb 23                	jmp    800bec <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bc9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bcc:	8d 50 01             	lea    0x1(%eax),%edx
  800bcf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bd2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bd5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bd8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bdb:	8a 12                	mov    (%edx),%dl
  800bdd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800be2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be5:	89 55 10             	mov    %edx,0x10(%ebp)
  800be8:	85 c0                	test   %eax,%eax
  800bea:	75 dd                	jne    800bc9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bef:	c9                   	leave  
  800bf0:	c3                   	ret    

00800bf1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bf1:	55                   	push   %ebp
  800bf2:	89 e5                	mov    %esp,%ebp
  800bf4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c00:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c03:	eb 2a                	jmp    800c2f <memcmp+0x3e>
		if (*s1 != *s2)
  800c05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c08:	8a 10                	mov    (%eax),%dl
  800c0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0d:	8a 00                	mov    (%eax),%al
  800c0f:	38 c2                	cmp    %al,%dl
  800c11:	74 16                	je     800c29 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	0f b6 d0             	movzbl %al,%edx
  800c1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	0f b6 c0             	movzbl %al,%eax
  800c23:	29 c2                	sub    %eax,%edx
  800c25:	89 d0                	mov    %edx,%eax
  800c27:	eb 18                	jmp    800c41 <memcmp+0x50>
		s1++, s2++;
  800c29:	ff 45 fc             	incl   -0x4(%ebp)
  800c2c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c32:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c35:	89 55 10             	mov    %edx,0x10(%ebp)
  800c38:	85 c0                	test   %eax,%eax
  800c3a:	75 c9                	jne    800c05 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c41:	c9                   	leave  
  800c42:	c3                   	ret    

00800c43 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c43:	55                   	push   %ebp
  800c44:	89 e5                	mov    %esp,%ebp
  800c46:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c49:	8b 55 08             	mov    0x8(%ebp),%edx
  800c4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4f:	01 d0                	add    %edx,%eax
  800c51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c54:	eb 15                	jmp    800c6b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	0f b6 d0             	movzbl %al,%edx
  800c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c61:	0f b6 c0             	movzbl %al,%eax
  800c64:	39 c2                	cmp    %eax,%edx
  800c66:	74 0d                	je     800c75 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c68:	ff 45 08             	incl   0x8(%ebp)
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c71:	72 e3                	jb     800c56 <memfind+0x13>
  800c73:	eb 01                	jmp    800c76 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c75:	90                   	nop
	return (void *) s;
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c79:	c9                   	leave  
  800c7a:	c3                   	ret    

00800c7b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c7b:	55                   	push   %ebp
  800c7c:	89 e5                	mov    %esp,%ebp
  800c7e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c81:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c88:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c8f:	eb 03                	jmp    800c94 <strtol+0x19>
		s++;
  800c91:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	3c 20                	cmp    $0x20,%al
  800c9b:	74 f4                	je     800c91 <strtol+0x16>
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	3c 09                	cmp    $0x9,%al
  800ca4:	74 eb                	je     800c91 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	3c 2b                	cmp    $0x2b,%al
  800cad:	75 05                	jne    800cb4 <strtol+0x39>
		s++;
  800caf:	ff 45 08             	incl   0x8(%ebp)
  800cb2:	eb 13                	jmp    800cc7 <strtol+0x4c>
	else if (*s == '-')
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	3c 2d                	cmp    $0x2d,%al
  800cbb:	75 0a                	jne    800cc7 <strtol+0x4c>
		s++, neg = 1;
  800cbd:	ff 45 08             	incl   0x8(%ebp)
  800cc0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cc7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ccb:	74 06                	je     800cd3 <strtol+0x58>
  800ccd:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cd1:	75 20                	jne    800cf3 <strtol+0x78>
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	8a 00                	mov    (%eax),%al
  800cd8:	3c 30                	cmp    $0x30,%al
  800cda:	75 17                	jne    800cf3 <strtol+0x78>
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	40                   	inc    %eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	3c 78                	cmp    $0x78,%al
  800ce4:	75 0d                	jne    800cf3 <strtol+0x78>
		s += 2, base = 16;
  800ce6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cea:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cf1:	eb 28                	jmp    800d1b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cf3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf7:	75 15                	jne    800d0e <strtol+0x93>
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	8a 00                	mov    (%eax),%al
  800cfe:	3c 30                	cmp    $0x30,%al
  800d00:	75 0c                	jne    800d0e <strtol+0x93>
		s++, base = 8;
  800d02:	ff 45 08             	incl   0x8(%ebp)
  800d05:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d0c:	eb 0d                	jmp    800d1b <strtol+0xa0>
	else if (base == 0)
  800d0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d12:	75 07                	jne    800d1b <strtol+0xa0>
		base = 10;
  800d14:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1e:	8a 00                	mov    (%eax),%al
  800d20:	3c 2f                	cmp    $0x2f,%al
  800d22:	7e 19                	jle    800d3d <strtol+0xc2>
  800d24:	8b 45 08             	mov    0x8(%ebp),%eax
  800d27:	8a 00                	mov    (%eax),%al
  800d29:	3c 39                	cmp    $0x39,%al
  800d2b:	7f 10                	jg     800d3d <strtol+0xc2>
			dig = *s - '0';
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	0f be c0             	movsbl %al,%eax
  800d35:	83 e8 30             	sub    $0x30,%eax
  800d38:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d3b:	eb 42                	jmp    800d7f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	8a 00                	mov    (%eax),%al
  800d42:	3c 60                	cmp    $0x60,%al
  800d44:	7e 19                	jle    800d5f <strtol+0xe4>
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	8a 00                	mov    (%eax),%al
  800d4b:	3c 7a                	cmp    $0x7a,%al
  800d4d:	7f 10                	jg     800d5f <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	0f be c0             	movsbl %al,%eax
  800d57:	83 e8 57             	sub    $0x57,%eax
  800d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d5d:	eb 20                	jmp    800d7f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	3c 40                	cmp    $0x40,%al
  800d66:	7e 39                	jle    800da1 <strtol+0x126>
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	8a 00                	mov    (%eax),%al
  800d6d:	3c 5a                	cmp    $0x5a,%al
  800d6f:	7f 30                	jg     800da1 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	8a 00                	mov    (%eax),%al
  800d76:	0f be c0             	movsbl %al,%eax
  800d79:	83 e8 37             	sub    $0x37,%eax
  800d7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d82:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d85:	7d 19                	jge    800da0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d87:	ff 45 08             	incl   0x8(%ebp)
  800d8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8d:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d91:	89 c2                	mov    %eax,%edx
  800d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d96:	01 d0                	add    %edx,%eax
  800d98:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d9b:	e9 7b ff ff ff       	jmp    800d1b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800da0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800da1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da5:	74 08                	je     800daf <strtol+0x134>
		*endptr = (char *) s;
  800da7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daa:	8b 55 08             	mov    0x8(%ebp),%edx
  800dad:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800daf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800db3:	74 07                	je     800dbc <strtol+0x141>
  800db5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db8:	f7 d8                	neg    %eax
  800dba:	eb 03                	jmp    800dbf <strtol+0x144>
  800dbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dbf:	c9                   	leave  
  800dc0:	c3                   	ret    

00800dc1 <ltostr>:

void
ltostr(long value, char *str)
{
  800dc1:	55                   	push   %ebp
  800dc2:	89 e5                	mov    %esp,%ebp
  800dc4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dc7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dd5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dd9:	79 13                	jns    800dee <ltostr+0x2d>
	{
		neg = 1;
  800ddb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800de2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800de8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800deb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800df6:	99                   	cltd   
  800df7:	f7 f9                	idiv   %ecx
  800df9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dff:	8d 50 01             	lea    0x1(%eax),%edx
  800e02:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e05:	89 c2                	mov    %eax,%edx
  800e07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0a:	01 d0                	add    %edx,%eax
  800e0c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e0f:	83 c2 30             	add    $0x30,%edx
  800e12:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e14:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e17:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e1c:	f7 e9                	imul   %ecx
  800e1e:	c1 fa 02             	sar    $0x2,%edx
  800e21:	89 c8                	mov    %ecx,%eax
  800e23:	c1 f8 1f             	sar    $0x1f,%eax
  800e26:	29 c2                	sub    %eax,%edx
  800e28:	89 d0                	mov    %edx,%eax
  800e2a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e2d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e30:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e35:	f7 e9                	imul   %ecx
  800e37:	c1 fa 02             	sar    $0x2,%edx
  800e3a:	89 c8                	mov    %ecx,%eax
  800e3c:	c1 f8 1f             	sar    $0x1f,%eax
  800e3f:	29 c2                	sub    %eax,%edx
  800e41:	89 d0                	mov    %edx,%eax
  800e43:	c1 e0 02             	shl    $0x2,%eax
  800e46:	01 d0                	add    %edx,%eax
  800e48:	01 c0                	add    %eax,%eax
  800e4a:	29 c1                	sub    %eax,%ecx
  800e4c:	89 ca                	mov    %ecx,%edx
  800e4e:	85 d2                	test   %edx,%edx
  800e50:	75 9c                	jne    800dee <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5c:	48                   	dec    %eax
  800e5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e60:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e64:	74 3d                	je     800ea3 <ltostr+0xe2>
		start = 1 ;
  800e66:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e6d:	eb 34                	jmp    800ea3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e75:	01 d0                	add    %edx,%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e82:	01 c2                	add    %eax,%edx
  800e84:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8a:	01 c8                	add    %ecx,%eax
  800e8c:	8a 00                	mov    (%eax),%al
  800e8e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e90:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e96:	01 c2                	add    %eax,%edx
  800e98:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e9b:	88 02                	mov    %al,(%edx)
		start++ ;
  800e9d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ea0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ea6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ea9:	7c c4                	jl     800e6f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800eab:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800eae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb1:	01 d0                	add    %edx,%eax
  800eb3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eb6:	90                   	nop
  800eb7:	c9                   	leave  
  800eb8:	c3                   	ret    

00800eb9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800eb9:	55                   	push   %ebp
  800eba:	89 e5                	mov    %esp,%ebp
  800ebc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ebf:	ff 75 08             	pushl  0x8(%ebp)
  800ec2:	e8 54 fa ff ff       	call   80091b <strlen>
  800ec7:	83 c4 04             	add    $0x4,%esp
  800eca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	e8 46 fa ff ff       	call   80091b <strlen>
  800ed5:	83 c4 04             	add    $0x4,%esp
  800ed8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800edb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ee2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee9:	eb 17                	jmp    800f02 <strcconcat+0x49>
		final[s] = str1[s] ;
  800eeb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eee:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef1:	01 c2                	add    %eax,%edx
  800ef3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	01 c8                	add    %ecx,%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eff:	ff 45 fc             	incl   -0x4(%ebp)
  800f02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f05:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f08:	7c e1                	jl     800eeb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f0a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f11:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f18:	eb 1f                	jmp    800f39 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1d:	8d 50 01             	lea    0x1(%eax),%edx
  800f20:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f23:	89 c2                	mov    %eax,%edx
  800f25:	8b 45 10             	mov    0x10(%ebp),%eax
  800f28:	01 c2                	add    %eax,%edx
  800f2a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f30:	01 c8                	add    %ecx,%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f36:	ff 45 f8             	incl   -0x8(%ebp)
  800f39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f3c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f3f:	7c d9                	jl     800f1a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f41:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f44:	8b 45 10             	mov    0x10(%ebp),%eax
  800f47:	01 d0                	add    %edx,%eax
  800f49:	c6 00 00             	movb   $0x0,(%eax)
}
  800f4c:	90                   	nop
  800f4d:	c9                   	leave  
  800f4e:	c3                   	ret    

00800f4f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f4f:	55                   	push   %ebp
  800f50:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f52:	8b 45 14             	mov    0x14(%ebp),%eax
  800f55:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f5b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5e:	8b 00                	mov    (%eax),%eax
  800f60:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f67:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6a:	01 d0                	add    %edx,%eax
  800f6c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f72:	eb 0c                	jmp    800f80 <strsplit+0x31>
			*string++ = 0;
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	8d 50 01             	lea    0x1(%eax),%edx
  800f7a:	89 55 08             	mov    %edx,0x8(%ebp)
  800f7d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	84 c0                	test   %al,%al
  800f87:	74 18                	je     800fa1 <strsplit+0x52>
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	0f be c0             	movsbl %al,%eax
  800f91:	50                   	push   %eax
  800f92:	ff 75 0c             	pushl  0xc(%ebp)
  800f95:	e8 13 fb ff ff       	call   800aad <strchr>
  800f9a:	83 c4 08             	add    $0x8,%esp
  800f9d:	85 c0                	test   %eax,%eax
  800f9f:	75 d3                	jne    800f74 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	84 c0                	test   %al,%al
  800fa8:	74 5a                	je     801004 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800faa:	8b 45 14             	mov    0x14(%ebp),%eax
  800fad:	8b 00                	mov    (%eax),%eax
  800faf:	83 f8 0f             	cmp    $0xf,%eax
  800fb2:	75 07                	jne    800fbb <strsplit+0x6c>
		{
			return 0;
  800fb4:	b8 00 00 00 00       	mov    $0x0,%eax
  800fb9:	eb 66                	jmp    801021 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbe:	8b 00                	mov    (%eax),%eax
  800fc0:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc3:	8b 55 14             	mov    0x14(%ebp),%edx
  800fc6:	89 0a                	mov    %ecx,(%edx)
  800fc8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd2:	01 c2                	add    %eax,%edx
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fd9:	eb 03                	jmp    800fde <strsplit+0x8f>
			string++;
  800fdb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	8a 00                	mov    (%eax),%al
  800fe3:	84 c0                	test   %al,%al
  800fe5:	74 8b                	je     800f72 <strsplit+0x23>
  800fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fea:	8a 00                	mov    (%eax),%al
  800fec:	0f be c0             	movsbl %al,%eax
  800fef:	50                   	push   %eax
  800ff0:	ff 75 0c             	pushl  0xc(%ebp)
  800ff3:	e8 b5 fa ff ff       	call   800aad <strchr>
  800ff8:	83 c4 08             	add    $0x8,%esp
  800ffb:	85 c0                	test   %eax,%eax
  800ffd:	74 dc                	je     800fdb <strsplit+0x8c>
			string++;
	}
  800fff:	e9 6e ff ff ff       	jmp    800f72 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801004:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801005:	8b 45 14             	mov    0x14(%ebp),%eax
  801008:	8b 00                	mov    (%eax),%eax
  80100a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801011:	8b 45 10             	mov    0x10(%ebp),%eax
  801014:	01 d0                	add    %edx,%eax
  801016:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80101c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801021:	c9                   	leave  
  801022:	c3                   	ret    

00801023 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801023:	55                   	push   %ebp
  801024:	89 e5                	mov    %esp,%ebp
  801026:	57                   	push   %edi
  801027:	56                   	push   %esi
  801028:	53                   	push   %ebx
  801029:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801032:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801035:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801038:	8b 7d 18             	mov    0x18(%ebp),%edi
  80103b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80103e:	cd 30                	int    $0x30
  801040:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801043:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801046:	83 c4 10             	add    $0x10,%esp
  801049:	5b                   	pop    %ebx
  80104a:	5e                   	pop    %esi
  80104b:	5f                   	pop    %edi
  80104c:	5d                   	pop    %ebp
  80104d:	c3                   	ret    

0080104e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80104e:	55                   	push   %ebp
  80104f:	89 e5                	mov    %esp,%ebp
  801051:	83 ec 04             	sub    $0x4,%esp
  801054:	8b 45 10             	mov    0x10(%ebp),%eax
  801057:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80105a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	6a 00                	push   $0x0
  801063:	6a 00                	push   $0x0
  801065:	52                   	push   %edx
  801066:	ff 75 0c             	pushl  0xc(%ebp)
  801069:	50                   	push   %eax
  80106a:	6a 00                	push   $0x0
  80106c:	e8 b2 ff ff ff       	call   801023 <syscall>
  801071:	83 c4 18             	add    $0x18,%esp
}
  801074:	90                   	nop
  801075:	c9                   	leave  
  801076:	c3                   	ret    

00801077 <sys_cgetc>:

int
sys_cgetc(void)
{
  801077:	55                   	push   %ebp
  801078:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80107a:	6a 00                	push   $0x0
  80107c:	6a 00                	push   $0x0
  80107e:	6a 00                	push   $0x0
  801080:	6a 00                	push   $0x0
  801082:	6a 00                	push   $0x0
  801084:	6a 01                	push   $0x1
  801086:	e8 98 ff ff ff       	call   801023 <syscall>
  80108b:	83 c4 18             	add    $0x18,%esp
}
  80108e:	c9                   	leave  
  80108f:	c3                   	ret    

00801090 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801090:	55                   	push   %ebp
  801091:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	6a 00                	push   $0x0
  801098:	6a 00                	push   $0x0
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	50                   	push   %eax
  80109f:	6a 05                	push   $0x5
  8010a1:	e8 7d ff ff ff       	call   801023 <syscall>
  8010a6:	83 c4 18             	add    $0x18,%esp
}
  8010a9:	c9                   	leave  
  8010aa:	c3                   	ret    

008010ab <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010ab:	55                   	push   %ebp
  8010ac:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010ae:	6a 00                	push   $0x0
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 02                	push   $0x2
  8010ba:	e8 64 ff ff ff       	call   801023 <syscall>
  8010bf:	83 c4 18             	add    $0x18,%esp
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010c7:	6a 00                	push   $0x0
  8010c9:	6a 00                	push   $0x0
  8010cb:	6a 00                	push   $0x0
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 00                	push   $0x0
  8010d1:	6a 03                	push   $0x3
  8010d3:	e8 4b ff ff ff       	call   801023 <syscall>
  8010d8:	83 c4 18             	add    $0x18,%esp
}
  8010db:	c9                   	leave  
  8010dc:	c3                   	ret    

008010dd <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010dd:	55                   	push   %ebp
  8010de:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010e0:	6a 00                	push   $0x0
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 04                	push   $0x4
  8010ec:	e8 32 ff ff ff       	call   801023 <syscall>
  8010f1:	83 c4 18             	add    $0x18,%esp
}
  8010f4:	c9                   	leave  
  8010f5:	c3                   	ret    

008010f6 <sys_env_exit>:


void sys_env_exit(void)
{
  8010f6:	55                   	push   %ebp
  8010f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010f9:	6a 00                	push   $0x0
  8010fb:	6a 00                	push   $0x0
  8010fd:	6a 00                	push   $0x0
  8010ff:	6a 00                	push   $0x0
  801101:	6a 00                	push   $0x0
  801103:	6a 06                	push   $0x6
  801105:	e8 19 ff ff ff       	call   801023 <syscall>
  80110a:	83 c4 18             	add    $0x18,%esp
}
  80110d:	90                   	nop
  80110e:	c9                   	leave  
  80110f:	c3                   	ret    

00801110 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801110:	55                   	push   %ebp
  801111:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801113:	8b 55 0c             	mov    0xc(%ebp),%edx
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	6a 00                	push   $0x0
  80111b:	6a 00                	push   $0x0
  80111d:	6a 00                	push   $0x0
  80111f:	52                   	push   %edx
  801120:	50                   	push   %eax
  801121:	6a 07                	push   $0x7
  801123:	e8 fb fe ff ff       	call   801023 <syscall>
  801128:	83 c4 18             	add    $0x18,%esp
}
  80112b:	c9                   	leave  
  80112c:	c3                   	ret    

0080112d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
  801130:	56                   	push   %esi
  801131:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801132:	8b 75 18             	mov    0x18(%ebp),%esi
  801135:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801138:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80113b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	56                   	push   %esi
  801142:	53                   	push   %ebx
  801143:	51                   	push   %ecx
  801144:	52                   	push   %edx
  801145:	50                   	push   %eax
  801146:	6a 08                	push   $0x8
  801148:	e8 d6 fe ff ff       	call   801023 <syscall>
  80114d:	83 c4 18             	add    $0x18,%esp
}
  801150:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801153:	5b                   	pop    %ebx
  801154:	5e                   	pop    %esi
  801155:	5d                   	pop    %ebp
  801156:	c3                   	ret    

00801157 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801157:	55                   	push   %ebp
  801158:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80115a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	6a 00                	push   $0x0
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	52                   	push   %edx
  801167:	50                   	push   %eax
  801168:	6a 09                	push   $0x9
  80116a:	e8 b4 fe ff ff       	call   801023 <syscall>
  80116f:	83 c4 18             	add    $0x18,%esp
}
  801172:	c9                   	leave  
  801173:	c3                   	ret    

00801174 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801174:	55                   	push   %ebp
  801175:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801177:	6a 00                	push   $0x0
  801179:	6a 00                	push   $0x0
  80117b:	6a 00                	push   $0x0
  80117d:	ff 75 0c             	pushl  0xc(%ebp)
  801180:	ff 75 08             	pushl  0x8(%ebp)
  801183:	6a 0a                	push   $0xa
  801185:	e8 99 fe ff ff       	call   801023 <syscall>
  80118a:	83 c4 18             	add    $0x18,%esp
}
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801192:	6a 00                	push   $0x0
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 0b                	push   $0xb
  80119e:	e8 80 fe ff ff       	call   801023 <syscall>
  8011a3:	83 c4 18             	add    $0x18,%esp
}
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011ab:	6a 00                	push   $0x0
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 0c                	push   $0xc
  8011b7:	e8 67 fe ff ff       	call   801023 <syscall>
  8011bc:	83 c4 18             	add    $0x18,%esp
}
  8011bf:	c9                   	leave  
  8011c0:	c3                   	ret    

008011c1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011c1:	55                   	push   %ebp
  8011c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011c4:	6a 00                	push   $0x0
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 0d                	push   $0xd
  8011d0:	e8 4e fe ff ff       	call   801023 <syscall>
  8011d5:	83 c4 18             	add    $0x18,%esp
}
  8011d8:	c9                   	leave  
  8011d9:	c3                   	ret    

008011da <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011da:	55                   	push   %ebp
  8011db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011dd:	6a 00                	push   $0x0
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	ff 75 0c             	pushl  0xc(%ebp)
  8011e6:	ff 75 08             	pushl  0x8(%ebp)
  8011e9:	6a 11                	push   $0x11
  8011eb:	e8 33 fe ff ff       	call   801023 <syscall>
  8011f0:	83 c4 18             	add    $0x18,%esp
	return;
  8011f3:	90                   	nop
}
  8011f4:	c9                   	leave  
  8011f5:	c3                   	ret    

008011f6 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011f6:	55                   	push   %ebp
  8011f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 00                	push   $0x0
  8011ff:	ff 75 0c             	pushl  0xc(%ebp)
  801202:	ff 75 08             	pushl  0x8(%ebp)
  801205:	6a 12                	push   $0x12
  801207:	e8 17 fe ff ff       	call   801023 <syscall>
  80120c:	83 c4 18             	add    $0x18,%esp
	return ;
  80120f:	90                   	nop
}
  801210:	c9                   	leave  
  801211:	c3                   	ret    

00801212 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 0e                	push   $0xe
  801221:	e8 fd fd ff ff       	call   801023 <syscall>
  801226:	83 c4 18             	add    $0x18,%esp
}
  801229:	c9                   	leave  
  80122a:	c3                   	ret    

0080122b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80122b:	55                   	push   %ebp
  80122c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80122e:	6a 00                	push   $0x0
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	ff 75 08             	pushl  0x8(%ebp)
  801239:	6a 0f                	push   $0xf
  80123b:	e8 e3 fd ff ff       	call   801023 <syscall>
  801240:	83 c4 18             	add    $0x18,%esp
}
  801243:	c9                   	leave  
  801244:	c3                   	ret    

00801245 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801245:	55                   	push   %ebp
  801246:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 10                	push   $0x10
  801254:	e8 ca fd ff ff       	call   801023 <syscall>
  801259:	83 c4 18             	add    $0x18,%esp
}
  80125c:	90                   	nop
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801262:	6a 00                	push   $0x0
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 14                	push   $0x14
  80126e:	e8 b0 fd ff ff       	call   801023 <syscall>
  801273:	83 c4 18             	add    $0x18,%esp
}
  801276:	90                   	nop
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 15                	push   $0x15
  801288:	e8 96 fd ff ff       	call   801023 <syscall>
  80128d:	83 c4 18             	add    $0x18,%esp
}
  801290:	90                   	nop
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <sys_cputc>:


void
sys_cputc(const char c)
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
  801296:	83 ec 04             	sub    $0x4,%esp
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80129f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	50                   	push   %eax
  8012ac:	6a 16                	push   $0x16
  8012ae:	e8 70 fd ff ff       	call   801023 <syscall>
  8012b3:	83 c4 18             	add    $0x18,%esp
}
  8012b6:	90                   	nop
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 17                	push   $0x17
  8012c8:	e8 56 fd ff ff       	call   801023 <syscall>
  8012cd:	83 c4 18             	add    $0x18,%esp
}
  8012d0:	90                   	nop
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	ff 75 0c             	pushl  0xc(%ebp)
  8012e2:	50                   	push   %eax
  8012e3:	6a 18                	push   $0x18
  8012e5:	e8 39 fd ff ff       	call   801023 <syscall>
  8012ea:	83 c4 18             	add    $0x18,%esp
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	52                   	push   %edx
  8012ff:	50                   	push   %eax
  801300:	6a 1b                	push   $0x1b
  801302:	e8 1c fd ff ff       	call   801023 <syscall>
  801307:	83 c4 18             	add    $0x18,%esp
}
  80130a:	c9                   	leave  
  80130b:	c3                   	ret    

0080130c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80130c:	55                   	push   %ebp
  80130d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80130f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	52                   	push   %edx
  80131c:	50                   	push   %eax
  80131d:	6a 19                	push   $0x19
  80131f:	e8 ff fc ff ff       	call   801023 <syscall>
  801324:	83 c4 18             	add    $0x18,%esp
}
  801327:	90                   	nop
  801328:	c9                   	leave  
  801329:	c3                   	ret    

0080132a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80132a:	55                   	push   %ebp
  80132b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80132d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	52                   	push   %edx
  80133a:	50                   	push   %eax
  80133b:	6a 1a                	push   $0x1a
  80133d:	e8 e1 fc ff ff       	call   801023 <syscall>
  801342:	83 c4 18             	add    $0x18,%esp
}
  801345:	90                   	nop
  801346:	c9                   	leave  
  801347:	c3                   	ret    

00801348 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801348:	55                   	push   %ebp
  801349:	89 e5                	mov    %esp,%ebp
  80134b:	83 ec 04             	sub    $0x4,%esp
  80134e:	8b 45 10             	mov    0x10(%ebp),%eax
  801351:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801354:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801357:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80135b:	8b 45 08             	mov    0x8(%ebp),%eax
  80135e:	6a 00                	push   $0x0
  801360:	51                   	push   %ecx
  801361:	52                   	push   %edx
  801362:	ff 75 0c             	pushl  0xc(%ebp)
  801365:	50                   	push   %eax
  801366:	6a 1c                	push   $0x1c
  801368:	e8 b6 fc ff ff       	call   801023 <syscall>
  80136d:	83 c4 18             	add    $0x18,%esp
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801375:	8b 55 0c             	mov    0xc(%ebp),%edx
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	52                   	push   %edx
  801382:	50                   	push   %eax
  801383:	6a 1d                	push   $0x1d
  801385:	e8 99 fc ff ff       	call   801023 <syscall>
  80138a:	83 c4 18             	add    $0x18,%esp
}
  80138d:	c9                   	leave  
  80138e:	c3                   	ret    

0080138f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80138f:	55                   	push   %ebp
  801390:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801392:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801395:	8b 55 0c             	mov    0xc(%ebp),%edx
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	51                   	push   %ecx
  8013a0:	52                   	push   %edx
  8013a1:	50                   	push   %eax
  8013a2:	6a 1e                	push   $0x1e
  8013a4:	e8 7a fc ff ff       	call   801023 <syscall>
  8013a9:	83 c4 18             	add    $0x18,%esp
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	52                   	push   %edx
  8013be:	50                   	push   %eax
  8013bf:	6a 1f                	push   $0x1f
  8013c1:	e8 5d fc ff ff       	call   801023 <syscall>
  8013c6:	83 c4 18             	add    $0x18,%esp
}
  8013c9:	c9                   	leave  
  8013ca:	c3                   	ret    

008013cb <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013cb:	55                   	push   %ebp
  8013cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 20                	push   $0x20
  8013da:	e8 44 fc ff ff       	call   801023 <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	c9                   	leave  
  8013e3:	c3                   	ret    

008013e4 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013e4:	55                   	push   %ebp
  8013e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	ff 75 10             	pushl  0x10(%ebp)
  8013f1:	ff 75 0c             	pushl  0xc(%ebp)
  8013f4:	50                   	push   %eax
  8013f5:	6a 21                	push   $0x21
  8013f7:	e8 27 fc ff ff       	call   801023 <syscall>
  8013fc:	83 c4 18             	add    $0x18,%esp
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801404:	8b 45 08             	mov    0x8(%ebp),%eax
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	50                   	push   %eax
  801410:	6a 22                	push   $0x22
  801412:	e8 0c fc ff ff       	call   801023 <syscall>
  801417:	83 c4 18             	add    $0x18,%esp
}
  80141a:	90                   	nop
  80141b:	c9                   	leave  
  80141c:	c3                   	ret    

0080141d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80141d:	55                   	push   %ebp
  80141e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	50                   	push   %eax
  80142c:	6a 23                	push   $0x23
  80142e:	e8 f0 fb ff ff       	call   801023 <syscall>
  801433:	83 c4 18             	add    $0x18,%esp
}
  801436:	90                   	nop
  801437:	c9                   	leave  
  801438:	c3                   	ret    

00801439 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801439:	55                   	push   %ebp
  80143a:	89 e5                	mov    %esp,%ebp
  80143c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80143f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801442:	8d 50 04             	lea    0x4(%eax),%edx
  801445:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	52                   	push   %edx
  80144f:	50                   	push   %eax
  801450:	6a 24                	push   $0x24
  801452:	e8 cc fb ff ff       	call   801023 <syscall>
  801457:	83 c4 18             	add    $0x18,%esp
	return result;
  80145a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80145d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801460:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801463:	89 01                	mov    %eax,(%ecx)
  801465:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	c9                   	leave  
  80146c:	c2 04 00             	ret    $0x4

0080146f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	ff 75 10             	pushl  0x10(%ebp)
  801479:	ff 75 0c             	pushl  0xc(%ebp)
  80147c:	ff 75 08             	pushl  0x8(%ebp)
  80147f:	6a 13                	push   $0x13
  801481:	e8 9d fb ff ff       	call   801023 <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
	return ;
  801489:	90                   	nop
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <sys_rcr2>:
uint32 sys_rcr2()
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 25                	push   $0x25
  80149b:	e8 83 fb ff ff       	call   801023 <syscall>
  8014a0:	83 c4 18             	add    $0x18,%esp
}
  8014a3:	c9                   	leave  
  8014a4:	c3                   	ret    

008014a5 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
  8014a8:	83 ec 04             	sub    $0x4,%esp
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014b1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	50                   	push   %eax
  8014be:	6a 26                	push   $0x26
  8014c0:	e8 5e fb ff ff       	call   801023 <syscall>
  8014c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c8:	90                   	nop
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <rsttst>:
void rsttst()
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 28                	push   $0x28
  8014da:	e8 44 fb ff ff       	call   801023 <syscall>
  8014df:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e2:	90                   	nop
}
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
  8014e8:	83 ec 04             	sub    $0x4,%esp
  8014eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014f1:	8b 55 18             	mov    0x18(%ebp),%edx
  8014f4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014f8:	52                   	push   %edx
  8014f9:	50                   	push   %eax
  8014fa:	ff 75 10             	pushl  0x10(%ebp)
  8014fd:	ff 75 0c             	pushl  0xc(%ebp)
  801500:	ff 75 08             	pushl  0x8(%ebp)
  801503:	6a 27                	push   $0x27
  801505:	e8 19 fb ff ff       	call   801023 <syscall>
  80150a:	83 c4 18             	add    $0x18,%esp
	return ;
  80150d:	90                   	nop
}
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <chktst>:
void chktst(uint32 n)
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	ff 75 08             	pushl  0x8(%ebp)
  80151e:	6a 29                	push   $0x29
  801520:	e8 fe fa ff ff       	call   801023 <syscall>
  801525:	83 c4 18             	add    $0x18,%esp
	return ;
  801528:	90                   	nop
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <inctst>:

void inctst()
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 2a                	push   $0x2a
  80153a:	e8 e4 fa ff ff       	call   801023 <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
	return ;
  801542:	90                   	nop
}
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <gettst>:
uint32 gettst()
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 2b                	push   $0x2b
  801554:	e8 ca fa ff ff       	call   801023 <syscall>
  801559:	83 c4 18             	add    $0x18,%esp
}
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
  801561:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 2c                	push   $0x2c
  801570:	e8 ae fa ff ff       	call   801023 <syscall>
  801575:	83 c4 18             	add    $0x18,%esp
  801578:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80157b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80157f:	75 07                	jne    801588 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801581:	b8 01 00 00 00       	mov    $0x1,%eax
  801586:	eb 05                	jmp    80158d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801588:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
  801592:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 2c                	push   $0x2c
  8015a1:	e8 7d fa ff ff       	call   801023 <syscall>
  8015a6:	83 c4 18             	add    $0x18,%esp
  8015a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015ac:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015b0:	75 07                	jne    8015b9 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b7:	eb 05                	jmp    8015be <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
  8015c3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 2c                	push   $0x2c
  8015d2:	e8 4c fa ff ff       	call   801023 <syscall>
  8015d7:	83 c4 18             	add    $0x18,%esp
  8015da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015dd:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015e1:	75 07                	jne    8015ea <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015e3:	b8 01 00 00 00       	mov    $0x1,%eax
  8015e8:	eb 05                	jmp    8015ef <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
  8015f4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 2c                	push   $0x2c
  801603:	e8 1b fa ff ff       	call   801023 <syscall>
  801608:	83 c4 18             	add    $0x18,%esp
  80160b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80160e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801612:	75 07                	jne    80161b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801614:	b8 01 00 00 00       	mov    $0x1,%eax
  801619:	eb 05                	jmp    801620 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80161b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	ff 75 08             	pushl  0x8(%ebp)
  801630:	6a 2d                	push   $0x2d
  801632:	e8 ec f9 ff ff       	call   801023 <syscall>
  801637:	83 c4 18             	add    $0x18,%esp
	return ;
  80163a:	90                   	nop
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    
  80163d:	66 90                	xchg   %ax,%ax
  80163f:	90                   	nop

00801640 <__udivdi3>:
  801640:	55                   	push   %ebp
  801641:	57                   	push   %edi
  801642:	56                   	push   %esi
  801643:	53                   	push   %ebx
  801644:	83 ec 1c             	sub    $0x1c,%esp
  801647:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80164b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80164f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801653:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801657:	89 ca                	mov    %ecx,%edx
  801659:	89 f8                	mov    %edi,%eax
  80165b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80165f:	85 f6                	test   %esi,%esi
  801661:	75 2d                	jne    801690 <__udivdi3+0x50>
  801663:	39 cf                	cmp    %ecx,%edi
  801665:	77 65                	ja     8016cc <__udivdi3+0x8c>
  801667:	89 fd                	mov    %edi,%ebp
  801669:	85 ff                	test   %edi,%edi
  80166b:	75 0b                	jne    801678 <__udivdi3+0x38>
  80166d:	b8 01 00 00 00       	mov    $0x1,%eax
  801672:	31 d2                	xor    %edx,%edx
  801674:	f7 f7                	div    %edi
  801676:	89 c5                	mov    %eax,%ebp
  801678:	31 d2                	xor    %edx,%edx
  80167a:	89 c8                	mov    %ecx,%eax
  80167c:	f7 f5                	div    %ebp
  80167e:	89 c1                	mov    %eax,%ecx
  801680:	89 d8                	mov    %ebx,%eax
  801682:	f7 f5                	div    %ebp
  801684:	89 cf                	mov    %ecx,%edi
  801686:	89 fa                	mov    %edi,%edx
  801688:	83 c4 1c             	add    $0x1c,%esp
  80168b:	5b                   	pop    %ebx
  80168c:	5e                   	pop    %esi
  80168d:	5f                   	pop    %edi
  80168e:	5d                   	pop    %ebp
  80168f:	c3                   	ret    
  801690:	39 ce                	cmp    %ecx,%esi
  801692:	77 28                	ja     8016bc <__udivdi3+0x7c>
  801694:	0f bd fe             	bsr    %esi,%edi
  801697:	83 f7 1f             	xor    $0x1f,%edi
  80169a:	75 40                	jne    8016dc <__udivdi3+0x9c>
  80169c:	39 ce                	cmp    %ecx,%esi
  80169e:	72 0a                	jb     8016aa <__udivdi3+0x6a>
  8016a0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016a4:	0f 87 9e 00 00 00    	ja     801748 <__udivdi3+0x108>
  8016aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8016af:	89 fa                	mov    %edi,%edx
  8016b1:	83 c4 1c             	add    $0x1c,%esp
  8016b4:	5b                   	pop    %ebx
  8016b5:	5e                   	pop    %esi
  8016b6:	5f                   	pop    %edi
  8016b7:	5d                   	pop    %ebp
  8016b8:	c3                   	ret    
  8016b9:	8d 76 00             	lea    0x0(%esi),%esi
  8016bc:	31 ff                	xor    %edi,%edi
  8016be:	31 c0                	xor    %eax,%eax
  8016c0:	89 fa                	mov    %edi,%edx
  8016c2:	83 c4 1c             	add    $0x1c,%esp
  8016c5:	5b                   	pop    %ebx
  8016c6:	5e                   	pop    %esi
  8016c7:	5f                   	pop    %edi
  8016c8:	5d                   	pop    %ebp
  8016c9:	c3                   	ret    
  8016ca:	66 90                	xchg   %ax,%ax
  8016cc:	89 d8                	mov    %ebx,%eax
  8016ce:	f7 f7                	div    %edi
  8016d0:	31 ff                	xor    %edi,%edi
  8016d2:	89 fa                	mov    %edi,%edx
  8016d4:	83 c4 1c             	add    $0x1c,%esp
  8016d7:	5b                   	pop    %ebx
  8016d8:	5e                   	pop    %esi
  8016d9:	5f                   	pop    %edi
  8016da:	5d                   	pop    %ebp
  8016db:	c3                   	ret    
  8016dc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016e1:	89 eb                	mov    %ebp,%ebx
  8016e3:	29 fb                	sub    %edi,%ebx
  8016e5:	89 f9                	mov    %edi,%ecx
  8016e7:	d3 e6                	shl    %cl,%esi
  8016e9:	89 c5                	mov    %eax,%ebp
  8016eb:	88 d9                	mov    %bl,%cl
  8016ed:	d3 ed                	shr    %cl,%ebp
  8016ef:	89 e9                	mov    %ebp,%ecx
  8016f1:	09 f1                	or     %esi,%ecx
  8016f3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016f7:	89 f9                	mov    %edi,%ecx
  8016f9:	d3 e0                	shl    %cl,%eax
  8016fb:	89 c5                	mov    %eax,%ebp
  8016fd:	89 d6                	mov    %edx,%esi
  8016ff:	88 d9                	mov    %bl,%cl
  801701:	d3 ee                	shr    %cl,%esi
  801703:	89 f9                	mov    %edi,%ecx
  801705:	d3 e2                	shl    %cl,%edx
  801707:	8b 44 24 08          	mov    0x8(%esp),%eax
  80170b:	88 d9                	mov    %bl,%cl
  80170d:	d3 e8                	shr    %cl,%eax
  80170f:	09 c2                	or     %eax,%edx
  801711:	89 d0                	mov    %edx,%eax
  801713:	89 f2                	mov    %esi,%edx
  801715:	f7 74 24 0c          	divl   0xc(%esp)
  801719:	89 d6                	mov    %edx,%esi
  80171b:	89 c3                	mov    %eax,%ebx
  80171d:	f7 e5                	mul    %ebp
  80171f:	39 d6                	cmp    %edx,%esi
  801721:	72 19                	jb     80173c <__udivdi3+0xfc>
  801723:	74 0b                	je     801730 <__udivdi3+0xf0>
  801725:	89 d8                	mov    %ebx,%eax
  801727:	31 ff                	xor    %edi,%edi
  801729:	e9 58 ff ff ff       	jmp    801686 <__udivdi3+0x46>
  80172e:	66 90                	xchg   %ax,%ax
  801730:	8b 54 24 08          	mov    0x8(%esp),%edx
  801734:	89 f9                	mov    %edi,%ecx
  801736:	d3 e2                	shl    %cl,%edx
  801738:	39 c2                	cmp    %eax,%edx
  80173a:	73 e9                	jae    801725 <__udivdi3+0xe5>
  80173c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80173f:	31 ff                	xor    %edi,%edi
  801741:	e9 40 ff ff ff       	jmp    801686 <__udivdi3+0x46>
  801746:	66 90                	xchg   %ax,%ax
  801748:	31 c0                	xor    %eax,%eax
  80174a:	e9 37 ff ff ff       	jmp    801686 <__udivdi3+0x46>
  80174f:	90                   	nop

00801750 <__umoddi3>:
  801750:	55                   	push   %ebp
  801751:	57                   	push   %edi
  801752:	56                   	push   %esi
  801753:	53                   	push   %ebx
  801754:	83 ec 1c             	sub    $0x1c,%esp
  801757:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80175b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80175f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801763:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801767:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80176b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80176f:	89 f3                	mov    %esi,%ebx
  801771:	89 fa                	mov    %edi,%edx
  801773:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801777:	89 34 24             	mov    %esi,(%esp)
  80177a:	85 c0                	test   %eax,%eax
  80177c:	75 1a                	jne    801798 <__umoddi3+0x48>
  80177e:	39 f7                	cmp    %esi,%edi
  801780:	0f 86 a2 00 00 00    	jbe    801828 <__umoddi3+0xd8>
  801786:	89 c8                	mov    %ecx,%eax
  801788:	89 f2                	mov    %esi,%edx
  80178a:	f7 f7                	div    %edi
  80178c:	89 d0                	mov    %edx,%eax
  80178e:	31 d2                	xor    %edx,%edx
  801790:	83 c4 1c             	add    $0x1c,%esp
  801793:	5b                   	pop    %ebx
  801794:	5e                   	pop    %esi
  801795:	5f                   	pop    %edi
  801796:	5d                   	pop    %ebp
  801797:	c3                   	ret    
  801798:	39 f0                	cmp    %esi,%eax
  80179a:	0f 87 ac 00 00 00    	ja     80184c <__umoddi3+0xfc>
  8017a0:	0f bd e8             	bsr    %eax,%ebp
  8017a3:	83 f5 1f             	xor    $0x1f,%ebp
  8017a6:	0f 84 ac 00 00 00    	je     801858 <__umoddi3+0x108>
  8017ac:	bf 20 00 00 00       	mov    $0x20,%edi
  8017b1:	29 ef                	sub    %ebp,%edi
  8017b3:	89 fe                	mov    %edi,%esi
  8017b5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017b9:	89 e9                	mov    %ebp,%ecx
  8017bb:	d3 e0                	shl    %cl,%eax
  8017bd:	89 d7                	mov    %edx,%edi
  8017bf:	89 f1                	mov    %esi,%ecx
  8017c1:	d3 ef                	shr    %cl,%edi
  8017c3:	09 c7                	or     %eax,%edi
  8017c5:	89 e9                	mov    %ebp,%ecx
  8017c7:	d3 e2                	shl    %cl,%edx
  8017c9:	89 14 24             	mov    %edx,(%esp)
  8017cc:	89 d8                	mov    %ebx,%eax
  8017ce:	d3 e0                	shl    %cl,%eax
  8017d0:	89 c2                	mov    %eax,%edx
  8017d2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017d6:	d3 e0                	shl    %cl,%eax
  8017d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017dc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017e0:	89 f1                	mov    %esi,%ecx
  8017e2:	d3 e8                	shr    %cl,%eax
  8017e4:	09 d0                	or     %edx,%eax
  8017e6:	d3 eb                	shr    %cl,%ebx
  8017e8:	89 da                	mov    %ebx,%edx
  8017ea:	f7 f7                	div    %edi
  8017ec:	89 d3                	mov    %edx,%ebx
  8017ee:	f7 24 24             	mull   (%esp)
  8017f1:	89 c6                	mov    %eax,%esi
  8017f3:	89 d1                	mov    %edx,%ecx
  8017f5:	39 d3                	cmp    %edx,%ebx
  8017f7:	0f 82 87 00 00 00    	jb     801884 <__umoddi3+0x134>
  8017fd:	0f 84 91 00 00 00    	je     801894 <__umoddi3+0x144>
  801803:	8b 54 24 04          	mov    0x4(%esp),%edx
  801807:	29 f2                	sub    %esi,%edx
  801809:	19 cb                	sbb    %ecx,%ebx
  80180b:	89 d8                	mov    %ebx,%eax
  80180d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801811:	d3 e0                	shl    %cl,%eax
  801813:	89 e9                	mov    %ebp,%ecx
  801815:	d3 ea                	shr    %cl,%edx
  801817:	09 d0                	or     %edx,%eax
  801819:	89 e9                	mov    %ebp,%ecx
  80181b:	d3 eb                	shr    %cl,%ebx
  80181d:	89 da                	mov    %ebx,%edx
  80181f:	83 c4 1c             	add    $0x1c,%esp
  801822:	5b                   	pop    %ebx
  801823:	5e                   	pop    %esi
  801824:	5f                   	pop    %edi
  801825:	5d                   	pop    %ebp
  801826:	c3                   	ret    
  801827:	90                   	nop
  801828:	89 fd                	mov    %edi,%ebp
  80182a:	85 ff                	test   %edi,%edi
  80182c:	75 0b                	jne    801839 <__umoddi3+0xe9>
  80182e:	b8 01 00 00 00       	mov    $0x1,%eax
  801833:	31 d2                	xor    %edx,%edx
  801835:	f7 f7                	div    %edi
  801837:	89 c5                	mov    %eax,%ebp
  801839:	89 f0                	mov    %esi,%eax
  80183b:	31 d2                	xor    %edx,%edx
  80183d:	f7 f5                	div    %ebp
  80183f:	89 c8                	mov    %ecx,%eax
  801841:	f7 f5                	div    %ebp
  801843:	89 d0                	mov    %edx,%eax
  801845:	e9 44 ff ff ff       	jmp    80178e <__umoddi3+0x3e>
  80184a:	66 90                	xchg   %ax,%ax
  80184c:	89 c8                	mov    %ecx,%eax
  80184e:	89 f2                	mov    %esi,%edx
  801850:	83 c4 1c             	add    $0x1c,%esp
  801853:	5b                   	pop    %ebx
  801854:	5e                   	pop    %esi
  801855:	5f                   	pop    %edi
  801856:	5d                   	pop    %ebp
  801857:	c3                   	ret    
  801858:	3b 04 24             	cmp    (%esp),%eax
  80185b:	72 06                	jb     801863 <__umoddi3+0x113>
  80185d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801861:	77 0f                	ja     801872 <__umoddi3+0x122>
  801863:	89 f2                	mov    %esi,%edx
  801865:	29 f9                	sub    %edi,%ecx
  801867:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80186b:	89 14 24             	mov    %edx,(%esp)
  80186e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801872:	8b 44 24 04          	mov    0x4(%esp),%eax
  801876:	8b 14 24             	mov    (%esp),%edx
  801879:	83 c4 1c             	add    $0x1c,%esp
  80187c:	5b                   	pop    %ebx
  80187d:	5e                   	pop    %esi
  80187e:	5f                   	pop    %edi
  80187f:	5d                   	pop    %ebp
  801880:	c3                   	ret    
  801881:	8d 76 00             	lea    0x0(%esi),%esi
  801884:	2b 04 24             	sub    (%esp),%eax
  801887:	19 fa                	sbb    %edi,%edx
  801889:	89 d1                	mov    %edx,%ecx
  80188b:	89 c6                	mov    %eax,%esi
  80188d:	e9 71 ff ff ff       	jmp    801803 <__umoddi3+0xb3>
  801892:	66 90                	xchg   %ax,%ax
  801894:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801898:	72 ea                	jb     801884 <__umoddi3+0x134>
  80189a:	89 d9                	mov    %ebx,%ecx
  80189c:	e9 62 ff ff ff       	jmp    801803 <__umoddi3+0xb3>
