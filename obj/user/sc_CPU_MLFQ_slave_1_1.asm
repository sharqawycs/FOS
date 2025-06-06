
obj/user/sc_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 11 01 00 00       	call   800147 <libmain>
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
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 04 20 80 00       	mov    0x802004,%eax
  80004c:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800052:	a1 04 20 80 00       	mov    0x802004,%eax
  800057:	8b 40 74             	mov    0x74(%eax),%eax
  80005a:	83 ec 04             	sub    $0x4,%esp
  80005d:	52                   	push   %edx
  80005e:	50                   	push   %eax
  80005f:	68 e0 19 80 00       	push   $0x8019e0
  800064:	e8 ff 13 00 00       	call   801468 <sys_create_env>
  800069:	83 c4 10             	add    $0x10,%esp
  80006c:	89 45 ec             	mov    %eax,-0x14(%ebp)
			sys_run_env(ID);
  80006f:	83 ec 0c             	sub    $0xc,%esp
  800072:	ff 75 ec             	pushl  -0x14(%ebp)
  800075:	e8 0b 14 00 00       	call   801485 <sys_run_env>
  80007a:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  80007d:	ff 45 f4             	incl   -0xc(%ebp)
  800080:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  800084:	7e c1                	jle    800047 <_main+0xf>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 40 42 0f 00       	push   $0xf4240
  80008e:	e8 c3 16 00 00       	call   801756 <busy_wait>
  800093:	83 c4 10             	add    $0x10,%esp
  800096:	89 45 e8             	mov    %eax,-0x18(%ebp)

	for (int i = 0; i < 5; ++i) {
  800099:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000a0:	e9 82 00 00 00       	jmp    800127 <_main+0xef>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000a5:	a1 04 20 80 00       	mov    0x802004,%eax
  8000aa:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000b0:	a1 04 20 80 00       	mov    0x802004,%eax
  8000b5:	8b 40 74             	mov    0x74(%eax),%eax
  8000b8:	83 ec 04             	sub    $0x4,%esp
  8000bb:	52                   	push   %edx
  8000bc:	50                   	push   %eax
  8000bd:	68 e0 19 80 00       	push   $0x8019e0
  8000c2:	e8 a1 13 00 00       	call   801468 <sys_create_env>
  8000c7:	83 c4 10             	add    $0x10,%esp
  8000ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
			sys_run_env(ID);
  8000cd:	83 ec 0c             	sub    $0xc,%esp
  8000d0:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d3:	e8 ad 13 00 00       	call   801485 <sys_run_env>
  8000d8:	83 c4 10             	add    $0x10,%esp
			x = busy_wait(10000);
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 10 27 00 00       	push   $0x2710
  8000e3:	e8 6e 16 00 00       	call   801756 <busy_wait>
  8000e8:	83 c4 10             	add    $0x10,%esp
  8000eb:	89 45 e8             	mov    %eax,-0x18(%ebp)
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000ee:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f3:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000f9:	a1 04 20 80 00       	mov    0x802004,%eax
  8000fe:	8b 40 74             	mov    0x74(%eax),%eax
  800101:	83 ec 04             	sub    $0x4,%esp
  800104:	52                   	push   %edx
  800105:	50                   	push   %eax
  800106:	68 e0 19 80 00       	push   $0x8019e0
  80010b:	e8 58 13 00 00       	call   801468 <sys_create_env>
  800110:	83 c4 10             	add    $0x10,%esp
  800113:	89 45 ec             	mov    %eax,-0x14(%ebp)
			sys_run_env(ID);
  800116:	83 ec 0c             	sub    $0xc,%esp
  800119:	ff 75 ec             	pushl  -0x14(%ebp)
  80011c:	e8 64 13 00 00       	call   801485 <sys_run_env>
  800121:	83 c4 10             	add    $0x10,%esp
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);

	for (int i = 0; i < 5; ++i) {
  800124:	ff 45 f0             	incl   -0x10(%ebp)
  800127:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  80012b:	0f 8e 74 ff ff ff    	jle    8000a5 <_main+0x6d>
			sys_run_env(ID);
			x = busy_wait(10000);
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	x = busy_wait(1000000);
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 40 42 0f 00       	push   $0xf4240
  800139:	e8 18 16 00 00       	call   801756 <busy_wait>
  80013e:	83 c4 10             	add    $0x10,%esp
  800141:	89 45 e8             	mov    %eax,-0x18(%ebp)

}
  800144:	90                   	nop
  800145:	c9                   	leave  
  800146:	c3                   	ret    

00800147 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800147:	55                   	push   %ebp
  800148:	89 e5                	mov    %esp,%ebp
  80014a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80014d:	e8 f6 0f 00 00       	call   801148 <sys_getenvindex>
  800152:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800155:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800158:	89 d0                	mov    %edx,%eax
  80015a:	01 c0                	add    %eax,%eax
  80015c:	01 d0                	add    %edx,%eax
  80015e:	c1 e0 02             	shl    $0x2,%eax
  800161:	01 d0                	add    %edx,%eax
  800163:	c1 e0 06             	shl    $0x6,%eax
  800166:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80016b:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800170:	a1 04 20 80 00       	mov    0x802004,%eax
  800175:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80017b:	84 c0                	test   %al,%al
  80017d:	74 0f                	je     80018e <libmain+0x47>
		binaryname = myEnv->prog_name;
  80017f:	a1 04 20 80 00       	mov    0x802004,%eax
  800184:	05 f4 02 00 00       	add    $0x2f4,%eax
  800189:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80018e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800192:	7e 0a                	jle    80019e <libmain+0x57>
		binaryname = argv[0];
  800194:	8b 45 0c             	mov    0xc(%ebp),%eax
  800197:	8b 00                	mov    (%eax),%eax
  800199:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	ff 75 0c             	pushl  0xc(%ebp)
  8001a4:	ff 75 08             	pushl  0x8(%ebp)
  8001a7:	e8 8c fe ff ff       	call   800038 <_main>
  8001ac:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001af:	e8 2f 11 00 00       	call   8012e3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001b4:	83 ec 0c             	sub    $0xc,%esp
  8001b7:	68 00 1a 80 00       	push   $0x801a00
  8001bc:	e8 5c 01 00 00       	call   80031d <cprintf>
  8001c1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001c4:	a1 04 20 80 00       	mov    0x802004,%eax
  8001c9:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001cf:	a1 04 20 80 00       	mov    0x802004,%eax
  8001d4:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001da:	83 ec 04             	sub    $0x4,%esp
  8001dd:	52                   	push   %edx
  8001de:	50                   	push   %eax
  8001df:	68 28 1a 80 00       	push   $0x801a28
  8001e4:	e8 34 01 00 00       	call   80031d <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001ec:	a1 04 20 80 00       	mov    0x802004,%eax
  8001f1:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001f7:	83 ec 08             	sub    $0x8,%esp
  8001fa:	50                   	push   %eax
  8001fb:	68 4d 1a 80 00       	push   $0x801a4d
  800200:	e8 18 01 00 00       	call   80031d <cprintf>
  800205:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800208:	83 ec 0c             	sub    $0xc,%esp
  80020b:	68 00 1a 80 00       	push   $0x801a00
  800210:	e8 08 01 00 00       	call   80031d <cprintf>
  800215:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800218:	e8 e0 10 00 00       	call   8012fd <sys_enable_interrupt>

	// exit gracefully
	exit();
  80021d:	e8 19 00 00 00       	call   80023b <exit>
}
  800222:	90                   	nop
  800223:	c9                   	leave  
  800224:	c3                   	ret    

00800225 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800225:	55                   	push   %ebp
  800226:	89 e5                	mov    %esp,%ebp
  800228:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80022b:	83 ec 0c             	sub    $0xc,%esp
  80022e:	6a 00                	push   $0x0
  800230:	e8 df 0e 00 00       	call   801114 <sys_env_destroy>
  800235:	83 c4 10             	add    $0x10,%esp
}
  800238:	90                   	nop
  800239:	c9                   	leave  
  80023a:	c3                   	ret    

0080023b <exit>:

void
exit(void)
{
  80023b:	55                   	push   %ebp
  80023c:	89 e5                	mov    %esp,%ebp
  80023e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800241:	e8 34 0f 00 00       	call   80117a <sys_env_exit>
}
  800246:	90                   	nop
  800247:	c9                   	leave  
  800248:	c3                   	ret    

00800249 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800249:	55                   	push   %ebp
  80024a:	89 e5                	mov    %esp,%ebp
  80024c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80024f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800252:	8b 00                	mov    (%eax),%eax
  800254:	8d 48 01             	lea    0x1(%eax),%ecx
  800257:	8b 55 0c             	mov    0xc(%ebp),%edx
  80025a:	89 0a                	mov    %ecx,(%edx)
  80025c:	8b 55 08             	mov    0x8(%ebp),%edx
  80025f:	88 d1                	mov    %dl,%cl
  800261:	8b 55 0c             	mov    0xc(%ebp),%edx
  800264:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026b:	8b 00                	mov    (%eax),%eax
  80026d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800272:	75 2c                	jne    8002a0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800274:	a0 08 20 80 00       	mov    0x802008,%al
  800279:	0f b6 c0             	movzbl %al,%eax
  80027c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80027f:	8b 12                	mov    (%edx),%edx
  800281:	89 d1                	mov    %edx,%ecx
  800283:	8b 55 0c             	mov    0xc(%ebp),%edx
  800286:	83 c2 08             	add    $0x8,%edx
  800289:	83 ec 04             	sub    $0x4,%esp
  80028c:	50                   	push   %eax
  80028d:	51                   	push   %ecx
  80028e:	52                   	push   %edx
  80028f:	e8 3e 0e 00 00       	call   8010d2 <sys_cputs>
  800294:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a3:	8b 40 04             	mov    0x4(%eax),%eax
  8002a6:	8d 50 01             	lea    0x1(%eax),%edx
  8002a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ac:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002af:	90                   	nop
  8002b0:	c9                   	leave  
  8002b1:	c3                   	ret    

008002b2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002b2:	55                   	push   %ebp
  8002b3:	89 e5                	mov    %esp,%ebp
  8002b5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002bb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002c2:	00 00 00 
	b.cnt = 0;
  8002c5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002cc:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002cf:	ff 75 0c             	pushl  0xc(%ebp)
  8002d2:	ff 75 08             	pushl  0x8(%ebp)
  8002d5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002db:	50                   	push   %eax
  8002dc:	68 49 02 80 00       	push   $0x800249
  8002e1:	e8 11 02 00 00       	call   8004f7 <vprintfmt>
  8002e6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002e9:	a0 08 20 80 00       	mov    0x802008,%al
  8002ee:	0f b6 c0             	movzbl %al,%eax
  8002f1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002f7:	83 ec 04             	sub    $0x4,%esp
  8002fa:	50                   	push   %eax
  8002fb:	52                   	push   %edx
  8002fc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800302:	83 c0 08             	add    $0x8,%eax
  800305:	50                   	push   %eax
  800306:	e8 c7 0d 00 00       	call   8010d2 <sys_cputs>
  80030b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80030e:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800315:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80031b:	c9                   	leave  
  80031c:	c3                   	ret    

0080031d <cprintf>:

int cprintf(const char *fmt, ...) {
  80031d:	55                   	push   %ebp
  80031e:	89 e5                	mov    %esp,%ebp
  800320:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800323:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  80032a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80032d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800330:	8b 45 08             	mov    0x8(%ebp),%eax
  800333:	83 ec 08             	sub    $0x8,%esp
  800336:	ff 75 f4             	pushl  -0xc(%ebp)
  800339:	50                   	push   %eax
  80033a:	e8 73 ff ff ff       	call   8002b2 <vcprintf>
  80033f:	83 c4 10             	add    $0x10,%esp
  800342:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800345:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800348:	c9                   	leave  
  800349:	c3                   	ret    

0080034a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80034a:	55                   	push   %ebp
  80034b:	89 e5                	mov    %esp,%ebp
  80034d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800350:	e8 8e 0f 00 00       	call   8012e3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800355:	8d 45 0c             	lea    0xc(%ebp),%eax
  800358:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80035b:	8b 45 08             	mov    0x8(%ebp),%eax
  80035e:	83 ec 08             	sub    $0x8,%esp
  800361:	ff 75 f4             	pushl  -0xc(%ebp)
  800364:	50                   	push   %eax
  800365:	e8 48 ff ff ff       	call   8002b2 <vcprintf>
  80036a:	83 c4 10             	add    $0x10,%esp
  80036d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800370:	e8 88 0f 00 00       	call   8012fd <sys_enable_interrupt>
	return cnt;
  800375:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800378:	c9                   	leave  
  800379:	c3                   	ret    

0080037a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80037a:	55                   	push   %ebp
  80037b:	89 e5                	mov    %esp,%ebp
  80037d:	53                   	push   %ebx
  80037e:	83 ec 14             	sub    $0x14,%esp
  800381:	8b 45 10             	mov    0x10(%ebp),%eax
  800384:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800387:	8b 45 14             	mov    0x14(%ebp),%eax
  80038a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80038d:	8b 45 18             	mov    0x18(%ebp),%eax
  800390:	ba 00 00 00 00       	mov    $0x0,%edx
  800395:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800398:	77 55                	ja     8003ef <printnum+0x75>
  80039a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80039d:	72 05                	jb     8003a4 <printnum+0x2a>
  80039f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003a2:	77 4b                	ja     8003ef <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003a4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003a7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003aa:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ad:	ba 00 00 00 00       	mov    $0x0,%edx
  8003b2:	52                   	push   %edx
  8003b3:	50                   	push   %eax
  8003b4:	ff 75 f4             	pushl  -0xc(%ebp)
  8003b7:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ba:	e8 b9 13 00 00       	call   801778 <__udivdi3>
  8003bf:	83 c4 10             	add    $0x10,%esp
  8003c2:	83 ec 04             	sub    $0x4,%esp
  8003c5:	ff 75 20             	pushl  0x20(%ebp)
  8003c8:	53                   	push   %ebx
  8003c9:	ff 75 18             	pushl  0x18(%ebp)
  8003cc:	52                   	push   %edx
  8003cd:	50                   	push   %eax
  8003ce:	ff 75 0c             	pushl  0xc(%ebp)
  8003d1:	ff 75 08             	pushl  0x8(%ebp)
  8003d4:	e8 a1 ff ff ff       	call   80037a <printnum>
  8003d9:	83 c4 20             	add    $0x20,%esp
  8003dc:	eb 1a                	jmp    8003f8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003de:	83 ec 08             	sub    $0x8,%esp
  8003e1:	ff 75 0c             	pushl  0xc(%ebp)
  8003e4:	ff 75 20             	pushl  0x20(%ebp)
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	ff d0                	call   *%eax
  8003ec:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ef:	ff 4d 1c             	decl   0x1c(%ebp)
  8003f2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003f6:	7f e6                	jg     8003de <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003f8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003fb:	bb 00 00 00 00       	mov    $0x0,%ebx
  800400:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800403:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800406:	53                   	push   %ebx
  800407:	51                   	push   %ecx
  800408:	52                   	push   %edx
  800409:	50                   	push   %eax
  80040a:	e8 79 14 00 00       	call   801888 <__umoddi3>
  80040f:	83 c4 10             	add    $0x10,%esp
  800412:	05 94 1c 80 00       	add    $0x801c94,%eax
  800417:	8a 00                	mov    (%eax),%al
  800419:	0f be c0             	movsbl %al,%eax
  80041c:	83 ec 08             	sub    $0x8,%esp
  80041f:	ff 75 0c             	pushl  0xc(%ebp)
  800422:	50                   	push   %eax
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	ff d0                	call   *%eax
  800428:	83 c4 10             	add    $0x10,%esp
}
  80042b:	90                   	nop
  80042c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80042f:	c9                   	leave  
  800430:	c3                   	ret    

00800431 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800431:	55                   	push   %ebp
  800432:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800434:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800438:	7e 1c                	jle    800456 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	8d 50 08             	lea    0x8(%eax),%edx
  800442:	8b 45 08             	mov    0x8(%ebp),%eax
  800445:	89 10                	mov    %edx,(%eax)
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	8b 00                	mov    (%eax),%eax
  80044c:	83 e8 08             	sub    $0x8,%eax
  80044f:	8b 50 04             	mov    0x4(%eax),%edx
  800452:	8b 00                	mov    (%eax),%eax
  800454:	eb 40                	jmp    800496 <getuint+0x65>
	else if (lflag)
  800456:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80045a:	74 1e                	je     80047a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	8d 50 04             	lea    0x4(%eax),%edx
  800464:	8b 45 08             	mov    0x8(%ebp),%eax
  800467:	89 10                	mov    %edx,(%eax)
  800469:	8b 45 08             	mov    0x8(%ebp),%eax
  80046c:	8b 00                	mov    (%eax),%eax
  80046e:	83 e8 04             	sub    $0x4,%eax
  800471:	8b 00                	mov    (%eax),%eax
  800473:	ba 00 00 00 00       	mov    $0x0,%edx
  800478:	eb 1c                	jmp    800496 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80047a:	8b 45 08             	mov    0x8(%ebp),%eax
  80047d:	8b 00                	mov    (%eax),%eax
  80047f:	8d 50 04             	lea    0x4(%eax),%edx
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	89 10                	mov    %edx,(%eax)
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	8b 00                	mov    (%eax),%eax
  80048c:	83 e8 04             	sub    $0x4,%eax
  80048f:	8b 00                	mov    (%eax),%eax
  800491:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800496:	5d                   	pop    %ebp
  800497:	c3                   	ret    

00800498 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800498:	55                   	push   %ebp
  800499:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80049b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80049f:	7e 1c                	jle    8004bd <getint+0x25>
		return va_arg(*ap, long long);
  8004a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a4:	8b 00                	mov    (%eax),%eax
  8004a6:	8d 50 08             	lea    0x8(%eax),%edx
  8004a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ac:	89 10                	mov    %edx,(%eax)
  8004ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b1:	8b 00                	mov    (%eax),%eax
  8004b3:	83 e8 08             	sub    $0x8,%eax
  8004b6:	8b 50 04             	mov    0x4(%eax),%edx
  8004b9:	8b 00                	mov    (%eax),%eax
  8004bb:	eb 38                	jmp    8004f5 <getint+0x5d>
	else if (lflag)
  8004bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004c1:	74 1a                	je     8004dd <getint+0x45>
		return va_arg(*ap, long);
  8004c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c6:	8b 00                	mov    (%eax),%eax
  8004c8:	8d 50 04             	lea    0x4(%eax),%edx
  8004cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ce:	89 10                	mov    %edx,(%eax)
  8004d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d3:	8b 00                	mov    (%eax),%eax
  8004d5:	83 e8 04             	sub    $0x4,%eax
  8004d8:	8b 00                	mov    (%eax),%eax
  8004da:	99                   	cltd   
  8004db:	eb 18                	jmp    8004f5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e0:	8b 00                	mov    (%eax),%eax
  8004e2:	8d 50 04             	lea    0x4(%eax),%edx
  8004e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e8:	89 10                	mov    %edx,(%eax)
  8004ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ed:	8b 00                	mov    (%eax),%eax
  8004ef:	83 e8 04             	sub    $0x4,%eax
  8004f2:	8b 00                	mov    (%eax),%eax
  8004f4:	99                   	cltd   
}
  8004f5:	5d                   	pop    %ebp
  8004f6:	c3                   	ret    

