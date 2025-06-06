
obj/user/test_trim1_c:     file format elf32-i386


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
  800031:	e8 e3 00 00 00       	call   800119 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 requiredMemFrames;
uint32 extraFramesNeeded ;
uint32 memFramesToAllocate;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	remainingfreeframes = sys_calculate_free_frames();
  80003e:	e8 32 14 00 00       	call   801475 <sys_calculate_free_frames>
  800043:	a3 28 30 80 00       	mov    %eax,0x803028
	memFramesToAllocate = (remainingfreeframes+0);
  800048:	a1 28 30 80 00       	mov    0x803028,%eax
  80004d:	a3 38 30 80 00       	mov    %eax,0x803038

	requiredMemFrames = sys_calculate_required_frames(USER_HEAP_START, memFramesToAllocate*PAGE_SIZE);
  800052:	a1 38 30 80 00       	mov    0x803038,%eax
  800057:	c1 e0 0c             	shl    $0xc,%eax
  80005a:	83 ec 08             	sub    $0x8,%esp
  80005d:	50                   	push   %eax
  80005e:	68 00 00 00 80       	push   $0x80000000
  800063:	e8 f2 13 00 00       	call   80145a <sys_calculate_required_frames>
  800068:	83 c4 10             	add    $0x10,%esp
  80006b:	a3 2c 30 80 00       	mov    %eax,0x80302c
	extraFramesNeeded = requiredMemFrames - remainingfreeframes;
  800070:	8b 15 2c 30 80 00    	mov    0x80302c,%edx
  800076:	a1 28 30 80 00       	mov    0x803028,%eax
  80007b:	29 c2                	sub    %eax,%edx
  80007d:	89 d0                	mov    %edx,%eax
  80007f:	a3 34 30 80 00       	mov    %eax,0x803034
	
	//cprintf("remaining frames = %d\n",remainingfreeframes);
	//cprintf("frames desired to be allocated = %d\n",memFramesToAllocate);
	//cprintf("req frames = %d\n",requiredMemFrames);
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
  800084:	a1 38 30 80 00       	mov    0x803038,%eax
  800089:	c1 e0 0c             	shl    $0xc,%eax
  80008c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char* x = malloc(sizeof(char)*size);
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	ff 75 f0             	pushl  -0x10(%ebp)
  800095:	e8 19 10 00 00       	call   8010b3 <malloc>
  80009a:	83 c4 10             	add    $0x10,%esp
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	uint32 i=0;
  8000a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(i=0; i<size;i++ )
  8000a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ae:	eb 0e                	jmp    8000be <_main+0x86>
	{
		x[i]=-1;
  8000b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8000b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b6:	01 d0                	add    %edx,%eax
  8000b8:	c6 00 ff             	movb   $0xff,(%eax)
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
	char* x = malloc(sizeof(char)*size);

	uint32 i=0;
	for(i=0; i<size;i++ )
  8000bb:	ff 45 f4             	incl   -0xc(%ebp)
  8000be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000c4:	72 ea                	jb     8000b0 <_main+0x78>
	{
		x[i]=-1;
	}

	uint32 all_frames_to_be_trimmed = ROUNDUP(extraFramesNeeded*2, 3);
  8000c6:	c7 45 e8 03 00 00 00 	movl   $0x3,-0x18(%ebp)
  8000cd:	a1 34 30 80 00       	mov    0x803034,%eax
  8000d2:	01 c0                	add    %eax,%eax
  8000d4:	89 c2                	mov    %eax,%edx
  8000d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d9:	01 d0                	add    %edx,%eax
  8000db:	48                   	dec    %eax
  8000dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8000e7:	f7 75 e8             	divl   -0x18(%ebp)
  8000ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000ed:	29 d0                	sub    %edx,%eax
  8000ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
	uint32 frames_to_trimmed_every_env = all_frames_to_be_trimmed/3;
  8000f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f5:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
  8000fa:	f7 e2                	mul    %edx
  8000fc:	89 d0                	mov    %edx,%eax
  8000fe:	d1 e8                	shr    %eax
  800100:	89 45 dc             	mov    %eax,-0x24(%ebp)

	cprintf("Frames to be trimmed from A or B = %d\n", frames_to_trimmed_every_env);
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	ff 75 dc             	pushl  -0x24(%ebp)
  800109:	68 80 1d 80 00       	push   $0x801d80
  80010e:	e8 dc 01 00 00       	call   8002ef <cprintf>
  800113:	83 c4 10             	add    $0x10,%esp

	return;	
  800116:	90                   	nop
}
  800117:	c9                   	leave  
  800118:	c3                   	ret    

00800119 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800119:	55                   	push   %ebp
  80011a:	89 e5                	mov    %esp,%ebp
  80011c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80011f:	e8 86 12 00 00       	call   8013aa <sys_getenvindex>
  800124:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800127:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80012a:	89 d0                	mov    %edx,%eax
  80012c:	01 c0                	add    %eax,%eax
  80012e:	01 d0                	add    %edx,%eax
  800130:	c1 e0 02             	shl    $0x2,%eax
  800133:	01 d0                	add    %edx,%eax
  800135:	c1 e0 06             	shl    $0x6,%eax
  800138:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80013d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800142:	a1 20 30 80 00       	mov    0x803020,%eax
  800147:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80014d:	84 c0                	test   %al,%al
  80014f:	74 0f                	je     800160 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800151:	a1 20 30 80 00       	mov    0x803020,%eax
  800156:	05 f4 02 00 00       	add    $0x2f4,%eax
  80015b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800160:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800164:	7e 0a                	jle    800170 <libmain+0x57>
		binaryname = argv[0];
  800166:	8b 45 0c             	mov    0xc(%ebp),%eax
  800169:	8b 00                	mov    (%eax),%eax
  80016b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	ff 75 0c             	pushl  0xc(%ebp)
  800176:	ff 75 08             	pushl  0x8(%ebp)
  800179:	e8 ba fe ff ff       	call   800038 <_main>
  80017e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800181:	e8 bf 13 00 00       	call   801545 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800186:	83 ec 0c             	sub    $0xc,%esp
  800189:	68 c0 1d 80 00       	push   $0x801dc0
  80018e:	e8 5c 01 00 00       	call   8002ef <cprintf>
  800193:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800196:	a1 20 30 80 00       	mov    0x803020,%eax
  80019b:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a6:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001ac:	83 ec 04             	sub    $0x4,%esp
  8001af:	52                   	push   %edx
  8001b0:	50                   	push   %eax
  8001b1:	68 e8 1d 80 00       	push   $0x801de8
  8001b6:	e8 34 01 00 00       	call   8002ef <cprintf>
  8001bb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001be:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c3:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001c9:	83 ec 08             	sub    $0x8,%esp
  8001cc:	50                   	push   %eax
  8001cd:	68 0d 1e 80 00       	push   $0x801e0d
  8001d2:	e8 18 01 00 00       	call   8002ef <cprintf>
  8001d7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 c0 1d 80 00       	push   $0x801dc0
  8001e2:	e8 08 01 00 00       	call   8002ef <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001ea:	e8 70 13 00 00       	call   80155f <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001ef:	e8 19 00 00 00       	call   80020d <exit>
}
  8001f4:	90                   	nop
  8001f5:	c9                   	leave  
  8001f6:	c3                   	ret    

008001f7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001f7:	55                   	push   %ebp
  8001f8:	89 e5                	mov    %esp,%ebp
  8001fa:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001fd:	83 ec 0c             	sub    $0xc,%esp
  800200:	6a 00                	push   $0x0
  800202:	e8 6f 11 00 00       	call   801376 <sys_env_destroy>
  800207:	83 c4 10             	add    $0x10,%esp
}
  80020a:	90                   	nop
  80020b:	c9                   	leave  
  80020c:	c3                   	ret    

0080020d <exit>:

void
exit(void)
{
  80020d:	55                   	push   %ebp
  80020e:	89 e5                	mov    %esp,%ebp
  800210:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800213:	e8 c4 11 00 00       	call   8013dc <sys_env_exit>
}
  800218:	90                   	nop
  800219:	c9                   	leave  
  80021a:	c3                   	ret    

0080021b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80021b:	55                   	push   %ebp
  80021c:	89 e5                	mov    %esp,%ebp
  80021e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800221:	8b 45 0c             	mov    0xc(%ebp),%eax
  800224:	8b 00                	mov    (%eax),%eax
  800226:	8d 48 01             	lea    0x1(%eax),%ecx
  800229:	8b 55 0c             	mov    0xc(%ebp),%edx
  80022c:	89 0a                	mov    %ecx,(%edx)
  80022e:	8b 55 08             	mov    0x8(%ebp),%edx
  800231:	88 d1                	mov    %dl,%cl
  800233:	8b 55 0c             	mov    0xc(%ebp),%edx
  800236:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80023a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023d:	8b 00                	mov    (%eax),%eax
  80023f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800244:	75 2c                	jne    800272 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800246:	a0 24 30 80 00       	mov    0x803024,%al
  80024b:	0f b6 c0             	movzbl %al,%eax
  80024e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800251:	8b 12                	mov    (%edx),%edx
  800253:	89 d1                	mov    %edx,%ecx
  800255:	8b 55 0c             	mov    0xc(%ebp),%edx
  800258:	83 c2 08             	add    $0x8,%edx
  80025b:	83 ec 04             	sub    $0x4,%esp
  80025e:	50                   	push   %eax
  80025f:	51                   	push   %ecx
  800260:	52                   	push   %edx
  800261:	e8 ce 10 00 00       	call   801334 <sys_cputs>
  800266:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800269:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800272:	8b 45 0c             	mov    0xc(%ebp),%eax
  800275:	8b 40 04             	mov    0x4(%eax),%eax
  800278:	8d 50 01             	lea    0x1(%eax),%edx
  80027b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80027e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800281:	90                   	nop
  800282:	c9                   	leave  
  800283:	c3                   	ret    

00800284 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800284:	55                   	push   %ebp
  800285:	89 e5                	mov    %esp,%ebp
  800287:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80028d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800294:	00 00 00 
	b.cnt = 0;
  800297:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80029e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002a1:	ff 75 0c             	pushl  0xc(%ebp)
  8002a4:	ff 75 08             	pushl  0x8(%ebp)
  8002a7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002ad:	50                   	push   %eax
  8002ae:	68 1b 02 80 00       	push   $0x80021b
  8002b3:	e8 11 02 00 00       	call   8004c9 <vprintfmt>
  8002b8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002bb:	a0 24 30 80 00       	mov    0x803024,%al
  8002c0:	0f b6 c0             	movzbl %al,%eax
  8002c3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002c9:	83 ec 04             	sub    $0x4,%esp
  8002cc:	50                   	push   %eax
  8002cd:	52                   	push   %edx
  8002ce:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002d4:	83 c0 08             	add    $0x8,%eax
  8002d7:	50                   	push   %eax
  8002d8:	e8 57 10 00 00       	call   801334 <sys_cputs>
  8002dd:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002e0:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002e7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002ed:	c9                   	leave  
  8002ee:	c3                   	ret    

008002ef <cprintf>:

int cprintf(const char *fmt, ...) {
  8002ef:	55                   	push   %ebp
  8002f0:	89 e5                	mov    %esp,%ebp
  8002f2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002f5:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002fc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800302:	8b 45 08             	mov    0x8(%ebp),%eax
  800305:	83 ec 08             	sub    $0x8,%esp
  800308:	ff 75 f4             	pushl  -0xc(%ebp)
  80030b:	50                   	push   %eax
  80030c:	e8 73 ff ff ff       	call   800284 <vcprintf>
  800311:	83 c4 10             	add    $0x10,%esp
  800314:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800317:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80031a:	c9                   	leave  
  80031b:	c3                   	ret    

0080031c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80031c:	55                   	push   %ebp
  80031d:	89 e5                	mov    %esp,%ebp
  80031f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800322:	e8 1e 12 00 00       	call   801545 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800327:	8d 45 0c             	lea    0xc(%ebp),%eax
  80032a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80032d:	8b 45 08             	mov    0x8(%ebp),%eax
  800330:	83 ec 08             	sub    $0x8,%esp
  800333:	ff 75 f4             	pushl  -0xc(%ebp)
  800336:	50                   	push   %eax
  800337:	e8 48 ff ff ff       	call   800284 <vcprintf>
  80033c:	83 c4 10             	add    $0x10,%esp
  80033f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800342:	e8 18 12 00 00       	call   80155f <sys_enable_interrupt>
	return cnt;
  800347:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80034a:	c9                   	leave  
  80034b:	c3                   	ret    

0080034c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80034c:	55                   	push   %ebp
  80034d:	89 e5                	mov    %esp,%ebp
  80034f:	53                   	push   %ebx
  800350:	83 ec 14             	sub    $0x14,%esp
  800353:	8b 45 10             	mov    0x10(%ebp),%eax
  800356:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800359:	8b 45 14             	mov    0x14(%ebp),%eax
  80035c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80035f:	8b 45 18             	mov    0x18(%ebp),%eax
  800362:	ba 00 00 00 00       	mov    $0x0,%edx
  800367:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80036a:	77 55                	ja     8003c1 <printnum+0x75>
  80036c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80036f:	72 05                	jb     800376 <printnum+0x2a>
  800371:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800374:	77 4b                	ja     8003c1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800376:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800379:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80037c:	8b 45 18             	mov    0x18(%ebp),%eax
  80037f:	ba 00 00 00 00       	mov    $0x0,%edx
  800384:	52                   	push   %edx
  800385:	50                   	push   %eax
  800386:	ff 75 f4             	pushl  -0xc(%ebp)
  800389:	ff 75 f0             	pushl  -0x10(%ebp)
  80038c:	e8 73 17 00 00       	call   801b04 <__udivdi3>
  800391:	83 c4 10             	add    $0x10,%esp
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	ff 75 20             	pushl  0x20(%ebp)
  80039a:	53                   	push   %ebx
  80039b:	ff 75 18             	pushl  0x18(%ebp)
  80039e:	52                   	push   %edx
  80039f:	50                   	push   %eax
  8003a0:	ff 75 0c             	pushl  0xc(%ebp)
  8003a3:	ff 75 08             	pushl  0x8(%ebp)
  8003a6:	e8 a1 ff ff ff       	call   80034c <printnum>
  8003ab:	83 c4 20             	add    $0x20,%esp
  8003ae:	eb 1a                	jmp    8003ca <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003b0:	83 ec 08             	sub    $0x8,%esp
  8003b3:	ff 75 0c             	pushl  0xc(%ebp)
  8003b6:	ff 75 20             	pushl  0x20(%ebp)
  8003b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bc:	ff d0                	call   *%eax
  8003be:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003c1:	ff 4d 1c             	decl   0x1c(%ebp)
  8003c4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003c8:	7f e6                	jg     8003b0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003ca:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003cd:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003d8:	53                   	push   %ebx
  8003d9:	51                   	push   %ecx
  8003da:	52                   	push   %edx
  8003db:	50                   	push   %eax
  8003dc:	e8 33 18 00 00       	call   801c14 <__umoddi3>
  8003e1:	83 c4 10             	add    $0x10,%esp
  8003e4:	05 54 20 80 00       	add    $0x802054,%eax
  8003e9:	8a 00                	mov    (%eax),%al
  8003eb:	0f be c0             	movsbl %al,%eax
  8003ee:	83 ec 08             	sub    $0x8,%esp
  8003f1:	ff 75 0c             	pushl  0xc(%ebp)
  8003f4:	50                   	push   %eax
  8003f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f8:	ff d0                	call   *%eax
  8003fa:	83 c4 10             	add    $0x10,%esp
}
  8003fd:	90                   	nop
  8003fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800401:	c9                   	leave  
  800402:	c3                   	ret    

