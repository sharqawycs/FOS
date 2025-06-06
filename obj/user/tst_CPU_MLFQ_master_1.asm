
obj/user/tst_CPU_MLFQ_master_1:     file format elf32-i386


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
  800031:	e8 2a 01 00 00       	call   800160 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// For EXIT
	int ID = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80003e:	a1 04 20 80 00       	mov    0x802004,%eax
  800043:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800049:	a1 04 20 80 00       	mov    0x802004,%eax
  80004e:	8b 40 74             	mov    0x74(%eax),%eax
  800051:	83 ec 04             	sub    $0x4,%esp
  800054:	52                   	push   %edx
  800055:	50                   	push   %eax
  800056:	68 00 1a 80 00       	push   $0x801a00
  80005b:	e8 21 14 00 00       	call   801481 <sys_create_env>
  800060:	83 c4 10             	add    $0x10,%esp
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	ff 75 f0             	pushl  -0x10(%ebp)
  80006c:	e8 2d 14 00 00       	call   80149e <sys_run_env>
  800071:	83 c4 10             	add    $0x10,%esp
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800074:	a1 04 20 80 00       	mov    0x802004,%eax
  800079:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80007f:	a1 04 20 80 00       	mov    0x802004,%eax
  800084:	8b 40 74             	mov    0x74(%eax),%eax
  800087:	83 ec 04             	sub    $0x4,%esp
  80008a:	52                   	push   %edx
  80008b:	50                   	push   %eax
  80008c:	68 0f 1a 80 00       	push   $0x801a0f
  800091:	e8 eb 13 00 00       	call   801481 <sys_create_env>
  800096:	83 c4 10             	add    $0x10,%esp
  800099:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  80009c:	83 ec 0c             	sub    $0xc,%esp
  80009f:	ff 75 f0             	pushl  -0x10(%ebp)
  8000a2:	e8 f7 13 00 00       	call   80149e <sys_run_env>
  8000a7:	83 c4 10             	add    $0x10,%esp
	//============

	for (int i = 0; i < 3; ++i) {
  8000aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000b1:	eb 39                	jmp    8000ec <_main+0xb4>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000b3:	a1 04 20 80 00       	mov    0x802004,%eax
  8000b8:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000be:	a1 04 20 80 00       	mov    0x802004,%eax
  8000c3:	8b 40 74             	mov    0x74(%eax),%eax
  8000c6:	83 ec 04             	sub    $0x4,%esp
  8000c9:	52                   	push   %edx
  8000ca:	50                   	push   %eax
  8000cb:	68 17 1a 80 00       	push   $0x801a17
  8000d0:	e8 ac 13 00 00       	call   801481 <sys_create_env>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
			sys_run_env(ID);
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e1:	e8 b8 13 00 00       	call   80149e <sys_run_env>
  8000e6:	83 c4 10             	add    $0x10,%esp
	sys_run_env(ID);
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(ID);
	//============

	for (int i = 0; i < 3; ++i) {
  8000e9:	ff 45 f4             	incl   -0xc(%ebp)
  8000ec:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  8000f0:	7e c1                	jle    8000b3 <_main+0x7b>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	env_sleep(10000);
  8000f2:	83 ec 0c             	sub    $0xc,%esp
  8000f5:	68 10 27 00 00       	push   $0x2710
  8000fa:	e8 db 15 00 00       	call   8016da <env_sleep>
  8000ff:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("cpuMLFQ1Slave_1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800102:	a1 04 20 80 00       	mov    0x802004,%eax
  800107:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80010d:	a1 04 20 80 00       	mov    0x802004,%eax
  800112:	8b 40 74             	mov    0x74(%eax),%eax
  800115:	83 ec 04             	sub    $0x4,%esp
  800118:	52                   	push   %edx
  800119:	50                   	push   %eax
  80011a:	68 25 1a 80 00       	push   $0x801a25
  80011f:	e8 5d 13 00 00       	call   801481 <sys_create_env>
  800124:	83 c4 10             	add    $0x10,%esp
  800127:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  80012a:	83 ec 0c             	sub    $0xc,%esp
  80012d:	ff 75 f0             	pushl  -0x10(%ebp)
  800130:	e8 69 13 00 00       	call   80149e <sys_run_env>
  800135:	83 c4 10             	add    $0x10,%esp

	// To wait till other queues filled with other processes
	env_sleep(10000);
  800138:	83 ec 0c             	sub    $0xc,%esp
  80013b:	68 10 27 00 00       	push   $0x2710
  800140:	e8 95 15 00 00       	call   8016da <env_sleep>
  800145:	83 c4 10             	add    $0x10,%esp


	// To check that the slave environments completed successfully
	rsttst();
  800148:	e8 1b 14 00 00       	call   801568 <rsttst>

	env_sleep(200);
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	68 c8 00 00 00       	push   $0xc8
  800155:	e8 80 15 00 00       	call   8016da <env_sleep>
  80015a:	83 c4 10             	add    $0x10,%esp
}
  80015d:	90                   	nop
  80015e:	c9                   	leave  
  80015f:	c3                   	ret    

00800160 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800160:	55                   	push   %ebp
  800161:	89 e5                	mov    %esp,%ebp
  800163:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800166:	e8 f6 0f 00 00       	call   801161 <sys_getenvindex>
  80016b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80016e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800171:	89 d0                	mov    %edx,%eax
  800173:	01 c0                	add    %eax,%eax
  800175:	01 d0                	add    %edx,%eax
  800177:	c1 e0 02             	shl    $0x2,%eax
  80017a:	01 d0                	add    %edx,%eax
  80017c:	c1 e0 06             	shl    $0x6,%eax
  80017f:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800184:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800189:	a1 04 20 80 00       	mov    0x802004,%eax
  80018e:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800194:	84 c0                	test   %al,%al
  800196:	74 0f                	je     8001a7 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800198:	a1 04 20 80 00       	mov    0x802004,%eax
  80019d:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001a2:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001ab:	7e 0a                	jle    8001b7 <libmain+0x57>
		binaryname = argv[0];
  8001ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b0:	8b 00                	mov    (%eax),%eax
  8001b2:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8001b7:	83 ec 08             	sub    $0x8,%esp
  8001ba:	ff 75 0c             	pushl  0xc(%ebp)
  8001bd:	ff 75 08             	pushl  0x8(%ebp)
  8001c0:	e8 73 fe ff ff       	call   800038 <_main>
  8001c5:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001c8:	e8 2f 11 00 00       	call   8012fc <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001cd:	83 ec 0c             	sub    $0xc,%esp
  8001d0:	68 50 1a 80 00       	push   $0x801a50
  8001d5:	e8 5c 01 00 00       	call   800336 <cprintf>
  8001da:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001dd:	a1 04 20 80 00       	mov    0x802004,%eax
  8001e2:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001e8:	a1 04 20 80 00       	mov    0x802004,%eax
  8001ed:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001f3:	83 ec 04             	sub    $0x4,%esp
  8001f6:	52                   	push   %edx
  8001f7:	50                   	push   %eax
  8001f8:	68 78 1a 80 00       	push   $0x801a78
  8001fd:	e8 34 01 00 00       	call   800336 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800205:	a1 04 20 80 00       	mov    0x802004,%eax
  80020a:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800210:	83 ec 08             	sub    $0x8,%esp
  800213:	50                   	push   %eax
  800214:	68 9d 1a 80 00       	push   $0x801a9d
  800219:	e8 18 01 00 00       	call   800336 <cprintf>
  80021e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800221:	83 ec 0c             	sub    $0xc,%esp
  800224:	68 50 1a 80 00       	push   $0x801a50
  800229:	e8 08 01 00 00       	call   800336 <cprintf>
  80022e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800231:	e8 e0 10 00 00       	call   801316 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800236:	e8 19 00 00 00       	call   800254 <exit>
}
  80023b:	90                   	nop
  80023c:	c9                   	leave  
  80023d:	c3                   	ret    

0080023e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80023e:	55                   	push   %ebp
  80023f:	89 e5                	mov    %esp,%ebp
  800241:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	6a 00                	push   $0x0
  800249:	e8 df 0e 00 00       	call   80112d <sys_env_destroy>
  80024e:	83 c4 10             	add    $0x10,%esp
}
  800251:	90                   	nop
  800252:	c9                   	leave  
  800253:	c3                   	ret    

00800254 <exit>:

void
exit(void)
{
  800254:	55                   	push   %ebp
  800255:	89 e5                	mov    %esp,%ebp
  800257:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80025a:	e8 34 0f 00 00       	call   801193 <sys_env_exit>
}
  80025f:	90                   	nop
  800260:	c9                   	leave  
  800261:	c3                   	ret    

00800262 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800262:	55                   	push   %ebp
  800263:	89 e5                	mov    %esp,%ebp
  800265:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026b:	8b 00                	mov    (%eax),%eax
  80026d:	8d 48 01             	lea    0x1(%eax),%ecx
  800270:	8b 55 0c             	mov    0xc(%ebp),%edx
  800273:	89 0a                	mov    %ecx,(%edx)
  800275:	8b 55 08             	mov    0x8(%ebp),%edx
  800278:	88 d1                	mov    %dl,%cl
  80027a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80027d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800281:	8b 45 0c             	mov    0xc(%ebp),%eax
  800284:	8b 00                	mov    (%eax),%eax
  800286:	3d ff 00 00 00       	cmp    $0xff,%eax
  80028b:	75 2c                	jne    8002b9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80028d:	a0 08 20 80 00       	mov    0x802008,%al
  800292:	0f b6 c0             	movzbl %al,%eax
  800295:	8b 55 0c             	mov    0xc(%ebp),%edx
  800298:	8b 12                	mov    (%edx),%edx
  80029a:	89 d1                	mov    %edx,%ecx
  80029c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80029f:	83 c2 08             	add    $0x8,%edx
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	50                   	push   %eax
  8002a6:	51                   	push   %ecx
  8002a7:	52                   	push   %edx
  8002a8:	e8 3e 0e 00 00       	call   8010eb <sys_cputs>
  8002ad:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002bc:	8b 40 04             	mov    0x4(%eax),%eax
  8002bf:	8d 50 01             	lea    0x1(%eax),%edx
  8002c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002c8:	90                   	nop
  8002c9:	c9                   	leave  
  8002ca:	c3                   	ret    

008002cb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002cb:	55                   	push   %ebp
  8002cc:	89 e5                	mov    %esp,%ebp
  8002ce:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002d4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002db:	00 00 00 
	b.cnt = 0;
  8002de:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002e5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002e8:	ff 75 0c             	pushl  0xc(%ebp)
  8002eb:	ff 75 08             	pushl  0x8(%ebp)
  8002ee:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002f4:	50                   	push   %eax
  8002f5:	68 62 02 80 00       	push   $0x800262
  8002fa:	e8 11 02 00 00       	call   800510 <vprintfmt>
  8002ff:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800302:	a0 08 20 80 00       	mov    0x802008,%al
  800307:	0f b6 c0             	movzbl %al,%eax
  80030a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800310:	83 ec 04             	sub    $0x4,%esp
  800313:	50                   	push   %eax
  800314:	52                   	push   %edx
  800315:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80031b:	83 c0 08             	add    $0x8,%eax
  80031e:	50                   	push   %eax
  80031f:	e8 c7 0d 00 00       	call   8010eb <sys_cputs>
  800324:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800327:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  80032e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800334:	c9                   	leave  
  800335:	c3                   	ret    

00800336 <cprintf>:

int cprintf(const char *fmt, ...) {
  800336:	55                   	push   %ebp
  800337:	89 e5                	mov    %esp,%ebp
  800339:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80033c:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800343:	8d 45 0c             	lea    0xc(%ebp),%eax
  800346:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800349:	8b 45 08             	mov    0x8(%ebp),%eax
  80034c:	83 ec 08             	sub    $0x8,%esp
  80034f:	ff 75 f4             	pushl  -0xc(%ebp)
  800352:	50                   	push   %eax
  800353:	e8 73 ff ff ff       	call   8002cb <vcprintf>
  800358:	83 c4 10             	add    $0x10,%esp
  80035b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80035e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800361:	c9                   	leave  
  800362:	c3                   	ret    

00800363 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800363:	55                   	push   %ebp
  800364:	89 e5                	mov    %esp,%ebp
  800366:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800369:	e8 8e 0f 00 00       	call   8012fc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80036e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800371:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800374:	8b 45 08             	mov    0x8(%ebp),%eax
  800377:	83 ec 08             	sub    $0x8,%esp
  80037a:	ff 75 f4             	pushl  -0xc(%ebp)
  80037d:	50                   	push   %eax
  80037e:	e8 48 ff ff ff       	call   8002cb <vcprintf>
  800383:	83 c4 10             	add    $0x10,%esp
  800386:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800389:	e8 88 0f 00 00       	call   801316 <sys_enable_interrupt>
	return cnt;
  80038e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800391:	c9                   	leave  
  800392:	c3                   	ret    

00800393 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800393:	55                   	push   %ebp
  800394:	89 e5                	mov    %esp,%ebp
  800396:	53                   	push   %ebx
  800397:	83 ec 14             	sub    $0x14,%esp
  80039a:	8b 45 10             	mov    0x10(%ebp),%eax
  80039d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8003a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003a6:	8b 45 18             	mov    0x18(%ebp),%eax
  8003a9:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ae:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003b1:	77 55                	ja     800408 <printnum+0x75>
  8003b3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003b6:	72 05                	jb     8003bd <printnum+0x2a>
  8003b8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003bb:	77 4b                	ja     800408 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003bd:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003c0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003c3:	8b 45 18             	mov    0x18(%ebp),%eax
  8003c6:	ba 00 00 00 00       	mov    $0x0,%edx
  8003cb:	52                   	push   %edx
  8003cc:	50                   	push   %eax
  8003cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8003d0:	ff 75 f0             	pushl  -0x10(%ebp)
  8003d3:	e8 b8 13 00 00       	call   801790 <__udivdi3>
  8003d8:	83 c4 10             	add    $0x10,%esp
  8003db:	83 ec 04             	sub    $0x4,%esp
  8003de:	ff 75 20             	pushl  0x20(%ebp)
  8003e1:	53                   	push   %ebx
  8003e2:	ff 75 18             	pushl  0x18(%ebp)
  8003e5:	52                   	push   %edx
  8003e6:	50                   	push   %eax
  8003e7:	ff 75 0c             	pushl  0xc(%ebp)
  8003ea:	ff 75 08             	pushl  0x8(%ebp)
  8003ed:	e8 a1 ff ff ff       	call   800393 <printnum>
  8003f2:	83 c4 20             	add    $0x20,%esp
  8003f5:	eb 1a                	jmp    800411 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003f7:	83 ec 08             	sub    $0x8,%esp
  8003fa:	ff 75 0c             	pushl  0xc(%ebp)
  8003fd:	ff 75 20             	pushl  0x20(%ebp)
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	ff d0                	call   *%eax
  800405:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800408:	ff 4d 1c             	decl   0x1c(%ebp)
  80040b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80040f:	7f e6                	jg     8003f7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800411:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800414:	bb 00 00 00 00       	mov    $0x0,%ebx
  800419:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80041f:	53                   	push   %ebx
  800420:	51                   	push   %ecx
  800421:	52                   	push   %edx
  800422:	50                   	push   %eax
  800423:	e8 78 14 00 00       	call   8018a0 <__umoddi3>
  800428:	83 c4 10             	add    $0x10,%esp
  80042b:	05 d4 1c 80 00       	add    $0x801cd4,%eax
  800430:	8a 00                	mov    (%eax),%al
  800432:	0f be c0             	movsbl %al,%eax
  800435:	83 ec 08             	sub    $0x8,%esp
  800438:	ff 75 0c             	pushl  0xc(%ebp)
  80043b:	50                   	push   %eax
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	ff d0                	call   *%eax
  800441:	83 c4 10             	add    $0x10,%esp
}
  800444:	90                   	nop
  800445:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80044d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800451:	7e 1c                	jle    80046f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800453:	8b 45 08             	mov    0x8(%ebp),%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	8d 50 08             	lea    0x8(%eax),%edx
  80045b:	8b 45 08             	mov    0x8(%ebp),%eax
  80045e:	89 10                	mov    %edx,(%eax)
  800460:	8b 45 08             	mov    0x8(%ebp),%eax
  800463:	8b 00                	mov    (%eax),%eax
  800465:	83 e8 08             	sub    $0x8,%eax
  800468:	8b 50 04             	mov    0x4(%eax),%edx
  80046b:	8b 00                	mov    (%eax),%eax
  80046d:	eb 40                	jmp    8004af <getuint+0x65>
	else if (lflag)
  80046f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800473:	74 1e                	je     800493 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800475:	8b 45 08             	mov    0x8(%ebp),%eax
  800478:	8b 00                	mov    (%eax),%eax
  80047a:	8d 50 04             	lea    0x4(%eax),%edx
  80047d:	8b 45 08             	mov    0x8(%ebp),%eax
  800480:	89 10                	mov    %edx,(%eax)
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	8b 00                	mov    (%eax),%eax
  800487:	83 e8 04             	sub    $0x4,%eax
  80048a:	8b 00                	mov    (%eax),%eax
  80048c:	ba 00 00 00 00       	mov    $0x0,%edx
  800491:	eb 1c                	jmp    8004af <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800493:	8b 45 08             	mov    0x8(%ebp),%eax
  800496:	8b 00                	mov    (%eax),%eax
  800498:	8d 50 04             	lea    0x4(%eax),%edx
  80049b:	8b 45 08             	mov    0x8(%ebp),%eax
  80049e:	89 10                	mov    %edx,(%eax)
  8004a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a3:	8b 00                	mov    (%eax),%eax
  8004a5:	83 e8 04             	sub    $0x4,%eax
  8004a8:	8b 00                	mov    (%eax),%eax
  8004aa:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004af:	5d                   	pop    %ebp
  8004b0:	c3                   	ret    

008004b1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004b1:	55                   	push   %ebp
  8004b2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004b4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004b8:	7e 1c                	jle    8004d6 <getint+0x25>
		return va_arg(*ap, long long);
  8004ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bd:	8b 00                	mov    (%eax),%eax
  8004bf:	8d 50 08             	lea    0x8(%eax),%edx
  8004c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c5:	89 10                	mov    %edx,(%eax)
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	8b 00                	mov    (%eax),%eax
  8004cc:	83 e8 08             	sub    $0x8,%eax
  8004cf:	8b 50 04             	mov    0x4(%eax),%edx
  8004d2:	8b 00                	mov    (%eax),%eax
  8004d4:	eb 38                	jmp    80050e <getint+0x5d>
	else if (lflag)
  8004d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004da:	74 1a                	je     8004f6 <getint+0x45>
		return va_arg(*ap, long);
  8004dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004df:	8b 00                	mov    (%eax),%eax
  8004e1:	8d 50 04             	lea    0x4(%eax),%edx
  8004e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e7:	89 10                	mov    %edx,(%eax)
  8004e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ec:	8b 00                	mov    (%eax),%eax
  8004ee:	83 e8 04             	sub    $0x4,%eax
  8004f1:	8b 00                	mov    (%eax),%eax
  8004f3:	99                   	cltd   
  8004f4:	eb 18                	jmp    80050e <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f9:	8b 00                	mov    (%eax),%eax
  8004fb:	8d 50 04             	lea    0x4(%eax),%edx
  8004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800501:	89 10                	mov    %edx,(%eax)
  800503:	8b 45 08             	mov    0x8(%ebp),%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	83 e8 04             	sub    $0x4,%eax
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	99                   	cltd   
}
  80050e:	5d                   	pop    %ebp
  80050f:	c3                   	ret    