008004f7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004f7:	55                   	push   %ebp
  8004f8:	89 e5                	mov    %esp,%ebp
  8004fa:	56                   	push   %esi
  8004fb:	53                   	push   %ebx
  8004fc:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ff:	eb 17                	jmp    800518 <vprintfmt+0x21>
			if (ch == '\0')
  800501:	85 db                	test   %ebx,%ebx
  800503:	0f 84 af 03 00 00    	je     8008b8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800509:	83 ec 08             	sub    $0x8,%esp
  80050c:	ff 75 0c             	pushl  0xc(%ebp)
  80050f:	53                   	push   %ebx
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	ff d0                	call   *%eax
  800515:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800518:	8b 45 10             	mov    0x10(%ebp),%eax
  80051b:	8d 50 01             	lea    0x1(%eax),%edx
  80051e:	89 55 10             	mov    %edx,0x10(%ebp)
  800521:	8a 00                	mov    (%eax),%al
  800523:	0f b6 d8             	movzbl %al,%ebx
  800526:	83 fb 25             	cmp    $0x25,%ebx
  800529:	75 d6                	jne    800501 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80052b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80052f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800536:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80053d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800544:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80054b:	8b 45 10             	mov    0x10(%ebp),%eax
  80054e:	8d 50 01             	lea    0x1(%eax),%edx
  800551:	89 55 10             	mov    %edx,0x10(%ebp)
  800554:	8a 00                	mov    (%eax),%al
  800556:	0f b6 d8             	movzbl %al,%ebx
  800559:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80055c:	83 f8 55             	cmp    $0x55,%eax
  80055f:	0f 87 2b 03 00 00    	ja     800890 <vprintfmt+0x399>
  800565:	8b 04 85 b8 1c 80 00 	mov    0x801cb8(,%eax,4),%eax
  80056c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80056e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800572:	eb d7                	jmp    80054b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800574:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800578:	eb d1                	jmp    80054b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80057a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800581:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800584:	89 d0                	mov    %edx,%eax
  800586:	c1 e0 02             	shl    $0x2,%eax
  800589:	01 d0                	add    %edx,%eax
  80058b:	01 c0                	add    %eax,%eax
  80058d:	01 d8                	add    %ebx,%eax
  80058f:	83 e8 30             	sub    $0x30,%eax
  800592:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800595:	8b 45 10             	mov    0x10(%ebp),%eax
  800598:	8a 00                	mov    (%eax),%al
  80059a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80059d:	83 fb 2f             	cmp    $0x2f,%ebx
  8005a0:	7e 3e                	jle    8005e0 <vprintfmt+0xe9>
  8005a2:	83 fb 39             	cmp    $0x39,%ebx
  8005a5:	7f 39                	jg     8005e0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005a7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005aa:	eb d5                	jmp    800581 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8005af:	83 c0 04             	add    $0x4,%eax
  8005b2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b8:	83 e8 04             	sub    $0x4,%eax
  8005bb:	8b 00                	mov    (%eax),%eax
  8005bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005c0:	eb 1f                	jmp    8005e1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c6:	79 83                	jns    80054b <vprintfmt+0x54>
				width = 0;
  8005c8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005cf:	e9 77 ff ff ff       	jmp    80054b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005d4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005db:	e9 6b ff ff ff       	jmp    80054b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005e0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e5:	0f 89 60 ff ff ff    	jns    80054b <vprintfmt+0x54>
				width = precision, precision = -1;
  8005eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005f1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005f8:	e9 4e ff ff ff       	jmp    80054b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005fd:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800600:	e9 46 ff ff ff       	jmp    80054b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800605:	8b 45 14             	mov    0x14(%ebp),%eax
  800608:	83 c0 04             	add    $0x4,%eax
  80060b:	89 45 14             	mov    %eax,0x14(%ebp)
  80060e:	8b 45 14             	mov    0x14(%ebp),%eax
  800611:	83 e8 04             	sub    $0x4,%eax
  800614:	8b 00                	mov    (%eax),%eax
  800616:	83 ec 08             	sub    $0x8,%esp
  800619:	ff 75 0c             	pushl  0xc(%ebp)
  80061c:	50                   	push   %eax
  80061d:	8b 45 08             	mov    0x8(%ebp),%eax
  800620:	ff d0                	call   *%eax
  800622:	83 c4 10             	add    $0x10,%esp
			break;
  800625:	e9 89 02 00 00       	jmp    8008b3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80062a:	8b 45 14             	mov    0x14(%ebp),%eax
  80062d:	83 c0 04             	add    $0x4,%eax
  800630:	89 45 14             	mov    %eax,0x14(%ebp)
  800633:	8b 45 14             	mov    0x14(%ebp),%eax
  800636:	83 e8 04             	sub    $0x4,%eax
  800639:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80063b:	85 db                	test   %ebx,%ebx
  80063d:	79 02                	jns    800641 <vprintfmt+0x14a>
				err = -err;
  80063f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800641:	83 fb 64             	cmp    $0x64,%ebx
  800644:	7f 0b                	jg     800651 <vprintfmt+0x15a>
  800646:	8b 34 9d 00 1b 80 00 	mov    0x801b00(,%ebx,4),%esi
  80064d:	85 f6                	test   %esi,%esi
  80064f:	75 19                	jne    80066a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800651:	53                   	push   %ebx
  800652:	68 a5 1c 80 00       	push   $0x801ca5
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	ff 75 08             	pushl  0x8(%ebp)
  80065d:	e8 5e 02 00 00       	call   8008c0 <printfmt>
  800662:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800665:	e9 49 02 00 00       	jmp    8008b3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80066a:	56                   	push   %esi
  80066b:	68 ae 1c 80 00       	push   $0x801cae
  800670:	ff 75 0c             	pushl  0xc(%ebp)
  800673:	ff 75 08             	pushl  0x8(%ebp)
  800676:	e8 45 02 00 00       	call   8008c0 <printfmt>
  80067b:	83 c4 10             	add    $0x10,%esp
			break;
  80067e:	e9 30 02 00 00       	jmp    8008b3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800683:	8b 45 14             	mov    0x14(%ebp),%eax
  800686:	83 c0 04             	add    $0x4,%eax
  800689:	89 45 14             	mov    %eax,0x14(%ebp)
  80068c:	8b 45 14             	mov    0x14(%ebp),%eax
  80068f:	83 e8 04             	sub    $0x4,%eax
  800692:	8b 30                	mov    (%eax),%esi
  800694:	85 f6                	test   %esi,%esi
  800696:	75 05                	jne    80069d <vprintfmt+0x1a6>
				p = "(null)";
  800698:	be b1 1c 80 00       	mov    $0x801cb1,%esi
			if (width > 0 && padc != '-')
  80069d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a1:	7e 6d                	jle    800710 <vprintfmt+0x219>
  8006a3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006a7:	74 67                	je     800710 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006ac:	83 ec 08             	sub    $0x8,%esp
  8006af:	50                   	push   %eax
  8006b0:	56                   	push   %esi
  8006b1:	e8 0c 03 00 00       	call   8009c2 <strnlen>
  8006b6:	83 c4 10             	add    $0x10,%esp
  8006b9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006bc:	eb 16                	jmp    8006d4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006be:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006c2:	83 ec 08             	sub    $0x8,%esp
  8006c5:	ff 75 0c             	pushl  0xc(%ebp)
  8006c8:	50                   	push   %eax
  8006c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cc:	ff d0                	call   *%eax
  8006ce:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006d1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d8:	7f e4                	jg     8006be <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006da:	eb 34                	jmp    800710 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006dc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006e0:	74 1c                	je     8006fe <vprintfmt+0x207>
  8006e2:	83 fb 1f             	cmp    $0x1f,%ebx
  8006e5:	7e 05                	jle    8006ec <vprintfmt+0x1f5>
  8006e7:	83 fb 7e             	cmp    $0x7e,%ebx
  8006ea:	7e 12                	jle    8006fe <vprintfmt+0x207>
					putch('?', putdat);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 0c             	pushl  0xc(%ebp)
  8006f2:	6a 3f                	push   $0x3f
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	ff d0                	call   *%eax
  8006f9:	83 c4 10             	add    $0x10,%esp
  8006fc:	eb 0f                	jmp    80070d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006fe:	83 ec 08             	sub    $0x8,%esp
  800701:	ff 75 0c             	pushl  0xc(%ebp)
  800704:	53                   	push   %ebx
  800705:	8b 45 08             	mov    0x8(%ebp),%eax
  800708:	ff d0                	call   *%eax
  80070a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80070d:	ff 4d e4             	decl   -0x1c(%ebp)
  800710:	89 f0                	mov    %esi,%eax
  800712:	8d 70 01             	lea    0x1(%eax),%esi
  800715:	8a 00                	mov    (%eax),%al
  800717:	0f be d8             	movsbl %al,%ebx
  80071a:	85 db                	test   %ebx,%ebx
  80071c:	74 24                	je     800742 <vprintfmt+0x24b>
  80071e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800722:	78 b8                	js     8006dc <vprintfmt+0x1e5>
  800724:	ff 4d e0             	decl   -0x20(%ebp)
  800727:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80072b:	79 af                	jns    8006dc <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80072d:	eb 13                	jmp    800742 <vprintfmt+0x24b>
				putch(' ', putdat);
  80072f:	83 ec 08             	sub    $0x8,%esp
  800732:	ff 75 0c             	pushl  0xc(%ebp)
  800735:	6a 20                	push   $0x20
  800737:	8b 45 08             	mov    0x8(%ebp),%eax
  80073a:	ff d0                	call   *%eax
  80073c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80073f:	ff 4d e4             	decl   -0x1c(%ebp)
  800742:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800746:	7f e7                	jg     80072f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800748:	e9 66 01 00 00       	jmp    8008b3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80074d:	83 ec 08             	sub    $0x8,%esp
  800750:	ff 75 e8             	pushl  -0x18(%ebp)
  800753:	8d 45 14             	lea    0x14(%ebp),%eax
  800756:	50                   	push   %eax
  800757:	e8 3c fd ff ff       	call   800498 <getint>
  80075c:	83 c4 10             	add    $0x10,%esp
  80075f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800762:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800765:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800768:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80076b:	85 d2                	test   %edx,%edx
  80076d:	79 23                	jns    800792 <vprintfmt+0x29b>
				putch('-', putdat);
  80076f:	83 ec 08             	sub    $0x8,%esp
  800772:	ff 75 0c             	pushl  0xc(%ebp)
  800775:	6a 2d                	push   $0x2d
  800777:	8b 45 08             	mov    0x8(%ebp),%eax
  80077a:	ff d0                	call   *%eax
  80077c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80077f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800782:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800785:	f7 d8                	neg    %eax
  800787:	83 d2 00             	adc    $0x0,%edx
  80078a:	f7 da                	neg    %edx
  80078c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800792:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800799:	e9 bc 00 00 00       	jmp    80085a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80079e:	83 ec 08             	sub    $0x8,%esp
  8007a1:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a4:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a7:	50                   	push   %eax
  8007a8:	e8 84 fc ff ff       	call   800431 <getuint>
  8007ad:	83 c4 10             	add    $0x10,%esp
  8007b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007b6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007bd:	e9 98 00 00 00       	jmp    80085a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007c2:	83 ec 08             	sub    $0x8,%esp
  8007c5:	ff 75 0c             	pushl  0xc(%ebp)
  8007c8:	6a 58                	push   $0x58
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	ff d0                	call   *%eax
  8007cf:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007d2:	83 ec 08             	sub    $0x8,%esp
  8007d5:	ff 75 0c             	pushl  0xc(%ebp)
  8007d8:	6a 58                	push   $0x58
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	ff d0                	call   *%eax
  8007df:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007e2:	83 ec 08             	sub    $0x8,%esp
  8007e5:	ff 75 0c             	pushl  0xc(%ebp)
  8007e8:	6a 58                	push   $0x58
  8007ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ed:	ff d0                	call   *%eax
  8007ef:	83 c4 10             	add    $0x10,%esp
			break;
  8007f2:	e9 bc 00 00 00       	jmp    8008b3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	ff 75 0c             	pushl  0xc(%ebp)
  8007fd:	6a 30                	push   $0x30
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	ff d0                	call   *%eax
  800804:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800807:	83 ec 08             	sub    $0x8,%esp
  80080a:	ff 75 0c             	pushl  0xc(%ebp)
  80080d:	6a 78                	push   $0x78
  80080f:	8b 45 08             	mov    0x8(%ebp),%eax
  800812:	ff d0                	call   *%eax
  800814:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800817:	8b 45 14             	mov    0x14(%ebp),%eax
  80081a:	83 c0 04             	add    $0x4,%eax
  80081d:	89 45 14             	mov    %eax,0x14(%ebp)
  800820:	8b 45 14             	mov    0x14(%ebp),%eax
  800823:	83 e8 04             	sub    $0x4,%eax
  800826:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800828:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80082b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800832:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800839:	eb 1f                	jmp    80085a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80083b:	83 ec 08             	sub    $0x8,%esp
  80083e:	ff 75 e8             	pushl  -0x18(%ebp)
  800841:	8d 45 14             	lea    0x14(%ebp),%eax
  800844:	50                   	push   %eax
  800845:	e8 e7 fb ff ff       	call   800431 <getuint>
  80084a:	83 c4 10             	add    $0x10,%esp
  80084d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800850:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800853:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80085a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80085e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800861:	83 ec 04             	sub    $0x4,%esp
  800864:	52                   	push   %edx
  800865:	ff 75 e4             	pushl  -0x1c(%ebp)
  800868:	50                   	push   %eax
  800869:	ff 75 f4             	pushl  -0xc(%ebp)
  80086c:	ff 75 f0             	pushl  -0x10(%ebp)
  80086f:	ff 75 0c             	pushl  0xc(%ebp)
  800872:	ff 75 08             	pushl  0x8(%ebp)
  800875:	e8 00 fb ff ff       	call   80037a <printnum>
  80087a:	83 c4 20             	add    $0x20,%esp
			break;
  80087d:	eb 34                	jmp    8008b3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80087f:	83 ec 08             	sub    $0x8,%esp
  800882:	ff 75 0c             	pushl  0xc(%ebp)
  800885:	53                   	push   %ebx
  800886:	8b 45 08             	mov    0x8(%ebp),%eax
  800889:	ff d0                	call   *%eax
  80088b:	83 c4 10             	add    $0x10,%esp
			break;
  80088e:	eb 23                	jmp    8008b3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800890:	83 ec 08             	sub    $0x8,%esp
  800893:	ff 75 0c             	pushl  0xc(%ebp)
  800896:	6a 25                	push   $0x25
  800898:	8b 45 08             	mov    0x8(%ebp),%eax
  80089b:	ff d0                	call   *%eax
  80089d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008a0:	ff 4d 10             	decl   0x10(%ebp)
  8008a3:	eb 03                	jmp    8008a8 <vprintfmt+0x3b1>
  8008a5:	ff 4d 10             	decl   0x10(%ebp)
  8008a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ab:	48                   	dec    %eax
  8008ac:	8a 00                	mov    (%eax),%al
  8008ae:	3c 25                	cmp    $0x25,%al
  8008b0:	75 f3                	jne    8008a5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008b2:	90                   	nop
		}
	}
  8008b3:	e9 47 fc ff ff       	jmp    8004ff <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008b8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008bc:	5b                   	pop    %ebx
  8008bd:	5e                   	pop    %esi
  8008be:	5d                   	pop    %ebp
  8008bf:	c3                   	ret    

008008c0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008c0:	55                   	push   %ebp
  8008c1:	89 e5                	mov    %esp,%ebp
  8008c3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008c6:	8d 45 10             	lea    0x10(%ebp),%eax
  8008c9:	83 c0 04             	add    $0x4,%eax
  8008cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8008d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d5:	50                   	push   %eax
  8008d6:	ff 75 0c             	pushl  0xc(%ebp)
  8008d9:	ff 75 08             	pushl  0x8(%ebp)
  8008dc:	e8 16 fc ff ff       	call   8004f7 <vprintfmt>
  8008e1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008e4:	90                   	nop
  8008e5:	c9                   	leave  
  8008e6:	c3                   	ret    

008008e7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008e7:	55                   	push   %ebp
  8008e8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ed:	8b 40 08             	mov    0x8(%eax),%eax
  8008f0:	8d 50 01             	lea    0x1(%eax),%edx
  8008f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fc:	8b 10                	mov    (%eax),%edx
  8008fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800901:	8b 40 04             	mov    0x4(%eax),%eax
  800904:	39 c2                	cmp    %eax,%edx
  800906:	73 12                	jae    80091a <sprintputch+0x33>
		*b->buf++ = ch;
  800908:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090b:	8b 00                	mov    (%eax),%eax
  80090d:	8d 48 01             	lea    0x1(%eax),%ecx
  800910:	8b 55 0c             	mov    0xc(%ebp),%edx
  800913:	89 0a                	mov    %ecx,(%edx)
  800915:	8b 55 08             	mov    0x8(%ebp),%edx
  800918:	88 10                	mov    %dl,(%eax)
}
  80091a:	90                   	nop
  80091b:	5d                   	pop    %ebp
  80091c:	c3                   	ret    

0080091d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80091d:	55                   	push   %ebp
  80091e:	89 e5                	mov    %esp,%ebp
  800920:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800923:	8b 45 08             	mov    0x8(%ebp),%eax
  800926:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800929:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	01 d0                	add    %edx,%eax
  800934:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800937:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80093e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800942:	74 06                	je     80094a <vsnprintf+0x2d>
  800944:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800948:	7f 07                	jg     800951 <vsnprintf+0x34>
		return -E_INVAL;
  80094a:	b8 03 00 00 00       	mov    $0x3,%eax
  80094f:	eb 20                	jmp    800971 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800951:	ff 75 14             	pushl  0x14(%ebp)
  800954:	ff 75 10             	pushl  0x10(%ebp)
  800957:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80095a:	50                   	push   %eax
  80095b:	68 e7 08 80 00       	push   $0x8008e7
  800960:	e8 92 fb ff ff       	call   8004f7 <vprintfmt>
  800965:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800968:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80096b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80096e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800971:	c9                   	leave  
  800972:	c3                   	ret    