00800403 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800403:	55                   	push   %ebp
  800404:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800406:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80040a:	7e 1c                	jle    800428 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	8d 50 08             	lea    0x8(%eax),%edx
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	89 10                	mov    %edx,(%eax)
  800419:	8b 45 08             	mov    0x8(%ebp),%eax
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	83 e8 08             	sub    $0x8,%eax
  800421:	8b 50 04             	mov    0x4(%eax),%edx
  800424:	8b 00                	mov    (%eax),%eax
  800426:	eb 40                	jmp    800468 <getuint+0x65>
	else if (lflag)
  800428:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80042c:	74 1e                	je     80044c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80042e:	8b 45 08             	mov    0x8(%ebp),%eax
  800431:	8b 00                	mov    (%eax),%eax
  800433:	8d 50 04             	lea    0x4(%eax),%edx
  800436:	8b 45 08             	mov    0x8(%ebp),%eax
  800439:	89 10                	mov    %edx,(%eax)
  80043b:	8b 45 08             	mov    0x8(%ebp),%eax
  80043e:	8b 00                	mov    (%eax),%eax
  800440:	83 e8 04             	sub    $0x4,%eax
  800443:	8b 00                	mov    (%eax),%eax
  800445:	ba 00 00 00 00       	mov    $0x0,%edx
  80044a:	eb 1c                	jmp    800468 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	8d 50 04             	lea    0x4(%eax),%edx
  800454:	8b 45 08             	mov    0x8(%ebp),%eax
  800457:	89 10                	mov    %edx,(%eax)
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	83 e8 04             	sub    $0x4,%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800468:	5d                   	pop    %ebp
  800469:	c3                   	ret    

0080046a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80046a:	55                   	push   %ebp
  80046b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80046d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800471:	7e 1c                	jle    80048f <getint+0x25>
		return va_arg(*ap, long long);
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	8d 50 08             	lea    0x8(%eax),%edx
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	89 10                	mov    %edx,(%eax)
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	83 e8 08             	sub    $0x8,%eax
  800488:	8b 50 04             	mov    0x4(%eax),%edx
  80048b:	8b 00                	mov    (%eax),%eax
  80048d:	eb 38                	jmp    8004c7 <getint+0x5d>
	else if (lflag)
  80048f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800493:	74 1a                	je     8004af <getint+0x45>
		return va_arg(*ap, long);
  800495:	8b 45 08             	mov    0x8(%ebp),%eax
  800498:	8b 00                	mov    (%eax),%eax
  80049a:	8d 50 04             	lea    0x4(%eax),%edx
  80049d:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a0:	89 10                	mov    %edx,(%eax)
  8004a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a5:	8b 00                	mov    (%eax),%eax
  8004a7:	83 e8 04             	sub    $0x4,%eax
  8004aa:	8b 00                	mov    (%eax),%eax
  8004ac:	99                   	cltd   
  8004ad:	eb 18                	jmp    8004c7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004af:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b2:	8b 00                	mov    (%eax),%eax
  8004b4:	8d 50 04             	lea    0x4(%eax),%edx
  8004b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ba:	89 10                	mov    %edx,(%eax)
  8004bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bf:	8b 00                	mov    (%eax),%eax
  8004c1:	83 e8 04             	sub    $0x4,%eax
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	99                   	cltd   
}
  8004c7:	5d                   	pop    %ebp
  8004c8:	c3                   	ret    

008004c9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004c9:	55                   	push   %ebp
  8004ca:	89 e5                	mov    %esp,%ebp
  8004cc:	56                   	push   %esi
  8004cd:	53                   	push   %ebx
  8004ce:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004d1:	eb 17                	jmp    8004ea <vprintfmt+0x21>
			if (ch == '\0')
  8004d3:	85 db                	test   %ebx,%ebx
  8004d5:	0f 84 af 03 00 00    	je     80088a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004db:	83 ec 08             	sub    $0x8,%esp
  8004de:	ff 75 0c             	pushl  0xc(%ebp)
  8004e1:	53                   	push   %ebx
  8004e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e5:	ff d0                	call   *%eax
  8004e7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ed:	8d 50 01             	lea    0x1(%eax),%edx
  8004f0:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f3:	8a 00                	mov    (%eax),%al
  8004f5:	0f b6 d8             	movzbl %al,%ebx
  8004f8:	83 fb 25             	cmp    $0x25,%ebx
  8004fb:	75 d6                	jne    8004d3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004fd:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800501:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800508:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80050f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800516:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80051d:	8b 45 10             	mov    0x10(%ebp),%eax
  800520:	8d 50 01             	lea    0x1(%eax),%edx
  800523:	89 55 10             	mov    %edx,0x10(%ebp)
  800526:	8a 00                	mov    (%eax),%al
  800528:	0f b6 d8             	movzbl %al,%ebx
  80052b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80052e:	83 f8 55             	cmp    $0x55,%eax
  800531:	0f 87 2b 03 00 00    	ja     800862 <vprintfmt+0x399>
  800537:	8b 04 85 78 20 80 00 	mov    0x802078(,%eax,4),%eax
  80053e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800540:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800544:	eb d7                	jmp    80051d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800546:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80054a:	eb d1                	jmp    80051d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80054c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800553:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800556:	89 d0                	mov    %edx,%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	01 d0                	add    %edx,%eax
  80055d:	01 c0                	add    %eax,%eax
  80055f:	01 d8                	add    %ebx,%eax
  800561:	83 e8 30             	sub    $0x30,%eax
  800564:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800567:	8b 45 10             	mov    0x10(%ebp),%eax
  80056a:	8a 00                	mov    (%eax),%al
  80056c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80056f:	83 fb 2f             	cmp    $0x2f,%ebx
  800572:	7e 3e                	jle    8005b2 <vprintfmt+0xe9>
  800574:	83 fb 39             	cmp    $0x39,%ebx
  800577:	7f 39                	jg     8005b2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800579:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80057c:	eb d5                	jmp    800553 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80057e:	8b 45 14             	mov    0x14(%ebp),%eax
  800581:	83 c0 04             	add    $0x4,%eax
  800584:	89 45 14             	mov    %eax,0x14(%ebp)
  800587:	8b 45 14             	mov    0x14(%ebp),%eax
  80058a:	83 e8 04             	sub    $0x4,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800592:	eb 1f                	jmp    8005b3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800594:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800598:	79 83                	jns    80051d <vprintfmt+0x54>
				width = 0;
  80059a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005a1:	e9 77 ff ff ff       	jmp    80051d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005a6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005ad:	e9 6b ff ff ff       	jmp    80051d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005b2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005b7:	0f 89 60 ff ff ff    	jns    80051d <vprintfmt+0x54>
				width = precision, precision = -1;
  8005bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005c3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005ca:	e9 4e ff ff ff       	jmp    80051d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005cf:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005d2:	e9 46 ff ff ff       	jmp    80051d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005da:	83 c0 04             	add    $0x4,%eax
  8005dd:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e3:	83 e8 04             	sub    $0x4,%eax
  8005e6:	8b 00                	mov    (%eax),%eax
  8005e8:	83 ec 08             	sub    $0x8,%esp
  8005eb:	ff 75 0c             	pushl  0xc(%ebp)
  8005ee:	50                   	push   %eax
  8005ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f2:	ff d0                	call   *%eax
  8005f4:	83 c4 10             	add    $0x10,%esp
			break;
  8005f7:	e9 89 02 00 00       	jmp    800885 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ff:	83 c0 04             	add    $0x4,%eax
  800602:	89 45 14             	mov    %eax,0x14(%ebp)
  800605:	8b 45 14             	mov    0x14(%ebp),%eax
  800608:	83 e8 04             	sub    $0x4,%eax
  80060b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80060d:	85 db                	test   %ebx,%ebx
  80060f:	79 02                	jns    800613 <vprintfmt+0x14a>
				err = -err;
  800611:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800613:	83 fb 64             	cmp    $0x64,%ebx
  800616:	7f 0b                	jg     800623 <vprintfmt+0x15a>
  800618:	8b 34 9d c0 1e 80 00 	mov    0x801ec0(,%ebx,4),%esi
  80061f:	85 f6                	test   %esi,%esi
  800621:	75 19                	jne    80063c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800623:	53                   	push   %ebx
  800624:	68 65 20 80 00       	push   $0x802065
  800629:	ff 75 0c             	pushl  0xc(%ebp)
  80062c:	ff 75 08             	pushl  0x8(%ebp)
  80062f:	e8 5e 02 00 00       	call   800892 <printfmt>
  800634:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800637:	e9 49 02 00 00       	jmp    800885 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80063c:	56                   	push   %esi
  80063d:	68 6e 20 80 00       	push   $0x80206e
  800642:	ff 75 0c             	pushl  0xc(%ebp)
  800645:	ff 75 08             	pushl  0x8(%ebp)
  800648:	e8 45 02 00 00       	call   800892 <printfmt>
  80064d:	83 c4 10             	add    $0x10,%esp
			break;
  800650:	e9 30 02 00 00       	jmp    800885 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800655:	8b 45 14             	mov    0x14(%ebp),%eax
  800658:	83 c0 04             	add    $0x4,%eax
  80065b:	89 45 14             	mov    %eax,0x14(%ebp)
  80065e:	8b 45 14             	mov    0x14(%ebp),%eax
  800661:	83 e8 04             	sub    $0x4,%eax
  800664:	8b 30                	mov    (%eax),%esi
  800666:	85 f6                	test   %esi,%esi
  800668:	75 05                	jne    80066f <vprintfmt+0x1a6>
				p = "(null)";
  80066a:	be 71 20 80 00       	mov    $0x802071,%esi
			if (width > 0 && padc != '-')
  80066f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800673:	7e 6d                	jle    8006e2 <vprintfmt+0x219>
  800675:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800679:	74 67                	je     8006e2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80067b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80067e:	83 ec 08             	sub    $0x8,%esp
  800681:	50                   	push   %eax
  800682:	56                   	push   %esi
  800683:	e8 0c 03 00 00       	call   800994 <strnlen>
  800688:	83 c4 10             	add    $0x10,%esp
  80068b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80068e:	eb 16                	jmp    8006a6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800690:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800694:	83 ec 08             	sub    $0x8,%esp
  800697:	ff 75 0c             	pushl  0xc(%ebp)
  80069a:	50                   	push   %eax
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	ff d0                	call   *%eax
  8006a0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006a3:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006aa:	7f e4                	jg     800690 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ac:	eb 34                	jmp    8006e2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006ae:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006b2:	74 1c                	je     8006d0 <vprintfmt+0x207>
  8006b4:	83 fb 1f             	cmp    $0x1f,%ebx
  8006b7:	7e 05                	jle    8006be <vprintfmt+0x1f5>
  8006b9:	83 fb 7e             	cmp    $0x7e,%ebx
  8006bc:	7e 12                	jle    8006d0 <vprintfmt+0x207>
					putch('?', putdat);
  8006be:	83 ec 08             	sub    $0x8,%esp
  8006c1:	ff 75 0c             	pushl  0xc(%ebp)
  8006c4:	6a 3f                	push   $0x3f
  8006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c9:	ff d0                	call   *%eax
  8006cb:	83 c4 10             	add    $0x10,%esp
  8006ce:	eb 0f                	jmp    8006df <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006d0:	83 ec 08             	sub    $0x8,%esp
  8006d3:	ff 75 0c             	pushl  0xc(%ebp)
  8006d6:	53                   	push   %ebx
  8006d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006da:	ff d0                	call   *%eax
  8006dc:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006df:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e2:	89 f0                	mov    %esi,%eax
  8006e4:	8d 70 01             	lea    0x1(%eax),%esi
  8006e7:	8a 00                	mov    (%eax),%al
  8006e9:	0f be d8             	movsbl %al,%ebx
  8006ec:	85 db                	test   %ebx,%ebx
  8006ee:	74 24                	je     800714 <vprintfmt+0x24b>
  8006f0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006f4:	78 b8                	js     8006ae <vprintfmt+0x1e5>
  8006f6:	ff 4d e0             	decl   -0x20(%ebp)
  8006f9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006fd:	79 af                	jns    8006ae <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ff:	eb 13                	jmp    800714 <vprintfmt+0x24b>
				putch(' ', putdat);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 0c             	pushl  0xc(%ebp)
  800707:	6a 20                	push   $0x20
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	ff d0                	call   *%eax
  80070e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800711:	ff 4d e4             	decl   -0x1c(%ebp)
  800714:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800718:	7f e7                	jg     800701 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80071a:	e9 66 01 00 00       	jmp    800885 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80071f:	83 ec 08             	sub    $0x8,%esp
  800722:	ff 75 e8             	pushl  -0x18(%ebp)
  800725:	8d 45 14             	lea    0x14(%ebp),%eax
  800728:	50                   	push   %eax
  800729:	e8 3c fd ff ff       	call   80046a <getint>
  80072e:	83 c4 10             	add    $0x10,%esp
  800731:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800734:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800737:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80073a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80073d:	85 d2                	test   %edx,%edx
  80073f:	79 23                	jns    800764 <vprintfmt+0x29b>
				putch('-', putdat);
  800741:	83 ec 08             	sub    $0x8,%esp
  800744:	ff 75 0c             	pushl  0xc(%ebp)
  800747:	6a 2d                	push   $0x2d
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	ff d0                	call   *%eax
  80074e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800751:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800754:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800757:	f7 d8                	neg    %eax
  800759:	83 d2 00             	adc    $0x0,%edx
  80075c:	f7 da                	neg    %edx
  80075e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800761:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800764:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80076b:	e9 bc 00 00 00       	jmp    80082c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 e8             	pushl  -0x18(%ebp)
  800776:	8d 45 14             	lea    0x14(%ebp),%eax
  800779:	50                   	push   %eax
  80077a:	e8 84 fc ff ff       	call   800403 <getuint>
  80077f:	83 c4 10             	add    $0x10,%esp
  800782:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800785:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800788:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80078f:	e9 98 00 00 00       	jmp    80082c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800794:	83 ec 08             	sub    $0x8,%esp
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	6a 58                	push   $0x58
  80079c:	8b 45 08             	mov    0x8(%ebp),%eax
  80079f:	ff d0                	call   *%eax
  8007a1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007a4:	83 ec 08             	sub    $0x8,%esp
  8007a7:	ff 75 0c             	pushl  0xc(%ebp)
  8007aa:	6a 58                	push   $0x58
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	ff d0                	call   *%eax
  8007b1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007b4:	83 ec 08             	sub    $0x8,%esp
  8007b7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ba:	6a 58                	push   $0x58
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	ff d0                	call   *%eax
  8007c1:	83 c4 10             	add    $0x10,%esp
			break;
  8007c4:	e9 bc 00 00 00       	jmp    800885 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007c9:	83 ec 08             	sub    $0x8,%esp
  8007cc:	ff 75 0c             	pushl  0xc(%ebp)
  8007cf:	6a 30                	push   $0x30
  8007d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d4:	ff d0                	call   *%eax
  8007d6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007d9:	83 ec 08             	sub    $0x8,%esp
  8007dc:	ff 75 0c             	pushl  0xc(%ebp)
  8007df:	6a 78                	push   $0x78
  8007e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e4:	ff d0                	call   *%eax
  8007e6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ec:	83 c0 04             	add    $0x4,%eax
  8007ef:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f5:	83 e8 04             	sub    $0x4,%eax
  8007f8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800804:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80080b:	eb 1f                	jmp    80082c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80080d:	83 ec 08             	sub    $0x8,%esp
  800810:	ff 75 e8             	pushl  -0x18(%ebp)
  800813:	8d 45 14             	lea    0x14(%ebp),%eax
  800816:	50                   	push   %eax
  800817:	e8 e7 fb ff ff       	call   800403 <getuint>
  80081c:	83 c4 10             	add    $0x10,%esp
  80081f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800822:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800825:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80082c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800830:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800833:	83 ec 04             	sub    $0x4,%esp
  800836:	52                   	push   %edx
  800837:	ff 75 e4             	pushl  -0x1c(%ebp)
  80083a:	50                   	push   %eax
  80083b:	ff 75 f4             	pushl  -0xc(%ebp)
  80083e:	ff 75 f0             	pushl  -0x10(%ebp)
  800841:	ff 75 0c             	pushl  0xc(%ebp)
  800844:	ff 75 08             	pushl  0x8(%ebp)
  800847:	e8 00 fb ff ff       	call   80034c <printnum>
  80084c:	83 c4 20             	add    $0x20,%esp
			break;
  80084f:	eb 34                	jmp    800885 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800851:	83 ec 08             	sub    $0x8,%esp
  800854:	ff 75 0c             	pushl  0xc(%ebp)
  800857:	53                   	push   %ebx
  800858:	8b 45 08             	mov    0x8(%ebp),%eax
  80085b:	ff d0                	call   *%eax
  80085d:	83 c4 10             	add    $0x10,%esp
			break;
  800860:	eb 23                	jmp    800885 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800862:	83 ec 08             	sub    $0x8,%esp
  800865:	ff 75 0c             	pushl  0xc(%ebp)
  800868:	6a 25                	push   $0x25
  80086a:	8b 45 08             	mov    0x8(%ebp),%eax
  80086d:	ff d0                	call   *%eax
  80086f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800872:	ff 4d 10             	decl   0x10(%ebp)
  800875:	eb 03                	jmp    80087a <vprintfmt+0x3b1>
  800877:	ff 4d 10             	decl   0x10(%ebp)
  80087a:	8b 45 10             	mov    0x10(%ebp),%eax
  80087d:	48                   	dec    %eax
  80087e:	8a 00                	mov    (%eax),%al
  800880:	3c 25                	cmp    $0x25,%al
  800882:	75 f3                	jne    800877 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800884:	90                   	nop
		}
	}
  800885:	e9 47 fc ff ff       	jmp    8004d1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80088a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80088b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80088e:	5b                   	pop    %ebx
  80088f:	5e                   	pop    %esi
  800890:	5d                   	pop    %ebp
  800891:	c3                   	ret    