00800510 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800510:	55                   	push   %ebp
  800511:	89 e5                	mov    %esp,%ebp
  800513:	56                   	push   %esi
  800514:	53                   	push   %ebx
  800515:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800518:	eb 17                	jmp    800531 <vprintfmt+0x21>
			if (ch == '\0')
  80051a:	85 db                	test   %ebx,%ebx
  80051c:	0f 84 af 03 00 00    	je     8008d1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800522:	83 ec 08             	sub    $0x8,%esp
  800525:	ff 75 0c             	pushl  0xc(%ebp)
  800528:	53                   	push   %ebx
  800529:	8b 45 08             	mov    0x8(%ebp),%eax
  80052c:	ff d0                	call   *%eax
  80052e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800531:	8b 45 10             	mov    0x10(%ebp),%eax
  800534:	8d 50 01             	lea    0x1(%eax),%edx
  800537:	89 55 10             	mov    %edx,0x10(%ebp)
  80053a:	8a 00                	mov    (%eax),%al
  80053c:	0f b6 d8             	movzbl %al,%ebx
  80053f:	83 fb 25             	cmp    $0x25,%ebx
  800542:	75 d6                	jne    80051a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800544:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800548:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80054f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800556:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80055d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800564:	8b 45 10             	mov    0x10(%ebp),%eax
  800567:	8d 50 01             	lea    0x1(%eax),%edx
  80056a:	89 55 10             	mov    %edx,0x10(%ebp)
  80056d:	8a 00                	mov    (%eax),%al
  80056f:	0f b6 d8             	movzbl %al,%ebx
  800572:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800575:	83 f8 55             	cmp    $0x55,%eax
  800578:	0f 87 2b 03 00 00    	ja     8008a9 <vprintfmt+0x399>
  80057e:	8b 04 85 f8 1c 80 00 	mov    0x801cf8(,%eax,4),%eax
  800585:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800587:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80058b:	eb d7                	jmp    800564 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80058d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800591:	eb d1                	jmp    800564 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800593:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80059a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80059d:	89 d0                	mov    %edx,%eax
  80059f:	c1 e0 02             	shl    $0x2,%eax
  8005a2:	01 d0                	add    %edx,%eax
  8005a4:	01 c0                	add    %eax,%eax
  8005a6:	01 d8                	add    %ebx,%eax
  8005a8:	83 e8 30             	sub    $0x30,%eax
  8005ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8005b1:	8a 00                	mov    (%eax),%al
  8005b3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005b6:	83 fb 2f             	cmp    $0x2f,%ebx
  8005b9:	7e 3e                	jle    8005f9 <vprintfmt+0xe9>
  8005bb:	83 fb 39             	cmp    $0x39,%ebx
  8005be:	7f 39                	jg     8005f9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005c0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005c3:	eb d5                	jmp    80059a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c8:	83 c0 04             	add    $0x4,%eax
  8005cb:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d1:	83 e8 04             	sub    $0x4,%eax
  8005d4:	8b 00                	mov    (%eax),%eax
  8005d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005d9:	eb 1f                	jmp    8005fa <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005db:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005df:	79 83                	jns    800564 <vprintfmt+0x54>
				width = 0;
  8005e1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005e8:	e9 77 ff ff ff       	jmp    800564 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005ed:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005f4:	e9 6b ff ff ff       	jmp    800564 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005f9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005fa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005fe:	0f 89 60 ff ff ff    	jns    800564 <vprintfmt+0x54>
				width = precision, precision = -1;
  800604:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800607:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80060a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800611:	e9 4e ff ff ff       	jmp    800564 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800616:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800619:	e9 46 ff ff ff       	jmp    800564 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80061e:	8b 45 14             	mov    0x14(%ebp),%eax
  800621:	83 c0 04             	add    $0x4,%eax
  800624:	89 45 14             	mov    %eax,0x14(%ebp)
  800627:	8b 45 14             	mov    0x14(%ebp),%eax
  80062a:	83 e8 04             	sub    $0x4,%eax
  80062d:	8b 00                	mov    (%eax),%eax
  80062f:	83 ec 08             	sub    $0x8,%esp
  800632:	ff 75 0c             	pushl  0xc(%ebp)
  800635:	50                   	push   %eax
  800636:	8b 45 08             	mov    0x8(%ebp),%eax
  800639:	ff d0                	call   *%eax
  80063b:	83 c4 10             	add    $0x10,%esp
			break;
  80063e:	e9 89 02 00 00       	jmp    8008cc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800643:	8b 45 14             	mov    0x14(%ebp),%eax
  800646:	83 c0 04             	add    $0x4,%eax
  800649:	89 45 14             	mov    %eax,0x14(%ebp)
  80064c:	8b 45 14             	mov    0x14(%ebp),%eax
  80064f:	83 e8 04             	sub    $0x4,%eax
  800652:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800654:	85 db                	test   %ebx,%ebx
  800656:	79 02                	jns    80065a <vprintfmt+0x14a>
				err = -err;
  800658:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80065a:	83 fb 64             	cmp    $0x64,%ebx
  80065d:	7f 0b                	jg     80066a <vprintfmt+0x15a>
  80065f:	8b 34 9d 40 1b 80 00 	mov    0x801b40(,%ebx,4),%esi
  800666:	85 f6                	test   %esi,%esi
  800668:	75 19                	jne    800683 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80066a:	53                   	push   %ebx
  80066b:	68 e5 1c 80 00       	push   $0x801ce5
  800670:	ff 75 0c             	pushl  0xc(%ebp)
  800673:	ff 75 08             	pushl  0x8(%ebp)
  800676:	e8 5e 02 00 00       	call   8008d9 <printfmt>
  80067b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80067e:	e9 49 02 00 00       	jmp    8008cc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800683:	56                   	push   %esi
  800684:	68 ee 1c 80 00       	push   $0x801cee
  800689:	ff 75 0c             	pushl  0xc(%ebp)
  80068c:	ff 75 08             	pushl  0x8(%ebp)
  80068f:	e8 45 02 00 00       	call   8008d9 <printfmt>
  800694:	83 c4 10             	add    $0x10,%esp
			break;
  800697:	e9 30 02 00 00       	jmp    8008cc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80069c:	8b 45 14             	mov    0x14(%ebp),%eax
  80069f:	83 c0 04             	add    $0x4,%eax
  8006a2:	89 45 14             	mov    %eax,0x14(%ebp)
  8006a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8006a8:	83 e8 04             	sub    $0x4,%eax
  8006ab:	8b 30                	mov    (%eax),%esi
  8006ad:	85 f6                	test   %esi,%esi
  8006af:	75 05                	jne    8006b6 <vprintfmt+0x1a6>
				p = "(null)";
  8006b1:	be f1 1c 80 00       	mov    $0x801cf1,%esi
			if (width > 0 && padc != '-')
  8006b6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ba:	7e 6d                	jle    800729 <vprintfmt+0x219>
  8006bc:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006c0:	74 67                	je     800729 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c5:	83 ec 08             	sub    $0x8,%esp
  8006c8:	50                   	push   %eax
  8006c9:	56                   	push   %esi
  8006ca:	e8 0c 03 00 00       	call   8009db <strnlen>
  8006cf:	83 c4 10             	add    $0x10,%esp
  8006d2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006d5:	eb 16                	jmp    8006ed <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006d7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006db:	83 ec 08             	sub    $0x8,%esp
  8006de:	ff 75 0c             	pushl  0xc(%ebp)
  8006e1:	50                   	push   %eax
  8006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e5:	ff d0                	call   *%eax
  8006e7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006ea:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f1:	7f e4                	jg     8006d7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006f3:	eb 34                	jmp    800729 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006f5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006f9:	74 1c                	je     800717 <vprintfmt+0x207>
  8006fb:	83 fb 1f             	cmp    $0x1f,%ebx
  8006fe:	7e 05                	jle    800705 <vprintfmt+0x1f5>
  800700:	83 fb 7e             	cmp    $0x7e,%ebx
  800703:	7e 12                	jle    800717 <vprintfmt+0x207>
					putch('?', putdat);
  800705:	83 ec 08             	sub    $0x8,%esp
  800708:	ff 75 0c             	pushl  0xc(%ebp)
  80070b:	6a 3f                	push   $0x3f
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	ff d0                	call   *%eax
  800712:	83 c4 10             	add    $0x10,%esp
  800715:	eb 0f                	jmp    800726 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	ff 75 0c             	pushl  0xc(%ebp)
  80071d:	53                   	push   %ebx
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	ff d0                	call   *%eax
  800723:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800726:	ff 4d e4             	decl   -0x1c(%ebp)
  800729:	89 f0                	mov    %esi,%eax
  80072b:	8d 70 01             	lea    0x1(%eax),%esi
  80072e:	8a 00                	mov    (%eax),%al
  800730:	0f be d8             	movsbl %al,%ebx
  800733:	85 db                	test   %ebx,%ebx
  800735:	74 24                	je     80075b <vprintfmt+0x24b>
  800737:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80073b:	78 b8                	js     8006f5 <vprintfmt+0x1e5>
  80073d:	ff 4d e0             	decl   -0x20(%ebp)
  800740:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800744:	79 af                	jns    8006f5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800746:	eb 13                	jmp    80075b <vprintfmt+0x24b>
				putch(' ', putdat);
  800748:	83 ec 08             	sub    $0x8,%esp
  80074b:	ff 75 0c             	pushl  0xc(%ebp)
  80074e:	6a 20                	push   $0x20
  800750:	8b 45 08             	mov    0x8(%ebp),%eax
  800753:	ff d0                	call   *%eax
  800755:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800758:	ff 4d e4             	decl   -0x1c(%ebp)
  80075b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80075f:	7f e7                	jg     800748 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800761:	e9 66 01 00 00       	jmp    8008cc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800766:	83 ec 08             	sub    $0x8,%esp
  800769:	ff 75 e8             	pushl  -0x18(%ebp)
  80076c:	8d 45 14             	lea    0x14(%ebp),%eax
  80076f:	50                   	push   %eax
  800770:	e8 3c fd ff ff       	call   8004b1 <getint>
  800775:	83 c4 10             	add    $0x10,%esp
  800778:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80077e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800781:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800784:	85 d2                	test   %edx,%edx
  800786:	79 23                	jns    8007ab <vprintfmt+0x29b>
				putch('-', putdat);
  800788:	83 ec 08             	sub    $0x8,%esp
  80078b:	ff 75 0c             	pushl  0xc(%ebp)
  80078e:	6a 2d                	push   $0x2d
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	ff d0                	call   *%eax
  800795:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800798:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80079b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80079e:	f7 d8                	neg    %eax
  8007a0:	83 d2 00             	adc    $0x0,%edx
  8007a3:	f7 da                	neg    %edx
  8007a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007ab:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007b2:	e9 bc 00 00 00       	jmp    800873 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007b7:	83 ec 08             	sub    $0x8,%esp
  8007ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8007bd:	8d 45 14             	lea    0x14(%ebp),%eax
  8007c0:	50                   	push   %eax
  8007c1:	e8 84 fc ff ff       	call   80044a <getuint>
  8007c6:	83 c4 10             	add    $0x10,%esp
  8007c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007cc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007cf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007d6:	e9 98 00 00 00       	jmp    800873 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007db:	83 ec 08             	sub    $0x8,%esp
  8007de:	ff 75 0c             	pushl  0xc(%ebp)
  8007e1:	6a 58                	push   $0x58
  8007e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e6:	ff d0                	call   *%eax
  8007e8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007eb:	83 ec 08             	sub    $0x8,%esp
  8007ee:	ff 75 0c             	pushl  0xc(%ebp)
  8007f1:	6a 58                	push   $0x58
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	ff d0                	call   *%eax
  8007f8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007fb:	83 ec 08             	sub    $0x8,%esp
  8007fe:	ff 75 0c             	pushl  0xc(%ebp)
  800801:	6a 58                	push   $0x58
  800803:	8b 45 08             	mov    0x8(%ebp),%eax
  800806:	ff d0                	call   *%eax
  800808:	83 c4 10             	add    $0x10,%esp
			break;
  80080b:	e9 bc 00 00 00       	jmp    8008cc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800810:	83 ec 08             	sub    $0x8,%esp
  800813:	ff 75 0c             	pushl  0xc(%ebp)
  800816:	6a 30                	push   $0x30
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	ff d0                	call   *%eax
  80081d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800820:	83 ec 08             	sub    $0x8,%esp
  800823:	ff 75 0c             	pushl  0xc(%ebp)
  800826:	6a 78                	push   $0x78
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	ff d0                	call   *%eax
  80082d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800830:	8b 45 14             	mov    0x14(%ebp),%eax
  800833:	83 c0 04             	add    $0x4,%eax
  800836:	89 45 14             	mov    %eax,0x14(%ebp)
  800839:	8b 45 14             	mov    0x14(%ebp),%eax
  80083c:	83 e8 04             	sub    $0x4,%eax
  80083f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800841:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800844:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80084b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800852:	eb 1f                	jmp    800873 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800854:	83 ec 08             	sub    $0x8,%esp
  800857:	ff 75 e8             	pushl  -0x18(%ebp)
  80085a:	8d 45 14             	lea    0x14(%ebp),%eax
  80085d:	50                   	push   %eax
  80085e:	e8 e7 fb ff ff       	call   80044a <getuint>
  800863:	83 c4 10             	add    $0x10,%esp
  800866:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800869:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80086c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800873:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800877:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80087a:	83 ec 04             	sub    $0x4,%esp
  80087d:	52                   	push   %edx
  80087e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800881:	50                   	push   %eax
  800882:	ff 75 f4             	pushl  -0xc(%ebp)
  800885:	ff 75 f0             	pushl  -0x10(%ebp)
  800888:	ff 75 0c             	pushl  0xc(%ebp)
  80088b:	ff 75 08             	pushl  0x8(%ebp)
  80088e:	e8 00 fb ff ff       	call   800393 <printnum>
  800893:	83 c4 20             	add    $0x20,%esp
			break;
  800896:	eb 34                	jmp    8008cc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800898:	83 ec 08             	sub    $0x8,%esp
  80089b:	ff 75 0c             	pushl  0xc(%ebp)
  80089e:	53                   	push   %ebx
  80089f:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a2:	ff d0                	call   *%eax
  8008a4:	83 c4 10             	add    $0x10,%esp
			break;
  8008a7:	eb 23                	jmp    8008cc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008a9:	83 ec 08             	sub    $0x8,%esp
  8008ac:	ff 75 0c             	pushl  0xc(%ebp)
  8008af:	6a 25                	push   $0x25
  8008b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b4:	ff d0                	call   *%eax
  8008b6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008b9:	ff 4d 10             	decl   0x10(%ebp)
  8008bc:	eb 03                	jmp    8008c1 <vprintfmt+0x3b1>
  8008be:	ff 4d 10             	decl   0x10(%ebp)
  8008c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c4:	48                   	dec    %eax
  8008c5:	8a 00                	mov    (%eax),%al
  8008c7:	3c 25                	cmp    $0x25,%al
  8008c9:	75 f3                	jne    8008be <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008cb:	90                   	nop
		}
	}
  8008cc:	e9 47 fc ff ff       	jmp    800518 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008d1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d5:	5b                   	pop    %ebx
  8008d6:	5e                   	pop    %esi
  8008d7:	5d                   	pop    %ebp
  8008d8:	c3                   	ret    

008008d9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008d9:	55                   	push   %ebp
  8008da:	89 e5                	mov    %esp,%ebp
  8008dc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008df:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e2:	83 c0 04             	add    $0x4,%eax
  8008e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ee:	50                   	push   %eax
  8008ef:	ff 75 0c             	pushl  0xc(%ebp)
  8008f2:	ff 75 08             	pushl  0x8(%ebp)
  8008f5:	e8 16 fc ff ff       	call   800510 <vprintfmt>
  8008fa:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008fd:	90                   	nop
  8008fe:	c9                   	leave  
  8008ff:	c3                   	ret    

00800900 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800900:	55                   	push   %ebp
  800901:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800903:	8b 45 0c             	mov    0xc(%ebp),%eax
  800906:	8b 40 08             	mov    0x8(%eax),%eax
  800909:	8d 50 01             	lea    0x1(%eax),%edx
  80090c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800912:	8b 45 0c             	mov    0xc(%ebp),%eax
  800915:	8b 10                	mov    (%eax),%edx
  800917:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091a:	8b 40 04             	mov    0x4(%eax),%eax
  80091d:	39 c2                	cmp    %eax,%edx
  80091f:	73 12                	jae    800933 <sprintputch+0x33>
		*b->buf++ = ch;
  800921:	8b 45 0c             	mov    0xc(%ebp),%eax
  800924:	8b 00                	mov    (%eax),%eax
  800926:	8d 48 01             	lea    0x1(%eax),%ecx
  800929:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092c:	89 0a                	mov    %ecx,(%edx)
  80092e:	8b 55 08             	mov    0x8(%ebp),%edx
  800931:	88 10                	mov    %dl,(%eax)
}
  800933:	90                   	nop
  800934:	5d                   	pop    %ebp
  800935:	c3                   	ret    