00800973 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800973:	55                   	push   %ebp
  800974:	89 e5                	mov    %esp,%ebp
  800976:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800979:	8d 45 10             	lea    0x10(%ebp),%eax
  80097c:	83 c0 04             	add    $0x4,%eax
  80097f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800982:	8b 45 10             	mov    0x10(%ebp),%eax
  800985:	ff 75 f4             	pushl  -0xc(%ebp)
  800988:	50                   	push   %eax
  800989:	ff 75 0c             	pushl  0xc(%ebp)
  80098c:	ff 75 08             	pushl  0x8(%ebp)
  80098f:	e8 89 ff ff ff       	call   80091d <vsnprintf>
  800994:	83 c4 10             	add    $0x10,%esp
  800997:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80099a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80099d:	c9                   	leave  
  80099e:	c3                   	ret    

0080099f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80099f:	55                   	push   %ebp
  8009a0:	89 e5                	mov    %esp,%ebp
  8009a2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ac:	eb 06                	jmp    8009b4 <strlen+0x15>
		n++;
  8009ae:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009b1:	ff 45 08             	incl   0x8(%ebp)
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	8a 00                	mov    (%eax),%al
  8009b9:	84 c0                	test   %al,%al
  8009bb:	75 f1                	jne    8009ae <strlen+0xf>
		n++;
	return n;
  8009bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009c0:	c9                   	leave  
  8009c1:	c3                   	ret    

008009c2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009c2:	55                   	push   %ebp
  8009c3:	89 e5                	mov    %esp,%ebp
  8009c5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009cf:	eb 09                	jmp    8009da <strnlen+0x18>
		n++;
  8009d1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009d4:	ff 45 08             	incl   0x8(%ebp)
  8009d7:	ff 4d 0c             	decl   0xc(%ebp)
  8009da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009de:	74 09                	je     8009e9 <strnlen+0x27>
  8009e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e3:	8a 00                	mov    (%eax),%al
  8009e5:	84 c0                	test   %al,%al
  8009e7:	75 e8                	jne    8009d1 <strnlen+0xf>
		n++;
	return n;
  8009e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ec:	c9                   	leave  
  8009ed:	c3                   	ret    

008009ee <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009ee:	55                   	push   %ebp
  8009ef:	89 e5                	mov    %esp,%ebp
  8009f1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009fa:	90                   	nop
  8009fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fe:	8d 50 01             	lea    0x1(%eax),%edx
  800a01:	89 55 08             	mov    %edx,0x8(%ebp)
  800a04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a07:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a0a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a0d:	8a 12                	mov    (%edx),%dl
  800a0f:	88 10                	mov    %dl,(%eax)
  800a11:	8a 00                	mov    (%eax),%al
  800a13:	84 c0                	test   %al,%al
  800a15:	75 e4                	jne    8009fb <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a17:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a1a:	c9                   	leave  
  800a1b:	c3                   	ret    

00800a1c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a1c:	55                   	push   %ebp
  800a1d:	89 e5                	mov    %esp,%ebp
  800a1f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a28:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a2f:	eb 1f                	jmp    800a50 <strncpy+0x34>
		*dst++ = *src;
  800a31:	8b 45 08             	mov    0x8(%ebp),%eax
  800a34:	8d 50 01             	lea    0x1(%eax),%edx
  800a37:	89 55 08             	mov    %edx,0x8(%ebp)
  800a3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a3d:	8a 12                	mov    (%edx),%dl
  800a3f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a44:	8a 00                	mov    (%eax),%al
  800a46:	84 c0                	test   %al,%al
  800a48:	74 03                	je     800a4d <strncpy+0x31>
			src++;
  800a4a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a4d:	ff 45 fc             	incl   -0x4(%ebp)
  800a50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a53:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a56:	72 d9                	jb     800a31 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a58:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a5b:	c9                   	leave  
  800a5c:	c3                   	ret    

00800a5d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a5d:	55                   	push   %ebp
  800a5e:	89 e5                	mov    %esp,%ebp
  800a60:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a69:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6d:	74 30                	je     800a9f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a6f:	eb 16                	jmp    800a87 <strlcpy+0x2a>
			*dst++ = *src++;
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	8d 50 01             	lea    0x1(%eax),%edx
  800a77:	89 55 08             	mov    %edx,0x8(%ebp)
  800a7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a80:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a83:	8a 12                	mov    (%edx),%dl
  800a85:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a87:	ff 4d 10             	decl   0x10(%ebp)
  800a8a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a8e:	74 09                	je     800a99 <strlcpy+0x3c>
  800a90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a93:	8a 00                	mov    (%eax),%al
  800a95:	84 c0                	test   %al,%al
  800a97:	75 d8                	jne    800a71 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800aa2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aa5:	29 c2                	sub    %eax,%edx
  800aa7:	89 d0                	mov    %edx,%eax
}
  800aa9:	c9                   	leave  
  800aaa:	c3                   	ret    

00800aab <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800aab:	55                   	push   %ebp
  800aac:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800aae:	eb 06                	jmp    800ab6 <strcmp+0xb>
		p++, q++;
  800ab0:	ff 45 08             	incl   0x8(%ebp)
  800ab3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8a 00                	mov    (%eax),%al
  800abb:	84 c0                	test   %al,%al
  800abd:	74 0e                	je     800acd <strcmp+0x22>
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	8a 10                	mov    (%eax),%dl
  800ac4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac7:	8a 00                	mov    (%eax),%al
  800ac9:	38 c2                	cmp    %al,%dl
  800acb:	74 e3                	je     800ab0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	8a 00                	mov    (%eax),%al
  800ad2:	0f b6 d0             	movzbl %al,%edx
  800ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad8:	8a 00                	mov    (%eax),%al
  800ada:	0f b6 c0             	movzbl %al,%eax
  800add:	29 c2                	sub    %eax,%edx
  800adf:	89 d0                	mov    %edx,%eax
}
  800ae1:	5d                   	pop    %ebp
  800ae2:	c3                   	ret    

00800ae3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ae3:	55                   	push   %ebp
  800ae4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ae6:	eb 09                	jmp    800af1 <strncmp+0xe>
		n--, p++, q++;
  800ae8:	ff 4d 10             	decl   0x10(%ebp)
  800aeb:	ff 45 08             	incl   0x8(%ebp)
  800aee:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800af1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af5:	74 17                	je     800b0e <strncmp+0x2b>
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	8a 00                	mov    (%eax),%al
  800afc:	84 c0                	test   %al,%al
  800afe:	74 0e                	je     800b0e <strncmp+0x2b>
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	8a 10                	mov    (%eax),%dl
  800b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b08:	8a 00                	mov    (%eax),%al
  800b0a:	38 c2                	cmp    %al,%dl
  800b0c:	74 da                	je     800ae8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b12:	75 07                	jne    800b1b <strncmp+0x38>
		return 0;
  800b14:	b8 00 00 00 00       	mov    $0x0,%eax
  800b19:	eb 14                	jmp    800b2f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	8a 00                	mov    (%eax),%al
  800b20:	0f b6 d0             	movzbl %al,%edx
  800b23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b26:	8a 00                	mov    (%eax),%al
  800b28:	0f b6 c0             	movzbl %al,%eax
  800b2b:	29 c2                	sub    %eax,%edx
  800b2d:	89 d0                	mov    %edx,%eax
}
  800b2f:	5d                   	pop    %ebp
  800b30:	c3                   	ret    

00800b31 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b31:	55                   	push   %ebp
  800b32:	89 e5                	mov    %esp,%ebp
  800b34:	83 ec 04             	sub    $0x4,%esp
  800b37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b3d:	eb 12                	jmp    800b51 <strchr+0x20>
		if (*s == c)
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8a 00                	mov    (%eax),%al
  800b44:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b47:	75 05                	jne    800b4e <strchr+0x1d>
			return (char *) s;
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	eb 11                	jmp    800b5f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b4e:	ff 45 08             	incl   0x8(%ebp)
  800b51:	8b 45 08             	mov    0x8(%ebp),%eax
  800b54:	8a 00                	mov    (%eax),%al
  800b56:	84 c0                	test   %al,%al
  800b58:	75 e5                	jne    800b3f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b5f:	c9                   	leave  
  800b60:	c3                   	ret    

00800b61 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b61:	55                   	push   %ebp
  800b62:	89 e5                	mov    %esp,%ebp
  800b64:	83 ec 04             	sub    $0x4,%esp
  800b67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b6d:	eb 0d                	jmp    800b7c <strfind+0x1b>
		if (*s == c)
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	8a 00                	mov    (%eax),%al
  800b74:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b77:	74 0e                	je     800b87 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b79:	ff 45 08             	incl   0x8(%ebp)
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	8a 00                	mov    (%eax),%al
  800b81:	84 c0                	test   %al,%al
  800b83:	75 ea                	jne    800b6f <strfind+0xe>
  800b85:	eb 01                	jmp    800b88 <strfind+0x27>
		if (*s == c)
			break;
  800b87:	90                   	nop
	return (char *) s;
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b8b:	c9                   	leave  
  800b8c:	c3                   	ret    

00800b8d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b8d:	55                   	push   %ebp
  800b8e:	89 e5                	mov    %esp,%ebp
  800b90:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b99:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b9f:	eb 0e                	jmp    800baf <memset+0x22>
		*p++ = c;
  800ba1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba4:	8d 50 01             	lea    0x1(%eax),%edx
  800ba7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800baa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bad:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800baf:	ff 4d f8             	decl   -0x8(%ebp)
  800bb2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bb6:	79 e9                	jns    800ba1 <memset+0x14>
		*p++ = c;

	return v;
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bbb:	c9                   	leave  
  800bbc:	c3                   	ret    

00800bbd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bbd:	55                   	push   %ebp
  800bbe:	89 e5                	mov    %esp,%ebp
  800bc0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bcf:	eb 16                	jmp    800be7 <memcpy+0x2a>
		*d++ = *s++;
  800bd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd4:	8d 50 01             	lea    0x1(%eax),%edx
  800bd7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bda:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bdd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800be0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800be3:	8a 12                	mov    (%edx),%dl
  800be5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800be7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bea:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bed:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf0:	85 c0                	test   %eax,%eax
  800bf2:	75 dd                	jne    800bd1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bf7:	c9                   	leave  
  800bf8:	c3                   	ret    

00800bf9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800bff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c11:	73 50                	jae    800c63 <memmove+0x6a>
  800c13:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c16:	8b 45 10             	mov    0x10(%ebp),%eax
  800c19:	01 d0                	add    %edx,%eax
  800c1b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c1e:	76 43                	jbe    800c63 <memmove+0x6a>
		s += n;
  800c20:	8b 45 10             	mov    0x10(%ebp),%eax
  800c23:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c26:	8b 45 10             	mov    0x10(%ebp),%eax
  800c29:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c2c:	eb 10                	jmp    800c3e <memmove+0x45>
			*--d = *--s;
  800c2e:	ff 4d f8             	decl   -0x8(%ebp)
  800c31:	ff 4d fc             	decl   -0x4(%ebp)
  800c34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c37:	8a 10                	mov    (%eax),%dl
  800c39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c3c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c41:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c44:	89 55 10             	mov    %edx,0x10(%ebp)
  800c47:	85 c0                	test   %eax,%eax
  800c49:	75 e3                	jne    800c2e <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c4b:	eb 23                	jmp    800c70 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c50:	8d 50 01             	lea    0x1(%eax),%edx
  800c53:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c56:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c59:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c5c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c5f:	8a 12                	mov    (%edx),%dl
  800c61:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c63:	8b 45 10             	mov    0x10(%ebp),%eax
  800c66:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c69:	89 55 10             	mov    %edx,0x10(%ebp)
  800c6c:	85 c0                	test   %eax,%eax
  800c6e:	75 dd                	jne    800c4d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c73:	c9                   	leave  
  800c74:	c3                   	ret    

00800c75 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c75:	55                   	push   %ebp
  800c76:	89 e5                	mov    %esp,%ebp
  800c78:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c84:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c87:	eb 2a                	jmp    800cb3 <memcmp+0x3e>
		if (*s1 != *s2)
  800c89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c8c:	8a 10                	mov    (%eax),%dl
  800c8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c91:	8a 00                	mov    (%eax),%al
  800c93:	38 c2                	cmp    %al,%dl
  800c95:	74 16                	je     800cad <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9a:	8a 00                	mov    (%eax),%al
  800c9c:	0f b6 d0             	movzbl %al,%edx
  800c9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	0f b6 c0             	movzbl %al,%eax
  800ca7:	29 c2                	sub    %eax,%edx
  800ca9:	89 d0                	mov    %edx,%eax
  800cab:	eb 18                	jmp    800cc5 <memcmp+0x50>
		s1++, s2++;
  800cad:	ff 45 fc             	incl   -0x4(%ebp)
  800cb0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cb9:	89 55 10             	mov    %edx,0x10(%ebp)
  800cbc:	85 c0                	test   %eax,%eax
  800cbe:	75 c9                	jne    800c89 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cc5:	c9                   	leave  
  800cc6:	c3                   	ret    