00800892 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800892:	55                   	push   %ebp
  800893:	89 e5                	mov    %esp,%ebp
  800895:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800898:	8d 45 10             	lea    0x10(%ebp),%eax
  80089b:	83 c0 04             	add    $0x4,%eax
  80089e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8008a7:	50                   	push   %eax
  8008a8:	ff 75 0c             	pushl  0xc(%ebp)
  8008ab:	ff 75 08             	pushl  0x8(%ebp)
  8008ae:	e8 16 fc ff ff       	call   8004c9 <vprintfmt>
  8008b3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008b6:	90                   	nop
  8008b7:	c9                   	leave  
  8008b8:	c3                   	ret    

008008b9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008b9:	55                   	push   %ebp
  8008ba:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bf:	8b 40 08             	mov    0x8(%eax),%eax
  8008c2:	8d 50 01             	lea    0x1(%eax),%edx
  8008c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ce:	8b 10                	mov    (%eax),%edx
  8008d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d3:	8b 40 04             	mov    0x4(%eax),%eax
  8008d6:	39 c2                	cmp    %eax,%edx
  8008d8:	73 12                	jae    8008ec <sprintputch+0x33>
		*b->buf++ = ch;
  8008da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008dd:	8b 00                	mov    (%eax),%eax
  8008df:	8d 48 01             	lea    0x1(%eax),%ecx
  8008e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e5:	89 0a                	mov    %ecx,(%edx)
  8008e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ea:	88 10                	mov    %dl,(%eax)
}
  8008ec:	90                   	nop
  8008ed:	5d                   	pop    %ebp
  8008ee:	c3                   	ret    

008008ef <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008ef:	55                   	push   %ebp
  8008f0:	89 e5                	mov    %esp,%ebp
  8008f2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800901:	8b 45 08             	mov    0x8(%ebp),%eax
  800904:	01 d0                	add    %edx,%eax
  800906:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800909:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800910:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800914:	74 06                	je     80091c <vsnprintf+0x2d>
  800916:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80091a:	7f 07                	jg     800923 <vsnprintf+0x34>
		return -E_INVAL;
  80091c:	b8 03 00 00 00       	mov    $0x3,%eax
  800921:	eb 20                	jmp    800943 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800923:	ff 75 14             	pushl  0x14(%ebp)
  800926:	ff 75 10             	pushl  0x10(%ebp)
  800929:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80092c:	50                   	push   %eax
  80092d:	68 b9 08 80 00       	push   $0x8008b9
  800932:	e8 92 fb ff ff       	call   8004c9 <vprintfmt>
  800937:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80093a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80093d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800940:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800943:	c9                   	leave  
  800944:	c3                   	ret    

00800945 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800945:	55                   	push   %ebp
  800946:	89 e5                	mov    %esp,%ebp
  800948:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80094b:	8d 45 10             	lea    0x10(%ebp),%eax
  80094e:	83 c0 04             	add    $0x4,%eax
  800951:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800954:	8b 45 10             	mov    0x10(%ebp),%eax
  800957:	ff 75 f4             	pushl  -0xc(%ebp)
  80095a:	50                   	push   %eax
  80095b:	ff 75 0c             	pushl  0xc(%ebp)
  80095e:	ff 75 08             	pushl  0x8(%ebp)
  800961:	e8 89 ff ff ff       	call   8008ef <vsnprintf>
  800966:	83 c4 10             	add    $0x10,%esp
  800969:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80096c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80096f:	c9                   	leave  
  800970:	c3                   	ret    

00800971 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800971:	55                   	push   %ebp
  800972:	89 e5                	mov    %esp,%ebp
  800974:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800977:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80097e:	eb 06                	jmp    800986 <strlen+0x15>
		n++;
  800980:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800983:	ff 45 08             	incl   0x8(%ebp)
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	8a 00                	mov    (%eax),%al
  80098b:	84 c0                	test   %al,%al
  80098d:	75 f1                	jne    800980 <strlen+0xf>
		n++;
	return n;
  80098f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800992:	c9                   	leave  
  800993:	c3                   	ret    

00800994 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800994:	55                   	push   %ebp
  800995:	89 e5                	mov    %esp,%ebp
  800997:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80099a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009a1:	eb 09                	jmp    8009ac <strnlen+0x18>
		n++;
  8009a3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009a6:	ff 45 08             	incl   0x8(%ebp)
  8009a9:	ff 4d 0c             	decl   0xc(%ebp)
  8009ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009b0:	74 09                	je     8009bb <strnlen+0x27>
  8009b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b5:	8a 00                	mov    (%eax),%al
  8009b7:	84 c0                	test   %al,%al
  8009b9:	75 e8                	jne    8009a3 <strnlen+0xf>
		n++;
	return n;
  8009bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009be:	c9                   	leave  
  8009bf:	c3                   	ret    

008009c0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009c0:	55                   	push   %ebp
  8009c1:	89 e5                	mov    %esp,%ebp
  8009c3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009cc:	90                   	nop
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	8d 50 01             	lea    0x1(%eax),%edx
  8009d3:	89 55 08             	mov    %edx,0x8(%ebp)
  8009d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009dc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009df:	8a 12                	mov    (%edx),%dl
  8009e1:	88 10                	mov    %dl,(%eax)
  8009e3:	8a 00                	mov    (%eax),%al
  8009e5:	84 c0                	test   %al,%al
  8009e7:	75 e4                	jne    8009cd <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ec:	c9                   	leave  
  8009ed:	c3                   	ret    

008009ee <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009ee:	55                   	push   %ebp
  8009ef:	89 e5                	mov    %esp,%ebp
  8009f1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a01:	eb 1f                	jmp    800a22 <strncpy+0x34>
		*dst++ = *src;
  800a03:	8b 45 08             	mov    0x8(%ebp),%eax
  800a06:	8d 50 01             	lea    0x1(%eax),%edx
  800a09:	89 55 08             	mov    %edx,0x8(%ebp)
  800a0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a0f:	8a 12                	mov    (%edx),%dl
  800a11:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a16:	8a 00                	mov    (%eax),%al
  800a18:	84 c0                	test   %al,%al
  800a1a:	74 03                	je     800a1f <strncpy+0x31>
			src++;
  800a1c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a1f:	ff 45 fc             	incl   -0x4(%ebp)
  800a22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a25:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a28:	72 d9                	jb     800a03 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a2d:	c9                   	leave  
  800a2e:	c3                   	ret    