00800936 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800936:	55                   	push   %ebp
  800937:	89 e5                	mov    %esp,%ebp
  800939:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80093c:	8b 45 08             	mov    0x8(%ebp),%eax
  80093f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800942:	8b 45 0c             	mov    0xc(%ebp),%eax
  800945:	8d 50 ff             	lea    -0x1(%eax),%edx
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	01 d0                	add    %edx,%eax
  80094d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800950:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800957:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80095b:	74 06                	je     800963 <vsnprintf+0x2d>
  80095d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800961:	7f 07                	jg     80096a <vsnprintf+0x34>
		return -E_INVAL;
  800963:	b8 03 00 00 00       	mov    $0x3,%eax
  800968:	eb 20                	jmp    80098a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80096a:	ff 75 14             	pushl  0x14(%ebp)
  80096d:	ff 75 10             	pushl  0x10(%ebp)
  800970:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800973:	50                   	push   %eax
  800974:	68 00 09 80 00       	push   $0x800900
  800979:	e8 92 fb ff ff       	call   800510 <vprintfmt>
  80097e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800981:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800984:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800987:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80098a:	c9                   	leave  
  80098b:	c3                   	ret    

0080098c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80098c:	55                   	push   %ebp
  80098d:	89 e5                	mov    %esp,%ebp
  80098f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800992:	8d 45 10             	lea    0x10(%ebp),%eax
  800995:	83 c0 04             	add    $0x4,%eax
  800998:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80099b:	8b 45 10             	mov    0x10(%ebp),%eax
  80099e:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a1:	50                   	push   %eax
  8009a2:	ff 75 0c             	pushl  0xc(%ebp)
  8009a5:	ff 75 08             	pushl  0x8(%ebp)
  8009a8:	e8 89 ff ff ff       	call   800936 <vsnprintf>
  8009ad:	83 c4 10             	add    $0x10,%esp
  8009b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009b6:	c9                   	leave  
  8009b7:	c3                   	ret    

008009b8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009b8:	55                   	push   %ebp
  8009b9:	89 e5                	mov    %esp,%ebp
  8009bb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c5:	eb 06                	jmp    8009cd <strlen+0x15>
		n++;
  8009c7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009ca:	ff 45 08             	incl   0x8(%ebp)
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	8a 00                	mov    (%eax),%al
  8009d2:	84 c0                	test   %al,%al
  8009d4:	75 f1                	jne    8009c7 <strlen+0xf>
		n++;
	return n;
  8009d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
  8009de:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009e8:	eb 09                	jmp    8009f3 <strnlen+0x18>
		n++;
  8009ea:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009ed:	ff 45 08             	incl   0x8(%ebp)
  8009f0:	ff 4d 0c             	decl   0xc(%ebp)
  8009f3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009f7:	74 09                	je     800a02 <strnlen+0x27>
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8a 00                	mov    (%eax),%al
  8009fe:	84 c0                	test   %al,%al
  800a00:	75 e8                	jne    8009ea <strnlen+0xf>
		n++;
	return n;
  800a02:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a05:	c9                   	leave  
  800a06:	c3                   	ret    

00800a07 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a07:	55                   	push   %ebp
  800a08:	89 e5                	mov    %esp,%ebp
  800a0a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a13:	90                   	nop
  800a14:	8b 45 08             	mov    0x8(%ebp),%eax
  800a17:	8d 50 01             	lea    0x1(%eax),%edx
  800a1a:	89 55 08             	mov    %edx,0x8(%ebp)
  800a1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a20:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a23:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a26:	8a 12                	mov    (%edx),%dl
  800a28:	88 10                	mov    %dl,(%eax)
  800a2a:	8a 00                	mov    (%eax),%al
  800a2c:	84 c0                	test   %al,%al
  800a2e:	75 e4                	jne    800a14 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a30:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a33:	c9                   	leave  
  800a34:	c3                   	ret    

00800a35 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a35:	55                   	push   %ebp
  800a36:	89 e5                	mov    %esp,%ebp
  800a38:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a41:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a48:	eb 1f                	jmp    800a69 <strncpy+0x34>
		*dst++ = *src;
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	8d 50 01             	lea    0x1(%eax),%edx
  800a50:	89 55 08             	mov    %edx,0x8(%ebp)
  800a53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a56:	8a 12                	mov    (%edx),%dl
  800a58:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5d:	8a 00                	mov    (%eax),%al
  800a5f:	84 c0                	test   %al,%al
  800a61:	74 03                	je     800a66 <strncpy+0x31>
			src++;
  800a63:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a66:	ff 45 fc             	incl   -0x4(%ebp)
  800a69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a6c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a6f:	72 d9                	jb     800a4a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a71:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a74:	c9                   	leave  
  800a75:	c3                   	ret    

00800a76 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a76:	55                   	push   %ebp
  800a77:	89 e5                	mov    %esp,%ebp
  800a79:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a82:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a86:	74 30                	je     800ab8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a88:	eb 16                	jmp    800aa0 <strlcpy+0x2a>
			*dst++ = *src++;
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	8d 50 01             	lea    0x1(%eax),%edx
  800a90:	89 55 08             	mov    %edx,0x8(%ebp)
  800a93:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a96:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a99:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a9c:	8a 12                	mov    (%edx),%dl
  800a9e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800aa0:	ff 4d 10             	decl   0x10(%ebp)
  800aa3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa7:	74 09                	je     800ab2 <strlcpy+0x3c>
  800aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aac:	8a 00                	mov    (%eax),%al
  800aae:	84 c0                	test   %al,%al
  800ab0:	75 d8                	jne    800a8a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ab8:	8b 55 08             	mov    0x8(%ebp),%edx
  800abb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800abe:	29 c2                	sub    %eax,%edx
  800ac0:	89 d0                	mov    %edx,%eax
}
  800ac2:	c9                   	leave  
  800ac3:	c3                   	ret    

00800ac4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ac4:	55                   	push   %ebp
  800ac5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ac7:	eb 06                	jmp    800acf <strcmp+0xb>
		p++, q++;
  800ac9:	ff 45 08             	incl   0x8(%ebp)
  800acc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8a 00                	mov    (%eax),%al
  800ad4:	84 c0                	test   %al,%al
  800ad6:	74 0e                	je     800ae6 <strcmp+0x22>
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8a 10                	mov    (%eax),%dl
  800add:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae0:	8a 00                	mov    (%eax),%al
  800ae2:	38 c2                	cmp    %al,%dl
  800ae4:	74 e3                	je     800ac9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	8a 00                	mov    (%eax),%al
  800aeb:	0f b6 d0             	movzbl %al,%edx
  800aee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af1:	8a 00                	mov    (%eax),%al
  800af3:	0f b6 c0             	movzbl %al,%eax
  800af6:	29 c2                	sub    %eax,%edx
  800af8:	89 d0                	mov    %edx,%eax
}
  800afa:	5d                   	pop    %ebp
  800afb:	c3                   	ret    

00800afc <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800afc:	55                   	push   %ebp
  800afd:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800aff:	eb 09                	jmp    800b0a <strncmp+0xe>
		n--, p++, q++;
  800b01:	ff 4d 10             	decl   0x10(%ebp)
  800b04:	ff 45 08             	incl   0x8(%ebp)
  800b07:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b0a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b0e:	74 17                	je     800b27 <strncmp+0x2b>
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8a 00                	mov    (%eax),%al
  800b15:	84 c0                	test   %al,%al
  800b17:	74 0e                	je     800b27 <strncmp+0x2b>
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	8a 10                	mov    (%eax),%dl
  800b1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b21:	8a 00                	mov    (%eax),%al
  800b23:	38 c2                	cmp    %al,%dl
  800b25:	74 da                	je     800b01 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b27:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b2b:	75 07                	jne    800b34 <strncmp+0x38>
		return 0;
  800b2d:	b8 00 00 00 00       	mov    $0x0,%eax
  800b32:	eb 14                	jmp    800b48 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8a 00                	mov    (%eax),%al
  800b39:	0f b6 d0             	movzbl %al,%edx
  800b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3f:	8a 00                	mov    (%eax),%al
  800b41:	0f b6 c0             	movzbl %al,%eax
  800b44:	29 c2                	sub    %eax,%edx
  800b46:	89 d0                	mov    %edx,%eax
}
  800b48:	5d                   	pop    %ebp
  800b49:	c3                   	ret    

00800b4a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b4a:	55                   	push   %ebp
  800b4b:	89 e5                	mov    %esp,%ebp
  800b4d:	83 ec 04             	sub    $0x4,%esp
  800b50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b53:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b56:	eb 12                	jmp    800b6a <strchr+0x20>
		if (*s == c)
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	8a 00                	mov    (%eax),%al
  800b5d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b60:	75 05                	jne    800b67 <strchr+0x1d>
			return (char *) s;
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	eb 11                	jmp    800b78 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b67:	ff 45 08             	incl   0x8(%ebp)
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	8a 00                	mov    (%eax),%al
  800b6f:	84 c0                	test   %al,%al
  800b71:	75 e5                	jne    800b58 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b73:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b78:	c9                   	leave  
  800b79:	c3                   	ret    

00800b7a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b7a:	55                   	push   %ebp
  800b7b:	89 e5                	mov    %esp,%ebp
  800b7d:	83 ec 04             	sub    $0x4,%esp
  800b80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b83:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b86:	eb 0d                	jmp    800b95 <strfind+0x1b>
		if (*s == c)
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8a 00                	mov    (%eax),%al
  800b8d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b90:	74 0e                	je     800ba0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b92:	ff 45 08             	incl   0x8(%ebp)
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	8a 00                	mov    (%eax),%al
  800b9a:	84 c0                	test   %al,%al
  800b9c:	75 ea                	jne    800b88 <strfind+0xe>
  800b9e:	eb 01                	jmp    800ba1 <strfind+0x27>
		if (*s == c)
			break;
  800ba0:	90                   	nop
	return (char *) s;
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba4:	c9                   	leave  
  800ba5:	c3                   	ret    

00800ba6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ba6:	55                   	push   %ebp
  800ba7:	89 e5                	mov    %esp,%ebp
  800ba9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bb8:	eb 0e                	jmp    800bc8 <memset+0x22>
		*p++ = c;
  800bba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bbd:	8d 50 01             	lea    0x1(%eax),%edx
  800bc0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bc8:	ff 4d f8             	decl   -0x8(%ebp)
  800bcb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bcf:	79 e9                	jns    800bba <memset+0x14>
		*p++ = c;

	return v;
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd4:	c9                   	leave  
  800bd5:	c3                   	ret    

00800bd6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bd6:	55                   	push   %ebp
  800bd7:	89 e5                	mov    %esp,%ebp
  800bd9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800be8:	eb 16                	jmp    800c00 <memcpy+0x2a>
		*d++ = *s++;
  800bea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bed:	8d 50 01             	lea    0x1(%eax),%edx
  800bf0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bf3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bf6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bfc:	8a 12                	mov    (%edx),%dl
  800bfe:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c00:	8b 45 10             	mov    0x10(%ebp),%eax
  800c03:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c06:	89 55 10             	mov    %edx,0x10(%ebp)
  800c09:	85 c0                	test   %eax,%eax
  800c0b:	75 dd                	jne    800bea <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c10:	c9                   	leave  
  800c11:	c3                   	ret    

00800c12 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c12:	55                   	push   %ebp
  800c13:	89 e5                	mov    %esp,%ebp
  800c15:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800c18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c21:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c27:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c2a:	73 50                	jae    800c7c <memmove+0x6a>
  800c2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c32:	01 d0                	add    %edx,%eax
  800c34:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c37:	76 43                	jbe    800c7c <memmove+0x6a>
		s += n;
  800c39:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c3f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c42:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c45:	eb 10                	jmp    800c57 <memmove+0x45>
			*--d = *--s;
  800c47:	ff 4d f8             	decl   -0x8(%ebp)
  800c4a:	ff 4d fc             	decl   -0x4(%ebp)
  800c4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c50:	8a 10                	mov    (%eax),%dl
  800c52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c55:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c57:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c5d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c60:	85 c0                	test   %eax,%eax
  800c62:	75 e3                	jne    800c47 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c64:	eb 23                	jmp    800c89 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c66:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c69:	8d 50 01             	lea    0x1(%eax),%edx
  800c6c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c6f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c72:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c75:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c78:	8a 12                	mov    (%edx),%dl
  800c7a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c82:	89 55 10             	mov    %edx,0x10(%ebp)
  800c85:	85 c0                	test   %eax,%eax
  800c87:	75 dd                	jne    800c66 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c8c:	c9                   	leave  
  800c8d:	c3                   	ret    