00800cc7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cc7:	55                   	push   %ebp
  800cc8:	89 e5                	mov    %esp,%ebp
  800cca:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ccd:	8b 55 08             	mov    0x8(%ebp),%edx
  800cd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd3:	01 d0                	add    %edx,%eax
  800cd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cd8:	eb 15                	jmp    800cef <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	0f b6 d0             	movzbl %al,%edx
  800ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce5:	0f b6 c0             	movzbl %al,%eax
  800ce8:	39 c2                	cmp    %eax,%edx
  800cea:	74 0d                	je     800cf9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cec:	ff 45 08             	incl   0x8(%ebp)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800cf5:	72 e3                	jb     800cda <memfind+0x13>
  800cf7:	eb 01                	jmp    800cfa <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cf9:	90                   	nop
	return (void *) s;
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cfd:	c9                   	leave  
  800cfe:	c3                   	ret    

00800cff <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cff:	55                   	push   %ebp
  800d00:	89 e5                	mov    %esp,%ebp
  800d02:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d0c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d13:	eb 03                	jmp    800d18 <strtol+0x19>
		s++;
  800d15:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8a 00                	mov    (%eax),%al
  800d1d:	3c 20                	cmp    $0x20,%al
  800d1f:	74 f4                	je     800d15 <strtol+0x16>
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	3c 09                	cmp    $0x9,%al
  800d28:	74 eb                	je     800d15 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	3c 2b                	cmp    $0x2b,%al
  800d31:	75 05                	jne    800d38 <strtol+0x39>
		s++;
  800d33:	ff 45 08             	incl   0x8(%ebp)
  800d36:	eb 13                	jmp    800d4b <strtol+0x4c>
	else if (*s == '-')
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8a 00                	mov    (%eax),%al
  800d3d:	3c 2d                	cmp    $0x2d,%al
  800d3f:	75 0a                	jne    800d4b <strtol+0x4c>
		s++, neg = 1;
  800d41:	ff 45 08             	incl   0x8(%ebp)
  800d44:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d4b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4f:	74 06                	je     800d57 <strtol+0x58>
  800d51:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d55:	75 20                	jne    800d77 <strtol+0x78>
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	8a 00                	mov    (%eax),%al
  800d5c:	3c 30                	cmp    $0x30,%al
  800d5e:	75 17                	jne    800d77 <strtol+0x78>
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	40                   	inc    %eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	3c 78                	cmp    $0x78,%al
  800d68:	75 0d                	jne    800d77 <strtol+0x78>
		s += 2, base = 16;
  800d6a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d6e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d75:	eb 28                	jmp    800d9f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d7b:	75 15                	jne    800d92 <strtol+0x93>
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	3c 30                	cmp    $0x30,%al
  800d84:	75 0c                	jne    800d92 <strtol+0x93>
		s++, base = 8;
  800d86:	ff 45 08             	incl   0x8(%ebp)
  800d89:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d90:	eb 0d                	jmp    800d9f <strtol+0xa0>
	else if (base == 0)
  800d92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d96:	75 07                	jne    800d9f <strtol+0xa0>
		base = 10;
  800d98:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	3c 2f                	cmp    $0x2f,%al
  800da6:	7e 19                	jle    800dc1 <strtol+0xc2>
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	8a 00                	mov    (%eax),%al
  800dad:	3c 39                	cmp    $0x39,%al
  800daf:	7f 10                	jg     800dc1 <strtol+0xc2>
			dig = *s - '0';
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	0f be c0             	movsbl %al,%eax
  800db9:	83 e8 30             	sub    $0x30,%eax
  800dbc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dbf:	eb 42                	jmp    800e03 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	3c 60                	cmp    $0x60,%al
  800dc8:	7e 19                	jle    800de3 <strtol+0xe4>
  800dca:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcd:	8a 00                	mov    (%eax),%al
  800dcf:	3c 7a                	cmp    $0x7a,%al
  800dd1:	7f 10                	jg     800de3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	8a 00                	mov    (%eax),%al
  800dd8:	0f be c0             	movsbl %al,%eax
  800ddb:	83 e8 57             	sub    $0x57,%eax
  800dde:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800de1:	eb 20                	jmp    800e03 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	3c 40                	cmp    $0x40,%al
  800dea:	7e 39                	jle    800e25 <strtol+0x126>
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	8a 00                	mov    (%eax),%al
  800df1:	3c 5a                	cmp    $0x5a,%al
  800df3:	7f 30                	jg     800e25 <strtol+0x126>
			dig = *s - 'A' + 10;
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	8a 00                	mov    (%eax),%al
  800dfa:	0f be c0             	movsbl %al,%eax
  800dfd:	83 e8 37             	sub    $0x37,%eax
  800e00:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e06:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e09:	7d 19                	jge    800e24 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e0b:	ff 45 08             	incl   0x8(%ebp)
  800e0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e11:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e15:	89 c2                	mov    %eax,%edx
  800e17:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e1a:	01 d0                	add    %edx,%eax
  800e1c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e1f:	e9 7b ff ff ff       	jmp    800d9f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e24:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e29:	74 08                	je     800e33 <strtol+0x134>
		*endptr = (char *) s;
  800e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2e:	8b 55 08             	mov    0x8(%ebp),%edx
  800e31:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e33:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e37:	74 07                	je     800e40 <strtol+0x141>
  800e39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3c:	f7 d8                	neg    %eax
  800e3e:	eb 03                	jmp    800e43 <strtol+0x144>
  800e40:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e43:	c9                   	leave  
  800e44:	c3                   	ret    

00800e45 <ltostr>:

void
ltostr(long value, char *str)
{
  800e45:	55                   	push   %ebp
  800e46:	89 e5                	mov    %esp,%ebp
  800e48:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e4b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e52:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e59:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e5d:	79 13                	jns    800e72 <ltostr+0x2d>
	{
		neg = 1;
  800e5f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e6c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e6f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e7a:	99                   	cltd   
  800e7b:	f7 f9                	idiv   %ecx
  800e7d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e83:	8d 50 01             	lea    0x1(%eax),%edx
  800e86:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e89:	89 c2                	mov    %eax,%edx
  800e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8e:	01 d0                	add    %edx,%eax
  800e90:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e93:	83 c2 30             	add    $0x30,%edx
  800e96:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e98:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e9b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ea0:	f7 e9                	imul   %ecx
  800ea2:	c1 fa 02             	sar    $0x2,%edx
  800ea5:	89 c8                	mov    %ecx,%eax
  800ea7:	c1 f8 1f             	sar    $0x1f,%eax
  800eaa:	29 c2                	sub    %eax,%edx
  800eac:	89 d0                	mov    %edx,%eax
  800eae:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800eb1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eb4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb9:	f7 e9                	imul   %ecx
  800ebb:	c1 fa 02             	sar    $0x2,%edx
  800ebe:	89 c8                	mov    %ecx,%eax
  800ec0:	c1 f8 1f             	sar    $0x1f,%eax
  800ec3:	29 c2                	sub    %eax,%edx
  800ec5:	89 d0                	mov    %edx,%eax
  800ec7:	c1 e0 02             	shl    $0x2,%eax
  800eca:	01 d0                	add    %edx,%eax
  800ecc:	01 c0                	add    %eax,%eax
  800ece:	29 c1                	sub    %eax,%ecx
  800ed0:	89 ca                	mov    %ecx,%edx
  800ed2:	85 d2                	test   %edx,%edx
  800ed4:	75 9c                	jne    800e72 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ed6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800edd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee0:	48                   	dec    %eax
  800ee1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ee4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ee8:	74 3d                	je     800f27 <ltostr+0xe2>
		start = 1 ;
  800eea:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ef1:	eb 34                	jmp    800f27 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ef3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef9:	01 d0                	add    %edx,%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f00:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f06:	01 c2                	add    %eax,%edx
  800f08:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0e:	01 c8                	add    %ecx,%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f14:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1a:	01 c2                	add    %eax,%edx
  800f1c:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f1f:	88 02                	mov    %al,(%edx)
		start++ ;
  800f21:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f24:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f2a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f2d:	7c c4                	jl     800ef3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f2f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f35:	01 d0                	add    %edx,%eax
  800f37:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f3a:	90                   	nop
  800f3b:	c9                   	leave  
  800f3c:	c3                   	ret    

00800f3d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f3d:	55                   	push   %ebp
  800f3e:	89 e5                	mov    %esp,%ebp
  800f40:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f43:	ff 75 08             	pushl  0x8(%ebp)
  800f46:	e8 54 fa ff ff       	call   80099f <strlen>
  800f4b:	83 c4 04             	add    $0x4,%esp
  800f4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f51:	ff 75 0c             	pushl  0xc(%ebp)
  800f54:	e8 46 fa ff ff       	call   80099f <strlen>
  800f59:	83 c4 04             	add    $0x4,%esp
  800f5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f66:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f6d:	eb 17                	jmp    800f86 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f6f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f72:	8b 45 10             	mov    0x10(%ebp),%eax
  800f75:	01 c2                	add    %eax,%edx
  800f77:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	01 c8                	add    %ecx,%eax
  800f7f:	8a 00                	mov    (%eax),%al
  800f81:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f83:	ff 45 fc             	incl   -0x4(%ebp)
  800f86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f89:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f8c:	7c e1                	jl     800f6f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f8e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f95:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f9c:	eb 1f                	jmp    800fbd <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa1:	8d 50 01             	lea    0x1(%eax),%edx
  800fa4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fa7:	89 c2                	mov    %eax,%edx
  800fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fac:	01 c2                	add    %eax,%edx
  800fae:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb4:	01 c8                	add    %ecx,%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fba:	ff 45 f8             	incl   -0x8(%ebp)
  800fbd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fc3:	7c d9                	jl     800f9e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fc5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcb:	01 d0                	add    %edx,%eax
  800fcd:	c6 00 00             	movb   $0x0,(%eax)
}
  800fd0:	90                   	nop
  800fd1:	c9                   	leave  
  800fd2:	c3                   	ret    

00800fd3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fd3:	55                   	push   %ebp
  800fd4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fd6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fdf:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe2:	8b 00                	mov    (%eax),%eax
  800fe4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800feb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fee:	01 d0                	add    %edx,%eax
  800ff0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800ff6:	eb 0c                	jmp    801004 <strsplit+0x31>
			*string++ = 0;
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	8d 50 01             	lea    0x1(%eax),%edx
  800ffe:	89 55 08             	mov    %edx,0x8(%ebp)
  801001:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	84 c0                	test   %al,%al
  80100b:	74 18                	je     801025 <strsplit+0x52>
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	8a 00                	mov    (%eax),%al
  801012:	0f be c0             	movsbl %al,%eax
  801015:	50                   	push   %eax
  801016:	ff 75 0c             	pushl  0xc(%ebp)
  801019:	e8 13 fb ff ff       	call   800b31 <strchr>
  80101e:	83 c4 08             	add    $0x8,%esp
  801021:	85 c0                	test   %eax,%eax
  801023:	75 d3                	jne    800ff8 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8a 00                	mov    (%eax),%al
  80102a:	84 c0                	test   %al,%al
  80102c:	74 5a                	je     801088 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80102e:	8b 45 14             	mov    0x14(%ebp),%eax
  801031:	8b 00                	mov    (%eax),%eax
  801033:	83 f8 0f             	cmp    $0xf,%eax
  801036:	75 07                	jne    80103f <strsplit+0x6c>
		{
			return 0;
  801038:	b8 00 00 00 00       	mov    $0x0,%eax
  80103d:	eb 66                	jmp    8010a5 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80103f:	8b 45 14             	mov    0x14(%ebp),%eax
  801042:	8b 00                	mov    (%eax),%eax
  801044:	8d 48 01             	lea    0x1(%eax),%ecx
  801047:	8b 55 14             	mov    0x14(%ebp),%edx
  80104a:	89 0a                	mov    %ecx,(%edx)
  80104c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801053:	8b 45 10             	mov    0x10(%ebp),%eax
  801056:	01 c2                	add    %eax,%edx
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80105d:	eb 03                	jmp    801062 <strsplit+0x8f>
			string++;
  80105f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801062:	8b 45 08             	mov    0x8(%ebp),%eax
  801065:	8a 00                	mov    (%eax),%al
  801067:	84 c0                	test   %al,%al
  801069:	74 8b                	je     800ff6 <strsplit+0x23>
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	8a 00                	mov    (%eax),%al
  801070:	0f be c0             	movsbl %al,%eax
  801073:	50                   	push   %eax
  801074:	ff 75 0c             	pushl  0xc(%ebp)
  801077:	e8 b5 fa ff ff       	call   800b31 <strchr>
  80107c:	83 c4 08             	add    $0x8,%esp
  80107f:	85 c0                	test   %eax,%eax
  801081:	74 dc                	je     80105f <strsplit+0x8c>
			string++;
	}
  801083:	e9 6e ff ff ff       	jmp    800ff6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801088:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801089:	8b 45 14             	mov    0x14(%ebp),%eax
  80108c:	8b 00                	mov    (%eax),%eax
  80108e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801095:	8b 45 10             	mov    0x10(%ebp),%eax
  801098:	01 d0                	add    %edx,%eax
  80109a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010a0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010a5:	c9                   	leave  
  8010a6:	c3                   	ret    

008010a7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
  8010aa:	57                   	push   %edi
  8010ab:	56                   	push   %esi
  8010ac:	53                   	push   %ebx
  8010ad:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8010b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010bc:	8b 7d 18             	mov    0x18(%ebp),%edi
  8010bf:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8010c2:	cd 30                	int    $0x30
  8010c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8010c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010ca:	83 c4 10             	add    $0x10,%esp
  8010cd:	5b                   	pop    %ebx
  8010ce:	5e                   	pop    %esi
  8010cf:	5f                   	pop    %edi
  8010d0:	5d                   	pop    %ebp
  8010d1:	c3                   	ret    

008010d2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8010d2:	55                   	push   %ebp
  8010d3:	89 e5                	mov    %esp,%ebp
  8010d5:	83 ec 04             	sub    $0x4,%esp
  8010d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010db:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8010de:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	6a 00                	push   $0x0
  8010e7:	6a 00                	push   $0x0
  8010e9:	52                   	push   %edx
  8010ea:	ff 75 0c             	pushl  0xc(%ebp)
  8010ed:	50                   	push   %eax
  8010ee:	6a 00                	push   $0x0
  8010f0:	e8 b2 ff ff ff       	call   8010a7 <syscall>
  8010f5:	83 c4 18             	add    $0x18,%esp
}
  8010f8:	90                   	nop
  8010f9:	c9                   	leave  
  8010fa:	c3                   	ret    