00800a2f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a2f:	55                   	push   %ebp
  800a30:	89 e5                	mov    %esp,%ebp
  800a32:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a3f:	74 30                	je     800a71 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a41:	eb 16                	jmp    800a59 <strlcpy+0x2a>
			*dst++ = *src++;
  800a43:	8b 45 08             	mov    0x8(%ebp),%eax
  800a46:	8d 50 01             	lea    0x1(%eax),%edx
  800a49:	89 55 08             	mov    %edx,0x8(%ebp)
  800a4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a52:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a55:	8a 12                	mov    (%edx),%dl
  800a57:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a59:	ff 4d 10             	decl   0x10(%ebp)
  800a5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a60:	74 09                	je     800a6b <strlcpy+0x3c>
  800a62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a65:	8a 00                	mov    (%eax),%al
  800a67:	84 c0                	test   %al,%al
  800a69:	75 d8                	jne    800a43 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a71:	8b 55 08             	mov    0x8(%ebp),%edx
  800a74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a77:	29 c2                	sub    %eax,%edx
  800a79:	89 d0                	mov    %edx,%eax
}
  800a7b:	c9                   	leave  
  800a7c:	c3                   	ret    

00800a7d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a7d:	55                   	push   %ebp
  800a7e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a80:	eb 06                	jmp    800a88 <strcmp+0xb>
		p++, q++;
  800a82:	ff 45 08             	incl   0x8(%ebp)
  800a85:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a88:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8b:	8a 00                	mov    (%eax),%al
  800a8d:	84 c0                	test   %al,%al
  800a8f:	74 0e                	je     800a9f <strcmp+0x22>
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	8a 10                	mov    (%eax),%dl
  800a96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a99:	8a 00                	mov    (%eax),%al
  800a9b:	38 c2                	cmp    %al,%dl
  800a9d:	74 e3                	je     800a82 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa2:	8a 00                	mov    (%eax),%al
  800aa4:	0f b6 d0             	movzbl %al,%edx
  800aa7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aaa:	8a 00                	mov    (%eax),%al
  800aac:	0f b6 c0             	movzbl %al,%eax
  800aaf:	29 c2                	sub    %eax,%edx
  800ab1:	89 d0                	mov    %edx,%eax
}
  800ab3:	5d                   	pop    %ebp
  800ab4:	c3                   	ret    

00800ab5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ab5:	55                   	push   %ebp
  800ab6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ab8:	eb 09                	jmp    800ac3 <strncmp+0xe>
		n--, p++, q++;
  800aba:	ff 4d 10             	decl   0x10(%ebp)
  800abd:	ff 45 08             	incl   0x8(%ebp)
  800ac0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ac3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ac7:	74 17                	je     800ae0 <strncmp+0x2b>
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	8a 00                	mov    (%eax),%al
  800ace:	84 c0                	test   %al,%al
  800ad0:	74 0e                	je     800ae0 <strncmp+0x2b>
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	8a 10                	mov    (%eax),%dl
  800ad7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ada:	8a 00                	mov    (%eax),%al
  800adc:	38 c2                	cmp    %al,%dl
  800ade:	74 da                	je     800aba <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ae0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ae4:	75 07                	jne    800aed <strncmp+0x38>
		return 0;
  800ae6:	b8 00 00 00 00       	mov    $0x0,%eax
  800aeb:	eb 14                	jmp    800b01 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	8a 00                	mov    (%eax),%al
  800af2:	0f b6 d0             	movzbl %al,%edx
  800af5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af8:	8a 00                	mov    (%eax),%al
  800afa:	0f b6 c0             	movzbl %al,%eax
  800afd:	29 c2                	sub    %eax,%edx
  800aff:	89 d0                	mov    %edx,%eax
}
  800b01:	5d                   	pop    %ebp
  800b02:	c3                   	ret    

00800b03 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b03:	55                   	push   %ebp
  800b04:	89 e5                	mov    %esp,%ebp
  800b06:	83 ec 04             	sub    $0x4,%esp
  800b09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b0f:	eb 12                	jmp    800b23 <strchr+0x20>
		if (*s == c)
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	8a 00                	mov    (%eax),%al
  800b16:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b19:	75 05                	jne    800b20 <strchr+0x1d>
			return (char *) s;
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	eb 11                	jmp    800b31 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b20:	ff 45 08             	incl   0x8(%ebp)
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	8a 00                	mov    (%eax),%al
  800b28:	84 c0                	test   %al,%al
  800b2a:	75 e5                	jne    800b11 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b31:	c9                   	leave  
  800b32:	c3                   	ret    

00800b33 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b33:	55                   	push   %ebp
  800b34:	89 e5                	mov    %esp,%ebp
  800b36:	83 ec 04             	sub    $0x4,%esp
  800b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b3f:	eb 0d                	jmp    800b4e <strfind+0x1b>
		if (*s == c)
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8a 00                	mov    (%eax),%al
  800b46:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b49:	74 0e                	je     800b59 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b4b:	ff 45 08             	incl   0x8(%ebp)
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	8a 00                	mov    (%eax),%al
  800b53:	84 c0                	test   %al,%al
  800b55:	75 ea                	jne    800b41 <strfind+0xe>
  800b57:	eb 01                	jmp    800b5a <strfind+0x27>
		if (*s == c)
			break;
  800b59:	90                   	nop
	return (char *) s;
  800b5a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b5d:	c9                   	leave  
  800b5e:	c3                   	ret    

00800b5f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b5f:	55                   	push   %ebp
  800b60:	89 e5                	mov    %esp,%ebp
  800b62:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
  800b68:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b71:	eb 0e                	jmp    800b81 <memset+0x22>
		*p++ = c;
  800b73:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b76:	8d 50 01             	lea    0x1(%eax),%edx
  800b79:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b7f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b81:	ff 4d f8             	decl   -0x8(%ebp)
  800b84:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b88:	79 e9                	jns    800b73 <memset+0x14>
		*p++ = c;

	return v;
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b8d:	c9                   	leave  
  800b8e:	c3                   	ret    

00800b8f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ba1:	eb 16                	jmp    800bb9 <memcpy+0x2a>
		*d++ = *s++;
  800ba3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ba6:	8d 50 01             	lea    0x1(%eax),%edx
  800ba9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800baf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bb5:	8a 12                	mov    (%edx),%dl
  800bb7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bbf:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc2:	85 c0                	test   %eax,%eax
  800bc4:	75 dd                	jne    800ba3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bc9:	c9                   	leave  
  800bca:	c3                   	ret    

00800bcb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bcb:	55                   	push   %ebp
  800bcc:	89 e5                	mov    %esp,%ebp
  800bce:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800bd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800be3:	73 50                	jae    800c35 <memmove+0x6a>
  800be5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800be8:	8b 45 10             	mov    0x10(%ebp),%eax
  800beb:	01 d0                	add    %edx,%eax
  800bed:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bf0:	76 43                	jbe    800c35 <memmove+0x6a>
		s += n;
  800bf2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bf8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bfe:	eb 10                	jmp    800c10 <memmove+0x45>
			*--d = *--s;
  800c00:	ff 4d f8             	decl   -0x8(%ebp)
  800c03:	ff 4d fc             	decl   -0x4(%ebp)
  800c06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c09:	8a 10                	mov    (%eax),%dl
  800c0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c10:	8b 45 10             	mov    0x10(%ebp),%eax
  800c13:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c16:	89 55 10             	mov    %edx,0x10(%ebp)
  800c19:	85 c0                	test   %eax,%eax
  800c1b:	75 e3                	jne    800c00 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c1d:	eb 23                	jmp    800c42 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c22:	8d 50 01             	lea    0x1(%eax),%edx
  800c25:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c28:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c2b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c2e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c31:	8a 12                	mov    (%edx),%dl
  800c33:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c35:	8b 45 10             	mov    0x10(%ebp),%eax
  800c38:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c3b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c3e:	85 c0                	test   %eax,%eax
  800c40:	75 dd                	jne    800c1f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c45:	c9                   	leave  
  800c46:	c3                   	ret    

00800c47 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c47:	55                   	push   %ebp
  800c48:	89 e5                	mov    %esp,%ebp
  800c4a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c56:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c59:	eb 2a                	jmp    800c85 <memcmp+0x3e>
		if (*s1 != *s2)
  800c5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c5e:	8a 10                	mov    (%eax),%dl
  800c60:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c63:	8a 00                	mov    (%eax),%al
  800c65:	38 c2                	cmp    %al,%dl
  800c67:	74 16                	je     800c7f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c6c:	8a 00                	mov    (%eax),%al
  800c6e:	0f b6 d0             	movzbl %al,%edx
  800c71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c74:	8a 00                	mov    (%eax),%al
  800c76:	0f b6 c0             	movzbl %al,%eax
  800c79:	29 c2                	sub    %eax,%edx
  800c7b:	89 d0                	mov    %edx,%eax
  800c7d:	eb 18                	jmp    800c97 <memcmp+0x50>
		s1++, s2++;
  800c7f:	ff 45 fc             	incl   -0x4(%ebp)
  800c82:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c85:	8b 45 10             	mov    0x10(%ebp),%eax
  800c88:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c8b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c8e:	85 c0                	test   %eax,%eax
  800c90:	75 c9                	jne    800c5b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c97:	c9                   	leave  
  800c98:	c3                   	ret    

00800c99 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
  800c9c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800ca2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca5:	01 d0                	add    %edx,%eax
  800ca7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800caa:	eb 15                	jmp    800cc1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	0f b6 d0             	movzbl %al,%edx
  800cb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb7:	0f b6 c0             	movzbl %al,%eax
  800cba:	39 c2                	cmp    %eax,%edx
  800cbc:	74 0d                	je     800ccb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cbe:	ff 45 08             	incl   0x8(%ebp)
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800cc7:	72 e3                	jb     800cac <memfind+0x13>
  800cc9:	eb 01                	jmp    800ccc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ccb:	90                   	nop
	return (void *) s;
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ccf:	c9                   	leave  
  800cd0:	c3                   	ret    

00800cd1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cd1:	55                   	push   %ebp
  800cd2:	89 e5                	mov    %esp,%ebp
  800cd4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800cd7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cde:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ce5:	eb 03                	jmp    800cea <strtol+0x19>
		s++;
  800ce7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	3c 20                	cmp    $0x20,%al
  800cf1:	74 f4                	je     800ce7 <strtol+0x16>
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	8a 00                	mov    (%eax),%al
  800cf8:	3c 09                	cmp    $0x9,%al
  800cfa:	74 eb                	je     800ce7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	8a 00                	mov    (%eax),%al
  800d01:	3c 2b                	cmp    $0x2b,%al
  800d03:	75 05                	jne    800d0a <strtol+0x39>
		s++;
  800d05:	ff 45 08             	incl   0x8(%ebp)
  800d08:	eb 13                	jmp    800d1d <strtol+0x4c>
	else if (*s == '-')
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	8a 00                	mov    (%eax),%al
  800d0f:	3c 2d                	cmp    $0x2d,%al
  800d11:	75 0a                	jne    800d1d <strtol+0x4c>
		s++, neg = 1;
  800d13:	ff 45 08             	incl   0x8(%ebp)
  800d16:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d21:	74 06                	je     800d29 <strtol+0x58>
  800d23:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d27:	75 20                	jne    800d49 <strtol+0x78>
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	3c 30                	cmp    $0x30,%al
  800d30:	75 17                	jne    800d49 <strtol+0x78>
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	40                   	inc    %eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	3c 78                	cmp    $0x78,%al
  800d3a:	75 0d                	jne    800d49 <strtol+0x78>
		s += 2, base = 16;
  800d3c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d40:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d47:	eb 28                	jmp    800d71 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4d:	75 15                	jne    800d64 <strtol+0x93>
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3c 30                	cmp    $0x30,%al
  800d56:	75 0c                	jne    800d64 <strtol+0x93>
		s++, base = 8;
  800d58:	ff 45 08             	incl   0x8(%ebp)
  800d5b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d62:	eb 0d                	jmp    800d71 <strtol+0xa0>
	else if (base == 0)
  800d64:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d68:	75 07                	jne    800d71 <strtol+0xa0>
		base = 10;
  800d6a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	8a 00                	mov    (%eax),%al
  800d76:	3c 2f                	cmp    $0x2f,%al
  800d78:	7e 19                	jle    800d93 <strtol+0xc2>
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	3c 39                	cmp    $0x39,%al
  800d81:	7f 10                	jg     800d93 <strtol+0xc2>
			dig = *s - '0';
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	8a 00                	mov    (%eax),%al
  800d88:	0f be c0             	movsbl %al,%eax
  800d8b:	83 e8 30             	sub    $0x30,%eax
  800d8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d91:	eb 42                	jmp    800dd5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	3c 60                	cmp    $0x60,%al
  800d9a:	7e 19                	jle    800db5 <strtol+0xe4>
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	3c 7a                	cmp    $0x7a,%al
  800da3:	7f 10                	jg     800db5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	0f be c0             	movsbl %al,%eax
  800dad:	83 e8 57             	sub    $0x57,%eax
  800db0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800db3:	eb 20                	jmp    800dd5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	8a 00                	mov    (%eax),%al
  800dba:	3c 40                	cmp    $0x40,%al
  800dbc:	7e 39                	jle    800df7 <strtol+0x126>
  800dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	3c 5a                	cmp    $0x5a,%al
  800dc5:	7f 30                	jg     800df7 <strtol+0x126>
			dig = *s - 'A' + 10;
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	0f be c0             	movsbl %al,%eax
  800dcf:	83 e8 37             	sub    $0x37,%eax
  800dd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dd8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ddb:	7d 19                	jge    800df6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ddd:	ff 45 08             	incl   0x8(%ebp)
  800de0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de3:	0f af 45 10          	imul   0x10(%ebp),%eax
  800de7:	89 c2                	mov    %eax,%edx
  800de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dec:	01 d0                	add    %edx,%eax
  800dee:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800df1:	e9 7b ff ff ff       	jmp    800d71 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800df6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800df7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dfb:	74 08                	je     800e05 <strtol+0x134>
		*endptr = (char *) s;
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	8b 55 08             	mov    0x8(%ebp),%edx
  800e03:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e05:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e09:	74 07                	je     800e12 <strtol+0x141>
  800e0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0e:	f7 d8                	neg    %eax
  800e10:	eb 03                	jmp    800e15 <strtol+0x144>
  800e12:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e15:	c9                   	leave  
  800e16:	c3                   	ret    