00800c8e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c8e:	55                   	push   %ebp
  800c8f:	89 e5                	mov    %esp,%ebp
  800c91:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ca0:	eb 2a                	jmp    800ccc <memcmp+0x3e>
		if (*s1 != *s2)
  800ca2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca5:	8a 10                	mov    (%eax),%dl
  800ca7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	38 c2                	cmp    %al,%dl
  800cae:	74 16                	je     800cc6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb3:	8a 00                	mov    (%eax),%al
  800cb5:	0f b6 d0             	movzbl %al,%edx
  800cb8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cbb:	8a 00                	mov    (%eax),%al
  800cbd:	0f b6 c0             	movzbl %al,%eax
  800cc0:	29 c2                	sub    %eax,%edx
  800cc2:	89 d0                	mov    %edx,%eax
  800cc4:	eb 18                	jmp    800cde <memcmp+0x50>
		s1++, s2++;
  800cc6:	ff 45 fc             	incl   -0x4(%ebp)
  800cc9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ccc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd5:	85 c0                	test   %eax,%eax
  800cd7:	75 c9                	jne    800ca2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cd9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cde:	c9                   	leave  
  800cdf:	c3                   	ret    

00800ce0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ce0:	55                   	push   %ebp
  800ce1:	89 e5                	mov    %esp,%ebp
  800ce3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ce6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce9:	8b 45 10             	mov    0x10(%ebp),%eax
  800cec:	01 d0                	add    %edx,%eax
  800cee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cf1:	eb 15                	jmp    800d08 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	8a 00                	mov    (%eax),%al
  800cf8:	0f b6 d0             	movzbl %al,%edx
  800cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfe:	0f b6 c0             	movzbl %al,%eax
  800d01:	39 c2                	cmp    %eax,%edx
  800d03:	74 0d                	je     800d12 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d05:	ff 45 08             	incl   0x8(%ebp)
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d0e:	72 e3                	jb     800cf3 <memfind+0x13>
  800d10:	eb 01                	jmp    800d13 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d12:	90                   	nop
	return (void *) s;
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d16:	c9                   	leave  
  800d17:	c3                   	ret    

00800d18 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d18:	55                   	push   %ebp
  800d19:	89 e5                	mov    %esp,%ebp
  800d1b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d1e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d25:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d2c:	eb 03                	jmp    800d31 <strtol+0x19>
		s++;
  800d2e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	3c 20                	cmp    $0x20,%al
  800d38:	74 f4                	je     800d2e <strtol+0x16>
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	3c 09                	cmp    $0x9,%al
  800d41:	74 eb                	je     800d2e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	3c 2b                	cmp    $0x2b,%al
  800d4a:	75 05                	jne    800d51 <strtol+0x39>
		s++;
  800d4c:	ff 45 08             	incl   0x8(%ebp)
  800d4f:	eb 13                	jmp    800d64 <strtol+0x4c>
	else if (*s == '-')
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	3c 2d                	cmp    $0x2d,%al
  800d58:	75 0a                	jne    800d64 <strtol+0x4c>
		s++, neg = 1;
  800d5a:	ff 45 08             	incl   0x8(%ebp)
  800d5d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d64:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d68:	74 06                	je     800d70 <strtol+0x58>
  800d6a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d6e:	75 20                	jne    800d90 <strtol+0x78>
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	3c 30                	cmp    $0x30,%al
  800d77:	75 17                	jne    800d90 <strtol+0x78>
  800d79:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7c:	40                   	inc    %eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	3c 78                	cmp    $0x78,%al
  800d81:	75 0d                	jne    800d90 <strtol+0x78>
		s += 2, base = 16;
  800d83:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d87:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d8e:	eb 28                	jmp    800db8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d94:	75 15                	jne    800dab <strtol+0x93>
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
  800d99:	8a 00                	mov    (%eax),%al
  800d9b:	3c 30                	cmp    $0x30,%al
  800d9d:	75 0c                	jne    800dab <strtol+0x93>
		s++, base = 8;
  800d9f:	ff 45 08             	incl   0x8(%ebp)
  800da2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800da9:	eb 0d                	jmp    800db8 <strtol+0xa0>
	else if (base == 0)
  800dab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800daf:	75 07                	jne    800db8 <strtol+0xa0>
		base = 10;
  800db1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	8a 00                	mov    (%eax),%al
  800dbd:	3c 2f                	cmp    $0x2f,%al
  800dbf:	7e 19                	jle    800dda <strtol+0xc2>
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	3c 39                	cmp    $0x39,%al
  800dc8:	7f 10                	jg     800dda <strtol+0xc2>
			dig = *s - '0';
  800dca:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcd:	8a 00                	mov    (%eax),%al
  800dcf:	0f be c0             	movsbl %al,%eax
  800dd2:	83 e8 30             	sub    $0x30,%eax
  800dd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dd8:	eb 42                	jmp    800e1c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	8a 00                	mov    (%eax),%al
  800ddf:	3c 60                	cmp    $0x60,%al
  800de1:	7e 19                	jle    800dfc <strtol+0xe4>
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	3c 7a                	cmp    $0x7a,%al
  800dea:	7f 10                	jg     800dfc <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	8a 00                	mov    (%eax),%al
  800df1:	0f be c0             	movsbl %al,%eax
  800df4:	83 e8 57             	sub    $0x57,%eax
  800df7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dfa:	eb 20                	jmp    800e1c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	8a 00                	mov    (%eax),%al
  800e01:	3c 40                	cmp    $0x40,%al
  800e03:	7e 39                	jle    800e3e <strtol+0x126>
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	3c 5a                	cmp    $0x5a,%al
  800e0c:	7f 30                	jg     800e3e <strtol+0x126>
			dig = *s - 'A' + 10;
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	0f be c0             	movsbl %al,%eax
  800e16:	83 e8 37             	sub    $0x37,%eax
  800e19:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e1f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e22:	7d 19                	jge    800e3d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e24:	ff 45 08             	incl   0x8(%ebp)
  800e27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2a:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e2e:	89 c2                	mov    %eax,%edx
  800e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e33:	01 d0                	add    %edx,%eax
  800e35:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e38:	e9 7b ff ff ff       	jmp    800db8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e3d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e42:	74 08                	je     800e4c <strtol+0x134>
		*endptr = (char *) s;
  800e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e47:	8b 55 08             	mov    0x8(%ebp),%edx
  800e4a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e4c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e50:	74 07                	je     800e59 <strtol+0x141>
  800e52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e55:	f7 d8                	neg    %eax
  800e57:	eb 03                	jmp    800e5c <strtol+0x144>
  800e59:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e5c:	c9                   	leave  
  800e5d:	c3                   	ret    

00800e5e <ltostr>:

void
ltostr(long value, char *str)
{
  800e5e:	55                   	push   %ebp
  800e5f:	89 e5                	mov    %esp,%ebp
  800e61:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e6b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e72:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e76:	79 13                	jns    800e8b <ltostr+0x2d>
	{
		neg = 1;
  800e78:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e82:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e85:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e88:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e93:	99                   	cltd   
  800e94:	f7 f9                	idiv   %ecx
  800e96:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9c:	8d 50 01             	lea    0x1(%eax),%edx
  800e9f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea2:	89 c2                	mov    %eax,%edx
  800ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea7:	01 d0                	add    %edx,%eax
  800ea9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800eac:	83 c2 30             	add    $0x30,%edx
  800eaf:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800eb1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eb4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb9:	f7 e9                	imul   %ecx
  800ebb:	c1 fa 02             	sar    $0x2,%edx
  800ebe:	89 c8                	mov    %ecx,%eax
  800ec0:	c1 f8 1f             	sar    $0x1f,%eax
  800ec3:	29 c2                	sub    %eax,%edx
  800ec5:	89 d0                	mov    %edx,%eax
  800ec7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800eca:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ecd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ed2:	f7 e9                	imul   %ecx
  800ed4:	c1 fa 02             	sar    $0x2,%edx
  800ed7:	89 c8                	mov    %ecx,%eax
  800ed9:	c1 f8 1f             	sar    $0x1f,%eax
  800edc:	29 c2                	sub    %eax,%edx
  800ede:	89 d0                	mov    %edx,%eax
  800ee0:	c1 e0 02             	shl    $0x2,%eax
  800ee3:	01 d0                	add    %edx,%eax
  800ee5:	01 c0                	add    %eax,%eax
  800ee7:	29 c1                	sub    %eax,%ecx
  800ee9:	89 ca                	mov    %ecx,%edx
  800eeb:	85 d2                	test   %edx,%edx
  800eed:	75 9c                	jne    800e8b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800eef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ef6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef9:	48                   	dec    %eax
  800efa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800efd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f01:	74 3d                	je     800f40 <ltostr+0xe2>
		start = 1 ;
  800f03:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f0a:	eb 34                	jmp    800f40 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f12:	01 d0                	add    %edx,%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1f:	01 c2                	add    %eax,%edx
  800f21:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f27:	01 c8                	add    %ecx,%eax
  800f29:	8a 00                	mov    (%eax),%al
  800f2b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f2d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	01 c2                	add    %eax,%edx
  800f35:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f38:	88 02                	mov    %al,(%edx)
		start++ ;
  800f3a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f3d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f43:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f46:	7c c4                	jl     800f0c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f48:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4e:	01 d0                	add    %edx,%eax
  800f50:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f53:	90                   	nop
  800f54:	c9                   	leave  
  800f55:	c3                   	ret    

00800f56 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f56:	55                   	push   %ebp
  800f57:	89 e5                	mov    %esp,%ebp
  800f59:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f5c:	ff 75 08             	pushl  0x8(%ebp)
  800f5f:	e8 54 fa ff ff       	call   8009b8 <strlen>
  800f64:	83 c4 04             	add    $0x4,%esp
  800f67:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f6a:	ff 75 0c             	pushl  0xc(%ebp)
  800f6d:	e8 46 fa ff ff       	call   8009b8 <strlen>
  800f72:	83 c4 04             	add    $0x4,%esp
  800f75:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f86:	eb 17                	jmp    800f9f <strcconcat+0x49>
		final[s] = str1[s] ;
  800f88:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8e:	01 c2                	add    %eax,%edx
  800f90:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	01 c8                	add    %ecx,%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f9c:	ff 45 fc             	incl   -0x4(%ebp)
  800f9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fa5:	7c e1                	jl     800f88 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fa7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fb5:	eb 1f                	jmp    800fd6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fba:	8d 50 01             	lea    0x1(%eax),%edx
  800fbd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fc0:	89 c2                	mov    %eax,%edx
  800fc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc5:	01 c2                	add    %eax,%edx
  800fc7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcd:	01 c8                	add    %ecx,%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fd3:	ff 45 f8             	incl   -0x8(%ebp)
  800fd6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fdc:	7c d9                	jl     800fb7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fde:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fe1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe4:	01 d0                	add    %edx,%eax
  800fe6:	c6 00 00             	movb   $0x0,(%eax)
}
  800fe9:	90                   	nop
  800fea:	c9                   	leave  
  800feb:	c3                   	ret    

00800fec <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fec:	55                   	push   %ebp
  800fed:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fef:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ff8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffb:	8b 00                	mov    (%eax),%eax
  800ffd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801004:	8b 45 10             	mov    0x10(%ebp),%eax
  801007:	01 d0                	add    %edx,%eax
  801009:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80100f:	eb 0c                	jmp    80101d <strsplit+0x31>
			*string++ = 0;
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	8d 50 01             	lea    0x1(%eax),%edx
  801017:	89 55 08             	mov    %edx,0x8(%ebp)
  80101a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	8a 00                	mov    (%eax),%al
  801022:	84 c0                	test   %al,%al
  801024:	74 18                	je     80103e <strsplit+0x52>
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	8a 00                	mov    (%eax),%al
  80102b:	0f be c0             	movsbl %al,%eax
  80102e:	50                   	push   %eax
  80102f:	ff 75 0c             	pushl  0xc(%ebp)
  801032:	e8 13 fb ff ff       	call   800b4a <strchr>
  801037:	83 c4 08             	add    $0x8,%esp
  80103a:	85 c0                	test   %eax,%eax
  80103c:	75 d3                	jne    801011 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	84 c0                	test   %al,%al
  801045:	74 5a                	je     8010a1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801047:	8b 45 14             	mov    0x14(%ebp),%eax
  80104a:	8b 00                	mov    (%eax),%eax
  80104c:	83 f8 0f             	cmp    $0xf,%eax
  80104f:	75 07                	jne    801058 <strsplit+0x6c>
		{
			return 0;
  801051:	b8 00 00 00 00       	mov    $0x0,%eax
  801056:	eb 66                	jmp    8010be <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801058:	8b 45 14             	mov    0x14(%ebp),%eax
  80105b:	8b 00                	mov    (%eax),%eax
  80105d:	8d 48 01             	lea    0x1(%eax),%ecx
  801060:	8b 55 14             	mov    0x14(%ebp),%edx
  801063:	89 0a                	mov    %ecx,(%edx)
  801065:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80106c:	8b 45 10             	mov    0x10(%ebp),%eax
  80106f:	01 c2                	add    %eax,%edx
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801076:	eb 03                	jmp    80107b <strsplit+0x8f>
			string++;
  801078:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8a 00                	mov    (%eax),%al
  801080:	84 c0                	test   %al,%al
  801082:	74 8b                	je     80100f <strsplit+0x23>
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	8a 00                	mov    (%eax),%al
  801089:	0f be c0             	movsbl %al,%eax
  80108c:	50                   	push   %eax
  80108d:	ff 75 0c             	pushl  0xc(%ebp)
  801090:	e8 b5 fa ff ff       	call   800b4a <strchr>
  801095:	83 c4 08             	add    $0x8,%esp
  801098:	85 c0                	test   %eax,%eax
  80109a:	74 dc                	je     801078 <strsplit+0x8c>
			string++;
	}
  80109c:	e9 6e ff ff ff       	jmp    80100f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010a1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a5:	8b 00                	mov    (%eax),%eax
  8010a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b1:	01 d0                	add    %edx,%eax
  8010b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010b9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	57                   	push   %edi
  8010c4:	56                   	push   %esi
  8010c5:	53                   	push   %ebx
  8010c6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010d2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010d5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8010d8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8010db:	cd 30                	int    $0x30
  8010dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8010e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010e3:	83 c4 10             	add    $0x10,%esp
  8010e6:	5b                   	pop    %ebx
  8010e7:	5e                   	pop    %esi
  8010e8:	5f                   	pop    %edi
  8010e9:	5d                   	pop    %ebp
  8010ea:	c3                   	ret    

008010eb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
  8010ee:	83 ec 04             	sub    $0x4,%esp
  8010f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8010f7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	6a 00                	push   $0x0
  801100:	6a 00                	push   $0x0
  801102:	52                   	push   %edx
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	50                   	push   %eax
  801107:	6a 00                	push   $0x0
  801109:	e8 b2 ff ff ff       	call   8010c0 <syscall>
  80110e:	83 c4 18             	add    $0x18,%esp
}
  801111:	90                   	nop
  801112:	c9                   	leave  
  801113:	c3                   	ret    