008010fb <sys_cgetc>:

int
sys_cgetc(void)
{
  8010fb:	55                   	push   %ebp
  8010fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010fe:	6a 00                	push   $0x0
  801100:	6a 00                	push   $0x0
  801102:	6a 00                	push   $0x0
  801104:	6a 00                	push   $0x0
  801106:	6a 00                	push   $0x0
  801108:	6a 01                	push   $0x1
  80110a:	e8 98 ff ff ff       	call   8010a7 <syscall>
  80110f:	83 c4 18             	add    $0x18,%esp
}
  801112:	c9                   	leave  
  801113:	c3                   	ret    

00801114 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801114:	55                   	push   %ebp
  801115:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	6a 00                	push   $0x0
  80111c:	6a 00                	push   $0x0
  80111e:	6a 00                	push   $0x0
  801120:	6a 00                	push   $0x0
  801122:	50                   	push   %eax
  801123:	6a 05                	push   $0x5
  801125:	e8 7d ff ff ff       	call   8010a7 <syscall>
  80112a:	83 c4 18             	add    $0x18,%esp
}
  80112d:	c9                   	leave  
  80112e:	c3                   	ret    

0080112f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80112f:	55                   	push   %ebp
  801130:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801132:	6a 00                	push   $0x0
  801134:	6a 00                	push   $0x0
  801136:	6a 00                	push   $0x0
  801138:	6a 00                	push   $0x0
  80113a:	6a 00                	push   $0x0
  80113c:	6a 02                	push   $0x2
  80113e:	e8 64 ff ff ff       	call   8010a7 <syscall>
  801143:	83 c4 18             	add    $0x18,%esp
}
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80114b:	6a 00                	push   $0x0
  80114d:	6a 00                	push   $0x0
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	6a 00                	push   $0x0
  801155:	6a 03                	push   $0x3
  801157:	e8 4b ff ff ff       	call   8010a7 <syscall>
  80115c:	83 c4 18             	add    $0x18,%esp
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801164:	6a 00                	push   $0x0
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	6a 00                	push   $0x0
  80116e:	6a 04                	push   $0x4
  801170:	e8 32 ff ff ff       	call   8010a7 <syscall>
  801175:	83 c4 18             	add    $0x18,%esp
}
  801178:	c9                   	leave  
  801179:	c3                   	ret    

0080117a <sys_env_exit>:


void sys_env_exit(void)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80117d:	6a 00                	push   $0x0
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 00                	push   $0x0
  801187:	6a 06                	push   $0x6
  801189:	e8 19 ff ff ff       	call   8010a7 <syscall>
  80118e:	83 c4 18             	add    $0x18,%esp
}
  801191:	90                   	nop
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801197:	8b 55 0c             	mov    0xc(%ebp),%edx
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	6a 00                	push   $0x0
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 00                	push   $0x0
  8011a3:	52                   	push   %edx
  8011a4:	50                   	push   %eax
  8011a5:	6a 07                	push   $0x7
  8011a7:	e8 fb fe ff ff       	call   8010a7 <syscall>
  8011ac:	83 c4 18             	add    $0x18,%esp
}
  8011af:	c9                   	leave  
  8011b0:	c3                   	ret    

008011b1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8011b1:	55                   	push   %ebp
  8011b2:	89 e5                	mov    %esp,%ebp
  8011b4:	56                   	push   %esi
  8011b5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8011b6:	8b 75 18             	mov    0x18(%ebp),%esi
  8011b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c5:	56                   	push   %esi
  8011c6:	53                   	push   %ebx
  8011c7:	51                   	push   %ecx
  8011c8:	52                   	push   %edx
  8011c9:	50                   	push   %eax
  8011ca:	6a 08                	push   $0x8
  8011cc:	e8 d6 fe ff ff       	call   8010a7 <syscall>
  8011d1:	83 c4 18             	add    $0x18,%esp
}
  8011d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011d7:	5b                   	pop    %ebx
  8011d8:	5e                   	pop    %esi
  8011d9:	5d                   	pop    %ebp
  8011da:	c3                   	ret    

008011db <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8011db:	55                   	push   %ebp
  8011dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8011de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	6a 00                	push   $0x0
  8011e6:	6a 00                	push   $0x0
  8011e8:	6a 00                	push   $0x0
  8011ea:	52                   	push   %edx
  8011eb:	50                   	push   %eax
  8011ec:	6a 09                	push   $0x9
  8011ee:	e8 b4 fe ff ff       	call   8010a7 <syscall>
  8011f3:	83 c4 18             	add    $0x18,%esp
}
  8011f6:	c9                   	leave  
  8011f7:	c3                   	ret    

008011f8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8011f8:	55                   	push   %ebp
  8011f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 00                	push   $0x0
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	ff 75 08             	pushl  0x8(%ebp)
  801207:	6a 0a                	push   $0xa
  801209:	e8 99 fe ff ff       	call   8010a7 <syscall>
  80120e:	83 c4 18             	add    $0x18,%esp
}
  801211:	c9                   	leave  
  801212:	c3                   	ret    

00801213 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801213:	55                   	push   %ebp
  801214:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801216:	6a 00                	push   $0x0
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	6a 00                	push   $0x0
  80121e:	6a 00                	push   $0x0
  801220:	6a 0b                	push   $0xb
  801222:	e8 80 fe ff ff       	call   8010a7 <syscall>
  801227:	83 c4 18             	add    $0x18,%esp
}
  80122a:	c9                   	leave  
  80122b:	c3                   	ret    

0080122c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80122c:	55                   	push   %ebp
  80122d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 0c                	push   $0xc
  80123b:	e8 67 fe ff ff       	call   8010a7 <syscall>
  801240:	83 c4 18             	add    $0x18,%esp
}
  801243:	c9                   	leave  
  801244:	c3                   	ret    

00801245 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801245:	55                   	push   %ebp
  801246:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 0d                	push   $0xd
  801254:	e8 4e fe ff ff       	call   8010a7 <syscall>
  801259:	83 c4 18             	add    $0x18,%esp
}
  80125c:	c9                   	leave  
  80125d:	c3                   	ret    

0080125e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80125e:	55                   	push   %ebp
  80125f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 00                	push   $0x0
  801267:	ff 75 0c             	pushl  0xc(%ebp)
  80126a:	ff 75 08             	pushl  0x8(%ebp)
  80126d:	6a 11                	push   $0x11
  80126f:	e8 33 fe ff ff       	call   8010a7 <syscall>
  801274:	83 c4 18             	add    $0x18,%esp
	return;
  801277:	90                   	nop
}
  801278:	c9                   	leave  
  801279:	c3                   	ret    

0080127a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80127a:	55                   	push   %ebp
  80127b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80127d:	6a 00                	push   $0x0
  80127f:	6a 00                	push   $0x0
  801281:	6a 00                	push   $0x0
  801283:	ff 75 0c             	pushl  0xc(%ebp)
  801286:	ff 75 08             	pushl  0x8(%ebp)
  801289:	6a 12                	push   $0x12
  80128b:	e8 17 fe ff ff       	call   8010a7 <syscall>
  801290:	83 c4 18             	add    $0x18,%esp
	return ;
  801293:	90                   	nop
}
  801294:	c9                   	leave  
  801295:	c3                   	ret    

00801296 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801296:	55                   	push   %ebp
  801297:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 00                	push   $0x0
  8012a1:	6a 00                	push   $0x0
  8012a3:	6a 0e                	push   $0xe
  8012a5:	e8 fd fd ff ff       	call   8010a7 <syscall>
  8012aa:	83 c4 18             	add    $0x18,%esp
}
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	ff 75 08             	pushl  0x8(%ebp)
  8012bd:	6a 0f                	push   $0xf
  8012bf:	e8 e3 fd ff ff       	call   8010a7 <syscall>
  8012c4:	83 c4 18             	add    $0x18,%esp
}
  8012c7:	c9                   	leave  
  8012c8:	c3                   	ret    

008012c9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8012c9:	55                   	push   %ebp
  8012ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 10                	push   $0x10
  8012d8:	e8 ca fd ff ff       	call   8010a7 <syscall>
  8012dd:	83 c4 18             	add    $0x18,%esp
}
  8012e0:	90                   	nop
  8012e1:	c9                   	leave  
  8012e2:	c3                   	ret    

008012e3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8012e3:	55                   	push   %ebp
  8012e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 14                	push   $0x14
  8012f2:	e8 b0 fd ff ff       	call   8010a7 <syscall>
  8012f7:	83 c4 18             	add    $0x18,%esp
}
  8012fa:	90                   	nop
  8012fb:	c9                   	leave  
  8012fc:	c3                   	ret    

008012fd <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012fd:	55                   	push   %ebp
  8012fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	6a 00                	push   $0x0
  801308:	6a 00                	push   $0x0
  80130a:	6a 15                	push   $0x15
  80130c:	e8 96 fd ff ff       	call   8010a7 <syscall>
  801311:	83 c4 18             	add    $0x18,%esp
}
  801314:	90                   	nop
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <sys_cputc>:


void
sys_cputc(const char c)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
  80131a:	83 ec 04             	sub    $0x4,%esp
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801323:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	50                   	push   %eax
  801330:	6a 16                	push   $0x16
  801332:	e8 70 fd ff ff       	call   8010a7 <syscall>
  801337:	83 c4 18             	add    $0x18,%esp
}
  80133a:	90                   	nop
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 17                	push   $0x17
  80134c:	e8 56 fd ff ff       	call   8010a7 <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	90                   	nop
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	ff 75 0c             	pushl  0xc(%ebp)
  801366:	50                   	push   %eax
  801367:	6a 18                	push   $0x18
  801369:	e8 39 fd ff ff       	call   8010a7 <syscall>
  80136e:	83 c4 18             	add    $0x18,%esp
}
  801371:	c9                   	leave  
  801372:	c3                   	ret    

00801373 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801376:	8b 55 0c             	mov    0xc(%ebp),%edx
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	52                   	push   %edx
  801383:	50                   	push   %eax
  801384:	6a 1b                	push   $0x1b
  801386:	e8 1c fd ff ff       	call   8010a7 <syscall>
  80138b:	83 c4 18             	add    $0x18,%esp
}
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801393:	8b 55 0c             	mov    0xc(%ebp),%edx
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	52                   	push   %edx
  8013a0:	50                   	push   %eax
  8013a1:	6a 19                	push   $0x19
  8013a3:	e8 ff fc ff ff       	call   8010a7 <syscall>
  8013a8:	83 c4 18             	add    $0x18,%esp
}
  8013ab:	90                   	nop
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	52                   	push   %edx
  8013be:	50                   	push   %eax
  8013bf:	6a 1a                	push   $0x1a
  8013c1:	e8 e1 fc ff ff       	call   8010a7 <syscall>
  8013c6:	83 c4 18             	add    $0x18,%esp
}
  8013c9:	90                   	nop
  8013ca:	c9                   	leave  
  8013cb:	c3                   	ret    