00800e17 <ltostr>:

void
ltostr(long value, char *str)
{
  800e17:	55                   	push   %ebp
  800e18:	89 e5                	mov    %esp,%ebp
  800e1a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e1d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e24:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e2b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e2f:	79 13                	jns    800e44 <ltostr+0x2d>
	{
		neg = 1;
  800e31:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e3e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e41:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e4c:	99                   	cltd   
  800e4d:	f7 f9                	idiv   %ecx
  800e4f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e55:	8d 50 01             	lea    0x1(%eax),%edx
  800e58:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e5b:	89 c2                	mov    %eax,%edx
  800e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e60:	01 d0                	add    %edx,%eax
  800e62:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e65:	83 c2 30             	add    $0x30,%edx
  800e68:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e6d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e72:	f7 e9                	imul   %ecx
  800e74:	c1 fa 02             	sar    $0x2,%edx
  800e77:	89 c8                	mov    %ecx,%eax
  800e79:	c1 f8 1f             	sar    $0x1f,%eax
  800e7c:	29 c2                	sub    %eax,%edx
  800e7e:	89 d0                	mov    %edx,%eax
  800e80:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e86:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e8b:	f7 e9                	imul   %ecx
  800e8d:	c1 fa 02             	sar    $0x2,%edx
  800e90:	89 c8                	mov    %ecx,%eax
  800e92:	c1 f8 1f             	sar    $0x1f,%eax
  800e95:	29 c2                	sub    %eax,%edx
  800e97:	89 d0                	mov    %edx,%eax
  800e99:	c1 e0 02             	shl    $0x2,%eax
  800e9c:	01 d0                	add    %edx,%eax
  800e9e:	01 c0                	add    %eax,%eax
  800ea0:	29 c1                	sub    %eax,%ecx
  800ea2:	89 ca                	mov    %ecx,%edx
  800ea4:	85 d2                	test   %edx,%edx
  800ea6:	75 9c                	jne    800e44 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ea8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800eaf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb2:	48                   	dec    %eax
  800eb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800eb6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800eba:	74 3d                	je     800ef9 <ltostr+0xe2>
		start = 1 ;
  800ebc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ec3:	eb 34                	jmp    800ef9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ec5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecb:	01 d0                	add    %edx,%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800ed2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed8:	01 c2                	add    %eax,%edx
  800eda:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800edd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee0:	01 c8                	add    %ecx,%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ee6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ee9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eec:	01 c2                	add    %eax,%edx
  800eee:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ef1:	88 02                	mov    %al,(%edx)
		start++ ;
  800ef3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ef6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ef9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800efc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eff:	7c c4                	jl     800ec5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f01:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f07:	01 d0                	add    %edx,%eax
  800f09:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f0c:	90                   	nop
  800f0d:	c9                   	leave  
  800f0e:	c3                   	ret    

00800f0f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f0f:	55                   	push   %ebp
  800f10:	89 e5                	mov    %esp,%ebp
  800f12:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f15:	ff 75 08             	pushl  0x8(%ebp)
  800f18:	e8 54 fa ff ff       	call   800971 <strlen>
  800f1d:	83 c4 04             	add    $0x4,%esp
  800f20:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f23:	ff 75 0c             	pushl  0xc(%ebp)
  800f26:	e8 46 fa ff ff       	call   800971 <strlen>
  800f2b:	83 c4 04             	add    $0x4,%esp
  800f2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f3f:	eb 17                	jmp    800f58 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f41:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f44:	8b 45 10             	mov    0x10(%ebp),%eax
  800f47:	01 c2                	add    %eax,%edx
  800f49:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	01 c8                	add    %ecx,%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f55:	ff 45 fc             	incl   -0x4(%ebp)
  800f58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f5b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f5e:	7c e1                	jl     800f41 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f60:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f67:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f6e:	eb 1f                	jmp    800f8f <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f73:	8d 50 01             	lea    0x1(%eax),%edx
  800f76:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f79:	89 c2                	mov    %eax,%edx
  800f7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7e:	01 c2                	add    %eax,%edx
  800f80:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f86:	01 c8                	add    %ecx,%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f8c:	ff 45 f8             	incl   -0x8(%ebp)
  800f8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f92:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f95:	7c d9                	jl     800f70 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f97:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9d:	01 d0                	add    %edx,%eax
  800f9f:	c6 00 00             	movb   $0x0,(%eax)
}
  800fa2:	90                   	nop
  800fa3:	c9                   	leave  
  800fa4:	c3                   	ret    

00800fa5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fa5:	55                   	push   %ebp
  800fa6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fa8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb4:	8b 00                	mov    (%eax),%eax
  800fb6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc0:	01 d0                	add    %edx,%eax
  800fc2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fc8:	eb 0c                	jmp    800fd6 <strsplit+0x31>
			*string++ = 0;
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	8d 50 01             	lea    0x1(%eax),%edx
  800fd0:	89 55 08             	mov    %edx,0x8(%ebp)
  800fd3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	8a 00                	mov    (%eax),%al
  800fdb:	84 c0                	test   %al,%al
  800fdd:	74 18                	je     800ff7 <strsplit+0x52>
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	8a 00                	mov    (%eax),%al
  800fe4:	0f be c0             	movsbl %al,%eax
  800fe7:	50                   	push   %eax
  800fe8:	ff 75 0c             	pushl  0xc(%ebp)
  800feb:	e8 13 fb ff ff       	call   800b03 <strchr>
  800ff0:	83 c4 08             	add    $0x8,%esp
  800ff3:	85 c0                	test   %eax,%eax
  800ff5:	75 d3                	jne    800fca <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffa:	8a 00                	mov    (%eax),%al
  800ffc:	84 c0                	test   %al,%al
  800ffe:	74 5a                	je     80105a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801000:	8b 45 14             	mov    0x14(%ebp),%eax
  801003:	8b 00                	mov    (%eax),%eax
  801005:	83 f8 0f             	cmp    $0xf,%eax
  801008:	75 07                	jne    801011 <strsplit+0x6c>
		{
			return 0;
  80100a:	b8 00 00 00 00       	mov    $0x0,%eax
  80100f:	eb 66                	jmp    801077 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801011:	8b 45 14             	mov    0x14(%ebp),%eax
  801014:	8b 00                	mov    (%eax),%eax
  801016:	8d 48 01             	lea    0x1(%eax),%ecx
  801019:	8b 55 14             	mov    0x14(%ebp),%edx
  80101c:	89 0a                	mov    %ecx,(%edx)
  80101e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801025:	8b 45 10             	mov    0x10(%ebp),%eax
  801028:	01 c2                	add    %eax,%edx
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80102f:	eb 03                	jmp    801034 <strsplit+0x8f>
			string++;
  801031:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	84 c0                	test   %al,%al
  80103b:	74 8b                	je     800fc8 <strsplit+0x23>
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	8a 00                	mov    (%eax),%al
  801042:	0f be c0             	movsbl %al,%eax
  801045:	50                   	push   %eax
  801046:	ff 75 0c             	pushl  0xc(%ebp)
  801049:	e8 b5 fa ff ff       	call   800b03 <strchr>
  80104e:	83 c4 08             	add    $0x8,%esp
  801051:	85 c0                	test   %eax,%eax
  801053:	74 dc                	je     801031 <strsplit+0x8c>
			string++;
	}
  801055:	e9 6e ff ff ff       	jmp    800fc8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80105a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80105b:	8b 45 14             	mov    0x14(%ebp),%eax
  80105e:	8b 00                	mov    (%eax),%eax
  801060:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801067:	8b 45 10             	mov    0x10(%ebp),%eax
  80106a:	01 d0                	add    %edx,%eax
  80106c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801072:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801077:	c9                   	leave  
  801078:	c3                   	ret    

00801079 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801079:	55                   	push   %ebp
  80107a:	89 e5                	mov    %esp,%ebp
  80107c:	83 ec 18             	sub    $0x18,%esp
  80107f:	8b 45 10             	mov    0x10(%ebp),%eax
  801082:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801085:	83 ec 04             	sub    $0x4,%esp
  801088:	68 d0 21 80 00       	push   $0x8021d0
  80108d:	6a 17                	push   $0x17
  80108f:	68 ef 21 80 00       	push   $0x8021ef
  801094:	e8 8a 08 00 00       	call   801923 <_panic>

00801099 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801099:	55                   	push   %ebp
  80109a:	89 e5                	mov    %esp,%ebp
  80109c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80109f:	83 ec 04             	sub    $0x4,%esp
  8010a2:	68 fb 21 80 00       	push   $0x8021fb
  8010a7:	6a 2f                	push   $0x2f
  8010a9:	68 ef 21 80 00       	push   $0x8021ef
  8010ae:	e8 70 08 00 00       	call   801923 <_panic>

008010b3 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
  8010b6:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8010b9:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8010c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010c6:	01 d0                	add    %edx,%eax
  8010c8:	48                   	dec    %eax
  8010c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8010cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8010d4:	f7 75 ec             	divl   -0x14(%ebp)
  8010d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010da:	29 d0                	sub    %edx,%eax
  8010dc:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	c1 e8 0c             	shr    $0xc,%eax
  8010e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8010e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8010ef:	e9 c8 00 00 00       	jmp    8011bc <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8010f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8010fb:	eb 27                	jmp    801124 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8010fd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801100:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801103:	01 c2                	add    %eax,%edx
  801105:	89 d0                	mov    %edx,%eax
  801107:	01 c0                	add    %eax,%eax
  801109:	01 d0                	add    %edx,%eax
  80110b:	c1 e0 02             	shl    $0x2,%eax
  80110e:	05 48 30 80 00       	add    $0x803048,%eax
  801113:	8b 00                	mov    (%eax),%eax
  801115:	85 c0                	test   %eax,%eax
  801117:	74 08                	je     801121 <malloc+0x6e>
            	i += j;
  801119:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80111c:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80111f:	eb 0b                	jmp    80112c <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801121:	ff 45 f0             	incl   -0x10(%ebp)
  801124:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801127:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80112a:	72 d1                	jb     8010fd <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80112c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80112f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801132:	0f 85 81 00 00 00    	jne    8011b9 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801138:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80113b:	05 00 00 08 00       	add    $0x80000,%eax
  801140:	c1 e0 0c             	shl    $0xc,%eax
  801143:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801146:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80114d:	eb 1f                	jmp    80116e <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80114f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801152:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801155:	01 c2                	add    %eax,%edx
  801157:	89 d0                	mov    %edx,%eax
  801159:	01 c0                	add    %eax,%eax
  80115b:	01 d0                	add    %edx,%eax
  80115d:	c1 e0 02             	shl    $0x2,%eax
  801160:	05 48 30 80 00       	add    $0x803048,%eax
  801165:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80116b:	ff 45 f0             	incl   -0x10(%ebp)
  80116e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801171:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801174:	72 d9                	jb     80114f <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801176:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801179:	89 d0                	mov    %edx,%eax
  80117b:	01 c0                	add    %eax,%eax
  80117d:	01 d0                	add    %edx,%eax
  80117f:	c1 e0 02             	shl    $0x2,%eax
  801182:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801188:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80118b:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80118d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801190:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801193:	89 c8                	mov    %ecx,%eax
  801195:	01 c0                	add    %eax,%eax
  801197:	01 c8                	add    %ecx,%eax
  801199:	c1 e0 02             	shl    $0x2,%eax
  80119c:	05 44 30 80 00       	add    $0x803044,%eax
  8011a1:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8011a3:	83 ec 08             	sub    $0x8,%esp
  8011a6:	ff 75 08             	pushl  0x8(%ebp)
  8011a9:	ff 75 e0             	pushl  -0x20(%ebp)
  8011ac:	e8 2b 03 00 00       	call   8014dc <sys_allocateMem>
  8011b1:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8011b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011b7:	eb 19                	jmp    8011d2 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8011b9:	ff 45 f4             	incl   -0xc(%ebp)
  8011bc:	a1 04 30 80 00       	mov    0x803004,%eax
  8011c1:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8011c4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011c7:	0f 83 27 ff ff ff    	jae    8010f4 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8011cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011d2:	c9                   	leave  
  8011d3:	c3                   	ret    

008011d4 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8011d4:	55                   	push   %ebp
  8011d5:	89 e5                	mov    %esp,%ebp
  8011d7:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8011da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011de:	0f 84 e5 00 00 00    	je     8012c9 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8011e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8011ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011ed:	05 00 00 00 80       	add    $0x80000000,%eax
  8011f2:	c1 e8 0c             	shr    $0xc,%eax
  8011f5:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8011f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011fb:	89 d0                	mov    %edx,%eax
  8011fd:	01 c0                	add    %eax,%eax
  8011ff:	01 d0                	add    %edx,%eax
  801201:	c1 e0 02             	shl    $0x2,%eax
  801204:	05 40 30 80 00       	add    $0x803040,%eax
  801209:	8b 00                	mov    (%eax),%eax
  80120b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80120e:	0f 85 b8 00 00 00    	jne    8012cc <free+0xf8>
  801214:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801217:	89 d0                	mov    %edx,%eax
  801219:	01 c0                	add    %eax,%eax
  80121b:	01 d0                	add    %edx,%eax
  80121d:	c1 e0 02             	shl    $0x2,%eax
  801220:	05 48 30 80 00       	add    $0x803048,%eax
  801225:	8b 00                	mov    (%eax),%eax
  801227:	85 c0                	test   %eax,%eax
  801229:	0f 84 9d 00 00 00    	je     8012cc <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80122f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801232:	89 d0                	mov    %edx,%eax
  801234:	01 c0                	add    %eax,%eax
  801236:	01 d0                	add    %edx,%eax
  801238:	c1 e0 02             	shl    $0x2,%eax
  80123b:	05 44 30 80 00       	add    $0x803044,%eax
  801240:	8b 00                	mov    (%eax),%eax
  801242:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801245:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801248:	c1 e0 0c             	shl    $0xc,%eax
  80124b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  80124e:	83 ec 08             	sub    $0x8,%esp
  801251:	ff 75 e4             	pushl  -0x1c(%ebp)
  801254:	ff 75 f0             	pushl  -0x10(%ebp)
  801257:	e8 64 02 00 00       	call   8014c0 <sys_freeMem>
  80125c:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80125f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801266:	eb 57                	jmp    8012bf <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801268:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80126b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80126e:	01 c2                	add    %eax,%edx
  801270:	89 d0                	mov    %edx,%eax
  801272:	01 c0                	add    %eax,%eax
  801274:	01 d0                	add    %edx,%eax
  801276:	c1 e0 02             	shl    $0x2,%eax
  801279:	05 48 30 80 00       	add    $0x803048,%eax
  80127e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801284:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801287:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80128a:	01 c2                	add    %eax,%edx
  80128c:	89 d0                	mov    %edx,%eax
  80128e:	01 c0                	add    %eax,%eax
  801290:	01 d0                	add    %edx,%eax
  801292:	c1 e0 02             	shl    $0x2,%eax
  801295:	05 40 30 80 00       	add    $0x803040,%eax
  80129a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8012a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012a6:	01 c2                	add    %eax,%edx
  8012a8:	89 d0                	mov    %edx,%eax
  8012aa:	01 c0                	add    %eax,%eax
  8012ac:	01 d0                	add    %edx,%eax
  8012ae:	c1 e0 02             	shl    $0x2,%eax
  8012b1:	05 44 30 80 00       	add    $0x803044,%eax
  8012b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8012bc:	ff 45 f4             	incl   -0xc(%ebp)
  8012bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8012c5:	7c a1                	jl     801268 <free+0x94>
  8012c7:	eb 04                	jmp    8012cd <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8012c9:	90                   	nop
  8012ca:	eb 01                	jmp    8012cd <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8012cc:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
  8012d2:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8012d5:	83 ec 04             	sub    $0x4,%esp
  8012d8:	68 18 22 80 00       	push   $0x802218
  8012dd:	68 ae 00 00 00       	push   $0xae
  8012e2:	68 ef 21 80 00       	push   $0x8021ef
  8012e7:	e8 37 06 00 00       	call   801923 <_panic>

008012ec <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
  8012ef:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8012f2:	83 ec 04             	sub    $0x4,%esp
  8012f5:	68 38 22 80 00       	push   $0x802238
  8012fa:	68 ca 00 00 00       	push   $0xca
  8012ff:	68 ef 21 80 00       	push   $0x8021ef
  801304:	e8 1a 06 00 00       	call   801923 <_panic>

00801309 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
  80130c:	57                   	push   %edi
  80130d:	56                   	push   %esi
  80130e:	53                   	push   %ebx
  80130f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	8b 55 0c             	mov    0xc(%ebp),%edx
  801318:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80131b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80131e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801321:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801324:	cd 30                	int    $0x30
  801326:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801329:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80132c:	83 c4 10             	add    $0x10,%esp
  80132f:	5b                   	pop    %ebx
  801330:	5e                   	pop    %esi
  801331:	5f                   	pop    %edi
  801332:	5d                   	pop    %ebp
  801333:	c3                   	ret    

00801334 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
  801337:	83 ec 04             	sub    $0x4,%esp
  80133a:	8b 45 10             	mov    0x10(%ebp),%eax
  80133d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801340:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	52                   	push   %edx
  80134c:	ff 75 0c             	pushl  0xc(%ebp)
  80134f:	50                   	push   %eax
  801350:	6a 00                	push   $0x0
  801352:	e8 b2 ff ff ff       	call   801309 <syscall>
  801357:	83 c4 18             	add    $0x18,%esp
}
  80135a:	90                   	nop
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <sys_cgetc>:

int
sys_cgetc(void)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 01                	push   $0x1
  80136c:	e8 98 ff ff ff       	call   801309 <syscall>
  801371:	83 c4 18             	add    $0x18,%esp
}
  801374:	c9                   	leave  
  801375:	c3                   	ret    

00801376 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	50                   	push   %eax
  801385:	6a 05                	push   $0x5
  801387:	e8 7d ff ff ff       	call   801309 <syscall>
  80138c:	83 c4 18             	add    $0x18,%esp
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 02                	push   $0x2
  8013a0:	e8 64 ff ff ff       	call   801309 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 03                	push   $0x3
  8013b9:	e8 4b ff ff ff       	call   801309 <syscall>
  8013be:	83 c4 18             	add    $0x18,%esp
}
  8013c1:	c9                   	leave  
  8013c2:	c3                   	ret    

008013c3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013c3:	55                   	push   %ebp
  8013c4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 04                	push   $0x4
  8013d2:	e8 32 ff ff ff       	call   801309 <syscall>
  8013d7:	83 c4 18             	add    $0x18,%esp
}
  8013da:	c9                   	leave  
  8013db:	c3                   	ret    

008013dc <sys_env_exit>:


void sys_env_exit(void)
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 06                	push   $0x6
  8013eb:	e8 19 ff ff ff       	call   801309 <syscall>
  8013f0:	83 c4 18             	add    $0x18,%esp
}
  8013f3:	90                   	nop
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	52                   	push   %edx
  801406:	50                   	push   %eax
  801407:	6a 07                	push   $0x7
  801409:	e8 fb fe ff ff       	call   801309 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
  801416:	56                   	push   %esi
  801417:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801418:	8b 75 18             	mov    0x18(%ebp),%esi
  80141b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80141e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801421:	8b 55 0c             	mov    0xc(%ebp),%edx
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	56                   	push   %esi
  801428:	53                   	push   %ebx
  801429:	51                   	push   %ecx
  80142a:	52                   	push   %edx
  80142b:	50                   	push   %eax
  80142c:	6a 08                	push   $0x8
  80142e:	e8 d6 fe ff ff       	call   801309 <syscall>
  801433:	83 c4 18             	add    $0x18,%esp
}
  801436:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801439:	5b                   	pop    %ebx
  80143a:	5e                   	pop    %esi
  80143b:	5d                   	pop    %ebp
  80143c:	c3                   	ret    

0080143d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801440:	8b 55 0c             	mov    0xc(%ebp),%edx
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	52                   	push   %edx
  80144d:	50                   	push   %eax
  80144e:	6a 09                	push   $0x9
  801450:	e8 b4 fe ff ff       	call   801309 <syscall>
  801455:	83 c4 18             	add    $0x18,%esp
}
  801458:	c9                   	leave  
  801459:	c3                   	ret    

0080145a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80145a:	55                   	push   %ebp
  80145b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	ff 75 0c             	pushl  0xc(%ebp)
  801466:	ff 75 08             	pushl  0x8(%ebp)
  801469:	6a 0a                	push   $0xa
  80146b:	e8 99 fe ff ff       	call   801309 <syscall>
  801470:	83 c4 18             	add    $0x18,%esp
}
  801473:	c9                   	leave  
  801474:	c3                   	ret    

00801475 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801475:	55                   	push   %ebp
  801476:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 0b                	push   $0xb
  801484:	e8 80 fe ff ff       	call   801309 <syscall>
  801489:	83 c4 18             	add    $0x18,%esp
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 0c                	push   $0xc
  80149d:	e8 67 fe ff ff       	call   801309 <syscall>
  8014a2:	83 c4 18             	add    $0x18,%esp
}
  8014a5:	c9                   	leave  
  8014a6:	c3                   	ret    

008014a7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014a7:	55                   	push   %ebp
  8014a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 0d                	push   $0xd
  8014b6:	e8 4e fe ff ff       	call   801309 <syscall>
  8014bb:	83 c4 18             	add    $0x18,%esp
}
  8014be:	c9                   	leave  
  8014bf:	c3                   	ret    

008014c0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	ff 75 0c             	pushl  0xc(%ebp)
  8014cc:	ff 75 08             	pushl  0x8(%ebp)
  8014cf:	6a 11                	push   $0x11
  8014d1:	e8 33 fe ff ff       	call   801309 <syscall>
  8014d6:	83 c4 18             	add    $0x18,%esp
	return;
  8014d9:	90                   	nop
}
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	ff 75 0c             	pushl  0xc(%ebp)
  8014e8:	ff 75 08             	pushl  0x8(%ebp)
  8014eb:	6a 12                	push   $0x12
  8014ed:	e8 17 fe ff ff       	call   801309 <syscall>
  8014f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f5:	90                   	nop
}
  8014f6:	c9                   	leave  
  8014f7:	c3                   	ret    

008014f8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8014f8:	55                   	push   %ebp
  8014f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 0e                	push   $0xe
  801507:	e8 fd fd ff ff       	call   801309 <syscall>
  80150c:	83 c4 18             	add    $0x18,%esp
}
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	ff 75 08             	pushl  0x8(%ebp)
  80151f:	6a 0f                	push   $0xf
  801521:	e8 e3 fd ff ff       	call   801309 <syscall>
  801526:	83 c4 18             	add    $0x18,%esp
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 10                	push   $0x10
  80153a:	e8 ca fd ff ff       	call   801309 <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
}
  801542:	90                   	nop
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 14                	push   $0x14
  801554:	e8 b0 fd ff ff       	call   801309 <syscall>
  801559:	83 c4 18             	add    $0x18,%esp
}
  80155c:	90                   	nop
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 15                	push   $0x15
  80156e:	e8 96 fd ff ff       	call   801309 <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	90                   	nop
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <sys_cputc>:


void
sys_cputc(const char c)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
  80157c:	83 ec 04             	sub    $0x4,%esp
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801585:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	50                   	push   %eax
  801592:	6a 16                	push   $0x16
  801594:	e8 70 fd ff ff       	call   801309 <syscall>
  801599:	83 c4 18             	add    $0x18,%esp
}
  80159c:	90                   	nop
  80159d:	c9                   	leave  
  80159e:	c3                   	ret    

0080159f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 17                	push   $0x17
  8015ae:	e8 56 fd ff ff       	call   801309 <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
}
  8015b6:	90                   	nop
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	ff 75 0c             	pushl  0xc(%ebp)
  8015c8:	50                   	push   %eax
  8015c9:	6a 18                	push   $0x18
  8015cb:	e8 39 fd ff ff       	call   801309 <syscall>
  8015d0:	83 c4 18             	add    $0x18,%esp
}
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	52                   	push   %edx
  8015e5:	50                   	push   %eax
  8015e6:	6a 1b                	push   $0x1b
  8015e8:	e8 1c fd ff ff       	call   801309 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	52                   	push   %edx
  801602:	50                   	push   %eax
  801603:	6a 19                	push   $0x19
  801605:	e8 ff fc ff ff       	call   801309 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	90                   	nop
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801613:	8b 55 0c             	mov    0xc(%ebp),%edx
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	52                   	push   %edx
  801620:	50                   	push   %eax
  801621:	6a 1a                	push   $0x1a
  801623:	e8 e1 fc ff ff       	call   801309 <syscall>
  801628:	83 c4 18             	add    $0x18,%esp
}
  80162b:	90                   	nop
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
  801631:	83 ec 04             	sub    $0x4,%esp
  801634:	8b 45 10             	mov    0x10(%ebp),%eax
  801637:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80163a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80163d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	6a 00                	push   $0x0
  801646:	51                   	push   %ecx
  801647:	52                   	push   %edx
  801648:	ff 75 0c             	pushl  0xc(%ebp)
  80164b:	50                   	push   %eax
  80164c:	6a 1c                	push   $0x1c
  80164e:	e8 b6 fc ff ff       	call   801309 <syscall>
  801653:	83 c4 18             	add    $0x18,%esp
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80165b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	52                   	push   %edx
  801668:	50                   	push   %eax
  801669:	6a 1d                	push   $0x1d
  80166b:	e8 99 fc ff ff       	call   801309 <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801678:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80167b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	51                   	push   %ecx
  801686:	52                   	push   %edx
  801687:	50                   	push   %eax
  801688:	6a 1e                	push   $0x1e
  80168a:	e8 7a fc ff ff       	call   801309 <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801697:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169a:	8b 45 08             	mov    0x8(%ebp),%eax
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	52                   	push   %edx
  8016a4:	50                   	push   %eax
  8016a5:	6a 1f                	push   $0x1f
  8016a7:	e8 5d fc ff ff       	call   801309 <syscall>
  8016ac:	83 c4 18             	add    $0x18,%esp
}
  8016af:	c9                   	leave  
  8016b0:	c3                   	ret    