00801114 <sys_cgetc>:

int
sys_cgetc(void)
{
  801114:	55                   	push   %ebp
  801115:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801117:	6a 00                	push   $0x0
  801119:	6a 00                	push   $0x0
  80111b:	6a 00                	push   $0x0
  80111d:	6a 00                	push   $0x0
  80111f:	6a 00                	push   $0x0
  801121:	6a 01                	push   $0x1
  801123:	e8 98 ff ff ff       	call   8010c0 <syscall>
  801128:	83 c4 18             	add    $0x18,%esp
}
  80112b:	c9                   	leave  
  80112c:	c3                   	ret    

0080112d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	6a 00                	push   $0x0
  801135:	6a 00                	push   $0x0
  801137:	6a 00                	push   $0x0
  801139:	6a 00                	push   $0x0
  80113b:	50                   	push   %eax
  80113c:	6a 05                	push   $0x5
  80113e:	e8 7d ff ff ff       	call   8010c0 <syscall>
  801143:	83 c4 18             	add    $0x18,%esp
}
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80114b:	6a 00                	push   $0x0
  80114d:	6a 00                	push   $0x0
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	6a 00                	push   $0x0
  801155:	6a 02                	push   $0x2
  801157:	e8 64 ff ff ff       	call   8010c0 <syscall>
  80115c:	83 c4 18             	add    $0x18,%esp
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801164:	6a 00                	push   $0x0
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	6a 00                	push   $0x0
  80116e:	6a 03                	push   $0x3
  801170:	e8 4b ff ff ff       	call   8010c0 <syscall>
  801175:	83 c4 18             	add    $0x18,%esp
}
  801178:	c9                   	leave  
  801179:	c3                   	ret    

0080117a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80117d:	6a 00                	push   $0x0
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 00                	push   $0x0
  801187:	6a 04                	push   $0x4
  801189:	e8 32 ff ff ff       	call   8010c0 <syscall>
  80118e:	83 c4 18             	add    $0x18,%esp
}
  801191:	c9                   	leave  
  801192:	c3                   	ret    

00801193 <sys_env_exit>:


void sys_env_exit(void)
{
  801193:	55                   	push   %ebp
  801194:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 06                	push   $0x6
  8011a2:	e8 19 ff ff ff       	call   8010c0 <syscall>
  8011a7:	83 c4 18             	add    $0x18,%esp
}
  8011aa:	90                   	nop
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8011b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	6a 00                	push   $0x0
  8011b8:	6a 00                	push   $0x0
  8011ba:	6a 00                	push   $0x0
  8011bc:	52                   	push   %edx
  8011bd:	50                   	push   %eax
  8011be:	6a 07                	push   $0x7
  8011c0:	e8 fb fe ff ff       	call   8010c0 <syscall>
  8011c5:	83 c4 18             	add    $0x18,%esp
}
  8011c8:	c9                   	leave  
  8011c9:	c3                   	ret    

008011ca <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8011ca:	55                   	push   %ebp
  8011cb:	89 e5                	mov    %esp,%ebp
  8011cd:	56                   	push   %esi
  8011ce:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8011cf:	8b 75 18             	mov    0x18(%ebp),%esi
  8011d2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	56                   	push   %esi
  8011df:	53                   	push   %ebx
  8011e0:	51                   	push   %ecx
  8011e1:	52                   	push   %edx
  8011e2:	50                   	push   %eax
  8011e3:	6a 08                	push   $0x8
  8011e5:	e8 d6 fe ff ff       	call   8010c0 <syscall>
  8011ea:	83 c4 18             	add    $0x18,%esp
}
  8011ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011f0:	5b                   	pop    %ebx
  8011f1:	5e                   	pop    %esi
  8011f2:	5d                   	pop    %ebp
  8011f3:	c3                   	ret    

008011f4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8011f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	52                   	push   %edx
  801204:	50                   	push   %eax
  801205:	6a 09                	push   $0x9
  801207:	e8 b4 fe ff ff       	call   8010c0 <syscall>
  80120c:	83 c4 18             	add    $0x18,%esp
}
  80120f:	c9                   	leave  
  801210:	c3                   	ret    

00801211 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801211:	55                   	push   %ebp
  801212:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801214:	6a 00                	push   $0x0
  801216:	6a 00                	push   $0x0
  801218:	6a 00                	push   $0x0
  80121a:	ff 75 0c             	pushl  0xc(%ebp)
  80121d:	ff 75 08             	pushl  0x8(%ebp)
  801220:	6a 0a                	push   $0xa
  801222:	e8 99 fe ff ff       	call   8010c0 <syscall>
  801227:	83 c4 18             	add    $0x18,%esp
}
  80122a:	c9                   	leave  
  80122b:	c3                   	ret    

0080122c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80122c:	55                   	push   %ebp
  80122d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 0b                	push   $0xb
  80123b:	e8 80 fe ff ff       	call   8010c0 <syscall>
  801240:	83 c4 18             	add    $0x18,%esp
}
  801243:	c9                   	leave  
  801244:	c3                   	ret    

00801245 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801245:	55                   	push   %ebp
  801246:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 0c                	push   $0xc
  801254:	e8 67 fe ff ff       	call   8010c0 <syscall>
  801259:	83 c4 18             	add    $0x18,%esp
}
  80125c:	c9                   	leave  
  80125d:	c3                   	ret    

0080125e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80125e:	55                   	push   %ebp
  80125f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	6a 0d                	push   $0xd
  80126d:	e8 4e fe ff ff       	call   8010c0 <syscall>
  801272:	83 c4 18             	add    $0x18,%esp
}
  801275:	c9                   	leave  
  801276:	c3                   	ret    

00801277 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801277:	55                   	push   %ebp
  801278:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	ff 75 0c             	pushl  0xc(%ebp)
  801283:	ff 75 08             	pushl  0x8(%ebp)
  801286:	6a 11                	push   $0x11
  801288:	e8 33 fe ff ff       	call   8010c0 <syscall>
  80128d:	83 c4 18             	add    $0x18,%esp
	return;
  801290:	90                   	nop
}
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	ff 75 0c             	pushl  0xc(%ebp)
  80129f:	ff 75 08             	pushl  0x8(%ebp)
  8012a2:	6a 12                	push   $0x12
  8012a4:	e8 17 fe ff ff       	call   8010c0 <syscall>
  8012a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8012ac:	90                   	nop
}
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 0e                	push   $0xe
  8012be:	e8 fd fd ff ff       	call   8010c0 <syscall>
  8012c3:	83 c4 18             	add    $0x18,%esp
}
  8012c6:	c9                   	leave  
  8012c7:	c3                   	ret    

008012c8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	ff 75 08             	pushl  0x8(%ebp)
  8012d6:	6a 0f                	push   $0xf
  8012d8:	e8 e3 fd ff ff       	call   8010c0 <syscall>
  8012dd:	83 c4 18             	add    $0x18,%esp
}
  8012e0:	c9                   	leave  
  8012e1:	c3                   	ret    

008012e2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8012e2:	55                   	push   %ebp
  8012e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 10                	push   $0x10
  8012f1:	e8 ca fd ff ff       	call   8010c0 <syscall>
  8012f6:	83 c4 18             	add    $0x18,%esp
}
  8012f9:	90                   	nop
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 14                	push   $0x14
  80130b:	e8 b0 fd ff ff       	call   8010c0 <syscall>
  801310:	83 c4 18             	add    $0x18,%esp
}
  801313:	90                   	nop
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 15                	push   $0x15
  801325:	e8 96 fd ff ff       	call   8010c0 <syscall>
  80132a:	83 c4 18             	add    $0x18,%esp
}
  80132d:	90                   	nop
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <sys_cputc>:


void
sys_cputc(const char c)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
  801333:	83 ec 04             	sub    $0x4,%esp
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80133c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	50                   	push   %eax
  801349:	6a 16                	push   $0x16
  80134b:	e8 70 fd ff ff       	call   8010c0 <syscall>
  801350:	83 c4 18             	add    $0x18,%esp
}
  801353:	90                   	nop
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801359:	6a 00                	push   $0x0
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 17                	push   $0x17
  801365:	e8 56 fd ff ff       	call   8010c0 <syscall>
  80136a:	83 c4 18             	add    $0x18,%esp
}
  80136d:	90                   	nop
  80136e:	c9                   	leave  
  80136f:	c3                   	ret    

00801370 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801370:	55                   	push   %ebp
  801371:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	ff 75 0c             	pushl  0xc(%ebp)
  80137f:	50                   	push   %eax
  801380:	6a 18                	push   $0x18
  801382:	e8 39 fd ff ff       	call   8010c0 <syscall>
  801387:	83 c4 18             	add    $0x18,%esp
}
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80138f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	52                   	push   %edx
  80139c:	50                   	push   %eax
  80139d:	6a 1b                	push   $0x1b
  80139f:	e8 1c fd ff ff       	call   8010c0 <syscall>
  8013a4:	83 c4 18             	add    $0x18,%esp
}
  8013a7:	c9                   	leave  
  8013a8:	c3                   	ret    

008013a9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013a9:	55                   	push   %ebp
  8013aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013af:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	52                   	push   %edx
  8013b9:	50                   	push   %eax
  8013ba:	6a 19                	push   $0x19
  8013bc:	e8 ff fc ff ff       	call   8010c0 <syscall>
  8013c1:	83 c4 18             	add    $0x18,%esp
}
  8013c4:	90                   	nop
  8013c5:	c9                   	leave  
  8013c6:	c3                   	ret    

008013c7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013c7:	55                   	push   %ebp
  8013c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	52                   	push   %edx
  8013d7:	50                   	push   %eax
  8013d8:	6a 1a                	push   $0x1a
  8013da:	e8 e1 fc ff ff       	call   8010c0 <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	90                   	nop
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
  8013e8:	83 ec 04             	sub    $0x4,%esp
  8013eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8013f1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8013f4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	6a 00                	push   $0x0
  8013fd:	51                   	push   %ecx
  8013fe:	52                   	push   %edx
  8013ff:	ff 75 0c             	pushl  0xc(%ebp)
  801402:	50                   	push   %eax
  801403:	6a 1c                	push   $0x1c
  801405:	e8 b6 fc ff ff       	call   8010c0 <syscall>
  80140a:	83 c4 18             	add    $0x18,%esp
}
  80140d:	c9                   	leave  
  80140e:	c3                   	ret    