008013cc <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8013cc:	55                   	push   %ebp
  8013cd:	89 e5                	mov    %esp,%ebp
  8013cf:	83 ec 04             	sub    $0x4,%esp
  8013d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8013d8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8013db:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	6a 00                	push   $0x0
  8013e4:	51                   	push   %ecx
  8013e5:	52                   	push   %edx
  8013e6:	ff 75 0c             	pushl  0xc(%ebp)
  8013e9:	50                   	push   %eax
  8013ea:	6a 1c                	push   $0x1c
  8013ec:	e8 b6 fc ff ff       	call   8010a7 <syscall>
  8013f1:	83 c4 18             	add    $0x18,%esp
}
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8013f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	52                   	push   %edx
  801406:	50                   	push   %eax
  801407:	6a 1d                	push   $0x1d
  801409:	e8 99 fc ff ff       	call   8010a7 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801416:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801419:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	51                   	push   %ecx
  801424:	52                   	push   %edx
  801425:	50                   	push   %eax
  801426:	6a 1e                	push   $0x1e
  801428:	e8 7a fc ff ff       	call   8010a7 <syscall>
  80142d:	83 c4 18             	add    $0x18,%esp
}
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801435:	8b 55 0c             	mov    0xc(%ebp),%edx
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	52                   	push   %edx
  801442:	50                   	push   %eax
  801443:	6a 1f                	push   $0x1f
  801445:	e8 5d fc ff ff       	call   8010a7 <syscall>
  80144a:	83 c4 18             	add    $0x18,%esp
}
  80144d:	c9                   	leave  
  80144e:	c3                   	ret    

0080144f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 20                	push   $0x20
  80145e:	e8 44 fc ff ff       	call   8010a7 <syscall>
  801463:	83 c4 18             	add    $0x18,%esp
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	ff 75 10             	pushl  0x10(%ebp)
  801475:	ff 75 0c             	pushl  0xc(%ebp)
  801478:	50                   	push   %eax
  801479:	6a 21                	push   $0x21
  80147b:	e8 27 fc ff ff       	call   8010a7 <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	50                   	push   %eax
  801494:	6a 22                	push   $0x22
  801496:	e8 0c fc ff ff       	call   8010a7 <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
}
  80149e:	90                   	nop
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	50                   	push   %eax
  8014b0:	6a 23                	push   $0x23
  8014b2:	e8 f0 fb ff ff       	call   8010a7 <syscall>
  8014b7:	83 c4 18             	add    $0x18,%esp
}
  8014ba:	90                   	nop
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
  8014c0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8014c3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014c6:	8d 50 04             	lea    0x4(%eax),%edx
  8014c9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	52                   	push   %edx
  8014d3:	50                   	push   %eax
  8014d4:	6a 24                	push   $0x24
  8014d6:	e8 cc fb ff ff       	call   8010a7 <syscall>
  8014db:	83 c4 18             	add    $0x18,%esp
	return result;
  8014de:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e7:	89 01                	mov    %eax,(%ecx)
  8014e9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	c9                   	leave  
  8014f0:	c2 04 00             	ret    $0x4

008014f3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	ff 75 10             	pushl  0x10(%ebp)
  8014fd:	ff 75 0c             	pushl  0xc(%ebp)
  801500:	ff 75 08             	pushl  0x8(%ebp)
  801503:	6a 13                	push   $0x13
  801505:	e8 9d fb ff ff       	call   8010a7 <syscall>
  80150a:	83 c4 18             	add    $0x18,%esp
	return ;
  80150d:	90                   	nop
}
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <sys_rcr2>:
uint32 sys_rcr2()
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 25                	push   $0x25
  80151f:	e8 83 fb ff ff       	call   8010a7 <syscall>
  801524:	83 c4 18             	add    $0x18,%esp
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
  80152c:	83 ec 04             	sub    $0x4,%esp
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801535:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	50                   	push   %eax
  801542:	6a 26                	push   $0x26
  801544:	e8 5e fb ff ff       	call   8010a7 <syscall>
  801549:	83 c4 18             	add    $0x18,%esp
	return ;
  80154c:	90                   	nop
}
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <rsttst>:
void rsttst()
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 28                	push   $0x28
  80155e:	e8 44 fb ff ff       	call   8010a7 <syscall>
  801563:	83 c4 18             	add    $0x18,%esp
	return ;
  801566:	90                   	nop
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
  80156c:	83 ec 04             	sub    $0x4,%esp
  80156f:	8b 45 14             	mov    0x14(%ebp),%eax
  801572:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801575:	8b 55 18             	mov    0x18(%ebp),%edx
  801578:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80157c:	52                   	push   %edx
  80157d:	50                   	push   %eax
  80157e:	ff 75 10             	pushl  0x10(%ebp)
  801581:	ff 75 0c             	pushl  0xc(%ebp)
  801584:	ff 75 08             	pushl  0x8(%ebp)
  801587:	6a 27                	push   $0x27
  801589:	e8 19 fb ff ff       	call   8010a7 <syscall>
  80158e:	83 c4 18             	add    $0x18,%esp
	return ;
  801591:	90                   	nop
}
  801592:	c9                   	leave  
  801593:	c3                   	ret    

00801594 <chktst>:
void chktst(uint32 n)
{
  801594:	55                   	push   %ebp
  801595:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	ff 75 08             	pushl  0x8(%ebp)
  8015a2:	6a 29                	push   $0x29
  8015a4:	e8 fe fa ff ff       	call   8010a7 <syscall>
  8015a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ac:	90                   	nop
}
  8015ad:	c9                   	leave  
  8015ae:	c3                   	ret    

008015af <inctst>:

void inctst()
{
  8015af:	55                   	push   %ebp
  8015b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 2a                	push   $0x2a
  8015be:	e8 e4 fa ff ff       	call   8010a7 <syscall>
  8015c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c6:	90                   	nop
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <gettst>:
uint32 gettst()
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 2b                	push   $0x2b
  8015d8:	e8 ca fa ff ff       	call   8010a7 <syscall>
  8015dd:	83 c4 18             	add    $0x18,%esp
}
  8015e0:	c9                   	leave  
  8015e1:	c3                   	ret    

008015e2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8015e2:	55                   	push   %ebp
  8015e3:	89 e5                	mov    %esp,%ebp
  8015e5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 2c                	push   $0x2c
  8015f4:	e8 ae fa ff ff       	call   8010a7 <syscall>
  8015f9:	83 c4 18             	add    $0x18,%esp
  8015fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015ff:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801603:	75 07                	jne    80160c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801605:	b8 01 00 00 00       	mov    $0x1,%eax
  80160a:	eb 05                	jmp    801611 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80160c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
  801616:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	6a 2c                	push   $0x2c
  801625:	e8 7d fa ff ff       	call   8010a7 <syscall>
  80162a:	83 c4 18             	add    $0x18,%esp
  80162d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801630:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801634:	75 07                	jne    80163d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801636:	b8 01 00 00 00       	mov    $0x1,%eax
  80163b:	eb 05                	jmp    801642 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80163d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801642:	c9                   	leave  
  801643:	c3                   	ret    

00801644 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801644:	55                   	push   %ebp
  801645:	89 e5                	mov    %esp,%ebp
  801647:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 2c                	push   $0x2c
  801656:	e8 4c fa ff ff       	call   8010a7 <syscall>
  80165b:	83 c4 18             	add    $0x18,%esp
  80165e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801661:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801665:	75 07                	jne    80166e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801667:	b8 01 00 00 00       	mov    $0x1,%eax
  80166c:	eb 05                	jmp    801673 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80166e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
  801678:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 2c                	push   $0x2c
  801687:	e8 1b fa ff ff       	call   8010a7 <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
  80168f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801692:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801696:	75 07                	jne    80169f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801698:	b8 01 00 00 00       	mov    $0x1,%eax
  80169d:	eb 05                	jmp    8016a4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80169f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016a4:	c9                   	leave  
  8016a5:	c3                   	ret    

008016a6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016a6:	55                   	push   %ebp
  8016a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	ff 75 08             	pushl  0x8(%ebp)
  8016b4:	6a 2d                	push   $0x2d
  8016b6:	e8 ec f9 ff ff       	call   8010a7 <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8016be:	90                   	nop
}
  8016bf:	c9                   	leave  
  8016c0:	c3                   	ret    

008016c1 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8016c1:	55                   	push   %ebp
  8016c2:	89 e5                	mov    %esp,%ebp
  8016c4:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8016c7:	8b 55 08             	mov    0x8(%ebp),%edx
  8016ca:	89 d0                	mov    %edx,%eax
  8016cc:	c1 e0 02             	shl    $0x2,%eax
  8016cf:	01 d0                	add    %edx,%eax
  8016d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d8:	01 d0                	add    %edx,%eax
  8016da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e1:	01 d0                	add    %edx,%eax
  8016e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ea:	01 d0                	add    %edx,%eax
  8016ec:	c1 e0 04             	shl    $0x4,%eax
  8016ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8016f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8016f9:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8016fc:	83 ec 0c             	sub    $0xc,%esp
  8016ff:	50                   	push   %eax
  801700:	e8 b8 fd ff ff       	call   8014bd <sys_get_virtual_time>
  801705:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801708:	eb 41                	jmp    80174b <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80170a:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80170d:	83 ec 0c             	sub    $0xc,%esp
  801710:	50                   	push   %eax
  801711:	e8 a7 fd ff ff       	call   8014bd <sys_get_virtual_time>
  801716:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801719:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80171c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80171f:	29 c2                	sub    %eax,%edx
  801721:	89 d0                	mov    %edx,%eax
  801723:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801726:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801729:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80172c:	89 d1                	mov    %edx,%ecx
  80172e:	29 c1                	sub    %eax,%ecx
  801730:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801733:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801736:	39 c2                	cmp    %eax,%edx
  801738:	0f 97 c0             	seta   %al
  80173b:	0f b6 c0             	movzbl %al,%eax
  80173e:	29 c1                	sub    %eax,%ecx
  801740:	89 c8                	mov    %ecx,%eax
  801742:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801745:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801748:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80174b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801751:	72 b7                	jb     80170a <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801753:	90                   	nop
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
  801759:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80175c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801763:	eb 03                	jmp    801768 <busy_wait+0x12>
  801765:	ff 45 fc             	incl   -0x4(%ebp)
  801768:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80176b:	3b 45 08             	cmp    0x8(%ebp),%eax
  80176e:	72 f5                	jb     801765 <busy_wait+0xf>
	return i;
  801770:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801773:	c9                   	leave  
  801774:	c3                   	ret    
  801775:	66 90                	xchg   %ax,%ax
  801777:	90                   	nop