008016b1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016b1:	55                   	push   %ebp
  8016b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 20                	push   $0x20
  8016c0:	e8 44 fc ff ff       	call   801309 <syscall>
  8016c5:	83 c4 18             	add    $0x18,%esp
}
  8016c8:	c9                   	leave  
  8016c9:	c3                   	ret    

008016ca <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8016ca:	55                   	push   %ebp
  8016cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	ff 75 10             	pushl  0x10(%ebp)
  8016d7:	ff 75 0c             	pushl  0xc(%ebp)
  8016da:	50                   	push   %eax
  8016db:	6a 21                	push   $0x21
  8016dd:	e8 27 fc ff ff       	call   801309 <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	50                   	push   %eax
  8016f6:	6a 22                	push   $0x22
  8016f8:	e8 0c fc ff ff       	call   801309 <syscall>
  8016fd:	83 c4 18             	add    $0x18,%esp
}
  801700:	90                   	nop
  801701:	c9                   	leave  
  801702:	c3                   	ret    

00801703 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	50                   	push   %eax
  801712:	6a 23                	push   $0x23
  801714:	e8 f0 fb ff ff       	call   801309 <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	90                   	nop
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
  801722:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801725:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801728:	8d 50 04             	lea    0x4(%eax),%edx
  80172b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	52                   	push   %edx
  801735:	50                   	push   %eax
  801736:	6a 24                	push   $0x24
  801738:	e8 cc fb ff ff       	call   801309 <syscall>
  80173d:	83 c4 18             	add    $0x18,%esp
	return result;
  801740:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801743:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801746:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801749:	89 01                	mov    %eax,(%ecx)
  80174b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80174e:	8b 45 08             	mov    0x8(%ebp),%eax
  801751:	c9                   	leave  
  801752:	c2 04 00             	ret    $0x4

00801755 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	ff 75 10             	pushl  0x10(%ebp)
  80175f:	ff 75 0c             	pushl  0xc(%ebp)
  801762:	ff 75 08             	pushl  0x8(%ebp)
  801765:	6a 13                	push   $0x13
  801767:	e8 9d fb ff ff       	call   801309 <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
	return ;
  80176f:	90                   	nop
}
  801770:	c9                   	leave  
  801771:	c3                   	ret    

00801772 <sys_rcr2>:
uint32 sys_rcr2()
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 25                	push   $0x25
  801781:	e8 83 fb ff ff       	call   801309 <syscall>
  801786:	83 c4 18             	add    $0x18,%esp
}
  801789:	c9                   	leave  
  80178a:	c3                   	ret    

0080178b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80178b:	55                   	push   %ebp
  80178c:	89 e5                	mov    %esp,%ebp
  80178e:	83 ec 04             	sub    $0x4,%esp
  801791:	8b 45 08             	mov    0x8(%ebp),%eax
  801794:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801797:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	50                   	push   %eax
  8017a4:	6a 26                	push   $0x26
  8017a6:	e8 5e fb ff ff       	call   801309 <syscall>
  8017ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ae:	90                   	nop
}
  8017af:	c9                   	leave  
  8017b0:	c3                   	ret    

008017b1 <rsttst>:
void rsttst()
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 28                	push   $0x28
  8017c0:	e8 44 fb ff ff       	call   801309 <syscall>
  8017c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c8:	90                   	nop
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
  8017ce:	83 ec 04             	sub    $0x4,%esp
  8017d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8017d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017d7:	8b 55 18             	mov    0x18(%ebp),%edx
  8017da:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017de:	52                   	push   %edx
  8017df:	50                   	push   %eax
  8017e0:	ff 75 10             	pushl  0x10(%ebp)
  8017e3:	ff 75 0c             	pushl  0xc(%ebp)
  8017e6:	ff 75 08             	pushl  0x8(%ebp)
  8017e9:	6a 27                	push   $0x27
  8017eb:	e8 19 fb ff ff       	call   801309 <syscall>
  8017f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f3:	90                   	nop
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <chktst>:
void chktst(uint32 n)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	ff 75 08             	pushl  0x8(%ebp)
  801804:	6a 29                	push   $0x29
  801806:	e8 fe fa ff ff       	call   801309 <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
	return ;
  80180e:	90                   	nop
}
  80180f:	c9                   	leave  
  801810:	c3                   	ret    

00801811 <inctst>:

void inctst()
{
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 2a                	push   $0x2a
  801820:	e8 e4 fa ff ff       	call   801309 <syscall>
  801825:	83 c4 18             	add    $0x18,%esp
	return ;
  801828:	90                   	nop
}
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <gettst>:
uint32 gettst()
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 2b                	push   $0x2b
  80183a:	e8 ca fa ff ff       	call   801309 <syscall>
  80183f:	83 c4 18             	add    $0x18,%esp
}
  801842:	c9                   	leave  
  801843:	c3                   	ret    

00801844 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801844:	55                   	push   %ebp
  801845:	89 e5                	mov    %esp,%ebp
  801847:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 2c                	push   $0x2c
  801856:	e8 ae fa ff ff       	call   801309 <syscall>
  80185b:	83 c4 18             	add    $0x18,%esp
  80185e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801861:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801865:	75 07                	jne    80186e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801867:	b8 01 00 00 00       	mov    $0x1,%eax
  80186c:	eb 05                	jmp    801873 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80186e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801873:	c9                   	leave  
  801874:	c3                   	ret    

00801875 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801875:	55                   	push   %ebp
  801876:	89 e5                	mov    %esp,%ebp
  801878:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 2c                	push   $0x2c
  801887:	e8 7d fa ff ff       	call   801309 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
  80188f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801892:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801896:	75 07                	jne    80189f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801898:	b8 01 00 00 00       	mov    $0x1,%eax
  80189d:	eb 05                	jmp    8018a4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80189f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
  8018a9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 2c                	push   $0x2c
  8018b8:	e8 4c fa ff ff       	call   801309 <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
  8018c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018c3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018c7:	75 07                	jne    8018d0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ce:	eb 05                	jmp    8018d5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
  8018da:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 2c                	push   $0x2c
  8018e9:	e8 1b fa ff ff       	call   801309 <syscall>
  8018ee:	83 c4 18             	add    $0x18,%esp
  8018f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8018f4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8018f8:	75 07                	jne    801901 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8018fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ff:	eb 05                	jmp    801906 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801901:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	ff 75 08             	pushl  0x8(%ebp)
  801916:	6a 2d                	push   $0x2d
  801918:	e8 ec f9 ff ff       	call   801309 <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
	return ;
  801920:	90                   	nop
}
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
  801926:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801929:	8d 45 10             	lea    0x10(%ebp),%eax
  80192c:	83 c0 04             	add    $0x4,%eax
  80192f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801932:	a1 40 30 98 00       	mov    0x983040,%eax
  801937:	85 c0                	test   %eax,%eax
  801939:	74 16                	je     801951 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80193b:	a1 40 30 98 00       	mov    0x983040,%eax
  801940:	83 ec 08             	sub    $0x8,%esp
  801943:	50                   	push   %eax
  801944:	68 5c 22 80 00       	push   $0x80225c
  801949:	e8 a1 e9 ff ff       	call   8002ef <cprintf>
  80194e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801951:	a1 00 30 80 00       	mov    0x803000,%eax
  801956:	ff 75 0c             	pushl  0xc(%ebp)
  801959:	ff 75 08             	pushl  0x8(%ebp)
  80195c:	50                   	push   %eax
  80195d:	68 61 22 80 00       	push   $0x802261
  801962:	e8 88 e9 ff ff       	call   8002ef <cprintf>
  801967:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80196a:	8b 45 10             	mov    0x10(%ebp),%eax
  80196d:	83 ec 08             	sub    $0x8,%esp
  801970:	ff 75 f4             	pushl  -0xc(%ebp)
  801973:	50                   	push   %eax
  801974:	e8 0b e9 ff ff       	call   800284 <vcprintf>
  801979:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80197c:	83 ec 08             	sub    $0x8,%esp
  80197f:	6a 00                	push   $0x0
  801981:	68 7d 22 80 00       	push   $0x80227d
  801986:	e8 f9 e8 ff ff       	call   800284 <vcprintf>
  80198b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80198e:	e8 7a e8 ff ff       	call   80020d <exit>

	// should not return here
	while (1) ;
  801993:	eb fe                	jmp    801993 <_panic+0x70>

00801995 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
  801998:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80199b:	a1 20 30 80 00       	mov    0x803020,%eax
  8019a0:	8b 50 74             	mov    0x74(%eax),%edx
  8019a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a6:	39 c2                	cmp    %eax,%edx
  8019a8:	74 14                	je     8019be <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8019aa:	83 ec 04             	sub    $0x4,%esp
  8019ad:	68 80 22 80 00       	push   $0x802280
  8019b2:	6a 26                	push   $0x26
  8019b4:	68 cc 22 80 00       	push   $0x8022cc
  8019b9:	e8 65 ff ff ff       	call   801923 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8019be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8019c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019cc:	e9 c2 00 00 00       	jmp    801a93 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8019d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019db:	8b 45 08             	mov    0x8(%ebp),%eax
  8019de:	01 d0                	add    %edx,%eax
  8019e0:	8b 00                	mov    (%eax),%eax
  8019e2:	85 c0                	test   %eax,%eax
  8019e4:	75 08                	jne    8019ee <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8019e6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8019e9:	e9 a2 00 00 00       	jmp    801a90 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8019ee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019f5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8019fc:	eb 69                	jmp    801a67 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8019fe:	a1 20 30 80 00       	mov    0x803020,%eax
  801a03:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a09:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a0c:	89 d0                	mov    %edx,%eax
  801a0e:	01 c0                	add    %eax,%eax
  801a10:	01 d0                	add    %edx,%eax
  801a12:	c1 e0 02             	shl    $0x2,%eax
  801a15:	01 c8                	add    %ecx,%eax
  801a17:	8a 40 04             	mov    0x4(%eax),%al
  801a1a:	84 c0                	test   %al,%al
  801a1c:	75 46                	jne    801a64 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a1e:	a1 20 30 80 00       	mov    0x803020,%eax
  801a23:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a29:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a2c:	89 d0                	mov    %edx,%eax
  801a2e:	01 c0                	add    %eax,%eax
  801a30:	01 d0                	add    %edx,%eax
  801a32:	c1 e0 02             	shl    $0x2,%eax
  801a35:	01 c8                	add    %ecx,%eax
  801a37:	8b 00                	mov    (%eax),%eax
  801a39:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a3c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a3f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801a44:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801a46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a49:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	01 c8                	add    %ecx,%eax
  801a55:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a57:	39 c2                	cmp    %eax,%edx
  801a59:	75 09                	jne    801a64 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801a5b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801a62:	eb 12                	jmp    801a76 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a64:	ff 45 e8             	incl   -0x18(%ebp)
  801a67:	a1 20 30 80 00       	mov    0x803020,%eax
  801a6c:	8b 50 74             	mov    0x74(%eax),%edx
  801a6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a72:	39 c2                	cmp    %eax,%edx
  801a74:	77 88                	ja     8019fe <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801a76:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a7a:	75 14                	jne    801a90 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801a7c:	83 ec 04             	sub    $0x4,%esp
  801a7f:	68 d8 22 80 00       	push   $0x8022d8
  801a84:	6a 3a                	push   $0x3a
  801a86:	68 cc 22 80 00       	push   $0x8022cc
  801a8b:	e8 93 fe ff ff       	call   801923 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801a90:	ff 45 f0             	incl   -0x10(%ebp)
  801a93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a96:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801a99:	0f 8c 32 ff ff ff    	jl     8019d1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801a9f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801aa6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801aad:	eb 26                	jmp    801ad5 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801aaf:	a1 20 30 80 00       	mov    0x803020,%eax
  801ab4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801aba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801abd:	89 d0                	mov    %edx,%eax
  801abf:	01 c0                	add    %eax,%eax
  801ac1:	01 d0                	add    %edx,%eax
  801ac3:	c1 e0 02             	shl    $0x2,%eax
  801ac6:	01 c8                	add    %ecx,%eax
  801ac8:	8a 40 04             	mov    0x4(%eax),%al
  801acb:	3c 01                	cmp    $0x1,%al
  801acd:	75 03                	jne    801ad2 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801acf:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ad2:	ff 45 e0             	incl   -0x20(%ebp)
  801ad5:	a1 20 30 80 00       	mov    0x803020,%eax
  801ada:	8b 50 74             	mov    0x74(%eax),%edx
  801add:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ae0:	39 c2                	cmp    %eax,%edx
  801ae2:	77 cb                	ja     801aaf <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ae7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801aea:	74 14                	je     801b00 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801aec:	83 ec 04             	sub    $0x4,%esp
  801aef:	68 2c 23 80 00       	push   $0x80232c
  801af4:	6a 44                	push   $0x44
  801af6:	68 cc 22 80 00       	push   $0x8022cc
  801afb:	e8 23 fe ff ff       	call   801923 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b00:	90                   	nop
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    
  801b03:	90                   	nop