0080140f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80140f:	55                   	push   %ebp
  801410:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801412:	8b 55 0c             	mov    0xc(%ebp),%edx
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	52                   	push   %edx
  80141f:	50                   	push   %eax
  801420:	6a 1d                	push   $0x1d
  801422:	e8 99 fc ff ff       	call   8010c0 <syscall>
  801427:	83 c4 18             	add    $0x18,%esp
}
  80142a:	c9                   	leave  
  80142b:	c3                   	ret    

0080142c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80142c:	55                   	push   %ebp
  80142d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80142f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801432:	8b 55 0c             	mov    0xc(%ebp),%edx
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	51                   	push   %ecx
  80143d:	52                   	push   %edx
  80143e:	50                   	push   %eax
  80143f:	6a 1e                	push   $0x1e
  801441:	e8 7a fc ff ff       	call   8010c0 <syscall>
  801446:	83 c4 18             	add    $0x18,%esp
}
  801449:	c9                   	leave  
  80144a:	c3                   	ret    

0080144b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80144b:	55                   	push   %ebp
  80144c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80144e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	52                   	push   %edx
  80145b:	50                   	push   %eax
  80145c:	6a 1f                	push   $0x1f
  80145e:	e8 5d fc ff ff       	call   8010c0 <syscall>
  801463:	83 c4 18             	add    $0x18,%esp
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 20                	push   $0x20
  801477:	e8 44 fc ff ff       	call   8010c0 <syscall>
  80147c:	83 c4 18             	add    $0x18,%esp
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	ff 75 10             	pushl  0x10(%ebp)
  80148e:	ff 75 0c             	pushl  0xc(%ebp)
  801491:	50                   	push   %eax
  801492:	6a 21                	push   $0x21
  801494:	e8 27 fc ff ff       	call   8010c0 <syscall>
  801499:	83 c4 18             	add    $0x18,%esp
}
  80149c:	c9                   	leave  
  80149d:	c3                   	ret    

0080149e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	50                   	push   %eax
  8014ad:	6a 22                	push   $0x22
  8014af:	e8 0c fc ff ff       	call   8010c0 <syscall>
  8014b4:	83 c4 18             	add    $0x18,%esp
}
  8014b7:	90                   	nop
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	50                   	push   %eax
  8014c9:	6a 23                	push   $0x23
  8014cb:	e8 f0 fb ff ff       	call   8010c0 <syscall>
  8014d0:	83 c4 18             	add    $0x18,%esp
}
  8014d3:	90                   	nop
  8014d4:	c9                   	leave  
  8014d5:	c3                   	ret    

008014d6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8014d6:	55                   	push   %ebp
  8014d7:	89 e5                	mov    %esp,%ebp
  8014d9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8014dc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014df:	8d 50 04             	lea    0x4(%eax),%edx
  8014e2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	52                   	push   %edx
  8014ec:	50                   	push   %eax
  8014ed:	6a 24                	push   $0x24
  8014ef:	e8 cc fb ff ff       	call   8010c0 <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
	return result;
  8014f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801500:	89 01                	mov    %eax,(%ecx)
  801502:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801505:	8b 45 08             	mov    0x8(%ebp),%eax
  801508:	c9                   	leave  
  801509:	c2 04 00             	ret    $0x4

0080150c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	ff 75 10             	pushl  0x10(%ebp)
  801516:	ff 75 0c             	pushl  0xc(%ebp)
  801519:	ff 75 08             	pushl  0x8(%ebp)
  80151c:	6a 13                	push   $0x13
  80151e:	e8 9d fb ff ff       	call   8010c0 <syscall>
  801523:	83 c4 18             	add    $0x18,%esp
	return ;
  801526:	90                   	nop
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_rcr2>:
uint32 sys_rcr2()
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 25                	push   $0x25
  801538:	e8 83 fb ff ff       	call   8010c0 <syscall>
  80153d:	83 c4 18             	add    $0x18,%esp
}
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
  801545:	83 ec 04             	sub    $0x4,%esp
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80154e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	50                   	push   %eax
  80155b:	6a 26                	push   $0x26
  80155d:	e8 5e fb ff ff       	call   8010c0 <syscall>
  801562:	83 c4 18             	add    $0x18,%esp
	return ;
  801565:	90                   	nop
}
  801566:	c9                   	leave  
  801567:	c3                   	ret    

00801568 <rsttst>:
void rsttst()
{
  801568:	55                   	push   %ebp
  801569:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 28                	push   $0x28
  801577:	e8 44 fb ff ff       	call   8010c0 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
	return ;
  80157f:	90                   	nop
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 04             	sub    $0x4,%esp
  801588:	8b 45 14             	mov    0x14(%ebp),%eax
  80158b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80158e:	8b 55 18             	mov    0x18(%ebp),%edx
  801591:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801595:	52                   	push   %edx
  801596:	50                   	push   %eax
  801597:	ff 75 10             	pushl  0x10(%ebp)
  80159a:	ff 75 0c             	pushl  0xc(%ebp)
  80159d:	ff 75 08             	pushl  0x8(%ebp)
  8015a0:	6a 27                	push   $0x27
  8015a2:	e8 19 fb ff ff       	call   8010c0 <syscall>
  8015a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8015aa:	90                   	nop
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <chktst>:
void chktst(uint32 n)
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	ff 75 08             	pushl  0x8(%ebp)
  8015bb:	6a 29                	push   $0x29
  8015bd:	e8 fe fa ff ff       	call   8010c0 <syscall>
  8015c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c5:	90                   	nop
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <inctst>:

void inctst()
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 2a                	push   $0x2a
  8015d7:	e8 e4 fa ff ff       	call   8010c0 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8015df:	90                   	nop
}
  8015e0:	c9                   	leave  
  8015e1:	c3                   	ret    

008015e2 <gettst>:
uint32 gettst()
{
  8015e2:	55                   	push   %ebp
  8015e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 2b                	push   $0x2b
  8015f1:	e8 ca fa ff ff       	call   8010c0 <syscall>
  8015f6:	83 c4 18             	add    $0x18,%esp
}
  8015f9:	c9                   	leave  
  8015fa:	c3                   	ret    

008015fb <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8015fb:	55                   	push   %ebp
  8015fc:	89 e5                	mov    %esp,%ebp
  8015fe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 2c                	push   $0x2c
  80160d:	e8 ae fa ff ff       	call   8010c0 <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
  801615:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801618:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80161c:	75 07                	jne    801625 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80161e:	b8 01 00 00 00       	mov    $0x1,%eax
  801623:	eb 05                	jmp    80162a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801625:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
  80162f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 2c                	push   $0x2c
  80163e:	e8 7d fa ff ff       	call   8010c0 <syscall>
  801643:	83 c4 18             	add    $0x18,%esp
  801646:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801649:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80164d:	75 07                	jne    801656 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80164f:	b8 01 00 00 00       	mov    $0x1,%eax
  801654:	eb 05                	jmp    80165b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801656:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
  801660:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 2c                	push   $0x2c
  80166f:	e8 4c fa ff ff       	call   8010c0 <syscall>
  801674:	83 c4 18             	add    $0x18,%esp
  801677:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80167a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80167e:	75 07                	jne    801687 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801680:	b8 01 00 00 00       	mov    $0x1,%eax
  801685:	eb 05                	jmp    80168c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801687:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80168c:	c9                   	leave  
  80168d:	c3                   	ret    

0080168e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80168e:	55                   	push   %ebp
  80168f:	89 e5                	mov    %esp,%ebp
  801691:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 2c                	push   $0x2c
  8016a0:	e8 1b fa ff ff       	call   8010c0 <syscall>
  8016a5:	83 c4 18             	add    $0x18,%esp
  8016a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8016ab:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8016af:	75 07                	jne    8016b8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8016b1:	b8 01 00 00 00       	mov    $0x1,%eax
  8016b6:	eb 05                	jmp    8016bd <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8016b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	ff 75 08             	pushl  0x8(%ebp)
  8016cd:	6a 2d                	push   $0x2d
  8016cf:	e8 ec f9 ff ff       	call   8010c0 <syscall>
  8016d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d7:	90                   	nop
}
  8016d8:	c9                   	leave  
  8016d9:	c3                   	ret    

008016da <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
  8016dd:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8016e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8016e3:	89 d0                	mov    %edx,%eax
  8016e5:	c1 e0 02             	shl    $0x2,%eax
  8016e8:	01 d0                	add    %edx,%eax
  8016ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f1:	01 d0                	add    %edx,%eax
  8016f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016fa:	01 d0                	add    %edx,%eax
  8016fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801703:	01 d0                	add    %edx,%eax
  801705:	c1 e0 04             	shl    $0x4,%eax
  801708:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80170b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801712:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801715:	83 ec 0c             	sub    $0xc,%esp
  801718:	50                   	push   %eax
  801719:	e8 b8 fd ff ff       	call   8014d6 <sys_get_virtual_time>
  80171e:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801721:	eb 41                	jmp    801764 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801723:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801726:	83 ec 0c             	sub    $0xc,%esp
  801729:	50                   	push   %eax
  80172a:	e8 a7 fd ff ff       	call   8014d6 <sys_get_virtual_time>
  80172f:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801732:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801735:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801738:	29 c2                	sub    %eax,%edx
  80173a:	89 d0                	mov    %edx,%eax
  80173c:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80173f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801742:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801745:	89 d1                	mov    %edx,%ecx
  801747:	29 c1                	sub    %eax,%ecx
  801749:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80174c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80174f:	39 c2                	cmp    %eax,%edx
  801751:	0f 97 c0             	seta   %al
  801754:	0f b6 c0             	movzbl %al,%eax
  801757:	29 c1                	sub    %eax,%ecx
  801759:	89 c8                	mov    %ecx,%eax
  80175b:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80175e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801761:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801764:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801767:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80176a:	72 b7                	jb     801723 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80176c:	90                   	nop
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
  801772:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801775:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80177c:	eb 03                	jmp    801781 <busy_wait+0x12>
  80177e:	ff 45 fc             	incl   -0x4(%ebp)
  801781:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801784:	3b 45 08             	cmp    0x8(%ebp),%eax
  801787:	72 f5                	jb     80177e <busy_wait+0xf>
	return i;
  801789:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80178c:	c9                   	leave  
  80178d:	c3                   	ret    
  80178e:	66 90                	xchg   %ax,%ax