00801778 <__udivdi3>:
  801778:	55                   	push   %ebp
  801779:	57                   	push   %edi
  80177a:	56                   	push   %esi
  80177b:	53                   	push   %ebx
  80177c:	83 ec 1c             	sub    $0x1c,%esp
  80177f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801783:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801787:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80178b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80178f:	89 ca                	mov    %ecx,%edx
  801791:	89 f8                	mov    %edi,%eax
  801793:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801797:	85 f6                	test   %esi,%esi
  801799:	75 2d                	jne    8017c8 <__udivdi3+0x50>
  80179b:	39 cf                	cmp    %ecx,%edi
  80179d:	77 65                	ja     801804 <__udivdi3+0x8c>
  80179f:	89 fd                	mov    %edi,%ebp
  8017a1:	85 ff                	test   %edi,%edi
  8017a3:	75 0b                	jne    8017b0 <__udivdi3+0x38>
  8017a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8017aa:	31 d2                	xor    %edx,%edx
  8017ac:	f7 f7                	div    %edi
  8017ae:	89 c5                	mov    %eax,%ebp
  8017b0:	31 d2                	xor    %edx,%edx
  8017b2:	89 c8                	mov    %ecx,%eax
  8017b4:	f7 f5                	div    %ebp
  8017b6:	89 c1                	mov    %eax,%ecx
  8017b8:	89 d8                	mov    %ebx,%eax
  8017ba:	f7 f5                	div    %ebp
  8017bc:	89 cf                	mov    %ecx,%edi
  8017be:	89 fa                	mov    %edi,%edx
  8017c0:	83 c4 1c             	add    $0x1c,%esp
  8017c3:	5b                   	pop    %ebx
  8017c4:	5e                   	pop    %esi
  8017c5:	5f                   	pop    %edi
  8017c6:	5d                   	pop    %ebp
  8017c7:	c3                   	ret    
  8017c8:	39 ce                	cmp    %ecx,%esi
  8017ca:	77 28                	ja     8017f4 <__udivdi3+0x7c>
  8017cc:	0f bd fe             	bsr    %esi,%edi
  8017cf:	83 f7 1f             	xor    $0x1f,%edi
  8017d2:	75 40                	jne    801814 <__udivdi3+0x9c>
  8017d4:	39 ce                	cmp    %ecx,%esi
  8017d6:	72 0a                	jb     8017e2 <__udivdi3+0x6a>
  8017d8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8017dc:	0f 87 9e 00 00 00    	ja     801880 <__udivdi3+0x108>
  8017e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8017e7:	89 fa                	mov    %edi,%edx
  8017e9:	83 c4 1c             	add    $0x1c,%esp
  8017ec:	5b                   	pop    %ebx
  8017ed:	5e                   	pop    %esi
  8017ee:	5f                   	pop    %edi
  8017ef:	5d                   	pop    %ebp
  8017f0:	c3                   	ret    
  8017f1:	8d 76 00             	lea    0x0(%esi),%esi
  8017f4:	31 ff                	xor    %edi,%edi
  8017f6:	31 c0                	xor    %eax,%eax
  8017f8:	89 fa                	mov    %edi,%edx
  8017fa:	83 c4 1c             	add    $0x1c,%esp
  8017fd:	5b                   	pop    %ebx
  8017fe:	5e                   	pop    %esi
  8017ff:	5f                   	pop    %edi
  801800:	5d                   	pop    %ebp
  801801:	c3                   	ret    
  801802:	66 90                	xchg   %ax,%ax
  801804:	89 d8                	mov    %ebx,%eax
  801806:	f7 f7                	div    %edi
  801808:	31 ff                	xor    %edi,%edi
  80180a:	89 fa                	mov    %edi,%edx
  80180c:	83 c4 1c             	add    $0x1c,%esp
  80180f:	5b                   	pop    %ebx
  801810:	5e                   	pop    %esi
  801811:	5f                   	pop    %edi
  801812:	5d                   	pop    %ebp
  801813:	c3                   	ret    
  801814:	bd 20 00 00 00       	mov    $0x20,%ebp
  801819:	89 eb                	mov    %ebp,%ebx
  80181b:	29 fb                	sub    %edi,%ebx
  80181d:	89 f9                	mov    %edi,%ecx
  80181f:	d3 e6                	shl    %cl,%esi
  801821:	89 c5                	mov    %eax,%ebp
  801823:	88 d9                	mov    %bl,%cl
  801825:	d3 ed                	shr    %cl,%ebp
  801827:	89 e9                	mov    %ebp,%ecx
  801829:	09 f1                	or     %esi,%ecx
  80182b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80182f:	89 f9                	mov    %edi,%ecx
  801831:	d3 e0                	shl    %cl,%eax
  801833:	89 c5                	mov    %eax,%ebp
  801835:	89 d6                	mov    %edx,%esi
  801837:	88 d9                	mov    %bl,%cl
  801839:	d3 ee                	shr    %cl,%esi
  80183b:	89 f9                	mov    %edi,%ecx
  80183d:	d3 e2                	shl    %cl,%edx
  80183f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801843:	88 d9                	mov    %bl,%cl
  801845:	d3 e8                	shr    %cl,%eax
  801847:	09 c2                	or     %eax,%edx
  801849:	89 d0                	mov    %edx,%eax
  80184b:	89 f2                	mov    %esi,%edx
  80184d:	f7 74 24 0c          	divl   0xc(%esp)
  801851:	89 d6                	mov    %edx,%esi
  801853:	89 c3                	mov    %eax,%ebx
  801855:	f7 e5                	mul    %ebp
  801857:	39 d6                	cmp    %edx,%esi
  801859:	72 19                	jb     801874 <__udivdi3+0xfc>
  80185b:	74 0b                	je     801868 <__udivdi3+0xf0>
  80185d:	89 d8                	mov    %ebx,%eax
  80185f:	31 ff                	xor    %edi,%edi
  801861:	e9 58 ff ff ff       	jmp    8017be <__udivdi3+0x46>
  801866:	66 90                	xchg   %ax,%ax
  801868:	8b 54 24 08          	mov    0x8(%esp),%edx
  80186c:	89 f9                	mov    %edi,%ecx
  80186e:	d3 e2                	shl    %cl,%edx
  801870:	39 c2                	cmp    %eax,%edx
  801872:	73 e9                	jae    80185d <__udivdi3+0xe5>
  801874:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801877:	31 ff                	xor    %edi,%edi
  801879:	e9 40 ff ff ff       	jmp    8017be <__udivdi3+0x46>
  80187e:	66 90                	xchg   %ax,%ax
  801880:	31 c0                	xor    %eax,%eax
  801882:	e9 37 ff ff ff       	jmp    8017be <__udivdi3+0x46>
  801887:	90                   	nop

00801888 <__umoddi3>:
  801888:	55                   	push   %ebp
  801889:	57                   	push   %edi
  80188a:	56                   	push   %esi
  80188b:	53                   	push   %ebx
  80188c:	83 ec 1c             	sub    $0x1c,%esp
  80188f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801893:	8b 74 24 34          	mov    0x34(%esp),%esi
  801897:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80189b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80189f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8018a3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8018a7:	89 f3                	mov    %esi,%ebx
  8018a9:	89 fa                	mov    %edi,%edx
  8018ab:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018af:	89 34 24             	mov    %esi,(%esp)
  8018b2:	85 c0                	test   %eax,%eax
  8018b4:	75 1a                	jne    8018d0 <__umoddi3+0x48>
  8018b6:	39 f7                	cmp    %esi,%edi
  8018b8:	0f 86 a2 00 00 00    	jbe    801960 <__umoddi3+0xd8>
  8018be:	89 c8                	mov    %ecx,%eax
  8018c0:	89 f2                	mov    %esi,%edx
  8018c2:	f7 f7                	div    %edi
  8018c4:	89 d0                	mov    %edx,%eax
  8018c6:	31 d2                	xor    %edx,%edx
  8018c8:	83 c4 1c             	add    $0x1c,%esp
  8018cb:	5b                   	pop    %ebx
  8018cc:	5e                   	pop    %esi
  8018cd:	5f                   	pop    %edi
  8018ce:	5d                   	pop    %ebp
  8018cf:	c3                   	ret    
  8018d0:	39 f0                	cmp    %esi,%eax
  8018d2:	0f 87 ac 00 00 00    	ja     801984 <__umoddi3+0xfc>
  8018d8:	0f bd e8             	bsr    %eax,%ebp
  8018db:	83 f5 1f             	xor    $0x1f,%ebp
  8018de:	0f 84 ac 00 00 00    	je     801990 <__umoddi3+0x108>
  8018e4:	bf 20 00 00 00       	mov    $0x20,%edi
  8018e9:	29 ef                	sub    %ebp,%edi
  8018eb:	89 fe                	mov    %edi,%esi
  8018ed:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8018f1:	89 e9                	mov    %ebp,%ecx
  8018f3:	d3 e0                	shl    %cl,%eax
  8018f5:	89 d7                	mov    %edx,%edi
  8018f7:	89 f1                	mov    %esi,%ecx
  8018f9:	d3 ef                	shr    %cl,%edi
  8018fb:	09 c7                	or     %eax,%edi
  8018fd:	89 e9                	mov    %ebp,%ecx
  8018ff:	d3 e2                	shl    %cl,%edx
  801901:	89 14 24             	mov    %edx,(%esp)
  801904:	89 d8                	mov    %ebx,%eax
  801906:	d3 e0                	shl    %cl,%eax
  801908:	89 c2                	mov    %eax,%edx
  80190a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80190e:	d3 e0                	shl    %cl,%eax
  801910:	89 44 24 04          	mov    %eax,0x4(%esp)
  801914:	8b 44 24 08          	mov    0x8(%esp),%eax
  801918:	89 f1                	mov    %esi,%ecx
  80191a:	d3 e8                	shr    %cl,%eax
  80191c:	09 d0                	or     %edx,%eax
  80191e:	d3 eb                	shr    %cl,%ebx
  801920:	89 da                	mov    %ebx,%edx
  801922:	f7 f7                	div    %edi
  801924:	89 d3                	mov    %edx,%ebx
  801926:	f7 24 24             	mull   (%esp)
  801929:	89 c6                	mov    %eax,%esi
  80192b:	89 d1                	mov    %edx,%ecx
  80192d:	39 d3                	cmp    %edx,%ebx
  80192f:	0f 82 87 00 00 00    	jb     8019bc <__umoddi3+0x134>
  801935:	0f 84 91 00 00 00    	je     8019cc <__umoddi3+0x144>
  80193b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80193f:	29 f2                	sub    %esi,%edx
  801941:	19 cb                	sbb    %ecx,%ebx
  801943:	89 d8                	mov    %ebx,%eax
  801945:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801949:	d3 e0                	shl    %cl,%eax
  80194b:	89 e9                	mov    %ebp,%ecx
  80194d:	d3 ea                	shr    %cl,%edx
  80194f:	09 d0                	or     %edx,%eax
  801951:	89 e9                	mov    %ebp,%ecx
  801953:	d3 eb                	shr    %cl,%ebx
  801955:	89 da                	mov    %ebx,%edx
  801957:	83 c4 1c             	add    $0x1c,%esp
  80195a:	5b                   	pop    %ebx
  80195b:	5e                   	pop    %esi
  80195c:	5f                   	pop    %edi
  80195d:	5d                   	pop    %ebp
  80195e:	c3                   	ret    
  80195f:	90                   	nop
  801960:	89 fd                	mov    %edi,%ebp
  801962:	85 ff                	test   %edi,%edi
  801964:	75 0b                	jne    801971 <__umoddi3+0xe9>
  801966:	b8 01 00 00 00       	mov    $0x1,%eax
  80196b:	31 d2                	xor    %edx,%edx
  80196d:	f7 f7                	div    %edi
  80196f:	89 c5                	mov    %eax,%ebp
  801971:	89 f0                	mov    %esi,%eax
  801973:	31 d2                	xor    %edx,%edx
  801975:	f7 f5                	div    %ebp
  801977:	89 c8                	mov    %ecx,%eax
  801979:	f7 f5                	div    %ebp
  80197b:	89 d0                	mov    %edx,%eax
  80197d:	e9 44 ff ff ff       	jmp    8018c6 <__umoddi3+0x3e>
  801982:	66 90                	xchg   %ax,%ax
  801984:	89 c8                	mov    %ecx,%eax
  801986:	89 f2                	mov    %esi,%edx
  801988:	83 c4 1c             	add    $0x1c,%esp
  80198b:	5b                   	pop    %ebx
  80198c:	5e                   	pop    %esi
  80198d:	5f                   	pop    %edi
  80198e:	5d                   	pop    %ebp
  80198f:	c3                   	ret    
  801990:	3b 04 24             	cmp    (%esp),%eax
  801993:	72 06                	jb     80199b <__umoddi3+0x113>
  801995:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801999:	77 0f                	ja     8019aa <__umoddi3+0x122>
  80199b:	89 f2                	mov    %esi,%edx
  80199d:	29 f9                	sub    %edi,%ecx
  80199f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8019a3:	89 14 24             	mov    %edx,(%esp)
  8019a6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019aa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8019ae:	8b 14 24             	mov    (%esp),%edx
  8019b1:	83 c4 1c             	add    $0x1c,%esp
  8019b4:	5b                   	pop    %ebx
  8019b5:	5e                   	pop    %esi
  8019b6:	5f                   	pop    %edi
  8019b7:	5d                   	pop    %ebp
  8019b8:	c3                   	ret    
  8019b9:	8d 76 00             	lea    0x0(%esi),%esi
  8019bc:	2b 04 24             	sub    (%esp),%eax
  8019bf:	19 fa                	sbb    %edi,%edx
  8019c1:	89 d1                	mov    %edx,%ecx
  8019c3:	89 c6                	mov    %eax,%esi
  8019c5:	e9 71 ff ff ff       	jmp    80193b <__umoddi3+0xb3>
  8019ca:	66 90                	xchg   %ax,%ax
  8019cc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8019d0:	72 ea                	jb     8019bc <__umoddi3+0x134>
  8019d2:	89 d9                	mov    %ebx,%ecx
  8019d4:	e9 62 ff ff ff       	jmp    80193b <__umoddi3+0xb3>