00801b04 <__udivdi3>:
  801b04:	55                   	push   %ebp
  801b05:	57                   	push   %edi
  801b06:	56                   	push   %esi
  801b07:	53                   	push   %ebx
  801b08:	83 ec 1c             	sub    $0x1c,%esp
  801b0b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b0f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b13:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b17:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b1b:	89 ca                	mov    %ecx,%edx
  801b1d:	89 f8                	mov    %edi,%eax
  801b1f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b23:	85 f6                	test   %esi,%esi
  801b25:	75 2d                	jne    801b54 <__udivdi3+0x50>
  801b27:	39 cf                	cmp    %ecx,%edi
  801b29:	77 65                	ja     801b90 <__udivdi3+0x8c>
  801b2b:	89 fd                	mov    %edi,%ebp
  801b2d:	85 ff                	test   %edi,%edi
  801b2f:	75 0b                	jne    801b3c <__udivdi3+0x38>
  801b31:	b8 01 00 00 00       	mov    $0x1,%eax
  801b36:	31 d2                	xor    %edx,%edx
  801b38:	f7 f7                	div    %edi
  801b3a:	89 c5                	mov    %eax,%ebp
  801b3c:	31 d2                	xor    %edx,%edx
  801b3e:	89 c8                	mov    %ecx,%eax
  801b40:	f7 f5                	div    %ebp
  801b42:	89 c1                	mov    %eax,%ecx
  801b44:	89 d8                	mov    %ebx,%eax
  801b46:	f7 f5                	div    %ebp
  801b48:	89 cf                	mov    %ecx,%edi
  801b4a:	89 fa                	mov    %edi,%edx
  801b4c:	83 c4 1c             	add    $0x1c,%esp
  801b4f:	5b                   	pop    %ebx
  801b50:	5e                   	pop    %esi
  801b51:	5f                   	pop    %edi
  801b52:	5d                   	pop    %ebp
  801b53:	c3                   	ret    
  801b54:	39 ce                	cmp    %ecx,%esi
  801b56:	77 28                	ja     801b80 <__udivdi3+0x7c>
  801b58:	0f bd fe             	bsr    %esi,%edi
  801b5b:	83 f7 1f             	xor    $0x1f,%edi
  801b5e:	75 40                	jne    801ba0 <__udivdi3+0x9c>
  801b60:	39 ce                	cmp    %ecx,%esi
  801b62:	72 0a                	jb     801b6e <__udivdi3+0x6a>
  801b64:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b68:	0f 87 9e 00 00 00    	ja     801c0c <__udivdi3+0x108>
  801b6e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b73:	89 fa                	mov    %edi,%edx
  801b75:	83 c4 1c             	add    $0x1c,%esp
  801b78:	5b                   	pop    %ebx
  801b79:	5e                   	pop    %esi
  801b7a:	5f                   	pop    %edi
  801b7b:	5d                   	pop    %ebp
  801b7c:	c3                   	ret    
  801b7d:	8d 76 00             	lea    0x0(%esi),%esi
  801b80:	31 ff                	xor    %edi,%edi
  801b82:	31 c0                	xor    %eax,%eax
  801b84:	89 fa                	mov    %edi,%edx
  801b86:	83 c4 1c             	add    $0x1c,%esp
  801b89:	5b                   	pop    %ebx
  801b8a:	5e                   	pop    %esi
  801b8b:	5f                   	pop    %edi
  801b8c:	5d                   	pop    %ebp
  801b8d:	c3                   	ret    
  801b8e:	66 90                	xchg   %ax,%ax
  801b90:	89 d8                	mov    %ebx,%eax
  801b92:	f7 f7                	div    %edi
  801b94:	31 ff                	xor    %edi,%edi
  801b96:	89 fa                	mov    %edi,%edx
  801b98:	83 c4 1c             	add    $0x1c,%esp
  801b9b:	5b                   	pop    %ebx
  801b9c:	5e                   	pop    %esi
  801b9d:	5f                   	pop    %edi
  801b9e:	5d                   	pop    %ebp
  801b9f:	c3                   	ret    
  801ba0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ba5:	89 eb                	mov    %ebp,%ebx
  801ba7:	29 fb                	sub    %edi,%ebx
  801ba9:	89 f9                	mov    %edi,%ecx
  801bab:	d3 e6                	shl    %cl,%esi
  801bad:	89 c5                	mov    %eax,%ebp
  801baf:	88 d9                	mov    %bl,%cl
  801bb1:	d3 ed                	shr    %cl,%ebp
  801bb3:	89 e9                	mov    %ebp,%ecx
  801bb5:	09 f1                	or     %esi,%ecx
  801bb7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bbb:	89 f9                	mov    %edi,%ecx
  801bbd:	d3 e0                	shl    %cl,%eax
  801bbf:	89 c5                	mov    %eax,%ebp
  801bc1:	89 d6                	mov    %edx,%esi
  801bc3:	88 d9                	mov    %bl,%cl
  801bc5:	d3 ee                	shr    %cl,%esi
  801bc7:	89 f9                	mov    %edi,%ecx
  801bc9:	d3 e2                	shl    %cl,%edx
  801bcb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bcf:	88 d9                	mov    %bl,%cl
  801bd1:	d3 e8                	shr    %cl,%eax
  801bd3:	09 c2                	or     %eax,%edx
  801bd5:	89 d0                	mov    %edx,%eax
  801bd7:	89 f2                	mov    %esi,%edx
  801bd9:	f7 74 24 0c          	divl   0xc(%esp)
  801bdd:	89 d6                	mov    %edx,%esi
  801bdf:	89 c3                	mov    %eax,%ebx
  801be1:	f7 e5                	mul    %ebp
  801be3:	39 d6                	cmp    %edx,%esi
  801be5:	72 19                	jb     801c00 <__udivdi3+0xfc>
  801be7:	74 0b                	je     801bf4 <__udivdi3+0xf0>
  801be9:	89 d8                	mov    %ebx,%eax
  801beb:	31 ff                	xor    %edi,%edi
  801bed:	e9 58 ff ff ff       	jmp    801b4a <__udivdi3+0x46>
  801bf2:	66 90                	xchg   %ax,%ax
  801bf4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bf8:	89 f9                	mov    %edi,%ecx
  801bfa:	d3 e2                	shl    %cl,%edx
  801bfc:	39 c2                	cmp    %eax,%edx
  801bfe:	73 e9                	jae    801be9 <__udivdi3+0xe5>
  801c00:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c03:	31 ff                	xor    %edi,%edi
  801c05:	e9 40 ff ff ff       	jmp    801b4a <__udivdi3+0x46>
  801c0a:	66 90                	xchg   %ax,%ax
  801c0c:	31 c0                	xor    %eax,%eax
  801c0e:	e9 37 ff ff ff       	jmp    801b4a <__udivdi3+0x46>
  801c13:	90                   	nop

00801c14 <__umoddi3>:
  801c14:	55                   	push   %ebp
  801c15:	57                   	push   %edi
  801c16:	56                   	push   %esi
  801c17:	53                   	push   %ebx
  801c18:	83 ec 1c             	sub    $0x1c,%esp
  801c1b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c1f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c27:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c2f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c33:	89 f3                	mov    %esi,%ebx
  801c35:	89 fa                	mov    %edi,%edx
  801c37:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c3b:	89 34 24             	mov    %esi,(%esp)
  801c3e:	85 c0                	test   %eax,%eax
  801c40:	75 1a                	jne    801c5c <__umoddi3+0x48>
  801c42:	39 f7                	cmp    %esi,%edi
  801c44:	0f 86 a2 00 00 00    	jbe    801cec <__umoddi3+0xd8>
  801c4a:	89 c8                	mov    %ecx,%eax
  801c4c:	89 f2                	mov    %esi,%edx
  801c4e:	f7 f7                	div    %edi
  801c50:	89 d0                	mov    %edx,%eax
  801c52:	31 d2                	xor    %edx,%edx
  801c54:	83 c4 1c             	add    $0x1c,%esp
  801c57:	5b                   	pop    %ebx
  801c58:	5e                   	pop    %esi
  801c59:	5f                   	pop    %edi
  801c5a:	5d                   	pop    %ebp
  801c5b:	c3                   	ret    
  801c5c:	39 f0                	cmp    %esi,%eax
  801c5e:	0f 87 ac 00 00 00    	ja     801d10 <__umoddi3+0xfc>
  801c64:	0f bd e8             	bsr    %eax,%ebp
  801c67:	83 f5 1f             	xor    $0x1f,%ebp
  801c6a:	0f 84 ac 00 00 00    	je     801d1c <__umoddi3+0x108>
  801c70:	bf 20 00 00 00       	mov    $0x20,%edi
  801c75:	29 ef                	sub    %ebp,%edi
  801c77:	89 fe                	mov    %edi,%esi
  801c79:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c7d:	89 e9                	mov    %ebp,%ecx
  801c7f:	d3 e0                	shl    %cl,%eax
  801c81:	89 d7                	mov    %edx,%edi
  801c83:	89 f1                	mov    %esi,%ecx
  801c85:	d3 ef                	shr    %cl,%edi
  801c87:	09 c7                	or     %eax,%edi
  801c89:	89 e9                	mov    %ebp,%ecx
  801c8b:	d3 e2                	shl    %cl,%edx
  801c8d:	89 14 24             	mov    %edx,(%esp)
  801c90:	89 d8                	mov    %ebx,%eax
  801c92:	d3 e0                	shl    %cl,%eax
  801c94:	89 c2                	mov    %eax,%edx
  801c96:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c9a:	d3 e0                	shl    %cl,%eax
  801c9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ca0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ca4:	89 f1                	mov    %esi,%ecx
  801ca6:	d3 e8                	shr    %cl,%eax
  801ca8:	09 d0                	or     %edx,%eax
  801caa:	d3 eb                	shr    %cl,%ebx
  801cac:	89 da                	mov    %ebx,%edx
  801cae:	f7 f7                	div    %edi
  801cb0:	89 d3                	mov    %edx,%ebx
  801cb2:	f7 24 24             	mull   (%esp)
  801cb5:	89 c6                	mov    %eax,%esi
  801cb7:	89 d1                	mov    %edx,%ecx
  801cb9:	39 d3                	cmp    %edx,%ebx
  801cbb:	0f 82 87 00 00 00    	jb     801d48 <__umoddi3+0x134>
  801cc1:	0f 84 91 00 00 00    	je     801d58 <__umoddi3+0x144>
  801cc7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ccb:	29 f2                	sub    %esi,%edx
  801ccd:	19 cb                	sbb    %ecx,%ebx
  801ccf:	89 d8                	mov    %ebx,%eax
  801cd1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cd5:	d3 e0                	shl    %cl,%eax
  801cd7:	89 e9                	mov    %ebp,%ecx
  801cd9:	d3 ea                	shr    %cl,%edx
  801cdb:	09 d0                	or     %edx,%eax
  801cdd:	89 e9                	mov    %ebp,%ecx
  801cdf:	d3 eb                	shr    %cl,%ebx
  801ce1:	89 da                	mov    %ebx,%edx
  801ce3:	83 c4 1c             	add    $0x1c,%esp
  801ce6:	5b                   	pop    %ebx
  801ce7:	5e                   	pop    %esi
  801ce8:	5f                   	pop    %edi
  801ce9:	5d                   	pop    %ebp
  801cea:	c3                   	ret    
  801ceb:	90                   	nop
  801cec:	89 fd                	mov    %edi,%ebp
  801cee:	85 ff                	test   %edi,%edi
  801cf0:	75 0b                	jne    801cfd <__umoddi3+0xe9>
  801cf2:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf7:	31 d2                	xor    %edx,%edx
  801cf9:	f7 f7                	div    %edi
  801cfb:	89 c5                	mov    %eax,%ebp
  801cfd:	89 f0                	mov    %esi,%eax
  801cff:	31 d2                	xor    %edx,%edx
  801d01:	f7 f5                	div    %ebp
  801d03:	89 c8                	mov    %ecx,%eax
  801d05:	f7 f5                	div    %ebp
  801d07:	89 d0                	mov    %edx,%eax
  801d09:	e9 44 ff ff ff       	jmp    801c52 <__umoddi3+0x3e>
  801d0e:	66 90                	xchg   %ax,%ax
  801d10:	89 c8                	mov    %ecx,%eax
  801d12:	89 f2                	mov    %esi,%edx
  801d14:	83 c4 1c             	add    $0x1c,%esp
  801d17:	5b                   	pop    %ebx
  801d18:	5e                   	pop    %esi
  801d19:	5f                   	pop    %edi
  801d1a:	5d                   	pop    %ebp
  801d1b:	c3                   	ret    
  801d1c:	3b 04 24             	cmp    (%esp),%eax
  801d1f:	72 06                	jb     801d27 <__umoddi3+0x113>
  801d21:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d25:	77 0f                	ja     801d36 <__umoddi3+0x122>
  801d27:	89 f2                	mov    %esi,%edx
  801d29:	29 f9                	sub    %edi,%ecx
  801d2b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d2f:	89 14 24             	mov    %edx,(%esp)
  801d32:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d36:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d3a:	8b 14 24             	mov    (%esp),%edx
  801d3d:	83 c4 1c             	add    $0x1c,%esp
  801d40:	5b                   	pop    %ebx
  801d41:	5e                   	pop    %esi
  801d42:	5f                   	pop    %edi
  801d43:	5d                   	pop    %ebp
  801d44:	c3                   	ret    
  801d45:	8d 76 00             	lea    0x0(%esi),%esi
  801d48:	2b 04 24             	sub    (%esp),%eax
  801d4b:	19 fa                	sbb    %edi,%edx
  801d4d:	89 d1                	mov    %edx,%ecx
  801d4f:	89 c6                	mov    %eax,%esi
  801d51:	e9 71 ff ff ff       	jmp    801cc7 <__umoddi3+0xb3>
  801d56:	66 90                	xchg   %ax,%ax
  801d58:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d5c:	72 ea                	jb     801d48 <__umoddi3+0x134>
  801d5e:	89 d9                	mov    %ebx,%ecx
  801d60:	e9 62 ff ff ff       	jmp    801cc7 <__umoddi3+0xb3>