00801790 <__udivdi3>:
  801790:	55                   	push   %ebp
  801791:	57                   	push   %edi
  801792:	56                   	push   %esi
  801793:	53                   	push   %ebx
  801794:	83 ec 1c             	sub    $0x1c,%esp
  801797:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80179b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80179f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017a3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8017a7:	89 ca                	mov    %ecx,%edx
  8017a9:	89 f8                	mov    %edi,%eax
  8017ab:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8017af:	85 f6                	test   %esi,%esi
  8017b1:	75 2d                	jne    8017e0 <__udivdi3+0x50>
  8017b3:	39 cf                	cmp    %ecx,%edi
  8017b5:	77 65                	ja     80181c <__udivdi3+0x8c>
  8017b7:	89 fd                	mov    %edi,%ebp
  8017b9:	85 ff                	test   %edi,%edi
  8017bb:	75 0b                	jne    8017c8 <__udivdi3+0x38>
  8017bd:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c2:	31 d2                	xor    %edx,%edx
  8017c4:	f7 f7                	div    %edi
  8017c6:	89 c5                	mov    %eax,%ebp
  8017c8:	31 d2                	xor    %edx,%edx
  8017ca:	89 c8                	mov    %ecx,%eax
  8017cc:	f7 f5                	div    %ebp
  8017ce:	89 c1                	mov    %eax,%ecx
  8017d0:	89 d8                	mov    %ebx,%eax
  8017d2:	f7 f5                	div    %ebp
  8017d4:	89 cf                	mov    %ecx,%edi
  8017d6:	89 fa                	mov    %edi,%edx
  8017d8:	83 c4 1c             	add    $0x1c,%esp
  8017db:	5b                   	pop    %ebx
  8017dc:	5e                   	pop    %esi
  8017dd:	5f                   	pop    %edi
  8017de:	5d                   	pop    %ebp
  8017df:	c3                   	ret    
  8017e0:	39 ce                	cmp    %ecx,%esi
  8017e2:	77 28                	ja     80180c <__udivdi3+0x7c>
  8017e4:	0f bd fe             	bsr    %esi,%edi
  8017e7:	83 f7 1f             	xor    $0x1f,%edi
  8017ea:	75 40                	jne    80182c <__udivdi3+0x9c>
  8017ec:	39 ce                	cmp    %ecx,%esi
  8017ee:	72 0a                	jb     8017fa <__udivdi3+0x6a>
  8017f0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8017f4:	0f 87 9e 00 00 00    	ja     801898 <__udivdi3+0x108>
  8017fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ff:	89 fa                	mov    %edi,%edx
  801801:	83 c4 1c             	add    $0x1c,%esp
  801804:	5b                   	pop    %ebx
  801805:	5e                   	pop    %esi
  801806:	5f                   	pop    %edi
  801807:	5d                   	pop    %ebp
  801808:	c3                   	ret    
  801809:	8d 76 00             	lea    0x0(%esi),%esi
  80180c:	31 ff                	xor    %edi,%edi
  80180e:	31 c0                	xor    %eax,%eax
  801810:	89 fa                	mov    %edi,%edx
  801812:	83 c4 1c             	add    $0x1c,%esp
  801815:	5b                   	pop    %ebx
  801816:	5e                   	pop    %esi
  801817:	5f                   	pop    %edi
  801818:	5d                   	pop    %ebp
  801819:	c3                   	ret    
  80181a:	66 90                	xchg   %ax,%ax
  80181c:	89 d8                	mov    %ebx,%eax
  80181e:	f7 f7                	div    %edi
  801820:	31 ff                	xor    %edi,%edi
  801822:	89 fa                	mov    %edi,%edx
  801824:	83 c4 1c             	add    $0x1c,%esp
  801827:	5b                   	pop    %ebx
  801828:	5e                   	pop    %esi
  801829:	5f                   	pop    %edi
  80182a:	5d                   	pop    %ebp
  80182b:	c3                   	ret    
  80182c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801831:	89 eb                	mov    %ebp,%ebx
  801833:	29 fb                	sub    %edi,%ebx
  801835:	89 f9                	mov    %edi,%ecx
  801837:	d3 e6                	shl    %cl,%esi
  801839:	89 c5                	mov    %eax,%ebp
  80183b:	88 d9                	mov    %bl,%cl
  80183d:	d3 ed                	shr    %cl,%ebp
  80183f:	89 e9                	mov    %ebp,%ecx
  801841:	09 f1                	or     %esi,%ecx
  801843:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801847:	89 f9                	mov    %edi,%ecx
  801849:	d3 e0                	shl    %cl,%eax
  80184b:	89 c5                	mov    %eax,%ebp
  80184d:	89 d6                	mov    %edx,%esi
  80184f:	88 d9                	mov    %bl,%cl
  801851:	d3 ee                	shr    %cl,%esi
  801853:	89 f9                	mov    %edi,%ecx
  801855:	d3 e2                	shl    %cl,%edx
  801857:	8b 44 24 08          	mov    0x8(%esp),%eax
  80185b:	88 d9                	mov    %bl,%cl
  80185d:	d3 e8                	shr    %cl,%eax
  80185f:	09 c2                	or     %eax,%edx
  801861:	89 d0                	mov    %edx,%eax
  801863:	89 f2                	mov    %esi,%edx
  801865:	f7 74 24 0c          	divl   0xc(%esp)
  801869:	89 d6                	mov    %edx,%esi
  80186b:	89 c3                	mov    %eax,%ebx
  80186d:	f7 e5                	mul    %ebp
  80186f:	39 d6                	cmp    %edx,%esi
  801871:	72 19                	jb     80188c <__udivdi3+0xfc>
  801873:	74 0b                	je     801880 <__udivdi3+0xf0>
  801875:	89 d8                	mov    %ebx,%eax
  801877:	31 ff                	xor    %edi,%edi
  801879:	e9 58 ff ff ff       	jmp    8017d6 <__udivdi3+0x46>
  80187e:	66 90                	xchg   %ax,%ax
  801880:	8b 54 24 08          	mov    0x8(%esp),%edx
  801884:	89 f9                	mov    %edi,%ecx
  801886:	d3 e2                	shl    %cl,%edx
  801888:	39 c2                	cmp    %eax,%edx
  80188a:	73 e9                	jae    801875 <__udivdi3+0xe5>
  80188c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80188f:	31 ff                	xor    %edi,%edi
  801891:	e9 40 ff ff ff       	jmp    8017d6 <__udivdi3+0x46>
  801896:	66 90                	xchg   %ax,%ax
  801898:	31 c0                	xor    %eax,%eax
  80189a:	e9 37 ff ff ff       	jmp    8017d6 <__udivdi3+0x46>
  80189f:	90                   	nop

008018a0 <__umoddi3>:
  8018a0:	55                   	push   %ebp
  8018a1:	57                   	push   %edi
  8018a2:	56                   	push   %esi
  8018a3:	53                   	push   %ebx
  8018a4:	83 ec 1c             	sub    $0x1c,%esp
  8018a7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8018ab:	8b 74 24 34          	mov    0x34(%esp),%esi
  8018af:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8018b3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8018b7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8018bb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8018bf:	89 f3                	mov    %esi,%ebx
  8018c1:	89 fa                	mov    %edi,%edx
  8018c3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018c7:	89 34 24             	mov    %esi,(%esp)
  8018ca:	85 c0                	test   %eax,%eax
  8018cc:	75 1a                	jne    8018e8 <__umoddi3+0x48>
  8018ce:	39 f7                	cmp    %esi,%edi
  8018d0:	0f 86 a2 00 00 00    	jbe    801978 <__umoddi3+0xd8>
  8018d6:	89 c8                	mov    %ecx,%eax
  8018d8:	89 f2                	mov    %esi,%edx
  8018da:	f7 f7                	div    %edi
  8018dc:	89 d0                	mov    %edx,%eax
  8018de:	31 d2                	xor    %edx,%edx
  8018e0:	83 c4 1c             	add    $0x1c,%esp
  8018e3:	5b                   	pop    %ebx
  8018e4:	5e                   	pop    %esi
  8018e5:	5f                   	pop    %edi
  8018e6:	5d                   	pop    %ebp
  8018e7:	c3                   	ret    
  8018e8:	39 f0                	cmp    %esi,%eax
  8018ea:	0f 87 ac 00 00 00    	ja     80199c <__umoddi3+0xfc>
  8018f0:	0f bd e8             	bsr    %eax,%ebp
  8018f3:	83 f5 1f             	xor    $0x1f,%ebp
  8018f6:	0f 84 ac 00 00 00    	je     8019a8 <__umoddi3+0x108>
  8018fc:	bf 20 00 00 00       	mov    $0x20,%edi
  801901:	29 ef                	sub    %ebp,%edi
  801903:	89 fe                	mov    %edi,%esi
  801905:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801909:	89 e9                	mov    %ebp,%ecx
  80190b:	d3 e0                	shl    %cl,%eax
  80190d:	89 d7                	mov    %edx,%edi
  80190f:	89 f1                	mov    %esi,%ecx
  801911:	d3 ef                	shr    %cl,%edi
  801913:	09 c7                	or     %eax,%edi
  801915:	89 e9                	mov    %ebp,%ecx
  801917:	d3 e2                	shl    %cl,%edx
  801919:	89 14 24             	mov    %edx,(%esp)
  80191c:	89 d8                	mov    %ebx,%eax
  80191e:	d3 e0                	shl    %cl,%eax
  801920:	89 c2                	mov    %eax,%edx
  801922:	8b 44 24 08          	mov    0x8(%esp),%eax
  801926:	d3 e0                	shl    %cl,%eax
  801928:	89 44 24 04          	mov    %eax,0x4(%esp)
  80192c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801930:	89 f1                	mov    %esi,%ecx
  801932:	d3 e8                	shr    %cl,%eax
  801934:	09 d0                	or     %edx,%eax
  801936:	d3 eb                	shr    %cl,%ebx
  801938:	89 da                	mov    %ebx,%edx
  80193a:	f7 f7                	div    %edi
  80193c:	89 d3                	mov    %edx,%ebx
  80193e:	f7 24 24             	mull   (%esp)
  801941:	89 c6                	mov    %eax,%esi
  801943:	89 d1                	mov    %edx,%ecx
  801945:	39 d3                	cmp    %edx,%ebx
  801947:	0f 82 87 00 00 00    	jb     8019d4 <__umoddi3+0x134>
  80194d:	0f 84 91 00 00 00    	je     8019e4 <__umoddi3+0x144>
  801953:	8b 54 24 04          	mov    0x4(%esp),%edx
  801957:	29 f2                	sub    %esi,%edx
  801959:	19 cb                	sbb    %ecx,%ebx
  80195b:	89 d8                	mov    %ebx,%eax
  80195d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801961:	d3 e0                	shl    %cl,%eax
  801963:	89 e9                	mov    %ebp,%ecx
  801965:	d3 ea                	shr    %cl,%edx
  801967:	09 d0                	or     %edx,%eax
  801969:	89 e9                	mov    %ebp,%ecx
  80196b:	d3 eb                	shr    %cl,%ebx
  80196d:	89 da                	mov    %ebx,%edx
  80196f:	83 c4 1c             	add    $0x1c,%esp
  801972:	5b                   	pop    %ebx
  801973:	5e                   	pop    %esi
  801974:	5f                   	pop    %edi
  801975:	5d                   	pop    %ebp
  801976:	c3                   	ret    
  801977:	90                   	nop
  801978:	89 fd                	mov    %edi,%ebp
  80197a:	85 ff                	test   %edi,%edi
  80197c:	75 0b                	jne    801989 <__umoddi3+0xe9>
  80197e:	b8 01 00 00 00       	mov    $0x1,%eax
  801983:	31 d2                	xor    %edx,%edx
  801985:	f7 f7                	div    %edi
  801987:	89 c5                	mov    %eax,%ebp
  801989:	89 f0                	mov    %esi,%eax
  80198b:	31 d2                	xor    %edx,%edx
  80198d:	f7 f5                	div    %ebp
  80198f:	89 c8                	mov    %ecx,%eax
  801991:	f7 f5                	div    %ebp
  801993:	89 d0                	mov    %edx,%eax
  801995:	e9 44 ff ff ff       	jmp    8018de <__umoddi3+0x3e>
  80199a:	66 90                	xchg   %ax,%ax
  80199c:	89 c8                	mov    %ecx,%eax
  80199e:	89 f2                	mov    %esi,%edx
  8019a0:	83 c4 1c             	add    $0x1c,%esp
  8019a3:	5b                   	pop    %ebx
  8019a4:	5e                   	pop    %esi
  8019a5:	5f                   	pop    %edi
  8019a6:	5d                   	pop    %ebp
  8019a7:	c3                   	ret    
  8019a8:	3b 04 24             	cmp    (%esp),%eax
  8019ab:	72 06                	jb     8019b3 <__umoddi3+0x113>
  8019ad:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8019b1:	77 0f                	ja     8019c2 <__umoddi3+0x122>
  8019b3:	89 f2                	mov    %esi,%edx
  8019b5:	29 f9                	sub    %edi,%ecx
  8019b7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8019bb:	89 14 24             	mov    %edx,(%esp)
  8019be:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019c2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8019c6:	8b 14 24             	mov    (%esp),%edx
  8019c9:	83 c4 1c             	add    $0x1c,%esp
  8019cc:	5b                   	pop    %ebx
  8019cd:	5e                   	pop    %esi
  8019ce:	5f                   	pop    %edi
  8019cf:	5d                   	pop    %ebp
  8019d0:	c3                   	ret    
  8019d1:	8d 76 00             	lea    0x0(%esi),%esi
  8019d4:	2b 04 24             	sub    (%esp),%eax
  8019d7:	19 fa                	sbb    %edi,%edx
  8019d9:	89 d1                	mov    %edx,%ecx
  8019db:	89 c6                	mov    %eax,%esi
  8019dd:	e9 71 ff ff ff       	jmp    801953 <__umoddi3+0xb3>
  8019e2:	66 90                	xchg   %ax,%ax
  8019e4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8019e8:	72 ea                	jb     8019d4 <__umoddi3+0x134>
  8019ea:	89 d9                	mov    %ebx,%ecx
  8019ec:	e9 62 ff ff ff       	jmp    801953 <__umoddi3+0xb3>
